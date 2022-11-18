Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7C62F17B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 10:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241582AbiKRJkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 04:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242006AbiKRJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 04:40:11 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAA4AF16;
        Fri, 18 Nov 2022 01:40:03 -0800 (PST)
Received: from pyrite.tail37cf.ts.net (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id EA73BCCA;
        Fri, 18 Nov 2022 10:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668764402;
        bh=HsmzzNy9bNbCe7hoI+/Bj6bzVvdd9lHy6nSs+THn7Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EO0/XrpNOAIwtmkdmi5JvwvMfsCeecpWtegG+3FDMI0Pnt+OeJxYpS66u/K8fR3nk
         JJfx1pP0gaoqi4HPX4GC/NlxtvIkcMRybYA4wGfVje3JwWhB65mDxGIq41ieESOZcs
         +GbRYq6AFKVO5pWp7bv7H4pcBHTrqNppqmMlFwuk=
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     linux-media@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Helen Koike <helen.koike@collabora.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] media: rkisp1: Configure gasket on i.MX8MP
Date:   Fri, 18 Nov 2022 18:39:22 +0900
Message-Id: <20221118093931.1284465-6-paul.elder@ideasonboard.com>
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

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The i.MX8MP has a gasket between the CSI-2 receiver and the ISP.
Configure and enable it when starting the ISP, and disable it when
stopping.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 .../platform/rockchip/rkisp1/rkisp1-common.h  |   5 +
 .../platform/rockchip/rkisp1/rkisp1-dev.c     |  16 +++
 .../platform/rockchip/rkisp1/rkisp1-isp.c     | 128 +++++++++++++++++-
 3 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index fc33c185b99f..1f9f373aa2a5 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -24,6 +24,7 @@
 #include "rkisp1-regs.h"
 
 struct dentry;
