Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27D64A906
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 21:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiLLU7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 15:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiLLU7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 15:59:01 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FB0186C0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id h8-20020a1c2108000000b003d1efd60b65so6363204wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 12:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t99/SFsMNtmGyI4mz9oW4N/Vb5nTNk7UReahhubAWF8=;
        b=I62rggSuemD4KBJ5cvSZyXPrnGSF/yT3ZcV94K/7IOcSoTjOsuhDNJ616NGUVnajQ1
         kve81y916WokLOh+sCLiWK+SiFGORsF83VPdy+9p1bmkld+c09ANTJ6sBw7FD3bkscCz
         /iZdic03G2hiH6TweggGJWfeexk+AWvnMH2IySUeYt4AdNG9gsFFbBEQgo6lMJ2h/w5C
         xj5YTc4UCeJZFwqtzTXxZkHv6+zNiv8K+TTWfBHDTnXZEebQ3uPlb8w0NmX24zoMSyjU
         73k7fP8yyYBq+tAQJMyF5SedcJkXII9ARE50B1hh4B6tGdIDOsvxlHnxevTJaW8FtcUq
         CaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t99/SFsMNtmGyI4mz9oW4N/Vb5nTNk7UReahhubAWF8=;
        b=JTat0R3treH/TFqs51+gwZRUsLckOuUL1aIDgYMOO/VCfL4wk7LI7Lm0HUpnsm0vxJ
         8CiLcssirhNQf51oOKqis/qR6dPRAeGHAYMhOZHW5f0AU+/NkWFCmhRKp12UL3M9gu3B
         8CczeWXIQFvHuTTRTNgIJuSMD3GtmZfusWn2ixFAxT1Y7jjlz9YnhJ4VGDVv/S4wWm1W
         V93H0H6suClDK2INZ1a8gOlv4IAXzLVfujqPk+ibX3u+L/kZCVCw/UVNAIMIAyqQBqMM
         UCk0VH3O2HkPxfNyCeXju04XzeLFudcy7Pl7FpBdKlzJtAisT/Im+x4tARtdnAUtOurc
         HRmw==
X-Gm-Message-State: ANoB5plsnswX2hQicG4h5a4JBpNLPO9hQh1wh9tqSYtqzpNJkPwSLApp
        mztosWnUnq6C2jqbosIH6+2uig==
X-Google-Smtp-Source: AA0mqf4mWPGMOANgJMv+aAiyaKdO+h48WiDvKrWNIQgl0yFdbapiYOOfOY92WFHsq9Y1ir7YE/7n/Q==
X-Received: by 2002:a7b:cd8f:0:b0:3d1:baf7:ceae with SMTP id y15-20020a7bcd8f000000b003d1baf7ceaemr13759660wmj.39.1670878738656;
        Mon, 12 Dec 2022 12:58:58 -0800 (PST)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id t123-20020a1c4681000000b003a3170a7af9sm10537201wma.4.2022.12.12.12.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 12:58:58 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
X-Google-Original-From: Daniel Lezcano <daniel.lezcano@kernel.org>
To:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] thermal/acpi: Add ACPI trip point routines
Date:   Mon, 12 Dec 2022 21:58:39 +0100
Message-Id: <20221212205843.3119407-2-daniel.lezcano@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
References: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
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

From: Daniel Lezcano <daniel.lezcano@linaro.org>

The ACPI specification describes the trip points, the device tree
bindings as well.

The OF code uses the generic trip point structures.

The ACPI has their own trip points structure and uses the get_trip_*
ops to retrieve them.

We can do the same as the OF code and create a set of ACPI functions
to retrieve a trip point desciption. Having a common code for ACPI
will help to cleanup the remaining Intel drivers and get rid of the
get_trip_* functions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
---
 drivers/thermal/Kconfig        |  13 ++
 drivers/thermal/Makefile       |   1 +
 drivers/thermal/thermal_acpi.c | 249 +++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  15 ++
 4 files changed, 278 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index e052dae614eb..e57011be7009 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -76,6 +76,19 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
