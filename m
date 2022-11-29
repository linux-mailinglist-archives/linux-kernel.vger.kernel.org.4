Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818DC63C479
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiK2QA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK2QAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:00:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF642F5E;
        Tue, 29 Nov 2022 07:58:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ho10so34917569ejc.1;
        Tue, 29 Nov 2022 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BILtrzXJ5yRtYE7hhS8hAZjrORquLTNRlDKrfD5m1Tk=;
        b=KVzbEMgthPEe+IT7Qhrq2QMU3YdiDdSJOat5VBF7tlTpnscSkASWTr7tPF9t9dicoB
         Ct6jU9IYz3tWe0pud1GHpiEMuVPW0/O8wy0+IMLBShIfPdkRHXd03KyUpjqXMlTI8nbY
         DRsi9ZPX1vmLhdUYKYkUaIUkuB1+659Xlh8k5a3fwEvQTTzYWYaYLtbJnvTt7njT1d1U
         xzS3fvcgy9mgl1LQ91ryOtvFHATwNQuUYkTPS8xX+7veMEbs3qzzMOzxzRimH0L7L1H7
         i5pPw/MSlK7GfIXwRh+HDyO1BkFv2WZa0ycbZ54qbH4UoBp8HitOc6W1LhPxiN/VNybp
         4v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BILtrzXJ5yRtYE7hhS8hAZjrORquLTNRlDKrfD5m1Tk=;
        b=rtsnmC13zJ6rve60YiocuCzAqwDfZXnCTebXh5+bUFNdVvFfPxYTLzhCkG25qGdS9I
         qsm7nu5dtAJPmP0acWHx6nooDsLEVjgCrfHkB0VAkTK8KVKSkmqqxe4+AXChxHgAXJWX
         qTmeoL0OlcfiyRVjLVLS2fwLte5D1x7Yer6nhv9YXmrUUc1WMjFddiGxfob0nPsZhsOw
         NLn0Maj7GTpL8hpJHoBfJLbm6Q1yS7cDgyBYWsR/I/CagOxR6Ht/TfMfABhndYYCELMB
         HEvxt2A1GSQ4izw/LqEZd6VGfkf1lbwYjNoiDbUhOHg+8PgUmq1KGNRh8zTIRtOoNEDz
         2jew==
X-Gm-Message-State: ANoB5pnRIMcrB5nLD2rkGTIw7H2KqT+YAFnnl3UYJhYDGHWsSbgFr4xC
        Clok9wyl3ZpLszxq5HFGye4s3YcNLs8=
X-Google-Smtp-Source: AA0mqf68VGneVeGR5DNdsE8M+YauIMts+4sX3B1v7WOnMxS/cCeEgBmhWx4vKzNzYKuhwP2H72W9TA==
X-Received: by 2002:a17:906:9493:b0:7ad:83cb:85e6 with SMTP id t19-20020a170906949300b007ad83cb85e6mr49631092ejx.108.1669737511157;
        Tue, 29 Nov 2022 07:58:31 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm6371059edx.10.2022.11.29.07.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:58:30 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 1/4] rcu/kvfree: Switch to a generic linked list API
Date:   Tue, 29 Nov 2022 16:58:19 +0100
Message-Id: <20221129155822.538434-2-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221129155822.538434-1-urezki@gmail.com>
References: <20221129155822.538434-1-urezki@gmail.com>
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

To make a code more readable and less confusing switch
to a standard circular double linked list API. It allows
to simplify the code since basic list operations are well
defined and documented.

Please note, this patch does not introduce any functional
change it is only limited by refactoring of code.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 89 +++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 46 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 219b4b516f38..1c79b244aac9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2740,13 +2740,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
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
 
@@ -2762,21 +2762,21 @@ struct kvfree_rcu_bulk_data {
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
@@ -2800,7 +2800,7 @@ struct kfree_rcu_cpu_work {
  */
 struct kfree_rcu_cpu {
 	struct rcu_head *head;
-	struct kvfree_rcu_bulk_data *bkvhead[FREE_N_CHANNELS];
+	struct list_head bulk_head[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
@@ -2895,12 +2895,13 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 
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
@@ -2912,10 +2913,8 @@ static void kfree_rcu_work(struct work_struct *work)
 
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
@@ -2924,36 +2923,33 @@ static void kfree_rcu_work(struct work_struct *work)
 
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
@@ -2989,7 +2985,7 @@ need_offload_krc(struct kfree_rcu_cpu *krcp)
 	int i;
 
 	for (i = 0; i < FREE_N_CHANNELS; i++)
-		if (krcp->bkvhead[i])
+		if (!list_empty(&krcp->bulk_head[i]))
 			return true;
 
 	return !!krcp->head;
@@ -3026,21 +3022,20 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3152,10 +3147,11 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
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
@@ -3179,18 +3175,13 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
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
 
@@ -4779,7 +4770,7 @@ struct workqueue_struct *rcu_gp_wq;
 static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
-	int i;
+	int i, j;
 
 	/* Clamp it to [0:100] seconds interval. */
 	if (rcu_delay_page_cache_fill_msec < 0 ||
@@ -4799,8 +4790,14 @@ static void __init kfree_rcu_batch_init(void)
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
2.30.2

