Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6B65E18F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjAEA2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbjAEA0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB254A975;
        Wed,  4 Jan 2023 16:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6335A61888;
        Thu,  5 Jan 2023 00:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CFAC4339E;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=BPcSGuUJdzaOvgoBas81TEqlhrtXgfDZlFCPUYBEIeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=khtpiFUCsXev16OPCqlsUBNEnj6Lbk/2xj3B7g6QBfsy+k/hcGlh3/aq+peF2VFI4
         x1BLTaPBRRiUbFUO/gH0CrUH2jEXpJZubnQ872PN4Zzoz+arUrHDTyg/1Zc82bpDe5
         4M7eY8ciQJZcWnCEc1pFQOfARFzK3uyne+4wOt5l4syPSNb6/awLd73hxFpACj6vjN
         QG7hmD6vewbXZN5jBgbo+O2ZMy8sv6q5yAdoIafoVypqLS2T9WxeWwu+T69mhsnUye
         W35SZGFYBr3BNDjG5bSJSs2qEJsrIzd8ZWjJxFVj7FweXxoAa8mLcXGUcZE3cB0huQ
         m3HcVX4K8XRWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F1C5C5C1C5B; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/8] rcu/kvfree: Split ready for reclaim objects from a batch
Date:   Wed,  4 Jan 2023 16:24:48 -0800
Message-Id: <20230105002448.1768892-8-paulmck@kernel.org>
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

This patch splits the lists of objects so as to avoid sending any
through RCU that have already been queued for more than one grace
period.  These long-term-resident objects are immediately freed.
The remaining short-term-resident objects are queued for later freeing
using queue_rcu_work().

This change avoids delaying workqueue handlers with synchronize_rcu()
invocations.  Yes, workqueue handlers are designed to handle blocking,
but avoiding blocking when unnecessary improves performance during
low-memory situations.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 87 +++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 52f4c7e87f88e..0b4f7dd551572 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2900,15 +2900,13 @@ struct kvfree_rcu_bulk_data {
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
- * @head_free_gp_snap: Snapshot of RCU state for objects placed to "@head_free"
  * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
-	struct work_struct rcu_work;
+	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
-	unsigned long head_free_gp_snap;
 	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
@@ -2916,6 +2914,7 @@ struct kfree_rcu_cpu_work {
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
  * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
@@ -2943,6 +2942,7 @@ struct kfree_rcu_cpu {
 	// Objects queued on a linked list
 	// through their rcu_head structures.
 	struct rcu_head *head;
+	unsigned long head_gp_snap;
 	atomic_t head_count;
 
 	// Objects queued on a bulk-list.
@@ -3111,10 +3111,9 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
-	unsigned long head_free_gp_snap;
 	int i;
 
-	krwp = container_of(work,
+	krwp = container_of(to_rcu_work(work),
 		struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
 
@@ -3126,26 +3125,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
-	head_free_gp_snap = krwp->head_free_gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
 		// Start from the tail page, so a GP is likely passed for it.
-		list_for_each_entry_safe_reverse(bnode, n, &bulk_head[i], list) {
-			// Not yet ready? Bail out since we need one more GP.
-			if (!poll_state_synchronize_rcu(bnode->gp_snap))
-				break;
-
-			list_del_init(&bnode->list);
-			kvfree_rcu_bulk(krcp, bnode, i);
-		}
-
-		// Please note a request for one more extra GP can
-		// occur only once for all objects in this batch.
-		if (!list_empty(&bulk_head[i]))
-			synchronize_rcu();
-
 		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
 			kvfree_rcu_bulk(krcp, bnode, i);
 	}
@@ -3157,10 +3141,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	if (head) {
-		cond_synchronize_rcu(head_free_gp_snap);
-		kvfree_rcu_list(head);
-	}
+	kvfree_rcu_list(head);
 }
 
 static bool
@@ -3201,6 +3182,44 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
 	queue_delayed_work(system_wq, &krcp->monitor_work, delay);
 }
 
+static void
+kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
+{
+	struct list_head bulk_ready[FREE_N_CHANNELS];
+	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct rcu_head *head_ready = NULL;
+	unsigned long flags;
+	int i;
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		INIT_LIST_HEAD(&bulk_ready[i]);
+
+		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
+			if (!poll_state_synchronize_rcu(bnode->gp_snap))
+				break;
+
+			atomic_sub(bnode->nr_records, &krcp->bulk_count[i]);
+			list_move(&bnode->list, &bulk_ready[i]);
+		}
+	}
+
+	if (krcp->head && poll_state_synchronize_rcu(krcp->head_gp_snap)) {
+		head_ready = krcp->head;
+		atomic_set(&krcp->head_count, 0);
+		WRITE_ONCE(krcp->head, NULL);
+	}
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		list_for_each_entry_safe(bnode, n, &bulk_ready[i], list)
+			kvfree_rcu_bulk(krcp, bnode, i);
+	}
+
+	if (head_ready)
+		kvfree_rcu_list(head_ready);
+}
+
 /*
  * This function is invoked after the KFREE_DRAIN_JIFFIES timeout.
  */
@@ -3211,6 +3230,9 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	unsigned long flags;
 	int i, j;
 
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 
 	// Attempt to start a new batch.
@@ -3230,8 +3252,9 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (list_empty(&krwp->bulk_head_free[j])) {
-					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
 					atomic_set(&krcp->bulk_count[j], 0);
+					list_replace_init(&krcp->bulk_head[j],
+						&krwp->bulk_head_free[j]);
 				}
 			}
 
@@ -3239,13 +3262,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
-				WRITE_ONCE(krcp->head, NULL);
 				atomic_set(&krcp->head_count, 0);
-
-				// Take a snapshot for this krwp. Please note no more
-				// any objects can be added to attached head_free channel
-				// therefore fixate a GP for it here.
-				krwp->head_free_gp_snap = get_state_synchronize_rcu();
+				WRITE_ONCE(krcp->head, NULL);
 			}
 
 			// One work is per one batch, so there are three
@@ -3253,7 +3271,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3440,6 +3458,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		head->next = krcp->head;
 		WRITE_ONCE(krcp->head, head);
 		atomic_inc(&krcp->head_count);
+
+		// Take a snapshot for this krcp.
+		krcp->head_gp_snap = get_state_synchronize_rcu();
 		success = true;
 	}
 
@@ -4834,7 +4855,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 
 			for (j = 0; j < FREE_N_CHANNELS; j++)
-- 
2.31.1.189.g2e36527f23