+config THERMAL_ACPI
+	bool
+	prompt "APIs to parse thermal data out of the ACPI tables"
+	depends on ACPI
+	default y
+	help
+	  This options provides helpers to add the support to
+	  read and parse thermal data definitions out of the
+	  ACPI tables blob.
+
+	  Say 'Y' here if you need to build thermal infrastructure
+	  based on ACPI.
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
index 000000000000..7dfff3001c1c
--- /dev/null
+++ b/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,249 @@
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
+int thermal_acpi_trip_gtsh(struct acpi_device *adev)
+{
+	unsigned long long hyst;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	return (int)(hyst * 100);
+}
+
+int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _TMP (Temperature): This control method returns the thermal zone’s
+	 * current operating temperature. The return value is the current
+	 * temperature of the thermal zone in tenths of degrees Kelvin
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TMP", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temperature = deci_kelvin_to_millicelsius(temp);
+	
+	return 0;
+}
+
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _CRT (Critical temperature): This object, when defined under a thermal
+	 * zone, returns the critical temperature at which OSPM must shutdown
+	 * the system. If this object it present under a device, the device’s
+	 * driver evaluates this object to determine the device’s critical cooling
+	 * temperature trip point. This value may then be used by the device’s
+	 * driver to program an internal device temperature sensor trip point
+         */
+	status = acpi_evaluate_integer(adev->handle, "_CRT", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_CRITICAL;
+
+	return 0;
+}
+
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _HOT (Hot Temperature): This optional object, when defined under a
+	 * thermal zone, returns the critical temperature at which OSPM may
+	 * choose to transition the system into the S4 sleeping state. The
+	 * platform vendor should define _HOT to be far enough below _CRT so as
+	 * to allow OSPM enough time to transition the system into the S4
+	 * sleeping state. While dependent on the amount of installed memory,
+	 * on typical platforms OSPM implementations can transition the system
+	 * into the S4 sleeping state in tens of seconds. If this object it 
+	 * present under a device, the device’s driver evaluates this object to
+	 * determine the device’s hot cooling temperature trip point. This value
+	 * may then be used by the device’s driver to program an internal device
+	 * temperature sensor trip point.
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_HOT", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_HOT;
+
+	return 0;
+}
+
+int thermal_acpi_trip_psl(struct acpi_device *adev, struct acpi_handle_list *devices)
+{
+	acpi_status status;
+
+	/*
+	 * _PSL (Passive List): This object is defined under a thermal zone and
+	 *  evaluates to a list of processor objects to be used for passive cooling
+	 */
+	status = acpi_evaluate_reference(adev->handle, "_PSL", NULL, devices);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+int thermal_acpi_trip_psv_tsp(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tsp;
+	
+	/*
+	 * _TSP (Thermal Sampling Period): This object evaluates to a thermal
+	 * sampling period (in tenths of seconds) used by OSPM to implement the
+	 * Passive cooling equation. This value, along with _TC1 and _TC2, will
+	 * enable OSPM to provide the proper hysteresis required by the system
+	 * to accomplish an effective passive cooling policy.
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TSP", NULL, &tsp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return (int)tsp;
+}
+
+int thermal_acpi_trip_psv_tc1(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tc1;
+
+	/*
+	 * _TC1 (Thermal Constant 1): This object evaluates to the constant _TC1
+	 * for use in the Passive cooling formula
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TC1", NULL, &tc1);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return (int)tc1;
+}
+
+int thermal_acpi_trip_psv_tc2(struct acpi_device *adev)
+{
+	acpi_status status;
+	unsigned long long tc2;
+	
+	/*
+	 * _TC2 (Thermal Constant 1): This object evaluates to the constant _TC2
+	 * for use in the Passive cooling formula
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_TC2", NULL, &tc2);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return (int)tc2;
+}
+
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	/*
+	 * _PSV (Passive): This optional object, if present under a thermal zone,
+	 * evaluates to the temperature at which OSPM must activate passive
+	 * cooling policy
+	 */
+	status = acpi_evaluate_integer(adev->handle, "_PSV", NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	/*
+	 * The _PSL, _TSP, _TC1 and _TC2 are required if the _PSV object exists.
+	 * We assume the caller will raise an error if it was able to get the _PSV
+	 * but then fail to get the other objects.
+	 */
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+
+int thermal_acpi_trip_acl(struct acpi_device *adev,
+			  struct acpi_handle_list *devices, int id)
+{
+	acpi_status status;
+	char name[5];	
+
+	/*
+	 * _ALx: This object is defined under a thermal zone and evaluates to a
+	 * list of Active cooling devices to be turned on when the corresponding
+	 * _ACx temperature threshold is exceeded. For example, these devices
+	 * could be fans.
+	 */
+	sprintf(name, "_AL%d", id);
+
+	status = acpi_evaluate_reference(adev->handle, name, NULL, devices);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return 0;
+}
+
+int thermal_acpi_trip_act(struct acpi_device *adev,
+			  struct thermal_trip *trip, int id)
+{
+	acpi_status status;
+	unsigned long long temp;
+	char name[5];	
+
+	/*
+	 * _ACx: This optional object, if present under a thermal zone, returns
+	 * the temperature trip point at which OSPM must start or stop active
+	 * cooling, where x is a value between 0 and 9 that designates multiple
+	 * active cooling levels of the thermal zone. If the Active cooling
+	 * device has one cooling level (that is, “on”) then that cooling level
+	 * must be defined as _AC0. If the cooling device has two levels of
+	 * capability, such as a high fan speed and a low fan speed, then they
+	 * must be defined as _AC0 and _AC1 respectively. The smaller the value
+	 * of x, the greater the cooling strength _ACx represents. In the above
+	 * example, _AC0 represents the greater level of cooling (the faster fan
+	 * speed) and _AC1 represents the lesser level of cooling (the slower
+	 * fan speed). For every _ACx method, there must be a matching _ALx
+	 * object or a corresponding entry in an _ART object’s active cooling
+	 * relationship list.
+	 */
+	sprintf(name, "_AC%d", id);
+
+	status = acpi_evaluate_integer(adev->handle, name, NULL, &temp);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	trip->hysteresis = thermal_acpi_trip_gtsh(adev);
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->type = THERMAL_TRIP_ACTIVE;
+
+	return 0;
+}
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e2797f314d99..b8b9d9eddb3a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -334,6 +334,21 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_ACPI
+struct acpi_handle_list;
+int thermal_acpi_get_temp(struct acpi_device *adev, int *temperature);
+int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_act(struct acpi_device *adev, struct thermal_trip *trip, int id);
+int thermal_acpi_trip_acl(struct acpi_device *adev, struct acpi_handle_list *devices, int id);
+int thermal_acpi_trip_psv_psl(struct acpi_device *adev, struct acpi_handle_list *devices);
+int thermal_acpi_trip_psv_tsp(struct acpi_device *adev);
+int thermal_acpi_trip_psv_tc1(struct acpi_device *adev);
+int thermal_acpi_trip_psv_tc2(struct acpi_device *adev);
+int thermal_acpi_trip_gtsh(struct acpi_device *adev);
+#endif
+
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
-- 
2.34.1

