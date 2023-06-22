Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEDF73A30B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFVO3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFVO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:29:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ACC1BC3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31297125334so763212f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687444146; x=1690036146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CfqHmQNu0Ht5PgRd1QSDEKSBj7V06Xi2hE5JuIL9ylQ=;
        b=a2BULHGOQgq7ClfwemRxaw7KV5toFto+ewxyLXzdYcmsfvH9Ft/FNWmd1eGVBOgi8P
         efItNDdXviEoCc3pqVpegMK6qPfi6rQ7pZLr5qiTSYEHaZ9Vl4kOem+f5pFpXvwTWuTs
         1MF9XEMHSxk16uglY2Uy8zohFCYhjn2hDkAvaV+BnVo1YVd+jLYN5PRuNPIFR8YH1bgZ
         eO5JDtaLDafFmudQfQj8S6S22u8ARJiRZ4VucDDrb/WG+hPZDhQSEsKE1BewApY3mZyH
         aY393hF/Wr7P0cLrwpqcaez+H4fmi2OjQj2cFjSQ3gVIS3VrB3UJsuj0xX9yN8aYhYxp
         wOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444146; x=1690036146;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfqHmQNu0Ht5PgRd1QSDEKSBj7V06Xi2hE5JuIL9ylQ=;
        b=Lhz+c9CMAU1IMQDjc3xl6B7gr4GhpQQ8J+kzSzOdTWuxBuLwPRrnYrUBdxUHI5bVqO
         /QIJpMBHiYiOzgGYnnXREt1u0AO6I/HmnxKU6HtyXVZlemiDZWTK/wf2nZZ4iqk5mnrz
         PgcZM2jmj2IB4dmrxuVCfDDkp+ERZOjTK2HbfmKFHbjLVsTxKyqm3eTv0P79z+KFHmN3
         IKCc+BpGJg3EaxYAeJrfS38W/M5q4+FC0qTGIDQa6oa6SGz6kKmX16Qc/N8vXUWl9YNd
         HwUM4nWEex/ltxo+DJamhJN4/AF217v6I5W9l3kqJMoQ5x0QRyDlxcbT6HgqUtKNCqDJ
         uCdg==
X-Gm-Message-State: AC+VfDx9L4Vg6LVgMLTnLbT7tmLJm7rUe/EVzexgKa3pb6GSVOZiD5jY
        0kWLwr4wvwXmpRt5QXQjISCh6g==
X-Google-Smtp-Source: ACHHUZ4SM5eJTVuBNM0qU53mu+xkuxC0NVmJC57COOE0jQQKcOE57jM0IG0dcpPuWX12RqTPlH+6dg==
X-Received: by 2002:adf:dcc1:0:b0:30a:a193:3987 with SMTP id x1-20020adfdcc1000000b0030aa1933987mr22064808wrm.30.1687444145994;
        Thu, 22 Jun 2023 07:29:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm7168361wru.53.2023.06.22.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:29:05 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 22 Jun 2023 16:29:00 +0200
