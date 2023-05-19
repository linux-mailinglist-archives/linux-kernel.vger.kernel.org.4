Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25ED708E58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjESD2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjESD1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278E10E9;
        Thu, 18 May 2023 20:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4112E653C3;
        Fri, 19 May 2023 03:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F121C4339E;
        Fri, 19 May 2023 03:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466863;
        bh=ujYvyZ0mZ6AlXxLS56qjiYCxAcNxvL+EYzl8ihJpbwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4wgFIUdZPMp2aSIvY0Dtwi1ytQPZlrke9rEsq2Nv3a7vcSzwbzO/UYxJ0HkiP0fK
         9C82l58vw22sST2p8bZdYTlf3nbfce9LvPZe0GBGyEqTjrkdYrqEaPyoH/AtRDK3Bz
         xpzvuW5KCW6RdYhaPMrmYlSyNfz0wSwnObqZqdw3dw+eajk1R6NESCAMwv5yWVNq/j
         irs+aDFBWTPEgEKzEFE2C802KDE6jE3WDtja8I9IFFPa15nPzA+OPvFdpQrA7l3U99
         RCCqmcYwLA0o93mZ6Br/zJ7Tgz48iqkgNP3o5uQJXX7V/4g2g8AphLiSFfVGyOp/nZ
         1wthwW0b7FpNg==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] thermal: stats: add error accounting to thermal zone
Date:   Thu, 18 May 2023 20:27:19 -0700
Message-Id: <20230519032719.2581689-8-evalenti@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519032719.2581689-1-evalenti@kernel.org>
References: <20230519032719.2581689-1-evalenti@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eduardo Valentin <eduval@amazon.com>

This patch adds an extra stat to report how many
temperature update failures were detected.
Error count is increase whenever the thermal
driver returns an actual error or when the temperature
is non positive.

Sample:

$ cat /sys/class/thermal/thermal_zone0/stats/error_count
0
$ echo -1 > /sys/class/thermal/thermal_zone0/emul_temp
$ cat /sys/class/thermal/thermal_zone0/stats/error_count
3

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
 drivers/thermal/thermal_core.c  |  3 ++
 drivers/thermal/thermal_core.h  |  7 ++++
 drivers/thermal/thermal_sysfs.c | 64 +++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 2ff7d9c7c973..359e7b2ff0e3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -389,6 +389,9 @@ static void update_temperature(struct thermal_zone_device *tz)
 		/* tell the governor its source is hosed */
 		handle_error_temperature(tz, ret);
 
+		/* book keeping */
+		thermal_zone_device_error_stats_update(tz, ret);
+
 		return;
 	}
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ef37b92bbb7c..612f93e6c257 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -141,12 +141,19 @@ ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 
 #ifdef CONFIG_THERMAL_STATISTICS
 void thermal_zone_device_stats_update(struct thermal_zone_device *tz);
+void thermal_zone_device_error_stats_update(struct thermal_zone_device *tz,
+					    int error);
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 					 struct thermal_instance *instance,
 					 unsigned long new_state);
 #else
 static inline
 void thermal_zone_device_stats_update(struct thermal_zone_device *tz) {}
+static inline
+void thermal_zone_device_error_stats_update(struct thermal_zone_device *tz,
+					    int error)
+{
+}
 static inline void
 thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 				    struct thermal_instance *instance,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 25851fe073c3..e511042e9dab 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -541,12 +541,21 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 /* thermal zone device statistics handling */
 struct thermal_zone_device_stats {
 	spinlock_t lock; /* protects this struct */
+	unsigned int error_count; /* just account them */
+	int max_temperature;
 	s64 max_gradient;
 	s64 min_gradient;
 	ktime_t last_time;
 	ktime_t *time_in_trip;
 };
 
+static void error_stats_update(struct thermal_zone_device *tz, int error)
+{
+	struct thermal_zone_device_stats *stats = tz->stats;
+
+	stats->error_count++;
+}
+
 #define DELTA_MILLI_C_TO_MICRO_C(t0, t1)		(((t0) - (t1)) * 1000)
 static void temperature_stats_update(struct thermal_zone_device *tz)
 {
@@ -555,6 +564,15 @@ static void temperature_stats_update(struct thermal_zone_device *tz)
 	s64 cur_gradient, delta_temp;
 	int i, trip_id = -1;
 
+	if (tz->temperature <= 0) {
+		/* probably a wrong reading */
+		error_stats_update(tz, tz->temperature);
+		return;
+	}
+
+	if (tz->temperature > stats->max_temperature)
+		stats->max_temperature = tz->temperature;
+
 	delta = ktime_sub(now, stats->last_time);
 	stats->last_time = now;
 
@@ -610,6 +628,31 @@ void thermal_zone_device_stats_update(struct thermal_zone_device *tz)
 	spin_unlock(&stats->lock);
 }
 
+void thermal_zone_device_error_stats_update(struct thermal_zone_device *tz,
+					    int error)
+{
+	struct thermal_zone_device_stats *stats = tz->stats;
+
+	spin_lock(&stats->lock);
+	error_stats_update(tz, error);
+	spin_unlock(&stats->lock);
+}
+
+static ssize_t max_temperature_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+	ret = snprintf(buf, PAGE_SIZE, "%d\n", stats->max_temperature);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
 static ssize_t max_gradient_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -640,6 +683,21 @@ static ssize_t min_gradient_show(struct device *dev,
 	return ret;
 }
 
+static ssize_t error_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+	ret = snprintf(buf, PAGE_SIZE, "%u\n", stats->error_count);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
 static ssize_t
 time_in_trip_ms_show(struct device *dev, struct device_attribute *attr,
 		     char *buf)
@@ -705,6 +763,8 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 
 	stats->min_gradient = 0;
 	stats->max_gradient = 0;
+	stats->max_temperature = 0;
+	stats->error_count = 0;
 	stats->last_time = ktime_get();
 
 	for (i = 0; i <= tz->num_trips; i++)
@@ -717,13 +777,17 @@ reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR_RO(min_gradient);
 static DEVICE_ATTR_RO(max_gradient);
+static DEVICE_ATTR_RO(max_temperature);
 static DEVICE_ATTR_RO(time_in_trip_ms);
+static DEVICE_ATTR_RO(error_count);
 static DEVICE_ATTR_WO(reset_tz_stats);
 
 static struct attribute *thermal_zone_device_stats_attrs[] = {
 	&dev_attr_min_gradient.attr,
 	&dev_attr_max_gradient.attr,
+	&dev_attr_max_temperature.attr,
 	&dev_attr_time_in_trip_ms.attr,
+	&dev_attr_error_count.attr,
 	&dev_attr_reset_tz_stats.attr,
 	NULL
 };
-- 
2.34.1

