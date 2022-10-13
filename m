Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1285FDEDE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJMRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJMRXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:23:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233EDFC03;
        Thu, 13 Oct 2022 10:22:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE341B81E4F;
        Thu, 13 Oct 2022 17:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA79C433B5;
        Thu, 13 Oct 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665681776;
        bh=+BgeKOIz7r4UkK02yl+nFx3V24nOUHvTKcW7npOo098=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGEb/z0DeH4yu0vFf3qsh+2Ig1bKuqUz+W7jsg62z2XwOm1e4QmQXoI1w3vqoDDEk
         PnnN4xKlHNTVEuqDkzumoO/JKLq4yiwjlBOqK6McNV4U06rYUUSSYbG+jyNgTy8/jU
         F46NNIdFpmB1TzczJke9s6lrF4wMO6xdNv7wnIgGJxqEnoBBZTM2e9BEY9jFsxPy59
         E8GcZp+VUL15NZrY9BF9BR7swSNA8s/L0ZCTB4zG9Ac50QN9+araYPCJpTNGHv/8vC
         E4yTQQdS+f4FPDsftRvQai+jaRjHva5nMK91OMJhnVUwlct2iuk6aWSR3IB/a2KAIt
         p/vbhrn+BopAA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/3] srcu: Debug NMI safety even on archs that don't require it
Date:   Thu, 13 Oct 2022 19:22:44 +0200
Message-Id: <20221013172244.1099010-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013172244.1099010-1-frederic@kernel.org>
References: <20221013172244.1099010-1-frederic@kernel.org>
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

Currently the NMI safety debugging is only performed on architectures
that don't support NMI-safe this_cpu_inc().

Reorder the code so that other architectures like x86 also detect bad
uses.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/srcu.h     | 44 +++++++++++++++++++++++++++++++---------
 include/linux/srcutiny.h | 12 -----------
 include/linux/srcutree.h |  7 -------
 kernel/rcu/srcutree.c    | 24 ++++++++--------------
 4 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 565f60d57484..f0814ffca34b 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,8 +52,6 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #else
 /* Dummy definition for things like notifiers.  Actual use gets link error. */
 struct srcu_struct { };
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
 #endif
 
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
@@ -66,6 +64,20 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+#ifdef CONFIG_NEED_SRCU_NMI_SAFE
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
+#else
+static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+{
+	return __srcu_read_lock(ssp);
+}
+static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+{
+	__srcu_read_unlock(ssp, idx);
+}
+#endif /* CONFIG_NEED_SRCU_NMI_SAFE */
+
 #ifdef CONFIG_SRCU
 void srcu_init(void);
 #else /* #ifdef CONFIG_SRCU */
@@ -106,6 +118,18 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
 
 #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
+#define SRCU_NMI_UNKNOWN	0x0
+#define SRCU_NMI_UNSAFE		0x1
+#define SRCU_NMI_SAFE		0x2
+
+#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_TREE_SRCU)
+void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe);
+#else
+static inline void srcu_check_nmi_safety(struct srcu_struct *ssp,
+					 bool nmi_safe) { }
+#endif
+
+
 /**
  * srcu_dereference_check - fetch SRCU-protected pointer for later dereferencing
  * @p: the pointer to fetch and protect for later dereferencing
@@ -163,6 +187,7 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
+	srcu_check_nmi_safety(ssp, false);
 	retval = __srcu_read_lock(ssp);
 	rcu_lock_acquire(&(ssp)->dep_map);
 	return retval;
@@ -179,10 +204,8 @@ static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp
 {
 	int retval;
 
-	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		retval = __srcu_read_lock_nmisafe(ssp, true);
-	else
-		retval = __srcu_read_lock(ssp);
+	srcu_check_nmi_safety(ssp, true);
+	retval = __srcu_read_lock_nmisafe(ssp);
 	rcu_lock_acquire(&(ssp)->dep_map);
 	return retval;
 }
@@ -193,6 +216,7 @@ srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
 {
 	int retval;
 
+	srcu_check_nmi_safety(ssp, false);
 	retval = __srcu_read_lock(ssp);
 	return retval;
 }
@@ -208,6 +232,7 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
+	srcu_check_nmi_safety(ssp, false);
 	rcu_lock_release(&(ssp)->dep_map);
 	__srcu_read_unlock(ssp, idx);
 }
@@ -223,17 +248,16 @@ static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 	__releases(ssp)
 {
 	WARN_ON_ONCE(idx & ~0x1);
+	srcu_check_nmi_safety(ssp, true);
 	rcu_lock_release(&(ssp)->dep_map);
-	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
-		__srcu_read_unlock_nmisafe(ssp, idx, true);
-	else
-		__srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 }
 
 /* Used by tracing, cannot be traced and cannot call lockdep. */
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
 {
+	srcu_check_nmi_safety(ssp, false);
 	__srcu_read_unlock(ssp, idx);
 }
 
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index efd808a23f8d..a2f620f8c559 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -87,16 +87,4 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[!idx])),
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
 }
