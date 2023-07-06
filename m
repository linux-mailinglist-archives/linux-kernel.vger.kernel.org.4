Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB7B74A49A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGFT6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGFT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:58:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA581BF0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5tMgPCFiF6pScKtxAU3ifxawh6D015g8mujt1W1PtKQ=; b=PBKdUm/ebLdz562oD0liHIr4oo
        J3Q12UWJLdWHxQ/o1Cs7WEgqyuATgQb4KNHSDJKNBhii5y9kbzKnVq8RCgZh59lJ3t5tjDgGpvzgG
        AQgOPN3RzTPiQCrHIole+FlLwOgmRjPbh9he0vvJGmGxHrQn7oLaO9KgWASjmqje3/rLUcU8SHBTI
        x+OJPLb7mL4xLITX+3/NMP4UEEivg2nuSBMAT83jivp0ZSU09nKsbZocYpTtCpOiHQBfxxGXxX6o2
        XYNeD37RR8k7+VzmILNDyYPJc8oTVu+296jpgy9i7dAbN9vDfNqEOvv2w+7O++bvcTIRptR0crptJ
        8AiuCfKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHV7R-00Deu3-2P;
        Thu, 06 Jul 2023 19:58:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 91E86300095;
        Thu,  6 Jul 2023 21:58:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7536E200869AF; Thu,  6 Jul 2023 21:58:24 +0200 (CEST)
Date:   Thu, 6 Jul 2023 21:58:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Henry Wu <triangletrap12@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Possible race in rt_mutex_adjust_prio_chain
Message-ID: <20230706195824.GA2862508@hirez.programming.kicks-ass.net>
References: <CAG-UpRQsdL_Fs9HSEv2pDYXehJC+YXcYjiZKFLvkGBTZkkaTcg@mail.gmail.com>
 <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706120103.GJ2833176@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:01:03PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 06, 2023 at 02:08:20PM +0800, Henry Wu wrote:
> > Hi,
> > 
> > I found that it's not safe to change waiter->prio after waiter
> > dequeued from mutex's waiter rbtree because it's still on owner's
> > pi_waiters rbtree. From my analysis, waiters on pi_waiters rbtree
> > should be protected by pi_lock of task which have pi_waiters and
> > corresponding rt_mutex's wait_lock, but pi_waiters is shared by many
> > locks owned by this task, so actually we serialize changes on
> > pi_waiters only by pi_lock.
> > 
> > `rt_mutex_adjust_prio_chain' changes key of nodes of pi_waiters rbtree
> > without pi_lock and pi_waiters rbtree's invariant is violated. Maybe
> > we are enqueuing waiter on other cpu and pi_waiters rbtree will be
> > corrupted.
> 
> Are you talking about [7];
> 
> Where we do waiter_update_prio() while only
> holding [L] rtmutex->wait_lock.
> 
> VS
> 
> rt_mutex_adjust_prio() / task_top_pi_waiter() that accesses ->pi_waiters
> while holding [P] task->pi_lock.
> 
> ?
> 
> I'll go stare at that in more detail -- but I wanted to verify that's
> what you're talking about.

Current notes...

We hold [L] from 5-13; we hold [P1] 1-8 and [P2] 10-13

  P1 - blocked task
  P2 - lock owner

  7  holds [L]+[P1]
     modifies the values, which, temporarily, messes up the pi_waiters tree

  11 holds [L]+[P2]
     requeues the waiter on pi_waiter, restoring pi_waiters tree

pi_waiters is modified by:

  - rt_mutex_{en,de}queue_pi(); which are used:

   - [11] (holds [L]+[P2])
   - try_to_wake_rt_mutex() [L]+[P3] ?!? (P3 will be owner,
					  but is not yet)
   - task_blocks_on_rt_mutex() [L]+[P2]
   - mark_wakeup_next_waiter() [L]+[P2] (current is owner,
					 gives up lock)
   - remove_waiter() [L]+[P2]

pi_waiters is used by:

  - task_top_pi_waiter(), asserts [P], this is used:

    - rt_mutex_adjust_prio(), which asserts [P2] (*), is used:

      - [11] (holds [L])
      - task_blocks_on_rt_mutex() (holds [L])
      - mark_wakeup_next_waiter() (holds [L])
      - remove_waiter() (holds [L])

      (*)(see patch below -- adding more assertions)

    - [3] -- does *NOT* hold [L], does hold [P]


Now, [3] doesn't hold [L], but since 'all' modifications are done under
[L]+[P], just holding [P] should provide a stable read. Except [7], that
messes up the tree while not holding (the right!) [P].

It's late, I'll have to continue staring at this tomorrow!


---
 kernel/locking/rtmutex.c        | 17 +++++++++++------
 kernel/locking/rtmutex_common.h |  1 +
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bb..ff64054fc24c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -472,10 +472,13 @@ rt_mutex_dequeue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->pi_tree_entry);
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
@@ -922,7 +925,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		 */
 		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 
 	} else if (prerequeue_top_waiter == waiter) {
 		/*
@@ -938,7 +941,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 		rt_mutex_dequeue_pi(task, waiter);
 		waiter = rt_mutex_top_waiter(lock);
 		rt_mutex_enqueue_pi(task, waiter);
-		rt_mutex_adjust_prio(task);
+		rt_mutex_adjust_prio(lock, task);
 	} else {
 		/*
 		 * Nothing changed. No need to do any priority
@@ -1187,7 +1190,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 		rt_mutex_dequeue_pi(owner, top_waiter);
 		rt_mutex_enqueue_pi(owner, waiter);
 
-		rt_mutex_adjust_prio(owner);
+		rt_mutex_adjust_prio(lock, owner);
 		if (owner->pi_blocked_on)
 			chain_walk = 1;
 	} else if (rt_mutex_cond_detect_deadlock(waiter, chwalk)) {
@@ -1234,6 +1237,8 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 {
 	struct rt_mutex_waiter *waiter;
 
+	lockdep_assert_held(&lock->wait_lock);
+
 	raw_spin_lock(&current->pi_lock);
 
 	waiter = rt_mutex_top_waiter(lock);
@@ -1246,7 +1251,7 @@ static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
 	 * task unblocks.
 	 */
 	rt_mutex_dequeue_pi(current, waiter);
-	rt_mutex_adjust_prio(current);
+	rt_mutex_adjust_prio(lock, current);
 
 	/*
 	 * As we are waking up the top waiter, and the waiter stays
@@ -1482,7 +1487,7 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	if (rt_mutex_has_waiters(lock))
 		rt_mutex_enqueue_pi(owner, rt_mutex_top_waiter(lock));
 
-	rt_mutex_adjust_prio(owner);
+	rt_mutex_adjust_prio(lock, owner);
 
 	/* Store the lock on which owner is blocked or NULL */
 	next_lock = task_blocked_on_lock(owner);
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c47e8361bfb5..a71cd0f2eea9 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -127,6 +127,7 @@ static inline int task_has_pi_waiters(struct task_struct *p)
 
 static inline struct rt_mutex_waiter *task_top_pi_waiter(struct task_struct *p)
 {
+	lockdep_assert_held(&p->pi_lock);
 	return rb_entry(p->pi_waiters.rb_leftmost, struct rt_mutex_waiter,
 			pi_tree_entry);
 }
