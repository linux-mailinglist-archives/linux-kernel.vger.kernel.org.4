Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A73365E1A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbjAEAeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbjAEAdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:33:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18A4FCEA;
        Wed,  4 Jan 2023 16:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7EF65B81988;
        Thu,  5 Jan 2023 00:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C5C433A7;
        Thu,  5 Jan 2023 00:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878534;
        bh=heNZkRhselcUeK4W6Q42S6IveI27Tt7taSP/M5NwFFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aba7WF8cgEF1Bwy6JU335bbMuWtqY3kl6l+V6sgmq18nrg5LiMEAGf0ytUrKsC80z
         BULDrr7tdKY/1k/j+HVxKUHqCLymrjgjj5z9IvzbdUbQHfV2oXBLg+EzbnFYS32ogr
         ME2+z1VycL+DkZgkkbhrIcr2AZGPf/ig49v7KBmGJMwbuvvO6QYNORK8jwQGcIGM47
         QctrgyXeUmXZ18/t3FiQLJHy6TU7NQ4crkv2Oc5IiEPGwpU7v7ib5e6pawql4+pbI0
         gDVP3m9ZUlaV0oMgrdqczD2nIJIrcD3OzekcHRrH6q/cwVvtcUuT8QV+azfyu/iauM
         UQL+hHLZLxfYQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 50C745C1AE0; Wed,  4 Jan 2023 16:28:54 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 7/9] srcu: Remove needless rcu_seq_done() check while holding read lock
Date:   Wed,  4 Jan 2023 16:28:51 -0800
Message-Id: <20230105002853.1769401-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002845.GA1769240@paulmck-ThinkPad-P17-Gen-1>
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

From: Pingfan Liu <kernelfans@gmail.com>

The srcu_gp_start_if_needed() function now read-holds the srcu_struct
whose grace period is being started, which means that the corresponding
SRCU grace period cannot end.  This in turn means that the SRCU
grace-period sequence number returned by rcu_seq_snap() cannot expire
during this time.  And that means that the calls to rcu_seq_done() in
srcu_funnel_exp_start() and srcu_funnel_gp_start() can never return true.

This commit therefore removes these rcu_seq_done() checks, but adds checks
in kernels built with CONFIG_PROVE_RCU=y that splats if rcu_seq_done()
does somehow return true.

[ paulmck: Rearrange checks to handle kernels built with lockdep. ]

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6af0312005801..68b8d8b150db1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -915,7 +915,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
 			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
+			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) ||
 			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
@@ -942,6 +942,9 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
  *
  * Note that this function also does the work of srcu_funnel_exp_start(),
  * in some cases by directly invoking it.
+ *
+ * The srcu read lock should be hold around this function. And s is a seq snap
+ * after holding that lock.
  */
 static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 				 unsigned long s, bool do_norm)
@@ -962,7 +965,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
+			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) && snp != snp_leaf)
 				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
@@ -999,8 +1002,8 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 
-	/* If grace period not already done and none in progress, start it. */
-	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
+	/* If grace period not already in progress, start it. */
+	if (!WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) &&
 	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
 		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
-- 
2.31.1.189.g2e36527f23

