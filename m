Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E61708E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 05:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjESD1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 23:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjESD1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 23:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59010D8;
        Thu, 18 May 2023 20:27:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C14FF653C9;
        Fri, 19 May 2023 03:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3906C4339B;
        Fri, 19 May 2023 03:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684466860;
        bh=4asWSzWthCuWva4vbm2BVZjitrrI9jnAgkO5N4CiQ/M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FxPsrxAbmBFyE6Mhl8fb+fnO453wXVCmss/sM6ypIT6Mv4x6p0oeR9ESn1PFxNa4y
         LTbjvVoqQ646yEpsOGZZB13Qx30c5f4gQdQFmSv23pcZIpGYCkm/w3PNOKojBfzH6S
         DvYPU8R3fSXjVho3qa6FCm/KYgHyHajut+3KM498UVdGC8NcbipMXMY4kRHsiBGLVF
         i+G1vKXmVC/BDltyj1o7Hivv8Xh2NoC+831w/7BjQgzOECSoc/i1gfhPNLXrCkECN/
         XOikShuFGYmlm9n2OTds7JFpDJieUlKTIO+2qZradvgZLivjMtGx50LagGsjxDSisE
         aFr5m6C4AN+CA==
From:   Eduardo Valentin <evalenti@kernel.org>
To:     eduval@amazon.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] thermal: stats: track time each dev changes due to tz
Date:   Thu, 18 May 2023 20:27:13 -0700
Message-Id: <20230519032719.2581689-2-evalenti@kernel.org>
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

This patch improves the current cooling device
statistics by adding a new file under
cdev/stats/time_in_thermal_zone_ms
to represent the time in milliseconds
that the cooling device was driven by each
associated thermal zone.

The file format is:
thermal_zone: <type> <time_in_ms>

Samples:
$ cat /sys/class/thermal/cooling_device0/stats/time_in_thermal_zone_ms
thermal_zone: amb0	117496

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
 .../driver-api/thermal/sysfs-api.rst          |   2 +
 drivers/thermal/thermal_core.c                |   2 +-
 drivers/thermal/thermal_core.h                |   5 +
 drivers/thermal/thermal_helpers.c             |  11 +-
 drivers/thermal/thermal_sysfs.c               | 128 +++++++++++++++++-
 5 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 6c1175c6afba..caa50d61a5bc 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -367,6 +367,8 @@ Thermal cooling device sys I/F, created once it's registered::
     |---stats/time_in_state_ms:	Time (msec) spent in various cooling states
     |---stats/total_trans:	Total number of times cooling state is changed
     |---stats/trans_table:	Cooling state transition table
+    |---stats/time_in_thermal_zone_ms:	Time that this cooling device was driven
+                                each associated thermal zone.
 
 
 Then next two dynamic attributes are created/removed in pairs. They represent
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 842f678c1c3e..4bb77af6a6f4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1078,7 +1078,7 @@ void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
 	if (cdev->ops->get_cur_state(cdev, &state) || state > cdev->max_state)
 		goto unlock;
 
-	thermal_cooling_device_stats_update(cdev, state);
+	thermal_cooling_device_stats_update(cdev, NULL, state);
 
 unlock:
 	mutex_unlock(&cdev->lock);
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 3d4a787c6b28..3cce60c6e065 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -102,6 +102,9 @@ struct thermal_instance {
 	struct list_head cdev_node; /* node in cdev->thermal_instances */
 	unsigned int weight; /* The weight of the cooling device */
 	bool upper_no_limit;
+#if IS_ENABLED(CONFIG_THERMAL_STATISTICS)
+	ktime_t time_in; /* time spent in this instance */
+#endif
 };
 
 #define to_thermal_zone(_dev) \
