Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA27A6E3B1F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjDPSSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 14:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDPSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 14:18:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32D212A;
        Sun, 16 Apr 2023 11:18:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-94f7a0818aeso7730766b.2;
        Sun, 16 Apr 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681669124; x=1684261124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T17Ts2yD9B/RccQUaUiaQxTvqJvFVmTmjYhTz5Wsjww=;
        b=QlrMhzj/BoHkC5noi73NmeMNSLUiGSvHtc6BjAjrftFFpezBJHhk+M+4RbzlVT1WkU
         RVthYtLiIwg3AvT/hC9XFpbYouvjEtljQcynrOk6DWHMRKvaCi5jKoyLYt72SaF3SW+8
         DyE1j+sijf/VTHtbcyq1QkvH1rHAz58u7odLXprQqvyqsBQxg5VWVtYvpqCuluIgR6OX
         4U9lw/0ugfaqNlBCioVpBSvi64KOnX8ByUYhCLl0fxWufrzxLnG22jCPhhgjY1vMDJ1s
         EE6ItUba5sg5qjKzSWsP488fjbzRnlZCSOqvKp5lXIfsycfle6n3712MTfMS4lLzAZni
         gW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681669124; x=1684261124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T17Ts2yD9B/RccQUaUiaQxTvqJvFVmTmjYhTz5Wsjww=;
        b=IEzKqMuzrShc92cgmJ1eJOPhMnGhb9dSJVJ3fihA3tgfixL33lDXEZqdQPES4XZfSy
         SqA1+Z75Fe3wrQZGaZ7/NDAjZqqP0Ac+kEeK/kapYbWYzjQ6vUoFMeuTWmmdircdtioh
         yIBjoTNTEoXWN6gD39kyQnghkBZTlKMbPrcxxk8OR+AS45Ypk12a30K4sFUBlsXOQ5y7
         nSnsh26PFJu4B62giC4o3OS0U0fnxnXorszsjH+JVZakanKRS6Uw1rB2SWpM0C1tI7Iy
         k6949O7hWOKba9pUak48pUG8T5KgHmI6+PhBMDdHkGmfvCweBl5DXcaP7qg2dLVDI6hz
         hWMw==
X-Gm-Message-State: AAQBX9fk+qrDWnFX9WT6solWTcVB9H7N0cW4BeS2WOiQO49opSLlnm83
        bn0+yps2wnJosaqObOlRmXCboH3Pa9U=
X-Google-Smtp-Source: AKy350ayrfVwAEXtxosNWDEq/qlH34gBHFInsOv25IAq/nxT/5GubhPy2C6VUivVEWYfNHGKfbHrBg==
X-Received: by 2002:a05:6402:110f:b0:506:7671:4e72 with SMTP id u15-20020a056402110f00b0050676714e72mr9076853edv.38.1681669123984;
        Sun, 16 Apr 2023 11:18:43 -0700 (PDT)
Received: from fedora.. ([87.116.164.240])
        by smtp.gmail.com with ESMTPSA id h19-20020aa7de13000000b0050673b13b58sm4680111edv.56.2023.04.16.11.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 11:18:43 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Aquacomputer Aquastream XT
Date:   Sun, 16 Apr 2023 20:17:01 +0200
Message-Id: <20230416181702.9892-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend aquacomputer_d5next driver to expose various hardware sensors of the
Aquacomputer Aquastream XT watercooling pump, which communicates
through a proprietary USB HID protocol. Implemented by Leonard Anderweit
[1] [2].

Coolant temp, fan IC and external temp sensor readings are available, along
with speed and voltage of both the pump and optionally connected fan.
It also exposes pump current.

Additionally, serial number and firmware version are exposed through
debugfs.

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/46
[2] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/49

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |   5 +
 drivers/hwmon/aquacomputer_d5next.c         | 114 +++++++++++++++++++-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index c604d4becb8d..14b37851af0c 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -12,6 +12,7 @@ Supported devices:
 * Aquacomputer Octo fan controller
 * Aquacomputer Quadro fan controller
 * Aquacomputer High Flow Next sensor
+* Aquacomputer Aquastream XT watercooling pump
 * Aquacomputer Aquastream Ultimate watercooling pump
 * Aquacomputer Poweradjust 3 fan controller
 
@@ -56,6 +57,10 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
 A temperature sensor can be connected to it, in which case it provides its reading
 and an estimation of the dissipated/absorbed power in the liquid cooling loop.
 
