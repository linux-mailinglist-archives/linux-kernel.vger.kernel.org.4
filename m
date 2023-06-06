Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBC7246A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbjFFOqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbjFFOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E131995
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:44:26 -0700 (PDT)
Message-ID: <20230606142033.048775731@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FbfX95bonQ6QuMNiHBaPdEVKsEDfcrvq6gge8bQAWbs=;
        b=qlPPi2zJ1gOLSHTvVnbN6QCmF6iqPsLJVhZeEwc5YDBdAyQLMp416H3yJCEezDSZnvKfTX
        hyooItR3CpENkV5UDazbBwUjcGIya+Az8psFl3glrZ1jrtJtIxB9Fu+6syIbjOr7zpA7Cq
        nCyxdYVLopIwnxhvUDeaj1RDPM2pYklFAo7yIvc99hkCPLsrNhVrSd7NtieS7Ok1u+CjZu
        CSp7DrEzYcJVUuFnkWoAZI9Y8pUqfa0gBA/eetCjEa1pmGG3BNUTm9+j7bvY1/at6D2P0G
        19k7eLR9TDaZUbhlLcr8uldK+n7Orh+g+8UgByCgFkiVpD1viADjgwwReqXltw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FbfX95bonQ6QuMNiHBaPdEVKsEDfcrvq6gge8bQAWbs=;
        b=DNdn4sddi0bwxcS7c+BucGdlXd/d1WavXafOwXOJF33YNAMK6P0VbLjtzLhCI5le5LfMMs
        lzNAd6E0WvZ4bEAg==
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
Subject: [patch 36/45] posix-timers: Embed sigqueue in struct k_itimer
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:38:16 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To cure the SIG_IGN handling for posix interval timers, the preallocated
sigqueue needs to be embedded into struct k_itimer to prevent life time
races of all sorts.

Now that the prerequisites are in place, embed the sigqueue into struct
k_itimer and fixup the relevant usage sites.

