Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA3F703C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbjEOS2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEOS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:28:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6B64225
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:28:00 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pycvO-0006GM-B2; Mon, 15 May 2023 20:27:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pycvM-000QXh-BK; Mon, 15 May 2023 20:27:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pycvL-004lrm-Jj; Mon, 15 May 2023 20:27:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2] mfd: Switch i2c drivers back to use .probe()
Date:   Mon, 15 May 2023 20:27:52 +0200
Message-Id: <20230515182752.10050-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=46381; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5bvvYII7+JQULUnK7XFm4haorh6GNAkBUR36q27dvO8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkYnmnM0zih0GjxXxEF+NvNcdtbctdWRW44+SUn 3mqfdvwVZ6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZGJ5pwAKCRCPgPtYfRL+ Tq+wB/9hl1eGc/0Uq2bgAyrMqMHSso83mL8Psi3MzVvS9iEqrQ+5TwnR6HFV/3Ed24bzRrxZGNp flU+Wbu4hmC15I+ioCejGSVtUVTU5gdYKOIA83ZjVmIlvZfBPGZUnTn5lfRPfy364BftcOPaNuG neRSa+y452n6Il2VQHmNEee8ToCKNrRa3TFVelS5A+65+Qo1tiKw7fthnw1E++tG3zjFJKRNagx fBivlB1twjWztmGRVdxEvEsp0uOvrNYHnED++8VoFnit8DBrlUkkos3Br9oUVY2FEJeRGG5v4OC 1wH0twjRAfGmuyRwMe4Q9KPnueHlaS+AhvN2H1bid5RYewd5
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
Changes since (implicit) v1:
 - Rebase on top of mfd-for-next from
   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git and resolve
   a conflict with commit c20e8c5b1203 ("mfd: rk808: Split into core and
   i2c")

 drivers/mfd/88pm800.c                 | 2 +-
 drivers/mfd/88pm805.c                 | 2 +-
 drivers/mfd/88pm860x-core.c           | 2 +-
 drivers/mfd/aat2870-core.c            | 2 +-
 drivers/mfd/acer-ec-a500.c            | 2 +-
 drivers/mfd/act8945a.c                | 2 +-
 drivers/mfd/adp5520.c                 | 2 +-
 drivers/mfd/arizona-i2c.c             | 2 +-
 drivers/mfd/as3711.c                  | 2 +-
 drivers/mfd/as3722.c                  | 2 +-
 drivers/mfd/atc260x-i2c.c             | 2 +-
 drivers/mfd/axp20x-i2c.c              | 2 +-
 drivers/mfd/bcm590xx.c                | 2 +-
 drivers/mfd/bd9571mwv.c               | 2 +-
 drivers/mfd/da903x.c                  | 2 +-
 drivers/mfd/da9052-i2c.c              | 2 +-
 drivers/mfd/da9055-i2c.c              | 2 +-
 drivers/mfd/da9062-core.c             | 2 +-
 drivers/mfd/da9063-i2c.c              | 2 +-
 drivers/mfd/da9150-core.c             | 2 +-
 drivers/mfd/ene-kb3930.c              | 2 +-
 drivers/mfd/gateworks-gsc.c           | 2 +-
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 +-
 drivers/mfd/intel_soc_pmic_chtwc.c    | 2 +-
 drivers/mfd/intel_soc_pmic_crc.c      | 2 +-
 drivers/mfd/iqs62x.c                  | 2 +-
 drivers/mfd/khadas-mcu.c              | 2 +-
 drivers/mfd/lm3533-core.c             | 2 +-
 drivers/mfd/lochnagar-i2c.c           | 2 +-
 drivers/mfd/lp3943.c                  | 2 +-
 drivers/mfd/lp873x.c                  | 2 +-
 drivers/mfd/lp87565.c                 | 2 +-
 drivers/mfd/lp8788.c                  | 2 +-
 drivers/mfd/madera-i2c.c              | 2 +-
 drivers/mfd/max14577.c                | 2 +-
 drivers/mfd/max77620.c                | 2 +-
 drivers/mfd/max77650.c                | 2 +-
 drivers/mfd/max77686.c                | 2 +-
 drivers/mfd/max77693.c                | 2 +-
 drivers/mfd/max77714.c                | 2 +-
 drivers/mfd/max77843.c                | 2 +-
 drivers/mfd/max8907.c                 | 2 +-
 drivers/mfd/max8925-i2c.c             | 2 +-
 drivers/mfd/max8997.c                 | 2 +-
 drivers/mfd/max8998.c                 | 2 +-
 drivers/mfd/mc13xxx-i2c.c             | 2 +-
 drivers/mfd/menelaus.c                | 2 +-
 drivers/mfd/menf21bmc.c               | 2 +-
 drivers/mfd/mp2629.c                  | 2 +-
 drivers/mfd/mt6360-core.c             | 2 +-
 drivers/mfd/mt6370.c                  | 2 +-
 drivers/mfd/ntxec.c                   | 2 +-
 drivers/mfd/palmas.c                  | 2 +-
 drivers/mfd/pcf50633-core.c           | 2 +-
 drivers/mfd/qcom-pm8008.c             | 2 +-
 drivers/mfd/rc5t583.c                 | 2 +-
 drivers/mfd/retu-mfd.c                | 2 +-
 drivers/mfd/rk8xx-i2c.c               | 2 +-
 drivers/mfd/rn5t618.c                 | 2 +-
 drivers/mfd/rohm-bd71828.c            | 2 +-
 drivers/mfd/rohm-bd718x7.c            | 2 +-
 drivers/mfd/rohm-bd9576.c             | 2 +-
 drivers/mfd/rsmu_i2c.c                | 2 +-
 drivers/mfd/rt4831.c                  | 2 +-
 drivers/mfd/rt5033.c                  | 2 +-
 drivers/mfd/rt5120.c                  | 2 +-
 drivers/mfd/sec-core.c                | 2 +-
 drivers/mfd/si476x-i2c.c              | 2 +-
 drivers/mfd/simple-mfd-i2c.c          | 2 +-
 drivers/mfd/sky81452.c                | 2 +-
 drivers/mfd/smpro-core.c              | 2 +-
 drivers/mfd/stmfx.c                   | 2 +-
 drivers/mfd/stmpe-i2c.c               | 2 +-
 drivers/mfd/stpmic1.c                 | 2 +-
 drivers/mfd/stw481x.c                 | 2 +-
 drivers/mfd/tc3589x.c                 | 2 +-
 drivers/mfd/ti-lmu.c                  | 2 +-
 drivers/mfd/tps6105x.c                | 2 +-
 drivers/mfd/tps65010.c                | 2 +-
 drivers/mfd/tps6507x.c                | 2 +-
 drivers/mfd/tps65086.c                | 2 +-
 drivers/mfd/tps65090.c                | 2 +-
 drivers/mfd/tps65217.c                | 2 +-
 drivers/mfd/tps65218.c                | 2 +-
 drivers/mfd/tps65219.c                | 2 +-
 drivers/mfd/tps6586x.c                | 2 +-
 drivers/mfd/tps65910.c                | 2 +-
 drivers/mfd/tps65912-i2c.c            | 2 +-
 drivers/mfd/twl-core.c                | 2 +-
 drivers/mfd/twl6040.c                 | 2 +-
 drivers/mfd/wl1273-core.c             | 2 +-
 drivers/mfd/wm831x-i2c.c              | 2 +-
 drivers/mfd/wm8350-i2c.c              | 2 +-
 drivers/mfd/wm8400-core.c             | 2 +-
 drivers/mfd/wm8994-core.c             | 2 +-
 95 files changed, 95 insertions(+), 95 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 4d9b61b92754..300caa067335 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -597,7 +597,7 @@ static struct i2c_driver pm800_driver = {
 		.name = "88PM800",
 		.pm = pm_sleep_ptr(&pm80x_pm_ops),
 		},
-	.probe_new = pm800_probe,
+	.probe = pm800_probe,
 	.remove = pm800_remove,
 	.id_table = pm80x_id_table,
 };
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
index 352f13cb1481..68417c3c4f5a 100644
--- a/drivers/mfd/88pm805.c
+++ b/drivers/mfd/88pm805.c
@@ -253,7 +253,7 @@ static struct i2c_driver pm805_driver = {
 		.name = "88PM805",
 		.pm = pm_sleep_ptr(&pm80x_pm_ops),
 		},
