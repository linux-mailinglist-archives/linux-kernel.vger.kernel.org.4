Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5472BBAD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbjFLJGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjFLJFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:05:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D873C15
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:02:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84B636605907;
        Mon, 12 Jun 2023 10:02:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686560526;
        bh=JI4lc9a8QXR5NBTwDSozQ6dg2sDhEor4ZM5gg2fngeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKQFxjdnH+vl70AlE44leMWTR2HIoRGjg1Oz2C9D8tXWCbGNiKIHuwHjJP78Wpl3t
         zf9Wu4CR22LvV5JYJGtLuCcO7xqRI6s2nc+b3kdppAVZ20gHUOGSsC3Qtg3gj6do3c
         6pciq9MW4DrH905coZp1e0GXtDCEqmR6xv98wfYZzgydVEpRXvBbij17X+1g5y3BMP
         CA9YLG8zm5Yy6XSps/c5+yzQCYU6Tfx4bhF4tgZ9EGV+t7mcvFp6Y/z4fjPL5+HuhM
         NMg4I7wxlKEFT9pC1eddEkdHzL+fQeBMmC9/Q5FJrvLM1juWtlKafTqgQ5KkcdECQG
         rT5xCXXiW/+3A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
Subject: [PATCH v6 04/11] drm/mediatek: gamma: Improve and simplify HW LUT calculation
Date:   Mon, 12 Jun 2023 11:01:50 +0200
Message-Id: <20230612090157.68205-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612090157.68205-1-angelogioacchino.delregno@collabora.com>
References: <20230612090157.68205-1-angelogioacchino.delregno@collabora.com>
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

Use drm_color_lut_extract() to avoid open-coding the bits reduction
calculations for each color channel and use a struct drm_color_lut
to temporarily store the information instead of an array of u32.

Also, slightly improve the precision of the HW LUT calculation in the
LUT DIFF case by performing the subtractions on the 16-bits values and
doing the 10 bits conversion later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index b25ba209e7a4..204a1aa7bfc9 100644
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

