Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3006F9215
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjEFMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjEFMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:36:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F39E156AA
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 05:35:59 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C38856605766;
        Sat,  6 May 2023 13:35:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683376558;
        bh=PJ/K8sWSNtETLOGCnVahEeOuYwzPapL8kUix8HM6Smg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LwksvY8WQquW5D94AmooaZNf4OsKMnJ7aSYmGAyUU6HzP2v9Da9Qq710QULegwNdX
         yjKgYG1v4R3LeUCtm3YzTaQ246Uanv3YuekpIIJ8MoXEXjCgsHFl8WuedZAD7/c7s7
         2F2Z+B+JTXO5jeoBRs0o2pr6/GX0MgeisT8pH/6N+1RqSSqYeWJUHmuVkwGssp4hRs
         3zedbx3bpSI6lZsyTbuZ0dCS4iB0mnOGAniZB/NrexI/upFTZwd+AT+P9MsoyvMwMy
         36Y6uWlg82LPo36kThzqa0PTqjm6+drOa0uXpl8i9BhD7MYXiCJQUs6QTONhId1Epw
         nNS63fh5O/rMQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH v3 04/11] drm/mediatek: gamma: Improve and simplify HW LUT calculation
Date:   Sat,  6 May 2023 14:35:42 +0200
Message-Id: <20230506123549.101727-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230506123549.101727-1-angelogioacchino.delregno@collabora.com>
References: <20230506123549.101727-1-angelogioacchino.delregno@collabora.com>
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

Use drm_color_lut_extract() to avoid open-coding the bits reduction
calculations for each color channel and use a struct drm_color_lut
to temporarily store the information instead of an array of u32.

Also, slightly improve the precision of the HW LUT calculation in the
LUT DIFF case by performing the subtractions on the 16-bits values and
doing the 10 bits conversion later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index d194d9bc2e2b..60ccea8c1e1a 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -77,7 +77,6 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	bool lut_diff;
 	u16 lut_size;
 	u32 word;
-	u32 diff[3] = {0};
 
 	/* If there's no gamma lut there's nothing to do here. */
 	if (!state->gamma_lut)
@@ -97,18 +96,29 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 	lut_base = regs + DISP_GAMMA_LUT;
 	lut = (struct drm_color_lut *)state->gamma_lut->data;
 	for (i = 0; i < lut_size; i++) {
+		struct drm_color_lut diff, hwlut;
+
+		hwlut.red = drm_color_lut_extract(lut[i].red, 10);
+		hwlut.green = drm_color_lut_extract(lut[i].green, 10);
+		hwlut.blue = drm_color_lut_extract(lut[i].blue, 10);
+
 		if (!lut_diff || (i % 2 == 0)) {
-			word = (((lut[i].red >> 6) & LUT_10BIT_MASK) << 20) +
-				(((lut[i].green >> 6) & LUT_10BIT_MASK) << 10) +
-				((lut[i].blue >> 6) & LUT_10BIT_MASK);
+			word = hwlut.red << 20 +
+			       hwlut.green << 10 +
+			       hwlut.red;
 		} else {
-			diff[0] = (lut[i].red >> 6) - (lut[i - 1].red >> 6);
-			diff[1] = (lut[i].green >> 6) - (lut[i - 1].green >> 6);
-			diff[2] = (lut[i].blue >> 6) - (lut[i - 1].blue >> 6);
+			diff.red = lut[i].red - lut[i - 1].red;
+			diff.red = drm_color_lut_extract(diff.red, 10);
+
+			diff.green = lut[i].green - lut[i - 1].green;
+			diff.green = drm_color_lut_extract(diff.green, 10);
+
+			diff.blue = lut[i].blue - lut[i - 1].blue;
+			diff.blue = drm_color_lut_extract(diff.blue, 10);
 
-			word = ((diff[0] & LUT_10BIT_MASK) << 20) +
-				((diff[1] & LUT_10BIT_MASK) << 10) +
-				(diff[2] & LUT_10BIT_MASK);
+			word = diff.blue << 20 +
+			       diff.green << 10 +
+			       diff.red;
 		}
 		writel(word, (lut_base + i * 4));
 	}
-- 
2.40.1

