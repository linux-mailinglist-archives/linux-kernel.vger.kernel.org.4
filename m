Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD9E7451FD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGBUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjGBUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 16:01:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA79959F1;
        Sun,  2 Jul 2023 12:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2E7660C8C;
        Sun,  2 Jul 2023 19:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70444C433CA;
        Sun,  2 Jul 2023 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688327867;
        bh=MlyiBlIvrWR+FMvlZMKgxNC3A519/M8R+ToVXS7wk+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOJRdhsXGuHtJf98gJVMRi15sBVtpcZnDHNwQhiNiacJ5PWbqLB58wd/7rlfHbZ4A
         elLCdKdz9IKporgkKY2lkwpRSjZjXUYhBBV3tYQkfAYY1ES0yVAdcotyG2Z8GATZkd
         6L9fQcYb/XqZ6AZAgKpICFXWxuUBlsckpMh0Koqci8AQKn50PP/YSvFsO2YNwBFN10
         XQfP9PYZT+i6gkAmvUF4v7X3s3k0Es9SPC1JeW7aNE72+dHEo2TQ6DCFdlx2SgWY8t
         c6SH+0Tuc4goxJ2Ked5CJ9SknTXBEBzNUnYYZ5kP9HsTDeA5/ghPnRlnbI3iREvyex
         PANlccIZRIWTQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sasha Levin <sashal@kernel.org>, frederic@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com, rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 2/4] rcu: Mark additional concurrent load from ->cpu_no_qs.b.exp
Date:   Sun,  2 Jul 2023 15:57:40 -0400
Message-Id: <20230702195743.1793074-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702195743.1793074-1-sashal@kernel.org>
References: <20230702195743.1793074-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
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

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 9146eb25495ea8bfb5010192e61e3ed5805ce9ef ]

The per-CPU rcu_data structure's ->cpu_no_qs.b.exp field is updated
only on the instance corresponding to the current CPU, but can be read
more widely.  Unmarked accesses are OK from the corresponding CPU, but
only if interrupts are disabled, given that interrupt handlers can and
do modify this field.

Unfortunately, although the load from rcu_preempt_deferred_qs() is always
carried out from the corresponding CPU, interrupts are not necessarily
disabled.  This commit therefore upgrades this load to READ_ONCE.

Similarly, the diagnostic access from synchronize_rcu_expedited_wait()
might run with interrupts disabled and from some other CPU.  This commit
therefore marks this load with data_race().

Finally, the C-language access in rcu_preempt_ctxt_queue() is OK as
is because interrupts are disabled and this load is always from the
corresponding CPU.  This commit adds a comment giving the rationale for
this access being safe.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_exp.h    | 2 +-
 kernel/rcu/tree_plugin.h | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 3b7abb58157df..8239b39d945bd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -643,7 +643,7 @@ static void synchronize_rcu_expedited_wait(void)
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
 					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)],
-					"D."[!!(rdp->cpu_no_qs.b.exp)]);
+					"D."[!!data_race(rdp->cpu_no_qs.b.exp)]);
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7b0fe741a0886..41021080ad258 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -257,6 +257,8 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * GP should not be able to end until we report, so there should be
 	 * no need to check for a subsequent expedited GP.  (Though we are
 	 * still in a quiescent state in any case.)
+	 *
+	 * Interrupts are disabled, so ->cpu_no_qs.b.exp cannot change.
 	 */
 	if (blkd_state & RCU_EXP_BLKD && rdp->cpu_no_qs.b.exp)
 		rcu_report_exp_rdp(rdp);
@@ -941,7 +943,7 @@ notrace void rcu_preempt_deferred_qs(struct task_struct *t)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	if (rdp->cpu_no_qs.b.exp)
+	if (READ_ONCE(rdp->cpu_no_qs.b.exp))
 		rcu_report_exp_rdp(rdp);
 }
 
-- 
2.39.2

