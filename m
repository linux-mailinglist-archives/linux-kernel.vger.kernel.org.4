Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115EA6F7F2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjEEIgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjEEIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:36:14 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2789614E4A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 01:36:13 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BB0F201466;
        Fri,  5 May 2023 10:25:19 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B092520106C;
        Fri,  5 May 2023 10:25:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 25315181D0E3;
        Fri,  5 May 2023 16:25:17 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: MCLK bind with TX/RX enable bit
Date:   Fri,  5 May 2023 15:55:22 +0800
Message-Id: <1683273322-2525-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX8MP, the sai MCLK is bound with TX/RX enable bit,
which means the TX/RE enable bit need to be enabled then
MCLK can be output on PAD.

Some codec (for example: WM8962) needs the MCLK output
earlier, otherwise there will be issue for codec
configuration.

Add new soc data "mclk_with_tere" for this platform and
enable the MCLK output in startup stage.

As "mclk_with_tere" only applied to i.MX8MP, currently
The soc data is shared with i.MX8MN, so need to add
an i.MX8MN own soc data with "mclk_with_tere" disabled.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 24 +++++++++++++++++++++---
 sound/soc/fsl/fsl_sai.h |  2 ++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index abdaffb00fbd..d9344025dc16 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1400,7 +1400,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		sai->cpu_dai_drv.symmetric_sample_bits = 0;
 	}
 
-	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
+	sai->mclk_direction_output = of_property_read_bool(np, "fsl,sai-mclk-direction-output");
+
+	if (sai->mclk_direction_output &&
 	    of_device_is_compatible(np, "fsl,imx6ul-sai")) {
 		gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
 		if (IS_ERR(gpr)) {
@@ -1443,7 +1445,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		dev_warn(dev, "Error reading SAI version: %d\n", ret);
 
 	/* Select MCLK direction */
-	if (of_property_read_bool(np, "fsl,sai-mclk-direction-output") &&
+	if (sai->mclk_direction_output &&
 	    sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		regmap_update_bits(sai->regmap, FSL_SAI_MCTL,
 				   FSL_SAI_MCTL_MCLK_EN, FSL_SAI_MCTL_MCLK_EN);
@@ -1562,6 +1564,17 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mm_data = {
 	.max_register = FSL_SAI_MCTL,
 };
 
+static const struct fsl_sai_soc_data fsl_sai_imx8mn_data = {
+	.use_imx_pcm = true,
+	.use_edma = false,
+	.fifo_depth = 128,
+	.reg_offset = 8,
+	.mclk0_is_mclk1 = false,
+	.pins = 8,
+	.flags = 0,
+	.max_register = FSL_SAI_MDIV,
+};
+
 static const struct fsl_sai_soc_data fsl_sai_imx8mp_data = {
 	.use_imx_pcm = true,
 	.use_edma = false,
@@ -1571,6 +1584,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8mp_data = {
 	.pins = 8,
 	.flags = 0,
 	.max_register = FSL_SAI_MDIV,
+	.mclk_with_tere = true,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8ulp_data = {
@@ -1606,7 +1620,7 @@ static const struct of_device_id fsl_sai_ids[] = {
 	{ .compatible = "fsl,imx8mm-sai", .data = &fsl_sai_imx8mm_data },
 	{ .compatible = "fsl,imx8mp-sai", .data = &fsl_sai_imx8mp_data },
 	{ .compatible = "fsl,imx8ulp-sai", .data = &fsl_sai_imx8ulp_data },
-	{ .compatible = "fsl,imx8mn-sai", .data = &fsl_sai_imx8mp_data },
+	{ .compatible = "fsl,imx8mn-sai", .data = &fsl_sai_imx8mn_data },
 	{ .compatible = "fsl,imx93-sai", .data = &fsl_sai_imx93_data },
 	{ /* sentinel */ }
 };
@@ -1671,6 +1685,10 @@ static int fsl_sai_runtime_resume(struct device *dev)
 	if (ret)
 		goto disable_rx_clk;
 
+	if (sai->soc_data->mclk_with_tere && sai->mclk_direction_output)
+		regmap_update_bits(sai->regmap, FSL_SAI_TCSR(ofs),
+				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
+
 	return 0;
 
 disable_rx_clk:
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 197748a888d5..3eb994aef36a 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -230,6 +230,7 @@ struct fsl_sai_soc_data {
 	bool use_imx_pcm;
 	bool use_edma;
 	bool mclk0_is_mclk1;
+	bool mclk_with_tere;
 	unsigned int fifo_depth;
 	unsigned int pins;
 	unsigned int reg_offset;
@@ -287,6 +288,7 @@ struct fsl_sai {
 	bool synchronous[2];
 	struct fsl_sai_dl_cfg *dl_cfg;
 	unsigned int dl_cfg_cnt;
+	bool mclk_direction_output;
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
-- 
2.34.1

