Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A5F660B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 02:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAGBQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 20:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 20:16:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC07A5FE2;
        Fri,  6 Jan 2023 17:16:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A7F44AE;
        Sat,  7 Jan 2023 02:16:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673054174;
        bh=ozKgACQ1++JdleonmKbsfK9MnhV9o2UAJaf2OqIwaOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EERUQWhrvHv7hw0THsE6DEwnLs1rFYdyna5eZUagUnLm7gQtw2bCzMTyKJlZBn390
         98Si27KA6OUPe/y4pCl5uZicVz57bDCrMGsiCjY1vAzSSd4Mtc0KovX4YRH9RjNbqm
         iVOt+5AZOLHirZDbKJaYwqlI0y/CopJGxApJpbyc=
Date:   Sat, 7 Jan 2023 03:16:08 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/8] media: uvc: Create
 UVC_QUIRK_IGNORE_EMPTY_TS quirk
Message-ID: <Y7jH2NnzszhW46QY@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-3-0d7978a817cc@chromium.org>
 <Y67raFd19OH4w2Fx@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y67raFd19OH4w2Fx@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Another comment.

On Fri, Dec 30, 2022 at 03:45:12PM +0200, Laurent Pinchart wrote:
> On Fri, Dec 02, 2022 at 06:02:43PM +0100, Ricardo Ribalda wrote:
> > Some Sunplus cameras took a borderline interpretation of the UVC 1.5
> > standard, and fill the PTS and SCR fields with invalid data if the
> > package does not contain data.
> > 
> > "STC must be captured when the first video data of a video frame is put
> > on the USB bus."
> > 
> > Eg:
> > 
> > buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> > buffer: 0xa7755c00 len 000012 header:0x8c stc 00000000 sof 0000 pts 00000000
> > buffer: 0xa7755c00 len 000668 header:0x8c stc 73779dba sof 070c pts 7376d37a
> > 
> > This borderline/buggy interpretation has been implemented in a variety
> > of devices, from directly Sunplus and from other OEMs that rebrand
> > Sunplus products.
> > 
> > Luckily we can identify the affected modules by looking at the guid of
> > one of the extension units:
> > 
> > VideoControl Interface Descriptor:
> >   guidExtensionCode         {82066163-7050-ab49-b8cc-b3855e8d221d}
> > 
> > This patch adds a new quirk to take care of this.
> > 
> > Complete lsusb of one of the affected cameras:
> 
> That's not complete (but that's fine from a commit message point of
> view, the full descriptors would be too long). Can you share the full
> descriptors for all the devices you know are affected by this ?
> 
> > Bus 001 Device 003: ID 1bcf:2a01 Sunplus Innovation Technology Inc.
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.01
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2 ?
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0        64
> >   idVendor           0x1bcf Sunplus Innovation Technology Inc.
> >   idProduct          0x2a01
> >   bcdDevice            0.02
> >   iManufacturer           1 SunplusIT Inc
> >   iProduct                2 HanChen Wise Camera
> >   iSerial                 3 01.00.00
> >   bNumConfigurations      1
> > 
> > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 11 +++++++++++
> >  drivers/media/usb/uvc/uvc_video.c  |  8 ++++++++
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> >  3 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index c63ecfd4617d..80ef0f0e04b0 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1497,6 +1497,17 @@ static const struct uvc_entity_quirk {
> >  	u8 guid[16];
> >  	u32 quirks;
> >  } uvc_entity_quirk[] = {
> > +	/*
> > +	 * Some SunPlus uvc 1.5 device firmware expects that packages with
> 
> s/uvc/UVC/
> 
> > +	 * no frame data are ignored by the host.
> 
> If it's two paragraphs, you need a blank line in-between. If it's a
> single paragraph, you must not add a line break.
> 
> > +	 * Therefore it does not clear the PTS/SCR bits in the header, and
> > +	 * breaks the timestamp decode algorithm.
> > +	 */
> > +	{
> > +		.guid = {0x82, 0x06, 0x61, 0x63, 0x70, 0x50, 0xab, 0x49,
> > +			 0xb8, 0xcc, 0xb3, 0x85, 0x5e, 0x8d, 0x22, 0x1d},
> > +		.quirks = UVC_QUIRK_IGNORE_EMPTY_TS,
> > +	},
> >  };
> >  
> >  static void uvc_entity_quirks(struct uvc_device *dev)
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index ab56e65ca324..a5b184e71ad7 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -500,6 +500,14 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
> >  	if (len < header_size)
> >  		return;
> >  
> > +	/*
> > +	 * Ignore the hardware timestamp on frames with no data on
> > +	 * miss-behaving devices.
> > +	 */
> 
> Could you please expand this comment to explain the issue ? Having to
> use git blame and read the commit message to understand why the check is
> here isn't very convenient.
> 
> > +	if (stream->dev->quirks & UVC_QUIRK_IGNORE_EMPTY_TS &&
> > +	    len == header_size)
> > +		return;

Given that there may be no guarantee that the above GUID won't be used
by devices that don't exhibit this problem, I'm wondering if we couldn't
use a heuristics instead of a quirk. I'm thinking about something along
the lines of

	if (buf->bytesused == 0 && len == header_size && has_scr &&
	    stc == 0 && sof == 0)

This will catch suspicious SCR values (stc == 0 && sof == 0) on empty
packets (len == header_size) sent before any data packet (buf->bytesused
== 0), which should handle the devices you have to support, and avoid
false positives (the stc == 0 && sof == 0 check is already quite
restrictive, adding buf->bytesused == 0 would limit the workaround to
packets before the first data packet).

With this we could drop patch 2/8.

> > +
> >  	/*
> >  	 * Extract the timestamps:
> >  	 *
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 24c911aeebce..f395b67fe95a 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -212,6 +212,7 @@
> >  #define UVC_QUIRK_RESTORE_CTRLS_ON_INIT	0x00000400
> >  #define UVC_QUIRK_FORCE_Y8		0x00000800
> >  #define UVC_QUIRK_FORCE_BPP		0x00001000
> > +#define UVC_QUIRK_IGNORE_EMPTY_TS	0x00002000
> >  
> >  /* Format flags */
> >  #define UVC_FMT_FLAG_COMPRESSED		0x00000001
> > 

-- 
Regards,

Laurent Pinchart
