Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCC96A1BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjBXL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBXL6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:58:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06879126DA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:58:07 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee7so38739850edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5SvRaaL3nXP8o8+09y7RyP7z+BdqnGVyC31UuwZSLB4=;
        b=fmJhu3nyDVSeySUZ2PbUE6zcmHHHERzxg5VF/SyR0hw0WaKRbkGBJMxsTX3TIzGvFx
         8E1gpn0X8An6VHls1t0+VAmdS5fOnzCA6rzOFlreAIdrcVOAlaRGwT2rDHCetSIzyuTw
         zsdcfZ0n81+UD0fT1NyG11sL/s9ePd/4bps1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SvRaaL3nXP8o8+09y7RyP7z+BdqnGVyC31UuwZSLB4=;
        b=0XRB5HZYy8a654mhlj4y3LN32oTCKZLy8u580lNRZ2qLkMjKnFRKB9S2ZN+nNo8Eik
         ay/cl8uHJXef6KF7UTswQm8D0qggt/aJcgM/8FOVlSDuXfBkAqFNKCfJ0iFE2TUgBN27
         QgRC/w3Bs92JqyFAvArn7vc8zV7I5GnwotHe8E1yW0jgv3p9AwhUegO0IxlpmJEhHyrw
         kisdfBOfD7GDouQhYP6Gd9vm/OuyOw7YxxeF9Ltm0TqAzFJyVHAzV/7waoREOKfDox1S
         /lqbrZSKsp3jprLO0FsGEby8tcr9Okw/IeBPnMyGApGj7Ei8TBD5PEq8PdsdpgU6wjC4
         2QfA==
X-Gm-Message-State: AO0yUKUjJD+bKZrJxXX/mTqcK463AoUDaUl58jsRjNUG6bdEOTGUtgbX
        E1z7/lkOSN0tQKxQKaWlvE5z/WFoyeTw9JpovsRNSsEv15Iy1I6m
X-Google-Smtp-Source: AK7set8dnBD+BRz/xrB9Os42h39GikwelmvocDp3Ir4AWUcCa7WQh0IB4rJ0xXvMqGaoFr/w+fVrMvaLHseaCuiFaVc=
X-Received: by 2002:a17:906:a96:b0:8b2:d30:e72b with SMTP id
 y22-20020a1709060a9600b008b20d30e72bmr11114020ejf.12.1677239885446; Fri, 24
 Feb 2023 03:58:05 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
 <874jrfq3jw.ffs@tglx> <CAOf5uw=+yZiTXGyjDgiw_w9yZZ5Pz3JQpykdCyFfbpNBTz+rXA@mail.gmail.com>
 <CAOf5uwmqLkFDAjQdSJF8zXHjoz1P-2-Fp1L6orRHsAa6x89EHA@mail.gmail.com> <CAOf5uwnmy=dOBhLS-AsGZ5MLcPkBDa-c63eV425sAEbms-R4Kg@mail.gmail.com>
In-Reply-To: <CAOf5uwnmy=dOBhLS-AsGZ5MLcPkBDa-c63eV425sAEbms-R4Kg@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 24 Feb 2023 12:57:54 +0100
Message-ID: <CAOf5uwnbBv-dN6cHm2t9R0ovqhAZRPV52tsR747wZnKcoeHr3Q@mail.gmail.com>
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

Drop my last email. I have made a wrong assumption, below the fix I have done

On Fri, Feb 24, 2023 at 11:32 AM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Fri, Feb 24, 2023 at 11:02 AM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi Thomas
> >
> > On Tue, Feb 21, 2023 at 8:10 AM Michael Nazzareno Trimarchi
> > <michael@amarulasolutions.com> wrote:
> > >
> > > Hi
> > >
> > > On Tue, Feb 21, 2023 at 1:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > Michael!
> > > >
> > > > On Mon, Feb 20 2023 at 22:32, Michael Nazzareno Trimarchi wrote:
> > > > > On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > >>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> > > > >> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
> > > > >>         int ret = HRTIMER_NORESTART;
> > > > >>         int restart = ALARMTIMER_NORESTART;
> > > > >>
> > > > >> +       atomic_inc(&alarmtimer_wakeup);
> > > > >> +
> >
> I have something like this
>
[snip]

