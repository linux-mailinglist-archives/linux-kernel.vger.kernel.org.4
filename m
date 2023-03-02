Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938CB6A8438
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjCBOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:33:03 -0500
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B466EBD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:33:02 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id i34so68356714eda.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677767580;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqzfWIN8X0b5Na4sWAfRCFtHyYByXAF636ZjKuYq3xQ=;
        b=A+CyS2j/TCW80KOicX9UyemljfpzH+YVWzEKKYSfyr1z0mmHrwFJhdsnt3HotNg8yx
         LjmYWL/UFRtqU3cUx685OYsky8pWk078qA4R9OOL2N2+0tbg9T+F8Ovve7pZ/HabJPDX
         kyf0MND/tI3HaB335cgkDdUSVSIvMJ8ClOBWscZJfj5hTOB0neiECg205Ole4L7bt/L4
         iLHRV9lfWxtLmN28TY2ZGS2tXl1g2Kxto6rwQIpE6Fqlc/0Y8Dkt4BmslXEdw5RhYEcb
         RCpvNQZNuJ/ShIgqxuwIhK0c1o/aS1RrDIIsgSgBji/7v8MxlPWEUXPNHpROQxPXl0Eb
         ncUA==
X-Gm-Message-State: AO0yUKURDlJbW92w4ysarbOW1icjOgxMmsV21MDGIM4y588tymqKY9Z3
        rh+1W4P62SJWrnKNiRBAy+0g0PVqSXv5d0y+PB4=
X-Google-Smtp-Source: AK7set8OlJ1VmVYcH9OTuALqHNHB2L/Edfu2q8/nU9Te5DcOxw86v7odHwYKac6O4J6tIZCzxit8DucSX8ZBzmzKnQk=
X-Received: by 2002:a50:cd17:0:b0:4bf:a788:1d68 with SMTP id
 z23-20020a50cd17000000b004bfa7881d68mr1765117edi.6.1677767580552; Thu, 02 Mar
 2023 06:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
