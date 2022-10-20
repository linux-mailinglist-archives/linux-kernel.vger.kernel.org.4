Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6927605351
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJSWpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJSWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8D175376;
        Wed, 19 Oct 2022 15:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7A05B8261A;
        Wed, 19 Oct 2022 22:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A66CC433B5;
        Wed, 19 Oct 2022 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219537;
        bh=paVOmpF7XtyU/d5w17H73/3RmaPLsYbv0OxL0LchCgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uryazwlc4qC5FFFqM4OhdLriEYNr4o0DQAMfNf4Ektg+QnpczBAYjeEKIw43TiO5X
         2yKB8ZusByznpIc6xVEvXv3H5gMFBBWn1w3c1YZckp7jh64cY/OzqcUuKhpECzZaIR
         FYIhV0CPxe16oivToF1OWDqqwtiuPTRKvjZje+T75kiJ/K705YYaVVNPquHnO1Ch1M
         wCOvPdT/2P0xOJnaLAMbzuZ5wMTSHvbI9WugshQ5XH1PitFJ4Kb1s8RnZ3z3teX8BG
         ZP25yMhv/kzIdzTDqD0RYxjBUuYH1CcX4/lM7uuuk4PdzKxu87x24QNF9K5W0IC3S8
         yHea0RQvByy8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DEBFA5C0890; Wed, 19 Oct 2022 15:45:36 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/4] doc: Update listRCU.rst
Date:   Wed, 19 Oct 2022 15:45:34 -0700
Message-Id: <20221019224535.2499245-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
References: <20221019224528.GA2499145@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates listRCU.txt to reflect RCU additions and changes
over the past few years.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/listRCU.rst | 174 ++++++++++++++++++++--------------
 1 file changed, 103 insertions(+), 71 deletions(-)

diff --git a/Documentation/RCU/listRCU.rst b/Documentation/RCU/listRCU.rst
index 2a643e293fb41..fa5493c1e28f2 100644
--- a/Documentation/RCU/listRCU.rst
+++ b/Documentation/RCU/listRCU.rst
@@ -3,11 +3,10 @@
 Using RCU to Protect Read-Mostly Linked Lists
 =============================================
 
-One of the best applications of RCU is to protect read-mostly linked lists
-(``struct list_head`` in list.h).  One big advantage of this approach
-is that all of the required memory barriers are included for you in
-the list macros.  This document describes several applications of RCU,
-with the best fits first.
+One of the most common uses of RCU is protecting read-mostly linked lists
+(``struct list_head`` in list.h).  One big advantage of this approach is
+that all of the required memory ordering is provided by the list macros.
+This document describes several list-based RCU use cases.
 
 
 Example 1: Read-mostly list: Deferred Destruction
@@ -35,7 +34,8 @@ The code traversing the list of all processes typically looks like::
 	}
 	rcu_read_unlock();
 
-The simplified code for removing a process from a task list is::
+The simplified and heavily inlined code for removing a process from a
+task list is::
 
 	void release_task(struct task_struct *p)
 	{
@@ -45,39 +45,48 @@ The simplified code for removing a process from a task list is::
 		call_rcu(&p->rcu, delayed_put_task_struct);
 	}
 
-When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)`` under
-``tasklist_lock`` writer lock protection, to remove the task from the list of
-all tasks. The ``tasklist_lock`` prevents concurrent list additions/removals
-from corrupting the list. Readers using ``for_each_process()`` are not protected
-with the ``tasklist_lock``. To prevent readers from noticing changes in the list
-pointers, the ``task_struct`` object is freed only after one or more grace
-periods elapse (with the help of call_rcu()). This deferring of destruction
-ensures that any readers traversing the list will see valid ``p->tasks.next``
-pointers and deletion/freeing can happen in parallel with traversal of the list.
-This pattern is also called an **existence lock**, since RCU pins the object in
-memory until all existing readers finish.
+When a process exits, ``release_task()`` calls ``list_del_rcu(&p->tasks)``
+via __exit_signal() and __unhash_process() under ``tasklist_lock``
+writer lock protection.  The list_del_rcu() invocation removes
+the task from the list of all tasks. The ``tasklist_lock``
+prevents concurrent list additions/removals from corrupting the
+list. Readers using ``for_each_process()`` are not protected with the
+``tasklist_lock``. To prevent readers from noticing changes in the list
+pointers, the ``task_struct`` object is freed only after one or more
+grace periods elapse, with the help of call_rcu(), which is invoked via
+put_task_struct_rcu_user(). This deferring of destruction ensures that
+any readers traversing the list will see valid ``p->tasks.next`` pointers
+and deletion/freeing can happen in parallel with traversal of the list.
+This pattern is also called an **existence lock**, since RCU refrains
+from invoking the delayed_put_task_struct() callback function until until
+all existing readers finish, which guarantees that the ``task_struct``
+object in question will remain in existence until after the completion
+of all RCU readers that might possibly have a reference to that object.
 
 
 Example 2: Read-Side Action Taken Outside of Lock: No In-Place Updates
 ----------------------------------------------------------------------
 
