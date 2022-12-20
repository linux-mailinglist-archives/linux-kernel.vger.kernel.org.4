Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB67C651F90
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiLTLTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLTLTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:19:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0E55F9B;
        Tue, 20 Dec 2022 03:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671535188; x=1703071188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SzQJswxVRxcpqFv6eaWlB/9VJizojsPMop7gx5A5odg=;
  b=SE6KkStud9tEq8niFaOJKz9kgnWR1l2Qcn1ZH3AegCB1Gz0RfmYLvetV
   riI65t5XERXAby4ocfWI+IPWIJ6G+PNwmUJxDtZNSXZgDWI9B0unFg7Mq
   CFp3bR4KCUSEDHGWDldboiXU9gURpbiYfp5c9YoEMPYOo1UpruybYKm4v
   q05Dnv1MApJkto0Dxvk+c5IlbVTj7OIjnE4Gg7WYEOTZjhqYrwaKdQme3
   70BKLPh9FwCFKXV4OrUGTyz4GsiB6DaEv74O39b0YMzJ6IyqJCMb4G8Ua
   j+G1DFeHGRhiyurEXo+I0v03pgdB+821JGATsLO4ygMD0Q47Tr9Bs0UeF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="307271012"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="307271012"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:19:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10566"; a="681608481"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="681608481"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 03:19:45 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix race in set and clear TICK_DEP_BIT_RCU_EXP bitmask
Date:   Tue, 20 Dec 2022 19:25:20 +0800
Message-Id: <20221220112520.3596920-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the kernel bulit with CONFIG_NO_HZ_FULL enabled and the following
cpus is nohz_full cpus:

	CPU1                                                 CPU2
rcu_report_exp_cpu_mult                          synchronize_rcu_expedited_wait
   acquires rnp->lock                               mask = rnp->expmask;
                                                    for_each_leaf_node_cpu_mask(rnp, cpu, mask)
   rnp->expmask = rnp->expmask & ~mask;                rdp = per_cpu_ptr(&rcu_data, cpu1);
   for_each_leaf_node_cpu_mask(rnp, cpu, mask)
      rdp = per_cpu_ptr(&rcu_data, cpu1);
      if (!rdp->rcu_forced_tick_exp)
             continue;                                 rdp->rcu_forced_tick_exp = true;
                                                       tick_dep_set_cpu(cpu1, TICK_DEP_BIT_RCU_EXP);

In the above scenario, after CPU1 reported the quiescent state, CPU1
misses the opportunity to clear the TICK_DEP_BIT_RCU_EXP bitmask, it
will not be cleared until the next expedited grace period starts and
the CPU1 quiescent state is reported again. during this window period,
the CPU1 whose tick can not be stopped, if CPU1 has only one runnable
task and this task has aggressive real-time response constraints, this
task may have one of the worst response times.

Therefore, this commit add rnp->lock when set TICK_DEP_BIT_RCU_EXP
bitmask to fix this race.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 927abaf6c822..e5fe0099488b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -593,6 +593,7 @@ static void synchronize_rcu_expedited_wait(void)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_root = rcu_get_root();
+	unsigned long flags;
 
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_exp_jiffies_till_stall_check();
@@ -601,17 +602,17 @@ static void synchronize_rcu_expedited_wait(void)
 		if (synchronize_rcu_expedited_wait_once(1))
 			return;
 		rcu_for_each_leaf_node(rnp) {
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			mask = READ_ONCE(rnp->expmask);
 			for_each_leaf_node_cpu_mask(rnp, cpu, mask) {
 				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				preempt_disable();
 				if (cpu_online(cpu))
 					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
-				preempt_enable();
 			}
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
 		if (synchronize_rcu_expedited_wait_once(j + HZ))
-- 
2.25.1

