Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DDA64CFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239038AbiLNTOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 14:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNTN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 14:13:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D7A1DDC7;
        Wed, 14 Dec 2022 11:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26A66B81A1A;
        Wed, 14 Dec 2022 19:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B44C433D2;
        Wed, 14 Dec 2022 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671045235;
        bh=lbcQbBDqs7Qx+KzgAaODIuLRdgR43Oa9oNjsW16WLH8=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Q8ppirq+NJCrqYeme+mkCmshi9MzdRHyYnYRknmyqdaRNCg0sPvKnrg36stwEa02L
         BxxsJjxI4WhaZdFsBspwNa5UwvYijJs3tL7mGbjozcXXm2ywPWTex4ekv36o4dqfq+
         AAn8OAPWVZrvGt2gh+6V6FplbBjsldr4+v3+QHgF11yEsoN7Vu6K+qEkkl6/ZxeLj9
         26ZMDFJ+gu8peOov34Fw+HbtUvuxgOCna/qK7wjurx4Sq1gfqkLnmTMZu0Ps5+prmh
         uEG4FQJWZWiDwAmBeaHGFDWHh5rkVdgBFV6y85otZqv2wW6X2TvE2b7fWJg6YxT4G6
         Uib2b0gftw3pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 687D05C0327; Wed, 14 Dec 2022 11:13:55 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:13:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     boqun.feng@gmail.com, frederic@kernel.org, joel@joelfernandes.org,
        neeraj.iitr10@gmail.com, urezki@gmail.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] srcu: Yet more detail for
 srcu_readers_active_idx_check() comments
Message-ID: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in srcu_readers_active_idx_check() following the smp_mb()
is out of date, hailing from a simpler time when preemption was disabled
across the bulk of __srcu_read_lock().  The fact that preemption was
disabled meant that the number of tasks that had fetched the old index
but not yet incremented counters was limited by the number of CPUs.

In our more complex modern times, the number of CPUs is no longer a limit.
This commit therefore updates this comment, additionally giving more
memory-ordering detail.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Reported-by: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 68b8d8b150db1..ba12c50ee3658 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -469,24 +469,53 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 
 	/*
 	 * If the locks are the same as the unlocks, then there must have
-	 * been no readers on this index at some time in between. This does
-	 * not mean that there are no more readers, as one could have read
-	 * the current index but not have incremented the lock counter yet.
+	 * been no readers on this index at some point in this function.
+	 * But there might be more readers, as a task might have read
+	 * the current ->srcu_idx but not yet have incremented its CPU's
+	 * ->srcu_lock_count[idx] counter.  In fact, it is possible
+	 * that most of the tasks have been preempted between fetching
+	 * ->srcu_idx and incrementing ->srcu_lock_count[idx].  And there
+	 * could be almost (ULONG_MAX / sizeof(struct task_struct)) tasks
+	 * in a system whose address space was fully populated with memory.
+	 * Call this quantity Nt.
 	 *
-	 * So suppose that the updater is preempted here for so long
-	 * that more than ULONG_MAX non-nested readers come and go in
-	 * the meantime.  It turns out that this cannot result in overflow
-	 * because if a reader modifies its unlock count after we read it
-	 * above, then that reader's next load of ->srcu_idx is guaranteed
-	 * to get the new value, which will cause it to operate on the
-	 * other bank of counters, where it cannot contribute to the
-	 * overflow of these counters.  This means that there is a maximum
-	 * of 2*NR_CPUS increments, which cannot overflow given current
-	 * systems, especially not on 64-bit systems.
+	 * So suppose that the updater is preempted at this point in the
+	 * code for a long time.  That now-preempted updater has already
+	 * flipped ->srcu_idx (possibly during the preceding grace period),
+	 * done an smp_mb() (again, possibly during the preceding grace
+	 * period), and summed up the ->srcu_unlock_count[idx] counters.
+	 * How many times can a given one of the aforementioned Nt tasks
+	 * increment the old ->srcu_idx value's ->srcu_lock_count[idx]
+	 * counter, in the absence of nesting?
 	 *
-	 * OK, how about nesting?  This does impose a limit on nesting
-	 * of floor(ULONG_MAX/NR_CPUS/2), which should be sufficient,
-	 * especially on 64-bit systems.
+	 * It can clearly do so once, given that it has already fetched
+	 * the old value of ->srcu_idx and is just about to use that value
+	 * to index its increment of ->srcu_lock_count[idx].  But as soon as
+	 * it leaves that SRCU read-side critical section, it will increment
+	 * ->srcu_unlock_count[idx], which must follow the updater's above
+	 * read from that same value.  Thus, as soon the reading task does
+	 * an smp_mb() and a later fetch from ->srcu_idx, that task will be
+	 * guaranteed to get the new index.  Except that the increment of
+	 * ->srcu_unlock_count[idx] in __srcu_read_unlock() is after the
+	 * smp_mb(), and the fetch from ->srcu_idx in __srcu_read_lock()
+	 * is before the smp_mb().  Thus, that task might not see the new
+	 * value of ->srcu_idx until the -second- __srcu_read_lock(),
+	 * which in turn means that this task might well increment
+	 * ->srcu_lock_count[idx] for the old value of ->srcu_idx twice,
+	 * not just once.
+	 *
+	 * That is, there can be almost 2 * Nt further increments of
+	 * ->srcu_lock_count[idx] for the old index.  But this is OK because
+	 * the size of the task_struct structure limits the value of Nt.
+	 *
+	 * OK, but what about nesting?  This does impose a limit on
+	 * nesting of half of the size of the task_struct structure
+	 * (measured in bytes), which should be sufficient.  A late 2022
+	 * TREE01 rcutorture run reported this size to be no less than
+	 * 9408 bytes, allowing up to 4704 levels of nesting, which is
+	 * comfortably beyond excessive.  Especially on 64-bit systems,
+	 * which are unlikely to be configured with an address space fully
+	 * populated with memory, at least not anytime soon.
 	 */
 	return srcu_readers_lock_idx(ssp, idx) == unlocks;
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee8a6a711719a..399c818fe47ce 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4900,6 +4900,7 @@ void __init rcu_init(void)
 	// Kick-start any polled grace periods that started early.
 	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
 		(void)start_poll_synchronize_rcu_expedited();
+	pr_alert("sizeof(struct task_struct) = %lu\n", sizeof(struct task_struct));
 }
 
 #include "tree_stall.h"