-The best applications are cases where, if reader-writer locking were
-used, the read-side lock would be dropped before taking any action
-based on the results of the search.  The most celebrated example is
-the routing table.  Because the routing table is tracking the state of
-equipment outside of the computer, it will at times contain stale data.
-Therefore, once the route has been computed, there is no need to hold
-the routing table static during transmission of the packet.  After all,
-you can hold the routing table static all you want, but that won't keep
-the external Internet from changing, and it is the state of the external
-Internet that really matters.  In addition, routing entries are typically
-added or deleted, rather than being modified in place.
-
-A straightforward example of this use of RCU may be found in the
-system-call auditing support.  For example, a reader-writer locked
+Some reader-writer locking use cases compute a value while holding
+the read-side lock, but continue to use that value after that lock is
+released.  These use cases are often good candidates for conversion
+to RCU.  One prominent example involves network packet routing.
+Because the packet-routing data tracks the state of equipment outside
+of the computer, it will at times contain stale data.  Therefore, once
+the route has been computed, there is no need to hold the routing table
+static during transmission of the packet.  After all, you can hold the
+routing table static all you want, but that won't keep the external
+Internet from changing, and it is the state of the external Internet
+that really matters.  In addition, routing entries are typically added
+or deleted, rather than being modified in place.  This is a rare example
+of the finite speed of light and the non-zero size of atoms actually
+helping make synchronization be lighter weight.
+
+A straightforward example of this type of RCU use case may be found in
+the system-call auditing support.  For example, a reader-writer locked
 implementation of ``audit_filter_task()`` might be as follows::
 
-	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	{
 		struct audit_entry *e;
 		enum audit_state   state;
@@ -86,6 +95,8 @@ implementation of ``audit_filter_task()`` might be as follows::
 		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+				if (state == AUDIT_STATE_RECORD)
+					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 				read_unlock(&auditsc_lock);
 				return state;
 			}
@@ -101,7 +112,7 @@ you are turning auditing off, it is OK to audit a few extra system calls.
 
 This means that RCU can be easily applied to the read side, as follows::
 
-	static enum audit_state audit_filter_task(struct task_struct *tsk)
+	static enum audit_state audit_filter_task(struct task_struct *tsk, char **key)
 	{
 		struct audit_entry *e;
 		enum audit_state   state;
@@ -110,6 +121,8 @@ This means that RCU can be easily applied to the read side, as follows::
 		/* Note: audit_filter_mutex held by caller. */
 		list_for_each_entry_rcu(e, &audit_tsklist, list) {
 			if (audit_filter_rules(tsk, &e->rule, NULL, &state)) {
+				if (state == AUDIT_STATE_RECORD)
+					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 				rcu_read_unlock();
 				return state;
 			}
@@ -118,13 +131,15 @@ This means that RCU can be easily applied to the read side, as follows::
 		return AUDIT_BUILD_CONTEXT;
 	}
 
-The ``read_lock()`` and ``read_unlock()`` calls have become rcu_read_lock()
-and rcu_read_unlock(), respectively, and the list_for_each_entry() has
-become list_for_each_entry_rcu().  The **_rcu()** list-traversal primitives
-insert the read-side memory barriers that are required on DEC Alpha CPUs.
+The read_lock() and read_unlock() calls have become rcu_read_lock()
+and rcu_read_unlock(), respectively, and the list_for_each_entry()
+has become list_for_each_entry_rcu().  The **_rcu()** list-traversal
+primitives add READ_ONCE() and diagnostic checks for incorrect use
+outside of an RCU read-side critical section.
 
 The changes to the update side are also straightforward. A reader-writer lock
-might be used as follows for deletion and insertion::
+might be used as follows for deletion and insertion in these simplified
+versions of audit_del_rule() and audit_add_rule()::
 
 	static inline int audit_del_rule(struct audit_rule *rule,
 					 struct list_head *list)
@@ -188,16 +203,16 @@ Following are the RCU equivalents for these two functions::
 		return 0;
 	}
 
