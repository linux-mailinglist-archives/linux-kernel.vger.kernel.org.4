Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A07B6F8C2F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjEEWDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjEEWD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:03:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CE65BB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:02:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3VP-0002Lw-SR; Sat, 06 May 2023 00:02:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3VP-001OMw-1s; Sat, 06 May 2023 00:02:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pv3VO-001do3-2k; Sat, 06 May 2023 00:02:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] regulator: Switch i2c drivers back to use .probe()
Date:   Sat,  6 May 2023 00:02:18 +0200
Message-Id: <20230505220218.1239542-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=29957; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YrUmyOMH4W2wFu70ItO0OzHcRpui8i96c2caVWPRqsc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkVXzpeBsx620QXz9aIdsslagTXwrmqlQtWtIXr CRbKyfcluSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZFV86QAKCRCPgPtYfRL+ ThsfCACuJRi9QFhyJzzqj7wPkJCyd1y3UhEcL+sqgxNwxrpql3VK+xNaakuVj2l9WdpGhisXUaO eTEaTyKE0ZU8zsAd/vkL5ea2cR+++kxYkSZASCOwLwBT0QkS1ClxHPLbH0nGyRFE9gJOZfkK/Nm KjvS22AfbYcliuKgnlLYkzaz7NwHy++42OuGTTCPJa0qFc448sVGyLthIff6XL9FgYUM21FG4LV hNNzxvfoQGiYYEfozT2MjvVEZtd23BWaO7XbfDPpYCCaeimW9cT/EFUyYHm8cXbDWG+0uyPCphu uR214BLOU9N4QmD7rsg4OMgE5MmXnlEyp08S76t51xOXDUke
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
call-back type"), all drivers being converted to .probe_new() and then
03c835f498b5 ("i2c: Switch .probe() to not take an id parameter") convert
back to (the new) .probe() to be able to eventually drop .probe_new() from
struct i2c_driver.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/regulator/88pg86x.c                    | 2 +-
 drivers/regulator/act8865-regulator.c          | 2 +-
 drivers/regulator/ad5398.c                     | 2 +-
 drivers/regulator/da9121-regulator.c           | 2 +-
 drivers/regulator/da9210-regulator.c           | 2 +-
 drivers/regulator/da9211-regulator.c           | 2 +-
 drivers/regulator/fan53555.c                   | 2 +-
 drivers/regulator/fan53880.c                   | 2 +-
 drivers/regulator/isl6271a-regulator.c         | 2 +-
 drivers/regulator/isl9305.c                    | 2 +-
 drivers/regulator/lp3971.c                     | 2 +-
 drivers/regulator/lp3972.c                     | 2 +-
 drivers/regulator/lp872x.c                     | 2 +-
 drivers/regulator/lp8755.c                     | 2 +-
 drivers/regulator/ltc3589.c                    | 2 +-
 drivers/regulator/ltc3676.c                    | 2 +-
 drivers/regulator/max1586.c                    | 2 +-
 drivers/regulator/max20086-regulator.c         | 2 +-
 drivers/regulator/max20411-regulator.c         | 2 +-
 drivers/regulator/max77826-regulator.c         | 2 +-
 drivers/regulator/max8649.c                    | 2 +-
 drivers/regulator/max8660.c                    | 2 +-
 drivers/regulator/max8893.c                    | 2 +-
 drivers/regulator/max8952.c                    | 2 +-
 drivers/regulator/max8973-regulator.c          | 2 +-
 drivers/regulator/mcp16502.c                   | 2 +-
 drivers/regulator/mp5416.c                     | 2 +-
 drivers/regulator/mp8859.c                     | 2 +-
 drivers/regulator/mp886x.c                     | 2 +-
 drivers/regulator/mpq7920.c                    | 2 +-
 drivers/regulator/mt6311-regulator.c           | 2 +-
 drivers/regulator/pca9450-regulator.c          | 2 +-
 drivers/regulator/pf8x00-regulator.c           | 2 +-
 drivers/regulator/pfuze100-regulator.c         | 2 +-
 drivers/regulator/pv88060-regulator.c          | 2 +-
 drivers/regulator/pv88080-regulator.c          | 2 +-
 drivers/regulator/pv88090-regulator.c          | 2 +-
 drivers/regulator/rpi-panel-attiny-regulator.c | 2 +-
 drivers/regulator/rt4801-regulator.c           | 2 +-
 drivers/regulator/rt5190a-regulator.c          | 2 +-
 drivers/regulator/rt5759-regulator.c           | 2 +-
 drivers/regulator/rt6160-regulator.c           | 2 +-
 drivers/regulator/rt6190-regulator.c           | 2 +-
 drivers/regulator/rt6245-regulator.c           | 2 +-
 drivers/regulator/rtmv20-regulator.c           | 2 +-
 drivers/regulator/rtq2134-regulator.c          | 2 +-
 drivers/regulator/rtq6752-regulator.c          | 2 +-
 drivers/regulator/slg51000-regulator.c         | 2 +-
 drivers/regulator/sy8106a-regulator.c          | 2 +-
 drivers/regulator/sy8824x.c                    | 2 +-
 drivers/regulator/sy8827n.c                    | 2 +-
 drivers/regulator/tps51632-regulator.c         | 2 +-
 drivers/regulator/tps62360-regulator.c         | 2 +-
 drivers/regulator/tps6286x-regulator.c         | 2 +-
 drivers/regulator/tps65023-regulator.c         | 2 +-
 drivers/regulator/tps65132-regulator.c         | 2 +-
 56 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/regulator/88pg86x.c b/drivers/regulator/88pg86x.c