In-Reply-To: <87sff0ox1a.ffs@tglx>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 2 Mar 2023 15:32:49 +0100
Message-ID: <CAJZ5v0iWZqAcbqdTuKbo35Gk6vNS0h9De20GDNZeZvqfhQiSWA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Michael!
>
> On Mon, Feb 20 2023 at 19:11, Michael Nazzareno Trimarchi wrote:
> > On Mon, Feb 20, 2023 at 6:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> [   27.349352] alarmtimer_enqueue()
> >>
> >> U: Before SUSPEND
> >>
> >> [   31.353228] PM: suspend entry (s2idle)
> >> [   31.388857] Filesystems sync: 0.033 seconds
> >> [   31.418427] Freezing user space processes
> >> [   31.422406] Freezing user space processes completed (elapsed 0.002 seconds)
> >> [   31.425435] OOM killer disabled.
> >> [   31.426833] Freezing remaining freezable tasks
> >> [   31.429838] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> >> [   31.432922] printk: Suspending console(s) (use no_console_suspend to debug)
> >> [   31.435912] alarmtimer alarmtimer.0.auto: PM: dpm_run_callback(): platform_pm_suspend+0x0/0x50 returns -16
> >> [   31.435954] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error -16
> >>
> >> That means the RTC interrupt was raised before the system was able to suspend.
> >
> > if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
> >     pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
> >     return -EBUSY;
> > }
> >
> > I think that above happens to you. So it means that you are too close
> > to this limit, can be?
>
> Maybe.
>
> > Yes but the alarm for me was set to be fired just before freezing. Is
> > this a valid scenario?
>
> Sure why not?
>
> > Let's say that I set an alarm to be fired just before the userspace
> > freeze happens. If I'm close to it then then process will not process
> > the signal to enquene again the alarm in the list and then during
> > alarm suspend the list will be empty for the above.
>
> Halfways, but slowly your explanations start to make sense. Here is the
> dmesg output you provided:
>
> > [   89.674127] PM: suspend entry (deep)
> > [   89.714916] Filesystems sync: 0.037 seconds
> > [   89.733594] Freezing user space processes
> > [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
>
> User space tasks are frozen now.
>
> > [   89.748593] OOM killer disabled.
> > [   89.752257] Freezing remaining freezable tasks
> > [   89.756807] alarmtimer_fired: called
> > [   89.756831] alarmtimer_dequeue: called <---- HERE
>
> Here fires the underlying hrtimer before devices are suspended, so the
> sig_sendqueue() cannot wake up the task because task->state ==
> TASK_FROZEN, which means the signal wont be handled and the timer wont
> be rearmed until the task is thawed.
>
> And as you correctly observed the alarmtimer_suspend() path won't see a
> pending timer anymore because it is dequeued.
>
> So precisely the time between freeze(alarmtask) and alarmtimer_suspend()
> is a gaping hole which guarantees lost wakeups.
>
> That's completely unrelated to Johns patches. That hole has been there
> forever.
>
> I assume that this horrible freezer hackery was supposed to plug that
> hole, but that gem is not solving anything as far as I understand what
> it is doing. I'm still failing to understand what it is supposed to
> solve, but that's a different story.
>
> Aside of that I can clearly reproduce the issue, now that I understand
> what you are trying to tell, on plain 6.2 without and with John's
> cleanup.
>
> Something like the below plugs the hole reliably.
>
> Thanks,
>
>         tglx
> ---
> --- a/kernel/time/alarmtimer.c
> +++ b/kernel/time/alarmtimer.c
> @@ -26,6 +26,7 @@
>  #include <linux/freezer.h>
>  #include <linux/compat.h>
>  #include <linux/module.h>
> +#include <linux/suspend.h>
>  #include <linux/time_namespace.h>
>
>  #include "posix-timers.h"
> @@ -176,6 +177,7 @@ static void alarmtimer_dequeue(struct al
>         alarm->state &= ~ALARMTIMER_STATE_ENQUEUED;
>  }
>
> +static atomic_t alarmtimer_wakeup;
>
>  /**
>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
>         int ret = HRTIMER_NORESTART;
>         int restart = ALARMTIMER_NORESTART;
>
> +       atomic_inc(&alarmtimer_wakeup);
> +

This appears to be still somewhat racy, because the notifier can run
at this point AFAICS.

>         spin_lock_irqsave(&base->lock, flags);
>         alarmtimer_dequeue(base, alarm);
>         spin_unlock_irqrestore(&base->lock, flags);
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
>         for (i = 0; i < ALARM_NUMTYPE; i++) {
>                 struct alarm_base *base = &alarm_bases[i];
> @@ -296,6 +310,31 @@ static int alarmtimer_resume(struct devi
>         return 0;
>  }
>
> +static int alarmtimer_pm_notifier_fn(struct notifier_block *bl, unsigned long state,
> +                                    void *unused)
> +{
> +       switch (state) {
> +       case PM_HIBERNATION_PREPARE:
> +       case PM_POST_HIBERNATION:
> +               atomic_set(&alarmtimer_wakeup, 0);
> +               break;
> +       }
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block alarmtimer_pm_notifier = {
> +       .notifier_call = alarmtimer_pm_notifier_fn,
> +};
> +
> +static inline int alarmtimer_register_pm_notifier(void)
> +{
> +       return register_pm_notifier(&alarmtimer_pm_notifier);
> +}
> +
> +static inline void alarmtimer_unregister_pm_notifier(void)
> +{
> +       unregister_pm_notifier(&alarmtimer_pm_notifier);
> +}
>  #else
>  static int alarmtimer_suspend(struct device *dev)
>  {
> @@ -306,6 +345,15 @@ static int alarmtimer_resume(struct devi
>  {
>         return 0;
>  }
> +
> +static inline int alarmtimer_register_pm_notifier(void)
> +{
> +       return 0;
> +}
> +
> +static inline void alarmtimer_unregister_pm_notifier(void)
> +{
> +}
>  #endif
>
>  static void
> @@ -904,11 +952,17 @@ static int __init alarmtimer_init(void)
>         if (error)
>                 return error;
>
> -       error = platform_driver_register(&alarmtimer_driver);
> +       error = alarmtimer_register_pm_notifier();
>         if (error)
>                 goto out_if;
>
> +       error = platform_driver_register(&alarmtimer_driver);
> +       if (error)
> +               goto out_pm;
> +
>         return 0;
> +out_pm:
> +       alarmtimer_unregister_pm_notifier();
>  out_if:
>         alarmtimer_rtc_interface_remove();
>         return error;
