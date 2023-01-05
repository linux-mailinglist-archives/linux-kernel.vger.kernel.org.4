Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB8865E18B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbjAEA1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbjAEA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600E84A941;
        Wed,  4 Jan 2023 16:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A1766189B;
        Thu,  5 Jan 2023 00:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961D7C433A1;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=d7YTGhFTM4KzsgpxZTGGeZQR3ZpgDoXNIpuouzZiz84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vL1tIQBRmDEAMoVcwK2B1dk52NSs4R9n3UydE1soj3iDSaSQ2DgdBE/PWt5IOQN80
         ZbyurBktwUn/Zh6WnKQKv9a6frTwR18i4tbZ3OmPHG/yxfdGmY1foCRz3hZe3tlUY5
         rztozHaUPWvILIwcm9lanovhKr8JUsBOIAE5bm2TrYo3Esz+sePKgV3Ft9AQKVqyMl
         6FooEJFGp1UQe+3XPPCZe0dnOKWHEhAEzZzcsY7HOrhkLITx7/J0RXRdMBeXLz5s0U
         M1kEGIIj33p9uRKpibrds/LHmGTskCJE3ftNyir5I1BVZuIdUOe3FjjNu9tEaEbOlr
         glMnhsHN5HcsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EF0FF5C1AE0; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/8] rcu/kvfree: Carefully reset number of objects in krcp
Date:   Wed,  4 Jan 2023 16:24:47 -0800
Message-Id: <20230105002448.1768892-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002441.GA1768817@paulmck-ThinkPad-P17-Gen-1>
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

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The schedule_delayed_monitor_work() function relies on the count of
objects queued into any given kfree_rcu_cpu structure.  This count is
used to determine how quickly to schedule passing these objects to RCU.

There are three pipes where pointers can be placed.  When any pipe is
offloaded, the kfree_rcu_cpu structure's ->count counter is set to zero,
which is wrong because the other pipes might still be non-empty.

This commit therefore maintains per-pipe counters, and introduces a
krc_count() helper to access the aggregate value of those counters.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 02551e0e11328..52f4c7e87f88e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2921,7 +2921,8 @@ struct kfree_rcu_cpu_work {
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
  * @initialized: The @rcu_work fields have been initialized
- * @count: Number of objects for which GP not started
+ * @head_count: Number of objects in rcu_head singular list
+ * @bulk_count: Number of objects in bulk-list
  * @bkvcache:
  *	A simple cache list that contains objects for reuse purpose.
  *	In order to save some per-cpu space the list is singular.
@@ -2939,13 +2940,19 @@ struct kfree_rcu_cpu_work {
  * the interactions with the slab allocators.
  */
 struct kfree_rcu_cpu {
+	// Objects queued on a linked list
+	// through their rcu_head structures.
 	struct rcu_head *head;
+	atomic_t head_count;
+
+	// Objects queued on a bulk-list.
 	struct list_head bulk_head[FREE_N_CHANNELS];
+	atomic_t bulk_count[FREE_N_CHANNELS];
+
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
 	bool initialized;
-	int count;
 
 	struct delayed_work page_cache_work;
 	atomic_t backoff_page_cache_fill;
@@ -3168,12 +3175,23 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	return !!READ_ONCE(krcp->head);
 }
 
+static int krc_count(struct kfree_rcu_cpu *krcp)
+{
+	int sum = atomic_read(&krcp->head_count);
+	int i;
+
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		sum += atomic_read(&krcp->bulk_count[i]);
+
+	return sum;
+}
+
 static void
 schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 {
 	long delay, delay_left;
 
-	delay = READ_ONCE(krcp->count) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
+	delay = krc_count(krcp) >= KVFREE_BULK_MAX_ENTR ? 1:KFREE_DRAIN_JIFFIES;
 	if (delayed_work_pending(&krcp->monitor_work)) {
 		delay_left = krcp->monitor_work.timer.expires - jiffies;
 		if (delay < delay_left)
@@ -3211,8 +3229,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
-				if (list_empty(&krwp->bulk_head_free[j]))
+				if (list_empty(&krwp->bulk_head_free[j])) {
 					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
+					atomic_set(&krcp->bulk_count[j], 0);
+				}
 			}
 
 			// Channel 3 corresponds to both SLAB and vmalloc
@@ -3220,6 +3240,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				WRITE_ONCE(krcp->head, NULL);
+				atomic_set(&krcp->head_count, 0);
 
 				// Take a snapshot for this krwp. Please note no more
 				// any objects can be added to attached head_free channel
@@ -3227,8 +3248,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 				krwp->head_free_gp_snap = get_state_synchronize_rcu();
 			}
 
-			WRITE_ONCE(krcp->count, 0);
-
 			// One work is per one batch, so there are three
 			// "free channels", the batch can handle. It can
 			// be that the work is in the pending state when
@@ -3365,6 +3384,8 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
 	bnode->gp_snap = get_state_synchronize_rcu();
+	atomic_inc(&(*krcp)->bulk_count[idx]);
+
 	return true;
 }
 
@@ -3418,11 +3439,10 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		head->func = ptr;
 		head->next = krcp->head;
 		WRITE_ONCE(krcp->head, head);
+		atomic_inc(&krcp->head_count);
 		success = true;
 	}
 
-	WRITE_ONCE(krcp->count, krcp->count + 1);
-
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);
@@ -3453,7 +3473,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		count += READ_ONCE(krcp->count);
+		count += krc_count(krcp);
 		count += READ_ONCE(krcp->nr_bkv_objs);
 		atomic_set(&krcp->backoff_page_cache_fill, 1);
 	}
@@ -3470,7 +3490,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		int count;
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		count = krcp->count;
+		count = krc_count(krcp);
 		count += drain_page_cache(krcp);
 		kfree_rcu_monitor(&krcp->monitor_work.work);
 
-- 
2.31.1.189.g2e36527f23

