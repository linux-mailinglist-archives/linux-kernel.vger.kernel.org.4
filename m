Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A72D65E14C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjAEAKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjAEAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:10:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF32543A2E;
        Wed,  4 Jan 2023 16:09:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EA08B81982;
        Thu,  5 Jan 2023 00:09:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3D7C433F0;
        Thu,  5 Jan 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672877397;
        bh=V2Z8QYT5z//Jt9zS0OsjC84Q9vVqZBpFtFH0qHjU5P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XEIEU+aT+PoiGBDGyH0Jr2XrApzwbVTa/rft5ZuyOBGPDvSsUC6JvbZsXxtoPRgRe
         hdgh4gFvPiiiG5WWV5hRs7feCMXw4KEawKe0sNkzTRunuGd0xyNDUddKMaoFcIfxFR
         L+lXK6MJaMVI2Rpc+HZ8EbENlZVzd//qdnTFFmIWRM+QFwH7m0veJk4Cw2iEwRw+5X
         0e7QcAYg7CCjK1UpQAJW0zLsgg6XkZ+v4WISVPeDN6O+PAaEEFIpuCNHWnr4J4aO9S
         2rtnz/IcPVOEGj8BdmrOnP2Q2BiBwKIvMGzhb51UKTgVqwVrXl0Uo1gF5B+YbIaHFh
         0QvsCtISup8uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C7D0A5C08E5; Wed,  4 Jan 2023 16:09:56 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 03/15] doc: Update rcubarrier.rst
Date:   Wed,  4 Jan 2023 16:09:43 -0800
Message-Id: <20230105000955.1767218-3-paulmck@kernel.org>
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

This commit updates rcubarrier.txt to reflect RCU additions and changes
over the past few years.

