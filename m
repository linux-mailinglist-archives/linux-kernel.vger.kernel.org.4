Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733636932B9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBKQ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjBKQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD014C14;
        Sat, 11 Feb 2023 08:59:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so8144349wrb.8;
        Sat, 11 Feb 2023 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4hKRpZ+hEFQcyNwS5GOyvO7MtSq27VTxXLUqx+BqEE=;
        b=gf9WGAXomfqvl9gBc576Y0OAlru1UJ0z2cbJ4vtU/Bvi6+POa/Was0k7sL6kBDsz3K
         +ingw4XCeJG/t6APudjgh5/iApG/Hdpu+Y+QZIatoSlex5fOWkp/CsWcQzc93/AzDhWv
         XQrW0a/fy023nQy1rwJoQbU0+peGwvcT8cbYTq3e29z7ThNwqTUDQjG3Iu/LRBMTmR2p
         Vk6XNqYeRx+E4B7Gu/cYoDG9xfCA8UdqhzTjDYChS+AqATFLQ0lIve3AflwGM21YHfcd
         O8wu8AKcF5UHmmwowknfP5pHL28cQx3d7iaz2XTuLM5a04Qs1eMHUIXX7IfIEZnwi5a7
         9VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4hKRpZ+hEFQcyNwS5GOyvO7MtSq27VTxXLUqx+BqEE=;
        b=zX0acVWn061iG9Slgw2dZ6jIfN7M9i2cY4ar/rI76frTEn3Cik1ZqvgL7pCsN/lTHI
         N6YryNnWNc+xMo0ooXKGuVRGSlRcW+QW0+XLDV6NIcdCKcglYnZpB2Sh4GrsZ6XHq5xw
         N3xr7pOrWNC4I/Vcz4SN3RHrX4vXH2DhLZNY36BKuyQgpqrcjXqah9rUovHgrss6F8ld
         Xkn+ZdhNS8mPsIacb2RVJwhHOfb/44Pan22VFuYVFP3CX1JD86gTUlm2fGcOw+VPGiN+
         bse08boueWv2JJuzdOs8obST1/AlLp0LZEM58V8RO0B8yZFpz9OPkSE9qa/2qBA3wFhF
         qksg==
X-Gm-Message-State: AO0yUKUYKDyqbKUW+4PB85ueeINhETzeWQgAxNhl9++QkvuLMDWdiJfd
        ZVbDimUAOuADbA4Vs3dZ7mhsb9/lgZpomw==
X-Google-Smtp-Source: AK7set/8WPwPTjxbE+2w323WC9PdsMzpDrO8rtQlbmJfcsHMlA+47RWZoiieotQIChIIAybX7ZJGqQ==
X-Received: by 2002:a05:6000:12cb:b0:2bf:cb91:a40a with SMTP id l11-20020a05600012cb00b002bfcb91a40amr15759490wrx.46.1676134750780;
        Sat, 11 Feb 2023 08:59:10 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:10 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 3/5] hwmon: (aquacomputer_d5next) Add temperature offset control for Aquaero
Date:   Sat, 11 Feb 2023 17:59:21 +0100
Message-Id: <20230211165923.17807-4-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230211165923.17807-1-leonard.anderweit@gmail.com>
References: <20230211165923.17807-1-leonard.anderweit@gmail.com>
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

Support sending control reports to Aquacomputer Aquaero. This commit only
enables control of the temperature offset as this works in the same manner as
with already supported devices.
Also, mention temperature offset control for Aquaero in docs.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  4 +-
 drivers/hwmon/aquacomputer_d5next.c         | 62 ++++++++++++++++-----
 2 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 7d0d015b1a52..de43374940b8 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -25,7 +25,7 @@ communicate through proprietary USB HID protocols.
 
 The Aquaero devices expose eight physical, eight virtual and four calculated
 virtual temperature sensors, as well as two flow sensors. The fans expose their
