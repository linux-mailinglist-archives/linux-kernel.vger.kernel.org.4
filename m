Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E1676153
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 00:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjATXPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 18:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjATXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 18:15:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6E572B8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:15:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r9so6104315wrw.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmpmbTelOLm3GxZGJKc3RpPo4g2mgSJUW4mMTFcNbb8=;
        b=U/z4QGUZDtiQ8kXnYfkagTBBcN0fw9eIOLR+nRuM9WEZrw5v7ha6npdco/9bTop06c
         UydrAmz3Ikow3YGkW//kOV9sFv1BQpZc2GDvdgPLcG+Ha9qUIvJ+aG6SIFlm20suGpAi
         WB2dhUP8/HBRqkOre6bhZR2tNEjFQhHwqVP9zVzAPinhBIXs8rmnwms7rDJPJiMn4cK7
         7elFOo0Ko6fp1gqKyYhbuyVWBrSqnIQg5OgnKYAZ4S30L7d2/xI3vsFJhYZbxaG0riUs
         cuu1aOg9YMrB6e1iA3asce1pPxfRrWg2qK4VoNlpnlqw6yYIxGdeAHjVwzr10gQVuYFf
         FtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmpmbTelOLm3GxZGJKc3RpPo4g2mgSJUW4mMTFcNbb8=;
        b=PD4tS2ONVC+uK+vdNcUeHdTbx3UNU/fQlZqocvsTmmmnTSIwWJMWNf4ooh4iU53uMh
         hg6E8S1T6dBHqeO6BLJw2b/VuJjqy7Dzq68cxngNDWqlNW1H7Wl4w6f57hP2YZZYgnZp
         2ltf5m4kX+8MqhP3fK278M83SwJqSYStC9dY+XUdccGpTU4m7LnhmSwwLt1GFF+q/X10
         87yEPzPfZuXM+rW+OjYkAoa5lU7oh6po82DYdVr361hnOjKZ6vTVJYCPEjx+8lYK+PH7
         4l46L5XRUeQ9r2xM0HbAoVrFw+nyZdFjy1FOeohRx4oElKVgnur3AGK4ohpUgeS7e9+X
         QzgA==
X-Gm-Message-State: AFqh2koy0Jz29pwnTPQqsB2JnBUwJSQ65djk8kp/o+D7AE79BnR8/nEe
        ORx/YWRhbe2Rr+PXZNotEFw0jw==
X-Google-Smtp-Source: AMrXdXuEaC1/9xNlzYGxPoJX9tujzTdDF++nkLLo8CStyd8MjhEFTzHK64oDhny/U9n1zw9nX+3Esg==
X-Received: by 2002:a5d:6389:0:b0:2bf:95dc:436b with SMTP id p9-20020a5d6389000000b002bf95dc436bmr1549148wru.59.1674256546148;
        Fri, 20 Jan 2023 15:15:46 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600001d100b00241d21d4652sm36436828wrx.21.2023.01.20.15.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 15:15:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, christophe.jaillet@wanadoo.fr,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v6 1/3] thermal/acpi: Add ACPI trip point routines
Date:   Sat, 21 Jan 2023 00:15:28 +0100
Message-Id: <20230120231530.2368330-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
References: <20230120231530.2368330-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The ACPI specification describes the trip points, the device tree
bindings as well.

The OF code uses the generic trip point structures.

The ACPI has their own trip points structure and uses the get_trip_*
ops to retrieve them.

We can do the same as the OF code and create a set of ACPI functions
to retrieve a trip point description. Having a common code for ACPI
will help to cleanup the remaining Intel drivers and get rid of the
get_trip_* functions.

These changes add the ACPI thermal calls to retrieve the basic
information we need to be reused in the thermal ACPI and Intel
drivers.

The different ACPI functions have the generic trip point structure
passed as parameter where it is filled.

This structure aims to be the one used by all the thermal drivers and
the thermal framework.

After this series, a couple of Intel drivers and the ACPI thermal
driver will still have their own trip points definition but a new
series on top of this one will finish the conversion to the generic
trip point handling.

This series depends on the generic trip point added to the thermal
framework and available in the thermal/linux-next branch.

 https://lkml.org/lkml/2022/10/3/456

It has been tested on a Intel i7-8650U - x280 with the INT3400, the
PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
---
 V6:
   - Changed the functions name and prototype to return the temperature
     instead of passing a pointer
   - Removed the GTSH function as it does not belong to the ACPI standard
   - Changed hysteresis -> hyst, temperature -> temp
   - Changed message level info -> debug
   - Changed error messages
   - Return -ENODATA error only
   - Fixed description functions

 V5:
   - Fixed GTSH unit conversion, deciK -> milli C

 V3:
   - Removed too simple wrappers
   - Changed the API to return an error and check the validity of the value
   - Removed the comments describing the objects
   - Added kerneldoc
   - Made the Kconfig option silent
   - Set the hysteresis value to zero by default

 V2:
   - Fixed the missing thermal_acpi.c in the patch

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig        |   4 +
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_acpi.c | 185 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |   7 ++
 4 files changed, 197 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..eaeb2b2ee6e9 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -76,6 +76,10 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_ACPI
