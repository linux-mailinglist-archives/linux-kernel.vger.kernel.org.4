Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8074C678523
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjAWSl6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Jan 2023 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjAWSlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:41:53 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086402B2B6;
        Mon, 23 Jan 2023 10:41:43 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 6c042b4eb57effe4; Mon, 23 Jan 2023 19:41:42 +0100
Received: from kreacher.localnet (unknown [213.134.188.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 96BFE213259F;
        Mon, 23 Jan 2023 19:41:41 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v7 1/3] thermal: ACPI: Add ACPI trip point routines
Date:   Mon, 23 Jan 2023 19:38:31 +0100
Message-ID: <4473674.LvFx2qVVIh@kreacher>
In-Reply-To: <5916342.lOV4Wx5bFT@kreacher>
References: <5916342.lOV4Wx5bFT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.188.170
X-CLIENT-HOSTNAME: 213.134.188.170
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddukedguddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthhqredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedtvdefgeelvdefvdevveehvdetfeefhedvueeiudekieeltdetgfdviefhgfetteenucfkphepvddufedrudefgedrudekkedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrddukeekrddujedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghr
 rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add library routines to populate a generic thermal trip point
structure with data obtained by evaluating a specific object in the
ACPI Namespace.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig        |    4 +
 drivers/thermal/Makefile       |    1 
 drivers/thermal/thermal_acpi.c |  150 +++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |    8 ++
 4 files changed, 163 insertions(+)
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
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ * Copyright 2023 Intel Corporation
+ *
+ * Library routines for populating a generic thermal trip point structure
+ * with data obtained by evaluating a specific object in the ACPI Namespace.
+ */
+#include <linux/acpi.h>
+#include <linux/units.h>
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
+				  obj_name, temp);
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
@@ -346,6 +346,14 @@ int thermal_zone_get_num_trips(struct th
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
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



