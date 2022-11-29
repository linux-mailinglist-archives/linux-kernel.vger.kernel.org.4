Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB6063C35E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiK2PPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiK2PPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:15:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFD31FA2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:15:18 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:15:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669734915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=txPkP1gmz5ib7ZxCaxHgSw+A6CvynfJ43gDERVP3hvc=;
        b=MS35rUBTXrZhWjskKOBCWxiDaQhAAX96dDoebUQjSHdGZHD0SI50KSoiiI5ELgmY0ZfCho
        YSlhDYMCZ8tlQBEQeE8Aho/11HKCaotzArKZhavFnQnCdFba7ID5Fl1PiYkaulfMUju5pm
        ionmj7S+KVcwHhgNenSg3h21QX4KhPFjVril29Al9GI/Rp2zhInGAAwcu80DPU3KqDSUyW
        3eltnWNSFdq1iPXRf9ufvAGKrpQ1lyf69ueYZQwu0uzhI2FTUKIgC7+KH70WedvacP1N81
        z/fp4Z8YnER9LQh187fTsZrGVJbdtIvd2xH1tRqTXKqmYZDQzlpEsUrpMoK+gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669734915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=txPkP1gmz5ib7ZxCaxHgSw+A6CvynfJ43gDERVP3hvc=;
        b=B8Zs679/Tnma2EQ4ALMdheVQJB5H/sFP/eb6uBLDNSOe5Yt5+2VQhSC/jjRAWHIcWTmmfp
        CMeRfMeO7xK9lPAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] signal: Allow tasks to cache one sigqueue struct (again).
Message-ID: <Y4YiArbU5h3h4n3s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The idea for this originates from the real time tree to make signal
delivery for realtime applications more efficient. In quite some of these
application scenarios a control tasks signals workers to start their
computations. There is usually only one signal per worker on flight.  This
works nicely as long as the kmem cache allocations do not hit the slow path
and cause latencies.

To cure this an optimistic caching was introduced (limited to RT tasks)
which allows a task to cache a single sigqueue in a pointer in task_struct
instead of handing it back to the kmem cache after consuming a signal. When
the next signal is sent to the task then the cached sigqueue is used
instead of allocating a new one. This solves the problem for this set of
application scenarios nicely.

The task cache is not preallocated so the first signal sent to a task goes
always to the cache allocator. The cached sigqueue stays around until the
task exits. Cache filling and depleting relies on task::sighand::siglock.
The sigqueue is cached until PF_EXITING is set. After this flag is set,
the cache is purged from __exit_signal().

After posting this solution for mainline the discussion came up whether
this would be useful in general and should not be limited to realtime
tasks: https://lore.kernel.org/r/m11rcu7nbr.fsf@fess.ebiederm.org

One concern leading to the original limitation was to avoid a large amount
of pointlessly cached sigqueues in alive tasks. The other concern was
vs. RLIMIT_SIGPENDING as these cached sigqueues are not accounted for.

The accounting problem is real, but on the other hand slightly academic.
After gathering some statistics it turned out that after boot of a regular
distro install there are less than 10 sigqueues cached in ~1500 tasks.

In case of a 'mass fork and fire signal to child' scenario the extra 80
bytes of memory per task are well in the noise of the overall memory
consumption of the fork bomb.

If this should be limited then this would need an extra counter in struct
user, more atomic instructions and a separate rlimit. Yet another tunable
which is mostly unused.

The caching is actually used. After boot and a full kernel compile on a
32CPU machine with make -j32 the number of 'allocations' looks like this:

  From slab:       152010
  From task cache: 349594

I.e. it reduces the number of slab cache operations by ~70%.
A typical pattern there is:

<...>-1428 __sigqueue_alloc: ALLOC SLAB  ffff88810b072218 sig 17 to bash-1427
 bash-1427 __sigqueue_cache: CACHE ffff88810b072218
 mesg-1429 __sigqueue_alloc: ALLOC CACHE ffff88810b072218 sig 17 to bash-1427
 bash-1427 __sigqueue_cache: CACHE ffff88810b072218
  cat-1430 __sigqueue_alloc: ALLOC CACHE ffff88810b072218 sig 17 to bash-1427
 bash-1427 __sigqueue_cache: CACHE ffff88810b072218

The interesting sequence is that the exiting task 1429 grabs the sigqueue
from bash's task cache to signal exit and bash sticks it back into it's own
cache. Same for 1430. Lather, rinse and repeat.

The caching is probably not noticeable for the general use case, but the
benefit for latency sensitive applications is clear. While kmem caches are
usually just serving from the fast path the slab merging (default) can
depending on the usage pattern of the merged slabs cause occasional slow
path allocations.

The time spared per cached entry is a few micro seconds per signal which is
not relevant for e.g. a kernel build, but for signal heavy workloads it's
measurable.

As there is no real downside of this caching mechanism making it
unconditionally available is preferred over more conditional code or new
magic tunables.

A previous version of this was reverted due to the incomplete handling
of exit races: b4b27b9eed8e ("Revert "signal: Allow tasks to cache one
sigqueue struct"").

