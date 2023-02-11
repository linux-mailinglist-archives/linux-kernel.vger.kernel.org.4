Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821B76930C3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKL6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjBKL6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:58:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A6311D3;
        Sat, 11 Feb 2023 03:58:11 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so8071747wma.1;
        Sat, 11 Feb 2023 03:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grc+1q9uM9hwHLyxjineZTEWNKp77U71L22yOni6MBg=;
        b=KZkBfcKcXUr7dW92bI0zyxKvhQ0XxRlrFYwgJiXAMtJ57oIU22U+EQ9TYVkfnRIGbp
         KefclW+P3D4bN3lXySCoKIOgE/gUKSljAqQRQxtG9/TPjSsFptOMZnyxnKk1IMDk6CCf
         v4lB89guQSWp9CIb4mswJOSa+hNiHX/QTawspumgIPDxAWrZ9qxGHLoW5UgaMny1ATpa
         OGKKSdJAScAXgnZLXxzmnFGpHc9YNS9VdU95fxJ04UOydD1Ws4yN/N1M+ZL8zVCBLEEj
         1UrKVsMPN86XxXxuynHrY9Y8ehCWgbgkK22GEhsGa+YErbKn/KwFq/iiSXTM8cUZHs8o
         netg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grc+1q9uM9hwHLyxjineZTEWNKp77U71L22yOni6MBg=;
        b=T97vV+bKJaQICUgu1qiTPjX6JZbXeQ9ZlyR8uOXoVLpiHKJEsOvxwyJCZRnH1ik6mN
         Gw40JEdv5Ia5yy/Cyzp9p+VFFN94y/3/LZURb7YX71VYM27i7w8n49OFGMJtXZ2eDz9d
         WAPjgwVEikDlHZJ6Fu0iRUquxv+Stk7EUMZ38+WHqprufykWQ1gl3/XaPbH6afEroGxB
         C3hQnQU00EyODhWhQ5BG8D8E0Rh93KZrQNjQb5XXvIHmjB4oh2U03orUhAF7WHOyhy4k
         5nvKXSBwfHKRij4ZAkPStpsfgj0y4viTLbpvTIs5XgkstcwSaRs0i5Y9iqN/3sku/oMt
         xaKw==
X-Gm-Message-State: AO0yUKXVv5s3U5qMlbNfXe4CDNoqmHVtelz6S+qUjCwdBCMaLRzB+799
        TgUgUKYnyZqeBst8y8DCEY7kdVZvD29Ljw==
X-Google-Smtp-Source: AK7set8rVILHAbyvyhl1UGAiCB/1ULHWuC5KmURyysT8r7XdBaaQXFJZjpih6zpZ8U1o43rrb1oeHQ==
X-Received: by 2002:a05:600c:502b:b0:3dc:c05:9db6 with SMTP id n43-20020a05600c502b00b003dc0c059db6mr14691538wmr.33.1676116690312;
        Sat, 11 Feb 2023 03:58:10 -0800 (PST)
Received: from michael-VirtualBox.. (109-186-125-17.bb.netvision.net.il. [109.186.125.17])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b003e01493b136sm11646027wms.43.2023.02.11.03.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 03:58:09 -0800 (PST)
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     jikos@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v1 1/1] HID: ft260: add GPIO support
Date:   Sat, 11 Feb 2023 13:57:52 +0200
Message-Id: <20230211115752.26276-2-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230211115752.26276-1-michael.zaidman@gmail.com>
References: <20230211115752.26276-1-michael.zaidman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FTDI FT260 chip has 14 multi-function pins. Each pin can be
set as I2C/UART-related function or GPIO. Some GPIO functions are
destined for applications like TX_ACTIVE, TX_LED, RX_LED for UART;
SUSPOUT_N, WAKEUP for USB; PWREN, and BCD_DET indicator for power
management. The driver enables the GPIO pins according to the
chip's current I2C/UART configuration.

