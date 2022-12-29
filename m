Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2D165925F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 23:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiL2WGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 17:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiL2WGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:06:37 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CD86560;
        Thu, 29 Dec 2022 14:06:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8DA9283;
        Thu, 29 Dec 2022 23:06:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672351593;
        bh=agfJuDG0n/AVc4UW5F93JCsJhE4sD6TySKtuYSoU2n0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J3diwGd71hBMAxKpQthbFTXQBaZwrrAVN+8Rcr96zFoTinQsnSbQg3So0OTgncJFo
         kpAqvWr1P2IA5RxFV58HLASX6T3nQ1xEZI2/OPbAXQ5wYAr0E9WNUcfJRqZpiWbZcr
         xSdyKBi3BGpccdQsB7HtG6iarNG66SeY7AsS+T6Q=
Date:   Fri, 30 Dec 2022 00:06:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 7/7] media: uvcvideo: Use standard names for
 menus
Message-ID: <Y64PY7TKn7P+3DnM@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
 <20220920-resend-v4l2-compliance-v2-7-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v2-7-b0ceb15353ac@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Fri, Dec 02, 2022 at 06:21:41PM +0100, Ricardo Ribalda wrote:
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
>  5 files changed, 146 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index df273b829961..5c28d8aace37 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -363,19 +363,31 @@ static const u32 uvc_control_classes[] = {
>  	V4L2_CID_USER_CLASS,
>  };
>  
> -static const struct uvc_menu_info power_line_frequency_controls[] = {
> -	{ 0, "Disabled" },
> -	{ 1, "50 Hz" },
> -	{ 2, "60 Hz" },
> -	{ 3, "Auto" },
> -};
> +static const int exposure_auto_mapping[] = { 2, 1, 4, 8 };
>  
> -static const struct uvc_menu_info exposure_auto_controls[] = {
> -	{ 2, "Auto Mode" },
> -	{ 1, "Manual Mode" },
> -	{ 4, "Shutter Priority Mode" },
> -	{ 8, "Aperture Priority Mode" },
> -};
> +static u32 uvc_mapping_get_menu_value(struct uvc_control_mapping *mapping,

The mapping argument can be const.

> +				      u32 idx)
> +{
> +	if (!test_bit(idx, &mapping->menu_mask))
> +		return 0;

0 is a valid menu value, are all callers fine with not being able to
differentiate it from an error ?

> +
> +	if (mapping->menu_mapping)
> +		return mapping->menu_mapping[idx];
> +
> +	return idx;
> +}
> +
> +static const char
> +*uvc_mapping_get_menu_name(struct uvc_control_mapping *mapping, u32 idx)

Here too. And the * belongs to the previous line.

> +{
> +	if (!test_bit(idx, &mapping->menu_mask))
> +		return NULL;
> +
> +	if (mapping->menu_names)
> +		return mapping->menu_names[idx];
> +
> +	return v4l2_ctrl_get_menu(mapping->id)[idx];
> +}
>  
>  static s32 uvc_ctrl_get_zoom(struct uvc_control_mapping *mapping,
>  	u8 query, const u8 *data)
> @@ -524,8 +536,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  		.offset		= 0,
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
> -		.menu_info	= exposure_auto_controls,
> -		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
> +		.menu_mapping	= exposure_auto_mapping,
> +		.menu_mask	= GENMASK(ARRAY_SIZE(exposure_auto_mapping) - 1, 0),
>  		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
>  	},
>  	{
> @@ -730,8 +742,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>  		.offset		= 0,
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
>  	},
>  };
>  
> @@ -744,8 +755,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  		.offset		= 0,
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
>  	},
>  };
>  
> @@ -972,13 +982,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>  	s32 value = mapping->get(mapping, UVC_GET_CUR, data);
>  
>  	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) {
> -		const struct uvc_menu_info *menu = mapping->menu_info;
>  		unsigned int i;
>  
> -		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
> +			u32 menu_value;
> +
>  			if (!test_bit(i, &mapping->menu_mask))
>  				continue;
> -			if (menu->value == value) {
> +
> +			menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +			if (menu_value == value) {
>  				value = i;
>  				break;
>  			}
> @@ -1174,7 +1188,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  {
>  	struct uvc_control_mapping *master_map = NULL;
>  	struct uvc_control *master_ctrl = NULL;
> -	const struct uvc_menu_info *menu;
>  	unsigned int i;
>  
>  	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> @@ -1219,11 +1232,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
>  		v4l2_ctrl->step = 1;
>  
> -		menu = mapping->menu_info;
> -		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +		for (i = 0; BIT(i) <= mapping->menu_mask; ++i) {
> +			u32 menu_value;
> +
>  			if (!test_bit(i, &mapping->menu_mask))
>  				continue;
> -			if (menu->value == v4l2_ctrl->default_value) {
> +
> +			menu_value = uvc_mapping_get_menu_value(mapping, i);
> +
> +			if (menu_value == v4l2_ctrl->default_value) {
>  				v4l2_ctrl->default_value = i;
>  				break;
>  			}
> @@ -1322,11 +1339,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  	struct v4l2_querymenu *query_menu)
>  {
> -	const struct uvc_menu_info *menu_info;
>  	struct uvc_control_mapping *mapping;
>  	struct uvc_control *ctrl;
>  	u32 index = query_menu->index;
>  	u32 id = query_menu->id;
> +	const char *name;
>  	int ret;
>  
>  	memset(query_menu, 0, sizeof(*query_menu));
> @@ -1348,22 +1365,28 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  		goto done;
>  	}
>  
> -	menu_info = &mapping->menu_info[query_menu->index];
> -
>  	if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
> +		u32 menu_value;
> +
>  		if (!ctrl->cached) {
>  			ret = uvc_ctrl_populate_cache(chain, ctrl);
>  			if (ret < 0)
>  				goto done;
>  		}
>  
> -		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_info->value)) {
> +		menu_value = uvc_mapping_get_menu_value(mapping,
> +							query_menu->index);
> +		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_value)) {
>  			ret = -EINVAL;
>  			goto done;
>  		}
>  	}
>  
> -	strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
> +	name = uvc_mapping_get_menu_name(mapping, query_menu->index);
> +	if (name)
> +		strscpy(query_menu->name, name, sizeof(query_menu->name));
> +	else
> +		ret = -EINVAL;

	if (!name) {
		ret = -EINVAL;
		goto done;
	}

	strscpy(query_menu->name, name, sizeof(query_menu->name));

