Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781F763CCC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 02:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiK3BTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 20:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiK3BTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 20:19:00 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D2D205CF;
        Tue, 29 Nov 2022 17:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669771140; x=1701307140;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sgLb3+hHrnxviwnVp4ajKcqE767kfjliDdxs3bjc7KU=;
  b=J2QLe1s/AYYZEVVrxkXP2Szqsca660cXRYKV08WoLVQ90se222FGkrq6
   Jxb7oZ/boiMWWJ59BTC6/JIUbaf1PplyTDXx7IAJCczM/KjpQ4NI2sAOC
   EWZPJ99lH6aS4idAqHHEzusWyokvvnsGyUdQ07WS8NT67/FOUx3mkybj1
   4T2PVO5fgRxugYx6OeEcNvlBERqa2kHWYudQe/G3I4lrAQ8rVHpDnrB6h
   NR/lmING3r0oLgcgtfgI20E4SVpr+cb4QKZ4odIbUszlckVpA8GUfxBh+
   cdyFpwoqPIt5a8FnTSJiRelvwZL9DWU9OwDc9B00QadZv/xx2YnrfhrPS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="298642889"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="298642889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:18:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="786271290"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="786271290"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 17:18:57 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu-tasks: Make rude RCU-Tasks work well with CPU hotplug
Date:   Wed, 30 Nov 2022 09:24:45 +0800
Message-Id: <20221130012445.1863104-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 4dda8e6e5707..e4f7d08bde64 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -560,8 +560,9 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 {
 	/* Complain if the scheduler has not started.  */
-	WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
-			 "synchronize_rcu_tasks called too soon");
+	if (WARN_ONCE(rcu_scheduler_active == RCU_SCHEDULER_INACTIVE,
+			"synchronize_rcu_tasks called too soon"))
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

