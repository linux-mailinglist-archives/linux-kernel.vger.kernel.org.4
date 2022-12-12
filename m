Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096AE649891
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 05:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLLE5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 23:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiLLE4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 23:56:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0198DF3E;
        Sun, 11 Dec 2022 20:56:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so10892356pjo.3;
        Sun, 11 Dec 2022 20:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ww/kIUj7rFU9UfXZFPnG3veXj7F0QvRe6SbpJGQVsK8=;
        b=EEmqzbe5K97vy7zEVE4M7bQddz/MotaYKqi4uwhapEw/CNx2EFtmWm8ITRkM36Pusp
         nDnc0PyK3wnOLWSAKJHUR8xbyijEeYN+0iPNrG8/4tpp2OF/Z5mZXuoXUFTw2md0kwqj
         e3YBb3xrlALM3UTpSvMbn31szQCK2rNswL7u2s90qk3lnlNBKKx713bhUX5dACQ3T3Zn
         z1IUhlzZFqLNSzr11afEq+sqere+K5J10xCN+sCv5c6VoPMUO04Iyxt18pNRFjxral+m
         SvmbmGlU0TzYBnAHxNMOT7qVoN06Pmz04ogodCSBBWs3scncUzgtNcPw86lua3IJBcpm
         HbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ww/kIUj7rFU9UfXZFPnG3veXj7F0QvRe6SbpJGQVsK8=;
        b=CXD5hzVVoMza/mI3mn4KJsvfjf0qqj6iDMCVR3ACMZZ9RpgMhypPygIllDZqSc5EUd
         /rNdW96ZBYKyA5RmF7oXyRdlTFMeDVSqwZe96soxUUa+zSTu+nk7gd+FMDKhaSR0pf39
         NSjRmx59kZMHFc6nO+Lnh/hI44odavPuVhnTIvEQVFWosnD7Fgu66pkU1kpvtcuKZcqQ
         Z2f+7GJToGaPWGQomsDNhTHiw92Y+tmFrGTYsOyrSQriePVWhn3R2pOeRUo56Ekeoy9r
         792Yb+jakSestwCBQvFseQg7+rOf3mWdpA0pRdlRcNwb+zvQJbicM1dcMvcSerM3Qe8p
         s3NQ==
X-Gm-Message-State: ANoB5pnMFyOwTGaA7T5M95N/iP/ao6XeTjpJqfTqDYrlGNcvkEn18ji3
        CRl8kLzRqjYX6GXJ5bxQRIvp2wjAkY8=
X-Google-Smtp-Source: AA0mqf6QeAtHvToCH9oAmj2zu7uSLScp23TaKKdFVB4tGdU5JACxqml6d0unF+sG8oocA68vrUfWUg==
X-Received: by 2002:a17:902:d551:b0:18d:6244:4676 with SMTP id z17-20020a170902d55100b0018d62444676mr10507327plf.18.1670820987845;
        Sun, 11 Dec 2022 20:56:27 -0800 (PST)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:5400:3ff:feb4:7578])
        by smtp.gmail.com with ESMTPSA id s20-20020a639254000000b00478eb777d18sm4217674pgn.72.2022.12.11.20.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:56:27 -0800 (PST)
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
Subject: [PATCH v4 3/3] leds: add driver for SPI driven WorldSemi WS2812B RGB LEDs
Date:   Mon, 12 Dec 2022 12:55:58 +0800
Message-Id: <20221212045558.69602-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212045558.69602-1-gch981213@gmail.com>
References: <20221212045558.69602-1-gch981213@gmail.com>
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

Changes since v2:
drop default-brightness and default-intensity

