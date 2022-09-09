Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CA55B3E56
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiIIRzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiIIRzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:55:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ECCA5733;
        Fri,  9 Sep 2022 10:55:30 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-168-128.ewe-ip-backbone.de [95.33.168.128])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42BD06601FCC;
        Fri,  9 Sep 2022 18:55:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662746129;
        bh=IC1rK2OqFIDOqVyBFEnQKGCt/HS50EnZDKdwgpxQ60k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mO/8sLb4r+dAhQsEd1+nptTW8KuGq833Svh16QSjdjzBAOxtOSfhVhkPZbRSVqMq/
         N5uFsfskbg94wWd4nfbeHBu+HZRl5Vihhzz3ZqQAWpUPin8mjUTrnQsvKrUDV974O/
         YrVRySJUS6xlerH7BPK6BzqolSsHGyYUf+Bfhj6UICzDlrPjSkG6JRb8T9He5ipz0I
         slHzy4CsNRAEKajTDbRqhdcLgUoSMuWnPito8HyZNOmGiGfFiSZZmzp2VcUO2O05tN
         /KC5K3YIMKz6M1t+Hlv9LBgXzMfoIi4/jzASPtJAe3qzYiKeo+BwMWbLgfKr2r/BoK
         rZ0XqMcNkoSmw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 1674A48016C; Fri,  9 Sep 2022 19:55:27 +0200 (CEST)
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
Subject: [PATCHv3 02/14] mfd: rk808: use dev_err_probe
Date:   Fri,  9 Sep 2022 19:55:10 +0200
Message-Id: <20220909175522.179175-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220909175522.179175-1-sebastian.reichel@collabora.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
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

Use dev_err_probe instead of dev_err in probe function,
which simplifies code a little bit and prints the error
code.

Also drop possibly incorrect printing of chip id registers
while touching the error message.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/mfd/rk808.c | 48 +++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index c17fea1d48ca..8b18a9d9cb74 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -650,18 +650,12 @@ static int rk808_probe(struct i2c_client *client,
 
 	/* Read chip variant */
 	msb = i2c_smbus_read_byte_data(client, pmic_id_msb);
-	if (msb < 0) {
-		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
-			RK808_ID_MSB);
-		return msb;
-	}
+	if (msb < 0)
+		return dev_err_probe(&client->dev, msb, "failed to read the chip id MSB\n");
 
 	lsb = i2c_smbus_read_byte_data(client, pmic_id_lsb);
-	if (lsb < 0) {
-		dev_err(&client->dev, "failed to read the chip id at 0x%x\n",
-			RK808_ID_LSB);
-		return lsb;
-	}
+	if (lsb < 0)
+		return dev_err_probe(&client->dev, lsb, "failed to read the chip id LSB\n");
 
 	rk808->variant = ((msb << 8) | lsb) & RK8XX_ID_MSK;
 	dev_info(&client->dev, "chip id: 0x%x\n", (unsigned int)rk808->variant);
@@ -710,44 +704,34 @@ static int rk808_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, rk808);
 
 	rk808->regmap = devm_regmap_init_i2c(client, rk808->regmap_cfg);
-	if (IS_ERR(rk808->regmap)) {
-		dev_err(&client->dev, "regmap initialization failed\n");
-		return PTR_ERR(rk808->regmap);
-	}
+	if (IS_ERR(rk808->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(rk808->regmap),
+				     "regmap initialization failed\n");
 
-	if (!client->irq) {
-		dev_err(&client->dev, "No interrupt support, no core IRQ\n");
-		return -EINVAL;
-	}
+	if (!client->irq)
+		return dev_err_probe(&client->dev, -EINVAL, "No interrupt support, no core IRQ\n");
 
 	ret = devm_regmap_add_irq_chip(&client->dev, rk808->regmap, client->irq,
 				       IRQF_ONESHOT, -1,
 				       rk808->regmap_irq_chip, &rk808->irq_data);
-	if (ret) {
-		dev_err(&client->dev, "Failed to add irq_chip %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to add irq_chip\n");
 
 	for (i = 0; i < nr_pre_init_regs; i++) {
 		ret = regmap_update_bits(rk808->regmap,
 					pre_init_reg[i].addr,
 					pre_init_reg[i].mask,
 					pre_init_reg[i].value);
-		if (ret) {
-			dev_err(&client->dev,
-				"0x%x write err\n",
-				pre_init_reg[i].addr);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&client->dev, ret, "0x%x write err\n",
+					     pre_init_reg[i].addr);
 	}
 
 	ret = devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_NONE,
 			      cells, nr_cells, NULL, 0,
 			      regmap_irq_get_domain(rk808->irq_data));
-	if (ret) {
-		dev_err(&client->dev, "failed to add MFD devices %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "failed to add MFD devices\n");
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		ret = devm_register_sys_off_handler(&client->dev,
-- 
2.35.1

