Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB9675A8A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjATQy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjATQyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:54:50 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FADB3E0A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674233688; x=1705769688;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BVdTbE7OiLOvOKccueDG9CLcflkjD3dI2bKS6By0FhY=;
  b=KcUXuKfXnTC4/OW5nYQkSO9Odf+CW4ivQkPOk9YZdFMMBFdez7+mSJdc
   Vq3af6sYebg2aLnr+YdSqi3dHpDuMIVxhhs8f6Oxg6wvYA4SJyT+IqMpz
   O/mLLCAAtZYYOGss0hQ7Dd5QLVE8S4a6LYU8zeXt01Ar+J7O7R/83H76E
   XJBb5JMGveEARsDJ+5qrNNhIK1qlIxWuyom0SoNdXQD27hLPDHK5C9tzX
   GOzKza0h5gSamBx4Jg5RE07qtGV0mOyV7yLZPK3gXoDKbwhI0Ffqb7Snq
   JkSvWaI3yj7+bmohR92BPt5D36HagCGCqp78gF8Wt2mCu1Hy1hK3r1uux
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="324315186"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="324315186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:54:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="638207834"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="638207834"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2023 08:54:46 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/7] iommu/vt-d: Retrieve IOMMU perfmon capability information
Date:   Fri, 20 Jan 2023 08:54:03 -0800
Message-Id: <20230120165408.500511-3-kan.liang@linux.intel.com>
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

The performance monitoring infrastructure, perfmon, is to support
collection of information about key events occurring during operation of
the remapping hardware, to aid performance tuning and debug. Each
remapping hardware unit has capability registers that indicate support
for performance monitoring features and enumerate the capabilities.

Add alloc_iommu_pmu() to retrieve IOMMU perfmon capability information
for each iommu unit. The information is stored in the iommu->pmu data
structure. Capability registers are read-only, so it's safe to prefetch
and store them in the pmu structure. This could avoid unnecessary VMEXIT
when this code is running in the virtualization environment.

Add free_iommu_pmu() to free the saved capability information when
freeing the iommu unit.

Add a kernel config option for the IOMMU perfmon feature. Unless a user
explicitly uses the perf tool to monitor the IOMMU perfmon event, there
isn't any impact for the existing IOMMU. Enable it by default.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/Kconfig   |   9 ++
 drivers/iommu/intel/Makefile  |   1 +
 drivers/iommu/intel/dmar.c    |   7 ++
 drivers/iommu/intel/iommu.h   |  41 ++++++++
 drivers/iommu/intel/perfmon.c | 172 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/perfmon.h |  41 ++++++++
 6 files changed, 271 insertions(+)
 create mode 100644 drivers/iommu/intel/perfmon.c
 create mode 100644 drivers/iommu/intel/perfmon.h

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index b7dff5092fd2..1a4aebddc9a6 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -96,4 +96,13 @@ config INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
 	  passing intel_iommu=sm_on to the kernel. If not sure, please use
 	  the default value.
 
+config INTEL_IOMMU_PERF_EVENTS
+	def_bool y
+	bool "Intel IOMMU performance events"
+	depends on INTEL_IOMMU && PERF_EVENTS
+	help
+	  Include support for Intel IOMMU performance events. These are
+	  available on modern processors which support Intel VT-d 4.0 and
+	  later.
+
 endif # INTEL_IOMMU
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index fa0dae16441c..7af3b8a4f2a0 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
+obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 3a40fef1ec1b..7a03cadb13ff 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -34,6 +34,7 @@
 #include "../irq_remapping.h"
 #include "perf.h"
 #include "trace.h"
+#include "perfmon.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
@@ -1106,6 +1107,9 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	if (sts & DMA_GSTS_QIES)
 		iommu->gcmd |= DMA_GCMD_QIE;
 
