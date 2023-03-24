Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5535C6C7478
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjCXAUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjCXATw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB332D15C;
        Thu, 23 Mar 2023 17:19:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08C6EB822B2;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6BAC433A8;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=1z9mhKOSF9Ot+/9TtqVkMS1pJCE+8rIytPo17nS5a68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VgYiTMlqqifxl++S+gtgsG3HPNfaeKWsMx3kYYo8nWyB9C23J9eMsk7qGs5Nm8xNo
         flSNHsMMcBqxTF3Mp5taBQKYwHuLG0Xrgmp/nC6x1/Rfd3VdNhHtnB2QN7piCBo8ZR
         i4xYJUaqL3uYrVbCp5tUhwuSnIawcaJoHsf5dOKHOVqu68qg1BF5SgC/n1lrYKP0Hz
         6SpdT/rtdEXmHO7SGg76CWA7O42OBNTYW1d+Mhk73kuGIOfg6Astq48LIqworxFy1+
         9Nqk7niQxo0IvtXPdnGZw2UiMibBvY5qU1+M+kz8KGNwsnRHWM0U7NbDfgBBZJVmkd
         4+TBHtvH8c63g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A88F315403A2; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 09/19] srcu: Move ->srcu_gp_mutex from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:28 -0700
Message-Id: <20230324001938.3443499-9-paulmck@kernel.org>
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

This commit moves the ->srcu_gp_mutex field from the srcu_struct structure
to the srcu_usage structure to reduce the size of the former in order
to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  2 +-
 kernel/rcu/srcutree.c    | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 6fe5743c1179..6402cd5a93ef 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -67,13 +67,13 @@ struct srcu_usage {
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
+	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
 	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 579c43ff0f4b..3bf3408c7716 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -245,7 +245,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
-	mutex_init(&ssp->srcu_gp_mutex);
+	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
 	ssp->srcu_gp_seq = 0;
 	ssp->srcu_barrier_seq = 0;
@@ -876,7 +876,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
 	spin_unlock_irq_rcu_node(ssp->srcu_sup);
-	mutex_unlock(&ssp->srcu_gp_mutex);
+	mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
@@ -1607,7 +1607,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 {
 	int idx;
 
-	mutex_lock(&ssp->srcu_gp_mutex);
+	mutex_lock(&ssp->srcu_sup->srcu_gp_mutex);
 
 	/*
 	 * Because readers might be delayed for an extended period after
@@ -1625,7 +1625,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
 			spin_unlock_irq_rcu_node(ssp->srcu_sup);
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
@@ -1633,7 +1633,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			srcu_gp_start(ssp);
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
 		}
 	}
@@ -1641,7 +1641,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
 		idx = 1 ^ (ssp->srcu_idx & 1);
 		if (!try_check_zero(ssp, idx, 1)) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
@@ -1659,7 +1659,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		 */
 		idx = 1 ^ (ssp->srcu_idx & 1);
 		if (!try_check_zero(ssp, idx, 2)) {
-			mutex_unlock(&ssp->srcu_gp_mutex);
+			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return; /* readers present, retry later. */
 		}
 		ssp->srcu_n_exp_nodelay = 0;
-- 
2.40.0.rc2