index e91d5885c5ef..c32289db00a6 100644
--- a/drivers/regulator/88pg86x.c
+++ b/drivers/regulator/88pg86x.c
@@ -103,7 +103,7 @@ static struct i2c_driver pg86x_regulator_driver = {
 		.name = "88pg86x",
 		.of_match_table = of_match_ptr(pg86x_dt_ids),
 	},
-	.probe_new = pg86x_i2c_probe,
+	.probe = pg86x_i2c_probe,
 	.id_table = pg86x_i2c_id,
 };
 
diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 53f2c75cdeb4..c09f354b09b7 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -790,7 +790,7 @@ static struct i2c_driver act8865_pmic_driver = {
 	.driver	= {
 		.name	= "act8865",
 	},
-	.probe_new	= act8865_pmic_probe,
+	.probe		= act8865_pmic_probe,
 	.id_table	= act8865_ids,
 };
 
diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 2ba8ac1773d1..74958ffd618e 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -254,7 +254,7 @@ static int ad5398_probe(struct i2c_client *client)
 }
 
 static struct i2c_driver ad5398_driver = {
-	.probe_new = ad5398_probe,
+	.probe = ad5398_probe,
 	.driver		= {
 		.name	= "ad5398",
 	},
diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index d016e049d264..2f2f22b6af62 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1196,7 +1196,7 @@ static struct i2c_driver da9121_regulator_driver = {
 		.name = "da9121",
 		.of_match_table = of_match_ptr(da9121_dt_ids),
 	},
-	.probe_new = da9121_i2c_probe,
+	.probe = da9121_i2c_probe,
 	.remove = da9121_i2c_remove,
 	.id_table = da9121_i2c_id,
 };
diff --git a/drivers/regulator/da9210-regulator.c b/drivers/regulator/da9210-regulator.c
index 7493af0b5c04..9d58d4b98004 100644
--- a/drivers/regulator/da9210-regulator.c
+++ b/drivers/regulator/da9210-regulator.c
@@ -223,7 +223,7 @@ static struct i2c_driver da9210_regulator_driver = {
 		.name = "da9210",
 		.of_match_table = of_match_ptr(da9210_dt_ids),
 	},
-	.probe_new = da9210_i2c_probe,
+	.probe = da9210_i2c_probe,
 	.id_table = da9210_i2c_id,
 };
 
diff --git a/drivers/regulator/da9211-regulator.c b/drivers/regulator/da9211-regulator.c
index 00828f5baa97..f98d233d6e48 100644
--- a/drivers/regulator/da9211-regulator.c
+++ b/drivers/regulator/da9211-regulator.c
@@ -554,7 +554,7 @@ static struct i2c_driver da9211_regulator_driver = {
 		.name = "da9211",
 		.of_match_table = of_match_ptr(da9211_dt_ids),
 	},
-	.probe_new = da9211_i2c_probe,
+	.probe = da9211_i2c_probe,
 	.id_table = da9211_i2c_id,
 };
 
diff --git a/drivers/regulator/fan53555.c b/drivers/regulator/fan53555.c
index 41537c45f036..f6a110729399 100644
--- a/drivers/regulator/fan53555.c
+++ b/drivers/regulator/fan53555.c
@@ -666,7 +666,7 @@ static struct i2c_driver fan53555_regulator_driver = {
 		.name = "fan53555-regulator",
 		.of_match_table = of_match_ptr(fan53555_dt_ids),
 	},
-	.probe_new = fan53555_regulator_probe,
+	.probe = fan53555_regulator_probe,
 	.id_table = fan53555_id,
 };
 
diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index 1d88d5381544..0f0daefc24ce 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -174,7 +174,7 @@ static struct i2c_driver fan53880_regulator_driver = {
 		.name = "fan53880",
 		.of_match_table	= fan53880_dt_ids,
 	},
-	.probe_new = fan53880_i2c_probe,
+	.probe = fan53880_i2c_probe,
 	.id_table = fan53880_i2c_id,
 };
 module_i2c_driver(fan53880_regulator_driver);
diff --git a/drivers/regulator/isl6271a-regulator.c b/drivers/regulator/isl6271a-regulator.c
index b23b052eab10..ac88c4668722 100644
--- a/drivers/regulator/isl6271a-regulator.c
+++ b/drivers/regulator/isl6271a-regulator.c
@@ -148,7 +148,7 @@ static struct i2c_driver isl6271a_i2c_driver = {
 	.driver = {
 		.name = "isl6271a",
 	},
-	.probe_new = isl6271a_probe,
+	.probe = isl6271a_probe,
 	.id_table = isl6271a_id,
 };
 
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index cfb765986d0d..9327c010a3e5 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -197,7 +197,7 @@ static struct i2c_driver isl9305_regulator_driver = {
 		.name = "isl9305",
 		.of_match_table	= of_match_ptr(isl9305_dt_ids),
 	},
-	.probe_new = isl9305_i2c_probe,
+	.probe = isl9305_i2c_probe,
 	.id_table = isl9305_i2c_id,
 };
 
diff --git a/drivers/regulator/lp3971.c b/drivers/regulator/lp3971.c
index 8be252f81b09..29788c4b87d5 100644
--- a/drivers/regulator/lp3971.c
+++ b/drivers/regulator/lp3971.c
@@ -448,7 +448,7 @@ static struct i2c_driver lp3971_i2c_driver = {
 	.driver = {
 		.name = "LP3971",
 	},
-	.probe_new = lp3971_i2c_probe,
+	.probe = lp3971_i2c_probe,
 	.id_table = lp3971_i2c_id,
 };
 
diff --git a/drivers/regulator/lp3972.c b/drivers/regulator/lp3972.c
index 27b216bf18fc..847969221006 100644
--- a/drivers/regulator/lp3972.c
+++ b/drivers/regulator/lp3972.c
@@ -546,7 +546,7 @@ static struct i2c_driver lp3972_i2c_driver = {
 	.driver = {
 		.name = "lp3972",
 	},
-	.probe_new = lp3972_i2c_probe,
+	.probe = lp3972_i2c_probe,
 	.id_table = lp3972_i2c_id,
 };
 
diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
index c576894c3d52..c989b2497637 100644
--- a/drivers/regulator/lp872x.c
+++ b/drivers/regulator/lp872x.c
@@ -947,7 +947,7 @@ static struct i2c_driver lp872x_driver = {
 		.name = "lp872x",
 		.of_match_table = of_match_ptr(lp872x_dt_ids),
 	},
-	.probe_new = lp872x_probe,
+	.probe = lp872x_probe,
 	.id_table = lp872x_ids,
 };
 
diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 467dfdcebc91..9c18d4949650 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -441,7 +441,7 @@ static struct i2c_driver lp8755_i2c_driver = {
 	.driver = {
 		   .name = LP8755_NAME,
 		   },
-	.probe_new = lp8755_probe,
+	.probe = lp8755_probe,
 	.remove = lp8755_remove,
 	.id_table = lp8755_id,
 };
diff --git a/drivers/regulator/ltc3589.c b/drivers/regulator/ltc3589.c
index 460d34c50fb0..c63f039c14e2 100644
--- a/drivers/regulator/ltc3589.c
+++ b/drivers/regulator/ltc3589.c
@@ -476,7 +476,7 @@ static struct i2c_driver ltc3589_driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(ltc3589_of_match),
 	},
-	.probe_new = ltc3589_probe,
+	.probe = ltc3589_probe,
 	.id_table = ltc3589_i2c_id,
 };
 module_i2c_driver(ltc3589_driver);
diff --git a/drivers/regulator/ltc3676.c b/drivers/regulator/ltc3676.c
index eb3d6bed6d54..4749e94aad64 100644
--- a/drivers/regulator/ltc3676.c
+++ b/drivers/regulator/ltc3676.c
@@ -373,7 +373,7 @@ static struct i2c_driver ltc3676_driver = {
 		.name = DRIVER_NAME,
 		.of_match_table = of_match_ptr(ltc3676_of_match),
 	},
