Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842EB6C7876
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCXHId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjCXHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:08:20 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2F02723;
        Fri, 24 Mar 2023 00:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679641699; x=1711177699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u6iHiScBifXZ1ltDhXObrT9QpiwYLsnp8xcW9/S7U+I=;
  b=Co4IB9WLWmF/EB+Bp0QncespEoLf8/WEda4Jt5hc524q15UEYpheQNJJ
   MyENTgnCZyMdwKKQQfOmBnqQJNlOAPz+7KNv5uVOYKLyQSYDF/XOmu15l
   /nsu76JUJpDWKxc+cecGyI9aSiQCT+XeY3DrpHeX943MH2oIyBKAZrRoV
   wRWwYYXFh0oxQXvIJ1G7605Ig+/lR+MoBu0Uyx8mUsdGhjJwN+fEglY/V
   ffBNcd9H8sTaLI7aEjpZIClf3UUEJVFmRi2X7t0Qy3Kjk8ObXTEvpKUM9
   Wxnf6Fxzp1gizLbfGjNofftVpNsKtvobUIsBzbLVNxaO2jNZtFZemJxZH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402296723"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="402296723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="747046056"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="747046056"
Received: from fli4-mobl1.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.28.30])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:08:17 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] thermal/core: Remove thermal_bind_params structure
Date:   Fri, 24 Mar 2023 15:08:05 +0800
Message-Id: <20230324070807.6342-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324070807.6342-1-rui.zhang@intel.com>
References: <20230324070807.6342-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct thermal_bind_params because no one is using it for thermal
binding now.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 .../driver-api/thermal/sysfs-api.rst          |  40 ------
 drivers/thermal/thermal_core.c                | 134 ++----------------
 include/linux/thermal.h                       |  38 -----
 3 files changed, 14 insertions(+), 198 deletions(-)

diff --git a/Documentation/driver-api/thermal/sysfs-api.rst b/Documentation/driver-api/thermal/sysfs-api.rst
index 2e0f79a9e2ee..6c1175c6afba 100644
--- a/Documentation/driver-api/thermal/sysfs-api.rst
+++ b/Documentation/driver-api/thermal/sysfs-api.rst
@@ -304,42 +304,6 @@ temperature) and throttle appropriate devices.
 1.4 Thermal Zone Parameters
 ---------------------------
 
-    ::
-
-	struct thermal_bind_params
-
-    This structure defines the following parameters that are used to bind
-    a zone with a cooling device for a particular trip point.
-
-    .cdev:
-	     The cooling device pointer
-    .weight:
-	     The 'influence' of a particular cooling device on this
-	     zone. This is relative to the rest of the cooling
-	     devices. For example, if all cooling devices have a
-	     weight of 1, then they all contribute the same. You can
-	     use percentages if you want, but it's not mandatory. A
-	     weight of 0 means that this cooling device doesn't
-	     contribute to the cooling of this zone unless all cooling
-	     devices have a weight of 0. If all weights are 0, then
-	     they all contribute the same.
-    .trip_mask:
-	       This is a bit mask that gives the binding relation between
-	       this thermal zone and cdev, for a particular trip point.
-	       If nth bit is set, then the cdev and thermal zone are bound
-	       for trip point n.
-    .binding_limits:
-		     This is an array of cooling state limits. Must have
-		     exactly 2 * thermal_zone.number_of_trip_points. It is an
-		     array consisting of tuples <lower-state upper-state> of
-		     state limits. Each trip will be associated with one state
-		     limit tuple when binding. A NULL pointer means
-		     <THERMAL_NO_LIMITS THERMAL_NO_LIMITS> on all trips.
-		     These limits are used when binding a cdev to a trip point.
-    .match:
-	    This call back returns success(0) if the 'tz and cdev' need to
-	    be bound, as per platform data.
-
     ::
 
 	struct thermal_zone_params
@@ -357,10 +321,6 @@ temperature) and throttle appropriate devices.
 	       will be created. when no_hwmon == true, nothing will be done.
 	       In case the thermal_zone_params is NULL, the hwmon interface
 	       will be created (for backward compatibility).
