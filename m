Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7C63C47C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbiK2QAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbiK2QAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:00:05 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8F59856;
        Tue, 29 Nov 2022 07:58:35 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id d20so9625596edn.0;
        Tue, 29 Nov 2022 07:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndu8NLiGjk7yRkLXGpL0Z42hS5iNlQz7b0o3ua4PdvI=;
        b=LGJS13DqQAiOtBkjjE+GxM+AJP0mskXMq5M1ui7bL9ICiCIxNir4ZQtWt5IX2CwMUz
         uE3PdyGluk3ivEKkDoEOLf+ctFNjJV4VmEsXoti0oDJVe0fcVy3ljyChvG7v0KhELMam
         drXGRLFhZt/F+GFaz5w9ICf62rLfpnbXn2xze+9TM9IUIHOdQyN8ofOZpc7/3bRgaqtT
         w3NTPy5JqhHiANe7X+A39RBZJhGFx+BKkBgSLwuckeyipaFKTGXXNX8YCqPQz61WM/6j
         a/DTihkR5lS4g1o33Qzcr4z+SzM0wb4DwXnsdJbGhKHl9HiTb0uHa9HTdNTWxUPYC6Wx
         1jVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndu8NLiGjk7yRkLXGpL0Z42hS5iNlQz7b0o3ua4PdvI=;
        b=YQyAtkt/N6R61bbUfyaa4/RCoFkOEdGw/vJCmf6ggzuucM0msL3iyHOtHKf8BlL6lW
         vzd0mc9QCXv9IQLXebbvOieZKGnu0VqDdCctIGyRZ2ICgN/TO8wt8WFJVcy6HGvSleX2
         rnzXkj/WystGC0ndYdXCgKrChuxYbjeMG7WX6BKejGg5x8Qt+eN6c5zJrmXxNQdJuWM+
         w2JARrqfV1HPwpXDcKeSPuYWsWmXzpqy5/AygwYx124+rpsgRGzj+iYmateLev7irnzA
         Z1uJqVHk1hOd0LAeHdbpbQy8Cfflw/4Ja1HZn82SET7TuZrfPvb138oEDNOZLudpVggb
         ekpQ==
X-Gm-Message-State: ANoB5pmVratW1pq7EyrwoM2qV6crhdziS3hpc67tr7+cSrIdXLzOj37R
        WlO/pf+HizHligsD5X3pTE1ReI/gLUQ=
X-Google-Smtp-Source: AA0mqf6jheYnM8cLkZNMbknrGpAhk3zVWsLiJV+U+ifBhgE93tzOkvuvKhoW82EvHxyB6lYSCSlcEg==
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id t33-20020a056402242100b00461524fa8f4mr51873418eda.260.1669737514117;
        Tue, 29 Nov 2022 07:58:34 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm6371059edx.10.2022.11.29.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:58:33 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 4/4] rcu/kvfree: Use a polled API to speedup a reclaim process
Date:   Tue, 29 Nov 2022 16:58:22 +0100
Message-Id: <20221129155822.538434-5-urezki@gmail.com>
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

Currently all objects placed into a batch require a full GP
after passing which objects in a batch are eligible to be
freed.

The problem is that many pointers may already passed several
GP sequences so there is no need for them in extra delay and
such objects can be reclaimed right away without waiting.

In order to reduce a memory footprint this patch introduces
a per-page-grace-period-controlling mechanism. It allows us
to distinguish pointers for which a grace period is passed
and for which not.

A reclaim thread in its turn frees a memory in a reverse
order starting from a tail because a GP is likely passed
for objects in a page. If a page with a GP sequence in a
list hits a condition when a GP is not ready we bail out
requesting one more grace period in order to complete a
drain process for left pages.

Test example:

kvm.sh --memory 10G --torture rcuscale --allcpus --duration 1 \
  --kconfig CONFIG_NR_CPUS=64 \
  --kconfig CONFIG_RCU_NOCB_CPU=y \
  --kconfig CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y \
  --kconfig CONFIG_RCU_LAZY=n \
  --bootargs "rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 \
  rcuscale.holdoff=20 rcuscale.kfree_loops=10000 \
  torture.disable_onoff_at_boot" --trust-make

Total time taken by all kfree'ers: 8535693700 ns, loops: 10000, batches: 1188, memory footprint: 2248MB
Total time taken by all kfree'ers: 8466933582 ns, loops: 10000, batches: 1157, memory footprint: 2820MB
Total time taken by all kfree'ers: 5375602446 ns, loops: 10000, batches: 1130, memory footprint: 6502MB
Total time taken by all kfree'ers: 7523283832 ns, loops: 10000, batches: 1006, memory footprint: 3343MB
Total time taken by all kfree'ers: 6459171956 ns, loops: 10000, batches: 1150, memory footprint: 6549MB

Total time taken by all kfree'ers: 8560060176 ns, loops: 10000, batches: 1787, memory footprint: 61MB
Total time taken by all kfree'ers: 8573885501 ns, loops: 10000, batches: 1777, memory footprint: 93MB
Total time taken by all kfree'ers: 8320000202 ns, loops: 10000, batches: 1727, memory footprint: 66MB
Total time taken by all kfree'ers: 8552718794 ns, loops: 10000, batches: 1790, memory footprint: 75MB
Total time taken by all kfree'ers: 8601368792 ns, loops: 10000, batches: 1724, memory footprint: 62MB

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 47 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c94c17194299..44279ca488ef 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2741,11 +2741,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2762,13 +2764,15 @@ struct kvfree_rcu_bulk_data {
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
@@ -2964,10 +2968,11 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -2978,12 +2983,29 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -2992,7 +3014,10 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3059,6 +3084,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3068,7 +3098,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3196,8 +3226,9 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
 	}
 
-	/* Finally insert. */
+	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
+	bnode->gp_snap = get_state_synchronize_rcu();
 	return true;
 }
 
@@ -4801,7 +4832,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 
 			for (j = 0; j < FREE_N_CHANNELS; j++)
-- 
2.30.2

