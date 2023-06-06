Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F972467A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbjFFOkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236184AbjFFOjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:39:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582421984
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:38:24 -0700 (PDT)
Message-ID: <20230606142032.993368223@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g7l/2zlLif3HG/2XRk0djJlztUlSNJVVihTa+AYF0Ng=;
        b=DY64q94Gr7wrbcshB8A2DNDl4W2LY5jV7sNZq7ieAT3C9PxCNyFWm+ECQQovXgpGL0ZOGN
        wNL0y4ypWKpchpDU4O2ePECiJuF4LdD2J4K4sez9VlJGS2zf5+6+pttuejY5WMn0wNRpOy
        UiFsqOR4a7HuThqyK4RtfeBEx2WEefOZrAVJSlpYze2HK1P2e19fp3SIRImFHRA4nklXjk
        Dy1ppYjZ6z0QuCftVICJiHoPDBfdGJsPxTM9YFIQ9xn8ITHVyKhrOlZ6XPzang/4143qtQ
        cz9Qc6jsQhzZ0gGfkhvO0ioNRACcoaGXsguk2ArKi3U4Y71s7jCSs38XW+hdNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=g7l/2zlLif3HG/2XRk0djJlztUlSNJVVihTa+AYF0Ng=;
        b=kMg9UwkfddSxmVr4V0gVW7txrjdRA9kem0+WWFZ5TPnH/Qv3jMUURv5SkYZZ/a0mg6cnA3
        vaYPPloZYtgAMgCA==
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
Subject: [patch 35/45] signal: Refactor send_sigqueue()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To handle posix timers which have their signal ignored via SIG_IGN properly
its required to requeue a ignored signal for delivery when SIG_IGN is
lifted so the timer gets rearmed.

Split the required code out of send_sigqueue() so it can be reused in
context of sigaction().

While at it rename send_sigqueue() to posixtimer_send_sigqueue() so its
clear what this is about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/posix-timers.h |    4 ++
 include/linux/sched/signal.h |    1 
 kernel/signal.c              |   73 ++++++++++++++++++++++++-------------------
 kernel/time/posix-timers.c   |   10 ++++-
 4 files changed, 53 insertions(+), 35 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -6,11 +6,13 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/alarmtimer.h>
+#include <linux/pid.h>
 #include <linux/rcuref.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
+struct sigqueue;
 struct k_itimer;
 
 /*
@@ -169,6 +171,7 @@ static inline void posix_cputimers_rt_wa
 
 void posixtimer_rearm_itimer(struct task_struct *p);
 bool posixtimer_init_sigqueue(struct sigqueue *q);
+int posixtimer_send_sigqueue(struct k_itimer *tmr);
 bool posixtimer_deliver_signal(struct kernel_siginfo *info);
 void posixtimer_free_timer(struct k_itimer *timer);
 
@@ -242,6 +245,7 @@ struct k_itimer {
 	s64			it_overrun_last;
 	unsigned int		it_signal_seq;
 	int			it_sigev_notify;
+	enum pid_type		it_pid_type;
 	ktime_t			it_interval;
 	struct signal_struct	*it_signal;
 	union {
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -348,7 +348,6 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1943,38 +1943,53 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
+static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t, enum pid_type type)
 {
-	int sig = q->info.si_signo;
 	struct sigpending *pending;
+	int sig = q->info.si_signo;
+
+	signalfd_notify(t, sig);
+	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
+	list_add_tail(&q->list, &pending->list);
+	sigaddset(&pending->signal, sig);
+	complete_signal(sig, t, type);
+}
+
+/*
+ * This function is used by POSIX timers to deliver a timer signal.
+ * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
+ * set), the signal must be delivered to the specific thread (queues
+ * into t->pending).
+ *
+ * Where type is not PIDTYPE_PID, signals must be delivered to the
+ * process. In this case, prefer to deliver to current if it is in
+ * the same thread group as the target process, which avoids
+ * unnecessarily waking up a potentially idle task.
+ */
+static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
+{
+	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
+
+	if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
+		t = current;
+	return t;
+}
+
+int posixtimer_send_sigqueue(struct k_itimer *tmr)
+{
+	struct sigqueue *q = tmr->sigq;
+	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
 	int ret, result;
 
-	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
-		return 0;
-	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
-		return 0;
-
 	ret = -1;
 	rcu_read_lock();
 
-	/*
-	 * This function is used by POSIX timers to deliver a timer signal.
-	 * Where type is PIDTYPE_PID (such as for timers with SIGEV_THREAD_ID
-	 * set), the signal must be delivered to the specific thread (queues
-	 * into t->pending).
-	 *
-	 * Where type is not PIDTYPE_PID, signals must be delivered to the
-	 * process. In this case, prefer to deliver to current if it is in
-	 * the same thread group as the target process, which avoids
-	 * unnecessarily waking up a potentially idle task.
-	 */
-	t = pid_task(pid, type);
+	t = posixtimer_get_target(tmr);
 	if (!t)
 		goto ret;
-	if (type != PIDTYPE_PID && same_thread_group(t, current))
-		t = current;
+
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
@@ -1984,7 +1999,7 @@ int send_sigqueue(struct sigqueue *q, st
 	 * decides based on si_sys_private whether to invoke
 	 * posixtimer_rearm() or not.
 	 */
-	q->info.si_sys_private = si_private;
+	q->info.si_sys_private = tmr->it_signal_seq;
 
 	/*
 	 * Set the overrun count to zero unconditionally. The posix timer
@@ -2015,24 +2030,20 @@ int send_sigqueue(struct sigqueue *q, st
 	q->info.si_overrun = 0;
 
 	ret = 1; /* the signal is ignored */
-	result = TRACE_SIGNAL_IGNORED;
-	if (!prepare_signal(sig, t, false))
+	if (!prepare_signal(sig, t, false)) {
+		result = TRACE_SIGNAL_IGNORED;
 		goto out;
+	}
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
-
-	signalfd_notify(t, sig);
-	pending = (type != PIDTYPE_PID) ? &t->signal->shared_pending : &t->pending;
-	list_add_tail(&q->list, &pending->list);
-	sigaddset(&pending->signal, sig);
-	complete_signal(sig, t, type);
+	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
-	trace_signal_generate(sig, &q->info, t, type != PIDTYPE_PID, result);
+	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
 ret:
 	rcu_read_unlock();
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -298,7 +298,6 @@ bool posixtimer_deliver_signal(struct ke
 int posix_timer_queue_signal(struct k_itimer *timr)
 {
 	enum posix_timer_state state = POSIX_TIMER_DISARMED;
-	enum pid_type type;
 	int ret;
 
 	lockdep_assert_held(&timr->it_lock);
@@ -309,8 +308,7 @@ int posix_timer_queue_signal(struct k_it
 	}
 	timr->it_status = state;
 
-	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type, timr->it_signal_seq);
+	ret = posixtimer_send_sigqueue(timr);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }
@@ -504,8 +502,14 @@ static int do_timer_create(clockid_t whi
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
+	if (new_timer->it_sigev_notify & SIGEV_THREAD_ID)
+		new_timer->it_pid_type = PIDTYPE_PID;
+	else
+		new_timer->it_pid_type = PIDTYPE_TGID;
+
 	new_timer->sigq->info.si_tid   = new_timer->it_id;
 	new_timer->sigq->info.si_code  = SI_TIMER;
+
 	new_timer->sigq->info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {

