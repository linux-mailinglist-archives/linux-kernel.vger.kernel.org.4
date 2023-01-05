Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9558D65E14D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjAEAKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbjAEAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B41F43A1C;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2131B618B3;
        Thu,  5 Jan 2023 00:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EDC433A8;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=zIuR6b+M23FgJhA/VuiF85BlWyIsIRWHp9NsUOE91v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elPQLO5e8H5+eFqhwK9LEoENtRiade+LxinnMZqzUoMWV0qLqr8+S++1iGnGp1pdb
         M9vJ8WBN0kT/t7ZOcqfbYJwKg9cBZPtp2X1u0dm3KBMr9DufCJ0GGMIhbVMseqC5RI
         EoiRmB0i1EaxecSzROwjLOg4iDyxVZ4Qw/23XEJ2VkRWLMEaSMD49D8JT65Ypw06+k
         9dEDPQ1BTkIUQhYZUFu4fiKzlragpb166oJ6WLn4d+pUtBxyPTPMD+ZxqvipjrxwyB
         sw/Vunp88O3qA8wudFQRkiBwCShx1uvOs+c4oyFEg3Pl/H78asTvL3HdgHXCY+oVtr
         SDsueunfADNew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D69A45C1C77; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 11/15] doc: Update whatisRCU.rst
Date:   Wed,  4 Jan 2023 16:09:51 -0800
Message-Id: <20230105000955.1767218-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
References: <20230105000945.GA1767128@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates whatisRCU.rst with wordsmithing and updates provokes
by the passage of time.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/whatisRCU.rst | 193 +++++++++++++++++++++-----------
 1 file changed, 125 insertions(+), 68 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 1c747ac3f2c8e..2c5563a91998f 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -16,18 +16,23 @@ to start learning about RCU:
 | 6.	The RCU API, 2019 Edition    https://lwn.net/Articles/777036/
 |	2019 Big API Table           https://lwn.net/Articles/777165/
 
+For those preferring video:
+
+| 1.	Unraveling RCU Mysteries: Fundamentals          https://www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries
+| 2.	Unraveling RCU Mysteries: Additional Use Cases  https://www.linuxfoundation.org/webinars/unraveling-rcu-usage-mysteries-additional-use-cases
+
 
 What is RCU?
 
 RCU is a synchronization mechanism that was added to the Linux kernel
 during the 2.5 development effort that is optimized for read-mostly
-situations.  Although RCU is actually quite simple once you understand it,
-getting there can sometimes be a challenge.  Part of the problem is that
-most of the past descriptions of RCU have been written with the mistaken
-assumption that there is "one true way" to describe RCU.  Instead,
-the experience has been that different people must take different paths
-to arrive at an understanding of RCU.  This document provides several
-different paths, as follows:
+situations.  Although RCU is actually quite simple, making effective use
+of it requires you to think differently about your code.  Another part
+of the problem is the mistaken assumption that there is "one true way" to
+describe and to use RCU.  Instead, the experience has been that different
+people must take different paths to arrive at an understanding of RCU,
+depending on their experiences and use cases.  This document provides
+several different paths, as follows:
 
 :ref:`1.	RCU OVERVIEW <1_whatisRCU>`
 
@@ -157,34 +162,36 @@ rcu_read_lock()
 ^^^^^^^^^^^^^^^
 	void rcu_read_lock(void);
 
-	Used by a reader to inform the reclaimer that the reader is
-	entering an RCU read-side critical section.  It is illegal
-	to block while in an RCU read-side critical section, though
-	kernels built with CONFIG_PREEMPT_RCU can preempt RCU
-	read-side critical sections.  Any RCU-protected data structure
-	accessed during an RCU read-side critical section is guaranteed to
-	remain unreclaimed for the full duration of that critical section.
-	Reference counts may be used in conjunction with RCU to maintain
-	longer-term references to data structures.
+	This temporal primitive is used by a reader to inform the
+	reclaimer that the reader is entering an RCU read-side critical
+	section.  It is illegal to block while in an RCU read-side
+	critical section, though kernels built with CONFIG_PREEMPT_RCU
+	can preempt RCU read-side critical sections.  Any RCU-protected
+	data structure accessed during an RCU read-side critical section
+	is guaranteed to remain unreclaimed for the full duration of that
+	critical section.  Reference counts may be used in conjunction
+	with RCU to maintain longer-term references to data structures.
 
 rcu_read_unlock()
 ^^^^^^^^^^^^^^^^^
 	void rcu_read_unlock(void);
 
-	Used by a reader to inform the reclaimer that the reader is
-	exiting an RCU read-side critical section.  Note that RCU
-	read-side critical sections may be nested and/or overlapping.
+	This temporal primitives is used by a reader to inform the
+	reclaimer that the reader is exiting an RCU read-side critical
+	section.  Note that RCU read-side critical sections may be nested
+	and/or overlapping.
 
 synchronize_rcu()
 ^^^^^^^^^^^^^^^^^
 	void synchronize_rcu(void);
 
-	Marks the end of updater code and the beginning of reclaimer
-	code.  It does this by blocking until all pre-existing RCU
-	read-side critical sections on all CPUs have completed.
-	Note that synchronize_rcu() will **not** necessarily wait for
-	any subsequent RCU read-side critical sections to complete.
-	For example, consider the following sequence of events::
+	This temporal primitive marks the end of updater code and the
+	beginning of reclaimer code.  It does this by blocking until
+	all pre-existing RCU read-side critical sections on all CPUs
+	have completed.  Note that synchronize_rcu() will **not**
+	necessarily wait for any subsequent RCU read-side critical
+	sections to complete.  For example, consider the following
+	sequence of events::
 
 	         CPU 0                  CPU 1                 CPU 2
 	     ----------------- ------------------------- ---------------
@@ -211,13 +218,13 @@ synchronize_rcu()
 	to be useful in all but the most read-intensive situations,
 	synchronize_rcu()'s overhead must also be quite small.
 
-	The call_rcu() API is a callback form of synchronize_rcu(),
-	and is described in more detail in a later section.  Instead of
-	blocking, it registers a function and argument which are invoked
-	after all ongoing RCU read-side critical sections have completed.
-	This callback variant is particularly useful in situations where
-	it is illegal to block or where update-side performance is
-	critically important.
+	The call_rcu() API is an asynchronous callback form of
+	synchronize_rcu(), and is described in more detail in a later
+	section.  Instead of blocking, it registers a function and
+	argument which are invoked after all ongoing RCU read-side
+	critical sections have completed.  This callback variant is
+	particularly useful in situations where it is illegal to block
+	or where update-side performance is critically important.
 
 	However, the call_rcu() API should not be used lightly, as use
 	of the synchronize_rcu() API generally results in simpler code.
@@ -236,11 +243,13 @@ rcu_assign_pointer()
 	would be cool to be able to declare a function in this manner.
 	(Compiler experts will no doubt disagree.)
 
-	The updater uses this function to assign a new value to an
+	The updater uses this spatial macro to assign a new value to an
 	RCU-protected pointer, in order to safely communicate the change
-	in value from the updater to the reader.  This macro does not
-	evaluate to an rvalue, but it does execute any memory-barrier
-	instructions required for a given CPU architecture.
+	in value from the updater to the reader.  This is a spatial (as
+	opposed to temporal) macro.  It does not evaluate to an rvalue,
+	but it does execute any memory-barrier instructions required
+	for a given CPU architecture.  Its ordering properties are that
+	of a store-release operation.
 
 	Perhaps just as important, it serves to document (1) which
 	pointers are protected by RCU and (2) the point at which a
@@ -255,14 +264,15 @@ rcu_dereference()
 	Like rcu_assign_pointer(), rcu_dereference() must be implemented
 	as a macro.
 
-	The reader uses rcu_dereference() to fetch an RCU-protected
-	pointer, which returns a value that may then be safely
-	dereferenced.  Note that rcu_dereference() does not actually
-	dereference the pointer, instead, it protects the pointer for
-	later dereferencing.  It also executes any needed memory-barrier
-	instructions for a given CPU architecture.  Currently, only Alpha
-	needs memory barriers within rcu_dereference() -- on other CPUs,
-	it compiles to nothing, not even a compiler directive.
+	The reader uses the spatial rcu_dereference() macro to fetch
+	an RCU-protected pointer, which returns a value that may
+	then be safely dereferenced.  Note that rcu_dereference()
+	does not actually dereference the pointer, instead, it
+	protects the pointer for later dereferencing.  It also
+	executes any needed memory-barrier instructions for a given
+	CPU architecture.  Currently, only Alpha needs memory barriers
+	within rcu_dereference() -- on other CPUs, it compiles to a
+	volatile load.
 
 	Common coding practice uses rcu_dereference() to copy an
 	RCU-protected pointer to a local variable, then dereferences
@@ -355,12 +365,15 @@ reader, updater, and reclaimer.
 	      synchronize_rcu() & call_rcu()
 
 
-The RCU infrastructure observes the time sequence of rcu_read_lock(),
+The RCU infrastructure observes the temporal sequence of rcu_read_lock(),
 rcu_read_unlock(), synchronize_rcu(), and call_rcu() invocations in
 order to determine when (1) synchronize_rcu() invocations may return
 to their callers and (2) call_rcu() callbacks may be invoked.  Efficient
 implementations of the RCU infrastructure make heavy use of batching in
 order to amortize their overhead over many uses of the corresponding APIs.
+The rcu_assign_pointer() and rcu_dereference() invocations communicate
+spatial changes via stores to and loads from the RCU-protected pointer in
+question.
 
 There are at least three flavors of RCU usage in the Linux kernel. The diagram
 above shows the most common one. On the updater side, the rcu_assign_pointer(),
@@ -392,7 +405,9 @@ b.	RCU applied to networking data structures that may be subjected
 c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
 
 Again, most uses will be of (a).  The (b) and (c) cases are important
-for specialized uses, but are relatively uncommon.
+for specialized uses, but are relatively uncommon.  The SRCU, RCU-Tasks,
+RCU-Tasks-Rude, and RCU-Tasks-Trace have similar relationships among
+their assorted primitives.
 
 .. _3_whatisRCU:
 
@@ -468,7 +483,7 @@ So, to sum up:
 -	Within an RCU read-side critical section, use rcu_dereference()
 	to dereference RCU-protected pointers.
 
--	Use some solid scheme (such as locks or semaphores) to
+-	Use some solid design (such as locks or semaphores) to
 	keep concurrent updates from interfering with each other.
 
 -	Use rcu_assign_pointer() to update an RCU-protected pointer.
@@ -579,6 +594,14 @@ to avoid having to write your own callback::
 
 	kfree_rcu(old_fp, rcu);
 
+If the occasional sleep is permitted, the single-argument form may
+be used, omitting the rcu_head structure from struct foo.
+
+	kfree_rcu(old_fp);
+
+This variant of kfree_rcu() almost never blocks, but might do so by
+invoking synchronize_rcu() in response to memory-allocation failure.
+
 Again, see checklist.rst for additional rules governing the use of RCU.
 
 .. _5_whatisRCU:
@@ -596,7 +619,7 @@ lacking both functionality and performance.  However, they are useful
 in getting a feel for how RCU works.  See kernel/rcu/update.c for a
 production-quality implementation, and see:
 
-	http://www.rdrop.com/users/paulmck/RCU
+	https://docs.google.com/document/d/1X0lThx8OK0ZgLMqVoXiR4ZrGURHrXK6NyLRbeXe3Xac/edit
 
 for papers describing the Linux kernel RCU implementation.  The OLS'01
 and OLS'02 papers are a good introduction, and the dissertation provides
@@ -929,6 +952,8 @@ unfortunately any spinlock in a ``SLAB_TYPESAFE_BY_RCU`` object must be
 initialized after each and every call to kmem_cache_alloc(), which renders
 reference-free spinlock acquisition completely unsafe.  Therefore, when
 using ``SLAB_TYPESAFE_BY_RCU``, make proper use of a reference counter.
+(Those willing to use a kmem_cache constructor may also use locking,
+including cache-friendly sequence locking.)
 
 With traditional reference counting -- such as that implemented by the
 kref library in Linux -- there is typically code that runs when the last