The FT260 has three pins that have more than two functions:
GPIO 2(pin 14), GPIOA (pin 7), and GPIOG (pin 27). The user can
change the function of these pins via eFUSE, EEPROM, or sysfs
interface.

For GPIO usage examples and tips, see
https://github.com/MichaelZaidman/hid-ft260#readme

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 476 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 447 insertions(+), 29 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 333341e80b0e..d8ade83b3f10 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/usb.h>
+#include <linux/gpio/driver.h>
 
 #ifdef DEBUG
 static int ft260_debug = 1;
@@ -29,7 +30,7 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 	} while (0)
 
 #define FT260_REPORT_MAX_LENGTH (64)
-#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+#define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + ((len) - 1) / 4)
 
 #define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
 
@@ -47,6 +48,12 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 #define FT260_RD_DATA_MAX (180)
 #define FT260_WR_DATA_MAX (60)
 
+#define FT260_GPIOCHIP "ft260_gpio"
+#define FT260_GPIO_MAX (6)
+#define FT260_GPIO_EX_MAX (8)
+#define FT260_GPIO_TOTAL (FT260_GPIO_MAX + FT260_GPIO_EX_MAX)
+#define FT260_GPIO_MASK (~(0xffff << FT260_GPIO_TOTAL))
+
 /*
  * Device interface configuration.
  * The FT260 has 2 interfaces that are controlled by DCNF0 and DCNF1 pins.
@@ -132,7 +139,55 @@ enum {
 	FT260_FLAG_START_STOP_REPEATED	= 0x07,
 };
 
-#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | report_id)
+/* Multi-function pin functions */
+enum {
+	FT260_MFPIN_GPIO		= 0x00,
+	FT260_MFPIN_SUSPOUT		= 0x01,
+	FT260_MFPIN_PWREN		= 0x02,
+	FT260_MFPIN_TX_ACTIVE		= 0x03,
+	FT260_MFPIN_TX_LED		= 0x04,
+	FT260_MFPIN_RX_LED		= 0x05,
+	FT260_MFPIN_BCD_DET		= 0x06,
+};
+
+enum {
+	FT260_GPIO_VALUE		= 0x00,
+	FT260_GPIO_DIRECTION		= 0x01,
+	FT260_GPIO_DIR_INPUT		= 0x00,
+	FT260_GPIO_DIR_OUTPUT		= 0x01,
+};
+
+/* GPIO offsets */
+enum {
+	FT260_GPIO_0			= (1 << 0),
+	FT260_GPIO_1			= (1 << 1),
+	FT260_GPIO_2			= (1 << 2),
+	FT260_GPIO_3			= (1 << 3),
+	FT260_GPIO_4			= (1 << 4),
+	FT260_GPIO_5			= (1 << 5),
+	FT260_GPIO_A			= (1 << (FT260_GPIO_MAX + 0)),
+	FT260_GPIO_B			= (1 << (FT260_GPIO_MAX + 1)),
+	FT260_GPIO_C			= (1 << (FT260_GPIO_MAX + 2)),
+	FT260_GPIO_D			= (1 << (FT260_GPIO_MAX + 3)),
+	FT260_GPIO_E			= (1 << (FT260_GPIO_MAX + 4)),
+	FT260_GPIO_F			= (1 << (FT260_GPIO_MAX + 5)),
+	FT260_GPIO_G			= (1 << (FT260_GPIO_MAX + 6)),
+	FT260_GPIO_H			= (1 << (FT260_GPIO_MAX + 7)),
+};
+
+/* GPIO groups */
+enum {
+	FT260_GPIO_WAKEUP		= (FT260_GPIO_3),
+	FT260_GPIO_I2C_DEFAULT		= (FT260_GPIO_0 | FT260_GPIO_1),
+	FT260_GPIO_UART_DCD_RI		= (FT260_GPIO_4 | FT260_GPIO_5),
+	FT260_GPIO_UART			= (FT260_GPIO_B | FT260_GPIO_C |
+					   FT260_GPIO_D | FT260_GPIO_E |
+					   FT260_GPIO_F | FT260_GPIO_H),
+	FT260_GPIO_UART_DEFAULT		= (FT260_GPIO_UART |
+					   FT260_GPIO_UART_DCD_RI),
+};
+
+#define FT260_SET_REQUEST_VALUE(report_id) ((FT260_FEATURE << 8) | (report_id))
 
 /* Feature In reports */
 
