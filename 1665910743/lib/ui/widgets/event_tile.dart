import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../extensions/date_extension.dart';
import '../../models/tags.dart';
import '../screens/settings/cubit/settings_cubit.dart';

class EventTile extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool favorite;
  final Image? image;
  final bool isSelected;
  final int iconCode;
  final int tag;

  EventTile({
    Key? key,
    required this.title,
    required this.date,
    required this.favorite,
    required this.isSelected,
    required this.iconCode,
    required this.tag,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tileAlignLeft =
        context.read<SettingsCubit>().state.chatTileAlignment ==
            Alignment.centerLeft;
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomRight: _tileAlignLeft
                ? const Radius.circular(15)
                : const Radius.circular(0),
            bottomLeft: _tileAlignLeft
                ? const Radius.circular(0)
                : const Radius.circular(15),
          ),
          color: isSelected
              ? Theme.of(context).primaryColor.withOpacity(0.7)
              : Theme.of(context).primaryColor),
      child: (image != null)
          ? _TileWithImage(
              image: image,
              title: title,
              formattedDate: date.mmddyy(),
              favorite: favorite,
            )
          : _TileWithoutImage(
              title: title,
              formattedDate: date.mmddyy(),
              favorite: favorite,
              iconCode: iconCode,
              tag: tag,
            ),
    );
  }
}

class _TileWithoutImage extends StatelessWidget {
  final String title;
  final String _formattedDate;
  final bool favorite;
  final int iconCode;
  final int tag;

  const _TileWithoutImage({
    Key? key,
    required this.title,
    required String formattedDate,
    required this.favorite,
    required this.iconCode,
    required this.tag,
  })  : _formattedDate = formattedDate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        (iconCode != 0)
            ? Icon(
                IconData(iconCode, fontFamily: 'MaterialIcons'),
                color: Theme.of(context).scaffoldBackgroundColor,
                size: 50,
              )
            : const SizedBox(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.02,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            (tag != -1)
                ? Text(
                    kMyTags[tag],
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                : const SizedBox(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formattedDate,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    favorite ? Icons.star : Icons.star_border,
                    size: 15,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

class _TileWithImage extends StatefulWidget {
  final Image? image;
  final String title;
  final String formattedDate;
  final bool favorite;

  _TileWithImage({
    Key? key,
    required this.image,
    required this.title,
    required this.favorite,
    required this.formattedDate,
  }) : super(key: key);

  @override
  State<_TileWithImage> createState() => _TileWithImageState();
}

class _TileWithImageState extends State<_TileWithImage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: widget.image),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                '${widget.title.substring(0, 10)}...',
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.formattedDate,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Icon(
                  widget.favorite ? Icons.star : Icons.star_border,
                  size: 15,
                  color: Theme.of(context).scaffoldBackgroundColor,
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