@@ -1047,6 +1072,30 @@ sched::
 	rcu_read_lock_sched_held
 
 
+RCU-Tasks::
+
+	Critical sections	Grace period		Barrier
+
+	N/A			call_rcu_tasks		rcu_barrier_tasks
+				synchronize_rcu_tasks
+
+
+RCU-Tasks-Rude::
+
+	Critical sections	Grace period		Barrier
+
+	N/A			call_rcu_tasks_rude	rcu_barrier_tasks_rude
+				synchronize_rcu_tasks_rude
+
+
+RCU-Tasks-Trace::
+
+	Critical sections	Grace period		Barrier
+
+	rcu_read_lock_trace	call_rcu_tasks_trace	rcu_barrier_tasks_trace
+	rcu_read_unlock_trace	synchronize_rcu_tasks_trace
+
+
 SRCU::
 
 	Critical sections	Grace period		Barrier
@@ -1087,35 +1136,43 @@ list can be helpful:
 
 a.	Will readers need to block?  If so, you need SRCU.
 
-b.	What about the -rt patchset?  If readers would need to block
-	in an non-rt kernel, you need SRCU.  If readers would block
-	in a -rt kernel, but not in a non-rt kernel, SRCU is not
-	necessary.  (The -rt patchset turns spinlocks into sleeplocks,
-	hence this distinction.)
+b.	Will readers need to block and are you doing tracing, for
+	example, ftrace or BPF?  If so, you need RCU-tasks,
+	RCU-tasks-rude, and/or RCU-tasks-trace.
+
+c.	What about the -rt patchset?  If readers would need to block in
+	an non-rt kernel, you need SRCU.  If readers would block when
+	acquiring spinlocks in a -rt kernel, but not in a non-rt kernel,
+	SRCU is not necessary.	(The -rt patchset turns spinlocks into
+	sleeplocks, hence this distinction.)
 
-c.	Do you need to treat NMI handlers, hardirq handlers,
+d.	Do you need to treat NMI handlers, hardirq handlers,
 	and code segments with preemption disabled (whether
 	via preempt_disable(), local_irq_save(), local_bh_disable(),
 	or some other mechanism) as if they were explicit RCU readers?
-	If so, RCU-sched is the only choice that will work for you.
-
-d.	Do you need RCU grace periods to complete even in the face
-	of softirq monopolization of one or more of the CPUs?  For
-	example, is your code subject to network-based denial-of-service
-	attacks?  If so, you should disable softirq across your readers,
-	for example, by using rcu_read_lock_bh().
-
-e.	Is your workload too update-intensive for normal use of
+	If so, RCU-sched readers are the only choice that will work
+	for you, but since about v4.20 you use can use the vanilla RCU
+	update primitives.
+
+e.	Do you need RCU grace periods to complete even in the face of
+	softirq monopolization of one or more of the CPUs?  For example,
+	is your code subject to network-based denial-of-service attacks?
+	If so, you should disable softirq across your readers, for
+	example, by using rcu_read_lock_bh().  Since about v4.20 you
+	use can use the vanilla RCU update primitives.
+
+f.	Is your workload too update-intensive for normal use of
 	RCU, but inappropriate for other synchronization mechanisms?
 	If so, consider SLAB_TYPESAFE_BY_RCU (which was originally
 	named SLAB_DESTROY_BY_RCU).  But please be careful!
 
-f.	Do you need read-side critical sections that are respected
-	even though they are in the middle of the idle loop, during
-	user-mode execution, or on an offlined CPU?  If so, SRCU is the
-	only choice that will work for you.
+g.	Do you need read-side critical sections that are respected even
+	on CPUs that are deep in the idle loop, during entry to or exit
+	from user-mode execution, or on an offlined CPU?  If so, SRCU
+	and RCU Tasks Trace are the only choices that will work for you,
+	with SRCU being strongly preferred in almost all cases.
 
-g.	Otherwise, use RCU.
+h.	Otherwise, use RCU.
 
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
-- 
2.31.1.189.g2e36527f23

