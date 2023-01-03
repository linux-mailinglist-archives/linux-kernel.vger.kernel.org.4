Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4D65C800
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjACUWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjACUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:22:08 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8297610B7E;
        Tue,  3 Jan 2023 12:22:07 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DDBD7108;
        Tue,  3 Jan 2023 21:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672777326;
        bh=pfwPqM2jz9OmWd2+dA3cmy3/g9aYv/U4swdxzt6N+UQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cWB80PEUIb/Y3Flzj5NSdqC5nhRqFrb9jruathY/i/VKhwz2toXFH6MkREB3d4F86
         vcDDklKYwzZ7HfIxI6xq7F4KHFcKgTm6JT/UQkEh/8OG06rCWgzPOAlTUNaE0FJ/+f
         3i7MvLIsO8Gp3m0vSeBpxU1hvIpRjSjjMkAna4C4=
Date:   Tue, 3 Jan 2023 22:22:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: [PATCH v3 7/8] media: uvcvideo: Refactor __uvc_ctrl_add_mapping
Message-ID: <Y7SOaXgUS/3G2s8M@pendragon.ideasonboard.com>
References: <20220920-resend-v4l2-compliance-v3-0-598d33a15815@chromium.org>
 <20220920-resend-v4l2-compliance-v3-7-598d33a15815@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-v4l2-compliance-v3-7-598d33a15815@chromium.org>
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

On Tue, Jan 03, 2023 at 03:36:25PM +0100, Ricardo Ribalda wrote:
> Simplify the exit code with a common error tag freeing all the memory.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index aa7a668f60a7..4830120e6506 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2296,32 +2296,30 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  	unsigned int i;
>  
>  	/*
> -	 * Most mappings come from static kernel data and need to be duplicated.
> +	 * Most mappings come from static kernel data, and need to be duplicated.
>  	 * Mappings that come from userspace will be unnecessarily duplicated,
>  	 * this could be optimized.
>  	 */
>  	map = kmemdup(mapping, sizeof(*mapping), GFP_KERNEL);
> -	if (map == NULL)
> +	if (!map)
>  		return -ENOMEM;
>  
> +	map->name = NULL;
> +	map->menu_info = NULL;
> +
>  	/* For UVCIOC_CTRL_MAP custom control */
>  	if (mapping->name) {
>  		map->name = kstrdup(mapping->name, GFP_KERNEL);
> -		if (!map->name) {
> -			kfree(map);
> -			return -ENOMEM;
> -		}
> +		if (!map->name)
> +			goto nomem;
>  	}
>  
>  	INIT_LIST_HEAD(&map->ev_subs);
>  
>  	size = sizeof(*mapping->menu_info) * fls(mapping->menu_mask);
>  	map->menu_info = kmemdup(mapping->menu_info, size, GFP_KERNEL);
> -	if (map->menu_info == NULL) {
> -		kfree(map->name);
> -		kfree(map);
> -		return -ENOMEM;
> -	}
> +	if (!map->menu_info)
> +		goto nomem;
>  
>  	if (map->get == NULL)
>  		map->get = uvc_get_le_value;
> @@ -2342,6 +2340,12 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
>  		ctrl->info.selector);
>  
>  	return 0;
> +
> +nomem:

As it's an error label, I'd name it err_nomem. I'll fix that when
applying.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	kfree(map->menu_info);
> +	kfree(map->name);
> +	kfree(map);
> +	return -ENOMEM;
>  }
>  
>  int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> 

-- 
Regards,

Laurent Pinchart
