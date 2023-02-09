Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614F6690487
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBIKWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIKWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:22:33 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935DF18B1A;
        Thu,  9 Feb 2023 02:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675938151; x=1707474151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1kt6/qxSHntuB8D77RMGIqs981Q8ssvwj2WUj2znR1A=;
  b=M5p3BqMcIs3Inyy8pjRaorK9cq43cAt1K0vbrJEGHi4P3mFQ4ewdoDej
   gBIWgKX1G9mOQnofib22JdTJr5Q1LtmP+xRmMobGG5ZtwyyEsmarsJfgd
   7fRNI7Rb1XoQwio/p1rpONWQZeUIbcd+NkSLg7Yt3EvhNm59Qpr73QoEv
   OhLASjnFV1mxz1dJfQG0ffSvMoxMN7xHvtk1ejxcoAX9M15XiFXalbLNV
   J9ghZI0wvlOiXx0r4gmSmTB77fj1wT1r9yqebISA1nfnXxlR3Lw0BJnvZ
   RxMmoE/MwS2jwZM9mjRkHWTjPOCjZe+TpMRFyvJ+XQIpmwhXlssAV+BZ9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309718548"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="309718548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 02:22:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="699995766"
X-IronPort-AV: E=Sophos;i="5.97,283,1669104000"; 
   d="scan'208";a="699995766"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 02:22:27 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, qiuxu.zhuo@intel.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Keeping rcu-related kthreads running on housekeeping CPUS
Date:   Thu,  9 Feb 2023 18:27:30 +0800
Message-Id: <20230209102730.974465-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernels built with CONFIG_NO_HZ_FULL=y and CONFIG_RCU_NOCB_CPU=y,
when passing cpulist to "isolcpus=", "nohz_full=" and "rcu_nocbs="
bootparams, after system starting, the rcu-related kthreads(include
rcu_gp, rcuog*, rcuop* kthreads etc) will running on housekeeping
CPUs, but for cpulist contains CPU0, the result will deferent, these
rcu-related kthreads will be restricted to running on CPU0.

Although invoke kthread_create() to spwan rcu-related kthreads and
when it's starting, invoke set_cpus_allowed_ptr() to allowed cpumaks
is housekeeping_cpumask(HK_TYPE_KTHREAD), but due to these rcu-related
kthreads are created before starting other CPUS, that is to say, at
this time, only CPU0 is online, when these rcu-related kthreads running
and set allowed cpumaks is housekeeping cpumask, if find that only CPU0
is online and CPU0 exists in "isolcpus=", "nohz_full=" and "rcu_nocbs="
bootparams, invoke set_cpus_allowed_ptr() will return error.

set_cpus_allowed_ptr()
 ->__set_cpus_allowed_ptr()
   ->__set_cpus_allowed_ptr_locked
     {
                bool kthread = p->flags & PF_KTHREAD;
                ....
                if (kthread || is_migration_disabled(p))
                        cpu_valid_mask = cpu_online_mask;
                ....
                dest_cpu = cpumask_any_and_distribute(cpu_valid_mask, ctx->new_mask);
                if (dest_cpu >= nr_cpu_ids) {
                        ret = -EINVAL;
                        goto out;
                }
                ....
     }

At this time, only CPU0 is set in the cpu_online_mask, the ctx->new_mask
is housekeeping cpumask and not contains CPU0, this will result dest_cpu
is illegal cpu value, the set_cpus_allowed_ptr() will return -EINVAL and
failed to set housekeeping cpumask.

