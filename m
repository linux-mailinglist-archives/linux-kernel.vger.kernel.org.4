Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884EA5BF293
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiIUBGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIUBGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:06:21 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4365E3E76D;
        Tue, 20 Sep 2022 18:06:20 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F222415;
        Wed, 21 Sep 2022 03:06:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663722378;
        bh=DOKp4yUVL0lOKfBdZ5Y2c9aGr/a6xlSB9ZXblqDfDkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dWsc7VPHZeP0J1RRT+U/yLzf+sqpnMzgMPKqDyzBGoCHCqlklJ/UECR9K1vjw3mhR
         Y3vb1XJbvkVGwHfy6ZOuq0AXXPOljt0o1yG0usjHZioODnp6Y/zcAidOu4f2i70v0x
         T0GhDOP4FN0kYun+xzYTDxjzjh5RO7iojQ7V8IeM=
Date:   Wed, 21 Sep 2022 04:06:04 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Implement mask for
 V4L2_CTRL_TYPE_MENU
Message-ID: <YypjfCLkmHRrsD66@pendragon.ideasonboard.com>
References: <20220920-standard-menues-v2-0-a35af3243c2f@chromium.org>
 <20220920-standard-menues-v2-1-a35af3243c2f@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-standard-menues-v2-1-a35af3243c2f@chromium.org>
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

On Wed, Sep 21, 2022 at 12:57:29AM +0200, Ricardo Ribalda wrote:
> Replace the count with a mask field that let us choose not only the max

s/let/lets/

> value, but also the minimum value and what values are valid in between.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 8c208db9600b..13bc57e2a08d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c

Let's include <linux/bitops.h> in this file for ffs() and fls().

> @@ -524,7 +524,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
>  		.menu_info	= exposure_auto_controls,
> -		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
> +		.menu_mask	=
> +			BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),

This fits on a single line.

>  		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
>  	},
>  	{
> @@ -730,7 +731,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
> +		.menu_mask	=
> +			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),

And this and the next hunk would benefit, I think, from exceeding the 80
columns.

>  	},
>  };
>  
> @@ -744,7 +746,8 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
> +		.menu_mask	=
> +			BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
>  	},
>  };
>  
> @@ -974,7 +977,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>  		const struct uvc_menu_info *menu = mapping->menu_info;
>  		unsigned int i;
>  
> -		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
> +		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +			if (!test_bit(i, &mapping->menu_mask))

I may be missing something, but if i starts at 1, aren't you testing bit
N+1 for menu entry N ?

> +				continue;
>  			if (menu->value == value) {
>  				value = i;
>  				break;
> @@ -1148,12 +1153,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
> +		for (i = 1; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +			if (!test_bit(i, &mapping->menu_mask))

Same here.

> +				continue;
>  			if (menu->value == v4l2_ctrl->default_value) {
>  				v4l2_ctrl->default_value = i;
>  				break;
> @@ -1268,7 +1275,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  		goto done;
>  	}
>  
> -	if (query_menu->index >= mapping->menu_count) {
> +	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
>  		ret = -EINVAL;
>  		goto done;
>  	}
> @@ -1776,8 +1783,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
> @@ -2227,7 +2239,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
> -	size = sizeof(*mapping->menu_info) * mapping->menu_count;
> +	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
>  	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
>  	if (map->menu_info == NULL) {
>  		kfree(map->name);
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..09cc459c1253 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2675,7 +2675,8 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> +	.menu_mask	=
> +		BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),

Here too I'd avoid the line wrap.

>  };
>  
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 4cc3fa6b8c98..07c7acce8025 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -80,7 +80,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  			goto free_map;
>  		}
>  
> -		map->menu_count = xmap->menu_count;
> +		map->menu_mask = BIT_MASK(xmap->menu_count);
>  		break;
>  
>  	default:
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 24c911aeebce..fde4e975334f 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -255,7 +255,7 @@ struct uvc_control_mapping {
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
