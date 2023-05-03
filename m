Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3546F575B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjECLtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjECLtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:49:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FD94EE3
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:49:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1DF4366056CE;
        Wed,  3 May 2023 12:49:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683114570;
        bh=+lHTPgE7Ar7zmV3aDmJ+jCdx2t03nLTQvXTE79e5Na0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rr2troRj5eDjZDFh3DbaMJO1subZ799UOBlP0nrwm2EFVokKrT8EZWL/9dD9eV0yq
         x7waXsFPWaLzgbq0k0J9946sP3DBxlNmx3ohx0M7WAP8IQgqMuxgskV7J/JPJ7oHuX
         y1n/Y1jNU0IWnaxbo9AFjQ8094zqJ0ZzY39FsEL//CWdVtpT+G6XJd85pdmPkNsp0G
         9mIYPjMCrFgR+werrZJ/9fGyY7xaNtLIPiPPbKF2PMOpYsyca4Xl5k6n40PCxe0UhN
         FCKNg7GblnbHh4lbntWqA1OXkWAuu8wLwdH9I0D0noYDQpxQGwUn8OLLvRIp7OQc1D
         dWvSYfKgn/Ljg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH v2 02/11] drm/mediatek: gamma: Reduce indentation in mtk_gamma_set_common()
Date:   Wed,  3 May 2023 13:49:14 +0200
Message-Id: <20230503114923.156985-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503114923.156985-1-angelogioacchino.delregno@collabora.com>
References: <20230503114923.156985-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the check for state->gamma_lut and move it at the beginning
of the function to reduce indentation: this prepares the code for
keeping readability on later additions.

This commit brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 45 ++++++++++++-----------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 99be515a941b..ce6f2499b891 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -65,34 +65,35 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	u32 word;
 	u32 diff[3] = {0};
 
+	/* If there's no gamma lut there's nothing to do here. */
+	if (!state->gamma_lut)
+		return;
+
 	if (gamma && gamma->data)
 		lut_diff = gamma->data->lut_diff;
 	else
 		lut_diff = false;
 
-	if (state->gamma_lut) {
-		reg = readl(regs + DISP_GAMMA_CFG);
-		reg = reg | GAMMA_LUT_EN;
-		writel(reg, regs + DISP_GAMMA_CFG);
-		lut_base = regs + DISP_GAMMA_LUT;
-		lut = (struct drm_color_lut *)state->gamma_lut->data;
-		for (i = 0; i < MTK_LUT_SIZE; i++) {
-
-			if (!lut_diff || (i % 2 == 0)) {
-				word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
-					(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
-					((lut[i].blue >> 6) & LUT_10BIT_MASK);
-			} else {
-				diff[0] = (lut[i].red >> 6) - (lut[i - 1].red >> 6);
-				diff[1] = (lut[i].green >> 6) - (lut[i - 1].green >> 6);
-				diff[2] = (lut[i].blue >> 6) - (lut[i - 1].blue >> 6);
-
-				word = ((diff[0] & LUT_10BIT_MASK) << 20) +
-					((diff[1] & LUT_10BIT_MASK) << 10) +
-					(diff[2] & LUT_10BIT_MASK);
-			}
-			writel(word, (lut_base + i * 4));
+	reg = readl(regs + DISP_GAMMA_CFG);
+	reg = reg | GAMMA_LUT_EN;
+	writel(reg, regs + DISP_GAMMA_CFG);
+	lut_base = regs + DISP_GAMMA_LUT;
+	lut = (struct drm_color_lut *)state->gamma_lut->data;
+	for (i = 0; i < MTK_LUT_SIZE; i++) {
+		if (!lut_diff || (i % 2 == 0)) {
+			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
+				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
+				((lut[i].blue >> 6) & LUT_10BIT_MASK);
+		} else {
+			diff[0] = (lut[i].red >> 6) - (lut[i - 1].red >> 6);
+			diff[1] = (lut[i].green >> 6) - (lut[i - 1].green >> 6);
+			diff[2] = (lut[i].blue >> 6) - (lut[i - 1].blue >> 6);
+
+			word = ((diff[0] & LUT_10BIT_MASK) << 20) +
+				((diff[1] & LUT_10BIT_MASK) << 10) +
+				(diff[2] & LUT_10BIT_MASK);
 		}
+		writel(word, (lut_base + i * 4));
 	}
 }
 
-- 
2.40.1

