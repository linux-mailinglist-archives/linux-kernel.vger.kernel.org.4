Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBEB65E192
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjAEAcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbjAEAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C464FD4A;
        Wed,  4 Jan 2023 16:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F865618A8;
        Thu,  5 Jan 2023 00:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B1DC433AA;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878535;
        bh=T0Si/nrJsXetq71MKP8bRh/LKYukQYZXgFQB6baZ280=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWAJirJpm/34s24IskvlarEdwydJNeEEAq2mnuAANDvxyB1YvF++oDvyImtF9YiTX
         iUzptH5DfMcBGpMIzw1tt0HrALg6Jnt7AYilF6su4SUXL0iY7B0vBUjRPicrzzmGse
         zny7tJTm2zlCqOO0GHcBpyYLfjR6/meCNzi8rGHjIxHHFRi88BTQnNC/W5+s1n9VCM
         huZ/o12tweWx4Rc+r/A2RrKZTnfa+eJ43S7JHB39H7yRS4xWPW5sGk92FmNbmoaek5
         XuLVBgneDg9UDy6RBgE5oRTzq04lNxmo/E3encp5YVSbJPzjbWge70iL2Z/jbRI1sT
         nd5k+QIQWBytw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 52B895C1C5B; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 8/9] srcu: Yet more detail for srcu_readers_active_idx_check() comments
Date:   Wed,  4 Jan 2023 16:28:52 -0800
Message-Id: <20230105002853.1769401-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
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

The comment in srcu_readers_active_idx_check() following the smp_mb()
is out of date, hailing from a simpler time when preemption was disabled
across the bulk of __srcu_read_lock().  The fact that preemption was
disabled meant that the number of tasks that had fetched the old index
but not yet incremented counters was limited by the number of CPUs.

In our more complex modern times, the number of CPUs is no longer a limit.
This commit therefore updates this comment, additionally giving more
memory-ordering detail.

[ paulmck: Apply Nt->Nc feedback from Joel Fernandes. ]

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reported-by: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Reported-by: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Reported-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 67 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 68b8d8b150db1..d2d2e31c42b13 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -469,24 +469,59 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 
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
+	 * However, it is important to note that a given smp_mb() takes
+	 * effect not just for the task executing it, but also for any
+	 * later task running on that same CPU.
+	 *
+	 * That is, there can be almost Nt + Nc further increments of
+	 * ->srcu_lock_count[idx] for the old index, where Nc is the number
+	 * of CPUs.  But this is OK because the size of the task_struct
+	 * structure limits the value of Nt and current systems limit Nc
+	 * to a few thousand.
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
-- 
2.31.1.189.g2e36527f23

