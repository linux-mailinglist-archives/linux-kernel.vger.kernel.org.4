Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE30B72465B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238147AbjFFOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjFFOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E7170B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:36 -0700 (PDT)
Message-ID: <20230606142031.591764431@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HZelD7evOzJCYoBqQ1DtkrmmziVEl2j+krjTDCi41Fw=;
        b=eKWFjcJLrzMr3pZrkCaPux8kc0/F5ATRMLRIkAmIXE6vAW2dLhmRu1FlnipAK8ZqAY87yN
        OKdVizAKcJwW+gDt6j3meD7VOb5suNceXo19xEpUev4iofYTJRl26w0Xy4alTZM/CxVXfe
        u5Jn1bIM2B7BbNYM9CmWdtcD7q+H7+Eh+kVl3u+Rl0NR55gR6TKNZ+Wfa38jIBGrSAX+qT
        SUFbn8l+kwkxvZMmCk1gb4P/lmmbv8D/ltbIfN/lrH0YwzcTdZsbdw/QYws73GyNWn9gJ0
        2jXicaTUDGO28/nNj+QYy82r/Znje7VcTuELo1Q0ucGg/iEcnlgY+4yPrAurdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HZelD7evOzJCYoBqQ1DtkrmmziVEl2j+krjTDCi41Fw=;
        b=DZ+CbV6pqD6kTZqg47gK9orPuBvbFpmsqiJfvD93glKabXigqESgkTneY7J5E6nbMULLEW
        9J1HkuJTyR6CM1BQ==
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
Subject: [patch 10/45] posix-cpu-timers: Use @now instead of @val for clarity
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:34 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

posix_cpu_timer_set() uses @val as variable for the current time. That's
confusing at best.

Use @now as anywhere else and rewrite the confusing comment about clock
sampling.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -620,7 +620,7 @@ static int posix_cpu_timer_set(struct k_
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, val;
+	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
@@ -672,17 +672,13 @@ static int posix_cpu_timer_set(struct k_
 	}
 
 	/*
-	 * We need to sample the current value to convert the new
-	 * value from to relative and absolute, and to convert the
-	 * old value from absolute to relative.  To set a process
-	 * timer, we need a sample to balance the thread expiry
-	 * times (in arm_timer).  With an absolute time, we must
-	 * check if it's already passed.  In short, we need a sample.
+	 * Sample the current clock for saving the previous setting
+	 * and for rearming the timer.
 	 */
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		val = cpu_clock_sample(clkid, p);
+		now = cpu_clock_sample(clkid, p);
 	else
-		val = cpu_clock_sample_group(clkid, p, !sigev_none);
+		now = cpu_clock_sample_group(clkid, p, !sigev_none);
 
 	if (old) {
 		if (old_expires == 0) {
@@ -696,10 +692,10 @@ static int posix_cpu_timer_set(struct k_
 			 * though we are swallowing that pending
 			 * notification here to install the new setting.
 			 */
-			u64 exp = bump_cpu_timer(timer, val);
+			u64 exp = bump_cpu_timer(timer, now);
 
-			if (val < exp) {
-				old_expires = exp - val;
+			if (now < exp) {
+				old_expires = exp - now;
 				old->it_value = ns_to_timespec64(old_expires);
 			} else {
 				old->it_value.tv_nsec = 1;
@@ -721,7 +717,7 @@ static int posix_cpu_timer_set(struct k_
 
 	/* Convert relative expiry time to absolute */
 	if (new_expires && !(timer_flags & TIMER_ABSTIME))
-		new_expires += val;
+		new_expires += now;
 
 	/* Set the new expiry time (might be 0) */
 	cpu_timer_setexpires(ctmr, new_expires);
@@ -731,7 +727,7 @@ static int posix_cpu_timer_set(struct k_
 	 * not yet expired and the timer requires signal delivery.
 	 * SIGEV_NONE timers are never armed.
 	 */
-	if (!sigev_none && new_expires && val < new_expires)
+	if (!sigev_none && new_expires && now < new_expires)
 		arm_timer(timer, p);
 
 	unlock_task_sighand(p, &flags);
@@ -751,7 +747,7 @@ static int posix_cpu_timer_set(struct k_
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1;
 
-	if (!sigev_none && val >= new_expires) {
+	if (!sigev_none && now >= new_expires) {
 		if (new_expires != 0) {
 			/*
 			 * The designated time already passed, so we notify

