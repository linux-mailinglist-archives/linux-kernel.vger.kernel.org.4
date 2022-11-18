Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE2F62F17E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbiKRJki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242033AbiKRJkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:40:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A130C97AA1;
        Fri, 18 Nov 2022 01:40:07 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CE37FAF4;
        Fri, 18 Nov 2022 10:40:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764406;
        bh=r3zG8M3+1vjzPmVaCplSDSJRv45l8DK+PswNmoO1740=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNoWIfAwrB+zmsCMb6WC84RuhSsAcKNwQXpCGjRFagfN/SnGrIqnRLm1leQg755xt
         wbmw87fvY0/UecsUB317W/wE75aWkzV9eu7L/wCu7Jo4Kt9ZnkNJO2N/lMr4WKZ41r
         Dv0zPnqUpcY/e52DTIdKO5gmxLmpjZFi5uHqwpnY=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/14] media: rkisp1: Add and set registers for crop for i.MX8MP
Date:   Fri, 18 Nov 2022 18:39:23 +0900
Message-Id: <20221118093931.1284465-7-paul.elder@ideasonboard.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
References: <20221118093931.1284465-1-paul.elder@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ISP version in the i.MX8MP has a separate set of registers for crop
that is currently not handled. Add a feature flag to determine which
type of crop the ISP supports and set the crop registers based on that.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
Changes since v2:

- Document the RKISP1_FEATURE_DUAL_CROP and RKISP1_FEATURE_RSZ_CROP bits
- Use the rkisp1_has_feature() macro
---
 .../platform/rockchip/rkisp1/rkisp1-common.h  |  4 ++++
 .../platform/rockchip/rkisp1/rkisp1-debug.c   | 14 +++++++++++++-
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  7 +++++--
 .../platform/rockchip/rkisp1/rkisp1-regs.h    |  9 +++++++++
 .../platform/rockchip/rkisp1/rkisp1-resizer.c | 19 +++++++++++++++++--
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 1f9f373aa2a5..d8851dca026f 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -103,6 +103,8 @@ enum rkisp1_isp_pad {
  * enum rkisp1_feature - ISP features
  *
  * @RKISP1_FEATURE_MIPI_CSI2: The ISP has an internal MIPI CSI-2 receiver
+ * @RKISP1_FEATURE_DUAL_CROP: The ISP has the dual crop block at the resizer input
+ * @RKISP1_FEATURE_RSZ_CROP: The ISP supports cropping in the resizer
  *
  * The ISP features are stored in a bitmask in &rkisp1_info.features and allow
  * the driver to implement support for features present in some ISP versions
@@ -110,6 +112,8 @@ enum rkisp1_isp_pad {
  */
 enum rkisp1_feature {
 	RKISP1_FEATURE_MIPI_CSI2 = BIT(0),
+	RKISP1_FEATURE_DUAL_CROP = BIT(1),
+	RKISP1_FEATURE_RSZ_CROP = BIT(2),
 };
 
 #define rkisp1_has_feature(rkisp1, feature) \
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
index 71df3dc95e6f..d7208dbafd11 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
@@ -115,9 +115,21 @@ static int rkisp1_debug_dump_rsz_regs_show(struct seq_file *m, void *p)
 		RKISP1_DEBUG_SHD_REG(RSZ_PHASE_VC),
 		{ /* Sentinel */ },
 	};
+	static const struct rkisp1_debug_register crop_registers[] = {
+		RKISP1_DEBUG_SHD_REG(RSZ_CROP_X_DIR),
+		RKISP1_DEBUG_SHD_REG(RSZ_CROP_Y_DIR),
+		RKISP1_DEBUG_REG(RSZ_FRAME_RATE),
+		RKISP1_DEBUG_REG(RSZ_FORMAT_CONV_CTRL),
+		{ /* Sentinel */ },
+	};
 	struct rkisp1_resizer *rsz = m->private;
 
-	return rkisp1_debug_dump_regs(rsz->rkisp1, m, rsz->regs_base, registers);
+	rkisp1_debug_dump_regs(rsz->rkisp1, m, rsz->regs_base, registers);
+	if (rkisp1_has_feature(rsz->rkisp1, RSZ_CROP))
+		rkisp1_debug_dump_regs(rsz->rkisp1, m, rsz->regs_base,
+				       crop_registers);
+
+	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_rsz_regs);
 
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 245caf1725aa..4fca4db091c8 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -475,7 +475,8 @@ static const struct rkisp1_info px30_isp_info = {
 	.isrs = px30_isp_isrs,
 	.isr_size = ARRAY_SIZE(px30_isp_isrs),
 	.isp_ver = RKISP1_V12,
-	.features = RKISP1_FEATURE_MIPI_CSI2,
+	.features = RKISP1_FEATURE_MIPI_CSI2
+		  | RKISP1_FEATURE_DUAL_CROP,
 };
 
 static const char * const rk3399_isp_clks[] = {
@@ -494,7 +495,8 @@ static const struct rkisp1_info rk3399_isp_info = {
 	.isrs = rk3399_isp_isrs,
 	.isr_size = ARRAY_SIZE(rk3399_isp_isrs),
 	.isp_ver = RKISP1_V10,
-	.features = RKISP1_FEATURE_MIPI_CSI2,
+	.features = RKISP1_FEATURE_MIPI_CSI2
+		  | RKISP1_FEATURE_DUAL_CROP,
 };
 
 static const char * const imx8mp_isp_clks[] = {
@@ -513,6 +515,7 @@ static const struct rkisp1_info imx8mp_isp_info = {
 	.isrs = imx8mp_isp_isrs,
 	.isr_size = ARRAY_SIZE(imx8mp_isp_isrs),
 	.isp_ver = IMX8MP_V10,
+	.features = RKISP1_FEATURE_RSZ_CROP,
 };
 
 static const struct of_device_id rkisp1_of_match[] = {
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
index 421cc73355db..cd6ce66945c4 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-regs.h
@@ -168,6 +168,9 @@
 #define RKISP1_CIF_RSZ_CTRL_CFG_UPD_AUTO		BIT(9)
 #define RKISP1_CIF_RSZ_SCALER_FACTOR			BIT(16)
 
+/* RSZ_CROP_[XY]_DIR */
+#define RKISP1_CIF_RSZ_CROP_XY_DIR(start, end)		((end) << 16 | (start) << 0)
+
 /* MI_IMSC - MI_MIS - MI_RIS - MI_ICR - MI_ISR */
 #define RKISP1_CIF_MI_FRAME(stream)			BIT((stream)->id)
 #define RKISP1_CIF_MI_MBLK_LINE				BIT(2)
@@ -925,6 +928,12 @@
 #define RKISP1_CIF_RSZ_PHASE_HC_SHD		0x004C
 #define RKISP1_CIF_RSZ_PHASE_VY_SHD		0x0050
 #define RKISP1_CIF_RSZ_PHASE_VC_SHD		0x0054
+#define RKISP1_CIF_RSZ_CROP_X_DIR		0x0058
+#define RKISP1_CIF_RSZ_CROP_Y_DIR		0x005C
+#define RKISP1_CIF_RSZ_CROP_X_DIR_SHD		0x0060
+#define RKISP1_CIF_RSZ_CROP_Y_DIR_SHD		0x0064
+#define RKISP1_CIF_RSZ_FRAME_RATE		0x0068
+#define RKISP1_CIF_RSZ_FORMAT_CONV_CTRL		0x006C
 
 #define RKISP1_CIF_MI_BASE			0x00001400
 #define RKISP1_CIF_MI_CTRL			(RKISP1_CIF_MI_BASE + 0x00000000)
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
index f76afd8112b2..cefc3cfb733c 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-resizer.c
@@ -244,6 +244,7 @@ static void rkisp1_rsz_config_regs(struct rkisp1_resizer *rsz,
 {
 	u32 ratio, rsz_ctrl = 0;
 	unsigned int i;
+	u32 val;
 
 	/* No phase offset */
 	rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_PHASE_HY, 0);
@@ -292,6 +293,18 @@ static void rkisp1_rsz_config_regs(struct rkisp1_resizer *rsz,
 
 	rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CTRL, rsz_ctrl);
 
+	if (rkisp1_has_feature(rsz->rkisp1, RSZ_CROP)) {
+		val = RKISP1_CIF_RSZ_CROP_XY_DIR(src_y->left, src_y->left + src_y->width - 1);
+		rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CROP_X_DIR, val);
+		val = RKISP1_CIF_RSZ_CROP_XY_DIR(src_y->top, src_y->top + src_y->height - 1);
+		rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_CROP_Y_DIR, val);
+
+		val = RKISP1_CIF_RSZ_FORMAT_CONV_CTRL_RSZ_INPUT_FORMAT_YCBCR_422
+		    | RKISP1_CIF_RSZ_FORMAT_CONV_CTRL_RSZ_OUTPUT_FORMAT_YCBCR_420
+		    | RKISP1_CIF_RSZ_FORMAT_CONV_CTRL_RSZ_PACK_FORMAT_SEMI_PLANAR;
+		rkisp1_rsz_write(rsz, RKISP1_CIF_RSZ_FORMAT_CONV_CTRL, val);
+	}
+
 	rkisp1_rsz_update_shadow(rsz, when);
 }
 
@@ -695,7 +708,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
 	enum rkisp1_shadow_regs_when when = RKISP1_SHADOW_REGS_SYNC;
 
 	if (!enable) {
-		rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
+		if (rkisp1_has_feature(rkisp1, DUAL_CROP))
+			rkisp1_dcrop_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
 		rkisp1_rsz_disable(rsz, RKISP1_SHADOW_REGS_ASYNC);
 		return 0;
 	}
@@ -705,7 +719,8 @@ static int rkisp1_rsz_s_stream(struct v4l2_subdev *sd, int enable)
 
 	mutex_lock(&rsz->ops_lock);
 	rkisp1_rsz_config(rsz, when);
-	rkisp1_dcrop_config(rsz);
+	if (rkisp1_has_feature(rkisp1, DUAL_CROP))
+		rkisp1_dcrop_config(rsz);
 
 	mutex_unlock(&rsz->ops_lock);
 	return 0;
-- 
2.35.1