[ paulmck: Apply Stephen Rothwell feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcubarrier.rst | 196 +++++++++++++++++--------------
 1 file changed, 110 insertions(+), 86 deletions(-)

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 3b4a248774961..5a643e5233d5f 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -5,37 +5,12 @@ RCU and Unloadable Modules
 
 [Originally published in LWN Jan. 14, 2007: http://lwn.net/Articles/217484/]
 
-RCU (read-copy update) is a synchronization mechanism that can be thought
-of as a replacement for read-writer locking (among other things), but with
-very low-overhead readers that are immune to deadlock, priority inversion,
-and unbounded latency. RCU read-side critical sections are delimited
-by rcu_read_lock() and rcu_read_unlock(), which, in non-CONFIG_PREEMPTION
-kernels, generate no code whatsoever.
-
-This means that RCU writers are unaware of the presence of concurrent
-readers, so that RCU updates to shared data must be undertaken quite
-carefully, leaving an old version of the data structure in place until all
-pre-existing readers have finished. These old versions are needed because
-such readers might hold a reference to them. RCU updates can therefore be
-rather expensive, and RCU is thus best suited for read-mostly situations.
-
-How can an RCU writer possibly determine when all readers are finished,
-given that readers might well leave absolutely no trace of their
-presence? There is a synchronize_rcu() primitive that blocks until all
-pre-existing readers have completed. An updater wishing to delete an
-element p from a linked list might do the following, while holding an
-appropriate lock, of course::
-
-	list_del_rcu(p);
-	synchronize_rcu();
-	kfree(p);
-
-But the above code cannot be used in IRQ context -- the call_rcu()
-primitive must be used instead. This primitive takes a pointer to an
-rcu_head struct placed within the RCU-protected data structure and
-another pointer to a function that may be invoked later to free that
-structure. Code to delete an element p from the linked list from IRQ
-context might then be as follows::
+RCU updaters sometimes use call_rcu() to initiate an asynchronous wait for
+a grace period to elapse.  This primitive takes a pointer to an rcu_head
+struct placed within the RCU-protected data structure and another pointer
+to a function that may be invoked later to free that structure. Code to
+delete an element p from the linked list from IRQ context might then be
+as follows::
 
 	list_del_rcu(p);
 	call_rcu(&p->rcu, p_callback);
@@ -54,7 +29,7 @@ IRQ context. The function p_callback() might be defined as follows::
 Unloading Modules That Use call_rcu()
 -------------------------------------
 
-But what if p_callback is defined in an unloadable module?
+But what if the p_callback() function is defined in an unloadable module?
 
 If we unload the module while some RCU callbacks are pending,
 the CPUs executing these callbacks are going to be severely
@@ -67,20 +42,21 @@ grace period to elapse, it does not wait for the callbacks to complete.
 
 One might be tempted to try several back-to-back synchronize_rcu()
 calls, but this is still not guaranteed to work. If there is a very
-heavy RCU-callback load, then some of the callbacks might be deferred
-in order to allow other processing to proceed. Such deferral is required
-in realtime kernels in order to avoid excessive scheduling latencies.
+heavy RCU-callback load, then some of the callbacks might be deferred in
+order to allow other processing to proceed. For but one example, such
+deferral is required in realtime kernels in order to avoid excessive
+scheduling latencies.
 
 
 rcu_barrier()
 -------------
 
-We instead need the rcu_barrier() primitive.  Rather than waiting for
-a grace period to elapse, rcu_barrier() waits for all outstanding RCU
-callbacks to complete.  Please note that rcu_barrier() does **not** imply
-synchronize_rcu(), in particular, if there are no RCU callbacks queued
-anywhere, rcu_barrier() is within its rights to return immediately,
-without waiting for a grace period to elapse.
+This situation can be handled by the rcu_barrier() primitive.  Rather
+than waiting for a grace period to elapse, rcu_barrier() waits for all
+outstanding RCU callbacks to complete.  Please note that rcu_barrier()
+does **not** imply synchronize_rcu(), in particular, if there are no RCU
+callbacks queued anywhere, rcu_barrier() is within its rights to return
+immediately, without waiting for anything, let alone a grace period.
 
 Pseudo-code using rcu_barrier() is as follows:
 
@@ -89,19 +65,22 @@ Pseudo-code using rcu_barrier() is as follows:
    3. Allow the module to be unloaded.
 
 There is also an srcu_barrier() function for SRCU, and you of course
-must match the flavor of rcu_barrier() with that of call_rcu().  If your
-module uses multiple flavors of call_rcu(), then it must also use multiple
-flavors of rcu_barrier() when unloading that module.  For example, if
-it uses call_rcu(), call_srcu() on srcu_struct_1, and call_srcu() on
-srcu_struct_2, then the following three lines of code will be required
-when unloading::
+must match the flavor of srcu_barrier() with that of call_srcu().
+If your module uses multiple srcu_struct structures, then it must also
+use multiple invocations of srcu_barrier() when unloading that module.
+For example, if it uses call_rcu(), call_srcu() on srcu_struct_1, and
+call_srcu() on srcu_struct_2, then the following three lines of code
+will be required when unloading::
 
  1 rcu_barrier();
  2 srcu_barrier(&srcu_struct_1);
  3 srcu_barrier(&srcu_struct_2);
 
-The rcutorture module makes use of rcu_barrier() in its exit function
-as follows::
+If latency is of the essence, workqueues could be used to run these
+three functions concurrently.
+
+An ancient version of the rcutorture module makes use of rcu_barrier()
+in its exit function as follows::
 
  1  static void
  2  rcu_torture_cleanup(void)
@@ -190,16 +169,17 @@ Quick Quiz #1:
 :ref:`Answer to Quick Quiz #1 <answer_rcubarrier_quiz_1>`
 
 Your module might have additional complications. For example, if your
-module invokes call_rcu() from timers, you will need to first cancel all
-the timers, and only then invoke rcu_barrier() to wait for any remaining
+module invokes call_rcu() from timers, you will need to first refrain
+from posting new timers, cancel (or wait for) all the already-posted
+timers, and only then invoke rcu_barrier() to wait for any remaining
 RCU callbacks to complete.
 
-Of course, if you module uses call_rcu(), you will need to invoke
+Of course, if your module uses call_rcu(), you will need to invoke
 rcu_barrier() before unloading.  Similarly, if your module uses
 call_srcu(), you will need to invoke srcu_barrier() before unloading,
 and on the same srcu_struct structure.  If your module uses call_rcu()
-**and** call_srcu(), then you will need to invoke rcu_barrier() **and**
-srcu_barrier().
+**and** call_srcu(), then (as noted above) you will need to invoke
+rcu_barrier() **and** srcu_barrier().
 
 
 Implementing rcu_barrier()
@@ -211,27 +191,40 @@ queues. His implementation queues an RCU callback on each of the per-CPU
 callback queues, and then waits until they have all started executing, at
 which point, all earlier RCU callbacks are guaranteed to have completed.
 
-The original code for rcu_barrier() was as follows::
-
- 1  void rcu_barrier(void)
- 2  {
- 3    BUG_ON(in_interrupt());
- 4    /* Take cpucontrol mutex to protect against CPU hotplug */
- 5    mutex_lock(&rcu_barrier_mutex);
- 6    init_completion(&rcu_barrier_completion);
- 7    atomic_set(&rcu_barrier_cpu_count, 0);
- 8    on_each_cpu(rcu_barrier_func, NULL, 0, 1);
- 9    wait_for_completion(&rcu_barrier_completion);
- 10   mutex_unlock(&rcu_barrier_mutex);
- 11 }
-
-Line 3 verifies that the caller is in process context, and lines 5 and 10
+The original code for rcu_barrier() was roughly as follows::
+
+ 1   void rcu_barrier(void)
+ 2   {
+ 3     BUG_ON(in_interrupt());
+ 4     /* Take cpucontrol mutex to protect against CPU hotplug */
+ 5     mutex_lock(&rcu_barrier_mutex);
+ 6     init_completion(&rcu_barrier_completion);
+ 7     atomic_set(&rcu_barrier_cpu_count, 1);
+ 8     on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+ 9     if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+ 10       complete(&rcu_barrier_completion);
+ 11    wait_for_completion(&rcu_barrier_completion);
+ 12    mutex_unlock(&rcu_barrier_mutex);
+ 13  }
+
+Line 3 verifies that the caller is in process context, and lines 5 and 12
 use rcu_barrier_mutex to ensure that only one rcu_barrier() is using the
 global completion and counters at a time, which are initialized on lines
 6 and 7. Line 8 causes each CPU to invoke rcu_barrier_func(), which is
 shown below. Note that the final "1" in on_each_cpu()'s argument list
 ensures that all the calls to rcu_barrier_func() will have completed
-before on_each_cpu() returns. Line 9 then waits for the completion.
+before on_each_cpu() returns. Line 9 removes the initial count from
+rcu_barrier_cpu_count, and if this count is now zero, line 10 finalizes
+the completion, which prevents line 11 from blocking.  Either way,
+line 11 then waits (if needed) for the completion.
+
+.. _rcubarrier_quiz_2:
+
+Quick Quiz #2:
+	Why doesn't line 8 initialize rcu_barrier_cpu_count to zero,
+	thereby avoiding the need for lines 9 and 10?
+
+:ref:`Answer to Quick Quiz #2 <answer_rcubarrier_quiz_2>`
 
 This code was rewritten in 2008 and several times thereafter, but this
 still gives the general idea.
@@ -253,7 +246,7 @@ to post an RCU callback, as follows::
 Lines 3 and 4 locate RCU's internal per-CPU rcu_data structure,
 which contains the struct rcu_head that needed for the later call to
 call_rcu(). Line 7 picks up a pointer to this struct rcu_head, and line
-8 increments a global counter. This counter will later be decremented
+8 increments the global counter. This counter will later be decremented
 by the callback. Line 9 then registers the rcu_barrier_callback() on
 the current CPU's queue.
 
@@ -267,27 +260,28 @@ reaches zero, as follows::
  4     complete(&rcu_barrier_completion);
  5 }
 
-.. _rcubarrier_quiz_2:
+.. _rcubarrier_quiz_3:
 
-Quick Quiz #2:
+Quick Quiz #3:
 	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
 	are delayed for a full grace period? Couldn't this result in
 	rcu_barrier() returning prematurely?
 
-:ref:`Answer to Quick Quiz #2 <answer_rcubarrier_quiz_2>`
+:ref:`Answer to Quick Quiz #3 <answer_rcubarrier_quiz_3>`
 
 The current rcu_barrier() implementation is more complex, due to the need
 to avoid disturbing idle CPUs (especially on battery-powered systems)
 and the need to minimally disturb non-idle CPUs in real-time systems.
-However, the code above illustrates the concepts.
+In addition, a great many optimizations have been applied.  However,
+the code above illustrates the concepts.
 
 
 rcu_barrier() Summary
 ---------------------
 
-The rcu_barrier() primitive has seen relatively little use, since most
+The rcu_barrier() primitive is used relatively infrequently, since most
 code using RCU is in the core kernel rather than in modules. However, if
 you are using RCU from an unloadable module, you need to use rcu_barrier()
 so that your module may be safely unloaded.
@@ -318,6 +312,39 @@ Answer: Interestingly enough, rcu_barrier() was not originally
 .. _answer_rcubarrier_quiz_2:
 
 Quick Quiz #2:
+	Why doesn't line 8 initialize rcu_barrier_cpu_count to zero,
+	thereby avoiding the need for lines 9 and 10?
+
+Answer: Suppose that the on_each_cpu() function shown on line 8 was
+	delayed, so that CPU 0's rcu_barrier_func() executed and
+	the corresponding grace period elapsed, all before CPU 1's
+	rcu_barrier_func() started executing.  This would result in
+	rcu_barrier_cpu_count being decremented to zero, so that line
+	11's wait_for_completion() would return immediately, failing to
+	wait for CPU 1's callbacks to be invoked.
+
+	Note that this was not a problem when the rcu_barrier() code
+	was first added back in 2005.  This is because on_each_cpu()
+	disables preemption, which acted as an RCU read-side critical
+	section, thus preventing CPU 0's grace period from completing
+	until on_each_cpu() had dealt with all of the CPUs.  However,
+	with the advent of preemptible RCU, rcu_barrier() no longer
+	waited on nonpreemptible regions of code in preemptible kernels,
+	that being the job of the new rcu_barrier_sched() function.
+
+	However, with the RCU flavor consolidation around v4.20, this
+	possibility was once again ruled out, because the consolidated
+	RCU once again waits on nonpreemptible regions of code.
+
+	Nevertheless, that extra count might still be a good idea.
+	Relying on these sort of accidents of implementation can result
+	in later surprise bugs when the implementation changes.
+
+:ref:`Back to Quick Quiz #2 <rcubarrier_quiz_2>`
+
+.. _answer_rcubarrier_quiz_3:
+
+Quick Quiz #3:
 	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
@@ -336,18 +363,15 @@ Answer: This cannot happen. The reason is that on_each_cpu() has its last
 
 	Therefore, on_each_cpu() disables preemption across its call
 	to smp_call_function() and also across the local call to
-	rcu_barrier_func(). This prevents the local CPU from context
-	switching, again preventing grace periods from completing. This
+	rcu_barrier_func(). Because recent RCU implementations treat
+	preemption-disabled regions of code as RCU read-side critical
+	sections, this prevents grace periods from completing. This
 	means that all CPUs have executed rcu_barrier_func() before
 	the first rcu_barrier_callback() can possibly execute, in turn
 	preventing rcu_barrier_cpu_count from prematurely reaching zero.
 
-	Currently, -rt implementations of RCU keep but a single global
-	queue for RCU callbacks, and thus do not suffer from this
-	problem. However, when the -rt RCU eventually does have per-CPU
-	callback queues, things will have to change. One simple change
-	is to add an rcu_read_lock() before line 8 of rcu_barrier()
-	and an rcu_read_unlock() after line 8 of this same function. If
-	you can think of a better change, please let me know!
+	But if on_each_cpu() ever decides to forgo disabling preemption,
+	as might well happen due to real-time latency considerations,
+	initializing rcu_barrier_cpu_count to one will save the day.
 
-:ref:`Back to Quick Quiz #2 <rcubarrier_quiz_2>`
+:ref:`Back to Quick Quiz #3 <rcubarrier_quiz_3>`
-- 
2.31.1.189.g2e36527f23

