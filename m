Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3166161A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKBLUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKBLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:20:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCB5B23EB1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:20:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C994C1FB;
        Wed,  2 Nov 2022 04:20:24 -0700 (PDT)
Received: from e126815.warwick.arm.com (e126815.arm.com [10.32.32.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D75F3F5A1;
        Wed,  2 Nov 2022 04:20:16 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     stable@kernel.org
Cc:     Suzuki.Poulose@arm.com, James Clark <james.clark@arm.com>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] coresight: cti: Fix hang in cti_disable_hw()
Date:   Wed,  2 Nov 2022 11:20:03 +0000
Message-Id: <20221102112003.2318583-1-james.clark@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 6746eae4bbaddcc16b40efb33dab79210828b3ce upstream.

cti_enable_hw() and cti_disable_hw() are called from an atomic context
so shouldn't use runtime PM because it can result in a sleep when
communicating with firmware.

This can cause a hang when running the Perf Coresight tests or running
this command:

  perf record -e cs_etm//u -- ls

With lock and scheduler debugging enabled the following is output:

   coresight cti_sys0: cti_enable_hw -- dev:cti_sys0  parent: 20020000.cti
   BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1151
   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 330, name: perf-exec
   preempt_count: 2, expected: 0
   RCU nest depth: 0, expected: 0
   INFO: lockdep is turned off.
   irq event stamp: 0
   hardirqs last  enabled at (0): [<0000000000000000>] 0x0
   hardirqs last disabled at (0): [<ffff80000822b394>] copy_process+0xa0c/0x1948
   softirqs last  enabled at (0): [<ffff80000822b394>] copy_process+0xa0c/0x1948
   softirqs last disabled at (0): [<0000000000000000>] 0x0
   CPU: 3 PID: 330 Comm: perf-exec Not tainted 6.0.0-00053-g042116d99298 #7
   Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Sep 13 2022
   Call trace:
    dump_backtrace+0x134/0x140
    show_stack+0x20/0x58
    dump_stack_lvl+0x8c/0xb8
    dump_stack+0x18/0x34
    __might_resched+0x180/0x228
    __might_sleep+0x50/0x88
    __pm_runtime_resume+0xac/0xb0
    cti_enable+0x44/0x120
    coresight_control_assoc_ectdev+0xc0/0x150
    coresight_enable_path+0xb4/0x288
    etm_event_start+0x138/0x170
    etm_event_add+0x48/0x70
    event_sched_in.isra.122+0xb4/0x280
    merge_sched_in+0x1fc/0x3d0
    visit_groups_merge.constprop.137+0x16c/0x4b0
    ctx_sched_in+0x114/0x1f0
    perf_event_sched_in+0x60/0x90
    ctx_resched+0x68/0xb0
    perf_event_exec+0x138/0x508
    begin_new_exec+0x52c/0xd40
    load_elf_binary+0x6b8/0x17d0
    bprm_execve+0x360/0x7f8
    do_execveat_common.isra.47+0x218/0x238
    __arm64_sys_execve+0x48/0x60
    invoke_syscall+0x4c/0x110
    el0_svc_common.constprop.4+0xfc/0x120
    do_el0_svc+0x34/0xc0
    el0_svc+0x40/0x98
    el0t_64_sync_handler+0x98/0xc0
    el0t_64_sync+0x170/0x174

Fix the issue by removing the runtime PM calls completely. They are not
needed here because it must have already been done when building the
path for a trace.

Fixes: 835d722ba10a ("coresight: cti: Initial CoreSight CTI Driver")
Cc: stable <stable@kernel.org> # 5.10.x
Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
Reported-by: Cristian Marussi <Cristian.Marussi@arm.com>
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
[ Fix build warnings ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20221025131032.1149459-1-suzuki.poulose@arm.com
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-cti-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index 0276700c246d..90270696206c 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -90,11 +90,9 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
 static int cti_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 	unsigned long flags;
 	int rc = 0;
 
-	pm_runtime_get_sync(dev->parent);
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* no need to do anything if enabled or unpowered*/
@@ -119,7 +117,6 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 	/* cannot enable due to error */
 cti_err_not_enabled:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(dev->parent);
 	return rc;
 }
 
@@ -153,7 +150,6 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 static int cti_disable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	struct device *dev = &drvdata->csdev->dev;
 
 	spin_lock(&drvdata->spinlock);
 
@@ -174,7 +170,6 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 	coresight_disclaim_device_unlocked(drvdata->base);
 	CS_LOCK(drvdata->base);
 	spin_unlock(&drvdata->spinlock);
-	pm_runtime_put(dev->parent);
 	return 0;
 
 	/* not disabled this call */
-- 
2.25.1

