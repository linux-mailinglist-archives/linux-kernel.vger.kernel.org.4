Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7284967FAB4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbjA1UEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 15:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjA1UEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 15:04:35 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC65924C89
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674936273; x=1706472273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXAPQ3LaUaYJi2tEWRJQ3eyKEZMZv0J4plwKFluGMpg=;
  b=D/im1qzB+7vkxUHSHXZj+TZzPedrLSxpolEatlMu0G39nP0z/yPUwJTP
   Q/9bro/FCZoSwj+e62JgwOwErB4HJTILyjfIeWd2ZZdAKs4+WUHISUdxi
   88TwrDxBdEFkLDn7as+MskdIX9N9t84aCZUOPeR9eF4EysNSyUG5ZXksn
   m2QxO/zcAdVDMVF2DYnuygfPfAl44iY/jjm/pt55NmJsy9hmSiu75r3Xt
   KGenYDvDQlZj0PSKGjZMM9/ekjfx009MZlgTVGzATtHjg77V2WcsgOUFW
   TSIcb2kLZkxlYEUAxay3Wcv1SsYzVuUip+GJXbsYY+PtOOTwPWewVB0Xe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="325022524"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="325022524"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 12:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="909038379"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="909038379"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2023 12:04:30 -0800
From:   kan.liang@linux.intel.com
To:     joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, robin.murphy@arm.com, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, lenb@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     yu-cheng.yu@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 6/7] iommu/vt-d: Add IOMMU perfmon overflow handler support
Date:   Sat, 28 Jan 2023 12:04:27 -0800
Message-Id: <20230128200428.1459118-7-kan.liang@linux.intel.com>
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

While enabled to count events and an event occurrence causes the counter
value to increment and roll over to or past zero, this is termed a
counter overflow. The overflow can trigger an interrupt. The IOMMU
perfmon needs to handle the case properly.

New HW IRQs are allocated for each IOMMU device for perfmon. The IRQ IDs
are after the SVM range.

In the overflow handler, the counter is not frozen. It's very unlikely
that the same counter overflows again during the period. But it's
possible that other counters overflow at the same time. Read the
overflow register at the end of the handler and check whether there are
more.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 drivers/iommu/intel/dmar.c    |  2 +
 drivers/iommu/intel/iommu.h   | 11 ++++-
 drivers/iommu/intel/perfmon.c | 82 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c     |  2 +-
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 0e429bab436f..43db6ebe8b57 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1879,6 +1879,8 @@ static inline int dmar_msi_reg(struct intel_iommu *iommu, int irq)
 		return DMAR_FECTL_REG;
 	else if (iommu->pr_irq == irq)
 		return DMAR_PECTL_REG;
+	else if (iommu->perf_irq == irq)
+		return DMAR_PERFINTRCTL_REG;
 	else
 		BUG();
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d56b3c386366..d7c61eb20f6f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -130,6 +130,8 @@
 #define DMAR_PERFCFGOFF_REG	0x310
 #define DMAR_PERFOVFOFF_REG	0x318
 #define DMAR_PERFCNTROFF_REG	0x31c
+#define DMAR_PERFINTRSTS_REG	0x324
+#define DMAR_PERFINTRCTL_REG	0x328
 #define DMAR_PERFEVNTCAP_REG	0x380
 #define DMAR_ECMD_REG		0x400
 #define DMAR_ECEO_REG		0x408
@@ -357,6 +359,9 @@
 
 #define DMA_VCS_PAS	((u64)1)
 
+/* PERFINTRSTS_REG */
+#define DMA_PERFINTRSTS_PIS	((u32)1)
+
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
 	cycles_t start_time = get_cycles();				\
@@ -635,8 +640,12 @@ struct iommu_pmu {
 	struct pmu		pmu;
 	DECLARE_BITMAP(used_mask, IOMMU_PMU_IDX_MAX);
 	struct perf_event	*event_list[IOMMU_PMU_IDX_MAX];
+	unsigned char		irq_name[16];
 };
 
