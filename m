Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC9605352
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiJSWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiJSWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:45:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4E31781E7;
        Wed, 19 Oct 2022 15:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B404B825C9;
        Wed, 19 Oct 2022 22:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E224C433D6;
        Wed, 19 Oct 2022 22:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219537;
        bh=MrvrWT2HzqZCFa6XSPNVmNYFbGDY/ORhal9YkrY4b6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcFW+asz6TGnQraAJ7OgZU2QhXDkv+09Q4WCbzOBz5unqrjiD83JqK05hg75Y/PCc
         uj9XxI+0SO+J3hDpAu0pOObQ8llz/Dsacrg65f8x8YVwI9R+A44UEr+bQl0DnzcUUM
         QR2JWhU4M7EA2LZns00k8bbtPzwKIl8fcfBXhMrNxgJ7wYGXrBA5Jz+yMZliGRGEhd
         2lE/EkvYJxZ5MXcs1QvWr9GrqUfnBdGXHJDDvQb9DhZJ6WJqmZLO6aQyLFzkb6EmB8
         bmdmzk5PV4HOYYOMt/RmIuC4KfEC8lIBX2owTAHPC+sRseuREvfiVuFiWeDX0iNap9
         /kFR7Zo+H8Wdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC7795C0879; Wed, 19 Oct 2022 15:45:36 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/4] doc: Update checklist.txt
Date:   Wed, 19 Oct 2022 15:45:33 -0700
Message-Id: <20221019224535.2499245-2-paulmck@kernel.org>
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

This commit updates checklist.txt to reflect RCU additions and changes
over the past few years.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 244 +++++++++++++++++++-------------
 1 file changed, 143 insertions(+), 101 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 048c5bc1f813e..cc361fb01ed4e 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -32,8 +32,8 @@ over a rather long period of time, but improvements are always welcome!
 	for lockless updates.  This does result in the mildly
 	counter-intuitive situation where rcu_read_lock() and
 	rcu_read_unlock() are used to protect updates, however, this
-	approach provides the same potential simplifications that garbage
-	collectors do.
+	approach can provide the same simplifications to certain types
+	of lockless algorithms that garbage collectors do.
 
 1.	Does the update code have proper mutual exclusion?
 
@@ -49,12 +49,12 @@ over a rather long period of time, but improvements are always welcome!
 	them -- even x86 allows later loads to be reordered to precede
 	earlier stores), and be prepared to explain why this added
 	complexity is worthwhile.  If you choose #c, be prepared to
-	explain how this single task does not become a major bottleneck on
-	big multiprocessor machines (for example, if the task is updating
-	information relating to itself that other tasks can read, there
-	by definition can be no bottleneck).  Note that the definition
-	of "large" has changed significantly:  Eight CPUs was "large"
-	in the year 2000, but a hundred CPUs was unremarkable in 2017.
+	explain how this single task does not become a major bottleneck
+	on large systems (for example, if the task is updating information
+	relating to itself that other tasks can read, there by definition
+	can be no bottleneck).	Note that the definition of "large" has
+	changed significantly:	Eight CPUs was "large" in the year 2000,
+	but a hundred CPUs was unremarkable in 2017.
 
 2.	Do the RCU read-side critical sections make proper use of
 	rcu_read_lock() and friends?  These primitives are needed
@@ -97,33 +97,38 @@ over a rather long period of time, but improvements are always welcome!
 
 	b.	Proceed as in (a) above, but also maintain per-element
 		locks (that are acquired by both readers and writers)
-		that guard per-element state.  Of course, fields that
-		the readers refrain from accessing can be guarded by
-		some other lock acquired only by updaters, if desired.
+		that guard per-element state.  Fields that the readers
+		refrain from accessing can be guarded by some other lock
+		acquired only by updaters, if desired.
 
-		This works quite well, also.
+		This also works quite well.
 
 	c.	Make updates appear atomic to readers.	For example,
 		pointer updates to properly aligned fields will
 		appear atomic, as will individual atomic primitives.
 		Sequences of operations performed under a lock will *not*
 		appear to be atomic to RCU readers, nor will sequences
