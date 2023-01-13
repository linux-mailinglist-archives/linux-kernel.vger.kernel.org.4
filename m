Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A366694E3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAMKzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbjAMKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:41 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D07577D35;
        Fri, 13 Jan 2023 02:51:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A80FC41A42;
        Fri, 13 Jan 2023 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673607114; bh=Ju2C3rYuZeAAMQDrVFOEXIDcQ7uiTLJGKcK1Xq/Sfi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Or2nRxF3+TX7nKOGGyIL4pQUoPAi5v/dGb9j1yvk5Ha5G0A7Jddz+5qB/Wp67kYbj
         TqLv74+57IEhw7nBdnS5fW109fISq0jJiTwqmIWoCsLlMt7iqAhhEn6MNRE/QOfzqH
         UbuG3XFeQFKrNgP4czvLBr83fTvRkWMLWHDPxIqaV1m5IoNiO5YKc44RKE/ofaL6yn
         sW5IoO43WY7qH1jqAVsARvQYRLW9mabfnNy7NzPMEddQqOsEQt8mtpB40U5+vmvTY8
         zH+XxqmhTEhj8MF1le7C+GGeLkQ3zaMmG/85BARVTPzXc4hNqbtGcr0cDYtfK2g6UY
         5R6b16Ei5vitw==
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
Subject: [PATCH 6/7] iommu: dart: Support different variants with different registers
Date:   Fri, 13 Jan 2023 19:50:29 +0900
Message-Id: <20230113105029.26654-7-marcan@marcan.st>
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

T8110 has a new register layout. To accommodate this, first move all the
register offsets to the hw structure, and rename all the existing
registers to DART_T8020_*.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 187 ++++++++++++++++++++++++-------------
 1 file changed, 124 insertions(+), 63 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 89be055a44be..75647433df9d 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -38,6 +38,7 @@
 #define DART_MAX_TTBR 4
 #define MAX_DARTS_PER_DEVICE 2
 
+/* Common registers */
 
 #define DART_PARAMS1 0x00
 #define DART_PARAMS1_PAGE_SHIFT GENMASK(27, 24)
@@ -45,52 +46,78 @@
 #define DART_PARAMS2 0x04
 #define DART_PARAMS2_BYPASS_SUPPORT BIT(0)
 
-#define DART_STREAM_COMMAND 0x20
-#define DART_STREAM_COMMAND_BUSY BIT(2)
-#define DART_STREAM_COMMAND_INVALIDATE BIT(20)
+/* T8020/T6000 registers */
 
-#define DART_STREAM_SELECT 0x34
+#define DART_T8020_STREAM_COMMAND 0x20
+#define DART_T8020_STREAM_COMMAND_BUSY BIT(2)
+#define DART_T8020_STREAM_COMMAND_INVALIDATE BIT(20)
 
-#define DART_ERROR 0x40
-#define DART_ERROR_STREAM GENMASK(27, 24)
-#define DART_ERROR_CODE GENMASK(11, 0)
-#define DART_ERROR_FLAG BIT(31)
+#define DART_T8020_STREAM_SELECT 0x34
 
-#define DART_ERROR_READ_FAULT BIT(4)
-#define DART_ERROR_WRITE_FAULT BIT(3)
-#define DART_ERROR_NO_PTE BIT(2)
-#define DART_ERROR_NO_PMD BIT(1)
-#define DART_ERROR_NO_TTBR BIT(0)
+#define DART_T8020_ERROR 0x40
+#define DART_T8020_ERROR_STREAM GENMASK(27, 24)
+#define DART_T8020_ERROR_CODE GENMASK(11, 0)
+#define DART_T8020_ERROR_FLAG BIT(31)
 
