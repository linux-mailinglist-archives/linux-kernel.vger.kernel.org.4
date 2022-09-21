Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826E5BFB64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIUJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiIUJnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:43:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7687C92F5A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so848729wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Ot6aPvSiYXAp0Hkm+zPI98RcgU3lQfSUO9dLDinpKfk=;
        b=mUjk1QIbqi1+YwFxY5dIDY0nUXFOL7uYUbwkbIp+k0yGF2zAF59PtOrP7X1foeB89z
         Ajd7TYHPvsZZVUdjRhQgHVIM52KyZjIie8OyciYQjbNCfKoAmBZ3gyWw6YBhB13pWpHd
         rJFjxh2vSogqkUhHLuoDCnv5o6h5HDxfKDk6TBuV+KiZwcXQIqJEz2YeRRQ0zh6waJO9
         clSuu3ktKXjcvJECF5AfprN7bux1dFwDLvAeQLeDFv+FMM5bti21zfMGhSEDvttVRqYo
         GbFk6emamloDqBXnI1MkNcoKw3RhQmII6zjlWNdnKo28x6YsAhWZKMEZ7lX1x/rxLJf3
         Yxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ot6aPvSiYXAp0Hkm+zPI98RcgU3lQfSUO9dLDinpKfk=;
        b=Z7Y8DQLW55DcICknN9IrCo1IolGC4EdzzNQ7LijhdIHSS0OetFM57ETDGzb76IRIFl
         w+Vg3PzIrFj1uRMIWv5hq8UrZaxTRo89aJ6imcrPdSjHcjkp63BjJpZHah/en0W2SFDv
         jFnjtmy33GDKXYCJC/H3dgxs5+z0J4Z1WAceQGz9zx7KqEV1LDOBDNolT3xF2OMjal7k
         C8BcEErHI5m5C8iSyEAyTmyCgos452ICNU96vHZ9Ff63YXobUm88C1cTOKV6dYSxQSnQ
         Ycg8acnq+/ETg7F33PcAFlEI7fKW0s/k3UMcwzsjWQ8IhYOfdLP+/dASsa+BirCiFMMl
         MfsA==
X-Gm-Message-State: ACrzQf3GjM1HTwlJ67dWMmy5l/+f/8Wi6bQmzKufxua+hm/eXSQzw0+4
        5b0KFZ4GcFkHo2s2njf9lTqQKg==
X-Google-Smtp-Source: AMsMyM5rvlBo1e6PdbmztUWGzkZEaiKzw1bqYCOZpNp2cyY9HgFtzhz7sgdCvt1qsorxjm7+sivpRQ==
X-Received: by 2002:a05:600c:2c47:b0:3b4:fcdf:d783 with SMTP id r7-20020a05600c2c4700b003b4fcdfd783mr424060wmg.157.1663753403670;
        Wed, 21 Sep 2022 02:43:23 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id r123-20020a1c2b81000000b003a62052053csm2763917wmr.18.2022.09.21.02.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:43:23 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v4 03/30] thermal/core: Add a generic thermal_zone_set_trip() function
Date:   Wed, 21 Sep 2022 11:42:16 +0200
Message-Id: <20220921094244.606948-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220921094244.606948-1-daniel.lezcano@linaro.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone ops defines a set_trip callback where we can invoke
the backend driver to set an interrupt for the next trip point
temperature being crossed the way up or down, or setting the low level
with the hysteresis.

The ops is only called from the thermal sysfs code where the userspace
has the ability to modify a trip point characteristic.

With the effort of encapsulating the thermal framework core code,
let's create a thermal_zone_set_trip() which is the writable side of
the thermal_zone_get_trip() and put there all the ops encapsulation.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.c  | 44 ++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c | 48 +++++++++++----------------------
 include/linux/thermal.h         |  3 +++
 3 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 381d85ec74a0..fa0f89a24b68 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1183,6 +1183,50 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip)
+{
+	struct thermal_trip t;
+	int ret = -EINVAL;
+
+	mutex_lock(&tz->lock);
+
+	if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
+		goto out;
+
+	ret = __thermal_zone_get_trip(tz, trip_id, &t);
+	if (ret)
+		goto out;
+
+	if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {
+
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			goto out;
+	}
+
+	if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
+
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			goto out;
+	}
+
+	if (((t.temperature != trip->temperature) ||
+	     (t.hysteresis != trip->hysteresis)) && tz->trips)
+		tz->trips[trip_id] = *trip;
+
+out:
+	mutex_unlock(&tz->lock);
+
+	if (!ret) {
+		thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
+					      trip->temperature, trip->hysteresis);
+		thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	}
+	
+	return ret;
+}
 
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 18cdd7cd0008..8d7b25ab67c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,31 +115,20 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 	struct thermal_trip trip;
 	int trip_id, ret;
 
-	if (!tz->ops->set_trip_temp && !tz->trips)
-		return -EPERM;
-
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &trip.temperature))
-		return -EINVAL;
-
-	ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	if (tz->trips)
-		tz->trips[trip_id].temperature = trip.temperature;
+	if (kstrtoint(buf, 10, &trip.temperature))
+		return -EINVAL;
 
-	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
-				      trip.temperature, trip.hysteresis);
-
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
-
 	return count;
 }
 
@@ -166,29 +155,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 		      const char *buf, size_t count)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
-	int trip, ret;
-	int temperature;
-
-	if (!tz->ops->set_trip_hyst)
-		return -EPERM;
+	struct thermal_trip trip;
+	int trip_id, ret;
 
-	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
+	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	if (kstrtoint(buf, 10, &temperature))
-		return -EINVAL;
+	ret = thermal_zone_get_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	/*
-	 * We are not doing any check on the 'temperature' value
-	 * here. The driver implementing 'set_trip_hyst' has to
-	 * take care of this.
-	 */
-	ret = tz->ops->set_trip_hyst(tz, trip, temperature);
+	if (kstrtoint(buf, 10, &trip.hysteresis))
+		return -EINVAL;
 
-	if (!ret)
-		thermal_zone_set_trips(tz);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 09dc09228717..5350a437f245 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -338,6 +338,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 #ifdef CONFIG_THERMAL
-- 
2.34.1

