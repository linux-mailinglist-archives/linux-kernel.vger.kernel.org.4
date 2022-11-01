Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492A615299
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiKATyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKATyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:54:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F32918E27;
        Tue,  1 Nov 2022 12:54:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so4342512wmg.2;
        Tue, 01 Nov 2022 12:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DqgDcLSZNA5Saaon/Fmk29zadvFURd3kHj533JQMAZI=;
        b=L3wtkvYXHlDG15kqSgQX9OEeEdTYNSkh7poQs18k8dBe/Uz6uEfZIzt16BhbzPKd2p
         RTz32NgKZY16G9g2S8SMpAqi8L/9Lp+yyq1nNeIKhwP1seuGjpowo1Tz7RDQnZY2ssA6
         haFJkb603fzoXpaGGzFWPtaTvQ0rP8lG2xyFUZHYjSgIGg9LRom+F51XEcU1cq4/Nbhu
         ATrgsKgpyZp2vhT/MARL3WVLhEsrHbWfUoIPb3cjfHwCrOyU+080G75vMs2UCmyV6tpM
         5o6TwpDMjQK8zWChJxJaWF1lf3GPBdtQPcPUeht+lmwvI2DJd6hOuLhbpNhnpwdnCMw9
         2Fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqgDcLSZNA5Saaon/Fmk29zadvFURd3kHj533JQMAZI=;
        b=acStzKqrC6EQnA0j6Kvhg6NJQNAWQ4WdIFMVrxsN+H1fRemJRr2j16qqSOGLlxE22o
         DEbU4X+TI19tGDbVDYRIHdZBn4KI9ZI3L328n/eeExQZ4lPL5iUnxDC2dZ8DkjyR9bK0
         5PxgZil9gFB3S/aUHkNEl3g08yUuffyBn6R5t4Y94HFCcAASd4Wlq0sghxYgpd6Fq5BQ
         ExgvhxhSx1U75m4n1aEV80nThQnZNCbHNV2xyBV7tRWSU0hDrOpaTI5TJsj0Rct1NOXL
         ssvcF77jeBAkonElSkMkBn9KI5ymHXK8feCbSSOpQ7dqlPY76lnFwJen1bOlkb6E7UDM
         9KoA==
X-Gm-Message-State: ACrzQf1r5qOgmkC0ULZalFXwMUh/cKhtQNR/Uv05BohfdSG9JURSnsiI
        tB49viW9AByOstsWDT+Wkiw=
X-Google-Smtp-Source: AMsMyM4scvnGtmJEI6L/0Q7Wcs3P0BW9nd6Ahkk/Xzw4ydDyis0Wsxx+GDBffAi2z+KCbeDkRKseLQ==
X-Received: by 2002:a05:600c:3147:b0:3c6:f860:9610 with SMTP id h7-20020a05600c314700b003c6f8609610mr23655070wmo.170.1667332448210;
        Tue, 01 Nov 2022 12:54:08 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003cf75213bb9sm6092617wmo.8.2022.11.01.12.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2022 12:54:07 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/3] power: supply: cpcap_battery: Read battery parameters from nvram
Date:   Tue,  1 Nov 2022 21:53:45 +0200
Message-Id: <1667332425-12536-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667332425-12536-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formulas were taken from android blob

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/power/supply/cpcap-battery.c | 88 ++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 4cfc325..5c51685 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -74,9 +74,6 @@
 
 #define CPCAP_BATTERY_CC_SAMPLE_PERIOD_MS	250
 
