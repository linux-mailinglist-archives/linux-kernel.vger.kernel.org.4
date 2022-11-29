Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0C63C478
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbiK2QAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbiK2QAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:00:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30136A775;
        Tue, 29 Nov 2022 07:58:33 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id b8so20345498edf.11;
        Tue, 29 Nov 2022 07:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1497nUJKqf7VUksi/0Y8xV/c/P+R8VIcAPELcOUy1w=;
        b=MhUMVf/m+igVldFa7ZmQ2pWdRqW1NuYkVc/IwSgq5NNNP5/jxn2sm/Z380OJj0htNf
         1zgvtVPf/Iyd0t6kPCVPZY6sMgXuGdDwBiZ5bnanINNSI7kG5lHI5gbJocSnwtvo1QmR
         9Xx+ilF4A4y1zoN4lPqZRtu52SbLop964AV/UxWTf7btSzSpFn7ZypYZarF+ikSibsHt
         shMpnQNClLljA49Qa+G1IOFvZyjNl4w2eX55G26YLHkR5mxU2bj57HKcXYAH69sUZ474
         WDCv7DQqIoEWi6mqTfDL+h0wB/T+bD1qG88nFMtVEUwkL75icLW+xth/k5aLuxnNSspd
         PxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1497nUJKqf7VUksi/0Y8xV/c/P+R8VIcAPELcOUy1w=;
        b=ziHLbvaz2aNl4ZGhvFL+JbfCmoTI6ufhwyyVu6EZpzALuwglE5Xnx6fosBrtfdAai0
         qlpp96bYg1Qw1jUGnw37r0lEZP9EHqnRxPEI6CYlEWlvOnXfw5Yq9XCfpLClFAcvaRjg
         FHfehxQUHBefMz4vXrIM60YhO7KG4Gma1XyLI/pp9tYoqSCZhNs3XcUR4vrx+wCPKCf5
         rcM3zOyKQ8//L79TJqAjUROiZH8qcAa+VTgaQzd0SL8tCbAVd2k7qIWYhxoHKdnwdcFe
         DgJnm1HTRIZqcL0IAbZBRqlHfXTnthOGOEptGHfOJSrQ0jywmTA6br9xFRZmQxXXZXl3
         Xtqg==
X-Gm-Message-State: ANoB5pkdWvsY4TMgBIHwnY2PbGNEr4rCAwWoflnC4JB+h+7J4I1DlFH7
        uDaOHl7u94IePWBWqBR/ZPndJhR33IQ=
X-Google-Smtp-Source: AA0mqf6b9TxEOWnQxnL4rSJh5Z0KY2uxGyNKqu356PyR0UMCjwvddB6RNRJ3OOpYqXnIztmm1vqq0Q==
X-Received: by 2002:a05:6402:1f89:b0:458:caec:8f1e with SMTP id c9-20020a0564021f8900b00458caec8f1emr51499032edc.280.1669737512122;
        Tue, 29 Nov 2022 07:58:32 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id u23-20020a056402065700b0046778ce5fdfsm6371059edx.10.2022.11.29.07.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:58:31 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 2/4] rcu/kvfree: Move bulk/list reclaim to separate functions
Date:   Tue, 29 Nov 2022 16:58:20 +0100
Message-Id: <20221129155822.538434-3-urezki@gmail.com>
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

There are two different paths how a memory is reclaimed.
Currently it is open-coded what makes it a bit messy and
less easy to read.

Introduce two separate functions kvfree_rcu_list() and
kvfree_rcu_bulk() to cover two independent cases.

Please note, this patch does not introduce any functional
change it is only limited by refactoring of code.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 114 ++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1c79b244aac9..445f8c11a9a3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2893,6 +2893,65 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
 	return freed;
 }
 
