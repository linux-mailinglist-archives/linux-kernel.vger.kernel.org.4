Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85925700595
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbjELKc0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 May 2023 06:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbjELKbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 06:31:37 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E41FEA;
        Fri, 12 May 2023 03:31:34 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 3937D24E32A;
        Fri, 12 May 2023 18:27:08 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:26:39 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 18:26:39 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v1 4/5] media: cadence: Add support for external dphy
Date:   Fri, 12 May 2023 18:26:36 +0800
Message-ID: <20230512102637.50917-5-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230512102637.50917-1-jack.zhu@starfivetech.com>
References: <20230512102637.50917-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for external MIPI D-PHY.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 66 +++++++++++++++++---
 1 file changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index bb78f54e944e..18d9c36cd560 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -31,6 +31,12 @@
 #define CSI2RX_STATIC_CFG_DLANE_MAP(llane, plane)	((plane) << (16 + (llane) * 4))
 #define CSI2RX_STATIC_CFG_LANES_MASK			GENMASK(11, 8)
 
+#define CSI2RX_DPHY_LANE_CTRL_REG		0x40
+#define CSI2RX_DPHY_CL_RST			BIT(16)
+#define CSI2RX_DPHY_DL_RST(i)			BIT((i) + 12)
+#define CSI2RX_DPHY_CL_EN			BIT(4)
+#define CSI2RX_DPHY_DL_EN(i)			BIT(i)
+
 #define CSI2RX_STREAM_BASE(n)		(((n) + 1) * 0x100)
 
 #define CSI2RX_STREAM_CTRL_REG(n)		(CSI2RX_STREAM_BASE(n) + 0x000)
@@ -105,6 +111,24 @@ static void csi2rx_reset(struct csi2rx_priv *csi2rx)
 	writel(0, csi2rx->base + CSI2RX_SOFT_RESET_REG);
 }
 
+static int csi2rx_configure_ext_dphy(struct csi2rx_priv *csi2rx)
+{
+	union phy_configure_opts opts = { };
+	int ret;
+
+	ret = phy_power_on(csi2rx->dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_configure(csi2rx->dphy, &opts);
+	if (ret) {
+		phy_power_off(csi2rx->dphy);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int csi2rx_start(struct csi2rx_priv *csi2rx)
 {
 	unsigned int i;
@@ -144,6 +168,17 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	if (ret)
 		goto err_disable_pclk;
 
+	/* Enable DPHY clk and data lanes. */
+	if (csi2rx->dphy) {
+		reg = CSI2RX_DPHY_CL_EN | CSI2RX_DPHY_CL_RST;
+		for (i = 0; i < csi2rx->num_lanes; i++) {
+			reg |= CSI2RX_DPHY_DL_EN(csi2rx->lanes[i] - 1);
+			reg |= CSI2RX_DPHY_DL_RST(csi2rx->lanes[i] - 1);
+		}
+
+		writel(reg, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+	}
+
 	/*
 	 * Create a static mapping between the CSI virtual channels
 	 * and the output stream.
@@ -177,10 +212,22 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		goto err_disable_pixclk;
 
 	reset_control_deassert(csi2rx->sys_rst);
+
+	if (csi2rx->dphy) {
+		ret = csi2rx_configure_ext_dphy(csi2rx);
+		if (ret) {
+			dev_err(csi2rx->dev,
+				"Failed to configure external DPHY: %d\n", ret);
+			goto err_disable_sysclk;
+		}
+	}
+
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
 
+err_disable_sysclk:
+	clk_disable_unprepare(csi2rx->sys_clk);
 err_disable_pixclk:
 	for (; i > 0; i--) {
 		reset_control_assert(csi2rx->pixel_rst[i - 1]);
@@ -213,6 +260,13 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 
 	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
 		dev_warn(csi2rx->dev, "Couldn't disable our subdev\n");
+
+	if (csi2rx->dphy) {
+		writel(0, csi2rx->base + CSI2RX_DPHY_LANE_CTRL_REG);
+
+		if (phy_power_off(csi2rx->dphy))
+			dev_warn(csi2rx->dev, "Couldn't power off DPHY\n");
+	}
 }
 
 static int csi2rx_s_stream(struct v4l2_subdev *subdev, int enable)
@@ -328,15 +382,6 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 		return PTR_ERR(csi2rx->dphy);
 	}
 
-	/*
-	 * FIXME: Once we'll have external D-PHY support, the check
-	 * will need to be removed.
-	 */
-	if (csi2rx->dphy) {
-		dev_err(&pdev->dev, "External D-PHY not supported yet\n");
-		return -EINVAL;
-	}
-
 	ret = clk_prepare_enable(csi2rx->p_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't prepare and enable P clock\n");
@@ -366,7 +411,7 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 	 * FIXME: Once we'll have internal D-PHY support, the check
 	 * will need to be removed.
 	 */
-	if (csi2rx->has_internal_dphy) {
+	if (!csi2rx->dphy && csi2rx->has_internal_dphy) {
 		dev_err(&pdev->dev, "Internal D-PHY not supported yet\n");
 		return -EINVAL;
 	}
@@ -492,6 +537,7 @@ static int csi2rx_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev,
 		 "Probed CSI2RX with %u/%u lanes, %u streams, %s D-PHY\n",
 		 csi2rx->num_lanes, csi2rx->max_lanes, csi2rx->max_streams,
+		 csi2rx->dphy ? "external" :
 		 csi2rx->has_internal_dphy ? "internal" : "no");
 
 	return 0;
-- 
2.34.1

