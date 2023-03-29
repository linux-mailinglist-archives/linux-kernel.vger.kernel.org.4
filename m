Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC426CDB1D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC2NrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjC2NrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:47:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E436D1FCA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097632; x=1711633632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ewl5JoHt9JT7wNP3tMvVmPjNenOQ8vgDP1BjfKxI6cE=;
  b=af6R5JAgwiKyhwSmNcn9huaQRKLQZFSyDT8BZhH++Thm7ud5Ggj420Jo
   lfYd7uPwVY/DmRzsmDds4uO4Hzh7ayQvDE6TAfq5OnZNeoI3qRJlXiCZc
   h0c1kxm81LHMkjOBYLDZXLEVkZ2hwDNxtc3+T31QZbrDuZ2DvoKzTWk+f
   loim+Ziieb+nIITGHFEhnztW0/yJGe+qNfTcqZRRNMk0uQueBhuu7BiDF
   xcok8yUrftpOlpwxiavEB+BaQ2w7Dm4mCss1wB2846+GOM1lsdkXZNOqA
   HLBy8GWW3dyrUZPcmoFzmb2fWBLo2vQ64IaP+jaaSaWY3tD2i8keJ9sdl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="403506251"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403506251"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:47:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="677783395"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="677783395"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Mar 2023 06:47:09 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iommu/vt-d: Fix an IOMMU perfmon warning when CPU hotplug
Date:   Wed, 29 Mar 2023 21:47:21 +0800
Message-Id: <20230329134721.469447-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329134721.469447-1-baolu.lu@linux.intel.com>
References: <20230329134721.469447-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

A warning can be triggered when hotplug CPU 0.
$ echo 0 > /sys/devices/system/cpu/cpu0/online

 ------------[ cut here ]------------
 Voluntary context switch within RCU read-side critical section!
 WARNING: CPU: 0 PID: 19 at kernel/rcu/tree_plugin.h:318
          rcu_note_context_switch+0x4f4/0x580
 RIP: 0010:rcu_note_context_switch+0x4f4/0x580
 Call Trace:
  <TASK>
  ? perf_event_update_userpage+0x104/0x150
  __schedule+0x8d/0x960
  ? perf_event_set_state.part.82+0x11/0x50
  schedule+0x44/0xb0
  schedule_timeout+0x226/0x310
  ? __perf_event_disable+0x64/0x1a0
  ? _raw_spin_unlock+0x14/0x30
  wait_for_completion+0x94/0x130
  __wait_rcu_gp+0x108/0x130
  synchronize_rcu+0x67/0x70
  ? invoke_rcu_core+0xb0/0xb0
  ? __bpf_trace_rcu_stall_warning+0x10/0x10
  perf_pmu_migrate_context+0x121/0x370
  iommu_pmu_cpu_offline+0x6a/0xa0
  ? iommu_pmu_del+0x1e0/0x1e0
  cpuhp_invoke_callback+0x129/0x510
  cpuhp_thread_fun+0x94/0x150
  smpboot_thread_fn+0x183/0x220
  ? sort_range+0x20/0x20
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>
 ---[ end trace 0000000000000000 ]---

The synchronize_rcu() will be invoked in the perf_pmu_migrate_context(),
when migrating a PMU to a new CPU. However, the current for_each_iommu()
is within RCU read-side critical section.

Two methods were considered to fix the issue.
- Use the dmar_global_lock to replace the RCU read lock when going
  through the drhd list. But it triggers a lockdep warning.
- Use the cpuhp_setup_state_multi() to set up a dedicated state for each
  IOMMU PMU. The lock can be avoided.

The latter method is implemented in this patch. Since each IOMMU PMU has
a dedicated state, add cpuhp_node and cpu in struct iommu_pmu to track
the state. The state can be dynamically allocated now. Remove the
CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE.

