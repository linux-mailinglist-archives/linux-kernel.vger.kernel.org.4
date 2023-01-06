Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1EFF660838
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAFUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjAFUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:23:19 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D33792;
        Fri,  6 Jan 2023 12:22:25 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35C474AE;
        Fri,  6 Jan 2023 21:22:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673036543;
        bh=gMyLNyVlUsLLNnpbd+TmruH6PmeV4QiKmU39Cwqy9iQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyXkfqpmrgYqQfD0DB30UdBWSaSKGZ81Xb9C0L5btm67HpJNwFaTUsEH8BrZInyTX
         l15rrjQyGuh0NHb6kbc6GMJbgSFckeSrLK/LE86gC5YvEfeEMgIDV6d5k2gPcWz3CI
         SZVK0zIrSFfPKkrzda8lhR8eu53AB7JYUPAxW4Jg=
Date:   Fri, 6 Jan 2023 22:22:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, Yunke Cao <yunkec@chromium.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 3/7] media: uvcvideo: Implement mask for
 V4L2_CTRL_TYPE_MENU
Message-ID: <Y7iC+Bj+SydtrG5X@pendragon.ideasonboard.com>
References: <20230105-uvc-gcc5-v2-0-2ba6c660d6f5@chromium.org>
 <20230105-uvc-gcc5-v2-3-2ba6c660d6f5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230105-uvc-gcc5-v2-3-2ba6c660d6f5@chromium.org>
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

On Thu, Jan 05, 2023 at 02:52:54PM +0100, Ricardo Ribalda wrote:
> Replace the count with a mask field that lets us choose not only the max
> value, but also the minimum value and what values are valid in between.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 33 +++++++++++++++++++++++----------
>  drivers/media/usb/uvc/uvc_driver.c |  4 +++-
>  drivers/media/usb/uvc/uvc_v4l2.c   |  3 ++-
>  drivers/media/usb/uvc/uvcvideo.h   |  2 +-
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index ffa0e2654264..2ebe5cc18ad9 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -6,6 +6,7 @@
>   *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -525,7 +526,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
>  		.menu_info	= exposure_auto_controls,
> -		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
> +		.menu_mask	=
> +			GENMASK(ARRAY_SIZE(exposure_auto_controls) - 1, 0),

To be consistent, could this be

		.menu_mask	= GENMASK(V4L2_EXPOSURE_APERTURE_PRIORITY,
					  V4L2_EXPOSURE_AUTO),

? I can fix this when applying.

>  		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
>  	},
>  	{
> @@ -731,7 +733,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
> +					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
>  	},
>  };
>  
> @@ -745,7 +748,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
> +		.menu_mask	= GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_AUTO,
> +					  V4L2_CID_POWER_LINE_FREQUENCY_DISABLED),
>  	},
>  };
>  
> @@ -975,7 +979,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>  		const struct uvc_menu_info *menu = mapping->menu_info;
>  		unsigned int i;
>  
> -		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
> +		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +			if (!test_bit(i, &mapping->menu_mask))
> +				continue;

Now that I re-read this, I think there is a problem (update: after
writing this long explanation, the problem isn't in this patch, but I'll
keep the text below for reference).

This function translates a UVC control value to a V4L2 control value.
'i' is the V4L2 control value, as shown two lines down by

				value = i;

that makes the function return 'i' (we could just return i here). You're
testing if bit i is set in menu_mask, menu_mask is thus a bitmask of
supported V4L2 control values. That's fine for the controls listed
above, but below you have, in the definition of
uvc_ctrl_power_line_mapping_limited,

	.menu_mask	=
		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),

with

static const struct uvc_menu_info power_line_frequency_controls_limited[] = {
	{ 1, "50 Hz" },
	{ 2, "60 Hz" },
};

V4L2 defines

