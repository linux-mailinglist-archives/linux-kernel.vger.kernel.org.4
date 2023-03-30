Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BC86D1290
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjC3WtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjC3WsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538E411660;
        Thu, 30 Mar 2023 15:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24D87621E3;
        Thu, 30 Mar 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1156C433AA;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=tZljGOSxt5h+qbZk8QZYlNumDRe8p6ORU5c3l95xxHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWAqiU4ZiVOj+cWfdDDDHtCJ7zC5PSXc5KGBe+Q9wcAaOdY3xveUC6gSX6SUjCZi1
         jiw7qca+YwzFCqZD01ZCEMcqDaKE6LcuNCAHJEv+MOaws4Ou7h739G5RTtVHx9ZJMd
         fvrpM5fi4xo1XD6mgZY6PSnWHfbG3Jp2i7bL1y7oeNTHEmzMCEVHAV09s6GeomxWXb
         86SsZ2FIGNAeDFIWPD2YiBIbzVih9zfYaUmhAk/g0WkF34nZy8ldZFIeG4vIwA4vs9
         bo+6tlfm4l2Z9EjiANuac9lxSbG5EsNubmnuluv07rm4CJ5g8LZ4hLze4xEsOU8AOa
         7LggWMLfxSxgA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 22A2F1540487; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 11/20] srcu: Move grace-period fields from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:17 -0700
Message-Id: <20230330224726.662344-11-paulmck@kernel.org>
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

This commit moves the ->srcu_gp_seq, ->srcu_gp_seq_needed,
->srcu_gp_seq_needed_exp, ->srcu_gp_start, and ->srcu_last_gp_end fields
from the srcu_struct structure to the srcu_usage structure to reduce
the size of the former in order to improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  25 ++++----
 kernel/rcu/srcutree.c    | 128 +++++++++++++++++++--------------------
 2 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d04e3da6181c..372e35b0e8b6 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -68,6 +68,11 @@ struct srcu_usage {
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
+	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
+	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
+	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
+	unsigned long srcu_gp_start;		/* Last GP start timestamp (jiffies) */
+	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
 };
 
 /*
@@ -75,11 +80,6 @@ struct srcu_usage {
  */
 struct srcu_struct {
 	unsigned int srcu_idx;			/* Current rdr array element. */
-	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
-	unsigned long srcu_gp_seq_needed;	/* Latest gp_seq needed. */
-	unsigned long srcu_gp_seq_needed_exp;	/* Furthest future exp GP. */
-	unsigned long srcu_gp_start;		/* Last GP start timestamp (jiffies) */
-	unsigned long srcu_last_gp_end;		/* Last GP end timestamp (ns) */
 	unsigned long srcu_size_jiffies;	/* Current contention-measurement interval. */
 	unsigned long srcu_n_lock_retries;	/* Contention events in current interval. */
 	unsigned long srcu_n_exp_nodelay;	/* # expedited no-delays in current GP phase. */
@@ -115,8 +115,13 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN1	1
 #define SRCU_STATE_SCAN2	2
 
-#define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
+#define __SRCU_USAGE_INIT(name)									\
+{												\
+	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq_needed = -1UL,								\
+}
+
+#define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 	.srcu_sup = &usage_name,								\
 	__SRCU_DEP_MAP_INIT(name)
@@ -153,9 +158,7 @@ struct srcu_struct {
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)								\
-	static struct srcu_usage name##_srcu_usage = {						\
-		.lock = __SPIN_LOCK_UNLOCKED(name.lock),					\
-	};											\
+	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
@@ -163,9 +166,7 @@ struct srcu_struct {
 #else
 # define __DEFINE_SRCU(name, is_static)								\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
-	static struct srcu_usage name##_srcu_usage = {						\
-		.lock = __SPIN_LOCK_UNLOCKED(name.lock),					\
-	};											\
+	static struct srcu_usage name##_srcu_usage = __SRCU_USAGE_INIT(name##_srcu_usage);	\
 	is_static struct srcu_struct name =							\
 		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a36066798de7..340eb685cf64 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -135,8 +135,8 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 		spin_lock_init(&ACCESS_PRIVATE(sdp, lock));
 		rcu_segcblist_init(&sdp->srcu_cblist);
 		sdp->srcu_cblist_invoking = false;
-		sdp->srcu_gp_seq_needed = ssp->srcu_gp_seq;
-		sdp->srcu_gp_seq_needed_exp = ssp->srcu_gp_seq;
+		sdp->srcu_gp_seq_needed = ssp->srcu_sup->srcu_gp_seq;
+		sdp->srcu_gp_seq_needed_exp = ssp->srcu_sup->srcu_gp_seq;
 		sdp->mynode = NULL;
 		sdp->cpu = cpu;
 		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