-#define DART_CONFIG 0x60
-#define DART_CONFIG_LOCK BIT(15)
+#define DART_T8020_ERROR_READ_FAULT BIT(4)
+#define DART_T8020_ERROR_WRITE_FAULT BIT(3)
+#define DART_T8020_ERROR_NO_PTE BIT(2)
+#define DART_T8020_ERROR_NO_PMD BIT(1)
+#define DART_T8020_ERROR_NO_TTBR BIT(0)
+
+#define DART_T8020_CONFIG 0x60
+#define DART_T8020_CONFIG_LOCK BIT(15)
 
 #define DART_STREAM_COMMAND_BUSY_TIMEOUT 100
 
-#define DART_ERROR_ADDR_HI 0x54
-#define DART_ERROR_ADDR_LO 0x50
+#define DART_T8020_ERROR_ADDR_HI 0x54
+#define DART_T8020_ERROR_ADDR_LO 0x50
+
+#define DART_T8020_STREAMS_ENABLE 0xfc
 
-#define DART_STREAMS_ENABLE 0xfc
+#define DART_T8020_TCR                  0x100
+#define DART_T8020_TCR_TRANSLATE_ENABLE BIT(7)
+#define DART_T8020_TCR_BYPASS_DART      BIT(8)
+#define DART_T8020_TCR_BYPASS_DAPF      BIT(12)
 
-#define DART_TCR(sid) (0x100 + 4 * (sid))
-#define DART_TCR_TRANSLATE_ENABLE BIT(7)
-#define DART_TCR_BYPASS0_ENABLE BIT(8)
-#define DART_TCR_BYPASS1_ENABLE BIT(12)
+#define DART_T8020_TTBR       0x200
+#define DART_T8020_TTBR_VALID BIT(31)
+#define DART_T8020_TTBR_ADDR_FIELD_SHIFT 0
+#define DART_T8020_TTBR_SHIFT 12
 
-#define DART_TTBR_VALID BIT(31)
-#define DART_TTBR_SHIFT 12
+#define DART_TCR(dart, sid) ((dart)->hw->tcr + ((sid) << 2))
 
-#define DART_TTBR(dart, sid, idx) (0x200 + \
+#define DART_TTBR(dart, sid, idx) ((dart)->hw->ttbr + \
 				   (((dart)->hw->ttbr_count * (sid)) << 2) + \
 				   ((idx) << 2))
 
+struct apple_dart_stream_map;
 
 struct apple_dart_hw {
+	irqreturn_t (*irq_handler)(int irq, void *dev);
+	int (*invalidate_tlb)(struct apple_dart_stream_map *stream_map);
+
 	u32 oas;
 	enum io_pgtable_fmt fmt;
 
 	int max_sid_count;
 
+	u64 lock;
+	u64 lock_bit;
+
+	u64 error;
+
+	u64 enable_streams;
+
+	u64 tcr;
+	u64 tcr_enabled;
+	u64 tcr_disabled;
+	u64 tcr_bypass;
+
+	u64 ttbr;
+	u64 ttbr_valid;
+	u64 ttbr_addr_field_shift;
+	u64 ttbr_shift;
 	int ttbr_count;
 };
 
@@ -217,8 +244,7 @@ apple_dart_hw_enable_translation(struct apple_dart_stream_map *stream_map)
 	int sid;
 
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(DART_TCR_TRANSLATE_ENABLE,
-		       dart->regs + DART_TCR(sid));
+		writel(dart->hw->tcr_enabled, dart->regs + DART_TCR(dart, sid));
 }
 
 static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
@@ -227,7 +253,7 @@ static void apple_dart_hw_disable_dma(struct apple_dart_stream_map *stream_map)
 	int sid;
 
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(0, dart->regs + DART_TCR(sid));
+		writel(dart->hw->tcr_disabled, dart->regs + DART_TCR(dart, sid));
 }
 
 static void
@@ -238,8 +264,8 @@ apple_dart_hw_enable_bypass(struct apple_dart_stream_map *stream_map)
 
 	WARN_ON(!stream_map->dart->supports_bypass);
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(DART_TCR_BYPASS0_ENABLE | DART_TCR_BYPASS1_ENABLE,
-		       dart->regs + DART_TCR(sid));
+		writel(dart->hw->tcr_bypass,
+		       dart->regs + DART_TCR(dart, sid));
 }
 
 static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
