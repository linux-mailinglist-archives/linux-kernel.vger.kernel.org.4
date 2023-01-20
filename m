Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB0B675A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjATQzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjATQyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:54:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F929A24A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674233691; x=1705769691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcZT/7ts8Z1Nd0zZr5T1O31AnNqRthUIEcQh9UoSLFk=;
  b=AAvyOUlO35PO2/eKUukMV8vCLnotvcy6Qb38z/MKIxUlK6yBw0xAiHSy
   MsU8LKsFa74ilqu2wWIyf5RbjbAw2FFPiZ9K267BRFmtyRQgs0cDqreth
   kW3mEE57K8uOgWyro7uNqN4qUlvptrrVutiYdL11yY5xkbL5QP6a9M98D
   0nN1YFqLJbp9FJP30lnK/PQ4F4LuAE5PnNQhNtEEVVRwqZyKQ7GPqmWOs
   vbd2XwQsnshGo7Yne0fmAA7Y5pPsSnOSTYqLd4LedP913bu4GltYaAlns
   leyxPpvaoT0/Pl95TO6neWQ/uNAZc40gv0TP7FJwg9x2oOzwRa+GHMi0I
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324315219"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324315219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638207849"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638207849"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:54:46 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/7] iommu/vt-d: Support cpumask for IOMMU perfmon
Date:   Fri, 20 Jan 2023 08:54:06 -0800
Message-Id: <20230120165408.500511-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230120165408.500511-1-kan.liang@linux.intel.com>
References: <20230120165408.500511-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
---
 .../sysfs-bus-event_source-devices-iommu      |   8 ++
 drivers/iommu/intel/perfmon.c                 | 115 ++++++++++++++++--
 include/linux/cpuhotplug.h                    |   1 +
 3 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
index 04e08851d8e6..3519954fe713 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-iommu
@@ -22,3 +22,11 @@ Description:	Read-only.  Attribute group to describe the magic bits
 		    filter_pasid	= "config1:32-53" - PASID filter
 		    filter_ats		= "config2:0-4"   - Address Type filter
 		    filter_page_table	= "config2:8-12"  - Page Table Level filter
+
+What:		/sys/bus/event_source/devices/dmar*/cpumask
+Date:		Jan 2023
+KernelVersion:	6.3
+Contact:	Kan Liang <kan.liang@linux.intel.com>
+Description:	Read-only.  This file always returns the CPU to which the
+		IOMMU pmu is bound for access to all IOMMU pmu
+		performance monitoring events.
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 06e95b9b88d5..ed06bf121b50 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -32,9 +32,30 @@ static struct attribute_group iommu_pmu_events_attr_group = {
 	.attrs = attrs_empty,
 };
 
+static cpumask_t iommu_pmu_cpu_mask;
+
+static ssize_t iommu_pmu_cpumask_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	return cpumap_print_to_pagebuf(true, buf, &iommu_pmu_cpu_mask);
+}
+
+static DEVICE_ATTR(cpumask, S_IRUGO, iommu_pmu_cpumask_show, NULL);
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
 
@@ -660,20 +681,98 @@ void free_iommu_pmu(struct intel_iommu *iommu)
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
-- 
2.35.1

