Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE963FF31
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbiLBDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiLBDn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:43:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E2A554A;
        Thu,  1 Dec 2022 19:43:23 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q1so3358672pgl.11;
        Thu, 01 Dec 2022 19:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QAi8Caord9mLKor0viB6nvfRqG/6jsMMSTIQ4z6um4=;
        b=ipBezcTpvd7O+lizQAa1YmL7gX621c9mIk2lYJUQOm3f1/Ynzp8wSmo0JJLgEPuVGe
         4jUUt3nf0jYh2fc0OA4yJY8Jjum5uYMvpj4WIKuIwE8Q3ARKdGaYsDvp0pIuJFNBaKEN
         ohvw+d+zpG7Te8IVNRRm5lAgn5/5nfssMH+RXitx/xnljmNJSUURvVxC92d0vAHzj/Mo
         0Xu6MP2tZurjlzqDA8vUAMMUWZ8n+zhEUbn/CFmeHa0TLwnA6stzjcf3LhBI9cy64h8i
         030zp9AUdW/qr+eM4jQ6KaQ8owR45P5xiI6kd5pdJPFG0FoefFBWTQoMgGM5XeWJreGo
         +s2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QAi8Caord9mLKor0viB6nvfRqG/6jsMMSTIQ4z6um4=;
        b=uoyb0TqVPzdLDEBP0pf1BSiHjlqdMG9O65G7mZ34r79kH8vEff6Y+4xg9ecH8bIOQX
         vbqdZftvUnX/siu2PFSqE9YF5Dgrw/b3KhlPcWRXArm62q+g7MW2vYEyhq6oXiUf6UUE
         uthUO8NqkWuKeYTf5TJZuFH1dRVvI2GD0+sUwqRHQ4z+jQUz2Fy/u6Qp53rii82JsaeA
         8GLAhxuufn0uoUHevl8RDIy6g8f4Zjj3MyoH+O0D8sbxwMuSxRCuW41pcwb8smWbtsjw
         03jsaWajeCgBuJgLwMwfJ2JWshedwGhI+x2RDVPmnczpW94cUvqLRvVxl0bShNHaGN70
         Kshw==
X-Gm-Message-State: ANoB5pkUjcvk+pMfcd6KuFD8syK5fzIf2o9J9saCj/uRvgtdFOSqh0Lg
        3l4e7o9yDhdVQelfvaqLGSaydDU3X08=
X-Google-Smtp-Source: AA0mqf7+8ZlRiWrKwilE58Phpp0CbwlfRLUd1hkUylbCqtMN4JT5YAuy82vfjdo/8tUVV/UGdObPYw==
X-Received: by 2002:a65:6753:0:b0:477:91c5:f9ff with SMTP id c19-20020a656753000000b0047791c5f9ffmr43531832pgu.403.1669952602631;
        Thu, 01 Dec 2022 19:43:22 -0800 (PST)
Received: from guoguo-omen.scut.edu.cn ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b0017f59ebafe7sm4370636plg.212.2022.12.01.19.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:43:22 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Fri,  2 Dec 2022 11:42:40 +0800
Message-Id: <20221202034240.455831-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202034240.455831-1-gch981213@gmail.com>
References: <20221202034240.455831-1-gch981213@gmail.com>
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

This patch adds support for driving a chain of WS2812B LED chips
using SPI bus.

WorldSemi WS2812B is a individually addressable LED chip that
can be chained together and controlled individually using a
single wire. The chip recognize a long pulse as a bit of 1 and
a short pulse as a bit of 0. Host sends a continuous stream
of 24-bits color values, each LED chip takes the first 3 byte
it receives as its color value and passes the leftover bytes to
the next LED on the chain.

This driver simulates this protocol using SPI bus by sending
a long pulse as 3'b110 and a short pulse as 3'b100. The SPI
frequency needs to be 2.105MHz~2.85MHz for the timing to be
correct and the controller needs to transfer all the bytes
continuously.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1:
rename the driver to drop -spi suffix
add support for default-brightness
use fwnode apis for properties

 drivers/leds/rgb/Kconfig        |  11 ++
 drivers/leds/rgb/Makefile       |   1 +
 drivers/leds/rgb/leds-ws2812b.c | 235 ++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-ws2812b.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 204cf470beae..5c2081852f01 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -26,4 +26,15 @@ config LEDS_QCOM_LPG
 
 	  If compiled as a module, the module will be named leds-qcom-lpg.
 
