Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C89731544
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbjFOK1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjFOK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:27:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD7C10E3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so16879745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686824831; x=1689416831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jajagWKtfaZySI2FZsCkEsGMMoObeBePAoORw5hV7F0=;
        b=Il3Aa0bCoGtw37uauhydiHm98oX2hB676kvha28vA4NpqTkalwiNSue+ONeK0CnxbD
         JZj63FMWuUWW/ofnclXbe70/VSwLICKyVNGdWrzFR9rbJ6cm06eyVlVa3dknCVd3r/0X
         c1+ETUf7DG3mDyJ/EimPuO5ktCkft8B24/0mq0CEvd8AahqxNXFNxV0WvSHbZLfGf+HF
         vBUVjOUr5gguA6bN7aCWgPN53xjgSnnVWXtsKCg+e/kqlDuR4i52fzzJjXXa4SwpBHl8
         QLlI21UO1VhhhukZ4X6LxTvLP/gUymidrpXikye5frNkj+KOFwV4pUn6na8fUZNdGj5j
         HK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824831; x=1689416831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jajagWKtfaZySI2FZsCkEsGMMoObeBePAoORw5hV7F0=;
        b=GZOV249wN84ikmwIhGZfe3jvTyPd47lm9+4uWEdcrpNfTQRiFudzoKNpl9eKp7WJ0P
         O+lEBmUxLFIDlJaG23/8PXhupkTU+fI6sI2A01+uXh3sBJU623jm6VUEcjCB+ZsHq7aL
         FPJb1IMbUQqUH3HVPVi35HiIt8v3EMnSFTtU+JVFxEJdY1bECm5z5e0h/sj+/g+CrUx9
         2PpA3gRb9TD33qI0fa6nahzgi5CQD/tT5blaaexdB5M432gcx7XaYDm/2YL2cAlzyV3S
         TaZleYfaKWUsL+zwgG76VZRC+SESj3+pbAXZyUCseVP7tmc6ggCfnNpVx6v/gmLd8nzx
         l6RA==
X-Gm-Message-State: AC+VfDxzFz5QbMhPk79s+zLv4+gpy4rX1hWDZYosdocfEpze2KIXsCC+
        fp0uIXFNiH3j3/UK8hc5pV3v8Q==
X-Google-Smtp-Source: ACHHUZ6h4Xz1zM+b24UVBglSvF8YFbDzOM5rzejkKRgcE8kN0Grx2RwFvcP2ugbNRbLd1gRl3nBzgQ==
X-Received: by 2002:a05:600c:211:b0:3f6:906:1195 with SMTP id 17-20020a05600c021100b003f609061195mr14081122wmi.35.1686824831088;
        Thu, 15 Jun 2023 03:27:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b0030fa57d8064sm17332337wrt.52.2023.06.15.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:27:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 15 Jun 2023 12:27:01 +0200
