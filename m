Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E6A6FE2F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236273AbjEJRDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbjEJRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8177423F;
        Wed, 10 May 2023 10:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4438464A1A;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34D7C433D2;
        Wed, 10 May 2023 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738163;
        bh=Q3rFOVXyjmWxSBKHzG6f0W6zOzsmEdlFl8cDsocGYto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Otb3WAq01eE3XPJpstZX+UNmbUyTaUU7GdBn5geALYF75KMTiGTHU3d1JqxwjATut
         X9975dywU8fXmcRlzrb49Zqp0pt8Oc8Vq1OnDRWgR+ZZdnqa1KT3MEzh+/zLOWuy0r
         wcQGV0wyeGkYCxOaOXlVlq+Odw5tHMIPpScT0sCC/jn5TadMW8q4c3E+plXg+SwhcK
         Mk0ts5mNWTr8/GTrKEkToIlm2a8g7ago/6jAjRSvLusFwZ4W5jRu+64KkwUTQ7/37J
         sjZmyw7Kck/H+dKxB9lZnbL2y6eKXUf/MaDPv8DaWFcEFxQeHXl+hggMIivcwH4bHG
         vTGUb0wXYwlNw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4EDBECE120B; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Ziwei Dai <ziwei.dai@unisoc.com>
Subject: [PATCH rcu 2/8] rcu/kvfree: Add debug to check grace periods
Date:   Wed, 10 May 2023 10:02:36 -0700
Message-Id: <20230510170242.2187714-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds debugging checks to verify that the required RCU
grace period has elapsed for each kvfree_rcu_bulk_data structure that
arrives at the kvfree_rcu_bulk() function.  These checks make use
of that structure's ->gp_snap field, which has been upgraded from an
unsigned long to an rcu_gp_oldstate structure.  This upgrade reduces
the chances of false positives to nearly zero, even on 32-bit systems,
for which this structure carries 64 bits of state.

Cc: Ziwei Dai <ziwei.dai@unisoc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f52ff7241041..91d75fd6c579 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2756,7 +2756,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
  */
 struct kvfree_rcu_bulk_data {
 	struct list_head list;
-	unsigned long gp_snap;
+	struct rcu_gp_oldstate gp_snap;
 	unsigned long nr_records;
 	void *records[];
 };
@@ -2921,23 +2921,24 @@ kvfree_rcu_bulk(struct kfree_rcu_cpu *krcp,
 	int i;
 
 	debug_rcu_bhead_unqueue(bnode);
-
-	rcu_lock_acquire(&rcu_callback_map);
-	if (idx == 0) { // kmalloc() / kfree().
-		trace_rcu_invoke_kfree_bulk_callback(
-			rcu_state.name, bnode->nr_records,
-			bnode->records);
-
-		kfree_bulk(bnode->nr_records, bnode->records);
-	} else { // vmalloc() / vfree().
-		for (i = 0; i < bnode->nr_records; i++) {
-			trace_rcu_invoke_kvfree_callback(
-				rcu_state.name, bnode->records[i], 0);
-
-			vfree(bnode->records[i]);
+	if (!WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&bnode->gp_snap))) {
+		rcu_lock_acquire(&rcu_callback_map);
+		if (idx == 0) { // kmalloc() / kfree().
+			trace_rcu_invoke_kfree_bulk_callback(
+				rcu_state.name, bnode->nr_records,
+				bnode->records);
+
+			kfree_bulk(bnode->nr_records, bnode->records);
+		} else { // vmalloc() / vfree().
+			for (i = 0; i < bnode->nr_records; i++) {
+				trace_rcu_invoke_kvfree_callback(
+					rcu_state.name, bnode->records[i], 0);
+
+				vfree(bnode->records[i]);
+			}
 		}
+		rcu_lock_release(&rcu_callback_map);
 	}
-	rcu_lock_release(&rcu_callback_map);
 
 	raw_spin_lock_irqsave(&krcp->lock, flags);
 	if (put_cached_bnode(krcp, bnode))
@@ -3081,7 +3082,7 @@ kvfree_rcu_drain_ready(struct kfree_rcu_cpu *krcp)
 		INIT_LIST_HEAD(&bulk_ready[i]);
 
 		list_for_each_entry_safe_reverse(bnode, n, &krcp->bulk_head[i], list) {
-			if (!poll_state_synchronize_rcu(bnode->gp_snap))
+			if (!poll_state_synchronize_rcu_full(&bnode->gp_snap))
 				break;
 
 			atomic_sub(bnode->nr_records, &krcp->bulk_count[i]);
@@ -3285,7 +3286,7 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 
 	// Finally insert and update the GP for this page.
 	bnode->records[bnode->nr_records++] = ptr;
-	bnode->gp_snap = get_state_synchronize_rcu();
+	get_state_synchronize_rcu_full(&bnode->gp_snap);
 	atomic_inc(&(*krcp)->bulk_count[idx]);
 
 	return true;
-- 
2.40.1