@@ -137,10 +140,12 @@ ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 
 #ifdef CONFIG_THERMAL_STATISTICS
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 struct thermal_instance *instance,
 					 unsigned long new_state);
 #else
 static inline void
 thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+				    struct thermal_instance *instance,
 				    unsigned long new_state) {}
 #endif /* CONFIG_THERMAL_STATISTICS */
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index cfba0965a22d..ec8e86394977 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -149,18 +149,19 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
+				       struct thermal_instance *target_instance,
 				       int target)
 {
 	if (cdev->ops->set_cur_state(cdev, target))
 		return;
 
 	thermal_notify_cdev_state_update(cdev->id, target);
-	thermal_cooling_device_stats_update(cdev, target);
+	thermal_cooling_device_stats_update(cdev, target_instance, target);
 }
 
 void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 {
-	struct thermal_instance *instance;
+	struct thermal_instance *instance, *target_instance = NULL;
 	unsigned long target = 0;
 
 	/* Make sure cdev enters the deepest cooling state */
@@ -169,11 +170,13 @@ void __thermal_cdev_update(struct thermal_cooling_device *cdev)
 			instance->tz->id, instance->target);
 		if (instance->target == THERMAL_NO_TARGET)
 			continue;
-		if (instance->target > target)
+		if (instance->target > target) {
 			target = instance->target;
+			target_instance = instance;
+		}
 	}
 
-	thermal_cdev_set_cur_state(cdev, target);
+	thermal_cdev_set_cur_state(cdev, target_instance, target);
 
 	trace_cdev_update(cdev, target);
 	dev_dbg(&cdev->device, "set to state %lu\n", target);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 6c20c9f90a05..a3b71f03db75 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -632,7 +632,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (!result)
-		thermal_cooling_device_stats_update(cdev, state);
+		thermal_cooling_device_stats_update(cdev, NULL, state);
 
 	mutex_unlock(&cdev->lock);
 	return result ? result : count;
@@ -661,6 +661,7 @@ static const struct attribute_group *cooling_device_attr_groups[] = {
 };
 
 #ifdef CONFIG_THERMAL_STATISTICS
