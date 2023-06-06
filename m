Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3700724668
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjFFOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjFFOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A110F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:53 -0700 (PDT)
Message-ID: <20230606142032.209201867@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y+RhxJJzE8uzstkBWfAPFhTwZDjjv6jfhmmgOqvJSb0=;
        b=gwgYgVQAUT+3KKpdi3wnvtWIKTUWUU1RrFh4glOGKxb8ztFzovqeMm1EggBrlL8G8jRujj
        9sWrK/aqDnCG2lntLhiY9APg0B8wQBz0O6Id7xuWxfQGFCWHFvpUtMlNP1mF1qNlhpFp8s
        EWGimSiG+2yY5aeJbSqv5ewDg3tDYOxfCKTNH+Z1pGC4juRBP5mFPGdBWqsSgilptkrNwW
        H7bsyawQ20vNZRJNJy0x3MoAIArY6AbBVsv8M/P4/YjCXLOt/C0PW9PwHVca16uYqq9iW3
        8A9sHCbP4Uhv85Gp68cCl25nO1tduw2Kq47p5cekTq//wf24iFKkeDeSDixRWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=y+RhxJJzE8uzstkBWfAPFhTwZDjjv6jfhmmgOqvJSb0=;
        b=ljl4qT+fsd3lzxkk2vZtMdZ2om0ov9TE6cQQfxnx07U26+XlAHdYyV98BPjTx6oEslQGJS
        VdQh1J6J657GerBw==
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
Subject: [patch 21/45] signal: Confine POSIX_TIMERS properly
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:52 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the itimer rearming out of the signal code and consolidate all posix
timer related functions in the signal code under one ifdef.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    5 +
 kernel/signal.c              |  125 +++++++++++++++----------------------------
 kernel/time/itimer.c         |   22 +++++++
 kernel/time/posix-timers.c   |   15 ++++-
 4 files changed, 82 insertions(+), 85 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -162,6 +162,8 @@ static inline void posix_cputimers_rt_wa
 {
 	pct->bases[CPUCLOCK_SCHED].nextevt = runtime;
 }
+void posixtimer_rearm_itimer(struct task_struct *p);
+void posixtimer_rearm(struct kernel_siginfo *info);
 
 /* Init task static initializer */
 #define INIT_CPU_TIMERBASE(b) {						\
