Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7D60B18A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJXQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbiJXQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:26:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBF3FED4;
        Mon, 24 Oct 2022 08:13:09 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b12so32316897edd.6;
        Mon, 24 Oct 2022 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XVIwiwHdQYve1RsKM3+xpHDgfR6/MEyqerk49LTO2rU=;
        b=VFCzTH9AZFAIayeiJSbGhiW27l0eahy4ulx+qe4ZCLgmbOHfzaWIceLy1klv5Q7fb1
         6PSsywNgcKqWuzRWw19Ppo4lAXF7jtwOz19bTo3HXsXMk3UuxtBP9eflr5V29WdJG0Lc
         +Y84Svo+gGM7QMfa30YIlyTcWNLpVx+CA0wjDrUd5q2vzJD6fHJ2urkgUP85y0ZF6aKl
         CoK2TwakeH74Dy9/6vMyax2HguhiS8gXyYmLnD/EJyToOYACZCrfJ87gtsafa21YZhiI
         vJHX3ba+CxFuzne50oc1mM4Hz/0c9VbcV/Yi8bSlNIT8/oo6M5dO8hoJMVGsMDOwqKkq
         hsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVIwiwHdQYve1RsKM3+xpHDgfR6/MEyqerk49LTO2rU=;
        b=MhhbBNKn+8e9JYbrbiZP/kMaZV0GeZv1EfupLJ2v93daG/dOfuFmatWpd5lYgO8lxj
         Bp45h8p8f25cQrO0UG+OeggYIYdehB7fMz8eKXX9YNspuxajh+kIoN/RyHLTv2c6ZQMx
         aWVjLX5oZNbEyDLDHRL6vlDthAVj5S4bhKivFANV6P7bDOXg3Q4lIPf/NXWHCCzyERbq
         k3B5I4grUBCW3wlYuptVjx596Bn9/eMQvMqvQJ0qmPTjQz4QMWOMtcVq+Yt/vyMx0KM4
         UmA3q0/hgfov1/NnOE1i4jq3IIAzmK7hxTApCm9b9eTUQy/b34trIwbxrosyNy7u2Ut/
         Tbrw==
X-Gm-Message-State: ACrzQf3JhJTXKyCPGT++lEYLkMHT4Dy3saUdlunNGw9h7+58AwPgkGy9
        Tj78k1SWgavuPhxRo8rCXa+gXlRvkQiOehfF
X-Google-Smtp-Source: AMsMyM5JBdj1+0i2Cg0f55rWGBTeiCdojCmdEoBX7Ue//Q0gd0IqvGxAntCeaMbaQvMAUbrs9sacKw==
X-Received: by 2002:aa7:c6c8:0:b0:460:e19b:ec12 with SMTP id b8-20020aa7c6c8000000b00460e19bec12mr20720191eds.209.1666624250735;
        Mon, 24 Oct 2022 08:10:50 -0700 (PDT)
Received: from fedora.. ([87.116.164.153])
        by smtp.gmail.com with ESMTPSA id fj20-20020a0564022b9400b004618f2127d2sm12437edb.57.2022.10.24.08.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:10:50 -0700 (PDT)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (aquacomputer_d5next) Add support for temperature sensor offsets
Date:   Mon, 24 Oct 2022 17:10:39 +0200
Message-Id: <20221024151039.7222-1-savicaleksa83@gmail.com>
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
Changes in v2:
- Removed unnecessary init to 0
- Reformatted lines to avoid line splits
---
 Documentation/hwmon/aquacomputer_d5next.rst |  1 +
 drivers/hwmon/aquacomputer_d5next.c         | 88 +++++++++++++++++----
 2 files changed, 75 insertions(+), 14 deletions(-)

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
index c51a2678f0eb..608f57f59cf9 100644
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
@@ -492,10 +518,25 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 
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
+			    aqc_get_ctrl_val(priv, priv->temp_ctrl_offset +
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
@@ -505,7 +546,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets) {
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel]);
+			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel], val);
 			if (ret < 0)
 				return ret;
 
@@ -563,6 +604,21 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
 	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_offset:
+			/* Limit temp offset to +/- 15K as in the official software */
+			val = clamp_val(val, -15000, 15000) / 10;
+			ret =
+			    aqc_set_ctrl_val(priv, priv->temp_ctrl_offset +
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
@@ -597,10 +653,10 @@ static const struct hwmon_ops aqc_hwmon_ops = {
 
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
@@ -853,6 +909,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = D5NEXT_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = D5NEXT_POWER_CYCLES;
 		priv->buffer_size = D5NEXT_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = D5NEXT_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_d5next_temp;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -877,7 +934,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = FARBWERK360_SENSOR_START;
 		priv->num_virtual_temp_sensors = FARBWERK360_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = FARBWERK360_VIRTUAL_SENSORS_START;
-
+		priv->buffer_size = FARBWERK360_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = FARBWERK360_TEMP_CTRL_OFFSET;
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
 		break;
@@ -893,6 +951,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->virtual_temp_sensor_start_offset = OCTO_VIRTUAL_SENSORS_START;
 		priv->power_cycle_count_offset = OCTO_POWER_CYCLES;
 		priv->buffer_size = OCTO_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = OCTO_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
@@ -914,6 +973,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
+		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
-- 
2.37.3

