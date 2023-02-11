Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA166932B8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBKQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBKQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:59:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C552A4EE8;
        Sat, 11 Feb 2023 08:59:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id by3so6846100wrb.10;
        Sat, 11 Feb 2023 08:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ljPvl7RI6IskznJgFi6iQwmZKfNOsC/TK50tjYkT9I=;
        b=ouTcX3hZj7mUUVxxjL/QfVbZpAl4KGRI8XMHD0X90W1gUQBMPuQx2koh8i6UHSZgGc
         76/M2hAvT9pakBCmXJPk91wqYWByMvYM5N9TXs9h1FkVcRTVCQgZCgrsxn5tP9D0qSEU
         C7WQ5pAg2VtNervXJ0n51WRYjTlgvIJLUQxl1H9wxe9nA0ljK/BxkqgjQE376PKl8YSZ
         FagmRgb04gLmT7GG3RALib6DEJAfEMINeAT1wJ7ALzUEslhfjsMn471d+QYA5BpWDOmc
         xVRwheW27MAouFFSaFUa7472g+ncZGdnWC2PIHFvTNiXTWsIFkQGpRYTavdq+ohpDi1c
         XD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ljPvl7RI6IskznJgFi6iQwmZKfNOsC/TK50tjYkT9I=;
        b=gbtB2V/sS3zUufdKDujYt6h+Zwhll6aGHRTAp/Jgx9Vsj7bNr1BiK3XckKApj+MJg8
         C+m2zyBjumriFty9HZNoCl9cWvX3WH4q8NJMmwJvRKW3gHazg6xTg2gidtU2hUHvEaY8
         QA1U70SzeSw/4TRt8x9OhJNrh1GUWoQcGCJQB1c+Kmeup7G2AjvU5J3uC+JDo/LtGm65
         7bzPPjv50ot/LB5dyJJ4rzjuxvht/ysU+wjMkm7u//AX7ZKcDW6RT7uyb2W4F6V96dQT
         E0E0pyyKKUnplw+zXFMfBlJsgdDtSlIroHq7uKBojIUFqG/+9AFv+fewmKVDPvHNIaJh
         +ZLw==
X-Gm-Message-State: AO0yUKW/A7dZEXwV8zahESG/nb1Nkcq5bKPk9Uw7uhj+JuseGP1RlFwZ
        Y+a3V3hhE+urg8QxVwZ7J2tr2jap6dyLaw==
X-Google-Smtp-Source: AK7set9SoJihj4CsphsWv1veXk6foJ34RavO3fVT2l/sU4PffJzgL0j5iEMb46TwGngaYhGiOc6XvQ==
X-Received: by 2002:adf:f9ca:0:b0:2c5:4d68:5512 with SMTP id w10-20020adff9ca000000b002c54d685512mr2202091wrr.19.1676134752386;
        Sat, 11 Feb 2023 08:59:12 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20d3:ac00:30d6:d4a1:e6f6:5876])
        by smtp.gmail.com with ESMTPSA id k16-20020adfe8d0000000b002c54536c662sm5097893wrn.34.2023.02.11.08.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 08:59:12 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 5/5] hwmon: (aquacomputer_d5next) Add PWM mode control for Aquaero
Date:   Sat, 11 Feb 2023 17:59:23 +0100
Message-Id: <20230211165923.17807-6-leonard.anderweit@gmail.com>
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

Add PWM mode control for the Aquacomputer Aquaero. On the Aquaero 6 all four
ports can switch between DC and PWM control. On the Aquaero 5 this is only
supported for the fourth port, but changing the setting for the other ports has
no consequences.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  4 +-
 drivers/hwmon/aquacomputer_d5next.c         | 86 ++++++++++++++++-----
 2 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 2dbb3bd37878..002cb9eecdf5 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -26,7 +26,8 @@ communicate through proprietary USB HID protocols.
 The Aquaero devices expose eight physical, eight virtual and four calculated
 virtual temperature sensors, as well as two flow sensors. The fans expose their
 speed (in RPM), power, voltage and current. The temperature offset and the fan speed
-can be controlled.
+can be controlled. The fan PWM mode (DC/PWM) can be controlled. The Aquaero 6 supports
+this on all four fan connectors and the Aquaero 5 only on the fourth connector.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
@@ -83,6 +84,7 @@ power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
 curr[1-8]_input  Pump/fan current (in milli Amperes)
 pwm[1-8]         Fan PWM (0 - 255)
