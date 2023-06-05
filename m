Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16D722D35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjFERCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjFERBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:01:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F0A0A6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:01:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90EA015BF;
        Mon,  5 Jun 2023 10:02:36 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F4753F587;
        Mon,  5 Jun 2023 10:01:49 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     will@kernel.org
Cc:     mark.rutland@arm.com, suzuki.poulose@arm.com,
        bwicaksono@nvidia.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] perf/arm_cspmu: Decouple APMT dependency
Date:   Mon,  5 Jun 2023 18:01:34 +0100
Message-Id: <88f97268603e1aa6016d178982a1dc2861f6770d.1685983270.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1685983270.git.robin.murphy@arm.com>
References: <cover.1685983270.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functional paths of the driver need not care about ACPI, so abstract
the property of atomic doubleword access as its own flag (repacking the
structure for a better fit). We also do not need to go poking directly
at the APMT for standard resources which the ACPI layer has already
dealt with, so deal with the optional MMIO page and interrupt in the
normal firmware-agnostic manner. The few remaining portions of probing
that *are* APMT-specific can still easily retrieve the APMT pointer as
needed without us having to carry a duplicate copy around everywhere.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>

---
v2: Fix platdata dereferences, clean up now-unused acpi.h include too.
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 54 ++++++++++--------------------
 drivers/perf/arm_cspmu/arm_cspmu.h |  5 ++-
 2 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 3b91115c376d..38e1170af347 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -100,10 +100,6 @@
 #define ARM_CSPMU_ACTIVE_CPU_MASK		0x0
 #define ARM_CSPMU_ASSOCIATED_CPU_MASK		0x1
 
