Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E04724659
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbjFFOiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbjFFOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:37:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3710FB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:33 -0700 (PDT)
Message-ID: <20230606142031.475141256@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=feQqbMJR8LNStx4hiDUEIHYcUpveV5I+mK7qWj22Q+I=;
        b=K+0PvOJHghqEuSL/XjZ+ievKQ/BpS5nPc98SPu4u7Piv031DQHuSw9oGajptxP1/O3ogEw
        Fl8h62mYfWJzhBl5vt1SfnvfDv6IZsSKv2SkCdnWniZbRcMcW24rreNAvg5IFmYuJPH25V
        8/A8aPCo2v2h6c+XDhMrLrBrRY9PaCT0+uUpc4KREfVFN7t97aDXY5hWuqtYp6/LUg/gdU
        FD5gLMYyWUjwLccJ3W1YoL64EQ0KSi+4O9ewaCKY/+VUesGZWbzBVVhb0bN/KHpZ17NiK1
        19EOg+RuOZcA4sR2BL32JucxrtRvxhIoNTYZ2saEXqn0+S6yjn3mqpv1K1J98w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=feQqbMJR8LNStx4hiDUEIHYcUpveV5I+mK7qWj22Q+I=;
        b=t67079sbUXtqL232iy/n95/NpVWYpidkqzaBa5qDnHjwomga0pshXT7Z0jzaT88DiOzQz+
        gBhkOKIZPUOtoeAw==
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
Subject: [patch 08/45] posix-timers: Convert timer list to hlist
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:31 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No requirement for a real list. Spare a few bytes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/base.c               |    6 +++---
 include/linux/posix-timers.h |    2 +-
 include/linux/sched/signal.h |    2 +-
 init/init_task.c             |    2 +-
 kernel/fork.c                |    2 +-
 kernel/time/posix-timers.c   |   16 ++++++++--------
 6 files changed, 15 insertions(+), 15 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2461,13 +2461,13 @@ static void *timers_start(struct seq_fil
 	if (!tp->sighand)
 		return ERR_PTR(-ESRCH);
 
-	return seq_list_start(&tp->task->signal->posix_timers, *pos);
+	return seq_hlist_start(&tp->task->signal->posix_timers, *pos);
 }
 
 static void *timers_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct timers_private *tp = m->private;
-	return seq_list_next(v, &tp->task->signal->posix_timers, pos);
+	return seq_hlist_next(v, &tp->task->signal->posix_timers, pos);
 }
 
 static void timers_stop(struct seq_file *m, void *v)
@@ -2496,7 +2496,7 @@ static int show_timer(struct seq_file *m
 		[SIGEV_THREAD] = "thread",
 	};
 
-	timer = list_entry((struct list_head *)v, struct k_itimer, list);
+	timer = hlist_entry((struct hlist_node *)v, struct k_itimer, list);
 	notify = timer->it_sigev_notify;
 
 	seq_printf(m, "ID: %d\n", timer->it_id);
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -221,7 +221,7 @@ static inline void posix_cputimers_init_
  * @rcu:		RCU head for freeing the timer.
  */
 struct k_itimer {
-	struct list_head	list;
+	struct hlist_node	list;
 	struct hlist_node	t_hash;
 	spinlock_t		it_lock;
 	const struct k_clock	*kclock;
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,7 @@ struct signal_struct {
 
 	/* POSIX.1b Interval Timers */
 	unsigned int		next_posix_timer_id;
-	struct list_head	posix_timers;
+	struct hlist_head	posix_timers;
 
 	/* ITIMER_REAL timer for the process */
 	struct hrtimer real_timer;
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -28,7 +28,7 @@ static struct signal_struct init_signals
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
-	.posix_timers = LIST_HEAD_INIT(init_signals.posix_timers),
+	.posix_timers	= HLIST_HEAD_INIT,
 	.cputimer	= {
 		.cputime_atomic	= INIT_CPUTIME_ATOMIC,
 	},
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1880,7 +1880,7 @@ static int copy_signal(unsigned long clo
 	prev_cputime_init(&sig->prev_cputime);
 
 #ifdef CONFIG_POSIX_TIMERS
-	INIT_LIST_HEAD(&sig->posix_timers);
+	INIT_HLIST_HEAD(&sig->posix_timers);
 	hrtimer_init(&sig->real_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	sig->real_timer.function = it_real_fn;
 #endif
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -515,7 +515,7 @@ static int do_timer_create(clockid_t whi
 	spin_lock_irq(&current->sighand->siglock);
 	/* This makes the timer valid in the hash table */
 	WRITE_ONCE(new_timer->it_signal, current->signal);
-	list_add(&new_timer->list, &current->signal->posix_timers);
+	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	spin_unlock_irq(&current->sighand->siglock);
 	/*
 	 * After unlocking sighand::siglock @new_timer is subject to
@@ -1021,7 +1021,7 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
 	}
 
 	spin_lock(&current->sighand->siglock);
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 	spin_unlock(&current->sighand->siglock);
 	/*
 	 * A concurrent lookup could check timer::it_signal lockless. It
@@ -1071,7 +1071,7 @@ static void itimer_delete(struct k_itime
 
 		goto retry_delete;
 	}
-	list_del(&timer->list);
+	hlist_del(&timer->list);
 
 	/*
 	 * Setting timer::it_signal to NULL is technically not required
@@ -1092,20 +1092,20 @@ static void itimer_delete(struct k_itime
  */
 void exit_itimers(struct task_struct *tsk)
 {
-	struct list_head timers;
+	struct hlist_head timers;
 	struct k_itimer *tmr;
 
-	if (list_empty(&tsk->signal->posix_timers))
+	if (hlist_empty(&tsk->signal->posix_timers))
 		return;
 
 	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
-	list_replace_init(&tsk->signal->posix_timers, &timers);
+	hlist_move_list(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	/* The timers are not longer accessible via tsk::signal */
-	while (!list_empty(&timers)) {
-		tmr = list_first_entry(&timers, struct k_itimer, list);
+	while (!hlist_empty(&timers)) {
+		tmr = hlist_entry(timers.first, struct k_itimer, list);
 		itimer_delete(tmr);
 	}
 }