+config LEDS_WS2812B
+	tristate "SPI driven WS2812B RGB LED support"
+	depends on OF
+	depends on SPI
+	help
+	  This option enables support for driving daisy-chained WS2812B RGB
+	  LED chips using SPI bus. This driver simulates the single-wire
+	  protocol by sending bits over the SPI MOSI pin. For this to work,
+	  the SPI frequency should be 2.105MHz~2.85MHz and the controller
+	  needs to transfer all the bytes continuously.
+
 endif # LEDS_CLASS_MULTICOLOR
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 0675bc0f6e18..a6f855eaeb14 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
+obj-$(CONFIG_LEDS_WS2812B)		+= leds-ws2812b.o
diff --git a/drivers/leds/rgb/leds-ws2812b.c b/drivers/leds/rgb/leds-ws2812b.c
new file mode 100644
index 000000000000..ca2ae83de573
--- /dev/null
+++ b/drivers/leds/rgb/leds-ws2812b.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * WorldSemi WS2812B individually-addressable LED driver using SPI
+ *
+ * Copyright 2022 Chuanhong Guo <gch981213@gmail.com>
+ *
+ * This driver simulates WS2812B protocol using SPI MOSI pin. A one pulse
+ * is transferred as 3'b110 and a zero pulse is 3'b100. For this driver to
+ * work properly, the SPI frequency should be 2.105MHz~2.85MHz and it needs
+ * to transfer all the bytes continuously.
+ */
+
+#include <linux/led-class-multicolor.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+#include <linux/mutex.h>
+
+#define WS2812B_BYTES_PER_COLOR 3
+#define WS2812B_NUM_COLORS 3
+#define WS2812B_RESET_LEN 18
+
+struct ws2812b_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled[WS2812B_NUM_COLORS];
+	struct ws2812b_priv *priv;
+	int reg;
+};
+
+struct ws2812b_priv {
+	struct led_classdev ldev;
+	struct spi_device *spi;
+	struct mutex mutex;
+	int num_leds;
+	size_t data_len;
+	u8 *data_buf;
+	struct ws2812b_led leds[];
+};
+
+static void ws2812b_set_byte(u8 *p, u8 val)
+{
+	/*
+	 * Every bit of data is represented using 3 bits: 3'b100 for
+	 * 0 and 3'b110 for 1.
+	 * 1 byte of data takes up 3 bytes in a SPI transfer. The higher
+	 * 3 bits, middle 2 bits and lower 3 bits are represented
+	 * with the 1st, 2nd and 3rd byte in the SPI transfer.
+	 * Here's the lookup table for them.
+	 */
+	const u8 h3b[] = { 0x92, 0x93, 0x9a, 0x9b, 0xd2, 0xd3, 0xda, 0xdb };
+	const u8 m2b[] = { 0x49, 0x4d, 0x69, 0x6d };
+	const u8 l3b[] = { 0x24, 0x26, 0x34, 0x36, 0xa4, 0xa6, 0xb4, 0xb6 };
+
+	p[0] = h3b[val >> 5];
+	p[1] = m2b[(val >> 3) & 0x3];
+	p[2] = l3b[val & 0x7];
+}
+
+static int ws2812b_set(struct led_classdev *cdev,
+		       enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct ws2812b_led *led =
+		container_of(mc_cdev, struct ws2812b_led, mc_cdev);
+	struct ws2812b_priv *priv = led->priv;
+	u8 *buf = priv->data_buf + WS2812B_RESET_LEN +
+		  led->reg * WS2812B_NUM_COLORS * WS2812B_BYTES_PER_COLOR;
+	int ret = 0;
+	int i;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	mutex_lock(&priv->mutex);
+	for (i = 0; i < WS2812B_NUM_COLORS; i++)
+		ws2812b_set_byte(buf + i * WS2812B_BYTES_PER_COLOR,
+				 led->subled[i].brightness);
+	ret = spi_write(priv->spi, priv->data_buf, priv->data_len);
+	mutex_unlock(&priv->mutex);
+
+	return ret;
+}
+
+static int ws2812b_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	int ret = 0, cur_led = 0;
+	struct ws2812b_priv *priv;
+	struct fwnode_handle *led_node;
+	int num_leds, i, cnt;
+
+	num_leds = device_get_child_node_count(dev);
+
+	priv = devm_kzalloc(dev, struct_size(priv, leds, num_leds), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->data_len =
+		num_leds * WS2812B_BYTES_PER_COLOR * WS2812B_NUM_COLORS +
+		WS2812B_RESET_LEN;
+	priv->data_buf = kzalloc(priv->data_len, GFP_KERNEL);
+	if (!priv->data_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_leds * WS2812B_NUM_COLORS; i++)
+		ws2812b_set_byte(priv->data_buf + WS2812B_RESET_LEN +
+					 i * WS2812B_BYTES_PER_COLOR,
+				 0);
+
+	mutex_init(&priv->mutex);
+	priv->num_leds = num_leds;
+	priv->spi = spi;
+
+	device_for_each_child_node(dev, led_node) {
+		u32 reg = -1;
+		struct led_init_data init_data = {
+			.fwnode = led_node,
+		};
+		/* WS2812B LEDs usually come with GRB color */
+		u32 color_idx[WS2812B_NUM_COLORS] = {
+			LED_COLOR_ID_GREEN,
+			LED_COLOR_ID_RED,
+			LED_COLOR_ID_BLUE,
+		};
+		u32 default_intensity[WS2812B_NUM_COLORS] = { 255, 255, 255 };
+		u32 default_brightness = 0;
+
+		ret = fwnode_property_read_u32(led_node, "reg", &reg);
+		if (ret) {
+			dev_err(dev, "failed to get reg of the %dth led.",
+				cur_led);
+			goto ERR_UNREG_LEDS;
+		}
+		if (reg >= num_leds) {
+			dev_err(dev, "reg of the %dth led is too big.",
+				cur_led);
+			ret = -EINVAL;
+			goto ERR_UNREG_LEDS;
+		}
+
+		cnt = fwnode_property_count_u32(led_node, "color-index");
+		if (cnt > 0 && cnt <= WS2812B_NUM_COLORS)
+			fwnode_property_read_u32_array(led_node, "color-index",
+						       color_idx, (size_t)cnt);
+		cnt = fwnode_property_count_u32(led_node, "default-intensity");
+		if (cnt > 0 && cnt <= WS2812B_NUM_COLORS)
+			fwnode_property_read_u32_array(led_node,
+						       "default-intensity",
+						       default_intensity,
+						       (size_t)cnt);
+		fwnode_property_read_u32(led_node, "default-brightness",
+					 &default_brightness);
+
+		priv->leds[cur_led].mc_cdev.subled_info =
+			priv->leds[cur_led].subled;
+		priv->leds[cur_led].mc_cdev.num_colors = WS2812B_NUM_COLORS;
+		priv->leds[cur_led].mc_cdev.led_cdev.brightness =
+			default_brightness;
+		priv->leds[cur_led].mc_cdev.led_cdev.max_brightness = 255;
+		priv->leds[cur_led].mc_cdev.led_cdev.brightness_set_blocking =
+			ws2812b_set;
+
+		for (i = 0; i < WS2812B_NUM_COLORS; i++) {
+			priv->leds[cur_led].subled[i].color_index =
+				color_idx[i];
+			priv->leds[cur_led].subled[i].intensity =
+				default_intensity[i];
+		}
+
+		priv->leds[cur_led].priv = priv;
+		priv->leds[cur_led].reg = reg;
+
+		ws2812b_set(&priv->leds[cur_led].mc_cdev.led_cdev,
+			    default_brightness);
+
+		ret = led_classdev_multicolor_register_ext(
+			dev, &priv->leds[cur_led].mc_cdev, &init_data);
+		if (ret) {
+			dev_err(dev, "registration of led@%d failed.", reg);
+			goto ERR_UNREG_LEDS;
+		}
+		cur_led++;
+	}
+
+	spi_set_drvdata(spi, priv);
+
+	return 0;
+ERR_UNREG_LEDS:
+	for (; cur_led >= 0; cur_led--)
+		led_classdev_multicolor_unregister(
+			&priv->leds[cur_led].mc_cdev);
+	mutex_destroy(&priv->mutex);
+	kfree(priv->data_buf);
+	return ret;
+}
+
+static void ws2812b_remove(struct spi_device *spi)
+{
+	struct ws2812b_priv *priv = spi_get_drvdata(spi);
+	int cur_led;
+
+	for (cur_led = priv->num_leds - 1; cur_led >= 0; cur_led--)
+		led_classdev_multicolor_unregister(
+			&priv->leds[cur_led].mc_cdev);
+	kfree(priv->data_buf);
+	mutex_destroy(&priv->mutex);
+}
+
+static const struct spi_device_id ws2812b_spi_ids[] = {
+	{ "ws2812b" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, ws2812b_spi_ids);
+
+static const struct of_device_id ws2812b_dt_ids[] = {
+	{ .compatible = "worldsemi,ws2812b" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ws2812b_dt_ids);
+
+static struct spi_driver ws2812b_driver = {
+	.probe		= ws2812b_probe,
+	.remove		= ws2812b_remove,
+	.id_table	= ws2812b_spi_ids,
+	.driver = {
+		.name		= KBUILD_MODNAME,
+		.of_match_table	= ws2812b_dt_ids,
+	},
+};
+
+module_spi_driver(ws2812b_driver);
+
+MODULE_AUTHOR("Chuanhong Guo <gch981213@gmail.com>");
+MODULE_DESCRIPTION("WS2812B LED driver using SPI");
+MODULE_LICENSE("GPL");
-- 
2.38.1

