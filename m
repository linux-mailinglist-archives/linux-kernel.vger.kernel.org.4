Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2136E17F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDMXOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDMXOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:14:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510331FFE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:13:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so10694362wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681427616; x=1684019616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF8rvg1z5XANVIBt+ONfTikNhwE8ybaWY9TqUuiseLs=;
        b=h2tPn6d/Yo41LiRgzT5eH3i1q4UiJBoq9n+iQNY+pqcbUwZpAmNN/OBK7vMY0rbegX
         tNlx1GtJjLlJMoT7P3c3VUTOUwgtr58boeVZ/HH8BoRebbQXPPwTEyrjVDRSciPf5728
         EVgtpIPT+mWH26oT844S7KnNgjcbfTPDcLQcDq5w93LrL9OUStGAtWQs2oJyCOlMB1QT
         ohR/zC7TOnL4Zxzxnj1dPzL/8tsQe/sQU/J+YKXPoLa3GYl6fQTSanLVpFCpOpQwe2Kr
         Dem92Jc0cm58+amqk1sxqcUxr7gRpWsJlrtzvtek4GNibndgHfb750sgJO7O+OQ5qEVr
         05Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427616; x=1684019616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZF8rvg1z5XANVIBt+ONfTikNhwE8ybaWY9TqUuiseLs=;
        b=WEGXxlvzKuXghtEmBXQ8jmejytG+FPFHIlCrD/+BwVwZ8TpNOK4cDonI63WdE1EMeJ
         i6O1DKX3314kxzg4NMd61piO83nTIue4wKgTJAl1P+hN6RRJMPmHNDsA/ilXn3OaxTUR
         Zu+vnIqOCfzUu8iTURmqN5KD6Xe3ccWiU4yKV/MBnhnXXdR0O2x8mBZVv1zYcSlbKXGh
         iGj8qyL9iEEcIaxRQboucX3cCUybfvzmILAbr2mbj+Puoq4Lb3gdZLemsh+AhmzmfDBm
         lrTnc0RxGw5JDOuuraaiYh91Xi0Jl35NCo0JLfXW3XolV94U+wne6Mrzv/2RnHoX8/Op
         fJtQ==
X-Gm-Message-State: AAQBX9fsC31L7P6F65LzzdQiUV7X3PLYUpCwF+iO/vxRArSyAfmSwdQU
        Qb5KaGIKulnKRENv6OVw96h03w==
X-Google-Smtp-Source: AKy350bqdhKSwq5RaBwZeO+d7otFOJSHYreipwNsXOnW9lfHqFxRIvkJdNPyxXZQXXmshoGx/VPMtw==
X-Received: by 2002:a7b:c3cc:0:b0:3ef:128d:7167 with SMTP id t12-20020a7bc3cc000000b003ef128d7167mr3057727wmj.13.1681427615924;
        Thu, 13 Apr 2023 16:13:35 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7529:f7da:b8df:f1dd])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c4f8500b003f0ad98522bsm1831588wmq.28.2023.04.13.16.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:13:35 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH] thermal/core: Update the generic trip points
Date:   Fri, 14 Apr 2023 01:13:18 +0200
Message-Id: <20230413231318.143135-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, the generic trip points rework allows to create a
thermal zone with a fixed number of trip points. This usage satisfy
almost all of the existing drivers.

A few remaining drivers have a mechanism where the firmware updates
the trip points. But there is no such update mechanism for the generic
trip points, thus those drivers can not be converted to the generic
approach.

This patch provides a function 'thermal_zone_trips_update()' allowing
to change the trip points of a thermal zone.

At the same time, with the logic the trip points array is passed as a
parameter to the thermal zone at creation time, we make our own
private trip points array by copying the one passed as parameter.

Note, no code has been found where the trip points update leads to a
refresh of the trip points in sysfs, so it is very unlikey the number
of trip points changes. However, for the sake of consistency it would
be nicer to have the trip points being refreshed in sysfs also, but
that could be done in a separate set of changes.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c | 40 ++++++++----------
 drivers/thermal/thermal_core.h |  3 ++
 drivers/thermal/thermal_trip.c | 76 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  4 ++
 4 files changed, 100 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index afcd4197babd..3688b06401c8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1224,32 +1224,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