@@ -247,7 +247,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_sup->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
-	ssp->srcu_gp_seq = 0;
+	ssp->srcu_sup->srcu_gp_seq = 0;
 	ssp->srcu_barrier_seq = 0;
 	mutex_init(&ssp->srcu_barrier_mutex);
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 0);
@@ -261,8 +261,8 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		return -ENOMEM;
 	}
 	init_srcu_struct_data(ssp);
-	ssp->srcu_gp_seq_needed_exp = 0;
-	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
+	ssp->srcu_sup->srcu_gp_seq_needed_exp = 0;
+	ssp->srcu_sup->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	if (READ_ONCE(ssp->srcu_sup->srcu_size_state) == SRCU_SIZE_SMALL && SRCU_SIZING_IS_INIT()) {
 		if (!init_srcu_struct_nodes(ssp, GFP_ATOMIC)) {
 			if (!ssp->sda_is_static) {
@@ -275,7 +275,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 			WRITE_ONCE(ssp->srcu_sup->srcu_size_state, SRCU_SIZE_BIG);
 		}
 	}
-	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
+	smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, 0); /* Init done. */
 	return 0;
 }
 
@@ -402,10 +402,10 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 	unsigned long flags;
 
 	/* The smp_load_acquire() pairs with the smp_store_release(). */
-	if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq_needed))) /*^^^*/
+	if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed))) /*^^^*/
 		return; /* Already initialized. */
 	spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
-	if (!rcu_seq_state(ssp->srcu_gp_seq_needed)) {
+	if (!rcu_seq_state(ssp->srcu_sup->srcu_gp_seq_needed)) {
 		spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
@@ -616,11 +616,11 @@ static unsigned long srcu_get_delay(struct srcu_struct *ssp)
 	unsigned long j;
 	unsigned long jbase = SRCU_INTERVAL;
 
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_sup->srcu_gp_seq), READ_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp)))
 		jbase = 0;
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq))) {
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq))) {
 		j = jiffies - 1;
-		gpstart = READ_ONCE(ssp->srcu_gp_start);
+		gpstart = READ_ONCE(ssp->srcu_sup->srcu_gp_start);
 		if (time_after(j, gpstart))
 			jbase += j - gpstart;
 		if (!jbase) {
@@ -656,12 +656,12 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 		if (WARN_ON(rcu_segcblist_n_cbs(&sdp->srcu_cblist)))
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
-	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
-	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
+	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq) != ssp->srcu_sup->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
 		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
-			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
+			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)),
+			rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq), ssp->srcu_sup->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	kfree(ssp->srcu_sup->node);
@@ -775,18 +775,18 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	else
 		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
-	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
+	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
+			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_gp_seq));
+				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	spin_unlock_rcu_node(sdp);  /* Interrupts remain disabled. */
-	WRITE_ONCE(ssp->srcu_gp_start, jiffies);
+	WRITE_ONCE(ssp->srcu_sup->srcu_gp_start, jiffies);
 	WRITE_ONCE(ssp->srcu_n_exp_nodelay, 0);
 	smp_mb(); /* Order prior store to ->srcu_gp_seq_needed vs. GP start. */
-	rcu_seq_start(&ssp->srcu_gp_seq);
-	state = rcu_seq_state(ssp->srcu_gp_seq);
+	rcu_seq_start(&ssp->srcu_sup->srcu_gp_seq);
+	state = rcu_seq_state(ssp->srcu_sup->srcu_gp_seq);
 	WARN_ON_ONCE(state != SRCU_STATE_SCAN1);
 }
 
@@ -865,16 +865,16 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 
 	/* End the current grace period. */
 	spin_lock_irq_rcu_node(ssp->srcu_sup);
-	idx = rcu_seq_state(ssp->srcu_gp_seq);
+	idx = rcu_seq_state(ssp->srcu_sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_sup->srcu_gp_seq), READ_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp)))
 		cbdelay = 0;
 
-	WRITE_ONCE(ssp->srcu_last_gp_end, ktime_get_mono_fast_ns());
-	rcu_seq_end(&ssp->srcu_gp_seq);
-	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
-	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
-		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
+	WRITE_ONCE(ssp->srcu_sup->srcu_last_gp_end, ktime_get_mono_fast_ns());
+	rcu_seq_end(&ssp->srcu_sup->srcu_gp_seq);
+	gpseq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
+	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, gpseq))
+		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, gpseq);
 	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
