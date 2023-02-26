Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA86A3506
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjBZWz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBZWzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:42 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB7F1A485
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l25so4426289wrb.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXmjkOh9eXvrRm2J04oJvypw5mYaRO/S2JmWwbjlE4k=;
        b=Ulq4K5wYfUCqgbuDpFdoU/FOsRM5gdvtGGJkxmOE5wTgsg8FIIYuLq5AnAAeMVFuX1
         LuOO09UYlRBUpR9mb09CAXegY4XZVnLCEy6RM6jyf7fWlzG+Kpg3svI+D8616y86Pr0F
         sxLGOI83muyWQyyhbDjOZeKdZj1XUykI3vRTYNWyfd3Xkdunxi96Zfb1Zew/OnNkIcG9
         617PBpyvxp/npDLo+QPrUpDIwqYgJl4vPYKpkjLL7uxXa1lk950fT9tkG6kIeOaDvC3x
         uIgyvdHhCUzuCQnhd8yWU6ttAi/z56grDblwBPnCwVgPK3xZj6gF3wqDme7D0C97Bkne
         15qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXmjkOh9eXvrRm2J04oJvypw5mYaRO/S2JmWwbjlE4k=;
        b=c1xTr1G7UyBJI8VKGv03F49r0FNXlJYumixWrUKaqBc7d5om3gmUWJPeKeSE00UuOo
         OIUIPvs/j/YrSxap/iySnCA7rq/LDzmF63tLqJ7xf69BHBmVmL/sNhANQ4ZnZuRqleiM
         9XyUEH34Hy1cTqFd8unUKgp/DVvS1t86pIYdTaSxHf6TPw7P1qAadqMIHClwUBJLfqHi
         SLvHLG/N4Z//vt4P1qiMuGAkMFYqaaZnDXmff/5YRxAlpzJ0eB8LMJ7d02Ww3ZAcMUgJ
         UuMUgQ1OYwDtRevJPd4gT8eypxnhMnTPmOJwl5ULKjWPFQdBmDQ+VoYAMX1bw9R/C8Ux
         EaKA==
X-Gm-Message-State: AO0yUKVRCUMIG8I5/V2RJ+mbCTKFzk59rFviuxLcPl2Brr9uZPD1uUPB
        GNsFluhlseQknagVBzng9LN11Q==
X-Google-Smtp-Source: AK7set8xFxyrABC0AqAa0V50yAR8C3hGuB3+h4x/RKhpauXdENa+qLIafMuCLLU6M15u8Xwy0zf5hg==
X-Received: by 2002:a05:6000:1801:b0:2c7:7701:2578 with SMTP id m1-20020a056000180100b002c777012578mr7274267wrh.54.1677452110349;
        Sun, 26 Feb 2023 14:55:10 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:09 -0800 (PST)
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
Subject: [PATCH v3 12/20] thermal: Add a thermal zone id accessor
Date:   Sun, 26 Feb 2023 23:53:58 +0100
Message-Id: <20230226225406.979703-13-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226225406.979703-1-daniel.lezcano@linaro.org>
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
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

