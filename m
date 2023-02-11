Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118856932B7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBKQ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBKQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:16 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B274ED1;
        Sat, 11 Feb 2023 08:59:13 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id by3so6846077wrb.10;
        Sat, 11 Feb 2023 08:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gc+Ey24cOtq0YnlGdaIZXPrHIGUrqi/dcY9GMPsZDs=;
        b=FKvBRRYMeuMDfNLZ+rDGVhAr45x5g9VQOoIs3OLOLLW3b/j3YuCT4IQ2zcV16hm1yv
         Wf0FHt5p852QMgqYpIy+AP7djw3RAUROWobD1SbcYkQbvE4uJi5mlCrRmeh1IWMY/7FB
         RpgbFdmF51WCUOTA3TPVDxitCpbEhdIny+rSRnIOOz6hrb4JfCeNXnbxaTKDlChFdPwF
         t6rla2jehaRTKGQOkEh5HKORoWprT0HNv37FxWnZdfdHxn/rSFfVxs0GXEUEU8ZoA1B5
         Rsp/VEtNXfQWMJ8lJf9lQdUydEuqkczaJgVxUWDYmNe9oPhKLFDl7OrnXN/2gaaoB4hM
         xBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gc+Ey24cOtq0YnlGdaIZXPrHIGUrqi/dcY9GMPsZDs=;
        b=aAP14OtZ3dJ3RCk+QagHnGncWUy/VP3TAUINgYp0Eyxxue5ADgThmA22yztOLqcMlR
         jGlG1K6vFeKw/7GIvHPomXc4t5o35atYG91a+wKT+qoSUiBZUoy+OL+OOQ1sFqKpuJPz
         mcLocVi3TOApOmVGYBabZ5gFcmeDkMNJkUxH4my0+z77GcVna8J/84vXWznrWj11hxzR
         1lGkURW7eJnCnSUN+fCYZTGpGmqDp1KG1sLdphn2YAkyUAK+0CZfgZRrOxF9pnNE/Gca
         j+7rGZHLefTPYK8JznErl3ZeRpaEwLPNAC6PEDSL8+twk3lz5wy7qt2RA2GcqQnSmXtk
         6qRQ==
X-Gm-Message-State: AO0yUKV9mguFP3biANbgEsoirxrLguT2FD5LrcL8az3ddp+luZ5tpfh1
        3t3zIzjz1ZtZLxrrHqbQrM7GcsIVXN/OJA==
X-Google-Smtp-Source: AK7set//e+3EAbp5kraTmogWd5f/aqWKEDBDB0STJJ1nNxE4Tb4iYKcKqaQg9ehaTtSlo2VmFoe4yQ==
X-Received: by 2002:adf:ff82:0:b0:2c5:499e:df69 with SMTP id j2-20020adfff82000000b002c5499edf69mr4473428wrr.68.1676134751592;
        Sat, 11 Feb 2023 08:59:11 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:11 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 4/5] hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero
Date:   Sat, 11 Feb 2023 17:59:22 +0100
Message-Id: <20230211165923.17807-5-leonard.anderweit@gmail.com>
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

Add the option to control fan PWM on Aquacomputer Aquaero. The Aquaero is the
most complex Aquacomputer device, control is therefore more complicated then on
already supported devices.
Setting PWM requires multiple steps. First, an internal static PWM controller
is set to the desired PWM value. Second, the fan is set to use that cwPWMpwm
controller. Last, the minimum and maximum accepted PWM values of the fan are
set to allow all possible PWM values.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
 drivers/hwmon/aquacomputer_d5next.c         | 63 +++++++++++++++++++--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index de43374940b8..2dbb3bd37878 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -25,7 +25,8 @@ communicate through proprietary USB HID protocols.
 
 The Aquaero devices expose eight physical, eight virtual and four calculated
 virtual temperature sensors, as well as two flow sensors. The fans expose their
-speed (in RPM), power, voltage and current. The temperature offset can be controlled.
+speed (in RPM), power, voltage and current. The temperature offset and the fan speed
+can be controlled.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 95461e2907e1..02551c26918a 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -104,6 +104,9 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
 #define AQUAERO_NUM_FLOW_SENSORS		2
 #define AQUAERO_CTRL_REPORT_SIZE		0xa93
