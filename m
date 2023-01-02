Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C0865B37A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjABOpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjABOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:45:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129C42BF0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:45:05 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h7-20020a17090aa88700b00225f3e4c992so20461308pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hk4clSxh5lBRO/IXvviKJih8Kg2t0t1kJgW0EQHTX5U=;
        b=ZaFjlBt7ZJPFI3wVxUUCGNG2A96WCXKhhihzCkC8U7sw9/M+jIkSHYVQsVMR9SrR+D
         TgxZ15qANvJ9bSAzWOQZWcHlACzVw8u3qc2y0Ah91hOL18HLN7r30eJoVevHSPvnDH6o
         TZoXpdOHIX5IFcXp9tXQPQ/5bFeqY3KuW53bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hk4clSxh5lBRO/IXvviKJih8Kg2t0t1kJgW0EQHTX5U=;
        b=5jaIzZw1efRhf/oJPK6V1KV4Lo1FS84vlqmnK6AUHDTA7RwbwqLWhb8g8FMIZFv7LI
         /xvyQ9sxaGYbiyrNjxCZLeB0avjlmmSZGR21dB1ssI/0s/Jjk9+nR8UH1Xq+7Hza+o9N
         FnV9YFwgqjDvwW1f+NAp4/L/TzM89KE2gaKLJqwpp4Hb22tk2QCuJwdtLhVYRb58J1+E
         +Bw9TgrHhofkwq97ra4kvqpzkK5FNElLqzc3z5L1Ex1dnVDiig58oepDniX1N+MC7rao
         MAD/Y2oZIHG11ynT+bt3S3qG2HF910M3m5sHwCR8IYqcsJ7EcVtti28V1HbVu3kmbv9P
         pNRQ==
X-Gm-Message-State: AFqh2kqNPoVUedorWnk7ms+HcvzT2bArE9JYw88SYulYk0B0O1gobp7L
        vpgHBUUZL8gaMgrwtoQdabsXkwWXrd6Oy4K+efk=
