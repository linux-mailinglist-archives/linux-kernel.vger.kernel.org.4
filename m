Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF296C80CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjCXPLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjCXPLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:11:42 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD67F1A97B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679670688; x=1711206688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=03V1PFd1+R7lHpt8jj+NKucwctNhr0rR2OfBz81nxZo=;
  b=fEOkUpLQGCKgTsK25Lfls+MUApQCOG8idUMcvcqBJnAt4IMdEgpPr3sG
   nve96pesJ8mdY+nMfZ+BHkVMRSO8b5Y4EQsXmTRw9BcoUOMTHGd+mvok3
   +y+gHrAuzSBN2ClGnXWdx5j3MFh+i4Wjq9UgwbcNlPp2iUNsrOGzOJgso
   sDURwQXM59ceKBHKZU0Y0pa8zlC47UM3NlkiYs+JSBy/L8XTsj6jFac48
   hdrXy9A6hiV7i0uogpWwArRGYTGWedI13T2ZCj09aG+/Licv+PeI2Q7zz
   RXRWgmYZ8J4dk6C32Z09PDb70Gcq/m8sYkUfoeFAuDSNGn/Fh6owjdWmq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="320195662"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="320195662"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 08:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806702875"
X-IronPort-AV: E=Sophos;i="5.98,288,1673942400"; 
   d="scan'208";a="806702875"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2023 08:11:09 -0700
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Fix a IOMMU perfmon warning when CPU hotplug
Date:   Fri, 24 Mar 2023 08:11:06 -0700
Message-Id: <20230324151106.526132-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
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

[11958.737635] ------------[ cut here ]------------
[11958.742882] Voluntary context switch within RCU read-side critical
section!
[11958.742891] WARNING: CPU: 0 PID: 19 at kernel/rcu/tree_plugin.h:318
rcu_note_context_switch+0x4f4/0x580
[11958.860095] RIP: 0010:rcu_note_context_switch+0x4f4/0x580
[11958.960360] Call Trace:
[11958.963161]  <TASK>
[11958.965565]  ? perf_event_update_userpage+0x104/0x150
[11958.971293]  __schedule+0x8d/0x960
[11958.975165]  ? perf_event_set_state.part.82+0x11/0x50
[11958.980891]  schedule+0x44/0xb0
[11958.984464]  schedule_timeout+0x226/0x310
[11958.989017]  ? __perf_event_disable+0x64/0x1a0
[11958.994054]  ? _raw_spin_unlock+0x14/0x30
[11958.998605]  wait_for_completion+0x94/0x130
[11959.003352]  __wait_rcu_gp+0x108/0x130
[11959.007616]  synchronize_rcu+0x67/0x70
[11959.011876]  ? invoke_rcu_core+0xb0/0xb0
[11959.016333]  ? __bpf_trace_rcu_stall_warning+0x10/0x10
[11959.022147]  perf_pmu_migrate_context+0x121/0x370
[11959.027478]  iommu_pmu_cpu_offline+0x6a/0xa0
[11959.032325]  ? iommu_pmu_del+0x1e0/0x1e0
[11959.036782]  cpuhp_invoke_callback+0x129/0x510
[11959.041825]  cpuhp_thread_fun+0x94/0x150
[11959.046283]  smpboot_thread_fn+0x183/0x220
[11959.050933]  ? sort_range+0x20/0x20
[11959.054902]  kthread+0xe6/0x110
[11959.058479]  ? kthread_complete_and_exit+0x20/0x20
[11959.063911]  ret_from_fork+0x1f/0x30
[11959.067982]  </TASK>
[11959.070489] ---[ end trace 0000000000000000 ]---

The synchronize_rcu() will be invoked in the perf_pmu_migrate_context(),
when migrating a PMU to a new CPU. However, the current for_each_iommu()
is within RCU read-side critical section.

Use the dmar_global_lock to replace the RCU read lock when going through
the drhd list.

Fixes: 46284c6ceb5e ("iommu/vt-d: Support cpumask for IOMMU perfmon")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/perfmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index e17d9743a0d8..81c9554fb1dc 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -797,14 +797,14 @@ static int iommu_pmu_cpu_offline(unsigned int cpu)
 	else
 		target = -1;
 
-	rcu_read_lock();
+	down_write(&dmar_global_lock);
 
 	for_each_iommu(iommu, drhd) {
 		if (!iommu->pmu)
 			continue;
 		perf_pmu_migrate_context(&iommu->pmu->pmu, cpu, target);
 	}
-	rcu_read_unlock();
+	up_write(&dmar_global_lock);
 
 	return 0;
 }
-- 
2.35.1