Fixes: 46284c6ceb5e ("iommu/vt-d: Support cpumask for IOMMU perfmon")
Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230328182028.1366416-1-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/cpuhotplug.h    |  1 -
 drivers/iommu/intel/iommu.h   |  2 ++
 drivers/iommu/intel/perfmon.c | 68 ++++++++++++++++++++++-------------
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index c6fab004104a..5b2f8147d1ae 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -218,7 +218,6 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_X86_IDXD_ONLINE,
-	CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d6df3b865812..694ab9b7d3e9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -641,6 +641,8 @@ struct iommu_pmu {
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
 	unsigned char		irq_name[16];
+	struct hlist_node	cpuhp_node;
+	int			cpu;
 };
 
 #define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index e17d9743a0d8..cf43e798eca4 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -773,19 +773,34 @@ static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
 	iommu->perf_irq = 0;
 }
 
-static int iommu_pmu_cpu_online(unsigned int cpu)
+static int iommu_pmu_cpu_online(unsigned int cpu, struct hlist_node *node)
 {
+	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
+
 	if (cpumask_empty(&iommu_pmu_cpu_mask))
 		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
 
+	if (cpumask_test_cpu(cpu, &iommu_pmu_cpu_mask))
+		iommu_pmu->cpu = cpu;
+
 	return 0;
 }
 
-static int iommu_pmu_cpu_offline(unsigned int cpu)
+static int iommu_pmu_cpu_offline(unsigned int cpu, struct hlist_node *node)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int target;
+	struct iommu_pmu *iommu_pmu = hlist_entry_safe(node, typeof(*iommu_pmu), cpuhp_node);
+	int target = cpumask_first(&iommu_pmu_cpu_mask);
+
+	/*
+	 * The iommu_pmu_cpu_mask has been updated when offline the CPU
+	 * for the first iommu_pmu. Migrate the other iommu_pmu to the
+	 * new target.
+	 */
+	if (target < nr_cpu_ids && target != iommu_pmu->cpu) {
+		perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
+		iommu_pmu->cpu = target;
+		return 0;
+	}
 
 	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
 		return 0;
@@ -795,45 +810,50 @@ static int iommu_pmu_cpu_offline(unsigned int cpu)
 	if (target < nr_cpu_ids)
 		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
 	else
-		target = -1;
+		return 0;
 
-	rcu_read_lock();
-
-	for_each_iommu(iommu, drhd) {
-		if (!iommu->pmu)
-			continue;
-		perf_pmu_migrate_context(&iommu->pmu->pmu, cpu, target);
-	}
-	rcu_read_unlock();
+	perf_pmu_migrate_context(&iommu_pmu->pmu, cpu, target);
+	iommu_pmu->cpu = target;
 
 	return 0;
 }
 
 static int nr_iommu_pmu;
+static enum cpuhp_state iommu_cpuhp_slot;
 
 static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
 {
 	int ret;
 
-	if (nr_iommu_pmu++)
-		return 0;
+	if (!nr_iommu_pmu) {
+		ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+					      "driver/iommu/intel/perfmon:online",
+					      iommu_pmu_cpu_online,
+					      iommu_pmu_cpu_offline);
+		if (ret < 0)
+			return ret;
+		iommu_cpuhp_slot = ret;
+	}
 
-	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
-				"driver/iommu/intel/perfmon:online",
-				iommu_pmu_cpu_online,
-				iommu_pmu_cpu_offline);
-	if (ret)
-		nr_iommu_pmu = 0;
+	ret = cpuhp_state_add_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
+	if (ret) {
+		if (!nr_iommu_pmu)
+			cpuhp_remove_multi_state(iommu_cpuhp_slot);
+		return ret;
+	}
+	nr_iommu_pmu++;
 
-	return ret;
+	return 0;
 }
 
 static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
 {
+	cpuhp_state_remove_instance(iommu_cpuhp_slot, &iommu_pmu->cpuhp_node);
+
 	if (--nr_iommu_pmu)
 		return;
 
-	cpuhp_remove_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE);
+	cpuhp_remove_multi_state(iommu_cpuhp_slot);
 }
 
 void iommu_pmu_register(struct intel_iommu *iommu)
-- 
2.34.1

