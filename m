Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85E464FEBC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 12:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiLRLcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 06:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiLRLcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 06:32:05 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE463CA;
        Sun, 18 Dec 2022 03:32:03 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so4619079wml.4;
        Sun, 18 Dec 2022 03:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0WKs2spplBX1OT7AnO6JAVTucdqtfLOI5UI2kX7UwE=;
        b=n+10qFGybORa4kQxYKG4STcwIMzcgSNUs6KbrEw/l3CHAKIVdqSflULT5InhFIenJe
         5JDN0aTef3TmUYokjEadD4fmMjz0XvfdKzaUQg2RTkfnh/kxGB+rieHAQATi7yt3GwbC
         2WlNb6O9zTmyH1B5pOZ/YjhR+GNcXQYkTpwQj5nMSuOsj2XAVV63e5YFJH8McBK0GLvR
         IJCdkB1ufAegaEhk81HCgfVpNGs0hyGBFzERaBx/OvkT0fPOcVh0Nd80rtVNPVyrmZF5
         nmrPHhFdhFq+8GNTDeveIs9mx+yEP/b8cvArmwd40aFhrOf+ZQUg/veR1QJkV7PieUXP
         L5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0WKs2spplBX1OT7AnO6JAVTucdqtfLOI5UI2kX7UwE=;
        b=W+h/4TlsbJfZJdtDbJj+A24Y+C3OGBfvDS0mjvpFYtxXpB/yts8csNFdkAWT6F++8P
         gRsVljt9SMvFSLe1kX91og/Auna5k55Ky9/Eu22FS08p+UqnqrB6JEjMYWO7KvzNBAHG
         MyoBCXZkEx1mfz9StsgvyASkfetipmvt3ILxtAMuBMLLwqMy9f4S34nVMAhIPklORkfn
         17pMmGT8M9PJNrXeakvOk4MGU+b91gnkSoP9GcnlN96ich+wEfidYqfvCfUlBC3GmVyW
         cRIdpuQgaNR1XlqP/PXU239FOkxGosJze4fmcw2Dp99SU/wWYoZX9eL9s9bNPADu3Iqh
         hO7g==
X-Gm-Message-State: ANoB5plEC5aKGclUXMRdAOAv0tqshbPjsa5AN11aidUJ/IszR83ZaU6D
        gANmXTSj3x8r5cJ3/bgJMXZcd0LTkKeZIg==
X-Google-Smtp-Source: AA0mqf4GeZbaUYl8nZJugrKURgZQZlUYLytwz1Xlq+W9MN8fPFHqv0eB6gu3SdFKr4o0EiY5QFpwmA==
X-Received: by 2002:a1c:f20e:0:b0:3cf:b690:6a9d with SMTP id s14-20020a1cf20e000000b003cfb6906a9dmr29690178wmc.30.1671363121554;
        Sun, 18 Dec 2022 03:32:01 -0800 (PST)
Received: from localhost.localdomain ([2001:9e8:20fa:a700:21e9:9128:9ea2:3911])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003d069fc7372sm9440751wms.1.2022.12.18.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 03:32:01 -0800 (PST)
From:   Leonard Anderweit <leonard.anderweit@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leonard Anderweit <leonard.anderweit@gmail.com>
Subject: [PATCH 1/6] hwmon: (aquacomputer_d5next) Rename AQC_TEMP_SENSOR_SIZE to AQC_SENSOR_SIZE
Date:   Sun, 18 Dec 2022 12:31:26 +0100
Message-Id: <20221218113131.3752-2-leonard.anderweit@gmail.com>
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

Rename AQC_TEMP_SENSOR_SIZE to AQC_SENSOR_SIZE to use with other sensor
types.

Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>
---
 drivers/hwmon/aquacomputer_d5next.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
index 9cc10080160b..8fd9f7fd7ec4 100644
--- a/drivers/hwmon/aquacomputer_d5next.c
+++ b/drivers/hwmon/aquacomputer_d5next.c
@@ -60,7 +60,7 @@ static u8 secondary_ctrl_report[] = {
 };
 
 /* Sensor sizes and offsets for all Aquacomputer devices */
-#define AQC_TEMP_SENSOR_SIZE		0x02
+#define AQC_SENSOR_SIZE			0x02
 #define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
 #define AQC_FAN_PERCENT_OFFSET		0x00
 #define AQC_FAN_VOLTAGE_OFFSET		0x02
@@ -557,7 +557,7 @@ static int aqc_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		case hwmon_temp_offset:
 			ret =
 			    aqc_get_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_TEMP_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val);
 			if (ret < 0)
 				return ret;
 
@@ -651,7 +651,7 @@ static int aqc_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 			val = clamp_val(val, -15000, 15000) / 10;
 			ret =
 			    aqc_set_ctrl_val(priv, priv->temp_ctrl_offset +
-					     channel * AQC_TEMP_SENSOR_SIZE, val);
+					     channel * AQC_SENSOR_SIZE, val);
 			if (ret < 0)
 				return ret;
 			break;
@@ -797,7 +797,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	for (i = 0; i < priv->num_temp_sensors; i++) {
 		sensor_value = get_unaligned_be16(data +
 						  priv->temp_sensor_start_offset +
-						  i * AQC_TEMP_SENSOR_SIZE);
+						  i * AQC_SENSOR_SIZE);
 		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
 			priv->temp_input[i] = -ENODATA;
 		else
@@ -808,7 +808,7 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
 	for (j = 0; j < priv->num_virtual_temp_sensors; j++) {
 		sensor_value = get_unaligned_be16(data +
 						  priv->virtual_temp_sensor_start_offset +
-						  j * AQC_TEMP_SENSOR_SIZE);
+						  j * AQC_SENSOR_SIZE);
 		if (sensor_value == AQC_TEMP_SENSOR_DISCONNECTED)
 			priv->temp_input[i] = -ENODATA;
 		else
-- 
2.38.1

