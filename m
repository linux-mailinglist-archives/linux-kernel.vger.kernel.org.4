Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF863E59D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiK3Xjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiK3Xjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:39:49 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BAC4AF00;
        Wed, 30 Nov 2022 15:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669851588; x=1701387588;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GWVuLU6hwlyf/0slfPIYoWjRHEi8uqhqjARf8Hxd8OA=;
  b=hIX6yuTT5J1xCF9qbI69McZqCW5kXMo/9rkXLg4ykRL1M/SB2fFGVy/t
   2ITvYBE9Dn+ESkpNEa5aFvzyh5ZRS12krHxP0LQzs2lXHh9cPf6FcITjD
   b+vvr0+0Ta3bTavkTsn/irypXPLV+qf0Hay8uVid4qYZ8WekwvNrLx9UY
   W67UvdSdSQw7zFLsVCfyykX2GkXxa5qztlsxhUGpIKfF2zOmGx/Id9WhN
   522cEmvn+xHTHJvH5QhIE6bMDLVZ4YPbR+qMIY8k7YA227LRZIxCr/VOn
   YpQBDbezjB1cyLVQhcQAN5krjDrVODn2yOSIgXoqgwA9TCRQgLJ8e+OQq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="303140897"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="303140897"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:39:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818816823"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="818816823"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:39:46 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Thu,  1 Dec 2022 07:45:33 +0800
Message-Id: <20221130234533.1983769-1-qiang1.zhang@intel.com>
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

Currently, invoke rcu_tasks_rude_wait_gp() to wait one rude
RCU-tasks grace period, if __num_online_cpus == 1, will return
directly, indicates the end of the rude RCU-task grace period.
suppose the system has two cpus, consider the following scenario:

        CPU0                                   CPU1 (going offline)
                                          migration/1 task:
                                      cpu_stopper_thread
                                       -> take_cpu_down
                                          -> _cpu_disable
                                           (dec __num_online_cpus)
                                          ->cpuhp_invoke_callback
                                                preempt_disable
                                                access old_data0
           task1
 del old_data0                                  .....
 synchronize_rcu_tasks_rude()
 task1 schedule out
 ....
 task2 schedule in
 rcu_tasks_rude_wait_gp()
     ->__num_online_cpus == 1
       ->return
 ....
 task1 schedule in
 ->free old_data0
                                                preempt_enable

when CPU1 dec __num_online_cpus and __num_online_cpus is equal one,
the CPU1 has not finished offline, stop_machine task(migration/1)
still running on CPU1, maybe still accessing 'old_data0', but the
'old_data0' has freed on CPU0.

In order to prevent the above scenario from happening, this commit
remove check for __num_online_cpus == 0 and add handling of calling
synchronize_rcu_tasks_generic() during early boot(when the
rcu_scheduler_active variable is RCU_SCHEDULER_INACTIVE, the scheduler
not yet initialized and only one boot-CPU online).

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4dda8e6e5707..9f0c439c73d2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
+	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			 "%s called too soon", rtp->name))
+		return;
 
 	// If the grace-period kthread is running, use it.
 	if (READ_ONCE(rtp->kthread_ptr)) {
@@ -1064,9 +1065,6 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
-	if (num_online_cpus() <= 1)
-		return;	// Fastpath for only one CPU.
-
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
 	schedule_on_each_cpu(rcu_tasks_be_rude);
 }
-- 
2.25.1