@@ -925,9 +925,9 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 
 	/* Start a new grace period if needed. */
 	spin_lock_irq_rcu_node(ssp->srcu_sup);
-	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
+	gpseq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
-	    ULONG_CMP_LT(gpseq, ssp->srcu_gp_seq_needed)) {
+	    ULONG_CMP_LT(gpseq, ssp->srcu_sup->srcu_gp_seq_needed)) {
 		srcu_gp_start(ssp);
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		srcu_reschedule(ssp, 0);
@@ -960,7 +960,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	if (snp)
 		for (; snp != NULL; snp = snp->srcu_parent) {
 			sgsne = READ_ONCE(snp->srcu_gp_seq_needed_exp);
-			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) ||
+			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) ||
 			    (!srcu_invl_snp_seq(sgsne) && ULONG_CMP_GE(sgsne, s)))
 				return;
 			spin_lock_irqsave_rcu_node(snp, flags);
@@ -973,8 +973,8 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 			spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
 	spin_lock_irqsave_ssp_contention(ssp, &flags);
-	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
+	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, s))
+		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, s);
 	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
@@ -1010,7 +1010,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) && snp != snp_leaf)
+			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) && snp != snp_leaf)
 				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
@@ -1037,20 +1037,20 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 
 	/* Top of tree, must ensure the grace period will be started. */
 	spin_lock_irqsave_ssp_contention(ssp, &flags);
-	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed, s)) {
+	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed, s)) {
 		/*
 		 * Record need for grace period s.  Pair with load
 		 * acquire setting up for initialization.
 		 */
-		smp_store_release(&ssp->srcu_gp_seq_needed, s); /*^^^*/
+		smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, s); /*^^^*/
 	}
-	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
+	if (!do_norm && ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, s))
+		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, s);
 
 	/* If grace period not already in progress, start it. */
-	if (!WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_gp_seq, s)) &&
-	    rcu_seq_state(ssp->srcu_gp_seq) == SRCU_STATE_IDLE) {
-		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
+	if (!WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) &&
+	    rcu_seq_state(ssp->srcu_sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
+		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
 		// And how can that list_add() in the "else" clause
@@ -1164,18 +1164,18 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
 
 	/* First, see if enough time has passed since the last GP. */
 	t = ktime_get_mono_fast_ns();
-	tlast = READ_ONCE(ssp->srcu_last_gp_end);
+	tlast = READ_ONCE(ssp->srcu_sup->srcu_last_gp_end);
 	if (exp_holdoff == 0 ||
 	    time_in_range_open(t, tlast, tlast + exp_holdoff))
 		return false; /* Too soon after last GP. */
 
 	/* Next, check for probable idleness. */
-	curseq = rcu_seq_current(&ssp->srcu_gp_seq);
+	curseq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 	smp_mb(); /* Order ->srcu_gp_seq with ->srcu_gp_seq_needed. */
-	if (ULONG_CMP_LT(curseq, READ_ONCE(ssp->srcu_gp_seq_needed)))
+	if (ULONG_CMP_LT(curseq, READ_ONCE(ssp->srcu_sup->srcu_gp_seq_needed)))
 		return false; /* Grace period in progress, so not idle. */
 	smp_mb(); /* Order ->srcu_gp_seq with prior access. */
-	if (curseq != rcu_seq_current(&ssp->srcu_gp_seq))
+	if (curseq != rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq))
 		return false; /* GP # changed, so not idle. */
 	return true; /* With reasonable probability, idle! */
 }
@@ -1218,8 +1218,8 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
-	s = rcu_seq_snap(&ssp->srcu_gp_seq);
+			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
+	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist, s);
 	if (ULONG_CMP_LT(sdp->srcu_gp_seq_needed, s)) {
 		sdp->srcu_gp_seq_needed = s;
@@ -1430,7 +1430,7 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp)
 	// Any prior manipulation of SRCU-protected data must happen
 	// before the load from ->srcu_gp_seq.
 	smp_mb();
-	return rcu_seq_snap(&ssp->srcu_gp_seq);
+	return rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_srcu);
 
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_srcu);
  */
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie)
 {
-	if (!rcu_seq_done(&ssp->srcu_gp_seq, cookie))
+	if (!rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, cookie))
 		return false;
 	// Ensure that the end of the SRCU grace period happens before
 	// any subsequent code that the caller might execute.
@@ -1597,16 +1597,16 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	 * The load-acquire ensures that we see the accesses performed
 	 * by the prior grace period.
 	 */