-	.probe_new = pm805_probe,
+	.probe = pm805_probe,
 	.remove = pm805_remove,
 	.id_table = pm80x_id_table,
 };
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 26d1ffefadc1..151bf03e772d 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -1250,7 +1250,7 @@ static struct i2c_driver pm860x_driver = {
 		.pm     = pm_sleep_ptr(&pm860x_pm_ops),
 		.of_match_table	= pm860x_dt_ids,
 	},
-	.probe_new	= pm860x_probe,
+	.probe		= pm860x_probe,
 	.remove		= pm860x_remove,
 	.id_table	= pm860x_id_table,
 };
diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 5ff0f1ed7a15..2fee62f1016c 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -449,7 +449,7 @@ static struct i2c_driver aat2870_i2c_driver = {
 		.pm			= pm_sleep_ptr(&aat2870_pm_ops),
 		.suppress_bind_attrs	= true,
 	},
-	.probe_new	= aat2870_i2c_probe,
+	.probe		= aat2870_i2c_probe,
 	.id_table	= aat2870_i2c_id_table,
 };
 
diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
index 7fd8b9988075..feb757e90dc3 100644
--- a/drivers/mfd/acer-ec-a500.c
+++ b/drivers/mfd/acer-ec-a500.c
@@ -190,7 +190,7 @@ static struct i2c_driver a500_ec_driver = {
 		.name = "acer-a500-embedded-controller",
 		.of_match_table = a500_ec_match,
 	},
-	.probe_new = a500_ec_probe,
+	.probe = a500_ec_probe,
 	.remove = a500_ec_remove,
 };
 module_i2c_driver(a500_ec_driver);
diff --git a/drivers/mfd/act8945a.c b/drivers/mfd/act8945a.c
index bcf0fda15f0c..2406fcdff5f9 100644
--- a/drivers/mfd/act8945a.c
+++ b/drivers/mfd/act8945a.c
@@ -70,7 +70,7 @@ static struct i2c_driver act8945a_i2c_driver = {
 		   .name = "act8945a",
 		   .of_match_table = of_match_ptr(act8945a_of_match),
 	},
-	.probe_new = act8945a_i2c_probe,
+	.probe = act8945a_i2c_probe,
 	.id_table = act8945a_i2c_id,
 };
 
diff --git a/drivers/mfd/adp5520.c b/drivers/mfd/adp5520.c
index cb168efdbafe..bd6f4965ebc8 100644
--- a/drivers/mfd/adp5520.c
+++ b/drivers/mfd/adp5520.c
@@ -340,7 +340,7 @@ static struct i2c_driver adp5520_driver = {
 		.pm			= pm_sleep_ptr(&adp5520_pm),
 		.suppress_bind_attrs	= true,
 	},
-	.probe_new	= adp5520_probe,
+	.probe		= adp5520_probe,
 	.id_table	= adp5520_id,
 };
 builtin_i2c_driver(adp5520_driver);
diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
index 43e393c8608d..9b7183ffc928 100644
--- a/drivers/mfd/arizona-i2c.c
+++ b/drivers/mfd/arizona-i2c.c
@@ -121,7 +121,7 @@ static struct i2c_driver arizona_i2c_driver = {
 		.pm	= pm_ptr(&arizona_pm_ops),
 		.of_match_table	= of_match_ptr(arizona_i2c_of_match),
 	},
-	.probe_new	= arizona_i2c_probe,
+	.probe		= arizona_i2c_probe,
 	.remove		= arizona_i2c_remove,
 	.id_table	= arizona_i2c_id,
 };
diff --git a/drivers/mfd/as3711.c b/drivers/mfd/as3711.c
index 3facfdd28e81..c7e85ff38013 100644
--- a/drivers/mfd/as3711.c
+++ b/drivers/mfd/as3711.c
@@ -201,7 +201,7 @@ static struct i2c_driver as3711_i2c_driver = {
 		   .name = "as3711",
 		   .of_match_table = of_match_ptr(as3711_of_match),
 	},
-	.probe_new = as3711_i2c_probe,
+	.probe = as3711_i2c_probe,
 	.id_table = as3711_i2c_id,
 };
 
diff --git a/drivers/mfd/as3722.c b/drivers/mfd/as3722.c
index b6dda0eb8645..a2bf68afc131 100644
--- a/drivers/mfd/as3722.c
+++ b/drivers/mfd/as3722.c
@@ -445,7 +445,7 @@ static struct i2c_driver as3722_i2c_driver = {
 		.of_match_table = as3722_of_match,
 		.pm = &as3722_pm_ops,
 	},
-	.probe_new = as3722_i2c_probe,
+	.probe = as3722_i2c_probe,
 	.id_table = as3722_i2c_id,
 };
 
diff --git a/drivers/mfd/atc260x-i2c.c b/drivers/mfd/atc260x-i2c.c
index 8e1491167160..fb53b0432a31 100644
--- a/drivers/mfd/atc260x-i2c.c
+++ b/drivers/mfd/atc260x-i2c.c
@@ -53,7 +53,7 @@ static struct i2c_driver atc260x_i2c_driver = {
 		.name = "atc260x",
 		.of_match_table	= atc260x_i2c_of_match,
 	},
-	.probe_new = atc260x_i2c_probe,
+	.probe = atc260x_i2c_probe,
 };
 module_i2c_driver(atc260x_i2c_driver);
 
diff --git a/drivers/mfd/axp20x-i2c.c b/drivers/mfd/axp20x-i2c.c
index a49e5e217554..da0e538c18bd 100644
--- a/drivers/mfd/axp20x-i2c.c
+++ b/drivers/mfd/axp20x-i2c.c
@@ -103,7 +103,7 @@ static struct i2c_driver axp20x_i2c_driver = {
 		.of_match_table	= of_match_ptr(axp20x_i2c_of_match),
 		.acpi_match_table = ACPI_PTR(axp20x_i2c_acpi_match),
 	},
-	.probe_new	= axp20x_i2c_probe,
+	.probe		= axp20x_i2c_probe,
 	.remove		= axp20x_i2c_remove,
 	.id_table	= axp20x_i2c_id,
 };
diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
index 251d515478d5..9f39b46b87f4 100644
--- a/drivers/mfd/bcm590xx.c
+++ b/drivers/mfd/bcm590xx.c
@@ -108,7 +108,7 @@ static struct i2c_driver bcm590xx_i2c_driver = {
 		   .name = "bcm590xx",
 		   .of_match_table = bcm590xx_of_match,
 	},
