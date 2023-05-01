Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3C6F3188
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjEANaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjEANaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:30:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1E19F
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 06:30:11 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1770188b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682947811; x=1685539811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8t+ryimp8XVllE7Zv2wMNMLGAWwLUyGzNT5BT3objI=;
        b=LtRPHZwXz888ApWCRSA63q4zBm2IMKP70NBl1DH5hFyDOUxggN/V3pgIVEvQ4GbdKR
         /yiZrgb/mbO45VrtAPbI7eIb6J2PlWZkXWPmdPGASW+uyPhsxrW5kbVn4aNQBJ3smok6
         Cao2b8fsxPbNg3FS9fkYAWGe/UXquAahQEKPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682947811; x=1685539811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8t+ryimp8XVllE7Zv2wMNMLGAWwLUyGzNT5BT3objI=;
        b=VGBmiPh1bao6RMIQ20t9jR7ptF4SLIBzBUgvbVc1XVXt+IhTJdigrCAKsVqXs7yIZe
         zT0N21LWnAPkKUhiUd00pao0hpL0kicG6gGb0qMKCPn1daSEIV6wX0S/uhemj+ZX2SNh
         YDHUj+7F148opanIw2MT8y9FwgLk3cj0Cba+5O+6ZekhtuSKXizn8l9Q0Kw2n3vY8381
         3dLDw1IvyU/SF/SkBzy/GFVKqRWgZewnIdky4zZZ6+JC7Lh3MyixyOrBaOepaErDV2et
         My/4YMV5gqskam7MWUmelXq2r0lX7ahL6BYTmxngWJ837UFUNRpJdv/qAJDCWj12vXLD
         yWDw==
X-Gm-Message-State: AC+VfDw3jJz4AydwAAhdELgYiiWWFhttYF9lw5zSTiqhxF+a/cUNSu9b
        1JBEMCeqLSYCxHXBe1uKCIYf6Gc2AJkl5v1fznWu+g==
X-Google-Smtp-Source: ACHHUZ54pMhMJyO/vxQyOMbbuU+9NdrTZCXEWbwlYqORwHPAN75xZ+Ari7ikruz5uRzp6HSNotWqSg==
X-Received: by 2002:a05:6a20:4309:b0:f0:515d:1742 with SMTP id h9-20020a056a20430900b000f0515d1742mr17872622pzk.53.1682947810673;
        Mon, 01 May 2023 06:30:10 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id i5-20020a6561a5000000b0050bd9c8c53dsm15602909pgv.23.2023.05.01.06.30.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:30:10 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-24df4ecdb87so822560a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 06:30:09 -0700 (PDT)
X-Received: by 2002:a17:90b:350b:b0:247:140b:c5d6 with SMTP id
 ls11-20020a17090b350b00b00247140bc5d6mr14366243pjb.45.1682947809251; Mon, 01
 May 2023 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
 <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org> <20230309145757.GB1088@pendragon.ideasonboard.com>
 <CANiDSCvCxk4m4MDPTL4DDot-PCkyuRQX7N6xAUvhOju16Hft4w@mail.gmail.com>
In-Reply-To: <CANiDSCvCxk4m4MDPTL4DDot-PCkyuRQX7N6xAUvhOju16Hft4w@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 1 May 2023 15:29:58 +0200
X-Gmail-Original-Message-ID: <CANiDSCv_MkhE2iJjvm9-0+bu7-iJGEai5UnGUqwwEki58FE81A@mail.gmail.com>
Message-ID: <CANiDSCv_MkhE2iJjvm9-0+bu7-iJGEai5UnGUqwwEki58FE81A@mail.gmail.com>
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
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

Friendly ping!