-/* Check if field f in flags is set with value v */
-#define CHECK_APMT_FLAG(flags, f, v) \
-	((flags & (ACPI_APMT_FLAGS_ ## f)) == (ACPI_APMT_FLAGS_ ## f ## _ ## v))
-
 /* Check and use default if implementer doesn't provide attribute callback */
 #define CHECK_DEFAULT_IMPL_OPS(ops, callback)			\
 	do {							\
@@ -121,6 +117,11 @@
 
 static unsigned long arm_cspmu_cpuhp_state;
 
+static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
+{
+	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
+}
+
 /*
  * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
  * counter register. The counter register can be implemented as 32-bit or 64-bit
@@ -155,12 +156,6 @@ static u64 read_reg64_hilohi(const void __iomem *addr, u32 max_poll_count)
 	return val;
 }
 
-/* Check if PMU supports 64-bit single copy atomic. */
-static inline bool supports_64bit_atomics(const struct arm_cspmu *cspmu)
-{
-	return CHECK_APMT_FLAG(cspmu->apmt_node->flags, ATOMIC, SUPP);
-}
-
 /* Check if cycle counter is supported. */
 static inline bool supports_cycle_counter(const struct arm_cspmu *cspmu)
 {
@@ -319,7 +314,7 @@ static const char *arm_cspmu_get_name(const struct arm_cspmu *cspmu)
 	static atomic_t pmu_idx[ACPI_APMT_NODE_TYPE_COUNT] = { 0 };
 
 	dev = cspmu->dev;
-	apmt_node = cspmu->apmt_node;
+	apmt_node = arm_cspmu_apmt_node(dev);
 	pmu_type = apmt_node->type;
 
 	if (pmu_type >= ACPI_APMT_NODE_TYPE_COUNT) {
@@ -396,8 +391,8 @@ static const struct impl_match impl_match[] = {
 static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 {
 	int ret;
-	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
+	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
 	const struct impl_match *match = impl_match;
 
 	/*
@@ -719,7 +714,7 @@ static u64 arm_cspmu_read_counter(struct perf_event *event)
 		offset = counter_offset(sizeof(u64), event->hw.idx);
 		counter_addr = cspmu->base1 + offset;
 
-		return supports_64bit_atomics(cspmu) ?
+		return cspmu->has_atomic_dword ?
 			       readq(counter_addr) :
 			       read_reg64_hilohi(counter_addr, HILOHI_MAX_POLL);
 	}
@@ -910,24 +905,18 @@ static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
 {
 	struct acpi_apmt_node *apmt_node;
 	struct arm_cspmu *cspmu;
-	struct device *dev;
-
-	dev = &pdev->dev;
-	apmt_node = *(struct acpi_apmt_node **)dev_get_platdata(dev);
-	if (!apmt_node) {
-		dev_err(dev, "failed to get APMT node\n");
-		return NULL;
-	}
+	struct device *dev = &pdev->dev;
 
 	cspmu = devm_kzalloc(dev, sizeof(*cspmu), GFP_KERNEL);
 	if (!cspmu)
 		return NULL;
 
 	cspmu->dev = dev;
-	cspmu->apmt_node = apmt_node;
-
 	platform_set_drvdata(pdev, cspmu);
 
+	apmt_node = arm_cspmu_apmt_node(dev);
+	cspmu->has_atomic_dword = apmt_node->flags & ACPI_APMT_FLAGS_ATOMIC;
+
 	return cspmu;
 }
 
@@ -935,11 +924,9 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
 {
 	struct device *dev;
 	struct platform_device *pdev;
-	struct acpi_apmt_node *apmt_node;
 
 	dev = cspmu->dev;
 	pdev = to_platform_device(dev);
-	apmt_node = cspmu->apmt_node;
 
 	/* Base address for page 0. */
 	cspmu->base0 = devm_platform_ioremap_resource(pdev, 0);
@@ -950,7 +937,7 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cspmu)
 
 	/* Base address for page 1 if supported. Otherwise point to page 0. */
 	cspmu->base1 = cspmu->base0;
-	if (CHECK_APMT_FLAG(apmt_node->flags, DUAL_PAGE, SUPP)) {
+	if (platform_get_resource(pdev, IORESOURCE_MEM, 1)) {
 		cspmu->base1 = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(cspmu->base1)) {
 			dev_err(dev, "ioremap failed for page-1 resource\n");
@@ -1047,19 +1034,14 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 	int irq, ret;
 	struct device *dev;
 	struct platform_device *pdev;
-	struct acpi_apmt_node *apmt_node;
 
 	dev = cspmu->dev;
 	pdev = to_platform_device(dev);
-	apmt_node = cspmu->apmt_node;
 
 	/* Skip IRQ request if the PMU does not support overflow interrupt. */
-	if (apmt_node->ovflw_irq == 0)
-		return 0;
-
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0)
-		return irq;
+		return irq == -ENXIO ? 0 : irq;
 
 	ret = devm_request_irq(dev, irq, arm_cspmu_handle_irq,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD, dev_name(dev),
@@ -1103,13 +1085,11 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 
 static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 {
-	struct device *dev;
 	struct acpi_apmt_node *apmt_node;
 	int affinity_flag;
 	int cpu;
 
-	dev = cspmu->pmu.dev;
-	apmt_node = cspmu->apmt_node;
+	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
 	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
 
 	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
@@ -1131,7 +1111,7 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
 	}
 
 	if (cpumask_empty(&cspmu->associated_cpus)) {
-		dev_dbg(dev, "No cpu associated with the PMU\n");
+		dev_dbg(cspmu->dev, "No cpu associated with the PMU\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..83df53d1c132 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -8,7 +8,6 @@
 #ifndef __ARM_CSPMU_H__
 #define __ARM_CSPMU_H__
 
-#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
 #include <linux/device.h>
@@ -118,16 +117,16 @@ struct arm_cspmu_impl {
 struct arm_cspmu {
 	struct pmu pmu;
 	struct device *dev;
-	struct acpi_apmt_node *apmt_node;
 	const char *name;
 	const char *identifier;
 	void __iomem *base0;
 	void __iomem *base1;
-	int irq;
 	cpumask_t associated_cpus;
 	cpumask_t active_cpu;
 	struct hlist_node cpuhp_node;
+	int irq;
 
+	bool has_atomic_dword;
 	u32 pmcfgr;
 	u32 num_logical_ctrs;
 	u32 num_set_clr_reg;
-- 
2.39.2.101.g768bb238c484.dirty

