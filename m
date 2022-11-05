Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1661D9B1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKEL0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 07:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiKEL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 07:26:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43291CFC2;
        Sat,  5 Nov 2022 04:26:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id q9so19390224ejd.0;
        Sat, 05 Nov 2022 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rw/rE+YmWmiRZPKzY49HONfLX1Etfc66IXHD8xnQCQI=;
        b=YFPxzIfijNm+mc4mTACato2ckTCyuN6azDv8/8qbxxQKOGw8EVT1VsaDXezrd0CgLJ
         FH70Y4Jto7N04ToxCKcFeUvp81GsQlUdFhoCvlPzYjMeGJg68VjWmNd/o+l1c8b2845C
         AFzht7O3W/0rghV8WqCETpt39bG1KcNHHBFMZZWhYIEkJ6YhMkSXwz+z+pGb+RTcJIqj
         836o8iPgIrV3YzYnxGd6Dmqa8ba8EabAUuDlCXtXj6EGWck3jOXh/YJcICgAu6ngiglD
         0314ChbMzrsnRAYupKQHTAfok6OuRQyyBrjKBcnBwU5hxCUWQbDZkIvtePRxipgTwed2
         RG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw/rE+YmWmiRZPKzY49HONfLX1Etfc66IXHD8xnQCQI=;
        b=ezeASOOCDfi/hMG2P0Sn0knngz60SdbaTrLN7B617d+oDsEHlc5vVw03SCS9MCRJXS
         y67KFV1AywEG3dI+J9kAeuNs5GjhgNbI7q1VjgvHKnAgxLTnMDvDFT9vxzqbaU1kE/vM
         R97S6jI54AHdd+1vp9K9bgA9pziDEBxcXOg1DJQxsJexhOL4OV1qUmGkzK0I2fg6yxZ/
         PKKgej/K9HFh2BHtJ+VCN1L7duE1rkVyCLbL1awHnrjfvRrucgruFWBrd7G3dAR768N4
         X92IUm3/xLSmg8Xom5B26WyBcKm2N76YphtAaOG5UyR6OpJdqoPF6xPhBqbx1q7L0y7/
         vOFw==
X-Gm-Message-State: ACrzQf37Y/Yxn1dUnJJzuwtNoBIC7pE5hLAAs1EuI77MBhwRT680IKkH
        fMpzSItscKG7kiSRkDTixl1x1nCeBokvYg==
X-Google-Smtp-Source: AMsMyM73VezoGUOkFB90+jlgzWTHUI8YILG1J5jgzzZ9RQzVzVSJ2pxkOb2tM3HwW+P2D44CV1lBMg==
X-Received: by 2002:a17:906:285a:b0:7ae:127a:cc2e with SMTP id s26-20020a170906285a00b007ae127acc2emr14117814ejc.229.1667647577357;
        Sat, 05 Nov 2022 04:26:17 -0700 (PDT)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id u18-20020a509512000000b004611c230bd0sm1050069eda.37.2022.11.05.04.26.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Nov 2022 04:26:16 -0700 (PDT)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 3/3] power: supply: cpcap_battery: Read battery parameters from nvram
Date:   Sat,  5 Nov 2022 13:25:44 +0200
Message-Id: <1667647544-12945-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
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
index ca6ee2b..92aa66c 100644
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