enum v4l2_power_line_frequency {
	V4L2_CID_POWER_LINE_FREQUENCY_DISABLED  = 0,
	V4L2_CID_POWER_LINE_FREQUENCY_50HZ      = 1,
	V4L2_CID_POWER_LINE_FREQUENCY_60HZ      = 2,
	V4L2_CID_POWER_LINE_FREQUENCY_AUTO      = 3,
};

so the above is effectively GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_50HZ,
V4L2_CID_POWER_LINE_FREQUENCY_DISABLED) and that's not correct.

We can just use GENMASK(V4L2_CID_POWER_LINE_FREQUENCY_60HZ,
V4L2_CID_POWER_LINE_FREQUENCY_50HZ) here, as the index 'i' in various
loops is also used to index the menu_info array.

This problem was introduced by commit 382075604a68 ("media: uvcvideo:
Limit power line control for Quanta UVC Webcam") which broke the
assumption that the menu_info array indices matched the standard V4L2
Amenu values, it is thus not a regression in this patch. I'll comment in
further patches in this series on related code, maybe it gets fixed
somewhere :-)

>  			if (menu->value == value) {
>  				value = i;
>  				break;
> @@ -1228,12 +1234,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>  
>  	switch (mapping->v4l2_type) {
>  	case V4L2_CTRL_TYPE_MENU:
> -		v4l2_ctrl->minimum = 0;
> -		v4l2_ctrl->maximum = mapping->menu_count - 1;
> +		v4l2_ctrl->minimum = ffs(mapping->menu_mask) - 1;
> +		v4l2_ctrl->maximum = fls(mapping->menu_mask) - 1;
>  		v4l2_ctrl->step = 1;
>  
>  		menu = mapping->menu_info;
> -		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
> +		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +			if (!test_bit(i, &mapping->menu_mask))
> +				continue;
>  			if (menu->value == v4l2_ctrl->default_value) {
>  				v4l2_ctrl->default_value = i;
>  				break;
> @@ -1354,7 +1362,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  		goto done;
>  	}
>  
> -	if (query_menu->index >= mapping->menu_count) {
> +	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
>  		ret = -EINVAL;
>  		goto done;
>  	}
> @@ -1868,8 +1876,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		break;
>  
>  	case V4L2_CTRL_TYPE_MENU:
> -		if (xctrl->value < 0 || xctrl->value >= mapping->menu_count)
> +		if (xctrl->value < (ffs(mapping->menu_mask) - 1) ||
> +		    xctrl->value > (fls(mapping->menu_mask) - 1))
>  			return -ERANGE;
> +
> +		if (!test_bit(xctrl->value, &mapping->menu_mask))
> +			return -EINVAL;
> +
>  		value = mapping->menu_info[xctrl->value].value;
>  
>  		/*
> @@ -2306,7 +2319,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
> -	size = sizeof(*mapping->menu_info) * mapping->menu_count;
> +	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
>  	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
>  	if (!map->menu_info)
>  		goto err_nomem;
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 6d08457ecb9c..e659670ea2d8 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/atomic.h>
> +#include <linux/bits.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -2391,7 +2392,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> +	.menu_mask	=
> +		GENMASK(ARRAY_SIZE(power_line_frequency_controls_limited) - 1, 0),
>  };
>  
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 3edb54c086b2..0774a11360c0 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -6,6 +6,7 @@
>   *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/compat.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -80,7 +81,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  			goto free_map;
>  		}
>  
> -		map->menu_count = xmap->menu_count;
> +		map->menu_mask = GENMASK(xmap->menu_count - 1, 0);
>  		break;
>  
>  	default:
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 41ba0bbd8171..a8eec43cd860 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -115,7 +115,7 @@ struct uvc_control_mapping {
>  	u32 data_type;
>  
>  	const struct uvc_menu_info *menu_info;
> -	u32 menu_count;
> +	unsigned long menu_mask;
>  
>  	u32 master_id;
>  	s32 master_manual;

-- 
Regards,

Laurent Pinchart
