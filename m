Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A5B705E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjEQEFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjEQEFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:05:35 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D415C3A8B
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:05:33 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f38956ffdbso2735731cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684296333; x=1686888333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A41ENrMX5x8zKKDNaUz4naidfiHWMXiWMyeFBHOAqaE=;
        b=jY5wSwccT7jcQM0a81wqYwI9HPQisng8sSkj7Szr3Vp3Kq9yMD2arSqix5dpCucPiq
         aqdDfui9fsp+AxPVFlD12MJCVBs1i++u/IhebU+aVpDal2klBG+8/JyXkaXarPkzNJ0m
         6cYZSLnp2uJ74yiyZv4lx6/m4Z19TPdxmw4+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684296333; x=1686888333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A41ENrMX5x8zKKDNaUz4naidfiHWMXiWMyeFBHOAqaE=;
        b=UvpKH0LXSmAJjtUAtKL11haA7+02ddAKesNElX007zOR12QkEBaOIL0tYf3qJ7DxGH
         sHApjlgt6YUCCEpznATnR2UHFEZZ6bcG7xQf5hjAS2TkjV6RJH324XTuGScgQsp9ZbIS
         cIB1SyyRND57V/mbNvcQ5ewItrOgNhChpQG3FBwh8G4Wd263XtHG9a6e9IAJqrIzZgoD
         OKgi/v9C90fZXdCrkQI4X7nDtmvPqkkUtxPGn4OojtI/QhVeTvA0kDybuEkowl+wUDnp
         asGEUkEJKb/YCFYX91wgnfFiTbUem6TIcKDr86wjR2CCBY40DlAevaoP38pNkRxj19XT
         hsAg==
X-Gm-Message-State: AC+VfDyULeONqPx7T0uJS2KoaZ8azfhdCACXZaQwG6rtP9tfMZs1tkcX
        mE8lGcxANeFE0qcJ4QOd4sAq3rR3bIwWM3j5o3axFg==
X-Google-Smtp-Source: ACHHUZ7vFnmzN2tTJnWw91DoasphQ1V0ZP66CiYEBQdr9aIgrmcHOxCdXywAuj6fh3zz6jSUSXEbYg==
X-Received: by 2002:ac8:7e92:0:b0:3f5:2faf:7912 with SMTP id w18-20020ac87e92000000b003f52faf7912mr13290391qtj.61.1684296332766;
        Tue, 16 May 2023 21:05:32 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id l30-20020ac8459e000000b003e97fe68511sm6816995qtn.3.2023.05.16.21.05.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 21:05:31 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-62384e391e3so1296246d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:05:30 -0700 (PDT)
X-Received: by 2002:a05:6214:27cc:b0:623:1a2f:fe06 with SMTP id
 ge12-20020a05621427cc00b006231a2ffe06mr25979660qvb.10.1684296330534; Tue, 16
 May 2023 21:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230309-guenter-mini-v2-0-e6410d590d43@chromium.org>
 <20230309-guenter-mini-v2-1-e6410d590d43@chromium.org> <20230309145757.GB1088@pendragon.ideasonboard.com>
 <CANiDSCvCxk4m4MDPTL4DDot-PCkyuRQX7N6xAUvhOju16Hft4w@mail.gmail.com> <CANiDSCv_MkhE2iJjvm9-0+bu7-iJGEai5UnGUqwwEki58FE81A@mail.gmail.com>
In-Reply-To: <CANiDSCv_MkhE2iJjvm9-0+bu7-iJGEai5UnGUqwwEki58FE81A@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 17 May 2023 13:05:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BWxV74P9YXEQpQQxFJ8aNn2CgxhjeABrOjdbVuESrm3w@mail.gmail.com>
Message-ID: <CAAFQd5BWxV74P9YXEQpQQxFJ8aNn2CgxhjeABrOjdbVuESrm3w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] media: uvcvideo: Cancel async worker earlier
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Staudt <mstaudt@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 10:30=E2=80=AFPM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Hi Laurent
>
> Friendly ping!

