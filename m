Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0181B708E54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjESD2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE7610DD;
        Thu, 18 May 2023 20:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E967D653B7;
        Fri, 19 May 2023 03:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3605C433D2;
        Fri, 19 May 2023 03:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466861;
        bh=YQ8esjaUlDPz/HxA3zI19y4t2Erk1u1PDHI45b/FAeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTblL0ZRymq9Z9SHMp6VVNQpGAQ4UTw7GleisCltuJuFe1mZhQLo1+iwAW+PmIR11
         VRoKelBaL1mQUnrSgoIQQAJJyeA8fHfXh4QgNyAjjYkWJSLMeU7EDdSRz9OyqGlq7q
         tCpIX5qcRLBr8iLGaDx+BAcSxK9BPgj9prQTfBXDmfFYUtVkUUeYIFKkf1626/w3Zo
         kB5Us0ZSP8cp7hUqlpul9s/klriqvkWMkOlLC1JO6/Ovd05vNAu4uSY6qyHu+2lRcm
         356X3MCuQcoCN/bcBRB2HxgHj5DxmbAqZDrzCvUyBkmV+w+Ft4OB0x0ITZrmdvsbOF
         eKC12yR2ymnvA==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] thermal: stats: introduce thermal zone stats/ directory
Date:   Thu, 18 May 2023 20:27:15 -0700
Message-Id: <20230519032719.2581689-4-evalenti@kernel.org>
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

This patch adds a new sysfs interface to report
statistics of each thermal zone. This interface
follows the existing thermal statistics for cooling
devices design, in which it is provided a reset
mechanism. The patch adds a statistic to track
the maximum gradient (dT/dt) to the thermal zone
stats/ folder.

Sample, how gradient changes using emulation:

$ cat stats/max_gradient
0
$ echo 2000 > emul_temp
$ cat temp
2000
$ cat stats/max_gradient
2849
$ cat temp
2000

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
 .../driver-api/thermal/sysfs-api.rst          |   3 +
 drivers/thermal/thermal_core.c                |   1 +
 drivers/thermal/thermal_core.h                |   3 +
 drivers/thermal/thermal_sysfs.c               | 142 +++++++++++++++++-
 include/linux/thermal.h                       |   2 +
 5 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 75309a51d9b3..18140dbb1ce1 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -355,6 +355,9 @@ Thermal zone device sys I/F, created once it's registered::
     |---integral_cutoff:        Offset above which errors are accumulated
     |---slope:                  Slope constant applied as linear extrapolation
     |---offset:                 Offset constant applied as linear extrapolation
+    |---stats:			Directory containing thermal zone device's stats
+    |---stats/reset_tz_stats:	Writes to this file resets the statistics.
+    |---stats/max_gradient:	The maximum recorded dT/dt in uC/ms.
 
 Thermal cooling device sys I/F, created once it's registered::
 
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4bb77af6a6f4..3ba970c0744f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -385,6 +385,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
+	thermal_zone_device_stats_update(tz);
 
 	trace_thermal_temperature(tz);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index ed6511c3b794..ef37b92bbb7c 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -140,10 +140,13 @@ ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
 
 #ifdef CONFIG_THERMAL_STATISTICS
+void thermal_zone_device_stats_update(struct thermal_zone_device *tz);
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 					 struct thermal_instance *instance,
 					 unsigned long new_state);
 #else
+static inline
+void thermal_zone_device_stats_update(struct thermal_zone_device *tz) {}
 static inline void
 thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 				    struct thermal_instance *instance,
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 0bce1415f7e8..aa28c1cae916 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -537,20 +537,147 @@ static void destroy_trip_attrs(struct thermal_zone_device *tz)
 	kfree(tz->trips_attribute_group.attrs);
 }
 
