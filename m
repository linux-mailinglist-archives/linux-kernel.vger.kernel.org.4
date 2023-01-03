Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5907E65C3A7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbjACQN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbjACQN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:13:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803B41261E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:13:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id p4so33373447pjk.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1H8VPSGvgpTrDAUE/zBL6BriDEyKvBPzo2ZBC0nBHpo=;
        b=Y9ctkcuSL5IzdXx6GNNR/0YVL3dQsWMq/r+9uznxEw0j7BnHeY+ZClECtz5ykJRWfH
         6db3dZQq2x2+xRA8PI4ck0qb2a+v+h7FZuNoJ2a1bcgtQmBcIAQOfICuo8LoWvnFJvbY
         oxqjluK7iKI66PqBiNWu/4nTBV5ZbxDEVYfdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H8VPSGvgpTrDAUE/zBL6BriDEyKvBPzo2ZBC0nBHpo=;
        b=fQTdWNXx1LaXnRhSpKlwulzoQNHLqD3nyuPmVRHFog1sByDWRqkH3lhdpiwLJPa2Zh
         8J2Nq20oCqzEueahEWfh3qlbTs1VsM08x5gg2BPpNX2R70UzJP4KUxgzn5dKWsDRUF+A
         fThjNu85brZhxNC1wm+a6C/DzHSiUBcFfcQtJkZw8aKsqzCcwuJtXddB+CLvKH97G6gK
         /NxehM0d4a5jlgSOGT4HOgFr/WQmemIiOiGGNZUDlkcv+6rfslH4KAYqaqXNzupT0jxa
         JQdjFjCsMrmvy2S/GgWH/qPTPAs2Ku2D7UxiWcMy91hYzXxHPSHPXUKZJ0sKi8LsvMvF
         rs4Q==
X-Gm-Message-State: AFqh2krDyM3I2XQS8dNv3E0uPaKJltD0LEiPS/li1ZRMoZJ1eHCmlzyy
        +ZrbuMCYAHjH810bZHSJ9Shi/5D9934gxN/jJAk=
X-Google-Smtp-Source: AMrXdXsQxC2JMdXkwnOfvtBivcD6loaN2IhfEyTRcna1/OkLjEKFl7H38/VlCNJPAiqrZKA1ph4oJQ==
X-Received: by 2002:a17:90b:215:b0:225:bf26:4928 with SMTP id fy21-20020a17090b021500b00225bf264928mr45355861pjb.38.1672762406729;
        Tue, 03 Jan 2023 08:13:26 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id q60-20020a17090a4fc200b00225d963fbc2sm15779852pjh.34.2023.01.03.08.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 08:13:26 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id r18so20412053pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 08:13:26 -0800 (PST)
X-Received: by 2002:a62:5e44:0:b0:576:af2d:4c4d with SMTP id
 s65-20020a625e44000000b00576af2d4c4dmr2854842pfb.69.1672762405425; Tue, 03
 Jan 2023 08:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
 <20220920-resend-hwtimestamp-v2-5-0d7978a817cc@chromium.org> <Y67tMN5+7vASplsE@pendragon.ideasonboard.com>
In-Reply-To: <Y67tMN5+7vASplsE@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 3 Jan 2023 17:13:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCvRe80jGFsiRYETz2TAp2+EEhRthsPTAB6tyBKO3GjCNA@mail.gmail.com>
Message-ID: <CANiDSCvRe80jGFsiRYETz2TAp2+EEhRthsPTAB6tyBKO3GjCNA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 5/8] media: uvcvideo: Quirk for autosuspend in
 Logi C910
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Fri, 30 Dec 2022 at 14:52, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> s/C910/B910 and C910/ in the subject line.
>
> On Fri, Dec 02, 2022 at 06:02:45PM +0100, Ricardo Ribalda wrote:
> > Logitech C910 firmware is unable to recover from a usb autosuspend. When
>
> s/C910/B910 and C910/
> s/usb/USB/
>
> > it resumes, the device is in a state where it only produces invalid
> > frames. Eg:
> >
> > $ echo 0xFFFF > /sys/module/uvcvideo/parameters/trace # enable verbose log
> > $ yavta -c1 -n1 --file='frame#.jpg' --format MJPEG --size=1920x1080 /dev/video1
>
> Is this true for YUYV frames too ?

I believe so. This is just the script that I typically use to play
with my cameras.

