Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3265D1AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjADLmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbjADLmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:42:02 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037E1DF28;
        Wed,  4 Jan 2023 03:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672832520; x=1704368520;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BM7pbgPVzjPPxD/bPuZCVEfKxo+O1hcP3qxZcuaFeEQ=;
  b=oK4c/l6WSuiq8jrRRli2R03OK4UR4kwP/UBSyhxJpXFzOWuvIx1uyTju
   Va3Y2Ihmm0MZ4gBgMXPe8ZQ4f0RYkf++ekdhGjshnUSdpP0qLAryQgCwg
   S78ZYRkNtSsncUz3cw2Bmx68ut6XM1RgQ+oMa3N5kThklYPpn0+NH0e1n
   oL5jdChavkehWRwBRJlqWTRvr2HUyErHlxiLo6rgBzLB0mQP4DZWL7xk1
   42YDqnnjdOFsl6WyAqZAO3XW80sxPfgB2dbIE7dn6hHrwQVsLyr/e6ACY
   b33ZGWPM2GbnonmG76+3hX20XsQpv/2Bo96yCVrdLqzbQItCzNblM+JC0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384206800"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="384206800"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 03:41:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="723618608"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="723618608"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 03:41:57 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joelfernandes.org@vger.kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Rework tick dependency setting into rcu_exp_handler()
Date:   Wed,  4 Jan 2023 19:47:22 +0800
Message-Id: <20230104114722.931144-1-qiang1.zhang@intel.com>
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

Currently, when first find out the expedited grace period is not end
and timeout occurred, we set tick dependency for CPUs that have not
yet reported the quiescent state in the rcu_node structure's->expmask
but need to eliminate races between set and clear tick dependency, setting
CPU tick dependency need to hold rcu_node structure's->lock.

This commit move tick dependency setting into rcu_exp_handler(), set tick
dependency when fail to report a quiescent state and clear tick dependency
in rcu_report_exp_rdp(). [from Frederic Weisbecker suggestion]

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..02605048830c 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -586,39 +586,19 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
 static void synchronize_rcu_expedited_wait(void)
 {
 	int cpu;
-	unsigned long j;
 	unsigned long jiffies_stall;
 	unsigned long jiffies_start;
 	unsigned long mask;
 	int ndetected;
-	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
-	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_exp_jiffies_till_stall_check();
 	jiffies_start = jiffies;
-	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended()) {
-		if (synchronize_rcu_expedited_wait_once(1))
-			return;
-		rcu_for_each_leaf_node(rnp) {
-			raw_spin_lock_irqsave_rcu_node(rnp, flags);
-			mask = READ_ONCE(rnp->expmask);
-			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
-				rdp = per_cpu_ptr(&rcu_data, cpu);
-				if (rdp->rcu_forced_tick_exp)
-					continue;
-				rdp->rcu_forced_tick_exp = true;
-				if (cpu_online(cpu))
-					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-			}
-			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		}
-		j = READ_ONCE(jiffies_till_first_fqs);
-		if (synchronize_rcu_expedited_wait_once(j + HZ))
-			return;
-	}
+
+	if (synchronize_rcu_expedited_wait_once(1))
+		return;
 
 	for (;;) {
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
@@ -653,8 +633,6 @@ static void synchronize_rcu_expedited_wait(void)
 		if (ndetected) {
 			pr_err("blocking rcu_node structures (internal RCU debug):");
 			rcu_for_each_node_breadth_first(rnp) {
-				if (rnp == rnp_root)
-					continue; /* printed unconditionally */
 				if (sync_rcu_exp_done_unlocked(rnp))
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
@@ -729,6 +707,17 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 
 #ifdef CONFIG_PREEMPT_RCU
 
+static void rcu_exp_set_tickdep(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	if (tick_nohz_full_enabled() && rcu_inkernel_boot_has_ended() &&
+						cpu_online(cpu)) {
+		rdp->rcu_forced_tick_exp = true;
+		tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+	}
+}
+
 /*
  * Remote handler for smp_call_function_single().  If there is an
  * RCU read-side critical section in effect, request that the
@@ -743,6 +732,7 @@ static void rcu_exp_handler(void *unused)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
+	int cpu = raw_smp_processor_id();
 
 	/*
 	 * First, the common case of not being in an RCU read-side
@@ -757,6 +747,7 @@ static void rcu_exp_handler(void *unused)
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
+			rcu_exp_set_tickdep(cpu);
 		}
 		return;
 	}
@@ -778,6 +769,7 @@ static void rcu_exp_handler(void *unused)
 		if (rnp->expmask & rdp->grpmask) {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			t->rcu_read_unlock_special.b.exp_hint = true;
+			rcu_exp_set_tickdep(cpu);
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
-- 
2.25.1

