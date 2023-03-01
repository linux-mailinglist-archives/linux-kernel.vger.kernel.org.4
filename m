Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED6D6A750C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjCAUQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCAUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:17 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B17548E30
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:15:43 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso257267wmp.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677701742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXmjkOh9eXvrRm2J04oJvypw5mYaRO/S2JmWwbjlE4k=;
        b=KJoDrEWTmy/NGzToMLWxtKnUldmaeCsojugTM6oVamuY0Dfznyw2ev6/AtrLpBpX78
         FJBcL9HwqclegUuN0SGxvJMQA8Z8RFoWrdgIM4MbXyL2O/gJ+FVc6JIHoHmt0aOa6KV+
         UQV+RSa5racDGMUvTs4/a2UEFXYl60HUx3walKVwiO8Kff5EgqZg+zCug9lnP7oOJxan
         g5xF6BWrDb9pGfa8lMKXajNIArv2DqL3zJ6do1C/x/vVqPNlvqmtVBEZzd1TNz7aKhfs
         OrjJFvnpNw3AG/tq6HzOCeCtbpD67dvYQE4wAkaUqep7wlYjP6vdY1zJOH0FhFkGzLk/
         fB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677701742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXmjkOh9eXvrRm2J04oJvypw5mYaRO/S2JmWwbjlE4k=;
        b=fGwgxKniR8v+BSJyTnVeVOjfpM9O9mxLIWgjtEBvk4CfiTcjy5K7K6SoY5fQaSLYOP
         NdvKByv4BXNmq9jWV0s5yh4gaV8I4FoIdD7FFM4fYTlLa7hcYHZuvvaikc/CC9kZxESS
         GWETBcK87KBah/gQ9xcthj9iOoEkXsP1L4tQUoB/5jjTYfDnMcG8IDOqLYoo5TMaciDk
         sAZJw7xAHY1YYYvu/+k6Em55GvqmpN9+4giSDXAi0V78R7LP6n4URpDllm1h/mG9B1A4
         BHRYde4z1+eYYbUZJzjRuR4PhdySS70z+CYZPxhWjEYmf3aJWj9JK5zmdEKyzmP+USYQ
         zkaw==
X-Gm-Message-State: AO0yUKXkb2g0MJItfMNALCqr/sqcQXYMdOY4G6JsKL2obqNQel5Ul7Mr
        WnzKhJReBFjtzFnwOMXM1Wxj2w==
X-Google-Smtp-Source: AK7set9Y+lo4lJMEQqXLfkt4NEKJYCYGDNJF8VXOADThZ4VevLaauLXcV1uozTeVimMNJB0O4WzttQ==
X-Received: by 2002:a05:600c:310b:b0:3eb:323e:de79 with SMTP id g11-20020a05600c310b00b003eb323ede79mr5805046wmo.6.1677701741785;
        Wed, 01 Mar 2023 12:15:41 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6ffe:ce4f:bd31:1e6d])
        by smtp.gmail.com with ESMTPSA id x16-20020a1c7c10000000b003e70a7c1b73sm576546wmc.16.2023.03.01.12.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 12:15:41 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI THERMAL DRIVER),
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING)
Subject: [PATCH v5 12/18] thermal: Add a thermal zone id accessor
Date:   Wed,  1 Mar 2023 21:14:40 +0100
Message-Id: <20230301201446.3713334-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the thermal zone id but without directly accessing the
thermal zone device structure, add an accessor.

Use the accessor in the hwmon_scmi and acpi_thermal.

No functional change intented.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c         | 2 +-
 drivers/hwmon/scmi-hwmon.c     | 2 +-
 drivers/thermal/thermal_core.c | 6 ++++++
 include/linux/thermal.h        | 6 ++++++
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 392b73b3e269..255efa73ed70 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -842,7 +842,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 		goto acpi_bus_detach;
 
 	dev_info(&tz->device->dev, "registered as thermal_zone%d\n",
-		 tz->thermal_zone->id);
+		 thermal_zone_device_id(tz->thermal_zone));
 
 	return 0;
 
diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
index 046ac157749d..364199b332c0 100644
--- a/drivers/hwmon/scmi-hwmon.c
+++ b/drivers/hwmon/scmi-hwmon.c
@@ -220,7 +220,7 @@ static int scmi_thermal_sensor_register(struct device *dev,
 			sensor->name);
 	} else {
 		dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
-			sensor->name, tzd->id);
+			sensor->name, thermal_zone_device_id(tzd));
 	}
 
 	return 0;
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 913ba9ca9792..46dedfe061df 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1390,6 +1390,12 @@ const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_type);
 
+int thermal_zone_device_id(struct thermal_zone_device *tzd)
+{
+	return tzd->id;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_id);
+
 /**
  * thermal_zone_device_unregister - removes the registered thermal zone device
  * @tz: the thermal zone device to remove
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 21686e676b3d..eb80cee4f64f 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -367,6 +367,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
+int thermal_zone_device_id(struct thermal_zone_device *tzd);
 
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
 				     struct thermal_cooling_device *,
@@ -449,6 +450,11 @@ static inline const char *thermal_zone_device_type(struct thermal_zone_device *t
 	return NULL;
 }
 
+static inline int thermal_zone_device_id(struct thermal_zone_device *tzd)
+{
+	return -ENODEV;
+}
+
 static inline int thermal_zone_device_enable(struct thermal_zone_device *tz)
 { return -ENODEV; }
 
-- 
2.34.1

