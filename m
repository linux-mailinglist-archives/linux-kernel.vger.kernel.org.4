Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FA6694E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241521AbjAMKzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241200AbjAMKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:48 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218277816D;
        Fri, 13 Jan 2023 02:52:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3FB7F42462;
        Fri, 13 Jan 2023 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673607119; bh=mG3NRAZAV+UBx4Xvm5DWiRmT3F55WtTracCeUatlMoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c/hHoA3GDnC7lbvESA1dL5QcOWTHSAbkJtFnHcYLeDiTRcFuvUSf7avULLfByXHnC
         B/eXxT9gDNc81XNtopHFv0tYyZRkWf1BxVExcBdgvpgMrf4WOOsiO2AX5ndrGAX2qb
         cz0BN6IAbkP0FTTJXo79fz0jNTMrkMvD+74U1yOBLbX+q6UmDnxYF/f1FkY+yjq9rp
         e9y/pAmkzt36jvtaS3H2T631wPS8gpZQVUTADrxI8GCQrYcAT/tvVWytbldCHEm+E8
         KcKE5zQawf+M3IW7nOxSWRaT5gz6ALnJWcF5hidXqAXuXc+Q6pc9BfuF2RAj42uySp
         WO0MLEZblTHBA==
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH 7/7] iommu: dart: Add t8110 DART support
Date:   Fri, 13 Jan 2023 19:50:30 +0900
Message-Id: <20230113105029.26654-8-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230113105029.26654-1-marcan@marcan.st>
References: <20230113105029.26654-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have the driver properly parameterized, we can add support
for T8110 DARTs. These DARTs drop the multiple TTBRs (which only make
sense with legacy 4K page platforms) and instead add support for new
features and more stream IDs. The register layout is different, but the
pagetable format is the same as T6000.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 205 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 200 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 75647433df9d..42666617803d 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -85,6 +85,62 @@
 #define DART_T8020_TTBR_ADDR_FIELD_SHIFT 0
 #define DART_T8020_TTBR_SHIFT 12
 
+/* T8110 registers */
+
+#define DART_T8110_PARAMS3 0x08
+#define DART_T8110_PARAMS3_PA_WIDTH GENMASK(29, 24)
+#define DART_T8110_PARAMS3_VA_WIDTH GENMASK(21, 16)
+#define DART_T8110_PARAMS3_VER_MAJ GENMASK(15, 8)
+#define DART_T8110_PARAMS3_VER_MIN GENMASK(7, 0)
+
+#define DART_T8110_PARAMS4 0x0c
+#define DART_T8110_PARAMS4_NUM_CLIENTS GENMASK(24, 16)
+#define DART_T8110_PARAMS4_NUM_SIDS GENMASK(8, 0)
+
+#define DART_T8110_TLB_CMD              0x80
+#define DART_T8110_TLB_CMD_BUSY         BIT(31)
+#define DART_T8110_TLB_CMD_OP           GENMASK(10, 8)
+#define DART_T8110_TLB_CMD_OP_FLUSH_ALL 0
+#define DART_T8110_TLB_CMD_OP_FLUSH_SID 1
+#define DART_T8110_TLB_CMD_STREAM       GENMASK(7, 0)
+
+#define DART_T8110_ERROR 0x100
+#define DART_T8110_ERROR_STREAM GENMASK(27, 20)
+#define DART_T8110_ERROR_CODE GENMASK(14, 0)
+#define DART_T8110_ERROR_FLAG BIT(31)
+
+#define DART_T8110_ERROR_MASK 0x104
+
+#define DART_T8110_ERROR_READ_FAULT BIT(4)
+#define DART_T8110_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8110_ERROR_NO_PTE BIT(3)
+#define DART_T8110_ERROR_NO_PMD BIT(2)
+#define DART_T8110_ERROR_NO_PGD BIT(1)
+#define DART_T8110_ERROR_NO_TTBR BIT(0)
+
+#define DART_T8110_ERROR_ADDR_LO 0x170
+#define DART_T8110_ERROR_ADDR_HI 0x174
+
+#define DART_T8110_PROTECT 0x200
+#define DART_T8110_UNPROTECT 0x204
+#define DART_T8110_PROTECT_LOCK 0x208
+#define DART_T8110_PROTECT_TTBR_TCR BIT(0)
+
+#define DART_T8110_ENABLE_STREAMS  0xc00
+#define DART_T8110_DISABLE_STREAMS 0xc20
+
+#define DART_T8110_TCR                  0x1000
+#define DART_T8110_TCR_REMAP            GENMASK(11, 8)
+#define DART_T8110_TCR_REMAP_EN         BIT(7)
+#define DART_T8110_TCR_BYPASS_DAPF      BIT(2)
+#define DART_T8110_TCR_BYPASS_DART      BIT(1)
+#define DART_T8110_TCR_TRANSLATE_ENABLE BIT(0)
+
+#define DART_T8110_TTBR       0x1400
+#define DART_T8110_TTBR_VALID BIT(0)
+#define DART_T8110_TTBR_ADDR_FIELD_SHIFT 2
+#define DART_T8110_TTBR_SHIFT 14
+
 #define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
 
 #define DART_TTBR(dart, sid, idx) ((dart)->hw->ttbr + \
