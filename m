Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E035C6D128D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjC3Ws6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjC3WsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B9611144;
        Thu, 30 Mar 2023 15:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDA0E621DE;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3ABC433B0;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=qPJUbLDwJoxuPvlXSd44/Cow3IQ05DhaplSKVjgn+ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxJ1PThBMsE0pdh3ZjhAIlFPzhLY5Pf40/q8k9/9SEIov6bwNqZNeqGiIFUqgEMal
         bUXheB5FTeuj9fiuuBYRxTN90nxayRrzQxwjvuHDg0qc9di0arbH212UV9GFyoHcj6
         1yQmY5ILQ3BZp4motYghbSuNMpn/uB1h/gbVTnB/jUQsg3O7qTee+dh/ukaWp7QaEL
         Fcc05qIgAtkt2tw/ughERM5dmtMyMgJhud/Y137n5UWtyOuQyRNVBAfEvxYcd3S6i/
         48FhHtMcBAr/UliTEwtOxjgvR2iRrMF7ac1GI9y61hi/i6i8UZvPx9KMCVAUguwd1A
         GsyE18DGzBbeQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2CDBD154048A; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 14/20] srcu: Move srcu_barrier() fields from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:20 -0700
Message-Id: <20230330224726.662344-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
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

This commit moves the ->srcu_barrier_seq, ->srcu_barrier_mutex,
->srcu_barrier_completion, and ->srcu_barrier_cpu_cnt fields from the
srcu_struct structure to the srcu_usage structure to reduce the size of
the former in order to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 14 +++++++-------
 kernel/rcu/srcutree.c    | 38 +++++++++++++++++++-------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d3534ecb806e..d544ec1c0c8e 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -77,6 +77,13 @@ struct srcu_usage {
 	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
 	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
 	bool sda_is_static;			/* May ->sda be passed to free_percpu()? */
+	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
+	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
+	struct completion srcu_barrier_completion;
+						/* Awaken barrier rq at end. */
+	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
+						/*  callback for the barrier */
+						/*  operation. */
 };
 
 /*
@@ -85,13 +92,6 @@ struct srcu_usage {
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	struct srcu_data __percpu *sda;		/* Per-CPU srcu_data array. */
-	unsigned long srcu_barrier_seq;		/* srcu_barrier seq #. */
-	struct mutex srcu_barrier_mutex;	/* Serialize barrier ops. */
-	struct completion srcu_barrier_completion;
-						/* Awaken barrier rq at end. */
-	atomic_t srcu_barrier_cpu_cnt;		/* # CPUs not yet posting a */
-						/*  callback for the barrier */
-						/*  operation. */
 	unsigned long reschedule_jiffies;
 	unsigned long reschedule_count;
 	struct delayed_work work;
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 20f2373f7e25..97d1fe9a160c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -248,9 +248,9 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
 	ssp->srcu_sup->srcu_gp_seq = 0;
-	ssp->srcu_barrier_seq = 0;
-	mutex_init(&ssp->srcu_barrier_mutex);
-	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
+	ssp->srcu_sup->srcu_barrier_seq = 0;
+	mutex_init(&ssp->srcu_sup->srcu_barrier_mutex);
+	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 0);
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
 	ssp->srcu_sup->sda_is_static = is_static;
 	if (!is_static)
@@ -1496,8 +1496,8 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 
 	sdp = container_of(rhp, struct srcu_data, srcu_barrier_head);
 	ssp = sdp->ssp;
-	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-		complete(&ssp->srcu_barrier_completion);
+	if (atomic_dec_and_test(&ssp->srcu_sup->srcu_barrier_cpu_cnt))
+		complete(&ssp->srcu_sup->srcu_barrier_completion);
 }
 
 /*
@@ -1511,13 +1511,13 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
 {
 	spin_lock_irq_rcu_node(sdp);
-	atomic_inc(&ssp->srcu_barrier_cpu_cnt);
+	atomic_inc(&ssp->srcu_sup->srcu_barrier_cpu_cnt);
 	sdp->srcu_barrier_head.func = srcu_barrier_cb;
 	debug_rcu_head_queue(&sdp->srcu_barrier_head);
 	if (!rcu_segcblist_entrain(&sdp->srcu_cblist,
 				   &sdp->srcu_barrier_head)) {
 		debug_rcu_head_unqueue(&sdp->srcu_barrier_head);
-		atomic_dec(&ssp->srcu_barrier_cpu_cnt);
+		atomic_dec(&ssp->srcu_sup->srcu_barrier_cpu_cnt);
 	}
 	spin_unlock_irq_rcu_node(sdp);
 }
@@ -1530,20 +1530,20 @@ void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
 	int idx;
-	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
+	unsigned long s = rcu_seq_snap(&ssp->srcu_sup->srcu_barrier_seq);
 
 	check_init_srcu_struct(ssp);
-	mutex_lock(&ssp->srcu_barrier_mutex);
-	if (rcu_seq_done(&ssp->srcu_barrier_seq, s)) {
+	mutex_lock(&ssp->srcu_sup->srcu_barrier_mutex);
+	if (rcu_seq_done(&ssp->srcu_sup->srcu_barrier_seq, s)) {
 		smp_mb(); /* Force ordering following return. */
-		mutex_unlock(&ssp->srcu_barrier_mutex);
+		mutex_unlock(&ssp->srcu_sup->srcu_barrier_mutex);
 		return; /* Someone else did our work for us. */
 	}
-	rcu_seq_start(&ssp->srcu_barrier_seq);
-	init_completion(&ssp->srcu_barrier_completion);
+	rcu_seq_start(&ssp->srcu_sup->srcu_barrier_seq);
+	init_completion(&ssp->srcu_sup->srcu_barrier_completion);
 
 	/* Initial count prevents reaching zero until all CBs are posted. */
-	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
+	atomic_set(&ssp->srcu_sup->srcu_barrier_cpu_cnt, 1);
 
 	idx = __srcu_read_lock_nmisafe(ssp);
 	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
@@ -1554,12 +1554,12 @@ void srcu_barrier(struct srcu_struct *ssp)
 	__srcu_read_unlock_nmisafe(ssp, idx);
 
 	/* Remove the initial count, at which point reaching zero can happen. */
-	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-		complete(&ssp->srcu_barrier_completion);
-	wait_for_completion(&ssp->srcu_barrier_completion);
+	if (atomic_dec_and_test(&ssp->srcu_sup->srcu_barrier_cpu_cnt))
+		complete(&ssp->srcu_sup->srcu_barrier_completion);
+	wait_for_completion(&ssp->srcu_sup->srcu_barrier_completion);
 
-	rcu_seq_end(&ssp->srcu_barrier_seq);
-	mutex_unlock(&ssp->srcu_barrier_mutex);
+	rcu_seq_end(&ssp->srcu_sup->srcu_barrier_seq);
+	mutex_unlock(&ssp->srcu_sup->srcu_barrier_mutex);
 }
 EXPORT_SYMBOL_GPL(srcu_barrier);
 
-- 
2.40.0.rc2