+The Aquastream XT pump exposes temperature readings for the coolant, external sensor
+and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
+current.
+
 The Aquastream Ultimate pump exposes coolant temp and an external temp sensor, along
 with speed, power, voltage and current of both the pump and optionally connected fan.
 It also exposes pressure and flow speed readings.
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 3bd35d833e69..a4fcd4ebf76c 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -29,12 +29,14 @@
 #define USB_PRODUCT_ID_FARBWERK360	0xf010
 #define USB_PRODUCT_ID_OCTO		0xf011
 #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
+#define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
 #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
 #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
 
 enum kinds {
 	d5next, farbwerk, farbwerk360, octo, quadro,
-	highflownext, aquaero, poweradjust3, aquastreamult
+	highflownext, aquaero, poweradjust3, aquastreamult,
+	aquastreamxt
 };
 
 static const char *const aqc_device_names[] = {
@@ -44,6 +46,7 @@ static const char *const aqc_device_names[] = {
 	[octo] = "octo",
 	[quadro] = "quadro",
 	[highflownext] = "highflownext",
+	[aquastreamxt] = "aquastreamxt",
 	[aquaero] = "aquaero",
 	[aquastreamult] = "aquastreamultimate",
 	[poweradjust3] = "poweradjust3"
@@ -77,6 +80,8 @@ static u8 aquaero_secondary_ctrl_report[] = {
 };
 
 /* Report IDs for legacy devices */
+#define AQUASTREAMXT_STATUS_REPORT_ID	0x04
+
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
 /* Data types for reading and writing control reports */
@@ -231,6 +236,24 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 #define HIGHFLOWNEXT_5V_VOLTAGE		97
 #define HIGHFLOWNEXT_5V_VOLTAGE_USB	99
 
+/* Specs of the Aquastream XT pump */
+#define AQUASTREAMXT_SERIAL_START		0x3a
+#define AQUASTREAMXT_FIRMWARE_VERSION		0x32
+#define AQUASTREAMXT_NUM_FANS			2
+#define AQUASTREAMXT_NUM_SENSORS		3
+#define AQUASTREAMXT_FAN_STOPPED		0x4
+#define AQUASTREAMXT_PUMP_CONVERSION_CONST	45000000
+#define AQUASTREAMXT_FAN_CONVERSION_CONST	5646000
+#define AQUASTREAMXT_SENSOR_REPORT_SIZE		0x42
+
+/* Sensor report offsets and info for Aquastream XT */
+#define AQUASTREAMXT_SENSOR_START		0xd
+#define AQUASTREAMXT_FAN_VOLTAGE_OFFSET		0x7
+#define AQUASTREAMXT_FAN_STATUS_OFFSET		0x1d
+#define AQUASTREAMXT_PUMP_VOLTAGE_OFFSET	0x9
+#define AQUASTREAMXT_PUMP_CURR_OFFSET		0xb
+static u16 aquastreamxt_sensor_fan_offsets[] = { 0x13, 0x1b };
+
 /* Specs of the Poweradjust 3 */
 #define POWERADJUST3_NUM_SENSORS	1
 #define POWERADJUST3_SENSOR_REPORT_SIZE	0x32
@@ -388,6 +411,13 @@ static const char *const label_highflownext_voltage[] = {
 	"+5V USB voltage"
 };
 
+/* Labels for Aquastream XT */
+static const char *const label_aquastreamxt_temp_sensors[] = {
+	"Fan IC temp",
+	"External sensor",
+	"Coolant temp"
+};
+
 /* Labels for Aquastream Ultimate */
 static const char *const label_aquastreamult_temp[] = {
 	"Coolant temp",
@@ -531,6 +561,22 @@ static int aqc_pwm_to_percent(long val)
 	return DIV_ROUND_CLOSEST(val * 100 * 100, 255);
 }
 
+/* Converts raw value for Aquastream XT pump speed to RPM */
+static int aqc_aquastreamxt_convert_pump_rpm(u16 val)
+{
+	if (val > 0)
+		return DIV_ROUND_CLOSEST(AQUASTREAMXT_PUMP_CONVERSION_CONST, val);
+	return 0;
+}
+
+/* Converts raw value for Aquastream XT fan speed to RPM */
+static int aqc_aquastreamxt_convert_fan_rpm(u16 val)
+{
+	if (val > 0)
+		return DIV_ROUND_CLOSEST(AQUASTREAMXT_FAN_CONVERSION_CONST, val);
+	return 0;
+}
+
 /* Expects the mutex to be locked */
 static int aqc_get_ctrl_data(struct aqc_data *priv)
 {
@@ -734,6 +780,8 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (channel == 0)
 				return 0444;
 			break;
+		case aquastreamxt:
+			break;
 		default:
 			if (channel < priv->num_fans)
 				return 0444;
@@ -747,6 +795,11 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			if (channel < 2)
 				return 0444;
 			break;
+		case aquastreamxt:
+			/* Special case to support pump current */
+			if (channel == 0)
+				return 0444;
+			break;
 		default:
 			if (channel < priv->num_fans)
 				return 0444;
@@ -799,6 +852,43 @@ static int aqc_legacy_read(struct aqc_data *priv)
 		priv->temp_input[i] = sensor_value * 10;
 	}
 
+	/* Special-case sensor readings */
+	switch (priv->kind) {
+	case aquastreamxt:
+		/* Info provided with every report */
+		priv->serial_number[0] = get_unaligned_le16(priv->buffer +
+							    priv->serial_number_start_offset);
+		priv->firmware_version =
+			get_unaligned_le16(priv->buffer + priv->firmware_version_offset);
+
+		/* Read pump speed in RPM */
+		sensor_value = get_unaligned_le16(priv->buffer + priv->fan_sensor_offsets[0]);
+		priv->speed_input[0] = aqc_aquastreamxt_convert_pump_rpm(sensor_value);
+
+		/* Read fan speed in RPM, if available */
+		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_FAN_STATUS_OFFSET);
+		if (sensor_value == AQUASTREAMXT_FAN_STOPPED) {
+			priv->speed_input[1] = 0;
+		} else {
+			sensor_value =
+				get_unaligned_le16(priv->buffer + priv->fan_sensor_offsets[1]);
+			priv->speed_input[1] = aqc_aquastreamxt_convert_fan_rpm(sensor_value);
+		}
+
+		/* Calculation derived from linear regression */
+		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_CURR_OFFSET);
+		priv->current_input[0] = DIV_ROUND_CLOSEST(sensor_value * 176, 100) - 52;
+
+		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_PUMP_VOLTAGE_OFFSET);
+		priv->voltage_input[0] = DIV_ROUND_CLOSEST(sensor_value * 1000, 61);
+
+		sensor_value = get_unaligned_le16(priv->buffer + AQUASTREAMXT_FAN_VOLTAGE_OFFSET);
+		priv->voltage_input[1] = DIV_ROUND_CLOSEST(sensor_value * 1000, 63);
+		break;
+	default:
+		break;
+	}
+
 	priv->updated = jiffies;
 
 unlock_and_return:
