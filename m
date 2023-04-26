Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE96EFB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 22:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbjDZUEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 16:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbjDZUEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 16:04:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E249196;
        Wed, 26 Apr 2023 13:04:19 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-959a3e2dc72so818305766b.2;
        Wed, 26 Apr 2023 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682539457; x=1685131457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nVVzdfDeFtpeDI1B5wTHnT9bN6QBqirmvI6/E1JB1OM=;
        b=bAFBRFC5fmhcz7uBAM3rucCPE8wYoRSAURnMifNLN8rCToLhJaTsS5bMoPDtigyV6Z
         P9sIn4oabLDJqrMf8FEq3ZGl8NltwKFGuEdWa9vLVPwXAjIkT9P+P9rmXQuOCUjJq5dM
         dseMWhFk5c9DVR4Z+RxSl6BpSEMQzhlM1Dr34DiMv//Nv5NhN2YfSaF+RZVsscbGPoOe
         N0BNTYLlDyFeegRAa9jmnnqkmjyGZ5OWuLhQaihfE8GChxXfodU+l4UecZexqSG+R3RU
         IMlQTMlLBI4QEvEu8LkwtJD7C9mP9qG8FtOLBxNafxoA1vuzBLyftaMfMDtuKwPKKFE0
         cXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682539457; x=1685131457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVVzdfDeFtpeDI1B5wTHnT9bN6QBqirmvI6/E1JB1OM=;
        b=h67YO9VC5FNKLeBqXIUm3fCTlVr4aP/gidhmuvAdbT6SLomXs3iYecTmCKB/x81SaM
         dMmgUJ2UZ0R9zMrVzA36AMNLVjTk+NcDLZ6aUxy0hwia8/pklc6cGOkp9JtcGWQ3c85C
         U14jqLhVWdt9KzsAy0PFglQ3icuHr7ov8Er2WmzNzo8nZ6vFgokQ7JlukgFldOFwzGaB
         A8Eo+dfChYxBuTmoJmxM3nTmuwnAy36DcUs97x1B4tak4oULu3RMP2GMrvj4wm83IhUI
         bC4C/omU1ZGE+0xjatgDdRBdNmP3JD+ZV2pScT/AhhmIiWbb6ksNebZ5onYbFtpJ017k
         gRwQ==
X-Gm-Message-State: AAQBX9f09OB1eekuQ5ZqIfo7WFEwWMsb6EPPWhNjhHgfTospPJWV/aX1
        b3AySKcBiII/8z3XHJ2UpqA=
X-Google-Smtp-Source: AKy350bG73dnu+Fh5OoG8SMPYaI+9lonhLBnm8bGYY2yIqxjvB4fZdBGzi3XAg/0dXwIHAr4j24VeQ==
X-Received: by 2002:a17:906:fa14:b0:94e:ffab:296a with SMTP id lo20-20020a170906fa1400b0094effab296amr17132364ejb.73.1682539457181;
        Wed, 26 Apr 2023 13:04:17 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f34d700b52838dc6de8d706.dip0.t-ipconnect.de. [2003:cf:9f34:d700:b528:38dc:6de8:d706])
        by smtp.googlemail.com with ESMTPSA id d9-20020a17090694c900b0095354acf666sm8705943ejy.92.2023.04.26.13.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 13:04:16 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.
Date:   Wed, 26 Apr 2023 22:03:44 +0200
Message-Id: <20230426200345.65765-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Carns <mike@carns.com>

Only the temp sensors that I can verify are present.  HWINFO in
Windows shows other accumulated data and statistics (time since
installed, total power used, etc) that I have not attempted to find.

Signed-off-by: Michael Carns <mike@carns.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 30 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index c92c1d3839e4..7e3cd5b6686f 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -14,6 +14,7 @@ Supported boards:
  * ROG CROSSHAIR VIII FORMULA
  * ROG CROSSHAIR VIII HERO
  * ROG CROSSHAIR VIII IMPACT
