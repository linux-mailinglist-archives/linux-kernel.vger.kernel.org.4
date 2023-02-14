Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A2169705E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbjBNWC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjBNWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:58 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10943305F8;
        Tue, 14 Feb 2023 14:01:57 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so17218940wrb.8;
        Tue, 14 Feb 2023 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRsF8ja+tN5dl8vKAEs9o0Dk+bv83K0UHjvvq2K1ytI=;
        b=obMn1FX8n+MUzihMA5YMDtgm4JW0ECMx3XUTO5JWDobb0jddOwXK9G2SOvOnlbHc51
         g7rQDcCCjKocdlM15aCRjzIX8UNY8KF4tgqyCezyQ01WwPTXDBLaE97WAa67Nojn4IRS
         5seAeoSNblaqvVFnX8ugtuVSAlvPKzet5iZMjG+sTCGiFQNCbnkMRh7UIE+7wJpzQ1C8
         jyFWH7qKmo8uYdLuYCYD7WVwgD4BgK/8+CMQJYa5t3KbcbC3LOAdf9SgvI1FgzfXewwU
         MnUxJ85VVXrvDbAp2DoheTbirF+sG/mASbKHlDvJiCJt4ZrKUlrVc1jGZF8Tpm+2uH1c
         7r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRsF8ja+tN5dl8vKAEs9o0Dk+bv83K0UHjvvq2K1ytI=;
        b=KEFaXt8okGELJhw4atfWrHRMzbcfnPF0SF65CQC/lfr4IJ71gCbufLEeKhUZFiZs68
         6poGL/lEdWWBdJAb6+mQe54Wk/F8Nl/dwhOZituqOE4jtZ4jJ+xsr84fatcrbzn0Iei1
         VGG9VwLgBosnDViczk3NT2hAa7++EZQMB9/I/tpa2oPIvig4bIQ6N80PSrZyv/RxWxsy
         Wg5p8BjfwX4VukR3oNLNDQcNkrfftifFIoQyyG+aHoc37SUjO9hOZDOv1fJ4mGP1s7z4
         6CGI2I3v29s/itafI1aTQWNDLP7SAGP8YKWYBsjb97lT7SY7/BkdBP+b1oKWWWLNcM4j
         r6yA==
X-Gm-Message-State: AO0yUKVhYubxHU/q5d3AWPMsQO5qoZgxKCA5q+A8ZJtK6xNMF2Eia9n6
        n37skg90MvS53nAhgLQCL77WJfCbqW6eLw==
X-Google-Smtp-Source: AK7set971LW0ys8KLs3D13GvqB1Jwv+kgEKZLz2dcEUGq0n19QHFszxPPNCbhVN6BSVQsgPueiLcKA==
X-Received: by 2002:adf:f80b:0:b0:2c5:4c8c:410d with SMTP id s11-20020adff80b000000b002c54c8c410dmr3289871wrp.6.1676412115485;
        Tue, 14 Feb 2023 14:01:55 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:55 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 6/6] hwmon: (aquacomputer_d5next) Add fan PWM control for Aquaero
Date:   Tue, 14 Feb 2023 23:02:21 +0100
Message-Id: <20230214220221.15003-7-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214220221.15003-1-leonard.anderweit@gmail.com>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
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
is set to the desired PWM value. Second, the fan is set to use that PWM
controller. Last, the minimum and maximum accepted PWM values of the fan are
set to allow all possible PWM values.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
 drivers/hwmon/aquacomputer_d5next.c         | 63 +++++++++++++++++++--
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 618c826093a2..c604d4becb8d 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -25,7 +25,8 @@ communicate through proprietary USB HID protocols.
 
 The Aquaero devices expose eight physical, eight virtual and four calculated
 virtual temperature sensors, as well as two flow sensors. The fans expose their
-speed (in RPM), power, voltage and current. Temperature offsets can be controlled.
+speed (in RPM), power, voltage and current. Temperature offsets and fan speeds
+can be controlled.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 61c1ffcd8f3b..a6cff7f9cac9 100644
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
@@ -857,13 +864,22 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
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
@@ -922,6 +938,10 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		     long val)
 {
 	int ret, pwm_value;
+	/* Arrays for setting multiple values at once in the control report */
+	int ctrl_values_offsets[4];
+	long ctrl_values[4];
+	int ctrl_values_types[4];
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
 	switch (type) {
@@ -956,15 +976,47 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
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
@@ -1287,6 +1339,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->num_fans = AQUAERO_NUM_FANS;
 		priv->fan_sensor_offsets = aquaero_sensor_fan_offsets;
+		priv->fan_ctrl_offsets = aquaero_ctrl_fan_offsets;
 
 		priv->num_temp_sensors = AQUAERO_NUM_SENSORS;
 		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
-- 
2.39.1