+	if (alloc_iommu_pmu(iommu))
+		pr_debug("Cannot alloc PMU for iommu (seq_id = %d)\n", iommu->seq_id);
+
 	raw_spin_lock_init(&iommu->register_lock);
 
 	/*
@@ -1140,6 +1144,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 err_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
 err_unmap:
+	free_iommu_pmu(iommu);
 	unmap_iommu(iommu);
 error_free_seq_id:
 	ida_free(&dmar_seq_ids, iommu->seq_id);
@@ -1155,6 +1160,8 @@ static void free_iommu(struct intel_iommu *iommu)
 		iommu_device_sysfs_remove(&iommu->iommu);
 	}
 
+	free_iommu_pmu(iommu);
+
 	if (iommu->irq) {
 		if (iommu->pr_irq) {
 			free_irq(iommu->pr_irq, iommu);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 06e61e474856..5bcefbea55c9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -125,6 +125,11 @@
 #define DMAR_MTRR_PHYSMASK8_REG 0x208
 #define DMAR_MTRR_PHYSBASE9_REG 0x210
 #define DMAR_MTRR_PHYSMASK9_REG 0x218
+#define DMAR_PERFCAP_REG	0x300
+#define DMAR_PERFCFGOFF_REG	0x310
+#define DMAR_PERFOVFOFF_REG	0x318
+#define DMAR_PERFCNTROFF_REG	0x31c
+#define DMAR_PERFEVNTCAP_REG	0x380
 #define DMAR_VCCAP_REG		0xe30 /* Virtual command capability register */
 #define DMAR_VCMD_REG		0xe00 /* Virtual command register */
 #define DMAR_VCRSP_REG		0xe10 /* Virtual command response register */
@@ -148,6 +153,7 @@
  */
 #define cap_esrtps(c)		(((c) >> 63) & 1)
 #define cap_esirtps(c)		(((c) >> 62) & 1)
+#define cap_ecmds(c)		(((c) >> 61) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
 #define cap_fl1gp_support(c)	(((c) >> 56) & 1)
@@ -179,6 +185,7 @@
  * Extended Capability Register
  */
 
+#define ecap_pms(e)		(((e) >> 51) & 0x1)
 #define	ecap_rps(e)		(((e) >> 49) & 0x1)
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
@@ -210,6 +217,22 @@
 #define ecap_max_handle_mask(e) (((e) >> 20) & 0xf)
 #define ecap_sc_support(e)	(((e) >> 7) & 0x1) /* Snooping Control */
 
+/*
+ * Decoding Perf Capability Register
+ */
+#define pcap_num_cntr(p)	((p) & 0xffff)
+#define pcap_cntr_width(p)	(((p) >> 16) & 0x7f)
+#define pcap_num_event_group(p)	(((p) >> 24) & 0x1f)
+#define pcap_filters_mask(p)	(((p) >> 32) & 0x1f)
+#define pcap_interrupt(p)	(((p) >> 50) & 0x1)
+/* The counter stride is calculated as 2 ^ (x+10) bytes */
+#define pcap_cntr_stride(p)	(1ULL << ((((p) >> 52) & 0x7) + 10))
+
+/*
+ * Decoding Perf Event Capability Register
+ */
+#define pecap_es(p)		((p) & 0xfffffff)
+
 /* Virtual command interface capability */
 #define vccap_pasid(v)		(((v) & DMA_VCS_PAS)) /* PASID allocation */
 
@@ -554,6 +577,22 @@ struct dmar_domain {
 					   iommu core */
 };
 