-#define CPCAP_BATTERY_EB41_HW4X_ID 0x9E
-#define CPCAP_BATTERY_BW8X_ID 0x98
-
 enum {
 	CPCAP_BATTERY_IIO_BATTDET,
 	CPCAP_BATTERY_IIO_VOLTAGE,
@@ -388,22 +385,9 @@ static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
  * kernel on droid 4, full is 4351000 and software initiates shutdown
  * at 3078000. The device will die around 2743000.
  */
-static const struct cpcap_battery_config cpcap_battery_eb41_data = {
-	.cd_factor = 0x3cc,
-	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
-	.info.voltage_max_design = 4351000,
-	.info.voltage_min_design = 3100000,
-	.info.charge_full_design = 1740000,
-	.bat.constant_charge_voltage_max_uv = 4200000,
-};
-
-/* Values for the extended Droid Bionic battery bw8x. */
-static const struct cpcap_battery_config cpcap_battery_bw8x_data = {
+static struct cpcap_battery_config cpcap_battery_mot_data = {
 	.cd_factor = 0x3cc,
 	.info.technology = POWER_SUPPLY_TECHNOLOGY_LION,
-	.info.voltage_max_design = 4200000,
-	.info.voltage_min_design = 3200000,
-	.info.charge_full_design = 2760000,
 	.bat.constant_charge_voltage_max_uv = 4200000,
 };
 
@@ -431,39 +415,63 @@ static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
 static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 {
 	struct nvmem_device *nvmem;
-	u8 battery_id = 0;
+	char buf[24];
+	u8 capacity;
+	u8 mul_idx;
+	u8 charge_voltage;
+	u32 v;
+	static const u32 multipliers[] = {20, 10, 10, 10, 10, 40, 10, 20, 40};
 
 	ddata->check_nvmem = false;
 
 	nvmem = nvmem_device_find(NULL, &cpcap_battery_match_nvmem);
 	if (IS_ERR_OR_NULL(nvmem)) {
-		ddata->check_nvmem = true;
 		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming generic lipo battery\n");
-	} else {
-		char buf[24];
-
-		if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
-		    strncmp(buf, "COPR", 4) != 0 ||
-		    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
-		    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0 ||
-		    nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
-			battery_id = 0;
-			ddata->check_nvmem = true;
-			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
-		}
+		goto unknown;
+	}
 
+	if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
+	    strncmp(buf, "COPR", 4) != 0 ||
+	    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
+	    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0) {
+		dev_warn(ddata->dev, "Unknown battery nvmem device. Assuming generic lipo battery\n");
+		goto unknown;
 	}
 
-	switch (battery_id) {
-	case CPCAP_BATTERY_EB41_HW4X_ID:
-		ddata->config = cpcap_battery_eb41_data;
-		break;
-	case CPCAP_BATTERY_BW8X_ID:
-		ddata->config = cpcap_battery_bw8x_data;
-		break;
-	default:
-		ddata->config = cpcap_battery_unkown_data;
+	if (nvmem_device_read(nvmem, 49, 1, &mul_idx) < 0 ||
+	    nvmem_device_read(nvmem, 34, 1, &capacity) < 0 ||
+	    nvmem_device_read(nvmem, 65, 1, &charge_voltage) < 0) {
+		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
+		goto unknown;
 	}
+
+	/* design capacity */
+	mul_idx -= 2;
+
+	if (mul_idx < ARRAY_SIZE(multipliers))
+		v = multipliers[mul_idx];
+	else
+		v = 10;
+
+	cpcap_battery_mot_data.info.charge_full_design = 1000 * v * capacity;
+
+	/* design max voltage */
+	v = 1000 * ((16702 * charge_voltage) / 1000 + 1260);
+	cpcap_battery_mot_data.info.voltage_max_design = v;
+
+	/* design min voltage */
+	if (v > 4200000)
+		cpcap_battery_mot_data.info.voltage_min_design = 3100000;
+	else
+		cpcap_battery_mot_data.info.voltage_min_design = 3200000;
+
+	ddata->config = cpcap_battery_mot_data;
+
+	return;
+
+unknown:
+	ddata->check_nvmem = true;
+	ddata->config = cpcap_battery_unkown_data;
 }
 
 /**
-- 
1.9.1