+struct regmap;
 
 /*
  * flags on the 'direction' field in struct rkisp1_mbus_info' that indicate
@@ -448,6 +449,8 @@ struct rkisp1_debug {
  * @dev:	   a pointer to the struct device
  * @clk_size:	   number of clocks
  * @clks:	   array of clocks
+ * @gasket:	   the gasket - i.MX8MP only
+ * @gasket_id:	   the gasket ID (0 or 1) - i.MX8MP only
  * @v4l2_dev:	   v4l2_device variable
  * @media_dev:	   media_device variable
  * @notifier:	   a notifier to register on the v4l2-async API to be notified on the sensor
@@ -468,6 +471,8 @@ struct rkisp1_device {
 	struct device *dev;
 	unsigned int clk_size;
 	struct clk_bulk_data clks[RKISP1_MAX_BUS_CLK];
+	struct regmap *gasket;
+	unsigned int gasket_id;
 	struct v4l2_device v4l2_dev;
 	struct media_device media_dev;
 	struct v4l2_async_notifier notifier;
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 69464ce91d59..245caf1725aa 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
@@ -579,6 +580,21 @@ static int rkisp1_probe(struct platform_device *pdev)
 		return ret;
 	rkisp1->clk_size = info->clk_size;
 
+	if (info->isp_ver == IMX8MP_V10) {
+		unsigned int id;
+
+		rkisp1->gasket = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+								      "fsl,blk-ctrl",
+								      1, &id);
+		if (IS_ERR(rkisp1->gasket)) {
+			ret = PTR_ERR(rkisp1->gasket);
+			dev_err(dev, "failed to get gasket: %d\n", ret);
+			return ret;
+		}
+
+		rkisp1->gasket_id = id;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_resume_and_get(&pdev->dev);
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
index 585cf3f53469..029191f4338d 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
@@ -10,6 +10,7 @@
 
 #include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/videodev2.h>
 #include <linux/vmalloc.h>
 
@@ -87,6 +88,115 @@ rkisp1_isp_get_pad_crop(struct rkisp1_isp *isp,
 		return v4l2_subdev_get_try_crop(&isp->sd, &state, pad);
 }
 
+/* -----------------------------------------------------------------------------
+ * Media block control (i.MX8MP only)
+ */
+
+#define ISP_DEWARP_CONTROL				0x0138
+
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY	BIT(22)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_RISING	(0 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_NEGATIVE	(1 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE	(2 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_FALLING	(3 << 20)
+#define ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK	GENMASK(21, 20)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE	BIT(19)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt)	((dt) << 13)
+#define ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK	GENMASK(18, 13)
+
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY	BIT(12)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_RISING	(0 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_NEGATIVE	(1 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE	(2 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_FALLING	(3 << 10)
+#define ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK	GENMASK(11, 10)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE	BIT(9)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt)	((dt) << 3)
+#define ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK	GENMASK(8, 3)
+
+#define ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE		BIT(1)
+#define ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE		BIT(0)
+
+static int rkisp1_gasket_enable(struct rkisp1_device *rkisp1,
+				struct media_pad *source)
+{
+	struct v4l2_subdev *source_sd;
+	struct v4l2_mbus_frame_desc fd;
+	unsigned int dt;
+	u32 mask;
+	u32 val;
+	int ret;
+
+	/*
+	 * Configure and enable the gasket with the CSI-2 data type. Set the
+	 * vsync polarity as active high, as that is what the ISP is configured
+	 * to expect in ISP_ACQ_PROP. Enable left justification, as the i.MX8MP
+	 * ISP has a 16-bit wide input and expects data to be left-aligned.
+	 */
+
+	source_sd = media_entity_to_v4l2_subdev(source->entity);
+	ret = v4l2_subdev_call(source_sd, pad, get_frame_desc,
+			       source->index, &fd);
+	if (ret) {
+		dev_err(rkisp1->dev,
+			"failed to get frame descriptor from '%s':%u: %d\n",
+			source_sd->name, 0, ret);
+		return ret;
+	}
+
+	if (fd.num_entries != 1) {
+		dev_err(rkisp1->dev, "invalid frame descriptor for '%s':%u\n",
+			source_sd->name, 0);
+		return -EINVAL;
+	}
+
+	dt = fd.entry[0].bus.csi2.dt;
+
+	if (rkisp1->gasket_id == 0) {
+		mask = ISP_DEWARP_CONTROL_MIPI_CSI1_HS_POLARITY
+		     | ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_MASK
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+		val = ISP_DEWARP_CONTROL_MIPI_CSI1_VS_SEL_POSITIVE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE(dt);
+	} else {
+		mask = ISP_DEWARP_CONTROL_MIPI_CSI2_HS_POLARITY
+		     | ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_MASK
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+		val = ISP_DEWARP_CONTROL_MIPI_CSI2_VS_SEL_POSITIVE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		    | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE(dt);
+	}
+
+	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
+
+	return 0;
+}
+
+static void rkisp1_gasket_disable(struct rkisp1_device *rkisp1)
+{
+	u32 mask;
+	u32 val;
+
+	if (rkisp1->gasket_id == 1) {
+		mask = ISP_DEWARP_CONTROL_MIPI_ISP2_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP2_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+		val = ISP_DEWARP_CONTROL_GPR_ISP_1_DISABLE;
+	} else {
+		mask = ISP_DEWARP_CONTROL_MIPI_ISP1_LEFT_JUST_MODE
+		     | ISP_DEWARP_CONTROL_MIPI_ISP1_DATA_TYPE_MASK
+		     | ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+		val = ISP_DEWARP_CONTROL_GPR_ISP_0_DISABLE;
+	}
+
+	regmap_update_bits(rkisp1->gasket, ISP_DEWARP_CONTROL, mask, val);
+}
+
 /* ----------------------------------------------------------------------------
  * Camera Interface registers configurations
  */
@@ -304,6 +414,9 @@ static void rkisp1_isp_stop(struct rkisp1_isp *isp)
 		     RKISP1_CIF_VI_IRCL_MIPI_SW_RST |
 		     RKISP1_CIF_VI_IRCL_ISP_SW_RST);
 	rkisp1_write(rkisp1, RKISP1_CIF_VI_IRCL, 0x0);
+
+	if (rkisp1->info->isp_ver == IMX8MP_V10)
+		rkisp1_gasket_disable(rkisp1);
 }
 
 static void rkisp1_config_clk(struct rkisp1_isp *isp)
@@ -328,13 +441,20 @@ static void rkisp1_config_clk(struct rkisp1_isp *isp)
 	}
 }
 
-static void rkisp1_isp_start(struct rkisp1_isp *isp)
+static int rkisp1_isp_start(struct rkisp1_isp *isp, struct media_pad *source)
 {
 	struct rkisp1_device *rkisp1 = isp->rkisp1;
 	u32 val;
+	int ret;
 
 	rkisp1_config_clk(isp);
 
+	if (rkisp1->info->isp_ver == IMX8MP_V10) {
+		ret = rkisp1_gasket_enable(rkisp1, source);
+		if (ret)
+			return ret;
+	}
+
 	/* Activate ISP */
 	val = rkisp1_read(rkisp1, RKISP1_CIF_ISP_CTRL);
 	val |= RKISP1_CIF_ISP_CTRL_ISP_CFG_UPD |
@@ -344,6 +464,8 @@ static void rkisp1_isp_start(struct rkisp1_isp *isp)
 
 	if (isp->src_fmt->pixel_enc != V4L2_PIXEL_ENC_BAYER)
 		rkisp1_params_post_configure(&rkisp1->params);
+
+	return 0;
 }
 
 /* ----------------------------------------------------------------------------
@@ -882,7 +1004,9 @@ static int rkisp1_isp_s_stream(struct v4l2_subdev *sd, int enable)
 	if (ret)
 		goto mutex_unlock;
 
-	rkisp1_isp_start(isp);
+	ret = rkisp1_isp_start(isp, source_pad);
+	if (ret)
+		goto mutex_unlock;
 
 	ret = v4l2_subdev_call(rkisp1->source, video, s_stream, true);
 	if (ret) {
-- 
2.35.1

