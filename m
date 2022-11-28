Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D763AADC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiK1O27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbiK1O25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:28:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B91F637;
        Mon, 28 Nov 2022 06:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669645736; x=1701181736;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MrI+cgsw8fa/uMy0ii8IS1azy4iiz+Bct6bPgqhgiOA=;
  b=juV/h03SzrZ470dHRA/kXpYr1i6AhXJr/pH/5M8Xev556W4zlOkv242h
   uHkb7cZ6RWHXEqqGDCcafZiq8l51x2Vmghxj6oivE7fllZvLD1tzbz8SO
   NSIwxUpagA7HR1VWXENSPWnnPg7VRDIb2n2cr+896uWGGz9LfJxbHIG4a
   nlP9uAvblDGSDKJ4shvMyz2DtW87WyerThKNq9++Y3iL5vkLNZ6AJ0gVv
   0Tle9IreDRebLeH5PwAKL/yjxRAw4SB3sLkaHpJh9uhNtScR5Lkjh14i1
   3AB5K+o8bnwgwVOA4oFovyINdZmVhoG4/rD/jYxIazowp00tfu9WH+dKf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="376985221"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="376985221"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:28:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="749408009"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749408009"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 06:28:39 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Mon, 28 Nov 2022 22:34:28 +0800
Message-Id: <20221128143428.1703744-1-qiang1.zhang@intel.com>
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

This commit add cpus_read_lock/unlock() protection before accessing
__num_online_cpus variables, to ensure that the CPU in the offline
process has been completed offline.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4a991311be9b..08e72c6462d8 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1033,14 +1033,30 @@ static void rcu_tasks_be_rude(struct work_struct *work)
 {
 }
 
+static DEFINE_PER_CPU(struct work_struct, rude_work);
+
 // Wait for one rude RCU-tasks grace period.
 static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
 {
+	int cpu;
+	struct work_struct *work;
+
+	cpus_read_lock();
 	if (num_online_cpus() <= 1)
-		return;	// Fastpath for only one CPU.
+		goto end;// Fastpath for only one CPU.
 
 	rtp->n_ipis += cpumask_weight(cpu_online_mask);
-	schedule_on_each_cpu(rcu_tasks_be_rude);
+	for_each_online_cpu(cpu) {
+		work = per_cpu_ptr(&rude_work, cpu);
+		INIT_WORK(work, rcu_tasks_be_rude);
+		schedule_work_on(cpu, work);
+	}
+
+	for_each_online_cpu(cpu)
+		flush_work(per_cpu_ptr(&rude_work, cpu));
+
+end:
+	cpus_read_unlock();
 }
 
 void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t func);
-- 
2.25.1

