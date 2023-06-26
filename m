Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC4C73E3EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjFZPvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjFZPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:51:16 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ADC1727
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:50:59 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-443512ad63cso526528137.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687794658; x=1690386658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKSMwoNCFJqjhmNluRcqz1rlJy8ndbz7M9biXkRY1fE=;
        b=Ex+NLXbugBxxE91biOqab0q5+oecC02Mju3FVcPa80ajjv1CKbGXaMbQoJzw48I8MM
         eci7nixWbzL81lY3MPfiEDI0DkNa5VaEWq5N7k/GtpyhrvGO0bllDrSjZbww4wTTAOma
         63aSBwMlMvqgRKl/fWAbJjmBY83CIadtUdCxG8NDlKN1RTHFZjXL00BUtxpvHTz3+AU9
         pnVU+41VCXVkPhJK8pzHLXD80QfYz1QoGDC18G0bsSYFnMlvkf7/wJJfvL8Knz/wTXyc
         W+19acEP5HE+KqwieRvHRyEdwQ0TQLBmwjgk3Zf0Hht/LLYSwoP6SfdX7g09HhRs8mGw
         wKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687794658; x=1690386658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cKSMwoNCFJqjhmNluRcqz1rlJy8ndbz7M9biXkRY1fE=;
        b=QctfomxxYQzd1Wq31XiE7c8V74CUeEYsup/DhcEazockLYicuyB5fUJ8L0diNm5rd/
         /VLwkCUXcvQCDxQS9Q/J42Z91y98kmslEE9RPATLSQbFhE5jzuf0IY4o6CP72JOxVWU6
         yyaSklbOEBU+PFD8imoy/qg2nSCPr0wDduCBT2fNmWq319hzsd3JN6E34/K6SfAeLxQl
         61he3wbuoEksUpGbB+EJS6Quqyw0dEZKFkwHLzObO5gcCnX5ms/0Aax02e/pVzfzx6pt
         n5hmP3djfOI10nGzQN3ws3KThxIT/UbAMKZlFPeopVd3qQaVYRaEbJkroDxIdcKlPvRQ
         EAWw==
X-Gm-Message-State: AC+VfDzi/XIqILkGsxReXRg7pPgzMQYAMNeIGfI/Oc8SKuhLnUvTCNHn
        vD4sxAk1zUxHJvNqEl9AlT82ltME7dQRVEoDNPKDoA==
X-Google-Smtp-Source: ACHHUZ7sbALJnuPT/qEi+APw9K7W8y4dUHupQU1VLcTriiizK9lQv2HLZWF/wjLWtNF3CVHDmyPrgrt2gsXx+smB5tM=
X-Received: by 2002:a67:ea8c:0:b0:43f:3f51:b804 with SMTP id
 f12-20020a67ea8c000000b0043f3f51b804mr12858094vso.32.1687794658337; Mon, 26
 Jun 2023 08:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <TYCP286MB1188B6A0379F7928C63288DF8A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
 <ZJk87rWsDj7pWJIP@sol>
In-Reply-To: <ZJk87rWsDj7pWJIP@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 26 Jun 2023 17:50:47 +0200
Message-ID: <CAMRc=McGOV+A8ROXRinUkWG0POTe37RWphRHDW6sy7UMU-e2UA@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpiolib-cdev: Fix potential &lr->wait.lock deadlock issue
To:     Kent Gibson <warthog618@gmail.com>
Cc:     YE Chengfeng <cyeaa@connect.ust.hk>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "andy@kernel.org" <andy@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 9:23=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Sun, Jun 25, 2023 at 02:45:12PM +0000, YE Chengfeng wrote:
> > linereq_put_event is called from both interrupt context (e.g.,
> > edge_irq_thread) and process context (process_hw_ts_thread).
> > Therefore, interrupt should be disabled before acquiring lock
> > &lr->wait.lock inside linereq_put_event to avoid deadlock when
> > the lock is held in process context and edge_irq_thread comes.
> >
> > Similarly, linereq_read_unlocked running in process context
> > also acquies the same lock. It also need to disable interrupt
> > otherwise deadlock could happen if the irq edge_irq_thread
> > comes to execution while the lock is held.
> >
>
> So, in both cases, a process context holding the lock is interrupted, on
> the same CPU, and the edge_irq_thread() deadlocks on that lock, as the
> interrupted process holds the lock and cannot proceed.
> That makes sense to me, but it would be good for Bart to confirm as he
> knows a lot more about the kfifo locking than I do.
>

Yeah, I'm not sure this is correct. edge_irq_thread() runs in process
context, so the whole premise of the patch seems to be flawed. What
tool reported this? Can this be a false positive? Have you seen this
happen in real life?