This commit therefore add additional cpus_allowed_ptr() call in CPU hotplug
path. and reset the CPU affinity of rcuboost, rcuog, rcuop kthreads after
all other CPUs are online.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---

 runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
 bootparams="console=ttyS0 isolcpus=0,1 nohz_full=0,1 rcu_nocbs=0,1" -d

 root@qemux86-64:~# ps -eo pid,psr,comm | grep rcu
    3   0 rcu_gp
    6   0 kworker/0:0-rcu_gp
   12   0 rcu_tasks_kthread
   13   0 rcu_tasks_rude_kthread
   14   0 rcu_tasks_trace_kthread
   16   0 rcu_preempt
   17   0 rcuog/0
   18   0 rcuop/0
   19   2 rcub/0
   20   0 rcu_exp_gp_kthread_worker
   21   0 rcu_exp_par_gp_kthread_worker
   29   0 rcuop/1
   35   0 rcuog/2
   36   0 rcuop/2
   42   2 rcuop/3
 root@qemux86-64:~#
 root@qemux86-64:~#
 root@qemux86-64:~#
 root@qemux86-64:~# cat /proc/16/status | grep Cpus
 Cpus_allowed:   1
 Cpus_allowed_list:      0

 Applay this patch:
 
 root@qemux86-64:/# ps -eo pid,psr,comm | grep rcu
    3   0 rcu_gp
    6   0 kworker/0:0-rcu_gp
   12   3 rcu_tasks_kthread
   13   2 rcu_tasks_rude_kthread
   14   3 rcu_tasks_trace_kthread
   16   3 rcu_preempt
   17   3 rcuog/0
   18   2 rcuop/0
   19   2 rcub/0
   20   3 rcu_exp_gp_kthread_worker
   21   0 rcu_exp_par_gp_kthread_worker
   29   3 rcuop/1
   35   0 rcuog/2
   36   0 rcuop/2
   42   2 rcuop/3
 root@qemux86-64:/# cat /proc/16/status | grep Cpus
 Cpus_allowed:   c
 Cpus_allowed_list:      2-3

 kernel/rcu/rcu.h         |  4 +++
 kernel/rcu/tasks.h       | 26 +++++++++++++----
 kernel/rcu/tree.c        | 61 +++++++++++++++++++++++++++++++++++++---
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_nocb.h   | 18 +++++++++++-
 kernel/rcu/tree_plugin.h |  9 ------
 6 files changed, 99 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index a3adcf9a9919..1cad82e93304 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -503,8 +503,10 @@ void rcu_async_relax(void);
 void rcupdate_announce_bootup_oddness(void);
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
+void rcu_tasks_generic_setaffinity(int cpu);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void show_rcu_tasks_gp_kthreads(void) {}
+void rcu_tasks_generic_setaffinity(int cpu) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
@@ -597,6 +599,7 @@ static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 static inline void rcu_fwd_progress_check(unsigned long j) { }
 static inline void rcu_gp_slow_register(atomic_t *rgssp) { }
 static inline void rcu_gp_slow_unregister(atomic_t *rgssp) { }
+void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 bool rcu_dynticks_zero_in_eqs(int cpu, int *vp);
 unsigned long rcu_get_gp_seq(void);
@@ -607,6 +610,7 @@ void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
 void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
+void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing);
 extern struct workqueue_struct *rcu_gp_wq;
 #ifdef CONFIG_RCU_EXP_KTHREAD
 extern struct kthread_worker *rcu_exp_gp_kworker;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index baf7ec178155..cebc02198ef7 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -545,10 +545,6 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 {
 	struct rcu_tasks *rtp = arg;
 
-	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_TYPE_RCU);
-	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
-
 	/*
 	 * Each pass through the following loop makes one check for
 	 * newly arrived callbacks, and, if there are some, waits for
@@ -586,9 +582,11 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 {
 	struct task_struct *t;
 
-	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
+	t = kthread_create(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
+	WRITE_ONCE(rtp->kthread_ptr, t);
+	wake_up_process(t);
 	smp_mb(); /* Ensure others see full kthread. */
 }
 
@@ -1969,6 +1967,24 @@ void __init rcu_init_tasks_generic(void)
 	rcu_tasks_initiate_self_tests();
 }
 
+void rcu_tasks_generic_setaffinity(int cpu)
+{
+#ifdef CONFIG_TASKS_RCU
+	if (rcu_tasks.kthread_ptr)
+		rcu_kthread_setaffinity(rcu_tasks.kthread_ptr, cpu);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	if (rcu_tasks_rude.kthread_ptr)
+		rcu_kthread_setaffinity(rcu_tasks_rude.kthread_ptr, cpu);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	if (rcu_tasks_trace.kthread_ptr)
+		rcu_kthread_setaffinity(rcu_tasks_trace.kthread_ptr, cpu);
+#endif
+}
+
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee27a03d7576..d1575d74346e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,6 +154,8 @@ static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
 static bool rcu_init_invoked(void);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
