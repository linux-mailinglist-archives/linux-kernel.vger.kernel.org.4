Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9932A6772EE
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 23:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjAVWIM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 22 Jan 2023 17:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 17:08:11 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB471CF46;
        Sun, 22 Jan 2023 14:08:08 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id b6253414859502fe; Sun, 22 Jan 2023 23:08:06 +0100
Received: from kreacher.localnet (89-77-51-84.dynamic.chello.pl [89.77.51.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 69B5BCB0590;
        Sun, 22 Jan 2023 23:08:05 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org,
        srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        christophe.jaillet@wanadoo.fr, Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v6 1/3] thermal/acpi: Add ACPI trip point routines
Date:   Sun, 22 Jan 2023 23:08:04 +0100
Message-ID: <5911499.lOV4Wx5bFT@kreacher>
In-Reply-To: <20230120231530.2368330-2-daniel.lezcano@linaro.org>
References: <20230120231530.2368330-1-daniel.lezcano@linaro.org> <20230120231530.2368330-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 89.77.51.84
X-CLIENT-HOSTNAME: 89-77-51-84.dynamic.chello.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgudeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeeivdduteekjedtteeuteefueejfeffuddtjeeuueevuedvgeeihfffieffgfdvkeenucffohhmrghinheplhhkmhhlrdhorhhgnecukfhppeekledrjeejrdehuddrkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeelrdejjedrhedurdekgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepuddtpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidr
 ihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, January 21, 2023 12:15:28 AM CET Daniel Lezcano wrote:
> The ACPI specification describes the trip points, the device tree
> bindings as well.
> 
> The OF code uses the generic trip point structures.
> 
> The ACPI has their own trip points structure and uses the get_trip_*
> ops to retrieve them.
> 
> We can do the same as the OF code and create a set of ACPI functions
> to retrieve a trip point description. Having a common code for ACPI
> will help to cleanup the remaining Intel drivers and get rid of the
> get_trip_* functions.
> 
> These changes add the ACPI thermal calls to retrieve the basic
> information we need to be reused in the thermal ACPI and Intel
> drivers.
> 
> The different ACPI functions have the generic trip point structure
> passed as parameter where it is filled.
> 
> This structure aims to be the one used by all the thermal drivers and
> the thermal framework.
> 
> After this series, a couple of Intel drivers and the ACPI thermal
> driver will still have their own trip points definition but a new
> series on top of this one will finish the conversion to the generic
> trip point handling.
> 
> This series depends on the generic trip point added to the thermal
> framework and available in the thermal/linux-next branch.
> 
>  https://lkml.org/lkml/2022/10/3/456
> 
> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>

Co-developed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Also I'm not sure if this version has been tested and reviewed.

There are still a few things to improve in it, but overall I think that
something like the patch below would be better - it is fewer lines of code
and less duplication.

I haven't compiled it, but it should be easy enough to fix if it fails to
build.  I am also not sure about the included header files (kernel.h and
uapi/linux/thermal.h in particular).

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH] thermal: ACPI: Add ACPI trip point routines

Add library routines to populate a generic thermal trip point
structure with data obtained by evaluating a specific object in the
ACPI Namespace.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig        |    4 +
 drivers/thermal/Makefile       |    1 
 drivers/thermal/thermal_acpi.c |  153 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |    8 ++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/thermal/thermal_acpi.c

Index: linux-pm/drivers/thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
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
Index: linux-pm/drivers/thermal/Makefile
===================================================================
--- linux-pm.orig/drivers/thermal/Makefile
+++ linux-pm/drivers/thermal/Makefile
@@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
+thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
 thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)	+= gov_fair_share.o