@@ -248,9 +274,10 @@ static void apple_dart_hw_set_ttbr(struct apple_dart_stream_map *stream_map,
 	struct apple_dart *dart = stream_map->dart;
 	int sid;
 
-	WARN_ON(paddr & ((1 << DART_TTBR_SHIFT) - 1));
+	WARN_ON(paddr & ((1 << dart->hw->ttbr_shift) - 1));
 	for_each_set_bit(sid, stream_map->sidmap, dart->num_streams)
-		writel(DART_TTBR_VALID | (paddr >> DART_TTBR_SHIFT),
+		writel(dart->hw->ttbr_valid |
+		       (paddr >> dart->hw->ttbr_shift) << dart->hw->ttbr_addr_field_shift,
 		       dart->regs + DART_TTBR(dart, sid, idx));
 }
 
@@ -274,7 +301,7 @@ apple_dart_hw_clear_all_ttbrs(struct apple_dart_stream_map *stream_map)
 }
 
 static int
-apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
+apple_dart_t8020_hw_stream_command(struct apple_dart_stream_map *stream_map,
 			     u32 command)
 {
 	unsigned long flags;
@@ -283,12 +310,12 @@ apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
 
 	spin_lock_irqsave(&stream_map->dart->lock, flags);
 
-	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_STREAM_SELECT);
-	writel(command, stream_map->dart->regs + DART_STREAM_COMMAND);
+	writel(stream_map->sidmap[0], stream_map->dart->regs + DART_T8020_STREAM_SELECT);
+	writel(command, stream_map->dart->regs + DART_T8020_STREAM_COMMAND);
 
 	ret = readl_poll_timeout_atomic(
-		stream_map->dart->regs + DART_STREAM_COMMAND, command_reg,
-		!(command_reg & DART_STREAM_COMMAND_BUSY), 1,
+		stream_map->dart->regs + DART_T8020_STREAM_COMMAND, command_reg,
+		!(command_reg & DART_T8020_STREAM_COMMAND_BUSY), 1,
 		DART_STREAM_COMMAND_BUSY_TIMEOUT);
 
 	spin_unlock_irqrestore(&stream_map->dart->lock, flags);
@@ -304,10 +331,10 @@ apple_dart_hw_stream_command(struct apple_dart_stream_map *stream_map,
 }
 
 static int
-apple_dart_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
+apple_dart_t8020_hw_invalidate_tlb(struct apple_dart_stream_map *stream_map)
 {
-	return apple_dart_hw_stream_command(stream_map,
-					    DART_STREAM_COMMAND_INVALIDATE);
+	return apple_dart_t8020_hw_stream_command(
+		stream_map, DART_T8020_STREAM_COMMAND_INVALIDATE);
 }
 
 static int apple_dart_hw_reset(struct apple_dart *dart)
@@ -316,8 +343,8 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 	struct apple_dart_stream_map stream_map;
 	int i;
 
-	config = readl(dart->regs + DART_CONFIG);
-	if (config & DART_CONFIG_LOCK) {
+	config = readl(dart->regs + dart->hw->lock);
+	if (config & dart->hw->lock_bit) {
 		dev_err(dart->dev, "DART is locked down until reboot: %08x\n",
 			config);
 		return -EINVAL;
@@ -331,12 +358,12 @@ static int apple_dart_hw_reset(struct apple_dart *dart)
 
 	/* enable all streams globally since TCR is used to control isolation */
 	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
-		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE + 4 * i);
+		writel(U32_MAX, dart->regs + dart->hw->enable_streams + 4 * i);
 
 	/* clear any pending errors before the interrupt is unmasked */
-	writel(readl(dart->regs + DART_ERROR), dart->regs + DART_ERROR);
+	writel(readl(dart->regs + dart->hw->error), dart->regs + dart->hw->error);
 
-	return apple_dart_hw_invalidate_tlb(&stream_map);
+	return dart->hw->invalidate_tlb(&stream_map);
 }
 
 static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