+#ifdef CONFIG_THERMAL_STATISTICS
+/* thermal zone device statistics handling */
+struct thermal_zone_device_stats {
+	spinlock_t lock; /* protects this struct */
+	s64 max_gradient;
+	ktime_t last_time;
+};
+
+#define DELTA_MILLI_C_TO_MICRO_C(t0, t1)		(((t0) - (t1)) * 1000)
+static void temperature_stats_update(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device_stats *stats = tz->stats;
+	ktime_t now = ktime_get(), delta;
+	s64 cur_gradient, delta_temp;
+
+	delta = ktime_sub(now, stats->last_time);
+	stats->last_time = now;
+
+	/* to see sub 1C/s, use uC/ms */
+	delta_temp = DELTA_MILLI_C_TO_MICRO_C(tz->temperature,
+					      tz->last_temperature);
+	cur_gradient = ktime_to_ms(delta);
+	if (cur_gradient)
+		cur_gradient = div64_s64(delta_temp, cur_gradient);
+
+	/* Corner case of initialization, first temp read */
+	if (tz->last_temperature == 0)
+		cur_gradient = 0;
+
+	/* update fastest temperature rise from our perspective */
+	if (cur_gradient > stats->max_gradient)
+		stats->max_gradient = cur_gradient;
+}
+
+void thermal_zone_device_stats_update(struct thermal_zone_device *tz)
+{
+	struct thermal_zone_device_stats *stats = tz->stats;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+	spin_unlock(&stats->lock);
+}
+
+static ssize_t max_gradient_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+	int ret;
+
+	spin_lock(&stats->lock);
+	temperature_stats_update(tz);
+	ret = snprintf(buf, PAGE_SIZE, "%lld\n", stats->max_gradient);
+	spin_unlock(&stats->lock);
+
+	return ret;
+}
+
+static ssize_t
+reset_tz_stats_store(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	struct thermal_zone_device_stats *stats = tz->stats;
+
+	spin_lock(&stats->lock);
+
+	stats->max_gradient = 0;
+	stats->last_time = ktime_get();
+
+	spin_unlock(&stats->lock);
+
+	return count;
+}
+
+static DEVICE_ATTR_RO(max_gradient);
+static DEVICE_ATTR_WO(reset_tz_stats);
+
+static struct attribute *thermal_zone_device_stats_attrs[] = {
+	&dev_attr_max_gradient.attr,
+	&dev_attr_reset_tz_stats.attr,
+	NULL
+};
+
+static const struct attribute_group thermal_zone_device_stats_attr_group = {
+	.attrs = thermal_zone_device_stats_attrs,
+	.name = "stats"
+};
+
+static void
+thermal_zone_device_stats_setup(struct thermal_zone_device *tz,
+				const struct attribute_group **group)
+{
+	struct thermal_zone_device_stats *stats;
+	int var;
+
+	var = sizeof(*stats);
+
+	stats = kzalloc(var, GFP_KERNEL);
+	if (!stats)
+		return;
+
+	stats->last_time = ktime_get();
+	spin_lock_init(&stats->lock);
+	tz->stats = stats;
+
+	/* Fill the empty slot left in thermal_zone_device_attr_groups */
+	*group = &thermal_zone_device_stats_attr_group;
+}
+
+static void thermal_zone_device_stats_destroy(struct thermal_zone_device *tz)
+{
+	kfree(tz->stats);
+	tz->stats = NULL;
+}
+#else
+
+static inline void
+thermal_zone_device_stats_setup(struct thermal_zone_device *tz,
+				const struct attribute_group **group) {}
+static inline void
+thermal_zone_device_stats_destroy(struct thermal_zone_device *tz) {}
+
+#endif
+
 int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 				      int mask)
 {
 	const struct attribute_group **groups;
-	int i, size, result;
+	int i, size, result, extras = 2;
 
+	if (IS_ENABLED(CONFIG_THERMAL_STATISTIC))
+		extras++;
 	/* we need one extra for trips and the NULL to terminate the array */
-	size = ARRAY_SIZE(thermal_zone_attribute_groups) + 2;
+	size = ARRAY_SIZE(thermal_zone_attribute_groups) + extras;
 	/* This also takes care of API requirement to be NULL terminated */
 	groups = kcalloc(size, sizeof(*groups), GFP_KERNEL);
 	if (!groups)
 		return -ENOMEM;
 
-	for (i = 0; i < size - 2; i++)
+	for (i = 0; i < size - extras; i++)
 		groups[i] = thermal_zone_attribute_groups[i];
 
 	if (tz->num_trips) {
@@ -561,9 +688,15 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 			return result;
 		}
 
-		groups[size - 2] = &tz->trips_attribute_group;
+		groups[size - extras] = &tz->trips_attribute_group;
 	}
 
+	/*
+	 * This will be nop if CONFIG_THERMAL_STATISTICS is not defined,
+	 * otherwise, it is always the last entry in the group prior to NULL
+	 */
+	thermal_zone_device_stats_setup(tz, &groups[size - 2]);
+
 	tz->device.groups = groups;
 
 	return 0;
@@ -578,6 +711,7 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
 		destroy_trip_attrs(tz);
 
 	kfree(tz->device.groups);
+	thermal_zone_device_stats_destroy(tz);
 }
 
 /* sys I/F for cooling device */
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..9dc8292f0314 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -121,6 +121,7 @@ struct thermal_cooling_device {
  * @trip_type_attrs:	attributes for trip points for sysfs: trip type
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
+ * @stats:		private pointer to stats collected on this thermal zone
  * @devdata:	private pointer for device private data
  * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
@@ -162,6 +163,7 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
+	void *stats;
 	void *devdata;
 	struct thermal_trip *trips;
 	int num_trips;
-- 
2.34.1

