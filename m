Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9776F3EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjEBIRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbjEBIRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:17:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F424EF9
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:17:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1AA6E6605636;
        Tue,  2 May 2023 09:17:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683015426;
        bh=e+z2Zo2svQXmXgzmCCJ1yKre7NYLgaysXM+EwLcVdPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7exdU/lMDKFOa/Aq8YbHIXa4raSyWn4Z0d7cM5qHt1CrxDg49fvp6FBX0TYFsGQA
         8PQOUDcCh2T/g710+OxvDkfWq7WDdCOcoI1kSG70rjsJfWN3VFn/vbzIDaQ7fPyZP2
         tpbN+y+pLvYZJt5eWIoOn5e5FVWQI6r/zecfwNhI6NWReml0B71h8F/XXeVIExOiM4
         ls1j1oblXdcE2e6A7oXdNPcex6/CyO/A6tpWYgP/Tjvdz+8ybqSEU1j/rlmjqWRpRF
         BuwteCJvytLLCtlbLWOocFSfrbJ6crVVowOMfbtsTASRTR+t4LI0sTv+IFvO1OrOvU
         MOZIVkd1OFhLQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: [PATCH 11/11] drm/mediatek: gamma: Program gamma LUT type for descending or rising
Date:   Tue,  2 May 2023 10:16:50 +0200
Message-Id: <20230502081650.25947-12-angelogioacchino.delregno@collabora.com>
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

All of the SoCs that don't have dithering control in the gamma IP
have got a GAMMA_LUT_TYPE bit that tells to the IP if the LUT is
"descending" (bit set) or "rising" (bit cleared): make sure to set
it correctly after programming the LUT.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 3501c8b549be..ac7ab3863f6f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -22,6 +22,7 @@
 #define GAMMA_RELAY_MODE				BIT(0)
 #define GAMMA_LUT_EN					BIT(1)
 #define GAMMA_DITHERING					BIT(2)
+#define GAMMA_LUT_TYPE					BIT(2)
 #define DISP_GAMMA_SIZE				0x0030
 #define DISP_GAMMA_SIZE_HSIZE				GENMASK(28, 16)
 #define DISP_GAMMA_SIZE_VSIZE				GENMASK(12, 0)
@@ -88,6 +89,16 @@ unsigned int mtk_gamma_get_lut_size(struct device *dev)
 	return lut_size;
 }
 
+static bool mtk_gamma_lut_is_descending(struct drm_color_lut *lut, u32 lut_size)
+{
+	u64 first, last;
+
+	first = lut[0].red + lut[0].green + lut[0].blue;
+	last = lut[lut_size].red + lut[lut_size].green + lut[lut_size].blue;
+
+	return !!(first > last);
+}
+
 void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crtc_state *state)
 {
 	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
@@ -181,6 +192,14 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
 		}
 	}
 
+	if (gamma && !gamma->data->has_dither) {
+		/* Descending or Rising LUT */
+		if (mtk_gamma_lut_is_descending(lut, lut_size))
+			cfg_val |= FIELD_PREP(GAMMA_LUT_TYPE, 1);
+		else
+			cfg_val &= ~GAMMA_LUT_TYPE;
+	}
+
 	/* Enable the gamma table */
 	cfg_val |= FIELD_PREP(GAMMA_LUT_EN, 1);
 
-- 
2.40.1