> Note that the same problem also exists in lineevent_read_unlocked() - the
> uAPI v1 equivalent of linereq_read_unlocked().
>
> > Fix the two potential deadlock issues by spin_lock_irqsave.
> >
>
> spin_lock_bh() should be sufficient, given that edge_irq_thread() is run
> in a softirq?  That is faster and would allow the hard irq handlers to
> still run, and timestamp the event, but inhibit the edge_irq_thread()
> from being called on that CPU until the lock is released.
> (hmmm, gpio_desc_to_lineinfo() also uses spin_lock_irqsave() but it is
> never called from hard irq context, so there is a good chance I'm missing
> something here??)
> More on spin_lock choice below.

Again: this is incorrect - edge_irq_thread() doesn't execute in
softirq context which can be verified by calling in_softirq() from it.

>
> This should have a Fixes tag.
> For v2, it has been there since it was added, so:
>
> 73e0341992b6 ("gpiolib: cdev: support edge detection for uAPI v2")
>
> And it also applies to lineevent_read_unlocked() from uAPI v1, so there
> should be a separate fix for that, or at least a separate tag.
>
> I looks to me that it was first introduced in uAPI v1 here:
>
> dea9c80ee672 ("gpiolib: rework the locking mechanism for lineevent kfifo"=
)
>
> > Signed-off-by: Chengfeng Ye <cyeaa@connect.ust.hk>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index 0a33971c964c..714631fde9a8 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -614,14 +614,15 @@ static void linereq_put_event(struct linereq *lr,
> >                             struct gpio_v2_line_event *le)
> >  {
> >       bool overflow =3D false;
> > +     unsigned long flags;
> >
> > -     spin_lock(&lr->wait.lock);
> > +     spin_lock_irqsave(&lr->wait.lock, flags);
>
> linereq_put_event() is never called from hard irq context, so
> spin_lock_irq() or spin_lock_bh() should suffice?
>

AFAICT it is only ever called from process context and so spin_lock()
is correct here.

Bart

> >       if (kfifo_is_full(&lr->events)) {
> >               overflow =3D true;
> >               kfifo_skip(&lr->events);
> >       }
> >       kfifo_in(&lr->events, le, 1);
> > -     spin_unlock(&lr->wait.lock);
> > +     spin_unlock_irqrestore(&lr->wait.lock, flags);
> >       if (!overflow)
> >               wake_up_poll(&lr->wait, EPOLLIN);
> >       else
> > @@ -1505,6 +1506,7 @@ static ssize_t linereq_read_unlocked(struct file =
*file, char __user *buf,
> >       struct linereq *lr =3D file->private_data;
> >       struct gpio_v2_line_event le;
> >       ssize_t bytes_read =3D 0;
> > +     unsigned long flags;
> >       int ret;
> >
> >       if (!lr->gdev->chip)
> > @@ -1514,28 +1516,28 @@ static ssize_t linereq_read_unlocked(struct fil=
e *file, char __user *buf,
> >               return -EINVAL;
> >
> >       do {
> > -             spin_lock(&lr->wait.lock);
> > +             spin_lock_irqsave(&lr->wait.lock, flags);
>
> linereq_read_unlocked() is only ever called in process context, so this
> could be spin_lock_irq() or even spin_lock_bh()?
>
> >               if (kfifo_is_empty(&lr->events)) {
> >                       if (bytes_read) {
> > -                             spin_unlock(&lr->wait.lock);
> > +                             spin_unlock_irqrestore(&lr->wait.lock, fl=
ags);
> >                               return bytes_read;
> >                       }
> >
> >                       if (file->f_flags & O_NONBLOCK) {
> > -                             spin_unlock(&lr->wait.lock);
> > +                             spin_unlock_irqrestore(&lr->wait.lock, fl=
ags);
> >                               return -EAGAIN;
> >                       }
> >
> >                       ret =3D wait_event_interruptible_locked(lr->wait,
> >                                       !kfifo_is_empty(&lr->events));
>
> wait_event_interruptible_locked() works with locks that are
> spin_lock()/spin_unlock(), so this will leave irqs disabled while
> waiting for a new event??
>
> And while there is a wait_event_interruptible_locked_irq(), there is
> no wait_event_interruptible_locked_bh() form that I can see, so using
> spin_lock_bh() would require some extra work.
>
> >                       if (ret) {
> > -                             spin_unlock(&lr->wait.lock);
> > +                             spin_unlock_irqrestore(&lr->wait.lock, fl=
ags);
> >                               return ret;
> >                       }
> >               }
> >
> >               ret =3D kfifo_out(&lr->events, &le, 1);
> > -             spin_unlock(&lr->wait.lock);
> > +             spin_unlock_irqrestore(&lr->wait.lock, flags);
> >               if (ret !=3D 1) {
> >                       /*
> >                        * This should never happen - we were holding the
> > --
> > 2.17.1
>
> Anyway, good catch.
>
> Cheers,
> Kent.
