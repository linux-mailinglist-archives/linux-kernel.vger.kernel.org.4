Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073F96E7867
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjDSLTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjDSLS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:18:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B8C13FA9;
        Wed, 19 Apr 2023 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eirZBr5whbQ/5LkAsBUpkmGGeegnaxrngCRkV0JwBOU=; b=EYjBabI/BPcPt2YCxGnsstbmWa
        wBJ4BGqQ50tJYktcPLPBrbP+SCrBfu9B2nCxWiuFec3hMnxf4cAeFPbOm+9AwL4A/BK6+DR5Db1eB
        voeGSNzwUF4NBqSHaCylu7dMhpVGOqStiS/PwFvFgqX0vN3xUacpFgiHiDTezssAfa9lwWBT/YOtt
        QNt8Ec4vwn0GljOaOgqyMPgZ3b1cMnm6LE4BAQuWY9EPQmH/Grarn2R6IXIGTjv6PpB72rmi25LHO
        DKQlxksjHeK8Zv/QrJ0UdDiZVs9nHl+uc2ONcjHQwZ8LWfdDCjt32w0fDcvoc0DMG0L3nH1Qpoa9U
        HstaYu3Q==;
Received: from p200300ccff0a67001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0a:6700:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pp5pH-00085w-24; Wed, 19 Apr 2023 13:18:15 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1pp5pG-004cHP-2g;
        Wed, 19 Apr 2023 13:18:14 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andreas@kemnade.info,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: [PATCH v6 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver
Date:   Wed, 19 Apr 2023 13:18:06 +0200
Message-Id: <20230419111806.1100437-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419111806.1100437-1-andreas@kemnade.info>
References: <20230419111806.1100437-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device provides 6 channels which can be individually
turned off and on but groups of two channels share a common brightness
register.

Limitation: The GPIO to enable the device is not used yet.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/Kconfig          |  14 +++
 drivers/leds/Makefile         |   1 +
 drivers/leds/leds-bd2606mvv.c | 160 ++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+)
 create mode 100644 drivers/leds/leds-bd2606mvv.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 9dbce09eabacf..09afc56f54f16 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -551,6 +551,20 @@ config LEDS_REGULATOR
 	help
 	  This option enables support for regulator driven LEDs.
 
+config LEDS_BD2606MVV
+	tristate "LED driver for BD2606MVV"
+	depends on LEDS_CLASS
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This option enables support for BD2606MVV LED driver chips
+	  accessed via the I2C bus. It supports setting brightness, with
+	  the limitiation that there are groups of two channels sharing
+	  a brightness setting, but not the on/off setting.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called leds-bd2606mvv.
+
 config LEDS_BD2802
 	tristate "LED driver for BD2802 RGB LED"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index d30395d11fd84..c07d1512c745a 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_LEDS_ARIEL)		+= leds-ariel.o
 obj-$(CONFIG_LEDS_AW2013)		+= leds-aw2013.o
 obj-$(CONFIG_LEDS_BCM6328)		+= leds-bcm6328.o
 obj-$(CONFIG_LEDS_BCM6358)		+= leds-bcm6358.o
+obj-$(CONFIG_LEDS_BD2606MVV)		+= leds-bd2606mvv.o
 obj-$(CONFIG_LEDS_BD2802)		+= leds-bd2802.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
 obj-$(CONFIG_LEDS_CLEVO_MAIL)		+= leds-clevo-mail.o
