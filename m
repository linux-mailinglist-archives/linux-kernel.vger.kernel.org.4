Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA25660B79
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAGBZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAGBZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:25:16 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2EC625F1;
        Fri,  6 Jan 2023 17:25:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6A2D64AE;
        Sat,  7 Jan 2023 02:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673054713;
        bh=G037BmUVvwh5YBMu1UbJn13gS1sSbOPUAKSwXAi4qHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOuZB96JOy408V+FgGb2xlodO8HggV+Y+yYX36PpeRMULdH6viFemLYdrUlFkTdVc
         YVPZxr8XBfHcdEMrdHayJOYyZqaz/HeVWBtJvF9HuooM4mDBMEbTKCVTAbEMka0kAq
         tA5lck+aRf2yu0ItGiKXQE+PZbAlvJjuMMxxJQZ4=
Date:   Sat, 7 Jan 2023 03:25:08 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v3 5/8] media: uvcvideo: Quirk for autosuspend in
 Logitech B910 and C910
Message-ID: <Y7jJ9GeFCsPvAH12@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v3-0-db9faee7f47d@chromium.org>
 <20220920-resend-hwtimestamp-v3-5-db9faee7f47d@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v3-5-db9faee7f47d@chromium.org>
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

On Wed, Jan 04, 2023 at 11:45:23AM +0100, Ricardo Ribalda wrote:
> Logitech B910 and C910 firmware are unable to recover from an USB

s/an USB/a USB/

> autosuspend. When it resumes, the device is in a state where it only produces
> invalid frames. Eg:
> 
> $ echo 0xFFFF > /sys/module/uvcvideo/parameters/trace # enable verbose log
> $ yavta -c1 -n1 --file='frame#.jpg' --format MJPEG --size=1920x1080 /dev/video1
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
> The devices can leave this invalid state if the alternate setting of
> the streaming interface is toggled.
> 
> This patch adds a quirk for this device so it can be autosuspended
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
>  drivers/media/usb/uvc/uvc_video.c  | 10 ++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index c89a1eebe91c..be6ad9b732a2 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2525,6 +2525,24 @@ static const struct usb_device_id uvc_ids[] = {
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
> index bc75c7c40251..fe5c7b465adf 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1984,6 +1984,16 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
>  			"Selecting alternate setting %u (%u B/frame bandwidth)\n",
>  			altsetting, best_psize);
>  
> +		/*
> +		 * Some devices, namely the Logitech C910 and B910, are unable
> +		 * to recover from an USB autosuspend, unless the alternate

Same here.

> +		 * setting of the streaming interface is toggled.
> +		 */
> +		if (stream->dev->quirks & UVC_QUIRK_WAKE_AUTOSUSPEND) {
> +			usb_set_interface(stream->dev->udev, intfnum,
> +					  altsetting);
> +			usb_set_interface(stream->dev->udev, intfnum, 0);
> +		}

Missing blank line.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I'll apply this patch to my tree independently from the rest of this
series with these small issues fixed locally.

>  		ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
>  		if (ret < 0)
>  			return ret;
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 88d1790e6695..24c3e9411415 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -76,6 +76,7 @@
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
