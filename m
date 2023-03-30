Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F26D1289
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjC3Wse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjC3Wr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:47:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD461284C;
        Thu, 30 Mar 2023 15:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1512621DA;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0900C433A7;
        Thu, 30 Mar 2023 22:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216448;
        bh=cCzGQyhtTKWvulawbEaYl/H/NEMJXQmFHtWWAEfRDjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6TuH8C9K4ADQJpkZ2GORgcG8QsicxJsHNy3rmryYERZoNnMvYQp4PCqfz/kKRB77
         p7s5gMlnxxk7beOPkSKI0JkgjtJI2FEm/WHo448m1pTYV2NHPa2GaYbvYeT43uM2/5
         uGdKMd4PsMA3EyAJrTL0liArrBI72A+gEYk/Btc4IP7VH8rssxQ0Ah/L0pbFPxW04H
         PXS3vy+7fbxSpWDe3MGFXSvzE/mSTXKsAF2oq1QKdW6py/7Y046NYp5I6WG92RQr2z
         cFMu5+se63RFSe0/WKnX0jS++gAak5eF8n5UOhpF6k5yqvtTjjGyOHogU1Ju43KzXT
         bNyOR4uW0vz6g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1B8AB1540485; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 09/20] srcu: Move ->lock from srcu_struct to srcu_usage
Date:   Thu, 30 Mar 2023 15:47:15 -0700
Message-Id: <20230330224726.662344-9-paulmck@kernel.org>
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

This commit moves the ->lock field from the srcu_struct structure to
the srcu_usage structure to reduce the size of the former in order to
improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 11 +++++---
 kernel/rcu/srcutree.c    | 56 ++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 231de66ceb15..694d87b81917 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -66,13 +66,13 @@ struct srcu_usage {
 						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
+	spinlock_t __private lock;		/* Protect counters and size state. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
@@ -116,7 +116,6 @@ struct srcu_struct {
 #define SRCU_STATE_SCAN2	2
 
 #define __SRCU_STRUCT_INIT_COMMON(name, usage_name)						\
-	.lock = __SPIN_LOCK_UNLOCKED(name.lock),						\
 	.srcu_gp_seq_needed = -1UL,								\
 	.work = __DELAYED_WORK_INITIALIZER(name.work, NULL, 0),					\
 	.srcu_sup = &usage_name,								\
@@ -154,7 +153,9 @@ struct srcu_struct {
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)								\
-	static struct srcu_usage name##_srcu_usage;						\
+	static struct srcu_usage name##_srcu_usage = {						\
+		.lock = __SPIN_LOCK_UNLOCKED(name.lock),					\
+	};											\
 	is_static struct srcu_struct name = __SRCU_STRUCT_INIT_MODULE(name, name##_srcu_usage);	\
 	extern struct srcu_struct * const __srcu_struct_##name;					\
 	struct srcu_struct * const __srcu_struct_##name						\
@@ -162,7 +163,9 @@ struct srcu_struct {
 #else
 # define __DEFINE_SRCU(name, is_static)								\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);				\
-	static struct srcu_usage name##_srcu_usage;						\
+	static struct srcu_usage name##_srcu_usage = {						\
+		.lock = __SPIN_LOCK_UNLOCKED(name.lock),					\
+	};											\
 	is_static struct srcu_struct name =							\
 		__SRCU_STRUCT_INIT(name, name##_srcu_usage, name##_srcu_data)
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c2a024a60f1a..c42248cf18f6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -103,7 +103,7 @@ do {										\
 
 #define spin_trylock_irqsave_rcu_node(p, flags)					\
 ({										\
-	bool ___locked = spin_trylock_irqsave(&ACCESS_PRIVATE(p, lock), flags);	\
+	bool ___locked = spin_trylock_irqsave(&ACCESS_PRIVATE(p, lock), flags); \
 										\
 	if (___locked)								\
 		smp_mb__after_unlock_lock();					\
@@ -241,7 +241,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->srcu_sup)
 		return -ENOMEM;
 	if (!is_static)
-		spin_lock_init(&ACCESS_PRIVATE(ssp, lock));
+		spin_lock_init(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	ssp->srcu_sup->srcu_size_state = SRCU_SIZE_SMALL;
 	ssp->srcu_sup->node = NULL;
 	mutex_init(&ssp->srcu_sup->srcu_cb_mutex);
@@ -314,7 +314,7 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
  */
 static void __srcu_transition_to_big(struct srcu_struct *ssp)
 {
-	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_ALLOC);
 }
 
@@ -328,13 +328,13 @@ static void srcu_transition_to_big(struct srcu_struct *ssp)
 	/* Double-checked locking on ->srcu_size-state. */
 	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL)
 		return;
-	spin_lock_irqsave_rcu_node(ssp, flags);
+	spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) != SRCU_SIZE_SMALL) {
-		spin_unlock_irqrestore_rcu_node(ssp, flags);
+		spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
 	__srcu_transition_to_big(ssp);
-	spin_unlock_irqrestore_rcu_node(ssp, flags);
+	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -369,9 +369,9 @@ static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned lon
 
 	if (spin_trylock_irqsave_rcu_node(sdp, *flags))
 		return;
-	spin_lock_irqsave_rcu_node(ssp, *flags);
+	spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
 	spin_lock_irqsave_check_contention(ssp);
-	spin_unlock_irqrestore_rcu_node(ssp, *flags);
+	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, *flags);
 	spin_lock_irqsave_rcu_node(sdp, *flags);
 }
 
