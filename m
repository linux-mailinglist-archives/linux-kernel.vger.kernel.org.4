Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC167ED21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjA0SNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 13:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjA0SNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 13:13:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DCD80175;
        Fri, 27 Jan 2023 10:13:22 -0800 (PST)
Received: from jupiter.universe (dyndsl-095-033-159-051.ewe-ip-backbone.de [95.33.159.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D5EC6602E9D;
        Fri, 27 Jan 2023 18:13:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674843200;
        bh=UO3zPVe9J/8GAbNzZJrvJERA9Z9ujQlsAdpOs77iZa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD8FEPDqK/pBsq2+KZKDDcAx4iM9zmkevZNqEVGpKKnF3deg0V9VNJfapWbzOEGan
         xN6Nd5T9gGekUR8lgQ7jp9HX+bnfnctEzvZc02f46wiJ/YJd+aW42DfNGu8vm6KGQt
         gSmPMjPILRo8ajccwYAC4nwtZi6rS9DOOCuiHhK7+sVWXmVSRz94ZMiql3Jm0ctjcG
         V7qjzw6R/tXypMjS1sxIQypvdTQFWmTFn4XwJLpbJ9+MAub1N2XU9jkOcCW5dn92od
         2RuvpWnAfpgjXb+u1yOASNHl+ImO5+p7SVEQRqYFMweIpFVR5MSEPv6bWbVUM5KLp2
         Th91JyuYnmOtg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 2EEDB48010D; Fri, 27 Jan 2023 19:13:17 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv6 01/11] clk: RK808: reduce 'struct rk808' usage
Date:   Fri, 27 Jan 2023 19:12:34 +0100
Message-Id: <20230127181244.160887-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230127181244.160887-1-sebastian.reichel@collabora.com>
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce usage of 'struct rk808' (driver data of the parent MFD), so
that only the chip variant field is still being accessed directly.
This allows restructuring the MFD driver to support SPI based
PMICs.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/clk-rk808.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 32f833d732ed..f7412b137e5e 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -12,10 +12,9 @@
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/rk808.h>
-#include <linux/i2c.h>
 
 struct rk808_clkout {
-	struct rk808 *rk808;
+	struct regmap		*regmap;
 	struct clk_hw		clkout1_hw;
 	struct clk_hw		clkout2_hw;
 };
@@ -31,9 +30,8 @@ static int rk808_clkout2_enable(struct clk_hw *hw, bool enable)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
 
-	return regmap_update_bits(rk808->regmap, RK808_CLK32OUT_REG,
+	return regmap_update_bits(rk808_clkout->regmap, RK808_CLK32OUT_REG,
 				  CLK32KOUT2_EN, enable ? CLK32KOUT2_EN : 0);
 }
 
@@ -52,10 +50,9 @@ static int rk808_clkout2_is_prepared(struct clk_hw *hw)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
 	uint32_t val;
 
-	int ret = regmap_read(rk808->regmap, RK808_CLK32OUT_REG, &val);
+	int ret = regmap_read(rk808_clkout->regmap, RK808_CLK32OUT_REG, &val);
 
 	if (ret < 0)
 		return ret;
@@ -93,9 +90,8 @@ static int rk817_clkout2_enable(struct clk_hw *hw, bool enable)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
 
-	return regmap_update_bits(rk808->regmap, RK817_SYS_CFG(1),
+	return regmap_update_bits(rk808_clkout->regmap, RK817_SYS_CFG(1),
 				  RK817_CLK32KOUT2_EN,
 				  enable ? RK817_CLK32KOUT2_EN : 0);
 }
@@ -115,10 +111,9 @@ static int rk817_clkout2_is_prepared(struct clk_hw *hw)
 	struct rk808_clkout *rk808_clkout = container_of(hw,
 							 struct rk808_clkout,
 							 clkout2_hw);
-	struct rk808 *rk808 = rk808_clkout->rk808;
 	unsigned int val;
 
-	int ret = regmap_read(rk808->regmap, RK817_SYS_CFG(1), &val);
+	int ret = regmap_read(rk808_clkout->regmap, RK817_SYS_CFG(1), &val);
 
 	if (ret < 0)
 		return 0;
@@ -153,18 +148,21 @@ static const struct clk_ops *rkpmic_get_ops(long variant)
 static int rk808_clkout_probe(struct platform_device *pdev)
 {
 	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
-	struct device_node *node = client->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct clk_init_data init = {};
 	struct rk808_clkout *rk808_clkout;
 	int ret;
 
-	rk808_clkout = devm_kzalloc(&client->dev,
+	dev->of_node = pdev->dev.parent->of_node;
+
+	rk808_clkout = devm_kzalloc(dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);
 	if (!rk808_clkout)
 		return -ENOMEM;
 
-	rk808_clkout->rk808 = rk808;
+	rk808_clkout->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!rk808_clkout->regmap)
+		return -ENODEV;
 
 	init.parent_names = NULL;
 	init.num_parents = 0;
@@ -173,10 +171,10 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	rk808_clkout->clkout1_hw.init = &init;
 
 	/* optional override of the clockname */
-	of_property_read_string_index(node, "clock-output-names",
+	of_property_read_string_index(dev->of_node, "clock-output-names",
 				      0, &init.name);
 
-	ret = devm_clk_hw_register(&client->dev, &rk808_clkout->clkout1_hw);
+	ret = devm_clk_hw_register(dev, &rk808_clkout->clkout1_hw);
 	if (ret)
 		return ret;
 
@@ -185,10 +183,10 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	rk808_clkout->clkout2_hw.init = &init;
 
 	/* optional override of the clockname */
-	of_property_read_string_index(node, "clock-output-names",
+	of_property_read_string_index(dev->of_node, "clock-output-names",
 				      1, &init.name);
 
-	ret = devm_clk_hw_register(&client->dev, &rk808_clkout->clkout2_hw);
+	ret = devm_clk_hw_register(dev, &rk808_clkout->clkout2_hw);
 	if (ret)
 		return ret;
 
-- 
2.39.0

