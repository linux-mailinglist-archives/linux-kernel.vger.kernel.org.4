Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10E4659957
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 15:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiL3Ob1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 09:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiL3ObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 09:31:24 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663113F58;
        Fri, 30 Dec 2022 06:31:22 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 186F02F5;
        Fri, 30 Dec 2022 15:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672410681;
        bh=kmVDOslIpm8jW9ST5a9nIVtbbU2eXCNnxFIdE8lsffo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2WX/F/yQysukoJW1wos6J05/vDkNxhezbQ9Bd/BRRoxlF9SfBETsLo6KtT1nnuJf
         P45L+iaHkHSW5iQJHPK2p0dOYydw9cwHufG0d0MC/YP0Dq6N/TUKWBTTIeiEEIl6+0
         JUyj/Of9hQL9fDm7MY7g0YdL2BNtp6bYgxbzEFQU=
Date:   Fri, 30 Dec 2022 16:31:16 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/8] media: uvcvideo: Quirk for invalid dev_sof
 in Logi C922
Message-ID: <Y672NOkSLpth7bu9@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-4-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-4-0d7978a817cc@chromium.org>
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

s/Logi/Logitech/ in the subject line (same in the previous patch)

On Fri, Dec 02, 2022 at 06:02:44PM +0100, Ricardo Ribalda wrote:
> Logitech C922 internal sof does not increases at a stable rate of 1KHz.

s/sof/SOF/
s/KHz/kHz/

> 

No need for a blank line.

> This causes that the device_sof and the host_sof run at different rates,

s/that //
s/run/ to run/

> breaking the clock domain conversion algorithm. Eg:
> 
> 30 (6) [-] none 30 614400 B 21.245557 21.395214 34.133 fps ts mono/SoE
> 31 (7) [-] none 31 614400 B 21.275327 21.427246 33.591 fps ts mono/SoE
> 32 (0) [-] none 32 614400 B 21.304739 21.459256 34.000 fps ts mono/SoE
> 33 (1) [-] none 33 614400 B 21.334324 21.495274 33.801 fps ts mono/SoE
> * 34 (2) [-] none 34 614400 B 21.529237 21.527297 5.130 fps ts mono/SoE
> * 35 (3) [-] none 35 614400 B 21.649416 21.559306 8.321 fps ts mono/SoE
> 36 (4) [-] none 36 614400 B 21.678789 21.595320 34.045 fps ts mono/SoE
> ...
> 99 (3) [-] none 99 614400 B 23.542226 23.696352 33.541 fps ts mono/SoE
> 100 (4) [-] none 100 614400 B 23.571578 23.728404 34.069 fps ts mono/SoE
> 101 (5) [-] none 101 614400 B 23.601425 23.760420 33.504 fps ts mono/SoE
> * 102 (6) [-] none 102 614400 B 23.798324 23.796428 5.079 fps ts mono/SoE
> * 103 (7) [-] none 103 614400 B 23.916271 23.828450 8.478 fps ts mono/SoE
> 104 (0) [-] none 104 614400 B 23.945720 23.860479 33.957 fps ts mono/SoE
> 
> Instead of disabling completely the hardware timestamping for such
> hardware we take the assumption that the package handling jitter is

s/package/packet/

> under 2ms and use the host_sof as dev_sof.

You know, I think we should really move all this timestamp handling code
to userspace...

> For the hardware tested, it provides a much better timestamping than a
> pure software solution:
> https://ibb.co/D1HJJ4x
> https://ibb.co/8s9dBdk
> https://ibb.co/QC9MgVK

A bit of context would be nice, such as labelling the axes, mentioning
what nominal frame rate is expected, as telling what each link
corresponds to.

> This bug in the camera firmware has been confirmed by the vendor.
> 
> lsusb -v
> 
> Bus 001 Device 044: ID 046d:085c Logitech, Inc. C922 Pro Stream Webcam
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x046d Logitech, Inc.
>   idProduct          0x085c C922 Pro Stream Webcam
>   bcdDevice            0.16
>   iManufacturer           0
>   iProduct                2 C922 Pro Stream Webcam
>   iSerial                 1 80B912DF
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c |  9 +++++++++
>  drivers/media/usb/uvc/uvc_video.c  | 11 +++++++++--
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 80ef0f0e04b0..4512316c8748 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2880,6 +2880,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_RESTORE_CTRLS_ON_INIT) },
> +	/* Logitech HD Pro Webcam C922 */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x085c,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_INVALID_DEVICE_SOF) },
>  	/* Chicony CNF7129 (Asus EEE 100HE) */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index a5b184e71ad7..d387d6335344 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -529,13 +529,20 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	 * data packages of the same frame contains the same sof. In that case
>  	 * only the first one will match the host_sof.
>  	 */
> -	dev_sof = get_unaligned_le16(&data[header_size - 2]);
> +	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> +		dev_sof = usb_get_current_frame_number(stream->dev->udev);
> +	else
> +		dev_sof = get_unaligned_le16(&data[header_size - 2]);
> +
>  	if (dev_sof == stream->clock.last_sof)
>  		return;
>  
>  	stream->clock.last_sof = dev_sof;
>  
> -	host_sof = usb_get_current_frame_number(stream->dev->udev);
> +	if (stream->dev->quirks & UVC_QUIRK_INVALID_DEVICE_SOF)
> +		host_sof = dev_sof;
> +	else
> +		host_sof = usb_get_current_frame_number(stream->dev->udev);
>  	time = uvc_video_get_time();

This effectively bypasses the SOF clock domain completely. If the SOF
values sent by the device are completely unrelated to the USB SOF
counter we can obviously not rely on the SOF clock domain, but I'd like
an explanation as to *why* this still provides better timestamps.

>  
>  	/*
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index f395b67fe95a..e41289605d0e 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -213,6 +213,7 @@
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
>  #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
> +#define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001

-- 
Regards,

Laurent Pinchart
