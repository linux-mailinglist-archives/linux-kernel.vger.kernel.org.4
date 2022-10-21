Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657A4607DE9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJURtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiJURtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:49:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7A412D3E;
        Fri, 21 Oct 2022 10:49:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u21so8660454edi.9;
        Fri, 21 Oct 2022 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y8DWF+UF8EVkd6v92FWoTJD5DkJphqAj6oypteWXvQ8=;
        b=bgq1HW5smypWPkPeGG40imnhVGvYodzpi9FVkSeDN1ZJnB4gLGe0zQlLW3PCcKy8ws
         Ql17nikI8SGYJL9YLMyHM0MwUL/bsHWO+qfkCer5aDQpBw410qrRPo9sqYcdWdMpCFxZ
         d73hCFh9F1ExHiZJ/ucw5DdztEzm3Qqtl7FQ7KQWra3QP9cmagwBU3ltWdyKxNlYWXpf
         JOnArhIgOqH6FYrOrIdFBD6odZveL1LAVlIHpaTvVmmCHZahXoJA8WjPTTQsq6pjWDC8
         TVzdyR/0Mf5gu9Ptp3dd5Sv6C6SZmCZ7SXKuhXZ6YSUWwMt8HeVf6hUbcAHblBMojydI
         FiQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y8DWF+UF8EVkd6v92FWoTJD5DkJphqAj6oypteWXvQ8=;
        b=vFZq6IMTJSNGsKjHoFiKa+r7VsVvmOpsjnU9QOtpcXesaUwlJsD2SkTfDyMTINQri9
         cSGtqLteXXXM5VmABuUVIivW4pB1CzwCOLs53FxKtCubG8U539B9QCQYl+TnF//DGXr7
         kG7PAppoizIt5Ab9BH+zQfo4OnSdCjOhShhkIIt1iuca2jmHgPxTPlTOfC6ODI4/ihfo
         5SlAIz/i/TBuWnZ1eTbgKIcJv2qAYingGPv22QiVqYJ1Bagk9fmd97Hidxw6qgaJ3Xg9
         nzofVqlYuRX2VWRfZN9cGEcnYiPPGCdXbpiUxqXqt4a0ELBSoyWQP8p///CIXI8ojN74
         rOng==
X-Gm-Message-State: ACrzQf0t5hwxjsjLYWck+9aYMUq6i0Vu+1rpes/o0Ahy/Jrb3/8w5Bxo
        IWC2kTQ0jpIPMUNI4QtNdflzV/KTBY8EcA==
X-Google-Smtp-Source: AMsMyM5zMmpNj7aFia7CO9XmwKtDQ3kKJlxeK2NztpW2FsjSipSqf0xUheMp3fXBmBEWQgZHzg1azg==
X-Received: by 2002:aa7:dd45:0:b0:458:7474:1fbe with SMTP id o5-20020aa7dd45000000b0045874741fbemr18742848edw.334.1666374540733;
        Fri, 21 Oct 2022 10:49:00 -0700 (PDT)
Received: from fedora.. ([87.116.164.153])
        by smtp.gmail.com with ESMTPSA id gl22-20020a170906e0d600b0078d3f96d293sm11921148ejb.30.2022.10.21.10.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:49:00 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets
Date:   Fri, 21 Oct 2022 19:48:34 +0200
Message-Id: <20221021174834.736930-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Add support for reading and writing temperature sensor offsets
on the Aquacomputer D5 Next, Farbwerk 360, Octo and Quadro,
for which the needed offsets are known. Implemented by
Leonard Anderweit [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/22

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  1 +
 drivers/hwmon/aquacomputer_d5next.c         | 91 ++++++++++++++++++---
 2 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index e238533b5fe0..15226346434d 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -62,6 +62,7 @@ Sysfs entries
 
 ================ ==============================================================
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
+temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index c51a2678f0eb..862d6c284e83 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -80,6 +80,7 @@ static u8 secondary_ctrl_report[] = {
 #define D5NEXT_5V_VOLTAGE		0x39
 #define D5NEXT_12V_VOLTAGE		0x37
 #define D5NEXT_CTRL_REPORT_SIZE		0x329
+#define D5NEXT_TEMP_CTRL_OFFSET		0x2D
 static u8 d5next_sensor_fan_offsets[] = { D5NEXT_PUMP_OFFSET, D5NEXT_FAN_OFFSET };
 
 /* Pump and fan speed registers in D5 Next control report (from 0-100%) */
@@ -94,6 +95,8 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
 #define FARBWERK360_SENSOR_START		0x32
 #define FARBWERK360_NUM_VIRTUAL_SENSORS		16
 #define FARBWERK360_VIRTUAL_SENSORS_START	0x3a
+#define FARBWERK360_CTRL_REPORT_SIZE		0x682
+#define FARBWERK360_TEMP_CTRL_OFFSET		0x8
 
 /* Register offsets for the Octo fan controller */
 #define OCTO_POWER_CYCLES		0x18
@@ -103,6 +106,7 @@ static u16 d5next_ctrl_fan_offsets[] = { 0x97, 0x42 };
 #define OCTO_NUM_VIRTUAL_SENSORS	16
 #define OCTO_VIRTUAL_SENSORS_START	0x45
 #define OCTO_CTRL_REPORT_SIZE		0x65F
+#define OCTO_TEMP_CTRL_OFFSET		0xA
 static u8 octo_sensor_fan_offsets[] = { 0x7D, 0x8A, 0x97, 0xA4, 0xB1, 0xBE, 0xCB, 0xD8 };
 
 /* Fan speed registers in Octo control report (from 0-100%) */
@@ -117,6 +121,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_VIRTUAL_SENSORS_START	0x3c
 #define QUADRO_CTRL_REPORT_SIZE		0x3c1
 #define QUADRO_FLOW_SENSOR_OFFSET	0x6e
+#define QUADRO_TEMP_CTRL_OFFSET		0xA
 static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Fan speed registers in Quadro control report (from 0-100%) */
@@ -282,6 +287,7 @@ struct aqc_data {
 	int temp_sensor_start_offset;
 	int num_virtual_temp_sensors;
 	int virtual_temp_sensor_start_offset;
+	u16 temp_ctrl_offset;
 	u16 power_cycle_count_offset;
 	u8 flow_sensor_offset;
 
@@ -365,8 +371,8 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
 	return ret;
 }
 
-/* Refreshes the control buffer and returns value at offset */
-static int aqc_get_ctrl_val(struct aqc_data *priv, int offset)
+/* Refreshes the control buffer and stores value at offset in val */
+static int aqc_get_ctrl_val(struct aqc_data *priv, int offset, long *val)
 {
 	int ret;
 
@@ -376,7 +382,7 @@ static int aqc_get_ctrl_val(struct aqc_data *priv, int offset)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	ret = get_unaligned_be16(priv->buffer + offset);
+	*val = (s16)get_unaligned_be16(priv->buffer + offset);
 
 unlock_and_return:
 	mutex_unlock(&priv->mutex);
@@ -393,7 +399,7 @@ static int aqc_set_ctrl_val(struct aqc_data *priv, int offset, long val)
 	if (ret < 0)
 		goto unlock_and_return;
 
-	put_unaligned_be16((u16)val, priv->buffer + offset);
+	put_unaligned_be16((s16)val, priv->buffer + offset);
 
 	ret = aqc_send_ctrl_data(priv);
 
@@ -408,8 +414,28 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 
 	switch (type) {
 	case hwmon_temp:
+		if (channel < priv->num_temp_sensors) {
+			switch (attr) {
+			case hwmon_temp_label:
+			case hwmon_temp_input:
+				return 0444;
+			case hwmon_temp_offset:
+				if (priv->temp_ctrl_offset != 0)
+					return 0644;
+				break;
+			default:
+				break;
+			}
+		}
+
 		if (channel < priv->num_temp_sensors + priv->num_virtual_temp_sensors)
-			return 0444;
+			switch (attr) {
+			case hwmon_temp_label:
+			case hwmon_temp_input:
+				return 0444;
+			default:
+				break;
+			}
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
@@ -492,10 +518,26 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 
 	switch (type) {
 	case hwmon_temp:
-		if (priv->temp_input[channel] == -ENODATA)
-			return -ENODATA;
+		switch (attr) {
+		case hwmon_temp_input:
+			if (priv->temp_input[channel] == -ENODATA)
+				return -ENODATA;
+
+			*val = priv->temp_input[channel];
+			break;
+		case hwmon_temp_offset:
+			ret =
+			    aqc_get_ctrl_val(priv,
+					     priv->temp_ctrl_offset +
+					     channel * AQC_TEMP_SENSOR_SIZE, val);
+			if (ret < 0)
+				return ret;
 
-		*val = priv->temp_input[channel];
+			*val *= 10;
+			break;
+		default:
+			break;
+		}
 		break;
 	case hwmon_fan:
 		*val = priv->speed_input[channel];
@@ -505,7 +547,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets) {
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel]);
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
 			if (ret < 0)
 				return ret;
 
@@ -563,6 +605,22 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
 	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_offset:
+			/* Limit temp offset to +/- 15K as in the official software */
+			val = clamp_val(val, -15000, 15000) / 10;
+			ret =
+			    aqc_set_ctrl_val(priv,
+					     priv->temp_ctrl_offset +
+					     channel * AQC_TEMP_SENSOR_SIZE, val);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
@@ -597,10 +655,10 @@ static const struct hwmon_ops aqc_hwmon_ops = {
 
 static const struct hwmon_channel_info *aqc_info[] = {
 	HWMON_CHANNEL_INFO(temp,
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
@@ -853,6 +911,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_d5next_temp;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -867,6 +926,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->num_fans = 0;
 		priv->num_temp_sensors = FARBWERK_NUM_SENSORS;
 		priv->temp_sensor_start_offset = FARBWERK_SENSOR_START;
+		priv->temp_ctrl_offset = 0;
+
 		priv->temp_label = label_temp_sensors;
 		break;
 	case USB_PRODUCT_ID_FARBWERK360:
@@ -877,6 +938,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
 		priv->num_virtual_temp_sensors = FARBWERK360_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = FARBWERK360_VIRTUAL_SENSORS_START;
+		priv->buffer_size = FARBWERK360_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = FARBWERK360_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -893,6 +956,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -914,6 +978,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
+		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
-- 
2.37.3

