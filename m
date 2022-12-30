Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99265318F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLUNTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiLUNTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:19:00 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB19205C7;
        Wed, 21 Dec 2022 05:18:58 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id x66so10673432pfx.3;
        Wed, 21 Dec 2022 05:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DriSRwCP3ggEVceguuPjWSqJlvi6Le2y23PSrVSIc6A=;
        b=i8CdrHruEyO26MA6OZEAlAqYhbmSI7rh9RDteCSKwED17marKImYToVCCQcIN0V1zx
         PVY/jRmQp3YKUuhApRTRNCe58NPXbtV3UVHFZzBPGrM+7zqI9PheBY8gpjQh/vwVsf7+
         anuIbJvJ2k9NqtA4UC7/k166XJzqfC04baiH9XOJyKQGBU6I1hEofLmyrQ/GFleWAXpk
         b5nRbpJCtG0gnBcO5OD+D2GN3TwRwAdNxlWJQz6olxvVa07K61agNn16QhsHQ9KH1+jX
         pCRVaVpP6PygR9FHGHVQUbAnLiDdjwb3UsIzgQB6lU4dccyFPcTHAHbvuvDtxeuwhgPn
         Jkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DriSRwCP3ggEVceguuPjWSqJlvi6Le2y23PSrVSIc6A=;
        b=bSAAE471BQTycgxlv9+kA8cTkZ4wClO9Yqo1jyvr2djN11T4OSJp3DQEfm4T1mpJtH
         DslcFi86U+75VjCFy+uUtCfjFs4rSW5qB/gmOz6jSFWP5mvTHowfON/XtjuKTl0Z4DTp
         1df12oWgvNg0/IrDhMYglfPbRLhAUmov7pROJyrlXHmpQVZD2sEqUBma2keJviHzGkj3
         dp9DBMJLycs6b8f0/j78rUbTcthFKUQBfZ0YrG5JeulKNqmSZXnasC/9VYeZwxJvwrj7
         iMjgkmnCKGiALcA2n116s/P5JCdWELkCpVWUz7lXe+XYxCgofdI2pXQ0w4wUZ7NBZSLE
         u2/Q==
X-Gm-Message-State: AFqh2krWSwWrpZWhYQiv6lbcLGhhaXq7Tkn//gretLlsin3whM+BtXa+
        ehT77fnNXP4se/ZkQKVMZRcBR3otXkhrExvr
X-Google-Smtp-Source: AMrXdXvUgucW2eElR7v3axe6MpjhP3/iuhGotxAcsEeVGK/R/v84SC4AtdYswO4K6Ko+RW2qp47vDg==
X-Received: by 2002:a62:1bc6:0:b0:56d:74bf:3256 with SMTP id b189-20020a621bc6000000b0056d74bf3256mr1903915pfb.22.1671628738303;
        Wed, 21 Dec 2022 05:18:58 -0800 (PST)
Received: from localhost.localdomain ([117.189.239.185])
        by smtp.gmail.com with ESMTPSA id w7-20020aa79a07000000b0056c2e497b02sm10866772pfj.173.2022.12.21.05.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 05:18:57 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [RESEND] backlight: ktz8866: Add support for Kinetic KTZ8866 backlight
Date:   Wed, 21 Dec 2022 21:18:43 +0800
Message-Id: <20221221131843.30438-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Kinetic KTZ8866 backlight, which is used in
Xiaomi tablet, Mi Pad 5 series. This driver lightly based on
downstream implementation [1].
[1] https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/elish-r-oss/drivers/video/backlight/ktz8866.c

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 drivers/video/backlight/Kconfig   |   8 ++
 drivers/video/backlight/Makefile  |   1 +
 drivers/video/backlight/ktz8866.c | 174 ++++++++++++++++++++++++++++++
 drivers/video/backlight/ktz8866.h |  31 ++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/video/backlight/ktz8866.c
 create mode 100644 drivers/video/backlight/ktz8866.h

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 936ba1e4d35e..2845fd7e33ad 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -190,6 +190,14 @@ config BACKLIGHT_KTD253
 	  which is a 1-wire GPIO-controlled backlight found in some mobile
 	  phones.
 
