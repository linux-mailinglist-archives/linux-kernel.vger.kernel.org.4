Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4F605394
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJSXAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiJSXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:00:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EDB15B13B;
        Wed, 19 Oct 2022 16:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 622B0B8261C;
        Wed, 19 Oct 2022 22:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17778C433B5;
        Wed, 19 Oct 2022 22:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220394;
        bh=heTCFvJswDxBI5C8hvwOT7FdiUNoVomfpcqIASj0cow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z1E62sMfLfhnh58D1mkPx6OYantfcmfSqflPqrbJ2+y6FpxT4KGkmRvO9732MdKBO
         u7+OM/6Ck0cM4LYJ9L/gAJ0GAdvuZ5POZcM2Dpp8t4IsindxUXPh8aextHmyRRSObO
         h0uxRRlzXW8kEanYVFgkM/gamkkKSATIPW3o1PN139xkPzzWnM+T40XCx3goTIEnBX
         GA7RN7OcpUM+wsvNlwt+Hnd11+GXPmV5KadMRApMwd7ROdcwzlGgY6s6tF3Djc+KN4
         C3kbRO+DzhuOIUKzeHqLftOrHbbnAQxyY3WOmoy/pm06jaip4/jgMmQBj/wNhJHX3Z
         CiJKi29c0DGzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C7BEC5C06B4; Wed, 19 Oct 2022 15:59:53 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 1/2] rcutorture: Verify NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE
Date:   Wed, 19 Oct 2022 15:59:51 -0700
Message-Id: <20221019225952.2501399-1-paulmck@kernel.org>
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

This commit adds code to the RTWS_POLL_GET_FULL case
of rcu_torture_writer() to verify that the value of
NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE is sufficiently large.

[ paulmck: Fix whitespace issue located by checkpatch.pl. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 503c2aa845a4a..b6885767ce46e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -357,6 +357,8 @@ struct rcu_torture_ops {
 	bool (*poll_gp_state_exp)(unsigned long oldstate);
 	void (*cond_sync_exp)(unsigned long oldstate);
 	void (*cond_sync_exp_full)(struct rcu_gp_oldstate *rgosp);
+	void (*get_comp_state_full)(struct rcu_gp_oldstate *rgosp);
+	bool (*same_gp_state_full)(struct rcu_gp_oldstate *rgosp1, struct rcu_gp_oldstate *rgosp2);
 	unsigned long (*get_gp_state)(void);
 	void (*get_gp_state_full)(struct rcu_gp_oldstate *rgosp);
 	unsigned long (*get_gp_completed)(void);
@@ -535,6 +537,8 @@ static struct rcu_torture_ops rcu_ops = {
 	.deferred_free		= rcu_torture_deferred_free,
 	.sync			= synchronize_rcu,
 	.exp_sync		= synchronize_rcu_expedited,
+	.same_gp_state_full	= same_state_synchronize_rcu_full,
+	.get_comp_state_full	= get_completed_synchronize_rcu_full,
 	.get_gp_state		= get_state_synchronize_rcu,
 	.get_gp_state_full	= get_state_synchronize_rcu_full,
 	.get_gp_completed	= get_completed_synchronize_rcu,
@@ -1264,7 +1268,8 @@ static void rcu_torture_write_types(void)
 	} else if (gp_poll && (!cur_ops->start_gp_poll || !cur_ops->poll_gp_state)) {
 		pr_alert("%s: gp_poll without primitives.\n", __func__);
 	}
-	if (gp_poll_full1 && cur_ops->start_gp_poll_full && cur_ops->poll_gp_state_full) {
+	if (gp_poll_full1 && cur_ops->get_comp_state_full && cur_ops->same_gp_state_full
+	    && cur_ops->start_gp_poll_full && cur_ops->poll_gp_state_full) {
 		synctype[nsynctypes++] = RTWS_POLL_GET_FULL;
 		pr_info("%s: Testing polling full-state GPs.\n", __func__);
 	} else if (gp_poll_full && (!cur_ops->start_gp_poll_full || !cur_ops->poll_gp_state_full)) {
@@ -1340,9 +1345,11 @@ rcu_torture_writer(void *arg)
 	int expediting = 0;
 	unsigned long gp_snap;
 	struct rcu_gp_oldstate gp_snap_full;
+	struct rcu_gp_oldstate gp_snap1_full;
 	int i;
 	int idx;
 	int oldnice = task_nice(current);
+	struct rcu_gp_oldstate rgo[NUM_ACTIVE_RCU_POLL_FULL_OLDSTATE];
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
@@ -1472,11 +1479,23 @@ rcu_torture_writer(void *arg)
 				break;
 			case RTWS_POLL_GET_FULL:
 				rcu_torture_writer_state = RTWS_POLL_GET_FULL;
+				for (i = 0; i < ARRAY_SIZE(rgo); i++)
+					cur_ops->get_comp_state_full(&rgo[i]);
 				cur_ops->start_gp_poll_full(&gp_snap_full);
 				rcu_torture_writer_state = RTWS_POLL_WAIT_FULL;
-				while (!cur_ops->poll_gp_state_full(&gp_snap_full))
+				while (!cur_ops->poll_gp_state_full(&gp_snap_full)) {
+					cur_ops->get_gp_state_full(&gp_snap1_full);
+					for (i = 0; i < ARRAY_SIZE(rgo); i++)
+						if (cur_ops->poll_gp_state_full(&rgo[i]) ||
+						    cur_ops->same_gp_state_full(&rgo[i],
+										&gp_snap1_full)) {
+							rgo[i] = gp_snap1_full;
+							break;
+						}
+					WARN_ON_ONCE(i >= ARRAY_SIZE(rgo));
 					torture_hrtimeout_jiffies(torture_random(&rand) % 16,
 								  &rand);
+				}
 				rcu_torture_pipe_update(old_rp);
 				break;
 			case RTWS_POLL_GET_EXP:
-- 
2.31.1.189.g2e36527f23