-
-static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
-{
-	BUG();
-	return 0;
-}
-
-static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe)
-{
-	BUG();
-}
-
 #endif
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 35ffdedf86cc..c689a81752c9 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -43,10 +43,6 @@ struct srcu_data {
 	struct srcu_struct *ssp;
 };
 
-#define SRCU_NMI_UNKNOWN	0x0
-#define SRCU_NMI_NMI_UNSAFE	0x1
-#define SRCU_NMI_NMI_SAFE	0x2
-
 /*
  * Node in SRCU combining tree, similar in function to rcu_data.
  */
@@ -159,7 +155,4 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
-
 #endif
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 5bf67d997796..f6425076779c 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -631,17 +631,16 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
+#ifdef CONFIG_PROVE_RCU
 /*
  * Check for consistent NMI safety.
  */
-static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
+void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 {
 	int nmi_safe_mask = 1 << nmi_safe;
 	int old_nmi_safe_mask;
 	struct srcu_data *sdp;
 
-	if (!IS_ENABLED(CONFIG_PROVE_RCU))
-		return;
 	/* NMI-unsafe use in NMI is a bad sign */
 	WARN_ON_ONCE(!nmi_safe && in_nmi());
 	sdp = raw_cpu_ptr(ssp->sda);
@@ -652,6 +651,7 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 	}
 	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
 }
+#endif /* CONFIG_PROVE_RCU */
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
@@ -665,7 +665,6 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	srcu_check_nmi_safety(ssp, false);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
@@ -679,7 +678,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
 	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
-	srcu_check_nmi_safety(ssp, false);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -688,7 +686,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  * srcu_struct, but in an NMI-safe manner using RMW atomics.
  * Returns an index that must be passed to the matching srcu_read_unlock().
  */
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 {
 	int idx;
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
@@ -696,8 +694,6 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	atomic_long_inc(&sdp->srcu_lock_count[idx]);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	if (chknmisafe)
-		srcu_check_nmi_safety(ssp, true);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
@@ -707,14 +703,12 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
  * element of the srcu_struct.  Note that this may well be a different
  * CPU than that which was incremented by the corresponding srcu_read_lock().
  */
-void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe)
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
 {
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
 
 	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
 	atomic_long_inc(&sdp->srcu_unlock_count[idx]);
-	if (chknmisafe)
-		srcu_check_nmi_safety(ssp, true);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
 
@@ -1159,7 +1153,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 * side critical section so that the gp sequence can't wrap around in
 	 * the middle.
 	 */
-	idx = __srcu_read_lock_nmisafe(ssp, false);
+	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, 0);
@@ -1192,7 +1186,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp_mynode, s);
-	__srcu_read_unlock_nmisafe(ssp, idx, false);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 	return s;
 }
 
@@ -1496,13 +1490,13 @@ void srcu_barrier(struct srcu_struct *ssp)
 	/* Initial count prevents reaching zero until all CBs are posted. */
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
-	idx = __srcu_read_lock_nmisafe(ssp, false);
+	idx = __srcu_read_lock_nmisafe(ssp);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
-	__srcu_read_unlock_nmisafe(ssp, idx, false);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 
 	/* Remove the initial count, at which point reaching zero can happen. */
 	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-- 
2.25.1

