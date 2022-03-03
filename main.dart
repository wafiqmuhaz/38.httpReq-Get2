import 'dart:convert';

import "package:flutter/material.dart";
import 'package:http/http.dart' as http;

void main() {
  runApp(app());
}

class app extends StatelessWidget {
  const app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  late String id;
  late String email;
  late String nama;

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    id = "";
    email = "";
    nama = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("HTTP - GET"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ID = $id",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              " EMAIL = $email",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "NAMA = $nama",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                var isinih = await http.get(
                  Uri.parse("https://reqres.in/api/users/5"),
                );
                if (isinih.statusCode == 200) {
                  Map<String, dynamic> isi =
                      json.decode(isinih.body) as Map<String, dynamic>;

                  setState(() {
                    id = isi["data"]["id"].toString();
                    email = isi["data"]["email"].toString();
                    nama =
                        "${isi["data"]["first_name"]} ${isi["data"]["last_name"]}";
                  });
                } else {
                  print(isinih.body);
                }
                ;
              },
              child: Text("GET DATA"),
            ),
          ],
        ),
      ),
    );
  }
}