-    .num_tbps:
-	       Number of thermal_bind_params entries for this zone
-    .tbp:
-	       thermal_bind_params entries
 
 2. sysfs attributes structure
 =============================
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fd54e6c10b60..5225d65fb0e0 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -794,65 +794,20 @@ void print_bind_err_msg(struct thermal_zone_device *tz,
 		tz->type, cdev->type, ret);
 }
 
-static void __bind(struct thermal_zone_device *tz, int mask,
-		   struct thermal_cooling_device *cdev,
-		   unsigned long *limits,
-		   unsigned int weight)
-{
-	int i, ret;
-
-	for (i = 0; i < tz->num_trips; i++) {
-		if (mask & (1 << i)) {
-			unsigned long upper, lower;
-
-			upper = THERMAL_NO_LIMIT;
-			lower = THERMAL_NO_LIMIT;
-			if (limits) {
-				lower = limits[i * 2];
-				upper = limits[i * 2 + 1];
-			}
-			ret = thermal_zone_bind_cooling_device(tz, i, cdev,
-							       upper, lower,
-							       weight);
-			if (ret)
-				print_bind_err_msg(tz, cdev, ret);
-		}
-	}
-}
-
 static void bind_cdev(struct thermal_cooling_device *cdev)
 {
-	int i, ret;
-	const struct thermal_zone_params *tzp;
+	int ret;
 	struct thermal_zone_device *pos = NULL;
 
 	mutex_lock(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (!pos->tzp && !pos->ops->bind)
+		if (!pos->ops->bind)
 			continue;
 
-		if (pos->ops->bind) {
-			ret = pos->ops->bind(pos, cdev);
-			if (ret)
-				print_bind_err_msg(pos, cdev, ret);
-			continue;
-		}
-
-		tzp = pos->tzp;
-		if (!tzp || !tzp->tbp)
-			continue;
-
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
-				continue;
-			if (tzp->tbp[i].match(pos, cdev))
-				continue;
-			tzp->tbp[i].cdev = cdev;
-			__bind(pos, tzp->tbp[i].trip_mask, cdev,
-			       tzp->tbp[i].binding_limits,
-			       tzp->tbp[i].weight);
-		}
+		ret = pos->ops->bind(pos, cdev);
+		if (ret)
+			print_bind_err_msg(pos, cdev, ret);
 	}
 
 	mutex_unlock(&thermal_list_lock);
@@ -1138,16 +1093,6 @@ void thermal_cooling_device_update(struct thermal_cooling_device *cdev)
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_update);
 
-static void __unbind(struct thermal_zone_device *tz, int mask,
-		     struct thermal_cooling_device *cdev)
-{
-	int i;
-
-	for (i = 0; i < tz->num_trips; i++)
-		if (mask & (1 << i))
-			thermal_zone_unbind_cooling_device(tz, i, cdev);
-}
-
 /**
  * thermal_cooling_device_unregister - removes a thermal cooling device
  * @cdev:	the thermal cooling device to remove.
@@ -1157,8 +1102,6 @@ static void __unbind(struct thermal_zone_device *tz, int mask,
  */
 void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 {
-	int i;
-	const struct thermal_zone_params *tzp;
 	struct thermal_zone_device *tz;
 
 	if (!cdev)
@@ -1175,21 +1118,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->ops->unbind) {
+		if (tz->ops->unbind)
 			tz->ops->unbind(tz, cdev);
-			continue;
-		}
-
-		if (!tz->tzp || !tz->tzp->tbp)
-			continue;
-
-		tzp = tz->tzp;
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev == cdev) {
-				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
-				tzp->tbp[i].cdev = NULL;
-			}
-		}
 	}
 
 	mutex_lock(&cdev->lock);
@@ -1204,41 +1134,20 @@ EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
 
 static void bind_tz(struct thermal_zone_device *tz)
 {
-	int i, ret;
+	int ret;
 	struct thermal_cooling_device *pos = NULL;
-	const struct thermal_zone_params *tzp = tz->tzp;
 
-	if (!tzp && !tz->ops->bind)
+	if (!tz->ops->bind)
 		return;
 
 	mutex_lock(&thermal_list_lock);
 
-	/* If there is ops->bind, try to use ops->bind */
-	if (tz->ops->bind) {
-		list_for_each_entry(pos, &thermal_cdev_list, node) {
-			ret = tz->ops->bind(tz, pos);
-			if (ret)
-				print_bind_err_msg(tz, pos, ret);
-		}
-		goto exit;
-	}
-
-	if (!tzp || !tzp->tbp)
-		goto exit;
-
 	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev || !tzp->tbp[i].match)
