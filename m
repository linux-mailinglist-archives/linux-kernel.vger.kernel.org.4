Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8965C860
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239035AbjACUrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbjACUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:46:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DA7311;
        Tue,  3 Jan 2023 12:46:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 23786108;
        Tue,  3 Jan 2023 21:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672778811;
        bh=DScUw1fE60SoKkKPLNQyjNxnwpp818IzduZxaUOjVn0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbqAr7wOunULK0EiEHM0dAwtrxmFMj3QEJERTS8cjikfG4EokCqsFa/xo1B7QfeBZ
         NqspRsJi9AgvFhbI/HzwtCSxzluQsAym0z2y8cLR8EM/VIZ4SNedCeliJLb7kayL5P
         pDyBnPwMO+zQMhT84YKgn4IUy7uTjMmTxA6b8eq4=
Date:   Tue, 3 Jan 2023 22:46:47 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3 8/8] media: uvcvideo: Use standard names for menus
Message-ID: <Y7SUN8A/A4Yu9w+k@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
 <20220920-resend-v4l2-compliance-v3-8-598d33a15815@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v3-8-598d33a15815@chromium.org>
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

On Tue, Jan 03, 2023 at 03:36:26PM +0100, Ricardo Ribalda wrote:
> Instead of duplicating the menu info, use the one from the core.
> Also, do not use extra memory for 1:1 mappings.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 126 +++++++++++++++++++++++++------------
>  drivers/media/usb/uvc/uvc_driver.c |   9 +--
>  drivers/media/usb/uvc/uvc_v4l2.c   | 104 ++++++++++++++++++++++--------
>  drivers/media/usb/uvc/uvcvideo.h   |   3 +-
>  include/uapi/linux/uvcvideo.h      |   4 +-
>  5 files changed, 170 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4830120e6506..86d74c9740b0 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -364,19 +364,31 @@ static const u32 uvc_control_classes[] = {
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
> +static int uvc_mapping_get_menu_value(const struct uvc_control_mapping *mapping,
> +				      u32 idx)
> +{
> +	if (!test_bit(idx, &mapping->menu_mask))
> +		return -EINVAL;
> +
> +	if (mapping->menu_mapping)
> +		return mapping->menu_mapping[idx];
> +
> +	return idx;
> +}
> +
> +static const char *
> +uvc_mapping_get_menu_name(const struct uvc_control_mapping *mapping, u32 idx)
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
> @@ -525,8 +537,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
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
> @@ -731,8 +743,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>  		.offset		= 0,
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ, 0),
>  	},
>  };
>  
> @@ -745,8 +756,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  		.offset		= 0,
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
> -		.menu_info	= power_line_frequency_controls,
> -		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO, 0),
>  	},
>  };
>  
> @@ -973,13 +983,17 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
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
> @@ -1190,7 +1204,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  {
>  	struct uvc_control_mapping *master_map = NULL;
>  	struct uvc_control *master_ctrl = NULL;
> -	const struct uvc_menu_info *menu;
>  	unsigned int i;
>  
>  	memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> @@ -1235,11 +1248,15 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
> @@ -1338,11 +1355,11 @@ int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
> @@ -1364,22 +1381,34 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
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
> +		if (menu_value < 0) {
> +			ret = menu_value;
> +			goto done;
> +		}

Please add a blank line.

> +		if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & menu_value)) {

If mapping->menu_mapping is not specified, uvc_mapping_get_menu_value()
return an index, and here you interpret it as a bitmask. I assume this
works because the UVC_CTRL_DATA_TYPE_BITMASK control supported by the
driver (there's only one) has a menu_mapping that translates to a
bitmask.

>  			ret = -EINVAL;
>  			goto done;
>  		}
>  	}
>  
> -	strscpy(query_menu->name, menu_info->name, sizeof(query_menu->name));
> +	name = uvc_mapping_get_menu_name(mapping, query_menu->index);
> +	if (!name) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	strscpy(query_menu->name, name, sizeof(query_menu->name));
>  
>  done:
>  	mutex_unlock(&chain->ctrl_mutex);
> @@ -1880,7 +1909,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		if (!test_bit(xctrl->value, &mapping->menu_mask))
>  			return -EINVAL;
>  
> -		value = mapping->menu_info[xctrl->value].value;
> +		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
>  
>  		/*
>  		 * Valid menu indices are reported by the GET_RES request for
> @@ -2305,21 +2334,36 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  		return -ENOMEM;
>  
>  	map->name = NULL;
> -	map->menu_info = NULL;
> +	map->menu_names = NULL;
> +	map->menu_mapping = NULL;
>  
>  	/* For UVCIOC_CTRL_MAP custom control */
>  	if (mapping->name) {
>  		map->name = kstrdup(mapping->name, GFP_KERNEL);
> -		if (!map->name)
> -			goto nomem;
> +		if (!map->name) {
> +			kfree(map);
> +			return -ENOMEM;

Anything wrong with the goto nomem here ?

> +		}
>  	}
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
> -	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
> -	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
> -	if (!map->menu_info)
> -		goto nomem;
> +	if (mapping->menu_mapping && mapping->menu_mask) {
> +		size = sizeof(mapping->menu_mapping[0])
> +		       * fls(mapping->menu_mask);
> +		map->menu_mapping = kmemdup(mapping->menu_mapping, size,
> +					    GFP_KERNEL);
> +		if (!map->menu_mapping)
> +			goto nomem;
> +	}
> +	if (mapping->menu_names && mapping->menu_mask) {
> +		size = sizeof(mapping->menu_names[0])
> +		       * fls(mapping->menu_mask);
> +		map->menu_names = kmemdup(mapping->menu_names, size,
> +					  GFP_KERNEL);
> +		if (!map->menu_names)
> +			goto nomem;
> +	}
>  
>  	if (map->get == NULL)
>  		map->get = uvc_get_le_value;
> @@ -2342,7 +2386,8 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  	return 0;
>  
>  nomem:
> -	kfree(map->menu_info);
> +	kfree(map->menu_names);
> +	kfree(map->menu_mapping);
>  	kfree(map->name);
>  	kfree(map);
>  	return -ENOMEM;
> @@ -2673,7 +2718,8 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
>  
>  	list_for_each_entry_safe(mapping, nm, &ctrl->info.mappings, list) {
>  		list_del(&mapping->list);
> -		kfree(mapping->menu_info);
> +		kfree(mapping->menu_names);
> +		kfree(mapping->menu_mapping);
>  		kfree(mapping->name);
>  		kfree(mapping);
>  	}
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index f9e6208c4636..ee016b370058 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2371,11 +2371,6 @@ MODULE_PARM_DESC(timeout, "Streaming control requests timeout");
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
> @@ -2384,8 +2379,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
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
> index ed2525e7e2a5..dfa26ed0c7f1 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -26,14 +26,83 @@
>  
>  #include "uvcvideo.h"
>  
> +static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
> +				      struct uvc_control_mapping *map,
> +				      const struct uvc_xu_control_mapping *xmap)
> +{
> +	unsigned int i;
> +	size_t size;
> +	int ret;
> +
> +	/*
> +	 * Prevent excessive memory consumption, as well as integer
> +	 * overflows.
> +	 */
> +	if (xmap->menu_count == 0 ||
> +	    xmap->menu_count > UVC_MAX_CONTROL_MENU_ENTRIES)
> +		return -EINVAL;
> +
> +	map->menu_names = NULL;
> +	map->menu_mapping = NULL;
> +
> +	map->menu_mask = BIT_MASK(xmap->menu_count);
> +
> +	size = xmap->menu_count * sizeof(*map->menu_mapping);
> +	map->menu_mapping = kzalloc(size, GFP_KERNEL);
> +	if (!map->menu_mapping) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < xmap->menu_count ; i++) {
> +		if (copy_from_user((u32 *)&map->menu_mapping[i],
> +				   &xmap->menu_info[i].value,
> +				   sizeof(map->menu_mapping[i]))) {
> +			ret = -EACCES;
> +			goto exit;
> +		}
> +	}
> +
> +	/* Always use the standard naming if available. */
> +	if (v4l2_ctrl_get_menu(map->id))
> +		goto done_mapping;
> +
> +	size = xmap->menu_count * sizeof(map->menu_names[0]);
> +	map->menu_names = kzalloc(size, GFP_KERNEL);
> +	if (!map->menu_names) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	for (i = 0; i < xmap->menu_count ; i++) {
> +		/* sizeof(names[i]) - 1: to take care of \0 */
> +		if (copy_from_user((char *)map->menu_names[i],
> +				   xmap->menu_info[i].name,
> +				   sizeof(map->menu_names[i]) - 1)) {
> +			ret = -EACCES;
> +			goto exit;
> +		}
> +	}