+struct iommu_pmu {
+	struct intel_iommu	*iommu;
+	u32			num_cntr;	/* Number of counters */
+	u32			num_eg;		/* Number of event group */
+	u32			cntr_width;	/* Counter width */
+	u32			cntr_stride;	/* Counter Stride */
+	u32			filter;		/* Bitmask of filter support */
+	void __iomem		*base;		/* the PerfMon base address */
+	void __iomem		*cfg_reg;	/* counter configuration base address */
+	void __iomem		*cntr_reg;	/* counter 0 address*/
+	void __iomem		*overflow;	/* overflow status register */
+
+	u64			*evcap;		/* Indicates all supported events */
+	u32			**cntr_evcap;	/* Supported events of each counter. */
+};
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -600,6 +639,8 @@ struct intel_iommu {
 
 	struct dmar_drhd_unit *drhd;
 	void *perf_statistic;
+
+	struct iommu_pmu *pmu;
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
new file mode 100644
index 000000000000..d8a9de537f19
--- /dev/null
+++ b/drivers/iommu/intel/perfmon.c
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Support Intel IOMMU PerfMon
+ * Copyright(c) 2023 Intel Corporation.
+ */
+
+#include <linux/dmar.h>
+#include "iommu.h"
+#include "perfmon.h"
+
+static inline void __iomem *
+get_perf_reg_address(struct intel_iommu *iommu, u32 offset)
+{
+	u32 off = dmar_readl(iommu->reg + offset);
+
+	return iommu->reg + off;
+}
+
+int alloc_iommu_pmu(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu;
+	int i, j, ret;
+	u64 perfcap;
+	u32 cap;
+
+	if (!ecap_pms(iommu->ecap))
+		return 0;
+
+	/* The IOMMU PMU requires the ECMD support as well */
+	if (!cap_ecmds(iommu->cap))
+		return -ENODEV;
+
+	perfcap = dmar_readq(iommu->reg + DMAR_PERFCAP_REG);
+	/* The performance monitoring is not supported. */
+	if (!perfcap)
+		return -ENODEV;
+
+	/* Sanity check for the number of the counters and event groups */
+	if (!pcap_num_cntr(perfcap) || !pcap_num_event_group(perfcap))
+		return -ENODEV;
+
+	/* The interrupt on overflow is required */
+	if (!pcap_interrupt(perfcap))
+		return -ENODEV;
+
+	iommu_pmu = kzalloc(sizeof(*iommu_pmu), GFP_KERNEL);
+	if (!iommu_pmu)
+		return -ENOMEM;
+
+	iommu_pmu->num_cntr = pcap_num_cntr(perfcap);
+	iommu_pmu->cntr_width = pcap_cntr_width(perfcap);
+	iommu_pmu->filter = pcap_filters_mask(perfcap);
+	iommu_pmu->cntr_stride = pcap_cntr_stride(perfcap);
+	iommu_pmu->num_eg = pcap_num_event_group(perfcap);
+
+	iommu_pmu->evcap = kcalloc(iommu_pmu->num_eg, sizeof(u64), GFP_KERNEL);
+	if (!iommu_pmu->evcap) {
+		ret = -ENOMEM;
+		goto free_pmu;
+	}
+
+	/* Parse event group capabilities */
+	for (i = 0; i < iommu_pmu->num_eg; i++) {
+		u64 pcap;
+
+		pcap = dmar_readq(iommu->reg + DMAR_PERFEVNTCAP_REG +
+				  i * IOMMU_PMU_CAP_REGS_STEP);
+		iommu_pmu->evcap[i] = pecap_es(pcap);
+	}
+
+	iommu_pmu->cntr_evcap = kcalloc(iommu_pmu->num_cntr, sizeof(u32 *), GFP_KERNEL);
+	if (!iommu_pmu->cntr_evcap) {
+		ret = -ENOMEM;
+		goto free_pmu_evcap;
+	}
+	for (i = 0; i < iommu_pmu->num_cntr; i++) {
+		iommu_pmu->cntr_evcap[i] = kcalloc(iommu_pmu->num_eg, sizeof(u32), GFP_KERNEL);
+		if (!iommu_pmu->cntr_evcap[i]) {
+			ret = -ENOMEM;
+			goto free_pmu_cntr_evcap;
+		}
+		/*
+		 * Set to the global capabilities, will adjust according
+		 * to per-counter capabilities later.
+		 */
+		for (j = 0; j < iommu_pmu->num_eg; j++)
+			iommu_pmu->cntr_evcap[i][j] = (u32)iommu_pmu->evcap[j];
+	}
+
+	iommu_pmu->cfg_reg = get_perf_reg_address(iommu, DMAR_PERFCFGOFF_REG);
+	iommu_pmu->cntr_reg = get_perf_reg_address(iommu, DMAR_PERFCNTROFF_REG);
+	iommu_pmu->overflow = get_perf_reg_address(iommu, DMAR_PERFOVFOFF_REG);
+
+	/*
+	 * Check per-counter capabilities. All counters should have the
+	 * same capabilities on Interrupt on Overflow Support and Counter
+	 * Width.
+	 */
+	for (i = 0; i < iommu_pmu->num_cntr; i++) {
+		cap = dmar_readl(iommu_pmu->cfg_reg +
+				 i * IOMMU_PMU_CFG_OFFSET +
+				 IOMMU_PMU_CFG_CNTRCAP_OFFSET);
+		if (!iommu_cntrcap_pcc(cap))
+			continue;
+
+		/*
+		 * It's possible that some counters have a different
+		 * capability because of e.g., HW bug. Check the corner
+		 * case here and simply drop those counters.
+		 */
+		if ((iommu_cntrcap_cw(cap) != iommu_pmu->cntr_width) ||
+		    !iommu_cntrcap_ios(cap)) {
+			iommu_pmu->num_cntr = i;
+			pr_warn("The counters have different Interrupt on "
+				"Overflow capability or Counter Width. "
+				"Reduce the number of PMU counter to %d for "
+				"iommu (seq_id = %d)\n", i, iommu->seq_id);
+		}
+
+		/* Clear the pre-defined events group */
+		for (j = 0; j < iommu_pmu->num_eg; j++)
+			iommu_pmu->cntr_evcap[i][j] = 0;
+
+		/* Override with per-counter event capabilities */
+		for (j = 0; j < iommu_cntrcap_egcnt(cap); j++) {
+			cap = dmar_readl(iommu_pmu->cfg_reg + i * IOMMU_PMU_CFG_OFFSET +
+					 IOMMU_PMU_CFG_CNTREVCAP_OFFSET +
+					 (j * IOMMU_PMU_OFF_REGS_STEP));
+			iommu_pmu->cntr_evcap[i][iommu_event_group(cap)] = iommu_event_select(cap);
+			/*
+			 * Some events may only be supported by a specific counter.
+			 * Track them in the evcap as well.
+			 */
+			iommu_pmu->evcap[iommu_event_group(cap)] |= iommu_event_select(cap);
+		}
+	}
+
+	iommu_pmu->iommu = iommu;
+	iommu->pmu = iommu_pmu;
+
+	return 0;
+
+free_pmu_cntr_evcap:
+	for (i = 0; i < iommu_pmu->num_cntr; i++)
+		kfree(iommu_pmu->cntr_evcap[i]);
+	kfree(iommu_pmu->cntr_evcap);
+free_pmu_evcap:
+	kfree(iommu_pmu->evcap);
+free_pmu:
+	kfree(iommu_pmu);
+
+	return ret;
+}
+
+void free_iommu_pmu(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+
+	if (!iommu_pmu)
+		return;
+
+	if (iommu_pmu->evcap) {
+		int i;
+
+		for (i = 0; i < iommu_pmu->num_cntr; i++)
+			kfree(iommu_pmu->cntr_evcap[i]);
+		kfree(iommu_pmu->cntr_evcap);
+	}
+	kfree(iommu_pmu->evcap);
+	kfree(iommu_pmu);
+	iommu->pmu = NULL;
+}
diff --git a/drivers/iommu/intel/perfmon.h b/drivers/iommu/intel/perfmon.h
new file mode 100644
index 000000000000..8587c80501cd
--- /dev/null
+++ b/drivers/iommu/intel/perfmon.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * PERFCFGOFF_REG, PERFFRZOFF_REG
+ * PERFOVFOFF_REG, PERFCNTROFF_REG
+ */
+#define IOMMU_PMU_NUM_OFF_REGS			4
+#define IOMMU_PMU_OFF_REGS_STEP			4
+
+#define IOMMU_PMU_CFG_OFFSET			0x100
+#define IOMMU_PMU_CFG_CNTRCAP_OFFSET		0x80
+#define IOMMU_PMU_CFG_CNTREVCAP_OFFSET		0x84
+#define IOMMU_PMU_CFG_SIZE			0x8
+#define IOMMU_PMU_CFG_FILTERS_OFFSET		0x4
+
+
+#define IOMMU_PMU_CAP_REGS_STEP			8
+
+#define iommu_cntrcap_pcc(p)			((p) & 0x1)
+#define iommu_cntrcap_cw(p)			((p >> 8) & 0xff)
+#define iommu_cntrcap_ios(p)			((p >> 16) & 0x1)
+#define iommu_cntrcap_egcnt(p)			((p >> 28) & 0xf)
+
+#define iommu_event_select(p)			((p) & 0xfffffff)
+#define iommu_event_group(p)			((p >> 28) & 0xf)
+
+#ifdef CONFIG_INTEL_IOMMU_PERF_EVENTS
+int alloc_iommu_pmu(struct intel_iommu *iommu);
+void free_iommu_pmu(struct intel_iommu *iommu);
+#else
+static inline int
+alloc_iommu_pmu(struct intel_iommu *iommu)
+{
+	return 0;
+}
+
+static inline void
+free_iommu_pmu(struct intel_iommu *iommu)
+{
+}
+#endif /* CONFIG_INTEL_IOMMU_PERF_EVENTS */
-- 
2.35.1

