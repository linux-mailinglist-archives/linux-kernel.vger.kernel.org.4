Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3DD6825C2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjAaHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjAaHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:46:16 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EF3E0BB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151175; x=1706687175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRhbLbcdzD3YZbuz7wKC51Hdu2i1rzT4Orz0g+avwrI=;
  b=n9NeBySKCxaSrR9QsmRRsq0WvyhgLQDl9o6nhEXcAOHdWaeDvpNiITYf
   HUWEQZ3/sp5bQ1kEyF/m5LNPoBhn9VU4yNQkgc/F706IERP+0jsqr06yV
   xdgGaJWkztI/jzQvnFBlyNbKrorzNS4ZdJZBVFM4SWYjD/wHKgDXyTBXq
   H7XOAtSFt5rVzy2aA2h7Tk32D8XWFnV5Q0XSLPaFZkGTjJgNumrfXwRae
   ZV4QH+r/DAXsYKTJH0qWpuQaozHppKP968Es+s86x80u2tSK9agra+m4Y
   sUd6dx9bqpA/z+fuWwWepJrsaG9nSPb5HFdXF49VfGmZFZetpQuVRm6Xl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="315736638"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="315736638"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="657775576"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="657775576"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jan 2023 23:46:07 -0800
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kan.liang@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] iommu/vt-d: Support cpumask for IOMMU perfmon
Date:   Tue, 31 Jan 2023 15:37:38 +0800
Message-Id: <20230131073740.378984-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131073740.378984-1-baolu.lu@linux.intel.com>
References: <20230131073740.378984-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf subsystem assumes that all counters are by default per-CPU. So
the user space tool reads a counter from each CPU. However, the IOMMU
counters are system-wide and can be read from any CPU. Here we use a CPU
mask to restrict counting to one CPU to handle the issue. (with CPU
hotplug notifier to choose a different CPU if the chosen one is taken
off-line).

The CPU is exposed to /sys/bus/event_source/devices/dmar*/cpumask for
the user space perf tool.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20230128200428.1459118-6-kan.liang@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/cpuhotplug.h                    |   1 +
 drivers/iommu/intel/perfmon.c                 | 113 ++++++++++++++++--
 .../sysfs-bus-event_source-devices-iommu      |   8 ++
 3 files changed, 114 insertions(+), 8 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 6c6859bfc454..f2ea348ce3b0 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -221,6 +221,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_X86_IDXD_ONLINE,
+	CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_PERF_ARM_CCI_ONLINE,
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index df9b78736462..322d362b85e4 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -34,9 +34,28 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
+static cpumask_t iommu_pmu_cpu_mask;
+
+static ssize_t
+cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *iommu_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group iommu_pmu_cpumask_attr_group = {
+	.attrs = iommu_pmu_cpumask_attrs,
+};
+
 static const struct attribute_group *iommu_pmu_attr_groups[] = {
 	&iommu_pmu_format_attr_group,
 	&iommu_pmu_events_attr_group,
+	&iommu_pmu_cpumask_attr_group,
 	NULL
 };
 
@@ -679,20 +698,98 @@ void free_iommu_pmu(struct intel_iommu *iommu)
 	iommu->pmu = NULL;
 }
 
+static int iommu_pmu_cpu_online(unsigned int cpu)
+{
+	if (cpumask_empty(&iommu_pmu_cpu_mask))
+		cpumask_set_cpu(cpu, &iommu_pmu_cpu_mask);
+
+	return 0;
+}
+
+static int iommu_pmu_cpu_offline(unsigned int cpu)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int target;
+
+	if (!cpumask_test_and_clear_cpu(cpu, &iommu_pmu_cpu_mask))
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+
+	if (target < nr_cpu_ids)
+		cpumask_set_cpu(target, &iommu_pmu_cpu_mask);
+	else
+		target = -1;
+
+	rcu_read_lock();
+
+	for_each_iommu(iommu, drhd) {
+		if (!iommu->pmu)
+			continue;
+		perf_pmu_migrate_context(&iommu->pmu->pmu, cpu, target);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int nr_iommu_pmu;
+
+static int iommu_pmu_cpuhp_setup(struct iommu_pmu *iommu_pmu)
+{
+	int ret;
+
+	if (nr_iommu_pmu++)
+		return 0;
+
+	ret = cpuhp_setup_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE,
+				"driver/iommu/intel/perfmon:online",
+				iommu_pmu_cpu_online,
+				iommu_pmu_cpu_offline);
+	if (ret)
+		nr_iommu_pmu = 0;
+
+	return ret;
+}
+
+static void iommu_pmu_cpuhp_free(struct iommu_pmu *iommu_pmu)
+{
+	if (--nr_iommu_pmu)
+		return;
+
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_IOMMU_PERF_ONLINE);
+}
+
 void iommu_pmu_register(struct intel_iommu *iommu)
 {
-	if (!iommu->pmu)
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
 		return;
 
-	if (__iommu_pmu_register(iommu)) {
-		pr_err("Failed to register PMU for iommu (seq_id = %d)\n",
-		       iommu->seq_id);
-		free_iommu_pmu(iommu);
-	}
+	if (__iommu_pmu_register(iommu))
+		goto err;
+
+	if (iommu_pmu_cpuhp_setup(iommu_pmu))
+		goto unregister;
+
+	return;
+
+unregister:
+	perf_pmu_unregister(&iommu_pmu->pmu);
+err:
+	pr_err("Failed to register PMU for iommu (seq_id = %d)\n", iommu->seq_id);
+	free_iommu_pmu(iommu);
 }
 
 void iommu_pmu_unregister(struct intel_iommu *iommu)
 {
-	if (iommu->pmu)
-		perf_pmu_unregister(&iommu->pmu->pmu);
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
+		return;
+
+	iommu_pmu_cpuhp_free(iommu_pmu);
+	perf_pmu_unregister(&iommu_pmu->pmu);
 }
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
index 988210a0e8ce..d7af4919302e 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
@@ -27,3 +27,11 @@ Description:	Read-only.  Attribute group to describe the magic bits
 		    filter_pasid	= "config2:0-21"  - PASID filter
 		    filter_ats		= "config2:24-28" - Address Type filter
 		    filter_page_table	= "config2:32-36" - Page Table Level filter
+
+What:		/sys/bus/event_source/devices/dmar*/cpumask
+Date:		Jan 2023
+KernelVersion:	6.3
+Contact:	Kan Liang <kan.liang@linux.intel.com>
+Description:	Read-only. This file always returns the CPU to which the
+		IOMMU pmu is bound for access to all IOMMU pmu performance
+		monitoring events.
-- 
2.34.1

