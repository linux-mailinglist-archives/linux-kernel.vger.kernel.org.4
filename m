Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC33C65E187
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240349AbjAEA0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjAEA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3654FD78;
        Wed,  4 Jan 2023 16:24:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC16761880;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3330EC433D2;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=9q3RXJaEMI0bXFO/vylOhYFyrOVZOPbjbOVjXgIBpGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFXK80sEV5h+vkOB8PnwWECzrbUYp/b297NgAZahEHq44//vzGeqCFZtKKqfathpL
         qmXHwFA/fOFCI2EzaUykt6N6qrfDAEDh7ntVvMBEW3laHX2zk+cSpEzkrffK+yPywC
         gnGwKMAmwG5HeM5QA4YeK/DuCLWOMvgg5eZR2esF0Jmj8IJrAnxBVB8ys+mm7HCfzL
         3wm0NOhK68AWOJncmc/oEYVMykLfcH1G2oQhufRoGw42KFvRQI4J9+1OvaVYOk6oYb
         ZmJkeg6GA54gLhya4oyXN7EEDpp2+MBdfMocrTFTTxhC+UoU8PV3fQn1gMJ01BEZH0
         TD+2y0KCVSTTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E27975C086D; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/8] rcu/kvfree: Switch to a generic linked list API
Date:   Wed,  4 Jan 2023 16:24:42 -0800
Message-Id: <20230105002448.1768892-2-paulmck@kernel.org>
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

This commit improves the readability and maintainability of the
kvfree_rcu() code by switching from an open-coded linked list to
the standard Linux-kernel circular doubly linked list.  This patch
does not introduce any functional change.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 89 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7d222acd85bfd..4088b34ce9610 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2876,13 +2876,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 /**
  * struct kvfree_rcu_bulk_data - single block to store kvfree_rcu() pointers
+ * @list: List node. All blocks are linked between each other
  * @nr_records: Number of active pointers in the array
- * @next: Next bulk object in the block chain
  * @records: Array of the kvfree_rcu() pointers
  */
 struct kvfree_rcu_bulk_data {
+	struct list_head list;
 	unsigned long nr_records;
-	struct kvfree_rcu_bulk_data *next;
 	void *records[];
 };
 
@@ -2898,21 +2898,21 @@ struct kvfree_rcu_bulk_data {
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
- * @bkvhead_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
+ * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
 
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
-	struct kvfree_rcu_bulk_data *bkvhead_free[FREE_N_CHANNELS];
+	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
- * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
+ * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
  * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
@@ -2936,7 +2936,7 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
-	struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS];
+	struct list_head bulk_head[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -3031,12 +3031,13 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
 /*
  * This function is invoked in workqueue context after a grace period.
- * It frees all the objects queued on ->bkvhead_free or ->head_free.
+ * It frees all the objects queued on ->bulk_head_free or ->head_free.
  */
 static void kfree_rcu_work(struct work_struct *work)
 {
 	unsigned long flags;
-	struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS], *bnext;
+	struct kvfree_rcu_bulk_data *bnode, *n;
+	struct list_head bulk_head[FREE_N_CHANNELS];
 	struct rcu_head *head, *next;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
@@ -3048,10 +3049,8 @@ static void kfree_rcu_work(struct work_struct *work)
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	// Channels 1 and 2.
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		bkvhead[i] = krwp->bkvhead_free[i];
-		krwp->bkvhead_free[i] = NULL;
-	}
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		list_replace_init(&krwp->bulk_head_free[i], &bulk_head[i]);
 
 	// Channel 3.
 	head = krwp->head_free;
