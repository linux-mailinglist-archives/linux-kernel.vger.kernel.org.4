Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F235BFB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIUJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbiIUJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB09693218
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso8675594wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=u0mxhacmQxIDsYhufw+34LhjN3eUn9K5O8FWLsoTNemZF6+Z3ucjvD9AFKCCum+ckP
         K9CW2cb3J5znddARofJL4JR4d3rRHqF2ds+9g2GCiPmKfWH6Ge/cyP9ZwL+6SqIKkrdy
         iSU1VCKd4e7h2aQ+qk2ZMj7O4KYz1hKk8ka7T/bsWhR3Of506eFfCLSZj48t8RcEEtud
         rSKdTcC4/7OLgIWBMv+ANkGZqLcbalrEGktOopwF3nWu4f4V4Q0UbLgSfs54TJ7S/sM6
         G3gnpP1PLebIa7r7LRN3OR1lk0RUzhW53ddErgDJDL7six2+Df6B5IUZC7n1uprb2rn2
         PYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XsxTgl9OJhYT/B2dXFDz/rl/9WpF5J4y9HKMzylFxc4=;
        b=22Eep4uSgnWDVl5m3gAXWZWITrVOozsJyTmUp6q/dXRKNlWoDgtalFdLgELgrbc3Mj
         54KKBb7IUvBiBJNO3EXZz46qtVeG4eavied9Ky1G2e+RkPKTv3mE2W1HZA9CuPuixi9F
         bJT1N8BJCI8Xgde0YkT+ET6GGzVR+Da6LmkeQBVSWW/MWwYORMlrE68sqBiZLZXncxmw
         N5/0EGkCCqrTY/7G/1sVHvbG+2LIFwOX8LVvo5Y5F59/xzFMdOPZ/E6KjoqDKlDd7uvD
         MR/tWcYUdnlrOavI3dsa99ac1VQ+T4s+3y+A+jUjzF/tr7dTs9EcxemdUL6crFDjtVYo
         tPqQ==
X-Gm-Message-State: ACrzQf0rtXMPipfx24rbsk3yYC4Tk03WPIsZw4daxakFMEGRDUq8L7RZ
        VbomvXX6aWMgTwsx+2lGXU0fVg==
X-Google-Smtp-Source: AMsMyM4tWySi0xBEIkP7CeEstg7kcGTgsx/2lbSxzqD9yMdT2Xnkgr6JbQnkLsmJAXZ1l0qVOo4w6w==
X-Received: by 2002:a7b:c00d:0:b0:3b4:6331:2fc5 with SMTP id c13-20020a7bc00d000000b003b463312fc5mr5133169wmb.11.1663753416909;
        Wed, 21 Sep 2022 02:43:36 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:36 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: [PATCH v4 11/30] thermal/drivers/tegra: Use generic thermal_zone_get_trip() function
Date:   Wed, 21 Sep 2022 11:42:24 +0200
Message-Id: <20220921094244.606948-12-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
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

