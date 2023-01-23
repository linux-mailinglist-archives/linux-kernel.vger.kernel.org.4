Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDCD677FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjAWP2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjAWP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:28:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BB22202A
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:28:21 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m15so9309815wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PODENPNbVWjL8xQyhgyl+t+P0w0tYfl3GahnpsmHGfc=;
        b=rBe6MWIuBU4PCPosy8wmdLnAW+6r7YikSJA5xpfDvJzaopUx7GneUOOzFqT9WpC6Zm
         w6bQKEy7zRI/udwTUnkYPw96lYwXM8Pf67jtjjPSHaMNoboQrVuixb/HaIUgkhL8QFk4
         7ZV4G2vh/5vzA2V6zwW7i/DItMiUA0UTkitFGhS8OxDvjgKob8yyTgPHmy6/WY8bpLuN
         mJzSVPvjqSreJ3jsdELvRgK+jG+6nJ483IsVpGRBUo0fvukuT07KQVenLCJAOuPb2RDk
         adjSfKfbqAYL/frRh3KkHsAkKTDll2XM0Q98sMey6w6wYQWfWtTBOVowWDup4NozKtoA
         1cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PODENPNbVWjL8xQyhgyl+t+P0w0tYfl3GahnpsmHGfc=;
        b=tmrIejEbEhtcTe7CbjZgHnQJkd2lS6dWDEUVSB4/0kLXsUKifbgJvbM8mRjh3r/E45
         T1279CTAELNiuNcsz02x7xgXavZpYH9r0f4mQ/5ZcfZ8XAHiPLRtma1m7oI7nRIXHxTd
         73WZUKId/BChzLeMJ31in9pnsElN9mOzRoIgpfehx92HKwk/UEBZ+LW3MsqKm0Bd+f6i
         QRJ2DU5DFNBVOS9YLvHYDyYLyJgr+XXHqO1XNIvquVvGoqVnzs5MTOrD8cr+qzMrQ7bg
         4F9Nb7kWt0guxQhPpUq+2eeXIlqg6RBAlgIAwnGVQDDHV80XSO0paXXlKjOyY2GzHgCz
         98lQ==
X-Gm-Message-State: AFqh2kqvJWFgiXglACkXXrnbWP3eEe0uahH0cJrWQw0a3HlHSaaD3yU3
        /6XvvH5O1XGuHX4Y1At+TphPsw==
X-Google-Smtp-Source: AMrXdXvGnLNGRLSFXB24uuBDMTzuXupdOxNjf55X9XoW+9vcUkTl81sFYVSEBG8lSDLiEJR7iG3gsg==
X-Received: by 2002:a05:600c:1c01:b0:3c6:e63e:23e9 with SMTP id j1-20020a05600c1c0100b003c6e63e23e9mr24804179wms.24.1674487700334;
        Mon, 23 Jan 2023 07:28:20 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003db1ca20170sm10673096wmi.37.2023.01.23.07.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:28:19 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v2 3/3] thermal/core: Move the thermal trip code to a dedicated file
Date:   Mon, 23 Jan 2023 16:27:56 +0100
Message-Id: <20230123152756.4031574-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal_core.c files contains a lot of functions handling
different thermal components like the governors, the trip points, the
cooling device, the OF cooling device, etc ...

This organization does not help to migrate to a more sane code where
there is a better self-encapsulation as all the components' internals
can be directly accessed from a single file.

For the sake of clarity, let's move the thermal trip points code in a
dedicated thermal_trip.c file and add a function to browse all the
trip points like we do with the thermal zones, the govenors and the
cooling devices.

The same can be done for the cooling devices and the governor code but
that will come later as the current work in the thermal framework is
to fix the trip point handling and use a generic trip point structure.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Makefile          |   4 +-
 drivers/thermal/thermal_core.c    |  87 --------------
 drivers/thermal/thermal_core.h    |   4 +
 drivers/thermal/thermal_helpers.c |  62 ----------
 drivers/thermal/thermal_trip.c    | 182 ++++++++++++++++++++++++++++++
 5 files changed, 188 insertions(+), 151 deletions(-)
 create mode 100644 drivers/thermal/thermal_trip.c

diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..2faf4651f34a 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -4,8 +4,8 @@
 #
 
 obj-$(CONFIG_THERMAL)		+= thermal_sys.o