@@ -152,10 +207,10 @@ struct ft260_get_system_status_report {
 	u8 uart_mode;		/* 0 - OFF; 1 - RTS_CTS, 2 - DTR_DSR, */
 				/* 3 - XON_XOFF, 4 - No flow control */
 	u8 hid_over_i2c_en;	/* 0 - disabled, 1 - enabled */
-	u8 gpio2_function;	/* 0 - GPIO,  1 - SUSPOUT, */
+	u8 gpio2_func;		/* 0 - GPIO,  1 - SUSPOUT, */
 				/* 2 - PWREN, 4 - TX_LED */
-	u8 gpioA_function;	/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
-	u8 gpioG_function;	/* 0 - GPIO, 2 - PWREN, */
+	u8 gpioa_func;		/* 0 - GPIO, 3 - TX_ACTIVE, 4 - TX_LED */
+	u8 gpiog_func;		/* 0 - GPIO, 2 - PWREN, */
 				/* 5 - RX_LED, 6 - BCD_DET */
 	u8 suspend_out_pol;	/* 0 - active-high, 1 - active-low */
 	u8 enable_wakeup_int;	/* 0 - disabled, 1 - enabled */
@@ -171,6 +226,18 @@ struct ft260_get_i2c_status_report {
 	u8 reserved;
 } __packed;
 
+struct ft260_gpio_state {
+	u8 vals;		/* GPIO[0-5] values in bits 0 - 5 */
+	u8 dirs;		/* GPIO[0-5] directions, 0 - in, 1 - out */
+	u8 ex_vals;		/* GPIO[A-H] values in bits 0 - 7 */
+	u8 ex_dirs;		/* GPIO[A-H] directions, 0 - in, 1 - out */
+} __packed;
+
+struct ft260_gpio_read_request_report {
+	u8 report;		/* FT260_GPIO */
+	struct ft260_gpio_state	gpio;
+} __packed;
+
 /* Feature Out reports */
 
 struct ft260_set_system_clock_report {
@@ -203,6 +270,33 @@ struct ft260_set_i2c_speed_report {
 	__le16 clock;		/* I2C bus clock in range 60-3400 KHz */
 } __packed;
 
+struct ft260_set_gpio2_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIO2_FUNC */
+	u8 gpio2_func;		/* Pin func: 0 - GPIO, 1 - SUSPOUT, */
+				/* 2 - PWREN# (active-low), 4 - TX_LED */
+} __packed;
+
+struct ft260_set_gpioa_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIOA_FUNC */
+	u8 gpioa_func;		/* Pin func: 0 - GPIO, */
+				/* 3 - TX_ACTIVE, 4 - TX_LED */
+} __packed;
+
+struct ft260_set_gpiog_func_report {
+	u8 report;		/* FT260_SYSTEM_SETTINGS */
+	u8 request;		/* FT260_SELECT_GPIOG_FUNC */
+	u8 gpiog_func;		/* Pin func: 0 - GPIO, */
+				/* 2 - PWREN# (active-low), */
+				/* 5 - RX_LED, 6 - BCD_DET */
+} __packed;
+
+struct ft260_gpio_write_request_report {
+	u8 report;		/* FT260_GPIO */
+	struct ft260_gpio_state	gpio;
+} __packed;
+
 /* Data transfer reports */
 
 struct ft260_i2c_write_request_report {
@@ -237,13 +331,17 @@ struct ft260_device {
 	struct i2c_adapter adap;
 	struct hid_device *hdev;
 	struct completion wait;
+	struct gpio_chip *gc;
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
+	u8 feature_buf[FT260_REPORT_MAX_LENGTH];
 	unsigned long need_wakeup_at;
 	u8 *read_buf;
 	u16 read_idx;
 	u16 read_len;
 	u16 clock;
+	struct ft260_gpio_state gpio;
+	u16 gpio_en;
 };
 
 static int ft260_hid_feature_report_get(struct hid_device *hdev,
@@ -277,8 +375,6 @@ static int ft260_hid_feature_report_set(struct hid_device *hdev, u8 *data,
 	if (!buf)
 		return -ENOMEM;
 
-	buf[0] = FT260_SYSTEM_SETTINGS;
-
 	ret = hid_hw_raw_request(hdev, buf[0], buf, len, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
 
@@ -291,6 +387,7 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	struct ft260_set_i2c_reset_report report;
 	int ret;
 
+	report.report = FT260_SYSTEM_SETTINGS;
 	report.request = FT260_SET_I2C_RESET;
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&report, sizeof(report));
@@ -767,6 +864,243 @@ static const struct i2c_algorithm ft260_i2c_algo = {
 	.functionality = ft260_functionality,
 };
 
+
+static int ft260_gpio_chip_match_name(struct gpio_chip *chip, void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+static void ft260_gpio_en_set(struct ft260_device *dev, u16 bitmap)
+{
+	dev->gpio_en |= bitmap & FT260_GPIO_MASK;
+}
+
+static void ft260_gpio_en_clr(struct ft260_device *dev, u16 bitmap)
+{
+	dev->gpio_en &= ~bitmap & FT260_GPIO_MASK;
+}
+
+static void ft260_gpio_en_update(struct hid_device *hdev, u8 req, u8 value)
+{
+	u16 bitmap;
+	struct ft260_device *dev = hid_get_drvdata(hdev);
+
+	switch (req) {
+	case FT260_SELECT_GPIO2_FUNC:
+		bitmap = FT260_GPIO_2;
+		break;
+	case FT260_SELECT_GPIOA_FUNC:
+		bitmap = FT260_GPIO_A;
+		break;
+	case FT260_SELECT_GPIOG_FUNC:
+		bitmap = FT260_GPIO_G;
+		break;
+	default:
+		return;
+	}
+
+	if (value == FT260_MFPIN_GPIO)
+		ft260_gpio_en_set(dev, bitmap);
+	else
+		ft260_gpio_en_clr(dev, bitmap);
+
+	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+}
+
+/*
+ * For GPIO, we use hid_hw_raw_request directly with preallocated buffer to not
+ * interfere with i2c operation.
+ */
+static void ft260_gpio_set(struct gpio_chip *gc, u32 offset, int value)
+{
+	int ret;
+	struct ft260_gpio_write_request_report *rep;
+	int len = sizeof(struct ft260_gpio_read_request_report);
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	if (offset >= FT260_GPIO_TOTAL) {
+		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
+		return;
+	}
+
+	ft260_dbg("offset %d val %d\n", offset, value);
+
+	mutex_lock(&dev->lock);
+
+	if (!(dev->gpio_en & (1 << offset))) {
+		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
+		goto exit;
+	}
+
+	rep = (struct ft260_gpio_write_request_report *)&dev->feature_buf;
+
+	rep->gpio = dev->gpio;
+
+	if ( offset < FT260_GPIO_MAX) {
+		if (value)
+			rep->gpio.vals |= !!value << offset;
+		else
+			rep->gpio.vals &= ~(1 << offset);
+	} else {
+		offset = offset - FT260_GPIO_MAX;
+		if (value)
+			rep->gpio.ex_vals |= !!value << offset;
+		else
+			rep->gpio.ex_vals &= ~(1 << offset);
+	}
+
+	ft260_dbg("dirs %#02x vals %#02x ex_dir %#02x ex_vals %#02x\n",
+		  rep->gpio.dirs, rep->gpio.vals,
+		  rep->gpio.ex_dirs, rep->gpio.ex_vals);
+
+	ret = hid_hw_raw_request(hdev, FT260_GPIO, (u8 *)rep, len,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	if (ret < 0) {
+		hid_err(hdev, "%s: error setting GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	dev->gpio = rep->gpio;
+exit:
+	mutex_unlock(&dev->lock);
+}
+
+static int ft260_gpio_direction_set(struct gpio_chip *gc, u32 offset,
+				    int value, int direction)
+{
+	int ret;
+	u8 *buf;
+	struct ft260_gpio_write_request_report *rep;
+	int len = sizeof(struct ft260_gpio_read_request_report);
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	if (offset >= FT260_GPIO_TOTAL) {
+		hid_err(hdev, "%s: invalid offset %d\n", __func__, offset);
+		return -EINVAL;
+	}
+
+	ft260_dbg("offset %d val %d direction %d\n", offset, value, direction);
+
+	mutex_lock(&dev->lock);
+
+	if (!(dev->gpio_en & (1 << offset))) {
+		hid_err(hdev, "%s: wrong pin function %d\n", __func__, offset);
+		ret = -EIO;
+		goto exit;
+	}
+
+	buf = (u8 *)&dev->feature_buf;
+
+	ret = hid_hw_raw_request(hdev, FT260_GPIO, buf, len,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret != len) {
+		ret = ret < 0 ? ret : -EIO;
+		hid_err(hdev, "%s: error getting GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	rep = (struct ft260_gpio_write_request_report *)buf;
+	len = sizeof(struct ft260_gpio_write_request_report);
+
+	if (direction == FT260_GPIO_DIR_OUTPUT)
+		if ( offset < FT260_GPIO_MAX)
+			rep->gpio.dirs |= 1 << offset;
+		else
+			rep->gpio.ex_dirs |= 1 << (offset - FT260_GPIO_MAX);
+	else
+		if ( offset < FT260_GPIO_MAX)
+			rep->gpio.dirs &= ~(1 << offset);
+		else
+			rep->gpio.ex_dirs &= ~(1 << (offset - FT260_GPIO_MAX));
+
+	ft260_dbg("dirs %#02x val %#02x ex_dirs %#02x ex_vals %#02x\n",
+		  rep->gpio.dirs, rep->gpio.vals,
+		  rep->gpio.ex_dirs, rep->gpio.ex_vals);
+
+	ret = hid_hw_raw_request(hdev, FT260_GPIO, buf, len,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	if (ret < 0) {
+		hid_err(hdev, "%s: error setting GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	dev->gpio = rep->gpio;
+	mutex_unlock(&dev->lock);
+
+	if (direction == FT260_GPIO_DIR_OUTPUT)
+		ft260_gpio_set(gc, offset, value);
+
+	return 0;
+exit:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+
+static int ft260_gpio_direction_output(struct gpio_chip *gc,
+				       u32 offset, int value)
+{
+	return ft260_gpio_direction_set(gc, offset, value,
+					FT260_GPIO_DIR_OUTPUT);
+}
+
+static int ft260_gpio_direction_input(struct gpio_chip *gc, u32 offset)
+{
+	return ft260_gpio_direction_set(gc, offset, 0,
+					FT260_GPIO_DIR_INPUT);
+}
+
+static int ft260_gpio_get_all(struct gpio_chip *gc, int item)
+{
+	int ret;
+	u8 *buf;
+	struct ft260_gpio_read_request_report *rep;
+	int len = sizeof(struct ft260_gpio_read_request_report);
+	struct ft260_device *dev = gpiochip_get_data(gc);
+	struct hid_device *hdev = dev->hdev;
+
+	buf = (u8 *)&dev->feature_buf;
+
+	mutex_lock(&dev->lock);
+	ret = hid_hw_raw_request(hdev, FT260_GPIO, buf, len,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+
+	if (ret != len) {
+		ret = ret < 0 ? ret : -EIO;
+		hid_err(hdev, "%s: error getting GPIO: %d\n", __func__, ret);
+		goto exit;
+	}
+
+	rep = (struct ft260_gpio_read_request_report *)buf;
+	if (item == FT260_GPIO_VALUE)
+		ret = (rep->gpio.ex_vals << FT260_GPIO_MAX) |
+		       rep->gpio.vals;
+	else
+		ret = (rep->gpio.ex_dirs << FT260_GPIO_MAX) |
+		       rep->gpio.dirs;
+exit:
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+
+static int ft260_gpio_get_direction(struct gpio_chip *gc, u32 offset)
+{
+	int ret = ft260_gpio_get_all(gc, FT260_GPIO_DIRECTION);
+	if (ret < 0)
+		return ret;
+	return (ret >> offset) & 1;
+}
+
+static int ft260_gpio_get(struct gpio_chip *gc, u32 offset)
+{
+	int ret = ft260_gpio_get_all(gc, FT260_GPIO_VALUE);
+	if (ret < 0)
+		return ret;
+	return (ret >> offset) & 1;
+}
+
 static int ft260_get_system_config(struct hid_device *hdev,
 				   struct ft260_get_system_status_report *cfg)
 {
@@ -782,24 +1116,28 @@ static int ft260_get_system_config(struct hid_device *hdev,
 	return 0;
 }
 
-static int ft260_is_interface_enabled(struct hid_device *hdev)
+static int ft260_is_interface_enabled(struct hid_device *hdev,
+				struct ft260_get_system_status_report *cfg)
 {
-	struct ft260_get_system_status_report cfg;
 	struct usb_interface *usbif = to_usb_interface(hdev->dev.parent);
 	int interface = usbif->cur_altsetting->desc.bInterfaceNumber;
 	int ret;
 
-	ret = ft260_get_system_config(hdev, &cfg);
+	ret = ft260_get_system_config(hdev, cfg);
 	if (ret < 0)
 		return ret;
 
 	ft260_dbg("interface:  0x%02x\n", interface);
-	ft260_dbg("chip mode:  0x%02x\n", cfg.chip_mode);
-	ft260_dbg("clock_ctl:  0x%02x\n", cfg.clock_ctl);
-	ft260_dbg("i2c_enable: 0x%02x\n", cfg.i2c_enable);
-	ft260_dbg("uart_mode:  0x%02x\n", cfg.uart_mode);
-
-	switch (cfg.chip_mode) {
+	ft260_dbg("chip mode:  0x%02x\n", cfg->chip_mode);
+	ft260_dbg("clock_ctl:  0x%02x\n", cfg->clock_ctl);
+	ft260_dbg("i2c_enable: 0x%02x\n", cfg->i2c_enable);
+	ft260_dbg("uart_mode:  0x%02x\n", cfg->uart_mode);
+	ft260_dbg("gpio2_func: 0x%02x\n", cfg->gpio2_func);
+	ft260_dbg("gpioA_func: 0x%02x\n", cfg->gpioa_func);
+	ft260_dbg("gpioG_func: 0x%02x\n", cfg->gpiog_func);
+	ft260_dbg("wakeup_int: 0x%02x\n", cfg->enable_wakeup_int);
+
+	switch (cfg->chip_mode) {
 	case FT260_MODE_ALL:
 	case FT260_MODE_BOTH:
 		if (interface == 1)
@@ -841,6 +1179,10 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 	return scnprintf(buf, PAGE_SIZE, "%d\n", le16_to_cpu(*field));
 }
 
+static void ft260_attr_dummy_func(struct hid_device *hdev, u8 req, u16 value)
+{
+}
+
 #define FT260_ATTR_SHOW(name, reptype, id, type, func)			       \
 	static ssize_t name##_show(struct device *kdev,			       \
 				   struct device_attribute *attr, char *buf)   \
@@ -861,37 +1203,42 @@ static int ft260_word_show(struct hid_device *hdev, int id, u8 *cfg, int len,
 		FT260_ATTR_SHOW(name, ft260_get_i2c_status_report,	       \
 				FT260_I2C_STATUS, __le16, ft260_word_show)
 
-#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, func)	       \
+#define FT260_ATTR_STORE(name, reptype, id, req, type, ctype, strtou, func)    \
 	static ssize_t name##_store(struct device *kdev,		       \
 				    struct device_attribute *attr,	       \
 				    const char *buf, size_t count)	       \
 	{								       \
 		struct reptype rep;					       \
 		struct hid_device *hdev = to_hid_device(kdev);		       \
+		struct ft260_device *dev = hid_get_drvdata(hdev);	       \
 		type name;						       \
 		int ret;						       \
 									       \
-		if (!func(buf, 10, (ctype *)&name)) {			       \
+		if (!strtou(buf, 10, (ctype *)&name)) {			       \
 			rep.name = name;				       \
 			rep.report = id;				       \
 			rep.request = req;				       \
+			mutex_lock(&dev->lock);				       \
 			ret = ft260_hid_feature_report_set(hdev, (u8 *)&rep,   \
 							   sizeof(rep));       \
-			if (!ret)					       \
-				ret = count;				       \
+			if (ret < 0)					       \
+				hid_err(hdev, "%s: failed!\n", __func__);      \
+			else						       \
+				func(hdev, req, name);			       \
+			mutex_unlock(&dev->lock);			       \
 		} else {						       \
 			ret = -EINVAL;					       \
 		}							       \
 		return ret;						       \
 	}
 
-#define FT260_BYTE_ATTR_STORE(name, reptype, req)			       \
+#define FT260_BYTE_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 u8, u8, kstrtou8)
+				 u8, u8, kstrtou8, func)
 
-#define FT260_WORD_ATTR_STORE(name, reptype, req)			       \
+#define FT260_WORD_ATTR_STORE(name, reptype, req, func)			       \
 		FT260_ATTR_STORE(name, reptype, FT260_SYSTEM_SETTINGS, req,    \
-				 __le16, u16, kstrtou16)
+				 __le16, u16, kstrtou16, func)
 
 FT260_SSTAT_ATTR_SHOW(chip_mode);
 static DEVICE_ATTR_RO(chip_mode);
@@ -905,27 +1252,42 @@ static DEVICE_ATTR_RO(suspend_status);
 FT260_SSTAT_ATTR_SHOW(hid_over_i2c_en);
 static DEVICE_ATTR_RO(hid_over_i2c_en);
 
+FT260_SSTAT_ATTR_SHOW(gpio2_func);
+FT260_BYTE_ATTR_STORE(gpio2_func, ft260_set_gpio2_func_report,
+		      FT260_SELECT_GPIO2_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpio2_func);
+
+FT260_SSTAT_ATTR_SHOW(gpioa_func);
+FT260_BYTE_ATTR_STORE(gpioa_func, ft260_set_gpioa_func_report,
+		      FT260_SELECT_GPIOA_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpioa_func);
+
+FT260_SSTAT_ATTR_SHOW(gpiog_func);
+FT260_BYTE_ATTR_STORE(gpiog_func, ft260_set_gpiog_func_report,
+		      FT260_SELECT_GPIOG_FUNC, ft260_gpio_en_update);
+static DEVICE_ATTR_RW(gpiog_func);
+
 FT260_SSTAT_ATTR_SHOW(power_saving_en);
 static DEVICE_ATTR_RO(power_saving_en);
 
 FT260_SSTAT_ATTR_SHOW(i2c_enable);
 FT260_BYTE_ATTR_STORE(i2c_enable, ft260_set_i2c_mode_report,
-		      FT260_SET_I2C_MODE);
+		      FT260_SET_I2C_MODE, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(i2c_enable);
 
 FT260_SSTAT_ATTR_SHOW(uart_mode);
 FT260_BYTE_ATTR_STORE(uart_mode, ft260_set_uart_mode_report,
-		      FT260_SET_UART_MODE);
+		      FT260_SET_UART_MODE, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(uart_mode);
 
 FT260_SSTAT_ATTR_SHOW(clock_ctl);
 FT260_BYTE_ATTR_STORE(clock_ctl, ft260_set_system_clock_report,
-		      FT260_SET_CLOCK);
+		      FT260_SET_CLOCK, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock_ctl);
 
 FT260_I2CST_ATTR_SHOW(clock);
 FT260_WORD_ATTR_STORE(clock, ft260_set_i2c_speed_report,
-		      FT260_SET_I2C_CLOCK_SPEED);
+		      FT260_SET_I2C_CLOCK_SPEED, ft260_attr_dummy_func);
 static DEVICE_ATTR_RW(clock);
 
 static ssize_t i2c_reset_store(struct device *kdev,
@@ -949,6 +1311,9 @@ static const struct attribute_group ft260_attr_group = {
 		  &dev_attr_hid_over_i2c_en.attr,
 		  &dev_attr_power_saving_en.attr,
 		  &dev_attr_i2c_enable.attr,
+		  &dev_attr_gpio2_func.attr,
+		  &dev_attr_gpioa_func.attr,
+		  &dev_attr_gpiog_func.attr,
 		  &dev_attr_uart_mode.attr,
 		  &dev_attr_clock_ctl.attr,
 		  &dev_attr_i2c_reset.attr,
@@ -961,6 +1326,8 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct ft260_device *dev;
 	struct ft260_get_chip_version_report version;
+	struct ft260_get_system_status_report cfg;
+	struct gpio_chip *chip;
 	int ret;
 
 	if (!hid_is_usb(hdev))
@@ -999,7 +1366,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 version.chip_code[0], version.chip_code[1],
 		 version.chip_code[2], version.chip_code[3]);
 
-	ret = ft260_is_interface_enabled(hdev);
+	ret = ft260_is_interface_enabled(hdev, &cfg);
 	if (ret <= 0)
 		goto err_hid_close;
 
@@ -1037,6 +1404,57 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_i2c_free;
 	}
 
+	chip = gpiochip_find(FT260_GPIOCHIP, ft260_gpio_chip_match_name);
+	if (chip)
+		return 0;
+
+	hid_info(hdev, "initialize gpio chip\n");
+
+	if (cfg.chip_mode) {
+		if (!(cfg.chip_mode & FT260_MODE_UART))
+			dev->gpio_en |= FT260_GPIO_UART_DEFAULT;
+
+		if (!(cfg.chip_mode & FT260_MODE_I2C))
+			dev->gpio_en |= FT260_GPIO_I2C_DEFAULT;
+	}
+
+	if (cfg.gpio2_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_2;
+
+	if (cfg.enable_wakeup_int == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_3;
+
+	if (cfg.gpioa_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_A;
+
+	if (cfg.gpiog_func == FT260_MFPIN_GPIO)
+		dev->gpio_en |= FT260_GPIO_G;
+
+	hid_info(hdev, "enabled GPIOs: %04x\n", dev->gpio_en);
+
+	dev->gc = devm_kzalloc(&hdev->dev, sizeof(*dev->gc), GFP_KERNEL);
+	if (!dev->gc) {
+		ret = -ENOMEM;
+		goto err_i2c_free;
+	}
+
+	hid_set_drvdata(hdev, dev);
+
+	dev->gc->label			= FT260_GPIOCHIP;
+	dev->gc->direction_input	= ft260_gpio_direction_input;
+	dev->gc->direction_output	= ft260_gpio_direction_output;
+	dev->gc->get_direction		= ft260_gpio_get_direction;
+	dev->gc->set			= ft260_gpio_set;
+	dev->gc->get			= ft260_gpio_get;
+	dev->gc->base			= -1;
+	dev->gc->ngpio			= FT260_GPIO_TOTAL;
+	dev->gc->can_sleep		= 1;
+	dev->gc->parent			= &hdev->dev;
+
+	ret = devm_gpiochip_add_data(&hdev->dev, dev->gc, dev);
+	if (ret)
+		goto err_i2c_free;
+
 	return 0;
 
 err_i2c_free:
-- 
2.34.1

