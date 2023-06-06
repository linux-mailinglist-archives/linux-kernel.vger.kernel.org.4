Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C941724619
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbjFFOcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbjFFOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:32:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2F10C3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:32:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso27088195e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686061924; x=1688653924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJmkENoeYIxcCZuPTERw706fBNCsnp0mTzF1iZ/txlU=;
        b=f2YTYba1h2fSRqLW92etH/3YXfLyAoxqEgs7ZSuWfQ5yrO9WfjOTzJcokzJMNleYyw
         6S9G/FcbsFmN1+XX06sAj4Ldsfou/H4q8bYLjosc8KRRTy94A/q1maZfNTgo2jvje4R8
         Nyxh/JW5mSx3Pix5dzQwuRPhOHAJk8m0u0bCz7UfTdiak+kGLxCmS1dV9lbyCjgfgKJL
         Nn821izDbDO/P6DimCrVNVWH0R3zp7/cr7NpOKF8EaoqszIS85WZVPKCYAQBEBlh/QN4
         Rz3H2ZOAbKOqH9HrL6cCWMbPM4oWMN7AXbeEFBwCEOyQKbjJFeZpnPa9a0+AnnzTGb/b
         KW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061924; x=1688653924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJmkENoeYIxcCZuPTERw706fBNCsnp0mTzF1iZ/txlU=;
        b=jzNkWA3EATai0qwJuQbChOs2XBj6AMcaGQtVw7dHC+E2tpvCXwnxwTfyYT2cRLlsvm
         f+6n/WLdrAuaFZz9MZWLWdbLDUXcsolR7JYhbcIXH/Bqvj41N089QVihWK3d5tLozRx+
         FJX6bNQYPVQ6p8vf1lRlYHDHRrJ1Ljwpleaakv/rRRPqBsFnKIj7VGhfXXiZx6+qyQSf
         PTQ1a1zEwIV02fcbOKEnMFWuoGHRLqdwRsSKvfBFrvWfSEHkBs0hQtDqqFlykFsuS6dG
         6Umy/V94bHG/7dBEceE1WYYDnX93axWXvZZQ+p6FToJyLkTJOzEm8kXCL5qu7Rk9cHUp
         JO4w==
X-Gm-Message-State: AC+VfDz/0g/dfp/kyOyjoz/DkOgsBjT5WknOQAg4xkHgoUnph6Hq0xLk
        vlWbBhcjbC26gY7RQxH+A++t7g==
X-Google-Smtp-Source: ACHHUZ6r0jlHi3M3MP5zsIEtxL59FdYYAaTl0OWPo9RGxpsPAxiZ4F2qVTlr5RxYcPzm+rUPEC0fTg==
X-Received: by 2002:a7b:ce88:0:b0:3f6:1508:950c with SMTP id q8-20020a7bce88000000b003f61508950cmr2368404wmj.29.1686061923889;
        Tue, 06 Jun 2023 07:32:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b003f61177faffsm3883600wmb.0.2023.06.06.07.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:32:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 06 Jun 2023 16:31:57 +0200
Subject: [PATCH RFC 2/4] input: touchscreen: add core support for Goodix
 Berlin Touchscreen IC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230606-topic-goodix-berlin-upstream-initial-v1-2-4a0741b8aefd@linaro.org>
