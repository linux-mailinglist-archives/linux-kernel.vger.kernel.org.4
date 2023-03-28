Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885176CB8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbjC1HxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjC1Hw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:52:57 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2314398
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:52:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw3so10867145plb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679989974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oh6ioMhNsMKgrbyT0Opg2xxclp3zb+Yju+WYnfl1IaU=;
        b=eo+qFwvaQwLGV/Qk3bRBadzkZ9j64zJatwJT+hcs/zhv50rKSj7Mh/AvIEpjVEPaFH
         U1AbiJhk6toN6YNwc0lag140WN2m29SXSfD6Z6R8Z55/eQscKXzqbauk5EWqdZr1amjz
         D4MeO00CAgMyc1nZYobNVhNs8CSpp+9urOZ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679989974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oh6ioMhNsMKgrbyT0Opg2xxclp3zb+Yju+WYnfl1IaU=;
        b=w2I5UaPdSxGFTvclWXkAkNj3Wnj6sCoarf5xggWK7jbZ/eIKEM43O3a7Ewyaj9Mqxf
         UEVzj2hv9S8pRh5LEt/a34hlysWH02u+bpLG8lw1RnR7RK3649HlRnM8vnDQvZ03BHCY
         Ar1/eLn+LZE1wQT+LtpqvKXjA574Du5vA0jyPjjIekS+oh5ditMBVGACajGvTGLKdFvK
         P4AREkFaJPSQUx8E0isAfPUZh8IFT96Qiip3JmjDz/rjwWXuvbkSMAlkEv8fkcBss4Ww
         mGH8BFD4Pr7qtGaklY8KOQ20+zR5nQ2S+KeFz10FRxeEZzrcHrlSpqwGNj6ZtHIrAAHn
         Yrbg==
X-Gm-Message-State: AO0yUKVMi7Wk8yksXtiYN6vk3ZqNlbUyVra4S+HYbQfi+L5iuQveejWi
        4qVl+WI/jCOgxxoH/OE9h5AlKdYpVZryZSucji+HYw==
X-Google-Smtp-Source: AKy350afYQX3lI4q0v2y7WXZnhr77B2NMpzkRt6ceuHl442SPbfaS4zytuSvHsryZeJ6SLxcF2ZisQ==
X-Received: by 2002:a17:90b:2243:b0:23f:7176:df32 with SMTP id hk3-20020a17090b224300b0023f7176df32mr15396936pjb.40.1679989974217;
        Tue, 28 Mar 2023 00:52:54 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090a13ca00b0023f5c867f82sm5493775pjf.41.2023.03.28.00.52.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 00:52:53 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so11681139pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:52:53 -0700 (PDT)
X-Received: by 2002:a17:90b:350c:b0:23b:349d:a159 with SMTP id
 ls12-20020a17090b350c00b0023b349da159mr8172673pjb.3.1679989972919; Tue, 28
 Mar 2023 00:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
 <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org> <20230309145757.GB1088@pendragon.ideasonboard.com>
In-Reply-To: <20230309145757.GB1088@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 28 Mar 2023 09:52:41 +0200
X-Gmail-Original-Message-ID: <CANiDSCvCxk4m4MDPTL4DDot-PCkyuRQX7N6xAUvhOju16Hft4w@mail.gmail.com>
Message-ID: <CANiDSCvCxk4m4MDPTL4DDot-PCkyuRQX7N6xAUvhOju16Hft4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] media: uvcvideo: Cancel async worker earlier
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

I have not tested it yet... but maybe something like this might be
slightly better?


diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 5e9d3da862dd..3944404b2de2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2762,10 +2762,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
        struct uvc_entity *entity;
        unsigned int i;

