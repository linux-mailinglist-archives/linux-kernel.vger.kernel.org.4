Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6B16B2042
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjCIJjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjCIJi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:38:57 -0500
X-Greylist: delayed 169411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Mar 2023 01:38:54 PST
Received: from mx3.securetransport.de (mx3.securetransport.de [116.203.31.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C98EC6403
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:38:53 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 6EA545DC68;
        Thu,  9 Mar 2023 10:38:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1678354695;
        bh=QrS0g2IaLcFDuj9/77hmEeVI9DdFtrhYtDncfOVFL9k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VktPNi7bVUbsT6mLgD2P4EAd8+hwAVd9huG0zjRE5pq6luBhhCn39qXi3q6gBYhT2
         zv1/PlZHl9SUup4AVDngMomAJw+TJjO8ANLgSitJZhNuFz7W+6ZH3F4hG8z0tvgn4A
         vXjvXw37bhb0uwrzpTj/s3bhONwgdGCMeTmH314o4Mo3LwBTr2q8kWFrdvmrbIThL2
         pjTIJcozsnxZtjQXiJcKy50yImS3TiJhaa1VOKkliosgboqwbp4Kqq14QxCM3sB61y
         1OLcAM26YcWutZP/HQK8sUY1mKkaSIhtXunn8Y+0NysRqfgPxWaYjwk6eZb2FETf5f
         VQUbWmHrTm+ug==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 9 Mar 2023 10:22:56 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25 via Frontend Transport; Thu, 9 Mar 2023 10:22:56 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 2/3] mfd: da9062: Remove IRQ requirement
Date:   Thu, 9 Mar 2023 10:22:53 +0100
Message-ID: <20230309092254.56279-2-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
References: <20230309092254.56279-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the requirement for an IRQ, because for the core
functionality IRQ isn't needed. So this makes the DA9061/62 chip
usable for designs which haven't connected the IRQ pin.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Lee Jones <lee@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rebase on current next 20230209
    - Add Lee Jones to Cc list
V3: - Rebase on current next 20230307
    - Use macro MFD_CELL_OF
    - Refactoring the code for use without IRQ
V4: - Rebase on current next 20230309
    - Add Acked-by tag
---
 drivers/mfd/da9062-core.c | 84 +++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 9418c58c2b06..d073d5f106ec 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -181,7 +181,7 @@ static const struct resource da9061_onkey_resources[] = {
 	DEFINE_RES_IRQ_NAMED(DA9061_IRQ_ONKEY, "ONKEY"),
 };
 
-static const struct mfd_cell da9061_devs[] = {
+static const struct mfd_cell da9061_devs_irq[] = {
 	MFD_CELL_OF("da9061-core", da9061_core_resources, NULL, 0, 0,
 		    NULL),
 	MFD_CELL_OF("da9062-regulators", da9061_regulators_resources, NULL, 0, 0,
@@ -194,6 +194,14 @@ static const struct mfd_cell da9061_devs[] = {
 		    "dlg,da9061-onkey"),
 };
 
+static const struct mfd_cell da9061_devs_noirq[] = {
+	MFD_CELL_OF("da9061-core", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-regulators", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9061-watchdog", NULL, NULL, 0, 0, "dlg,da9061-watchdog"),
+	MFD_CELL_OF("da9061-thermal", NULL, NULL, 0, 0, "dlg,da9061-thermal"),
+	MFD_CELL_OF("da9061-onkey", NULL, NULL, 0, 0, "dlg,da9061-onkey"),
+};
+
 static const struct resource da9062_core_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
 };
@@ -227,7 +235,7 @@ static const struct resource da9062_gpio_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_GPI4, 1, "GPI4", IORESOURCE_IRQ),
 };
 