+#define IOMMU_IRQ_ID_OFFSET_PRQ		(DMAR_UNITS_SUPPORTED)
+#define IOMMU_IRQ_ID_OFFSET_PERF	(2 * DMAR_UNITS_SUPPORTED)
+
 struct intel_iommu {
 	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
 	u64 		reg_phys; /* physical address of hw register set */
@@ -650,7 +659,7 @@ struct intel_iommu {
 	int		seq_id;	/* sequence id of the iommu */
 	int		agaw; /* agaw of this iommu */
 	int		msagaw; /* max sagaw of this iommu */
-	unsigned int 	irq, pr_irq;
+	unsigned int	irq, pr_irq, perf_irq;
 	u16		segment;     /* PCI segment# */
 	unsigned char 	name[13];    /* Device Name */
 
diff --git a/drivers/iommu/intel/perfmon.c b/drivers/iommu/intel/perfmon.c
index 322d362b85e4..e17d9743a0d8 100644
--- a/drivers/iommu/intel/perfmon.c
+++ b/drivers/iommu/intel/perfmon.c
@@ -505,6 +505,49 @@ static void iommu_pmu_disable(struct pmu *pmu)
 	ecmd_submit_sync(iommu, DMA_ECMD_FREEZE, 0, 0);
 }
 
+static void iommu_pmu_counter_overflow(struct iommu_pmu *iommu_pmu)
+{
+	struct perf_event *event;
+	u64 status;
+	int i;
+
+	/*
+	 * Two counters may be overflowed very close. Always check
+	 * whether there are more to handle.
+	 */
+	while ((status = dmar_readq(iommu_pmu->overflow))) {
+		for_each_set_bit(i, (unsigned long *)&status, iommu_pmu->num_cntr) {
+			/*
+			 * Find the assigned event of the counter.
+			 * Accumulate the value into the event->count.
+			 */
+			event = iommu_pmu->event_list[i];
+			if (!event) {
+				pr_warn_once("Cannot find the assigned event for counter %d\n", i);
+				continue;
+			}
+			iommu_pmu_event_update(event);
+		}
+
+		dmar_writeq(iommu_pmu->overflow, status);
+	}
+}
+
+static irqreturn_t iommu_pmu_irq_handler(int irq, void *dev_id)
+{
+	struct intel_iommu *iommu = dev_id;
+
+	if (!dmar_readl(iommu->reg + DMAR_PERFINTRSTS_REG))
+		return IRQ_NONE;
+
+	iommu_pmu_counter_overflow(iommu->pmu);
+
+	/* Clear the status bit */
+	dmar_writel(iommu->reg + DMAR_PERFINTRSTS_REG, DMA_PERFINTRSTS_PIS);
+
+	return IRQ_HANDLED;
+}
+
 static int __iommu_pmu_register(struct intel_iommu *iommu)
 {
 	struct iommu_pmu *iommu_pmu = iommu->pmu;
@@ -698,6 +741,38 @@ void free_iommu_pmu(struct intel_iommu *iommu)
 	iommu->pmu = NULL;
 }
 
+static int iommu_pmu_set_interrupt(struct intel_iommu *iommu)
+{
+	struct iommu_pmu *iommu_pmu = iommu->pmu;
+	int irq, ret;
+
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PERF + iommu->seq_id, iommu->node, iommu);
+	if (irq <= 0)
+		return -EINVAL;
+
+	snprintf(iommu_pmu->irq_name, sizeof(iommu_pmu->irq_name), "dmar%d-perf", iommu->seq_id);
+
+	iommu->perf_irq = irq;
+	ret = request_threaded_irq(irq, NULL, iommu_pmu_irq_handler,
+				   IRQF_ONESHOT, iommu_pmu->irq_name, iommu);
+	if (ret) {
+		dmar_free_hwirq(irq);
+		iommu->perf_irq = 0;
+		return ret;
+	}
+	return 0;
+}
+
+static void iommu_pmu_unset_interrupt(struct intel_iommu *iommu)
+{
+	if (!iommu->perf_irq)
+		return;
+
+	free_irq(iommu->perf_irq, iommu);
+	dmar_free_hwirq(iommu->perf_irq);
+	iommu->perf_irq = 0;
+}
+
 static int iommu_pmu_cpu_online(unsigned int cpu)
 {
 	if (cpumask_empty(&iommu_pmu_cpu_mask))
@@ -774,8 +849,14 @@ void iommu_pmu_register(struct intel_iommu *iommu)
 	if (iommu_pmu_cpuhp_setup(iommu_pmu))
 		goto unregister;
 
+	/* Set interrupt for overflow */
+	if (iommu_pmu_set_interrupt(iommu))
+		goto cpuhp_free;
+
 	return;
 
+cpuhp_free:
+	iommu_pmu_cpuhp_free(iommu_pmu);
 unregister:
 	perf_pmu_unregister(&iommu_pmu->pmu);
 err:
@@ -790,6 +871,7 @@ void iommu_pmu_unregister(struct intel_iommu *iommu)
 	if (!iommu_pmu)
 		return;
 
+	iommu_pmu_unset_interrupt(iommu);
 	iommu_pmu_cpuhp_free(iommu_pmu);
 	perf_pmu_unregister(&iommu_pmu->pmu);
 }
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e7b9bedebcc0..7367f56c3bad 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -78,7 +78,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
 	}
 	iommu->prq = page_address(pages);
 
-	irq = dmar_alloc_hwirq(DMAR_UNITS_SUPPORTED + iommu->seq_id, iommu->node, iommu);
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
 	if (irq <= 0) {
 		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
 		       iommu->name);
-- 
2.35.1

