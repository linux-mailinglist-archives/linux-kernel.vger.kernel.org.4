Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0465E18A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbjAEA0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjAEA0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:26:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48934FD61;
        Wed,  4 Jan 2023 16:24:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4786B8167B;
        Thu,  5 Jan 2023 00:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40566C43392;
        Thu,  5 Jan 2023 00:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878290;
        bh=f7VPeHyZLzEgBCJrtOOLYruhtWg4ipMr6+XcpqWU8pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S0UK3HPKJw+YCNaT91b6RahkwPZdBiq81FkIwsG9KBREFG09g2/nmVPLGuRh9Slsy
         P+4TZMVDBBg/vGftfxnLkORAChuSVkc5ICBoEKxZrGgAQVIyHYP5LvO8brggTJuZCJ
         ktTBwbLdLudB0OkMS8YjPWg/R1L39dxxRVPC9Aa9GRSr6i2iOqnHDu/hhRrrY00qCP
         F9P96p8iaAWPrftcUINLWz1GevjGXlNDd7pRqQuB2mOtbmxH7YE37QtMsKkarxNaxL
         LeEi54QJk+Yd+5pStjMBYv7ODBiqtkfZuUYssslpRcmsuf/FJ2a3Rw1CUpSqoL42Nk
         eI+xcDj0wTyrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E79AC5C1456; Wed,  4 Jan 2023 16:24:49 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 4/8] rcu/kvfree: Move need_offload_krc() out of krcp->lock
Date:   Wed,  4 Jan 2023 16:24:44 -0800
Message-Id: <20230105002448.1768892-4-paulmck@kernel.org>
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

The need_offload_krc() function currently holds the krcp->lock in order
to safely check krcp->head.  This commit removes the need for this lock
in that function by updating the krcp->head pointer using WRITE_ONCE()
macro so that readers can carry out lockless loads of that pointer.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 839e617f6c370..0c42fce4efe32 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3194,7 +3194,7 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// objects queued on the linked list.
 			if (!krwp->head_free) {
 				krwp->head_free = krcp->head;
-				krcp->head = NULL;
+				WRITE_ONCE(krcp->head, NULL);
 			}
 
 			WRITE_ONCE(krcp->count, 0);
@@ -3208,6 +3208,8 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		}
 	}
 
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
 	// If there is nothing to detach, it means that our job is
 	// successfully done here. In case of having at least one
 	// of the channels that is still busy we should rearm the
@@ -3215,8 +3217,6 @@ static void kfree_rcu_monitor(struct work_struct *work)
 	// still in progress.
 	if (need_offload_krc(krcp))
 		schedule_delayed_monitor_work(krcp);
-
-	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static enum hrtimer_restart
@@ -3386,7 +3386,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 
 		head->func = ptr;
 		head->next = krcp->head;
-		krcp->head = head;
+		WRITE_ONCE(krcp->head, head);
 		success = true;
 	}
 
@@ -3463,15 +3463,12 @@ static struct shrinker kfree_rcu_shrinker = {
 void __init kfree_rcu_scheduler_running(void)
 {
 	int cpu;
-	unsigned long flags;
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
-		raw_spin_lock_irqsave(&krcp->lock, flags);
 		if (need_offload_krc(krcp))
 			schedule_delayed_monitor_work(krcp);
-		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 	}
 }
 
-- 
2.31.1.189.g2e36527f23