-	.probe_new = ltc3676_regulator_probe,
+	.probe = ltc3676_regulator_probe,
 	.id_table = ltc3676_i2c_id,
 };
 module_i2c_driver(ltc3676_driver);
diff --git a/drivers/regulator/max1586.c b/drivers/regulator/max1586.c
index a00aa2e8ff3f..10bf59de1926 100644
--- a/drivers/regulator/max1586.c
+++ b/drivers/regulator/max1586.c
@@ -289,7 +289,7 @@ static const struct i2c_device_id max1586_id[] = {
 MODULE_DEVICE_TABLE(i2c, max1586_id);
 
 static struct i2c_driver max1586_pmic_driver = {
-	.probe_new = max1586_pmic_probe,
+	.probe = max1586_pmic_probe,
 	.driver		= {
 		.name	= "max1586",
 		.of_match_table = of_match_ptr(max1586_of_match),
diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
index b8bf76c170fe..1842d1a4937e 100644
--- a/drivers/regulator/max20086-regulator.c
+++ b/drivers/regulator/max20086-regulator.c
@@ -322,7 +322,7 @@ static struct i2c_driver max20086_regulator_driver = {
 		.name = "max20086",
 		.of_match_table = of_match_ptr(max20086_dt_ids),
 	},
-	.probe_new = max20086_i2c_probe,
+	.probe = max20086_i2c_probe,
 	.id_table = max20086_i2c_id,
 };
 
diff --git a/drivers/regulator/max20411-regulator.c b/drivers/regulator/max20411-regulator.c
index 83dacb4ff173..4b53a34ff403 100644
--- a/drivers/regulator/max20411-regulator.c
+++ b/drivers/regulator/max20411-regulator.c
@@ -155,7 +155,7 @@ static struct i2c_driver max20411_i2c_driver = {
 		.name = "max20411",
 		.of_match_table	= of_max20411_match_tbl,
 	},
-	.probe_new = max20411_probe,
+	.probe = max20411_probe,
 	.id_table = max20411_id,
 };
 module_i2c_driver(max20411_i2c_driver);
diff --git a/drivers/regulator/max77826-regulator.c b/drivers/regulator/max77826-regulator.c
index f9e2e884ff54..8e4f85ca5dff 100644
--- a/drivers/regulator/max77826-regulator.c
+++ b/drivers/regulator/max77826-regulator.c
@@ -291,7 +291,7 @@ static struct i2c_driver max77826_regulator_driver = {
 		.name = "max77826",
 		.of_match_table = of_match_ptr(max77826_of_match),
 	},
-	.probe_new = max77826_i2c_probe,
+	.probe = max77826_i2c_probe,
 	.id_table = max77826_id,
 };
 module_i2c_driver(max77826_regulator_driver);