@@ -383,9 +383,9 @@ static void spin_lock_irqsave_sdp_contention(struct srcu_data *sdp, unsigned lon
  */
 static void spin_lock_irqsave_ssp_contention(struct srcu_struct *ssp, unsigned long *flags)
 {
-	if (spin_trylock_irqsave_rcu_node(ssp, *flags))
+	if (spin_trylock_irqsave_rcu_node(ssp->srcu_sup, *flags))
 		return;
-	spin_lock_irqsave_rcu_node(ssp, *flags);
+	spin_lock_irqsave_rcu_node(ssp->srcu_sup, *flags);
 	spin_lock_irqsave_check_contention(ssp);
 }
 
@@ -404,13 +404,13 @@ static void check_init_srcu_struct(struct srcu_struct *ssp)
 	/* The smp_load_acquire() pairs with the smp_store_release(). */
 	if (!rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq_needed))) /*^^^*/
 		return; /* Already initialized. */
-	spin_lock_irqsave_rcu_node(ssp, flags);
+	spin_lock_irqsave_rcu_node(ssp->srcu_sup, flags);
 	if (!rcu_seq_state(ssp->srcu_gp_seq_needed)) {
-		spin_unlock_irqrestore_rcu_node(ssp, flags);
+		spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 		return;
 	}
 	init_srcu_struct_fields(ssp, true);
-	spin_unlock_irqrestore_rcu_node(ssp, flags);
+	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -774,7 +774,7 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = this_cpu_ptr(ssp->sda);
-	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
+	lockdep_assert_held(&ACCESS_PRIVATE(ssp->srcu_sup, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
 	rcu_segcblist_advance(&sdp->srcu_cblist,
@@ -864,7 +864,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	mutex_lock(&ssp->srcu_sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
-	spin_lock_irq_rcu_node(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	idx = rcu_seq_state(ssp->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
 	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_gp_seq), READ_ONCE(ssp->srcu_gp_seq_needed_exp)))
@@ -875,7 +875,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
-	spin_unlock_irq_rcu_node(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	mutex_unlock(&ssp->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
@@ -924,15 +924,15 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	mutex_unlock(&ssp->srcu_sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
-	spin_lock_irq_rcu_node(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
 	    ULONG_CMP_LT(gpseq, ssp->srcu_gp_seq_needed)) {
 		srcu_gp_start(ssp);
-		spin_unlock_irq_rcu_node(ssp);
+		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		srcu_reschedule(ssp, 0);
 	} else {
-		spin_unlock_irq_rcu_node(ssp);
+		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
 	/* Transition to big if needed. */
@@ -975,7 +975,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	spin_lock_irqsave_ssp_contention(ssp, &flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
-	spin_unlock_irqrestore_rcu_node(ssp, flags);
+	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -1064,7 +1064,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		else if (list_empty(&ssp->work.work.entry))
 			list_add(&ssp->work.work.entry, &srcu_boot_list);
 	}
-	spin_unlock_irqrestore_rcu_node(ssp, flags);
+	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
 }
 
 /*
@@ -1599,17 +1599,17 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 	 */
 	idx = rcu_seq_state(smp_load_acquire(&ssp->srcu_gp_seq)); /* ^^^ */
 	if (idx == SRCU_STATE_IDLE) {
-		spin_lock_irq_rcu_node(ssp);
+		spin_lock_irq_rcu_node(ssp->srcu_sup);
 		if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
 			WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq));
-			spin_unlock_irq_rcu_node(ssp);
+			spin_unlock_irq_rcu_node(ssp->srcu_sup);
 			mutex_unlock(&ssp->srcu_gp_mutex);
 			return;
 		}
 		idx = rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq));
 		if (idx == SRCU_STATE_IDLE)
 			srcu_gp_start(ssp);
-		spin_unlock_irq_rcu_node(ssp);
+		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 		if (idx != SRCU_STATE_IDLE) {
 			mutex_unlock(&ssp->srcu_gp_mutex);
 			return; /* Someone else started the grace period. */
@@ -1623,10 +1623,10 @@ static void srcu_advance_state(struct srcu_struct *ssp)
 			return; /* readers present, retry later. */
 		}
 		srcu_flip(ssp);
-		spin_lock_irq_rcu_node(ssp);
+		spin_lock_irq_rcu_node(ssp->srcu_sup);
 		rcu_seq_set_state(&ssp->srcu_gp_seq, SRCU_STATE_SCAN2);
 		ssp->srcu_n_exp_nodelay = 0;
-		spin_unlock_irq_rcu_node(ssp);
+		spin_unlock_irq_rcu_node(ssp->srcu_sup);
 	}
 
 	if (rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
@@ -1710,7 +1710,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 {
 	bool pushgp = true;
 
-	spin_lock_irq_rcu_node(ssp);
+	spin_lock_irq_rcu_node(ssp->srcu_sup);
 	if (ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed)) {
 		if (!WARN_ON_ONCE(rcu_seq_state(ssp->srcu_gp_seq))) {
 			/* All requests fulfilled, time to go idle. */
@@ -1720,7 +1720,7 @@ static void srcu_reschedule(struct srcu_struct *ssp, unsigned long delay)
 		/* Outstanding request and no GP.  Start one. */
 		srcu_gp_start(ssp);
 	}
-	spin_unlock_irq_rcu_node(ssp);
+	spin_unlock_irq_rcu_node(ssp->srcu_sup);
 
 	if (pushgp)
 		queue_delayed_work(rcu_gp_wq, &ssp->work, delay);
-- 
2.40.0.rc2

