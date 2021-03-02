
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';

void main() {runApp(MaterialApp(
  home: Home(),
  // home: FirebaseRealtimeDemoScreen(),
));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

// ValueChanged<Color> callback
  void changeColor(Color color) {
    createData();
    setState(() => pickerColor = color);
  }

  var flag=0;
  final databaseReference = FirebaseDatabase.instance.reference();
  void createData(){
    databaseReference.set({
      'red': pickerColor.red,
      'green': pickerColor.green,
      'blue': pickerColor.blue,
      'flagauto': flag,
    });}

  void flagData(){
    databaseReference.set({
      'flagauto': flag,
    });}
  List<bool> isSelected = [true, false];

  bool _enable=false;
  int sele;
  int pic;
  String lab='Cicle Color Picker';
  void _pictype () {
    if (pic==0){
      pic=1;
      lab='Box Color picker';
    }else{
      pic=0;
      lab='Cicle Color Picker';
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    Size screen =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pickerColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                // color: Colors.black,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ToggleButtons(
                borderColor: Colors.redAccent,
                fillColor: Colors.black,
                // highlightColor: Colors.green,
                borderWidth: 2,
                selectedBorderColor: Colors.redAccent,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Manual',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Auto',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;

                      if(index==0){
                        flag=0;
                        sele=0;
                        _enable=false;
                      }else{
                        flag=1;
                        sele=1;
                        _enable=true;
                      }
                    }
                  });
                  createData();
                },
                isSelected: isSelected,
              ),
            ),
            IndexedStack(
              index: sele,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: pickerColor.withAlpha(600),
                        width: 3,
                      )
                  ),
                  child: Column(
                    children: [
                      IndexedStack(
                        index: pic,
                        children: [
                        ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                          showLabel: false,
                          displayThumbColor: true,
                          pickerAreaHeightPercent: 0.8,
                          portraitOnly: false,
                          pickerAreaBorderRadius: BorderRadius.circular(20),
                        ),
                          // ColorPicker(
                          //   pickerColor: pickerColor,
                          //   onColorChanged: changeColor,
                          //   showLabel: true,
                          //   displayThumbColor: true,
                          //   labelTextStyle: TextStyle(
                          //     color: Colors.white,
                          //   ),
                          //   pickerAreaHeightPercent: 0.8,
                          //   portraitOnly: false,
                          //   pickerAreaBorderRadius: BorderRadius.circular(20),
                          // ),
                          Center(
                            child: CircleColorPicker(
                              initialColor: pickerColor,
                              onChanged: changeColor,
                              thumbSize: 30,
                              strokeWidth: 7,
                            ),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text(
                          '$lab',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.redAccent,
                        elevation: 20,
                        focusElevation: 10,
                        highlightElevation: 50,
                        hoverElevation: 50,
                        highlightColor: Colors.black,
                        onPressed: () {
                          _pictype();
                        },
                      ),
                    ],
                  ),
                  // child: ColorPicker(
                  //   pickerColor: pickerColor,
                  //   onColorChanged: changeColor,
                  //   showLabel: false,
                  //   displayThumbColor: true,
                  //   pickerAreaHeightPercent: 0.8,
                  //   portraitOnly: false,
                  //   pickerAreaBorderRadius: BorderRadius.circular(20),
                  // ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        // color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: pickerColor.withAlpha(600),
                          width: 3,
                        )
                    ),
                    child: Text(
                      'Auto',
                    ),
                  ),
                ),
              ],
            ),
            // Stack(
            //   children: [
            //     Center(
            //       child: AbsorbPointer(
            //         absorbing: !_enable,
            //         child: Visibility(
            //           visible: _enable,
            //           child: Container(
            //             padding: EdgeInsets.all(20),
            //             margin: EdgeInsets.all(30),
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //               // color: Colors.black,
            //                 borderRadius: BorderRadius.circular(20),
            //                 border: Border.all(
            //                   color: pickerColor.withAlpha(600),
            //                   width: 3,
            //                 )
            //             ),
            //             child: Text(
            //               'Auto',
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     AbsorbPointer(
            //       absorbing: _enable,
            //       child: Visibility(
            //         visible: !_enable,
            //         child: Container(
            //           padding: EdgeInsets.all(20),
            //           margin: EdgeInsets.all(30),
            //           decoration: BoxDecoration(
            //               // color: Colors.white,
            //             color: Colors.black,
            //               borderRadius: BorderRadius.circular(20),
            //               border: Border.all(
            //                 color: pickerColor.withAlpha(600),
            //                 width: 3,
            //               )
            //           ),
            //           child: ColorPicker(
            //             pickerColor: pickerColor,
            //             onColorChanged: changeColor,
            //             showLabel: false,
            //             displayThumbColor: true,
            //             pickerAreaHeightPercent: 0.8,
            //             portraitOnly: false,
            //             pickerAreaBorderRadius: BorderRadius.circular(20),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            ///////////////////////////////////////////
            // AbsorbPointer(
            //   absorbing: _enable,
            //   child: Container(
            //     padding: EdgeInsets.all(20),
            //     margin: EdgeInsets.all(30),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(20),
            //       border: Border.all(
            //         color: pickerColor.withAlpha(600),
            //         width: 3,
            //       )
            //     ),
            //     child: ColorPicker(
            //       pickerColor: pickerColor,
            //       onColorChanged: changeColor,
            //       showLabel: false,
            //       displayThumbColor: true,
            //       pickerAreaHeightPercent: 0.8,
            //       portraitOnly: false,
            //       pickerAreaBorderRadius: BorderRadius.circular(20),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