@@ -351,7 +378,7 @@ static void apple_dart_domain_flush_tlb(struct apple_dart_domain *domain)
 		for (j = 0; j < BITS_TO_LONGS(stream_map.dart->num_streams); j++)
 			stream_map.sidmap[j] = atomic_long_read(&domain_stream_map->sidmap[j]);
 
-		apple_dart_hw_invalidate_tlb(&stream_map);
+		stream_map.dart->hw->invalidate_tlb(&stream_map);
 	}
 }
 
@@ -425,7 +452,7 @@ apple_dart_setup_translation(struct apple_dart_domain *domain,
 		apple_dart_hw_clear_ttbr(stream_map, i);
 
 	apple_dart_hw_enable_translation(stream_map);
-	apple_dart_hw_invalidate_tlb(stream_map);
+	stream_map->dart->hw->invalidate_tlb(stream_map);
 }
 
 static int apple_dart_finalize_domain(struct iommu_domain *domain,
@@ -816,30 +843,30 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	}
 };
 
-static irqreturn_t apple_dart_irq(int irq, void *dev)
+static irqreturn_t apple_dart_t8020_irq(int irq, void *dev)
 {
 	struct apple_dart *dart = dev;
 	const char *fault_name = NULL;
-	u32 error = readl(dart->regs + DART_ERROR);
-	u32 error_code = FIELD_GET(DART_ERROR_CODE, error);
-	u32 addr_lo = readl(dart->regs + DART_ERROR_ADDR_LO);
-	u32 addr_hi = readl(dart->regs + DART_ERROR_ADDR_HI);
+	u32 error = readl(dart->regs + DART_T8020_ERROR);
+	u32 error_code = FIELD_GET(DART_T8020_ERROR_CODE, error);
+	u32 addr_lo = readl(dart->regs + DART_T8020_ERROR_ADDR_LO);
+	u32 addr_hi = readl(dart->regs + DART_T8020_ERROR_ADDR_HI);
 	u64 addr = addr_lo | (((u64)addr_hi) << 32);
-	u8 stream_idx = FIELD_GET(DART_ERROR_STREAM, error);
+	u8 stream_idx = FIELD_GET(DART_T8020_ERROR_STREAM, error);
 
-	if (!(error & DART_ERROR_FLAG))
+	if (!(error & DART_T8020_ERROR_FLAG))
 		return IRQ_NONE;
 
 	/* there should only be a single bit set but let's use == to be sure */
-	if (error_code == DART_ERROR_READ_FAULT)
+	if (error_code == DART_T8020_ERROR_READ_FAULT)
 		fault_name = "READ FAULT";
-	else if (error_code == DART_ERROR_WRITE_FAULT)
+	else if (error_code == DART_T8020_ERROR_WRITE_FAULT)
 		fault_name = "WRITE FAULT";
-	else if (error_code == DART_ERROR_NO_PTE)
+	else if (error_code == DART_T8020_ERROR_NO_PTE)
 		fault_name = "NO PTE FOR IOVA";
-	else if (error_code == DART_ERROR_NO_PMD)
+	else if (error_code == DART_T8020_ERROR_NO_PMD)
 		fault_name = "NO PMD FOR IOVA";
-	else if (error_code == DART_ERROR_NO_TTBR)
+	else if (error_code == DART_T8020_ERROR_NO_TTBR)
 		fault_name = "NO TTBR FOR IOVA";
 	else
 		fault_name = "unknown";
@@ -849,7 +876,7 @@ static irqreturn_t apple_dart_irq(int irq, void *dev)
 		"translation fault: status:0x%x stream:%d code:0x%x (%s) at 0x%llx",
 		error, stream_idx, error_code, fault_name, addr);
 