-	.probe_new = bcm590xx_i2c_probe,
+	.probe = bcm590xx_i2c_probe,
 	.id_table = bcm590xx_i2c_id,
 };
 module_i2c_driver(bcm590xx_i2c_driver);
diff --git a/drivers/mfd/bd9571mwv.c b/drivers/mfd/bd9571mwv.c
index 60dc858c8117..819d09e4d100 100644
--- a/drivers/mfd/bd9571mwv.c
+++ b/drivers/mfd/bd9571mwv.c
@@ -278,7 +278,7 @@ static struct i2c_driver bd9571mwv_driver = {
 		.name	= "bd9571mwv",
 		.of_match_table = bd9571mwv_of_match_table,
 	},
-	.probe_new	= bd9571mwv_probe,
+	.probe		= bd9571mwv_probe,
 	.id_table       = bd9571mwv_id_table,
 };
 module_i2c_driver(bd9571mwv_driver);
diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index 6570b33a5a77..e86b39de3303 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -543,7 +543,7 @@ static struct i2c_driver da903x_driver = {
 	.driver	= {
 		.name	= "da903x",
 	},
-	.probe_new	= da903x_probe,
+	.probe		= da903x_probe,
 	.remove		= da903x_remove,
 	.id_table	= da903x_id_table,
 };
diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
index 03db7a2ccf7a..541e2d47677e 100644
--- a/drivers/mfd/da9052-i2c.c
+++ b/drivers/mfd/da9052-i2c.c
@@ -176,7 +176,7 @@ static void da9052_i2c_remove(struct i2c_client *client)
 }
 
 static struct i2c_driver da9052_i2c_driver = {
-	.probe_new = da9052_i2c_probe,
+	.probe = da9052_i2c_probe,
 	.remove = da9052_i2c_remove,
 	.id_table = da9052_i2c_id,
 	.driver = {
diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
index 537fd5de3e6d..bbaf4f07f274 100644
--- a/drivers/mfd/da9055-i2c.c
+++ b/drivers/mfd/da9055-i2c.c
@@ -66,7 +66,7 @@ static const struct of_device_id da9055_of_match[] = {
 };
 
 static struct i2c_driver da9055_i2c_driver = {
-	.probe_new = da9055_i2c_probe,
+	.probe = da9055_i2c_probe,
 	.remove = da9055_i2c_remove,
 	.id_table = da9055_i2c_id,
 	.driver = {
diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index d073d5f106ec..48f58b6f5629 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -726,7 +726,7 @@ static struct i2c_driver da9062_i2c_driver = {
 		.name = "da9062",
 		.of_match_table = da9062_dt_ids,
 	},
-	.probe_new = da9062_i2c_probe,
+	.probe = da9062_i2c_probe,
 	.remove   = da9062_i2c_remove,
 	.id_table = da9062_i2c_id,
 };
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 03f8f95a1d62..d715cf9a9e68 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -469,7 +469,7 @@ static struct i2c_driver da9063_i2c_driver = {
 		.name = "da9063",
 		.of_match_table = da9063_dt_ids,
 	},
-	.probe_new = da9063_i2c_probe,
+	.probe = da9063_i2c_probe,
 	.id_table = da9063_i2c_id,
 };
 
diff --git a/drivers/mfd/da9150-core.c b/drivers/mfd/da9150-core.c
index d2c954103b2f..94d621e20635 100644
--- a/drivers/mfd/da9150-core.c
+++ b/drivers/mfd/da9150-core.c
@@ -510,7 +510,7 @@ static struct i2c_driver da9150_driver = {
 		.name	= "da9150",
 		.of_match_table = da9150_of_match,
 	},
-	.probe_new	= da9150_probe,
+	.probe		= da9150_probe,
 	.remove		= da9150_remove,
 	.shutdown	= da9150_shutdown,
 	.id_table	= da9150_i2c_id,
diff --git a/drivers/mfd/ene-kb3930.c b/drivers/mfd/ene-kb3930.c
index 3eff98e26bea..fa0ad2f14a39 100644
--- a/drivers/mfd/ene-kb3930.c
+++ b/drivers/mfd/ene-kb3930.c
@@ -196,7 +196,7 @@ static const struct of_device_id kb3930_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, kb3930_dt_ids);
 
 static struct i2c_driver kb3930_driver = {
-	.probe_new = kb3930_probe,
+	.probe = kb3930_probe,
 	.remove = kb3930_remove,
 	.driver = {
 		.name = "ene-kb3930",
diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
index c954ed265de8..b02bfdc871e9 100644
--- a/drivers/mfd/gateworks-gsc.c
+++ b/drivers/mfd/gateworks-gsc.c
@@ -264,7 +264,7 @@ static struct i2c_driver gsc_driver = {
 		.name	= "gateworks-gsc",
 		.of_match_table = gsc_of_match,
 	},
-	.probe_new	= gsc_probe,
+	.probe		= gsc_probe,
 	.remove		= gsc_remove,
 };
 module_i2c_driver(gsc_driver);
diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 282b8fd08009..992855bfda3e 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -172,7 +172,7 @@ static struct i2c_driver chtdc_ti_i2c_driver = {
 		.pm = pm_sleep_ptr(&chtdc_ti_pm_ops),
 		.acpi_match_table = chtdc_ti_acpi_ids,
 	},
-	.probe_new = chtdc_ti_probe,
+	.probe = chtdc_ti_probe,
 	.shutdown = chtdc_ti_shutdown,
 };
 module_i2c_driver(chtdc_ti_i2c_driver);
diff --git a/drivers/mfd/intel_soc_pmic_chtwc.c b/drivers/mfd/intel_soc_pmic_chtwc.c
index 871776d511e3..7fce3ef7ab45 100644
--- a/drivers/mfd/intel_soc_pmic_chtwc.c
+++ b/drivers/mfd/intel_soc_pmic_chtwc.c
@@ -272,7 +272,7 @@ static struct i2c_driver cht_wc_driver = {
 		.pm     = pm_sleep_ptr(&cht_wc_pm_ops),
 		.acpi_match_table = cht_wc_acpi_ids,
 	},
-	.probe_new = cht_wc_probe,
+	.probe = cht_wc_probe,
 	.shutdown = cht_wc_shutdown,
 	.id_table = cht_wc_i2c_id,
 };
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index b745ace46e5b..581f81cbaa24 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -263,7 +263,7 @@ static struct i2c_driver crystal_cove_i2c_driver = {
 		.pm = pm_sleep_ptr(&crystal_cove_pm_ops),
 		.acpi_match_table = crystal_cove_acpi_match,
 	},
-	.probe_new = crystal_cove_i2c_probe,
+	.probe = crystal_cove_i2c_probe,
 	.remove = crystal_cove_i2c_remove,
 	.shutdown = crystal_cove_shutdown,
 };
diff --git a/drivers/mfd/iqs62x.c b/drivers/mfd/iqs62x.c
index 1895fce25b06..dfe9cb79e6a1 100644
--- a/drivers/mfd/iqs62x.c
+++ b/drivers/mfd/iqs62x.c
@@ -1069,7 +1069,7 @@ static struct i2c_driver iqs62x_i2c_driver = {
 		.of_match_table = iqs62x_of_match,
 		.pm = &iqs62x_pm,
 	},
-	.probe_new = iqs62x_probe,
+	.probe = iqs62x_probe,
 	.remove = iqs62x_remove,
 };
 module_i2c_driver(iqs62x_i2c_driver);
diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index 1c807c0e6d25..61396d824f16 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -134,7 +134,7 @@ static struct i2c_driver khadas_mcu_driver = {
 		.name = "khadas-mcu-core",
 		.of_match_table = of_match_ptr(khadas_mcu_of_match),
 	},
-	.probe_new = khadas_mcu_probe,
+	.probe = khadas_mcu_probe,
 };
 module_i2c_driver(khadas_mcu_driver);
 
diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 03830aa4979a..c211183cecb2 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -624,7 +624,7 @@ static struct i2c_driver lm3533_i2c_driver = {
 		   .name = "lm3533",
 	},
 	.id_table	= lm3533_i2c_ids,
-	.probe_new	= lm3533_i2c_probe,
+	.probe		= lm3533_i2c_probe,
 	.remove		= lm3533_i2c_remove,
 };
 
diff --git a/drivers/mfd/lochnagar-i2c.c b/drivers/mfd/lochnagar-i2c.c
index 3a65d9938902..3c8843117080 100644
--- a/drivers/mfd/lochnagar-i2c.c
+++ b/drivers/mfd/lochnagar-i2c.c
@@ -382,7 +382,7 @@ static struct i2c_driver lochnagar_i2c_driver = {
 		.of_match_table = of_match_ptr(lochnagar_of_match),
 		.suppress_bind_attrs = true,
 	},
-	.probe_new = lochnagar_i2c_probe,
+	.probe = lochnagar_i2c_probe,
 };
 
 static int __init lochnagar_i2c_init(void)
diff --git a/drivers/mfd/lp3943.c b/drivers/mfd/lp3943.c
index f9f39b53d030..7f749a23dca8 100644
--- a/drivers/mfd/lp3943.c
+++ b/drivers/mfd/lp3943.c
@@ -140,7 +140,7 @@ MODULE_DEVICE_TABLE(of, lp3943_of_match);
 #endif
 
 static struct i2c_driver lp3943_driver = {
-	.probe_new = lp3943_probe,
+	.probe = lp3943_probe,
 	.driver = {
 		.name = "lp3943",
 		.of_match_table = of_match_ptr(lp3943_of_match),
diff --git a/drivers/mfd/lp873x.c b/drivers/mfd/lp873x.c
index c81c5c9ad748..6639f0fad4ea 100644
--- a/drivers/mfd/lp873x.c
+++ b/drivers/mfd/lp873x.c
@@ -78,7 +78,7 @@ static struct i2c_driver lp873x_driver = {
 		.name	= "lp873x",
 		.of_match_table = of_lp873x_match_table,
 	},
-	.probe_new	= lp873x_probe,
+	.probe		= lp873x_probe,
 	.id_table	= lp873x_id_table,
 };
 module_i2c_driver(lp873x_driver);
diff --git a/drivers/mfd/lp87565.c b/drivers/mfd/lp87565.c
index 568f0f01ea0d..88ce4d7c50a7 100644
--- a/drivers/mfd/lp87565.c
+++ b/drivers/mfd/lp87565.c
@@ -119,7 +119,7 @@ static struct i2c_driver lp87565_driver = {
 		.name	= "lp87565",
 		.of_match_table = of_lp87565_match_table,
 	},
-	.probe_new = lp87565_probe,
+	.probe = lp87565_probe,
 	.shutdown = lp87565_shutdown,
 	.id_table = lp87565_id_table,
 };
diff --git a/drivers/mfd/lp8788.c b/drivers/mfd/lp8788.c
index 18583addaae2..f371eeb042e0 100644
--- a/drivers/mfd/lp8788.c
+++ b/drivers/mfd/lp8788.c
@@ -225,7 +225,7 @@ static struct i2c_driver lp8788_driver = {
 	.driver = {
 		.name = "lp8788",
 	},
-	.probe_new = lp8788_probe,
+	.probe = lp8788_probe,
 	.remove = lp8788_remove,
 	.id_table = lp8788_ids,
 };
diff --git a/drivers/mfd/madera-i2c.c b/drivers/mfd/madera-i2c.c
index 47e65d88feb0..0968aa9733ac 100644
--- a/drivers/mfd/madera-i2c.c
+++ b/drivers/mfd/madera-i2c.c
@@ -139,7 +139,7 @@ static struct i2c_driver madera_i2c_driver = {
 		.pm	= &madera_pm_ops,
 		.of_match_table	= of_match_ptr(madera_of_match),
 	},
-	.probe_new	= madera_i2c_probe,
+	.probe		= madera_i2c_probe,
 	.remove		= madera_i2c_remove,
 	.id_table	= madera_i2c_id,
 };
diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index 0e3731e9e9b5..25ed8846b7fb 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -518,7 +518,7 @@ static struct i2c_driver max14577_i2c_driver = {
 		.pm = pm_sleep_ptr(&max14577_pm),
 		.of_match_table = max14577_dt_match,
 	},
-	.probe_new = max14577_i2c_probe,
+	.probe = max14577_i2c_probe,
 	.remove = max14577_i2c_remove,
 	.id_table = max14577_i2c_id,
 };
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index cbd2297126f0..5811ed8f4840 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -698,7 +698,7 @@ static struct i2c_driver max77620_driver = {
 		.name = "max77620",
 		.pm = pm_sleep_ptr(&max77620_pm_ops),
 	},
-	.probe_new = max77620_probe,
+	.probe = max77620_probe,
 	.id_table = max77620_id,
 };
 builtin_i2c_driver(max77620_driver);
diff --git a/drivers/mfd/max77650.c b/drivers/mfd/max77650.c
index 3c07fcdd9d07..75b5dc44e38c 100644
--- a/drivers/mfd/max77650.c
+++ b/drivers/mfd/max77650.c
@@ -222,7 +222,7 @@ static struct i2c_driver max77650_i2c_driver = {
 		.name = "max77650",
 		.of_match_table = max77650_of_match,
 	},
-	.probe_new = max77650_i2c_probe,
+	.probe = max77650_i2c_probe,
 };
 module_i2c_driver(max77650_i2c_driver);
 
diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index f8e863f3fc95..01833086ca7d 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -269,7 +269,7 @@ static struct i2c_driver max77686_i2c_driver = {
 		   .pm = pm_sleep_ptr(&max77686_pm),
 		   .of_match_table = max77686_pmic_dt_match,
 	},
-	.probe_new = max77686_i2c_probe,
+	.probe = max77686_i2c_probe,
 };
 
 module_i2c_driver(max77686_i2c_driver);
diff --git a/drivers/mfd/max77693.c b/drivers/mfd/max77693.c
index 3995e8769f49..1c485a4c3dcf 100644
--- a/drivers/mfd/max77693.c
+++ b/drivers/mfd/max77693.c
@@ -356,7 +356,7 @@ static struct i2c_driver max77693_i2c_driver = {
 		   .pm = &max77693_pm,
 		   .of_match_table = of_match_ptr(max77693_dt_match),
 	},
-	.probe_new = max77693_i2c_probe,
+	.probe = max77693_i2c_probe,
 	.remove = max77693_i2c_remove,
 	.id_table = max77693_i2c_id,
 };
diff --git a/drivers/mfd/max77714.c b/drivers/mfd/max77714.c
index 143a432ea343..c618605a3fb2 100644
--- a/drivers/mfd/max77714.c
+++ b/drivers/mfd/max77714.c
@@ -143,7 +143,7 @@ static struct i2c_driver max77714_driver = {
 		.name = "max77714",
 		.of_match_table = max77714_dt_match,
 	},
