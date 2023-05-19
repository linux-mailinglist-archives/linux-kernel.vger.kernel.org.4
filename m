Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16561708E57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjESD2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjESD1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2650610DF;
        Thu, 18 May 2023 20:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD2BD61D72;
        Fri, 19 May 2023 03:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCD9C4339B;
        Fri, 19 May 2023 03:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466862;
        bh=j5rfFoVzEr1r1mhCyIHkEbkNMEE39ME6y6wkLNwDhXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lYhbQcr2Jh0r1DJKiqXu81vy4FDODEAouLPYOQABwTLfDo5ARGG7zmpVHVW8Ja15U
         qOx/sUSIFsPUZzoanVTeDqOYJPT9XZE9EaM0LDvqypCJFeL1NUfQJXsSQU3sTW1FuN
         +wzBk1YKQR0ordWKRan4/pvgDWF3VOzF0coGpo6/MTu9hdHNsaXb0uJA0ZJ4f1X+Xj
         z/qLkyq6RLAGY2GH/HvcB3pjESiOGcQswd+t0beEToG23RdfUm2ZSxII8Z6vzOahrp
         3xME5TdzDtWUqfOWRRTJgZqiQ/qG4Tp2NfXz16Wz7NXBz+oYR1WEZ0E1PnQ2GzQgtw
         Q5JT6MKAwo5ew==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] thermal: stats: introduce tz time in trip
Date:   Thu, 18 May 2023 20:27:17 -0700
Message-Id: <20230519032719.2581689-6-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032719.2581689-1-evalenti@kernel.org>
References: <20230519032719.2581689-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

This patch adds a statistic to report how long
the thermal zone spent on temperature intervals
created by each trip point. The first interval
is the range below the first trip point. All
subsequent intervals are accounted when temperature
is above the trip point temperature value.

Samples:
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	35188
trip1	25000	0
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	36901
trip1	25000	0
$ echo 25001 > /sys//class/thermal/thermal_zone0/emul_temp
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	47810
trip1	25000	2259
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	47810
trip1	25000	3224
$ echo 24001 > /sys//class/thermal/thermal_zone0/emul_temp
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	48960
trip1	25000	10080
$ cat /sys//class/thermal/thermal_zone0/stats/time_in_trip_ms
trip-1	0	0
trip0	-10000	49844
trip1	25000	10080

Cc: "Rafael J. Wysocki" <rafael@kernel.org> (supporter:THERMAL)
Cc: Daniel Lezcano <daniel.lezcano@linaro.org> (supporter:THERMAL)
Cc: Amit Kucheria <amitk@kernel.org> (reviewer:THERMAL)
Cc: Zhang Rui <rui.zhang@intel.com> (reviewer:THERMAL)
Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-pm@vger.kernel.org (open list:THERMAL)
Cc: linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc: linux-kernel@vger.kernel.org (open list)

Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 .../driver-api/thermal/sysfs-api.rst          |  2 +
 drivers/thermal/thermal_sysfs.c               | 86 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index ed5e6ba4e0d7..4a2b92a7488c 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -359,6 +359,8 @@ Thermal zone device sys I/F, created once it's registered::
     |---stats/reset_tz_stats:	Writes to this file resets the statistics.
     |---stats/max_gradient:	The maximum recorded dT/dt in uC/ms.
     |---stats/min_gradient:	The minimum recorded dT/dt in uC/ms.
+    |---stats/time_in_trip_ms:	Time spent on each temperature interval of
+				trip points.
 
 Thermal cooling device sys I/F, created once it's registered::
 
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f89ec9a7e8c8..25851fe073c3 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -544,6 +544,7 @@ struct thermal_zone_device_stats {
 	s64 max_gradient;
 	s64 min_gradient;
 	ktime_t last_time;
+	ktime_t *time_in_trip;
 };
 
 #define DELTA_MILLI_C_TO_MICRO_C(t0, t1)		(((t0) - (t1)) * 1000)
@@ -552,6 +553,7 @@ static void temperature_stats_update(struct thermal_zone_device *tz)
 	struct thermal_zone_device_stats *stats = tz->stats;
 	ktime_t now = ktime_get(), delta;
 	s64 cur_gradient, delta_temp;