-		of multiple atomic primitives.
+		of multiple atomic primitives.	One alternative is to
+		move multiple individual fields to a separate structure,
+		thus solving the multiple-field problem by imposing an
+		additional level of indirection.
 
 		This can work, but is starting to get a bit tricky.
 
-	d.	Carefully order the updates and the reads so that
-		readers see valid data at all phases of the update.
-		This is often more difficult than it sounds, especially
-		given modern CPUs' tendency to reorder memory references.
-		One must usually liberally sprinkle memory barriers
-		(smp_wmb(), smp_rmb(), smp_mb()) through the code,
-		making it difficult to understand and to test.
-
-		It is usually better to group the changing data into
-		a separate structure, so that the change may be made
-		to appear atomic by updating a pointer to reference
-		a new structure containing updated values.
+	d.	Carefully order the updates and the reads so that readers
+		see valid data at all phases of the update.  This is often
+		more difficult than it sounds, especially given modern
+		CPUs' tendency to reorder memory references.  One must
+		usually liberally sprinkle memory-ordering operations
+		through the code, making it difficult to understand and
+		to test.  Where it works, it is better to use things
+		like smp_store_release() and smp_load_acquire(), but in
+		some cases the smp_mb() full memory barrier is required.
+
+		As noted earlier, it is usually better to group the
+		changing data into a separate structure, so that the
+		change may be made to appear atomic by updating a pointer
+		to reference a new structure containing updated values.
 
 4.	Weakly ordered CPUs pose special challenges.  Almost all CPUs
 	are weakly ordered -- even x86 CPUs allow later loads to be
@@ -188,26 +193,29 @@ over a rather long period of time, but improvements are always welcome!
 		when publicizing a pointer to a structure that can
 		be traversed by an RCU read-side critical section.
 
-5.	If call_rcu() or call_srcu() is used, the callback function will
-	be called from softirq context.  In particular, it cannot block.
-	If you need the callback to block, run that code in a workqueue
-	handler scheduled from the callback.  The queue_rcu_work()
-	function does this for you in the case of call_rcu().
+5.	If any of call_rcu(), call_srcu(), call_rcu_tasks(),
+	call_rcu_tasks_rude(), or call_rcu_tasks_trace() is used,
+	the callback function may be invoked from softirq context,
+	and in any case with bottom halves disabled.  In particular,
+	this callback function cannot block.  If you need the callback
+	to block, run that code in a workqueue handler scheduled from
+	the callback.  The queue_rcu_work() function does this for you
+	in the case of call_rcu().
 
 6.	Since synchronize_rcu() can block, it cannot be called
 	from any sort of irq context.  The same rule applies
-	for synchronize_srcu(), synchronize_rcu_expedited(), and
-	synchronize_srcu_expedited().
+	for synchronize_srcu(), synchronize_rcu_expedited(),
+	synchronize_srcu_expedited(), synchronize_rcu_tasks(),
+	synchronize_rcu_tasks_rude(), and synchronize_rcu_tasks_trace().
 
 	The expedited forms of these primitives have the same semantics
-	as the non-expedited forms, but expediting is both expensive and
-	(with the exception of synchronize_srcu_expedited()) unfriendly
-	to real-time workloads.  Use of the expedited primitives should
-	be restricted to rare configuration-change operations that would
-	not normally be undertaken while a real-time workload is running.
-	However, real-time workloads can use rcupdate.rcu_normal kernel
-	boot parameter to completely disable expedited grace periods,
-	though this might have performance implications.
+	as the non-expedited forms, but expediting is more CPU intensive.
+	Use of the expedited primitives should be restricted to rare
+	configuration-change operations that would not normally be
+	undertaken while a real-time workload is running.  Note that
+	IPI-sensitive real-time workloads can use the rcupdate.rcu_normal
+	kernel boot parameter to completely disable expedited grace
+	periods, though this might have performance implications.
 
 	In particular, if you find yourself invoking one of the expedited
 	primitives repeatedly in a loop, please do everyone a favor:
