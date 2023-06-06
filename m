Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA058724682
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbjFFOlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237988AbjFFOjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158B1989
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:32 -0700 (PDT)
Message-ID: <20230606142033.441203108@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KPCEPHtczWIeEtOKLehO2QvyWfrjwM+++WUquCbpcRw=;
        b=1zWf1jQqodWBHesc5jNRNFwVphF/JwvuwQna14t8+u4vPvJ3+YuUGqenFpAHOkE110KJZb
        +c0Jk7dbTnIOEzrtwyWkasQcqR6DhR/TBGvNOZbxKFCr/NVJ9/FPsK9BBXZFIeGY9Vhwou
        Q9Xfhw+EXIaTMUk+qe0H6JVGBXJN9gA07uPqzWV0Pb59lzilizTGX1eJ7W/XhZ9e3EmqFk
        +rfDwWAXcw1CeUq17l5hvN6r4kuWk3crCYvLrLHNzuFYfwYTJ9AexjfRmV2oihEGIi9BKr
        H6xyK3u3D9/YbFLg4ACsEp6DGRR6Dnp8Vrx6q2Kn/4+m13dB9ZITLz4zX5wepw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=KPCEPHtczWIeEtOKLehO2QvyWfrjwM+++WUquCbpcRw=;
        b=O/NQe4Bm1NUZ1jjSQh1sYdCGkranWpGj655TOKUl5yu08KaH+ZGR9ainJvhDQyS9uTH0m0
        MHosmz8BK5lJQEAg==
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
Subject: [patch 43/45] posix-timers: Cleanup SIG_IGN workaround leftovers
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:27 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ignored posix timer signals are requeued and the timers are
rearmed on signal delivery the workaround to keep such timers alive and
self rearm them is not longer required.

Remove the relevant hacks and the not longer required return values from
the related functions. The alarm timer workarounds will be cleaned up in a
separate step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h   |    2 -
 kernel/signal.c                |    3 -
 kernel/time/alarmtimer.c       |   37 +++---------------------
 kernel/time/posix-cpu-timers.c |   18 ++---------
 kernel/time/posix-timers.c     |   63 +++--------------------------------------
 kernel/time/posix-timers.h     |    2 -
 6 files changed, 18 insertions(+), 107 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -173,7 +173,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
-int posixtimer_send_sigqueue(struct k_itimer *tmr);
+void posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1960,7 +1960,7 @@ static inline struct task_struct *posixt
 	return t;
 }
 
-int posixtimer_send_sigqueue(struct k_itimer *tmr)
+void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
 	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
@@ -2045,7 +2045,6 @@ int posixtimer_send_sigqueue(struct k_it
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
-	return 0;
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -198,27 +198,16 @@ static enum hrtimer_restart alarmtimer_f
 	struct alarm *alarm = container_of(timer, struct alarm, timer);
 	struct alarm_base *base = &alarm_bases[alarm->type];
 	unsigned long flags;
-	int ret = HRTIMER_NORESTART;
-	int restart = ALARMTIMER_NORESTART;
 
 	spin_lock_irqsave(&base->lock, flags);
 	alarmtimer_dequeue(base, alarm);
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	if (alarm->function)
-		restart = alarm->function(alarm, base->get_ktime());
-
-	spin_lock_irqsave(&base->lock, flags);
-	if (restart != ALARMTIMER_NORESTART) {
-		hrtimer_set_expires(&alarm->timer, alarm->node.expires);
-		alarmtimer_enqueue(base, alarm);
-		ret = HRTIMER_RESTART;
-	}
-	spin_unlock_irqrestore(&base->lock, flags);
+		alarm->function(alarm, base->get_ktime());
 
 	trace_alarmtimer_fired(alarm, base->get_ktime());
-	return ret;
-
+	return HRTIMER_NORESTART;
 }
 
 ktime_t alarm_expires_remaining(const struct alarm *alarm)
