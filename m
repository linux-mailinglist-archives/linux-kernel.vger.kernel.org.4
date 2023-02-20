Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E1069D296
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjBTSLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 13:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjBTSLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 13:11:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828B1A941
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:11:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s26so7908611edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U4yGzCvNsFvwB1+vwsCpcTwbj4gXsgxIrOhwmP5GaKA=;
        b=OpSfyN4lNGnqDhBzXdXaypGT3Glr2oO2li1HiYlIisHxWfxJXgObhFriRNPoK6c3yQ
         EusA5/A6IBInEc8mzPnyf8ZRz7gdark95KeL4jWnchzd0i6WfCYTB2Zq+tB0h0IrXDWT
         4HHr/CpNH/t9YSI7/R6CMcPN59tD65p7+Be0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4yGzCvNsFvwB1+vwsCpcTwbj4gXsgxIrOhwmP5GaKA=;
        b=iuCxmfrQ6OJ+whOIymPluz+HxJI4euBtyvpOmiOJJB5BbnkuPMcizGFUYyScLI8ZFY
         UkhsmxkxUaouzHgZYzltgj9lHJF/X214LfuuqVG15jd+AoisJbAzXu6FSIrFr7iyeHfI
         AMRisGwFJKx1HOtCkYEUDEN8zIp4hqp9AqXhOEfMroiMY1RyBruHHYO0B6I2Cr0hzGVA
         83G+3EgEO6weyWWHdVtr0xXkMNulG8lLa35Lg2RJ1fpZTO2EmH3Kk5RdpEDH9eWSieKX
         LHPF1fPj63go0qnqn66EChAnuryd4YgaGDRLBYEyR9JwoRXr9eh3vYDBImvMNOhp1G4y
         y//g==
X-Gm-Message-State: AO0yUKUQqpSP2WU5LfZgFJjB6H991WdjA0O3D/E6eXuejYnZRyrqTDQk
        xJdIla+8ity/MjM7IQP4KrEdWjrOZLeXCWMB+JuUVA==
X-Google-Smtp-Source: AK7set85vxmHPPshXmDwFIUAOygjDhA4EiqzXU7yH7qr1Zov/l0ZAQGTUsuOXryaMvmWEmTW0Bjk7DvH/g92EJZBpEI=
X-Received: by 2002:a17:906:40cc:b0:877:747d:4a82 with SMTP id
 a12-20020a17090640cc00b00877747d4a82mr4754647ejk.0.1676916703869; Mon, 20 Feb
 2023 10:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com> <87a618qlcp.ffs@tglx>
In-Reply-To: <87a618qlcp.ffs@tglx>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 20 Feb 2023 19:11:33 +0100
Message-ID: <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/2] time: alarmtimer: Use TASK_FREEZABLE to cleanup
 freezer handling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michael <michael@mipisi.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas

On Mon, Feb 20, 2023 at 6:48 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Michael!
>
> On Mon, Feb 20 2023 at 12:47, Michael Nazzareno Trimarchi wrote:
> > On Mon, Feb 20, 2023 at 9:23 AM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> >> On Mon, Feb 20, 2023 at 8:23 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> > > Starting suspend loops
> >> > > [   89.674127] PM: suspend entry (deep)
> >> > > [   89.714916] Filesystems sync: 0.037 seconds
> >> > > [   89.733594] Freezing user space processes
> >> > > [   89.740680] Freezing user space processes completed (elapsed 0.002 seconds)
> >> > > [   89.748593] OOM killer disabled.
> >> > > [   89.752257] Freezing remaining freezable tasks
> >> > > [   89.756807] alarmtimer_fired: called
> >> > > [   89.756831] alarmtimer_dequeue: called <---- HERE
> >> > >
> >> > > I have the dequeue but not an enquee of the periodic alarm. I was
> >> > > thinking that create a periodic time of 4 seconds
> >> > > and have the first alarm on suspend will always guarantee the re-arm
> >> > > it but it's not working as I expect
> >> >
> >> > Again. You are not telling what you expect. It depends on how the timer
> >> > is set up whether the timer is self rearmed or not.
> >>
> >> Posted the pseudo code. As far as I understand, the timer periodic is
> >> re-armed in get_signal do_work_pending->do_signal()->get_signal(),
> >> then in the posix timer code the enqueue_alarm is called. All the
> >> timers used from suspend are coming from the expiration list that
> >> contains only the enqueue alarm.
>
> Let me try to decode the above.
>
> Yes, periodic timers are re-armed when the signal is delivered, but that
> happens way later after the system resumed.
>
> Here is what I observe:
>
> [   27.349352] alarmtimer_enqueue()
>
> U: Before SUSPEND
>
> [   31.353228] PM: suspend entry (s2idle)
> [   31.388857] Filesystems sync: 0.033 seconds
> [   31.418427] Freezing user space processes
> [   31.422406] Freezing user space processes completed (elapsed 0.002 seconds)
> [   31.425435] OOM killer disabled.
> [   31.426833] Freezing remaining freezable tasks
> [   31.429838] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> [   31.432922] printk: Suspending console(s) (use no_console_suspend to debug)
> [   31.435912] alarmtimer alarmtimer.0.auto: PM: dpm_run_callback(): platform_pm_suspend+0x0/0x50 returns -16
> [   31.435954] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error -16
>
> That means the RTC interrupt was raised before the system was able to suspend.

if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
    pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
    return -EBUSY;
}

I think that above happens to you. So it means that you are too close
to this limit, can be?
Yes but the alarm for me was set to be fired just before freezing. Is
this a valid scenario? I can retest on 6.2

Let's say that I set an alarm to be fired just before the userspace
freeze happens. If I'm close to
it then then process will not process the signal to enquene again the
alarm in the list and then during
alarm suspend the list will be empty for the above.

So your suggestion is that something is wrong with my environment so I
will do the same on top of 6.2

Michael

>
> [   31.436077] PM: Some devices failed to suspend, or early wake event detected
> [   31.444270] OOM killer enabled.
> [   31.445011] Restarting tasks ... done.
> [   31.446820] random: crng reseeded on system resumption
> [   31.466019] PM: suspend exit
>
> [   31.480283] alarmtimer_fired()
> [   31.481403] alarmtimer_dequeue()     <- Signal queued
>
> [   31.482596] alarmtimer_rearm()_      <- Signal delivery
> [   31.483713] alarmtimer_enqueue()
>
> U: ALRM signal received                 <- User space signal handler
> U: Post Suspend                         <- system("echo .... >") returns
>
> That's 6.2 + John's patches.
>
> Thanks,
>
>         tglx
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
