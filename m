Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485485EE71F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 23:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiI1VCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 17:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiI1VBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 17:01:44 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E6B67CAC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:01:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so2050200wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 14:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=3w6X3JVNiKRT92+QAllo+YG55ME/ZdTJyQvYR7P+Hfw=;
        b=odqFR4bM7EJvQzUbU6Dk/aODPLb2VxNwDESLcmviDfCj1xKOvZRKr1v1aDYFJwbFp/
         L4/1hMWqB0LyP5i3380M5yAe0KEtcZaHkmLJmW5pzNdjkmFfiBvFJroq86t1nHr5UFnv
         djlEJ8HuSh5DXWumKamnUIYs14hOQn86Jp4E5WD8dhBVt2reYUc16elHy//LFBah9Bgq
         1kiQ2ZGnAfd3sx2umz8Yi/hHtGiyP47vdfTv4hUOh3kUPPzLMdMoaVgP4VwrGSO+USB4
         ibt7uJpt8gXsAxQBGLl1MuE2yRAw78gqbxqIRS70Jj/xWWvqTteH5K35qrE7IGY/GWww
         fFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3w6X3JVNiKRT92+QAllo+YG55ME/ZdTJyQvYR7P+Hfw=;
        b=6gXtGgyDku9WGE9CWscHkb0jwQI+9SHDPz0Roy4+JvvcZJDQZjsiRaM0wYtAE0hTtg
         uj/0WD9AQ/sqPezANTde9rW5F/9PGcOUCLFhA3Q1PQbl1gIJrqYgok/7NmyznvYYFJgn
         oblWqGVf0nEcQhaZkpzzfkTy9AVMcbXQIH4ro6/1zAjTaudWhkkmLNOhaiC1HeVR5MDO
         0lZNApl633ssqjV8HP9Uu8YetZSjgt7iplGyhPHWcjjEhKk647onYIJxBUmC04I1m2Z+
         Bk52pfD1d9MC1oE2VM445UiECBw1238BdvOham6IaYJQ3iH7etz86PyQ0RwBvEAvuy2D
         FWsg==
X-Gm-Message-State: ACrzQf3aMMRiKiWk+K0T3+xKy25368hPcqW23yoolMMyZZKqP56UTOCZ
        6bTtbFgbUf1FrKiNosp0zBr1VA==
X-Google-Smtp-Source: AMsMyM4RM93ircA9apTj7YPnwMAM73TFBLkrWkcmR9GF5Wi4bRBysK4p2TuymUPTj2aeJQJfBh3Ahg==
X-Received: by 2002:a05:600c:310b:b0:3b4:c1ce:cd83 with SMTP id g11-20020a05600c310b00b003b4c1cecd83mr8130939wmo.91.1664398879327;
        Wed, 28 Sep 2022 14:01:19 -0700 (PDT)
Received: from mai.. ([2a05:6e02:1041:c10:48a2:39eb:9d1b:8b8d])
        by smtp.gmail.com with ESMTPSA id g20-20020a05600c4ed400b003b4931eb435sm2874300wmq.26.2022.09.28.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:01:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v7 03/29] thermal/core: Add a generic thermal_zone_set_trip() function
Date:   Wed, 28 Sep 2022 23:00:33 +0200
Message-Id: <20220928210059.891387-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220928210059.891387-1-daniel.lezcano@linaro.org>
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
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
 drivers/thermal/thermal_core.c  | 47 +++++++++++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c | 52 +++++++++++----------------------
 include/linux/thermal.h         |  3 ++
 3 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 16ef91dc102f..2675671781cd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1211,6 +1211,53 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
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
+	if (t.type != trip->type) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (t.temperature != trip->temperature && tz->ops->set_trip_temp) {
+		ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
+		if (ret)
+			goto out;
+	}
+
+	if (t.hysteresis != trip->hysteresis && tz->ops->set_trip_hyst) {
+		ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
+		if (ret)
+			goto out;
+	}
+
+	if (tz->trips && ((t.temperature != trip->temperature) ||
+			  (t.hysteresis != trip->hysteresis)))
+		tz->trips[trip_id] = *trip;
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
index 6c45194aaabb..8d7b25ab67c2 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -115,32 +115,19 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
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
-	if (tz->ops->set_trip_temp) {
-		ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
-		if (ret)
-			return ret;
-	}
-
-	if (tz->trips)
-		tz->trips[trip_id].temperature = trip.temperature;
-
 	ret = thermal_zone_get_trip(tz, trip_id, &trip);
 	if (ret)
 		return ret;
 
-	thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
-				      trip.temperature, trip.hysteresis);
+	if (kstrtoint(buf, 10, &trip.temperature))
+		return -EINVAL;
 
-	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	ret = thermal_zone_set_trip(tz, trip_id, &trip);
+	if (ret)
+		return ret;
 
 	return count;
 }
@@ -168,29 +155,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
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
index feb8b61df746..66373f872237 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -338,6 +338,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			  struct thermal_trip *trip);
 
+int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
+			  const struct thermal_trip *trip);
+
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
-- 
2.34.1