diff --git a/drivers/regulator/max8649.c b/drivers/regulator/max8649.c
index aed5443d88e1..aa7bd019dc30 100644
--- a/drivers/regulator/max8649.c
+++ b/drivers/regulator/max8649.c
@@ -246,7 +246,7 @@ static const struct i2c_device_id max8649_id[] = {
 MODULE_DEVICE_TABLE(i2c, max8649_id);
 
 static struct i2c_driver max8649_driver = {
-	.probe_new	= max8649_regulator_probe,
+	.probe		= max8649_regulator_probe,
 	.driver		= {
 		.name	= "max8649",
 	},
diff --git a/drivers/regulator/max8660.c b/drivers/regulator/max8660.c
index 711623be8eb5..f37d9db59554 100644
--- a/drivers/regulator/max8660.c
+++ b/drivers/regulator/max8660.c
@@ -503,7 +503,7 @@ static const struct i2c_device_id max8660_id[] = {
 MODULE_DEVICE_TABLE(i2c, max8660_id);
 
 static struct i2c_driver max8660_driver = {
-	.probe_new = max8660_probe,
+	.probe = max8660_probe,
 	.driver		= {
 		.name	= "max8660",
 	},
diff --git a/drivers/regulator/max8893.c b/drivers/regulator/max8893.c
index 1519bf760da7..182ffcf9096e 100644
--- a/drivers/regulator/max8893.c
+++ b/drivers/regulator/max8893.c
@@ -168,7 +168,7 @@ static const struct i2c_device_id max8893_ids[] = {
 MODULE_DEVICE_TABLE(i2c, max8893_ids);
 
 static struct i2c_driver max8893_driver = {
-	.probe_new	= max8893_probe_new,
+	.probe		= max8893_probe_new,
 	.driver		= {
 		.name	= "max8893",
 		.of_match_table = of_match_ptr(max8893_dt_match),
diff --git a/drivers/regulator/max8952.c b/drivers/regulator/max8952.c
index 360a33ecc093..384c680d0056 100644
--- a/drivers/regulator/max8952.c
+++ b/drivers/regulator/max8952.c
@@ -313,7 +313,7 @@ static const struct i2c_device_id max8952_ids[] = {
 MODULE_DEVICE_TABLE(i2c, max8952_ids);
 
 static struct i2c_driver max8952_pmic_driver = {
-	.probe_new	= max8952_pmic_probe,
+	.probe		= max8952_pmic_probe,
 	.driver		= {
 		.name	= "max8952",
 		.of_match_table = of_match_ptr(max8952_dt_match),
diff --git a/drivers/regulator/max8973-regulator.c b/drivers/regulator/max8973-regulator.c
index 7e00a45db26a..490ef8984d5e 100644
--- a/drivers/regulator/max8973-regulator.c
+++ b/drivers/regulator/max8973-regulator.c
@@ -806,7 +806,7 @@ static struct i2c_driver max8973_i2c_driver = {
 		.name = "max8973",
 		.of_match_table = of_max8973_match_tbl,
 	},
-	.probe_new = max8973_probe,
+	.probe = max8973_probe,
 	.id_table = max8973_id,
 };
 
diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index abee1b09008d..84eed81b87df 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -584,7 +584,7 @@ static const struct i2c_device_id mcp16502_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, mcp16502_i2c_id);
 
 static struct i2c_driver mcp16502_drv = {
-	.probe_new	= mcp16502_probe,
+	.probe		= mcp16502_probe,
 	.driver		= {
 		.name	= "mcp16502-regulator",
 		.of_match_table	= of_match_ptr(mcp16502_ids),
diff --git a/drivers/regulator/mp5416.c b/drivers/regulator/mp5416.c
index 82892d71c2c9..04734ca5f947 100644
--- a/drivers/regulator/mp5416.c
+++ b/drivers/regulator/mp5416.c
@@ -239,7 +239,7 @@ static struct i2c_driver mp5416_regulator_driver = {
 		.name = "mp5416",
 		.of_match_table = of_match_ptr(mp5416_of_match),
 	},
-	.probe_new = mp5416_i2c_probe,
+	.probe = mp5416_i2c_probe,
 	.id_table = mp5416_id,
 };
 module_i2c_driver(mp5416_regulator_driver);
diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
index f2300714d5a9..c1cacaffed9c 100644
--- a/drivers/regulator/mp8859.c
+++ b/drivers/regulator/mp8859.c
@@ -146,7 +146,7 @@ static struct i2c_driver mp8859_regulator_driver = {
 		.name = "mp8859",
 		.of_match_table = of_match_ptr(mp8859_dt_id),
 	},
-	.probe_new = mp8859_i2c_probe,
+	.probe = mp8859_i2c_probe,
 	.id_table = mp8859_i2c_id,
 };
 
diff --git a/drivers/regulator/mp886x.c b/drivers/regulator/mp886x.c
index 6a0c94c15027..9a1163df9926 100644
--- a/drivers/regulator/mp886x.c
+++ b/drivers/regulator/mp886x.c
@@ -364,7 +364,7 @@ static struct i2c_driver mp886x_regulator_driver = {
 		.name = "mp886x-regulator",
 		.of_match_table = mp886x_dt_ids,
 	},
-	.probe_new = mp886x_i2c_probe,
+	.probe = mp886x_i2c_probe,
 	.id_table = mp886x_id,
 };
 module_i2c_driver(mp886x_regulator_driver);
diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index 54c862edf571..d971f5d38c9d 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -320,7 +320,7 @@ static struct i2c_driver mpq7920_regulator_driver = {
 		.name = "mpq7920",
 		.of_match_table = of_match_ptr(mpq7920_of_match),
 	},
-	.probe_new = mpq7920_i2c_probe,
+	.probe = mpq7920_i2c_probe,
 	.id_table = mpq7920_id,
 };
 module_i2c_driver(mpq7920_regulator_driver);
diff --git a/drivers/regulator/mt6311-regulator.c b/drivers/regulator/mt6311-regulator.c
index 69e6af3cd505..69d782f72ba6 100644
--- a/drivers/regulator/mt6311-regulator.c
+++ b/drivers/regulator/mt6311-regulator.c
@@ -153,7 +153,7 @@ static struct i2c_driver mt6311_regulator_driver = {
 		.name = "mt6311",
 		.of_match_table = of_match_ptr(mt6311_dt_ids),
 	},
-	.probe_new = mt6311_i2c_probe,
+	.probe = mt6311_i2c_probe,
 	.id_table = mt6311_i2c_id,
 };
 
diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index c6351fac9f4d..28f6ee9eca4c 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -874,7 +874,7 @@ static struct i2c_driver pca9450_i2c_driver = {
 		.name = "nxp-pca9450",
 		.of_match_table = pca9450_of_match,
 	},
-	.probe_new = pca9450_i2c_probe,
+	.probe = pca9450_i2c_probe,
 };
 
 module_i2c_driver(pca9450_i2c_driver);
diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 5d319fb81288..108d9108dbfe 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -609,7 +609,7 @@ static struct i2c_driver pf8x00_regulator_driver = {
 		.name = "pf8x00",
 		.of_match_table = pf8x00_dt_ids,
 	},
-	.probe_new = pf8x00_i2c_probe,
+	.probe = pf8x00_i2c_probe,
 };
 module_i2c_driver(pf8x00_regulator_driver);
 
diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index 9ab604289b5c..b15093bbbd26 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -847,7 +847,7 @@ static struct i2c_driver pfuze_driver = {
 		.name = "pfuze100-regulator",
 		.of_match_table = pfuze_dt_ids,
 	},
-	.probe_new = pfuze100_regulator_probe,
+	.probe = pfuze100_regulator_probe,
 };
 module_i2c_driver(pfuze_driver);
 
diff --git a/drivers/regulator/pv88060-regulator.c b/drivers/regulator/pv88060-regulator.c
index 48238846f45c..226d0cf53618 100644
--- a/drivers/regulator/pv88060-regulator.c
+++ b/drivers/regulator/pv88060-regulator.c
@@ -378,7 +378,7 @@ static struct i2c_driver pv88060_regulator_driver = {
 		.name = "pv88060",
 		.of_match_table = of_match_ptr(pv88060_dt_ids),
 	},
-	.probe_new = pv88060_i2c_probe,
+	.probe = pv88060_i2c_probe,
 	.id_table = pv88060_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88080-regulator.c b/drivers/regulator/pv88080-regulator.c
index 15a67c05f519..f124dbd83220 100644
--- a/drivers/regulator/pv88080-regulator.c
+++ b/drivers/regulator/pv88080-regulator.c
@@ -559,7 +559,7 @@ static struct i2c_driver pv88080_regulator_driver = {
 		.name = "pv88080",
 		.of_match_table = of_match_ptr(pv88080_dt_ids),
 	},
-	.probe_new = pv88080_i2c_probe,
+	.probe = pv88080_i2c_probe,
 	.id_table = pv88080_i2c_id,
 };
 
diff --git a/drivers/regulator/pv88090-regulator.c b/drivers/regulator/pv88090-regulator.c
index a80176bdf8ec..8d279041da0e 100644
--- a/drivers/regulator/pv88090-regulator.c
+++ b/drivers/regulator/pv88090-regulator.c
@@ -399,7 +399,7 @@ static struct i2c_driver pv88090_regulator_driver = {
 		.name = "pv88090",
 		.of_match_table = of_match_ptr(pv88090_dt_ids),
 	},
-	.probe_new = pv88090_i2c_probe,
+	.probe = pv88090_i2c_probe,
 	.id_table = pv88090_i2c_id,
 };
 