@@ -185,6 +187,8 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void posixtimer_rearm_itimer(struct task_struct *p) { }
+static inline void posixtimer_rearm(struct kernel_siginfo *info) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
@@ -259,5 +263,4 @@ void set_process_cpu_timer(struct task_s
 
 int update_rlimit_cpu(struct task_struct *task, unsigned long rlim_new);
 
-void posixtimer_rearm(struct kernel_siginfo *info);
 #endif
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -485,42 +485,6 @@ void flush_signals(struct task_struct *t
 }
 EXPORT_SYMBOL(flush_signals);
 
-#ifdef CONFIG_POSIX_TIMERS
-static void __flush_itimer_signals(struct sigpending *pending)
-{
-	sigset_t signal, retain;
-	struct sigqueue *q, *n;
-
-	signal = pending->signal;
-	sigemptyset(&retain);
-
-	list_for_each_entry_safe(q, n, &pending->list, list) {
-		int sig = q->info.si_signo;
-
-		if (likely(q->info.si_code != SI_TIMER)) {
-			sigaddset(&retain, sig);
-		} else {
-			sigdelset(&signal, sig);
-			list_del_init(&q->list);
-			__sigqueue_free(q);
-		}
-	}
-
-	sigorsets(&pending->signal, &signal, &retain);
-}
-
-void flush_itimer_signals(void)
-{
-	struct task_struct *tsk = current;
-	unsigned long flags;
-
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
-	__flush_itimer_signals(&tsk->pending);
-	__flush_itimer_signals(&tsk->signal->shared_pending);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
-}
-#endif
-
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -639,31 +603,9 @@ int dequeue_signal(sigset_t *mask, kerne
 		*type = PIDTYPE_TGID;
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
-		/*
-		 * itimer signal ?
-		 *
-		 * itimers are process shared and we restart periodic
-		 * itimers in the signal delivery path to prevent DoS
-		 * attacks in the high resolution timer case. This is
-		 * compliant with the old way of self-restarting
-		 * itimers, as the SIGALRM is a legacy signal and only
-		 * queued once. Changing the restart behaviour to
-		 * restart the timer in the signal dequeue path is
-		 * reducing the timer noise on heavy loaded !highres
-		 * systems too.
-		 */
-		if (unlikely(signr == SIGALRM)) {
-			struct hrtimer *tmr = &tsk->signal->real_timer;
 
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr != 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+		if (unlikely(signr == SIGALRM))
+			posixtimer_rearm_itimer(tsk);
 	}
 
 	recalc_sigpending();
@@ -685,22 +627,12 @@ int dequeue_signal(sigset_t *mask, kerne
 		 */
 		current->jobctl |= JOBCTL_STOP_DEQUEUED;
 	}
-#ifdef CONFIG_POSIX_TIMERS
-	if (resched_timer) {
-		/*
-		 * Release the siglock to ensure proper locking order
-		 * of timer locks outside of siglocks.  Note, we leave
-		 * irqs disabled here, since the posix-timers code is
-		 * about to disable them again anyway.
-		 */
-		spin_unlock(&tsk->sighand->siglock);
-		posixtimer_rearm(info);
-		spin_lock(&tsk->sighand->siglock);
 
-		/* Don't expose the si_sys_private value to userspace */
-		info->si_sys_private = 0;
+	if (IS_ENABLED(CONFIG_POSIX_TIMERS)) {
+		if (unlikely(resched_timer))
+			posixtimer_rearm(info);
 	}
-#endif
+
 	return signr;
 }
 EXPORT_SYMBOL_GPL(dequeue_signal);
@@ -1916,15 +1848,45 @@ int kill_pid(struct pid *pid, int sig, i
 }
 EXPORT_SYMBOL(kill_pid);
 
+#ifdef CONFIG_POSIX_TIMERS
 /*
- * These functions support sending signals using preallocated sigqueue
- * structures.  This is needed "because realtime applications cannot
- * afford to lose notifications of asynchronous events, like timer
- * expirations or I/O completions".  In the case of POSIX Timers
- * we allocate the sigqueue structure from the timer_create.  If this
- * allocation fails we are able to report the failure to the application
- * with an EAGAIN error.
+ * These functions handle POSIX timer signals. POSIX timers use
+ * preallocated sigqueue structs for sending signals.
  */
+static void __flush_itimer_signals(struct sigpending *pending)
+{
+	sigset_t signal, retain;
+	struct sigqueue *q, *n;
+
+	signal = pending->signal;
+	sigemptyset(&retain);
+
+	list_for_each_entry_safe(q, n, &pending->list, list) {
+		int sig = q->info.si_signo;
+
+		if (likely(q->info.si_code != SI_TIMER)) {
+			sigaddset(&retain, sig);
+		} else {
+			sigdelset(&signal, sig);
+			list_del_init(&q->list);
+			__sigqueue_free(q);
+		}
+	}
+
+	sigorsets(&pending->signal, &signal, &retain);
+}
+
+void flush_itimer_signals(void)
+{
+	struct task_struct *tsk = current;
+	unsigned long flags;
+
+	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	__flush_itimer_signals(&tsk->pending);
+	__flush_itimer_signals(&tsk->signal->shared_pending);
+	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+}
+
 struct sigqueue *sigqueue_alloc(void)
 {
 	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
@@ -2021,6 +1983,7 @@ int send_sigqueue(struct sigqueue *q, st
 	rcu_read_unlock();
 	return ret;
 }
+#endif /* CONFIG_POSIX_TIMERS */
 
 static void do_notify_pidfd(struct task_struct *task)
 {
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -151,7 +151,27 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, w
 #endif
 
 /*
- * The timer is automagically restarted, when interval != 0
+ * Invoked from dequeue_signal() when SIG_ALRM is delivered.
+ *
+ * Restart the ITIMER_REAL timer if it is armed as periodic timer.  Doing
+ * this in the signal delivery path instead of self rearming prevents a DoS
+ * with small increments in the high reolution timer case and reduces timer
+ * noise in general.
+ */
+void posixtimer_rearm_itimer(struct task_struct *tsk)
+{
+	struct hrtimer *tmr = &tsk->signal->real_timer;
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
+		hrtimer_forward(tmr, tmr->base->get_time(),
+				tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
+/*
+ * Interval timers are restarted in the signal delivery path.  See
+ * posixtimer_rearm_itimer().
  */
 enum hrtimer_restart it_real_fn(struct hrtimer *timer)
 {
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,7 +251,7 @@ static void common_hrtimer_rearm(struct
 
 /*
  * This function is called from the signal delivery code if
- * info->si_sys_private is not zero, which indicates that the timer has to
+ * info::si_sys_private is not zero, which indicates that the timer has to
  * be rearmed. Restart the timer and update info::si_overrun.
  */
 void posixtimer_rearm(struct kernel_siginfo *info)
@@ -259,9 +259,15 @@ void posixtimer_rearm(struct kernel_sigi
 	struct k_itimer *timr;
 	unsigned long flags;
 
+	/*
+	 * Release siglock to ensure proper locking order versus
+	 * timr::it_lock. Keep interrupts disabled.
+	 */
+	spin_unlock(&current->sighand->siglock);
+
 	timr = lock_timer(info->si_tid, &flags);
 	if (!timr)
-		return;
+		goto out;
 
 	if (timr->it_interval && timr->it_requeue_pending == info->si_sys_private) {
 		timr->kclock->timer_rearm(timr);
@@ -275,6 +281,11 @@ void posixtimer_rearm(struct kernel_sigi
 	}
 
 	unlock_timer(timr, flags);
+out:
+	spin_lock(&current->sighand->siglock);
+
+	/* Don't expose the si_sys_private value to userspace */
+	info->si_sys_private = 0;
 }
 
 int posix_timer_queue_signal(struct k_itimer *timr)

