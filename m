Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC311690E69
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBIQgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBIQgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:36:04 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77B15D1D5;
        Thu,  9 Feb 2023 08:36:02 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d40so1348168eda.8;
        Thu, 09 Feb 2023 08:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EOfW6T6B8QOW9L3wKVd9xNkr96frILN3seTzII1LVE=;
        b=ZX+JqMWS64npOfK7R0bse7BLwv4cU1g674tUkbUzAY/HvZUneDmABSMLL90+m2PPoY
         4aBPZzc2ZRRR9+bVz8G3rtWCH41NEEPNdJgeWHE6ZDxPD1ZTraA/ls1GybbIpcnVFB/Q
         +baxlHAXkLGnQ+lXV3em9PbwhVG34doUzTqdtrXW8/eaEKD2qX8AHP7i6Zb/DCouX2fF
         N5IxwZ/zBllT6zeGi/SOd1cXy0GyzodcTsfpiJM2/RRdj5lsvnsudge6r4R9Uv8PMw6T
         dwgUdw5Xl3YqJoXL2yUSTIrCePDfFgtG5su6ABBhiU8a49RO3xeOvhJsyU4lXFQzVvkS
         BoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EOfW6T6B8QOW9L3wKVd9xNkr96frILN3seTzII1LVE=;
        b=psbU04tSMKnr5PbS2BfePKv+THkyhjQ/QXZO3Rm2ey3FyP58HR8aYKO/37NGUSc61l
         7IEcVLxEOWsLUfsOS9gw/cW4NpccBY9pVISJZdRPJi2MrCa4UINr0j/OiZMi4VXX4WCR
         EjjpluCWGwwJ3xQB5Gt6FqOth1cxv5laK1gE6vPxJIhVFcwxzLyComIzKPV3Jlgs5mFP
         1nh9vX4b6mvvOYp9hcbRI1MT2K3D7rRpoA7A4ORLdUmbcdgTyg4Pe4FpHskTmaTtmCoo
         shC2smCtkt/lwFzwbmFR5pRXZ1ztLPuJ8TiU89nzu/dTz4F00+KCt2p2g/CSI0SITqPK
         NNng==
X-Gm-Message-State: AO0yUKWEzKhcfAZQUmt5RVYX5530ps5WBTPHQ49GPEuH4vITARs7NIdJ
        1XQfRCKsOtcTOtJhptxhZMs=
X-Google-Smtp-Source: AK7set88/Eyc2sOI0OXNCjP7sJ6JivBs3kJhEHYp65G7aJvUHGA2D2mY4wMVPRpsUrF0msUNUPOtzA==
X-Received: by 2002:a50:cdc2:0:b0:4ab:1793:1254 with SMTP id h2-20020a50cdc2000000b004ab17931254mr4113459edj.13.1675960561165;
        Thu, 09 Feb 2023 08:36:01 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e12-20020a50ec8c000000b0046b471596e6sm959335edr.57.2023.02.09.08.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:36:00 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal: tegra: Implement bind/unbind for cooling device
Date:   Thu,  9 Feb 2023 17:35:55 +0100
Message-Id: <20230209163555.1993557-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209163555.1993557-1-thierry.reding@gmail.com>
References: <20230209163555.1993557-1-thierry.reding@gmail.com>
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

From: Thierry Reding <treding@nvidia.com>

The SOCTHERM hardware found on Tegra implements a way of throttling the
CPU and GPU when a given temperature threshold is reached. As opposed to
traditional cooling devices, the programming for this happens during the
initialization stage rather than dynamically at runtime when the thermal
framework gets notified of thresholds being crossed.

Use the newly introduced ->bind() and ->unbind() operations to make sure
the SOCTHERM programming happens at the right time. This allows us to
get rid of calls to the get_thermal_instance() helper which is not
supposed to be accessed by drivers.