+	int i, trip_id = -1;
 
 	delta = ktime_sub(now, stats->last_time);
 	stats->last_time = now;
@@ -567,6 +569,29 @@ static void temperature_stats_update(struct thermal_zone_device *tz)
 	if (tz->last_temperature == 0)
 		cur_gradient = 0;
 
+	for (i = 0; i < tz->num_trips; i++) {
+		struct thermal_trip trip;
+		int ret;
+
+		ret = __thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			continue;
+
+		if (tz->temperature > trip.temperature)
+			trip_id = i;
+	}
+
+	/*
+	 * Update how long we spend in each temperature interval.
+	 * This array is like as follows:
+	 * time_in_trip[0] == time spent with temperature <= trip[0]
+	 * time_in_trip[1] == time spent with temperature > trip[0]
+	 * time_in_trip[2] == time spent with temperature > trip[1]
+	 * ...
+	 */
+	stats->time_in_trip[trip_id + 1] =
+		ktime_add(stats->time_in_trip[trip_id + 1], delta);
+
 	/* update fastest temperature rise from our perspective */
 	if (cur_gradient > stats->max_gradient)
 		stats->max_gradient = cur_gradient;
@@ -615,12 +640,66 @@ static ssize_t min_gradient_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t
+time_in_trip_ms_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+	ssize_t len = 0, ret = 0;
+	int i;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+
+	/*
+	 * This should look like this:
+	 * trip-1	X
+	 * trip0	Y
+	 * trip1	Z
+	 * ...
+	 * and the way to read is. This thermal zone temperature was seen
+	 * X ms with tz->temperature <= trip0, Y ms with tz->temperature > trip0
+	 * and Z ms with tz->temperature > trip1.
+	 */
+	for (i = 0; i <= tz->num_trips; i++) {
+		int trip_temp = 0, r = 0;
+
+		if (i > 0) {
+			struct thermal_trip trip;
+
+			r = __thermal_zone_get_trip(tz, i - 1, &trip);
+			if (r < 0) {
+				ret = r;
+				break;
+			}
+			trip_temp = trip.temperature;
+		}
+
+		ret = snprintf(buf + len, PAGE_SIZE - len, "trip%d\t%d\t%llu\n",
+			       i - 1, trip_temp,
+			       ktime_to_ms(stats->time_in_trip[i]));
+
+		if (ret == 0)
+			ret = -EOVERFLOW;
+
+		if (ret < 0)
+			break;
+
+		len += ret;
+	}
+	spin_unlock(&stats->lock);
+
+	return ret < 0 ? ret : len;
+}
+
 static ssize_t
 reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 		     const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	struct thermal_zone_device_stats *stats = tz->stats;
+	int i;
 
 	spin_lock(&stats->lock);
 
@@ -628,6 +707,9 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 	stats->max_gradient = 0;
 	stats->last_time = ktime_get();
 
+	for (i = 0; i <= tz->num_trips; i++)
+		stats->time_in_trip[i] = ktime_set(0, 0);
+
 	spin_unlock(&stats->lock);
 
 	return count;
@@ -635,11 +717,13 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(min_gradient);
 static DEVICE_ATTR_RO(max_gradient);
+static DEVICE_ATTR_RO(time_in_trip_ms);
 static DEVICE_ATTR_WO(reset_tz_stats);
 
 static struct attribute *thermal_zone_device_stats_attrs[] = {
 	&dev_attr_min_gradient.attr,
 	&dev_attr_max_gradient.attr,
+	&dev_attr_time_in_trip_ms.attr,
 	&dev_attr_reset_tz_stats.attr,
 	NULL
 };
@@ -657,11 +741,13 @@ thermal_zone_device_stats_setup(struct thermal_zone_device *tz,
 	int var;
 
 	var = sizeof(*stats);
+	var += sizeof(*stats->time_in_trip) * (tz->num_trips + 1);
 
 	stats = kzalloc(var, GFP_KERNEL);
 	if (!stats)
 		return;
 
+	stats->time_in_trip = (ktime_t *)(stats + 1);
 	stats->last_time = ktime_get();
 	spin_lock_init(&stats->lock);
 	tz->stats = stats;
-- 
2.34.1