-	 * For example, shifting by 32 will result in compiler warning:
-	 * warning: right shift count >= width of type [-Wshift-count- overflow]
-	 *
-	 * Also "mask >> num_trips" will always be true with 32 bit shift.
-	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
-	 * mask >> 32 = 0x80000000
-	 * This will result in failure for the below condition.
-	 *
-	 * Check will be true when the bit 31 of the mask is set.
-	 * 32 bit shift will cause overflow of 4 byte integer.
-	 */
-	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
-		pr_err("Incorrect number of thermal trips\n");
-		return ERR_PTR(-EINVAL);
-	}
-
 	if (!ops) {
 		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
-		return ERR_PTR(-EINVAL);
-
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
@@ -1283,8 +1262,22 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	tz->ops = ops;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
-	tz->trips = trips;
-	tz->num_trips = num_trips;
+
+	if (trips) {
+		result = __thermal_zone_trips_update(tz, trips, num_trips, mask);
+		if (result)
+			goto remove_id;
+	} else {
+		/*
+		 * Legacy trip point handling
+		 */
+		if ((!tz->ops->get_trip_type || !tz->ops->get_trip_temp) && num_trips) {
+			result = -EINVAL;
+			goto remove_id;
+		}
+
+		tz->num_trips = num_trips;
+	}
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1451,6 +1444,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	mutex_unlock(&tz->lock);
 
 	kfree(tz->tzp);
+	kfree(tz->trips);
 
 	put_device(&tz->device);
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index d9182fb8dd11..9fc7d9e9debd 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -203,6 +203,9 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
+int __thermal_zone_trips_update(struct thermal_zone_device *tz,
+				struct thermal_trip *trips,
+				int num_trips, int mask);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index a12980a8bac5..e05384c3e557 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -227,3 +227,79 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 
 	return 0;
 }
+
+int __thermal_zone_trips_update(struct thermal_zone_device *tz, struct thermal_trip *trips,
+				int num_trips, int mask)
+{
+	struct thermal_trip *new_trips;
+
+	/*
+	 * Legacy trip point handling is incompatible with this
+	 * function
+	 */
+	if (tz->ops->get_trip_type || tz->ops->get_trip_temp) {
+		pr_err("Legacy trip points use incompatible function '%s'\n", __func__);
+		return -ENOSYS;
+	}
+	
+	/*
+	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
+	 * For example, shifting by 32 will result in compiler warning:
+	 * warning: right shift count >= width of type [-Wshift-count- overflow]
+	 *
+	 * Also "mask >> num_trips" will always be true with 32 bit shift.
+	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
+	 * mask >> 32 = 0x80000000
+	 * This will result in failure for the below condition.
+	 *
+	 * Check will be true when the bit 31 of the mask is set.
+	 * 32 bit shift will cause overflow of 4 byte integer.
+	 */
+	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
+		pr_err("Incorrect number of thermal trips\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * New generic trip point handling
+	 */
+	if (num_trips > 0 && !trips) {
+		pr_err("Inconsistent parameters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate our private trip points array structure
+	 */
+	new_trips = kmemdup(trips, sizeof(*trips) * num_trips, GFP_KERNEL);
+	if (!new_trips)
+		return -ENOMEM;
+	
+	/*
+	 * Newly allocated thermal zone will have the 'trips' field
+	 * NULL, kfree() is immune against that
+	 */
+	kfree(tz->trips);
+	tz->trips = new_trips;
+	tz->num_trips = num_trips;
+
+	return 0;
+}
+
+int thermal_zone_trips_update(struct thermal_zone_device *tz, struct thermal_trip *trips,
+			      int num_trips, int mask)
+{
+	int ret;
+
+	mutex_lock(&tz->lock);
+	ret = __thermal_zone_trips_update(tz, trips, num_trips, mask);
+	mutex_unlock(&tz->lock);
+
+	if (ret)
+		return ret;
+
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_trips_update);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 3e8bedb21755..0ea2da5c33ac 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -216,6 +216,10 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
+int thermal_zone_trips_update(struct thermal_zone_device *tz,
+			      struct thermal_trip *trips,
+			      int num_trips, int mask);
+
 #ifdef CONFIG_THERMAL_ACPI
 int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
 int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
-- 
2.34.1

