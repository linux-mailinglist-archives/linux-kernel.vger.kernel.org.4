Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B35C003F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiIUOrA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 10:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIUOqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 10:46:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458997509;
        Wed, 21 Sep 2022 07:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3423DB82022;
        Wed, 21 Sep 2022 14:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FD2C433D7;
        Wed, 21 Sep 2022 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663771600;
        bh=1co+xN/qQaemr8j3WZCMmCO62oK3HgxTXvvOO8SJiVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5d4Lfquhaj0veHZmWzuKSxD5FfEEmKjCLOxdg7o32IezS3e4zWEA4wx0Oqvr9TMw
         oI1bSXoBScKTwJKbeo1Mq9VLMNWP+d0yzU+9/PMHAH26cWh4VWBhGGNVFRmqsqsZvI
         KCnE1dGWXSvDn4PPl7g+/9LxEJcXLpb7o/0KXf87z1KfSgRL+E9i1NXPpYP67Ui2ln
         M8kKEKeh9sOTKCah1W3tbjEkVzOFE0hv109PZzdFbOiycRcudj1XWCBINm6+MdZc1W
         WWtDk0of/1jXhQMH1h2iBNFlZbLmmGi/xjcsjNSuErpl7lUo4OomI6JtWN5Eb32Xwv
         VvDezy3AP4+vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79A3C5C092A; Wed, 21 Sep 2022 07:46:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC rcu 2/4] srcu: Create and srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()
Date:   Wed, 21 Sep 2022 07:46:36 -0700
Message-Id: <20220921144638.1201361-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
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

This commit creates a pair of new srcu_read_lock_nmisafe() and
srcu_read_unlock_nmisafe() functions, which allow SRCU readers in both
NMI handlers and in process and IRQ context.  It is bad practice to mix
the existing and the new _nmisafe() primitives on the same srcu_struct
structure.  Use one set or the other, not both.

[ paulmck: Apply kernel test robot feedback. ]

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
---
 include/linux/srcu.h     | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/srcutiny.h | 11 +++++++++++
 include/linux/srcutree.h |  3 +++
 kernel/rcu/Kconfig       |  3 +++
 kernel/rcu/rcutorture.c  | 11 +++++++++--
 kernel/rcu/srcutree.c    | 39 +++++++++++++++++++++++++++++++++++----
 6 files changed, 98 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 01226e4d960a..aa9406e88fb8 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -166,6 +166,25 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
 	return retval;
 }
 
+/**
+ * srcu_read_lock_nmisafe - register a new reader for an SRCU-protected structure.
+ * @ssp: srcu_struct in which to register the new reader.
+ *
+ * Enter an SRCU read-side critical section, but in an NMI-safe manner.
+ * See srcu_read_lock() for more information.
+ */
+static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
+{
+	int retval;
+
+	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		retval = __srcu_read_lock_nmisafe(ssp);
+	else
+		retval = __srcu_read_lock(ssp);
+	rcu_lock_acquire(&(ssp)->dep_map);
+	return retval;
+}
+
 /* Used by tracing, cannot be traced and cannot invoke lockdep. */
 static inline notrace int
 srcu_read_lock_notrace(struct srcu_struct *ssp) __acquires(ssp)
@@ -191,6 +210,24 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	__srcu_read_unlock(ssp, idx);
 }
 
+/**
+ * srcu_read_unlock_nmisafe - unregister a old reader from an SRCU-protected structure.
+ * @ssp: srcu_struct in which to unregister the old reader.
+ * @idx: return value from corresponding srcu_read_lock().
+ *
+ * Exit an SRCU read-side critical section, but in an NMI-safe manner.
+ */
+static inline void srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+	__releases(ssp)
+{
+	WARN_ON_ONCE(idx & ~0x1);
+	rcu_lock_release(&(ssp)->dep_map);
+	if (IS_ENABLED(CONFIG_NEED_SRCU_NMI_SAFE))
+		__srcu_read_unlock_nmisafe(ssp, idx);
+	else
+		__srcu_read_unlock(ssp, idx);
+}
+
 /* Used by tracing, cannot be traced and cannot call lockdep. */
 static inline notrace void
 srcu_read_unlock_notrace(struct srcu_struct *ssp, int idx) __releases(ssp)
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 5aa5e0faf6a1..278331bd7766 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -90,4 +90,15 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_idx_max)));
 }
 