-	.probe_new = max77714_probe,
+	.probe = max77714_probe,
 };
 module_i2c_driver(max77714_driver);
 
diff --git a/drivers/mfd/max77843.c b/drivers/mfd/max77843.c
index 8ff0723808c8..b3689c13a14d 100644
--- a/drivers/mfd/max77843.c
+++ b/drivers/mfd/max77843.c
@@ -207,7 +207,7 @@ static struct i2c_driver max77843_i2c_driver = {
 		.of_match_table = max77843_dt_match,
 		.suppress_bind_attrs = true,
 	},
-	.probe_new = max77843_probe,
+	.probe = max77843_probe,
 	.id_table = max77843_id,
 };
 
diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 0b8f6c298f97..78b5ee688dec 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -311,7 +311,7 @@ static struct i2c_driver max8907_i2c_driver = {
 		.name = "max8907",
 		.of_match_table = of_match_ptr(max8907_of_match),
 	},
-	.probe_new = max8907_i2c_probe,
+	.probe = max8907_i2c_probe,
 	.remove = max8907_i2c_remove,
 	.id_table = max8907_i2c_id,
 };
diff --git a/drivers/mfd/max8925-i2c.c b/drivers/mfd/max8925-i2c.c
index c8761003c716..7608000488f9 100644
--- a/drivers/mfd/max8925-i2c.c
+++ b/drivers/mfd/max8925-i2c.c
@@ -239,7 +239,7 @@ static struct i2c_driver max8925_driver = {
 		.pm     = pm_sleep_ptr(&max8925_pm_ops),
 		.of_match_table = max8925_dt_ids,
 	},
-	.probe_new	= max8925_probe,
+	.probe		= max8925_probe,
 	.remove		= max8925_remove,
 	.id_table	= max8925_id_table,
 };
diff --git a/drivers/mfd/max8997.c b/drivers/mfd/max8997.c
index 79d551b86150..94c09a5eab32 100644
--- a/drivers/mfd/max8997.c
+++ b/drivers/mfd/max8997.c
@@ -478,7 +478,7 @@ static struct i2c_driver max8997_i2c_driver = {
 		   .suppress_bind_attrs = true,
 		   .of_match_table = of_match_ptr(max8997_pmic_dt_match),
 	},
-	.probe_new = max8997_i2c_probe,
+	.probe = max8997_i2c_probe,
 	.id_table = max8997_i2c_id,
 };
 
diff --git a/drivers/mfd/max8998.c b/drivers/mfd/max8998.c
index 122f7b931f5a..33a3ec5464fb 100644
--- a/drivers/mfd/max8998.c
+++ b/drivers/mfd/max8998.c
@@ -348,7 +348,7 @@ static struct i2c_driver max8998_i2c_driver = {
 		   .suppress_bind_attrs = true,
 		   .of_match_table = of_match_ptr(max8998_dt_match),
 	},
-	.probe_new = max8998_i2c_probe,
+	.probe = max8998_i2c_probe,
 	.id_table = max8998_i2c_id,
 };
 
diff --git a/drivers/mfd/mc13xxx-i2c.c b/drivers/mfd/mc13xxx-i2c.c
index 633b973a5ba7..de59b498c925 100644
--- a/drivers/mfd/mc13xxx-i2c.c
+++ b/drivers/mfd/mc13xxx-i2c.c
@@ -95,7 +95,7 @@ static struct i2c_driver mc13xxx_i2c_driver = {
 		.name = "mc13xxx",
 		.of_match_table = mc13xxx_dt_ids,
 	},
-	.probe_new = mc13xxx_i2c_probe,
+	.probe = mc13xxx_i2c_probe,
 	.remove = mc13xxx_i2c_remove,
 };
 
diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index c2866a11c1d2..662604ea97f2 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1240,7 +1240,7 @@ static struct i2c_driver menelaus_i2c_driver = {
 	.driver = {
 		.name		= DRIVER_NAME,
 	},
-	.probe_new	= menelaus_probe,
+	.probe		= menelaus_probe,
 	.remove		= menelaus_remove,
 	.id_table	= menelaus_id,
 };
diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
index 9092fac46e35..1d36095155e0 100644
--- a/drivers/mfd/menf21bmc.c
+++ b/drivers/mfd/menf21bmc.c
@@ -111,7 +111,7 @@ MODULE_DEVICE_TABLE(i2c, menf21bmc_id_table);
 static struct i2c_driver menf21bmc_driver = {
 	.driver.name	= "menf21bmc",
 	.id_table	= menf21bmc_id_table,
-	.probe_new	= menf21bmc_probe,
+	.probe		= menf21bmc_probe,
 };
 
 module_i2c_driver(menf21bmc_driver);
diff --git a/drivers/mfd/mp2629.c b/drivers/mfd/mp2629.c
index 16840ec5fd1c..717b704c3c6b 100644
--- a/drivers/mfd/mp2629.c
+++ b/drivers/mfd/mp2629.c
@@ -70,7 +70,7 @@ static struct i2c_driver mp2629_driver = {
 		.name = "mp2629",
 		.of_match_table = mp2629_of_match,
 	},
-	.probe_new	= mp2629_probe,
+	.probe		= mp2629_probe,
 };
 module_i2c_driver(mp2629_driver);
 
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index d3b32eb79837..2685efa5c9e2 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -623,7 +623,7 @@ static struct i2c_driver mt6360_driver = {
 		.pm = &mt6360_pm_ops,
 		.of_match_table = of_match_ptr(mt6360_of_id),
 	},
-	.probe_new = mt6360_probe,
+	.probe = mt6360_probe,
 };
 module_i2c_driver(mt6360_driver);
 
diff --git a/drivers/mfd/mt6370.c b/drivers/mfd/mt6370.c
index cf19cce2fdc0..c126ccb25d66 100644
--- a/drivers/mfd/mt6370.c
+++ b/drivers/mfd/mt6370.c
@@ -303,7 +303,7 @@ static struct i2c_driver mt6370_driver = {
 		.name = "mt6370",
 		.of_match_table = mt6370_match_table,
 	},
-	.probe_new = mt6370_probe,
+	.probe = mt6370_probe,
 };
 module_i2c_driver(mt6370_driver);
 
diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index b02785b10d48..4416cd37e539 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -260,7 +260,7 @@ static struct i2c_driver ntxec_driver = {
 		.name = "ntxec",
 		.of_match_table = of_ntxec_match_table,
 	},
-	.probe_new = ntxec_probe,
+	.probe = ntxec_probe,
 	.remove = ntxec_remove,
 };
 module_i2c_driver(ntxec_driver);
diff --git a/drivers/mfd/palmas.c b/drivers/mfd/palmas.c
index b8383c6cba3f..a36f12402987 100644
--- a/drivers/mfd/palmas.c
+++ b/drivers/mfd/palmas.c
@@ -725,7 +725,7 @@ static struct i2c_driver palmas_i2c_driver = {
 		   .name = "palmas",
 		   .of_match_table = of_palmas_match_tbl,
 	},
-	.probe_new = palmas_i2c_probe,
+	.probe = palmas_i2c_probe,
 	.remove = palmas_i2c_remove,
 	.id_table = palmas_i2c_id,
 };
diff --git a/drivers/mfd/pcf50633-core.c b/drivers/mfd/pcf50633-core.c
index 0e4fc99e9f49..014a68711b18 100644
--- a/drivers/mfd/pcf50633-core.c
+++ b/drivers/mfd/pcf50633-core.c
@@ -282,7 +282,7 @@ static struct i2c_driver pcf50633_driver = {
 		.pm	= pm_sleep_ptr(&pcf50633_pm),
 	},
 	.id_table = pcf50633_id_table,
