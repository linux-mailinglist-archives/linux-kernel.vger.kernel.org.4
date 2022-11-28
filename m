Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2B663ACBC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiK1PhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiK1Pgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:36:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DA112AAE;
        Mon, 28 Nov 2022 07:36:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id td2so12699596ejc.5;
        Mon, 28 Nov 2022 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjZC8oz4eSz/h0GXB4XNuXwYGePhtNfkeI4YWERXdjQ=;
        b=lScR4JUm2TXvlzPIwB3dFKToQLqP7DNfSBzccmwNbLEP0T5PHkIvfgMcOzVMky2VaH
         X7wHAAn9GooxUSTYfiZF9Q6rFqdEYkYsS7rEfAzu6rSeGTie2DJRm7pDPJlbwKA3t6gC
         4vGwm/gZaLSwtAdEg2OxbAD2MwSH0W5K1SsaZkRs5CHf7/CZvv3DJeALpgPpPjq0xcWA
         MmauCF4saFG9k3quttAxXuF9AhUXH6BfZQeRKvo55NMJzKkUP5ca6R/fnfW72Cie1GYK
         Zx5rfW4StO3nuBMwEXOg9w4W6Y86NDxTwcLfZ0lYidhR9gIOmcJlghf6gd4OFOJfBHJr
         t/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjZC8oz4eSz/h0GXB4XNuXwYGePhtNfkeI4YWERXdjQ=;
        b=f1qiidA4zHSQC4jVfhmJA1J99AJomb4y890Mjehzxy4rfd5T5Rmxcm5myZqqJ1r/wF
         oUK3Lwp80Qggji1amFkkS/e9+NLBeLZ8+jqcr4CfDx82KR/EyibXT4LVjsOFIfCGBP5p
         Z3p6RwmNesMY+Mcip7Lj0L7/qhxjIWg9JxSa1LKnQx36raghAuVGQKbw+t4TdQsGwZ6+
         mni1dDNB84QZpXuLd6S9mcJxiFh74hiCfEUQGq3Unq73R4DX5kGEzWD13KBe4BmyKEvg
         ICLemN90ZgkHFWn2nBekQzqiFNUMkwf6De4oFT1YvyhKyTkQFiDw4vPE20lfsDc3TwQM
         YprA==
X-Gm-Message-State: ANoB5pngzmwgzflHFF2vo1YG1B7QNsADQgfj1KrwYY/DUS4CbdmmhCDX
        AmzlJ1wDt+AQNeT42KYwCZUZs4E7YyE=
X-Google-Smtp-Source: AA0mqf5pWrze0pyrPy0dr5tuOj4yhIVmFT8M+nbUHASc/TKnp6zC65YcfyPc6dZ1Z+32Uoq6pnSZVA==
X-Received: by 2002:a17:906:5f88:b0:7c0:7fda:7f7d with SMTP id a8-20020a1709065f8800b007c07fda7f7dmr1267587eju.424.1669649798386;
        Mon, 28 Nov 2022 07:36:38 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b00459ad800bbcsm5303306edr.33.2022.11.28.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:36:38 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 4/4] rcu/kvfree: Use a polled API to speedup a reclaim process
Date:   Mon, 28 Nov 2022 16:36:28 +0100
Message-Id: <20221128153628.541361-4-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128153628.541361-1-urezki@gmail.com>
References: <20221128153628.541361-1-urezki@gmail.com>
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
index f68ddbef2a33..b41241994672 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2901,11 +2901,13 @@ EXPORT_SYMBOL_GPL(call_rcu);
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
@@ -2922,13 +2924,15 @@ struct kvfree_rcu_bulk_data {
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
@@ -3124,10 +3128,11 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3138,12 +3143,29 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3152,7 +3174,10 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3219,6 +3244,11 @@ static void kfree_rcu_monitor(struct work_struct *work)
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
@@ -3228,7 +3258,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			queue_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3356,8 +3386,9 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 		list_add(&bnode->list, &(*krcp)->bulk_head[idx]);
 	}
 
-	/* Finally insert. */
+	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
+	bnode->gp_snap = get_state_synchronize_rcu();
 	return true;
 }
 
@@ -4812,7 +4843,7 @@ static void __init kfree_rcu_batch_init(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
-			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
+			INIT_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 
 			for (j = 0; j < FREE_N_CHANNELS; j++)
-- 
2.30.2

