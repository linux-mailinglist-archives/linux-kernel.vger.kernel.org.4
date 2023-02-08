Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61EC68E69A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjBHD3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjBHD3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:29:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1E11670;
        Tue,  7 Feb 2023 19:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675826946; x=1707362946;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ufRhdl8/azvaiz+dPp7YwCq28sBNdS8ODzww2em55rI=;
  b=U5B+qPslz04n5hCJraREk0++MkmT6Rmd+ZKAMwkPohA6SXyZJjjwiFYc
   J6SiesVp4oCvAMGAcdU372NlsHA52ShMAS0dYLoaDLz45PSp5XAM8XMLs
   wH7heIbhndvGUMS6QumR6I90usdhGJGly6bGDSvwW1/AK8dZP6of7/CMs
   xCxKAUQcpy1KIGS6ri8dPhThb+ttY113Yhiax8vd0jMuHaVSMZ+vz4koV
   IDJficzb5ilMY7MvTFzjIBI3kwDfrlKQByBEIrocSLBpaD7gQRNHwLlDr
   5pR4wMxf1rfoZpn40KkBNxH3XxOfoGN92HdMgI7HV8E+Xr6uuMLWeK5a1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="329723669"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="329723669"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 19:29:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809787210"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="809787210"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 19:29:04 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix bind rcu related kthreads to housekeeping CPUs
Date:   Wed,  8 Feb 2023 11:34:08 +0800
Message-Id: <20230208033408.3997610-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernels built with CONFIG_NO_HZ_FULL=y and CONFIG_RCU_NOCB_CPU=y,
run the following tests:

runqemu kvm slirp nographic qemuparams="-m 1024 -smp 4"
bootparams="console=ttyS0 isolcpus=0,1 nohz_full=0,1 rcu_nocbs=0,1"

root@qemux86-64:~# ps -ef | grep "rcu_preempt" | grep -v grep | awk '{print $2}'
15
root@qemux86-64:~# ps -ef | grep "rcuop/0" | grep -v grep | awk '{print $2}'
17
root@qemux86-64:~# taskset -p 15
pid 15's current affinity mask: 1
root@qemux86-64:~# taskset -p 17
pid 17's current affinity mask: 1

The affinity of these rcu related kthreads is not set to housekeeping
cpumask, even if called rcu_bind_gp_kthread() when the rcu related
kthread starts.

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

Due to these rcu related kthreads be created before bringup other CPUS,
so when they running and set hosekeeping cpus affinity, found that only CPU0
is online at this time and CPU0 is set to no_hz_full CPU, the ctx->new_mask
not contain CPU0 and this will cause dest_cpu in the above code snippet to be
an illegal value and return directly, ultimately, these rcu related kthreads
failed to bind housekeeping CPUS.

This commit therefore rebind these rcu related kthreads to housekeeping CPUs
after the kernel boot sequence ends, at this point all CPUs are online.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h       |  7 +++++--
 kernel/rcu/tree.c        |  7 ++++++-
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_nocb.h   | 13 ++++++++++++-
 kernel/rcu/tree_plugin.h |  9 ---------
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index baf7ec178155..8b3530cca291 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -544,9 +544,8 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
 	struct rcu_tasks *rtp = arg;
+	bool rcu_setaffinity_setup = false;
 
-	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
-	housekeeping_affine(current, HK_TYPE_RCU);
 	WRITE_ONCE(rtp->kthread_ptr, current); // Let GPs start!
 
 	/*
@@ -556,6 +555,10 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
+		if (!rcu_setaffinity_setup && rcu_inkernel_boot_has_ended()) {
+			set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_RCU));
+			rcu_setaffinity_setup = true;
+		}
 		// Wait for one grace period and invoke any callbacks
 		// that are ready.
 		rcu_tasks_one_gp(rtp, false);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ee27a03d7576..0ac47a773e13 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1781,8 +1781,13 @@ static noinline void rcu_gp_cleanup(void)
  */
 static int __noreturn rcu_gp_kthread(void *unused)
 {
-	rcu_bind_gp_kthread();
+	bool rcu_setaffinity_setup = false;
+
 	for (;;) {
+		if (!rcu_setaffinity_setup && rcu_inkernel_boot_has_ended()) {
+			set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_RCU));
+			rcu_setaffinity_setup = true;
+		}
 
 		/* Handle grace-period start. */
 		for (;;) {
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
index f2280616f9d5..254d0f631d57 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -894,8 +894,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 static int rcu_nocb_gp_kthread(void *arg)
 {
 	struct rcu_data *rdp = arg;
+	bool rcu_setaffinity_setup = false;
 
 	for (;;) {
+		if (!rcu_setaffinity_setup && rcu_inkernel_boot_has_ended()) {
+			set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_RCU));
+			rcu_setaffinity_setup = true;
+		}
+
 		WRITE_ONCE(rdp->nocb_gp_loops, rdp->nocb_gp_loops + 1);
 		nocb_gp_wait(rdp);
 		cond_resched_tasks_rcu_qs();
@@ -1002,10 +1008,15 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 static int rcu_nocb_cb_kthread(void *arg)
 {
 	struct rcu_data *rdp = arg;
-
+	bool rcu_setaffinity_setup = false;
 	// Each pass through this loop does one callback batch, and,
 	// if there are no more ready callbacks, waits for them.
 	for (;;) {
+		if (!rcu_setaffinity_setup && rcu_inkernel_boot_has_ended()) {
+			set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_TYPE_RCU));
+			rcu_setaffinity_setup = true;
+		}
+
 		nocb_cb_wait(rdp);
 		cond_resched_tasks_rcu_qs();
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