-       /* Can be uninitialized if we are aborting on probe error. */
-       if (dev->async_ctrl.work.func)
-               cancel_work_sync(&dev->async_ctrl.work);
-
        /* Free controls and control mappings for all entities. */
        list_for_each_entry(entity, &dev->entities, list) {
                for (i = 0; i < entity->ncontrols; ++i) {
diff --git a/drivers/media/usb/uvc/uvc_status.c
b/drivers/media/usb/uvc/uvc_status.c
index a78a88c710e2..0208612a9f12 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)

 void uvc_status_unregister(struct uvc_device *dev)
 {
-       usb_kill_urb(dev->int_urb);
+       uvc_status_stop(dev);
        uvc_input_unregister(dev);
 }


The benefit from Guenter patch is that it has been tested for years...

What do you think? Shall we try this approach instead?

Regards!

On Thu, 9 Mar 2023 at 15:57, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo and Guenter,
>
> Thank you for the patch.
>
> On Thu, Mar 09, 2023 at 03:44:05PM +0100, Ricardo Ribalda wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> >
> > So far the asynchronous control worker was canceled only in
> > uvc_ctrl_cleanup_device. This is much later than the call to
> > uvc_disconnect. However, after the call to uvc_disconnect returns,
> > there must be no more USB activity. This can result in all kinds
> > of problems in the USB code. One observed example:
> >
> > URB ffff993e83d0bc00 submitted while active
> > WARNING: CPU: 0 PID: 4046 at drivers/usb/core/urb.c:364 usb_submit_urb+0x4ba/0x55e
> > Modules linked in: <...>
> > CPU: 0 PID: 4046 Comm: kworker/0:35 Not tainted 4.19.139 #18
> > Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 08/09/2018
> > Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
> > RIP: 0010:usb_submit_urb+0x4ba/0x55e
> > Code: <...>
> > RSP: 0018:ffffb08d471ebde8 EFLAGS: 00010246
> > RAX: a6da85d923ea5d00 RBX: ffff993e71985928 RCX: 0000000000000000
> > RDX: ffff993f37a1de90 RSI: ffff993f37a153d0 RDI: ffff993f37a153d0
> > RBP: ffffb08d471ebe28 R08: 000000000000003b R09: 001424bf85822e96
> > R10: 0000001000000000 R11: ffffffff975a4398 R12: ffff993e83d0b000
> > R13: ffff993e83d0bc00 R14: 0000000000000000 R15: 00000000fffffff0
> > FS:  0000000000000000(0000) GS:ffff993f37a00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000ec9c0000 CR3: 000000025b160000 CR4: 0000000000340ef0
> > Call Trace:
> >  uvc_ctrl_status_event_work+0xd6/0x107 [uvcvideo]
> >  process_one_work+0x19b/0x4c5
> >  worker_thread+0x10d/0x286
> >  kthread+0x138/0x140
> >  ? process_one_work+0x4c5/0x4c5
> >  ? kthread_associate_blkcg+0xc1/0xc1
> >  ret_from_fork+0x1f/0x40
> >
> > Introduce new function uvc_ctrl_stop_device() to cancel the worker
> > and call it from uvc_unregister_video() to solve the problem.
> >
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
> >  drivers/media/usb/uvc/uvc_driver.c |  1 +
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> >  3 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 5e9d3da862dd..769c1d2a2f45 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2757,14 +2757,17 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
> >       }
> >  }
> >
> > -void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > +void uvc_ctrl_stop_device(struct uvc_device *dev)
> >  {
> > -     struct uvc_entity *entity;
> > -     unsigned int i;
> > -
> >       /* Can be uninitialized if we are aborting on probe error. */
> >       if (dev->async_ctrl.work.func)
> >               cancel_work_sync(&dev->async_ctrl.work);
> > +}
>
> There may be an opportunity for refactoring, as we have
> uvc_status_stop() that stops the work queue, but I think this is good
> enough for now. I'm wondering, though, if there could be a race
> condition here similar to the one that the recent changes to
> uvc_status_stop() have fixed ? As uvc_ctrl_stop_device() is called at
> release time I assume that URBs have been cancelled, so there should be
> no race, but a second pair of eyeballs to confirm this would be
> appreciated.
>
> Other than that, the patch looks good to me, and fixes an issue
> independent from the rest of the series, so
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> I will wait for a reply regarding the race condition before queuing this
> up though.
>
> > +
> > +void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > +{
> > +     struct uvc_entity *entity;
> > +     unsigned int i;
> >
> >       /* Free controls and control mappings for all entities. */
> >       list_for_each_entry(entity, &dev->entities, list) {
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 7aefa76a42b3..4be6dfeaa295 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -1893,6 +1893,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
> >       }
> >
> >       uvc_status_unregister(dev);
> > +     uvc_ctrl_stop_device(dev);
> >
> >       if (dev->vdev.dev)
> >               v4l2_device_unregister(&dev->vdev);
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 9a596c8d894a..50f171e7381b 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -760,6 +760,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
> >  int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> >                        const struct uvc_control_mapping *mapping);
> >  int uvc_ctrl_init_device(struct uvc_device *dev);
> > +void uvc_ctrl_stop_device(struct uvc_device *dev);
> >  void uvc_ctrl_cleanup_device(struct uvc_device *dev);
> >  int uvc_ctrl_restore_values(struct uvc_device *dev);
> >  bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
