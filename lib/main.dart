import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* -------------------- APP ROOT -------------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseScreen(),
    );
  }
}

/* -------------------- SCREEN -------------------- */

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text("Courses"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: courseList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // ✅ 2 cards per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.60, // prevents bottom overflow
          ),
          itemBuilder: (context, index) {
            return CourseCard(course: courseList[index]);
          },
        ),
      ),
    );
  }
}

/* -------------------- COURSE CARD -------------------- */

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // SAFETY: ensure info is always a list
    final List infoList = course["info"] ?? [];

    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(14),
            ),
            child: Image.asset(
              course["image"],
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // INFO ROW (SAFE)
                  if (infoList.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: infoList.map<Widget>((item) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 2),
                            child: InfoBox(
                              icon: item["icon"],
                              text: item["text"],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  const SizedBox(height: 6),

                  // TITLE
                  Text(
                    course["title"],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUTTON
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("View Details"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/* -------------------- INFO BOX -------------------- */

class InfoBox extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoBox({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 211,211,211),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: Colors.grey),
          const SizedBox(width: 1),
          Text(
            text,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

/* -------------------- DATA -------------------- */

final List<Map<String, dynamic>> courseList = [
  {
    "title": "Full Stack Web Development with JavaScript (MERN)",
    "image": "assets/images/mern.jpg",
    "info": [
      {"icon": Icons.add_card, "text": "Batch 19"},
      {"icon": Icons.group, "text": "6 seats left"},
      {"icon": Icons.schedule, "text": "40 days left"},
    ],
  },
  {
    "title":
        "Full Stack Web Development with Python, Django & React",
    "image": "assets/images/python.jpg",
    "info": [
      {"icon": Icons.add_card, "text": "Batch 12"},
      {"icon": Icons.group, "text": "10 seats left"},
      {"icon": Icons.schedule, "text": "60 days left"},
    ],
  },
  {
    "title": "Full Stack Web Development with ASP.NET Core",
    "image": "assets/images/dotnet.jpg",
    "info": [
      {"icon": Icons.add_card, "text": "Batch 8"},
      {"icon": Icons.group, "text": "4 seats left"},
      {"icon": Icons.schedule, "text": "30 days left"},
    ],
  },
  {
    "title": "SQA: Manual & Automated Testing",
    "image": "assets/images/sqa.jpg",
    "info": [
      {"icon": Icons.add_card, "text": "Batch 5"},
      {"icon": Icons.group, "text": "12 seats left"},
      {"icon": Icons.schedule, "text": "20 days left"},
    ],
  },
];
