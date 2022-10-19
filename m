Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D20660538E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbiJSW7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJSW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212511CBAAD;
        Wed, 19 Oct 2022 15:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58FD9B8261D;
        Wed, 19 Oct 2022 22:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D9EC43145;
        Wed, 19 Oct 2022 22:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=BdQBnT/5Lg+ztsBrYfPMi3iUxQTo6LmC+1YzXMhFGpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cU8gnXdGPAvsqb8jSRTMD5Tspc+o/pThgguWUy9C0+HKiSB02l5GfNIGxS0JkL7uX
         pq+RNB4RMzE074QpEWxilIEtr7DP28edGfkQiaGDDJT2n8K1gKZlATm9DXGgaKo8wG
         hDWPKAtu3fuXKGyMMvmjFBcs3gV9VQjqWDVSyyr2rbyzRt0hU2S/kJ0OCsX9eRyAy5
         NEQ/jAccQDyxbgxzafRZOvp74EWbisM43SneTv+DSiK+TjDYrUYdhvKA7Y95NiHV4v
         Y+rymIeTADKMHoCQUGs00uf3WFhiACFYWcP3ZkoSodalaYjLJfkN8YHvwGgjBfbTku
         PN9wNMrWoqdSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AF0AF5C0890; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 rcu 03/11] srcu: Check for consistent per-CPU per-srcu_struct NMI safety
Date:   Wed, 19 Oct 2022 15:58:38 -0700
Message-Id: <20221019225846.2501109-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
References: <20221019225838.GA2500612@paulmck-ThinkPad-P17-Gen-1>
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

This commit adds runtime checks to verify that a given srcu_struct uses
consistent NMI-safe (or not) read-side primitives on a per-CPU basis.

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/srcu.h     |  4 ++--
 include/linux/srcutiny.h |  4 ++--
 include/linux/srcutree.h |  9 +++++++--
 kernel/rcu/srcutree.c    | 38 ++++++++++++++++++++++++++++++++------
 4 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 2cc8321c0c86a..565f60d574847 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -180,7 +180,7 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 	int retval;
 
 	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		retval = __srcu_read_lock_nmisafe(ssp);
+		retval = __srcu_read_lock_nmisafe(ssp, true);
 	else
 		retval = __srcu_read_lock(ssp);
 	rcu_lock_acquire(&(ssp)->dep_map);
@@ -225,7 +225,7 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	WARN_ON_ONCE(idx & ~0x1);
 	rcu_lock_release(&(ssp)->dep_map);
 	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		__srcu_read_unlock_nmisafe(ssp, idx);
+		__srcu_read_unlock_nmisafe(ssp, idx, true);
 	else
 		__srcu_read_unlock(ssp, idx);
 }
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 278331bd77660..f890301f123df 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -90,13 +90,13 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_idx_max)));
 }
 
-static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
 {
 	BUG();
 	return 0;
 }
 
-static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe)
 {
 	BUG();
 }
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index d45dd507f4a56..35ffdedf86ccb 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -25,6 +25,7 @@ struct srcu_data {
 	/* Read-side state. */
 	atomic_long_t srcu_lock_count[2];	/* Locks per CPU. */
 	atomic_long_t srcu_unlock_count[2];	/* Unlocks per CPU. */
+	int srcu_nmi_safety;			/* NMI-safe srcu_struct structure? */
 
 	/* Update-side state. */
 	spinlock_t __private lock ____cacheline_internodealigned_in_smp;
@@ -42,6 +43,10 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
+#define SRCU_NMI_UNKNOWN	0x0
+#define SRCU_NMI_NMI_UNSAFE	0x1
+#define SRCU_NMI_NMI_SAFE	0x2
+
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
@@ -154,7 +159,7 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
 
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 32a94b254d29f..30575864fcfa3 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -626,6 +626,26 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
+/*
+ * Check for consistent NMI safety.
+ */
+static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
+{
+	int nmi_safe_mask = 1 << nmi_safe;
+	int old_nmi_safe_mask;
+	struct srcu_data *sdp;
+
+	if (!IS_ENABLED(CONFIG_PROVE_RCU))
+		return;
+	sdp = raw_cpu_ptr(ssp->sda);
+	old_nmi_safe_mask = READ_ONCE(sdp->srcu_nmi_safety);
+	if (!old_nmi_safe_mask) {
+		WRITE_ONCE(sdp->srcu_nmi_safety, nmi_safe_mask);
+		return;
+	}
+	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
+}
+
 /*
  * Counts the new reader in the appropriate per-CPU element of the
  * srcu_struct.
@@ -638,6 +658,7 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
+	srcu_check_nmi_safety(ssp, false);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
@@ -651,6 +672,7 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
 	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
+	srcu_check_nmi_safety(ssp, false);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -661,7 +683,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  * srcu_struct, but in an NMI-safe manner using RMW atomics.
  * Returns an index that must be passed to the matching srcu_read_unlock().
  */
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
 {
 	int idx;
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
@@ -669,6 +691,8 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	atomic_long_inc(&sdp->srcu_lock_count[idx]);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
+	if (chknmisafe)
+		srcu_check_nmi_safety(ssp, true);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
@@ -678,12 +702,14 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
  * element of the srcu_struct.  Note that this may well be a different
  * CPU than that which was incremented by the corresponding srcu_read_lock().
  */
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe)
 {
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
 	atomic_long_inc(&sdp->srcu_unlock_count[idx]);
+	if (chknmisafe)
+		srcu_check_nmi_safety(ssp, true);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
@@ -1125,7 +1151,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	int ss_state;
 
 	check_init_srcu_struct(ssp);
-	idx = __srcu_read_lock_nmisafe(ssp);
+	idx = __srcu_read_lock_nmisafe(ssp, false);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, 0);
@@ -1158,7 +1184,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp_mynode, s);
-	__srcu_read_unlock_nmisafe(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx, false);
 	return s;
 }
 
@@ -1462,13 +1488,13 @@ void srcu_barrier(struct srcu_struct *ssp)
 	/* Initial count prevents reaching zero until all CBs are posted. */
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
-	idx = __srcu_read_lock_nmisafe(ssp);
+	idx = __srcu_read_lock_nmisafe(ssp, false);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
-	__srcu_read_unlock_nmisafe(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx, false);
 
 	/* Remove the initial count, at which point reaching zero can happen. */
 	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-- 
2.31.1.189.g2e36527f23