+static void rcu_exp_gp_kworkers_setaffinity(int cpu);
+static void rcu_nocb_kthread_setaffinity(int cpu, int outgoing);
 
 /*
  * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
@@ -1781,7 +1783,6 @@ static noinline void rcu_gp_cleanup(void)
  */
 static int __noreturn rcu_gp_kthread(void *unused)
 {
-	rcu_bind_gp_kthread();
 	for (;;) {
 
 		/* Handle grace-period start. */
@@ -4297,6 +4298,30 @@ static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
 	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
 }
 
+void rcu_kthread_setaffinity(struct task_struct *tsk, int outgoing)
+{
+	cpumask_var_t mask;
+
+	if (!tsk)
+		return;
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return;
+	cpumask_copy(mask, housekeeping_cpumask(HK_TYPE_RCU));
+	if (outgoing >= 0 && cpumask_test_cpu(outgoing, mask))
+		cpumask_clear_cpu(outgoing, mask);
+	cpumask_and(mask, cpu_online_mask, mask);
+	if (cpumask_empty(mask))
+		cpumask_copy(mask, cpu_possible_mask);
+	set_cpus_allowed_ptr(tsk, mask);
+	free_cpumask_var(mask);
+}
+
+static void rcu_gp_kthread_setaffinity(int cpu)
+{
+	if (rcu_state.gp_kthread)
+		rcu_kthread_setaffinity(rcu_state.gp_kthread, cpu);
+}
+
 /*
  * Near the end of the CPU-online process.  Pretty much all services
  * enabled, and the CPU is now very much alive.
@@ -4316,7 +4341,10 @@ int rcutree_online_cpu(unsigned int cpu)
 		return 0; /* Too early in boot for scheduler work. */
 	sync_sched_exp_online_cleanup(cpu);
 	rcutree_affinity_setting(cpu, -1);
-
+	rcu_gp_kthread_setaffinity(-1);
+	rcu_nocb_kthread_setaffinity(cpu, -1);
+	rcu_tasks_generic_setaffinity(-1);
+	rcu_exp_gp_kworkers_setaffinity(-1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
@@ -4339,7 +4367,10 @@ int rcutree_offline_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
-
+	rcu_gp_kthread_setaffinity(cpu);
+	rcu_nocb_kthread_setaffinity(cpu, cpu);
+	rcu_tasks_generic_setaffinity(cpu);
+	rcu_exp_gp_kworkers_setaffinity(cpu);
 	// nohz_full CPUs need the tick for stop-machine to work quickly
 	tick_dep_set(TICK_DEP_BIT_RCU);
 	return 0;
@@ -4550,6 +4581,14 @@ static void __init rcu_start_exp_gp_kworkers(void)
 				   &param);
 }
 
+static void rcu_exp_gp_kworkers_setaffinity(int cpu)
+{
+	if (rcu_exp_gp_kworker)
+		rcu_kthread_setaffinity(rcu_exp_gp_kworker->task, cpu);
+	if (rcu_exp_par_gp_kworker)
+		rcu_kthread_setaffinity(rcu_exp_par_gp_kworker->task, cpu);
+}
+
 static inline void rcu_alloc_par_gp_wq(void)
 {
 }
@@ -4559,7 +4598,9 @@ struct workqueue_struct *rcu_par_gp_wq;
 static void __init rcu_start_exp_gp_kworkers(void)
 {
 }
-
+static void rcu_exp_gp_kworkers_setaffinity(int cpu)
+{
+}
 static inline void rcu_alloc_par_gp_wq(void)
 {
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
@@ -4609,6 +4650,18 @@ static int __init rcu_spawn_gp_kthread(void)
 }
 early_initcall(rcu_spawn_gp_kthread);
 
+static int __init rcu_boost_resetaffinity(void)
+{
+	struct rcu_node *rnp;
+	int cpu;
+
+	rcu_for_each_leaf_node(rnp)
+		rcu_boost_kthread_setaffinity(rnp, -1);
+	for_each_possible_cpu(cpu)
+		rcu_nocb_kthread_setaffinity(cpu, -1);
+	return 0;
+}
+core_initcall(rcu_boost_resetaffinity);
 /*
  * This function is invoked towards the end of the scheduler's
  * initialization process.  Before this is called, the idle task might
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..391e3fae4ff5 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -495,7 +495,6 @@ do {								\
 #define rcu_nocb_lock_irqsave(rdp, flags) local_irq_save(flags)
 #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
 
-static void rcu_bind_gp_kthread(void);
 static bool rcu_nohz_full_cpu(void);
 
 /* Forward declarations for tree_stall.h */
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index f2280616f9d5..a9cd07ccf959 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1494,6 +1494,20 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
+static void rcu_nocb_kthread_setaffinity(int cpu, int outgoing)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_data *rdp_gp;
+
+	if (rdp->nocb_cb_kthread)
+		rcu_kthread_setaffinity(rdp->nocb_cb_kthread, outgoing);
+	rdp_gp = rdp->nocb_gp_rdp;
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
+	if (rdp_gp->nocb_gp_kthread)
+		rcu_kthread_setaffinity(rdp_gp->nocb_gp_kthread, outgoing);
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+}
+
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
 static int rcu_nocb_gp_stride = -1;
 module_param(rcu_nocb_gp_stride, int, 0444);
@@ -1754,7 +1768,9 @@ static bool do_nocb_deferred_wakeup(struct rcu_data *rdp)
 static void rcu_spawn_cpu_nocb_kthread(int cpu)
 {
 }
-
+static void rcu_nocb_kthread_setaffinity(int cpu, int outgoing)
+{
+}
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
 }
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7b0fe741a088..fdde71ebb83e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1294,12 +1294,3 @@ static bool rcu_nohz_full_cpu(void)
 	return false;
 }
 
-/*
- * Bind the RCU grace-period kthreads to the housekeeping CPU.
- */
-static void rcu_bind_gp_kthread(void)
-{
-	if (!tick_nohz_full_enabled())
-		return;
-	housekeeping_affine(current, HK_TYPE_RCU);
-}
-- 
2.25.1

