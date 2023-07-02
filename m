Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB6F7450A3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 21:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGBTkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGBTkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 15:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD1A10C1;
        Sun,  2 Jul 2023 12:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C549560CA3;
        Sun,  2 Jul 2023 19:39:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26427C433C7;
        Sun,  2 Jul 2023 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326751;
        bh=PNIokpclxdAzimCydZBKPG3yelQqnCeelkzUmquiXA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IU4u97OqOurwbuAqz0xVQhIKPNjmDjVFcLMhGU14FtPZGuO9J8HicasvJ0dC+fg3h
         b/tU+ElHHHHKGxAdA1OJJKalAvPXz7CimSnS2f8aiZS+sbPYef4EDuR2sMl4sOoe3H
         i36hZilWgb5/BGO2w5bHPVgIplx9hE2qZFnsoC0l122FXMayUfbM42ANR1L96az5nY
         UkMwvyrQokASo5XN9CwgBtZx3zfRR/tC9X/da7Ph4/VND91gGAJiSyG+B3HPedNrsu
         txC1UmUHr1IPdBCJN8o664T6Q1Rj+BIt0hcxbNfgPg86+lqp6dmhi1Tx6UOO4wrHYo
         INhjjV+2QAiKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zqiang <qiang1.zhang@intel.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/3] rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
Date:   Sun,  2 Jul 2023 15:39:04 -0400
Message-Id: <20230702193904.1775957-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702193904.1775957-1-sashal@kernel.org>
References: <20230702193904.1775957-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.37
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
index 60732264a7d0b..e25321dbb068e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -800,9 +800,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
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