Subject: [PATCH v2 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v2-2-26bc8fe1e90e@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v2-0-26bc8fe1e90e@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=25024;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+ySkoQd8PzZ8Y7a52sr7pX8Ooep7RlfAdO67cRA8JNA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiud6Ug5kaBeoRJxGIIH6o8x8kKssMBZq8ZAxT9cy
 Fy2LJYSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIrnegAKCRB33NvayMhJ0b4sD/
 45LGvLyCc0O/v51iToRs57hsERMIR7xrSF+k55Y8coYgo2a/XAMLelhosdFGNtzqIckH7MSaB5pNn8
 ZHswuO9XXbz+NvJPc9Bwm04uROFsDJK+g4SY7swIDJP9lxxjkxu1zXb94ZiP6SjKUTP7Cv2yhaQq44
 zwgUqhZV8g+54slfZYcCmYI/f4grVPzGbolILrYcSiT3ZrGN/pLTwOo2gGLX4bY8CuNAs1W9TtlYKW
 n/G4Xjx/hVV54m2azpSZPIpeGnJs7ulzxPnGq1TV+SI6AjPCRHVECnxQ4kT/PJgZ2HHjKwNdQ4Lp4V
 EyNpC6yz9u26A4R1V2vohWWpp8/wK1tD+ghFn0HfvK/S42VAjIuMtOF/Hfw4p1LG8jkbjxv1+nF9wY
 6ditfX58e62lz6snhePiFZPMwt5ifKox51OzArzyRp+AFu9W9b+f86b5ZhNMFXNo1QkdOU3xiG5FPQ
 5yosvp4ygjdmHxXtSnvlnpuYG0SaD8apVc4a/RsbIqe4LheNVtlhgDPEuJdzpbzTgoNNs+nFY9ZgKM
 urSFdr6w5/uvbBlBbe9WMkYW2N7q/NlXUcSBpLYRm+xNce7JZE/zqS+37O6V7quFSxfZmemCWyTfxG
 QZyU406LuomDeAXOGiGVp8t/spK1IHhZrXfws4j/1FcCbS3NGxU7I0t8dGPw==
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
 drivers/input/touchscreen/goodix_berlin.h      | 178 +++++++
 drivers/input/touchscreen/goodix_berlin_core.c | 681 +++++++++++++++++++++++++
 4 files changed, 865 insertions(+)

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
index 000000000000..56c110d94dff
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin.h
@@ -0,0 +1,178 @@
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
+#include <linux/input.h>
+#include <linux/of_gpio.h>
+#include <linux/input/touchscreen.h>
+#include <linux/regulator/consumer.h>
+
+#define GOODIX_MAX_TOUCH 10
+
+#define GOODIX_NORMAL_RESET_DELAY_MS 100
+
+#define MAX_SCAN_FREQ_NUM	8
+#define MAX_SCAN_RATE_NUM	8
+#define MAX_FREQ_NUM_STYLUS	8
+
+#define IRQ_EVENT_HEAD_LEN	8
+#define BYTES_PER_POINT		8
+#define COOR_DATA_CHECKSUM_SIZE 2
+
+#define GOODIX_TOUCH_EVENT	BIT(7)
+#define GOODIX_REQUEST_EVENT	BIT(6)
+
+#define GOODIX_REQUEST_CODE_RESET	3
+
+#define POINT_TYPE_STYLUS_HOVER	0x01
+#define POINT_TYPE_STYLUS	0x03
+
+#define DEV_CONFIRM_VAL		0xAA
+#define BOOTOPTION_ADDR		0x10000
+#define FW_VERSION_INFO_ADDR	0x10014
+
+#define GOODIX_IC_INFO_MAX_LEN	1024
+#define GOODIX_IC_INFO_ADDR	0x10070
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
+	u16 checksum;
+} __packed;
+
+struct goodix_berlin_ic_info_version {
+	u8 info_customer_id;
+	u8 info_version_id;
+	u8 ic_die_id;
+	u8 ic_version_id;
+	u32 config_id;
+	u8 config_version;
+	u8 frame_data_customer_id;
+	u8 frame_data_version_id;
+	u8 touch_data_customer_id;
+	u8 touch_data_version_id;
+	u8 reserved[3];
+} __packed;
+
+struct goodix_berlin_ic_info_feature {
+	u16 freqhop_feature;
+	u16 calibration_feature;
+	u16 gesture_feature;
+	u16 side_touch_feature;
+	u16 stylus_feature;
+} __packed;
+
+struct goodix_berlin_ic_info_misc {
+	u32 cmd_addr;
+	u16 cmd_max_len;
+	u32 cmd_reply_addr;
+	u16 cmd_reply_len;
+	u32 fw_state_addr;
+	u16 fw_state_len;
+	u32 fw_buffer_addr;
+	u16 fw_buffer_max_len;
+	u32 frame_data_addr;
+	u16 frame_data_head_len;
+	u16 fw_attr_len;
+	u16 fw_log_len;
+	u8 pack_max_num;
+	u8 pack_compress_version;
+	u16 stylus_struct_len;
+	u16 mutual_struct_len;
+	u16 self_struct_len;
+	u16 noise_struct_len;
+	u32 touch_data_addr;
+	u16 touch_data_head_len;
+	u16 point_struct_len;
+	u16 reserved1;
+	u16 reserved2;
+	u32 mutual_rawdata_addr;
+	u32 mutual_diffdata_addr;
+	u32 mutual_refdata_addr;
+	u32 self_rawdata_addr;
+	u32 self_diffdata_addr;
+	u32 self_refdata_addr;
+	u32 iq_rawdata_addr;
+	u32 iq_refdata_addr;
+	u32 im_rawdata_addr;
+	u16 im_readata_len;
+	u32 noise_rawdata_addr;
+	u16 noise_rawdata_len;
+	u32 stylus_rawdata_addr;
+	u16 stylus_rawdata_len;
+	u32 noise_data_addr;
+	u32 esd_addr;
+} __packed;
+
+enum goodix_berlin_ts_event_type {
+	GOODIX_BERLIN_EVENT_INVALID,
+	GOODIX_BERLIN_EVENT_TOUCH,
+	GOODIX_BERLIN_EVENT_REQUEST,
+};
+
+enum goodix_berlin_ts_request_type {
+	GOODIX_BERLIN_REQUEST_TYPE_INVALID,
+	GOODIX_BERLIN_REQUEST_TYPE_RESET,
+};
+
+enum goodix_berlin_touch_point_status {
+	GOODIX_BERLIN_TS_NONE,
+	GOODIX_BERLIN_TS_TOUCH,
+};
+
+struct goodix_berlin_coords {
+	enum goodix_berlin_touch_point_status status;
+	unsigned int x, y, w, p;
+};
+
+struct goodix_berlin_touch_data {
+	int touch_num;
+	struct goodix_berlin_coords coords[GOODIX_MAX_TOUCH];
+};
+
+struct goodix_berlin_event {
+	enum goodix_berlin_ts_event_type event_type;
+	enum goodix_berlin_ts_request_type request_code;
+	struct goodix_berlin_touch_data touch_data;
+};
+
+/* Runtime parameters extracted from goodix_berlin_ic_info */
+struct goodix_berlin_params {
+	u32 touch_data_addr;
+};
+
+struct goodix_berlin_core {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *avdd;
+	struct regulator *iovdd;
+	struct gpio_desc *reset_gpio;
+	struct touchscreen_properties props;
+	struct goodix_berlin_fw_version fw_version;
+	struct goodix_berlin_params params;
+	struct input_dev *input_dev;
+	struct goodix_berlin_event ts_event;
+	int irq;
+	struct dentry *debugfs_root;
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
index 000000000000..11788662722a
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -0,0 +1,681 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Touchscreen Driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/regmap.h>
+
+#include "goodix_berlin.h"
+
+/*
+ * Goodix "Berlin" Touchscreen ID driver
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
+ * - Support for older revisions (A, B & C)
+ */
+
+static bool goodix_berlin_check_checksum(const u8 *data, int size)
+{
+	u32 cal_checksum = 0;
+	u32 r_checksum = 0;
+	u32 i;
+
+	if (size < COOR_DATA_CHECKSUM_SIZE)
+		return false;
+
+	for (i = 0; i < size - COOR_DATA_CHECKSUM_SIZE; i++)
+		cal_checksum += data[i];
+
+	r_checksum += data[i++];
+	r_checksum += (data[i] << 8);
+
+	return (cal_checksum & 0xFFFF) == r_checksum;
+}
+
+static bool goodix_berlin_is_dummy_data(struct goodix_berlin_core *cd,
+					const u8 *data, int size)
+{
+	int zero_count = 0;
+	int ff_count = 0;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		if (data[i] == 0)
+			zero_count++;
+		else if (data[i] == 0xff)
+			ff_count++;
+	}
+	if (zero_count == size || ff_count == size) {
+		dev_warn(cd->dev, "warning data is all %s\n",
+			 zero_count == size ? "zero" : "0xff");
+		return true;
+	}
+
+	return false;
+}
+
+static int goodix_berlin_dev_confirm(struct goodix_berlin_core *cd)
+{
+	u8 tx_buf[8], rx_buf[8];
+	int retry = 3;
+	int error;
+
+	memset(tx_buf, DEV_CONFIRM_VAL, sizeof(tx_buf));
+	while (retry--) {
+		error = regmap_raw_write(cd->regmap, BOOTOPTION_ADDR, tx_buf,
+					 sizeof(tx_buf));
+		if (error < 0)
+			return error;
+
+		error = regmap_raw_read(cd->regmap, BOOTOPTION_ADDR, rx_buf,
+					sizeof(rx_buf));
+		if (error < 0)
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
+		if (error < 0) {
+			dev_err(cd->dev, "Failed to enable iovdd: %d\n", error);
+			return error;
+		}
+
+		/* Vendor waits 3ms for IOVDD to settle */
+		usleep_range(3000, 3100);
+
+		error = regulator_enable(cd->avdd);
+		if (error < 0) {
+			dev_err(cd->dev, "Failed to enable avdd: %d\n", error);
+			goto power_off_iovdd;
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
+		if (error < 0)
+			goto power_off_gpio;
+
+		/* Vendor waits 100ms for Firmware to fully boot */
+		msleep(GOODIX_NORMAL_RESET_DELAY_MS);
+
+		return 0;
+	}
+
+power_off_gpio:
+	gpiod_set_value(cd->reset_gpio, 1);
+
+	regulator_disable(cd->avdd);
+
+power_off_iovdd:
+	regulator_disable(cd->iovdd);
+
+	return error;
+}
+
+static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
+{
+	u8 buf[sizeof(struct goodix_berlin_fw_version)];
+	int retry = 2;
+	int error;
+
+	while (retry--) {
+		error = regmap_raw_read(cd->regmap, FW_VERSION_INFO_ADDR, buf, sizeof(buf));
+		if (error) {
+			dev_dbg(cd->dev, "read fw version: %d, retry %d\n", error, retry);
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		if (goodix_berlin_check_checksum(buf, sizeof(buf)))
+			break;
+
+		dev_dbg(cd->dev, "invalid fw version: checksum error\n");
+
+		error = -EINVAL;
+
+		/* Do not sleep on the last try */
+		if (retry)
+			usleep_range(10000, 11000);
+	}
+
+	if (error) {
+		dev_err(cd->dev, "failed to get fw version");
+		return error;
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
+	/* goodix_berlin_ic_info_param, variable width structure */
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
+	cd->params.touch_data_addr = le32_to_cpu(misc.touch_data_addr);
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
+	int error, i;
+	u16 length = 0;
+	u32 ic_addr;
+	u8 afe_data[GOODIX_IC_INFO_MAX_LEN] = { 0 };
+
+	ic_addr = GOODIX_IC_INFO_ADDR;
+
+	for (i = 0; i < 3; i++) {
+		error = regmap_raw_read(cd->regmap, ic_addr, (u8 *)&length, sizeof(length));
+		if (error) {
+			dev_info(cd->dev, "failed get ic info length, %d\n", error);
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		length = le16_to_cpu(length);
+		if (length >= GOODIX_IC_INFO_MAX_LEN) {
+			dev_info(cd->dev, "invalid ic info length %d, retry %d\n", length, i);
+			continue;
+		}
+
+		error = regmap_raw_read(cd->regmap, ic_addr, afe_data, length);
+		if (error) {
+			dev_info(cd->dev, "failed get ic info data, %d\n", error);
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		/* check whether the data is valid (ex. bus default values) */
+		if (goodix_berlin_is_dummy_data(cd, (const uint8_t *)afe_data, length)) {
+			dev_info(cd->dev, "fw info data invalid\n");
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		if (!goodix_berlin_check_checksum((const uint8_t *)afe_data, length)) {
+			dev_info(cd->dev, "fw info checksum error\n");
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		break;
+	}
+	if (i == 3) {
+		dev_err(cd->dev, "failed get ic info\n");
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
+	if (!cd->params.touch_data_addr) {
+		dev_err(cd->dev, "touch_data_addr is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int goodix_berlin_after_event_handler(struct goodix_berlin_core *cd)
+{
+	u8 sync_clean = 0;
+
+	return regmap_raw_write(cd->regmap, cd->params.touch_data_addr, &sync_clean, 1);
+}
+
+static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
+				       struct goodix_berlin_touch_data *touch_data,
+				       u8 *buf, int touch_num)
+{
+	unsigned int id = 0, x = 0, y = 0, w = 0;
+	u8 *coor_data;
+	int i;
+
+	coor_data = &buf[IRQ_EVENT_HEAD_LEN];
+
+	for (i = 0; i < touch_num; i++) {
+		id = (coor_data[0] >> 4) & 0x0F;
+
+		if (id >= GOODIX_MAX_TOUCH) {
+			dev_warn(cd->dev, "invalid finger id %d\n", id);
+
+			touch_data->touch_num = 0;
+			return;
+		}
+
+		x = le16_to_cpup((__le16 *)(coor_data + 2));
+		y = le16_to_cpup((__le16 *)(coor_data + 4));
+		w = le16_to_cpup((__le16 *)(coor_data + 6));
+
+		touch_data->coords[id].status = GOODIX_BERLIN_TS_TOUCH;
+		touch_data->coords[id].x = x;
+		touch_data->coords[id].y = y;
+		touch_data->coords[id].w = w;
+
+		coor_data += BYTES_PER_POINT;
+	}
+
+	touch_data->touch_num = touch_num;
+}
+
+static int goodix_berlin_touch_handler(struct goodix_berlin_core *cd,
+				       u8 *pre_buf, u32 pre_buf_len)
+{
+	static u8 buffer[IRQ_EVENT_HEAD_LEN + BYTES_PER_POINT * GOODIX_MAX_TOUCH + 2];
+	struct goodix_berlin_touch_data *touch_data = &cd->ts_event.touch_data;
+	u8 point_type = 0;
+	u8 touch_num = 0;
+	int error = 0;
+
+	memset(&cd->ts_event, 0, sizeof(cd->ts_event));
+
+	/* copy pre-data to buffer */
+	memcpy(buffer, pre_buf, pre_buf_len);
+
+	touch_num = buffer[2] & 0x0F;
+
+	if (touch_num > GOODIX_MAX_TOUCH) {
+		dev_warn(cd->dev, "invalid touch num %d\n", touch_num);
+		return -EINVAL;
+	}
+
+	/* read more data if more than 2 touch events */
+	if (unlikely(touch_num > 2)) {
+		error = regmap_raw_read(cd->regmap,
+					cd->params.touch_data_addr + pre_buf_len,
+					&buffer[pre_buf_len],
+					(touch_num - 2) * BYTES_PER_POINT);
+		if (error) {
+			dev_err(cd->dev, "failed get touch data\n");
+			return error;
+		}
+	}
+
+	goodix_berlin_after_event_handler(cd);
+
+	if (!touch_num)
+		goto out_touch_handler;
+
+	point_type = buffer[IRQ_EVENT_HEAD_LEN] & 0x0F;
+
+	if (point_type == POINT_TYPE_STYLUS || point_type == POINT_TYPE_STYLUS_HOVER) {
+		dev_warn_once(cd->dev, "Stylus event type not handled\n");
+		return 0;
+	}
+
+	if (!goodix_berlin_check_checksum(&buffer[IRQ_EVENT_HEAD_LEN],
+					  touch_num * BYTES_PER_POINT + 2)) {
+		dev_dbg(cd->dev, "touch data checksum error\n");
+		dev_dbg(cd->dev, "data: %*ph\n",
+			touch_num * BYTES_PER_POINT + 2, &buffer[IRQ_EVENT_HEAD_LEN]);
+		return -EINVAL;
+	}
+
+out_touch_handler:
+	cd->ts_event.event_type = GOODIX_BERLIN_EVENT_TOUCH;
+	goodix_berlin_parse_finger(cd, touch_data, buffer, touch_num);
+
+	return 0;
+}
+
+static int goodix_berlin_event_handler(struct goodix_berlin_core *cd)
+{
+	int pre_read_len;
+	u8 pre_buf[32];
+	u8 event_status;
+	int error;
+
+	pre_read_len = IRQ_EVENT_HEAD_LEN + BYTES_PER_POINT * 2 +
+		       COOR_DATA_CHECKSUM_SIZE;
+
+	error = regmap_raw_read(cd->regmap, cd->params.touch_data_addr, pre_buf,
+				pre_read_len);
+	if (error) {
+		dev_err(cd->dev, "failed get event head data\n");
+		return error;
+	}
+
+	if (pre_buf[0] == 0x00)
+		return -EINVAL;
+
+	if (!goodix_berlin_check_checksum(pre_buf, IRQ_EVENT_HEAD_LEN)) {
+		dev_warn(cd->dev, "touch head checksum err : %*ph\n",
+			 IRQ_EVENT_HEAD_LEN, pre_buf);
+		return -EINVAL;
+	}
+
+	event_status = pre_buf[0];
+	if (event_status & GOODIX_TOUCH_EVENT)
+		return goodix_berlin_touch_handler(cd, pre_buf, pre_read_len);
+
+	if (event_status & GOODIX_REQUEST_EVENT) {
+		cd->ts_event.event_type = GOODIX_BERLIN_EVENT_REQUEST;
+		if (pre_buf[2] == GOODIX_REQUEST_CODE_RESET)
+			cd->ts_event.request_code = GOODIX_BERLIN_REQUEST_TYPE_RESET;
+		else
+			dev_warn(cd->dev, "unsupported request code 0x%x\n", pre_buf[2]);
+	}
+
+	goodix_berlin_after_event_handler(cd);
+
+	return 0;
+}
+
+static void goodix_berlin_report_finger(struct goodix_berlin_core *cd)
+{
+	struct goodix_berlin_touch_data *touch_data = &cd->ts_event.touch_data;
+	int i;
+
+	mutex_lock(&cd->input_dev->mutex);
+
+	for (i = 0; i < GOODIX_MAX_TOUCH; i++) {
+		bool pressed = touch_data->coords[i].status == GOODIX_BERLIN_TS_TOUCH;
+
+		input_mt_slot(cd->input_dev, i);
+		input_mt_report_slot_state(cd->input_dev, MT_TOOL_FINGER, pressed);
+
+		if (touch_data->coords[i].status == GOODIX_BERLIN_TS_TOUCH) {
+			dev_dbg(cd->dev, "report: id[%d], x %d, y %d, w %d\n", i,
+				touch_data->coords[i].x,
+				touch_data->coords[i].y,
+				touch_data->coords[i].w);
+
+			touchscreen_report_pos(cd->input_dev, &cd->props,
+					       touch_data->coords[i].x,
+					       touch_data->coords[i].y, true);
+			input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
+					 touch_data->coords[i].w);
+		}
+	}
+
+	input_mt_sync_frame(cd->input_dev);
+	input_sync(cd->input_dev);
+
+	mutex_unlock(&cd->input_dev->mutex);
+}
+
+static int goodix_berlin_request_handle(struct goodix_berlin_core *cd)
+{
+	/* TOFIX: Handle more request codes */
+	if (cd->ts_event.request_code != GOODIX_BERLIN_REQUEST_TYPE_RESET) {
+		dev_info(cd->dev, "can't handle request type 0x%x\n",
+			 cd->ts_event.request_code);
+		return -EINVAL;
+	}
+
+	gpiod_set_value(cd->reset_gpio, 1);
+	usleep_range(2000, 2100);
+	gpiod_set_value(cd->reset_gpio, 0);
+
+	msleep(GOODIX_NORMAL_RESET_DELAY_MS);
+
+	return 0;
+}
+
+static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
+{
+	struct goodix_berlin_core *cd = data;
+	int error;
+
+	error = goodix_berlin_event_handler(cd);
+	if (likely(!error)) {
+		switch (cd->ts_event.event_type) {
+		case GOODIX_BERLIN_EVENT_TOUCH:
+			goodix_berlin_report_finger(cd);
+			break;
+
+		case GOODIX_BERLIN_EVENT_REQUEST:
+			goodix_berlin_request_handle(cd);
+			break;
+
+		/* TOFIX: Handle more request types */
+		case GOODIX_BERLIN_EVENT_INVALID:
+			break;
+		}
+	}
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
+	input_dev->dev.parent = cd->dev;
+
+	memcpy(&input_dev->id, id, sizeof(*id));
+
+	/* Set input parameters */
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
+
+	error = input_mt_init_slots(cd->input_dev, GOODIX_MAX_TOUCH, INPUT_MT_DIRECT);
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
+	if (irq <= 0)
+		return -EINVAL;
+
+	cd = devm_kzalloc(dev, sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return -ENOMEM;
+
+	cd->dev = dev;
+	cd->regmap = regmap;
+	cd->irq = irq;
+
+	cd->reset_gpio = devm_gpiod_get_optional(cd->dev, "reset", GPIOF_OUT_INIT_HIGH);
+	if (IS_ERR(cd->reset_gpio))
+		return dev_err_probe(cd->dev, PTR_ERR(cd->reset_gpio),
+				     "Failed to request reset gpio\n");
+
+	cd->avdd = devm_regulator_get(cd->dev, "avdd");
+	if (IS_ERR(cd->avdd))
+		return dev_err_probe(cd->dev, PTR_ERR(cd->avdd),
+				     "Failed to request avdd regulator\n");
+
+	cd->iovdd = devm_regulator_get(cd->dev, "iovdd");
+	if (IS_ERR(cd->iovdd))
+		return dev_err_probe(cd->dev, PTR_ERR(cd->iovdd),
+				     "Failed to request iovdd regulator\n");
+
+	error = goodix_berlin_input_dev_config(cd, id);
+	if (error < 0) {
+		dev_err(cd->dev, "failed set input device");
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
+	error = goodix_berlin_power_on(cd, true);
+	if (error) {
+		dev_err(cd->dev, "failed power on");
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, goodix_berlin_power_off, cd);
+	if (error)
+		return error;
+
+	error = goodix_berlin_read_version(cd);
+	if (error < 0) {
+		dev_err(cd->dev, "failed to get version info");
+		return error;
+	}
+
+	error = goodix_berlin_get_ic_info(cd);
+	if (error) {
+		dev_err(cd->dev, "invalid ic info, abort");
+		return error;
+	}
+
+	dev_dbg(cd->dev, "Goodix Berlin %s Touchscreen Controller", cd->fw_version.patch_pid);
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

