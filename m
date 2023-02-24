Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DFE6A1A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBXKe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBXKdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:33:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BF916307
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:32:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id da10so54241618edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VgMFdC6ibbZOtd9fIoLXBHhH0VUtRIb+6ju7RO2fD7Y=;
        b=PdrtKogBI4MK7bvpvoBxKz02S1hTzPtvSVVy6fz+GtgRHpJDCqMDbIzG7BGlRI0TgO
         iZbrpC8ozYXSvaa0OTn56b7xgSqmn/kcrJxGZ3gwvOYhVDdX1yFr/4FfCnR9yC7m77oq
         0h8x35WPbgkeImLdke1XZkfKwrJTGmVzGHKc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgMFdC6ibbZOtd9fIoLXBHhH0VUtRIb+6ju7RO2fD7Y=;
        b=McmyEg6sJMsyH9Kk0y49XTNSCFwHkybhTghkhuCptpSJPXYARSvycuh71vfnxBuH3x
         awObfboR/qr9KJZ086D0m0UiUy0MtlIQR/4JwdDNvHSmwZHPqskSaTinxW5UCtL03yh8
         9gj8LjWoACgUZWndQWz9y2efb+1mk1aj7XfXBvmrqoYqqk19zQnCi7gBAHxmWp/7fUCD
         daae6rZONeoujCRMDXVa63lmfLXiaVQHcQ6/wTueVefMjdYQKhxWlvXqUu1HQKwHo8jr
         Mv/wo0B+TKRbBQ+8yxkey8Yhnulrimi12Imkxd6eaiesZQT+pF6ZL1myiQCY4jYdbWua
         i6OQ==
X-Gm-Message-State: AO0yUKU+ifZS5H7SHwdyZQS6f1QojGmEoIVYkWWZ3ATfeS/yPyNBhb+6
        rPyAa5AyTWHS0iFgam0kEA0v9pEPA1Xs9F6jJDWKog==
X-Google-Smtp-Source: AK7set94j2EgusYDIPFJpqlmZAE2h9JOS6PK3HKmO/GVyY/Ntoao0ZditMYj3Sh007jQx2hxudE5Fe41xltbBFtRcbA=
X-Received: by 2002:a17:906:a04f:b0:8f1:4c6a:e77 with SMTP id
 bg15-20020a170906a04f00b008f14c6a0e77mr1886839ejb.12.1677234742696; Fri, 24
 Feb 2023 02:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20230211064527.3481754-1-jstultz@google.com> <20230211064527.3481754-2-jstultz@google.com>
 <CAOf5uwnW1u=nfFnj3C8kCVmhgwRaVh6sHZR1RGnXdbrCNpkGVg@mail.gmail.com>
 <87o7porea9.ffs@tglx> <CAOf5uwmhtQ8GXhMiE-Y3-wgL5=xfjOv0Tpq1vqPB8p=LyZHBmw@mail.gmail.com>
 <CAOf5uwmpayJwpAFzUS6qsCgdpyek1f-2t2t9YNr76vnRjSC8=w@mail.gmail.com>
 <87a618qlcp.ffs@tglx> <CAOf5uw=a2RYYFj+4_WOX+KaF_FCXSsUgfM+T2m2XjVuqKMdooA@mail.gmail.com>
 <87sff0ox1a.ffs@tglx> <CAOf5uwmZWZij1tKUFUWKSKqyph4OYe6C3HdA8TQtrB7ztOdC-A@mail.gmail.com>
 <874jrfq3jw.ffs@tglx> <CAOf5uw=+yZiTXGyjDgiw_w9yZZ5Pz3JQpykdCyFfbpNBTz+rXA@mail.gmail.com>
 <CAOf5uwmqLkFDAjQdSJF8zXHjoz1P-2-Fp1L6orRHsAa6x89EHA@mail.gmail.com>
In-Reply-To: <CAOf5uwmqLkFDAjQdSJF8zXHjoz1P-2-Fp1L6orRHsAa6x89EHA@mail.gmail.com>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Fri, 24 Feb 2023 11:32:11 +0100
Message-ID: <CAOf5uwnmy=dOBhLS-AsGZ5MLcPkBDa-c63eV425sAEbms-R4Kg@mail.gmail.com>
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

