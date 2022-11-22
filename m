Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7429633A59
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiKVKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiKVKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:43:13 -0500
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Nov 2022 02:37:56 PST
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C4502FFED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:37:53 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 9F6EF720109;
        Tue, 22 Nov 2022 11:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669113013;
        bh=UxAFvVtbqMJfsjbWnEHsf/pzy6Jo+6CqJCL6bt0gbJ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=LcbJGvwJLp/A9g/aHdNe+sBfSo/TRymzvgsBvoGXs/fk5pUjhPDHhZl0ZpWYTh/mo
         2i2KoULRHnqIhsNA/a2qBvCOOZFVQL6/dOjf3gvdH8790mLOvqkysQBvPFcvpd/26B
         ZWG2D6/nam0qGxS0OzGGKftdkwWa+mquonzKaZKKY0Kes0sJpmuhKZDI+9AOYnrNFn
         uWe7RN+GFffEFfNYYFpQNjRyG6skLdnMew/ZNAAAPSo4yraI1zUdtOtkmzK0bWGaRj
         sO52wvKlTcQiH0IUvE492yH1tw61kmDLZOqLhSPvo7lXhBynBggEC95hTxY0/l8Atf
         e3gmfGwzc9POQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 22 Nov 2022 11:00:03 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Tue, 22 Nov 2022 11:00:02 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        "Support Opensource" <support.opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] mfd: da9062: Remove IRQ requirement
Date:   Tue, 22 Nov 2022 10:58:32 +0100
Message-ID: <20221122095833.3957-3-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
In-Reply-To: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
References: <20221122095833.3957-1-cniedermaier@dh-electronics.com>
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
useable for designs which haven't connected the IRQ pin.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
---
Cc: Support Opensource <support.opensource@diasemi.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
 drivers/mfd/da9062-core.c | 98 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index a26e473507c7..9255f86a527c 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -212,6 +212,27 @@ static const struct mfd_cell da9061_devs[] = {
 	},
 };
 
+static const struct mfd_cell da9061_devs_without_irq[] = {
+	{
+		.name		= "da9061-core",
+	},
+	{
+		.name		= "da9062-regulators",
+	},
+	{
+		.name		= "da9061-watchdog",
+		.of_compatible  = "dlg,da9061-watchdog",
+	},
+	{
+		.name		= "da9061-thermal",
+		.of_compatible  = "dlg,da9061-thermal",
+	},
+	{
+		.name		= "da9061-onkey",
+		.of_compatible = "dlg,da9061-onkey",
+	},
+};
+
 static const struct resource da9062_core_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_VDD_WARN, 1, "VDD_WARN", IORESOURCE_IRQ),
 };
@@ -288,6 +309,35 @@ static const struct mfd_cell da9062_devs[] = {
 	},
 };
 
+static const struct mfd_cell da9062_devs_without_irq[] = {
+	{
+		.name		= "da9062-core",
+	},
+	{
+		.name		= "da9062-regulators",
+	},
+	{
+		.name		= "da9062-watchdog",
+		.of_compatible  = "dlg,da9062-watchdog",
+	},
+	{
+		.name		= "da9062-thermal",
+		.of_compatible  = "dlg,da9062-thermal",
+	},
+	{
+		.name		= "da9062-rtc",
+		.of_compatible  = "dlg,da9062-rtc",
+	},
+	{
+		.name		= "da9062-onkey",
+		.of_compatible	= "dlg,da9062-onkey",
+	},
+	{
+		.name		= "da9062-gpio",
+		.of_compatible	= "dlg,da9062-gpio",
+	},
+};
+
 static int da9062_clear_fault_log(struct da9062 *chip)
 {
 	int ret;
@@ -625,7 +675,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	const struct i2c_device_id *id)
 {
 	struct da9062 *chip;
-	unsigned int irq_base;
+	unsigned int irq_base = 0;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
@@ -645,21 +695,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	i2c_set_clientdata(i2c, chip);
 	chip->dev = &i2c->dev;
 
-	if (!i2c->irq) {
-		dev_err(chip->dev, "No IRQ configured\n");
-		return -EINVAL;
-	}
-
 	switch (chip->chip_type) {
 	case COMPAT_TYPE_DA9061:
-		cell = da9061_devs;
-		cell_num = ARRAY_SIZE(da9061_devs);
+		cell = i2c->irq ? da9061_devs : da9061_devs_without_irq;
+		cell_num = i2c->irq ? ARRAY_SIZE(da9061_devs) : ARRAY_SIZE(da9061_devs_without_irq);
 		irq_chip = &da9061_irq_chip;
 		config = &da9061_regmap_config;
 		break;
 	case COMPAT_TYPE_DA9062:
-		cell = da9062_devs;
-		cell_num = ARRAY_SIZE(da9062_devs);
+		cell = i2c->irq ? da9062_devs : da9062_devs_without_irq;
+		cell_num = i2c->irq ? ARRAY_SIZE(da9062_devs) : ARRAY_SIZE(da9062_devs_without_irq);
 		irq_chip = &da9062_irq_chip;
 		config = &da9062_regmap_config;
 		break;
@@ -695,29 +740,32 @@ static int da9062_i2c_probe(struct i2c_client *i2c,
 	if (ret)
 		return ret;
 
-	ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
-	if (ret < 0) {
-		dev_err(chip->dev, "Failed to configure IRQ type\n");
-		return ret;
-	}
+	if (i2c->irq) {
+		ret = da9062_configure_irq_type(chip, i2c->irq, &trigger_type);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to configure IRQ type\n");
+			return ret;
+		}
 
-	ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
-			trigger_type | IRQF_SHARED | IRQF_ONESHOT,
-			-1, irq_chip, &chip->regmap_irq);
-	if (ret) {
-		dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
-			i2c->irq, ret);
-		return ret;
-	}
+		ret = regmap_add_irq_chip(chip->regmap, i2c->irq,
+				trigger_type | IRQF_SHARED | IRQF_ONESHOT,
+				-1, irq_chip, &chip->regmap_irq);
+		if (ret) {
+			dev_err(chip->dev, "Failed to request IRQ %d: %d\n",
+				i2c->irq, ret);
+			return ret;
+		}
 
-	irq_base = regmap_irq_chip_get_base(chip->regmap_irq);
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