Changes since v3:
1. add more comments
2. rename reg to cascade
3. redo some line breaking
4. move duplicated pointer calculation into ws2812b_set_byte
5. reword error message
6. get ws2812b_priv from led cdev->dev->parent

 drivers/leds/rgb/Kconfig        |  11 ++
 drivers/leds/rgb/Makefile       |   1 +
 drivers/leds/rgb/leds-ws2812b.c | 231 ++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
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
index 000000000000..ca9c5caabe48
--- /dev/null
+++ b/drivers/leds/rgb/leds-ws2812b.c
@@ -0,0 +1,231 @@
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
+/* A continuous 0 for 50us+ as the 'reset' signal */
+#define WS2812B_RESET_LEN 18
+
+struct ws2812b_led {
+	struct led_classdev_mc mc_cdev;
+	struct mc_subled subled[WS2812B_NUM_COLORS];
+	int cascade;
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
+/**
+ * ws2812b_set_byte - convert a byte of data to 3-byte SPI data for pulses
+ * @priv: pointer to the private data structure
+ * @offset: offset of the target byte in the data stream
+ * @val: 1-byte data to be set
+ *
+ * WS2812B receives a stream of bytes from DI, takes the first 3 byte as LED
+ * brightness and pases the rest to the next LED through the DO pin.
+ * This function assembles a single byte of data to the LED:
+ * A bit is represented with a pulse of specific length. A long pulse is a 1
+ * and a short pulse is a 0.
+ * SPI transfers data continuously, MSB first. We can send 3'b100 to create a
+ * 0 pulse and 3'b110 for a 1 pulse. In this way, a byte of data takes up 3
+ * bytes in a SPI transfer:
+ *  1x0 1x0 1x0 1x0 1x0 1x0 1x0 1x0
+ * Let's rearrange it in 8 bits:
+ *  1x01x01x 01x01x01 x01x01x0
+ * The higher 3 bits, middle 2 bits and lower 3 bits are represented with the
+ * 1st, 2nd and 3rd byte in the SPI transfer respectively.
+ * There are only 8 combinations for 3 bits and 4 for 2 bits, so we can create
+ * a lookup table for the 3 bytes.
+ * e.g. For 0x6b -> 2'b01101011:
+ *  Bit 7-5: 3'b011 -> 10011011 -> 0x9b
+ *  Bit 4-3: 2'b01  -> 01001101 -> 0x4d
+ *  Bit 2-0: 3'b011 -> 00110110 -> 0x36
+ */
+static void ws2812b_set_byte(struct ws2812b_priv *priv, size_t offset, u8 val)
+{
+	/* The lookup table for Bit 7-5 4-3 2-0 */
+	const u8 h3b[] = { 0x92, 0x93, 0x9a, 0x9b, 0xd2, 0xd3, 0xda, 0xdb };
+	const u8 m2b[] = { 0x49, 0x4d, 0x69, 0x6d };
+	const u8 l3b[] = { 0x24, 0x26, 0x34, 0x36, 0xa4, 0xa6, 0xb4, 0xb6 };
+	u8 *p = priv->data_buf + WS2812B_RESET_LEN + (offset * WS2812B_BYTES_PER_COLOR);
+
+	p[0] = h3b[val >> 5]; /* Bit 7-5 */
+	p[1] = m2b[(val >> 3) & 0x3]; /* Bit 4-3 */
+	p[2] = l3b[val & 0x7]; /* Bit 2-0 */
+}
+
+static int ws2812b_set(struct led_classdev *cdev,
+		       enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct ws2812b_led *led =
+		container_of(mc_cdev, struct ws2812b_led, mc_cdev);
+	struct ws2812b_priv *priv = dev_get_drvdata(cdev->dev->parent);
+	int ret;
+	int i;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+
+	mutex_lock(&priv->mutex);
+	for (i = 0; i < WS2812B_NUM_COLORS; i++)
+		ws2812b_set_byte(priv, led->cascade * WS2812B_NUM_COLORS + i,
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
+	int cur_led = 0;
+	struct ws2812b_priv *priv;
+	struct fwnode_handle *led_node;
+	int num_leds, i, cnt, ret;
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
+		ws2812b_set_byte(priv, i, 0);
+
+	mutex_init(&priv->mutex);
+	priv->num_leds = num_leds;
+	priv->spi = spi;
+
+	device_for_each_child_node(dev, led_node) {
+		struct led_init_data init_data = {
+			.fwnode = led_node,
+		};
+		/* WS2812B LEDs usually come with GRB color */
+		u32 color_idx[WS2812B_NUM_COLORS] = {
+			LED_COLOR_ID_GREEN,
+			LED_COLOR_ID_RED,
+			LED_COLOR_ID_BLUE,
+		};
+		u32 cascade;
+
+		ret = fwnode_property_read_u32(led_node, "reg", &cascade);
+		if (ret) {
+			dev_err(dev, "failed to obtain numerical LED index for %s",
+				fwnode_get_name(led_node));
+			goto ERR_UNREG_LEDS;
+		}
+		if (cascade >= num_leds) {
+			dev_err(dev, "LED index of %s is larger than the number of LEDs.",
+				fwnode_get_name(led_node));
+			ret = -EINVAL;
+			goto ERR_UNREG_LEDS;
+		}
+
+		cnt = fwnode_property_count_u32(led_node, "color-index");
+		if (cnt > 0 && cnt <= WS2812B_NUM_COLORS)
+			fwnode_property_read_u32_array(led_node, "color-index",
+						       color_idx, (size_t)cnt);
+
+		priv->leds[cur_led].mc_cdev.subled_info =
+			priv->leds[cur_led].subled;
+		priv->leds[cur_led].mc_cdev.num_colors = WS2812B_NUM_COLORS;
+		priv->leds[cur_led].mc_cdev.led_cdev.max_brightness = 255;
+		priv->leds[cur_led].mc_cdev.led_cdev.brightness_set_blocking = ws2812b_set;
+
+		for (i = 0; i < WS2812B_NUM_COLORS; i++) {
+			priv->leds[cur_led].subled[i].color_index = color_idx[i];
+			priv->leds[cur_led].subled[i].intensity = 255;
+		}
+
+		priv->leds[cur_led].cascade = cascade;
+
+		ret = led_classdev_multicolor_register_ext(
+			dev, &priv->leds[cur_led].mc_cdev, &init_data);
+		if (ret) {
+			dev_err(dev, "registration of %s failed.",
+				fwnode_get_name(led_node));
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
+		led_classdev_multicolor_unregister(&priv->leds[cur_led].mc_cdev);
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
+		led_classdev_multicolor_unregister(&priv->leds[cur_led].mc_cdev);
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

