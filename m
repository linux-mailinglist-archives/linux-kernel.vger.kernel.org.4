Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C77450A4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjGBTkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjGBTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8498D10C6;
        Sun,  2 Jul 2023 12:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A1260C8C;
        Sun,  2 Jul 2023 19:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CF7C433C7;
        Sun,  2 Jul 2023 19:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326761;
        bh=Ae48q991+6sN+WpLvwffuwzxp3CKf3ahp86kBK08iQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkB4pelXrGACDlaB+jAINLTZhGIJsR8e19QXwqyRqFfYH5QRknwTpQNzRBNJiz3j8
         2waGVD8o/h6aEUoCDy1oS3QHoSPW56c7xa41HLahPmZSvolTnI9la9GUe7Tjayw/Hi
         MbsKa//S/D06t46+goVKzNq13RkoPYa/9Dvds2AKa3uxQUIv4/TuIUcFWNQ+5xHDRI
         UZg9T/NxfY8aLb64BUV8pS/dnzBamvtCb7CMc1FG8LB6zHjvtjvTXwmyxBYqfkBE9s
         UrQtc+CwKqB3mY73g6LYOE/1NHaAxCQsUY3QENQ8T4HfPUHZfYMCSmATcaS9GFVdi/
         CdT3bJpdZ2KdQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zqiang <qiang1.zhang@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/2] rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
Date:   Sun,  2 Jul 2023 15:39:16 -0400
Message-Id: <20230702193916.1776226-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193916.1776226-1-sashal@kernel.org>
References: <20230702193916.1776226-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
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

From: Zqiang <qiang1.zhang@intel.com>

[ Upstream commit 3c1566bca3f8349f12b75d0a2d5e4a20ad6262ec ]

For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario can
result in a NULL-pointer dereference:

           CPU1                                           CPU2
rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
  if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
    raw_spin_lock_rcu_node
    np = rcu_next_node_entry(t, rnp)
    if (&t->rcu_node_entry == rnp->exp_tasks)
      WRITE_ONCE(rnp->exp_tasks, np)
      ....
      raw_spin_unlock_irqrestore_rcu_node
                                                    raw_spin_lock_irqsave_rcu_node
                                                    t = list_entry(rnp->exp_tasks->prev,
                                                        struct task_struct, rcu_node_entry)
                                                    (if rnp->exp_tasks is NULL, this
                                                       will dereference a NULL pointer)

The problem is that CPU2 accesses the rcu_node structure's->exp_tasks
field without holding the rcu_node structure's ->lock and CPU2 did
not observe CPU1's change to rcu_node structure's ->exp_tasks in time.
Therefore, if CPU1 sets rcu_node structure's->exp_tasks pointer to NULL,
then CPU2 might dereference that NULL pointer.

This commit therefore holds the rcu_node structure's ->lock while
accessing that structure's->exp_tasks field.

[ paulmck: Apply Frederic Weisbecker feedback. ]

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index ef6570137dcd5..401c1f331cafa 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -707,9 +707,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	int ndetected = 0;
 	struct task_struct *t;
 
-	if (!READ_ONCE(rnp->exp_tasks))
-		return 0;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!rnp->exp_tasks) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return 0;
+	}
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-- 
2.39.2

