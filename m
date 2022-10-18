Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8A6031C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJRRum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJRRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3B0BD06E;
        Tue, 18 Oct 2022 10:50:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E563861698;
        Tue, 18 Oct 2022 17:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E1CC433D7;
        Tue, 18 Oct 2022 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666115435;
        bh=s0AtPCxvwT/SYc2M4XT+07XI3Fxh92Yc/HIv16ZnFNw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dAr20U50dwi5uzOcYbf33SpSmuU8Rb33ooA0Jug3IZt4EEYTtnMep3V4fPXh7+PyA
         Z/p2NhqD+fXtvTF8lhnaHOpf39AkXP5MDaRLFNJHPweYPjqobR1iEcJNWtNNqa2nEP
         6ua8G3eOfUny9ISLlsR5xcMfJVsmGLM+D1hsL+D6cBJnY0L/ggYfLa4EVxUqCHLVHH
         /36pQp2M7IgZ3IYz0wn+/Owo6SDNEQEmAnS7FTFPkbvxZk1uNWlZmS6SnAcw6F/kIW
         2E1z50/DMqMnM9b16vazcXik/l8CFXYjJb3aKwwXTHYO+ixLB8r9toeeJpwd2J2RCH
         tUeCV99Ok1LVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EAF525C0528; Tue, 18 Oct 2022 10:50:34 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:50:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Zqiang <qiang1.zhang@intel.com>, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] srcu: Export srcu_check_nmi_safety() to modules
Message-ID: <20221018175034.GU5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221018013906.3890007-1-qiang1.zhang@intel.com>
 <20221018104533.GC1166572@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018104533.GC1166572@lothringen>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 12:45:33PM +0200, Frederic Weisbecker wrote:
> On Tue, Oct 18, 2022 at 09:39:06AM +0800, Zqiang wrote:
> > When enable CONFIG_PROVE_RCU and built modules, the following
> > error appear:
> > 
> > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcutorture.ko] undefined!
> > ERROR: modpost: "srcu_check_nmi_safety" [kernel/rcu/rcuscale.ko] undefined!
> > 
> > This commit fix it by exporting the srcu_check_nmi_safety().
> > 
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> 
> Paul, whichever way you prefer, editing the commit or adding this
> one on top.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you all!

This is what I currently have, folded into Frederic's original.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 88a6ff77b433f1f60af01fc94430eaad448ca491
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Thu Oct 13 19:22:44 2022 +0200

    srcu: Debug NMI safety even on archs that don't require it
    
    Currently the NMI safety debugging is only performed on architectures
    that don't support NMI-safe this_cpu_inc().
    
    Reorder the code so that other architectures like x86 also detect bad
    uses.
    
    [ paulmck: Apply kernel test robot, Stephen Rothwell, and Zqiang feedback. ]
    
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

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
index efd808a23f8d8..a2f620f8c5592 100644
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
