Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0265889C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiL2CWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiL2CWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:22:36 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D5A6421;
        Wed, 28 Dec 2022 18:22:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8B236109;
        Thu, 29 Dec 2022 03:22:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672280553;
        bh=FvB+mp1XgGaAlQNYl8Kki+4EdFS5MuHNwXf+BcLix8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkD4pU9h0n46OTV1UNgFDHM+Miq8h+f+q+Y3uMEaDOYwM4UKom+OPSiefsGtmVsBL
         lm08cQ1xmUH2f3TujhMaLK2n9f9pEaXvBL5ZHE10i/ZgcQORvh5A/KZUL255tm3y4U
         Rs8qeSu5mU46ByD5XpcNqWbasHIB7ETsPBE1jrd0=
Date:   Thu, 29 Dec 2022 04:22:29 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH RESEND] media: uvcvideo: Disable autosuspend for Insta360
 Link
Message-ID: <Y6z55cXTt5yXjIZj@pendragon.ideasonboard.com>
References: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221101-instal-v1-0-d13d1331c4b5@chromium.org>
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

On Fri, Dec 02, 2022 at 05:48:52PM +0100, Ricardo Ribalda wrote:
> When the device suspends, it keeps power-cycling.
> 
> The user notices it because the LED constanct oscillate between
> blue (ready) and no LED (off).
> 
> <6>[95202.128542] usb 3-3-port4: attempt power cycle
> <6>[95206.070120] usb 3-3.4: new high-speed USB device number 49 using xhci_hcd
> <6>[95206.212027] usb 3-3.4: New USB device found, idVendor=2e1a, idProduct=4c01, bcdDevice= 2.00
> <6>[95206.212044] usb 3-3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=<Serial: 1>
> <6>[95206.212050] usb 3-3.4: Product: Insta360 Link
> <6>[95206.212075] usb 3-3.4: Manufacturer: Amba
> <7>[95206.214862] usb 3-3.4: GPIO lookup for consumer privacy
> <7>[95206.214866] usb 3-3.4: using lookup tables for GPIO lookup
> <7>[95206.214869] usb 3-3.4: No GPIO consumer privacy found
> <6>[95206.214871] usb 3-3.4: Found UVC 1.10 device Insta360 Link (2e1a:4c01)
> <3>[95206.217113] usb 3-3.4: Failed to query (GET_INFO) UVC control 14 on unit 1: -32 (exp. 1).
> <3>[95206.217733] usb 3-3.4: Failed to query (GET_INFO) UVC control 16 on unit 1: -32 (exp. 1).
> <4>[95206.223544] usb 3-3.4: Warning! Unlikely big volume range (=32767), cval->res is probably wrong.
> <4>[95206.223554] usb 3-3.4: [9] FU [Mic Capture Volume] ch = 1, val = -32768/-1/1
> <6>[95210.698990] usb 3-3.4: USB disconnect, device number 49
> <6>[95211.963090] usb 3-3.4: new high-speed USB device number 50 using xhci_hcd
> <6>[95212.657061] usb 3-3.4: new full-speed USB device number 51 using xhci_hcd
> <3>[95212.783119] usb 3-3.4: device descriptor read/64, error -32
> <3>[95213.015076] usb 3-3.4: device descriptor read/64, error -32
> <6>[95213.120358] usb 3-3-port4: attempt power cycle
> 
> Bus 001 Device 009: ID 2e1a:4c01 Amba Insta360 Link
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x2e1a
>   idProduct          0x4c01
>   bcdDevice            2.00
>   iManufacturer           1 Amba
>   iProduct                2 Insta360 Link
>   iSerial                 0
>   bNumConfigurations      1
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> media: uvcvideo: Disable autosuspend for Insta360
> 
> The device does not handle properly the USB suspend and makes it barely usable.

Isn't this best handled with a quirk in the USB core ? Autosuspend is a
device feature, not an interface feature, so if the USB sound driver is
loaded but uvcvideo isn't, the kernel may still attempt to autosuspend
the device.

> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 13 ++++++++++++-
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 215fb483efb0..ad95c7599863 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2223,7 +2223,9 @@ static int uvc_probe(struct usb_interface *intf,
>  	}
>  
>  	uvc_dbg(dev, PROBE, "UVC device initialized\n");
> -	usb_enable_autosuspend(udev);
> +	if (!(dev->quirks & UVC_QUIRK_DISABLE_AUTOSUSPEND))
> +		usb_enable_autosuspend(udev);
> +
>  	return 0;
>  
>  error:
> @@ -2967,6 +2969,15 @@ static const struct usb_device_id uvc_ids[] = {
>  	  .bInterfaceSubClass	= 1,
>  	  .bInterfaceProtocol	= 0,
>  	  .driver_info		= (kernel_ulong_t)&uvc_quirk_force_y8 },
> +	/* Insta360 Link */
> +	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
> +				| USB_DEVICE_ID_MATCH_INT_INFO,
> +	  .idVendor		= 0x2e1a,
> +	  .idProduct		= 0x4c01,
> +	  .bInterfaceClass	= USB_CLASS_VIDEO,
> +	  .bInterfaceSubClass	= 1,
> +	  .bInterfaceProtocol	= 0,
> +	  .driver_info		= UVC_INFO_QUIRK(UVC_QUIRK_DISABLE_AUTOSUSPEND) },
>  	/* GEO Semiconductor GC6500 */
>  	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
>  				| USB_DEVICE_ID_MATCH_INT_INFO,
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index df93db259312..47c86c7c6346 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -74,6 +74,7 @@
>  #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
> +#define UVC_QUIRK_DISABLE_AUTOSUSPEND	0x00002000
>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> 
> ---
> base-commit: 23758867219c8d84c8363316e6dd2f9fd7ae3049
> change-id: 20221101-instal-9a77ba1cc448

-- 
Regards,

Laurent Pinchart