Fixed now and tested on my side as below

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index b68cb7f02a6b..1f2678fe6939 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <linux/time_namespace.h>

 #include "posix-timers.h"
@@ -171,11 +172,11 @@ static void alarmtimer_dequeue(struct alarm_base
*base, struct alarm *alarm)
 {
     if (!(alarm->state & ALARMTIMER_STATE_ENQUEUED))
         return;

     timerqueue_del(&base->timerqueue, &alarm->node);
     alarm->state &= ~ALARMTIMER_STATE_ENQUEUED;
 }

+static atomic_t alarmtimer_wakeup;

 /**
  * alarmtimer_fired - Handles alarm hrtimer being fired.
@@ -194,6 +195,8 @@ static enum hrtimer_restart
alarmtimer_fired(struct hrtimer *timer)
     int ret = HRTIMER_NORESTART;
     int restart = ALARMTIMER_NORESTART;

+    atomic_inc(&alarmtimer_wakeup);
+
     spin_lock_irqsave(&base->lock, flags);
     alarmtimer_dequeue(base, alarm);
     spin_unlock_irqrestore(&base->lock, flags);
@@ -244,6 +247,16 @@ static int alarmtimer_suspend(struct device *dev)
     if (!rtc)
         return 0;

+    /*
+     * Handle wakeups which happened between the start of suspend and
+     * now as those wakeups might have tried to wake up a frozen task
+     * which means they are not longer in the alarm timer list.
+     */
+    if (atomic_read(&alarmtimer_wakeup)) {
+        pm_wakeup_event(dev, 0);
+        return -EBUSY;
+    }
+
     /* Find the soonest timer to expire*/
     for (i = 0; i < ALARM_NUMTYPE; i++) {
         struct alarm_base *base = &alarm_bases[i];
@@ -296,6 +309,33 @@ static int alarmtimer_resume(struct device *dev)
     return 0;
 }

+static int alarmtimer_pm_notifier_fn(struct notifier_block *bl,
unsigned long state,
+                                    void *unused)
+{
+    switch (state) {
+    case PM_SUSPEND_PREPARE:
+    case PM_POST_SUSPEND:
+    case PM_HIBERNATION_PREPARE:
+    case PM_POST_HIBERNATION:
+        atomic_set(&alarmtimer_wakeup, 0);
+        break;
+    }
+    return NOTIFY_DONE;
+}
+
+static struct notifier_block alarmtimer_pm_notifier = {
+       .notifier_call = alarmtimer_pm_notifier_fn,
+};
+
+static inline int alarmtimer_register_pm_notifier(void)
+{
+       return register_pm_notifier(&alarmtimer_pm_notifier);
+}
+
+static inline void alarmtimer_unregister_pm_notifier(void)
+{
+       unregister_pm_notifier(&alarmtimer_pm_notifier);
+}
 #else
 static int alarmtimer_suspend(struct device *dev)
 {
@@ -306,6 +346,15 @@ static int alarmtimer_resume(struct device *dev)
 {
     return 0;
 }
+
+static inline int alarmtimer_register_pm_notifier(void)
+{
+       return 0;
+}
+
+static inline void alarmtimer_unregister_pm_notifier(void)
+{
+}
 #endif

 static void
@@ -904,11 +953,18 @@ static int __init alarmtimer_init(void)
     if (error)
         return error;

-    error = platform_driver_register(&alarmtimer_driver);
+    error = alarmtimer_register_pm_notifier();
     if (error)
         goto out_if;

+    error = platform_driver_register(&alarmtimer_driver);
+    if (error)
+        goto out_pm;
+
     return 0;
+
+out_pm:
+    alarmtimer_unregister_pm_notifier();
 out_if:
     alarmtimer_rtc_interface_remove();
     return error;
