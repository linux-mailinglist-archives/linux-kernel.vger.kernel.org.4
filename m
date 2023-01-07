Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52632660A9B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjAGAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbjAGALj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:11:39 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E344BD54;
        Fri,  6 Jan 2023 16:11:37 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B13BF4AE;
        Sat,  7 Jan 2023 01:11:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673050295;
        bh=x8pzsewZWxr/vcdPPfkmHtSjn4WeCTlmgfotf/DK77o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiSJsOZHaq3Strt7jLItKZPFvIWEvEUGzf5p6pEklUQO18aa0GL+Bd9fII2DGjth6
         e0yi2eOLZG/hIJ3dNDxhyurJBbMXEPkAr1ry4s08UL8SaYfr/eHH5oG4M2oJCYdE/X
         smh0EFDI0dpkmmOp+ttrI6SGMfBFeI73zHYsuKgI=
Date:   Sat, 7 Jan 2023 02:11:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ai Chao <aichao@kylinos.cn>
Cc:     mchehab@kernel.org, ribalda@chromium.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] media: uvcvideo: Fix bandwidth error for Alcor camera
Message-ID: <Y7i4skTM/DBXpgca@pendragon.ideasonboard.com>
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

Hi again,

On Tue, Nov 22, 2022 at 04:48:33PM +0800, Ai Chao wrote:
> For Alcor Corp. Slave camera(1b17:6684/2017:0011), it support to output
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

Let's add a bit more documentation:

	/*
	 * Another issue is with devices that report a transfer size that
	 * greatly exceeds the maximum supported by any existing USB version.
	 * For instance, the "Slave camera" devices from Alcor Corp. (2017:0011
	 * and 1b17:66B8) request 2752512 bytes per interval.
	 */

I would also take this as an opportunity to document the previous fixup,
just above the UVC_QUIRK_FIX_BANDWIDTH check, with

	/*
	 * Many devices report an incorrect dwMaxPayloadTransferSize value. The
	 * most common issue is devices requesting the maximum possible USB
	 * bandwidth (3072 bytes per interval for high-speed, high-bandwidth
	 * isochronous endpoints) while they actually require less, preventing
	 * multiple cameras from being used at the same time due to bandwidth
	 * overallocation.
	 *
	 * For those devices, replace the dwMaxPayloadTransferSize value based
	 * on an estimation calculated from the frame format and size. This is
	 * only possible for uncompressed formats, as not enough information is
	 * available to reliably estimate the bandwidth requirements for
	 * compressed formats.
	 */

> +	if ((format->flags & UVC_FMT_FLAG_COMPRESSED) &&
> +	    (ctrl->dwMaxPayloadTransferSize > 0x1000) &&

Given that the highest bandwidth supported by high-speed, high bandwidth
devices is 3072 bytes per interval, I would check

	    (ctrl->dwMaxPayloadTransferSize > 3072) &&

here.

> +	    usb_match_id(stream->dev->intf, alcor_corp_slave_cam)) {

I'm also wondering if we could enable this fixup for all devices using
isochronous endpoints (as for bulk endpoints the transfer size can be
higher), without checking the VID:PID. No isochronous high-speed,
high-bandwidth device should have a swMaxPayloadTransferSize value
higher than 3072.  For super-speed devices I'm not entirely sure if the
maximum transfer size covers multiple transfers in a burst. Ricardo, do
you know anything about that ?

I can send a v5 that does all this.

> +		ctrl->dwMaxPayloadTransferSize = 1024;
> +	}
>  }
>  
>  static size_t uvc_video_ctrl_size(struct uvc_streaming *stream)

-- 
Regards,

Laurent Pinchart