+static void
+kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
+	struct kvfree_rcu_bulk_data *bnode, int idx)
+{
+	unsigned long flags;
+	int i;
+
+	debug_rcu_bhead_unqueue(bnode);
+
+	rcu_lock_acquire(&rcu_callback_map);
+	if (idx == 0) { // kmalloc() / kfree().
+		trace_rcu_invoke_kfree_bulk_callback(
+			rcu_state.name, bnode->nr_records,
+			bnode->records);
+
+		kfree_bulk(bnode->nr_records, bnode->records);
+	} else { // vmalloc() / vfree().
+		for (i = 0; i < bnode->nr_records; i++) {
+			trace_rcu_invoke_kvfree_callback(
+				rcu_state.name, bnode->records[i], 0);
+
+			vfree(bnode->records[i]);
+		}
+	}
+	rcu_lock_release(&rcu_callback_map);
+
+	raw_spin_lock_irqsave(&krcp->lock, flags);
+	if (put_cached_bnode(krcp, bnode))
+		bnode = NULL;
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+	if (bnode)
+		free_page((unsigned long) bnode);
+
+	cond_resched_tasks_rcu_qs();
+}
+
+static void
+kvfree_rcu_list(struct rcu_head *head)
+{
+	struct rcu_head *next;
+
+	for (; head; head = next) {
+		void *ptr = (void *) head->func;
+		unsigned long offset = (void *) head - ptr;
+
+		next = head->next;
+		debug_rcu_head_unqueue((struct rcu_head *)ptr);
+		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
+
+		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
+			kvfree(ptr);
+
+		rcu_lock_release(&rcu_callback_map);
+		cond_resched_tasks_rcu_qs();
+	}
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bulk_head_free or ->head_free.
@@ -2902,10 +2961,10 @@ static void kfree_rcu_work(struct work_struct *work)
 	unsigned long flags;
 	struct kvfree_rcu_bulk_data *bnode, *n;
 	struct list_head bulk_head[FREE_N_CHANNELS];
-	struct rcu_head *head, *next;
+	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
-	int i, j;
+	int i;
 
 	krwp = container_of(to_rcu_work(work),
 			    struct kfree_rcu_cpu_work, rcu_work);
@@ -2922,38 +2981,9 @@ static void kfree_rcu_work(struct work_struct *work)
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
-	for (i = 0; i < FREE_N_CHANNELS; i++) {
-		list_for_each_entry_safe(bnode, n, &bulk_head[i], list) {
-			debug_rcu_bhead_unqueue(bnode);
-
-			rcu_lock_acquire(&rcu_callback_map);
-			if (i == 0) { // kmalloc() / kfree().
-				trace_rcu_invoke_kfree_bulk_callback(
-					rcu_state.name, bnode->nr_records,
-					bnode->records);
-
-				kfree_bulk(bnode->nr_records, bnode->records);
-			} else { // vmalloc() / vfree().
-				for (j = 0; j < bnode->nr_records; j++) {
-					trace_rcu_invoke_kvfree_callback(
-						rcu_state.name, bnode->records[j], 0);
-
-					vfree(bnode->records[j]);
-				}
-			}
-			rcu_lock_release(&rcu_callback_map);
-
-			raw_spin_lock_irqsave(&krcp->lock, flags);
-			if (put_cached_bnode(krcp, bnode))
-				bnode = NULL;
-			raw_spin_unlock_irqrestore(&krcp->lock, flags);
-
-			if (bnode)
-				free_page((unsigned long) bnode);
-
-			cond_resched_tasks_rcu_qs();
-		}
-	}
+	for (i = 0; i < FREE_N_CHANNELS; i++)
+		list_for_each_entry_safe(bnode, n, &bulk_head[i], list)
+			kvfree_rcu_bulk(krcp, bnode, i);
 
 	/*
 	 * This is used when the "bulk" path can not be used for the
@@ -2962,21 +2992,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	for (; head; head = next) {
-		void *ptr = (void *) head->func;
-		unsigned long offset = (void *) head - ptr;
-
-		next = head->next;
-		debug_rcu_head_unqueue((struct rcu_head *)ptr);
-		rcu_lock_acquire(&rcu_callback_map);
-		trace_rcu_invoke_kvfree_callback(rcu_state.name, head, offset);
-
-		if (!WARN_ON_ONCE(!__is_kvfree_rcu_offset(offset)))
-			kvfree(ptr);
-
-		rcu_lock_release(&rcu_callback_map);
-		cond_resched_tasks_rcu_qs();
-	}
+	kvfree_rcu_list(head);
 }
 
 static bool
-- 
2.30.2