References: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v1-0-4a0741b8aefd@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=36191;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ILK55+3rcQFd0dPRS7Pcqox8J1tft+54xSQfGmJYSr4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkf0NgFCd6v+wpQxp5kchOfulLoGz5MpwsssEtwB43
 8MagbXWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZH9DYAAKCRB33NvayMhJ0b3+D/
 0fgTdSrvwenu+eY4E/rWFOZ7ISwN5s6NbSU+KZI2thJefxnQja2mZ5Z7PaM6giHBzSmT7inXwCsW6S
 BGKa1FZzH5lmf53WjraU99TULX6srnV9wft4eBW13xmyztc2ykejwC7QnJhaV8HYplzaoSqMF9KPsI
 Y1YlT0aB0UK42ybrjaD7+kZU8U5msJw4Ym5Vi7h5WLQlHzdjeMRv3mzSlkSsoqVyGCk198Tq+mh85Y
 uhZ29LwJj8f0nZupAabozfzOitLcCLqYvtU05K2PxqiMojMvlJqCJ6ietBIUiR4CbiBJvPEodq0wAl
 QeYNdAwlyhBiOmQYxl4/2bJmuHoOA9V3veg+yj01wAT9rgSlazED+2pdIlFrMCHH+hmufbbtvSEB5H
 0ou5ts7EEyUmpjC373+WLs0XEeduIDJDOoAYzrC4nOPVq7znx1RIA9CYaecLgo2hfrTQObS1PTJ6A/
 UrY1fpKeyfcV37vu6f418xv02Cjt6cIqdfDIqRmHfUxrhEZ6M8ncB9DZLsLGZYbJoWM9vVb8gAUw3Q
 scfhnIdkLKdPWiYtNuAjfGI+vwHYVjIyntc5zcCak+tHJhMEb5TqCo0YW2yFG/aHvKcQbrCMN5tYqk
 LXwHkA3l4PRegWlspPt0v4g6hHhwgiD9J+q9DxPiP9qJfq87O9ixq/vi5mxg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/input/touchscreen/goodix_berlin.h      | 228 ++++++
 drivers/input/touchscreen/goodix_berlin_core.c | 935 +++++++++++++++++++++++++
 4 files changed, 1169 insertions(+)

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
index 000000000000..83f16201c354
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin.h
@@ -0,0 +1,228 @@
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
+#define GOODIX_MAX_FRAMEDATA_LEN 1700
+
+#define GOODIX_NORMAL_RESET_DELAY_MS 100
+#define GOODIX_HOLD_CPU_RESET_DELAY_MS 5
+
+enum CHECKSUM_MODE {
+	CHECKSUM_MODE_U8_LE,
+	CHECKSUM_MODE_U16_LE,
+};
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
+#define GOODIX_GESTURE_EVENT	BIT(5)
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
+enum brl_request_code {
+	BRL_REQUEST_CODE_CONFIG = 1,
+	BRL_REQUEST_CODE_REF_ERR = 2,
+	BRL_REQUEST_CODE_RESET = 3,
+	BRL_REQUEST_CODE_CLOCK = 4,
+};
+
+struct goodix_fw_version {
+	u8 rom_pid[6]; /* rom PID */
+	u8 rom_vid[3]; /* Mask VID */
+	u8 rom_vid_reserved;
+	u8 patch_pid[8]; /* Patch PID */
+	u8 patch_vid[4]; /* Patch VID */
+	u8 patch_vid_reserved;
+	u8 sensor_id;
+	u8 reserved[2];
+	u16 checksum;
+} __packed;
+
+struct goodix_ic_info_version {
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
+struct goodix_ic_info_feature { /* feature info*/
+	u16 freqhop_feature;
+	u16 calibration_feature;
+	u16 gesture_feature;
+	u16 side_touch_feature;
+	u16 stylus_feature;
+} __packed;
+
+struct goodix_ic_info_param { /* param */
+	u8 drv_num;
+	u8 sen_num;
+	u8 button_num;
+	u8 force_num;
+	u8 active_scan_rate_num;
+	u16 active_scan_rate[MAX_SCAN_RATE_NUM];
+	u8 mutual_freq_num;
+	u16 mutual_freq[MAX_SCAN_FREQ_NUM];
+	u8 self_tx_freq_num;
+	u16 self_tx_freq[MAX_SCAN_FREQ_NUM];
+	u8 self_rx_freq_num;
+	u16 self_rx_freq[MAX_SCAN_FREQ_NUM];
+	u8 stylus_freq_num;
+	u16 stylus_freq[MAX_FREQ_NUM_STYLUS];
+} __packed;
+
+struct goodix_ic_info_misc { /* other data */
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
+struct goodix_ic_info {
+	u16 length;
+	struct goodix_ic_info_version version;
+	struct goodix_ic_info_feature feature;
+	struct goodix_ic_info_param parm;
+	struct goodix_ic_info_misc misc;
+} __packed;
+
+/* interrupt event type */
+enum ts_event_type {
+	EVENT_INVALID,
+	EVENT_TOUCH, /* finger touch event */
+	EVENT_REQUEST,
+};
+
+enum ts_request_type {
+	REQUEST_TYPE_RESET,
+};
+
+enum touch_point_status {
+	TS_NONE,
+	TS_RELEASE,
+	TS_TOUCH,
+};
+
+/* coordinate package */
+struct goodix_berlin_coords {
+	int status; /* NONE, RELEASE, TOUCH */
+	unsigned int x, y, w, p;
+};
+
+/* touch event data */
+struct goodix_touch_data {
+	int touch_num;
+	struct goodix_berlin_coords coords[GOODIX_MAX_TOUCH];
+};
+
+/* touch event struct */
+struct goodix_berlin_event {
+	enum ts_event_type event_type;
+	u8 request_code; /* represent the request type */
+	struct goodix_touch_data touch_data;
+};
+
+struct goodix_berlin_core {
+	struct device *dev;
+	struct regmap *regmap;
+
+	struct regulator *avdd;
+	struct regulator *iovdd;
+	struct gpio_desc *reset_gpio;
+
+	struct touchscreen_properties props;
+
+	struct goodix_fw_version fw_version;
+	struct goodix_ic_info ic_info;
+
+	struct input_dev *input_dev;
+	struct goodix_berlin_event ts_event;
+
+	int irq;
+
+	struct dentry *debugfs_root;
+};
+
+u32 goodix_append_checksum(u8 *data, int len, int mode);
+int checksum_cmp(const u8 *data, int size, int mode);
+int is_risk_data(const u8 *data, int size);
+u32 goodix_get_file_config_id(u8 *ic_config);
+void goodix_rotate_abcd2cbad(int tx, int rx, s16 *data);
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap);
+int goodix_berlin_remove(struct device *dev);
+
+extern const struct dev_pm_ops goodix_berlin_pm_ops;
+
+#endif
diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
new file mode 100644
index 000000000000..0719690a5bd3
--- /dev/null
+++ b/drivers/input/touchscreen/goodix_berlin_core.c
@@ -0,0 +1,935 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Goodix Touchscreen Driver
+ * Copyright (C) 2020 - 2021 Goodix, Inc.
+ * Copyright (C) 2023 Linaro Ltd.
+ *
+ * Based on goodix_ts_berlin driver.
+ */
+#include <linux/regmap.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/debugfs.h>
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
+ * - PEN Events
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
+static bool goodix_berlin_is_risk_data(struct goodix_berlin_core *cd,
+				       const u8 *data, int size)
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
+	u8 tx_buf[8] = { 0 };
+	u8 rx_buf[8] = { 0 };
+	int retry = 3;
+	int ret = 0;
+
+	memset(tx_buf, DEV_CONFIRM_VAL, sizeof(tx_buf));
+	while (retry--) {
+		ret = regmap_raw_write(cd->regmap, BOOTOPTION_ADDR, tx_buf,
+				       sizeof(tx_buf));
+		if (ret < 0)
+			return ret;
+		ret = regmap_raw_read(cd->regmap, BOOTOPTION_ADDR, rx_buf,
+				      sizeof(rx_buf));
+		if (ret < 0)
+			return ret;
+		if (!memcmp(tx_buf, rx_buf, sizeof(tx_buf)))
+			break;
+		usleep_range(5000, 5100);
+	}
+
+	if (retry < 0) {
+		ret = -EINVAL;
+		dev_err(cd->dev, "device confirm failed, rx_buf: %*ph\n", 8, rx_buf);
+	}
+
+	return ret;
+}
+
+static int goodix_berlin_power_on(struct goodix_berlin_core *cd, bool on)
+{
+	int ret = 0;
+
+	if (on) {
+		ret = regulator_enable(cd->iovdd);
+		if (ret < 0) {
+			dev_err(cd->dev, "Failed to enable iovdd: %d\n", ret);
+			goto power_off;
+		}
+
+		usleep_range(3000, 3100);
+
+		ret = regulator_enable(cd->avdd);
+		if (ret < 0) {
+			dev_err(cd->dev, "Failed to enable avdd: %d\n", ret);
+			goto power_off;
+		}
+
+		usleep_range(15000, 15100);
+
+		gpiod_set_value(cd->reset_gpio, 0);
+
+		usleep_range(4000, 4100);
+
+		ret = goodix_berlin_dev_confirm(cd);
+		if (ret < 0)
+			goto power_off;
+
+		msleep(GOODIX_NORMAL_RESET_DELAY_MS);
+
+		return 0;
+	}
+
+power_off:
+	gpiod_set_value(cd->reset_gpio, 1);
+	regulator_disable(cd->iovdd);
+	regulator_disable(cd->avdd);
+	return ret;
+}
+
+static int goodix_berlin_do_suspend(struct goodix_berlin_core *cd)
+{
+	if (goodix_berlin_power_on(cd, 0))
+		dev_err(cd->dev, "failed power off\n");
+
+	return 0;
+}
+
+static int goodix_berlin_do_resume(struct goodix_berlin_core *cd)
+{
+	int ret = 0;
+
+	ret = goodix_berlin_power_on(cd, 1);
+	if (ret) {
+		dev_err(cd->dev, "failed power on\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int goodix_berlin_reset(struct goodix_berlin_core *cd, int delay)
+{
+	gpiod_set_value(cd->reset_gpio, 1);
+	usleep_range(2000, 2100);
+	gpiod_set_value(cd->reset_gpio, 0);
+
+	if (delay < 20)
+		usleep_range(delay * 1000, delay * 1000 + 100);
+	else
+		msleep(delay);
+
+	return 0;
+}
+
+static int goodix_berlin_irq_enable(struct goodix_berlin_core *cd, bool enable)
+{
+	if (enable)
+		enable_irq(cd->irq);
+	else
+		disable_irq(cd->irq);
+
+	return 0;
+}
+
+static int goodix_berlin_read_version(struct goodix_berlin_core *cd,
+				      struct goodix_fw_version *version)
+{
+	u8 buf[sizeof(struct goodix_fw_version)] = { 0 };
+	int ret, i;
+
+	for (i = 0; i < 2; i++) {
+		ret = regmap_raw_read(cd->regmap, FW_VERSION_INFO_ADDR, buf, sizeof(buf));
+		if (ret) {
+			dev_dbg(cd->dev, "read fw version: %d, retry %d\n", ret, i);
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		if (goodix_berlin_check_checksum(buf, sizeof(buf)))
+			break;
+
+		dev_dbg(cd->dev, "invalid fw version: checksum error\n");
+
+		ret = -EINVAL;
+		usleep_range(10000, 11000);
+	}
+
+	if (ret) {
+		dev_err(cd->dev, "failed to get fw version");
+		return ret;
+	}
+
+	memcpy(version, buf, sizeof(*version));
+
+	return 0;
+}
+
+static int goodix_berlin_fw_version_show(struct seq_file *s, void *unused)
+{
+	struct goodix_berlin_core *cd = s->private;
+	struct goodix_fw_version *version = &cd->fw_version;
+	u8 temp_pid[9] = { 0 };
+
+	memcpy(temp_pid, version->rom_pid, sizeof(version->rom_pid));
+	temp_pid[sizeof(version->rom_pid)] = '\0';
+
+	seq_printf(s, "rom_pid: %s\n", temp_pid);
+	seq_printf(s, "rom_vid: %*ph\n",
+		   (int)sizeof(version->rom_vid),
+		   version->rom_vid);
+
+	memcpy(temp_pid, version->patch_pid, sizeof(version->patch_pid));
+	temp_pid[sizeof(version->patch_pid)] = '\0';
+
+	seq_printf(s, "patch_pid: %s\n", temp_pid);
+	seq_printf(s, "patch_vid: %*ph\n",
+		   (int)sizeof(version->patch_vid),
+		   version->patch_vid);
+	seq_printf(s, "sensor_id: %d\n",
+		   version->sensor_id);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(goodix_berlin_fw_version);
+
+static int goodix_berlin_convert_ic_info(struct goodix_berlin_core *cd,
+					 struct goodix_ic_info *info,
+					 const u8 *data)
+{
+	int i;
+	struct goodix_ic_info_version *version = &info->version;
+	struct goodix_ic_info_feature *feature = &info->feature;
+	struct goodix_ic_info_param *parm = &info->parm;
+	struct goodix_ic_info_misc *misc = &info->misc;
+
+	info->length = le16_to_cpup((__le16 *)data);
+
+	data += 2;
+	memcpy(version, data, sizeof(*version));
+	version->config_id = le32_to_cpu(version->config_id);
+
+	data += sizeof(struct goodix_ic_info_version);
+	memcpy(feature, data, sizeof(*feature));
+	feature->freqhop_feature = le16_to_cpu(feature->freqhop_feature);
+	feature->calibration_feature =
+		le16_to_cpu(feature->calibration_feature);
+	feature->gesture_feature = le16_to_cpu(feature->gesture_feature);
+	feature->side_touch_feature = le16_to_cpu(feature->side_touch_feature);
+	feature->stylus_feature = le16_to_cpu(feature->stylus_feature);
+
+	data += sizeof(struct goodix_ic_info_feature);
+	parm->drv_num = *(data++);
+	parm->sen_num = *(data++);
+	parm->button_num = *(data++);
+	parm->force_num = *(data++);
+	parm->active_scan_rate_num = *(data++);
+
+	if (parm->active_scan_rate_num > MAX_SCAN_RATE_NUM) {
+		dev_err(cd->dev, "invalid scan rate num %d > %d\n",
+			parm->active_scan_rate_num, MAX_SCAN_RATE_NUM);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < parm->active_scan_rate_num; i++)
+		parm->active_scan_rate[i] =
+			le16_to_cpup((__le16 *)(data + i * 2));
+
+	data += parm->active_scan_rate_num * 2;
+	parm->mutual_freq_num = *(data++);
+
+	if (parm->mutual_freq_num > MAX_SCAN_FREQ_NUM) {
+		dev_err(cd->dev, "invalid mntual freq num %d > %d\n",
+			parm->mutual_freq_num, MAX_SCAN_FREQ_NUM);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < parm->mutual_freq_num; i++)
+		parm->mutual_freq[i] = le16_to_cpup((__le16 *)(data + i * 2));
+
+	data += parm->mutual_freq_num * 2;
+	parm->self_tx_freq_num = *(data++);
+
+	if (parm->self_tx_freq_num > MAX_SCAN_FREQ_NUM) {
+		dev_err(cd->dev, "invalid tx freq num %d > %d\n",
+			parm->self_tx_freq_num, MAX_SCAN_FREQ_NUM);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < parm->self_tx_freq_num; i++)
+		parm->self_tx_freq[i] = le16_to_cpup((__le16 *)(data + i * 2));
+
+	data += parm->self_tx_freq_num * 2;
+	parm->self_rx_freq_num = *(data++);
+
+	if (parm->self_rx_freq_num > MAX_SCAN_FREQ_NUM) {
+		dev_err(cd->dev, "invalid rx freq num %d > %d\n",
+			parm->self_rx_freq_num, MAX_SCAN_FREQ_NUM);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < parm->self_rx_freq_num; i++)
+		parm->self_rx_freq[i] = le16_to_cpup((__le16 *)(data + i * 2));
+
+	data += parm->self_rx_freq_num * 2;
+	parm->stylus_freq_num = *(data++);
+
+	if (parm->stylus_freq_num > MAX_FREQ_NUM_STYLUS) {
+		dev_err(cd->dev, "invalid stylus freq num %d > %d\n",
+			parm->stylus_freq_num, MAX_FREQ_NUM_STYLUS);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < parm->stylus_freq_num; i++)
+		parm->stylus_freq[i] = le16_to_cpup((__le16 *)(data + i * 2));
+
+	data += parm->stylus_freq_num * 2;
+	memcpy(misc, data, sizeof(*misc));
+	misc->cmd_addr = le32_to_cpu(misc->cmd_addr);
+	misc->cmd_max_len = le16_to_cpu(misc->cmd_max_len);
+	misc->cmd_reply_addr = le32_to_cpu(misc->cmd_reply_addr);
+	misc->cmd_reply_len = le16_to_cpu(misc->cmd_reply_len);
+	misc->fw_state_addr = le32_to_cpu(misc->fw_state_addr);
+	misc->fw_state_len = le16_to_cpu(misc->fw_state_len);
+	misc->fw_buffer_addr = le32_to_cpu(misc->fw_buffer_addr);
+	misc->fw_buffer_max_len = le16_to_cpu(misc->fw_buffer_max_len);
+	misc->frame_data_addr = le32_to_cpu(misc->frame_data_addr);
+	misc->frame_data_head_len = le16_to_cpu(misc->frame_data_head_len);
+
+	misc->fw_attr_len = le16_to_cpu(misc->fw_attr_len);
+	misc->fw_log_len = le16_to_cpu(misc->fw_log_len);
+	misc->stylus_struct_len = le16_to_cpu(misc->stylus_struct_len);
+	misc->mutual_struct_len = le16_to_cpu(misc->mutual_struct_len);
+	misc->self_struct_len = le16_to_cpu(misc->self_struct_len);
+	misc->noise_struct_len = le16_to_cpu(misc->noise_struct_len);
+	misc->touch_data_addr = le32_to_cpu(misc->touch_data_addr);
+	misc->touch_data_head_len = le16_to_cpu(misc->touch_data_head_len);
+	misc->point_struct_len = le16_to_cpu(misc->point_struct_len);
+	misc->mutual_rawdata_addr = le32_to_cpu(misc->mutual_rawdata_addr);
+	misc->mutual_diffdata_addr = le32_to_cpu(misc->mutual_diffdata_addr);
+	misc->mutual_refdata_addr = le32_to_cpu(misc->mutual_refdata_addr);
+	misc->self_rawdata_addr = le32_to_cpu(misc->self_rawdata_addr);
+	misc->self_diffdata_addr = le32_to_cpu(misc->self_diffdata_addr);
+	misc->self_refdata_addr = le32_to_cpu(misc->self_refdata_addr);
+	misc->iq_rawdata_addr = le32_to_cpu(misc->iq_rawdata_addr);
+	misc->iq_refdata_addr = le32_to_cpu(misc->iq_refdata_addr);
+	misc->im_rawdata_addr = le32_to_cpu(misc->im_rawdata_addr);
+	misc->im_readata_len = le16_to_cpu(misc->im_readata_len);
+	misc->noise_rawdata_addr = le32_to_cpu(misc->noise_rawdata_addr);
+	misc->noise_rawdata_len = le16_to_cpu(misc->noise_rawdata_len);
+	misc->stylus_rawdata_addr = le32_to_cpu(misc->stylus_rawdata_addr);
+	misc->stylus_rawdata_len = le16_to_cpu(misc->stylus_rawdata_len);
+	misc->noise_data_addr = le32_to_cpu(misc->noise_data_addr);
+	misc->esd_addr = le32_to_cpu(misc->esd_addr);
+
+	return 0;
+}
+
+/* Convert to debugfs */
+static int goodix_berlin_ic_info_show(struct seq_file *s, void *unused)
+{
+	struct goodix_berlin_core *cd = s->private;
+	struct goodix_ic_info_version *version = &cd->ic_info.version;
+	struct goodix_ic_info_feature *feature = &cd->ic_info.feature;
+	struct goodix_ic_info_param *parm = &cd->ic_info.parm;
+	struct goodix_ic_info_misc *misc = &cd->ic_info.misc;
+
+	seq_printf(s, "ic_info_length:                %d\n", cd->ic_info.length);
+	seq_printf(s, "info_customer_id:              0x%01X\n",
+		   version->info_customer_id);
+	seq_printf(s, "info_version_id:               0x%01X\n",
+		   version->info_version_id);
+	seq_printf(s, "ic_die_id:                     0x%01X\n",
+		   version->ic_die_id);
+	seq_printf(s, "ic_version_id:                 0x%01X\n",
+		   version->ic_version_id);
+	seq_printf(s, "config_id:                     0x%4X\n",
+		   version->config_id);
+	seq_printf(s, "config_version:                0x%01X\n",
+		   version->config_version);
+	seq_printf(s, "frame_data_customer_id:        0x%01X\n",
+		   version->frame_data_customer_id);
+	seq_printf(s, "frame_data_version_id:         0x%01X\n",
+		   version->frame_data_version_id);
+	seq_printf(s, "touch_data_customer_id:        0x%01X\n",
+		   version->touch_data_customer_id);
+	seq_printf(s, "touch_data_version_id:         0x%01X\n",
+		   version->touch_data_version_id);
+	seq_printf(s, "freqhop_feature:               0x%04X\n",
+		   feature->freqhop_feature);
+	seq_printf(s, "calibration_feature:           0x%04X\n",
+		   feature->calibration_feature);
+	seq_printf(s, "gesture_feature:               0x%04X\n",
+		   feature->gesture_feature);
+	seq_printf(s, "side_touch_feature:            0x%04X\n",
+		   feature->side_touch_feature);
+	seq_printf(s, "stylus_feature:                0x%04X\n",
+		   feature->stylus_feature);
+	seq_printf(s, "Drv*Sen,Button,Force num:      %d x %d, %d, %d\n",
+		   parm->drv_num, parm->sen_num, parm->button_num, parm->force_num);
+	seq_printf(s, "Cmd:                           0x%04X, %d\n",
+		   misc->cmd_addr, misc->cmd_max_len);
+	seq_printf(s, "Cmd-Reply:                     0x%04X, %d\n",
+		   misc->cmd_reply_addr, misc->cmd_reply_len);
+	seq_printf(s, "FW-State:                      0x%04X, %d\n",
+		   misc->fw_state_addr, misc->fw_state_len);
+	seq_printf(s, "FW-Buffer:                     0x%04X, %d\n",
+		   misc->fw_buffer_addr, misc->fw_buffer_max_len);
+	seq_printf(s, "Touch-Data:                    0x%04X, %d\n",
+		   misc->touch_data_addr, misc->touch_data_head_len);
+	seq_printf(s, "point_struct_len:              %d\n",
+		   misc->point_struct_len);
+	seq_printf(s, "mutual_rawdata_addr:           0x%04X\n",
+		   misc->mutual_rawdata_addr);
+	seq_printf(s, "mutual_diffdata_addr:          0x%04X\n",
+		   misc->mutual_diffdata_addr);
+	seq_printf(s, "self_rawdata_addr:             0x%04X\n",
+		   misc->self_rawdata_addr);
+	seq_printf(s, "self_diffdata_addr:            0x%04X\n",
+		   misc->self_diffdata_addr);
+	seq_printf(s, "stylus_rawdata_addr:           0x%04X, %d\n",
+		   misc->stylus_rawdata_addr, misc->stylus_rawdata_len);
+	seq_printf(s, "esd_addr:                      0x%04X\n",
+		   misc->esd_addr);
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(goodix_berlin_ic_info);
+
+static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd,
+				     struct goodix_ic_info *ic_info)
+{
+	int ret, i;
+	u16 length = 0;
+	u32 ic_addr;
+	u8 afe_data[GOODIX_IC_INFO_MAX_LEN] = { 0 };
+
+	ic_addr = GOODIX_IC_INFO_ADDR;
+
+	for (i = 0; i < 3; i++) {
+		ret = regmap_raw_read(cd->regmap, ic_addr, (u8 *)&length, sizeof(length));
+		if (ret) {
+			dev_info(cd->dev, "failed get ic info length, %d\n", ret);
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
+		ret = regmap_raw_read(cd->regmap, ic_addr, afe_data, length);
+		if (ret) {
+			dev_info(cd->dev, "failed get ic info data, %d\n", ret);
+			usleep_range(5000, 5100);
+			continue;
+		}
+
+		/* judge whether the data is valid */
+		if (goodix_berlin_is_risk_data(cd, (const uint8_t *)afe_data,
+					       length)) {
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
+	ret = goodix_berlin_convert_ic_info(cd, ic_info, afe_data);
+	if (ret) {
+		dev_err(cd->dev, "error converting ic info\n");
+		return ret;
+	}
+
+	/* check some key info */
+	if (!ic_info->misc.cmd_addr || !ic_info->misc.fw_buffer_addr ||
+	    !ic_info->misc.touch_data_addr) {
+		dev_err(cd->dev, "cmd_addr fw_buf_addr and touch_data_addr is null\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int goodix_berlin_after_event_handler(struct goodix_berlin_core *cd)
+{
+	struct goodix_ic_info_misc *misc = &cd->ic_info.misc;
+	u8 sync_clean = 0;
+
+	return regmap_raw_write(cd->regmap, misc->touch_data_addr, &sync_clean, 1);
+}
+
+static void goodix_berlin_parse_finger(struct goodix_berlin_core *cd,
+				       struct goodix_touch_data *touch_data,
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
+		touch_data->coords[id].status = TS_TOUCH;
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
+	struct goodix_touch_data *touch_data = &cd->ts_event.touch_data;
+	struct goodix_ic_info_misc *misc = &cd->ic_info.misc;
+	u8 point_type = 0;
+	u8 touch_num = 0;
+	int ret = 0;
+
+	/* clean event buffer */
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
+		ret = regmap_raw_read(cd->regmap,
+				      misc->touch_data_addr + pre_buf_len,
+				      &buffer[pre_buf_len],
+				      (touch_num - 2) * BYTES_PER_POINT);
+		if (ret) {
+			dev_err(cd->dev, "failed get touch data\n");
+			return ret;
+		}
+	}
+
+	/* read done */
+	goodix_berlin_after_event_handler(cd);
+
+	if (touch_num == 0)
+		return 0;
+
+	point_type = buffer[IRQ_EVENT_HEAD_LEN] & 0x0F;
+
+	/* TOFIX: Not handled */
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
+	cd->ts_event.event_type = EVENT_TOUCH;
+	goodix_berlin_parse_finger(cd, touch_data, buffer, touch_num);
+
+	return 0;
+}
+
+static int goodix_berlin_event_handler(struct goodix_berlin_core *cd)
+{
+	struct goodix_ic_info_misc *misc = &cd->ic_info.misc;
+	int pre_read_len;
+	u8 pre_buf[32];
+	u8 event_status;
+	int ret;
+
+	pre_read_len = IRQ_EVENT_HEAD_LEN + BYTES_PER_POINT * 2 +
+		       COOR_DATA_CHECKSUM_SIZE;
+
+	ret = regmap_raw_read(cd->regmap, misc->touch_data_addr, pre_buf,
+			      pre_read_len);
+	if (ret) {
+		dev_err(cd->dev, "failed get event head data\n");
+		return ret;
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
+		cd->ts_event.event_type = EVENT_REQUEST;
+		if (pre_buf[2] == BRL_REQUEST_CODE_RESET)
+			cd->ts_event.request_code = REQUEST_TYPE_RESET;
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
+	struct goodix_touch_data *touch_data = &cd->ts_event.touch_data;
+	int i;
+
+	mutex_lock(&cd->input_dev->mutex);
+
+	for (i = 0; i < GOODIX_MAX_TOUCH; i++) {
+		if (touch_data->coords[i].status == TS_TOUCH) {
+			dev_dbg(cd->dev, "report: id[%d], x %d, y %d, w %d\n", i,
+				touch_data->coords[i].x,
+				touch_data->coords[i].y,
+				touch_data->coords[i].w);
+
+			input_mt_slot(cd->input_dev, i);
+			input_mt_report_slot_state(cd->input_dev,
+						   MT_TOOL_FINGER, true);
+			touchscreen_report_pos(cd->input_dev, &cd->props,
+					       touch_data->coords[i].x,
+					       touch_data->coords[i].y, true);
+			input_report_abs(cd->input_dev, ABS_MT_TOUCH_MAJOR,
+					 touch_data->coords[i].w);
+		} else {
+			input_mt_slot(cd->input_dev, i);
+			input_mt_report_slot_state(cd->input_dev,
+						   MT_TOOL_FINGER, false);
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
+	if (cd->ts_event.request_code != REQUEST_TYPE_RESET) {
+		dev_info(cd->dev, "can't handle request type 0x%x\n",
+			 cd->ts_event.request_code);
+		return -EINVAL;
+	}
+
+	return goodix_berlin_reset(cd, GOODIX_NORMAL_RESET_DELAY_MS);
+}
+
+static irqreturn_t goodix_berlin_threadirq_func(int irq, void *data)
+{
+	struct goodix_berlin_core *cd = data;
+	int ret;
+
+	ret = goodix_berlin_event_handler(cd);
+	if (likely(!ret)) {
+		switch (cd->ts_event.event_type) {
+		case EVENT_TOUCH:
+			goodix_berlin_report_finger(cd);
+			break;
+
+		case EVENT_REQUEST:
+			goodix_berlin_request_handle(cd);
+			break;
+
+		/* TOFIX: Handle more request types */
+		case EVENT_INVALID:
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
+	struct input_dev *input_dev = devm_input_allocate_device(cd->dev);
+
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
+	/* set input parameters */
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_X, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_POSITION_Y, 0, SZ_64K - 1, 0, 0);
+	input_set_abs_params(cd->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	/* Override with DT */
+	touchscreen_parse_properties(cd->input_dev, true, &cd->props);
+
+	input_mt_init_slots(cd->input_dev, GOODIX_MAX_TOUCH, INPUT_MT_DIRECT);
+
+	return input_register_device(cd->input_dev);
+}
+
+static void goodix_berlin_release_connects(struct goodix_berlin_core *cd)
+{
+	struct input_dev *input_dev = cd->input_dev;
+	int i;
+
+	mutex_lock(&input_dev->mutex);
+
+	for (i = 0; i < GOODIX_MAX_TOUCH; i++) {
+		input_mt_slot(input_dev, i);
+		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, false);
+	}
+	input_mt_sync_frame(input_dev);
+	input_sync(input_dev);
+
+	mutex_unlock(&input_dev->mutex);
+}
+
+static int goodix_berlin_suspend(struct goodix_berlin_core *cd)
+{
+	/* disable irq */
+	goodix_berlin_irq_enable(cd, false);
+
+	/* enter sleep mode or power off */
+	goodix_berlin_do_suspend(cd);
+
+	goodix_berlin_release_connects(cd);
+
+	return 0;
+}
+
+static int goodix_berlin_resume(struct goodix_berlin_core *cd)
+{
+	goodix_berlin_irq_enable(cd, false);
+
+	/* reset device or power on*/
+	goodix_berlin_do_resume(cd);
+
+	/* enable irq */
+	goodix_berlin_irq_enable(cd, true);
+
+	return 0;
+}
+
+int goodix_berlin_pm_suspend(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+
+	return goodix_berlin_suspend(cd);
+}
+
+int goodix_berlin_pm_resume(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+
+	return goodix_berlin_resume(cd);
+}
+
+EXPORT_GPL_SIMPLE_DEV_PM_OPS(goodix_berlin_pm_ops,
+			     goodix_berlin_pm_suspend,
+			     goodix_berlin_pm_resume);
+
+int goodix_berlin_probe(struct device *dev, int irq, const struct input_id *id,
+			struct regmap *regmap)
+{
+	struct goodix_berlin_core *cd;
+	int ret;
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
+	cd->reset_gpio = devm_gpiod_get(cd->dev, "reset", GPIOF_OUT_INIT_HIGH);
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
+	ret = goodix_berlin_input_dev_config(cd, id);
+	if (ret < 0) {
+		dev_err(cd->dev, "failed set input device");
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					goodix_berlin_threadirq_func,
+					IRQF_ONESHOT, "goodix-berlin", cd);
+	if (ret) {
+		dev_err(dev, "request threaded irq failed: %d\n", ret);
+		return ret;
+	}
+
+	dev_set_drvdata(dev, cd);
+
+	ret = goodix_berlin_power_on(cd, true);
+	if (ret) {
+		dev_err(cd->dev, "failed power on");
+		goto err_out;
+	}
+
+	ret = goodix_berlin_read_version(cd, &cd->fw_version);
+	if (ret < 0) {
+		dev_err(cd->dev, "failed to get version info");
+		goto err_out;
+	}
+
+	ret = goodix_berlin_get_ic_info(cd, &cd->ic_info);
+	if (ret) {
+		dev_err(cd->dev, "invalid ic info, abort");
+		goto err_out;
+	}
+
+	cd->debugfs_root = debugfs_create_dir(dev_name(dev), NULL);
+	debugfs_create_file("fw_version", 0444, cd->debugfs_root,
+			    cd, &goodix_berlin_fw_version_fops);
+	debugfs_create_file("ic_info", 0444, cd->debugfs_root,
+			    cd, &goodix_berlin_ic_info_fops);
+
+	dev_info(cd->dev, "Goodix Berlin %s Touchscreen Controller", cd->fw_version.patch_pid);
+
+	return 0;
+
+err_out:
+	goodix_berlin_power_on(cd, false);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(goodix_berlin_probe);
+
+int goodix_berlin_remove(struct device *dev)
+{
+	struct goodix_berlin_core *cd = dev_get_drvdata(dev);
+
+	goodix_berlin_release_connects(cd);
+
+	goodix_berlin_irq_enable(cd, false);
+
+	goodix_berlin_power_on(cd, false);
+
+	debugfs_remove(cd->debugfs_root);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(goodix_berlin_remove);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Goodix Berlin Core Touchscreen driver");
+MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");

-- 
2.34.1

