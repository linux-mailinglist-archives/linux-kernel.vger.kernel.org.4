Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF55B9A80
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiIOMKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiIOMJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:09:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3169E1403F;
        Thu, 15 Sep 2022 05:09:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EF626601FC1;
        Thu, 15 Sep 2022 13:09:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663243768;
        bh=b73S+v63Xy5BcQgYOj0NF2u+G+p7Y8haQ0o9DBpBNoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6nmdEHXzI73VmsbQxijOWkBdeBWwRT6BWYcbtc7uZfmH+Dg2SyWaHUWIwt33jVb5
         LrG06HM4uz7HdNcYMKBowQwLwOXMF+QqKmHNGECNSvJr2kWulQkDIwf4KTadEE5KP6
         qEJxdrNCWvEoClcYWrE5NOeFqT6h697HfAbH8VkJLg/rTRLxJ8NpL9KYSr/gR/J2Yl
         Jfq65yKhp47fxkZdDScoSFCJl+GLFa7b+Hu2b1ScctDBurR+9VxXRsNgYs/OX9ht/p
         09HVSGChBj5WmjlDzhS/dyOfykyRYsNQtOqD4hROUAcXx1pFRCulox0qkZzz81wqIl
         Zuwgh6TO18V4g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/2] mmc: mtk-sd: Reorder of_device_id and platform data by name
Date:   Thu, 15 Sep 2022 14:09:22 +0200
Message-Id: <20220915120923.86038-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
References: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
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

Both of_device_id compatible strings and platform data were partially
ordered by name. Fix the ordering.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mmc/host/mtk-sd.c | 99 ++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 69d78604d1fc..572eb5d48813 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -474,33 +474,20 @@ struct msdc_host {
 	struct cqhci_host *cq_host;
 };
 
-static const struct mtk_mmc_compatible mt8135_compat = {
-	.clk_div_bits = 8,
+static const struct mtk_mmc_compatible mt2701_compat = {
+	.clk_div_bits = 12,
 	.recheck_sdio_irq = true,
 	.hs400_tune = false,
-	.pad_tune_reg = MSDC_PAD_TUNE,
-	.async_fifo = false,
-	.data_tune = false,
-	.busy_check = false,
-	.stop_clk_fix = false,
-	.enhance_rx = false,
-	.support_64g = false,
-};
-
-static const struct mtk_mmc_compatible mt8173_compat = {
-	.clk_div_bits = 8,
-	.recheck_sdio_irq = true,
-	.hs400_tune = true,
-	.pad_tune_reg = MSDC_PAD_TUNE,
-	.async_fifo = false,
-	.data_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
 	.busy_check = false,
 	.stop_clk_fix = false,
 	.enhance_rx = false,
 	.support_64g = false,
 };
 
-static const struct mtk_mmc_compatible mt8183_compat = {
+static const struct mtk_mmc_compatible mt2712_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
@@ -513,20 +500,7 @@ static const struct mtk_mmc_compatible mt8183_compat = {
 	.support_64g = true,
 };
 
-static const struct mtk_mmc_compatible mt2701_compat = {
-	.clk_div_bits = 12,
-	.recheck_sdio_irq = true,
-	.hs400_tune = false,
-	.pad_tune_reg = MSDC_PAD_TUNE0,
-	.async_fifo = true,
-	.data_tune = true,
-	.busy_check = false,
-	.stop_clk_fix = false,
-	.enhance_rx = false,
-	.support_64g = false,
-};
-
-static const struct mtk_mmc_compatible mt2712_compat = {
+static const struct mtk_mmc_compatible mt6779_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
@@ -539,6 +513,19 @@ static const struct mtk_mmc_compatible mt2712_compat = {
 	.support_64g = true,
 };
 
+static const struct mtk_mmc_compatible mt7620_compat = {
+	.clk_div_bits = 8,
+	.recheck_sdio_irq = true,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
+	.busy_check = false,
+	.stop_clk_fix = false,
+	.enhance_rx = false,
+	.use_internal_cd = true,
+};
+
 static const struct mtk_mmc_compatible mt7622_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = true,
@@ -552,31 +539,33 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 	.support_64g = false,
 };
 
-static const struct mtk_mmc_compatible mt8516_compat = {
-	.clk_div_bits = 12,
+static const struct mtk_mmc_compatible mt8135_compat = {
+	.clk_div_bits = 8,
 	.recheck_sdio_irq = true,
 	.hs400_tune = false,
-	.pad_tune_reg = MSDC_PAD_TUNE0,
-	.async_fifo = true,
-	.data_tune = true,
-	.busy_check = true,
-	.stop_clk_fix = true,
+	.pad_tune_reg = MSDC_PAD_TUNE,
+	.async_fifo = false,
+	.data_tune = false,
+	.busy_check = false,
+	.stop_clk_fix = false,
+	.enhance_rx = false,
+	.support_64g = false,
 };
 
-static const struct mtk_mmc_compatible mt7620_compat = {
+static const struct mtk_mmc_compatible mt8173_compat = {
 	.clk_div_bits = 8,
 	.recheck_sdio_irq = true,
-	.hs400_tune = false,
+	.hs400_tune = true,
 	.pad_tune_reg = MSDC_PAD_TUNE,
 	.async_fifo = false,
 	.data_tune = false,
 	.busy_check = false,
 	.stop_clk_fix = false,
 	.enhance_rx = false,
-	.use_internal_cd = true,
+	.support_64g = false,
 };
 
-static const struct mtk_mmc_compatible mt6779_compat = {
+static const struct mtk_mmc_compatible mt8183_compat = {
 	.clk_div_bits = 12,
 	.recheck_sdio_irq = false,
 	.hs400_tune = false,
@@ -589,16 +578,28 @@ static const struct mtk_mmc_compatible mt6779_compat = {
 	.support_64g = true,
 };
 
+static const struct mtk_mmc_compatible mt8516_compat = {
+	.clk_div_bits = 12,
+	.recheck_sdio_irq = true,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
-	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
-	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
-	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
+	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
+	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
+	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
+	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
+	{ .compatible = "mediatek,mt8183-mmc", .data = &mt8183_compat},
 	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
-	{ .compatible = "mediatek,mt7620-mmc", .data = &mt7620_compat},
-	{ .compatible = "mediatek,mt6779-mmc", .data = &mt6779_compat},
+
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
-- 
2.37.2

