Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B91719BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbjFAMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjFAMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8351A5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 05:10:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 320E46606EC8;
        Thu,  1 Jun 2023 13:10:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685621432;
        bh=3I8Rjj9QMcA+JJ4/+HINgDnaxJetoJetOg2mGldS5tI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNvJVaw9Qg3hqwhe1jvPK/WEIfm2kNdvIY/f4JRPTftAwjL/ymp5xhyfWhwG+PYks
         jYddPx5C2kplfkij6My/voJMbPudzafbN2eWdxL66kaC3llR/9DRKZxn2LP36BKCDJ
         nRbqsV2iPLvpKkIwUO0+YF6Gl4YWysPtC6pCpRQOoayp0ECBKI5TH+d1ZD/WlQRyMl
         bAHIIAvexEBNJBmx9+IVNHrPK3uNAF5GItnf5+oUkPvX7e0n2lWbhS7h+6DU3y8j/p
         O9nbZdoSBo0ZK493WH3Hrfxv20LGPBiCs0BgdCldopuIfl3f0M6JIGcLsF7A8ZOv8r
         i92a+xKvl1VWw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
Subject: [PATCH v5 06/11] drm/mediatek: gamma: Use bitfield macros
Date:   Thu,  1 Jun 2023 14:10:17 +0200
Message-Id: <20230601121022.2401844-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601121022.2401844-1-angelogioacchino.delregno@collabora.com>
References: <20230601121022.2401844-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code more robust and improve readability by using bitfield
macros instead of open coding bit operations.
While at it, also add a definition for LUT_BITS_DEFAULT.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 41 ++++++++++++++---------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index b75a77af5205..f4bf5b37992c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/module.h>
@@ -22,9 +23,16 @@
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
+#define DISP_GAMMA_SIZE_HSIZE				GENMASK(28, 16)
+#define DISP_GAMMA_SIZE_VSIZE				GENMASK(12, 0)
 #define DISP_GAMMA_LUT				0x0700
 
+#define DISP_GAMMA_LUT_10BIT_R			GENMASK(29, 20)
+#define DISP_GAMMA_LUT_10BIT_G			GENMASK(19, 10)
+#define DISP_GAMMA_LUT_10BIT_B			GENMASK(9, 0)
+
 #define LUT_10BIT_MASK				0x03ff
+#define LUT_BITS_DEFAULT			10
 #define LUT_SIZE_DEFAULT			512
 
 struct mtk_disp_gamma_data {
@@ -96,33 +104,33 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	for (i = 0; i < lut_size; i++) {
 		struct drm_color_lut diff, hwlut;
 
-		hwlut.red = drm_color_lut_extract(lut[i].red, 10);
-		hwlut.green = drm_color_lut_extract(lut[i].green, 10);
-		hwlut.blue = drm_color_lut_extract(lut[i].blue, 10);
+		hwlut.red = drm_color_lut_extract(lut[i].red, LUT_BITS_DEFAULT);
+		hwlut.green = drm_color_lut_extract(lut[i].green, LUT_BITS_DEFAULT);
+		hwlut.blue = drm_color_lut_extract(lut[i].blue, LUT_BITS_DEFAULT);
 
 		if (!lut_diff || (i % 2 == 0)) {
-			word = hwlut.red << 20 +
-			       hwlut.green << 10 +
-			       hwlut.red;
+			word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, hwlut.red);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, hwlut.green);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, hwlut.blue);
 		} else {
 			diff.red = lut[i].red - lut[i - 1].red;
-			diff.red = drm_color_lut_extract(diff.red, 10);
+			diff.red = drm_color_lut_extract(diff.red, LUT_BITS_DEFAULT);
 
 			diff.green = lut[i].green - lut[i - 1].green;
-			diff.green = drm_color_lut_extract(diff.green, 10);
+			diff.green = drm_color_lut_extract(diff.green, LUT_BITS_DEFAULT);
 
 			diff.blue = lut[i].blue - lut[i - 1].blue;
-			diff.blue = drm_color_lut_extract(diff.blue, 10);
+			diff.blue = drm_color_lut_extract(diff.blue, LUT_BITS_DEFAULT);
 
-			word = diff.blue << 20 +
-			       diff.green << 10 +
-			       diff.red;
+			word = FIELD_PREP(DISP_GAMMA_LUT_10BIT_R, diff.red);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_G, diff.green);
+			word |= FIELD_PREP(DISP_GAMMA_LUT_10BIT_B, diff.blue);
 		}
 		writel(word, (lut_base + i * 4));
 	}
 
 	/* Enable the gamma table */
-	cfg_val = cfg_val | GAMMA_LUT_EN;
+	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
 	writel(cfg_val, regs + DISP_GAMMA_CFG);
 }
@@ -139,9 +147,12 @@ void mtk_gamma_config(struct device *dev, unsigned int w,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
 	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+	u32 sz;
+
+	sz = FIELD_PREP(DISP_GAMMA_SIZE_HSIZE, w);
+	sz |= FIELD_PREP(DISP_GAMMA_SIZE_VSIZE, h);
 
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, &gamma->cmdq_reg, gamma->regs,
-		      DISP_GAMMA_SIZE);
+	mtk_ddp_write(cmdq_pkt, sz, &gamma->cmdq_reg, gamma->regs, DISP_GAMMA_SIZE);
 	if (gamma->data && gamma->data->has_dither)
 		mtk_dither_set_common(gamma->regs, &gamma->cmdq_reg, bpc,
 				      DISP_GAMMA_CFG, GAMMA_DITHERING, cmdq_pkt);
-- 
2.40.1

