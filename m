Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879B6659910
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbiL3NxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiL3Nw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:52:56 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E81266C;
        Fri, 30 Dec 2022 05:52:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68CC52F5;
        Fri, 30 Dec 2022 14:52:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672408373;
        bh=pWyCa7YPvyQYxGyOzTcJlxTW9SXuUg3m6Q4yMoxGhW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YMqOAcXUgmJuS0lg10N8wUPVWnDWf8LHr19nDNkncUPE5JiOQPf2ggNP9ZmKW+xjX
         pXFwAfCGccetKtauXuu/jLVIkzsh5HOjtTF+2AUc7UwyQg0FEGtR3pUSMRDVi+wFib
         2rAZYqDq5lGIsG+iUFmnxW+CULjaKJJbGY1x8Mgg=
Date:   Fri, 30 Dec 2022 15:52:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 5/8] media: uvcvideo: Quirk for autosuspend in
 Logi C910
Message-ID: <Y67tMN5+7vASplsE@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-5-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-5-0d7978a817cc@chromium.org>
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

s/C910/B910 and C910/ in the subject line.

On Fri, Dec 02, 2022 at 06:02:45PM +0100, Ricardo Ribalda wrote:
> Logitech C910 firmware is unable to recover from a usb autosuspend. When

s/C910/B910 and C910/
s/usb/USB/

> it resumes, the device is in a state where it only produces invalid
> frames. Eg:
> 
> $ echo 0xFFFF > /sys/module/uvcvideo/parameters/trace # enable verbose log
> $ yavta -c1 -n1 --file='frame#.jpg' --format MJPEG --size=1920x1080 /dev/video1

Is this true for YUYV frames too ?

> [350438.435219] uvcvideo: uvc_v4l2_open
> [350438.529794] uvcvideo: Resuming interface 2
> [350438.529801] uvcvideo: Resuming interface 3
> [350438.529991] uvcvideo: Trying format 0x47504a4d (MJPG): 1920x1080.
> [350438.529996] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
> [350438.551496] uvcvideo: uvc_v4l2_mmap
> [350438.555890] uvcvideo: Device requested 3060 B/frame bandwidth.
> [350438.555896] uvcvideo: Selecting alternate setting 11 (3060 B/frame bandwidth).
> [350438.556362] uvcvideo: Allocated 5 URB buffers of 32x3060 bytes each.
> [350439.316468] uvcvideo: Marking buffer as bad (error bit set).
> [350439.316475] uvcvideo: Frame complete (EOF found).
> [350439.316477] uvcvideo: EOF in empty payload.
> [350439.316484] uvcvideo: frame 1 stats: 149/261/417 packets, 1/149/417 pts (early initial), 416/417 scr, last pts/stc/sof 2976325734/2978107243/249
> [350439.384510] uvcvideo: Marking buffer as bad (error bit set).
> [350439.384516] uvcvideo: Frame complete (EOF found).
> [350439.384518] uvcvideo: EOF in empty payload.
> [350439.384525] uvcvideo: frame 2 stats: 265/379/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2979524454/2981305193/316
> [350439.448472] uvcvideo: Marking buffer as bad (error bit set).
> [350439.448478] uvcvideo: Frame complete (EOF found).
> [350439.448480] uvcvideo: EOF in empty payload.
> [350439.448487] uvcvideo: frame 3 stats: 265/377/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2982723174/2984503144/382
> ...(loop)...
> 
> The devices can leave this invalid state if its altstate is toggled.

s/its altstate/the alternate setting of the streaming interface/

How did you figure this out ?

> This patch addes a quirk for this device so it can be autosuspended
> properly.
> 
> lsusb -v:
> Bus 001 Device 049: ID 046d:0821 Logitech, Inc. HD Webcam C910
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x046d Logitech, Inc.
>   idProduct          0x0821 HD Webcam C910
>   bcdDevice            0.10
>   iManufacturer           0
>   iProduct                0
>   iSerial                 1 390022B0
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
>  drivers/media/usb/uvc/uvc_video.c  |  5 +++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 4512316c8748..d2a158a1ce35 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2823,6 +2823,24 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
> +	/* Logitech, Webcam C910 */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x0821,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
> +	/* Logitech, Webcam B910 */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x046d,
> +	  .idProduct		= 0x0823,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
>  	/* Logitech Quickcam Fusion */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d387d6335344..75c32e232f5d 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1983,6 +1983,11 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
>  			"Selecting alternate setting %u (%u B/frame bandwidth)\n",
>  			altsetting, best_psize);
>  

Please add a comment to explain the issue.

> +		if (stream->dev->quirks & UVC_QUIRK_WAKE_AUTOSUSPEND) {
> +			usb_set_interface(stream->dev->udev, intfnum,
> +					  altsetting);
> +			usb_set_interface(stream->dev->udev, intfnum, 0);
> +		}

Missing blank line.

>  		ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
>  		if (ret < 0)
>  			return ret;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index e41289605d0e..14daa7111953 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -214,6 +214,7 @@
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
>  #define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
>  #define UVC_QUIRK_INVALID_DEVICE_SOF	0x00004000
> +#define UVC_QUIRK_WAKE_AUTOSUSPEND	0x00008000
>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> 

-- 
Regards,

Laurent Pinchart