-	.probe_new = pcf50633_probe,
+	.probe = pcf50633_probe,
 	.remove = pcf50633_remove,
 };
 
diff --git a/drivers/mfd/qcom-pm8008.c b/drivers/mfd/qcom-pm8008.c
index 837246aab4ac..959b70148442 100644
--- a/drivers/mfd/qcom-pm8008.c
+++ b/drivers/mfd/qcom-pm8008.c
@@ -205,7 +205,7 @@ static struct i2c_driver pm8008_mfd_driver = {
 		.name = "pm8008",
 		.of_match_table = pm8008_match,
 	},
-	.probe_new = pm8008_probe,
+	.probe = pm8008_probe,
 };
 module_i2c_driver(pm8008_mfd_driver);
 
diff --git a/drivers/mfd/rc5t583.c b/drivers/mfd/rc5t583.c
index df83cc399315..5e81f011363f 100644
--- a/drivers/mfd/rc5t583.c
+++ b/drivers/mfd/rc5t583.c
@@ -288,7 +288,7 @@ static struct i2c_driver rc5t583_i2c_driver = {
 	.driver = {
 		   .name = "rc5t583",
 		   },
-	.probe_new = rc5t583_i2c_probe,
+	.probe = rc5t583_i2c_probe,
 	.id_table = rc5t583_i2c_id,
 };
 
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index d71483859e2e..b50cfa7f4b8f 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -318,7 +318,7 @@ static struct i2c_driver retu_driver = {
 		.name = "retu-mfd",
 		.of_match_table = retu_of_match,
 	},
-	.probe_new	= retu_probe,
+	.probe		= retu_probe,
 	.remove		= retu_remove,
 	.id_table	= retu_id,
 };
diff --git a/drivers/mfd/rk8xx-i2c.c b/drivers/mfd/rk8xx-i2c.c
index 2822bfa8a04a..1a98feea97e2 100644
--- a/drivers/mfd/rk8xx-i2c.c
+++ b/drivers/mfd/rk8xx-i2c.c
@@ -173,7 +173,7 @@ static struct i2c_driver rk8xx_i2c_driver = {
 		.of_match_table = rk8xx_i2c_of_match,
 		.pm = &rk8xx_i2c_pm_ops,
 	},
-	.probe_new = rk8xx_i2c_probe,
+	.probe = rk8xx_i2c_probe,
 	.shutdown  = rk8xx_i2c_shutdown,
 };
 module_i2c_driver(rk8xx_i2c_driver);
diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 2f59230749cd..333fef8729a5 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -280,7 +280,7 @@ static struct i2c_driver rn5t618_i2c_driver = {
 		.of_match_table = of_match_ptr(rn5t618_of_match),
 		.pm = &rn5t618_i2c_dev_pm_ops,
 	},
-	.probe_new = rn5t618_i2c_probe,
+	.probe = rn5t618_i2c_probe,
 	.remove = rn5t618_i2c_remove,
 };
 
diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
index 7eb920633ee9..93d80a79b901 100644
--- a/drivers/mfd/rohm-bd71828.c
+++ b/drivers/mfd/rohm-bd71828.c
@@ -564,7 +564,7 @@ static struct i2c_driver bd71828_drv = {
 		.name = "rohm-bd71828",
 		.of_match_table = bd71828_of_match,
 	},
-	.probe_new = &bd71828_i2c_probe,
+	.probe = bd71828_i2c_probe,
 };
 module_i2c_driver(bd71828_drv);
 
diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index 378eb1a692e4..0b58ecc78334 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -208,7 +208,7 @@ static struct i2c_driver bd718xx_i2c_driver = {
 		.name = "rohm-bd718x7",
 		.of_match_table = bd718xx_of_match,
 	},
-	.probe_new = bd718xx_i2c_probe,
+	.probe = bd718xx_i2c_probe,
 };
 
 static int __init bd718xx_i2c_init(void)
diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index 6491e385d980..645673322ec0 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -178,7 +178,7 @@ static struct i2c_driver bd957x_drv = {
 		.name = "rohm-bd957x",
 		.of_match_table = bd957x_of_match,
 	},
-	.probe_new = &bd957x_i2c_probe,
+	.probe = bd957x_i2c_probe,
 };
 module_i2c_driver(bd957x_drv);
 
diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
index 807c32101460..26972a5aff45 100644
--- a/drivers/mfd/rsmu_i2c.c
+++ b/drivers/mfd/rsmu_i2c.c
@@ -279,7 +279,7 @@ static struct i2c_driver rsmu_i2c_driver = {
 		.name = "rsmu-i2c",
 		.of_match_table = of_match_ptr(rsmu_i2c_of_match),
 	},
-	.probe_new = rsmu_i2c_probe,
+	.probe = rsmu_i2c_probe,
 	.remove	= rsmu_i2c_remove,
 	.id_table = rsmu_i2c_id,
 };
diff --git a/drivers/mfd/rt4831.c b/drivers/mfd/rt4831.c
index c6d34dc2b520..f8d6dc55b558 100644
--- a/drivers/mfd/rt4831.c
+++ b/drivers/mfd/rt4831.c
@@ -109,7 +109,7 @@ static struct i2c_driver rt4831_driver = {
 		.name = "rt4831",
 		.of_match_table = rt4831_of_match,
 	},
-	.probe_new = rt4831_probe,
+	.probe = rt4831_probe,
 	.remove = rt4831_remove,
 };
 module_i2c_driver(rt4831_driver);
diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
index a5e520fe50a1..9b3078d776d5 100644
--- a/drivers/mfd/rt5033.c
+++ b/drivers/mfd/rt5033.c
@@ -122,7 +122,7 @@ static struct i2c_driver rt5033_driver = {
 		.name = "rt5033",
 		.of_match_table = rt5033_dt_match,
 	},
-	.probe_new = rt5033_i2c_probe,
+	.probe = rt5033_i2c_probe,
 	.id_table = rt5033_i2c_id,
 };
 module_i2c_driver(rt5033_driver);
diff --git a/drivers/mfd/rt5120.c b/drivers/mfd/rt5120.c
index 829b7a0a0781..58d9a124d795 100644
--- a/drivers/mfd/rt5120.c
+++ b/drivers/mfd/rt5120.c
@@ -114,7 +114,7 @@ static struct i2c_driver rt5120_driver = {
 		.name = "rt5120",
 		.of_match_table = rt5120_device_match_table,
 	},
-	.probe_new = rt5120_probe,
+	.probe = rt5120_probe,
 };
 module_i2c_driver(rt5120_driver);
 
diff --git a/drivers/mfd/sec-core.c b/drivers/mfd/sec-core.c
index c2d0ed496959..d2f631901886 100644
--- a/drivers/mfd/sec-core.c
+++ b/drivers/mfd/sec-core.c
@@ -450,7 +450,7 @@ static struct i2c_driver sec_pmic_driver = {
 		   .pm = pm_sleep_ptr(&sec_pmic_pm_ops),
 		   .of_match_table = sec_dt_match,
 	},
-	.probe_new = sec_pmic_probe,
+	.probe = sec_pmic_probe,
 	.shutdown = sec_pmic_shutdown,
 };
 module_i2c_driver(sec_pmic_driver);
