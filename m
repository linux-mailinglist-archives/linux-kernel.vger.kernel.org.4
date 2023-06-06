Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FE4724660
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238050AbjFFOiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjFFOh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD981980
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:42 -0700 (PDT)
Message-ID: <20230606142031.816970056@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BUuJOcWJlcdLruwzTzGc8KK7BJlrslnwV3YCPjzAVYM=;
        b=I5569+xRiO8L9SxBdKWLlInNoyMp15B5f1fsUhs1CMRrvo5cp44kG2L/Vcn4zOOOwD3ItK
        P0YOx8Jr1BJcWmL6/6Bre25ByppqEqyTZGXau7n2XKgzVwo1iKT+NygySaNgaVIaZgKgDm
        FBGuAblTC/3KUREjAh0G5g+N332bg8jawAaS4FdNzKcaqvn4/9dys+TWVzQH1Dig/P+eJ3
        M6jDAzJ009c4ETi/evZbe7DzEEPSKUMTFfWtKzSjHvkYNnRQWMpIVDTaNx7mek0YPtQwZu
        IWNGPjoYqTN6VZJWe/scJykc/7NCj9CRvp36kpt0gfRsLPx5zwOwoBsmbMnUhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BUuJOcWJlcdLruwzTzGc8KK7BJlrslnwV3YCPjzAVYM=;
        b=/2HWb7Dxf5+XWRHkdmmsirK76BRh2t1DBD0zPzjUamOK6oidZTOXdFM19EyVGUwK69a7Pm
        sCh2xituWWCaJOBA==
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
Subject: [patch 14/45] posix-timers: Consolidate interval retrieval
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:40 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to collect the current interval in the posix clock
specific settime() and gettime() callbacks. Just do it right in the common
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 ++++++++------------------
 kernel/time/posix-timers.c     |   18 +++++++++---------
 2 files changed, 17 insertions(+), 27 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,8 +622,8 @@ static int posix_cpu_timer_set(struct k_
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 old_expires, new_expires, now;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
@@ -660,10 +660,7 @@ static int posix_cpu_timer_set(struct k_
 		return -ESRCH;
 	}
 
-	/*
-	 * Disarm any old timer after extracting its expiry time.
-	 */
-	old_incr = timer->it_interval;
+	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
@@ -737,9 +734,6 @@ static int posix_cpu_timer_set(struct k_
 		cpu_timer_fire(timer);
 out:
 	rcu_read_unlock();
-	if (old)
-		old->it_interval = ns_to_timespec64(old_incr);
-
 	return ret;
 }
 
@@ -785,17 +779,13 @@ static void posix_cpu_timer_get(struct k
 
 	rcu_read_lock();
 	p = cpu_timer_task_rcu(timer);
-	if (p) {
-		itp->it_interval = ktime_to_timespec64(timer->it_interval);
-
-		if (cpu_timer_getexpires(ctmr)) {
-			if (CPUCLOCK_PERTHREAD(timer->it_clock))
-				now = cpu_clock_sample(clkid, p);
-			else
-				now = cpu_clock_sample_group(clkid, p, false);
+	if (p && cpu_timer_getexpires(ctmr)) {
+		if (CPUCLOCK_PERTHREAD(timer->it_clock))
+			now = cpu_clock_sample(clkid, p);
+		else
+			now = cpu_clock_sample_group(clkid, p, false);
 
-			__posix_cpu_timer_get(timer, itp, now);
-		}
+		__posix_cpu_timer_get(timer, itp, now);
 	}
 	rcu_read_unlock();
 }
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -636,17 +636,12 @@ static s64 common_hrtimer_forward(struct
  */
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
+	bool sig_none = timr->it_sigev_notify == SIGEV_NONE;
 	const struct k_clock *kc = timr->kclock;
-	ktime_t now, remaining, iv;
-	bool sig_none;
+	bool iv = !!timr->it_interval;
+	ktime_t now, remaining;
 
-	sig_none = timr->it_sigev_notify == SIGEV_NONE;
-	iv = timr->it_interval;
-
-	/* interval timer ? */
-	if (iv) {
-		cur_setting->it_interval = ktime_to_timespec64(iv);
-	} else if (!timr->it_active) {
+	if (!iv && !timr->it_active) {
 		/*
 		 * SIGEV_NONE oneshot timers are never queued and therefore
 		 * timr->it_active is always false. The check below
@@ -705,6 +700,8 @@ static int do_timer_gettime(timer_t time
 		return -EINVAL;
 
 	memset(setting, 0, sizeof(*setting));
+	setting->it_interval = ktime_to_timespec64(timr->it_interval);
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_get))
 		ret = -EINVAL;
@@ -918,6 +915,9 @@ static int do_timer_settime(timer_t time
 	if (!timr)
 		return -EINVAL;
 
+	if (old_spec64)
+		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;

