Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E379D67FAB3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbjA1UEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjA1UEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:04:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8260824C87
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936273; x=1706472273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0BoJbcxdFtP9XvCk8YKv2BGs4JRjdtTtpdWDD3qJO8=;
  b=SoWokpc8dLz1K03q1S8nlE3H+e9hpj15nk0UE1PklGyD3UaFM7jAaEJb
   sz+e5/vd0OX63kYkLxxXFXoORFmZITt3KOiQx2gIZ52rif+vHLvSgAxzY
   6K9MFYyaBUeMWADfTUatfKny3mrFjt1TcZ0rHELNG1DfqeXRAQl3fN3sN
   8YB0xLypR/c/FSx0LKa1vPIRTG0a7UAzAPfkME3qpkH8xGL33x+OWjGiR
   7KDpcT9EJmw0DZeNLc9iCdAm1TTptp3xcNL5TlKDCNRKizGU4D04qqs2h
   pYtE+WA64UvjpYQ2yORc0GB0m6MGpgWGNBEw8T+G4T617zmNbfzcwTRlz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022518"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022518"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038376"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038376"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:30 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 5/7] iommu/vt-d: Support cpumask for IOMMU perfmon
Date:   Sat, 28 Jan 2023 12:04:26 -0800
Message-Id: <20230128200428.1459118-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230128200428.1459118-1-kan.liang@linux.intel.com>
References: <20230128200428.1459118-1-kan.liang@linux.intel.com>
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
 drivers/iommu/intel/perfmon.c                 | 113 ++++++++++++++++--
 include/linux/cpuhotplug.h                    |   1 +
 3 files changed, 114 insertions(+), 8 deletions(-)

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