On Fri, Feb 24, 2023 at 11:02 AM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Thomas
>
> On Tue, Feb 21, 2023 at 8:10 AM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > On Tue, Feb 21, 2023 at 1:12 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > Michael!
> > >
> > > On Mon, Feb 20 2023 at 22:32, Michael Nazzareno Trimarchi wrote:
> > > > On Mon, Feb 20, 2023 at 10:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >>   * alarmtimer_fired - Handles alarm hrtimer being fired.
> > > >> @@ -194,6 +196,8 @@ static enum hrtimer_restart alarmtimer_f
> > > >>         int ret = HRTIMER_NORESTART;
> > > >>         int restart = ALARMTIMER_NORESTART;
> > > >>
> > > >> +       atomic_inc(&alarmtimer_wakeup);
> > > >> +
> > > >
> > > >        ptr->it_active = 0;
> > > >         if (ptr->it_interval) {
> > > >                 atomic_inc(&alarmtimer_wakeup);
> > > >                 si_private = ++ptr->it_requeue_pending;
> > > >         }
> > > >
> > > > Should I not go to the alarm_handle_timer? and only if it's a periodic
> > > > one?
> > >
> > > Why?
> > >
> >
> > You are right. I will pay more attention to my reply.
> >
>
> I get time to test it and if the system suspend to ram we need to catch:
>
> case PM_SUSPEND_PREPARE:
> case PM_POST_SUSPEND:
>
> Michael
>
> > Michael
> >
> > > Any alarmtimer which hits that window has exactly the same problem.
> > >
> > > It's not restricted to periodic timers. Why would a dropped one-shot
> > > wakeup be acceptable?
> > >
> > > It's neither restricted to posix timers. If a clock_nanosleep(ALARM)
> > > expires in that window then the task wake up will just end up in the
> > > /dev/null bucket for the very same reason. Why would this be correct?
> > >
> > > Hmm?
> > >
> > > <GRMBL>
> > > > Michael
> > > >
> > > >>         spin_lock_irqsave(&base->lock, flags);
> > >
[snip]

I have something like this

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index b68cb7f02a6b..b5f15e7f76cb 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -26,6 +26,7 @@
 #include <linux/freezer.h>
 #include <linux/compat.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <linux/time_namespace.h>

 #include "posix-timers.h"
@@ -176,6 +177,7 @@ static void alarmtimer_dequeue(struct alarm_base
*base, struct alarm *alarm)
     alarm->state &= ~ALARMTIMER_STATE_ENQUEUED;
 }

+static atomic_t alarmtimer_wakeup;

 /**
  * alarmtimer_fired - Handles alarm hrtimer being fired.
@@ -194,6 +196,8 @@ static enum hrtimer_restart
alarmtimer_fired(struct hrtimer *timer)
     int ret = HRTIMER_NORESTART;
     int restart = ALARMTIMER_NORESTART;

+    atomic_inc(&alarmtimer_wakeup);
+
     spin_lock_irqsave(&base->lock, flags);
     alarmtimer_dequeue(base, alarm);
     spin_unlock_irqrestore(&base->lock, flags);
@@ -263,8 +267,18 @@ static int alarmtimer_suspend(struct device *dev)
         }
     }
     /* No timers to expire */
-    if (min == KTIME_MAX)
+    if (min == KTIME_MAX) {
+        /*
+         * Handle wakeups which happened between the start of suspend and
+         * now as those wakeups might have tried to wake up a frozen task
+         * which means they are no longer in the alarm timer list.
+         */
+        if (atomic_read(&alarmtimer_wakeup)) {
+            pm_wakeup_event(dev, 0);
+            return -EBUSY;
+        }
         return 0;
+    }

     if (ktime_to_ns(min) < 2 * NSEC_PER_SEC) {
         pm_wakeup_event(dev, 2 * MSEC_PER_SEC);
@@ -296,6 +310,30 @@ static int alarmtimer_resume(struct device *dev)
     return 0;
 }

+static int alarmtimer_pm_notifier_fn(struct notifier_block *bl,
unsigned long state,
+                                    void *unused)
+{
+    switch (state) {
+    case PM_POST_SUSPEND:
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
@@ -306,6 +344,15 @@ static int alarmtimer_resume(struct device *dev)
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
@@ -904,11 +951,18 @@ static int __init alarmtimer_init(void)
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
