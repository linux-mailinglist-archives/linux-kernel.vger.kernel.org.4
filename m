Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D05EFCB1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbiI2SHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 14:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbiI2SHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 14:07:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE361BA39E;
        Thu, 29 Sep 2022 11:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901DD6211B;
        Thu, 29 Sep 2022 18:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9D2C433C1;
        Thu, 29 Sep 2022 18:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664474853;
        bh=2Jh80GWNwRkfnWA+99BLc3ZhAnhYInD3Tgge0HK/BRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAhjt8p0QLmFcXtOQH8EVQq1GN99sejmKu6PRmi4jipCjYuRYPEySP08WkVDFAOzJ
         aG4gueKz+hY6yIV4PH+noV88YC9OhavDkNbp6Y+BnaNVwA/GarN63G/YeUqJrPriBk
         FagD5ZwDKGSlEy3Tu13OOCuY7ue6vF03dbl5SaiYbKi8UKKNpri8yqatueHX178UUo
         sDHwjrchteyMpiPz74MeQtYudfJGfpxkD6km1acKs6CmMQyYqnWXf+EPTSrVRgupPj
         oNsBWDC6PJ5XAhhev0MrfnmmpaoOesKwrpulhd+0HmyhbW87stJeey+4VLhXedm5qT
         6/unpMHPGkAAw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AC1045C0BE3; Thu, 29 Sep 2022 11:07:32 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC v2 rcu 2/8] srcu: Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe()
Date:   Thu, 29 Sep 2022 11:07:25 -0700
Message-Id: <20220929180731.2875722-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
References: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On strict load-store architectures, the use of this_cpu_inc() by
srcu_read_lock() and srcu_read_unlock() is not NMI-safe in TREE SRCU.
To see this suppose that an NMI arrives in the middle of srcu_read_lock(),
just after it has read ->srcu_lock_count, but before it has written
the incremented value back to memory.  If that NMI handler also does
srcu_read_lock() and srcu_read_lock() on that same srcu_struct structure,
then upon return from that NMI handler, the interrupted srcu_read_lock()
will overwrite the NMI handler's update to ->srcu_lock_count, but
leave unchanged the NMI handler's update by srcu_read_unlock() to
->srcu_unlock_count.

This can result in a too-short SRCU grace period, which can in turn
result in arbitrary memory corruption.

If the NMI handler instead interrupts the srcu_read_unlock(), this
can result in eternal SRCU grace periods, which is not much better.

This commit therefore creates a pair of new srcu_read_lock_nmisafe()
and srcu_read_unlock_nmisafe() functions, which allow SRCU readers in
both NMI handlers and in process and IRQ context.  It is bad practice
to mix the existing and the new _nmisafe() primitives on the same
srcu_struct structure.  Use one set or the other, not both.

Just to underline that "bad practice" point, using srcu_read_lock() at
process level and srcu_read_lock_nmisafe() in your NMI handler will not,
repeat NOT, work.  If you do not immediately understand why this is the
case, please review the earlier paragraphs in this commit log.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply feedback from Randy Dunlap. ]

Link: https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>

---
 include/linux/srcu.h     | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/srcutiny.h | 11 +++++++++++
 include/linux/srcutree.h |  3 +++
 kernel/rcu/Kconfig       |  3 +++
 kernel/rcu/rcutorture.c  | 11 +++++++++--
 kernel/rcu/srcutree.c    | 39 +++++++++++++++++++++++++++++++++++----
 6 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 01226e4d960a..2cc8321c0c86 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -52,6 +52,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
 #else
 /* Dummy definition for things like notifiers.  Actual use gets link error. */
 struct srcu_struct { };
+int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
+void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
 #endif
 
 void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,
@@ -166,6 +168,25 @@ static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
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
@@ -191,6 +212,24 @@ static inline void srcu_read_unlock(struct srcu_struct *ssp, int idx)
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
index 6cfaa0a9a9b9..bccfa18b1b15 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -88,4 +88,15 @@ static inline void srcu_torture_stats_print(struct srcu_struct *ssp,
 		 data_race(READ_ONCE(ssp->srcu_lock_nesting[idx])));
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
index d8e1b270a065..7f9703b88cae 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -574,10 +574,14 @@ static struct rcu_torture_ops rcu_busted_ops = {
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
@@ -601,7 +605,10 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 
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

