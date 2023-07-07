Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B80374B4FA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGGQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGGQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:11:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19D526AB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 09:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=SR7jQ0wemZ+SPGb5TlJ63svlte7GIRWmPqnJCT0vaQE=; b=Z/4ZTm6s6FE0C4MtjNUj/nteAm
        kmk+N6EGncRgefSEzbTkeGZVQKwyUY6dp2J9iMU640pezJDVG8wNkDiLp+xLJnaUSM1ESZ1H52GGN
        Gi3zQhcDDaQL/dHQNLFgnkDW3gb/pNgKl+JPi7Xr9gpVOFSdzM727h7dn8mX3M+yngPbbsa6B/Dky
        PdVYqk9o/+vAVsw2bj0Tpwmc35NZ7gGzf4UQc1BJw6ZxYhMq/G0IQ+MqNBdrHLDRZokCKd/OI/OVn
        huYag83nf0dfcptUm/AKkaO9fJ+k5EMeBnCFd+5HekSEyx2NilKY2OGPrKSspFN7RpI1ttKj4YV2R
        mOxDEHDw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHo2m-00F9XH-1v;
        Fri, 07 Jul 2023 16:10:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3788E300274;
        Fri,  7 Jul 2023 18:10:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20E0B29C1E6E8; Fri,  7 Jul 2023 18:10:52 +0200 (CEST)
Date:   Fri, 7 Jul 2023 18:10:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     triangletrap12@gmail.com
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/rtmutex: Fix task->pi_waiters integrity
Message-ID: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Henry reported that rt_mutex_adjust_prio_check() has an ordering
problem and puts the lie to the comment in [7]. Sharing the sort key
between lock->waiters and owner->pi_waiters *does* create problems,
since unlike what the comment claims, holding [L] is insufficient.

Notably, consider:

	A
      /   \
     M1   M2
     |     |
     B     C

That is, task A owns both M1 and M2, B and C block on them. In this
case a concurrent chain walk (B & C) will modify their resp. sort keys
in [7] while holding M1->wait_lock and M2->wait_lock. So holding [L]
is meaningless, they're different Ls.

This then gives rise to a race condition between [7] and [11], where
the requeue of pi_waiters will observe an inconsistent tree order.

	B				C

  (holds M1->wait_lock,		(holds M2->wait_lock,
   holds B->pi_lock)		 holds A->pi_lock)

  [7]
  waiter_update_prio();
  ...
  [8]
  raw_spin_unlock(B->pi_lock);
  ...
  [10]
  raw_spin_lock(A->pi_lock);

				[11]
				rt_mutex_enqueue_pi();
				// observes inconsistent A->pi_waiters
				// tree order

Fixing this means either extending the range of the owner lock from
[10-13] to [6-13], with the immediate problem that this means [6-8]
hold both blocked and owner locks, or duplicating the sort key.

Since the locking in chain walk is horrible enough without having to
consider pi_lock nesting rules, duplicate the sort key instead.

By giving each tree their own sort key, the above race becomes
harmless, if C sees B at the old location, then B will correct things
(if they need correcting) when it walks up the chain and reaches A.

Fixes: fb00aca47440 ("rtmutex: Turn the plist into an rb-tree")
Reported-by: Henry Wu <triangletrap12@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rtmutex.c        |  170 ++++++++++++++++++++++++++--------------
 kernel/locking/rtmutex_api.c    |    2 
 kernel/locking/rtmutex_common.h |   47 ++++++++---
 kernel/locking/ww_mutex.h       |   12 +-
 4 files changed, 155 insertions(+), 76 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -333,21 +333,43 @@ static __always_inline int __waiter_prio
 	return prio;
 }
 
+/*
+ * Update the waiter->tree copy of the sort keys.
+ */
 static __always_inline void
 waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	waiter->prio = __waiter_prio(task);
-	waiter->deadline = task->dl.deadline;
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->tree.entry));
+
+	waiter->tree.prio = __waiter_prio(task);
+	waiter->tree.deadline = task->dl.deadline;
+}
+
+/*
+ * Update the waiter->pi_tree copy of the sort keys (from the tree copy).
+ */
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	lockdep_assert_held(&waiter->lock->wait_lock);
+	lockdep_assert_held(&task->pi_lock);
+	lockdep_assert(RB_EMPTY_NODE(&waiter->pi_tree.entry));
+
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Only use with rt_waiter_node_{less,equal}()
  */
