Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87F5EC657
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiI0OeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbiI0OdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:33:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A51D12CD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso5548346wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=G0uQrIPEvhe+LHZJTgCfBJsZ8XmcJC+gKJgug/+isHhTyZ7z67OQ9tGXfZsPBR8v/A
         nJSF0KlD1pk5l2mO1dKdDYoULqKqxlC8lPNYJ2gqEzgFU/2SozRC3KlgCIMjCWZBJxyk
         Dyxj+PVdYTv4DiEySoZqSn2kMmE1XdU1jmWffMX0ZZMVMUZpIOkKM0W1/oxlhJRk+e/R
         6+KDMk+cHvc3ZE30FUR0MxLVHvl2FImx5rt7cHo8vJ3xfskqp5gEH3Iuk8M0F3UMVms8
         WUK860XOv1q5yvUBa+6y7fC/O02uAlGKEq054a902DseECXhmjQlg+Hxj8qBOWhKzrMy
         jJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=mnkVpziNp8RggfC6zLAE8DynPsVufs40+pd/TT7tehIpyRr1IR0jVIgFUygWGrFQ5K
         3taS0YWW+LZbwRt4RvtFhD+WDEI5nXa4usT6ygmp+12WN22FZ0N2PA+2ZwAW+PhDe20i
         wwVdvZfICfjEqt1DtMnFjaSPdwoyg1DxnYrSHTi2QQdxEu6sPdkolhoHbJuquIrX0nIf
         plNCCYV3hBOC6CD3M2uS/osgV2IVQsCQHqzcAgVVmhXIK+YriFltMX34AGtBl00HFYSW
         SbH+VDmjJBDbP/ZNL9Jy4/0R1yZ9pKbEEIep8RJubeaA+v4n3vptD9xJXlBLm1ZS+UzT
         YgIg==
X-Gm-Message-State: ACrzQf3zVHU9x15UJ9LmV5yB4FFVyGmeno+iVKyiPYj5juhrdz1sNiQG
        PmWSQ1A6ioAzZQ1ChRdEvrSSIQ==
X-Google-Smtp-Source: AMsMyM4rZial6XqFQ7CPea8ozsw+ZhYiET1jrFdyhtdxO745t9qc9x4yTGaTOoGP3enBHjtpYhh3OQ==
X-Received: by 2002:a05:600c:310b:b0:3b4:c1ce:cd83 with SMTP id g11-20020a05600c310b00b003b4c1cecd83mr2901066wmo.91.1664289185977;
        Tue, 27 Sep 2022 07:33:05 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b003b4924493bfsm17518371wmq.9.2022.09.27.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:33:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v6 10/29] thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
Date:   Tue, 27 Sep 2022 16:32:20 +0200
Message-Id: <20220927143239.376737-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927143239.376737-1-daniel.lezcano@linaro.org>
References: <20220927143239.376737-1-daniel.lezcano@linaro.org>
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

Replace a single call to thermal_zone_get_trip() to get a trip point
instead of calling the different ops->get_trip*

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/tegra/soctherm.c        | 33 +++++++++++--------------
 drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++-------
 2 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 1efe470f31e9..96b541458ccd 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -582,23 +582,23 @@ static int tsensor_group_thermtrip_get(struct tegra_soctherm *ts, int id)
 	return temp;
 }
 
-static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip_id, int temp)
 {
 	struct tegra_thermctl_zone *zone = tz->devdata;
 	struct tegra_soctherm *ts = zone->ts;
+	struct thermal_trip trip;
 	const struct tegra_tsensor_group *sg = zone->sg;
 	struct device *dev = zone->dev;
-	enum thermal_trip_type type;
 	int ret;
 
 	if (!tz)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_type(tz, trip, &type);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	if (type == THERMAL_TRIP_CRITICAL) {
+	if (trip.type == THERMAL_TRIP_CRITICAL) {
 		/*
 		 * If thermtrips property is set in DT,
 		 * doesn't need to program critical type trip to HW,
@@ -609,7 +609,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 		else
 			return 0;
 
-	} else if (type == THERMAL_TRIP_HOT) {
+	} else if (trip.type == THERMAL_TRIP_HOT) {
 		int i;
 
 		for (i = 0; i < THROTTLE_SIZE; i++) {
@@ -620,7 +620,7 @@ static int tegra_thermctl_set_trip_temp(struct thermal_zone_device *tz, int trip
 				continue;
 
 			cdev = ts->throt_cfgs[i].cdev;
-			if (get_thermal_instance(tz, cdev, trip))
+			if (get_thermal_instance(tz, cdev, trip_id))
 				stc = find_throttle_cfg_by_name(ts, cdev->type);
 			else
 				continue;
@@ -687,25 +687,20 @@ static const struct thermal_zone_device_ops tegra_of_thermal_ops = {
 	.set_trips = tegra_thermctl_set_trips,
 };
 
-static int get_hot_temp(struct thermal_zone_device *tz, int *trip, int *temp)
+static int get_hot_temp(struct thermal_zone_device *tz, int *trip_id, int *temp)
 {
-	int ntrips, i, ret;
-	enum thermal_trip_type type;
+	int i, ret;
+	struct thermal_trip trip;
 
-	ntrips = of_thermal_get_ntrips(tz);
-	if (ntrips <= 0)
-		return -EINVAL;
+	for (i = 0; i < thermal_zone_get_num_trips(tz); i++) {
 
-	for (i = 0; i < ntrips; i++) {
-		ret = tz->ops->get_trip_type(tz, i, &type);
+		ret = thermal_zone_get_trip(tz, i, &trip);
 		if (ret)
 			return -EINVAL;
-		if (type == THERMAL_TRIP_HOT) {
-			ret = tz->ops->get_trip_temp(tz, i, temp);
-			if (!ret)
-				*trip = i;
 
-			return ret;
+		if (trip.type == THERMAL_TRIP_HOT) {
+			*trip_id = i;
+			return 0;	
 		}
 	}
 
diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/thermal/tegra/tegra30-tsensor.c
index c34501287e96..cbaad2245f1d 100644
--- a/drivers/thermal/tegra/tegra30-tsensor.c
+++ b/drivers/thermal/tegra/tegra30-tsensor.c
@@ -316,18 +316,17 @@ static void tegra_tsensor_get_hw_channel_trips(struct thermal_zone_device *tzd,
 	*hot_trip  = 85000;
 	*crit_trip = 90000;
 
-	for (i = 0; i < tzd->num_trips; i++) {
-		enum thermal_trip_type type;
-		int trip_temp;
+	for (i = 0; i < thermal_zone_get_num_trips(tzd); i++) {
 
-		tzd->ops->get_trip_temp(tzd, i, &trip_temp);
-		tzd->ops->get_trip_type(tzd, i, &type);
+		struct thermal_trip trip;
 
-		if (type == THERMAL_TRIP_HOT)
-			*hot_trip = trip_temp;
+		thermal_zone_get_trip(tzd, i, &trip);
+		
+		if (trip.type == THERMAL_TRIP_HOT)
+			*hot_trip = trip.temperature;
 
-		if (type == THERMAL_TRIP_CRITICAL)
-			*crit_trip = trip_temp;
+		if (trip.type == THERMAL_TRIP_CRITICAL)
+			*crit_trip = trip.temperature;
 	}
 
 	/* clamp hardware trips to the calibration limits */
-- 
2.34.1

