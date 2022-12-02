Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3CF6403F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiLBKCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiLBKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:02:40 -0500
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1532195
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:02:38 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 7EDB61FC1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:02:36 +0000 (GMT)
Received: (qmail 18455 invoked from network); 2 Dec 2022 10:02:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Dec 2022 10:02:36 -0000
Date:   Fri, 2 Dec 2022 10:02:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-RT <linux-rt-users@vger.kernel.org>
Subject: [PATCH] rtmutex: Add acquire semantics for rtmutex lock acquisition
Message-ID: <20221202100223.6mevpbl7i6x5udfd@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara reported the following bug triggering on 6.0.5-rt14 running
dbench on XFS on arm64.

 kernel BUG at fs/inode.c:625!
 Internal error: Oops - BUG: 0 [#1] PREEMPT_RT SMP
 CPU: 11 PID: 6611 Comm: dbench Tainted: G            E   6.0.0-rt14-rt+ #1
 Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG
 pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : clear_inode+0xa0/0xc0
 lr : clear_inode+0x38/0xc0
 sp : ffff80000f4f3cd0
 x29: ffff80000f4f3cd0 x28: ffff07ff92142000 x27: 0000000000000000
 x26: ffff08012aef6058 x25: 0000000000000002 x24: ffffb657395e8000
 x23: ffffb65739072008 x22: ffffb656e0bed0a8 x21: ffff08012aef6190
 x20: ffff08012aef61f8 x19: ffff08012aef6058 x18: 0000000000000014
 x17: 00000000f0d86255 x16: ffffb65737dfdb00 x15: 0100000004000000
 x14: 644d000008090000 x13: 644d000008090000 x12: ffff80000f4f3b20
 x11: 0000000000000002 x10: ffff083f5ffbe1c0 x9 : ffffb657388284a4
 x8 : fffffffffffffffe x7 : ffff80000f4f3b20 x6 : ffff80000f4f3b20
 x5 : ffff08012aef6210 x4 : ffff08012aef6210 x3 : 0000000000000000
 x2 : ffff08012aef62d8 x1 : ffff07ff8fbbf690 x0 : ffff08012aef61a0
 Call trace:
  clear_inode+0xa0/0xc0
  evict+0x160/0x180
  iput+0x154/0x240
  do_unlinkat+0x184/0x300
  __arm64_sys_unlinkat+0x48/0xc0
  el0_svc_common.constprop.4+0xe4/0x2c0
  do_el0_svc+0xac/0x100
  el0_svc+0x78/0x200
  el0t_64_sync_handler+0x9c/0xc0
  el0t_64_sync+0x19c/0x1a0

It also affects 6.1-rc7-rt5 and affects a preempt-rt fork of 5.14 so this is
likely a bug that existed forever and only became visible when ARM support
was added to preempt-rt. The same problem does not occur on x86-64 and he
also reported that converting sb->s_inode_wblist_lock to raw_spinlock_t makes
the problem disappear indicating that the RT spinlock variant is the problem.

Will Deacon observed

	I'd be more inclined to be suspicious of the slowpath tbh, as we
	need to make sure that we have acquire semantics on all paths
	where the lock can be taken. Looking at the rtmutex code, this
	really isn't obvious to me -- for example, try_to_take_rt_mutex()
	appears to be able to return via the 'takeit' label without acquire
	semantics and it looks like we might be relying on the caller's
	subsequent _unlock_ of the wait_lock for ordering, but that will
	give us release semantics which aren't correct.

Sebastian Andrzej Siewior prototyped a fix that does work based on that
comment but it was a little bit overkill and added some fences that
should not be necessary.

The lock owner is updated with an IRQ-safe raw spinlock held but the
spin_unlock does not provide acquire semantics which are needed when
acquiring a mutex. This patch adds the necessary acquire semantics for a
lock operation when the lock owner is updated. It successfully completed
10 iterations of the dbench workload while the vanilla kernel fails on
the first iteration.

[bigeasy@linutronix.de: Initial prototype fix]
Reported-by: Jan Kara <jack@suse.cz>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/locking/rtmutex.c     | 48 +++++++++++++++++++++++++++++++++++---------
 kernel/locking/rtmutex_api.c |  6 +++---
 2 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7779ee8abc2a..35212f260148 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -89,15 +89,33 @@ static inline int __ww_mutex_check_kill(struct rt_mutex *lock,
  * set this bit before looking at the lock.
  */
 
-static __always_inline void
-rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
+static __always_inline struct task_struct *
+rt_mutex_owner_encode(struct rt_mutex_base *lock, struct task_struct *owner)
 {
 	unsigned long val = (unsigned long)owner;
 
 	if (rt_mutex_has_waiters(lock))
 		val |= RT_MUTEX_HAS_WAITERS;
 
-	WRITE_ONCE(lock->owner, (struct task_struct *)val);
+	return (struct task_struct *)val;
+}
+
+
+static __always_inline void
+rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
+{
+	/*
+	 * lock->wait_lock is held but explicit acquire semantics are needed
+	 * for a new lock owner so WRITE_ONCE is insufficient.
+	 */
+	xchg_acquire(&lock->owner, rt_mutex_owner_encode(lock, owner));
+}
+
+static __always_inline void
+rt_mutex_clear_owner(struct rt_mutex_base *lock)
+{
+	/* lock->wait_lock is held so the unlock provides release semantics. */
+	WRITE_ONCE(lock->owner, rt_mutex_owner_encode(lock, NULL));
 }
 
 static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
@@ -106,7 +124,8 @@ static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *lock)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
 
-static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
+static __always_inline void
+fixup_rt_mutex_waiters(struct rt_mutex_base *lock, bool acquire_lock)
 {
 	unsigned long owner, *p = (unsigned long *) &lock->owner;
 
@@ -172,8 +191,19 @@ static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *lock)
 	 * still set.
 	 */
 	owner = READ_ONCE(*p);
-	if (owner & RT_MUTEX_HAS_WAITERS)
-		WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
+	if (owner & RT_MUTEX_HAS_WAITERS) {
+		/*
+		 * See comments in rt_mutex_set_owner and
+		 * rt_mutex_clear_owner on why xchg_acquire is used for
+		 * updating owner for locking and WRITE_ONCE for unlocking.
+		 * WRITE_ONCE would work for both here although other lock
+		 * acquisitions may enter the slow path unnecessarily.
+		 */
+		if (acquire_lock)
+			xchg_acquire(p, owner & ~RT_MUTEX_HAS_WAITERS);
+		else
+			WRITE_ONCE(*p, owner & ~RT_MUTEX_HAS_WAITERS);
+	}
 }
 
 /*
@@ -1243,7 +1273,7 @@ static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 	 * try_to_take_rt_mutex() sets the lock waiters bit
 	 * unconditionally. Clean this up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 
 	return ret;
 }
@@ -1604,7 +1634,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit
 	 * unconditionally. We might have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 
 	trace_contention_end(lock, ret);
 
@@ -1719,7 +1749,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally.
 	 * We might have to fix that up:
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 	debug_rt_mutex_free_waiter(&waiter);
 
 	trace_contention_end(lock, 0);
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 900220941caa..cb9fdff76a8a 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -267,7 +267,7 @@ void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	debug_rt_mutex_proxy_unlock(lock);
-	rt_mutex_set_owner(lock, NULL);
+	rt_mutex_clear_owner(lock);
 }
 
 /**
@@ -382,7 +382,7 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
@@ -438,7 +438,7 @@ bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
 	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
 	 * have to fix that up.
 	 */
-	fixup_rt_mutex_waiters(lock);
+	fixup_rt_mutex_waiters(lock, false);
 
 	raw_spin_unlock_irq(&lock->wait_lock);
 