-	writel(error, dart->regs + DART_ERROR);
+	writel(error, dart->regs + DART_T8020_ERROR);
 	return IRQ_HANDLED;
 }
 
@@ -911,7 +938,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk_disable;
 
-	ret = request_irq(dart->irq, apple_dart_irq, IRQF_SHARED,
+	ret = request_irq(dart->irq, dart->hw->irq_handler, IRQF_SHARED,
 			  "apple-dart fault handler", dart);
 	if (ret)
 		goto err_clk_disable;
@@ -959,17 +986,51 @@ static int apple_dart_remove(struct platform_device *pdev)
 }
 
 static const struct apple_dart_hw apple_dart_hw_t8103 = {
+	.irq_handler = apple_dart_t8020_irq,
+	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
 	.oas = 36,
 	.fmt = APPLE_DART,
 	.max_sid_count = 16,
 
+	.enable_streams = DART_T8020_STREAMS_ENABLE,
+	.lock = DART_T8020_CONFIG,
+	.lock_bit = DART_T8020_CONFIG_LOCK,
+
+	.error = DART_T8020_ERROR,
+
+	.tcr = DART_T8020_TCR,
+	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
+	.tcr_disabled = 0,
+	.tcr_bypass = DART_T8020_TCR_BYPASS_DAPF | DART_T8020_TCR_BYPASS_DART,
+
+	.ttbr = DART_T8020_TTBR,
+	.ttbr_valid = DART_T8020_TTBR_VALID,
+	.ttbr_addr_field_shift = DART_T8020_TTBR_ADDR_FIELD_SHIFT,
+	.ttbr_shift = DART_T8020_TTBR_SHIFT,
 	.ttbr_count = 4,
 };
 static const struct apple_dart_hw apple_dart_hw_t6000 = {
+	.irq_handler = apple_dart_t8020_irq,
+	.invalidate_tlb = apple_dart_t8020_hw_invalidate_tlb,
 	.oas = 42,
 	.fmt = APPLE_DART2,
 	.max_sid_count = 16,
 
+	.enable_streams = DART_T8020_STREAMS_ENABLE,
+	.lock = DART_T8020_CONFIG,
+	.lock_bit = DART_T8020_CONFIG_LOCK,
+
+	.error = DART_T8020_ERROR,
+
+	.tcr = DART_T8020_TCR,
+	.tcr_enabled = DART_T8020_TCR_TRANSLATE_ENABLE,
+	.tcr_disabled = 0,
+	.tcr_bypass = DART_T8020_TCR_BYPASS_DAPF | DART_T8020_TCR_BYPASS_DART,
+
+	.ttbr = DART_T8020_TTBR,
+	.ttbr_valid = DART_T8020_TTBR_VALID,
+	.ttbr_addr_field_shift = DART_T8020_TTBR_ADDR_FIELD_SHIFT,
+	.ttbr_shift = DART_T8020_TTBR_SHIFT,
 	.ttbr_count = 4,
 };
 
@@ -979,7 +1040,7 @@ static __maybe_unused int apple_dart_suspend(struct device *dev)
 	unsigned int sid, idx;
 
 	for (sid = 0; sid < dart->num_streams; sid++) {
-		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
+		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(dart, sid));
 		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
 			dart->save_ttbr[sid][idx] =
 				readl(dart->regs + DART_TTBR(dart, sid, idx));
@@ -1004,7 +1065,7 @@ static __maybe_unused int apple_dart_resume(struct device *dev)
 		for (idx = 0; idx < dart->hw->ttbr_count; idx++)
 			writel(dart->save_ttbr[sid][idx],
 			       dart->regs + DART_TTBR(dart, sid, idx));
-		writel(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
+		writel(dart->save_tcr[sid], dart->regs + DART_TCR(dart, sid));
 	}
 
 	return 0;
-- 
2.35.1