@@ -215,8 +223,9 @@ over a rather long period of time, but improvements are always welcome!
 	a single non-expedited primitive to cover the entire batch.
 	This will very likely be faster than the loop containing the
 	expedited primitive, and will be much much easier on the rest
-	of the system, especially to real-time workloads running on
-	the rest of the system.
+	of the system, especially to real-time workloads running on the
+	rest of the system.  Alternatively, instead use asynchronous
+	primitives such as call_rcu().
 
 7.	As of v4.20, a given kernel implements only one RCU flavor, which
 	is RCU-sched for PREEMPTION=n and RCU-preempt for PREEMPTION=y.
@@ -239,7 +248,8 @@ over a rather long period of time, but improvements are always welcome!
 	the corresponding readers must use rcu_read_lock_trace() and
 	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
 	or synchronize_rcu_tasks_rude(), then the corresponding readers
-	must use anything that disables interrupts.
+	must use anything that disables preemption, for example,
+	preempt_disable() and preempt_enable().
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,
@@ -253,15 +263,16 @@ over a rather long period of time, but improvements are always welcome!
 	that this usage is safe is that readers can use anything that
 	disables BH when updaters use call_rcu() or synchronize_rcu().
 
-8.	Although synchronize_rcu() is slower than is call_rcu(), it
-	usually results in simpler code.  So, unless update performance is
-	critically important, the updaters cannot block, or the latency of
-	synchronize_rcu() is visible from userspace, synchronize_rcu()
-	should be used in preference to call_rcu().  Furthermore,
-	kfree_rcu() usually results in even simpler code than does
-	synchronize_rcu() without synchronize_rcu()'s multi-millisecond
-	latency.  So please take advantage of kfree_rcu()'s "fire and
-	forget" memory-freeing capabilities where it applies.
+8.	Although synchronize_rcu() is slower than is call_rcu(),
+	it usually results in simpler code.  So, unless update
+	performance is critically important, the updaters cannot block,
+	or the latency of synchronize_rcu() is visible from userspace,
+	synchronize_rcu() should be used in preference to call_rcu().
+	Furthermore, kfree_rcu() and kvfree_rcu() usually result
+	in even simpler code than does synchronize_rcu() without
+	synchronize_rcu()'s multi-millisecond latency.	So please take
+	advantage of kfree_rcu()'s and kvfree_rcu()'s "fire and forget"
+	memory-freeing capabilities where it applies.
 
 	An especially important property of the synchronize_rcu()
 	primitive is that it automatically self-limits: if grace periods
@@ -271,8 +282,8 @@ over a rather long period of time, but improvements are always welcome!
 	cases where grace periods are delayed, as failing to do so can
 	result in excessive realtime latencies or even OOM conditions.
 
-	Ways of gaining this self-limiting property when using call_rcu()
-	include:
+	Ways of gaining this self-limiting property when using call_rcu(),
+	kfree_rcu(), or kvfree_rcu() include:
 
 	a.	Keeping a count of the number of data-structure elements
 		used by the RCU-protected data structure, including
@@ -304,18 +315,21 @@ over a rather long period of time, but improvements are always welcome!
 		here is that superuser already has lots of ways to crash
 		the machine.
 
-	d.	Periodically invoke synchronize_rcu(), permitting a limited
-		number of updates per grace period.  Better yet, periodically
-		invoke rcu_barrier() to wait for all outstanding callbacks.
+	d.	Periodically invoke rcu_barrier(), permitting a limited
+		number of updates per grace period.
 
-	The same cautions apply to call_srcu() and kfree_rcu().
+	The same cautions apply to call_srcu(), call_rcu_tasks(),
+	call_rcu_tasks_rude(), and call_rcu_tasks_trace().  This is
+	why there is an srcu_barrier(), rcu_barrier_tasks(),
+	rcu_barrier_tasks_rude(), and rcu_barrier_tasks_rude(),
+	respectively.
 