Aside of preparing for proper SIG_IGN handling, this spares an extra
allocation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/base.c               |    4 +-
 include/linux/posix-timers.h |   23 +++++++++++++++-
 kernel/signal.c              |   12 +++++++-
 kernel/time/posix-timers.c   |   59 ++++++++++++++++++++++++++-----------------
 4 files changed, 69 insertions(+), 29 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2501,8 +2501,8 @@ static int show_timer(struct seq_file *m
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
 	seq_printf(m, "signal: %d/%px\n",
-		   timer->sigq->info.si_signo,
-		   timer->sigq->info.si_value.sival_ptr);
+		   timer->sigq.info.si_signo,
+		   timer->sigq.info.si_value.sival_ptr);
 	seq_printf(m, "notify: %s/%s.%d\n",
 		   nstr[notify & ~SIGEV_THREAD_ID],
 		   (notify & SIGEV_THREAD_ID) ? "tid" : "pid",
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -63,6 +63,8 @@ static inline int clockid_to_fd(const cl
 
 #ifdef CONFIG_POSIX_TIMERS
 
+#include <linux/signal_types.h>
+
 /**
  * cpu_timer - Posix CPU timer representation for k_itimer
  * @node:	timerqueue node to queue in the task/sig
@@ -228,7 +230,7 @@ static inline void posix_cputimers_init_
  * @it_pid:		The pid of the process/task targeted by the signal
  * @it_process:		The task to wakeup on clock_nanosleep (CPU timers)
  * @rcuref:		Reference count for life time management
- * @sigq:		Pointer to preallocated sigqueue
+ * @sigq:		Embedded sigqueue
  * @it:			Union representing the various posix timer type
  *			internals.
  * @rcu:		RCU head for freeing the timer.
@@ -252,7 +254,7 @@ struct k_itimer {
 		struct pid		*it_pid;
 		struct task_struct	*it_process;
 	};
-	struct sigqueue		*sigq;
+	struct sigqueue		sigq;
 	rcuref_t		rcuref;
 	union {
 		struct {
@@ -280,6 +282,23 @@ static inline void posixtimer_putref(str
 	if (rcuref_put(&tmr->rcuref))
 		posixtimer_free_timer(tmr);
 }
+
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	WARN_ON_ONCE(!rcuref_get(&tmr->rcuref));
+}
+
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q)
+{
+	struct k_itimer *tmr = container_of(q, struct k_itimer, sigq);
+
+	posixtimer_putref(tmr);
+}
+#else  /* CONFIG_POSIX_TIMERS */
+static inline void posixtimer_sigqueue_getref(struct sigqueue *q) { }
+static inline void posixtimer_sigqueue_putref(struct sigqueue *q) { }
 #endif /* !CONFIG_POSIX_TIMERS */
 
 #endif
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -569,7 +569,12 @@ static void collect_signal(int sig, stru
 still_pending:
 		list_del_init(&first->list);
 		copy_siginfo(info, &first->info);
-		__sigqueue_free(first);
+		/*
+		 * Do not drop the reference count for posix timer
+		 * signals. That's done in posix_timer_deliver_signal().
+		 */
+		if (info->si_code != SI_TIMER)
+			__sigqueue_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -1977,7 +1982,7 @@ static inline struct task_struct *posixt
 
 int posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
-	struct sigqueue *q = tmr->sigq;
+	struct sigqueue *q = &tmr->sigq;
 	int sig = q->info.si_signo;
 	struct task_struct *t;
 	unsigned long flags;
@@ -2037,9 +2042,12 @@ int posixtimer_send_sigqueue(struct k_it
 
 	ret = 0;
 	if (unlikely(!list_empty(&q->list))) {
+		/* This holds a reference count already */
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;
 	}
+
+	posixtimer_sigqueue_getref(q);
 	posixtimer_queue_sigqueue(q, t, tmr->it_pid_type);
 	result = TRACE_SIGNAL_DELIVERED;
 out:
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -251,12 +251,13 @@ static void common_hrtimer_rearm(struct
 
 /*
  * This function is called from the signal delivery code. It decides
- * whether the signal should be dropped and rearms interval timers.
+ * whether the signal should be dropped and rearms interval timers.  The
+ * timer can be unconditionally accessed as there is a reference held on
+ * it.
  */
 bool posixtimer_deliver_signal(struct kernel_siginfo *info)
 {
-	struct k_itimer *timr;
-	unsigned long flags;
+	struct k_itimer *timr = info->si_sys_privptr;
 	bool ret = false;
 
 	/*
@@ -264,12 +265,14 @@ bool posixtimer_deliver_signal(struct ke
 	 * timr::it_lock. Keep interrupts disabled.
 	 */
 	spin_unlock(&current->sighand->siglock);
+	spin_lock(&timr->it_lock);
 
-	timr = lock_timer(info->si_tid, &flags);
-	if (!timr)
-		goto out;
-
-	if (timr->it_signal_seq != info->si_sys_private)
+	/*
+	 * Check if the timer is still alive or whether it got modified
+	 * since the signal was queued. In either case, don't rearm and
+	 * drop the signal.
+	 */
+	if (!timr->it_signal || timr->it_signal_seq != info->si_sys_private)
 		goto out_unlock;
 
 	if (timr->it_interval && timr->it_status == POSIX_TIMER_REQUEUE_PENDING) {
@@ -285,8 +288,10 @@ bool posixtimer_deliver_signal(struct ke
 	ret = true;
 
 out_unlock:
-	unlock_timer(timr, flags);
-out:
+	spin_unlock(&timr->it_lock);
+	/* Drop the reference which was acquired when the signal was queued */
+	posixtimer_putref(timr);
+
 	spin_lock(&current->sighand->siglock);
 
 	/* Don't expose the si_sys_priv* values to userspace */
@@ -405,17 +410,17 @@ static struct pid *good_sigevent(sigeven
 	}
 }
 
-static struct k_itimer * alloc_posix_timer(void)
+static struct k_itimer *alloc_posix_timer(void)
 {
 	struct k_itimer *tmr = kmem_cache_zalloc(posix_timers_cache, GFP_KERNEL);
 
 	if (!tmr)
 		return tmr;
-	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
+
+	if (unlikely(!posixtimer_init_sigqueue(&tmr->sigq))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		return NULL;
 	}
-	clear_siginfo(&tmr->sigq->info);
 	rcuref_init(&tmr->rcuref, 1);
 	return tmr;
 }
@@ -430,7 +435,8 @@ static void k_itimer_rcu_free(struct rcu
 void posixtimer_free_timer(struct k_itimer *tmr)
 {
 	put_pid(tmr->it_pid);
-	sigqueue_free(tmr->sigq);
+	if (tmr->sigq.ucounts)
+		dec_rlimit_put_ucounts(tmr->sigq.ucounts, UCOUNT_RLIMIT_SIGPENDING);
 	call_rcu(&tmr->rcu, k_itimer_rcu_free);
 }
 
@@ -492,13 +498,13 @@ static int do_timer_create(clockid_t whi
 			goto out;
 		}
 		new_timer->it_sigev_notify     = event->sigev_notify;
-		new_timer->sigq->info.si_signo = event->sigev_signo;
-		new_timer->sigq->info.si_value = event->sigev_value;
+		new_timer->sigq.info.si_signo = event->sigev_signo;
+		new_timer->sigq.info.si_value = event->sigev_value;
 	} else {
 		new_timer->it_sigev_notify     = SIGEV_SIGNAL;
-		new_timer->sigq->info.si_signo = SIGALRM;
-		memset(&new_timer->sigq->info.si_value, 0, sizeof(sigval_t));
-		new_timer->sigq->info.si_value.sival_int = new_timer->it_id;
+		new_timer->sigq.info.si_signo = SIGALRM;
+		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
+		new_timer->sigq.info.si_value.sival_int = new_timer->it_id;
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}
 
@@ -507,10 +513,10 @@ static int do_timer_create(clockid_t whi
 	else
 		new_timer->it_pid_type = PIDTYPE_TGID;
 
-	new_timer->sigq->info.si_tid   = new_timer->it_id;
-	new_timer->sigq->info.si_code  = SI_TIMER;
+	new_timer->sigq.info.si_tid   = new_timer->it_id;
+	new_timer->sigq.info.si_code  = SI_TIMER;
 
-	new_timer->sigq->info.si_sys_privptr  = new_timer;
+	new_timer->sigq.info.si_sys_privptr  = new_timer;
 
 	if (copy_to_user(created_timer_id, &new_timer_id, sizeof (new_timer_id))) {
 		error = -EFAULT;
@@ -594,7 +600,14 @@ static struct k_itimer *__lock_timer(tim
 	 *  1) Set timr::it_signal to NULL with timr::it_lock held
 	 *  2) Release timr::it_lock
 	 *  3) Remove from the hash under hash_lock
-	 *  4) Call RCU for removal after the grace period
+	 *  4) Put the reference count.
+	 *
+	 * The reference count might not drop to zero if timr::sigq is
+	 * queued. In that case the signal delivery or flush will put the
+	 * last reference count.
+	 *
+	 * When the reference count reaches zero, the timer is scheduled
+	 * for RCU removal after the grace period.
 	 *
 	 * Holding rcu_read_lock() accross the lookup ensures that
 	 * the timer cannot be freed.

