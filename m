Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83794605393
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbiJSXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiJSXAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22E915A311;
        Wed, 19 Oct 2022 16:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9C6F61920;
        Wed, 19 Oct 2022 22:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1774CC433D7;
        Wed, 19 Oct 2022 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220394;
        bh=QzU3fJG5bwIRq0jbB5e2N1//MT/bQTExGwvu9xmK1LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l1rXsntSqQC1kHiKsYnzDLEzvMLPIu1rAdgm7CAgtAoF5Z28dQmhAvgP7ToSjekT9
         52bZFE1SCZKPeRDbTMF7LSCE4VO49pz2Slc850Unli9Ji2MPsYGIYFGFnvcYVwxvxA
         uqFey9OvSREANO17IuSKsH6UwbiMa+9Rh36s9y9l1NJkVklZFATgayD6M4Tkn0L0nq
         7wYB0ukQZHNh1iGQQyG4Ckk12gis6nC52BU5oq2EBpMTrQXOydiovz23C9dzq2R2nk
         KKKQxJqbO3ATU0pA4yCh3ECqUuswUy5quX+VjllKJT2zZCYg2oxBvGlcYCRACsJKFP
         ud8YDdhCVxXUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CB06A5C0879; Wed, 19 Oct 2022 15:59:53 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 2/2] rcutorture: Verify NUM_ACTIVE_RCU_POLL_OLDSTATE
Date:   Wed, 19 Oct 2022 15:59:52 -0700
Message-Id: <20221019225952.2501399-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225946.GA2501259@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225946.GA2501259@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds code to the RTWS_POLL_GET case of rcu_torture_writer()
to verify that the value of NUM_ACTIVE_RCU_POLL_OLDSTATE is sufficiently
large

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b6885767ce46e..9ad5301385a41 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -357,7 +357,9 @@ struct rcu_torture_ops {
 	bool (*poll_gp_state_exp)(unsigned long oldstate);
 	void (*cond_sync_exp)(unsigned long oldstate);
 	void (*cond_sync_exp_full)(struct rcu_gp_oldstate *rgosp);
+	unsigned long (*get_comp_state)(void);
 	void (*get_comp_state_full)(struct rcu_gp_oldstate *rgosp);
+	bool (*same_gp_state)(unsigned long oldstate1, unsigned long oldstate2);
 	bool (*same_gp_state_full)(struct rcu_gp_oldstate *rgosp1, struct rcu_gp_oldstate *rgosp2);
 	unsigned long (*get_gp_state)(void);
 	void (*get_gp_state_full)(struct rcu_gp_oldstate *rgosp);
@@ -537,7 +539,9 @@ static struct rcu_torture_ops rcu_ops = {
 	.deferred_free		= rcu_torture_deferred_free,
 	.sync			= synchronize_rcu,
 	.exp_sync		= synchronize_rcu_expedited,
+	.same_gp_state		= same_state_synchronize_rcu,
 	.same_gp_state_full	= same_state_synchronize_rcu_full,
+	.get_comp_state		= get_completed_synchronize_rcu,
 	.get_comp_state_full	= get_completed_synchronize_rcu_full,
 	.get_gp_state		= get_state_synchronize_rcu,
 	.get_gp_state_full	= get_state_synchronize_rcu_full,
@@ -1262,7 +1266,8 @@ static void rcu_torture_write_types(void)
 	} else if (gp_normal && !cur_ops->deferred_free) {
 		pr_alert("%s: gp_normal without primitives.\n", __func__);
 	}
-	if (gp_poll1 && cur_ops->start_gp_poll && cur_ops->poll_gp_state) {
+	if (gp_poll1 && cur_ops->get_comp_state && cur_ops->same_gp_state &&
+	    cur_ops->start_gp_poll && cur_ops->poll_gp_state) {
 		synctype[nsynctypes++] = RTWS_POLL_GET;
 		pr_info("%s: Testing polling GPs.\n", __func__);
 	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
@@ -1344,6 +1349,7 @@ rcu_torture_writer(void *arg)
 	struct rcu_gp_oldstate cookie_full;
 	int expediting = 0;
 	unsigned long gp_snap;
+	unsigned long gp_snap1;
 	struct rcu_gp_oldstate gp_snap_full;
 	struct rcu_gp_oldstate gp_snap1_full;
 	int i;
@@ -1354,6 +1360,7 @@ rcu_torture_writer(void *arg)
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
 	bool stutter_waited;
+	unsigned long ulo[NUM_ACTIVE_RCU_POLL_OLDSTATE];
 
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
@@ -1470,11 +1477,22 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_POLL_GET:
 				rcu_torture_writer_state = RTWS_POLL_GET;
+				for (i = 0; i < ARRAY_SIZE(ulo); i++)
+					ulo[i] = cur_ops->get_comp_state();
 				gp_snap = cur_ops->start_gp_poll();
 				rcu_torture_writer_state = RTWS_POLL_WAIT;
-				while (!cur_ops->poll_gp_state(gp_snap))
+				while (!cur_ops->poll_gp_state(gp_snap)) {
+					gp_snap1 = cur_ops->get_gp_state();
+					for (i = 0; i < ARRAY_SIZE(ulo); i++)
+						if (cur_ops->poll_gp_state(ulo[i]) ||
+						    cur_ops->same_gp_state(ulo[i], gp_snap1)) {
+							ulo[i] = gp_snap1;
+							break;
+						}
+					WARN_ON_ONCE(i >= ARRAY_SIZE(ulo));
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
+				}
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_POLL_GET_FULL:
-- 
2.31.1.189.g2e36527f23

