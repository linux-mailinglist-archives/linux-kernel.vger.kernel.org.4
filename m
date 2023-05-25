Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43A710DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241513AbjEYOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241492AbjEYOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F8A1BD
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-309553c5417so2116872f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023324; x=1687615324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7GrEPFhayNtImibH8MsMjS6Dma/89gLhxwpMIW9yxY=;
        b=RpvIHYxC1L44ES6U7GEAWLQGswS5iAFE0DExP5zmyuhCwp7enuXc3eZ7jBk7SR+zHy
         L9vLWMb4rDhnPg2g1VoGUgfGv6uDlrEjB9T77/gkUMJk0570P5oaBsrexSVDVmBatg1A
         BsbgJxWYkogcPg4g7RiuDdlNkiWARFam2jLJJzSM+LLTPNSuPspqetAZC0qlLq9+olwB
         Ycen8vukVwyZsSMDPhZ1TY0Fgv8hFTCyZ8Ai/+93q1IBYLWaNlFUKD9vonAR85ypcRC8
         wVGb5MHogYaxZxR41PPplCGVsUrD6hnAYp11/RvhLOpWV2lQIMfWKwb3A7VAlWynMr5p
         zSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023324; x=1687615324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7GrEPFhayNtImibH8MsMjS6Dma/89gLhxwpMIW9yxY=;
        b=XPf5fLmx4DxJeDbEUzZBlUFdRFUKfO3fOBEEHPwvBF+/Iz8xjyyIiYDQjMzENXCca+
         msiI0F0wxjLQKdxrI9aE5X9LK1B/mnWR2p87fWtq6y7VeUMwtWEGQlOmU24SW9WyPMwV
         zUF5heJNUgSZQOOwJpTXn7YYt7o4L3+qNwKi8o29NO7ztL5K2SqPwd7M1sgcRDBDUEHZ
         +BvNAeYiO7UJfPT3BPowNLx3a82A/dBhYHQ5ZIuLZrI3/jJcrHg7lBiYfIBNRlKX/0Gc
         Y+e0aYYhQafSdmW0SqjnE8+/7/KmdfdxEM8XmdNSyQhysi+cQ3nBeN89TVj6+gEeoCjE
         Ay4g==
X-Gm-Message-State: AC+VfDxylle+rz9Jpwy77qjreSOnRo1b57J5Y+fNSJPQQhNW+9pSDhnQ
        uy82vdwnRCzRqVV16NwlDqFeXA==
X-Google-Smtp-Source: ACHHUZ5ji2kITZJRetE5AnyLqm88KcN37w8yCMnnvtqmdUj9ATobOayhpip9OOZqEWhQTZZlK7zm2A==
X-Received: by 2002:a5d:5248:0:b0:307:873d:2ea with SMTP id k8-20020a5d5248000000b00307873d02eamr2413486wrc.47.1685023324377;
        Thu, 25 May 2023 07:02:04 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:03 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/8] thermal/core: Update the generic trip points
Date:   Thu, 25 May 2023 16:01:31 +0200
Message-Id: <20230525140135.3589917-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/thermal/thermal_core.c | 40 ++++++++---------
 drivers/thermal/thermal_core.h |  3 ++
 drivers/thermal/thermal_trip.c | 78 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  4 ++
 4 files changed, 102 insertions(+), 23 deletions(-)

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
index 84ada34ff079..c27a9930f904 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -125,6 +125,9 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
+int __thermal_zone_trips_update(struct thermal_zone_device *tz,
+				struct thermal_trip *trips,
+				int num_trips, int mask);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index 61d927c35776..171b1902c01c 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -7,6 +7,8 @@
  *
  * Thermal trips handling
  */
+#include <linux/slab.h>
+
 #define THERMAL_CORE_SUBSYS
 #include "thermal_core.h"
 
@@ -181,3 +183,79 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
 
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
index 87837094d549..83937256a01c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -291,6 +291,10 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
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