-thermal_sys-y			+= thermal_core.o thermal_sysfs.o \
-					thermal_helpers.o
+thermal_sys-y			+= thermal_core.o thermal_sysfs.o	
+thermal_sys-y			+= thermal_trip.o thermal_helpers.o
 
 # netlink interface to manage the thermal framework
 thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index fad0c4a07d16..4ee685043a3e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1155,12 +1155,6 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
 		*delay_jiffies = round_jiffies(*delay_jiffies);
 }
 
-int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
-{
-	return tz->num_trips;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
-
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int i, ret = -EINVAL;
@@ -1187,87 +1181,6 @@ int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
-int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			    struct thermal_trip *trip)
-{
-	int ret;
-
-	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
-		return -EINVAL;
-
-	if (tz->trips) {
-		*trip = tz->trips[trip_id];
-		return 0;
-	}
-
-	if (tz->ops->get_trip_hyst) {
-		ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
-		if (ret)
-			return ret;
-	} else {
-		trip->hysteresis = 0;
-	}
-
-	ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
-	if (ret)
-		return ret;
-
-	return tz->ops->get_trip_type(tz, trip_id, &trip->type);
-}
-EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
-
-int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-			  struct thermal_trip *trip)
-{
-	int ret;
-
-	mutex_lock(&tz->lock);
-	ret = __thermal_zone_get_trip(tz, trip_id, trip);
-	mutex_unlock(&tz->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
-
-int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
-			  const struct thermal_trip *trip)
-{
-	struct thermal_trip t;
-	int ret;
-
-	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
-		return -EINVAL;
-
-	ret = __thermal_zone_get_trip(tz, trip_id, &t);
-	if (ret)
-		return ret;
-
-	if (t.type != trip->type)
-		return -EINVAL;
-
-	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
-		if (ret)
-			return ret;
-	}
-
-	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
-		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
-		if (ret)
-			return ret;
-	}
-
-	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
-		tz->trips[trip_id] = *trip;
-
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
-				      trip->temperature, trip->hysteresis);
-
-	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
-	
-	return 0;
-}
-
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 26350206a98d..7af54382e915 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -52,6 +52,10 @@ int for_each_thermal_cooling_device(int (*cb)(struct thermal_cooling_device *,
 int for_each_thermal_governor(int (*cb)(struct thermal_governor *, void *),
 			      void *thermal_governor);
 
+int __for_each_thermal_trip(struct thermal_zone_device *,
+			    int (*cb)(struct thermal_trip *, void *),
+			    void *);
+
 struct thermal_zone_device *thermal_zone_get_by_id(int id);
 
 struct thermal_attr {
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 8977d5ddc23c..0f648131b0b5 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -146,68 +146,6 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
 
-/**
- * __thermal_zone_set_trips - Computes the next trip points for the driver
- * @tz: a pointer to a thermal zone device structure
- *
- * The function computes the next temperature boundaries by browsing
- * the trip points. The result is the closer low and high trip points
- * to the current temperature. These values are passed to the backend
- * driver to let it set its own notification mechanism (usually an
- * interrupt).
- *
- * This function must be called with tz->lock held. Both tz and tz->ops
- * must be valid pointers.
- *
- * It does not return a value
- */
-void __thermal_zone_set_trips(struct thermal_zone_device *tz)
-{
-	struct thermal_trip trip;
-	int low = -INT_MAX, high = INT_MAX;
-	int i, ret;
-
-	lockdep_assert_held(&tz->lock);
-
-	if (!tz->ops->set_trips)
-		return;
-
-	for (i = 0; i < tz->num_trips; i++) {
-		int trip_low;
-
-		ret = __thermal_zone_get_trip(tz, i , &trip);
-		if (ret)
-			return;
-
-		trip_low = trip.temperature - trip.hysteresis;
-
-		if (trip_low < tz->temperature && trip_low > low)
-			low = trip_low;
-
-		if (trip.temperature > tz->temperature &&
-		    trip.temperature < high)
-			high = trip.temperature;
-	}
-
-	/* No need to change trip points */
-	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
-		return;
-
-	tz->prev_low_trip = low;
-	tz->prev_high_trip = high;
-
-	dev_dbg(&tz->device,
-		"new temperature boundaries: %d < x < %d\n", low, high);
-
-	/*
-	 * Set a temperature window. When this window is left the driver
-	 * must inform the thermal core via thermal_zone_device_update.
-	 */
-	ret = tz->ops->set_trips(tz, low, high);
-	if (ret)
-		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
-}
-
 static void thermal_cdev_set_cur_state(struct thermal_cooling_device *cdev,
 				       int target)
 {
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
new file mode 100644
index 000000000000..5ce71f1cb1ba
--- /dev/null
+++ b/drivers/thermal/thermal_trip.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2008 Intel Corp
+ *  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>
+ *  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
+ *  Copyright 2022 Linaro Limited
+ *
+ * Thermal trips handling
+ */
+#include "thermal_core.h"
+
+int __for_each_thermal_trip(struct thermal_zone_device *tz,
+			    int (*cb)(struct thermal_trip *, void *),
+			    void *data)
+{
+	int i, ret;
+	struct thermal_trip trip;
+
+	lockdep_assert_held(&tz->lock);
+
+	for (i = 0; i < tz->num_trips; i++) {
+
+		ret = __thermal_zone_get_trip(tz, i, &trip);
+		if (ret)
+			return ret;
+		
+		ret = cb(&trip, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
+{
+	return tz->num_trips;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
+
+/**
+ * __thermal_zone_set_trips - Computes the next trip points for the driver
+ * @tz: a pointer to a thermal zone device structure
+ *
+ * The function computes the next temperature boundaries by browsing
+ * the trip points. The result is the closer low and high trip points
+ * to the current temperature. These values are passed to the backend
+ * driver to let it set its own notification mechanism (usually an
+ * interrupt).
+ *
+ * This function must be called with tz->lock held. Both tz and tz->ops
+ * must be valid pointers.
+ *
+ * It does not return a value
+ */
+void __thermal_zone_set_trips(struct thermal_zone_device *tz)
+{
+	struct thermal_trip trip;
+	int low = -INT_MAX, high = INT_MAX;
+	int i, ret;
+
+	lockdep_assert_held(&tz->lock);
+
+	if (!tz->ops->set_trips)
+		return;
+
+	for (i = 0; i < tz->num_trips; i++) {
+		int trip_low;
+
+		ret = __thermal_zone_get_trip(tz, i , &trip);
+		if (ret)
+			return;
+
+		trip_low = trip.temperature - trip.hysteresis;
+
+		if (trip_low < tz->temperature && trip_low > low)
+			low = trip_low;
+
+		if (trip.temperature > tz->temperature &&
+		    trip.temperature < high)
+			high = trip.temperature;
+	}
+
+	/* No need to change trip points */
+	if (tz->prev_low_trip == low && tz->prev_high_trip == high)
+		return;
+
+	tz->prev_low_trip = low;
+	tz->prev_high_trip = high;
+
+	dev_dbg(&tz->device,
+		"new temperature boundaries: %d < x < %d\n", low, high);
+
+	/*
+	 * Set a temperature window. When this window is left the driver
+	 * must inform the thermal core via thermal_zone_device_update.
+	 */
+	ret = tz->ops->set_trips(tz, low, high);
+	if (ret)
+		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
+}
+
+int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
+			    struct thermal_trip *trip)
+{
+	int ret;
+
+	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
+		return -EINVAL;
+
+	if (tz->trips) {
+		*trip = tz->trips[trip_id];
+		return 0;
+	}
+
+	if (tz->ops->get_trip_hyst) {
+		ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
+		if (ret)
+			return ret;
+	} else {
+		trip->hysteresis = 0;
+	}
+
+	ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
+	if (ret)
+		return ret;
+
+	return tz->ops->get_trip_type(tz, trip_id, &trip->type);
+}
+EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
+
+int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
+			  struct thermal_trip *trip)
+{
+	int ret;
+
+	mutex_lock(&tz->lock);
+	ret = __thermal_zone_get_trip(tz, trip_id, trip);
+	mutex_unlock(&tz->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
+
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip)
+{
+	struct thermal_trip t;
+	int ret;
+
+	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
+		return -EINVAL;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	if (ret)
+		return ret;
+
+	if (t.type != trip->type)
+		return -EINVAL;
+
+	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			return ret;
+	}
+
+	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			return ret;
+	}
+
+	if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
+		tz->trips[trip_id] = *trip;
+
+	thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
+				      trip->temperature, trip->hysteresis);
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	
+	return 0;
+}
-- 
2.34.1