@@ -3060,36 +3059,33 @@ static void kfree_rcu_work(struct work_struct *work)
 
 	// Handle the first two channels.
 	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		for (; bkvhead[i]; bkvhead[i] = bnext) {
-			bnext = bkvhead[i]->next;
-			debug_rcu_bhead_unqueue(bkvhead[i]);
+		list_for_each_entry_safe(bnode, n, &bulk_head[i], list) {
+			debug_rcu_bhead_unqueue(bnode);
 
 			rcu_lock_acquire(&rcu_callback_map);
 			if (i == 0) { // kmalloc() / kfree().
 				trace_rcu_invoke_kfree_bulk_callback(
-					rcu_state.name, bkvhead[i]->nr_records,
-					bkvhead[i]->records);
+					rcu_state.name, bnode->nr_records,
+					bnode->records);
 
-				kfree_bulk(bkvhead[i]->nr_records,
-					bkvhead[i]->records);
+				kfree_bulk(bnode->nr_records, bnode->records);
 			} else { // vmalloc() / vfree().
-				for (j = 0; j < bkvhead[i]->nr_records; j++) {
+				for (j = 0; j < bnode->nr_records; j++) {
 					trace_rcu_invoke_kvfree_callback(
-						rcu_state.name,
-						bkvhead[i]->records[j], 0);
+						rcu_state.name, bnode->records[j], 0);
 
-					vfree(bkvhead[i]->records[j]);
+					vfree(bnode->records[j]);
 				}
 			}
 			rcu_lock_release(&rcu_callback_map);
 
 			raw_spin_lock_irqsave(&krcp->lock, flags);
-			if (put_cached_bnode(krcp, bkvhead[i]))
-				bkvhead[i] = NULL;
+			if (put_cached_bnode(krcp, bnode))
+				bnode = NULL;
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
-			if (bkvhead[i])
-				free_page((unsigned long) bkvhead[i]);
+			if (bnode)
+				free_page((unsigned long) bnode);
 
 			cond_resched_tasks_rcu_qs();
 		}
@@ -3125,7 +3121,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	int i;
 
 	for (i = 0; i < FREE_N_CHANNELS; i++)
-		if (krcp->bkvhead[i])
+		if (!list_empty(&krcp->bulk_head[i]))
 			return true;
 
 	return !!krcp->head;
@@ -3162,21 +3158,20 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	for (i = 0; i < KFREE_N_BATCHES; i++) {
 		struct kfree_rcu_cpu_work *krwp = &(krcp->krw_arr[i]);
 
-		// Try to detach bkvhead or head and attach it over any
+		// Try to detach bulk_head or head and attach it over any
 		// available corresponding free channel. It can be that
 		// a previous RCU batch is in progress, it means that
 		// immediately to queue another one is not possible so
 		// in that case the monitor work is rearmed.
-		if ((krcp->bkvhead[0] && !krwp->bkvhead_free[0]) ||
-			(krcp->bkvhead[1] && !krwp->bkvhead_free[1]) ||
+		if ((!list_empty(&krcp->bulk_head[0]) && list_empty(&krwp->bulk_head_free[0])) ||
+			(!list_empty(&krcp->bulk_head[1]) && list_empty(&krwp->bulk_head_free[1])) ||
 				(krcp->head && !krwp->head_free)) {
+
 			// Channel 1 corresponds to the SLAB-pointer bulk path.
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
-				if (!krwp->bkvhead_free[j]) {
-					krwp->bkvhead_free[j] = krcp->bkvhead[j];
-					krcp->bkvhead[j] = NULL;
-				}
+				if (list_empty(&krwp->bulk_head_free[j]))
+					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
 			}
 
 			// Channel 3 corresponds to both SLAB and vmalloc
@@ -3288,10 +3283,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		return false;
 
 	idx = !!is_vmalloc_addr(ptr);
+	bnode = list_first_entry_or_null(&(*krcp)->bulk_head[idx],
+		struct kvfree_rcu_bulk_data, list);
 
 	/* Check if a new block is required. */
-	if (!(*krcp)->bkvhead[idx] ||
-			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
+	if (!bnode || bnode->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(*krcp);
 		if (!bnode && can_alloc) {
 			krc_this_cpu_unlock(*krcp, *flags);
@@ -3315,18 +3311,13 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		if (!bnode)
 			return false;
 
-		/* Initialize the new block. */
+		// Initialize the new block and attach it.
 		bnode->nr_records = 0;
-		bnode->next = (*krcp)->bkvhead[idx];
-
-		/* Attach it to the head. */
-		(*krcp)->bkvhead[idx] = bnode;
+		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
 	}
 
 	/* Finally insert. */
-	(*krcp)->bkvhead[idx]->records
-		[(*krcp)->bkvhead[idx]->nr_records++] = ptr;
-
+	bnode->records[bnode->nr_records++] = ptr;
 	return true;
 }
 
@@ -4761,7 +4752,7 @@ struct workqueue_struct *rcu_gp_wq;
 static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
-	int i;
+	int i, j;
 
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
@@ -4781,8 +4772,14 @@ static void __init kfree_rcu_batch_init(void)
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
+
+			for (j = 0; j < FREE_N_CHANNELS; j++)
+				INIT_LIST_HEAD(&krcp->krw_arr[i].bulk_head_free[j]);
 		}
 
+		for (i = 0; i < FREE_N_CHANNELS; i++)
+			INIT_LIST_HEAD(&krcp->bulk_head[i]);
+
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
 		INIT_DELAYED_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
-- 
2.31.1.189.g2e36527f23