+#define task_to_waiter_node(p)	\
+	&(struct rt_waiter_node){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .tree = *task_to_waiter_node(p) }
 
-static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
-						struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_less(struct rt_waiter_node *left,
+					       struct rt_waiter_node *right)
 {
 	if (left->prio < right->prio)
 		return 1;
@@ -364,8 +386,8 @@ static __always_inline int rt_mutex_wait
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -385,7 +407,7 @@ static __always_inline int rt_mutex_wait
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -393,30 +415,30 @@ static inline bool rt_mutex_steal(struct
 	 * Note that RT tasks are excluded from same priority (lateral)
 	 * steals to prevent the introduction of an unbounded latency.
 	 */
-	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+	if (rt_prio(waiter->tree.prio) || dl_prio(waiter->tree.prio))
 		return false;
 
-	return rt_mutex_waiter_equal(waiter, top_waiter);
+	return rt_waiter_node_equal(&waiter->tree, &top_waiter->tree);
 #else
 	return false;
 #endif
 }
 
 #define __node_2_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+	rb_entry((node), struct rt_mutex_waiter, tree.entry)
 
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
 {
 	struct rt_mutex_waiter *aw = __node_2_waiter(a);
 	struct rt_mutex_waiter *bw = __node_2_waiter(b);
 
-	if (rt_mutex_waiter_less(aw, bw))
+	if (rt_waiter_node_less(&aw->tree, &bw->tree))
 		return 1;
 
 	if (!build_ww_mutex())
 		return 0;
 
-	if (rt_mutex_waiter_less(bw, aw))
+	if (rt_waiter_node_less(&bw->tree, &aw->tree))
 		return 0;
 
 	/* NOTE: relies on waiter->ww_ctx being set before insertion */
@@ -434,48 +456,58 @@ static __always_inline bool __waiter_les
 static __always_inline void
 rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
+	lockdep_assert_held(&lock->wait_lock);
+
+	rb_add_cached(&waiter->tree.entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->tree_entry))
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (RB_EMPTY_NODE(&waiter->tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->tree_entry, &lock->waiters);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	rb_erase_cached(&waiter->tree.entry, &lock->waiters);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 }
 
-#define __node_2_pi_waiter(node) \
-	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+#define __node_2_rt_node(node) \
+	rb_entry((node), struct rt_waiter_node, entry)
 
-static __always_inline bool
-__pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+static __always_inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+	return rt_waiter_node_less(__node_2_rt_node(a), __node_2_rt_node(b));
 }
 
 static __always_inline void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
+	lockdep_assert_held(&task->pi_lock);
+
+	rb_add_cached(&waiter->pi_tree.entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->pi_tree_entry))
+	lockdep_assert_held(&task->pi_lock);
+
+	if (RB_EMPTY_NODE(&waiter->pi_tree.entry))
 		return;
 
-	rb_erase_cached(&waiter->pi_tree_entry, &task->pi_waiters);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	rb_erase_cached(&waiter->pi_tree.entry, &task->pi_waiters);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
 }
 