Index: linux-pm/drivers/thermal/thermal_acpi.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/thermal/thermal_acpi.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ * Copyright 2023 Intel Corporation
+ *
+ * Library routines for populating a generic thermal trip point structure
+ * with data obtained by evaluating a specific object in the ACPI Namespace.
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
+ * Minimum temperature for full military grade is 218°K (-55°C) and
+ * max temperature is 448°K (175°C). We can consider those values as
+ * the boundaries for the [trips] temperature returned by the
+ * firmware. Any values out of these boundaries may be considered
+ * bogus and we can assume the firmware has no data to provide.
+ */
+#define TEMP_MIN_DECIK	2180
+#define TEMP_MAX_DECIK	4480
+
+static int thermal_acpi_trip_init(struct acpi_device *adev,
+				  enum thermal_trip_type type, int id,
+				  struct thermal_trip *trip)
+{
+	unsigned long long temp;
+	acpi_status status;
+	char obj_name[5];
+
+	switch (type) {
+	case THERMAL_TRIP_ACTIVE:
+		if (id < 0 || id > 9)
+			return -EINVAL;
+
+		obj_name[1] = 'A';
+		obj_name[2] = 'C';
+		obj_name[3] = '0' + id;
+		break;
+	case THERMAL_TRIP_PASSIVE:
+		obj_name[1] = 'P';
+		obj_name[2] = 'S';
+		obj_name[3] = 'V';
+		break;
+	case THERMAL_TRIP_HOT:
+		obj_name[1] = 'H';
+		obj_name[2] = 'O';
+		obj_name[3] = 'T';
+		break;
+	case THERMAL_TRIP_CRITICAL:
+		obj_name[1] = 'C';
+		obj_name[2] = 'R';
+		obj_name[3] = 'T';
+		break;
+	}
+
+	obj_name[0] = '_';
+	obj_name[4] = '\0';
+
+	status = acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(adev->handle, "%s evaluation failed\n", obj_name);
+		return -ENODATA;
+	}
+
+	if (temp < TEMP_MIN_DECIK || temp >= TEMP_MAX_DECIK) {
+		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
+				  temp, obj_name);
+		return -ENODATA;
+	}
+
+	trip->temperature = deci_kelvin_to_millicelsius(temp);
+	trip->hysteresis = 0;
+	trip->type = type;
+
+	return 0;
+}
+
+/**
+ * thermal_acpi_trip_active - Get the specified active trip point
+ * @adev: Thermal zone ACPI device object to get the description from.
+ * @id: Active cooling level (0 - 9).
+ * @trip: Trip point structure to be populated on success.
+ *
+ * Evaluate the _ACx object for the thermal zone represented by @adev to obtain
+ * the temperature of the active cooling trip point corresponding to the active
+ * cooling level given by @id and initialize @trip as an active trip point using
+ * that temperature value.
+ *
+ * Return 0 on success or a negative error value on failure.
+ */
+int thermal_acpi_trip_active(struct acpi_device *adev, int id,
+			     struct thermal_trip *trip)
+{
+	return thermal_acpi_trip_init(adev, THERMAL_TRIP_ACTIVE, id, trip);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_active);
+
+/**
+ * thermal_acpi_trip_passive - Get the passive trip point
+ * @adev: Thermal zone ACPI device object to get the description from.
+ * @trip: Trip point structure to be populated on success.
+ *
+ * Evaluate the _PSV object for the thermal zone represented by @adev to obtain
+ * the temperature of the passive cooling trip point and initialize @trip as a
+ * passive trip point using that temperature value.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_trip_passive(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	return thermal_acpi_trip_init(adev, THERMAL_TRIP_PASSIVE, INT_MAX, trip);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_passive);
+
+/**
+ * thermal_acpi_trip_hot - Get the near critical trip point
+ * @adev: the ACPI device to get the description from.
+ * @trip: a &struct thermal_trip to be filled if the function succeed.
+ *
+ * Evaluate the _HOT object for the thermal zone represented by @adev to obtain
+ * the temperature of the trip point at which the system is expected to be put
+ * into the S4 sleep state and initialize @trip as a hot trip point using that
+ * temperature value.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	return thermal_acpi_trip_init(adev, THERMAL_TRIP_HOT, INT_MAX, trip);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_hot);
+
+/**
+ * thermal_acpi_trip_critical - Get the critical trip point
+ * @adev: the ACPI device to get the description from.
+ * @trip: a &struct thermal_trip to be filled if the function succeed.
+ *
+ * Evaluate the _CRT object for the thermal zone represented by @adev to obtain
+ * the temperature of the critical cooling trip point and initialize @trip as a
+ * critical trip point using that temperature value.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_trip_critical(struct acpi_device *adev, struct thermal_trip *trip)
+{
+	return thermal_acpi_trip_init(adev, THERMAL_TRIP_CRITICAL, INT_MAX, trip);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_trip_critical);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -334,6 +334,14 @@ static inline void devm_thermal_of_zone_
 }
 #endif
 
+#ifdef CONFIG_THERMAL_ACPI
+int thermal_acpi_trip_active(struct acpi_device *adev, int id,
+			     struct thermal_trip *trip);
+int thermal_acpi_trip_passive(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
+int thermal_acpi_trip_critical(struct acpi_device *adev, struct thermal_trip *trip);
+#endif
+
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
 		void *, struct thermal_zone_device_ops *,