-speed (in RPM), power, voltage and current.
+speed (in RPM), power, voltage and current. The temperature offset can be controlled.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
@@ -75,7 +75,7 @@ Sysfs entries
 
 ================ ==============================================================
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
-temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
+temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
 fan5_pulses      Quadro flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 03ef9e0258d2..95461e2907e1 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -56,6 +56,7 @@ static const char *const aqc_device_names[] = {
 #define SERIAL_PART_OFFSET		2
 
 #define CTRL_REPORT_ID			0x03
+#define AQUAERO_CTRL_REPORT_ID		0x0b
 
 /* The HID report that the official software always sends
  * after writing values, currently same for all devices
@@ -67,6 +68,14 @@ static u8 secondary_ctrl_report[] = {
 	0x02, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x34, 0xC6
 };
 
+/* Secondary HID report values for Aquaero */
+#define AQUAERO_SECONDARY_CTRL_REPORT_ID	0x06
+#define AQUAERO_SECONDARY_CTRL_REPORT_SIZE	0x07
+
+static u8 aquaero_secondary_ctrl_report[] = {
+	0x06, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00
+};
+
 /* Report IDs for legacy devices */
 #define POWERADJUST3_STATUS_REPORT_ID	0x03
 
@@ -94,6 +103,7 @@ static u8 secondary_ctrl_report[] = {
 #define AQUAERO_NUM_VIRTUAL_SENSORS		8
 #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
 #define AQUAERO_NUM_FLOW_SENSORS		2
+#define AQUAERO_CTRL_REPORT_SIZE		0xa93
 
 /* Sensor report offsets for Aquaero fan controllers */
 #define AQUAERO_SENSOR_START			0x65
@@ -106,6 +116,9 @@ static u8 secondary_ctrl_report[] = {
 #define AQUAERO_FAN_SPEED_OFFSET		0x00
 static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
 
+/* Control report offsets for the Aquaero fan controllers */
+#define AQUAERO_TEMP_CTRL_OFFSET	0xdb
+
 /* Specs of the D5 Next pump */
 #define D5NEXT_NUM_FANS			2
 #define D5NEXT_NUM_SENSORS		1
@@ -441,6 +454,10 @@ struct aqc_data {
 	const char *name;
 
 	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
+	int ctrl_report_id;
+	int secondary_ctrl_report_id;
+	int secondary_ctrl_report_size;
+	u8 *secondary_ctrl_report;
 
 	int buffer_size;
 	u8 *buffer;
@@ -513,7 +530,7 @@ static int aqc_get_ctrl_data(struct aqc_data *priv)
 	int ret;
 
 	memset(priv->buffer, 0x00, priv->buffer_size);
-	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 	if (ret < 0)
 		ret = -ENODATA;
@@ -527,23 +544,27 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	int ret;
 	u16 checksum;
 
-	/* Init and xorout value for CRC-16/USB is 0xffff */
-	checksum = crc16(0xffff, priv->buffer + priv->checksum_start, priv->checksum_length);
-	checksum ^= 0xffff;
+	/* Checksum is not needed for Aquaero */
+	if (priv->kind != aquaero) {
+		/* Init and xorout value for CRC-16/USB is 0xffff */
+		checksum = crc16(0xffff, priv->buffer + priv->checksum_start,
+				 priv->checksum_length);
+		checksum ^= 0xffff;
 
-	/* Place the new checksum at the end of the report */
-	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
+		/* Place the new checksum at the end of the report */
+		put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
+	}
 
 	/* Send the patched up report back to the device */
-	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
+	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
 				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	if (ret < 0)
 		return ret;
 
 	/* The official software sends this report after every change, so do it here as well */
-	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
-				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
-				 HID_REQ_SET_REPORT);
+	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
+				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 	return ret;
 }
 
@@ -969,10 +990,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
 			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_OFFSET,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
 			   HWMON_T_INPUT | HWMON_T_LABEL,
@@ -1275,6 +1296,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
 		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
 
+		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
+
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
@@ -1438,6 +1462,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
 
 		priv->fan_structure = &aqc_aquaero_fan_structure;
+
+		priv->ctrl_report_id = AQUAERO_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_id = AQUAERO_SECONDARY_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_size = AQUAERO_SECONDARY_CTRL_REPORT_SIZE;
+		priv->secondary_ctrl_report = aquaero_secondary_ctrl_report;
 		break;
 	case poweradjust3:
 		priv->status_report_id = POWERADJUST3_STATUS_REPORT_ID;
@@ -1446,6 +1475,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->serial_number_start_offset = AQC_SERIAL_START;
 		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
 
+		priv->ctrl_report_id = CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_id = SECONDARY_CTRL_REPORT_ID;
+		priv->secondary_ctrl_report_size = SECONDARY_CTRL_REPORT_SIZE;
+		priv->secondary_ctrl_report = secondary_ctrl_report;
+
 		if (priv->kind == aquastreamult)
 			priv->fan_structure = &aqc_aquastreamult_fan_structure;
 		else
-- 
2.39.1