+Kieran and +Mauro, could you take a look at this please, since
Laurent has not responded to this for almost 2 months?

>
> On Tue, 28 Mar 2023 at 09:52, Ricardo Ribalda <ribalda@chromium.org> wrot=
e:
> >
> > Hi Laurent
> >
> > I have not tested it yet... but maybe something like this might be
> > slightly better?
> >
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/u=
vc_ctrl.c
> > index 5e9d3da862dd..3944404b2de2 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -2762,10 +2762,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *=
dev)
> >         struct uvc_entity *entity;
> >         unsigned int i;
> >
> > -       /* Can be uninitialized if we are aborting on probe error. */
> > -       if (dev->async_ctrl.work.func)
> > -               cancel_work_sync(&dev->async_ctrl.work);
> > -
> >         /* Free controls and control mappings for all entities. */
> >         list_for_each_entry(entity, &dev->entities, list) {
> >                 for (i =3D 0; i < entity->ncontrols; ++i) {
> > diff --git a/drivers/media/usb/uvc/uvc_status.c
> > b/drivers/media/usb/uvc/uvc_status.c
> > index a78a88c710e2..0208612a9f12 100644
> > --- a/drivers/media/usb/uvc/uvc_status.c
> > +++ b/drivers/media/usb/uvc/uvc_status.c
> > @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
> >
> >  void uvc_status_unregister(struct uvc_device *dev)
> >  {
> > -       usb_kill_urb(dev->int_urb);
> > +       uvc_status_stop(dev);
> >         uvc_input_unregister(dev);
> >  }
> >
> >
> > The benefit from Guenter patch is that it has been tested for years...
> >
> > What do you think? Shall we try this approach instead?
> >
> > Regards!
> >
> > On Thu, 9 Mar 2023 at 15:57, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > Hi Ricardo and Guenter,
> > >
> > > Thank you for the patch.
> > >
> > > On Thu, Mar 09, 2023 at 03:44:05PM +0100, Ricardo Ribalda wrote:
> > > > From: Guenter Roeck <linux@roeck-us.net>
> > > >
> > > > So far the asynchronous control worker was canceled only in
> > > > uvc_ctrl_cleanup_device. This is much later than the call to
> > > > uvc_disconnect. However, after the call to uvc_disconnect returns,
> > > > there must be no more USB activity. This can result in all kinds
> > > > of problems in the USB code. One observed example:
> > > >
> > > > URB ffff993e83d0bc00 submitted while active
> > > > WARNING: CPU: 0 PID: 4046 at drivers/usb/core/urb.c:364 usb_submit_=
urb+0x4ba/0x55e
> > > > Modules linked in: <...>
> > > > CPU: 0 PID: 4046 Comm: kworker/0:35 Not tainted 4.19.139 #18
> > > > Hardware name: Google Phaser/Phaser, BIOS Google_Phaser.10952.0.0 0=
8/09/2018
> > > > Workqueue: events uvc_ctrl_status_event_work [uvcvideo]
> > > > RIP: 0010:usb_submit_urb+0x4ba/0x55e
> > > > Code: <...>
> > > > RSP: 0018:ffffb08d471ebde8 EFLAGS: 00010246
> > > > RAX: a6da85d923ea5d00 RBX: ffff993e71985928 RCX: 0000000000000000
> > > > RDX: ffff993f37a1de90 RSI: ffff993f37a153d0 RDI: ffff993f37a153d0
> > > > RBP: ffffb08d471ebe28 R08: 000000000000003b R09: 001424bf85822e96
> > > > R10: 0000001000000000 R11: ffffffff975a4398 R12: ffff993e83d0b000
> > > > R13: ffff993e83d0bc00 R14: 0000000000000000 R15: 00000000fffffff0
> > > > FS:  0000000000000000(0000) GS:ffff993f37a00000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 00000000ec9c0000 CR3: 000000025b160000 CR4: 0000000000340ef0
> > > > Call Trace:
> > > >  uvc_ctrl_status_event_work+0xd6/0x107 [uvcvideo]
> > > >  process_one_work+0x19b/0x4c5
> > > >  worker_thread+0x10d/0x286
> > > >  kthread+0x138/0x140
> > > >  ? process_one_work+0x4c5/0x4c5
> > > >  ? kthread_associate_blkcg+0xc1/0xc1
> > > >  ret_from_fork+0x1f/0x40
> > > >
> > > > Introduce new function uvc_ctrl_stop_device() to cancel the worker
> > > > and call it from uvc_unregister_video() to solve the problem.
> > > >
> > > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > > Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> > > > Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> > > > Reviewed-by: Sean Paul <seanpaul@chromium.org>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c   | 11 +++++++----
> > > >  drivers/media/usb/uvc/uvc_driver.c |  1 +
> > > >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> > > >  3 files changed, 9 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/u=
vc/uvc_ctrl.c
> > > > index 5e9d3da862dd..769c1d2a2f45 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -2757,14 +2757,17 @@ static void uvc_ctrl_cleanup_mappings(struc=
t uvc_device *dev,
> > > >       }
> > > >  }
> > > >
> > > > -void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > > > +void uvc_ctrl_stop_device(struct uvc_device *dev)
> > > >  {
> > > > -     struct uvc_entity *entity;
> > > > -     unsigned int i;
> > > > -
> > > >       /* Can be uninitialized if we are aborting on probe error. */
> > > >       if (dev->async_ctrl.work.func)
> > > >               cancel_work_sync(&dev->async_ctrl.work);
> > > > +}
> > >
> > > There may be an opportunity for refactoring, as we have
> > > uvc_status_stop() that stops the work queue, but I think this is good
> > > enough for now. I'm wondering, though, if there could be a race
> > > condition here similar to the one that the recent changes to
> > > uvc_status_stop() have fixed ? As uvc_ctrl_stop_device() is called at
> > > release time I assume that URBs have been cancelled, so there should =
be
> > > no race, but a second pair of eyeballs to confirm this would be
> > > appreciated.
> > >
> > > Other than that, the patch looks good to me, and fixes an issue
> > > independent from the rest of the series, so
> > >
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >
> > > I will wait for a reply regarding the race condition before queuing t=
his
> > > up though.
> > >
> > > > +
> > > > +void uvc_ctrl_cleanup_device(struct uvc_device *dev)
> > > > +{
> > > > +     struct uvc_entity *entity;
> > > > +     unsigned int i;
> > > >
> > > >       /* Free controls and control mappings for all entities. */
> > > >       list_for_each_entry(entity, &dev->entities, list) {
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb=
/uvc/uvc_driver.c
> > > > index 7aefa76a42b3..4be6dfeaa295 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -1893,6 +1893,7 @@ static void uvc_unregister_video(struct uvc_d=
evice *dev)
> > > >       }
> > > >
> > > >       uvc_status_unregister(dev);
> > > > +     uvc_ctrl_stop_device(dev);
> > > >
> > > >       if (dev->vdev.dev)
> > > >               v4l2_device_unregister(&dev->vdev);
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/u=
vc/uvcvideo.h
> > > > index 9a596c8d894a..50f171e7381b 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -760,6 +760,7 @@ int uvc_query_v4l2_menu(struct uvc_video_chain =
*chain,
> > > >  int uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> > > >                        const struct uvc_control_mapping *mapping);
> > > >  int uvc_ctrl_init_device(struct uvc_device *dev);
> > > > +void uvc_ctrl_stop_device(struct uvc_device *dev);
> > > >  void uvc_ctrl_cleanup_device(struct uvc_device *dev);
> > > >  int uvc_ctrl_restore_values(struct uvc_device *dev);
> > > >  bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video=
_chain *chain,
> > >
> > > --
> > > Regards,
> > >
> > > Laurent Pinchart
> >
> >
> >
> > --
> > Ricardo Ribalda
>
>
>
> --
> Ricardo Ribalda
