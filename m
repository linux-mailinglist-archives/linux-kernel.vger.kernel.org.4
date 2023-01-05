Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9590665E18C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240371AbjAEA0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbjAEA0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A820850F51;
        Wed,  4 Jan 2023 16:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2DF26188D;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D264C433F0;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=LCE+SHgExBVrEz2EAshUB2ptHQamWCte/NKiDUBtId4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCQBIAXbEoDtbjF0OqnJDoNR0jiYtqCZCEyLTiGY1uD2OGAmEYKRbyPsUJybLSfC8
         rOlvkjRFFZKp/rW7wvfFTBKCdAnXyktk3VJXmMmTyHUpywkPevc0SRdPTLuOnWTj1J
         6I0rv/ORP1485Nvwutltd6V6SPsrSEyToCDE9RgEP6CCPSiWavLI3zl4UshUUecxoY
         oUD98NwCIYScSC0/faMcOy65cLDgUkdxKByqyvXl5SDV9cOYzFjyHPDZNjMq//6ntP
         hrRU/C2S8NCE52NOOWDNAvaMAqqiv3egZF/LSnZCG+vIdr9KUnUfS1BOOZbg9rQXT0
         Egen0kTu+23sw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EA3D15C149B; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/8] rcu/kvfree: Use a polled API to speedup a reclaim process
Date:   Wed,  4 Jan 2023 16:24:45 -0800
Message-Id: <20230105002448.1768892-5-paulmck@kernel.org>
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

Currently all objects placed into a batch wait for a full grace period
to elapse after that batch is ready to send to RCU.  However, this
can unnecessarily delay freeing of the first objects that were added
to the batch.  After all, several RCU grace periods might have elapsed
since those objects were added, and if so, there is no point in further
deferring their freeing.

This commit therefore adds per-page grace-period snapshots which are
obtained from get_state_synchronize_rcu().  When the batch is ready
to be passed to call_rcu(), each page's snapshot is checked by passing
it to poll_state_synchronize_rcu().  If a given page's RCU grace period
has already elapsed, its objects are freed immediately by kvfree_rcu_bulk().
Otherwise, these objects are freed after a call to synchronize_rcu().

This approach requires that the pages be traversed in reverse order,
that is, the oldest ones first.

Test example:

kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
  --kconfig CONFIG_NR_CPUS=64 \
  --kconfig CONFIG_RCU_NOCB_CPU=y \
  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
  --kconfig CONFIG_RCU_LAZY=n \
  --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
  rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
  torture.disable_onoff_at_boot" --trust-make

Before this commit:

Total time taken by all kfree'ers: 8535693700 ns, loops: 10000, batches: 1188, memory footprint: 2248MB
Total time taken by all kfree'ers: 8466933582 ns, loops: 10000, batches: 1157, memory footprint: 2820MB
Total time taken by all kfree'ers: 5375602446 ns, loops: 10000, batches: 1130, memory footprint: 6502MB
Total time taken by all kfree'ers: 7523283832 ns, loops: 10000, batches: 1006, memory footprint: 3343MB
Total time taken by all kfree'ers: 6459171956 ns, loops: 10000, batches: 1150, memory footprint: 6549MB

After this commit:

Total time taken by all kfree'ers: 8560060176 ns, loops: 10000, batches: 1787, memory footprint: 61MB
Total time taken by all kfree'ers: 8573885501 ns, loops: 10000, batches: 1777, memory footprint: 93MB
Total time taken by all kfree'ers: 8320000202 ns, loops: 10000, batches: 1727, memory footprint: 66MB
Total time taken by all kfree'ers: 8552718794 ns, loops: 10000, batches: 1790, memory footprint: 75MB
Total time taken by all kfree'ers: 8601368792 ns, loops: 10000, batches: 1724, memory footprint: 62MB

The reduction in memory footprint is well in excess of an order of
magnitude.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0c42fce4efe32..735312f78e980 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2877,11 +2877,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
 /**
  * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
  * @list: List node. All blocks are linked between each other
+ * @gp_snap: Snapshot of RCU state for objects placed to this bulk
  * @nr_records: Number of active pointers in the array
  * @records: Array of the kvfree_rcu() pointers
  */
 struct kvfree_rcu_bulk_data {
 	struct list_head list;
+	unsigned long gp_snap;
 	unsigned long nr_records;
 	void *records[];
 };
@@ -2898,13 +2900,15 @@ struct kvfree_rcu_bulk_data {
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @head_free_gp_snap: Snapshot of RCU state for objects placed to "@head_free"
  * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
-	struct rcu_work rcu_work;
+	struct work_struct rcu_work;
 	struct rcu_head *head_free;
+	unsigned long head_free_gp_snap;
 	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
@@ -3100,10 +3104,11 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	unsigned long head_free_gp_snap;
 	int i;
 
-	krwp = container_of(to_rcu_work(work),
-			    struct kfree_rcu_cpu_work, rcu_work);
+	krwp = container_of(work,
+		struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
@@ -3114,12 +3119,29 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	head_free_gp_snap = krwp->head_free_gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
-	for (i = 0; i < FREE_N_CHANNELS; i++)
+	for (i = 0; i < FREE_N_CHANNELS; i++) {
+		// Start from the tail page, so a GP is likely passed for it.
+		list_for_each_entry_safe_reverse(bnode, n, &bulk_head[i], list) {
+			// Not yet ready? Bail out since we need one more GP.
+			if (!poll_state_synchronize_rcu(bnode->gp_snap))
+				break;
+
+			list_del_init(&bnode->list);
+			kvfree_rcu_bulk(krcp, bnode, i);
+		}
+
+		// Please note a request for one more extra GP can
+		// occur only once for all objects in this batch.
+		if (!list_empty(&bulk_head[i]))
+			synchronize_rcu();
+
 		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
 			kvfree_rcu_bulk(krcp, bnode, i);
+	}
 
 	/*
 	 * This is used when the "bulk" path can not be used for the
@@ -3128,7 +3150,10 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	kvfree_rcu_list(head);
+	if (head) {
+		cond_synchronize_rcu(head_free_gp_snap);
+		kvfree_rcu_list(head);
+	}
 }
 
 static bool
@@ -3195,6 +3220,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
 				WRITE_ONCE(krcp->head, NULL);
+
+				// Take a snapshot for this krwp. Please note no more
+				// any objects can be added to attached head_free channel
+				// therefore fixate a GP for it here.
+				krwp->head_free_gp_snap = get_state_synchronize_rcu();
 			}
 
 			WRITE_ONCE(krcp->count, 0);
@@ -3204,7 +3234,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3332,8 +3362,9 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
 	}
 
-	/* Finally insert. */
+	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
+	bnode->gp_snap = get_state_synchronize_rcu();
 	return true;
 }
 
@@ -4783,7 +4814,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 
 			for (j = 0; j < FREE_N_CHANNELS; j++)
-- 
2.31.1.189.g2e36527f23