diff --git a/drivers/regulator/rpi-panel-attiny-regulator.c b/drivers/regulator/rpi-panel-attiny-regulator.c
index 34514976475e..73e42f99f57b 100644
--- a/drivers/regulator/rpi-panel-attiny-regulator.c
+++ b/drivers/regulator/rpi-panel-attiny-regulator.c
@@ -398,7 +398,7 @@ static struct i2c_driver attiny_regulator_driver = {
 		.name = "rpi_touchscreen_attiny",
 		.of_match_table = of_match_ptr(attiny_dt_ids),
 	},
-	.probe_new = attiny_i2c_probe,
+	.probe = attiny_i2c_probe,
 	.remove	= attiny_i2c_remove,
 };
 
diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 563d79196fdd..3ce0241e06bd 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -241,7 +241,7 @@ static struct i2c_driver rt4801_driver = {
 		.name = "rt4801",
 		.of_match_table = of_match_ptr(rt4801_of_id),
 	},
-	.probe_new = rt4801_probe,
+	.probe = rt4801_probe,
 };
 module_i2c_driver(rt4801_driver);
 
diff --git a/drivers/regulator/rt5190a-regulator.c b/drivers/regulator/rt5190a-regulator.c
index 4a3397b32582..5df714e98b08 100644
--- a/drivers/regulator/rt5190a-regulator.c
+++ b/drivers/regulator/rt5190a-regulator.c
@@ -507,7 +507,7 @@ static struct i2c_driver rt5190a_driver = {
 		.name = "rt5190a",
 		.of_match_table = rt5190a_device_table,
 	},