diff --git a/drivers/leds/leds-bd2606mvv.c b/drivers/leds/leds-bd2606mvv.c
new file mode 100644
index 0000000000000..76f9d4d70f9a6
--- /dev/null
+++ b/drivers/leds/leds-bd2606mvv.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Andreas Kemnade
+ *
+ * Datasheet:
+ * https://fscdn.rohm.com/en/products/databook/datasheet/ic/power/led_driver/bd2606mvv_1-e.pdf
+ *
+ * If LED brightness cannot be controlled independently due to shared
+ * brightness registers, max_brightness is set to 1 and only on/off
+ * is possible for the affected LED pair.
+ */
+
+#include <linux/i2c.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define BD2606_MAX_LEDS 6
+#define BD2606_MAX_BRIGHTNESS 63
+#define BD2606_REG_PWRCNT 3
+#define ldev_to_led(c)	container_of(c, struct bd2606mvv_led, ldev)
+
+struct bd2606mvv_led {
+	unsigned int led_no;
+	struct led_classdev ldev;
+	struct bd2606mvv_priv *priv;
+};
+
+struct bd2606mvv_priv {
+	struct bd2606mvv_led leds[BD2606_MAX_LEDS];
+	struct regmap *regmap;
+};
+
+static int
+bd2606mvv_brightness_set(struct led_classdev *led_cdev,
+		      enum led_brightness brightness)
+{
+	struct bd2606mvv_led *led = ldev_to_led(led_cdev);
+	struct bd2606mvv_priv *priv = led->priv;
+	int err;
+
+	if (brightness == 0)
+		return regmap_update_bits(priv->regmap,
+					  BD2606_REG_PWRCNT,
+					  1 << led->led_no,
+					  0);
+
+	/* shared brightness register */
+	err = regmap_write(priv->regmap, led->led_no / 2,
+			   led_cdev->max_brightness == 1 ?
+			   BD2606_MAX_BRIGHTNESS : brightness);
+	if (err)
+		return err;
+
+	return regmap_update_bits(priv->regmap,
+				  BD2606_REG_PWRCNT,
+				  1 << led->led_no,
+				  1 << led->led_no);
+}
+
+static const struct regmap_config bd2606mvv_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3,
+};
+
+static int bd2606mvv_probe(struct i2c_client *client)
+{
+	struct fwnode_handle *np, *child;
+	struct device *dev = &client->dev;
+	struct bd2606mvv_priv *priv;
+	struct fwnode_handle *led_fwnodes[BD2606_MAX_LEDS] = { 0 };
+	int active_pairs[BD2606_MAX_LEDS / 2] = { 0 };
+	int err, reg;
+	int i;
+
+	np = dev_fwnode(dev);
+	if (!np)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = devm_regmap_init_i2c(client, &bd2606mvv_regmap);
+	if (IS_ERR(priv->regmap)) {
+		err = PTR_ERR(priv->regmap);
+		dev_err(dev, "Failed to allocate register map: %d\n", err);
+		return err;
+	}
+
+	i2c_set_clientdata(client, priv);
+
+	fwnode_for_each_available_child_node(np, child) {
+		struct bd2606mvv_led *led;
+
+		err = fwnode_property_read_u32(child, "reg", &reg);
+		if (err) {
+			fwnode_handle_put(child);
+			return err;
+		}
+		if (reg < 0 || reg >= BD2606_MAX_LEDS || led_fwnodes[reg]) {
+			fwnode_handle_put(child);
+			return -EINVAL;
+		}
+		led = &priv->leds[reg];
+		led_fwnodes[reg] = child;
+		active_pairs[reg / 2]++;
+		led->priv = priv;
+		led->led_no = reg;
+		led->ldev.brightness_set_blocking = bd2606mvv_brightness_set;
+		led->ldev.max_brightness = BD2606_MAX_BRIGHTNESS;
+	}
+
+	for (i = 0; i < BD2606_MAX_LEDS; i++) {
+		struct led_init_data init_data = {};
+
+		if (!led_fwnodes[i])
+			continue;
+
+		init_data.fwnode = led_fwnodes[i];
+		/* Check whether brightness can be independently adjusted. */
+		if (active_pairs[i / 2] == 2)
+			priv->leds[i].ldev.max_brightness = 1;
+
+		err = devm_led_classdev_register_ext(dev,
+						     &priv->leds[i].ldev,
+						     &init_data);
+		if (err < 0) {
+			fwnode_handle_put(child);
+			return dev_err_probe(dev, err,
+					     "couldn't register LED %s\n",
+					     priv->leds[i].ldev.name);
+		}
+	}
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused of_bd2606mvv_leds_match[] = {
+	{ .compatible = "rohm,bd2606mvv", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_bd2606mvv_leds_match);
+
+static struct i2c_driver bd2606mvv_driver = {
+	.driver   = {
+		.name    = "leds-bd2606mvv",
+		.of_match_table = of_match_ptr(of_bd2606mvv_leds_match),
+	},
+	.probe_new = bd2606mvv_probe,
+};
+
+module_i2c_driver(bd2606mvv_driver);
+
+MODULE_AUTHOR("Andreas Kemnade <andreas@kemnade.info>");
+MODULE_DESCRIPTION("BD2606 LED driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

