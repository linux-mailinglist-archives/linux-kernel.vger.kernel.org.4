Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5E5EE7D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiI1VIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI1VH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:07:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F0E9985
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:02:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1664504wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8pE/zvW6S2HkLQ2nl2eyAsUouKTzMht2lN2QByjtNa0=;
        b=HXgRA9xl5RtEEpQ5/9Hq1X1TOVu6+5Dvikau2PJ8VMeDHLrc4OSRAgVq//EZ48s8q5
         lDmlvj3F8CY47RTSGFLxjUvZADzBtXslmokGMTKuqFodZJ+Zl1QG9Ub9a/JSC2+JQ2Td
         Y313IR+CtM5NwQ+St6ezsiZXV4Pckcd6eQJMBCT0zVedq+RBNCvCtSB7/OEP4t+v08OB
         HbUUnJsUtuAWBjALk+KkkIY2SwUi9InwQhBx/gK2+pSoH+1jgxRFchL4xAA1pi1L3Mrt
         ur2x0CX+ziGq1Ob5Bu5cR9jloA1h2sodrdmQQAU5+R8fhDeGi0+Bey1/uHrH0yPwzC0G
         fSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8pE/zvW6S2HkLQ2nl2eyAsUouKTzMht2lN2QByjtNa0=;
        b=TBMTAnfY2ISDrsrgGXLIrUXymGRMqz3XTSoKZ7SqxE7DenLZPiNt0vNlxrWw0cbWHK
         /x0AYqyz7JcBJqohfcgg6qfPq77OdiDVz6pE8jFH/uFBoVQ0xshf/joHDV3rEbZlJCRI
         8DWU8ZQSt+Di0yrgJ9+NybSi2fT2VzR83kse1jC1egh6Y5rDEVu/q4HDhTh3rqHaCbXP
         HUR6HV+P88guT+1Oa+etcD9qNJ7lN82O3/RaPS02OlA2jiPlwU7HjlD98PUWEhFLwtTZ
         Hw74AKRjrarVtfvAIqw+mPtJLuNdHFtZBf8+mG0ilmvPCoSM7K+Oh+D44NEdTpnB0LUv
         42CQ==
X-Gm-Message-State: ACrzQf2nblfqVW/r3KfEugUvKqPsgts6PCndlKJKdMpjBi0XMhjNFu8C
        H+4FLGjH2LgXfWqsxh+gn9bP4Q==
X-Google-Smtp-Source: AMsMyM53Cgbe2M2piI5xT5mM6XcJ8yzolBHl+XMtiR3Xq3RzX8Yn8x7ONN7QPSwi29vVBxqLfLohWw==
X-Received: by 2002:a1c:2743:0:b0:3b3:4066:fa61 with SMTP id n64-20020a1c2743000000b003b34066fa61mr8362048wmn.79.1664398968373;
        Wed, 28 Sep 2022 14:02:48 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:48a2:39eb:9d1b:8b8d])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2874300wmq.26.2022.09.28.14.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:02:46 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH v7 29/29] thermal/drivers/intel: Use generic thermal_zone_get_trip() function
Date:   Wed, 28 Sep 2022 23:00:59 +0200
Message-Id: <20220928210059.891387-30-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928210059.891387-1-daniel.lezcano@linaro.org>
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 120 +++++++++++--------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index a0e234fce71a..40a9355207e7 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -53,6 +53,7 @@ struct zone_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
+	struct thermal_trip		*trips;
 	struct cpumask			cpumask;
 };
 
@@ -138,40 +139,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 	return -EINVAL;
 }
 