-Normally, the ``write_lock()`` and ``write_unlock()`` would be replaced by a
+Normally, the write_lock() and write_unlock() would be replaced by a
 spin_lock() and a spin_unlock(). But in this case, all callers hold
 ``audit_filter_mutex``, so no additional locking is required. The
-``auditsc_lock`` can therefore be eliminated, since use of RCU eliminates the
+auditsc_lock can therefore be eliminated, since use of RCU eliminates the
 need for writers to exclude readers.
 
 The list_del(), list_add(), and list_add_tail() primitives have been
 replaced by list_del_rcu(), list_add_rcu(), and list_add_tail_rcu().
-The **_rcu()** list-manipulation primitives add memory barriers that are needed on
-weakly ordered CPUs (most of them!).  The list_del_rcu() primitive omits the
+The **_rcu()** list-manipulation primitives add memory barriers that are
+needed on weakly ordered CPUs.  The list_del_rcu() primitive omits the
 pointer poisoning debug-assist code that would otherwise cause concurrent
 readers to fail spectacularly.
 
@@ -238,7 +253,9 @@ need to be filled in)::
 The RCU version creates a copy, updates the copy, then replaces the old
 entry with the newly updated entry.  This sequence of actions, allowing
 concurrent reads while making a copy to perform an update, is what gives
-RCU (*read-copy update*) its name.  The RCU code is as follows::
+RCU (*read-copy update*) its name.
+
+The RCU version of audit_upd_rule() is as follows::
 
 	static inline int audit_upd_rule(struct audit_rule *rule,
 					 struct list_head *list,
@@ -267,6 +284,9 @@ RCU (*read-copy update*) its name.  The RCU code is as follows::
 Again, this assumes that the caller holds ``audit_filter_mutex``.  Normally, the
 writer lock would become a spinlock in this sort of code.
 
+The update_lsm_rule() does something very similar, for those who would
+prefer to look at real Linux-kernel code.
+
 Another use of this pattern can be found in the openswitch driver's *connection
 tracking table* code in ``ct_limit_set()``.  The table holds connection tracking
 entries and has a limit on the maximum entries.  There is one such table
@@ -281,9 +301,10 @@ Example 4: Eliminating Stale Data
 ---------------------------------
 
 The auditing example above tolerates stale data, as do most algorithms
-that are tracking external state.  Because there is a delay from the
-time the external state changes before Linux becomes aware of the change,
-additional RCU-induced staleness is generally not a problem.
+that are tracking external state.  After all, given there is a delay
+from the time the external state changes before Linux becomes aware
+of the change, and so as noted earlier, a small quantity of additional
+RCU-induced staleness is generally not a problem.
 
 However, there are many examples where stale data cannot be tolerated.
 One example in the Linux kernel is the System V IPC (see the shm_lock()
@@ -302,7 +323,7 @@ Quick Quiz:
 
 If the system-call audit module were to ever need to reject stale data, one way
 to accomplish this would be to add a ``deleted`` flag and a ``lock`` spinlock to the
-audit_entry structure, and modify ``audit_filter_task()`` as follows::
+``audit_entry`` structure, and modify audit_filter_task() as follows::
 
 	static enum audit_state audit_filter_task(struct task_struct *tsk)
 	{
@@ -319,6 +340,8 @@ audit_entry structure, and modify ``audit_filter_task()`` as follows::
 					return AUDIT_BUILD_CONTEXT;
 				}
 				rcu_read_unlock();
+				if (state == AUDIT_STATE_RECORD)
+					*key = kstrdup(e->rule.filterkey, GFP_ATOMIC);
 				return state;
 			}
 		}
@@ -326,12 +349,6 @@ audit_entry structure, and modify ``audit_filter_task()`` as follows::
 		return AUDIT_BUILD_CONTEXT;
 	}
 
-Note that this example assumes that entries are only added and deleted.
-Additional mechanism is required to deal correctly with the update-in-place
-performed by ``audit_upd_rule()``.  For one thing, ``audit_upd_rule()`` would
-need additional memory barriers to ensure that the list_add_rcu() was really
-executed before the list_del_rcu().
-
 The ``audit_del_rule()`` function would need to set the ``deleted`` flag under the
 spinlock as follows::
 
@@ -357,24 +374,32 @@ spinlock as follows::
 
 This too assumes that the caller holds ``audit_filter_mutex``.
 