-	.probe_new = rt5190a_probe,
+	.probe = rt5190a_probe,
 };
 module_i2c_driver(rt5190a_driver);
 
diff --git a/drivers/regulator/rt5759-regulator.c b/drivers/regulator/rt5759-regulator.c
index 8488417f4b2c..acc7d0801ac2 100644
--- a/drivers/regulator/rt5759-regulator.c
+++ b/drivers/regulator/rt5759-regulator.c
@@ -361,7 +361,7 @@ static struct i2c_driver rt5759_driver = {
 		.name = "rt5759",
 		.of_match_table = of_match_ptr(rt5759_device_table),
 	},
-	.probe_new = rt5759_probe,
+	.probe = rt5759_probe,
 };
 module_i2c_driver(rt5759_driver);
 
diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index 5d7b0e7ad69a..a1c0c51770b8 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -310,7 +310,7 @@ static struct i2c_driver rt6160_driver = {
 		.name = "rt6160",
 		.of_match_table = rt6160_of_match_table,
 	},
-	.probe_new = rt6160_probe,
+	.probe = rt6160_probe,
 };
 module_i2c_driver(rt6160_driver);
 
diff --git a/drivers/regulator/rt6190-regulator.c b/drivers/regulator/rt6190-regulator.c
index 995e028abdd7..9cd932c56d1f 100644
--- a/drivers/regulator/rt6190-regulator.c
+++ b/drivers/regulator/rt6190-regulator.c
@@ -486,7 +486,7 @@ static struct i2c_driver rt6190_driver = {
 		.of_match_table = rt6190_of_dev_table,
 		.pm = pm_ptr(&rt6190_dev_pm),
 	},
-	.probe_new = rt6190_probe,
+	.probe = rt6190_probe,
 };
 module_i2c_driver(rt6190_driver);
 
diff --git a/drivers/regulator/rt6245-regulator.c b/drivers/regulator/rt6245-regulator.c
index cb22a207e9ff..169412cb9c52 100644
--- a/drivers/regulator/rt6245-regulator.c
+++ b/drivers/regulator/rt6245-regulator.c
@@ -245,7 +245,7 @@ static struct i2c_driver rt6245_driver = {
 		.name = "rt6245",
 		.of_match_table = rt6245_of_match_table,
 	},
-	.probe_new = rt6245_probe,
+	.probe = rt6245_probe,
 };
 module_i2c_driver(rt6245_driver);
 
diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 2ee334174e2b..8e90f25d5372 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -428,7 +428,7 @@ static struct i2c_driver rtmv20_driver = {
 		.of_match_table = of_match_ptr(rtmv20_of_id),
 		.pm = &rtmv20_pm,
 	},
-	.probe_new = rtmv20_probe,
+	.probe = rtmv20_probe,
 };
 module_i2c_driver(rtmv20_driver);
 
diff --git a/drivers/regulator/rtq2134-regulator.c b/drivers/regulator/rtq2134-regulator.c
index 8e13dea354a2..5e391972a871 100644
--- a/drivers/regulator/rtq2134-regulator.c
+++ b/drivers/regulator/rtq2134-regulator.c
@@ -365,7 +365,7 @@ static struct i2c_driver rtq2134_driver = {
 		.name = "rtq2134",
 		.of_match_table = rtq2134_device_tables,
 	},
-	.probe_new = rtq2134_probe,
+	.probe = rtq2134_probe,
 };
 module_i2c_driver(rtq2134_driver);
 
diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index dfe45fb67353..acf2a847262e 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -280,7 +280,7 @@ static struct i2c_driver rtq6752_driver = {
 		.name = "rtq6752",
 		.of_match_table = rtq6752_device_table,
 	},
-	.probe_new = rtq6752_probe,
+	.probe = rtq6752_probe,
 };
 module_i2c_driver(rtq6752_driver);
 
diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
index 1b2eee95ad3f..1a8036094d3b 100644
--- a/drivers/regulator/slg51000-regulator.c
+++ b/drivers/regulator/slg51000-regulator.c
@@ -506,7 +506,7 @@ static struct i2c_driver slg51000_regulator_driver = {
 	.driver = {
 		.name = "slg51000-regulator",
 	},
-	.probe_new = slg51000_i2c_probe,
+	.probe = slg51000_i2c_probe,
 	.id_table = slg51000_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8106a-regulator.c b/drivers/regulator/sy8106a-regulator.c
index b10bd99768a3..18d3c29e36b5 100644
--- a/drivers/regulator/sy8106a-regulator.c
+++ b/drivers/regulator/sy8106a-regulator.c
@@ -140,7 +140,7 @@ static struct i2c_driver sy8106a_regulator_driver = {
 		.name = "sy8106a",
 		.of_match_table	= sy8106a_i2c_of_match,
 	},
-	.probe_new = sy8106a_i2c_probe,
+	.probe = sy8106a_i2c_probe,
 	.id_table = sy8106a_i2c_id,
 };
 
diff --git a/drivers/regulator/sy8824x.c b/drivers/regulator/sy8824x.c
index 2a81519bdf67..b3c3297cd904 100644
--- a/drivers/regulator/sy8824x.c
+++ b/drivers/regulator/sy8824x.c
@@ -235,7 +235,7 @@ static struct i2c_driver sy8824_regulator_driver = {
 		.name = "sy8824-regulator",
 		.of_match_table = sy8824_dt_ids,
 	},
-	.probe_new = sy8824_i2c_probe,
+	.probe = sy8824_i2c_probe,
 	.id_table = sy8824_id,
 };
 module_i2c_driver(sy8824_regulator_driver);
diff --git a/drivers/regulator/sy8827n.c b/drivers/regulator/sy8827n.c
index 936a94b6df5b..2d61ef6c41c5 100644
--- a/drivers/regulator/sy8827n.c
+++ b/drivers/regulator/sy8827n.c
@@ -189,7 +189,7 @@ static struct i2c_driver sy8827n_regulator_driver = {
 		.name = "sy8827n-regulator",
 		.of_match_table = sy8827n_dt_ids,
 	},
-	.probe_new = sy8827n_i2c_probe,
+	.probe = sy8827n_i2c_probe,
 	.id_table = sy8827n_id,
 };
 module_i2c_driver(sy8827n_regulator_driver);
diff --git a/drivers/regulator/tps51632-regulator.c b/drivers/regulator/tps51632-regulator.c
index 152c5ad6709c..1b4ebe8fbd66 100644
--- a/drivers/regulator/tps51632-regulator.c
+++ b/drivers/regulator/tps51632-regulator.c
@@ -353,7 +353,7 @@ static struct i2c_driver tps51632_i2c_driver = {
 		.name = "tps51632",
 		.of_match_table = of_match_ptr(tps51632_of_match),
 	},
-	.probe_new = tps51632_probe,
+	.probe = tps51632_probe,
 	.id_table = tps51632_id,
 };
 
diff --git a/drivers/regulator/tps62360-regulator.c b/drivers/regulator/tps62360-regulator.c
index da1b2b1341ae..02476506586a 100644
--- a/drivers/regulator/tps62360-regulator.c
+++ b/drivers/regulator/tps62360-regulator.c
@@ -497,7 +497,7 @@ static struct i2c_driver tps62360_i2c_driver = {
 		.name = "tps62360",
 		.of_match_table = of_match_ptr(tps62360_of_match),
 	},
-	.probe_new = tps62360_probe,
+	.probe = tps62360_probe,
 	.shutdown = tps62360_shutdown,
 	.id_table = tps62360_id,
 };
diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 207ac1d1d88d..375f6665a1c5 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -149,7 +149,7 @@ static struct i2c_driver tps6286x_regulator_driver = {
 		.name = "tps6286x",
 		.of_match_table = of_match_ptr(tps6286x_dt_ids),
 	},
-	.probe_new = tps6286x_i2c_probe,
+	.probe = tps6286x_i2c_probe,
 	.id_table = tps6286x_i2c_id,
 };
 
diff --git a/drivers/regulator/tps65023-regulator.c b/drivers/regulator/tps65023-regulator.c
index 680a57ff0837..fd77b45cc9d1 100644
--- a/drivers/regulator/tps65023-regulator.c
+++ b/drivers/regulator/tps65023-regulator.c
@@ -336,7 +336,7 @@ static struct i2c_driver tps_65023_i2c_driver = {
 		.name = "tps65023",
 		.of_match_table = of_match_ptr(tps65023_of_match),
 	},
-	.probe_new = tps_65023_probe,
+	.probe = tps_65023_probe,
 	.id_table = tps_65023_id,
 };
 
diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index 0edc83089ba2..9a29a45db591 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -271,7 +271,7 @@ static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
 	},
-	.probe_new = tps65132_probe,
+	.probe = tps65132_probe,
 	.id_table = tps65132_id,
 };
 

base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
-- 
2.39.2

