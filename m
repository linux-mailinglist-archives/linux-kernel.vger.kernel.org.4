Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBE16C46FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjCVJtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjCVJtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:49:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2D728E6A;
        Wed, 22 Mar 2023 02:48:35 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 6215624E31D;
        Wed, 22 Mar 2023 17:48:33 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:33 +0800
Received: from localhost.localdomain (183.27.97.64) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 22 Mar
 2023 17:48:32 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        Walker Chen <walker.chen@starfivetech.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v6 2/4] dmaengine: dw-axi-dmac: Add support for StarFive JH7110 DMA
Date:   Wed, 22 Mar 2023 17:48:18 +0800
Message-ID: <20230322094820.24738-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230322094820.24738-1-walker.chen@starfivetech.com>
References: <20230322094820.24738-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.97.64]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMA reset operation in device probe and use different configuration
on CH_CFG registers according to match data. Update all uses of
of_device_is_compatible with of_device_get_match_data.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 38 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 4169e1d7d5ca..6cfcb541d8c3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -21,10 +21,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -46,6 +48,10 @@
 	DMA_SLAVE_BUSWIDTH_32_BYTES	| \
 	DMA_SLAVE_BUSWIDTH_64_BYTES)
 
+#define AXI_DMA_FLAG_HAS_APB_REGS	BIT(0)
+#define AXI_DMA_FLAG_HAS_RESETS		BIT(1)
+#define AXI_DMA_FLAG_USE_CFG2		BIT(2)
+
 static inline void
 axi_dma_iowrite32(struct axi_dma_chip *chip, u32 reg, u32 val)
 {
@@ -86,7 +92,8 @@ static inline void axi_chan_config_write(struct axi_dma_chan *chan,
 
 	cfg_lo = (config->dst_multblk_type << CH_CFG_L_DST_MULTBLK_TYPE_POS |
 		  config->src_multblk_type << CH_CFG_L_SRC_MULTBLK_TYPE_POS);
-	if (chan->chip->dw->hdata->reg_map_8_channels) {
+	if (chan->chip->dw->hdata->reg_map_8_channels &&
+	    !chan->chip->dw->hdata->use_cfg2) {
 		cfg_hi = config->tt_fc << CH_CFG_H_TT_FC_POS |
 			 config->hs_sel_src << CH_CFG_H_HS_SEL_SRC_POS |
 			 config->hs_sel_dst << CH_CFG_H_HS_SEL_DST_POS |
@@ -1367,10 +1374,11 @@ static int parse_device_properties(struct axi_dma_chip *chip)
 
 static int dw_probe(struct platform_device *pdev)
 {
-	struct device_node *node = pdev->dev.of_node;
 	struct axi_dma_chip *chip;
 	struct dw_axi_dma *dw;
 	struct dw_axi_dma_hcfg *hdata;
+	struct reset_control *resets;
+	unsigned int flags;
 	u32 i;
 	int ret;
 
@@ -1398,12 +1406,25 @@ static int dw_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->regs))
 		return PTR_ERR(chip->regs);
 
-	if (of_device_is_compatible(node, "intel,kmb-axi-dma")) {
+	flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
+	if (flags & AXI_DMA_FLAG_HAS_APB_REGS) {
 		chip->apb_regs = devm_platform_ioremap_resource(pdev, 1);
 		if (IS_ERR(chip->apb_regs))
 			return PTR_ERR(chip->apb_regs);
 	}
 
+	if (flags & AXI_DMA_FLAG_HAS_RESETS) {
+		resets = devm_reset_control_array_get_exclusive(&pdev->dev);
+		if (IS_ERR(resets))
+			return PTR_ERR(resets);
+
+		ret = reset_control_deassert(resets);
+		if (ret)
+			return ret;
+	}
+
+	chip->dw->hdata->use_cfg2 = !!(flags & AXI_DMA_FLAG_USE_CFG2);
+
 	chip->core_clk = devm_clk_get(chip->dev, "core-clk");
 	if (IS_ERR(chip->core_clk))
 		return PTR_ERR(chip->core_clk);
@@ -1554,8 +1575,15 @@ static const struct dev_pm_ops dw_axi_dma_pm_ops = {
 };
 
 static const struct of_device_id dw_dma_of_id_table[] = {
-	{ .compatible = "snps,axi-dma-1.01a" },
-	{ .compatible = "intel,kmb-axi-dma" },
+	{
+		.compatible = "snps,axi-dma-1.01a"
+	}, {
+		.compatible = "intel,kmb-axi-dma",
+		.data = (void *)AXI_DMA_FLAG_HAS_APB_REGS,
+	}, {
+		.compatible = "starfive,jh7110-axi-dma",
+		.data = (void *)(AXI_DMA_FLAG_HAS_RESETS | AXI_DMA_FLAG_USE_CFG2),
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, dw_dma_of_id_table);
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index e9d5eb0fd594..eb267cb24f67 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -33,6 +33,7 @@ struct dw_axi_dma_hcfg {
 	/* Register map for DMAX_NUM_CHANNELS <= 8 */
 	bool	reg_map_8_channels;
 	bool	restrict_axi_burst_len;
+	bool	use_cfg2;
 };
 
 struct axi_dma_chan {
-- 
2.17.1

