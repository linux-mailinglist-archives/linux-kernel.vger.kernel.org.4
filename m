Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2556774B159
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjGGM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:59:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5354C10EC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3R14VpcaeXKa5oUp9oOlFmgo8HiUJUMUPaTmGAG3+9o=; b=p83NCVn6tvmkYdkTfrgjgMK+zr
        l9IhYFtTftioBS2DpXnkBBntyYtjBrMOYvt8VOh1OgE0CnVWc1vQbDUPL+HrdGEk2oJ6smG0YGnjE
        e9wpatEO5mMuAxDycCwDoOFiu9tOO2kIKlNIRT4qzFGFKNj4MyfLdLuMabjTdfQldXYYwo4Td7Fks
        gt8zHdII8p+hbk+AXyI2dmt4tnHehMOxU6eBrxSSpyEfa7GTZULnl0y2Jx+vzVYqB7gdIyPUB/sYb
        GuqdC+NVk+SS40Wr5chqxdCxdGXVoEiUVJgwf4LCV9vcAe3raUZaEcLtRIJTttdxeTkwMZiGcX6Yy
        JK1glU3g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHl3o-00C2Cq-MA; Fri, 07 Jul 2023 12:59:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 41D903001E7;
        Fri,  7 Jul 2023 14:59:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18DE82784D44F; Fri,  7 Jul 2023 14:59:43 +0200 (CEST)
Date:   Fri, 7 Jul 2023 14:59:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henry Wu <triangletrap12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fwd: Possible race in rt_mutex_adjust_prio_chain
Message-ID: <20230707125942.GB2883469@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
 <CAG-UpRTQ-ovVO02HRd5z-9oZGCPvZ0vODJse8oyuA9L-3NV_pQ@mail.gmail.com>
 <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG-UpRRLFTHg64b0hG4=FbuzhhqNQEU8jGt6TygCVAK1BaT2kQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 10:09:04AM +0800, Henry Wu wrote:

> Imagine a scenario that we have two rt_mutex (M1, M2) and three
> threads (A, B, C). Both rt_mutex are owned by thread A. B is blocked
> when acquiring M1 and C is blocked when acquiring M2. We use
> sched_setattr to change priority of B and C.

      A
     / \
    M1  M2
    |   |
    B   C

And in that case L will be two different locks, which I overlooked
yesterday. So L can't save the day.

This means I either need to take P2 earlier in overlap with P1 -- which
is tricky at best -- or duplicate the data to retain consistency.

Duplicating the data would still leave the logical race condition in
that a concurrent observer will not observe the waiter in the 'right'
location, however it should be harmless since both will continue the
propagate their resp state.

The below implements this duplication and seems to not insta-crash.

I'll endeavour to write a few comments and a Changelog to go with it.

---
 kernel/locking/rtmutex.c        | 93 ++++++++++++++++++++++++-----------------
 kernel/locking/rtmutex_api.c    |  2 +-
 kernel/locking/rtmutex_common.h | 34 +++++++++------
 3 files changed, 76 insertions(+), 53 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bb..3af6772cebb6 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -336,18 +336,27 @@ static __always_inline int __waiter_prio(struct task_struct *task)
 static __always_inline void
 waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
 {
-	waiter->prio = __waiter_prio(task);
-	waiter->deadline = task->dl.deadline;
+	waiter->tree.prio = __waiter_prio(task);
+	waiter->tree.deadline = task->dl.deadline;
+}
+
+static __always_inline void
+waiter_clone_prio(struct rt_mutex_waiter *waiter)
+{
+	waiter->pi_tree.prio = waiter->tree.prio;
+	waiter->pi_tree.deadline = waiter->tree.deadline;
 }
 
 /*
- * Only use with rt_mutex_waiter_{less,equal}()
+ * Only use with rt_waiter_node_{less,equal}()
  */
+#define task_to_waiter_node(p) \
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
@@ -364,8 +373,8 @@ static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 	return 0;
 }
 
-static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
-						 struct rt_mutex_waiter *right)
+static __always_inline int rt_waiter_node_equal(struct rt_waiter_node *left,
+						 struct rt_waiter_node *right)
 {
 	if (left->prio != right->prio)
 		return 0;
@@ -385,7 +394,7 @@ static __always_inline int rt_mutex_waiter_equal(struct rt_mutex_waiter *left,
 static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
 				  struct rt_mutex_waiter *top_waiter)
 {
-	if (rt_mutex_waiter_less(waiter, top_waiter))
+	if (rt_waiter_node_less(&waiter->tree, &top_waiter->tree))
 		return true;
 
 #ifdef RT_MUTEX_BUILD_SPINLOCKS
@@ -393,30 +402,30 @@ static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
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
@@ -434,48 +443,54 @@ static __always_inline bool __waiter_less(struct rb_node *a, const struct rb_nod
 static __always_inline void
 rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
+	rb_add_cached(&waiter->tree.entry, &lock->waiters, __waiter_less);
 }
 
 static __always_inline void
 rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
-	if (RB_EMPTY_NODE(&waiter->tree_entry))
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
@@ -756,7 +771,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * enabled we continue, but stop the requeueing in the chain
 	 * walk.
 	 */
-	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		if (!detect_deadlock)
 			goto out_unlock_pi;
 		else
@@ -874,11 +889,6 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
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
 
@@ -921,8 +931,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 * and adjust the priority of the owner.
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
+		waiter_clone_prio(waiter);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -937,8 +948,9 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
+		waiter_clone_prio(waiter);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1154,6 +1166,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	waiter->task = task;
 	waiter->lock = lock;
 	waiter_update_prio(waiter, task);
+	waiter_clone_prio(waiter);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -1187,7 +1200,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1234,6 +1247,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1246,7 +1261,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1482,7 +1497,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index cb9fdff76a8a..a6974d044593 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -459,7 +459,7 @@ void __sched rt_mutex_adjust_pi(struct task_struct *task)
 	raw_spin_lock_irqsave(&task->pi_lock, flags);
 
 	waiter = task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+	if (!waiter || rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
 		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		return;
 	}
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..3d7457bffd43 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -17,27 +17,34 @@
 #include <linux/rtmutex.h>
 #include <linux/sched/wake_q.h>
 
+
+/*
+ * @prio:		Priority of the waiter
+ * @deadline:		Deadline of the waiter if applicable
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
+ * @tree:		pi node to enqueue into the mutex waiters tree
+ * @pi_tree:		pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
  * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
- * @prio:		Priority of the waiter
- * @deadline:		Deadline of the waiter if applicable
  * @ww_ctx:		WW context pointer
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
 
@@ -105,7 +112,7 @@ static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
 
-	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree.entry) == waiter;
 }
 
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
@@ -114,7 +121,7 @@ static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *
 	struct rt_mutex_waiter *w = NULL;
 
 	if (leftmost) {
-		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
+		w = rb_entry(leftmost, struct rt_mutex_waiter, tree.entry);
 		BUG_ON(w->lock != lock);
 	}
 	return w;
@@ -127,8 +134,9 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
-			pi_tree_entry);
+			pi_tree.entry);
 }
 
 #define RT_MUTEX_HAS_WAITERS	1UL
@@ -190,8 +198,8 @@ static inline void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
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
