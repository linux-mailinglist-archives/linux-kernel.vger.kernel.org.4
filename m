Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0985D64FEBD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiLRLcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiLRLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57276422;
        Sun, 18 Dec 2022 03:32:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f13-20020a1cc90d000000b003d08c4cf679so4611205wmb.5;
        Sun, 18 Dec 2022 03:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/yBxHd+8YC4wBMSoujgnt9WFjjMoc4F6zebxkDT7rA=;
        b=e04n22PUh9HTJJnTrs3svu9UYml5c26/3n6xroQlixSoamCKRgIp4h/08m+dJTzaM7
         Diubcz3Ult7xs5F7ToSQ8XfhF+D876dT9db+PM8glyJyk2T0V9uwcQ935G6aVkBXsOIl
         mHWxZOJ4HvbhUhifA6B4uPQAEWTsM/AbOsi09olqveGQoWS7alDpflC7vu4tkDJEHFlX
         OlL/ThMtEtjBSfDbfTq5zwmozMxndep/P/KvFGNSGKKmUaAa0ZeaNcqtWwM+nhi3YRVM
         8xdEu4f7OyMmcaWxaT23R94G0doSZZ7kCIa2bhP+xqu253+nrhd8Of5ZnkxrwHIO5Ov/
         sUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/yBxHd+8YC4wBMSoujgnt9WFjjMoc4F6zebxkDT7rA=;
        b=UqJga+WWdK0ORsMDSlsAO24tiAypfenoMPJJbdk7hDZCj3AaauKOK+xePPG3RSEOeV
         OIZx50xRqDX9PxaY3yXTi9T7shOHkJJ0sS7itLj+pp8QEM6t7/3JtSEkuJRd6E0J1lSP
         3Gt/ZKsDk2rHHHP5XOQ7hzjGuXQyem4f9SoN8DOym/SrnODMWwEjcAQZoTkj0NQz2/TI
         mqDKRrcb6i8pGGowja1lEMq4a71guBKILTy3pu8ybUFApguWB5/HoMDKhJoxA+hzA6Qr
         prpese2URtJ72Lin/lUqXCmBSr9nUfHcdQqAT4+DqIyhfFmSeR2eBdDMxKO0PuQdqwLI
         jHRg==
X-Gm-Message-State: ANoB5pmgcUKY7DZAuuJFL+Gfa9G+jYc5g4gVsWu3b80l7ENPe8JTXaaZ
        DU0gMcMcAIpCwVZLACO9sYDOjCJ0aX77BQ==
X-Google-Smtp-Source: AA0mqf6LPjNEoILNeV0EDRCaCsgDAkh35iA4P8Y7ncxG98gkhQk0BW+hTz4F6CajMU9UQTZETaL3kw==
X-Received: by 2002:a05:600c:1d2a:b0:3d2:2faf:e54b with SMTP id l42-20020a05600c1d2a00b003d22fafe54bmr16328656wms.6.1671363122396;
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 2/6] hwmon: (aquacomputer_d5next) Restructure flow sensor reading
Date:   Sun, 18 Dec 2022 12:31:27 +0100
Message-Id: <20221218113131.3752-3-leonard.anderweit@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221218113131.3752-1-leonard.anderweit@gmail.com>
References: <20221218113131.3752-1-leonard.anderweit@gmail.com>
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

Read flow sensors the same way for all devices instead of in special
cases. Implemented by Aleksa Savic [1].

