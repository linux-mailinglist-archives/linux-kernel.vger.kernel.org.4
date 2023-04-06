Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED306DA49C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbjDFVWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDFVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:22:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABDFA275;
        Thu,  6 Apr 2023 14:22:42 -0700 (PDT)
Date:   Thu, 6 Apr 2023 23:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680816161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jKt28xVhGx+GsxyYmoh7wHS36qYx1kF/bzeTQ6uwioM=;
        b=gYdaiMSon+fukxtJAijz5OrsUgKL/FdBUc5QItYKZBnUEUIboXOCdou/2xn++vSsFKHB/3
        utZ8wYKIBO1utYZZO7IchhAD+sXAB6do3yuMTOoNMRpyiLYInTIecHzP/rdQIEF5220HRa
        nbXUEjmBXhgtRWwDJ/9G+1fPKypwQzgcfW0qrCrQqebos9WJ9EqYjynRtI8aeeduOC2HIf
        3uQoGcwteDX4DMsuau7Q3qeTgLqBFV8gaWfFppSqD8zCMi9UK5//l2GvSR6JpfFBWAAsHJ
        NS/f5O2QgzmCekTz1xyWWO6BdWuGRGMJwY9h/2jrcpJi4fETsKvlOuUhX0GTkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680816161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jKt28xVhGx+GsxyYmoh7wHS36qYx1kF/bzeTQ6uwioM=;
        b=kAsmI2BXmaeY/OHdRQdCdyIIkZT/gMt/elajmdB8AzeC+Nri8AM6v3PxyPz+sxfhmQwr/4
        JrFDdKKByF56B7Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3-rc5-rt8
Message-ID: <20230406212240.FBSL4HBN@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.3-rc5-rt8 patch set. 

Changes since v6.3-rc5-rt7:

  - Optimise the rtmutex slowpath with DEBUG_RT_MUTEXES enabled to not
    always invoke blk_flush_plug() if the lock can be acquired without
    blocking.

  - Cache one struct sigqueue on signal reception and use this cache
    while sending a signal. This improves latency for signal heavy
    applications.

  - Improve the comment in ptrace_stop() regarding the current situation
    and PREEMPT_RT.

Known issues
     None

The delta patch against v6.3-rc5-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3-rc5-rt7-rt8.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3-rc5-rt8

The RT patch against v6.3-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3-rc5-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3-rc5-rt8.tar.xz

Sebastian

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 20099268fa257..a39be9f9ba966 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -22,6 +22,7 @@ struct sighand_struct {
 	refcount_t		count;
 	wait_queue_head_t	signalfd_wqh;
 	struct k_sigaction	action[_NSIG];
+	struct sigqueue		*sigqueue_cache;
 };
 
 /*
@@ -349,6 +350,7 @@ extern int send_sig(int, struct task_struct *, int);
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
+extern void sigqueue_free_cached_entry(struct sigqueue *q);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c0257cbee0931..e0988e952b707 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1661,6 +1661,7 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 	RCU_INIT_POINTER(tsk->sighand, sig);
 	if (!sig)
 		return -ENOMEM;
+	sig->sigqueue_cache = NULL;
 
 	refcount_set(&sig->count, 1);
 	spin_lock_irq(&current->sighand->siglock);
@@ -1677,7 +1678,17 @@ static int copy_sighand(unsigned long clone_flags, struct task_struct *tsk)
 void __cleanup_sighand(struct sighand_struct *sighand)
 {
 	if (refcount_dec_and_test(&sighand->count)) {
+		struct sigqueue *sigqueue = NULL;
+
 		signalfd_cleanup(sighand);
+		spin_lock_irq(&sighand->siglock);
+		if (sighand->sigqueue_cache) {
+			sigqueue = sighand->sigqueue_cache;
+			sighand->sigqueue_cache = NULL;
+		}
+		spin_unlock_irq(&sighand->siglock);
+
+		sigqueue_free_cached_entry(sigqueue);
 		/*
 		 * sighand_cachep is SLAB_TYPESAFE_BY_RCU so we can free it
 		 * without an RCU grace period, see __lock_task_sighand().
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c1bc2cb1522cb..08c599a5089a2 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1698,9 +1698,18 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
 					   unsigned int state)
 {
+	/*
+	 * With DEBUG enabled cmpxchg trylock will always fail. Instead of
+	 * invoking blk_flush_plug() try the trylock-slowpath first which will
+	 * succeed if the lock is not contended.
+	 */
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+	if (likely(rt_mutex_slowtrylock(lock)))
+		return 0;
+#else
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
-
+#endif
 	/*
 	 * If we are going to sleep and we have plugged IO queued, make sure to
 	 * submit it to avoid deadlocks.
diff --git a/kernel/signal.c b/kernel/signal.c
index b190366f5c98b..138d68cfc204d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -432,7 +432,18 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		return NULL;
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+
+		if (!sigqueue_flags) {
+			struct sighand_struct *sighand = t->sighand;
+
+			lockdep_assert_held(&sighand->siglock);
+			if (sighand->sigqueue_cache) {
+				q = sighand->sigqueue_cache;
+				sighand->sigqueue_cache = NULL;
+			}
+		}
+		if (!q)
+			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -447,14 +458,43 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	return q;
 }
 
-static void __sigqueue_free(struct sigqueue *q)
+static bool sigqueue_cleanup_accounting(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
-		return;
+		return false;
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
 	}
+	return true;
+}
+
+static void __sigqueue_free(struct sigqueue *q)
+{
+	if (!sigqueue_cleanup_accounting(q))
+		return;
+	kmem_cache_free(sigqueue_cachep, q);
+}
+
+void sigqueue_free_cached_entry(struct sigqueue *q)
+{
+	if (!q)
+		return;
+	kmem_cache_free(sigqueue_cachep, q);
+}
+
+static void sigqueue_cache_or_free(struct sigqueue *q)
+{
+	struct sighand_struct *sighand = current->sighand;
+
+	if (!sigqueue_cleanup_accounting(q))
+		return;
+
+	lockdep_assert_held(&sighand->siglock);
+	if (!sighand->sigqueue_cache) {
+		sighand->sigqueue_cache = q;
+		return;
+	}
 	kmem_cache_free(sigqueue_cachep, q);
 }
 
@@ -594,7 +634,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		__sigqueue_free(first);
+		sigqueue_cache_or_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -2296,8 +2336,24 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 		do_notify_parent_cldstop(current, false, why);
 
 	/*
-	 * Don't want to allow preemption here, because
-	 * sys_ptrace() needs this task to be inactive.
+	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
+	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * which will be fulfilled after read_unlock() and the ptracer will be
+	 * put on the CPU.
+	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
+	 * this task wait in schedule(). If this task gets preempted then it
+	 * remains enqueued on the runqueue. The ptracer will observe this and
+	 * then sleep for a delay of one HZ tick. In the meantime this task
+	 * gets scheduled, enters schedule() and will wait for the ptracer.
+	 *
+	 * This preemption point is not bad from correctness point of view but
+	 * extends the runtime by one HZ tick time due to the ptracer's sleep.
+	 * The preempt-disable section ensures that there will be no preemption
+	 * between unlock and schedule() and so improving the performance since
+	 * the ptracer has no reason to sleep.
+	 *
+	 * This optimisation is not doable on PREEMPT_RT due to the spinlock_t
+	 * within the preempt-disable section.
 	 */
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		preempt_disable();
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
