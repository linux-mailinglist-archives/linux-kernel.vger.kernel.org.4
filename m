Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078646FE2F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjEJRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbjEJRDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4786F1BCF;
        Wed, 10 May 2023 10:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD6664A21;
        Wed, 10 May 2023 17:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9708C4339B;
        Wed, 10 May 2023 17:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683738163;
        bh=GUdtbnxrMYKHSRw0zedHwvfAbvZ5RfDc9Uh+UMVsuF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV7lPW9STo0XsQIh0/hNxKrBRQS4wndoPPoVFC8NGisk0B37o0XnAjykCcf/9aRT0
         9svfmNbCmWkW9uDWraFp2QaZ/YyCLu3K1atSLIFI+a+w3QS9LL+ahVcDrr6RpLF6Cs
         lQVswOpzk9rdUesfWxWIrjPEcn2V2bwAZW9K8E1qTJ7jwxZwuaZuwhLi65aqKwPhya
         zGhRsxLHy0LfooHSY5LDYlJ0abX8htv3W7Y7sV6F9skS+ZZQ0HwLLat0DCLAiB2wzy
         cnmdpX8aDhhqhYSMV+k2WU5EHJOrJjByGNJtbtlrMCrbv6bVNqBzGV3DoVjqRzN3Yn
         QlE01/WKBuD6g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5136DCE127A; Wed, 10 May 2023 10:02:43 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/8] rcu/kvfree: Add debug check for GP complete for kfree_rcu_cpu list
Date:   Wed, 10 May 2023 10:02:37 -0700
Message-Id: <20230510170242.2187714-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
References: <1c01c38f-3783-44d7-8c11-7416cd5b849c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Under low-memory conditions, kvfree_rcu() will use each object's
rcu_head structure to queue objects in a singly linked list headed by
the kfree_rcu_cpu structure's ->head field.  This list is passed to
call_rcu() as a unit, but there is no indication of which grace period
this list needs to wait for.  This in turn prevents adding debug checks
in the kfree_rcu_work() as was done for the two page-of-pointers channels
in the kfree_rcu_cpu structure.

This commit therefore adds a ->head_free_gp_snap field to the
kfree_rcu_cpu_work structure to record this grace-period number.  It also
adds a WARN_ON_ONCE() to kfree_rcu_monitor() that checks to make sure
that the required grace period has in fact elapsed.

[ paulmck: Fix kerneldoc issue raised by Stephen Rothwell. ]

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 91d75fd6c579..7452ba97ba34 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2773,6 +2773,7 @@ struct kvfree_rcu_bulk_data {
  * struct kfree_rcu_cpu_work - single batch of kfree_rcu() requests
  * @rcu_work: Let queue_rcu_work() invoke workqueue handler after grace period
  * @head_free: List of kfree_rcu() objects waiting for a grace period
+ * @head_free_gp_snap: Grace-period snapshot to check for attempted premature frees.
  * @bulk_head_free: Bulk-List of kvfree_rcu() objects waiting for a grace period
  * @krcp: Pointer to @kfree_rcu_cpu structure
  */
@@ -2780,6 +2781,7 @@ struct kvfree_rcu_bulk_data {
 struct kfree_rcu_cpu_work {
 	struct rcu_work rcu_work;
 	struct rcu_head *head_free;
+	struct rcu_gp_oldstate head_free_gp_snap;
 	struct list_head bulk_head_free[FREE_N_CHANNELS];
 	struct kfree_rcu_cpu *krcp;
 };
@@ -2985,6 +2987,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	struct rcu_head *head;
 	struct kfree_rcu_cpu *krcp;
 	struct kfree_rcu_cpu_work *krwp;
+	struct rcu_gp_oldstate head_gp_snap;
 	int i;
 
 	krwp = container_of(to_rcu_work(work),
@@ -2999,6 +3002,7 @@ static void kfree_rcu_work(struct work_struct *work)
 	// Channel 3.
 	head = krwp->head_free;
 	krwp->head_free = NULL;
+	head_gp_snap = krwp->head_free_gp_snap;
 	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 	// Handle the first two channels.
@@ -3015,7 +3019,8 @@ static void kfree_rcu_work(struct work_struct *work)
 	 * queued on a linked list through their rcu_head structures.
 	 * This list is named "Channel 3".
 	 */
-	kvfree_rcu_list(head);
+	if (head && !WARN_ON_ONCE(!poll_state_synchronize_rcu_full(&head_gp_snap)))
+		kvfree_rcu_list(head);
 }
 
 static bool
@@ -3147,6 +3152,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
+				get_state_synchronize_rcu_full(&krwp->head_free_gp_snap);
 				atomic_set(&krcp->head_count, 0);
 				WRITE_ONCE(krcp->head, NULL);
 			}
-- 
2.40.1

