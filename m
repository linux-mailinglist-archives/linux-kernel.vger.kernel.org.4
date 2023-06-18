Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6128F734600
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjFRLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFRLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:47:44 -0400
Received: from smtprelay05.ispgateway.de (smtprelay05.ispgateway.de [80.67.18.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED50FA;
        Sun, 18 Jun 2023 04:47:38 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1qAqs8-00070T-5U; Sun, 18 Jun 2023 13:47:08 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 18 Jun 2023 13:45:54 +0200
Subject: [PATCH 2/2] leds: add ktd202x driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230618-ktd202x-v1-2-fc182fefadd7@apitzsch.eu>
References: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
In-Reply-To: <20230618-ktd202x-v1-0-fc182fefadd7@apitzsch.eu>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.2
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for Kinetic KTD2026/7 RGB/White LED driver.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/leds/rgb/Kconfig        |  12 +
 drivers/leds/rgb/Makefile       |   1 +
 drivers/leds/rgb/leds-ktd202x.c | 610 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 623 insertions(+)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 360c8679c6e2..fa422e7a3f74 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -2,6 +2,18 @@
 
 if LEDS_CLASS_MULTICOLOR
 
+config LEDS_KTD202X
+	tristate "LED support for KTD202x Chips"
+	depends on I2C
+	depends on OF
+	select REGMAP_I2C
+	help
+	  This option enables support for LEDs connected to the KTD202x
+	  chip.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-ktd202x.
+
 config LEDS_PWM_MULTICOLOR
 	tristate "PWM driven multi-color LED Support"
 	depends on PWM
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 8c01daf63f61..5b4f22e077c0 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_LEDS_KTD202X)		+= leds-ktd202x.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
 obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
new file mode 100644
index 000000000000..4f0cc558c797
--- /dev/null
+++ b/drivers/leds/rgb/leds-ktd202x.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Driver for Kinetic KTD2026/7 RGB/White LED driver
+
+#include <linux/i2c.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define KTD202X_MAX_LEDS 4
+
+#define KTD202X_REG_RESET_CONTROL	0x00
+#define KTD202X_REG_FLASH_PERIOD	0x01
+#define KTD202X_REG_PWM1_TIMER		0x02
+#define KTD202X_REG_PWM2_TIMER		0x03
+#define KTD202X_REG_CHANNEL_CTRL	0x04
+#define KTD202X_REG_TRISE_FALL		0x05
+#define KTD202X_REG_LED_IOUT(x)		(0x06 + (x))
+
+#define KTD202X_RSTR_RESET 0x07
+
+#define KTD202X_ENABLE_CTRL_WAKE 0x00 /* SCL & SDA High */
+#define KTD202X_ENABLE_CTRL_SLEEP 0x08 /* SCL=High & SDA Toggling */
+
+#define KTD202X_CHANNEL_CTRL_MASK(x) (BIT(2 * (x)) | BIT(2 * (x) + 1))
+#define KTD202X_CHANNEL_CTRL_OFF 0
+#define KTD202X_CHANNEL_CTRL_ON(x) BIT(2 * (x))
+#define KTD202X_CHANNEL_CTRL_PWM1(x) BIT(2 * (x) + 1)
+#define KTD202X_CHANNEL_CTRL_PWM2(x) (BIT(2 * (x)) | BIT(2 * (x) + 1))
+
+#define KTD202X_TIME_MIN 256 /* ms */
+#define KTD202X_TIME_STEP 128 /* ms */
+#define KTD202X_ON_MAX 256
+
+static const struct reg_default ktd202x_reg_defaults[] = {
+	{ KTD202X_REG_RESET_CONTROL, 0x00 },
+	{ KTD202X_REG_FLASH_PERIOD, 0x00 },
+	{ KTD202X_REG_PWM1_TIMER, 0x01 },
+	{ KTD202X_REG_PWM2_TIMER, 0x01 },
+	{ KTD202X_REG_CHANNEL_CTRL, 0x00 },
+	{ KTD202X_REG_TRISE_FALL, 0x00 },
+	{ KTD202X_REG_LED_IOUT(0), 0x4f },
+	{ KTD202X_REG_LED_IOUT(1), 0x4f },
+	{ KTD202X_REG_LED_IOUT(2), 0x4f },
+	{ KTD202X_REG_LED_IOUT(3), 0x4f },
+};
+
+struct ktd202x;
+
+struct ktd202x_led {
+	struct ktd202x *chip;
+	union {
+		struct led_classdev cdev;
+		struct led_classdev_mc mcdev;
+	};
+	u32 index;
+};
+
+struct ktd202x {
+	struct mutex mutex; /* held when writing to registers */
+	struct regulator *vin_regulator;
+	struct device *dev;
+	struct regmap *regmap;
+	bool enabled;
+	int num_leds;
+	struct ktd202x_led leds[KTD202X_MAX_LEDS];
+};
+
+struct ktd202x_info {
+	unsigned int num_leds;
+};
+
+static const struct ktd202x_info ktd2026 = {
+	.num_leds = 3,
+};
+
+static const struct ktd202x_info ktd2027 = {
+	.num_leds = 4,
+};
+
+static int ktd202x_chip_init(struct ktd202x *chip)
+{
+	int ret;
+
+	ret = regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL,
+			   KTD202X_ENABLE_CTRL_WAKE);
+
+	if (ret) {
+		dev_err(chip->dev, "Failed to enable the chip: %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void ktd202x_chip_disable(struct ktd202x *chip)
+{
+	int ret;
+
+	if (!chip->enabled)
+		return;
+
+	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL,
+		     KTD202X_ENABLE_CTRL_SLEEP);
+
+	ret = regulator_disable(chip->vin_regulator);
+	if (ret) {
+		dev_err(chip->dev, "Failed to disable regulator: %d\n", ret);
+		return;
+	}
+
+	chip->enabled = false;
+}
+
+static int ktd202x_chip_enable(struct ktd202x *chip)
+{
+	int ret;
+
+	if (chip->enabled)
+		return 0;
+
+	ret = regulator_enable(chip->vin_regulator);
+	if (ret) {
+		dev_err(chip->dev, "Failed to enable regulator: %d\n", ret);
+		return ret;
+	}
+	chip->enabled = true;
+
+	ret = ktd202x_chip_init(chip);
+	if (ret)
+		ktd202x_chip_disable(chip);
+
+	return ret;
+}
+
+static bool ktd202x_chip_in_use(struct ktd202x *chip)
+{
+	int i;
+
+	if (chip->num_leds == 1) {
+		if (chip->leds[0].mcdev.led_cdev.brightness)
+			return true;
+	} else {
+		for (i = 0; i < chip->num_leds; i++)
+			if (chip->leds[i].cdev.brightness)
+				return true;
+	}
+	return false;
+}
+
+static void ktd202x_brightness_set(struct ktd202x_led *led, struct led_classdev *cdev,
+				   struct mc_subled *subleds, unsigned int num_colors)
+{
+	enum led_brightness brightness;
+	int idx;
+	int ret;
+	int i;
+
+	if (ktd202x_chip_in_use(led->chip)) {
+		ret = ktd202x_chip_enable(led->chip);
+		if (ret)
+			return;
+	}
+
+	for (i = 0; i < num_colors; i++) {
+		idx = subleds[i].channel;
+		brightness = subleds[i].brightness;
+
+		ret = regmap_write(led->chip->regmap, KTD202X_REG_LED_IOUT(idx),
+				   brightness ? brightness-1 : 0);
+		if (ret)
+			return;
+
+		if (brightness) {
+			ret = regmap_update_bits(led->chip->regmap,
+						 KTD202X_REG_CHANNEL_CTRL,
+						 KTD202X_CHANNEL_CTRL_MASK(idx),
+						 KTD202X_CHANNEL_CTRL_ON(idx));
+		} else {
+			ret = regmap_update_bits(led->chip->regmap,
+						 KTD202X_REG_CHANNEL_CTRL,
+						 KTD202X_CHANNEL_CTRL_MASK(idx),
+						 KTD202X_CHANNEL_CTRL_OFF);
+		}
+		if (ret)
+			return;
+	}
+
+	if (!ktd202x_chip_in_use(led->chip))
+		ktd202x_chip_disable(led->chip);
+}
+
+static int ktd202x_brightness_single_set(struct led_classdev *cdev,
+					 enum led_brightness value)
+{
+	struct ktd202x_led *led = container_of(cdev, struct ktd202x_led, cdev);
+	struct mc_subled info;
+	int num_channels = 1;
+
+	mutex_lock(&led->chip->mutex);
+
+	info.brightness = value;
+	info.channel = led->index;
+	ktd202x_brightness_set(led, cdev, &info, num_channels);
+
+	mutex_unlock(&led->chip->mutex);
+
+	return 0;
+}
+
+static int ktd202x_brightness_mc_set(struct led_classdev *cdev,
+				     enum led_brightness value)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct ktd202x_led *led = container_of(mc, struct ktd202x_led, mcdev);
+
+	mutex_lock(&led->chip->mutex);
+
+	led_mc_calc_color_components(mc, value);
+	ktd202x_brightness_set(led, cdev, mc->subled_info, mc->num_colors);
+
+	mutex_unlock(&led->chip->mutex);
+
+	return 0;
+}
+
+static int ktd202x_blink_set(struct ktd202x_led *led, struct led_classdev *cdev,
+			     unsigned long *delay_on, unsigned long *delay_off,
+			     u8 ctrl_mask, u8 ctrl_on, u8 ctrl_pwm1)
+{
+	unsigned long delay_total; /* ms */
+	int ret, num_steps, on;
+
+	/* Never off - brightness is already set, disable blinking */
+	if (!*delay_off) {
+		ret = regmap_update_bits(led->chip->regmap,
+					 KTD202X_REG_CHANNEL_CTRL,
+					 ctrl_mask,
+					 ctrl_on);
+		return ret;
+	}
+
+	/* Convert into values the HW will understand. */
+	num_steps = (*delay_on + *delay_off - KTD202X_TIME_MIN) /
+		    KTD202X_TIME_STEP + 1;
+	num_steps = min(126, num_steps);
+	on = (*delay_on * KTD202X_ON_MAX) / (*delay_on + *delay_off);
+
+	delay_total = num_steps * KTD202X_TIME_STEP + KTD202X_TIME_MIN;
+	*delay_on = (delay_total * on) / KTD202X_ON_MAX;
+	*delay_off = delay_total - *delay_on;
+
+	/* Set timings */
+	ret = regmap_write(led->chip->regmap, KTD202X_REG_FLASH_PERIOD,
+			   num_steps);
+	if (ret)
+		return ret;
+	ret = regmap_write(led->chip->regmap, KTD202X_REG_PWM1_TIMER, on);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(led->chip->regmap, KTD202X_REG_CHANNEL_CTRL,
+				 ctrl_mask,
+				 ctrl_pwm1);
+	return ret;
+}
+
+static int ktd202x_blink_single_set(struct led_classdev *cdev,
+				    unsigned long *delay_on,
+				    unsigned long *delay_off)
+{
+	struct ktd202x_led *led = container_of(cdev, struct ktd202x_led, cdev);
+	struct led_classdev *lcdev;
+	int index, ret;
+	u8 ctrl_mask;
+	u8 ctrl_on;
+	u8 ctrl_pwm1;
+
+	lcdev = &led->cdev;
+
+	/* If no blink specified, default to 1 Hz. */
+	if (!*delay_off && !*delay_on) {
+		*delay_off = 500;
+		*delay_on = 500;
+	}
+
+	if (!lcdev->brightness) {
+		lcdev->brightness = LED_FULL;
+		ret = ktd202x_brightness_single_set(lcdev, lcdev->brightness);
+		if (ret)
+			return ret;
+	}
+
+	/* Never on - just set to off */
+	if (!*delay_on) {
+		lcdev->brightness = LED_OFF;
+		return ktd202x_brightness_single_set(lcdev, LED_OFF);
+	}
+
+	index = led->index;
+	ctrl_mask = KTD202X_CHANNEL_CTRL_MASK(index);
+	ctrl_on = KTD202X_CHANNEL_CTRL_ON(index);
+	ctrl_pwm1 = KTD202X_CHANNEL_CTRL_PWM1(index);
+
+	mutex_lock(&led->chip->mutex);
+
+	ret = ktd202x_blink_set(led, lcdev, delay_on, delay_off, ctrl_mask,
+				ctrl_on, ctrl_pwm1);
+
+	mutex_unlock(&led->chip->mutex);
+
+	return ret;
+}
+
+static int ktd202x_blink_mc_set(struct led_classdev *cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct ktd202x_led *led = container_of(mc, struct ktd202x_led, mcdev);
+	struct led_classdev *lcdev;
+	u8 ctrl_mask = 0;
+	u8 ctrl_on = 0;
+	u8 ctrl_pwm1 = 0;
+	int ret, i;
+
+	lcdev = &led->mcdev.led_cdev;
+
+	/* If no blink specified, default to 1 Hz. */
+	if (!*delay_off && !*delay_on) {
+		*delay_off = 500;
+		*delay_on = 500;
+	}
+
+	if (!lcdev->brightness) {
+		lcdev->brightness = LED_FULL;
+		ret = ktd202x_brightness_mc_set(lcdev, lcdev->brightness);
+		if (ret)
+			return ret;
+	}
+
+	/* Never on - just set to off */
+	if (!*delay_on) {
+		lcdev->brightness = LED_OFF;
+		return ktd202x_brightness_mc_set(lcdev, LED_OFF);
+	}
+
+	for (i = 0; i < mc->num_colors; i++) {
+		int index = mc->subled_info[i].channel;
+
+		ctrl_mask |= KTD202X_CHANNEL_CTRL_MASK(index);
+		ctrl_on |= KTD202X_CHANNEL_CTRL_ON(index);
+		ctrl_pwm1 |= KTD202X_CHANNEL_CTRL_PWM1(index);
+	}
+
+	mutex_lock(&led->chip->mutex);
+
+	ret = ktd202x_blink_set(led, lcdev, delay_on, delay_off, ctrl_mask,
+				ctrl_on, ctrl_pwm1);
+
+	mutex_unlock(&led->chip->mutex);
+
+	return ret;
+}
+
+static int ktd202x_add_led(struct ktd202x *chip, struct device_node *np,
+			   unsigned int index)
+{
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct device_node *child;
+	struct mc_subled *info;
+	struct ktd202x_led *led = &chip->leds[index];
+	int num_channels;
+	u32 color = 0;
+	u32 reg;
+	int ret;
+	int i;
+
+	ret = of_property_read_u32(np, "color", &color);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(chip->dev, "failed to parse \"color\" of %pOF\n", np);
+		return ret;
+	}
+
+	if (color == LED_COLOR_ID_RGB) {
+		num_channels = of_get_available_child_count(np);
+		if (!num_channels || num_channels > chip->num_leds)
+			return -EINVAL;
+	} else {
+		num_channels = 1;
+	}
+
+	led->chip = chip;
+
+	if (color == LED_COLOR_ID_RGB) {
+		info = devm_kcalloc(chip->dev, num_channels, sizeof(*info),
+				    GFP_KERNEL);
+		if (!info)
+			return -ENOMEM;
+
+		i = 0;
+		for_each_available_child_of_node(np, child) {
+			u32 color = 0;
+
+			ret = of_property_read_u32(child, "reg", &reg);
+			if (ret != 0 || reg >= chip->num_leds) {
+				dev_err(chip->dev, "invalid \"reg\" of %pOFn\n",
+					np);
+				return -EINVAL;
+			}
+
+			ret = of_property_read_u32(child, "color", &color);
+			if (ret < 0 && ret != -EINVAL) {
+				dev_err(chip->dev,
+					"failed to parse \"color\" of %pOF\n",
+					np);
+				return ret;
+			}
+
+			info[i].color_index = color;
+			info[i].channel = reg;
+			info[i].intensity = 0;
+			i++;
+		}
+
+		led->mcdev.subled_info = info;
+		led->mcdev.num_colors = num_channels;
+
+		cdev = &led->mcdev.led_cdev;
+		cdev->brightness_set_blocking = ktd202x_brightness_mc_set;
+		cdev->blink_set = ktd202x_blink_mc_set;
+	} else {
+		ret = of_property_read_u32(np, "reg", &reg);
+		if (ret != 0 || reg >= chip->num_leds) {
+			dev_err(chip->dev, "invalid \"reg\" of %pOFn\n", np);
+			return -EINVAL;
+		}
+		led->index = reg;
+
+		cdev = &led->cdev;
+		cdev->brightness_set_blocking = ktd202x_brightness_single_set;
+		cdev->blink_set = ktd202x_blink_single_set;
+	}
+
+	cdev->max_brightness = 192;
+
+	init_data.fwnode = of_fwnode_handle(np);
+
+	if (color == LED_COLOR_ID_RGB)
+		ret = devm_led_classdev_multicolor_register_ext(chip->dev,
+								&led->mcdev,
+								&init_data);
+	else
+		ret = devm_led_classdev_register_ext(chip->dev, &led->cdev,
+						     &init_data);
+	if (ret) {
+		dev_err(chip->dev, "unable to register %s\n", cdev->name);
+		of_node_put(np);
+	}
+
+	return ret;
+}
+
+static int ktd202x_probe_dt(struct ktd202x *chip)
+{
+	struct device_node *np = dev_of_node(chip->dev), *child;
+	const struct ktd202x_info *ktd202x;
+	unsigned int i;
+	int count, ret;
+
+	ktd202x = of_device_get_match_data(chip->dev);
+	if (!ktd202x)
+		return -ENODEV;
+
+	chip->num_leds = ktd202x->num_leds;
+
+	count = of_get_available_child_count(np);
+	if (!count || count > ktd202x->num_leds)
+		return -EINVAL;
+
+	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL,
+		     KTD202X_RSTR_RESET);
+	/* allow the device to execute the complete reset */
+	usleep_range(200, 300);
+
+	i = 0;
+	for_each_available_child_of_node(np, child) {
+		ret = ktd202x_add_led(chip, child, i);
+		if (ret)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct regmap_config ktd202x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x09,
+	.cache_type = REGCACHE_FLAT,
+	.reg_defaults = ktd202x_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(ktd202x_reg_defaults),
+};
+
+static int ktd202x_probe(struct i2c_client *client)
+{
+	struct ktd202x *chip;
+	int ret;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	mutex_init(&chip->mutex);
+	mutex_lock(&chip->mutex);
+
+	chip->dev = &client->dev;
+	i2c_set_clientdata(client, chip);
+
+	chip->regmap = devm_regmap_init_i2c(client, &ktd202x_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
+				    "Failed to allocate register map.\n");
+		goto error;
+	}
+
+	chip->vin_regulator = devm_regulator_get(&client->dev, "vin");
+	ret = PTR_ERR_OR_ZERO(chip->vin_regulator);
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			      "Failed to request regulator.\n");
+		goto error;
+	}
+
+	ret = regulator_enable(chip->vin_regulator);
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			      "Failed to enable regulator.\n");
+		goto error;
+	}
+
+	ret = ktd202x_probe_dt(chip);
+	if (ret < 0)
+		goto error_reg;
+
+	ret = regulator_disable(chip->vin_regulator);
+	if (ret) {
+		dev_err_probe(&client->dev, ret,
+			      "Failed to disable regulator.\n");
+		goto error;
+	}
+
+	mutex_unlock(&chip->mutex);
+
+	return 0;
+
+error_reg:
+	regulator_disable(chip->vin_regulator);
+
+error:
+	mutex_destroy(&chip->mutex);
+	return ret;
+}
+
+static void ktd202x_remove(struct i2c_client *client)
+{
+	struct ktd202x *chip = i2c_get_clientdata(client);
+
+	ktd202x_chip_disable(chip);
+
+	mutex_destroy(&chip->mutex);
+}
+
+static void ktd202x_shutdown(struct i2c_client *client)
+{
+	struct ktd202x *chip = i2c_get_clientdata(client);
+
+	/* Reset registers to make sure all off before shutdown */
+	regmap_write(chip->regmap, KTD202X_REG_RESET_CONTROL,
+		     KTD202X_RSTR_RESET);
+}
+
+static const struct of_device_id ktd202x_match_table[] = {
+	{ .compatible = "kinetic,ktd2026", .data = &ktd2026 },
+	{ .compatible = "kinetic,ktd2027", .data = &ktd2027 },
+	{ /* sentinel */ },
+};
+
+MODULE_DEVICE_TABLE(of, ktd202x_match_table);
+
+static struct i2c_driver ktd202x_driver = {
+	.driver = {
+		.name = "leds-ktd202x",
+		.of_match_table = of_match_ptr(ktd202x_match_table),
+	},
+	.probe_new = ktd202x_probe,
+	.remove = ktd202x_remove,
+	.shutdown = ktd202x_shutdown,
+};
+
+module_i2c_driver(ktd202x_driver);
+
+MODULE_AUTHOR("André Apitzsch <git@apitzsch.eu>");
+MODULE_DESCRIPTION("Kinetic KTD2026/7 LED driver");
+MODULE_LICENSE("GPL");

-- 
2.41.0

