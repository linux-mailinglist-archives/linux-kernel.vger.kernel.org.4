Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11253640C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiLBRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbiLBRey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:34:54 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B164E802F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:34:51 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c15so5505074pfb.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=axko6ycs0VJVmCkKT/927XYLWCbadtInJC+ZmDyd86I=;
        b=gm2bxg4oyYQI86jxdgnYo9xlXGPSf3MbbHaHxqHFb4nF68Z9be1dgvc/U6yMu9ZCbw
         golxIEFg1je1Imh4o8G+406teg7HK2TemUu8RXTiU/Kb2yJbsKJZjbYoPR0y6Mfz9e65
         PVuZ+nvp7LQVjyo1RlEVgz6cAimqnIcKX7ngU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axko6ycs0VJVmCkKT/927XYLWCbadtInJC+ZmDyd86I=;
        b=OOTMl3PB+x/+pl2M+j1QYKQan95M+9b7/MEsYVRqM8IHcDzU0CAs2AJcwALIjQNkSI
         SJr8wH1B8A4uh6UVtSog06bFk0xmRbHjblsJTiDTFfEoaKSJEMJAfZ+tm2DMtc871FE3
         rSF7AH3NC1TO555odulfN5fCJn79vKQEvh963DjzXfyeEyEGLfAF0DDyX5skspTikgI4
         QH7GpdbuHwFd4TQVB6cXT+21xR2sp7x2iwzlOTCBFJChIqAzBDboozhB6nT7AJtY9xN3
         3h452/1uCDBevydc5RI8PGV2dc3zgVVKbq0j5F5zK7FjvY1jCPNw8MkMh2GqfzVgXpgr
         VnRQ==
X-Gm-Message-State: ANoB5pnTldwm9HXfY2ewVOyv8zyNlqu53Qh4Cy0rDsmoKE7C3pN/5OCA
        Hw+M4pF3IMRoXaOHPXVUr6/06Fqnnhy0UKv4xkw=
X-Google-Smtp-Source: AA0mqf5rg/5yz+KYzWbKMFe/dStM3Ns5zD0KnUjtckusNEkGjCP92TRSsmkIGXlrFOUi9JM2gXlK6A==
X-Received: by 2002:a62:ea0e:0:b0:575:7bb:d6fc with SMTP id t14-20020a62ea0e000000b0057507bbd6fcmr29886365pfh.79.1670002491008;
        Fri, 02 Dec 2022 09:34:51 -0800 (PST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090a6d8900b0020aacde1964sm6839975pjk.32.2022.12.02.09.34.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 09:34:50 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id y4so5254724plb.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:34:50 -0800 (PST)
X-Received: by 2002:a17:902:ce04:b0:174:af35:4b90 with SMTP id
 k4-20020a170902ce0400b00174af354b90mr53350453plg.8.1670002489709; Fri, 02 Dec
 2022 09:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20220920-standard-menues-v2-0-323be5539c22@chromium.org> <20220920-standard-menues-v2-2-323be5539c22@chromium.org>
In-Reply-To: <20220920-standard-menues-v2-2-323be5539c22@chromium.org>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 2 Dec 2022 18:34:37 +0100
X-Gmail-Original-Message-ID: <CANiDSCtAxgLnTeD_GPRMPO05gJebTgZ=b-d3fWc17SPu2rxfHQ@mail.gmail.com>
Message-ID: <CANiDSCtAxgLnTeD_GPRMPO05gJebTgZ=b-d3fWc17SPu2rxfHQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] media: uvcvideo: Use standard names for menus
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this one. It is already part of the series Follow-up
patches for uvc v4l2-compliance

Sorry for sending it duplicated