On Tue, 28 Mar 2023 at 09:52, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Laurent
>
> I have not tested it yet... but maybe something like this might be
> slightly better?
>
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5e9d3da862dd..3944404b2de2 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2762,10 +2762,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
>         struct uvc_entity *entity;
>         unsigned int i;
>
> -       /* Can be uninitialized if we are aborting on probe error. */
> -       if (dev->async_ctrl.work.func)
> -               cancel_work_sync(&dev->async_ctrl.work);
> -
>         /* Free controls and control mappings for all entities. */
>         list_for_each_entry(entity, &dev->entities, list) {
>                 for (i = 0; i < entity->ncontrols; ++i) {
> diff --git a/drivers/media/usb/uvc/uvc_status.c
> b/drivers/media/usb/uvc/uvc_status.c
> index a78a88c710e2..0208612a9f12 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
>
>  void uvc_status_unregister(struct uvc_device *dev)
>  {
> -       usb_kill_urb(dev->int_urb);
> +       uvc_status_stop(dev);
>         uvc_input_unregister(dev);
>  }
>
>
> The benefit from Guenter patch is that it has been tested for years...
>
> What do you think? Shall we try this approach instead?
>
> Regards!
>
> On Thu, 9 Mar 2023 at 15:57, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Ricardo and Guenter,
> >
> > Thank you for the patch.
> >
> > On Thu, Mar 09, 2023 at 03:44:05PM +0100, Ricardo Ribalda wrote:
> > > From: Guenter Roeck <linux@roeck-us.net>
> > >
> > > So far the asynchronous control worker was canceled only in
> > > uvc_ctrl_cleanup_device. This is much later than the call to
> > > uvc_disconnect. However, after the call to uvc_disconnect returns,
> > > there must be no more USB activity. This can result in all kinds
> > > of problems in the USB code. One observed example:
> > >
> > > URB ffff993e83d0bc00 submitted while active
> > > WARNING: CPU: 0 PID: 4046 at drivers/usb/core/urb.c:364 usb_submit_urb+0x4ba/0x55e
> > > Modules linked in: <...>
> > > CPU: 0 PID: 4046 Comm: kworker/0:35 Not tainted 4.19.139 #18
> > > Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 08/09/2018
> > > Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
> > > RIP: 0010:usb_submit_urb+0x4ba/0x55e
> > > Code: <...>
> > > RSP: 0018:ffffb08d471ebde8 EFLAGS: 00010246
> > > RAX: a6da85d923ea5d00 RBX: ffff993e71985928 RCX: 0000000000000000
> > > RDX: ffff993f37a1de90 RSI: ffff993f37a153d0 RDI: ffff993f37a153d0
> > > RBP: ffffb08d471ebe28 R08: 000000000000003b R09: 001424bf85822e96
> > > R10: 0000001000000000 R11: ffffffff975a4398 R12: ffff993e83d0b000
> > > R13: ffff993e83d0bc00 R14: 0000000000000000 R15: 00000000fffffff0
> > > FS:  0000000000000000(0000) GS:ffff993f37a00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 00000000ec9c0000 CR3: 000000025b160000 CR4: 0000000000340ef0
> > > Call Trace:
> > >  uvc_ctrl_status_event_work+0xd6/0x107 [uvcvideo]
> > >  process_one_work+0x19b/0x4c5
> > >  worker_thread+0x10d/0x286
> > >  kthread+0x138/0x140
> > >  ? process_one_work+0x4c5/0x4c5
> > >  ? kthread_associate_blkcg+0xc1/0xc1
> > >  ret_from_fork+0x1f/0x40
> > >
> > > Introduce new function uvc_ctrl_stop_device() to cancel the worker
> > > and call it from uvc_unregister_video() to solve the problem.
> > >
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
> > >  drivers/media/usb/uvc/uvc_driver.c |  1 +
> > >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> > >  3 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > index 5e9d3da862dd..769c1d2a2f45 100644
> > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > @@ -2757,14 +2757,17 @@ static void uvc_ctrl_cleanup_mappings(struct uvc_device *dev,
> > >       }
> > >  }
> > >
> > > -void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > > +void uvc_ctrl_stop_device(struct uvc_device *dev)
> > >  {
> > > -     struct uvc_entity *entity;
> > > -     unsigned int i;
> > > -
> > >       /* Can be uninitialized if we are aborting on probe error. */
> > >       if (dev->async_ctrl.work.func)
> > >               cancel_work_sync(&dev->async_ctrl.work);
> > > +}
> >
> > There may be an opportunity for refactoring, as we have
> > uvc_status_stop() that stops the work queue, but I think this is good
> > enough for now. I'm wondering, though, if there could be a race
> > condition here similar to the one that the recent changes to
> > uvc_status_stop() have fixed ? As uvc_ctrl_stop_device() is called at
> > release time I assume that URBs have been cancelled, so there should be
> > no race, but a second pair of eyeballs to confirm this would be
> > appreciated.
> >
> > Other than that, the patch looks good to me, and fixes an issue
> > independent from the rest of the series, so
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > I will wait for a reply regarding the race condition before queuing this
> > up though.
> >
> > > +
> > > +void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > > +{
> > > +     struct uvc_entity *entity;
> > > +     unsigned int i;
> > >
> > >       /* Free controls and control mappings for all entities. */
> > >       list_for_each_entry(entity, &dev->entities, list) {
> > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > index 7aefa76a42b3..4be6dfeaa295 100644
> > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > @@ -1893,6 +1893,7 @@ static void uvc_unregister_video(struct uvc_device *dev)
> > >       }
> > >
> > >       uvc_status_unregister(dev);
> > > +     uvc_ctrl_stop_device(dev);
> > >
> > >       if (dev->vdev.dev)
> > >               v4l2_device_unregister(&dev->vdev);
> > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > index 9a596c8d894a..50f171e7381b 100644
> > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > @@ -760,6 +760,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
> > >  int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> > >                        const struct uvc_control_mapping *mapping);
> > >  int uvc_ctrl_init_device(struct uvc_device *dev);
> > > +void uvc_ctrl_stop_device(struct uvc_device *dev);
> > >  void uvc_ctrl_cleanup_device(struct uvc_device *dev);
> > >  int uvc_ctrl_restore_values(struct uvc_device *dev);
> > >  bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
>
>
> --
> Ricardo Ribalda



-- 
Ricardo Ribalda
