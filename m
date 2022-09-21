Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2935BFB81
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiIUJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiIUJnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:42 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B6993200
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso8140472wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aNmMz3cRMj5kxPfKCvTpL8Ywx++ZqyPMyM5lgZsCem0=;
        b=opBVigkRy1OeHJrzgVEv50Om8MwOvmKtdXtGwDmTqDiVeKIVBTX9lyRdNNyru+jQpf
         pvHxkjNQDbdCSku4L0BzhyYs8MC3x533ztjIKkKKHK9xqBnfIAroNYuUGZHcPR4SKq7B
         FLgZnDwCHlwDxSirS6wY+jzARCYEFuYEnEUOcO1Qw1mr6riViPYm6NRi2t+rqGo3RZhg
         LxF87n6cjFqA4Q7MJdW8b+Boouz8tDTWD6P1Eg+IRMHihWo6wX2Dd+Re1QwFQZ/KDEXU
         +6GCsa7FaQ3YqbYcke8pcLCZ7Pz9y2kwrLYW62BRHvz5VG6q1gZO8ovwfSzTWKvxTQOs
         kKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aNmMz3cRMj5kxPfKCvTpL8Ywx++ZqyPMyM5lgZsCem0=;
        b=3+T3emqNHzKlMZSdE+jf1SSf7Tt4j28CykKZwi70CDR7Q22MH2gNKTe2mSfkXqpW7p
         FGddt+MdrTJqz+0fU59fCMew7TG8Un+wGa+6w20nha/vjHASoW20atulh640hv+0IRih
         6PRUiXsg8riqxVhkYXzZCSiBDEHwzR2PX9FFW+PTEulURZFVJ2JOmE0jELtKhyGbxbde
         9/GWGdgPJ+qUUAvIWHA7Xmz6jEfg0h4LxNHdvaqW3zkuOk5RW138RzT6GLe9cKxe0iyo
         Wpg6vZIjpB3WO8g0yRg7P9gdyYnjqxUbK2j+2mtnycTzNtqiT4q1NUzZNvvubJ7q8nIh
         Ah3g==
X-Gm-Message-State: ACrzQf24wXiViufaXOkNDEgTsIJuPa7c4pCT2Itftg+tLd2QlGsJCyOD
        w8mVZahNgGxtOSM0UzCXJZ36Gw==
X-Google-Smtp-Source: AMsMyM591OTlLMxQsmmUWR66w2WKMc3P6675xLoxproqZsL80SdIV9dgnd2ab52ATVMOcbZgomjCmA==
X-Received: by 2002:a05:600c:4c22:b0:3b4:766a:4f76 with SMTP id d34-20020a05600c4c2200b003b4766a4f76mr4978885wmp.101.1663753411232;
        Wed, 21 Sep 2022 02:43:31 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:30 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org (open list:SAMSUNG THERMAL DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES)
Subject: [PATCH v4 08/30] thermal/drivers/exynos: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:21 +0200
Message-Id: <20220921094244.606948-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework gives the possibility to register the trip
points with the thermal zone. When that is done, no get_trip_* ops are
needed and they can be removed.

Convert ops content logic into generic trip points and register them with the
thermal zone.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/samsung/exynos_tmu.c | 41 +++++++++++-----------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 51874d0a284c..0e33d32a9d2e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -260,16 +260,8 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
 	struct thermal_zone_device *tzd = data->tzd;
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(tzd);
 	unsigned int status;
-	int ret = 0, temp, hyst;
-
-	if (!trips) {
-		dev_err(&pdev->dev,
-			"Cannot get trip points from device tree!\n");
-		return -ENODEV;
-	}
+	int ret = 0, temp;
 
 	if (data->soc != SOC_ARCH_EXYNOS5433) /* FIXME */
 		ret = tzd->ops->get_crit_temp(tzd, &temp);
@@ -303,19 +295,16 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 		/* Write temperature code for rising and falling threshold */
 		for (i = 0; i < ntrips; i++) {
-			/* Write temperature code for rising threshold */
-			ret = tzd->ops->get_trip_temp(tzd, i, &temp);
-			if (ret)
-				goto err;
-			temp /= MCELSIUS;
-			data->tmu_set_trip_temp(data, i, temp);
 
-			/* Write temperature code for falling threshold */
-			ret = tzd->ops->get_trip_hyst(tzd, i, &hyst);
+			struct thermal_trip trip;
+			
+			ret = thermal_zone_get_trip(tzd, i, &trip);
 			if (ret)
 				goto err;
-			hyst /= MCELSIUS;
-			data->tmu_set_trip_hyst(data, i, temp, hyst);
+
+			data->tmu_set_trip_temp(data, i, trip.temperature / MCELSIUS);
+			data->tmu_set_trip_hyst(data, i, trip.temperature / MCELSIUS,
+						trip.hysteresis / MCELSIUS);
 		}
 
 		data->tmu_clear_irqs(data);
@@ -360,21 +349,23 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
 }
 
 static void exynos4210_tmu_set_trip_temp(struct exynos_tmu_data *data,
-					 int trip, u8 temp)
+					 int trip_id, u8 temp)
 {
-	const struct thermal_trip * const trips =
-		of_thermal_get_trip_points(data->tzd);
+	struct thermal_trip trip;
 	u8 ref, th_code;
 
-	ref = trips[0].temperature / MCELSIUS;
+	if (thermal_zone_get_trip(data->tzd, 0, &trip))
+		return;
 
-	if (trip == 0) {
+	ref = trip.temperature / MCELSIUS;
+	
+	if (trip_id == 0) {
 		th_code = temp_to_code(data, ref);
 		writeb(th_code, data->base + EXYNOS4210_TMU_REG_THRESHOLD_TEMP);
 	}
 
 	temp -= ref;
-	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip * 4);
+	writeb(temp, data->base + EXYNOS4210_TMU_REG_TRIG_LEVEL0 + trip_id * 4);
 }
 
 /* failing thresholds are not supported on Exynos4210 */
-- 
2.34.1