-	Note that although these primitives do take action to avoid memory
-	exhaustion when any given CPU has too many callbacks, a determined
-	user could still exhaust memory.  This is especially the case
-	if a system with a large number of CPUs has been configured to
-	offload all of its RCU callbacks onto a single CPU, or if the
-	system has relatively little free memory.
+	Note that although these primitives do take action to avoid
+	memory exhaustion when any given CPU has too many callbacks,
+	a determined user or administrator can still exhaust memory.
+	This is especially the case if a system with a large number of
+	CPUs has been configured to offload all of its RCU callbacks onto
+	a single CPU, or if the system has relatively little free memory.
 
 9.	All RCU list-traversal primitives, which include
 	rcu_dereference(), list_for_each_entry_rcu(), and
@@ -344,14 +358,14 @@ over a rather long period of time, but improvements are always welcome!
 	and you don't hold the appropriate update-side lock, you *must*
 	use the "_rcu()" variants of the list macros.  Failing to do so
 	will break Alpha, cause aggressive compilers to generate bad code,
-	and confuse people trying to read your code.
+	and confuse people trying to understand your code.
 
 11.	Any lock acquired by an RCU callback must be acquired elsewhere
-	with softirq disabled, e.g., via spin_lock_irqsave(),
-	spin_lock_bh(), etc.  Failing to disable softirq on a given
-	acquisition of that lock will result in deadlock as soon as
-	the RCU softirq handler happens to run your RCU callback while
-	interrupting that acquisition's critical section.
+	with softirq disabled, e.g., via spin_lock_bh().  Failing to
+	disable softirq on a given acquisition of that lock will result
+	in deadlock as soon as the RCU softirq handler happens to run
+	your RCU callback while interrupting that acquisition's critical
+	section.
 
 12.	RCU callbacks can be and are executed in parallel.  In many cases,
 	the callback code simply wrappers around kfree(), so that this
@@ -372,7 +386,17 @@ over a rather long period of time, but improvements are always welcome!
 	for some  real-time workloads, this is the whole point of using
 	the rcu_nocbs= kernel boot parameter.
 
-13.	Unlike other forms of RCU, it *is* permissible to block in an
+	In addition, do not assume that callbacks queued in a given order
+	will be invoked in that order, even if they all are queued on the
+	same CPU.  Furthermore, do not assume that same-CPU callbacks will
+	be invoked serially.  For example, in recent kernels, CPUs can be
+	switched between offloaded and de-offloaded callback invocation,
+	and while a given CPU is undergoing such a switch, its callbacks
+	might be concurrently invoked by that CPU's softirq handler and
+	that CPU's rcuo kthread.  At such times, that CPU's callbacks
+	might be executed both concurrently and out of order.
+
+13.	Unlike most flavors of RCU, it *is* permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
 	Please note that if you don't need to sleep in read-side critical
@@ -412,6 +436,12 @@ over a rather long period of time, but improvements are always welcome!
 	never sends IPIs to other CPUs, so it is easier on
 	real-time workloads than is synchronize_rcu_expedited().
 
+	It is also permissible to sleep in RCU Tasks Trace read-side
+	critical, which are delimited by rcu_read_lock_trace() and
+	rcu_read_unlock_trace().  However, this is a specialized flavor
+	of RCU, and you should not use it without first checking with
+	its current users.  In most cases, you should instead use SRCU.
+
 	Note that rcu_assign_pointer() relates to SRCU just as it does to
 	other forms of RCU, but instead of rcu_dereference() you should
 	use srcu_dereference() in order to avoid lockdep splats.
@@ -442,50 +472,62 @@ over a rather long period of time, but improvements are always welcome!
 	find problems as follows:
 
 	CONFIG_PROVE_LOCKING:
-		check that accesses to RCU-protected data
-		structures are carried out under the proper RCU
-		read-side critical section, while holding the right
-		combination of locks, or whatever other conditions
-		are appropriate.
+		check that accesses to RCU-protected data structures
+		are carried out under the proper RCU read-side critical
+		section, while holding the right combination of locks,
+		or whatever other conditions are appropriate.
 
 	CONFIG_DEBUG_OBJECTS_RCU_HEAD:
-		check that you don't pass the
-		same object to call_rcu() (or friends) before an RCU
-		grace period has elapsed since the last time that you
-		passed that same object to call_rcu() (or friends).
+		check that you don't pass the same object to call_rcu()
+		(or friends) before an RCU grace period has elapsed
+		since the last time that you passed that same object to
+		call_rcu() (or friends).
 
 	__rcu sparse checks:
-		tag the pointer to the RCU-protected data
-		structure with __rcu, and sparse will warn you if you
-		access that pointer without the services of one of the
-		variants of rcu_dereference().
+		tag the pointer to the RCU-protected data structure
+		with __rcu, and sparse will warn you if you access that
+		pointer without the services of one of the variants
+		of rcu_dereference().
 
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-17.	If you register a callback using call_rcu() or call_srcu(), and
-	pass in a function defined within a loadable module, then it in
-	necessary to wait for all pending callbacks to be invoked after
-	the last invocation and before unloading that module.  Note that
-	it is absolutely *not* sufficient to wait for a grace period!
-	The current (say) synchronize_rcu() implementation is *not*
-	guaranteed to wait for callbacks registered on other CPUs.
-	Or even on the current CPU if that CPU recently went offline
-	and came back online.
+17.	If you pass a callback function defined within a module to one of
+	call_rcu(), call_srcu(), call_rcu_tasks(), call_rcu_tasks_rude(),
+	or call_rcu_tasks_trace(), then it is necessary to wait for all
+	pending callbacks to be invoked before unloading that module.
+	Note that it is absolutely *not* sufficient to wait for a grace
+	period!  For example, synchronize_rcu() implementation is *not*
+	guaranteed to wait for callbacks registered on other CPUs via
+	call_rcu().  Or even on the current CPU if that CPU recently
+	went offline and came back online.
 
 	You instead need to use one of the barrier functions:
 
 	-	call_rcu() -> rcu_barrier()
 	-	call_srcu() -> srcu_barrier()
+	-	call_rcu_tasks() -> rcu_barrier_tasks()
+	-	call_rcu_tasks_rude() -> rcu_barrier_tasks_rude()
+	-	call_rcu_tasks_trace() -> rcu_barrier_tasks_trace()
 
 	However, these barrier functions are absolutely *not* guaranteed
-	to wait for a grace period.  In fact, if there are no call_rcu()
-	callbacks waiting anywhere in the system, rcu_barrier() is within
-	its rights to return immediately.
-
-	So if you need to wait for both an RCU grace period and for
-	all pre-existing call_rcu() callbacks, you will need to execute
-	both rcu_barrier() and synchronize_rcu(), if necessary, using
-	something like workqueues to execute them concurrently.
+	to wait for a grace period.  For example, if there are no
+	call_rcu() callbacks queued anywhere in the system, rcu_barrier()
+	can and will return immediately.
+
+	So if you need to wait for both a grace period and for all
+	pre-existing callbacks, you will need to invoke both functions,
+	with the pair depending on the flavor of RCU:
+
+	-	Either synchronize_rcu() or synchronize_rcu_expedited(),
+		together with rcu_barrier()
+	-	Either synchronize_srcu() or synchronize_srcu_expedited(),
+		together with and srcu_barrier()
+	-	synchronize_rcu_tasks() and rcu_barrier_tasks()
+	-	synchronize_tasks_rude() and rcu_barrier_tasks_rude()
+	-	synchronize_tasks_trace() and rcu_barrier_tasks_trace()
+
+	If necessary, you can use something like workqueues to execute
+	the requisite pair of functions concurrently.
 
 	See rcubarrier.rst for more information.
-- 
2.31.1.189.g2e36527f23