While I'm a big proponent of goto's for error handling, I tend to frown
upon them in most other case as they hinder readability and can hide
design problems. Here you can simply write

	/*
	 * Always use the standard naming if available, otherwise copy the names
	 * supplied by userspace.
	 */
	if (!v4l2_ctrl_get_menu(map->id)) {
		size = xmap->menu_count * sizeof(map->menu_names[0]);
		map->menu_names = kzalloc(size, GFP_KERNEL);
		if (!map->menu_names) {
			ret = -ENOMEM;
			goto exit;
		}

		for (i = 0; i < xmap->menu_count ; i++) {
			/* sizeof(names[i]) - 1: to take care of \0 */
			if (copy_from_user((char *)map->menu_names[i],
					   xmap->menu_info[i].name,
					   sizeof(map->menu_names[i]) - 1)) {
				ret = -EACCES;
				goto exit;
			}
		}
	}

> +
> +done_mapping:
> +	ret = uvc_ctrl_add_mapping(chain, map);
> +
> +exit:

The driver uses several done: labels but no exit:. Let's stick with
'done' for consistency.

> +	kfree(map->menu_names);
> +	map->menu_names = NULL;
> +	kfree(map->menu_mapping);
> +	map->menu_mapping = NULL;
> +
> +	return ret;
> +}
> +
>  /* ------------------------------------------------------------------------
>   * UVC ioctls
>   */
> -static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
> -	struct uvc_xu_control_mapping *xmap)
> +static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
> +				 struct uvc_xu_control_mapping *xmap)
>  {
>  	struct uvc_control_mapping *map;
> -	unsigned int size;
>  	int ret;
>  
>  	map = kzalloc(sizeof(*map), GFP_KERNEL);
> @@ -61,39 +130,20 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  	case V4L2_CTRL_TYPE_INTEGER:
>  	case V4L2_CTRL_TYPE_BOOLEAN:
>  	case V4L2_CTRL_TYPE_BUTTON:
> +		ret = uvc_ctrl_add_mapping(chain, map);
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
> -			goto free_map;
> -		}
> -
> -		map->menu_mask = BIT_MASK(xmap->menu_count);
> +		ret = uvc_control_add_xu_mapping(chain, map, xmap);
>  		break;
>  
>  	default:
>  		uvc_dbg(chain->dev, CONTROL,
>  			"Unsupported V4L2 control type %u\n", xmap->v4l2_type);
>  		ret = -ENOTTY;
> -		goto free_map;
> +		break;
>  	}
>  
> -	ret = uvc_ctrl_add_mapping(chain, map);
> -
> -	kfree(map->menu_info);
>  free_map:
>  	kfree(map);
>  
> @@ -1316,7 +1366,7 @@ static long uvc_ioctl_default(struct file *file, void *fh, bool valid_prio,
>  	switch (cmd) {
>  	/* Dynamic controls. */
>  	case UVCIOC_CTRL_MAP:
> -		return uvc_ioctl_ctrl_map(chain, arg);
> +		return uvc_ioctl_xu_ctrl_map(chain, arg);
>  
>  	case UVCIOC_CTRL_QUERY:
>  		return uvc_xu_ctrl_query(chain, arg);
> @@ -1429,7 +1479,7 @@ static long uvc_v4l2_compat_ioctl32(struct file *file,
>  		ret = uvc_v4l2_get_xu_mapping(&karg.xmap, up);
>  		if (ret)
>  			return ret;
> -		ret = uvc_ioctl_ctrl_map(handle->chain, &karg.xmap);
> +		ret = uvc_ioctl_xu_ctrl_map(handle->chain, &karg.xmap);
>  		if (ret)
>  			return ret;
>  		ret = uvc_v4l2_put_xu_mapping(&karg.xmap, up);
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index f75e5864bbf7..0e816be556f2 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -116,7 +116,8 @@ struct uvc_control_mapping {
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
> index 8288137387c0..d45d0c2ea252 100644
> --- a/include/uapi/linux/uvcvideo.h
> +++ b/include/uapi/linux/uvcvideo.h
> @@ -36,9 +36,11 @@
>  	 UVC_CTRL_FLAG_GET_MAX | UVC_CTRL_FLAG_GET_RES | \
>  	 UVC_CTRL_FLAG_GET_DEF)
>  
> +#define UVC_MENU_NAME_LEN 32
> +
>  struct uvc_menu_info {
>  	__u32 value;
> -	__u8 name[32];
> +	__u8 name[UVC_MENU_NAME_LEN];
>  };
>  
>  struct uvc_xu_control_mapping {
> 

-- 
Regards,

Laurent Pinchart