[1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/commit/1c10912c5fdc8287d88378bcf1ef14d596f29462

Originally-from: Aleksa Savic <savicaleksa83@gmail.com>
Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 8fd9f7fd7ec4..388bf1e33e0d 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -125,6 +125,7 @@ static u16 octo_ctrl_fan_offsets[] = { 0x5B, 0xB0, 0x105, 0x15A, 0x1AF, 0x204, 0
 #define QUADRO_NUM_FANS			4
 #define QUADRO_NUM_SENSORS		4
 #define QUADRO_NUM_VIRTUAL_SENSORS	16
+#define QUADRO_NUM_FLOW_SENSORS		1
 #define QUADRO_CTRL_REPORT_SIZE		0x3c1
 
 /* Sensor report offsets for the Quadro */
@@ -141,6 +142,7 @@ static u16 quadro_ctrl_fan_offsets[] = { 0x37, 0x8c, 0xe1, 0x136 }; /* Fan speed
 
 /* Specs of High Flow Next flow sensor */
 #define HIGHFLOWNEXT_NUM_SENSORS	2
+#define HIGHFLOWNEXT_NUM_FLOW_SENSORS	1
 
 /* Sensor report offsets for the High Flow Next */
 #define HIGHFLOWNEXT_SENSOR_START	85
@@ -303,7 +305,8 @@ struct aqc_data {
 	int virtual_temp_sensor_start_offset;
 	u16 temp_ctrl_offset;
 	u16 power_cycle_count_offset;
-	u8 flow_sensor_offset;
+	int num_flow_sensors;
+	u8 flow_sensors_start_offset;
 	u8 flow_pulses_ctrl_offset;
 
 	/* General info, same across all devices */
@@ -475,8 +478,8 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
 					return 0444;
 				break;
 			case quadro:
-				/* Special case to support flow sensor */
-				if (channel < priv->num_fans + 1)
+				/* Special case to support flow sensors */
+				if (channel < priv->num_fans + priv->num_flow_sensors)
 					return 0444;
 				break;
 			default:
@@ -830,6 +833,13 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		    get_unaligned_be16(data + priv->fan_sensor_offsets[i] + AQC_FAN_CURRENT_OFFSET);
 	}
 
+	/* Flow sensor readings */
+	for (j = 0; j < priv->num_flow_sensors; j++) {
+		priv->speed_input[i] = get_unaligned_be16(data + priv->flow_sensors_start_offset +
+							  j * AQC_SENSOR_SIZE);
+		i++;
+	}
+
 	if (priv->power_cycle_count_offset != 0)
 		priv->power_cycles = get_unaligned_be32(data + priv->power_cycle_count_offset);
 
@@ -839,9 +849,6 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->voltage_input[2] = get_unaligned_be16(data + D5NEXT_5V_VOLTAGE) * 10;
 		priv->voltage_input[3] = get_unaligned_be16(data + D5NEXT_12V_VOLTAGE) * 10;
 		break;
-	case quadro:
-		priv->speed_input[4] = get_unaligned_be16(data + priv->flow_sensor_offset);
-		break;
 	case highflownext:
 		/* If external temp sensor is not connected, its power reading is also N/A */
 		if (priv->temp_input[1] == -ENODATA)
@@ -854,7 +861,6 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 		priv->voltage_input[1] =
 		    get_unaligned_be16(data + HIGHFLOWNEXT_5V_VOLTAGE_USB) * 10;
 
-		priv->speed_input[0] = get_unaligned_be16(data + HIGHFLOWNEXT_FLOW);
 		priv->speed_input[1] = get_unaligned_be16(data + HIGHFLOWNEXT_WATER_QUALITY);
 		priv->speed_input[2] = get_unaligned_be16(data + HIGHFLOWNEXT_CONDUCTIVITY);
 		break;
@@ -1034,11 +1040,13 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->temp_sensor_start_offset = QUADRO_SENSOR_START;
 		priv->num_virtual_temp_sensors = QUADRO_NUM_VIRTUAL_SENSORS;
 		priv->virtual_temp_sensor_start_offset = QUADRO_VIRTUAL_SENSORS_START;
+		priv->num_flow_sensors = QUADRO_NUM_FLOW_SENSORS;
+		priv->flow_sensors_start_offset = QUADRO_FLOW_SENSOR_OFFSET;
+
 		priv->temp_ctrl_offset = QUADRO_TEMP_CTRL_OFFSET;
 
 		priv->buffer_size = QUADRO_CTRL_REPORT_SIZE;
 
-		priv->flow_sensor_offset = QUADRO_FLOW_SENSOR_OFFSET;
 		priv->flow_pulses_ctrl_offset = QUADRO_FLOW_PULSES_CTRL_OFFSET;
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
@@ -1056,6 +1064,8 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 		priv->num_temp_sensors = HIGHFLOWNEXT_NUM_SENSORS;
 		priv->temp_sensor_start_offset = HIGHFLOWNEXT_SENSOR_START;
+		priv->num_flow_sensors = HIGHFLOWNEXT_NUM_FLOW_SENSORS;
+		priv->flow_sensors_start_offset = HIGHFLOWNEXT_FLOW;
 
 		priv->power_cycle_count_offset = QUADRO_POWER_CYCLES;
 
-- 
2.38.1

