Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F282063DCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiK3SOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiK3SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6763862DA;
        Wed, 30 Nov 2022 10:13:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6195CB81C9C;
        Wed, 30 Nov 2022 18:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CB6C43154;
        Wed, 30 Nov 2022 18:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669832008;
        bh=bN1R1Byx9JRzp9KLFli6bl4Fbxjs+KDfwn4AF0kT8Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujwYutX6/+BLv6Om3JgkjH/l6Pfi1kGfAwpi0Jrm78iqr1Ko5dBems6PV/sGMeL20
         OWevhyCULn9ND6xnLOZim1GIbUQ35Col1jDlXkYyDtD42jK/dmDwznsmBIQcB4ZwJG
         TpVJsiu7Xsl7qArx58yTBUKcIiM9XNkGwT+9xcJA8SwZR6isg028Vimh8eFj0HhQzL
         ow4K4Co1ewczqUMXI2j4Gcwwz8cIHZ6XirPSChEct56uEJCyYzCsQ7kU5p4jec7NIq
         jvMm41apnBYIylB1VNTrBS0APxfrOhCccrIiAE36kBJIvgjnIHSqtz6VXzSXDWJVa7
         TJMMFS4y19Scg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67C6E5C16C5; Wed, 30 Nov 2022 10:13:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/16] rcu/rcutorture: Use call_rcu_hurry() where needed
Date:   Wed, 30 Nov 2022 10:13:19 -0800
Message-Id: <20221130181325.1012760-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
References: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

call_rcu() changes to save power will change the behavior of rcutorture
tests. Use the call_rcu_hurry() API instead which reverts to the old
behavior.

[ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 503c2aa845a4a..2226f86f54f78 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -510,7 +510,7 @@ static unsigned long rcu_no_completed(void)
 
 static void rcu_torture_deferred_free(struct rcu_torture *p)
 {
-	call_rcu(&p->rtort_rcu, rcu_torture_cb);
+	call_rcu_hurry(&p->rtort_rcu, rcu_torture_cb);
 }
 
 static void rcu_sync_torture_init(void)
@@ -551,7 +551,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.start_gp_poll_exp_full	= start_poll_synchronize_rcu_expedited_full,
 	.poll_gp_state_exp	= poll_state_synchronize_rcu,
 	.cond_sync_exp		= cond_synchronize_rcu_expedited,
-	.call			= call_rcu,
+	.call			= call_rcu_hurry,
 	.cb_barrier		= rcu_barrier,
 	.fqs			= rcu_force_quiescent_state,
 	.stats			= NULL,
@@ -848,7 +848,7 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 
 static void synchronize_rcu_mult_test(void)
 {
-	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu_hurry);
 }
 
 static struct rcu_torture_ops tasks_ops = {
@@ -3388,13 +3388,13 @@ static void rcu_test_debug_objects(void)
 	/* Try to queue the rh2 pair of callbacks for the same grace period. */
 	preempt_disable(); /* Prevent preemption from interrupting test. */
 	rcu_read_lock(); /* Make it impossible to finish a grace period. */
-	call_rcu(&rh1, rcu_torture_leak_cb); /* Start grace period. */
+	call_rcu_hurry(&rh1, rcu_torture_leak_cb); /* Start grace period. */
 	local_irq_disable(); /* Make it harder to start a new grace period. */
-	call_rcu(&rh2, rcu_torture_leak_cb);
-	call_rcu(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
+	call_rcu_hurry(&rh2, rcu_torture_leak_cb);
+	call_rcu_hurry(&rh2, rcu_torture_err_cb); /* Duplicate callback. */
 	if (rhp) {
-		call_rcu(rhp, rcu_torture_leak_cb);
-		call_rcu(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
+		call_rcu_hurry(rhp, rcu_torture_leak_cb);
+		call_rcu_hurry(rhp, rcu_torture_err_cb); /* Another duplicate callback. */
 	}
 	local_irq_enable();
 	rcu_read_unlock();
-- 
2.31.1.189.g2e36527f23

