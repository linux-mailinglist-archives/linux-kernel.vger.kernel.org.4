Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42E06598F6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbiL3Npq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiL3NpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:45:23 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DE219C37;
        Fri, 30 Dec 2022 05:45:21 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6AC5D2F5;
        Fri, 30 Dec 2022 14:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1672407919;
        bh=AZlM891moJMdZk/N+hwRpcwDek3at5lAcndY5CaviBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZK6OrkjEKOGBweRl/ey400fgEEhiNloYNBWMSqyjRl57hIjqxk73ZX4N8jD1W8CsI
         I4xEPCUvwIJIEhIuDdloBL4AGUYgSQkEP7qE8V4gi7vSxn28MKDnN15wY9Bf6W/9jz
         XzeMEEsVtfnNqGdBZRstjh04cBW/B6+CV5H+Q/To=
Date:   Fri, 30 Dec 2022 15:45:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/8] media: uvc: Create
 UVC_QUIRK_IGNORE_EMPTY_TS quirk
Message-ID: <Y67raFd19OH4w2Fx@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-3-0d7978a817cc@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v2-3-0d7978a817cc@chromium.org>
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

On Fri, Dec 02, 2022 at 06:02:43PM +0100, Ricardo Ribalda wrote:
> Some Sunplus cameras took a borderline interpretation of the UVC 1.5
> standard, and fill the PTS and SCR fields with invalid data if the
> package does not contain data.
> 
> "STC must be captured when the first video data of a video frame is put
> on the USB bus."
> 
> Eg:
> 
> buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a
> 
> This borderline/buggy interpretation has been implemented in a variety
> of devices, from directly Sunplus and from other OEMs that rebrand
> Sunplus products.
> 
> Luckily we can identify the affected modules by looking at the guid of
> one of the extension units:
> 
> VideoControl Interface Descriptor:
>   guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}
> 
> This patch adds a new quirk to take care of this.
> 
> Complete lsusb of one of the affected cameras:

That's not complete (but that's fine from a commit message point of
view, the full descriptors would be too long). Can you share the full
descriptors for all the devices you know are affected by this ?

> Bus 001 Device 003: ID 1bcf:2a01 Sunplus Innovation Technology Inc.
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.01
>   bDeviceClass          239 Miscellaneous Device
>   bDeviceSubClass         2 ?
>   bDeviceProtocol         1 Interface Association
>   bMaxPacketSize0        64
>   idVendor           0x1bcf Sunplus Innovation Technology Inc.
>   idProduct          0x2a01
>   bcdDevice            0.02
>   iManufacturer           1 SunplusIT Inc
>   iProduct                2 HanChen Wise Camera
>   iSerial                 3 01.00.00
>   bNumConfigurations      1
> 
> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
>  drivers/media/usb/uvc/uvc_video.c  |  8 ++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index c63ecfd4617d..80ef0f0e04b0 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1497,6 +1497,17 @@ static const struct uvc_entity_quirk {
>  	u8 guid[16];
>  	u32 quirks;
>  } uvc_entity_quirk[] = {
> +	/*
> +	 * Some SunPlus uvc 1.5 device firmware expects that packages with

s/uvc/UVC/

> +	 * no frame data are ignored by the host.

If it's two paragraphs, you need a blank line in-between. If it's a
single paragraph, you must not add a line break.

> +	 * Therefore it does not clear the PTS/SCR bits in the header, and
> +	 * breaks the timestamp decode algorithm.
> +	 */
> +	{
> +		.guid = {0x82, 0x06, 0x61, 0x63, 0x70, 0x50, 0xab, 0x49,
> +			 0xb8, 0xcc, 0xb3, 0x85, 0x5e, 0x8d, 0x22, 0x1d},
> +		.quirks = UVC_QUIRK_IGNORE_EMPTY_TS,
> +	},
>  };
>  
>  static void uvc_entity_quirks(struct uvc_device *dev)
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index ab56e65ca324..a5b184e71ad7 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -500,6 +500,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
>  	if (len < header_size)
>  		return;
>  
> +	/*
> +	 * Ignore the hardware timestamp on frames with no data on
> +	 * miss-behaving devices.
> +	 */

Could you please expand this comment to explain the issue ? Having to
use git blame and read the commit message to understand why the check is
here isn't very convenient.

> +	if (stream->dev->quirks & UVC_QUIRK_IGNORE_EMPTY_TS &&
> +	    len == header_size)
> +		return;
> +
>  	/*
>  	 * Extract the timestamps:
>  	 *
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 24c911aeebce..f395b67fe95a 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -212,6 +212,7 @@
>  #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
>  #define UVC_QUIRK_FORCE_Y8		0x00000800
>  #define UVC_QUIRK_FORCE_BPP		0x00001000
> +#define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
>  
>  /* Format flags */
>  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> 

-- 
Regards,

Laurent Pinchart