>
> > [350438.435219] uvcvideo: uvc_v4l2_open
> > [350438.529794] uvcvideo: Resuming interface 2
> > [350438.529801] uvcvideo: Resuming interface 3
> > [350438.529991] uvcvideo: Trying format 0x47504a4d (MJPG): 1920x1080.
> > [350438.529996] uvcvideo: Using default frame interval 33333.3 us (30.0 fps).
> > [350438.551496] uvcvideo: uvc_v4l2_mmap
> > [350438.555890] uvcvideo: Device requested 3060 B/frame bandwidth.
> > [350438.555896] uvcvideo: Selecting alternate setting 11 (3060 B/frame bandwidth).
> > [350438.556362] uvcvideo: Allocated 5 URB buffers of 32x3060 bytes each.
> > [350439.316468] uvcvideo: Marking buffer as bad (error bit set).
> > [350439.316475] uvcvideo: Frame complete (EOF found).
> > [350439.316477] uvcvideo: EOF in empty payload.
> > [350439.316484] uvcvideo: frame 1 stats: 149/261/417 packets, 1/149/417 pts (early initial), 416/417 scr, last pts/stc/sof 2976325734/2978107243/249
> > [350439.384510] uvcvideo: Marking buffer as bad (error bit set).
> > [350439.384516] uvcvideo: Frame complete (EOF found).
> > [350439.384518] uvcvideo: EOF in empty payload.
> > [350439.384525] uvcvideo: frame 2 stats: 265/379/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2979524454/2981305193/316
> > [350439.448472] uvcvideo: Marking buffer as bad (error bit set).
> > [350439.448478] uvcvideo: Frame complete (EOF found).
> > [350439.448480] uvcvideo: EOF in empty payload.
> > [350439.448487] uvcvideo: frame 3 stats: 265/377/533 packets, 1/265/533 pts (early initial), 532/533 scr, last pts/stc/sof 2982723174/2984503144/382
> > ...(loop)...
> >
> > The devices can leave this invalid state if its altstate is toggled.
>
> s/its altstate/the alternate setting of the streaming interface/
>
> How did you figure this out ?

A deterministic process, where we analysed all the variables involved
in the streaming process....
(aka, educated guess + luck + trial and error :P)

I triggered a whole reconfiguration of the device and that worked, and
then I started removing parts of it until I ended up with the minimum
thing that made the device work.

>
> > This patch addes a quirk for this device so it can be autosuspended
> > properly.
> >
> > lsusb -v:
> > Bus 001 Device 049: ID 046d:0821 Logitech, Inc. HD Webcam C910
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               2.00
> >   bDeviceClass          239 Miscellaneous Device
> >   bDeviceSubClass         2
> >   bDeviceProtocol         1 Interface Association
> >   bMaxPacketSize0        64
> >   idVendor           0x046d Logitech, Inc.
> >   idProduct          0x0821 HD Webcam C910
> >   bcdDevice            0.10
> >   iManufacturer           0
> >   iProduct                0
> >   iSerial                 1 390022B0
> >   bNumConfigurations      1
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 18 ++++++++++++++++++
> >  drivers/media/usb/uvc/uvc_video.c  |  5 +++++
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> >  3 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 4512316c8748..d2a158a1ce35 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2823,6 +2823,24 @@ static const struct usb_device_id uvc_ids[] = {
> >         .bInterfaceSubClass   = 1,
> >         .bInterfaceProtocol   = 0,
> >         .driver_info          = (kernel_ulong_t)&uvc_quirk_probe_minmax },
> > +     /* Logitech, Webcam C910 */
> > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > +       .idVendor             = 0x046d,
> > +       .idProduct            = 0x0821,
> > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > +       .bInterfaceSubClass   = 1,
> > +       .bInterfaceProtocol   = 0,
> > +       .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
> > +     /* Logitech, Webcam B910 */
> > +     { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> > +                             | USB_DEVICE_ID_MATCH_INT_INFO,
> > +       .idVendor             = 0x046d,
> > +       .idProduct            = 0x0823,
> > +       .bInterfaceClass      = USB_CLASS_VIDEO,
> > +       .bInterfaceSubClass   = 1,
> > +       .bInterfaceProtocol   = 0,
> > +       .driver_info          = UVC_INFO_QUIRK(UVC_QUIRK_WAKE_AUTOSUSPEND)},
> >       /* Logitech Quickcam Fusion */
> >       { .match_flags          = USB_DEVICE_ID_MATCH_DEVICE
> >                               | USB_DEVICE_ID_MATCH_INT_INFO,
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index d387d6335344..75c32e232f5d 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -1983,6 +1983,11 @@ static int uvc_video_start_transfer(struct uvc_streaming *stream,
> >                       "Selecting alternate setting %u (%u B/frame bandwidth)\n",
> >                       altsetting, best_psize);
> >
>
> Please add a comment to explain the issue.
>
> > +             if (stream->dev->quirks & UVC_QUIRK_WAKE_AUTOSUSPEND) {
> > +                     usb_set_interface(stream->dev->udev, intfnum,
> > +                                       altsetting);
> > +                     usb_set_interface(stream->dev->udev, intfnum, 0);
> > +             }
>
> Missing blank line.
>
> >               ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
> >               if (ret < 0)
> >                       return ret;
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index e41289605d0e..14daa7111953 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -214,6 +214,7 @@
> >  #define UVC_QUIRK_FORCE_BPP          0x00001000
> >  #define UVC_QUIRK_IGNORE_EMPTY_TS    0x00002000
> >  #define UVC_QUIRK_INVALID_DEVICE_SOF 0x00004000
> > +#define UVC_QUIRK_WAKE_AUTOSUSPEND   0x00008000
> >
> >  /* Format flags */
> >  #define UVC_FMT_FLAG_COMPRESSED              0x00000001
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
