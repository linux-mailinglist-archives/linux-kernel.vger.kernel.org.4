Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8545BE993
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiITPES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiITPD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:03:56 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC1136DD5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z6so4822711wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=lgeGpTBAYoR2IF4IQP47VjInSDUdDHryBKm4+oxNgzo=;
        b=AwC13zQZ7kpIyEMDTyYtYKqbjeLAubqIrtdYOPfa/uOpnkkYa76Y6RtVfeAAlN/RBH
         sCyaomhU6F9DV37buweMO6Aw2qK5fsGJDwFR13qkaxxCdC5xqPG94t1lQmuPqI8lnmQn
         hlYTi7j9LyTiBwjbJ/k07izpQ+PI6w2oGpoKBa9JMt//Mc2dowHh98L5JiQkqjd0OnrG
         za3xPPPbS+j7n8SobpIdcq6H0m5LBKre9FPpie4aiUbaTOate1rtgKGBSmza5QIdAQ4s
         m0I3Er5LJgfj3TxKApCDk1qREv6rQZ/rrOZ4V1cNuGA4U3UifcyIkJvKWengp0cHlWzq
         tghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lgeGpTBAYoR2IF4IQP47VjInSDUdDHryBKm4+oxNgzo=;
        b=e23hF6fCuHZPve5Lo3JrM7+f2U+s5V5LbIGQB7APwquXc+3nbLqw/+bVbLC8Fc4uSN
         hpuVm4f6mcgVnSUCEftmyT1jNK1FRP/JUB8vKn1PSttdEkNPgaKEL3cUuSK3gyPI6rED
         WRE0pB0Uiq3qLj9K0hBX5lFCe9JSqCfQwU1ttovGyoQrkeFhPTyAzbDoeUZyuAZy7kD6
         iYI5tS8t5lFIEEmv+8MoV1x8iPIqsImNLIz+/yO8LDaLzPinS6KzLqlwpXEOGUizii7n
         DLOmJn7kUI+cN7peNJ0HSLrHliuLAAPaFUXqmbYRDWpTRLEFx0cErHDPoBu0BwEm3/y3
         Z7Xw==
X-Gm-Message-State: ACrzQf20QntgmmL1YK5UVppV9qZMrbQxMVVeIRPM4pTWgb0Mc/MVjymS
        ZO3hJUcim5/W0+r0/jvomWo8Cg==
X-Google-Smtp-Source: AMsMyM7Se7NW9TRk/0csWrLvSYf0SPYJQHiZVddFEksgD1KIkNLhxiJM/2UQYS3BzgORDTemXsFUaw==
X-Received: by 2002:a05:6000:69d:b0:22a:fa56:86b9 with SMTP id bo29-20020a056000069d00b0022afa5686b9mr7899787wrb.193.1663686234509;
        Tue, 20 Sep 2022 08:03:54 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id u3-20020a5d4683000000b00225239d9265sm242056wrq.74.2022.09.20.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 08:03:53 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 20 Sep 2022 17:03:51 +0200
Subject: [PATCH v5 4/4] thermal: mediatek: add another get_temp ops for thermal
 sensors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-i350-thermal-up-v5-4-123bc852d199@baylibre.com>
References: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
In-Reply-To: <20220920-i350-thermal-up-v5-0-123bc852d199@baylibre.com>
To:     Amit Kucheria <amitk@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Kao <michael.kao@mediatek.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1663686228; l=5826;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=fxjNU673oWyI9k55hJ8TJXejNRUhPRMZg1dfJg2fwYI=;
 b=/WAqzQvGkGzuEAKGTCj1zS0PVtjbWepDWLrysKd1rXCGSExs2zPyqTrv5WTmGzILLsZ2JwGXYouB
 tcIfHt4sBfp0clrszepUhqZ6eMsfkxVgJ6IL1P+CP3BMOzDaiRXx
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide thermal zone to read thermal sensor in the SoC. We can read all the
thermal sensors value in the SoC by the node /sys/class/thermal/