On Fri, 2 Dec 2022 at 18:26, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Instead of duplicating the menu info, use the one from the core.
> Also, do not use extra memory for 1:1 mappings.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 116 +++++++++++++++++++++++++------------
>  drivers/media/usb/uvc/uvc_driver.c |   9 +--
>  drivers/media/usb/uvc/uvc_v4l2.c   |  81 ++++++++++++++++++++------
>  drivers/media/usb/uvc/uvcvideo.h   |   3 +-
>  include/uapi/linux/uvcvideo.h      |   3 +-
>  5 files changed, 145 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 13bc57e2a08d..3bb1c97c7e11 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -362,19 +362,31 @@ static const u32 uvc_control_classes[] = {
>         V4L2_CID_USER_CLASS,
>  };
>
> -static const struct uvc_menu_info power_line_frequency_controls[] = {
> -       { 0, "Disabled" },
> -       { 1, "50 Hz" },
> -       { 2, "60 Hz" },
> -       { 3, "Auto" },
> -};
> +static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
>
> -static const struct uvc_menu_info exposure_auto_controls[] = {
> -       { 2, "Auto Mode" },
> -       { 1, "Manual Mode" },
> -       { 4, "Shutter Priority Mode" },
> -       { 8, "Aperture Priority Mode" },
> -};
> +static u32 uvc_mapping_get_menu_value(struct uvc_control_mapping *mapping,
> +                                     u32 idx)
> +{
> +       if (!test_bit(idx, &mapping->menu_mask))
> +               return 0;
> +
> +       if (mapping->menu_mapping)
> +               return mapping->menu_mapping[idx];
> +
> +       return idx;
> +}
> +
> +static const char
> +*uvc_mapping_get_menu_name(struct uvc_control_mapping *mapping, u32 idx)
> +{
> +       if (!test_bit(idx, &mapping->menu_mask))
> +               return NULL;
> +
> +       if (mapping->menu_names)
> +               return mapping->menu_names[idx];
> +
> +       return v4l2_ctrl_get_menu(mapping->id)[idx];
> +}
>
>  static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
>         u8 query, const u8 *data)
> @@ -523,9 +535,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> -               .menu_info      = exposure_auto_controls,
> +               .menu_mapping   = exposure_auto_mapping,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
> +                       GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
>                 .slave_ids      = { V4L2_CID_EXPOSURE_ABSOLUTE, },
>         },
>         {
> @@ -730,9 +742,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> -               .menu_info      = power_line_frequency_controls,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
> +                       GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
>         },
>  };
>
> @@ -745,9 +756,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>                 .offset         = 0,
>                 .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>                 .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> -               .menu_info      = power_line_frequency_controls,
>                 .menu_mask      =
> -                       BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
> +                       GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
>         },
>  };
>
> @@ -974,13 +984,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>         s32 value = mapping->get(mapping, UVC_GET_CUR, data);
>
>         if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
> -               const struct uvc_menu_info *menu = mapping->menu_info;
>                 unsigned int i;
>
> -               for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +               for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
> +                       u32 menu_value;
> +
>                         if (!test_bit(i, &mapping->menu_mask))
>                                 continue;
> -                       if (menu->value == value) {
> +
> +                       menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +                       if (menu_value == value) {
>                                 value = i;
>                                 break;
>                         }
> @@ -1112,7 +1126,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  {
>         struct uvc_control_mapping *master_map = NULL;
>         struct uvc_control *master_ctrl = NULL;
> -       const struct uvc_menu_info *menu;
>         unsigned int i;
>
>         memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> @@ -1157,11 +1170,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
>                 v4l2_ctrl->step = 1;
>
> -               menu = mapping->menu_info;
> -               for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +               for (i = 1; BIT(i) <= mapping->menu_mask; ++i) {
> +                       u32 menu_value;
> +
>                         if (!test_bit(i, &mapping->menu_mask))
>                                 continue;
> -                       if (menu->value == v4l2_ctrl->default_value) {
> +
> +                       menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +                       if (menu_value == v4l2_ctrl->default_value) {
>                                 v4l2_ctrl->default_value = i;
>                                 break;
>                         }
> @@ -1254,11 +1271,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>         struct v4l2_querymenu *query_menu)
>  {
> -       const struct uvc_menu_info *menu_info;
>         struct uvc_control_mapping *mapping;
>         struct uvc_control *ctrl;
>         u32 index = query_menu->index;
>         u32 id = query_menu->id;
> +       const char *name;
>         int ret;
>
>         memset(query_menu, 0, sizeof(*query_menu));
> @@ -1280,11 +1297,10 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>                 goto done;
>         }
>
> -       menu_info = &mapping->menu_info[query_menu->index];
> -
>         if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK &&
>             (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)) {
>                 s32 bitmap;
> +               u32 menu_value;
>
>                 if (!ctrl->cached) {
>                         ret = uvc_ctrl_populate_cache(chain, ctrl);
> @@ -1292,15 +1308,22 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>                                 goto done;
>                 }
>
> +               menu_value = uvc_mapping_get_menu_value(mapping,
> +                                                       query_menu->index);
> +
>                 bitmap = mapping->get(mapping, UVC_GET_RES,
>                                       uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> -               if (!(bitmap & menu_info->value)) {
> +               if (!(bitmap & menu_value)) {
>                         ret = -EINVAL;
>                         goto done;
>                 }
>         }
>
> -       strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
> +       name = uvc_mapping_get_menu_name(mapping, query_menu->index);
> +       if (name)
> +               strscpy(query_menu->name, name, sizeof(query_menu->name));
> +       else
> +               ret = -EINVAL;
>
>  done:
>         mutex_unlock(&chain->ctrl_mutex);
> @@ -1790,7 +1813,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                 if (!test_bit(xctrl->value, &mapping->menu_mask))
>                         return -EINVAL;
>
> -               value = mapping->menu_info[xctrl->value].value;
> +               value = uvc_mapping_get_menu_value(mapping, xctrl->value);
>
>                 /*
>                  * Valid menu indices are reported by the GET_RES request for
> @@ -2239,12 +2262,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>
>         INIT_LIST_HEAD(&map->ev_subs);
>
> -       size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
> -       map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
> -       if (map->menu_info == NULL) {
> -               kfree(map->name);
> -               kfree(map);
> -               return -ENOMEM;
> +       if (mapping->menu_mapping && mapping->menu_mask) {
> +               size = sizeof(mapping->menu_mapping[0]) *
> +                             fls(mapping->menu_mask);
> +               map->menu_mapping = kmemdup(mapping->menu_mapping, size,
> +                                           GFP_KERNEL);
> +               if (!map->menu_mapping) {
> +                       kfree(map->name);
> +                       kfree(map);
> +                       return -ENOMEM;
> +               }
> +       }
> +       if (mapping->menu_names && mapping->menu_mask) {
> +               size = sizeof(mapping->menu_names[0]) *
> +                             fls(mapping->menu_mask);
> +               map->menu_names = kmemdup(mapping->menu_names, size,
> +                                         GFP_KERNEL);
> +               if (!map->menu_names) {
> +                       kfree(map->menu_mapping);
> +                       kfree(map->name);
> +                       kfree(map);
> +                       return -ENOMEM;
> +               }
>         }
>
>         if (map->get == NULL)
> @@ -2589,7 +2628,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
>
>         list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
>                 list_del(&mapping->list);
> -               kfree(mapping->menu_info);
> +               kfree(mapping->menu_names);
> +               kfree(mapping->menu_mapping);
>                 kfree(mapping->name);
>                 kfree(mapping);
>         }
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 09cc459c1253..a8d2260cca1d 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2661,11 +2661,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>
> -static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> -       { 1, "50 Hz" },
> -       { 2, "60 Hz" },
> -};
> -
>  static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>         .id             = V4L2_CID_POWER_LINE_FREQUENCY,
>         .entity         = UVC_GUID_UVC_PROCESSING,
> @@ -2674,9 +2669,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>         .offset         = 0,
>         .v4l2_type      = V4L2_CTRL_TYPE_MENU,
>         .data_type      = UVC_CTRL_DATA_TYPE_ENUM,
> -       .menu_info      = power_line_frequency_controls_limited,
> -       .menu_mask      =
> -               BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
> +       .menu_mask      = GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 1),
>  };
>
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 07c7acce8025..75be164baf4d 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -25,6 +25,64 @@
>
>  #include "uvcvideo.h"
>
> +static int uvc_control_xu_2_mapping(struct uvc_control_mapping *map,
> +                                   struct uvc_xu_control_mapping *xmap)
> +{
> +       char (*names)[UVC_MENU_NAME_LEN];
> +       unsigned int i;
> +       u32 *mapping;
> +       size_t size;
> +
> +       /* Prevent excessive memory consumption, as well as integer
> +        * overflows.
> +        */
> +       if (xmap->menu_count == 0 ||
> +           xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
> +               return -EINVAL;
> +
> +       map->menu_mask = BIT_MASK(xmap->menu_count);
> +
> +       size = xmap->menu_count * sizeof(*map->menu_mapping);
> +       mapping = kzalloc(size, GFP_KERNEL);
> +       if (!mapping)
> +               return -ENOMEM;
> +
> +       for (i = 0; i < xmap->menu_count ; i++)
> +               if (copy_from_user(&mapping[i], &xmap->menu_info[i].value,
> +                                  sizeof(mapping[i]))) {
> +                       kfree(mapping);
> +                       return -ENOMEM;
> +               }
> +
> +       map->menu_mapping = mapping;
> +
> +       /*
> +        * Always use the standard naming if available.
> +        */
> +       if (v4l2_ctrl_get_menu(map->id))
> +               return 0;
> +
> +       size = xmap->menu_count * sizeof(map->menu_names[0]);
> +       names = kzalloc(size, GFP_KERNEL);
> +       if (!names) {
> +               kfree(mapping);
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; i < xmap->menu_count ; i++) {
> +               /* sizeof(names[i]) - 1: to take care of \0 */
> +               if (copy_from_user(&names[i], &xmap->menu_info[i].name,
> +                                  sizeof(names[i]) - 1)) {
> +                       kfree(names);
> +                       kfree(mapping);
> +                       return -ENOMEM;
> +               }
> +       }
> +       map->menu_names = names;
> +
> +       return 0;
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -32,7 +90,6 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>         struct uvc_xu_control_mapping *xmap)
>  {
>         struct uvc_control_mapping *map;
> -       unsigned int size;
>         int ret;
>
>         map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -63,24 +120,9 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>                 break;
>
>         case V4L2_CTRL_TYPE_MENU:
> -               /*
> -                * Prevent excessive memory consumption, as well as integer
> -                * overflows.
> -                */
> -               if (xmap->menu_count == 0 ||
> -                   xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES) {
> -                       ret = -EINVAL;
> -                       goto free_map;
> -               }
> -
> -               size = xmap->menu_count * sizeof(*map->menu_info);
> -               map->menu_info = memdup_user(xmap->menu_info, size);
> -               if (IS_ERR(map->menu_info)) {
> -                       ret = PTR_ERR(map->menu_info);
> +               ret = uvc_control_xu_2_mapping(map, xmap);
> +               if (ret)
>                         goto free_map;
> -               }
> -
> -               map->menu_mask = BIT_MASK(xmap->menu_count);
>                 break;
>
>         default:
> @@ -92,7 +134,8 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>
>         ret = uvc_ctrl_add_mapping(chain, map);
>
> -       kfree(map->menu_info);
> +       kfree(map->menu_names);
> +       kfree(map->menu_mapping);
>  free_map:
>         kfree(map);
>
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index fde4e975334f..2bb0a5951915 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -254,7 +254,8 @@ struct uvc_control_mapping {
>         enum v4l2_ctrl_type v4l2_type;
>         u32 data_type;
>
> -       const struct uvc_menu_info *menu_info;
> +       const u32 *menu_mapping;
> +       const char (*menu_names)[UVC_MENU_NAME_LEN];
>         unsigned long menu_mask;
>
>         u32 master_id;
> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> index 8288137387c0..1b64b6aa40b5 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -36,9 +36,10 @@
>          UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
>          UVC_CTRL_FLAG_GET_DEF)
>
> +#define UVC_MENU_NAME_LEN 32
>  struct uvc_menu_info {
>         __u32 value;
> -       __u8 name[32];
> +       __u8 name[UVC_MENU_NAME_LEN];
>  };
>
>  struct uvc_xu_control_mapping {
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae



-- 
Ricardo Ribalda
