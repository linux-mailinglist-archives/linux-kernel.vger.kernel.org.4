Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EA569705D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjBNWCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBNWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:01:57 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30523305E6;
        Tue, 14 Feb 2023 14:01:56 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co8so13487401wrb.1;
        Tue, 14 Feb 2023 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8wVCVDWqocKGppF+Fpoz1fhnzSpt25qSkQ0ztIc8eqY=;
        b=bAqRpZ2uGaI2rmZX6Rh5Xfd4vx+eBvYPZhZBYhrPZqajekiuk7fHGbffuQ4zKx4lqv
         CF82m2Pv0bUINLAIsQMrS4afy8WKjfOVaL6d7pt9ybiv/C71he06JDmOgcyxCauXughQ
         X5IdNRWoR/oMqu12iDJ7WRZt8XbypWqPHUSsJEg/6ij+5s57+KCLSR9ZOZdTUWw9nVDJ
         NPmIX2ynayj5BI2G6OblsT23Dwpd3Jaf205Gp+fplfhmhEVBQhVKwQA2ImfnOp6fOogx
         Pn1BsSOxLPn0R2b/faSxfxKJjfGLTCRWwMvyqPK7hTGePL5hA5i5aO/8T0KPny3Zvu7C
         3DbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wVCVDWqocKGppF+Fpoz1fhnzSpt25qSkQ0ztIc8eqY=;
        b=g+NmimfvYu1qIjuDvZoJHxH24deH2zpTs5q8qUdtkBHhzo7rhKS3TGcXwlPvHQndWj
         YLxTQDvs7LsjM0d8KUXdrvYRCj+M7GFxfYKRw6Wfa4VSrFdBV/ZoKLbJrksZ6pzgP1dQ
         qFTDaDbNyaAF2Nr2YKZMfXZptC6TIF5hO269R6wDvCEFFi0Me6B2IkBfRGEgJGPd5oLd
         NQSTeB4HyAjeksWYu98eC5P4KW1cSW0436Gp1ut3HzNETXz6YycRsZuo+XrbeRqNkIGc
         iEgafmwSg5ebE0Kefi69sfOo5I/ueVaLMpaWuraCLP4m/gUeOhPQCUKVQf3WWjxrQpI3
         JN0w==
X-Gm-Message-State: AO0yUKWjm8NMPAUwd0MgYvpjXQ/S+jW+UD1UyncepDdMJ0uguPKPF32u
        ubk3KjIW6QY5LgDFjtuV1j1yM164tuA87A==
X-Google-Smtp-Source: AK7set955QGyyiJswyK+H+0qL5XScGA+BWwumtIKVZQ7Vvs3VMQWxLHQCzNTBoNbvLD60WaO3m9Idw==
X-Received: by 2002:adf:e984:0:b0:2c5:5455:96a1 with SMTP id h4-20020adfe984000000b002c5545596a1mr4538020wrm.29.1676412114606;
        Tue, 14 Feb 2023 14:01:54 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20f2:3300:c2d2:a008:b022:b1e0])
        by smtp.gmail.com with ESMTPSA id u14-20020adff88e000000b002c56046a3b5sm4033704wrp.53.2023.02.14.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:01:54 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH v2 5/6] hwmon: (aquacomputer_d5next) Add temperature offset control for Aquaero
Date:   Tue, 14 Feb 2023 23:02:20 +0100
Message-Id: <20230214220221.15003-6-leonard.anderweit@gmail.com>
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

Adds control over the Aquacomputer Aquaero temperature offset for all eight
temperature sensors.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 Documentation/hwmon/aquacomputer_d5next.rst |  4 ++--
 drivers/hwmon/aquacomputer_d5next.c         | 12 ++++++++----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
index 7d0d015b1a52..618c826093a2 100644
--- a/Documentation/hwmon/aquacomputer_d5next.rst
+++ b/Documentation/hwmon/aquacomputer_d5next.rst
@@ -25,7 +25,7 @@ communicate through proprietary USB HID protocols.
 
 The Aquaero devices expose eight physical, eight virtual and four calculated
 virtual temperature sensors, as well as two flow sensors. The fans expose their
-speed (in RPM), power, voltage and current.
+speed (in RPM), power, voltage and current. Temperature offsets can be controlled.
 
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
index eb185318098a..61c1ffcd8f3b 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -116,6 +116,9 @@ static u8 aquaero_secondary_ctrl_report[] = {
 #define AQUAERO_FAN_SPEED_OFFSET		0x00
 static u16 aquaero_sensor_fan_offsets[] = { 0x167, 0x173, 0x17f, 0x18B };
 
+/* Control report offsets for the Aquaero fan controllers */
+#define AQUAERO_TEMP_CTRL_OFFSET	0xdb
+
 /* Specs of the D5 Next pump */
 #define D5NEXT_NUM_FANS			2
 #define D5NEXT_NUM_SENSORS		1
@@ -988,10 +991,10 @@ static const struct hwmon_channel_info *aqc_info[] = {
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
@@ -1295,6 +1298,7 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		priv->flow_sensors_start_offset = AQUAERO_FLOW_SENSORS_START;
 
 		priv->buffer_size = AQUAERO_CTRL_REPORT_SIZE;
+		priv->temp_ctrl_offset = AQUAERO_TEMP_CTRL_OFFSET;
 
 		priv->temp_label = label_temp_sensors;
 		priv->virtual_temp_label = label_virtual_temp_sensors;
-- 
2.39.1

