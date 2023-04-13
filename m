Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48736E0588
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjDMDzx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Apr 2023 23:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDMDzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:55:49 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180C1527E;
        Wed, 12 Apr 2023 20:55:46 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A454524E171;
        Thu, 13 Apr 2023 11:55:43 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 11:55:43 +0800
Received: from xiaofei.localdomain (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 13 Apr
 2023 11:55:43 +0800
From:   Jack Zhu <jack.zhu@starfivetech.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jack.zhu@starfivetech.com>,
        <changhuang.liang@starfivetech.com>
Subject: [PATCH v4 3/8] media: cadence: Add operation on reset
Date:   Thu, 13 Apr 2023 11:55:36 +0800
Message-ID: <20230413035541.62129-4-jack.zhu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230413035541.62129-1-jack.zhu@starfivetech.com>
References: <20230413035541.62129-1-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add operation on reset for Cadence MIPI-CSI2 RX Controller.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 40 +++++++++++++++++---
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index cc3ebb0d96f6..c5bc40491bf8 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -13,6 +13,7 @@
 #include <linux/of_graph.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 
 #include <media/v4l2-ctrls.h>
@@ -68,6 +69,9 @@ struct csi2rx_priv {
 	struct clk			*sys_clk;
 	struct clk			*p_clk;
 	struct clk			*pixel_clk[CSI2RX_STREAMS_MAX];
+	struct reset_control		*sys_rst;
+	struct reset_control		*p_rst;
+	struct reset_control		*pixel_rst[CSI2RX_STREAMS_MAX];
 	struct phy			*dphy;
 
 	u8				lanes[CSI2RX_LANES_MAX];
@@ -112,6 +116,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	if (ret)
 		return ret;
 
+	reset_control_deassert(csi2rx->p_rst);
 	csi2rx_reset(csi2rx);
 
 	reg = csi2rx->num_lanes << 8;
@@ -154,6 +159,8 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 		if (ret)
 			goto err_disable_pixclk;
 
+		reset_control_deassert(csi2rx->pixel_rst[i]);
+
 		writel(CSI2RX_STREAM_CFG_FIFO_MODE_LARGE_BUF,
 		       csi2rx->base + CSI2RX_STREAM_CFG_REG(i));
 
@@ -169,13 +176,16 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	if (ret)
 		goto err_disable_pixclk;
 
+	reset_control_deassert(csi2rx->sys_rst);
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	return 0;
 
 err_disable_pixclk:
-	for (; i > 0; i--)
+	for (; i > 0; i--) {
+		reset_control_assert(csi2rx->pixel_rst[i - 1]);
 		clk_disable_unprepare(csi2rx->pixel_clk[i - 1]);
+	}
 
 err_disable_pclk:
 	clk_disable_unprepare(csi2rx->p_clk);
@@ -188,14 +198,17 @@ static void csi2rx_stop(struct csi2rx_priv *csi2rx)
 	unsigned int i;
 
 	clk_prepare_enable(csi2rx->p_clk);
+	reset_control_assert(csi2rx->sys_rst);
 	clk_disable_unprepare(csi2rx->sys_clk);
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
 		writel(0, csi2rx->base + CSI2RX_STREAM_CTRL_REG(i));
 
+		reset_control_assert(csi2rx->pixel_rst[i]);
 		clk_disable_unprepare(csi2rx->pixel_clk[i]);
 	}
 
+	reset_control_assert(csi2rx->p_rst);
 	clk_disable_unprepare(csi2rx->p_clk);
 
 	if (v4l2_subdev_call(csi2rx->source_subdev, video, s_stream, false))
@@ -299,6 +312,16 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 		return PTR_ERR(csi2rx->p_clk);
 	}
 
+	csi2rx->sys_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								    "sys_rst");
+	if (IS_ERR(csi2rx->sys_rst))
+		return PTR_ERR(csi2rx->sys_rst);
+
+	csi2rx->p_rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								  "p_rst");
+	if (IS_ERR(csi2rx->p_rst))
+		return PTR_ERR(csi2rx->p_rst);
+
 	csi2rx->dphy = devm_phy_optional_get(&pdev->dev, "dphy");
 	if (IS_ERR(csi2rx->dphy)) {
 		dev_err(&pdev->dev, "Couldn't get external D-PHY\n");
@@ -349,14 +372,21 @@ static int csi2rx_get_resources(struct csi2rx_priv *csi2rx,
 	}
 
 	for (i = 0; i < csi2rx->max_streams; i++) {
-		char clk_name[16];
+		char name[16];
 
-		snprintf(clk_name, sizeof(clk_name), "pixel_if%u_clk", i);
-		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, clk_name);
+		snprintf(name, sizeof(name), "pixel_if%u_clk", i);
+		csi2rx->pixel_clk[i] = devm_clk_get(&pdev->dev, name);
 		if (IS_ERR(csi2rx->pixel_clk[i])) {
-			dev_err(&pdev->dev, "Couldn't get clock %s\n", clk_name);
+			dev_err(&pdev->dev, "Couldn't get clock %s\n", name);
 			return PTR_ERR(csi2rx->pixel_clk[i]);
 		}
+
+		snprintf(name, sizeof(name), "pixel_if%u_rst", i);
+		csi2rx->pixel_rst[i] =
+			devm_reset_control_get_optional_exclusive(&pdev->dev,
+								  name);
+		if (IS_ERR(csi2rx->pixel_rst[i]))
+			return PTR_ERR(csi2rx->pixel_rst[i]);
 	}
 
 	return 0;
-- 
2.34.1