+#define AQUAERO_CTRL_PRESET_ID			0x5c
+#define AQUAERO_CTRL_PRESET_SIZE		0x02
+#define AQUAERO_CTRL_PRESET_START		0x55c
 
 /* Sensor report offsets for Aquaero fan controllers */
 #define AQUAERO_SENSOR_START			0x65
@@ -118,6 +121,10 @@ static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
 
 /* Control report offsets for the Aquaero fan controllers */
 #define AQUAERO_TEMP_CTRL_OFFSET	0xdb
+#define AQUAERO_FAN_CTRL_MIN_PWR_OFFSET	0x04
+#define AQUAERO_FAN_CTRL_MAX_PWR_OFFSET	0x06
+#define AQUAERO_FAN_CTRL_SRC_OFFSET	0x10
+static u16 aquaero_ctrl_fan_offsets[] = { 0x20c, 0x220, 0x234, 0x248 };
 
 /* Specs of the D5 Next pump */
 #define D5NEXT_NUM_FANS			2
@@ -856,13 +863,22 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		*val = priv->power_input[channel];
 		break;
 	case hwmon_pwm:
-		if (priv->fan_ctrl_offsets) {
+		switch (priv->kind) {
+		case aquaero:
+			ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
+					       val, AQC_BE16);
+			if (ret < 0)
+				return ret;
+			*val = aqc_percent_to_pwm(*val);
+			break;
+		default:
 			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
 					       val, AQC_BE16);
 			if (ret < 0)
 				return ret;
 
 			*val = aqc_percent_to_pwm(ret);
+			break;
 		}
 		break;
 	case hwmon_in:
@@ -921,6 +937,10 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		     long val)
 {
 	int ret, pwm_value;
+	/* Arrays for setting multiple values at once in the control report */
+	int ctrl_values_offsets[4];
+	long ctrl_values[4];
+	int ctrl_values_types[4];
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
 	switch (type) {
@@ -955,15 +975,47 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
-			if (priv->fan_ctrl_offsets) {
-				pwm_value = aqc_pwm_to_percent(val);
-				if (pwm_value < 0)
-					return pwm_value;
+			pwm_value = aqc_pwm_to_percent(val);
+			if (pwm_value < 0)
+				return pwm_value;
 
+			switch (priv->kind) {
+			case aquaero:
+				/* Write pwm value to preset corresponding to the channel */
+				ctrl_values_offsets[0] = AQUAERO_CTRL_PRESET_START +
+				    channel * AQUAERO_CTRL_PRESET_SIZE;
+				ctrl_values[0] = pwm_value;
+				ctrl_values_types[0] = AQC_BE16;
+
+				/* Write preset number in fan control source */
+				ctrl_values_offsets[1] = priv->fan_ctrl_offsets[channel] +
+				    AQUAERO_FAN_CTRL_SRC_OFFSET;
+				ctrl_values[1] = AQUAERO_CTRL_PRESET_ID + channel;
+				ctrl_values_types[1] = AQC_BE16;
+
+				/* Set minimum power to 0 to allow the fan to turn off */
+				ctrl_values_offsets[2] = priv->fan_ctrl_offsets[channel] +
+				    AQUAERO_FAN_CTRL_MIN_PWR_OFFSET;
+				ctrl_values[2] = 0;
+				ctrl_values_types[2] = AQC_BE16;
+
+				/* Set maximum power to 255 to allow the fan to reach max speed */
+				ctrl_values_offsets[3] = priv->fan_ctrl_offsets[channel] +
+				    AQUAERO_FAN_CTRL_MAX_PWR_OFFSET;
+				ctrl_values[3] = aqc_pwm_to_percent(255);
+				ctrl_values_types[3] = AQC_BE16;
+
+				ret = aqc_set_ctrl_vals(priv, ctrl_values_offsets, ctrl_values,
+							ctrl_values_types, 4);
+				if (ret < 0)
+					return ret;
+				break;
+			default:
 				ret = aqc_set_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
 						       pwm_value, AQC_BE16);
 				if (ret < 0)
 					return ret;
+				break;
 			}
 			break;
 		default:
@@ -1286,6 +1338,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->num_fans = AQUAERO_NUM_FANS;
 		priv->fan_sensor_offsets = aquaero_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = aquaero_ctrl_fan_offsets;
 
 		priv->num_temp_sensors = AQUAERO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
-- 
2.39.1