Subject: [PATCH v3 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v3-2-f0577cead709@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23029;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=BZr+GFW/2+OhZThRudz1d0U3eEQEqHJ9KwSnDZp2Fc0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBklFqtgUbtDg7qNyz4jgB7QZNarCwX7rhGqAJtq8yP
 7z8L2feJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJRarQAKCRB33NvayMhJ0TycD/
 9TfHcwveKNDkPCtBKL+KLcppKUaMuaoa3usPHjTMkLaJ5URXvKfuBQcTpkd0flCyt775k1eDX3CIst
 pdQqR5uhGiKm9l3K2QG6pHPhfjQJCAzEP5mb61arSMbAbNqOBWUnPCj25VKMGlvUDMEHGLSF6IeFLa
 /U8Q8fYC4PRNdHeTVy9ypIMECgtU7LfVjyxP0AHRPgB/Sl2Z6n5SjjefM/0HtjZ3NSEA6mLEZ3svg1
 8i/oan069Qs4YE5yeQNvV7Z/TK+u9Q9nUy5V6CCs8uj7w5G9zxu2uG415D1MWlrKKNgCSaE4FkkXpy
 ourtUTCHlx6PAlB0pVauaMtq+7h94J1JIJZpt26o/8UxmqmAVerNdaizeVZ66xmNKOLV95Jy8Wzbvh
 iCOr2V2fQSxu6tFekMR2qpSzO01iyO+ocY+6oxn6mFoCXzrFE+RfIeDP4enMCrzE3/w4eO2RNp//Kc
 CZUZxLg7pgsGuyhXaG1yozzMHSrayiFXvIh55057Nx7O6WVfu/WbJN71/XIML2DGLVGn6VUzaj+0iJ
 225W+P3oArszxSyfzYCJcL4cnoCBD1Z/a/1q3QQZiRWLt5BE2SdF//Q71wtUQUTbRHYTg6dpGVQ92Y
 Z7ATxVKcHqi5YNiBngJ57V8WKbDYk5v5gor0ZL9X87iTdFXeqsb0R1YlSG+A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for the new Goodix "Berlin" touchscreen ICs.

These touchscreen ICs support SPI, I2C and I3C interface, up to
10 finger touch, stylus and gestures events.

This initial driver is derived from the Goodix goodix_ts_berlin
available at [1] and [2] and only supports the GT9916 IC
present on the Qualcomm SM8550 MTP & QRD touch panel.

The current implementation only supports BerlinD, aka GT9916.

Support for advanced features like:
- Firmware & config update
- Stylus events
- Gestures events
- Previous revisions support (BerlinA or BerlinB)
is not included in current version.

The current support will work with currently flashed firmware
and config, and bail out if firmware or config aren't flashed yet.

[1] https://github.com/goodix/goodix_ts_berlin
[2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/input/touchscreen/Kconfig              |   5 +
 drivers/input/touchscreen/Makefile             |   1 +
 drivers/input/touchscreen/goodix_berlin.h      | 159 +++++++
 drivers/input/touchscreen/goodix_berlin_core.c | 584 +++++++++++++++++++++++++
 4 files changed, 749 insertions(+)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index c2cbd332af1d..1a6f6f6da991 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -416,6 +416,11 @@ config TOUCHSCREEN_GOODIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called goodix.
 
+config TOUCHSCREEN_GOODIX_BERLIN_CORE
+	depends on GPIOLIB || COMPILE_TEST
+	depends on REGMAP
+	tristate
+
 config TOUCHSCREEN_HIDEEP
 	tristate "HiDeep Touch IC"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 159cd5136fdb..29cdb042e104 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
 obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
+obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
 obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
 obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
new file mode 100644
index 000000000000..235f44947a28
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Goodix Touchscreen Driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_berlin_berlin driver.
+ */
+
+#ifndef __GOODIX_BERLIN_H_
+#define __GOODIX_BERLIN_H_
+
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/regulator/consumer.h>
+#include <linux/sizes.h>
+
+#define GOODIX_BERLIN_MAX_TOUCH			10
+
+#define GOODIX_BERLIN_NORMAL_RESET_DELAY_MS	100
+
+#define GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN	8
+#define GOODIX_BERLIN_STATUS_OFFSET		0
+#define GOODIX_BERLIN_REQUEST_TYPE_OFFSET	2
+
+#define GOODIX_BERLIN_BYTES_PER_POINT		8
+#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE	2
+#define GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK	GENMASK(15, 0)
+
+/* Read n finger events */
+#define GOODIX_BERLIN_IRQ_READ_LEN(n)		(GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN + \
+						 (GOODIX_BERLIN_BYTES_PER_POINT * (n)) + \
+						 GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
+
+#define GOODIX_BERLIN_TOUCH_EVENT		BIT(7)
+#define GOODIX_BERLIN_REQUEST_EVENT		BIT(6)
+#define GOODIX_BERLIN_TOUCH_COUNT_MASK		GENMASK(3, 0)
+
+#define GOODIX_BERLIN_REQUEST_CODE_RESET	3
+
+#define GOODIX_BERLIN_POINT_TYPE_MASK		GENMASK(3, 0)
+#define GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER	1
+#define GOODIX_BERLIN_POINT_TYPE_STYLUS		3
+
+#define GOODIX_BERLIN_TOUCH_ID_MASK		GENMASK(7, 4)
+
+#define GOODIX_BERLIN_DEV_CONFIRM_VAL		0xAA
+#define GOODIX_BERLIN_BOOTOPTION_ADDR		0x10000
+#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR	0x10014
+
+#define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
+#define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
+
+struct goodix_berlin_fw_version {
+	u8 rom_pid[6];
+	u8 rom_vid[3];
+	u8 rom_vid_reserved;
+	u8 patch_pid[8];
+	u8 patch_vid[4];
+	u8 patch_vid_reserved;
+	u8 sensor_id;
+	u8 reserved[2];
+	__le16 checksum;
+} __packed;
+
+struct goodix_berlin_ic_info_version {
+	u8 info_customer_id;
+	u8 info_version_id;
+	u8 ic_die_id;
+	u8 ic_version_id;
+	__le32 config_id;
+	u8 config_version;
+	u8 frame_data_customer_id;
+	u8 frame_data_version_id;
+	u8 touch_data_customer_id;
+	u8 touch_data_version_id;
+	u8 reserved[3];
+} __packed;
+
+struct goodix_berlin_ic_info_feature {
+	__le16 freqhop_feature;
+	__le16 calibration_feature;
+	__le16 gesture_feature;
+	__le16 side_touch_feature;
+	__le16 stylus_feature;
+} __packed;
+
+struct goodix_berlin_ic_info_misc {
+	__le32 cmd_addr;
+	__le16 cmd_max_len;
+	__le32 cmd_reply_addr;
+	__le16 cmd_reply_len;
+	__le32 fw_state_addr;
+	__le16 fw_state_len;
+	__le32 fw_buffer_addr;
+	__le16 fw_buffer_max_len;
+	__le32 frame_data_addr;
+	__le16 frame_data_head_len;
+	__le16 fw_attr_len;
+	__le16 fw_log_len;
+	u8 pack_max_num;
+	u8 pack_compress_version;
+	__le16 stylus_struct_len;
+	__le16 mutual_struct_len;
+	__le16 self_struct_len;
+	__le16 noise_struct_len;
+	__le32 touch_data_addr;
+	__le16 touch_data_head_len;
+	__le16 point_struct_len;
+	__le16 reserved1;
+	__le16 reserved2;
+	__le32 mutual_rawdata_addr;
+	__le32 mutual_diffdata_addr;
+	__le32 mutual_refdata_addr;
+	__le32 self_rawdata_addr;
+	__le32 self_diffdata_addr;
+	__le32 self_refdata_addr;
+	__le32 iq_rawdata_addr;
+	__le32 iq_refdata_addr;
+	__le32 im_rawdata_addr;
+	__le16 im_readata_len;
+	__le32 noise_rawdata_addr;
+	__le16 noise_rawdata_len;
+	__le32 stylus_rawdata_addr;
+	__le16 stylus_rawdata_len;
+	__le32 noise_data_addr;
+	__le32 esd_addr;
+} __packed;
+
+struct goodix_berlin_touch_data {
+	u8 id;
+	u8 unused;
+	__le16 x;
+	__le16 y;
+	__le16 w;
+} __packed;
+
+struct goodix_berlin_core {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *avdd;
+	struct regulator *iovdd;
+	struct gpio_desc *reset_gpio;
+	struct touchscreen_properties props;
+	struct goodix_berlin_fw_version fw_version;
+	struct input_dev *input_dev;
+	int irq;
+
+	/* Runtime parameters extracted from IC_INFO buffer  */
+	u32 touch_data_addr;
+};
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap);
+
+extern const struct dev_pm_ops goodix_berlin_pm_ops;
+
+#endif
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
new file mode 100644
index 000000000000..af3e73bbb3ec
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -0,0 +1,584 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Touchscreen Driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <asm/unaligned.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/regmap.h>
+
+#include "goodix_berlin.h"
+
+/*
+ * Goodix "Berlin" Touchscreen ID driver
+ *
+ * This driver is distinct from goodix.c since hardware interface
+ * is different enough to require a new driver.
+ * None of the register address or data structure are close enough
+ * to the previous generations.
+ *
+ * Currently only handles Multitouch events with already
+ * programmed firmware and "config" for "Revision D" Berlin IC.
+ *
+ * Support is missing for:
+ * - ESD Management
+ * - Firmware update/flashing
+ * - "Config" update/flashing
+ * - Stylus Events
+ * - Gesture Events
+ * - Support for older revisions (A & B)
+ */
+
+static bool goodix_berlin_checksum_valid(const u8 *data, int size)
+{
+	u32 cal_checksum = 0;
+	u16 r_checksum;
+	u32 i;
+
+	if (size < GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE)
+		return false;
+
+	for (i = 0; i < size - GOODIX_BERLIN_COOR_DATA_CHECKSUM_SIZE; i++)
+		cal_checksum += data[i];
+
+	r_checksum = get_unaligned_le16(&data[i]);
+
+	return FIELD_GET(GOODIX_BERLIN_COOR_DATA_CHECKSUM_MASK, cal_checksum) == r_checksum;
+}
+
+static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
+					const u8 *data, int size)
+{
+	int i;
+
+	/*
+	 * If the device is missing or doesn't respond the buffer
+	 * could be filled with bus default line state, 0x00 or 0xff,
+	 * so declare success the first time we encounter neither.
+	 */
+	for (i = 0; i < size; i++)
+		if (data[i] > 0 && data[i] < 0xff)
+			return false;
+
+	return true;
+}
+
+static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
+{
+	u8 tx_buf[8], rx_buf[8];
+	int retry = 3;
+	int error;
+
+	memset(tx_buf, GOODIX_BERLIN_DEV_CONFIRM_VAL, sizeof(tx_buf));
+	while (retry--) {
+		error = regmap_raw_write(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, tx_buf,
+					 sizeof(tx_buf));
+		if (error)
+			return error;
+
+		error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_BOOTOPTION_ADDR, rx_buf,
+					sizeof(rx_buf));
+		if (error)
+			return error;
+
+		if (!memcmp(tx_buf, rx_buf, sizeof(tx_buf)))
+			return 0;
+
+		usleep_range(5000, 5100);
+	}
+
+	dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n", 8, rx_buf);
+
+	return -EINVAL;
+}
+
+static int goodix_berlin_power_on(struct goodix_berlin_core *cd, bool on)
+{
+	int error = 0;
+
+	if (on) {
+		error = regulator_enable(cd->iovdd);
+		if (error) {
+			dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
+			return error;
+		}
+
+		/* Vendor waits 3ms for IOVDD to settle */
+		usleep_range(3000, 3100);
+
+		error = regulator_enable(cd->avdd);
+		if (error) {
+			dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
+			goto error_avdd_regulator;
+		}
+
+		/* Vendor waits 15ms for IOVDD to settle */
+		usleep_range(15000, 15100);
+
+		gpiod_set_value(cd->reset_gpio, 0);
+
+		/* Vendor waits 4ms for Firmware to initialize */
+		usleep_range(4000, 4100);
+
+		error = goodix_berlin_dev_confirm(cd);
+		if (error)
+			goto error_dev_confirm;
+
+		/* Vendor waits 100ms for Firmware to fully boot */
+		msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
+
+		return 0;
+	}
+
+error_dev_confirm:
+	gpiod_set_value(cd->reset_gpio, 1);
+
+	regulator_disable(cd->avdd);
+
+error_avdd_regulator:
+	regulator_disable(cd->iovdd);
+
+	return error;
+}
+
+static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
+{
+	u8 buf[sizeof(struct goodix_berlin_fw_version)];
+	int error;
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR, buf, sizeof(buf));
+	if (error) {
+		dev_err(cd->dev, "error reading fw version\n");
+		return error;
+	}
+
+	if (!goodix_berlin_checksum_valid(buf, sizeof(buf))) {
+		dev_err(cd->dev, "invalid fw version: checksum error\n");
+		return -EINVAL;
+	}
+
+	memcpy(&cd->fw_version, buf, sizeof(cd->fw_version));
+
+	return 0;
+}
+
+/* Only extract necessary data for runtime */
+static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
+					 const u8 *data, u16 length)
+{
+	struct goodix_berlin_ic_info_misc misc;
+	unsigned int offset = 0;
+	u8 param_num;
+
+	offset += sizeof(__le16); /* length */
+	offset += sizeof(struct goodix_berlin_ic_info_version);
+	offset += sizeof(struct goodix_berlin_ic_info_feature);
+
+	/* IC_INFO Parameters, variable width structure */
+	offset += 4 * sizeof(u8); /* drv_num, sen_num, button_num, force_num */
+
+	if (offset >= length)
+		goto invalid_offset;
+
+	param_num = data[offset++]; /* active_scan_rate_num */
+
+	offset += param_num * sizeof(__le16);
+
+	if (offset >= length)
+		goto invalid_offset;
+
+	param_num = data[offset++]; /* mutual_freq_num*/
+
+	offset += param_num * sizeof(__le16);
+
+	if (offset >= length)
+		goto invalid_offset;
+
+	param_num = data[offset++]; /* self_tx_freq_num */
+
+	offset += param_num * sizeof(__le16);
+
+	if (offset >= length)
+		goto invalid_offset;
+
+	param_num = data[offset++]; /* self_rx_freq_num */
+
+	offset += param_num * sizeof(__le16);
+
+	if (offset >= length)
+		goto invalid_offset;
+
+	param_num = data[offset++]; /* stylus_freq_num */
+
+	offset += param_num * sizeof(__le16);
+
+	if (offset + sizeof(misc) > length)
+		goto invalid_offset;
+
+	/* goodix_berlin_ic_info_misc */
+	memcpy(&misc, &data[offset], sizeof(misc));
+
+	cd->touch_data_addr = le32_to_cpu(misc.touch_data_addr);
+
+	return 0;
+
+invalid_offset:
+	dev_err(cd->dev, "ic_info length is invalid (offset %d length %d)\n",
+		offset, length);
+	return -EINVAL;
+}
+
+static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
+{
+	u8 afe_data[GOODIX_BERLIN_IC_INFO_MAX_LEN];
+	__le16 length_raw;
+	u16 length;
+	int error;
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
+				&length_raw, sizeof(length_raw));
+	if (error) {
+		dev_info(cd->dev, "failed get ic info length, %d\n", error);
+		return error;
+	}
+
+	length = le16_to_cpu(length_raw);
+	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
+		dev_info(cd->dev, "invalid ic info length %d\n", length);
+		return -EINVAL;
+	}
+
+	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
+				afe_data, length);
+	if (error) {
+		dev_info(cd->dev, "failed get ic info data, %d\n", error);
+		return error;
+	}
+
+	/* check whether the data is valid (ex. bus default values) */
+	if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {
+		dev_err(cd->dev, "fw info data invalid\n");
+		return -EINVAL;
+	}
+
+	if (!goodix_berlin_checksum_valid((const uint8_t *)afe_data, length)) {
+		dev_info(cd->dev, "fw info checksum error\n");
+		return -EINVAL;
+	}
+
+	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
+	if (error) {
+		dev_err(cd->dev, "error converting ic info\n");
+		return error;
+	}
+
+	/* check some key info */
+	if (!cd->touch_data_addr) {
+		dev_err(cd->dev, "touch_data_addr is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
+				       const void *buf, int touch_num)
+{
+	const struct goodix_berlin_touch_data *touch_data = buf;
+	int i;
+
+	/* Check for data validity */
+	for (i = 0; i < touch_num; i++) {
+		unsigned int id;
+
+		id = FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK, touch_data[i].id);
+
+		if (id >= GOODIX_BERLIN_MAX_TOUCH) {
+			dev_warn(cd->dev, "invalid finger id %d\n", id);
+			return;
+		}
+	}
+
+	/* Report finger touches */
+	for (i = 0; i < touch_num; i++) {
+		input_mt_slot(cd->input_dev,
+			      FIELD_GET(GOODIX_BERLIN_TOUCH_ID_MASK,
+					touch_data[i].id));
+		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, true);
+
+		touchscreen_report_pos(cd->input_dev, &cd->props,
+				       __le16_to_cpu(touch_data[i].x),
+				       __le16_to_cpu(touch_data[i].y),
+				       true);
+		input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
+				 __le16_to_cpu(touch_data[i].w));
+	}
+
+	input_mt_sync_frame(cd->input_dev);
+	input_sync(cd->input_dev);
+}
+
+static void goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
+					const void *pre_buf, u32 pre_buf_len)
+{
+	static u8 buffer[GOODIX_BERLIN_IRQ_READ_LEN(GOODIX_BERLIN_MAX_TOUCH)];
+	u8 point_type = 0;
+	u8 touch_num = 0;
+	int error = 0;
+
+	/* copy pre-data to buffer */
+	memcpy(buffer, pre_buf, pre_buf_len);
+
+	touch_num = FIELD_GET(GOODIX_BERLIN_TOUCH_COUNT_MASK,
+			      buffer[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
+
+	if (touch_num > GOODIX_BERLIN_MAX_TOUCH) {
+		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
+		return;
+	}
+
+	if (touch_num) {
+		/* read more data if more than 2 touch events */
+		if (unlikely(touch_num > 2)) {
+			error = regmap_raw_read(cd->regmap,
+						cd->touch_data_addr + pre_buf_len,
+						&buffer[pre_buf_len],
+						(touch_num - 2) * GOODIX_BERLIN_BYTES_PER_POINT);
+			if (error) {
+				dev_err_ratelimited(cd->dev, "failed get touch data\n");
+				return;
+			}
+		}
+
+		point_type = FIELD_GET(GOODIX_BERLIN_POINT_TYPE_MASK,
+				       buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
+
+		if (point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS ||
+		    point_type == GOODIX_BERLIN_POINT_TYPE_STYLUS_HOVER) {
+			dev_warn_once(cd->dev, "Stylus event type not handled\n");
+			return;
+		}
+
+		if (!goodix_berlin_checksum_valid(&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
+						  touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2)) {
+			dev_dbg(cd->dev, "touch data checksum error\n");
+			dev_dbg(cd->dev, "data: %*ph\n",
+				touch_num * GOODIX_BERLIN_BYTES_PER_POINT + 2,
+				&buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN]);
+			return;
+		}
+	}
+
+	goodix_berlin_parse_finger(cd, &buffer[GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN],
+				   touch_num);
+}
+
+static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
+{
+	gpiod_set_value(cd->reset_gpio, 1);
+	usleep_range(2000, 2100);
+	gpiod_set_value(cd->reset_gpio, 0);
+
+	msleep(GOODIX_BERLIN_NORMAL_RESET_DELAY_MS);
+
+	return 0;
+}
+
+static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
+{
+	struct goodix_berlin_core *cd = data;
+	u8 buf[GOODIX_BERLIN_IRQ_READ_LEN(2)];
+	u8 event_status;
+	int error;
+
+	/* First, read buffer with space for 2 touch events */
+	error = regmap_raw_read(cd->regmap, cd->touch_data_addr, buf,
+				GOODIX_BERLIN_IRQ_READ_LEN(2));
+	if (error) {
+		dev_err_ratelimited(cd->dev, "failed get event head data\n");
+		return IRQ_HANDLED;
+	}
+
+	if (buf[GOODIX_BERLIN_STATUS_OFFSET] == 0)
+		return IRQ_HANDLED;
+
+	if (!goodix_berlin_checksum_valid(buf, GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN)) {
+		dev_warn_ratelimited(cd->dev, "touch head checksum err : %*ph\n",
+				     GOODIX_BERLIN_IRQ_EVENT_HEAD_LEN, buf);
+		return IRQ_HANDLED;
+	}
+
+	event_status = buf[GOODIX_BERLIN_STATUS_OFFSET];
+
+	if (event_status & GOODIX_BERLIN_TOUCH_EVENT)
+		goodix_berlin_touch_handler(cd, buf, GOODIX_BERLIN_IRQ_READ_LEN(2));
+
+	if (event_status & GOODIX_BERLIN_REQUEST_EVENT) {
+		switch (buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]) {
+		case GOODIX_BERLIN_REQUEST_CODE_RESET:
+			goodix_berlin_request_handle_reset(cd);
+			break;
+
+		default:
+			dev_warn(cd->dev, "unsupported request code 0x%x\n",
+				 buf[GOODIX_BERLIN_REQUEST_TYPE_OFFSET]);
+		}
+	}
+
+	/* Clear up status field */
+	regmap_write(cd->regmap, cd->touch_data_addr, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int goodix_berlin_input_dev_config(struct goodix_berlin_core *cd,
+					  const struct input_id *id)
+{
+	struct input_dev *input_dev;
+	int error;
+
+	input_dev = devm_input_allocate_device(cd->dev);
+	if (!input_dev)
+		return -ENOMEM;
+
+	cd->input_dev = input_dev;
+	input_set_drvdata(input_dev, cd);
+
+	input_dev->name = "Goodix Berlin Capacitive TouchScreen";
+	input_dev->phys = "input/ts";
+
+	input_dev->id = *id;
+
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
+
+	error = input_mt_init_slots(cd->input_dev, GOODIX_BERLIN_MAX_TOUCH,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	return input_register_device(cd->input_dev);
+}
+
+static int goodix_berlin_pm_suspend(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+
+	disable_irq(cd->irq);
+
+	return goodix_berlin_power_on(cd, false);
+}
+
+static int goodix_berlin_pm_resume(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+	int error;
+
+	error = goodix_berlin_power_on(cd, true);
+	if (error)
+		return error;
+
+	enable_irq(cd->irq);
+
+	return 0;
+}
+
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_berlin_pm_ops,
+			     goodix_berlin_pm_suspend,
+			     goodix_berlin_pm_resume);
+
+static void goodix_berlin_power_off(void *data)
+{
+	struct goodix_berlin_core *cd = data;
+
+	goodix_berlin_power_on(cd, false);
+}
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap)
+{
+	struct goodix_berlin_core *cd;
+	int error;
+
+	if (irq <= 0) {
+		dev_err(dev, "Missing interrupt number\n");
+		return -EINVAL;
+	}
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->dev = dev;
+	cd->regmap = regmap;
+	cd->irq = irq;
+
+	cd->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(cd->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(cd->reset_gpio),
+				     "Failed to request reset gpio\n");
+
+	cd->avdd = devm_regulator_get(dev, "avdd");
+	if (IS_ERR(cd->avdd))
+		return dev_err_probe(dev, PTR_ERR(cd->avdd),
+				     "Failed to request avdd regulator\n");
+
+	cd->iovdd = devm_regulator_get(dev, "iovdd");
+	if (IS_ERR(cd->iovdd))
+		return dev_err_probe(dev, PTR_ERR(cd->iovdd),
+				     "Failed to request iovdd regulator\n");
+
+	error = goodix_berlin_power_on(cd, true);
+	if (error) {
+		dev_err(dev, "failed power on");
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, goodix_berlin_power_off, cd);
+	if (error)
+		return error;
+
+	error = goodix_berlin_read_version(cd);
+	if (error) {
+		dev_err(dev, "failed to get version info");
+		return error;
+	}
+
+	error = goodix_berlin_get_ic_info(cd);
+	if (error) {
+		dev_err(dev, "invalid ic info, abort");
+		return error;
+	}
+
+	error = goodix_berlin_input_dev_config(cd, id);
+	if (error) {
+		dev_err(dev, "failed set input device");
+		return error;
+	}
+
+	error = devm_request_threaded_irq(dev, irq, NULL,
+					  goodix_berlin_threadirq_func,
+					  IRQF_ONESHOT, "goodix-berlin", cd);
+	if (error) {
+		dev_err(dev, "request threaded irq failed: %d\n", error);
+		return error;
+	}
+
+	dev_set_drvdata(dev, cd);
+
+	dev_dbg(dev, "Goodix Berlin %s Touchscreen Controller", cd->fw_version.patch_pid);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(goodix_berlin_probe);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin Core Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

