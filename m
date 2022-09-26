Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9F65EAA4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiIZPTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiIZPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:18:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D0981696
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id e18so4580263wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LWUSHCJ7OfLyXhypGb9pb8SFllwy6yIkhbdWXrtw3Z8=;
        b=ZkGpFlM6gwmZgkWKZDjSlzYO+KxUpTRkG88i8pb74UEmWlvIOSEXh3KP/KS4MjvS7b
         uWIvf3M4P6fyfze1LiZ+qd+rfJGegXLD4kp8xCicietAjMJJKKjSy3Cl5DouU7wlWdBA
         bxZsaae0LHpYMEMNqIkT9XmfY+hUttPC+a6Xic8ffyqLjPxbrwtVtmoM2mkBZttadgUz
         62mjK9l4TpmuGkE2dEHF3m7pgrl0QkaFqlER/IHVH4PbzsR9zhpZt0AqhAb5GwG9Jjnc
         rawChWTeILVxdAaRXnqc1eEuaEL7oEgppkCcvuyNPIZCgLBREF96ZumeIdu50xxATGsn
         6iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LWUSHCJ7OfLyXhypGb9pb8SFllwy6yIkhbdWXrtw3Z8=;
        b=WWppB+5G6BJ94vEVjMWx3lgxWvGnrSS43lES8WkTmsz3K1gmbWhAJ+5zffcZIYYZXH
         jsHRz7kxAAUq0Rc1JZi0hrpLnTDc+mhExPj7jlb03nX+hHqSPxVKOVXVu2nmni10TiCR
         3CIffT7q3NxHbfs1LjoSW/ZL9hJUzhiktfNfhP6c6rq559J0YT8IMpsIHNmgc+x5R+rg
         OqlpR91p866l7DuhvxY+P2aJQNRnzNh+KLA3Nf0Cuiys1PM+Usw1gq8NNKKilyS1JY6M
         agtAKWpWZ9DejcGVICUd7CFZvYnnfggYjsCIVUYdNSEfDn6ek5TF5I77QaF32PvEN0sf
         UyaQ==
X-Gm-Message-State: ACrzQf3KmZm+tm217ksuB0pxbdqC1Mfsg1drDP6pPWxoeL4+5Ep5dh1W
        N1dnlVZthPuhP70hpaAMlvQ6kA==
X-Google-Smtp-Source: AMsMyM7XW/SjYQTZ1CbbYJencjUx2l8y8/VQ6y+UtBJcd8bqpASCG4qJQlMLZTuvU3CJOyIBOV2MFQ==
X-Received: by 2002:a05:600c:23ca:b0:3b4:6199:8ab9 with SMTP id p10-20020a05600c23ca00b003b461998ab9mr21727232wmb.20.1664201179580;
        Mon, 26 Sep 2022 07:06:19 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id v3-20020adfebc3000000b0022adf321d22sm14310731wrn.92.2022.09.26.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 07:06:19 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v5 03/30] thermal/core: Add a generic thermal_zone_set_trip() function
Date:   Mon, 26 Sep 2022 16:05:37 +0200
Message-Id: <20220926140604.4173723-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_core.c  | 45 +++++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c | 48 +++++++++++----------------------
 include/linux/thermal.h         |  3 +++
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 903a858df35f..9f61b0ab57b7 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1212,6 +1212,51 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
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
+
 /**
  * thermal_zone_device_register_with_trips() - register a new thermal zone device
  * @type:	the thermal zone device type
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