+static inline int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+{
+	BUG();
+	return 0;
+}
+
+static inline void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+{
+	BUG();
+}
+
 #endif
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 0c4eca07d78d..d45dd507f4a5 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -154,4 +154,7 @@ void synchronize_srcu_expedited(struct srcu_struct *ssp);
 void srcu_barrier(struct srcu_struct *ssp);
 void srcu_torture_stats_print(struct srcu_struct *ssp, char *tt, char *tf);
 
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
+
 #endif
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index d471d22a5e21..f53ad63b2bc6 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -72,6 +72,9 @@ config TREE_SRCU
 	help
 	  This option selects the full-fledged version of SRCU.
 
+config NEED_SRCU_NMI_SAFE
+	def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
+
 config TASKS_RCU_GENERIC
 	def_bool TASKS_RCU || TASKS_RUDE_RCU || TASKS_TRACE_RCU
 	select SRCU
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9ad5301385a4..684e24f12a79 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -623,10 +623,14 @@ static struct rcu_torture_ops rcu_busted_ops = {
 DEFINE_STATIC_SRCU(srcu_ctl);
 static struct srcu_struct srcu_ctld;
 static struct srcu_struct *srcu_ctlp = &srcu_ctl;
+static struct rcu_torture_ops srcud_ops;
 
 static int srcu_torture_read_lock(void) __acquires(srcu_ctlp)
 {
-	return srcu_read_lock(srcu_ctlp);
+	if (cur_ops == &srcud_ops)
+		return srcu_read_lock_nmisafe(srcu_ctlp);
+	else
+		return srcu_read_lock(srcu_ctlp);
 }
 
 static void
@@ -650,7 +654,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
 static void srcu_torture_read_unlock(int idx) __releases(srcu_ctlp)
 {
-	srcu_read_unlock(srcu_ctlp, idx);
+	if (cur_ops == &srcud_ops)
+		srcu_read_unlock_nmisafe(srcu_ctlp, idx);
+	else
+		srcu_read_unlock(srcu_ctlp, idx);
 }
 
 static int torture_srcu_read_lock_held(void)
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6fd0665f4d1f..f5b1485e79aa 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -654,6 +654,37 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
+/*
+ * Counts the new reader in the appropriate per-CPU element of the
+ * srcu_struct, but in an NMI-safe manner using RMW atomics.
+ * Returns an index that must be passed to the matching srcu_read_unlock().
+ */
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp)
+{
+	int idx;
+	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+
+	idx = READ_ONCE(ssp->srcu_idx) & 0x1;
+	atomic_long_inc(&sdp->srcu_lock_count[idx]);
+	smp_mb__after_atomic(); /* B */  /* Avoid leaking the critical section. */
+	return idx;
+}
+EXPORT_SYMBOL_GPL(__srcu_read_lock_nmisafe);
+
+/*
+ * Removes the count for the old reader from the appropriate per-CPU
+ * element of the srcu_struct.  Note that this may well be a different
+ * CPU than that which was incremented by the corresponding srcu_read_lock().
+ */
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx)
+{
+	struct srcu_data *sdp = raw_cpu_ptr(ssp->sda);
+
+	smp_mb__before_atomic(); /* C */  /* Avoid leaking the critical section. */
+	atomic_long_inc(&sdp->srcu_unlock_count[idx]);
+}
+EXPORT_SYMBOL_GPL(__srcu_read_unlock_nmisafe);
+
 /*
  * Start an SRCU grace period.
  */
@@ -1090,7 +1121,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	int ss_state;
 
 	check_init_srcu_struct(ssp);
-	idx = srcu_read_lock(ssp);
+	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_CALL)
 		sdp = per_cpu_ptr(ssp->sda, 0);
@@ -1123,7 +1154,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
 		srcu_funnel_exp_start(ssp, sdp_mynode, s);
-	srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 	return s;
 }
 
@@ -1427,13 +1458,13 @@ void srcu_barrier(struct srcu_struct *ssp)
 	/* Initial count prevents reaching zero until all CBs are posted. */
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
-	idx = srcu_read_lock(ssp);
+	idx = __srcu_read_lock_nmisafe(ssp);
 	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
 	else
 		for_each_possible_cpu(cpu)
 			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
-	srcu_read_unlock(ssp, idx);
+	__srcu_read_unlock_nmisafe(ssp, idx);
 
 	/* Remove the initial count, at which point reaching zero can happen. */
 	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-- 
2.31.1.189.g2e36527f23

