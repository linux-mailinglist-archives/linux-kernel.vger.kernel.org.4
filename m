Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1F6438E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiLEXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiLEXCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:02:37 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A4B5F59
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:02:36 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 130so12861078pfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mVzvOMvXgDRGIbjKtb/T9ErGnaXQACOhgeKupxFj7l8=;
        b=JGTUSbYwILNuJpdiQGkq+LLAyvzz38Ad/o+CVXclHtrphDW51zs6cA6JmIQ+Gi1Y6j
         on3thviUstKtsd0BZ7J7BfotzSEanpxspagxqcITBUfcB0r0FON8wdE4qiB7NL/sQZXw
         ISqZuUvMG6Dchad8gKFbP/yR4Ios4g/LRKpqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVzvOMvXgDRGIbjKtb/T9ErGnaXQACOhgeKupxFj7l8=;
        b=uZ4rMrgcet/3T6vqEynXPk5JgGD4z31kyLhsWkM6Bo7xh85PRX0JZlsDncXRzdwxO/
         bNdYWfryvU7BLfxIF1v5RKwpa2BsnbVHvcGmrQWGXhVFBztvHNc7ZAfGeCD0lR7tAy0b
         TLbYKTGtUg1/TmnZcoLMtOoQ2JTcUOQi1AWMto5AE8nisHMNy0SeRIjfKD8cI4Si1tXg
         8o3bzFPgAfsDonirmGj39HwRBgUtO7ej0bs71wjvvPxfjrS9dMO35PxLJyKMNrqBPFej
         Ark04Pd3ngzHjpgj9ZlfDGowJ1H5MXDdG97nZvntsO0+wcjL7hEnNCjASEyS2HG7S3nA
         8ZOw==
X-Gm-Message-State: ANoB5pmY2GYdYySbTATctTHGCIQTbAEIvryAwlzWrXgQwoX3zYc1dB9k
        ZpbMV5j3qiCoTL80szX6r09uTNw0jIkmMlnpuZg=
X-Google-Smtp-Source: AA0mqf6JbYqtlk0Law5Ekg5XNmXzQjXiBg5s/3WbBmcR5FgCmXX+Ngstghd45l8fzeZ2U6KXpywLkg==
X-Received: by 2002:a63:1965:0:b0:464:a9a6:5717 with SMTP id 37-20020a631965000000b00464a9a65717mr60320109pgz.584.1670281355957;
        Mon, 05 Dec 2022 15:02:35 -0800 (PST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com. [209.85.216.50])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902650700b001801aec1f6bsm11130723plk.141.2022.12.05.15.02.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 15:02:34 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so12997383pjd.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:02:34 -0800 (PST)
X-Received: by 2002:a17:902:ce04:b0:174:af35:4b90 with SMTP id
 k4-20020a170902ce0400b00174af354b90mr66888079plg.8.1670281353827; Mon, 05 Dec
 2022 15:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
 <20220920-resend-meta-v4-3-3ac355b66723@chromium.org> <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
In-Reply-To: <Y45tnp0naosOrYCY@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 6 Dec 2022 00:02:22 +0100
X-Gmail-Original-Message-ID: <CANiDSCtRoVQ2+asPmOacarvC2VrJYTbU67+wKJq1ciuMrwguPg@mail.gmail.com>
Message-ID: <CANiDSCtRoVQ2+asPmOacarvC2VrJYTbU67+wKJq1ciuMrwguPg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] media: uvcvideo: Add a unique suffix to camera names
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Mon, 5 Dec 2022 at 23:16, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Fri, Dec 02, 2022 at 06:08:19PM +0100, Ricardo Ribalda wrote:
> > Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
> > append a unique number to the device name.
> >
> > Fixes v4l2-compliance:
> >     Media Controller ioctls:
> >          fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
> >        test MEDIA_IOC_G_TOPOLOGY: FAIL
> >          fail: v4l2-test-media.cpp(394): num_data_links != num_links
> >        test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 215fb483efb0..f4032ebb3689 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1963,7 +1963,8 @@ int uvc_register_video_device(struct uvc_device *dev,
> >               break;
> >       }
> >
> > -     strscpy(vdev->name, dev->name, sizeof(vdev->name));
> > +     snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
> > +              stream->header.bTerminalLink);
>
> This won't be perfect as the string is not guaranteed to fit in
> vdev->name, but I suppose it will help as a quick fix for some devices.
> How about the other devices ? Won't they still exhibit the above
> v4l2-compliance failure ? Isn't that something that will still affect
> Chrome OS devices ?

We could place the id first... but that will look bad: Eg:

1- My favorite camera

Another option is to remove the last chars to fit the id. Eg:

My favorite came-1

If you prefer any of those options or have a better idea I can implement that.


>
> The change should not cause any regression as big as in patch 1/3.
> However, unless I'm mistaken users will notice a device name change,
> especially when selecting a device in their web browser. Could that be a
> problem ?

I think the only side effect is that the first time that the kernel
changes the naming convention, if there are more than one camera on
the system, the video conference might pick a different camera.
The good news is that the user will be presented with cameras with
different names. Now some cameras show very confusing names:

ribalda@alco:~/work/linux$ for a in /dev/video* ; do yavta -l $a| grep
"Dell Webcam"; done
Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
'uvcvideo') supports video, capture, without mplanes.
Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
'uvcvideo') supports meta-data, capture, without mplanes.
Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
'uvcvideo') supports video, capture, without mplanes.
Device `Dell Webcam WB7022' on `usb-0000:2d:00.0-1.2.3.1' (driver
'uvcvideo') supports meta-data, capture, without mplanes.



>
> >       /*
> >        * Set the driver data before calling video_register_device, otherwise
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