-	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq)); /* ^^^ */
+	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq)); /* ^^^ */
 	if (idx == SRCU_STATE_IDLE) {
 		spin_lock_irq_rcu_node(ssp->srcu_sup);
-		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
-			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
+		if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
+			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq));
 			spin_unlock_irq_rcu_node(ssp->srcu_sup);
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
 			return;
 		}
-		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
+		idx = rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq));
 		if (idx == SRCU_STATE_IDLE)
 			srcu_gp_start(ssp);
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
@@ -1616,7 +1616,7 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		}
 	}
 
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
 		idx = 1 ^ (ssp->srcu_idx & 1);
 		if (!try_check_zero(ssp, idx, 1)) {
 			mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
@@ -1624,12 +1624,12 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 		}
 		srcu_flip(ssp);
 		spin_lock_irq_rcu_node(ssp->srcu_sup);
-		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
+		rcu_seq_set_state(&ssp->srcu_sup->srcu_gp_seq, SRCU_STATE_SCAN2);
 		ssp->srcu_n_exp_nodelay = 0;
 		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
-	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
+	if (rcu_seq_state(READ_ONCE(ssp->srcu_sup->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
 
 		/*
 		 * SRCU read-side critical sections are normally short,
@@ -1666,7 +1666,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	rcu_cblist_init(&ready_cbs);
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_advance(&sdp->srcu_cblist,
-			      rcu_seq_current(&ssp->srcu_gp_seq));
+			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
 	if (sdp->srcu_cblist_invoking ||
 	    !rcu_segcblist_ready_cbs(&sdp->srcu_cblist)) {
 		spin_unlock_irq_rcu_node(sdp);
@@ -1694,7 +1694,7 @@ static void srcu_invoke_callbacks(struct work_struct *work)
 	spin_lock_irq_rcu_node(sdp);
 	rcu_segcblist_add_len(&sdp->srcu_cblist, -len);
 	(void)rcu_segcblist_accelerate(&sdp->srcu_cblist,
-				       rcu_seq_snap(&ssp->srcu_gp_seq));
+				       rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq));
 	sdp->srcu_cblist_invoking = false;
 	more = rcu_segcblist_ready_cbs(&sdp->srcu_cblist);
 	spin_unlock_irq_rcu_node(sdp);
@@ -1711,12 +1711,12 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 	bool pushgp = true;
 
 	spin_lock_irq_rcu_node(ssp->srcu_sup);
-	if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
-		if (!WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq))) {
+	if (ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed)) {
+		if (!WARN_ON_ONCE(rcu_seq_state(ssp->srcu_sup->srcu_gp_seq))) {
 			/* All requests fulfilled, time to go idle. */
 			pushgp = false;
 		}
-	} else if (!rcu_seq_state(ssp->srcu_gp_seq)) {
+	} else if (!rcu_seq_state(ssp->srcu_sup->srcu_gp_seq)) {
 		/* Outstanding request and no GP.  Start one. */
 		srcu_gp_start(ssp);
 	}
@@ -1762,7 +1762,7 @@ void srcutorture_get_gp_data(enum rcutorture_type test_type,
 	if (test_type != SRCU_FLAVOR)
 		return;
 	*flags = 0;
-	*gp_seq = rcu_seq_current(&ssp->srcu_gp_seq);
+	*gp_seq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
 }
 EXPORT_SYMBOL_GPL(srcutorture_get_gp_data);
 
@@ -1791,7 +1791,7 @@ void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf)
 	if (ss_state < 0 || ss_state >= ARRAY_SIZE(srcu_size_state_name))
 		ss_state_idx = ARRAY_SIZE(srcu_size_state_name) - 1;
 	pr_alert("%s%s Tree SRCU g%ld state %d (%s)",
-		 tt, tf, rcu_seq_current(&ssp->srcu_gp_seq), ss_state,
+		 tt, tf, rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq), ss_state,
 		 srcu_size_state_name[ss_state_idx]);
 	if (!ssp->sda) {
 		// Called after cleanup_srcu_struct(), perhaps.
@@ -1905,7 +1905,7 @@ static void srcu_module_going(struct module *mod)
 
 	for (i = 0; i < mod->num_srcu_structs; i++) {
 		ssp = *(sspp++);
-		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq_needed)) &&
+		if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_sup->srcu_gp_seq_needed)) &&
 		    !WARN_ON_ONCE(!ssp->sda_is_static))
 			cleanup_srcu_struct(ssp);
 		free_percpu(ssp->sda);
-- 
2.40.0.rc2

