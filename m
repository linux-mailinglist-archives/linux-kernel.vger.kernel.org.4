Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F09269D5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 22:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjBTVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 16:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBTVc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 16:32:28 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3471EFF1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:32:26 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g1so9333695edz.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8DpIajKBKqdM6BAHr+F/ejKJz9S/FK/QHygyITJ+5L4=;
        b=iOWxe2omg/0+kMvp/NoOq6MegsZYkL0TuoUVhCS/BO1pHQpG0juipnI4qI7SLXQmXf
         NghUY4Mt+v8h3yHLH/toHSqYWHGWb0VPapRkp6iEev8VKppSkdk1GBFaQZlVJdcPgcFk
         ASRJutBspE76ZwS6apTVEhqmo52Zr1r7IDk/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DpIajKBKqdM6BAHr+F/ejKJz9S/FK/QHygyITJ+5L4=;
        b=tedMFRAFxlgMqO0OmQfs38EmunMoM/WnfCta5ga6kJB8wLIpJmjbDTJnYyzXPDqhj0
         NLYNIHY3LfUFU3+5Q3UmEG3F8v4je7UcXuVonl3qpy2vva5UhlyLtgEHzNUuuUBSbQw5
         XNi2MJSeUsQ4eqOLZqKr5uokHH8lj48JiwYhVZuKgQQxBhqKy0as9M2XWwvPC0Im8pw2
         tEipd8G/AhTfBtixaTc1cGA6KGVkLuJ1upF04Mfv704t4nH4EErl6xmR1FgoLpHq5N5q
         PXVT4ZFfyxOExZ7uCa64AQqRHh+ms/DkqrDdaa8ZRduRgymkVi8FlRSjd6a1mmFx32vN
         LM2g==
X-Gm-Message-State: AO0yUKUNpp6KmKii8ufZZxBmWOgOuXf7T2qQoyTBFxy65ugRhI+wbCOy
        FRR0D7Ab+DiqxDqsPz5BQU0TYispT2JOJgp1BVLtAA==
X-Google-Smtp-Source: AK7set9B7N1QUL4k3i0quivAHUtGwZmbVOgPNO95SpwJLJheM5+aE24p9zzQn03WzGAzXglWyAYaNyKH4YOZrUqFHD4=
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr4990853ejk.0.1676928744693; Mon, 20 Feb
 2023 13:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx>
In-Reply-To: <87sff0ox1a.ffs@tglx>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 20 Feb 2023 22:32:13 +0100
Message-ID: <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
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

That was clear, but I was trying to test the race here.

> I assume that this horrible freezer hackery was supposed to plug that
> hole, but that gem is not solving anything as far as I understand what
> it is doing. I'm still failing to understand what it is supposed to
> solve, but that's a different story.
>

Yes, cleaning up was good.

> Aside of that I can clearly reproduce the issue, now that I understand
> what you are trying to tell, on plain 6.2 without and with John's
> cleanup.
>
> Something like the below plugs the hole reliably.
>

Some comments below

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

       ptr->it_active = 0;
        if (ptr->it_interval) {
                atomic_inc(&alarmtimer_wakeup);
                si_private = ++ptr->it_requeue_pending;
        }

Should I not go to the alarm_handle_timer? and only if it's a periodic one?

Michael

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
>
>
>
>
>
>
>
>


-- 
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
