Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7E63ACB8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiK1Pgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiK1Pgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:36:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AB212AAE;
        Mon, 28 Nov 2022 07:36:38 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id td2so12699407ejc.5;
        Mon, 28 Nov 2022 07:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsG879eIKhP8V3VjjSrfZO129/c6P3Y13iqVAmLZmiU=;
        b=D4zcCWdIo3sj9cIoqxj04QwiUHZUwS4WOHnrSLuPRtjQPNo0Ugg2jkQP10KAxRDSpT
         +6QmGMdlbaVy7GvRM8g3Cq/PKpwCsuyxUt1U4NW+In5TKsDJ7wx0Zr6ONc+sSqr2/WXj
         3pmuF+i47x3GoNfr/iIt2wkagNtETrIVCgwoQGRgHuD9VZZNFkD3eLzP7cviPbKjZhTL
         JKUIHqLWR+5dtW/kv1Heu/N1yS4vSl9d2uTH/A4Cj6YkRVNdutSoUisWetyv5gNoqPQc
         NFWgZBLWJFVGNjpvoTuH5jUewmmgQwDXo7sQePX/tNPciDebGCTEwn6vDtdY8stmjdm0
         tACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsG879eIKhP8V3VjjSrfZO129/c6P3Y13iqVAmLZmiU=;
        b=wf7XkCbtiERvEE5QU85c11VKeRlJb+KNFEVnx9YEVrbTUPfaLrZY0UQiILb38bPWPG
         wgFI5X8JmW0Sntd9liHcFCNsa2dx0PksSDzcg8h8kWrs3qKnlsBEcqHctIfv5BoAFwB8
         M+rW1YW4/5qj2LAQzfC7jY+mzvkBBkppMy1zB1IJrBKiYz7ISH6NOxrBiu2N9vxl80bq
         YhuZE7q6dw5KKeQk4smnWogyCiXmKOiIG4VoUmeNDuVdcxRoKUumCuVc5mNzNrE5JCcf
         +Sauvc9eUaUQqgyuKwO0wZtOpbEXd3a69Hb9N2fNxDu9VpGiSi6EMdUEtlAxgDyapqIn
         020Q==
X-Gm-Message-State: ANoB5plfcq26IauGJlxt9nkPZUzU6q+QBOdeC7kEZi//fARSE4YvGwid
        L28/spbBz7vw8hGQ6EPLoUQa6bKNeg4=
X-Google-Smtp-Source: AA0mqf4O8lDYZhUOT9y+b5zfESjQd+TBhELW8VQ7dm7EjIxA7si3FeKX8pnl8YbtVfUSKHzlkLj9GA==
X-Received: by 2002:a17:906:6dd5:b0:78d:a633:b55 with SMTP id j21-20020a1709066dd500b0078da6330b55mr45731910ejt.106.1669649796944;
        Mon, 28 Nov 2022 07:36:36 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7d347000000b00459ad800bbcsm5303306edr.33.2022.11.28.07.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 07:36:36 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 2/4] rcu/kvfree: Move bulk/list reclaim to separate functions
Date:   Mon, 28 Nov 2022 16:36:26 +0100
Message-Id: <20221128153628.541361-2-urezki@gmail.com>
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
index 74d6889dcc50..3b5f6036d884 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3053,6 +3053,65 @@ drain_page_cache(struct kfree_rcu_cpu *krcp)
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
+		unsigned long offset = (unsigned long)head->func;
+		void *ptr = (void *)head - offset;
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
@@ -3062,10 +3121,10 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3082,38 +3141,9 @@ static void kfree_rcu_work(struct work_struct *work)
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
@@ -3122,21 +3152,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	for (; head; head = next) {
-		unsigned long offset = (unsigned long)head->func;
-		void *ptr = (void *)head - offset;
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