-static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
+static __always_inline void rt_mutex_adjust_prio(struct rt_mutex_base *lock,
+						 struct task_struct *p)
 {
 	struct task_struct *pi_task = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+	lockdep_assert(rt_mutex_owner(lock) == p);
 	lockdep_assert_held(&p->pi_lock);
 
 	if (task_has_pi_waiters(p))
@@ -571,9 +603,14 @@ static __always_inline struct rt_mutex_b
  * Chain walk basics and protection scope
  *
  * [R] refcount on task
- * [P] task->pi_lock held
+ * [Pn] task->pi_lock held
  * [L] rtmutex->wait_lock held
  *
+ * Normal locking order:
+ *
+ *   rtmutex->wait_lock
+ *     task->pi_lock
+ *
  * Step	Description				Protected by
  *	function arguments:
  *	@task					[R]
@@ -588,27 +625,32 @@ static __always_inline struct rt_mutex_b
  *	again:
  *	  loop_sanity_check();
  *	retry:
- * [1]	  lock(task->pi_lock);			[R] acquire [P]
- * [2]	  waiter = task->pi_blocked_on;		[P]
- * [3]	  check_exit_conditions_1();		[P]
- * [4]	  lock = waiter->lock;			[P]
- * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
- *	    unlock(task->pi_lock);		release [P]
+ * [1]	  lock(task->pi_lock);			[R] acquire [P1]
+ * [2]	  waiter = task->pi_blocked_on;		[P1]
+ * [3]	  check_exit_conditions_1();		[P1]
+ * [4]	  lock = waiter->lock;			[P1]
+ * [5]	  if (!try_lock(lock->wait_lock)) {	[P1] try to acquire [L]
+ *	    unlock(task->pi_lock);		release [P1]
  *	    goto retry;
  *	  }
- * [6]	  check_exit_conditions_2();		[P] + [L]
- * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
- * [8]	  unlock(task->pi_lock);		release [P]
+ * [6]	  check_exit_conditions_2();		[P1] + [L]
+ * [7]	  requeue_lock_waiter(lock, waiter);	[P1] + [L]
+ * [8]	  unlock(task->pi_lock);		release [P1]
  *	  put_task_struct(task);		release [R]
  * [9]	  check_exit_conditions_3();		[L]
  * [10]	  task = owner(lock);			[L]
  *	  get_task_struct(task);		[L] acquire [R]
- *	  lock(task->pi_lock);			[L] acquire [P]
- * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
- * [12]	  check_exit_conditions_4();		[P] + [L]
- * [13]	  unlock(task->pi_lock);		release [P]
+ *	  lock(task->pi_lock);			[L] acquire [P2]
+ * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P2] + [L]
+ * [12]	  check_exit_conditions_4();		[P2] + [L]
+ * [13]	  unlock(task->pi_lock);		release [P2]
  *	  unlock(lock->wait_lock);		release [L]
  *	  goto again;
+ *
+ * Where P1 is the blocking task and P2 is the lock owner; going up one step
+ * the owner becomes the next blocked task etc..
+ *
+*
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
@@ -756,7 +798,7 @@ static int __sched rt_mutex_adjust_prio_
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -764,13 +806,18 @@ static int __sched rt_mutex_adjust_prio_
 	}
 
 	/*
-	 * [4] Get the next lock
+	 * [4] Get the next lock; per holding task->pi_lock we can't unblock
+	 * and guarantee @lock's existence.
 	 */
 	lock = waiter->lock;
 	/*
 	 * [5] We need to trylock here as we are holding task->pi_lock,
 	 * which is the reverse lock order versus the other rtmutex
 	 * operations.
+	 *
+	 * Per the above, holding task->pi_lock guarantees lock exists, so
+	 * inverting this lock order is infeasible from a life-time
+	 * perspective.
 	 */
 	if (!raw_spin_trylock(&lock->wait_lock)) {
 		raw_spin_unlock_irq(&task->pi_lock);
@@ -874,17 +921,18 @@ static int __sched rt_mutex_adjust_prio_
 	 * or
 	 *
 	 *   DL CBS enforcement advancing the effective deadline.
-	 *
-	 * Even though pi_waiters also uses these fields, and that tree is only
-	 * updated in [11], we can do this here, since we hold [L], which
-	 * serializes all pi_waiters access and rb_erase() does not care about
-	 * the values of the node being removed.
 	 */
 	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
-	/* [8] Release the task */
+	/*
+	 * [8] Release the (blocking) task in preparation for
+	 * taking the owner task in [10].
+	 *
+	 * Since we hold lock->waiter_lock, task cannot unblock, even if we
+	 * release task->pi_lock.
+	 */
 	raw_spin_unlock(&task->pi_lock);
 	put_task_struct(task);
 
@@ -908,7 +956,12 @@ static int __sched rt_mutex_adjust_prio_
 		return 0;
 	}
 
