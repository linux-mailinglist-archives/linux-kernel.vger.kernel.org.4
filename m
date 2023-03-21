Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009136C344E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCUOdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjCUOdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:33:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC2424733
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:33:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EE7966030D8;
        Tue, 21 Mar 2023 14:33:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679409207;
        bh=hfOZhZvwpqq4ufYx8Sox86gnGr5bS6DeOHGjzIeVHPo=;
        h=From:To:Cc:Subject:Date:From;
        b=QjFR76b5ozWwX+fQ0Mlt67ZpeSPuvj5YdKFce9CbrSGWw2Sy62WzQ+jmobznEWm3o
         DudEvYaKi02PXXhtXEsll5xLZCNVlCCCCeg2Uzj/AR0Hxlw0i2n6gPH+GmuIyTEoe8
         6PzCP5dU2w7P1ZceoHlpwalnFBVJkKeZahOJgeVHvMMUf6t/nOX1AQANWaxyBfP+sC
         iMgvfajHEkUD8m0r8Kg3jHjZLceKfeT9vfOhU6XDwg8Y44hczyK+P/Yt2V2MNRJAc5
         tcVMb6FYKHsBqKAnKI8xuXquq0l/Ej7/Bz2NJrVySMGjnAAQjqDpMjK+LgrKqkNZLA
         xWtY4kxZFDc9A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     srinivas.kandagatla@linaro.org
Cc:     wenst@chromium.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH] nvmem: mtk-efuse: Support postprocessing for GPU speed binning data
Date:   Tue, 21 Mar 2023 15:33:19 +0100
Message-Id: <20230321143319.333803-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some MediaTek SoCs GPU speed binning data is available for read
in the SoC's eFuse array but it has a format that is incompatible
with what the OPP API expects, as we read a number from 0 to 7 but
opp-supported-hw is expecting a bitmask to enable an OPP entry:
being what we read limited to 0-7, it's straightforward to simply
convert the value to BIT(value) as a post-processing action.

So, introduce post-processing support and enable it by evaluating
the newly introduced platform data's `uses_post_processing` member,
currently enabled only for MT8186.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/nvmem/mtk-efuse.c | 53 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index a08e0aedd21c..b36cd0dcc8c7 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -10,6 +10,11 @@
 #include <linux/io.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct mtk_efuse_pdata {
+	bool uses_post_processing;
+};
 
 struct mtk_efuse_priv {
 	void __iomem *base;
@@ -29,6 +34,37 @@ static int mtk_reg_read(void *context,
 	return 0;
 }
 
+static int mtk_efuse_gpu_speedbin_pp(void *context, const char *id, int index,
+				     unsigned int offset, void *data, size_t bytes)
+{
+	u8 *val = data;
+
+	if (val[0] < 8)
+		val[0] = BIT(val[0]);
+
+	return 0;
+}
+
+static void mtk_efuse_fixup_cell_info(struct nvmem_device *nvmem,
+				      struct nvmem_layout *layout,
+				      struct nvmem_cell_info *cell)
+{
+	size_t sz = strlen(cell->name);
+
+	/*
+	 * On some SoCs, the GPU speedbin is not read as bitmask but as
+	 * a number with range [0-7] (max 3 bits): post process to use
+	 * it in OPP tables to describe supported-hw.
+	 */
+	if (cell->nbits <= 3 &&
+	    strncmp(cell->name, "gpu-speedbin", min(sz, strlen("gpu-speedbin"))) == 0)
+		cell->read_post_process = mtk_efuse_gpu_speedbin_pp;
+}
+
+static struct nvmem_layout mtk_efuse_layout = {
+	.fixup_cell_info = mtk_efuse_fixup_cell_info,
+};
+
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -36,6 +72,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	struct nvmem_device *nvmem;
 	struct nvmem_config econfig = {};
 	struct mtk_efuse_priv *priv;
+	const struct mtk_efuse_pdata *pdata;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -45,20 +82,32 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
+	pdata = device_get_match_data(dev);
 	econfig.stride = 1;
 	econfig.word_size = 1;
 	econfig.reg_read = mtk_reg_read;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
+	if (pdata->uses_post_processing)
+		econfig.layout = &mtk_efuse_layout;
 	nvmem = devm_nvmem_register(dev, &econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
+static const struct mtk_efuse_pdata mtk_mt8186_efuse_pdata = {
+	.uses_post_processing = true,
+};
+
+static const struct mtk_efuse_pdata mtk_efuse_pdata = {
+	.uses_post_processing = false,
+};
+
 static const struct of_device_id mtk_efuse_of_match[] = {
-	{ .compatible = "mediatek,mt8173-efuse",},
-	{ .compatible = "mediatek,efuse",},
+	{ .compatible = "mediatek,mt8173-efuse", .data = &mtk_efuse_pdata },
+	{ .compatible = "mediatek,mt8186-efuse", .data = &mtk_mt8186_efuse_pdata },
+	{ .compatible = "mediatek,efuse", .data = &mtk_efuse_pdata },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
-- 
2.40.0