-static const struct mfd_cell da9062_devs[] = {
+static const struct mfd_cell da9062_devs_irq[] = {
 	MFD_CELL_OF("da9062-core", da9062_core_resources, NULL, 0, 0,
 		    NULL),
 	MFD_CELL_OF("da9062-regulators", da9062_regulators_resources, NULL, 0, 0,
@@ -244,6 +252,16 @@ static const struct mfd_cell da9062_devs[] = {
 		    "dlg,da9062-gpio"),
 };
 
+static const struct mfd_cell da9062_devs_noirq[] = {
+	MFD_CELL_OF("da9062-core", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-regulators", NULL, NULL, 0, 0, NULL),
+	MFD_CELL_OF("da9062-watchdog", NULL, NULL, 0, 0, "dlg,da9062-watchdog"),
+	MFD_CELL_OF("da9062-thermal", NULL, NULL, 0, 0, "dlg,da9062-thermal"),
+	MFD_CELL_OF("da9062-rtc", NULL, NULL, 0, 0, "dlg,da9062-rtc"),
+	MFD_CELL_OF("da9062-onkey", NULL, NULL, 0, 0, "dlg,da9062-onkey"),
+	MFD_CELL_OF("da9062-gpio", NULL, NULL, 0, 0, "dlg,da9062-gpio"),
+};
+
 static int da9062_clear_fault_log(struct da9062 *chip)
 {
 	int ret;
@@ -581,7 +599,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct da9062 *chip;
-	unsigned int irq_base;
+	unsigned int irq_base = 0;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
@@ -601,22 +619,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
 	i2c_set_clientdata(i2c, chip);
 	chip->dev = &i2c->dev;
 
-	if (!i2c->irq) {
-		dev_err(chip->dev, "No IRQ configured\n");
-		return -EINVAL;
-	}
-
+	/* Start with a base configuration without IRQ */
 	switch (chip->chip_type) {
 	case COMPAT_TYPE_DA9061:
-		cell = da9061_devs;
-		cell_num = ARRAY_SIZE(da9061_devs);
-		irq_chip = &da9061_irq_chip;
+		cell = da9061_devs_noirq;
+		cell_num = ARRAY_SIZE(da9061_devs_noirq);
 		config = &da9061_regmap_config;
 		break;
 	case COMPAT_TYPE_DA9062:
-		cell = da9062_devs;
-		cell_num = ARRAY_SIZE(da9062_devs);
-		irq_chip = &da9062_irq_chip;
+		cell = da9062_devs_noirq;
+		cell_num = ARRAY_SIZE(da9062_devs_noirq);
 		config = &da9062_regmap_config;
 		break;
 	default:
@@ -651,29 +663,43 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return ret;
 
-	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to configure IRQ type\n");
-		return ret;
-	}
+	/* If IRQ is available, reconfigure it accordingly */
+	if (i2c->irq) {
+		if (chip->chip_type == COMPAT_TYPE_DA9061) {
+			cell = da9061_devs_irq;
+			cell_num = ARRAY_SIZE(da9061_devs_irq);
+			irq_chip = &da9061_irq_chip;
+		} else {
+			cell = da9062_devs_irq;
+			cell_num = ARRAY_SIZE(da9062_devs_irq);
+			irq_chip = &da9062_irq_chip;
+		}
 
-	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
-			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
-			-1, irq_chip, &chip->regmap_irq);
-	if (ret) {
-		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
-			i2c->irq, ret);
-		return ret;
-	}
+		ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to configure IRQ type\n");
+			return ret;
+		}
 
-	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
+		ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
+					  trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+					  -1, irq_chip, &chip->regmap_irq);
+		if (ret) {
+			dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
+				i2c->irq, ret);
+			return ret;
+		}
+
+		irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
+	}
 
 	ret = mfd_add_devices(chip->dev, PLATFORM_DEVID_NONE, cell,
 			      cell_num, NULL, irq_base,
 			      NULL);
 	if (ret) {
 		dev_err(chip->dev, "Cannot register child devices\n");
-		regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
+		if (i2c->irq)
+			regmap_del_irq_chip(i2c->irq, chip->regmap_irq);
 		return ret;
 	}
 
-- 
2.11.0

