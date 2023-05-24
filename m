Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB54170F2E2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEXJeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEXJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:34:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F3993
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:34:24 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E54866031B5;
        Wed, 24 May 2023 10:34:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684920862;
        bh=AF3G+Ay1qVP5IzxZeph5rM6hzV1JNEhtA1DrPHYLiqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OugGCOpFY54lbwjNzJQJiM8JFbU00DKYcvd4pl9j8/D0gKxbP/MhLhSt3/ebjUoey
         qr54Etmah/yFx7zQ2q6o9QdUSZQp7RIZi5Jvz+/ihnlwgQlGToWZGaR9X6BVDIykF5
         eZdAf3MUmP3RHwlcd1WC5eWg9P/p9k+MBqqY75D7e90E4gIOf9TD3BtjJ0lvt2N+hh
         1SIC9EZ3NW7MAvoJcb8HDETnurF0WBS1nwYT/DIdN6zbkp+AVZGve0OhcQLWwvSa4F
         xQ6Fh235PzeyK7FJc0wu3SRyjIGRGnNXQN0oWiJ5bl/7cknW1L6naB3YRZx+RUWfQo
         Zido2mMFKMt9w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v1 2/4] drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
Date:   Wed, 24 May 2023 11:34:10 +0200
Message-Id: <20230524093412.92211-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
References: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
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

Function mtk_dsi_ps_control() is a subset of mtk_dsi_ps_control_vact():
merge the two in one mtk_dsi_ps_control() function by adding one
function parameter `config_vact` which, when true, writes the VACT
related registers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 76 +++++++++---------------------
 1 file changed, 23 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 246a3a338c1e..97d5b3083057 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -350,40 +350,6 @@ static void mtk_dsi_set_vm_cmd(struct mtk_dsi *dsi)
 	mtk_dsi_mask(dsi, DSI_VM_CMD_CON, TS_VFP_EN, TS_VFP_EN);
 }
 
-static void mtk_dsi_ps_control_vact(struct mtk_dsi *dsi)
-{
-	struct videomode *vm = &dsi->vm;
-	u32 dsi_buf_bpp, ps_wc;
-	u32 ps_bpp_mode;
-
-	if (dsi->format == MIPI_DSI_FMT_RGB565)
-		dsi_buf_bpp = 2;
-	else
-		dsi_buf_bpp = 3;
-
-	ps_wc = vm->hactive * dsi_buf_bpp;
-	ps_bpp_mode = ps_wc;
-
-	switch (dsi->format) {
-	case MIPI_DSI_FMT_RGB888:
-		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
-		break;
-	case MIPI_DSI_FMT_RGB666:
-		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
-		break;
-	case MIPI_DSI_FMT_RGB666_PACKED:
-		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
-		break;
-	case MIPI_DSI_FMT_RGB565:
-		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
-		break;
-	}
-
-	writel(vm->vactive, dsi->regs + DSI_VACT_NL);
-	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
-	writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
-}
-
 static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 {
 	u32 tmp_reg;
@@ -415,36 +381,40 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
 }
 
-static void mtk_dsi_ps_control(struct mtk_dsi *dsi)
+static void mtk_dsi_ps_control(struct mtk_dsi *dsi, bool config_vact)
 {
-	u32 dsi_tmp_buf_bpp;
-	u32 tmp_reg;
+	struct videomode *vm = &dsi->vm;
+	u32 dsi_buf_bpp, ps_wc;
+	u32 ps_bpp_mode;
+
+	if (dsi->format == MIPI_DSI_FMT_RGB565)
+		dsi_buf_bpp = 2;
+	else
+		dsi_buf_bpp = 3;
+
+	ps_wc = vm->hactive * dsi_buf_bpp;
+	ps_bpp_mode = ps_wc;
 
 	switch (dsi->format) {
 	case MIPI_DSI_FMT_RGB888:
-		tmp_reg = PACKED_PS_24BIT_RGB888;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_24BIT_RGB888;
 		break;
 	case MIPI_DSI_FMT_RGB666:
-		tmp_reg = LOOSELY_PS_18BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB666_PACKED:
-		tmp_reg = PACKED_PS_18BIT_RGB666;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= LOOSELY_PS_18BIT_RGB666;
 		break;
 	case MIPI_DSI_FMT_RGB565:
-		tmp_reg = PACKED_PS_16BIT_RGB565;
-		dsi_tmp_buf_bpp = 2;
-		break;
-	default:
-		tmp_reg = PACKED_PS_24BIT_RGB888;
-		dsi_tmp_buf_bpp = 3;
+		ps_bpp_mode |= PACKED_PS_16BIT_RGB565;
 		break;
 	}
 
-	tmp_reg += dsi->vm.hactive * dsi_tmp_buf_bpp & DSI_PS_WC;
-	writel(tmp_reg, dsi->regs + DSI_PSCTRL);
+	if (config_vact) {
+		writel(vm->vactive, dsi->regs + DSI_VACT_NL);
+		writel(ps_wc, dsi->regs + DSI_HSTX_CKL_WC);
+	}
+	writel(ps_bpp_mode, dsi->regs + DSI_PSCTRL);
 }
 
 static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
@@ -520,7 +490,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 	writel(horizontal_backporch_byte, dsi->regs + DSI_HBP_WC);
 	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
 
-	mtk_dsi_ps_control(dsi);
+	mtk_dsi_ps_control(dsi, false);
 }
 
 static void mtk_dsi_start(struct mtk_dsi *dsi)
@@ -665,7 +635,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
-	mtk_dsi_ps_control_vact(dsi);
+	mtk_dsi_ps_control(dsi, true);
 	mtk_dsi_set_vm_cmd(dsi);
 	mtk_dsi_config_vdo_timing(dsi);
 	mtk_dsi_set_interrupt_enable(dsi);
-- 
2.40.1