+/* thermal cooling device statistics handling */
 struct cooling_dev_stats {
 	spinlock_t lock;
 	unsigned int total_trans;
@@ -668,9 +669,29 @@ struct cooling_dev_stats {
 	ktime_t last_time;
 	ktime_t *time_in_state;
 	unsigned int *trans_table;
+	struct thermal_instance *last_instance;
+	struct thermal_instance *curr_instance;
 };
 
-static void update_time_in_state(struct cooling_dev_stats *stats)
+static void update_time_in_instance(struct cooling_dev_stats *stats,
+				    struct thermal_instance *instance,
+				    ktime_t now, ktime_t delta)
+{
+	if (!instance)
+		return;
+
+	stats->last_instance = stats->curr_instance;
+	stats->curr_instance = instance;
+
+	if (!stats->last_instance)
+		stats->last_instance = instance;
+
+	stats->last_instance->time_in =
+			ktime_add(stats->last_instance->time_in, delta);
+}
+
+static void update_time_in_state(struct cooling_dev_stats *stats,
+				 struct thermal_instance *instance)
 {
 	ktime_t now = ktime_get(), delta;
 
@@ -678,9 +699,12 @@ static void update_time_in_state(struct cooling_dev_stats *stats)
 	stats->time_in_state[stats->state] =
 		ktime_add(stats->time_in_state[stats->state], delta);
 	stats->last_time = now;
+
+	update_time_in_instance(stats, instance, now, delta);
 }
 
 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+					 struct thermal_instance *instance,
 					 unsigned long new_state)
 {
 	struct cooling_dev_stats *stats = cdev->stats;
@@ -695,7 +719,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 	if (stats->state == new_state)
 		goto unlock;
 
-	update_time_in_state(stats);
+	update_time_in_state(stats, instance);
 	stats->trans_table[stats->state * (cdev->max_state + 1) + new_state]++;
 	stats->state = new_state;
 	stats->total_trans++;
@@ -744,7 +768,7 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 
 	spin_lock(&stats->lock);
 
-	update_time_in_state(stats);
+	update_time_in_state(stats, stats->curr_instance);
 
 	for (i = 0; i <= cdev->max_state; i++) {
 		len += sprintf(buf + len, "state%u\t%llu\n", i,
@@ -758,12 +782,98 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 	return len;
 }
 
+struct cdev_thermal_zone_residency {
+	char thermal_zone[THERMAL_NAME_LENGTH];
+	ktime_t time_in;
+	unsigned long counter;
+	struct list_head node; /* we build this as we go */
+};
+
+static void
+build_cdev_thermal_zone_residency(struct list_head *list,
+				  struct thermal_cooling_device *cdev)
+{
+	struct cdev_thermal_zone_residency *res, *update_res;
+	struct thermal_instance *instance;
+
+	/*
+	 * Build an array of pairs <thermal zone, time> to represent
+	 * how this cooling device was driven by each thermal zone
+	 */
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
+		update_res = NULL;
+
+		list_for_each_entry(res, list, node) {
+			if (strncmp(res->thermal_zone, instance->tz->type,
+				    THERMAL_NAME_LENGTH) == 0)
+				update_res = res;
+		}
+		if (!update_res) {
+			update_res = kzalloc(sizeof(*update_res), GFP_KERNEL);
+			strscpy(update_res->thermal_zone,
+				instance->tz->type, THERMAL_NAME_LENGTH);
+			list_add_tail(&update_res->node, list);
+		}
+	}
+}
+
+static ssize_t
+time_in_thermal_zone_ms_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	LIST_HEAD(cdev_thermal_zone_list);
+	struct thermal_cooling_device *cdev = to_cooling_device(dev);
+	struct cooling_dev_stats *stats = cdev->stats;
+	struct cdev_thermal_zone_residency *res, *next;
+	struct thermal_instance *instance;
+	ssize_t len = 0, ret = 0;
+
+	mutex_lock(&cdev->lock);
+
+	spin_lock(&stats->lock);
+	update_time_in_state(stats, stats->curr_instance);
+	spin_unlock(&stats->lock);
+
+	build_cdev_thermal_zone_residency(&cdev_thermal_zone_list, cdev);
+
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node)
+		list_for_each_entry(res, &cdev_thermal_zone_list, node)
+			if (strncmp(res->thermal_zone, instance->tz->type,
+				    THERMAL_NAME_LENGTH) == 0)
+				res->time_in = ktime_add(res->time_in,
+							 instance->time_in);
+
+	mutex_unlock(&cdev->lock);
+
+	list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {
+		ret = snprintf(buf + len, PAGE_SIZE - len,
+			       "thermal_zone: %s\t%llu\n",
+			       res->thermal_zone, ktime_to_ms(res->time_in));
+
+		if (ret == 0)
+			ret = -EOVERFLOW;
+
+		if (ret < 0)
+			break;
+
+		len += ret;
+	}
+
+	list_for_each_entry_safe(res, next, &cdev_thermal_zone_list, node) {
+		list_del(&res->node);
+		kfree(res);
+	}
+
+	return ret < 0 ? ret : len;
+}
+
 static ssize_t
 reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	    size_t count)
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats;
+	struct thermal_instance *instance;
 	int i, states;
 
 	mutex_lock(&cdev->lock);
@@ -774,6 +884,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 
 	states = cdev->max_state + 1;
 
+	mutex_lock(&cdev->lock);
 	spin_lock(&stats->lock);
 
 	stats->total_trans = 0;
@@ -784,7 +895,14 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	for (i = 0; i < states; i++)
 		stats->time_in_state[i] = ktime_set(0, 0);
 
+	/* Make sure we reset all counters per instance */
+	list_for_each_entry(instance, &cdev->thermal_instances, cdev_node) {
+		instance->time_in = ktime_set(0, 0);
+	}
+
 	spin_unlock(&stats->lock);
+	mutex_unlock(&cdev->lock);
+
 
 unlock:
 	mutex_unlock(&cdev->lock);
@@ -852,12 +970,14 @@ static ssize_t trans_table_show(struct device *dev,
 
 static DEVICE_ATTR_RO(total_trans);
 static DEVICE_ATTR_RO(time_in_state_ms);
+static DEVICE_ATTR_RO(time_in_thermal_zone_ms);
 static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_RO(trans_table);
 
 static struct attribute *cooling_device_stats_attrs[] = {
 	&dev_attr_total_trans.attr,
 	&dev_attr_time_in_state_ms.attr,
+	&dev_attr_time_in_thermal_zone_ms.attr,
 	&dev_attr_reset.attr,
 	&dev_attr_trans_table.attr,
 	NULL
-- 
2.34.1