+Note that this example assumes that entries are only added and deleted.
+Additional mechanism is required to deal correctly with the update-in-place
+performed by audit_upd_rule().  For one thing, audit_upd_rule() would
+need to hold the locks of both the old ``audit_entry`` and its replacement
+while executing the list_replace_rcu().
+
 
 Example 5: Skipping Stale Objects
 ---------------------------------
 
-For some usecases, reader performance can be improved by skipping stale objects
-during read-side list traversal if the object in concern is pending destruction
-after one or more grace periods. One such example can be found in the timerfd
-subsystem. When a ``CLOCK_REALTIME`` clock is reprogrammed - for example due to
-setting of the system time, then all programmed timerfds that depend on this
-clock get triggered and processes waiting on them to expire are woken up in
-advance of their scheduled expiry. To facilitate this, all such timers are added
-to an RCU-managed ``cancel_list`` when they are setup in
+For some use cases, reader performance can be improved by skipping
+stale objects during read-side list traversal, where stale objects
+are those that will be removed and destroyed after one or more grace
+periods. One such example can be found in the timerfd subsystem. When a
+``CLOCK_REALTIME`` clock is reprogrammed (for example due to setting
+of the system time) then all programmed ``timerfds`` that depend on
+this clock get triggered and processes waiting on them are awakened in
+advance of their scheduled expiry. To facilitate this, all such timers
+are added to an RCU-managed ``cancel_list`` when they are setup in
 ``timerfd_setup_cancel()``::
 
 	static void timerfd_setup_cancel(struct timerfd_ctx *ctx, int flags)
 	{
 		spin_lock(&ctx->cancel_lock);
-		if ((ctx->clockid == CLOCK_REALTIME &&
+		if ((ctx->clockid == CLOCK_REALTIME ||
+		     ctx->clockid == CLOCK_REALTIME_ALARM) &&
 		    (flags & TFD_TIMER_ABSTIME) && (flags & TFD_TIMER_CANCEL_ON_SET)) {
 			if (!ctx->might_cancel) {
 				ctx->might_cancel = true;
@@ -382,13 +407,16 @@ to an RCU-managed ``cancel_list`` when they are setup in
 				list_add_rcu(&ctx->clist, &cancel_list);
 				spin_unlock(&cancel_lock);
 			}
+		} else {
+			__timerfd_remove_cancel(ctx);
 		}
 		spin_unlock(&ctx->cancel_lock);
 	}
 
-When a timerfd is freed (fd is closed), then the ``might_cancel`` flag of the
-timerfd object is cleared, the object removed from the ``cancel_list`` and
-destroyed::
+When a timerfd is freed (fd is closed), then the ``might_cancel``
+flag of the timerfd object is cleared, the object removed from the
+``cancel_list`` and destroyed, as shown in this simplified and inlined
+version of timerfd_release()::
 
 	int timerfd_release(struct inode *inode, struct file *file)
 	{
@@ -403,7 +431,10 @@ destroyed::
 		}
 		spin_unlock(&ctx->cancel_lock);
 
-		hrtimer_cancel(&ctx->t.tmr);
+		if (isalarm(ctx))
+			alarm_cancel(&ctx->t.alarm);
+		else
+			hrtimer_cancel(&ctx->t.tmr);
 		kfree_rcu(ctx, rcu);
 		return 0;
 	}
@@ -416,6 +447,7 @@ objects::
 
 	void timerfd_clock_was_set(void)
 	{
+		ktime_t moffs = ktime_mono_to_real(0);
 		struct timerfd_ctx *ctx;
 		unsigned long flags;
 
@@ -424,7 +456,7 @@ objects::
 			if (!ctx->might_cancel)
 				continue;
 			spin_lock_irqsave(&ctx->wqh.lock, flags);
-			if (ctx->moffs != ktime_mono_to_real(0)) {
+			if (ctx->moffs != moffs) {
 				ctx->moffs = KTIME_MAX;
 				ctx->ticks++;
 				wake_up_locked_poll(&ctx->wqh, EPOLLIN);
@@ -434,10 +466,10 @@ objects::
 		rcu_read_unlock();
 	}
 
-The key point here is, because RCU-traversal of the ``cancel_list`` happens
-while objects are being added and removed to the list, sometimes the traversal
-can step on an object that has been removed from the list. In this example, it
-is seen that it is better to skip such objects using a flag.
+The key point is that because RCU-protected traversal of the
+``cancel_list`` happens concurrently with object addition and removal,
+sometimes the traversal can access an object that has been removed from
+the list. In this example, a flag is used to skip such objects.
 
 
 Summary
-- 
2.31.1.189.g2e36527f23