-static int sys_get_trip_temp(struct thermal_zone_device *tzd,
-			     int trip, int *temp)
-{
-	struct zone_device *zonedev = tzd->devdata;
-	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
-	int ret;
-
-	if (trip >= MAX_NUMBER_OF_TRIPS)
-		return -EINVAL;
-
-	if (trip) {
-		mask = THERM_MASK_THRESHOLD1;
-		shift = THERM_SHIFT_THRESHOLD1;
-	} else {
-		mask = THERM_MASK_THRESHOLD0;
-		shift = THERM_SHIFT_THRESHOLD0;
-	}
-
-	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &eax, &edx);
-	if (ret < 0)
-		return ret;
-
-	thres_reg_value = (eax & mask) >> shift;
-	if (thres_reg_value)
-		*temp = zonedev->tj_max - thres_reg_value * 1000;
-	else
-		*temp = THERMAL_TEMP_INVALID;
-	pr_debug("sys_get_trip_temp %d\n", *temp);
-
-	return 0;
-}
-
 static int
 sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 {
@@ -212,18 +179,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd, int trip, int temp)
 			l, h);
 }
 
-static int sys_get_trip_type(struct thermal_zone_device *thermal, int trip,
-			     enum thermal_trip_type *type)
-{
-	*type = THERMAL_TRIP_PASSIVE;
-	return 0;
-}
-
 /* Thermal zone callback registry */
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
-	.get_trip_temp = sys_get_trip_temp,
-	.get_trip_type = sys_get_trip_type,
 	.set_trip_temp = sys_set_trip_temp,
 };
 
@@ -328,6 +286,48 @@ static int pkg_thermal_notify(u64 msr_val)
 	return 0;
 }
 
+static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
+{
+	struct thermal_trip *trips;
+	unsigned long thres_reg_value;
+	u32 mask, shift, eax, edx;
+	int ret, i;
+
+	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
+	if (!trips)
+		return ERR_PTR(-ENOMEM);
+	
+	for (i = 0; i < num_trips; i++) {
+
+		if (i) {
+			mask = THERM_MASK_THRESHOLD1;
+			shift = THERM_SHIFT_THRESHOLD1;
+		} else {
+			mask = THERM_MASK_THRESHOLD0;
+			shift = THERM_SHIFT_THRESHOLD0;
+		}
+
+		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				   &eax, &edx);
+		if (ret < 0) {
+			kfree(trips);
+			return ERR_PTR(ret);
+		}
+
+		thres_reg_value = (eax & mask) >> shift;
+
+		trips[i].temperature = thres_reg_value ?
+			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
+
+		trips[i].type = THERMAL_TRIP_PASSIVE;
+		
+		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
+			 __func__, cpu, i, trips[i].temperature);
+	}
+
+	return trips;
+}
+
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
 	int id = topology_logical_die_id(cpu);
@@ -353,24 +353,27 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	if (!zonedev)
 		return -ENOMEM;
 
+	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
+	if (IS_ERR(zonedev->trips)) {
+		err = PTR_ERR(zonedev->trips);
+		goto out_kfree_zonedev;
+	}
+	
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tj_max = tj_max;
-	zonedev->tzone = thermal_zone_device_register("x86_pkg_temp",
-			thres_count,
+	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
+			zonedev->trips, thres_count,
 			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
-		kfree(zonedev);
-		return err;
+		goto out_kfree_trips;
 	}
 	err = thermal_zone_device_enable(zonedev->tzone);
-	if (err) {
-		thermal_zone_device_unregister(zonedev->tzone);
-		kfree(zonedev);
-		return err;
-	}
+	if (err)
+		goto out_unregister_tz;
+
 	/* Store MSR value for package thermal interrupt, to restore at exit */
 	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
 	      zonedev->msr_pkg_therm_high);
@@ -379,7 +382,16 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 	raw_spin_lock_irq(&pkg_temp_lock);
 	zones[id] = zonedev;
 	raw_spin_unlock_irq(&pkg_temp_lock);
+
 	return 0;
+
+out_unregister_tz:	
+	thermal_zone_device_unregister(zonedev->tzone);
+out_kfree_trips:
+	kfree(zonedev->trips);
+out_kfree_zonedev:
+	kfree(zonedev);
+	return err;
 }
 
 static int pkg_thermal_cpu_offline(unsigned int cpu)
@@ -463,8 +475,10 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
-	if (lastcpu)
+	if (lastcpu) {
+		kfree(zonedev->trips);
 		kfree(zonedev);
+	}
 	return 0;
 }
 
-- 
2.34.1