+pwm[1-4]_mode    Fan control mode (0: DC mode; 1: PWM mode)
 ================ ==============================================================
 
 Debugfs entries
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 02551c26918a..2ec00124785f 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -123,6 +123,7 @@ static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
 #define AQUAERO_TEMP_CTRL_OFFSET	0xdb
 #define AQUAERO_FAN_CTRL_MIN_PWR_OFFSET	0x04
 #define AQUAERO_FAN_CTRL_MAX_PWR_OFFSET	0x06
+#define AQUAERO_FAN_CTRL_MODE_OFFSET	0x0f
 #define AQUAERO_FAN_CTRL_SRC_OFFSET	0x10
 static u16 aquaero_ctrl_fan_offsets[] = { 0x20c, 0x220, 0x234, 0x248 };
 
@@ -672,10 +673,23 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		break;
 	case hwmon_pwm:
 		if (priv->fan_ctrl_offsets && channel < priv->num_fans) {
-			switch (attr) {
-			case hwmon_pwm_input:
-				return 0644;
+			switch (priv->kind) {
+			case aquaero:
+				switch (attr) {
+				case hwmon_pwm_input:
+				case hwmon_pwm_mode:
+					return 0644;
+				default:
+					break;
+				}
+				break;
 			default:
+				switch (attr) {
+				case hwmon_pwm_input:
+					return 0644;
+				default:
+					break;
+				}
 				break;
 			}
 		}
@@ -863,22 +877,46 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		*val = priv->power_input[channel];
 		break;
 	case hwmon_pwm:
-		switch (priv->kind) {
-		case aquaero:
-			ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START + channel * AQUAERO_CTRL_PRESET_SIZE,
-					       val, AQC_BE16);
-			if (ret < 0)
-				return ret;
-			*val = aqc_percent_to_pwm(*val);
+		switch (attr) {
+		case hwmon_pwm_input:
+			switch (priv->kind) {
+			case aquaero:
+				ret = aqc_get_ctrl_val(priv, AQUAERO_CTRL_PRESET_START +
+						       channel * AQUAERO_CTRL_PRESET_SIZE,
+						       val, AQC_BE16);
+				if (ret < 0)
+					return ret;
+				*val = aqc_percent_to_pwm(*val);
+				break;
+			default:
+				ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
+						       val, AQC_BE16);
+				if (ret < 0)
+					return ret;
+
+				*val = aqc_percent_to_pwm(ret);
+				break;
+			}
 			break;
-		default:
-			ret = aqc_get_ctrl_val(priv, priv->fan_ctrl_offsets[channel],
-					       val, AQC_BE16);
+		case hwmon_pwm_mode:
+			ret = aqc_get_ctrl_val(priv,
+					       priv->fan_ctrl_offsets[channel] +
+					       AQUAERO_FAN_CTRL_MODE_OFFSET, val, AQC_8);
 			if (ret < 0)
 				return ret;
 
-			*val = aqc_percent_to_pwm(ret);
+			switch (*val) {
+			case 0:	/* DC mode */
+				break;
+			case 2:	/* PWM mode */
+				*val = 1;
+				break;
+			default:
+				break;
+			}
 			break;
+		default:
+			return -EOPNOTSUPP;
 		}
 		break;
 	case hwmon_in:
@@ -936,7 +974,7 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
 static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
 		     long val)
 {
-	int ret, pwm_value;
+	int ret, pwm_value, ctrl_mode;
 	/* Arrays for setting multiple values at once in the control report */
 	int ctrl_values_offsets[4];
 	long ctrl_values[4];
@@ -1018,6 +1056,16 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 				break;
 			}
 			break;
+		case hwmon_pwm_mode:
+			if (val > 1 || val < 0)
+				return -EINVAL;
+			ctrl_mode = 2 * val;
+			ret = aqc_set_ctrl_val(priv,
+					       priv->fan_ctrl_offsets[channel] +
+					       AQUAERO_FAN_CTRL_MODE_OFFSET, ctrl_mode, AQC_8);
+			if (ret < 0)
+				return ret;
+			break;
 		default:
 			break;
 		}
@@ -1077,10 +1125,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
 			   HWMON_P_INPUT | HWMON_P_LABEL,
 			   HWMON_P_INPUT | HWMON_P_LABEL),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
+			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
+			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
+			   HWMON_PWM_INPUT | HWMON_PWM_MODE,
 			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT,
-- 
2.39.1