@@ -93,7 +149,14 @@
 
 struct apple_dart_stream_map;
 
+enum dart_type {
+	DART_T8020,
+	DART_T6000,
+	DART_T8110,
+};
+
 struct apple_dart_hw {
+	enum dart_type type;
 	irqreturn_t (*irq_handler)(int irq, void *dev);
 	int (*invalidate_tlb)(struct apple_dart_stream_map *stream_map);
 
@@ -149,6 +212,8 @@ struct apple_dart {
 
 	spinlock_t lock;
 
+	u32 ias;
+	u32 oas;
 	u32 pgsize;
 	u32 num_streams;
 	u32 supports_bypass : 1;
@@ -330,6 +395,44 @@ apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
 	return 0;
 }
 
+static int
+apple_dart_t8110_hw_tlb_command(struct apple_dart_stream_map *stream_map,
+				u32 command)
+{
+	struct apple_dart *dart = stream_map->dart;
+	unsigned long flags;
+	int ret = 0;
+	int sid;
+
+	spin_lock_irqsave(&dart->lock, flags);
+
+	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams) {
+		u32 val = FIELD_PREP(DART_T8110_TLB_CMD_OP, command) |
+			FIELD_PREP(DART_T8110_TLB_CMD_STREAM, sid);
+		writel(val, dart->regs + DART_T8110_TLB_CMD);
+
+		ret = readl_poll_timeout_atomic(
+			dart->regs + DART_T8110_TLB_CMD, val,
+			!(val & DART_T8110_TLB_CMD_BUSY), 1,
+			DART_STREAM_COMMAND_BUSY_TIMEOUT);
+
+		if (ret)
+			break;
+
+	}
+
+	spin_unlock_irqrestore(&dart->lock, flags);
+
+	if (ret) {
+		dev_err(stream_map->dart->dev,
+			"busy bit did not clear after command %x for stream %d\n",
+			command, sid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int
 apple_dart_t8020_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
 {
@@ -337,6 +440,13 @@ apple_dart_t8020_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
 		stream_map, DART_T8020_STREAM_COMMAND_INVALIDATE);
 }
 
+static int
+apple_dart_t8110_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
+{
+	return apple_dart_t8110_hw_tlb_command(
+		stream_map, DART_T8110_TLB_CMD_OP_FLUSH_SID);
+}
+
 static int apple_dart_hw_reset(struct apple_dart *dart)
 {
 	u32 config;
@@ -363,6 +473,9 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 	/* clear any pending errors before the interrupt is unmasked */
 	writel(readl(dart->regs + dart->hw->error), dart->regs + dart->hw->error);
 
+	if (dart->hw->type == DART_T8110)
+		writel(0,  dart->regs + DART_T8110_ERROR_MASK);
+
 	return dart->hw->invalidate_tlb(&stream_map);
 }
 
@@ -478,8 +591,8 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 
 	pgtbl_cfg = (struct io_pgtable_cfg){
 		.pgsize_bitmap = dart->pgsize,
-		.ias = 32,
-		.oas = dart->hw->oas,
+		.ias = dart->ias,
+		.oas = dart->oas,
 		.coherent_walk = 1,
 		.iommu_dev = dart->dev,
 	};
@@ -493,7 +606,7 @@ static int apple_dart_finalize_domain(struct iommu_domain *domain,
 
 	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
 	domain->geometry.aperture_start = 0;
-	domain->geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->geometry.aperture_end = (dma_addr_t)DMA_BIT_MASK(dart->ias);
 	domain->geometry.force_aperture = true;
 
 	dart_domain->finalized = true;
@@ -880,10 +993,49 @@ static irqreturn_t apple_dart_t8020_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t apple_dart_t8110_irq(int irq, void *dev)
+{
+	struct apple_dart *dart = dev;
+	const char *fault_name = NULL;
+	u32 error = readl(dart->regs + DART_T8110_ERROR);
+	u32 error_code = FIELD_GET(DART_T8110_ERROR_CODE, error);
+	u32 addr_lo = readl(dart->regs + DART_T8110_ERROR_ADDR_LO);
+	u32 addr_hi = readl(dart->regs + DART_T8110_ERROR_ADDR_HI);
+	u64 addr = addr_lo | (((u64)addr_hi) << 32);
+	u8 stream_idx = FIELD_GET(DART_T8110_ERROR_STREAM, error);
+
+	if (!(error & DART_T8110_ERROR_FLAG))
+		return IRQ_NONE;
+
+	/* there should only be a single bit set but let's use == to be sure */
+	if (error_code == DART_T8110_ERROR_READ_FAULT)
+		fault_name = "READ FAULT";
+	else if (error_code == DART_T8110_ERROR_WRITE_FAULT)
+		fault_name = "WRITE FAULT";
+	else if (error_code == DART_T8110_ERROR_NO_PTE)
+		fault_name = "NO PTE FOR IOVA";
+	else if (error_code == DART_T8110_ERROR_NO_PMD)
+		fault_name = "NO PMD FOR IOVA";
+	else if (error_code == DART_T8110_ERROR_NO_PGD)
+		fault_name = "NO PGD FOR IOVA";
+	else if (error_code == DART_T8110_ERROR_NO_TTBR)
+		fault_name = "NO TTBR FOR IOVA";
+	else
+		fault_name = "unknown";
+
+	dev_err_ratelimited(
+		dart->dev,
+		"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
+		error, stream_idx, error_code, fault_name, addr);
+
+	writel(error, dart->regs + DART_T8110_ERROR);
+	return IRQ_HANDLED;
+}
+
 static int apple_dart_probe(struct platform_device *pdev)
 {
 	int ret;
-	u32 dart_params[2];
+	u32 dart_params[4];
 	struct resource *res;
 	struct apple_dart *dart;
 	struct device *dev = &pdev->dev;
@@ -923,7 +1075,22 @@ static int apple_dart_probe(struct platform_device *pdev)
 	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
 	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
 
-	dart->num_streams = dart->hw->max_sid_count;
+	switch (dart->hw->type) {
+	case DART_T8020:
+	case DART_T6000:
+		dart->ias = 32;
+		dart->oas = dart->hw->oas;
+		dart->num_streams = dart->hw->max_sid_count;
+		break;
+
+	case DART_T8110:
+		dart_params[2] = readl(dart->regs + DART_T8110_PARAMS3);
+		dart_params[3] = readl(dart->regs + DART_T8110_PARAMS4);
+		dart->ias = FIELD_GET(DART_T8110_PARAMS3_VA_WIDTH, dart_params[2]);
+		dart->oas = FIELD_GET(DART_T8110_PARAMS3_PA_WIDTH, dart_params[2]);
+		dart->num_streams = FIELD_GET(DART_T8110_PARAMS4_NUM_SIDS, dart_params[3]);
+		break;
+	}
 
 	if (dart->num_streams > DART_MAX_STREAMS) {
 		dev_err(&pdev->dev, "Too many streams (%d > %d)\n",
@@ -986,6 +1153,7 @@ static int apple_dart_remove(struct platform_device *pdev)
 }
 
 static const struct apple_dart_hw apple_dart_hw_t8103 = {
+	.type = DART_T8020,
 	.irq_handler = apple_dart_t8020_irq,
 	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
 	.oas = 36,
@@ -1010,6 +1178,7 @@ static const struct apple_dart_hw apple_dart_hw_t8103 = {
 	.ttbr_count = 4,
 };
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
+	.type = DART_T6000,
 	.irq_handler = apple_dart_t8020_irq,
 	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
 	.oas = 42,
@@ -1034,6 +1203,31 @@ static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.ttbr_count = 4,
 };
 
+static const struct apple_dart_hw apple_dart_hw_t8110 = {
+	.type = DART_T8110,
+	.irq_handler = apple_dart_t8110_irq,
+	.invalidate_tlb = apple_dart_t8110_hw_invalidate_tlb,
+	.fmt = APPLE_DART2,
+	.max_sid_count = 256,
+
+	.enable_streams = DART_T8110_ENABLE_STREAMS,
+	.lock = DART_T8110_PROTECT,
+	.lock_bit = DART_T8110_PROTECT_TTBR_TCR,
+
+	.error = DART_T8110_ERROR,
+
+	.tcr = DART_T8110_TCR,
+	.tcr_enabled = DART_T8110_TCR_TRANSLATE_ENABLE,
+	.tcr_disabled = 0,
+	.tcr_bypass = DART_T8110_TCR_BYPASS_DAPF | DART_T8110_TCR_BYPASS_DART,
+
+	.ttbr = DART_T8110_TTBR,
+	.ttbr_valid = DART_T8110_TTBR_VALID,
+	.ttbr_addr_field_shift = DART_T8110_TTBR_ADDR_FIELD_SHIFT,
+	.ttbr_shift = DART_T8110_TTBR_SHIFT,
+	.ttbr_count = 1,
+};
+
 static __maybe_unused int apple_dart_suspend(struct device *dev)
 {
 	struct apple_dart *dart = dev_get_drvdata(dev);
@@ -1075,6 +1269,7 @@ DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resum
 
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
+	{ .compatible = "apple,t8110-dart", .data = &apple_dart_hw_t8110 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
 	{},
 };
-- 
2.35.1

