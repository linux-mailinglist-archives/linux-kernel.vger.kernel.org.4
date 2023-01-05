Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1030365E38A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjAEDem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjAEDej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:34:39 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90064882C;
        Wed,  4 Jan 2023 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672889678; x=1704425678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QUTlUNdOBhgTJmvcsTFaL20j9mIag+B96H14BJHxIUs=;
  b=LWLxoqFJQjpjnipVakjFtQl0YcsP9FOIXBMeA6eqz3G2a3kpUSjfYQTL
   aptaOtz71sO6QgjmzV+z9GIF1v/UUBWtuQUHjUSRuFk8TuilMgkf2zEq4
   V+sl9Hmz16JTV20N4ndpR7NEwbnb3HoJj7qv/Ivt6ngJ55oXtdmPOsP/j
   vOlAVbAlHszvU52S8T7CdlSVqq9p7HLfuVm/ViDA/pbB52tXaM4YOkPzc
   ESI60UCtpJCr45d68+9GDax7Ejr/bX08uoYhrBD3mfyCJLa64ron2SxGP
   5a8tth9lUhxzXAPHJLADh00mRMYij4HLg3tAt1PzDH+MF/eS2ghAnv7LM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="322177651"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="322177651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 19:34:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="779428061"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="779428061"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 19:34:35 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Rework tick dependency setting into rcu_exp_handler()
Date:   Thu,  5 Jan 2023 11:40:00 +0800
Message-Id: <20230105034000.971748-1-qiang1.zhang@intel.com>
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
 kernel/rcu/tree_exp.h | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..f1e947675727 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -586,39 +586,16 @@ static bool synchronize_rcu_expedited_wait_once(long tlimit)
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
 
 	for (;;) {
 		if (synchronize_rcu_expedited_wait_once(jiffies_stall))
@@ -729,6 +706,24 @@ static void rcu_exp_sel_wait_wake(unsigned long s)
 
 #ifdef CONFIG_PREEMPT_RCU
 
+static void rcu_exp_set_tickdep(struct rcu_data *rdp)
+{
+	int cpu = rdp->cpu;
+
+	if (tick_nohz_full_cpu(cpu) && rcu_inkernel_boot_has_ended() &&
+						cpu_online(cpu)) {
+		/*
+		 * The rcu_exp_handler() can be invoked from stop machine,
+		 * at this time CPU has disabled all interrupts and offline,
+		 * in which case, we don't need requeue IPI or irq work.
+		 * which is not a problem since rcu_report_dead() does the
+		 * QS report.
+		 */
+		rdp->rcu_forced_tick_exp = true;
+		tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+	}
+}
+
 /*
  * Remote handler for smp_call_function_single().  If there is an
  * RCU read-side critical section in effect, request that the
@@ -757,6 +752,7 @@ static void rcu_exp_handler(void *unused)
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			set_tsk_need_resched(t);
 			set_preempt_need_resched();
+			rcu_exp_set_tickdep(rdp);
 		}
 		return;
 	}
@@ -778,6 +774,7 @@ static void rcu_exp_handler(void *unused)
 		if (rnp->expmask & rdp->grpmask) {
 			WRITE_ONCE(rdp->cpu_no_qs.b.exp, true);
 			t->rcu_read_unlock_special.b.exp_hint = true;
+			rcu_exp_set_tickdep(rdp);
 		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
-- 
2.25.1