+config BACKLIGHT_KTZ8866
+	tristate "Backlight Driver for Kinetic KTZ8866"
+	depends on I2C
+	select REGMAP_I2C
+	help
+		Say Y to enabled the backlight driver for the Kinetic KTZ8866
+		found in Xiaomi Mi Pad 5 series.
+
 config BACKLIGHT_LM3533
 	tristate "Backlight Driver for LM3533"
 	depends on MFD_LM3533
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index e815f3f1deff..f70a819c304c 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
 obj-$(CONFIG_BACKLIGHT_IPAQ_MICRO)	+= ipaq_micro_bl.o
 obj-$(CONFIG_BACKLIGHT_KTD253)		+= ktd253-backlight.o
+obj-$(CONFIG_BACKLIGHT_KTZ8866)		+= ktz8866.o
 obj-$(CONFIG_BACKLIGHT_LM3533)		+= lm3533_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3630A)		+= lm3630a_bl.o
 obj-$(CONFIG_BACKLIGHT_LM3639)		+= lm3639_bl.o
diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
new file mode 100644
index 000000000000..a0ea6ebbda60
--- /dev/null
+++ b/drivers/video/backlight/ktz8866.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Backlight driver for the Kinetic KTZ8866
+ *
+ * Copyright (C) Jianhua Lu <lujianhua000@gmail.com>
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include "ktz8866.h"
+
+#define DEF_BRIGHTNESS 1500
+#define MAX_BRIGHTNESS 2047
+#define REG_MAX 0x15
+
+/* Helper */
+#define low_3_bit(x) ((x)&0x7)
+#define high_8_bit(x) ((x >> 3) & 0xFF)
+
+struct ktz8866 {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	bool state;
+};
+
+enum {
+	LED_OFF,
+	LED_ON,
+};
+
+static const struct regmap_config ktz8866_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+};
+
+static int ktz8866_write(struct ktz8866 *ktz, unsigned int reg,
+			 unsigned int val)
+{
+	return regmap_write(ktz->regmap, reg, val);
+}
+
+static int ktz8866_update_bits(struct ktz8866 *ktz, unsigned int reg,
+			       unsigned int mask, unsigned int val)
+{
+	return regmap_update_bits(ktz->regmap, reg, mask, val);
+}
+
+static int
+ktz8866_backlight_update_status(struct backlight_device *backlight_dev)
+{
+	struct ktz8866 *ktz = bl_get_data(backlight_dev);
+	unsigned int brightness = backlight_get_brightness(backlight_dev);
+
+	if (!ktz->state && brightness > 0) {
+		ktz8866_update_bits(ktz, BL_EN, BIT(6), BIT(6));
+		ktz->state = LED_ON;
+	} else if (brightness == 0) {
+		ktz8866_update_bits(ktz, BL_EN, BIT(6), 0);
+		ktz->state = LED_OFF;
+		msleep(10);
+	}
+
+	/* Set brightness */
+	ktz8866_write(ktz, BL_BRT_LSB, low_3_bit(brightness));
+	ktz8866_write(ktz, BL_BRT_MSB, high_8_bit(brightness));
+
+	return 0;
+}
+
+static const struct backlight_ops ktz8866_backlight_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = ktz8866_backlight_update_status,
+};
+
+static void ktz8866_init(struct ktz8866 *ktz)
+{
+	/* Enable 1~5 current sinks */
+	ktz8866_write(ktz, BL_EN, 0x1F);
+	/* Backlight OVP 26.4V */
+	ktz8866_write(ktz, BL_CFG1, 0x33);
+	/* LED ramping time 128ms */
+	ktz8866_write(ktz, BL_CFG2, 0xBD);
+	/* LED on/off ramping time 1ms */
+	ktz8866_write(ktz, BL_DIMMING, 0x11);
+	/* Enable OUTP and OUTN via pin ENP and ENN */
+	ktz8866_write(ktz, LCD_BIAS_CFG1, 0x9F);
+	/* Backlight Full-scale LED Current 30.0mA */
+	ktz8866_write(ktz, FULL_SCALE_CURRENT, 0xF9);
+}
+
+static int ktz8866_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct backlight_device *backlight_dev;
+	struct backlight_properties props;
+	struct ktz8866 *ktz;
+
+	ktz = devm_kzalloc(&client->dev, sizeof(*ktz), GFP_KERNEL);
+	if (!ktz)
+		return -ENOMEM;
+
+	ktz->client = client;
+	ktz->regmap = devm_regmap_init_i2c(client, &ktz8866_regmap_config);
+
+	if (IS_ERR(ktz->regmap)) {
+		dev_err(&client->dev, "failed to init regmap\n");
+		return PTR_ERR(ktz->regmap);
+	}
+
+	memset(&props, 0, sizeof(props));
+	props.type = BACKLIGHT_RAW;
+	props.max_brightness = MAX_BRIGHTNESS;
+	props.brightness =
+		clamp_t(unsigned int, DEF_BRIGHTNESS, 0, props.max_brightness);
+
+	backlight_dev = devm_backlight_device_register(
+		&client->dev, "ktz8866-backlight", &client->dev, ktz,
+		&ktz8866_backlight_ops, &props);
+
+	if (IS_ERR(backlight_dev)) {
+		dev_err(&client->dev, "failed to register backlight device\n");
+		return PTR_ERR(backlight_dev);
+	}
+
+	ktz8866_init(ktz);
+
+	i2c_set_clientdata(client, backlight_dev);
+	backlight_update_status(backlight_dev);
+
+	return 0;
+}
+
+static void ktz8866_remove(struct i2c_client *client)
+{
+	struct backlight_device *backlight_dev = i2c_get_clientdata(client);
+
+	backlight_dev->props.brightness = 0;
+	backlight_update_status(backlight_dev);
+}
+
+static const struct i2c_device_id ktz8866_ids[] = {
+	{ "ktz8866", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, ktz8866_ids);
+
+static const struct of_device_id ktz8866_match_table[] = {
+	{
+		.compatible = "kinetic,ktz8866",
+	},
+	{},
+};
+
+static struct i2c_driver ktz8866_driver = {
+	.driver = {
+		.name = "ktz8866",
+		.of_match_table = ktz8866_match_table,
+	},
+	.probe = ktz8866_probe,
+	.remove = ktz8866_remove,
+	.id_table = ktz8866_ids,
+};
+
+module_i2c_driver(ktz8866_driver);
+
+MODULE_DESCRIPTION("Kinetic KTZ8866 Backlight Driver");
+MODULE_AUTHOR("Jianhua Lu <lujianhua000@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/video/backlight/ktz8866.h b/drivers/video/backlight/ktz8866.h
new file mode 100644
index 000000000000..b2a606288a7e
--- /dev/null
+++ b/drivers/video/backlight/ktz8866.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Register definitions for Kinetic KTZ8866 backlight
+ *
+ * Copyright (C) Jianhua Lu <lujianhua000@gmail.com>
+ */
+
+#ifndef KTZ8866_H
+#define KTZ8866_H
+
+#define DEVICE_ID 0x01
+#define BL_CFG1 0x02
+#define BL_CFG2 0x03
+#define BL_BRT_LSB 0x04
+#define BL_BRT_MSB 0x05
+#define BL_EN 0x08
+#define LCD_BIAS_CFG1 0x09
+#define LCD_BIAS_CFG2 0x0A
+#define LCD_BIAS_CFG3 0x0B
+#define LCD_BOOST_CFG 0x0C
+#define OUTP_CFG 0x0D
+#define OUTN_CFG 0x0E
+#define FLAG 0x0F
+#define BL_OPTION1 0x10
+#define BL_OPTION2 0x11
+#define PWM2DIG_LSBs 0x12
+#define PWM2DIG_MSBs 0x13
+#define BL_DIMMING 0x14
+#define FULL_SCALE_CURRENT 0x15
+
+#endif /* KTZ8866_H */
-- 
2.38.2

