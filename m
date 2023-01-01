Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3F65AB13
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjAATCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAATCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:02:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D56F21AB;
        Sun,  1 Jan 2023 11:02:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kw15so62343535ejc.10;
        Sun, 01 Jan 2023 11:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCtn7UDCmjdEkLn74uIR0ZYG/vD589RMJSIj4ufxEqw=;
        b=B7QxH0ud+BvXR4QhLh5BpuyDxIkin5cki1GpRDd6Bk6P1VzGcP7zbrQzt5onhO6OCV
         QJR451XZKiv7jePsL+P1uX55lmDjrAeZn4VASjcsDFSXUjUCBVksLCIkDtfTNBr3SedJ
         C0MPwUHsKkBfWQolFo3sMYIUcigEGZqFqFVPf3dP8verkFbh8yCvi2+1o7XzjygXkJx8
         0BDrn3QOUfQvpJHA8WNhcqu6QH/UnIRW/vtB85ul1t6pmdYHGW6JK0csvgBg2cdIY0cH
         sEr9oMRPb+Z5QipP86RUSZGCpSUAD6keNXIVUchIRIpFqNo1tqfFMYIbRoxh+GyYh3lc
         Su7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCtn7UDCmjdEkLn74uIR0ZYG/vD589RMJSIj4ufxEqw=;
        b=5TQmHaMkhBmo8hqFMBkr748zTw8MVYdnWgcnyC4h0n5XI0An+QpND+odAaDzcTcIxa
         eTVreZOe0UTjEyzdAUqqd8yKpI8KXdzgMl/dNiJAEUq8d1z0yczEMLXeVKOO8nlk/0h6
         +tUFfZRQHE8niy+i8oM7dVY759PBKTIR4um2vVKwnfXu5tmh9pKgFa1HcRdvUJ2LL3GN
         HavVgeKV4ys/bNQG/yxGYVRXUJW71ddiFgjB9YN2FHlcetQYUij0YQOJcC9OZ9WjagQn
         AogCvx55Ja64ZxlffKsZNCX/cwe2o6MhBi2blRAe/n8ED4O59xDamBYbnR/jLtC8MuKv
         Vllg==
X-Gm-Message-State: AFqh2kqMI/fqqXGPYCwAB3eEjhPWUDcKZnlbp6l7+urRYG6gjF8TWxcP
        0cZ8OA47H2gzMApyr9lxEGSt+j2dwp4=
X-Google-Smtp-Source: AMrXdXtV5KNnaav/0r1iJ31riO9o6eu3XEtltPLpUQ0LJ1BPNiEKlrznhVlUSy6pUzjcRGkXMCvYdw==
X-Received: by 2002:a17:906:958:b0:7c0:be4d:46d6 with SMTP id j24-20020a170906095800b007c0be4d46d6mr30002669ejd.59.1672599731033;
        Sun, 01 Jan 2023 11:02:11 -0800 (PST)
Received: from fedora.. ([87.116.164.178])
        by smtp.gmail.com with ESMTPSA id hk25-20020a170906c9d900b007c094d31f35sm12050578ejb.76.2023.01.01.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 11:02:10 -0800 (PST)
From:   Aleksa Savic <savicaleksa83@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (aquacomputer_d5next) Add support for reading calculated Aquaero sensors
Date:   Sun,  1 Jan 2023 20:00:56 +0100
Message-Id: <20230101190056.1357124-1-savicaleksa83@gmail.com>
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

Add support for reading four calculated virtual temp sensors on the
Aquacomputer Aquaero. Values of these sensors are calculated on the
device itself based on what the user configured in the official software.
Configuring these sensors is not currently reverse engineered.

Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  6 +--
 drivers/hwmon/aquacomputer_d5next.c         | 49 ++++++++++++++++++---
 2 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index b94ff08080bf..3f7880fb8116 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -21,9 +21,9 @@ Description
 This driver exposes hardware sensors of listed Aquacomputer devices, which
 communicate through proprietary USB HID protocols.
 
-The Aquaero devices expose eight temperature sensors, eight virtual temperature
-sensors and two flow senors. The fans expose their speed (in RPM), power,
-voltage and current.
+The Aquaero devices expose eight physical, eight virtual and four calculated
+virtual temperature sensors, as well as two flow sensors. The fans expose their
+speed (in RPM), power, voltage and current.
 
 For the D5 Next pump, available sensors are pump and fan speed, power, voltage
 and current, as well as coolant temperature and eight virtual temp sensors. Also
diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 0fd00cfb86c8..c1b885240ddf 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -77,11 +77,13 @@ static u8 secondary_ctrl_report[] = {
 #define AQUAERO_NUM_FANS			4
 #define AQUAERO_NUM_SENSORS			8
 #define AQUAERO_NUM_VIRTUAL_SENSORS		8
+#define AQUAERO_NUM_CALC_VIRTUAL_SENSORS	4
 #define AQUAERO_NUM_FLOW_SENSORS		2
 
 /* Sensor report offsets for Aquaero fan controllers */
 #define AQUAERO_SENSOR_START			0x65
 #define AQUAERO_VIRTUAL_SENSOR_START		0x85
+#define AQUAERO_CALC_VIRTUAL_SENSOR_START	0x95
 #define AQUAERO_FLOW_SENSORS_START		0xF9
 #define AQUAERO_FAN_VOLTAGE_OFFSET		0x04
 #define AQUAERO_FAN_CURRENT_OFFSET		0x06
@@ -232,6 +234,13 @@ static const char *const label_virtual_temp_sensors[] = {
 	"Virtual sensor 16",
 };
 
+static const char *const label_aquaero_calc_temp_sensors[] = {
+	"Calc. virtual sensor 1",
+	"Calc. virtual sensor 2",
+	"Calc. virtual sensor 3",
+	"Calc. virtual sensor 4"
+};
+
 /* Labels for Octo and Quadro (except speed) */
 static const char *const label_fan_speed[] = {
 	"Fan 1 speed",
@@ -361,6 +370,8 @@ struct aqc_data {
 	int temp_sensor_start_offset;
 	int num_virtual_temp_sensors;
 	int virtual_temp_sensor_start_offset;
+	int num_calc_virt_temp_sensors;
+	int calc_virt_temp_sensor_start_offset;
 	u16 temp_ctrl_offset;
 	u16 power_cycle_count_offset;
 	int num_flow_sensors;
@@ -378,7 +389,7 @@ struct aqc_data {
 	u32 power_cycles;
 
 	/* Sensor values */
-	s32 temp_input[20];	/* Max 4 physical and 16 virtual */
+	s32 temp_input[20];	/* Max 4 physical and 16 virtual or 8 physical and 12 virtual */
 	u16 speed_input[8];
 	u32 power_input[8];
 	u16 voltage_input[8];
@@ -387,6 +398,7 @@ struct aqc_data {
 	/* Label values */
 	const char *const *temp_label;
 	const char *const *virtual_temp_label;
+	const char *const *calc_virt_temp_label;	/* For Aquaero */
 	const char *const *speed_label;
 	const char *const *power_label;
 	const char *const *voltage_label;
@@ -507,7 +519,9 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 			}
 		}
 
-		if (channel < priv->num_temp_sensors + priv->num_virtual_temp_sensors)
+		if (channel <
+		    priv->num_temp_sensors + priv->num_virtual_temp_sensors +
+		    priv->num_calc_virt_temp_sensors)
 			switch (attr) {
 			case hwmon_temp_label:
 			case hwmon_temp_input:
@@ -676,12 +690,20 @@ static int aqc_read_string(struct device *dev, enum hwmon_sensor_types type, u32
 {
 	struct aqc_data *priv = dev_get_drvdata(dev);
 
+	/* Number of sensors that are not calculated */
+	int num_non_calc_sensors = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
+
 	switch (type) {
 	case hwmon_temp:
-		if (channel < priv->num_temp_sensors)
+		if (channel < priv->num_temp_sensors) {
 			*str = priv->temp_label[channel];
-		else
-			*str = priv->virtual_temp_label[channel - priv->num_temp_sensors];
+		} else {
+			if (priv->kind == aquaero && channel >= num_non_calc_sensors)
+				*str =
+				    priv->calc_virt_temp_label[channel - num_non_calc_sensors];
+			else
+				*str = priv->virtual_temp_label[channel - priv->num_temp_sensors];
+		}
 		break;
 	case hwmon_fan:
 		*str = priv->speed_label[channel];
@@ -910,6 +932,20 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 
 	/* Special-case sensor readings */
 	switch (priv->kind) {
+	case aquaero:
+		/* Read calculated virtual temp sensors */
+		i = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
+		for (j = 0; j < priv->num_calc_virt_temp_sensors; j++) {
+			sensor_value = get_unaligned_be16(data +
+					priv->calc_virt_temp_sensor_start_offset +
+					j * AQC_SENSOR_SIZE);
+			if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
+				priv->temp_input[i] = -ENODATA;
+			else
+				priv->temp_input[i] = sensor_value * 10;
+			i++;
+		}
+		break;
 	case d5next:
 		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
 		priv->voltage_input[3] = get_unaligned_be16(data + D5NEXT_12V_VOLTAGE) * 10;
@@ -1046,11 +1082,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = AQUAERO_SENSOR_START;
 		priv->num_virtual_temp_sensors = AQUAERO_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = AQUAERO_VIRTUAL_SENSOR_START;
+		priv->num_calc_virt_temp_sensors = AQUAERO_NUM_CALC_VIRTUAL_SENSORS;
+		priv->calc_virt_temp_sensor_start_offset = AQUAERO_CALC_VIRTUAL_SENSOR_START;
 		priv->num_flow_sensors = AQUAERO_NUM_FLOW_SENSORS;
 		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
+		priv->calc_virt_temp_label = label_aquaero_calc_temp_sensors;
 		priv->speed_label = label_aquaero_speeds;
 		priv->power_label = label_fan_power;
 		priv->voltage_label = label_fan_voltage;
-- 
2.38.1

