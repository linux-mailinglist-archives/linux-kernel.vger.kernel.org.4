Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5276F7122
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjEDRgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjEDRgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:36:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2F5589;
        Thu,  4 May 2023 10:36:28 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-211-176.ewe-ip-backbone.de [91.248.211.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F5BE660570C;
        Thu,  4 May 2023 18:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683221785;
        bh=JRA4rbYQN2WDlDgM+lLQRDDOel1gAU5BBrsIXnna0m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QloSqe/jj/e26mZoAG5vmD3/CbwN4VG+cv1oO/+SWmhPrM4xtg2iO3Qk+vpFx5yMy
         /qz90hRCC/zMMA8iRWgAJLKvp0iBt/+B9B+hzMYAAu5qXVRQ+lnR7N/KD82TZNqojt
         KxZXAX7YvwlknmuTGvyOZJCSrgzuUrHkzZlQ4tA+XfDiraD53RxyI/hajGpv3l/76t
         9csVJNsfUy5ObTRhZTXWkpRKFV6NzNIEYytnd5Vo781J+tOqBfh7g61k5WVXH4EMYX
         IYM+LRMHE0Cek0I/swQY21Rs2LU+oDxlHZLHFJVesNoBNpVSklCMIK1PinNoWR7qBo
         m3H3nLQzdPmSQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id E751A4807F7; Thu,  4 May 2023 19:36:20 +0200 (CEST)
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
Subject: [PATCH v8 12/14] regulator: rk808: cleanup parent device usage
Date:   Thu,  4 May 2023 19:36:16 +0200
Message-Id: <20230504173618.142075-13-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504173618.142075-1-sebastian.reichel@collabora.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
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

By overridering the device's of_node a bit earlier we can
get the GPIOs and any other DT properties from our own
device instead of relying on the parent device.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/regulator/rk808-regulator.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 80ba782d8923..71a1ca8b917e 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -1245,20 +1245,19 @@ static const struct regulator_desc rk818_reg[] = {
 };
 
 static int rk808_regulator_dt_parse_pdata(struct device *dev,
-				   struct device *client_dev,
 				   struct regmap *map,
 				   struct rk808_regulator_data *pdata)
 {
 	struct device_node *np;
 	int tmp, ret = 0, i;
 
-	np = of_get_child_by_name(client_dev->of_node, "regulators");
+	np = of_get_child_by_name(dev->of_node, "regulators");
 	if (!np)
 		return -ENXIO;
 
 	for (i = 0; i < ARRAY_SIZE(pdata->dvs_gpio); i++) {
 		pdata->dvs_gpio[i] =
-			devm_gpiod_get_index_optional(client_dev, "dvs", i,
+			devm_gpiod_get_index_optional(dev, "dvs", i,
 						      GPIOD_OUT_LOW);
 		if (IS_ERR(pdata->dvs_gpio[i])) {
 			ret = PTR_ERR(pdata->dvs_gpio[i]);
@@ -1292,6 +1291,9 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret, i, nregulators;
 
+	pdev->dev.of_node = pdev->dev.parent->of_node;
+	pdev->dev.of_node_reused = true;
+
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
 		return -ENODEV;
@@ -1300,8 +1302,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -ENOMEM;
 
-	ret = rk808_regulator_dt_parse_pdata(&pdev->dev, pdev->dev.parent,
-					     regmap, pdata);
+	ret = rk808_regulator_dt_parse_pdata(&pdev->dev, regmap, pdata);
 	if (ret < 0)
 		return ret;
 
@@ -1335,8 +1336,6 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	}
 
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
-	config.dev->of_node_reused = true;
 	config.driver_data = pdata;
 	config.regmap = regmap;
 
-- 
2.39.2

