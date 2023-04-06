Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34CD6DA1BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbjDFTmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237881AbjDFTmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:42:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CA39747;
        Thu,  6 Apr 2023 12:42:24 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E70F66031CF;
        Thu,  6 Apr 2023 20:42:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680810143;
        bh=aW4fe1+DDo3cV0bZP+53AoiJSFgqHyfIP7z13IHIZi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aEHJyh2X1YhOg4vQKdBRIVPbQn8OBAJuEP3l1Iqrt6aX9fw7XYha1LnPXjg1Y3xMt
         zZwhhnDiZQM9phbDAtQEIEU4gvY3faGu6uR6zkhVn80soUn8dVf+Uy8uO45FRMAi5S
         VeOV/hTHD41F8ibJRNumKBIqbLICGj08djW58vqkLeiNWZ66lgVAfR/UbVBzZFL3vF
         tIRteF2by+S7azDg/t1pXjalQsWjA3dmNkan7AzL7p5Vp3Q34jyJvRTnL+X/f8ciUV
         oCz+P+4GhoF4TxalYYjoJV+EKEg0boZ9WEeZU1ikmM7ZQEGd0pSVnItkMhdRCAhGDr
         cDxqG7J21FlRA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 7/8] regulator: fan53555: Use dev_err_probe
Date:   Thu,  6 Apr 2023 22:41:57 +0300
Message-Id: <20230406194158.963352-8-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
References: <20230406194158.963352-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe() instead of dev_err() in the probe function, which
ensures the error code is always printed and, additionally, simplifies
the code a bit.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/regulator/fan53555.c | 47 ++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 39c9c29f4ff6..acf14ba7aaa6 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -568,10 +568,9 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 	if (!pdata)
 		pdata = fan53555_parse_dt(&client->dev, np, &di->desc);
 
-	if (!pdata || !pdata->regulator) {
-		dev_err(&client->dev, "Platform data not found!\n");
-		return -ENODEV;
-	}
+	if (!pdata || !pdata->regulator)
+		return dev_err_probe(&client->dev, -ENODEV,
+				     "Platform data not found!\n");
 
 	di->regulator = pdata->regulator;
 	if (client->dev.of_node) {
@@ -580,10 +579,9 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 	} else {
 		/* if no ramp constraint set, get the pdata ramp_delay */
 		if (!di->regulator->constraints.ramp_delay) {
-			if (pdata->slew_rate >= ARRAY_SIZE(slew_rates)) {
-				dev_err(&client->dev, "Invalid slew_rate\n");
-				return -EINVAL;
-			}
+			if (pdata->slew_rate >= ARRAY_SIZE(slew_rates))
+				return dev_err_probe(&client->dev, -EINVAL,
+						     "Invalid slew_rate\n");
 
 			di->regulator->constraints.ramp_delay
 					= slew_rates[pdata->slew_rate];
@@ -593,34 +591,31 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 	}
 
 	regmap = devm_regmap_init_i2c(client, &fan53555_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to allocate regmap!\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to allocate regmap!\n");
+
 	di->dev = &client->dev;
 	i2c_set_clientdata(client, di);
 	/* Get chip ID */
 	ret = regmap_read(regmap, FAN53555_ID1, &val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to get chip ID!\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to get chip ID!\n");
+
 	di->chip_id = val & DIE_ID;
 	/* Get chip revision */
 	ret = regmap_read(regmap, FAN53555_ID2, &val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to get chip Rev!\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to get chip Rev!\n");
+
 	di->chip_rev = val & DIE_REV;
 	dev_info(&client->dev, "FAN53555 Option[%d] Rev[%d] Detected!\n",
 				di->chip_id, di->chip_rev);
 	/* Device init */
 	ret = fan53555_device_setup(di, pdata);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to setup device!\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Failed to setup device!\n");
+
 	/* Register regulator */
 	config.dev = di->dev;
 	config.init_data = di->regulator;
@@ -630,9 +625,9 @@ static int fan53555_regulator_probe(struct i2c_client *client)
 
 	ret = fan53555_regulator_register(di, &config);
 	if (ret < 0)
-		dev_err(&client->dev, "Failed to register regulator!\n");
-	return ret;
+		dev_err_probe(&client->dev, ret, "Failed to register regulator!\n");
 
+	return ret;
 }
 
 static const struct i2c_device_id fan53555_id[] = {
-- 
2.40.0

