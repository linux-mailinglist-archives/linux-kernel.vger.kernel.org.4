Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404C46588BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiL2Cuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiL2Cui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:50:38 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B068810B76;
        Wed, 28 Dec 2022 18:50:36 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 83673109;
        Thu, 29 Dec 2022 03:50:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672282233;
        bh=kr/KMqyJ37X4fK4i6QdUKRzoLvLGk3YoMdym7liQ8TU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBKmgoziPI4NSXzuvEhQolG2fD6ZSjHG1AXZ2ZPdtmt3+Y0RWHEJsnwo4FiTZT9kD
         HfwpKHCHln3OSSdmxOq8dZ8WePfbn92Etr8oyHSP61F+HfE0GR3xzkT8cPxT1EXIO0
         LcPh/H+zjFxASLQWYjOSq0DNVw1cxFNGZu2ewBZI=
Date:   Thu, 29 Dec 2022 04:50:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [PATCH RESEND v2 6/7] media: uvcvideo: Implement mask for
 V4L2_CTRL_TYPE_MENU
Message-ID: <Y60AdY7eACCXVQS+@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v2-0-b0ceb15353ac@chromium.org>
 <20220920-resend-v4l2-compliance-v2-6-b0ceb15353ac@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v2-6-b0ceb15353ac@chromium.org>
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

On Fri, Dec 02, 2022 at 06:21:40PM +0100, Ricardo Ribalda wrote:
> Replace the count with a mask field that lets us choose not only the max
> value, but also the minimum value and what values are valid in between.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 30 ++++++++++++++++++++----------
>  drivers/media/usb/uvc/uvc_driver.c |  2 +-
>  drivers/media/usb/uvc/uvc_v4l2.c   |  2 +-
>  drivers/media/usb/uvc/uvcvideo.h   |  2 +-
>  4 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 526572044e82..df273b829961 100644
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
> @@ -524,7 +525,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_BITMASK,
>  		.menu_info	= exposure_auto_controls,
> -		.menu_count	= ARRAY_SIZE(exposure_auto_controls),
> +		.menu_mask	= BIT_MASK(ARRAY_SIZE(exposure_auto_controls)),
>  		.slave_ids	= { V4L2_CID_EXPOSURE_ABSOLUTE, },
>  	},
>  	{
> @@ -730,7 +731,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc11[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls) - 1,
> +		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls) - 1),
>  	},
>  };
>  
> @@ -744,7 +745,7 @@ static const struct uvc_control_mapping uvc_ctrl_mappings_uvc15[] = {
>  		.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  		.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  		.menu_info	= power_line_frequency_controls,
> -		.menu_count	= ARRAY_SIZE(power_line_frequency_controls),
> +		.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls)),
>  	},
>  };
>  
> @@ -974,7 +975,9 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
>  		const struct uvc_menu_info *menu = mapping->menu_info;
>  		unsigned int i;
>  
> -		for (i = 0; i < mapping->menu_count; ++i, ++menu) {
> +		for (i = 0; BIT(i) <= mapping->menu_mask; ++i, ++menu) {
> +			if (!test_bit(i, &mapping->menu_mask))
> +				continue;
>  			if (menu->value == value) {
>  				value = i;
>  				break;
> @@ -1212,12 +1215,14 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
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
> @@ -1338,7 +1343,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>  		goto done;
>  	}
>  
> -	if (query_menu->index >= mapping->menu_count) {
> +	if (!test_bit(query_menu->index, &mapping->menu_mask)) {
>  		ret = -EINVAL;
>  		goto done;
>  	}
> @@ -1853,8 +1858,13 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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
> @@ -2301,7 +2311,7 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
> -	size = sizeof(*mapping->menu_info) * mapping->menu_count;
> +	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
>  	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
>  	if (map->menu_info == NULL) {
>  		kfree(map->name);
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 9c05776f11d1..abdb9ca7eed6 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2675,7 +2675,7 @@ static const struct uvc_control_mapping uvc_ctrl_power_line_mapping_limited = {
>  	.v4l2_type	= V4L2_CTRL_TYPE_MENU,
>  	.data_type	= UVC_CTRL_DATA_TYPE_ENUM,
>  	.menu_info	= power_line_frequency_controls_limited,
> -	.menu_count	= ARRAY_SIZE(power_line_frequency_controls_limited),
> +	.menu_mask	= BIT_MASK(ARRAY_SIZE(power_line_frequency_controls_limited)),

Let's include linux/bits.h. Same in the next file. I'll fix this when
applying the patch if there's no other need to submit a new version of
the series.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  };
>  
>  static const struct uvc_device_info uvc_ctrl_power_line_limited = {
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index d95168cdc2d1..e6792fd46bf5 100644
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
> index 644d5fcf2eef..7e2339fc256e 100644
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
> 

-- 
Regards,

Laurent Pinchart
