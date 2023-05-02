Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597536F3EF2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjEBIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjEBIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:17:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336CC46AF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:17:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3B5B8660563C;
        Tue,  2 May 2023 09:17:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683015422;
        bh=mcvCjKcTwSrzbxbITq5xPqu5CEFkCpo13KEci8toc/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTkX3V+aFlfXNH6emZdBZw9i+T5eYGUmlrwE2awxG8sZnGYp5Dm91sqjFjkRqTj4O
         nBZULmZW8D/VnoDxyoMaYdzk7fukyzrGn9fumegYV0yXjqT6550UCRG+ubjWVlE4Kj
         xvA/V14D1adn9F4M/3k9Lgq58qbTpUEupdfZQhCfSs+vORRxmcX/huQnh1S2+T77lz
         1D0gp8UzWCC5vrqpEwCrmkK8nj9mkPavlWZktGAKGiv8EpjwEP2XjrjuXTSiWVY+id
         LxEvRUAdWHz1ziNeSmbU5W+lQvld3+HZHyZeZglLzNV5TcEbw13XEmExgU2xM6aV66
         os63oRkruZeEg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH 06/11] drm/mediatek: gamma: Use bitfield macros
Date:   Tue,  2 May 2023 10:16:45 +0200
Message-Id: <20230502081650.25947-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502081650.25947-1-angelogioacchino.delregno@collabora.com>
References: <20230502081650.25947-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 97b34963ef73..ef0243034663 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -22,9 +22,16 @@
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
 #define LUT_SIZE_DEFAULT			512 /* for setting gamma lut from AAL */
 
 struct mtk_disp_gamma_data {
@@ -96,33 +103,33 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	for (i = 0; i < lut_size; i++) {
 		struct drm_color_lut diff, hwlut;
 
-		hwlut.red = drm_color_lut_extract(lut[i].red, 10);
-		hwlut.green = drm_color_lut_extract(lut[i].green, 10);
-		hwlut.red = drm_color_lut_extract(lut[i].blue, 10);
+		hwlut.red = drm_color_lut_extract(lut[i].red, LUT_BITS_DEFAULT);
+		hwlut.green = drm_color_lut_extract(lut[i].green, LUT_BITS_DEFAULT);
+		hwlut.red = drm_color_lut_extract(lut[i].blue, LUT_BITS_DEFAULT);
 
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
@@ -139,9 +146,12 @@ void mtk_gamma_config(struct device *dev, unsigned int w,
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