diff --git a/drivers/mfd/si476x-i2c.c b/drivers/mfd/si476x-i2c.c
index 22131cf85e3f..899c0b5ea3aa 100644
--- a/drivers/mfd/si476x-i2c.c
+++ b/drivers/mfd/si476x-i2c.c
@@ -866,7 +866,7 @@ static struct i2c_driver si476x_core_driver = {
 	.driver		= {
 		.name	= "si476x-core",
 	},
-	.probe_new	= si476x_core_probe,
+	.probe		= si476x_core_probe,
 	.remove         = si476x_core_remove,
 	.id_table       = si476x_id,
 };
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 20782b4dd172..4c85cf7d21ea 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -93,7 +93,7 @@ static const struct of_device_id simple_mfd_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
 
 static struct i2c_driver simple_mfd_i2c_driver = {
-	.probe_new = simple_mfd_i2c_probe,
+	.probe = simple_mfd_i2c_probe,
 	.driver = {
 		.name = "simple-mfd-i2c",
 		.of_match_table = simple_mfd_i2c_of_match,
diff --git a/drivers/mfd/sky81452.c b/drivers/mfd/sky81452.c
index 2515ecae1d3f..771b62a5c70f 100644
--- a/drivers/mfd/sky81452.c
+++ b/drivers/mfd/sky81452.c
@@ -77,7 +77,7 @@ static struct i2c_driver sky81452_driver = {
 		.name = "sky81452",
 		.of_match_table = of_match_ptr(sky81452_of_match),
 	},
-	.probe_new = sky81452_probe,
+	.probe = sky81452_probe,
 	.id_table = sky81452_ids,
 };
 
diff --git a/drivers/mfd/smpro-core.c b/drivers/mfd/smpro-core.c
index d7729cf70378..59d31590c69b 100644
--- a/drivers/mfd/smpro-core.c
+++ b/drivers/mfd/smpro-core.c
@@ -125,7 +125,7 @@ static const struct of_device_id smpro_core_of_match[] = {
 MODULE_DEVICE_TABLE(of, smpro_core_of_match);
 
 static struct i2c_driver smpro_core_driver = {
-	.probe_new = smpro_core_probe,
+	.probe = smpro_core_probe,
 	.driver = {
 		.name = "smpro-core",
 		.of_match_table = smpro_core_of_match,
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index e281971ba54e..f30c7c304147 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -553,7 +553,7 @@ static struct i2c_driver stmfx_driver = {
 		.of_match_table = stmfx_of_match,
 		.pm = pm_sleep_ptr(&stmfx_dev_pm_ops),
 	},
-	.probe_new = stmfx_probe,
+	.probe = stmfx_probe,
 	.remove = stmfx_remove,
 };
 module_i2c_driver(stmfx_driver);
diff --git a/drivers/mfd/stmpe-i2c.c b/drivers/mfd/stmpe-i2c.c
index 7998e0db1e15..1d7b401776d1 100644
--- a/drivers/mfd/stmpe-i2c.c
+++ b/drivers/mfd/stmpe-i2c.c
@@ -118,7 +118,7 @@ static struct i2c_driver stmpe_i2c_driver = {
 		.pm = pm_sleep_ptr(&stmpe_dev_pm_ops),
 		.of_match_table = stmpe_of_match,
 	},
-	.probe_new	= stmpe_i2c_probe,
+	.probe		= stmpe_i2c_probe,
 	.remove		= stmpe_i2c_remove,
 	.id_table	= stmpe_i2c_id,
 };
diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index 8db1530d9bac..d0ff46961910 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -201,7 +201,7 @@ static struct i2c_driver stpmic1_driver = {
 		.of_match_table = of_match_ptr(stpmic1_of_match),
 		.pm = pm_sleep_ptr(&stpmic1_pm),
 	},
-	.probe_new = stpmic1_probe,
+	.probe = stpmic1_probe,
 };
 
 module_i2c_driver(stpmic1_driver);
diff --git a/drivers/mfd/stw481x.c b/drivers/mfd/stw481x.c
index 2a8fc9d1c806..f35c3af680dd 100644
--- a/drivers/mfd/stw481x.c
+++ b/drivers/mfd/stw481x.c
@@ -239,7 +239,7 @@ static struct i2c_driver stw481x_driver = {
 		.name	= "stw481x",
 		.of_match_table = stw481x_match,
 	},
-	.probe_new	= stw481x_probe,
+	.probe		= stw481x_probe,
 	.id_table	= stw481x_id,
 };
 
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index cbfe19d1b145..16df64e3c0be 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -485,7 +485,7 @@ static struct i2c_driver tc3589x_driver = {
 		.pm	= pm_sleep_ptr(&tc3589x_dev_pm_ops),
 		.of_match_table = of_match_ptr(tc3589x_match),
 	},
-	.probe_new	= tc3589x_probe,
+	.probe		= tc3589x_probe,
 	.remove		= tc3589x_remove,
 	.id_table	= tc3589x_id,
 };
diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
index 9921320be255..4f06adad7b5e 100644
--- a/drivers/mfd/ti-lmu.c
+++ b/drivers/mfd/ti-lmu.c
@@ -217,7 +217,7 @@ static const struct i2c_device_id ti_lmu_ids[] = {
 MODULE_DEVICE_TABLE(i2c, ti_lmu_ids);
 
 static struct i2c_driver ti_lmu_driver = {
-	.probe_new = ti_lmu_probe,
+	.probe = ti_lmu_probe,
 	.driver = {
 		.name = "ti-lmu",
 		.of_match_table = ti_lmu_of_match,
diff --git a/drivers/mfd/tps6105x.c b/drivers/mfd/tps6105x.c
index a66cb911998d..5601f6d0d874 100644
--- a/drivers/mfd/tps6105x.c
+++ b/drivers/mfd/tps6105x.c
@@ -209,7 +209,7 @@ static struct i2c_driver tps6105x_driver = {
 		.name	= "tps6105x",
 		.of_match_table = tps6105x_of_match,
 	},
-	.probe_new	= tps6105x_probe,
+	.probe		= tps6105x_probe,
 	.remove		= tps6105x_remove,
 	.id_table	= tps6105x_id,
 };
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index fb733288cca3..d4ee7983c9e1 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -668,7 +668,7 @@ static struct i2c_driver tps65010_driver = {
 	.driver = {
 		.name	= "tps65010",
 	},
-	.probe_new = tps65010_probe,
+	.probe = tps65010_probe,
 	.remove	= tps65010_remove,
 	.id_table = tps65010_id,
 };
diff --git a/drivers/mfd/tps6507x.c b/drivers/mfd/tps6507x.c
index 500b594de316..9716bf703c7a 100644
--- a/drivers/mfd/tps6507x.c
+++ b/drivers/mfd/tps6507x.c
@@ -122,7 +122,7 @@ static struct i2c_driver tps6507x_i2c_driver = {
 		   .name = "tps6507x",
 		   .of_match_table = of_match_ptr(tps6507x_of_match),
 	},
-	.probe_new = tps6507x_i2c_probe,
+	.probe = tps6507x_i2c_probe,
 	.id_table = tps6507x_i2c_id,
 };
 
diff --git a/drivers/mfd/tps65086.c b/drivers/mfd/tps65086.c
index 9494c1d71b86..6a21000aad4a 100644
--- a/drivers/mfd/tps65086.c
+++ b/drivers/mfd/tps65086.c
@@ -129,7 +129,7 @@ static struct i2c_driver tps65086_driver = {
 		.name	= "tps65086",
 		.of_match_table = tps65086_of_match_table,
 	},
-	.probe_new	= tps65086_probe,
+	.probe		= tps65086_probe,
 	.remove		= tps65086_remove,
 	.id_table       = tps65086_id_table,
 };
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index af718a9c58b3..a35ad70755fb 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -236,7 +236,7 @@ static struct i2c_driver tps65090_driver = {
 		.suppress_bind_attrs = true,
 		.of_match_table = of_match_ptr(tps65090_of_match),
 	},
