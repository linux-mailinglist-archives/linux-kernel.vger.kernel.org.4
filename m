Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FD6C7476
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCXAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjCXATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB6E2DE7B;
        Thu, 23 Mar 2023 17:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 767AAB822A6;
        Fri, 24 Mar 2023 00:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20ED7C4339E;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=02q/OWqQRR5LuTJFEoF1ibkG9lx5Gkwwg1gtcCvUyAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WitaechdF+UVTeKMRghz048IL1tjLUpNxWNIBHDdg3lFobWazzXUOomhkTztr7NPu
         HBce1UJvGbiwcptwp3imR1KssRsB4U+w3vnt+Y/+TDkSUbBOJVc0Kt90Y0o/aTmtoY
         MokOY3ks5N6PWdLuuvG401Q2fApH55ocgWl/hNI/DecejGatRhrf0uMhyVymFBZXYv
         dXGnnl9VnXko503f6bBJtxrLhlEq/hLPYbAPv3x2WCjjYHgwNWVkJMcKcXkp3F8ROF
         n0vZVVxVnfdbDnZqfQ2JusCRvB8DgE5IiD8VXh7QZvVy06uF/lN4gQD5lj2HYcvTW6
         7ken20WLJCDGg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 98870154039E; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 05/19] srcu: Move ->srcu_size_state from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:24 -0700
Message-Id: <20230324001938.3443499-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves the ->srcu_size_state field from the srcu_struct
structure to the srcu_usage structure to reduce the size of the former
in order to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  2 +-
 kernel/rcu/srcutree.c    | 37 +++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 362c8f39c53d..72fb01fb2eb5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -64,13 +64,13 @@ struct srcu_usage {
 	struct srcu_node *node;			/* Combining tree. */
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
+	int srcu_size_state;			/* Small-to-big transition state. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 90d753e10e33..2717217de136 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -225,7 +225,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 		}
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 	}
-	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
+	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
 	return true;
 }
 
@@ -240,7 +240,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->srcu_sup = kzalloc(sizeof(*ssp->srcu_sup), GFP_KERNEL);
 	if (!ssp->srcu_sup)
 		return -ENOMEM;
-	ssp->srcu_size_state = SRCU_SIZE_SMALL;
+	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
@@ -261,7 +261,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	init_srcu_struct_data(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
-	if (READ_ONCE(ssp->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
+	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
 			if (!ssp->sda_is_static) {
 				free_percpu(ssp->sda);
@@ -270,7 +270,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 				return -ENOMEM;
 			}
 		} else {
-			WRITE_ONCE(ssp->srcu_size_state, SRCU_SIZE_BIG);
+			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 		}
 	}
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
@@ -315,7 +315,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 static void __srcu_transition_to_big(struct srcu_struct *ssp)
 {
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
-	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_ALLOC);
+	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_ALLOC);
 }
 
 /*
@@ -326,10 +326,10 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
 	unsigned long flags;
 
 	/* Double-checked locking on ->srcu_size-state. */
-	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL)
+	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL)
 		return;
 	spin_lock_irqsave_rcu_node(ssp, flags);
-	if (smp_load_acquire(&ssp->srcu_size_state) != SRCU_SIZE_SMALL) {
+	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL) {
 		spin_unlock_irqrestore_rcu_node(ssp, flags);
 		return;
 	}
@@ -345,7 +345,7 @@ static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
 {
 	unsigned long j;
 
-	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_size_state)
+	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_sup->srcu_size_state)
 		return;
 	j = jiffies;
 	if (ssp->srcu_size_jiffies != j) {
@@ -666,7 +666,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	}
 	kfree(ssp->srcu_sup->node);
 	ssp->srcu_sup->node = NULL;
-	ssp->srcu_size_state = SRCU_SIZE_SMALL;
+	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	if (!ssp->sda_is_static) {
 		free_percpu(ssp->sda);
 		ssp->sda = NULL;
@@ -770,7 +770,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	struct srcu_data *sdp;
 	int state;
 
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = this_cpu_ptr(ssp->sda);
@@ -880,7 +880,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
-	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
 					cbdelay);
@@ -940,7 +940,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
+			smp_store_release(&ssp->srcu_sup->srcu_size_state, ss_state + 1);
 	}
 }
 
@@ -1002,7 +1002,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	unsigned long snp_seq;
 
 	/* Ensure that snp node tree is fully initialized before traversing it */
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		snp_leaf = NULL;
 	else
 		snp_leaf = sdp->mynode;
@@ -1229,7 +1229,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 * sequence number cannot wrap around in the meantime.
 	 */
 	idx = __srcu_read_lock_nmisafe(ssp);
-	ss_state = smp_load_acquire(&ssp->srcu_size_state);
+	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
@@ -1568,7 +1568,7 @@ void srcu_barrier(struct srcu_struct *ssp)
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
 	idx = __srcu_read_lock_nmisafe(ssp);
-	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda,	get_boot_cpu_id()));
 	else
 		for_each_possible_cpu(cpu)
@@ -1806,7 +1806,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 	int cpu;
 	int idx;
 	unsigned long s0 = 0, s1 = 0;
-	int ss_state = READ_ONCE(ssp->srcu_size_state);
+	int ss_state = READ_ONCE(ssp->srcu_sup->srcu_size_state);
 	int ss_state_idx = ss_state;
 
 	idx = ssp->srcu_idx & 0x1;
@@ -1893,8 +1893,9 @@ void __init srcu_init(void)
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
 		list_del_init(&ssp->work.work.entry);
-		if (SRCU_SIZING_IS(SRCU_SIZING_INIT) && ssp->srcu_size_state == SRCU_SIZE_SMALL)
-			ssp->srcu_size_state = SRCU_SIZE_ALLOC;
+		if (SRCU_SIZING_IS(SRCU_SIZING_INIT) &&
+		    ssp->srcu_sup->srcu_size_state == SRCU_SIZE_SMALL)
+			ssp->srcu_sup->srcu_size_state = SRCU_SIZE_ALLOC;
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
 }
-- 
2.40.0.rc2