@@ -1481,6 +1571,21 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_label = label_highflownext_power;
 		priv->voltage_label = label_highflownext_voltage;
 		break;
+	case USB_PRODUCT_ID_AQUASTREAMXT:
+		priv->kind = aquastreamxt;
+
+		priv->num_fans = AQUASTREAMXT_NUM_FANS;
+		priv->fan_sensor_offsets = aquastreamxt_sensor_fan_offsets;
+
+		priv->num_temp_sensors = AQUASTREAMXT_NUM_SENSORS;
+		priv->temp_sensor_start_offset = AQUASTREAMXT_SENSOR_START;
+		priv->buffer_size = AQUASTREAMXT_SENSOR_REPORT_SIZE;
+
+		priv->temp_label = label_aquastreamxt_temp_sensors;
+		priv->speed_label = label_d5next_speeds;
+		priv->voltage_label = label_d5next_voltages;
+		priv->current_label = label_d5next_current;
+		break;
 	case USB_PRODUCT_ID_AQUASTREAMULT:
 		priv->kind = aquastreamult;
 
@@ -1526,6 +1631,12 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	case poweradjust3:
 		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
 		break;
+	case aquastreamxt:
+		priv->serial_number_start_offset = AQUASTREAMXT_SERIAL_START;
+		priv->firmware_version_offset = AQUASTREAMXT_FIRMWARE_VERSION;
+
+		priv->status_report_id = AQUASTREAMXT_STATUS_REPORT_ID;
+		break;
 	default:
 		priv->serial_number_start_offset = AQC_SERIAL_START;
 		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
@@ -1596,6 +1707,7 @@ static const struct hid_device_id aqc_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_OCTO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
 	{ }
-- 
2.39.2

