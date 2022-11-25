Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97763913E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKYVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKYVzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:55:42 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F8455CAC;
        Fri, 25 Nov 2022 13:55:41 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id l11so7987748edb.4;
        Fri, 25 Nov 2022 13:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D3EDYbGccBK89yykxes9BQKaCfAxUWSmOZVPyYSYNP4=;
        b=HW0RUCPUMjBLDO1TxAyw2BM+t22jEI0sTP6233lB+dAXLsWzsZYFkXRYkpOrQXnWEP
         dyQgnwg8KFMCMlQQIPTk1hOYObv3To/VzmjzT7wv2cfQjtYf8r27A++EDccRDn1Y90Sv
         8XFBcC18B6F/GlKYFzBr34ODmhTIKZRwUt1eNcl07WwRjG7mDOULGTz6pFuzSIgXHikx
         og6NNgCfzlPbmGrpNcvwbfNFMBZHngQh5LTzaflitNv8wFH5xPrMF0LHXuOACoBaItZA
         gP0vnA3+rMbT8VDL9UZzSxJEjDY6wo63azhqXJLVxeAFNurOBdKIpqyWDZ7BcyFDa2cw
         SexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3EDYbGccBK89yykxes9BQKaCfAxUWSmOZVPyYSYNP4=;
        b=qYNMOi5bwr7F/Ely6ITIFGzihZgYjCui0/4ghK3AIvjI7/O4+iEOKWS9SgQfJ8zqsk
         AZQsupbpkwZBSEGuhJ5C93IqX819kjY56mBUlx1LBhOjghFZSyPD4jM42KM/VNtb7e4K
         auiok2HYEsuSaD0RxvL8rpULV5/oobTATw9IQ0ySc7To5BJfvFmp+JTLuz7QIWfY60eQ
         CogTfPRCVNnyTnovCPZOXnNPmtBNl57hPEmbcSyOHA9tB0rVmbJVYpX/GmF1WV/9WFdY
         taU8eJ1HZ710HukyF5fPPR+nnmVHxwrKk7f2jz1Z5nea56Kgqyvifv4k1lLzRMNJhN5a
         qS2Q==
X-Gm-Message-State: ANoB5pmU/hJHT4jNiU+8afqTlAX+Isp/FFTu6N5xdH8wGr++RHm1YzcF
        DfT6VIZ+oLS5K9JFpc+RwVZlHjjVd7E4SA==
X-Google-Smtp-Source: AA0mqf4l5vaneNpIO321KGUaXFfMa/VazMYDj+chO79WirXmWnJ3kp1CnIm7BqmmX2Maf1ZYP4NUNg==
X-Received: by 2002:a05:6402:1aca:b0:469:701b:588d with SMTP id ba10-20020a0564021aca00b00469701b588dmr19471780edb.384.1669413339594;
        Fri, 25 Nov 2022 13:55:39 -0800 (PST)
Received: from fedora.. ([87.116.166.89])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709063d3100b0077b2b0563f4sm2009764ejf.173.2022.11.25.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 13:55:39 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     leonard.anderweit@gmail.com,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for Quadro flow sensor pulses
Date:   Fri, 25 Nov 2022 22:55:15 +0100
Message-Id: <20221125215515.31380-1-savicaleksa83@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Add support for reading and writing flow sensor pulses value on
the Aquacomputer Quadro. Implemented by Leonard Anderweit [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/45

Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  3 +-
 drivers/hwmon/aquacomputer_d5next.c         | 68 ++++++++++++++++-----
 2 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 15226346434d..637bdbc8fcad 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -39,7 +39,7 @@ current.
 
 The Quadro exposes four physical and sixteen virtual temperature sensors, a flow
 sensor and four PWM controllable fans, along with their speed (in RPM), power,
-voltage and current.
+voltage and current. Flow sensor pulses are also available.
 
 The Farbwerk and Farbwerk 360 expose four temperature sensors. Additionally,
 sixteen virtual temperature sensors of the Farbwerk 360 are exposed.
@@ -64,6 +64,7 @@ Sysfs entries
 temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
 temp[1-4]_offset Temperature sensor correction offset (in millidegrees Celsius)
 fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
+fan5_pulses      Quadro flow sensor pulses
 power[1-8]_input Pump/fan power (in micro Watts)
 in[0-7]_input    Pump/fan voltage (in milli Volts)
 curr[1-8]_input  Pump/fan current (in milli Amperes)
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 49d3f9876fe8..77a3ac33d4ac 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -136,6 +136,7 @@ static u8 quadro_sensor_fan_offsets[] = { 0x70, 0x7D, 0x8A, 0x97 };
 
 /* Control report offsets for the Quadro */
 #define QUADRO_TEMP_CTRL_OFFSET		0xA
+#define QUADRO_FLOW_PULSES_CTRL_OFFSET	0x6
 static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed offsets (0-100%) */
 
 /* Specs of High Flow Next flow sensor */
@@ -303,6 +304,7 @@ struct aqc_data {
 	u16 temp_ctrl_offset;
 	u16 power_cycle_count_offset;
 	u8 flow_sensor_offset;
+	u8 flow_pulses_ctrl_offset;
 
 	/* General info, same across all devices */
 	u32 serial_number[2];
@@ -461,20 +463,32 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 		}
 		break;
 	case hwmon_fan:
-		switch (priv->kind) {
-		case highflownext:
-			/* Special case to support flow sensor, water quality and conductivity */
-			if (channel < 3)
-				return 0444;
-			break;
-		case quadro:
-			/* Special case to support flow sensor */
-			if (channel < priv->num_fans + 1)
-				return 0444;
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_label:
+			switch (priv->kind) {
+			case highflownext:
+				/* Special case to support flow sensor, water quality
+				 * and conductivity
+				 */
+				if (channel < 3)
+					return 0444;
+				break;
+			case quadro:
+				/* Special case to support flow sensor */
+				if (channel < priv->num_fans + 1)
+					return 0444;
+				break;
+			default:
+				if (channel < priv->num_fans)
+					return 0444;
+				break;
+			}
 			break;
-		default:
-			if (channel < priv->num_fans)
-				return 0444;
+		case hwmon_fan_pulses:
+			/* Special case for Quadro flow sensor */
+			if (priv->kind == quadro && channel == priv->num_fans)
+				return 0644;
 			break;
 		}
 		break;
@@ -552,7 +566,18 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		}
 		break;
 	case hwmon_fan:
-		*val = priv->speed_input[channel];
+		switch (attr) {
+		case hwmon_fan_input:
+			*val = priv->speed_input[channel];
+			break;
+		case hwmon_fan_pulses:
+			ret = aqc_get_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			break;
+		}
 		break;
 	case hwmon_power:
 		*val = priv->power_input[channel];
@@ -632,6 +657,18 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			return -EOPNOTSUPP;
 		}
 		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_pulses:
+			val = clamp_val(val, 10, 1000);
+			ret = aqc_set_ctrl_val(priv, priv->flow_pulses_ctrl_offset, val);
+			if (ret < 0)
+				return ret;
+			break;
+		default:
+			break;
+		}
+		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
@@ -691,7 +728,7 @@ static const struct hwmon_channel_info *aqc_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
-			   HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_PULSES,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL,
 			   HWMON_F_INPUT | HWMON_F_LABEL),
@@ -1000,6 +1037,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 
 		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
+		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
 		priv->temp_label = label_temp_sensors;
-- 
2.38.1