>  
>  done:
>  	mutex_unlock(&chain->ctrl_mutex);
> @@ -1865,7 +1888,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		if (!test_bit(xctrl->value, &mapping->menu_mask))
>  			return -EINVAL;
>  
> -		value = mapping->menu_info[xctrl->value].value;
> +		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
>  
>  		/*
>  		 * Valid menu indices are reported by the GET_RES request for
> @@ -2311,12 +2334,28 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
> -	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
> -	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
> -	if (map->menu_info == NULL) {
> -		kfree(map->name);
> -		kfree(map);
> -		return -ENOMEM;
> +	if (mapping->menu_mapping && mapping->menu_mask) {
> +		size = sizeof(mapping->menu_mapping[0]) *
> +			      fls(mapping->menu_mask);

Misleading indentation.

		size = sizeof(mapping->menu_mapping[0]) *
		       fls(mapping->menu_mask);

or better

		size = sizeof(mapping->menu_mapping[0])
		     * fls(mapping->menu_mask);

> +		map->menu_mapping = kmemdup(mapping->menu_mapping, size,
> +					    GFP_KERNEL);
> +		if (!map->menu_mapping) {
> +			kfree(map->name);
> +			kfree(map);
> +			return -ENOMEM;
> +		}
> +	}
> +	if (mapping->menu_names && mapping->menu_mask) {
> +		size = sizeof(mapping->menu_names[0]) *
> +			      fls(mapping->menu_mask);

Same here.

> +		map->menu_names = kmemdup(mapping->menu_names, size,
> +					  GFP_KERNEL);
> +		if (!map->menu_names) {
> +			kfree(map->menu_mapping);
> +			kfree(map->name);
> +			kfree(map);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	if (map->get == NULL)
> @@ -2661,7 +2700,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
>  
>  	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
>  		list_del(&mapping->list);
> -		kfree(mapping->menu_info);
> +		kfree(mapping->menu_names);
> +		kfree(mapping->menu_mapping);
>  		kfree(mapping->name);
>  		kfree(mapping);

That's getting long. You could initialize all the pointer fields of
mapping to NULL just after the kmemdup() call above, which should
simplify all these error paths by allowing all kfree() calls to be moved
to an error label. Maybe this could be done in a patch before this one ?

>  	}
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index abdb9ca7eed6..97c267e75fa4 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2661,11 +2661,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
>   * Driver initialization and cleanup
>   */
>  
> -static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
> -	{ 1, "50 Hz" },
> -	{ 2, "60 Hz" },
> -};
> -
>  static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  	.id		= V4L2_CID_POWER_LINE_FREQUENCY,
>  	.entity		= UVC_GUID_UVC_PROCESSING,
> @@ -2674,8 +2669,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  	.offset		= 0,
>  	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),
> +	.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
> +				  V4L2_CID_POWER_LINE_FREQUENCY_50HZ),
>  };
>  
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index e6792fd46bf5..89581c1559df 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -25,6 +25,64 @@
>  
>  #include "uvcvideo.h"
>  
> +static int uvc_control_xu_2_mapping(struct uvc_control_mapping *map,
> +				    struct uvc_xu_control_mapping *xmap)
> +{
> +	char (*names)[UVC_MENU_NAME_LEN];
> +	unsigned int i;
> +	u32 *mapping;
> +	size_t size;
> +
> +	/* Prevent excessive memory consumption, as well as integer

Wrong comment style.

> +	 * overflows.
> +	 */
> +	if (xmap->menu_count == 0 ||
> +	    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
> +		return -EINVAL;
> +
> +	map->menu_mask = BIT_MASK(xmap->menu_count);
> +
> +	size = xmap->menu_count * sizeof(*map->menu_mapping);
> +	mapping = kzalloc(size, GFP_KERNEL);
> +	if (!mapping)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < xmap->menu_count ; i++)

Missing braces.

> +		if (copy_from_user(&mapping[i], &xmap->menu_info[i].value,
> +				   sizeof(mapping[i]))) {
> +			kfree(mapping);
> +			return -ENOMEM;
> +		}
> +
> +	map->menu_mapping = mapping;
> +
> +	/*
> +	 * Always use the standard naming if available.

Holds on a single line.

> +	 */
> +	if (v4l2_ctrl_get_menu(map->id))
> +		return 0;
> +
> +	size = xmap->menu_count * sizeof(map->menu_names[0]);
> +	names = kzalloc(size, GFP_KERNEL);
> +	if (!names) {
> +		kfree(mapping);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < xmap->menu_count ; i++) {
> +		/* sizeof(names[i]) - 1: to take care of \0 */
> +		if (copy_from_user(&names[i], &xmap->menu_info[i].name,
> +				   sizeof(names[i]) - 1)) {
> +			kfree(names);
> +			kfree(mapping);
> +			return -ENOMEM;

map->menu_mapping isn't NULL when you return, that's asking for problem
later.

> +		}
> +	}

Add a blank line.

> +	map->menu_names = names;
> +
> +	return 0;
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> @@ -32,7 +90,6 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  	struct uvc_xu_control_mapping *xmap)
>  {
>  	struct uvc_control_mapping *map;
> -	unsigned int size;
>  	int ret;
>  
>  	map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -63,24 +120,9 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  		break;
>  
>  	case V4L2_CTRL_TYPE_MENU:
> -		/*
> -		 * Prevent excessive memory consumption, as well as integer
> -		 * overflows.
> -		 */
> -		if (xmap->menu_count == 0 ||
> -		    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES) {
> -			ret = -EINVAL;
> -			goto free_map;
> -		}
> -
> -		size = xmap->menu_count * sizeof(*map->menu_info);
> -		map->menu_info = memdup_user(xmap->menu_info, size);
> -		if (IS_ERR(map->menu_info)) {
> -			ret = PTR_ERR(map->menu_info);
> +		ret = uvc_control_xu_2_mapping(map, xmap);

That's not a great function name, as uvc_ioctl_ctrl_map() deals with XUs
only.

> +		if (ret)
>  			goto free_map;
> -		}
> -
> -		map->menu_mask = BIT_MASK(xmap->menu_count);
>  		break;
>  
>  	default:
> @@ -92,7 +134,8 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  
>  	ret = uvc_ctrl_add_mapping(chain, map);
>  
> -	kfree(map->menu_info);
> +	kfree(map->menu_names);
> +	kfree(map->menu_mapping);

Freeing here what you've allocated in a separate function makes me
cringe :-S

>  free_map:
>  	kfree(map);
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 7e2339fc256e..8ebd7ee2934d 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -254,7 +254,8 @@ struct uvc_control_mapping {
>  	enum v4l2_ctrl_type v4l2_type;
>  	u32 data_type;
>  
> -	const struct uvc_menu_info *menu_info;
> +	const u32 *menu_mapping;
> +	const char (*menu_names)[UVC_MENU_NAME_LEN];
>  	unsigned long menu_mask;
>  
>  	u32 master_id;
> diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvideo.h
> index 8288137387c0..1b64b6aa40b5 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -36,9 +36,10 @@
>  	 UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
>  	 UVC_CTRL_FLAG_GET_DEF)
>  
> +#define UVC_MENU_NAME_LEN 32

A blank line here would be nice.

>  struct uvc_menu_info {
>  	__u32 value;
> -	__u8 name[32];
> +	__u8 name[UVC_MENU_NAME_LEN];
>  };
>  
>  struct uvc_xu_control_mapping {

-- 
Regards,

Laurent Pinchart
