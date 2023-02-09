Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88486905B8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjBIKxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjBIKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:53:41 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F226049402
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:53:33 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id 685565E9DA;
        Thu,  9 Feb 2023 11:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1675939967;
        bh=rIypa5wgaFQgkB38FGKqj8GeX3xjPSyXjalzqhgKna8=;
        h=From:To:CC:Subject:Date:From;
        b=Fn+A49E5ToBchG3vvkwIa761MxFIbMkSfdHkNwMsY+OMm4q/I91zYc3IVjCVgMdPS
         njG83IBXtrzmd29KXbLjtwiVTGptRP5rcLxUqxgmVjK7zmIg+oFVLOv1bhYnQ98OR1
         Z0q6knKkRDUo9dYYdt57nI+D1Ya2KEPn/Ib7NbcjDGn/RdwX8GDj8qQftcy0/uV1sl
         xNfwnFVYSdD/BIeeH/CrS1KxqiP/JzN5+FnVNm5hUg3M42xNyIoETbS60C0/+PxgE9
         tY/JlTj2gPMPCkLYWcda1LygS8+En0XCQsvB3/a8uk1ADMI83yF8e4obuxa5XB1a+c
         1+E6VV54GmU0A==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21; Thu, 9 Feb 2023 11:52:34 +0100
Received: from Stretch-CN.dh-electronics.org (10.64.6.116) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.21 via Frontend Transport; Thu, 9 Feb 2023 11:52:34 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
        <kernel@dh-electronics.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/2] mfd: da9062: Remove IRQ requirement
Date:   Thu, 9 Feb 2023 11:51:43 +0100
Message-ID: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
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
---
 drivers/mfd/da9062-core.c | 98 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 25 deletions(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 40cde51e5719..caa597400dd1 100644
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
@@ -625,7 +675,7 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct da9062 *chip;
-	unsigned int irq_base;
+	unsigned int irq_base = 0;
 	const struct mfd_cell *cell;
 	const struct regmap_irq_chip *irq_chip;
 	const struct regmap_config *config;
@@ -645,21 +695,16 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
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
@@ -695,29 +740,32 @@ static int da9062_i2c_probe(struct i2c_client *i2c)
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

