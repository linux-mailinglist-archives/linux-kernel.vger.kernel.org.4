Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D8664C8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbiLNMJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237935AbiLNMJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:09:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F18275E8;
        Wed, 14 Dec 2022 04:06:35 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kw15so43939068ejc.10;
        Wed, 14 Dec 2022 04:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3lOYLy6hAwvTbleBaisZzVn+G3EKZrKO7ElSF5IHAY=;
        b=XUIyDci7KG2VideokEYfZEJJ/hRZJMdB9EZ9D6DxTtaLrYKIRhI/9L2rQSL/6dKlX5
         OxHsOa06vwov4+QSwvOXVMW0SLYSw2qfNHN1nx7pVTMCSC/BeV5sbJbr6Gw3edpL1KSW
         SlmgtAlS9sGYTX5XeIgFTcw5ImNOghldo9fE3PirjmoXnHvl2KHBcV+134cOfRzHVRGi
         LjCJYASlEE12Z9HNWIUNDGfCZzBhaADrqIaJgYc/QTHyduYZlD9cfkhBfmAnsqspftYm
         l0AADoIaxeh/dsn0s/YdaQleTp2SwB6SQwpvPzgZb6G7safg8eieF0ZToxs5W4j/KteG
         hZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3lOYLy6hAwvTbleBaisZzVn+G3EKZrKO7ElSF5IHAY=;
        b=7QNSapdeGb08I/mFgGprcd364614sRkLAGPJrhRqtdxX+dw5JnIdZef9ugHjjrJlPt
         Ok2BbZheWmtyhCPmDXSsLI0Ut7wb1FCRsJbum99zC+w0rnvdEHadeV/VwkEhfhIO0I4Q
         kC0hufo2RPskwJMMvYQ946hok84hxkTFAa7Y3lSZ1Uok+D5Gla+TI//HFf6BKPMyPu71
         icEanuNjeEUubg4iTLeQHJe0ZvoaauJ2/xRAkWzTqouEvbkJtKlV7XWv4saoG5WeK3ZJ
         talxyCFbxiy6LGU2NrnhZPufp5ZhTHnmDUu7mx/7IfrCxdueSxQ3jDWfDpE2XHPDESLp
         DlkQ==
X-Gm-Message-State: ANoB5plabhKJGZdHut6nfAGRaoT+eOY7FwOyW5DPU72NrYwyxofqnZ7m
        8KNIuuWGyijzQOcgXPE7r3ndgLCUd+8=
X-Google-Smtp-Source: AMrXdXuUEU4KaxoejgGAjUJiJl1PeXQyOqRzefnO0YnOu5EBl3cRMH2D//PD6u4xIBdfe15fx75Ltg==
X-Received: by 2002:a17:906:34d8:b0:7c4:f8fb:6a27 with SMTP id h24-20020a17090634d800b007c4f8fb6a27mr226013ejb.0.1671019594374;
        Wed, 14 Dec 2022 04:06:34 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id d17-20020a170906305100b007c0b28b85c5sm5669875ejd.138.2022.12.14.04.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:06:33 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/2] rcu/kvfree: Split ready for reclaim objects from a batch
Date:   Wed, 14 Dec 2022 13:06:30 +0100
Message-Id: <20221214120630.379527-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221214120630.379527-1-urezki@gmail.com>
References: <20221214120630.379527-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits ready to free pointers from the ones which
require an extra grace period. This is done before submitting
a new batch.

Once a split is done, ready to free are released right away
and after that a new batch is queued from the monitor work
over a queue_rcu_work().

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 87 +++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 312cb0dee117..50a585caf698 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2764,15 +2764,13 @@ struct kvfree_rcu_bulk_data {
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
@@ -2780,6 +2778,7 @@ struct kfree_rcu_cpu_work {
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
+ * @head_gp_snap: Snapshot of RCU state for objects placed to "@head"
  * @bulk_head: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
  * @lock: Synchronize access to this structure
@@ -2807,6 +2806,7 @@ struct kfree_rcu_cpu {
 	// Objects queued on a linked list
 	// through their rcu_head structures.
 	struct rcu_head *head;
+	unsigned long head_gp_snap;
 	atomic_t head_count;
 
 	// Objects queued on a bulk-list.
@@ -2975,10 +2975,9 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
-	unsigned long head_free_gp_snap;
 	int i;
 
-	krwp = container_of(work,
+	krwp = container_of(to_rcu_work(work),
 		struct kfree_rcu_cpu_work, rcu_work);
 	krcp = krwp->krcp;
 
@@ -2990,26 +2989,11 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3021,10 +3005,7 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3065,6 +3046,44 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu *krcp)
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
@@ -3075,6 +3094,9 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	unsigned long flags;
 	int i, j;
 
+	// Drain ready for reclaim.
+	kvfree_rcu_drain_ready(krcp);
+
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 
 	// Attempt to start a new batch.
@@ -3094,8 +3116,9 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// Channel 2 corresponds to vmalloc-pointer bulk path.
 			for (j = 0; j < FREE_N_CHANNELS; j++) {
 				if (list_empty(&krwp->bulk_head_free[j])) {
-					list_replace_init(&krcp->bulk_head[j], &krwp->bulk_head_free[j]);
 					atomic_set(&krcp->bulk_count[j], 0);
+					list_replace_init(&krcp->bulk_head[j],
+						&krwp->bulk_head_free[j]);
 				}
 			}
 
@@ -3103,13 +3126,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3117,7 +3135,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_work(system_wq, &krwp->rcu_work);
+			queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3304,6 +3322,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 		head->next = krcp->head;
 		WRITE_ONCE(krcp->head, head);
 		atomic_inc(&krcp->head_count);
+
+		// Take a snapshot for this krcp.
+		krcp->head_gp_snap = get_state_synchronize_rcu();
 		success = true;
 	}
 
@@ -4860,7 +4881,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 
 			for (j = 0; j < FREE_N_CHANNELS; j++)
-- 
2.30.2