-				continue;
-			if (tzp->tbp[i].match(tz, pos))
-				continue;
-			tzp->tbp[i].cdev = pos;
-			__bind(tz, tzp->tbp[i].trip_mask, pos,
-			       tzp->tbp[i].binding_limits,
-			       tzp->tbp[i].weight);
-		}
+		ret = tz->ops->bind(tz, pos);
+		if (ret)
+			print_bind_err_msg(tz, pos, ret);
 	}
-exit:
+
 	mutex_unlock(&thermal_list_lock);
 }
 
@@ -1477,15 +1386,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register);
  */
 void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 {
-	int i, tz_id;
-	const struct thermal_zone_params *tzp;
+	int tz_id;
 	struct thermal_cooling_device *cdev;
 	struct thermal_zone_device *pos = NULL;
 
 	if (!tz)
 		return;
 
-	tzp = tz->tzp;
 	tz_id = tz->id;
 
 	mutex_lock(&thermal_list_lock);
@@ -1516,22 +1423,9 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 		continue;
 
 unbind:
-		if (tz->ops->unbind) {
+		if (tz->ops->unbind)
 			tz->ops->unbind(tz, cdev);
-			goto deactivate;
-		}
-
-		if (!tzp || !tzp->tbp)
-			break;
-
-		for (i = 0; i < tzp->num_tbps; i++) {
-			if (tzp->tbp[i].cdev == cdev) {
-				__unbind(tz, tzp->tbp[i].trip_mask, cdev);
-				tzp->tbp[i].cdev = NULL;
-			}
-		}
 
-deactivate:
 		/*
 		 * The thermal instances for current thermal zone has been
 		 * removed. Update the cooling device in case it is activated
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 13c6aaed18df..481417d3b9b7 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -207,41 +207,6 @@ struct thermal_governor {
 	struct list_head	governor_list;
 };
 
-/* Structure that holds binding parameters for a zone */
-struct thermal_bind_params {
-	struct thermal_cooling_device *cdev;
-
-	/*
-	 * This is a measure of 'how effectively these devices can
-	 * cool 'this' thermal zone. It shall be determined by
-	 * platform characterization. This value is relative to the
-	 * rest of the weights so a cooling device whose weight is
-	 * double that of another cooling device is twice as
-	 * effective. See Documentation/driver-api/thermal/sysfs-api.rst for more
-	 * information.
-	 */
-	int weight;
-
-	/*
-	 * This is a bit mask that gives the binding relation between this
-	 * thermal zone and cdev, for a particular trip point.
-	 * See Documentation/driver-api/thermal/sysfs-api.rst for more information.
-	 */
-	int trip_mask;
-
-	/*
-	 * This is an array of cooling state limits. Must have exactly
-	 * 2 * thermal_zone.number_of_trip_points. It is an array consisting
-	 * of tuples <lower-state upper-state> of state limits. Each trip
-	 * will be associated with one state limit tuple when binding.
-	 * A NULL pointer means <THERMAL_NO_LIMITS THERMAL_NO_LIMITS>
-	 * on all trips.
-	 */
-	unsigned long *binding_limits;
-	int (*match) (struct thermal_zone_device *tz,
-			struct thermal_cooling_device *cdev);
-};
-
 /* Structure to define Thermal Zone parameters */
 struct thermal_zone_params {
 	char governor_name[THERMAL_NAME_LENGTH];
@@ -253,9 +218,6 @@ struct thermal_zone_params {
 	 */
 	bool no_hwmon;
 
-	int num_tbps;	/* Number of tbp entries */
-	struct thermal_bind_params *tbp;
-
 	/*
 	 * Sustainable power (heat) that this thermal zone can dissipate in
 	 * mW
-- 
2.25.1