-	.probe_new	= tps65090_i2c_probe,
+	.probe		= tps65090_i2c_probe,
 	.id_table	= tps65090_id_table,
 };
 
diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index eebd60601b01..60599291b315 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -402,7 +402,7 @@ static struct i2c_driver tps65217_driver = {
 		.of_match_table = tps65217_of_match,
 	},
 	.id_table	= tps65217_id_table,
-	.probe_new	= tps65217_probe,
+	.probe		= tps65217_probe,
 	.remove		= tps65217_remove,
 };
 
diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
index ea69dcef91ec..619bf7adb20c 100644
--- a/drivers/mfd/tps65218.c
+++ b/drivers/mfd/tps65218.c
@@ -347,7 +347,7 @@ static struct i2c_driver tps65218_driver = {
 		.name	= "tps65218",
 		.of_match_table = of_tps65218_match_table,
 	},
-	.probe_new	= tps65218_probe,
+	.probe		= tps65218_probe,
 	.id_table       = tps65218_id_table,
 };
 
diff --git a/drivers/mfd/tps65219.c b/drivers/mfd/tps65219.c
index 0e402fda206b..72ee23fb46bc 100644
--- a/drivers/mfd/tps65219.c
+++ b/drivers/mfd/tps65219.c
@@ -290,7 +290,7 @@ static struct i2c_driver tps65219_driver = {
 		.name	= "tps65219",
 		.of_match_table = of_tps65219_match_table,
 	},
-	.probe_new	= tps65219_probe,
+	.probe		= tps65219_probe,
 };
 module_i2c_driver(tps65219_driver);
 
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index 90e23232b6b0..55675ceedcd3 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -619,7 +619,7 @@ static struct i2c_driver tps6586x_driver = {
 		.of_match_table = of_match_ptr(tps6586x_of_match),
 		.pm	= &tps6586x_pm_ops,
 	},
-	.probe_new	= tps6586x_i2c_probe,
+	.probe		= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,
 	.id_table	= tps6586x_id_table,
 };
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 821c0277a2ed..41408df1712f 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -535,7 +535,7 @@ static struct i2c_driver tps65910_i2c_driver = {
 		   .name = "tps65910",
 		   .of_match_table = of_match_ptr(tps65910_of_match),
 	},
-	.probe_new = tps65910_i2c_probe,
+	.probe = tps65910_i2c_probe,
 	.id_table = tps65910_i2c_id,
 };
 
diff --git a/drivers/mfd/tps65912-i2c.c b/drivers/mfd/tps65912-i2c.c
index 1bf945966bf7..3c5ac781b6c1 100644
--- a/drivers/mfd/tps65912-i2c.c
+++ b/drivers/mfd/tps65912-i2c.c
@@ -60,7 +60,7 @@ static struct i2c_driver tps65912_i2c_driver = {
 		.name	= "tps65912",
 		.of_match_table = tps65912_i2c_of_match_table,
 	},
-	.probe_new	= tps65912_i2c_probe,
+	.probe		= tps65912_i2c_probe,
 	.remove		= tps65912_i2c_remove,
 	.id_table       = tps65912_i2c_id_table,
 };
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e801b7ce010f..ce01a87f8dc3 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -890,7 +890,7 @@ static struct i2c_driver twl_driver = {
 	.driver.name	= DRIVER_NAME,
 	.driver.pm	= &twl_dev_pm_ops,
 	.id_table	= twl_ids,
-	.probe_new	= twl_probe,
+	.probe		= twl_probe,
 	.remove		= twl_remove,
 };
 builtin_i2c_driver(twl_driver);
diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index e982119bbefa..e7658999bda2 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -829,7 +829,7 @@ static struct i2c_driver twl6040_driver = {
 	.driver = {
 		.name = "twl6040",
 	},
-	.probe_new	= twl6040_probe,
+	.probe		= twl6040_probe,
 	.remove		= twl6040_remove,
 	.id_table	= twl6040_i2c_id,
 };
diff --git a/drivers/mfd/wl1273-core.c b/drivers/mfd/wl1273-core.c
index a5d6128fc67d..e2a7fccaed01 100644
--- a/drivers/mfd/wl1273-core.c
+++ b/drivers/mfd/wl1273-core.c
@@ -232,7 +232,7 @@ static struct i2c_driver wl1273_core_driver = {
 	.driver = {
 		.name = WL1273_FM_DRIVER_NAME,
 	},
-	.probe_new = wl1273_core_probe,
+	.probe = wl1273_core_probe,
 	.id_table = wl1273_driver_id_table,
 };
 
diff --git a/drivers/mfd/wm831x-i2c.c b/drivers/mfd/wm831x-i2c.c
index 9dbe96e2d46a..997837f13180 100644
--- a/drivers/mfd/wm831x-i2c.c
+++ b/drivers/mfd/wm831x-i2c.c
@@ -102,7 +102,7 @@ static struct i2c_driver wm831x_i2c_driver = {
 		.of_match_table = of_match_ptr(wm831x_of_match),
 		.suppress_bind_attrs = true,
 	},
-	.probe_new = wm831x_i2c_probe,
+	.probe = wm831x_i2c_probe,
 	.id_table = wm831x_i2c_id,
 };
 
diff --git a/drivers/mfd/wm8350-i2c.c b/drivers/mfd/wm8350-i2c.c
index 1fa1dfbc9e31..c2a7d7069975 100644
--- a/drivers/mfd/wm8350-i2c.c
+++ b/drivers/mfd/wm8350-i2c.c
@@ -52,7 +52,7 @@ static struct i2c_driver wm8350_i2c_driver = {
 		   .name = "wm8350",
 		   .suppress_bind_attrs = true,
 	},
-	.probe_new = wm8350_i2c_probe,
+	.probe = wm8350_i2c_probe,
 	.id_table = wm8350_i2c_id,
 };
 
diff --git a/drivers/mfd/wm8400-core.c b/drivers/mfd/wm8400-core.c
index b572966e1ff6..75483c9be0c4 100644
--- a/drivers/mfd/wm8400-core.c
+++ b/drivers/mfd/wm8400-core.c
@@ -143,7 +143,7 @@ static struct i2c_driver wm8400_i2c_driver = {
 	.driver = {
 		.name = "WM8400",
 	},
-	.probe_new = wm8400_i2c_probe,
+	.probe = wm8400_i2c_probe,
 	.id_table = wm8400_i2c_id,
 };
 #endif
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1b769ac3e53b..1e4f1694f065 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -670,7 +670,7 @@ static struct i2c_driver wm8994_i2c_driver = {
 		.pm = pm_ptr(&wm8994_pm_ops),
 		.of_match_table = wm8994_of_match,
 	},
-	.probe_new = wm8994_i2c_probe,
+	.probe = wm8994_i2c_probe,
 	.remove = wm8994_i2c_remove,
 	.id_table = wm8994_i2c_id,
 };

base-commit: 9bdc4322bbd17047e014795aacc4e1eaff682cba
-- 
2.39.2