In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
on the first read of sensor that often are bogus values.
This can avoid following warning on boot:

  thermal thermal_zone6: failed to read out thermal zone (-13)

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3a5df1440822..311ad611fdab 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -259,6 +259,11 @@ enum mtk_thermal_version {
 
 struct mtk_thermal;
 
+struct mtk_thermal_zone {
+	struct mtk_thermal *mt;
+	int id;
+};
+
 struct thermal_bank_cfg {
 	unsigned int num_sensors;
 	const int *sensors;
@@ -307,6 +312,8 @@ struct mtk_thermal {
 
 	const struct mtk_thermal_data *conf;
 	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
+
+	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
 };
 
 /* MT8183 thermal sensor data */
@@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 		mutex_unlock(&mt->lock);
 }
 
+static int _get_sensor_temp(struct mtk_thermal *mt, int id)
+{
+	u32 raw;
+	int temp;
+
+	const struct mtk_thermal_data *conf = mt->conf;
+
+	raw = readl(mt->thermal_base + conf->msr[id]);
+
+	temp = mt->raw_to_mcelsius(mt, id, raw);
+
+	/*
+	 * The first read of a sensor often contains very high bogus
+	 * temperature value. Filter these out so that the system does
+	 * not immediately shut down.
+	 */
+
+	if (temp > 200000)
+		return -EAGAIN;
+	else
+		return temp;
+}
+
 /**
  * mtk_thermal_bank_temperature - get the temperature of a bank
  * @bank:	The bank
@@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	struct mtk_thermal *mt = bank->mt;
 	const struct mtk_thermal_data *conf = mt->conf;
 	int i, temp = INT_MIN, max = INT_MIN;
-	u32 raw;
 
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
-
-		if (mt->conf->version == MTK_THERMAL_V1) {
-			temp = raw_to_mcelsius_v1(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		} else {
-			temp = raw_to_mcelsius_v2(
-				mt, conf->bank_data[bank->id].sensors[i], raw);
-		}
-
-		/*
-		 * The first read of a sensor often contains very high bogus
-		 * temperature value. Filter these out so that the system does
-		 * not immediately shut down.
-		 */
-		if (temp > 200000)
-			temp = 0;
+		temp = _get_sensor_temp(mt, i);
 
 		if (temp > max)
 			max = temp;
@@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	return max;
 }
 
-static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
+static int mtk_read_temp(struct thermal_zone_device *tzdev, int *temperature)
 {
-	struct mtk_thermal *mt = tz->devdata;
+	struct mtk_thermal_zone *tz = tzdev->devdata;
+	struct mtk_thermal *mt = tz->mt;
 	int i;
 	int tempmax = INT_MIN;
 
@@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_device *tz, int *temperature)
 	return 0;
 }
 
+static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int *temperature)
+{
+	struct mtk_thermal_zone *tz = tzdev->devdata;
+	struct mtk_thermal *mt = tz->mt;
+	int id = tz->id - 1;
+
+	if (id < 0)
+		return -EACCES;
+
+	*temperature = _get_sensor_temp(mt, id);
+
+	return 0;
+}
+
 static const struct thermal_zone_device_ops mtk_thermal_ops = {
 	.get_temp = mtk_read_temp,
 };
 
+static const struct thermal_zone_device_ops mtk_thermal_sensor_ops = {
+	.get_temp = mtk_read_sensor_temp,
+};
+
 static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 				  u32 apmixed_phys_base, u32 auxadc_phys_base,
 				  int ctrl_id)
@@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 	u64 auxadc_phys_base, apmixed_phys_base;
 	struct thermal_zone_device *tzdev;
 	void __iomem *apmixed_base, *auxadc_base;
+	struct mtk_thermal_zone *tz;
 
 	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
 	if (!mt)
@@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	mtk_thermal_turn_on_buffer(mt, apmixed_base);
 
+	mt->raw_to_mcelsius = (mt->conf->version == MTK_THERMAL_V1) ?
+				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
+
 	if (mt->conf->version == MTK_THERMAL_V2) {
 		mtk_thermal_release_periodic_ts(mt, auxadc_base);
 	}
@@ -1161,11 +1197,29 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	tzdev = devm_thermal_of_zone_register(&pdev->dev, 0, mt,
-					      &mtk_thermal_ops);
-	if (IS_ERR(tzdev)) {
-		ret = PTR_ERR(tzdev);
-		goto err_disable_clk_peri_therm;
+	for (i = 0; i < mt->conf->num_sensors + 1; i++) {
+		tz = devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
+		if (!tz)
+			return -ENOMEM;
+
+		tz->mt = mt;
+		tz->id = i;
+
+		tzdev = devm_thermal_of_zone_register(&pdev->dev, i, tz, (i == 0) ?
+							     &mtk_thermal_ops :
+							     &mtk_thermal_sensor_ops);
+
+		if (IS_ERR(tzdev)) {
+			if (PTR_ERR(tzdev) == -ENODEV) {
+				dev_warn(&pdev->dev,
+					 "sensor %d not registered in thermal zone in dt\n", i);
+				continue;
+			}
+			if (PTR_ERR(tzdev) == -EACCES) {
+				ret = PTR_ERR(tzdev);
+				goto err_disable_clk_peri_therm;
+			}
+		}
 	}
 
 	ret = devm_thermal_add_hwmon_sysfs(tzdev);

-- 
b4 0.10.0
