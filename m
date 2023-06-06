Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E74672465A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbjFFOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjFFOhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11861706
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:34 -0700 (PDT)
Message-ID: <20230606142031.532247561@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2mlrLNBzpK9wpMz36KzO779P+Hz9+q0V8boLAVqB0tk=;
        b=CJ8WvJz92LOksqzWChyCdQgegHuA0iI3APF+UbZhF4QTEWI16R6Zi1n2EtGAEhAxFgoWpJ
        2IhuE+b5XAhpZg7ZVSz8T8FGoUAYr4iIoPtW3zaHAWtOc6KHuETgfoIDai0N8rWfxqjbhU
        OFL1WyXZZuX0SiBvAy/0daSoqx7caiDZLTGQOwhOJebvQkfHQDkpukEZnHVAo+QfJCof8f
        lDnuydDPUcN+YHK6UNRLZ3zf4iff7iraJyNVf+Jhnj4mJWYCNaE1lCBjn+SqVpZFrdRodF
        5ewoilq02tbaXMHgi/2snlkBwR6zKEHT1chfANfqXoGu3PI1R2Z77g2CXBMK2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2mlrLNBzpK9wpMz36KzO779P+Hz9+q0V8boLAVqB0tk=;
        b=+c+DRtc+oNbJkpTeMlItVZc5M7N1nViAElD/CWYyRFb4rkkQD6yPHkUaB2xaaSn3fF6hR6
        Rm3g9gbP3GROP+Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 09/45] posix-cpu-timers: Fix posix_cpu_timer_get() behaviour
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:33 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timer_gettime() must return the remaining time to the next expiry of a
timer or 0 if the timer is not armed and no signal pending.

This has to be correct also for interval timers even if the signal is
pending or the timer has been created with SIGEV_NONE.

The posix CPU timer implementation fails for both cases as it does not
forward the timer in posix_cpu_timer_get() before calculating the expiry
time.

It neither clears the expiry value when a oneshot SIGEV_NONE timer expired
and returns 1nsec instead, which is only correct for timers with signals
when the signal delivery did not happen yet.

Aside of that posix_cpu_timer_set() pointlessly arms SIGEV_NONE timers
which are later disarmed when the initial expiry happens. That's bogus and
just keeping the process wide timer active for nothing.

Cure this by:

     1) Avoiding to arm SIGEV_NONE timers

     2) Forwarding interval timers in posix_cpu_timer_get()

     3) Taking SIGEV_NONE into account when a oneshot timer has expired

Make the update logic a separate function so it can be reused to simplify
posix_cpu_timer_set().

Fixes: ae1a78eecc45 ("cpu-timers: Return correct previous timer reload value")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   96 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 42 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -584,12 +584,7 @@ static void cpu_timer_fire(struct k_itim
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 
-	if ((timer->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
-		/*
-		 * User don't want any signal.
-		 */
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (unlikely(timer->sigq == NULL)) {
+	if (unlikely(timer->sigq == NULL)) {
 		/*
 		 * This a special case for clock_nanosleep,
 		 * not a normal timer from sys_timer_create.
@@ -623,6 +618,7 @@ static void cpu_timer_fire(struct k_itim
 static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 			       struct itimerspec64 *new, struct itimerspec64 *old)
 {
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
 	u64 old_expires, new_expires, old_incr, val;
 	struct cpu_timer *ctmr = &timer->it.cpu;
@@ -686,7 +682,7 @@ static int posix_cpu_timer_set(struct k_
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		val = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, true);
+		val = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	if (old) {
 		if (old_expires == 0) {
@@ -723,19 +719,20 @@ static int posix_cpu_timer_set(struct k_
 		goto out;
 	}
 
-	if (new_expires != 0 && !(timer_flags & TIMER_ABSTIME)) {
+	/* Convert relative expiry time to absolute */
+	if (new_expires && !(timer_flags & TIMER_ABSTIME))
 		new_expires += val;
-	}
+
+	/* Set the new expiry time (might be 0) */
+	cpu_timer_setexpires(ctmr, new_expires);
 
 	/*
-	 * Install the new expiry time (or zero).
-	 * For a timer with no notification action, we don't actually
-	 * arm the timer (we'll just fake it for timer_gettime).
+	 * Arm the timer if it is not disabled, the new expiry value has
+	 * not yet expired and the timer requires signal delivery.
+	 * SIGEV_NONE timers are never armed.
 	 */
-	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires != 0 && val < new_expires) {
+	if (!sigev_none && new_expires && val < new_expires)
 		arm_timer(timer, p);
-	}
 
 	unlock_task_sighand(p, &flags);
 	/*
@@ -754,7 +751,7 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (val >= new_expires) {
+	if (!sigev_none && val >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify
@@ -785,45 +782,60 @@ static int posix_cpu_timer_set(struct k_
 	return ret;
 }
 
-static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+static void __posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp, u64 now)
 {
-	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	struct cpu_timer *ctmr = &timer->it.cpu;
-	u64 now, expires = cpu_timer_getexpires(ctmr);
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = cpu_timer_task_rcu(timer);
-	if (!p)
-		goto out;
+	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
+	u64 expires;
 
 	/*
-	 * Easy part: convert the reload time.
+	 * Make sure that interval timers are moved forward for the
+	 * following cases:
+	 *  - SIGEV_NONE timers which are never armed
+	 *  - Timers which expired, but the signal has not yet been
+	 *    delivered
 	 */
-	itp->it_interval = ktime_to_timespec64(timer->it_interval);
-
-	if (!expires)
-		goto out;
+	expires = bump_cpu_timer(timer, now);
 
 	/*
-	 * Sample the clock to take the difference with the expiry time.
+	 * Interval timers cannot have a remaining time <= 0 because the
+	 * forwarding guarantees to move them forward so that the next
+	 * timer expiry is > @now.
 	 */
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		now = cpu_clock_sample(clkid, p);
-	else
-		now = cpu_clock_sample_group(clkid, p, false);
-
 	if (now < expires) {
 		itp->it_value = ns_to_timespec64(expires - now);
 	} else {
 		/*
-		 * The timer should have expired already, but the firing
-		 * hasn't taken place yet.  Say it's just about to expire.
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
-		itp->it_value.tv_nsec = 1;
-		itp->it_value.tv_sec = 0;
+		if (!sigev_none)
+			itp->it_value.tv_nsec = 1;
+	}
+}
+
+static void posix_cpu_timer_get(struct k_itimer *timer, struct itimerspec64 *itp)
+{
+	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
+	struct cpu_timer *ctmr = &timer->it.cpu;
+	struct task_struct *p;
+	u64 now;
+
+	rcu_read_lock();
+	p = cpu_timer_task_rcu(timer);
+	if (p) {
+		itp->it_interval = ktime_to_timespec64(timer->it_interval);
+
+		if (cpu_timer_getexpires(ctmr)) {
+			if (CPUCLOCK_PERTHREAD(timer->it_clock))
+				now = cpu_clock_sample(clkid, p);
+			else
+				now = cpu_clock_sample_group(clkid, p, false);
+
+			__posix_cpu_timer_get(timer, itp, now);
+		}
 	}
-out:
 	rcu_read_unlock();
 }
 