+ * ROG CROSSHAIR X670E HERO
  * ROG MAXIMUS XI HERO
  * ROG MAXIMUS XI HERO (WI-FI)
  * ROG STRIX B550-E GAMING
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index e5be0cf472fc..f52a539eb33e 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -101,6 +101,8 @@ enum ec_sensors {
 	ec_sensor_temp_chipset,
 	/* CPU temperature [℃] */
 	ec_sensor_temp_cpu,
+	/* CPU package temperature [℃] */
+	ec_sensor_temp_cpu_package,
 	/* motherboard temperature [℃] */
 	ec_sensor_temp_mb,
 	/* "T_Sensor" temperature sensor reading [℃] */
@@ -139,6 +141,7 @@ enum ec_sensors {
 
 #define SENSOR_TEMP_CHIPSET BIT(ec_sensor_temp_chipset)
 #define SENSOR_TEMP_CPU BIT(ec_sensor_temp_cpu)
+#define SENSOR_TEMP_CPU_PACKAGE BIT(ec_sensor_temp_cpu_package)
 #define SENSOR_TEMP_MB BIT(ec_sensor_temp_mb)
 #define SENSOR_TEMP_T_SENSOR BIT(ec_sensor_temp_t_sensor)
 #define SENSOR_TEMP_VRM BIT(ec_sensor_temp_vrm)
@@ -161,6 +164,7 @@ enum board_family {
 	family_unknown,
 	family_amd_400_series,
 	family_amd_500_series,
+	family_amd_600_series,
 	family_intel_300_series,
 	family_intel_600_series
 };
@@ -233,6 +237,19 @@ static const struct ec_sensor_info sensors_family_amd_500[] = {
 		EC_SENSOR("Extra_3", hwmon_temp, 1, 0x01, 0x0c),
 };
 
+static const struct ec_sensor_info sensors_family_amd_600[] = {
+	[ec_sensor_temp_cpu] = EC_SENSOR("CPU", hwmon_temp, 1, 0x00, 0x30),
+	[ec_sensor_temp_cpu_package] = EC_SENSOR("CPU Package", hwmon_temp, 1, 0x00, 0x31),
+	[ec_sensor_temp_mb] =
+	EC_SENSOR("Motherboard", hwmon_temp, 1, 0x00, 0x32),
+	[ec_sensor_temp_vrm] =
+		EC_SENSOR("VRM", hwmon_temp, 1, 0x00, 0x33),
+	[ec_sensor_temp_water_in] =
+		EC_SENSOR("Water_In", hwmon_temp, 1, 0x01, 0x00),
+	[ec_sensor_temp_water_out] =
+		EC_SENSOR("Water_Out", hwmon_temp, 1, 0x01, 0x01),
+};
+
 static const struct ec_sensor_info sensors_family_intel_300[] = {
 	[ec_sensor_temp_chipset] =
 		EC_SENSOR("Chipset", hwmon_temp, 1, 0x00, 0x3a),
@@ -319,6 +336,14 @@ static const struct ec_board_info board_info_pro_ws_x570_ace = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_crosshair_x670e_hero = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_SET_TEMP_WATER,
+	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_crosshair_viii_dark_hero = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB |
 		SENSOR_TEMP_T_SENSOR |
@@ -463,6 +488,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_crosshair_viii_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR VIII HERO (WI-FI)",
 					&board_info_crosshair_viii_hero),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG CROSSHAIR X670E HERO",
+					&board_info_crosshair_x670e_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO",
 					&board_info_maximus_xi_hero),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG MAXIMUS XI HERO (WI-FI)",
@@ -946,6 +973,9 @@ static int asus_ec_probe(struct platform_device *pdev)
 	case family_amd_500_series:
 		ec_data->sensors_info = sensors_family_amd_500;
 		break;
+	case family_amd_600_series:
+		ec_data->sensors_info = sensors_family_amd_600;
+		break;
 	case family_intel_300_series:
 		ec_data->sensors_info = sensors_family_intel_300;
 		break;
-- 
2.40.0

