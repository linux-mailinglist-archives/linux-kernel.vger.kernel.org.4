Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8326245A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiKJPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiKJPZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:25:21 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096883E086;
        Thu, 10 Nov 2022 07:25:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id n205so2162506oib.1;
        Thu, 10 Nov 2022 07:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wERUdQdjWjh/WLWGcq6kXq7Y3fhhIRGrVPA3P4TVF/k=;
        b=XlcvyvGdDoL7j/ld25ik8DutzpkV/ZhQe5SsKtayc7k0cH7McLdnpH7Rz7pb4os8oD
         niAH3q9Vj29F3ImpOFH0sGgKWEE6/eIMu/okSj7HeY/3uoELTaanIlljr4Y5Eb/ct+29
         yxxawZ7k9JCQvLD/X5LwkUsnrCt2xe0upzKAanbY3wUSqUyjcGc5VrMG80MiakGCxuro
         8KVizuzoKSFN60Zns+Hp72DXGX0hS92YVnuhy6geIC/VupZQrDEZzW5a5k4ZnqoNaQs3
         Q7hRrMtHLE3bz23jU24DnuURApm+NpuOA39YAji3BEj8bOsNR4SMWToYqk9fo4dKldjF
         Q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wERUdQdjWjh/WLWGcq6kXq7Y3fhhIRGrVPA3P4TVF/k=;
        b=dqVwZfHa/TptIOLp20WGPc1/aRpAJ17eb8ro9KE1cLNpk9B0HR8u0VMfLflj7wkO4X
         W5RDmV+J+vw75cELf4FqaPxU7vB4BElsxyW/ypzxOqbmw51T4x1VKVeLti0pODCGFit2
         ixkiPdNL/l2GjWKDSuaL8TTaLSx7OEsB0a9Ronn+/GWFtHSAqQ986Eo/nTXAizgOK5di
         bym9RUsDRvJGfM4sL3R5/FPzuvFUkd736xTAkm77Sz6thSXEIUm4rdeC5IHGnaphkoPP
         s4r4CkKHxVijVv8LBgcimqSUO6jWLqYcoVVqommLutSlvN4TruZHl0kAf6YxAn8xzJ9z
         hA8g==
X-Gm-Message-State: ACrzQf3MqNMNUitJaovDRcnsKQa81HgETDfsAJSdzxr8v68CDxcryPLG
        SPAqfZZQ6Yw31W26CYdYskE=
X-Google-Smtp-Source: AMsMyM5bzam3dy73MJhtfkSrDSyFw9k/AQHbFevLBsds752pwtCblgDMYIgHSXHmKJHhRFi5KzKDKQ==
X-Received: by 2002:a05:6808:658:b0:343:4df6:c5d with SMTP id z24-20020a056808065800b003434df60c5dmr1574790oih.279.1668093915356;
        Thu, 10 Nov 2022 07:25:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s16-20020a4adb90000000b0047f72b6988fsm5221123oou.45.2022.11.10.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:25:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 7/9] thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
Date:   Thu, 10 Nov 2022 07:24:58 -0800
Message-Id: <20221110152500.3032655-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.36.2
In-Reply-To: <20221110152500.3032655-1-linux@roeck-us.net>
References: <20221110152500.3032655-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Protect access to thermal operations against thermal zone removal by
acquiring the thermal zone device mutex. After acquiring the mutex, check
if the thermal zone device is registered and abort the operation if not.

With this change, we can call __thermal_zone_device_update() instead of
thermal_zone_device_update() from trip_point_temp_store() and from
emul_temp_store(). Similar, we can call __thermal_zone_set_trips() instead
of thermal_zone_set_trips() from trip_point_hyst_store().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Simplify error handling to avoid additional goto.
    Do not use ternary operator in modified code.
    Remove now unnecessary { } in emul_temp_store().

 drivers/thermal/thermal_core.c  |  4 +-
 drivers/thermal/thermal_core.h  |  2 +
 drivers/thermal/thermal_sysfs.c | 79 +++++++++++++++++++++++++++------
 3 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 9facd9c5b70f..b8e3b262b2bd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -403,8 +403,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 		pos->initialized = false;
 }
 
-static void __thermal_zone_device_update(struct thermal_zone_device *tz,
-					 enum thermal_notify_event event)
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event)
 {
 	int count;
 
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index 1571917bd3c8..7b51b9a22e7e 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -109,6 +109,8 @@ int thermal_register_governor(struct thermal_governor *);
 void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
+void __thermal_zone_device_update(struct thermal_zone_device *tz,
+				  enum thermal_notify_event event);
 
 /* Helpers */
 void thermal_zone_set_trips(struct thermal_zone_device *tz);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index ec495c7dff03..e2e94294fbb2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -92,7 +92,14 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
 		return -EINVAL;
 
-	result = tz->ops->get_trip_type(tz, trip, &type);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		result = tz->ops->get_trip_type(tz, trip, &type);
+	else
+		result = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 	if (result)
 		return result;
 
@@ -128,10 +135,17 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (tz->ops->set_trip_temp) {
 		ret = tz->ops->set_trip_temp(tz, trip, temperature);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	if (tz->trips)
@@ -140,16 +154,22 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	if (tz->ops->get_trip_hyst) {
 		ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
 		if (ret)
-			return ret;
+			goto unlock;
 	}
 
 	ret = tz->ops->get_trip_type(tz, trip, &type);
 	if (ret)
-		return ret;
+		goto unlock;
 
 	thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+unlock:
+	mutex_unlock(&tz->lock);
+
+	if (ret)
+		return ret;
 
 	return count;
 }
@@ -168,7 +188,14 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		ret = tz->ops->get_trip_temp(tz, trip, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 
 	if (ret)
 		return ret;
@@ -193,6 +220,13 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	/*
 	 * We are not doing any check on the 'temperature' value
 	 * here. The driver implementing 'set_trip_hyst' has to
@@ -201,7 +235,10 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
 
 	if (!ret)
-		thermal_zone_set_trips(tz);
+		__thermal_zone_set_trips(tz);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
@@ -220,7 +257,14 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
 		return -EINVAL;
 
-	ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	mutex_lock(&tz->lock);
+
+	if (device_is_registered(dev))
+		ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
+	else
+		ret = -ENODEV;
+
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : sprintf(buf, "%d\n", temperature);
 }
@@ -269,16 +313,23 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoint(buf, 10, &temperature))
 		return -EINVAL;
 
-	if (!tz->ops->set_emul_temp) {
-		mutex_lock(&tz->lock);
+	mutex_lock(&tz->lock);
+
+	if (!device_is_registered(dev)) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (!tz->ops->set_emul_temp)
 		tz->emul_temperature = temperature;
-		mutex_unlock(&tz->lock);
-	} else {
+	else
 		ret = tz->ops->set_emul_temp(tz, temperature);
-	}
 
 	if (!ret)
-		thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+unlock:
+	mutex_unlock(&tz->lock);
 
 	return ret ? ret : count;
 }
-- 
2.36.2