Reported-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/thermal/tegra/soctherm.c | 146 ++++++++++++++-----------------
 1 file changed, 67 insertions(+), 79 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 220873298d77..cdc8764e88aa 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -303,6 +303,8 @@ struct tegra_thermctl_zone {
 	struct tegra_soctherm *ts;
 	struct thermal_zone_device *tz;
 	const struct tegra_tsensor_group *sg;
+	/* instance of an internal throttle cooling device */
+	struct thermal_cooling_device *cdev;
 };
 
 struct soctherm_oc_cfg {
@@ -315,6 +317,7 @@ struct soctherm_oc_cfg {
 };
 
 struct soctherm_throt_cfg {
+	struct tegra_soctherm *soctherm;
 	const char *name;
 	unsigned int id;
 	u8 priority;
@@ -585,10 +588,10 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct tegra_thermctl_zone *zone = tz->devdata;
-	struct tegra_soctherm *ts = zone->ts;
-	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
+	struct tegra_soctherm *ts = zone->ts;
 	struct device *dev = zone->dev;
+	struct thermal_trip trip;
 	int ret;
 
 	if (!tz)
@@ -610,26 +613,14 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 			return 0;
 
 	} else if (trip.type == THERMAL_TRIP_HOT) {
-		int i;
-
-		for (i = 0; i < THROTTLE_SIZE; i++) {
-			struct thermal_cooling_device *cdev;
-			struct soctherm_throt_cfg *stc;
-
-			if (!ts->throt_cfgs[i].init)
-				continue;
-
-			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip_id))
-				stc = find_throttle_cfg_by_name(ts, cdev->type);
-			else
-				continue;
+		if (zone->cdev) {
+			struct soctherm_throt_cfg *stc = zone->cdev->devdata;
 
 			return throttrip_program(dev, sg, stc, temp);
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static void thermal_irq_enable(struct tegra_thermctl_zone *zn)
@@ -687,26 +678,6 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
-{
-	int i, ret;
-	struct thermal_trip trip;
-
-	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
-
-		ret = thermal_zone_get_trip(tz, i, &trip);
-		if (ret)
-			return -EINVAL;
-
-		if (trip.type == THERMAL_TRIP_HOT) {
-			*trip_id = i;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 /**
  * tegra_soctherm_set_hwtrips() - set HW trip point from DT data
  * @dev: struct device * of the SOC_THERM instance
@@ -736,8 +707,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 				      struct thermal_zone_device *tz)
 {
 	struct tegra_soctherm *ts = dev_get_drvdata(dev);
-	struct soctherm_throt_cfg *stc;
-	int i, trip, temperature, ret;
+	int temperature, ret;
 
 	/* Get thermtrips. If missing, try to get critical trips. */
 	temperature = tsensor_group_thermtrip_get(ts, sg->id);
@@ -754,42 +724,6 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
 	dev_info(dev, "thermtrip: will shut down when %s reaches %d mC\n",
 		 sg->name, temperature);
 
-	ret = get_hot_temp(tz, &trip, &temperature);
-	if (ret) {
-		dev_info(dev, "throttrip: %s: missing hot temperature\n",
-			 sg->name);
-		return 0;
-	}
-
-	for (i = 0; i < THROTTLE_OC1; i++) {
-		struct thermal_cooling_device *cdev;
-
-		if (!ts->throt_cfgs[i].init)
-			continue;
-
-		cdev = ts->throt_cfgs[i].cdev;
-		if (get_thermal_instance(tz, cdev, trip))
-			stc = find_throttle_cfg_by_name(ts, cdev->type);
-		else
-			continue;
-
-		ret = throttrip_program(dev, sg, stc, temperature);
-		if (ret) {
-			dev_err(dev, "throttrip: %s: error during enable\n",
-				sg->name);
-			return ret;
-		}
-
-		dev_info(dev,
-			 "throttrip: will throttle when %s reaches %d mC\n",
-			 sg->name, temperature);
-		break;
-	}
-
-	if (i == THROTTLE_SIZE)
-		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
-			 sg->name);
-
 	return 0;
 }
 
@@ -1497,6 +1431,55 @@ static int soctherm_clk_enable(struct platform_device *pdev, bool enable)
 	return 0;
 }
 
+static int throt_bind(struct thermal_cooling_device *cdev,
+		      struct thermal_zone_device *tz, int trip_id,
+		      unsigned long upper, unsigned long lower,
+		      unsigned int weight)
+{
+	struct tegra_thermctl_zone *zone = tz->devdata;
+	struct device *dev = &cdev->device;
+	struct thermal_trip trip;
+	int err;
+
+	err = thermal_zone_get_trip(tz, trip_id, &trip);
+	if (err < 0)
+		return err;
+
+	if (trip.type == THERMAL_TRIP_HOT) {
+		struct soctherm_throt_cfg *stc = cdev->devdata;
+
+		err = throttrip_program(zone->dev, zone->sg, stc, trip.temperature);
+		if (err < 0) {
+			dev_err(dev, "throttrip: %s: error during enable\n",
+				zone->sg->name);
+			return err;
+		}
+
+		dev_info(dev, "throttrip: will throttle when %s reaches %d mC\n",
+			 zone->sg->name, trip.temperature);
+
+		/* keep a reference to this for ->set_trip_temp() */
+		zone->cdev = cdev;
+	}
+
+	return 0;
+}
+
+static void throt_unbind(struct thermal_cooling_device *cdev,
+			 struct thermal_zone_device *tz, int trip_id)
+{
+	struct tegra_thermctl_zone *zone = tz->devdata;
+	struct thermal_trip trip;
+	int err;
+
+	err = __thermal_zone_get_trip(tz, trip_id, &trip);
+	if (err < 0)
+		return;
+
+	if (trip.type == THERMAL_TRIP_HOT)
+		zone->cdev = NULL;
+}
+
 static int throt_get_cdev_max_state(struct thermal_cooling_device *cdev,
 				    unsigned long *max_state)
 {
@@ -1507,7 +1490,8 @@ static int throt_get_cdev_max_state(struct thermal_cooling_device *cdev,
 static int throt_get_cdev_cur_state(struct thermal_cooling_device *cdev,
 				    unsigned long *cur_state)
 {
-	struct tegra_soctherm *ts = cdev->devdata;
+	struct soctherm_throt_cfg *stc = cdev->devdata;
+	struct tegra_soctherm *ts = stc->soctherm;
 	u32 r;
 
 	r = readl(ts->regs + THROT_STATUS);
@@ -1526,6 +1510,8 @@ static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
 }
 
 static const struct thermal_cooling_device_ops throt_cooling_ops = {
+	.bind = throt_bind,
+	.unbind = throt_unbind,
 	.get_max_state = throt_get_cdev_max_state,
 	.get_cur_state = throt_get_cdev_cur_state,
 	.set_cur_state = throt_set_cdev_state,
@@ -1576,8 +1562,8 @@ static int soctherm_thermtrips_parse(struct platform_device *pdev)
 }
 
 static void soctherm_oc_cfg_parse(struct device *dev,
-				struct device_node *np_oc,
-				struct soctherm_throt_cfg *stc)
+				  struct device_node *np_oc,
+				  struct soctherm_throt_cfg *stc)
 {
 	u32 val;
 
@@ -1694,13 +1680,15 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 		if (err)
 			continue;
 
+		stc->soctherm = ts;
+
 		if (stc->id >= THROTTLE_OC1) {
 			soctherm_oc_cfg_parse(dev, np_stcc, stc);
 			stc->init = true;
 		} else {
 
 			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
+							 (char *)name, stc,
 							 &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
-- 
2.39.1