The current version takes a substantially more robust approach to this:

  1) Caching a sigqueue is only allowed in context of the current task
     with current's sighand lock held.

     This avoids two issues of the previous version: the lockless
     mechanism and the caching from e.g. interrupt context.

  2) The exit race is prevented via PF_EXITING. PF_EXITING disables
     caching so that the following free of an already cached sigqueue
     is guaranteed to be the last operation on task::sigqueue_cache.

[ bigeasy: Refurbished commit after if got reverted for valid reasons. ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h  |  1 +
 include/linux/signal.h |  1 +
 kernel/exit.c          |  1 +
 kernel/fork.c          |  1 +
 kernel/signal.c        | 65 +++++++++++++++++++++++++++++++++++++-----
 5 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffb6eb55cd135..ac44ed5bb0abc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1103,6 +1103,7 @@ struct task_struct {
 	/* Signal handlers: */
 	struct signal_struct		*signal;
 	struct sighand_struct __rcu		*sighand;
+	struct sigqueue			*sigqueue_cache;
 	sigset_t			blocked;
 	sigset_t			real_blocked;
 	/* Restored if set_restore_sigmask() was used: */
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3b98e7a28538b..e140aa496e4fc 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -266,6 +266,7 @@ static inline void init_sigpending(struct sigpending *sig)
 }
 
 extern void flush_sigqueue(struct sigpending *queue);
+extern void exit_task_sigqueue_cache(struct task_struct *tsk);
 
 /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
 static inline int valid_signal(unsigned long sig)
diff --git a/kernel/exit.c b/kernel/exit.c
index 35e0a31a0315c..ee10207d62e13 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -157,6 +157,7 @@ static void __exit_signal(struct task_struct *tsk)
 	 */
 	flush_sigqueue(&tsk->pending);
 	tsk->sighand = NULL;
+	exit_task_sigqueue_cache(tsk);
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
diff --git a/kernel/fork.c b/kernel/fork.c
index 08969f5aa38d5..07ce3e490cad9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2141,6 +2141,7 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
+	p->sigqueue_cache = NULL;
 
 	p->utime = p->stime = p->gtime = 0;
 #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
diff --git a/kernel/signal.c b/kernel/signal.c
index d140672185a48..88dfe52f65e74 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -432,7 +432,15 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		return NULL;
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		/*
+		 * The caching relies on sighand::siglock and so preallocation
+		 * can not use it.
+		 */
+		q = t->sigqueue_cache;
+		if (!q || sigqueue_flags)
+			q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
+		else
+			t->sigqueue_cache = NULL;
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -447,15 +455,58 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 	return q;
 }
 
-static void __sigqueue_free(struct sigqueue *q)
+void exit_task_sigqueue_cache(struct task_struct *tsk)
+{
+	/*
+	 * Race free because @tsk is mopped up. PF_EXITING is set and siglock
+	 * is held by the caller, which cannot be validated by lockdep because
+	 * tsk->sighand is already NULL.
+	 */
+	struct sigqueue *q = tsk->sigqueue_cache;
+
+	if (q)
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
+static bool sigqueue_free_common(struct sigqueue *q)
 {
 	if (q->flags & SIGQUEUE_PREALLOC)
-		return;
+		return false;
 	if (q->ucounts) {
 		dec_rlimit_put_ucounts(q->ucounts, UCOUNT_RLIMIT_SIGPENDING);
 		q->ucounts = NULL;
 	}
-	kmem_cache_free(sigqueue_cachep, q);
+	return true;
+}
+
+static void __sigqueue_free(struct sigqueue *q)
+{
+	/*
+	 * Don't attempt to cache the sigqueue. This can be invoked from
+	 * interrupt context and has no requirement to hold siglock.
+	 */
+	if (sigqueue_free_common(q))
+		kmem_cache_free(sigqueue_cachep, q);
+}
+
+static void __sigqueue_cache_or_free(struct sigqueue *q)
+{
+	if (!sigqueue_free_common(q))
+		return;
+	/*
+	 * Try to cache one sigqueue per task. This pairs with the consumer
+	 * side in __sigqueue_alloc().
+	 * Caching is only possible in current's task context. Siglock must be
+	 * held, the task must be alive and not a kernel thread.
+	 *
+	 * Kernel threads are excluded from caching. No caching is done once the
+	 * task is exiting.
+	 */
+	if (current->sigqueue_cache || current->flags & (PF_EXITING | PF_KTHREAD)) {
+		kmem_cache_free(sigqueue_cachep, q);
+		return;
+	}
+	current->sigqueue_cache = q;
 }
 
 void flush_sigqueue(struct sigpending *queue)
@@ -594,7 +645,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
 			(info->si_code == SI_TIMER) &&
 			(info->si_sys_private);
 
-		__sigqueue_free(first);
+		__sigqueue_cache_or_free(first);
 	} else {
 		/*
 		 * Ok, it wasn't in the queue.  This must be
@@ -745,7 +796,7 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
 still_pending:
 	list_del_init(&sync->list);
 	copy_siginfo(info, &sync->info);
-	__sigqueue_free(sync);
+	__sigqueue_cache_or_free(sync);
 	return info->si_signo;
 }
 
@@ -1955,7 +2006,7 @@ void sigqueue_free(struct sigqueue *q)
 	spin_unlock_irqrestore(lock, flags);
 
 	if (q)
-		__sigqueue_free(q);
+		__sigqueue_cache_or_free(q);
 }
 
 int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
-- 
2.38.1
