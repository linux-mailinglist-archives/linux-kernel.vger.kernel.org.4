Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08226C7472
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXAUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjCXATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51992D174;
        Thu, 23 Mar 2023 17:19:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA0F62926;
        Fri, 24 Mar 2023 00:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78130C433AA;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=RoSQbzhbQELx/c2FQsLQzy2pL9pqIn71fkr9W5LQAqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yfz1FPE9CogRTIXNDhDP2T6oWMeLLachsiSzYRCLrvfpOqPNTnPhR7YttabfOXnO3
         mHUqTIdoQ7weGQPfq/NTya4OscFlzHiK7ylZ+y03g6lLtcephz2iLLyDwvmns50TmF
         dWJGe2q4RwWV8j69WtR+0h6/2V5f7ZiLlwftUNppfkz375nCs/r7Xbmd6Adfhpyti7
         0FAuLuXTuH5/SSYlh9nFWBguvxfANqQ11fm2axRd6V+6gBw6VXFKfqIgmgO6SAm+bR
         RT649DPgOLeDyJYSoySdklFcWAzHppWbq8n8svZkTtHcyasYJ4V/asyj+M9XE0LViF
         5JIoMYbAa5jtQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AF94B15403A4; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 11/19] srcu: Move heuristics fields from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:30 -0700
Message-Id: <20230324001938.3443499-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves the ->srcu_size_jiffies, ->srcu_n_lock_retries,
and ->srcu_n_exp_nodelay fields from the srcu_struct structure to the
srcu_usage structure to reduce the size of the former in order to improve
cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  6 +++---
 kernel/rcu/srcutree.c    | 18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 7458df6bbe00..82d07466da93 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -73,6 +73,9 @@ struct srcu_usage {
 	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
 	unsigned long srcu_gp_start;		/* Last GP start timestamp (jiffies) */
 	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
+	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
+	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
+	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 };
 
 /*
@@ -80,9 +83,6 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
-	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
-	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
-	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
 	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
 	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c1ac78b1cfc..3f389b3a25aa 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -348,11 +348,11 @@ static void spin_lock_irqsave_check_contention(struct srcu_struct *ssp)
 	if (!SRCU_SIZING_IS_CONTEND() || ssp->srcu_sup->srcu_size_state)
 		return;
 	j = jiffies;
-	if (ssp->srcu_size_jiffies != j) {
-		ssp->srcu_size_jiffies = j;
-		ssp->srcu_n_lock_retries = 0;
+	if (ssp->srcu_sup->srcu_size_jiffies != j) {
+		ssp->srcu_sup->srcu_size_jiffies = j;
+		ssp->srcu_sup->srcu_n_lock_retries = 0;
 	}
-	if (++ssp->srcu_n_lock_retries <= small_contention_lim)
+	if (++ssp->srcu_sup->srcu_n_lock_retries <= small_contention_lim)
 		return;
 	__srcu_transition_to_big(ssp);
 }
@@ -624,8 +624,8 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
-			WRITE_ONCE(ssp->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_n_exp_nodelay) + 1);
-			if (READ_ONCE(ssp->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
+			WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) + 1);
+			if (READ_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay) > srcu_max_nodelay_phase)
 				jbase = 1;
 		}
 	}
@@ -783,7 +783,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
 	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
-	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
+	WRITE_ONCE(ssp->srcu_sup->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
 	rcu_seq_start(&ssp->srcu_sup->srcu_gp_seq);
 	state = rcu_seq_state(ssp->srcu_sup->srcu_gp_seq);
@@ -1647,7 +1647,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		srcu_flip(ssp);
 		spin_lock_irq_rcu_node(ssp->srcu_sup);
 		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
-		ssp->srcu_n_exp_nodelay = 0;
+		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
@@ -1662,7 +1662,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
-		ssp->srcu_n_exp_nodelay = 0;
+		ssp->srcu_sup->srcu_n_exp_nodelay = 0;
 		srcu_gp_end(ssp);  /* Releases ->srcu_gp_mutex. */
 	}
 }
-- 
2.40.0.rc2

