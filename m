Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A271B60538C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiJSW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJSW6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:58:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140221CCCEE;
        Wed, 19 Oct 2022 15:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CFF661962;
        Wed, 19 Oct 2022 22:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C47C4315F;
        Wed, 19 Oct 2022 22:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220328;
        bh=UBuj76kHE7Oii/4AoWLoto3e/2iEtgpEdWdwXnDVmFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XdE4x2ZJHM7aJD5PUYc0rXTv6uWHLp+BmrOXwgZ/n795GNKG82V1omLedMJT1KxNB
         5hoLRNWWWs3f1jubTVC13kelpwCZWqdWhy6qJn/xf28/L79Awu7xQbUndIWsHEN7sW
         joJn7gFP+lVxKMeRx+SOLREoRFegwJ/JsWjjl1D1CdPgqHpQZJOoII6TtyuE5ANasw
         TD2HurdcYQDgGua0p1LaKqJuJo1G35agZD3Dpp2DrMKPuJKhZofYkvgdFbCkD2VUwp
         EOJKtHDCqgCn0m+/oLE7KGU7E4fNyqmRqSZu0GATBLwFfCiaOgXOEXFloHYoRzo8bH
         dQd8KEm9c5XTw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BEF155C0DA6; Wed, 19 Oct 2022 15:58:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v3 rcu 11/11] srcu: Debug NMI safety even on archs that don't require it
Date:   Wed, 19 Oct 2022 15:58:46 -0700
Message-Id: <20221019225846.2501109-11-paulmck@kernel.org>
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

From: Frederic Weisbecker <frederic@kernel.org>

Currently the NMI safety debugging is only performed on architectures
that don't support NMI-safe this_cpu_inc().

Reorder the code so that other architectures like x86 also detect bad
uses.

[ paulmck: Apply kernel test robot, Stephen Rothwell, and Zqiang feedback. ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcu.h     | 44 +++++++++++++++++++++++++++++++---------
 include/linux/srcutiny.h | 12 -----------
 include/linux/srcutree.h |  7 -------
 kernel/rcu/srcutree.c    | 25 +++++++++--------------
 4 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 565f60d574847..f0814ffca34bb 100644
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
index f890301f123df..f3a4d65b91efd 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -89,16 +89,4 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_idx)),
 		 data_race(READ_ONCE(ssp->srcu_idx_max)));
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
index 35ffdedf86ccb..c689a81752c9a 100644
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
index 272830a87e566..ca4b5dcec675b 100644
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
@@ -652,6 +651,8 @@ static void srcu_check_nmi_safety(struct srcu_struct *ssp, bool nmi_safe)
 	}
 	WARN_ONCE(old_nmi_safe_mask != nmi_safe_mask, "CPU %d old state %d new state %d\n", sdp->cpu, old_nmi_safe_mask, nmi_safe_mask);
 }
+EXPORT_SYMBOL_GPL(srcu_check_nmi_safety);
+#endif /* CONFIG_PROVE_RCU */
 
 /*
  * Counts the new reader in the appropriate per-CPU element of the
@@ -665,7 +666,6 @@ int __srcu_read_lock(struct srcu_struct *ssp)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
 	smp_mb(); /* B */  /* Avoid leaking the critical section. */
-	srcu_check_nmi_safety(ssp, false);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
@@ -679,7 +679,6 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 {
 	smp_mb(); /* C */  /* Avoid leaking the critical section. */
 	this_cpu_inc(ssp->sda->srcu_unlock_count[idx].counter);
-	srcu_check_nmi_safety(ssp, false);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
@@ -690,7 +689,7 @@ EXPORT_SYMBOL_GPL(__srcu_read_unlock);
  * srcu_struct, but in an NMI-safe manner using RMW atomics.
  * Returns an index that must be passed to the matching srcu_read_unlock().
  */
-int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
 {
 	int idx;
 	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
@@ -698,8 +697,6 @@ int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe)
 	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
 	atomic_long_inc(&sdp->srcu_lock_count[idx]);
 	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
-	if (chknmisafe)
-		srcu_check_nmi_safety(ssp, true);
 	return idx;
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
@@ -709,14 +706,12 @@ EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
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
 
@@ -1163,7 +1158,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 * SRCU read-side critical section so that the grace-period
 	 * sequence number cannot wrap around in the meantime.
 	 */
-	idx = __srcu_read_lock_nmisafe(ssp, false);
+	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, 0);
@@ -1196,7 +1191,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp_mynode, s);
-	__srcu_read_unlock_nmisafe(ssp, idx, false);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 	return s;
 }
 
@@ -1500,13 +1495,13 @@ void srcu_barrier(struct srcu_struct *ssp)
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
2.31.1.189.g2e36527f23

