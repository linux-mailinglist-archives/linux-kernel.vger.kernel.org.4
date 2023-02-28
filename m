Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AE86A4FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjB1ADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjB1ADt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:03:49 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCF113C8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:03:47 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536bf92b55cso223828687b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 16:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eoaqg4+/L2h1X7Nq8q9yhqhl+2vlL6TXu7FeEp44rJc=;
        b=V3+cBagi3uuAMPC9rj2QhaRHurjKRovwZKjd2GBt8Lv9bLLWJ28Vxqcc9Mzeym9L07
         h79ZqjVwC4p/QVreAriN7e149Db+cU0v41QMGyuM22AiFWigc8oWht1seGBZmNXYlT3R
         yxqJOCwiDo9Q0zaXwIhxfcniZlGppgZE5TwuY1Yy1qKb467mq9fgGdko+nQss++6C0cM
         J26FWrUKlAKfHEG1w1YuGVWIUX+8f6iCURo7P0u0yR7HU7j+jHFXWghm2KZ8+wigZDL0
         5a2PdBaMviAGYmvuae4T6rmQ1UhKMLEUUgf+3/3sRsIuGgscHcjTuS4W+rzkj27VPCGu
         tRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eoaqg4+/L2h1X7Nq8q9yhqhl+2vlL6TXu7FeEp44rJc=;
        b=FfcUDAyxUn5JJ3pMHhfVbVXA7hgCxEW7bGtf+HxuFpdVOppucdyNaM2l4o/aqkcTYj
         UuohPOUszIfh7iFs/71t4S03OP2MOiQIiGG1EKe51u7//hZa7OdT53Zl0e5N1KUcI4fB
         9eM1WSeVfjhnoW7cZrP4Jmmk8qH01iCKanoD6XWm6WOlkcZrmNyAXFWCl25yvZXB3xJG
         4RktjWgOaWMnUoQZCzG5Yo+hcmVcOsHMhzoI07lMUQSUc9dOUbEB7XdUhOfdO1nZAMjA
         qGc7atsTi0h5dHwsf+VLmsoQq29yPfPmVU9UskHZZ7M6HR058eccRis4oGhIQioq7Wps
         fksA==
X-Gm-Message-State: AO0yUKUBegdAcKz/TDFH3N2AK8/lhOFiJtvbtN/ai9hsYoFI2STRikGX
        j/C1IS3u1JLhFigbEq6rjA+2UAu5QCWzU/UI8Mo/NPeSHDCNssb/+Q==
X-Google-Smtp-Source: AK7set9ygvzzz1jHLTW2rU9pZJNZ+2r3KNFUZ0Tu5IHO2c+6YYDiXrE5qR2Iyg7xTOKVTEmnlXtnRnNnYcOTQuBs6BM=
X-Received: by 2002:a81:ae0e:0:b0:534:7429:2eb4 with SMTP id
 m14-20020a81ae0e000000b0053474292eb4mr338764ywh.3.1677542626760; Mon, 27 Feb
 2023 16:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
In-Reply-To: <87sff0ox1a.ffs@tglx>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 27 Feb 2023 16:03:36 -0800
Message-ID: <CANDhNCrfoiz1WdTs+5B8y+TVv8cn4_J-770=bsPqC9Xe=j14hA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 1:18=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
> On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > [   89.674127] PM: suspend entry (deep)
> > [   89.714916] Filesystems sync: 0.037 seconds
> > [   89.733594] Freezing user space processes
> > [   89.740680] Freezing user space processes completed (elapsed 0.002 s=
econds)
>
> User space tasks are frozen now.
>
> > [   89.748593] OOM killer disabled.
> > [   89.752257] Freezing remaining freezable tasks
> > [   89.756807] alarmtimer_fired: called
> > [   89.756831] alarmtimer_dequeue: called <---- HERE
>
> Here fires the underlying hrtimer before devices are suspended, so the
> sig_sendqueue() cannot wake up the task because task->state =3D=3D
> TASK_FROZEN, which means the signal wont be handled and the timer wont
> be rearmed until the task is thawed.
>
> And as you correctly observed the alarmtimer_suspend() path won't see a
> pending timer anymore because it is dequeued.
>
> So precisely the time between freeze(alarmtask) and alarmtimer_suspend()
> is a gaping hole which guarantees lost wakeups.
>

Hey Michael, Thomas,
 Sorry for being a little slow to respond the last few weeks. :(

So I've managed to reproduce the issue following Michael's
instructions and your analysis, Thomas, looks right!

Though I'm a bit confused on the suggested solution:


> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
>         int ret =3D HRTIMER_NORESTART;
>         int restart =3D ALARMTIMER_NORESTART;
>
> +       atomic_inc(&alarmtimer_wakeup);
> +
>         spin_lock_irqsave(&base->lock, flags);
>         alarmtimer_dequeue(base, alarm);
>         spin_unlock_irqrestore(&base->lock, flags);

Ok, so here we're incrementing the wakeup counter for each
alarmtimer_fired call.

> @@ -244,6 +248,16 @@ static int alarmtimer_suspend(struct dev
>         if (!rtc)
>                 return 0;
>
> +       /*
> +        * Handle wakeups which happened between the start of suspend and
> +        * now as those wakeups might have tried to wake up a frozen task
> +        * which means they are not longer in the alarm timer list.
> +        */
> +       if (atomic_read(&alarmtimer_wakeup)) {
> +               pm_wakeup_event(dev, 0);
> +               return -EBUSY;
> +       }
> +
>         /* Find the soonest timer to expire*/
>         for (i =3D 0; i < ALARM_NUMTYPE; i++) {
>                 struct alarm_base *base =3D &alarm_bases[i];

And here we're bailing on alarmtimer_suspend if an alarmtimer_fired
happened recently.  Still looks okish.


> +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsigned=
 long state,
> +                                    void *unused)
> +{
> +       switch (state) {
> +       case PM_HIBERNATION_PREPARE:
> +       case PM_POST_HIBERNATION:
> +               atomic_set(&alarmtimer_wakeup, 0);
> +               break;
> +       }
> +       return NOTIFY_DONE;

But here, we're setting the alarmtimer_wakeup count to zero if we get
PM_HIBERNATION_PREPARE or  PM_POST_HIBERNATION notifications?
And Michael noted we need to add  PM_SUSPEND_PREPARE and
PM_POST_SUSPEND there for this to seemingly work.

This zeroing out the counter here feels a little sloppy, as it seems
nothing prevents the notifier from racing with the other added logic.

If the issue is that when we're expiring timers in alarmtimer_fire(),
a suspend event may come in midway after the alarmtimer_dequeue(),
while the timer is running but before the alarmtimer_enqueue(),
causing recurring timers to not be re-armed, it seems we probably
should do the accounting fully in alarmtimer_fire(), doing an
atomic_dec(&alarmtimer_wakeup) at the end of that function.  That way
we avoid suspending while running an alarmtimer, so the recurring
timers will always be back on the timer list when we do suspend.

This sort of has a risk that if there's timers that run for too long,
you'd prevent suspend for that period, but we already avoid suspending
if there's a alarmtimer within two seconds in the future, so having
alarmtimers recur quickly is inherently going to prevent you from
suspending.

I'll send out a reworked patch here in a moment after I validate it as work=
ing.

thanks
-john