+       depends on ACPI
+       bool
+
 config THERMAL_WRITABLE_TRIPS
 	bool "Enable writable trip points"
 	help
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 2506c6c8ca83..60f0dfa9aae2 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+= thermal_netlink.o
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
+thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
new file mode 100644
index 000000000000..c72fca44bc86
--- /dev/null
+++ b/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * ACPI thermal configuration
+ */
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/units.h>
+#include <uapi/linux/thermal.h>
+
+#include "thermal_core.h"
+
+/*
+ * An hysteresis value below zero is invalid and we can consider a
+ * value greater than 20°K/°C is invalid too.
+ */
+#define HYST_MIN_DECIK	0
+#define HYST_MAX_DECIK	200
+
+/*
+ * Minimum temperature for full military grade is 218°K (-55°C) and
+ * max temperature is 448°K (175°C). We can consider those values as
+ * the boundaries for the [trips] temperature returned by the
+ * firmware. Any values out of these boundaries may be considered
+ * bogus and we can assume the firmware has no data to provide.
+ */
+#define TEMP_MIN_DECIK	2180
+#define TEMP_MAX_DECIK	4480
+
+static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, object_name, NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(adev->handle, "Failed to get temperature object '%s'\n", object_name);
+		return -ENODATA;
+	}
+
+	if (temp < TEMP_MIN_DECIK || temp >= TEMP_MAX_DECIK) {
+		acpi_handle_debug(adev->handle, "Invalid value '%llu' returned by '%s'\n", temp, object_name);
+		return -ENODATA;
+	}
+
+	return (int)temp;
+}
+
+/**
+ * thermal_acpi_active_trip_temp() - Get the specified active trip point
+ * @adev: Thermal zone ACPI device object to get the description from
+ * @trip: Trip point structure to be populated on success
+ * @id: Active cooling level (0 - 9)
+ *
+ * Evaluate the _ACx object for the thermal zone represented by @adev
+ * to obtain the temperature of the active cooling trip point
+ * corresponding to the active cooling level given by @id and
+ * initialize @trip as an active trip point using that temperature
+ * value.
+ *
+ * Return: 
+ * * 0 - Success
+ * * -ENODATA - Failed to get the ACPI object, or the value appears to be inconsistent
+ */
+int thermal_acpi_active_trip_temp(struct acpi_device *adev,
+				  struct thermal_trip *trip, int id)
+{
+	char name[] = "_AC0";
+	int temp;
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	name[3] += id;
+	
+	temp = thermal_acpi_get_temp(adev, name);
+	if (temp < 0)
+		return temp;
+
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
+
+/**
+ * thermal_acpi_passive_trip_temp() - Get the passive trip point
+ * @adev: Thermal zone ACPI device object to get the description from
+ * @trip: Trip point structure to be populated on success
+ *
+ * Evaluate the _PSV object for the thermal zone represented by @adev
+ * to obtain the temperature of the passive cooling trip point and
+ * initialize @trip as a passive trip point using that temperature
+ * value.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODATA - Failed to get the ACPI object, or the value appears to be inconsistent
+ */
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int temp;
+
+	temp = thermal_acpi_get_temp(adev, "_PSV");
+	if (temp < 0)
+		return temp;
+
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
+
+/**
+ * thermal_acpi_hot_trip_temp() - Get the near critical trip point
+ * @adev: the ACPI device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ *
+ * Evaluate the _HOT object for the thermal zone represented by @adev
+ * to obtain the temperature of the trip point at which the system is
+ * expected to be put into the S4 sleep state and initialize @trip as
+ * a hot trip point using that temperature value.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODATA - Failed to get the ACPI object, or the value appears to be inconsistent
+ */
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int temp;
+
+	temp = thermal_acpi_get_temp(adev, "_HOT");
+	if (temp < 0)
+		return temp;
+
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_HOT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
+
+/**
+ * thermal_acpi_critical_trip_temp() - Get the critical trip point
+ * @adev: the ACPI device to get the description from
+ * @trip: a &struct thermal_trip to be filled if the function succeed
+ *
+ * Evaluate the _CRT object for the thermal zone represented by @adev
+ * to obtain the temperature of the critical cooling trip point and
+ * initialize @trip as a critical trip point using that temperature
+ * value.
+ *
+ * Return:
+ * * 0 - Success
+ * * -ENODATA - Failed to get the ACPI object, or the value appears to be inconsistent
+ */
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	int temp;
+
+	temp = thermal_acpi_get_temp(adev, "_CRT");
+	if (temp < 0)
+		return temp;
+
+	/*
+	 * The hysteresis value has no sense here because critical
+	 * trip point has no u-turn
+	 */
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->hysteresis = 0;
+	trip->type = THERMAL_TRIP_CRITICAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);
+
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 30353e4b1424..2aee1f0d5fac 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,13 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_THERMAL_ACPI
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, struct thermal_trip *trip, int id);
+#endif
+
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
-- 
2.34.1