X-Google-Smtp-Source: AMrXdXtXj88FE/8huX/4VxICXmZ8kG0DOvPXpPNTaTtzH0p0mJlsGuCeO46W5YAfYSg7oLCWNw6O7A==
X-Received: by 2002:a05:6a20:e61b:b0:af:7ed7:d370 with SMTP id my27-20020a056a20e61b00b000af7ed7d370mr48265769pzb.43.1672670704379;
        Mon, 02 Jan 2023 06:45:04 -0800 (PST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id x11-20020a63484b000000b00477a442d450sm16583503pgk.16.2023.01.02.06.45.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 06:45:03 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso18743078pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:45:03 -0800 (PST)
X-Received: by 2002:a17:902:934b:b0:191:2a9b:ec94 with SMTP id
 g11-20020a170902934b00b001912a9bec94mr2665864plp.8.1672670702971; Mon, 02 Jan
 2023 06:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20221212-uvc-race-v5-0-3db3933d1608@chromium.org> <Y7Lp9hUgF6XItA4q@pendragon.ideasonboard.com>
In-Reply-To: <Y7Lp9hUgF6XItA4q@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 2 Jan 2023 15:44:51 +0100
X-Gmail-Original-Message-ID: <CANiDSCv=X_KHFwKy-hWfVSn=EgmxirQXB3dUmGvYpE7eySL=9g@mail.gmail.com>
Message-ID: <CANiDSCv=X_KHFwKy-hWfVSn=EgmxirQXB3dUmGvYpE7eySL=9g@mail.gmail.com>
Subject: Re: [PATCH v5] media: uvcvideo: Fix race condition with usb_kill_urb
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Max Staudt <mstaudt@google.com>, linux-media@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yunke Cao <yunkec@chromium.org>
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

On Mon, 2 Jan 2023 at 15:28, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Jan 02, 2023 at 01:53:38PM +0100, Ricardo Ribalda wrote:
> > usb_kill_urb warranties that all the handlers are finished when it
> > returns, but does not protect against threads that might be handling
> > asynchronously the urb.
> >
> > For UVC, the function uvc_ctrl_status_event_async() takes care of
> > control changes asynchronously.
> >
> >  If the code is executed in the following order:
> >
> > CPU 0                                 CPU 1
> > =====                                         =====
> > uvc_status_complete()
> >                                       uvc_status_stop()
> > uvc_ctrl_status_event_work()
> >                                       uvc_status_start() -> FAIL
> >
> > Then uvc_status_start will keep failing and this error will be shown:
> >
> > <4>[    5.540139] URB 0000000000000000 submitted while active
> > drivers/usb/core/urb.c:378 usb_submit_urb+0x4c3/0x528
> >
> > Let's improve the current situation, by not re-submiting the urb if
> > we are stopping the status event. Also process the queued work
> > (if any) during stop.
> >
> > CPU 0                                 CPU 1
> > =====                                         =====
> > uvc_status_complete()
> >                                       uvc_status_stop()
> >                                       uvc_status_start()
> > uvc_ctrl_status_event_work() -> FAIL
> >
> > Hopefully, with the usb layer protection this should be enough to cover
> > all the cases.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Reviewed-by: Yunke Cao <yunkec@chromium.org>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > uvc: Fix race condition on uvc
> >
> > Make sure that all the async work is finished when we stop the status urb.
> >
> > To: Yunke Cao <yunkec@chromium.org>
> > To: Sergey Senozhatsky <senozhatsky@chromium.org>
> > To: Max Staudt <mstaudt@google.com>
> > To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > To: Mauro Carvalho Chehab <mchehab@kernel.org>
> > Cc: linux-media@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> > Changes in v5:
> > - atomic_t do not impose barriers, use smp_mb() instead. (Thanks Laurent)
> > - Add an extra cancel_work_sync().
> > - Link to v4: https://lore.kernel.org/r/20221212-uvc-race-v4-0-38d7075b03f5@chromium.org
> >
> > Changes in v4:
> > - Replace bool with atomic_t to avoid compiler reordering.
> > - First complete the async work and then kill the urb to avoid race (Thanks Laurent!)
> > - Link to v3: https://lore.kernel.org/r/20221212-uvc-race-v3-0-954efc752c9a@chromium.org
> >
> > Changes in v3:
> > - Remove the patch for dev->status, makes more sense in another series, and makes
> >   the zero day less nervous.
> > - Update reviewed-by (thanks Yunke!).
> > - Link to v2: https://lore.kernel.org/r/20221212-uvc-race-v2-0-54496cc3b8ab@chromium.org
> >
> > Changes in v2:
> > - Add a patch for not kalloc dev->status
> > - Redo the logic mechanism, so it also works with suspend (Thanks Yunke!)
> > - Link to v1: https://lore.kernel.org/r/20221212-uvc-race-v1-0-c52e1783c31d@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c   |  3 +++
> >  drivers/media/usb/uvc/uvc_status.c | 36 ++++++++++++++++++++++++++++++++++++
> >  drivers/media/usb/uvc/uvcvideo.h   |  1 +
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index c95a2229f4fa..5160facc8e20 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1442,6 +1442,9 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
> >
> >       uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
> >
> > +     if (dev->flush_status)
> > +             return;
> > +
> >       /* Resubmit the URB. */
> >       w->urb->interval = dev->int_ep->desc.bInterval;
> >       ret = usb_submit_urb(w->urb, GFP_KERNEL);
> > diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> > index 7518ffce22ed..5911e63776e1 100644
> > --- a/drivers/media/usb/uvc/uvc_status.c
> > +++ b/drivers/media/usb/uvc/uvc_status.c
> > @@ -6,6 +6,7 @@
> >   *          Laurent Pinchart (laurent.pinchart@ideasonboard.com)
> >   */
> >
> > +#include <asm/barrier.h>
> >  #include <linux/kernel.h>
> >  #include <linux/input.h>
> >  #include <linux/slab.h>
> > @@ -309,5 +310,40 @@ int uvc_status_start(struct uvc_device *dev, gfp_t flags)
> >
> >  void uvc_status_stop(struct uvc_device *dev)
> >  {
> > +     struct uvc_ctrl_work *w = &dev->async_ctrl;
> > +
> > +     /* From this point, the status urb is not re-queued */
> > +     dev->flush_status = 1;
>
> flush_status is now a bool, set it to true instead of 1. Same below for
> false instead of 0.
>
> > +     /*
> > +      * Make sure that the other CPUs are aware of the new value of
> > +      * flush_status.
> > +      */
> > +     smp_mb();
>
>         /*
>          * Prevent to asynchronous control handler from requeing the URB. The
>          * barrier is needed the flush_status change is visible to other CPUs
>          * running the asynchronous handler before usb_kill_urb() is called
>          * below.
>          */
>         dev->flush_status = true;
>         smp_mb();
>
> > +
> > +     /* If there is any status event on the queue, process it. */
> > +     if (cancel_work_sync(&w->work))
> > +             uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
> > +
> > +     /* Kill the urb. */
> >       usb_kill_urb(dev->int_urb);
> > +
> > +     /*
> > +      * If an status event was queued between cancel_work_sync() and
> > +      * usb_kill_urb(), process it.
> > +      */
>
>         /*
>          * The URB completion handler may have queued asynchronous work. This
>          * won't resubmit the URB as flush_status is set, but it needs to be
>          * cancelled before returning or it could then race with a future
>          * uvc_status_start() call.
>          */
>
> > +     if (cancel_work_sync(&w->work))
> > +             uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
>
> I think I'd still prefer checking flush_status in
> uvc_ctrl_status_event_async() and drop the event, as it would be simpler
> here. uvc_status_stop() is called when the last user indicates it's not
> interested in events anymore (by closing the device at the moment,
> possibly by unsubscribing from events in the future), so dropping the
> event isn't a problem as far as I can tell. What do you think ?

Since the user do not have direct control to when uvc_status_stop is
called, I prefer to have the second cancel_work_sync() here. That will
give us more flexibility when we rework the power saving.

Also, uvc_status_stop is done only once and not in IRQ context. the
change you propose will make the irq context bigger.... Yes I know it
is only one if, but I had to say something :P

>
> > +
> > +     /*
> > +      * From this point, there are no events on the queue and the status urb
>
> s/urb/URB/
>
> > +      * is dead, this is, no events will be queued until uvc_status_start()
> > +      * is called.
> > +      */
> > +     dev->flush_status = 0;
> > +     /*
> > +      * Write to memory the value of flush_status before uvc_status_start()
> > +      * is called again,
>
> s/,/./
>
> > +      */
> > +     smp_mb();
>
>         /*
>          * From this point, the status URB is dead, and no asynchronous work is
>          * queued. No event will be processed until uvc_status_start() is
>          * called. Reset flush_status and make it visible to the asynchronous
>          * handler before uvc_status_start() requeues the status URB.
>          */
>         dev->flush_status = 0;
>         smp_mb();
>
> The barrier here is most likely overkill given that I'd be very
> surprised if a URB could be queued, followed by a work item being
> queued, without any memory barrier, but it's good to be explicit I
> suppose :-)
>
> > +
>
> Drop the blank line.
>
> >  }
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index df93db259312..6a9b72d6789e 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -560,6 +560,7 @@ struct uvc_device {
> >       struct usb_host_endpoint *int_ep;
> >       struct urb *int_urb;
> >       u8 *status;
> > +     bool flush_status;
> >       struct input_dev *input;
> >       char input_phys[64];
> >
> >
> > ---
> > base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
> > change-id: 20221212-uvc-race-09276ea68bf8
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda
