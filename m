Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA513659B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiL3Rrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiL3Rrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:47:46 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C313CC3;
        Fri, 30 Dec 2022 09:47:44 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C5222F5;
        Fri, 30 Dec 2022 18:47:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672422462;
        bh=j/YlUzIxu/q6NUJAqgakN4HSBzdHx5nGEFvh9jW71IM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7aAhpaIQ1KSija3BtmyEzSP54U//kfyObok42ceO4JwSuDaElZyVwX0pJCitWtWI
         t6n+1/yVMjhStGbxfSP9UZy+pXRnfSqMn6hXu+6S4Bq7rOoexWD5Js6tUdE9eqRMMm
         DKxfaYvAMwospvbXTTbbbMNjwmQyAU21xS/2r7t8=
Date:   Fri, 30 Dec 2022 19:47:37 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ai Chao <aichao@kylinos.cn>
Cc:     mchehab@kernel.org, ribalda@chromium.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor camera
Message-ID: <Y68kOe3WNjnkPS57@pendragon.ideasonboard.com>
References: <20221122084833.1241078-1-aichao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122084833.1241078-1-aichao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ai,

Thank you for the patch.

On Tue, Nov 22, 2022 at 04:48:33PM +0800, Ai Chao wrote:
> For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to output

Could you please send me the USB descriptors for the 2017:0011 device
(lsusb -v -d 2017:0011) ?

>  compressed video data, and it return a wrong dwMaxPayloadTransferSize
>  fields. This is a fireware issue, but the manufacturer cannot provide
>  a const return fieldsby the fireware. For some device, it requested
>  2752512 B/frame bandwidth. For normally device, it requested 3072 or 1024
>  B/frame bandwidth. so we check the dwMaxPayloadTransferSize fields,if it
>  large than 0x1000, reset dwMaxPayloadTransferSize to 1024, and the camera
>  preview normally.
>
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> 
> ---
> change for v4
> - Change usb_match_one_id to usb_match_id
> - Modify the discription
> 
> change for v3
> - Add VID/PID 2017:0011
> 
> change for v2
> - Used usb_match_one_id to check VID and PID
> ---
> ---
>  drivers/media/usb/uvc/uvc_video.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d2eb9066e4dc..75bdd71d0e5a 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -135,6 +135,11 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>  	static const struct usb_device_id elgato_cam_link_4k = {
>  		USB_DEVICE(0x0fd9, 0x0066)
>  	};
> +	static const struct usb_device_id alcor_corp_slave_cam[] = {
> +		{ USB_DEVICE(0x2017, 0x0011) },
> +		{ USB_DEVICE(0x1b17, 0x6684) },
> +		{ }
> +	};
>  	struct uvc_format *format = NULL;
>  	struct uvc_frame *frame = NULL;
>  	unsigned int i;
> @@ -234,6 +239,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
>  
>  		ctrl->dwMaxPayloadTransferSize = bandwidth;
>  	}
> +
> +	/* Alcor Corp. Slave camera return wrong dwMaxPayloadTransferSize */
> +	if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&

Is the issue limited to MJPEG ? The device also supports YUYV, does it
provide a correct dwMaxPayloadTransferSize in that case ?

> +	    (ctrl->dwMaxPayloadTransferSize > 0x1000) &&
> +	    usb_match_id(stream->dev->intf, alcor_corp_slave_cam)) {
> +		ctrl->dwMaxPayloadTransferSize = 1024;
> +	}
>  }
>  
>  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)

-- 
Regards,

Laurent Pinchart