-	/* [10] Grab the next task, i.e. the owner of @lock */
+	/*
+	 * [10] Grab the next task, i.e. the owner of @lock
+	 *
+	 * Per holding lock->wait_lock and checking for !owner above, there
+	 * must be an owner and it cannot go away.
+	 */
 	task = get_task_struct(rt_mutex_owner(lock));
 	raw_spin_lock(&task->pi_lock);
 
@@ -921,8 +974,9 @@ static int __sched rt_mutex_adjust_prio_
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -937,8 +991,9 @@ static int __sched rt_mutex_adjust_prio_
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
+		waiter_clone_prio(waiter, task);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1154,6 +1209,7 @@ static int __sched task_blocks_on_rt_mut
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1187,7 +1243,7 @@ static int __sched task_blocks_on_rt_mut
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1234,6 +1290,8 @@ static void __sched mark_wakeup_next_wai
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1246,7 +1304,7 @@ static void __sched mark_wakeup_next_wai
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1482,7 +1540,7 @@ static void __sched remove_waiter(struct
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -459,7 +459,7 @@ void __sched rt_mutex_adjust_pi(struct t
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -17,27 +17,44 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
+
+/*
+ * This is a helper for the struct rt_mutex_waiter below. A waiter goes in two
+ * separate trees and they need their own copy of the sort keys because of
+ * different locking requirements.
+ *
+ * @entry:		rbtree node to enqueue into the waiters tree
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
+ *
+ * See rt_waiter_node_less() and waiter_*_prio().
+ */
+struct rt_waiter_node {
+	struct rb_node	entry;
+	int		prio;
+	u64		deadline;
+};
+
 /*
  * This is the control structure for tasks blocked on a rt_mutex,
  * which is allocated on the kernel stack on of the blocked task.
  *
- * @tree_entry:		pi node to enqueue into the mutex waiters tree
- * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
+ * @tree:		node to enqueue into the mutex waiters tree
+ * @pi_tree:		node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
- * @prio:		Priority of the waiter
- * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
+ *
+ * @tree is ordered by @lock->wait_lock
+ * @pi_tree is ordered by rt_mutex_owner(@lock)->pi_lock
  */
 struct rt_mutex_waiter {
-	struct rb_node		tree_entry;
-	struct rb_node		pi_tree_entry;
+	struct rt_waiter_node	tree;
+	struct rt_waiter_node	pi_tree;
 	struct task_struct	*task;
 	struct rt_mutex_base	*lock;
 	unsigned int		wake_state;
-	int			prio;
-	u64			deadline;
 	struct ww_acquire_ctx	*ww_ctx;
 };
 
@@ -105,7 +122,7 @@ static inline bool rt_mutex_waiter_is_to
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 
-	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree.entry) == waiter;
 }
 
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
@@ -113,8 +130,10 @@ static inline struct rt_mutex_waiter *rt
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w = NULL;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	if (leftmost) {
-		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree.entry);
 		BUG_ON(w->lock != lock);
 	}
 	return w;
@@ -127,8 +146,10 @@ static inline int task_has_pi_waiters(st
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
+
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
-			pi_tree_entry);
+			pi_tree.entry);
 }
 
 #define RT_MUTEX_HAS_WAITERS	1UL
@@ -190,8 +211,8 @@ static inline void debug_rt_mutex_free_w
 static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 {
 	debug_rt_mutex_init_waiter(waiter);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
+	RB_CLEAR_NODE(&waiter->pi_tree.entry);
+	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
 }
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -96,25 +96,25 @@ __ww_waiter_first(struct rt_mutex *lock)
 	struct rb_node *n = rb_first(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_next(&w->tree_entry);
+	struct rb_node *n = rb_next(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
 __ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
 {
-	struct rb_node *n = rb_prev(&w->tree_entry);
+	struct rb_node *n = rb_prev(&w->tree.entry);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline struct rt_mutex_waiter *
@@ -123,7 +123,7 @@ __ww_waiter_last(struct rt_mutex *lock)
 	struct rb_node *n = rb_last(&lock->rtmutex.waiters.rb_root);
 	if (!n)
 		return NULL;
-	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+	return rb_entry(n, struct rt_mutex_waiter, tree.entry);
 }
 
 static inline void
