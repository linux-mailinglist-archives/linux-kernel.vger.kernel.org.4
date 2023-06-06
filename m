Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6353E724671
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238216AbjFFOje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238107AbjFFOjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DEA1BF2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:05 -0700 (PDT)
Message-ID: <20230606142032.489307214@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9SYjUCAe0AgsqCGuTWf7t+WUqVVywcl4/ZGVc9cUSlA=;
        b=qxu1lZ9377m1VdXrFDK7hm0MCDbgZuf1oa7cKHpXv9jMupkRKDli7MoIf4AeWKjuPEuWPd
        9HjzVBhABZ+JqAiOrNP7c4ViUqE7MgiHSt4LSAEqRJoyVpyjYcXTiMlqLzYMoxsMl6iVVz
        WSyKN2iWFFR1oGgYONZoIe1/lzhxvYf5mut4FHNSrJVnq9nzukQjRELWq3P3wXp7rK6fNr
        9a+0J0Dkm87qeVVlj2N5iTSDvUKu3SmZ1s+ao3oU3A14aOQ/ZWwHyUa6yNsb3u4kzqHvV7
        FrGeZZVjmyaHIGITJnuuI/KCbN/iwsBRzA0NEksuMBlXWXrcwhxvBthG1AERGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9SYjUCAe0AgsqCGuTWf7t+WUqVVywcl4/ZGVc9cUSlA=;
        b=x/Zj3IWC//rixGZDrq+hF1gwDYu/SR5Sf3JVr45VCeoe7YU3bpROw7BBg8TGKJa7FweLbz
        PO9GHG/GXN45WWAQ==
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
Subject: [patch 26/45] posix-timers: Rename k_itimer::it_requeue_pending
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for using this struct member to do a proper reprogramming and
deletion accounting so that stale signals can be dropped.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    5 ++---
 kernel/time/alarmtimer.c       |    2 +-
 kernel/time/posix-cpu-timers.c |    2 +-
 kernel/time/posix-timers.c     |   12 ++++++------
 4 files changed, 10 insertions(+), 11 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -213,8 +213,7 @@ static inline void posix_cputimers_init_
  * @it_active:		Marker that timer is active
  * @it_overrun:		The overrun counter for pending signals
  * @it_overrun_last:	The overrun at the time of the last delivered signal
- * @it_requeue_pending:	Indicator that timer waits for being requeued on
- *			signal delivery
+ * @it_signal_seq:	Sequence count to control signal delivery
  * @it_sigev_notify:	The notify word of sigevent struct for signal delivery
  * @it_interval:	The interval for periodic timers
  * @it_signal:		Pointer to the creators signal struct
@@ -235,7 +234,7 @@ struct k_itimer {
 	int			it_active;
 	s64			it_overrun;
 	s64			it_overrun_last;
-	int			it_requeue_pending;
+	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -573,7 +573,7 @@ static enum alarmtimer_restart alarm_han
 		 * small intervals cannot starve the system.
 		 */
 		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_requeue_pending;
+		++ptr->it_signal_seq;
 		ptr->it_active = 1;
 		result = ALARMTIMER_RESTART;
 	}
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -607,7 +607,7 @@ static void cpu_timer_fire(struct k_itim
 		 * ticking in case the signal is deliverable next time.
 		 */
 		posix_cpu_timer_rearm(timer);
-		++timer->it_requeue_pending;
+		++timer->it_signal_seq;
 	}
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -269,13 +269,13 @@ bool posixtimer_deliver_signal(struct ke
 	if (!timr)
 		goto out;
 
-	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
+	if (timr->it_interval && timr->it_signal_seq == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
 
 		timr->it_active = 1;
 		timr->it_overrun_last = timr->it_overrun;
 		timr->it_overrun = -1LL;
-		++timr->it_requeue_pending;
+		++timr->it_signal_seq;
 
 		info->si_overrun = timer_overrun_to_int(timr, info->si_overrun);
 	}
@@ -299,7 +299,7 @@ int posix_timer_queue_signal(struct k_it
 
 	timr->it_active = 0;
 	if (timr->it_interval)
-		si_private = ++timr->it_requeue_pending;
+		si_private = ++timr->it_signal_seq;
 
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
 	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
@@ -366,7 +366,7 @@ static enum hrtimer_restart posix_timer_
 
 			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
-			++timr->it_requeue_pending;
+			++timr->it_signal_seq;
 			timr->it_active = 1;
 		}
 	}
@@ -662,7 +662,7 @@ void common_timer_get(struct k_itimer *t
 	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
 	 * so expiry is > now.
 	 */
-	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
+	if (iv && (timr->it_signal_seq & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
@@ -863,7 +863,7 @@ void posix_timer_set_common(struct k_iti
 		timer->it_interval = timespec64_to_ktime(new_setting->it_interval);
 
 	/* Prevent reloading in case there is a signal pending */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	timer->it_signal_seq = (timer->it_signal_seq + 2) & ~REQUEUE_PENDING;
 	/* Reset overrun accounting */
 	timer->it_overrun_last = 0;
 	timer->it_overrun = -1LL;