@@ -556,30 +545,16 @@ static enum alarmtimer_type clock2alarm(
  *
  * Return: whether the timer is to be restarted
  */
-static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm,
-							ktime_t now)
+static enum alarmtimer_restart alarm_handle_timer(struct alarm *alarm, ktime_t now)
 {
-	struct k_itimer *ptr = container_of(alarm, struct k_itimer,
-					    it.alarm.alarmtimer);
-	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
+	struct k_itimer *ptr = container_of(alarm, struct k_itimer, it.alarm.alarmtimer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
-
-	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
-		/*
-		 * Handle ignored signals and rearm the timer. This will go
-		 * away once we handle ignored signals proper. Ensure that
-		 * small intervals cannot starve the system.
-		 */
-		ptr->it_overrun += __alarm_forward_now(alarm, ptr->it_interval, true);
-		++ptr->it_signal_seq;
-		ptr->it_status = POSIX_TIMER_ARMED;
-		result = ALARMTIMER_RESTART;
-	}
+	posix_timer_queue_signal(ptr);
 	spin_unlock_irqrestore(&ptr->it_lock, flags);
 
-	return result;
+	return ALARMTIMER_NORESTART;
 }
 
 /**
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -593,21 +593,11 @@ static void cpu_timer_fire(struct k_itim
 		 */
 		wake_up_process(timer->it_process);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (!timer->it_interval) {
-		/*
-		 * One-shot timer.  Clear it as soon as it's fired.
-		 */
+	} else {
 		posix_timer_queue_signal(timer);
-		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_queue_signal(timer)) {
-		/*
-		 * The signal did not get queued because the signal
-		 * was ignored, so we won't get any callback to
-		 * reload the timer.  But we need to keep it
-		 * ticking in case the signal is deliverable next time.
-		 */
-		posix_cpu_timer_rearm(timer);
-		++timer->it_signal_seq;
+		/* Disable oneshot timers */
+		if (!timer->it_interval)
+			cpu_timer_setexpires(ctmr, 0);
 	}
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -300,10 +300,9 @@ bool posixtimer_deliver_signal(struct ke
 	return ret;
 }
 
-int posix_timer_queue_signal(struct k_itimer *timr)
+void posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
 
@@ -313,9 +312,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	ret = posixtimer_send_sigqueue(timr);
-	/* If we failed to send the signal the timer stops. */
-	return ret > 0;
+	posixtimer_send_sigqueue(timr);
 }
 
 /*
@@ -328,62 +325,12 @@ int posix_timer_queue_signal(struct k_it
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
 	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
-	enum hrtimer_restart ret = HRTIMER_NORESTART;
 	unsigned long flags;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
-
-	if (posix_timer_queue_signal(timr)) {
-		/*
-		 * The signal was not queued due to SIG_IGN. As a
-		 * consequence the timer is not going to be rearmed from
-		 * the signal delivery path. But as a real signal handler
-		 * can be installed later the timer must be rearmed here.
-		 */
-		if (timr->it_interval != 0) {
-			ktime_t now = hrtimer_cb_get_time(timer);
-
-			/*
-			 * FIXME: What we really want, is to stop this
-			 * timer completely and restart it in case the
-			 * SIG_IGN is removed. This is a non trivial
-			 * change to the signal handling code.
-			 *
-			 * For now let timers with an interval less than a
-			 * jiffie expire every jiffie and recheck for a
-			 * valid signal handler.
-			 *
-			 * This avoids interrupt starvation in case of a
-			 * very small interval, which would expire the
-			 * timer immediately again.
-			 *
-			 * Moving now ahead of time by one jiffie tricks
-			 * hrtimer_forward() to expire the timer later,
-			 * while it still maintains the overrun accuracy
-			 * for the price of a slight inconsistency in the
-			 * timer_gettime() case. This is at least better
-			 * than a timer storm.
-			 *
-			 * Only required when high resolution timers are
-			 * enabled as the periodic tick based timers are
-			 * automatically aligned to the next tick.
-			 */
-			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
-				ktime_t kj = TICK_NSEC;
-
-				if (timr->it_interval < kj)
-					now = ktime_add(now, kj);
-			}
-
-			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
-			ret = HRTIMER_RESTART;
-			++timr->it_signal_seq;
-			timr->it_status = POSIX_TIMER_ARMED;
-		}
-	}
-
-	unlock_timer(timr, flags);
-	return ret;
+	posix_timer_queue_signal(timr);
+	spin_unlock_irqrestore(&timr->it_lock, flags);
+	return HRTIMER_NORESTART;
 }
 
 static struct pid *good_sigevent(sigevent_t * event)
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,7 +42,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_queue_signal(struct k_itimer *timr);
+void posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,

