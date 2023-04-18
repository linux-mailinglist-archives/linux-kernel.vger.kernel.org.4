Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F86E5C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjDRIb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjDRIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:31:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A014EC3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l31-20020a05600c1d1f00b003f1718d89b2so3431697wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681806669; x=1684398669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxd4s2C5sMKfjUufqyKegiNsjshtUcEOvXHcUf8vktQ=;
        b=rQhdsjfVrvCeOAYpxDOsF1But51g+urZZc1NTbbOXKX45dY9SiXOio7uIAoVH5f7En
         /83VoIYgx1Zn+JyiYGBkkSJYbXLfzAeCnSngc1wLwN7TioZ4Da0TloLC6qwqTucHwUWq
         4BgXQF57/fROxpulXp968tI+JAGoX3NJg9TVjtTAb2bzxOGXS/RRyevHcAAoXOstq7iZ
         eZTK6K5iMrhwDBNw+/G7gr9kfjC1x3prD1yNsrMpDIjZ03MANPVeHdEqwYkJcQBKPfmr
         kgfkLZ7gqQ8w/b+OpLrVJF+tf+SwrDA337b+pMZOOw7oT0uSAmkLk/RTZhq0hPzLVZ1w
         MOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806669; x=1684398669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxd4s2C5sMKfjUufqyKegiNsjshtUcEOvXHcUf8vktQ=;
        b=GG5G45Gfl7aoK2xGKrqPKWOJSlWco2IwdNRiGDJkj9uJXLVHqNBIQ4Mi7OXgw1NUL5
         rI3CSYkTxPErCQFL14Rcy4JQCW1pT+Gmv9tfwfpqpKIXiDFe1wGsr6uuC17T8VR+LwFh
         wOI//VvUtYNppKcls7Rbtsg0kfDGB3xwiXIAHnKwh8k5UFQaoZe7fMy1BkPGRbNklxZG
         NW621MOVaIfrW7+bc4cZy6nB+ion+Sy5GeJd/hc28bFKI7HVYLatQllqsaz8j0/qJasw
         pMrOrn8N2U/bPTHVOg3p0kqzECXPq3JUNz8y1BIdbVtLpMdeKA24NcagMi4cQyji3Ay/
         MeRA==
X-Gm-Message-State: AAQBX9elRJOVF+AcpZkp+4ZRY/1xKK7AH5vlccymYgCC6tVSY1UBVAjO
        /au71EqaS7jX50Jcv3EkW5IgDg==
X-Google-Smtp-Source: AKy350aD6rwNgLE5Xe+x6fNCr5L+7fPbeEjOgKxDuQpJX130OXB24T3V8Ezo7RNwTZ3vxg2nxpjAUw==
X-Received: by 2002:a1c:790f:0:b0:3f1:72e3:576b with SMTP id l15-20020a1c790f000000b003f172e3576bmr5701930wme.26.1681806669232;
        Tue, 18 Apr 2023 01:31:09 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c25b:18d5:815a:e12b])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003f1738d0d13sm1805978wms.1.2023.04.18.01.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:31:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Subject: [PATCH v1 3/3] thermal/core: Move the thermal zone structure to the private core header
Date:   Tue, 18 Apr 2023 10:30:55 +0200
Message-Id: <20230418083055.3611721-4-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
References: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in the different drivers have been sanitized and they no
longer access the thermal zone structure internals. This one is just a
pointer passed around to the thermal core code as a handler.

Move the structure definition to the private core code header to
self-encapsulate the core code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 75 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 75 ----------------------------------
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index feb02c48beba..e55d1eaa8bdb 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -18,6 +18,81 @@
 #warning This header can only be included by the thermal core code
 #endif
 
+/**
+ * struct thermal_zone_device - structure for a thermal zone
+ * @id:		unique id number for each thermal zone
+ * @type:	the thermal zone device type
+ * @device:	&struct device for this thermal zone
+ * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
+ * @trip_type_attrs:	attributes for trip points for sysfs: trip type
+ * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
+ * @mode:		current mode of this thermal zone
+ * @devdata:	private pointer for device private data
+ * @trips:	an array of struct thermal_trip
+ * @num_trips:	number of trip points the thermal zone supports
+ * @trips_disabled;	bitmap for disabled trips
+ * @passive_delay_jiffies: number of jiffies to wait between polls when
+ *			performing passive cooling.
+ * @polling_delay_jiffies: number of jiffies to wait between polls when
+ *			checking whether trip points have been crossed (0 for
+ *			interrupt driven systems)
+ * @temperature:	current temperature.  This is only for core code,
+ *			drivers should use thermal_zone_get_temp() to get the
+ *			current temperature
+ * @last_temperature:	previous temperature read
+ * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
+ * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
+ * @prev_low_trip:	the low current temperature if you've crossed a passive
+			trip point.
+ * @prev_high_trip:	the above current temperature if you've crossed a
+			passive trip point.
+ * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
+ * @ops:	operations this &thermal_zone_device supports
+ * @tzp:	thermal zone parameters
+ * @governor:	pointer to the governor for this thermal zone
+ * @governor_data:	private pointer for governor data
+ * @thermal_instances:	list of &struct thermal_instance of this thermal zone
+ * @ida:	&struct ida to generate unique id for this zone's cooling
+ *		devices
+ * @lock:	lock to protect thermal_instances list
+ * @node:	node in thermal_tz_list (in thermal_core.c)
+ * @poll_queue:	delayed work for polling
+ * @notify_event: Last notification event
+ */
+struct thermal_zone_device {
+	int id;
+	char type[THERMAL_NAME_LENGTH];
+	struct device device;
+	struct attribute_group trips_attribute_group;
+	struct thermal_attr *trip_temp_attrs;
+	struct thermal_attr *trip_type_attrs;
+	struct thermal_attr *trip_hyst_attrs;
+	enum thermal_device_mode mode;
+	void *devdata;
+	struct thermal_trip *trips;
+	int num_trips;
+	unsigned long trips_disabled;	/* bitmap for disabled trips */
+	unsigned long passive_delay_jiffies;
+	unsigned long polling_delay_jiffies;
+	int temperature;
+	int last_temperature;
+	int emul_temperature;
+	int passive;
+	int prev_low_trip;
+	int prev_high_trip;
+	atomic_t need_update;
+	struct thermal_zone_device_ops *ops;
+	struct thermal_zone_params *tzp;
+	struct thermal_governor *governor;
+	void *governor_data;
+	struct list_head thermal_instances;
+	struct ida ida;
+	struct mutex lock;
+	struct list_head node;
+	struct delayed_work poll_queue;
+	enum thermal_notify_event notify_event;
+};
+
 /* Default Thermal Governor */
 #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
 #define DEFAULT_THERMAL_GOVERNOR       "step_wise"
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..3e8bedb21755 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -112,81 +112,6 @@ struct thermal_cooling_device {
 	struct list_head node;
 };
 
-/**
- * struct thermal_zone_device - structure for a thermal zone
- * @id:		unique id number for each thermal zone
- * @type:	the thermal zone device type
- * @device:	&struct device for this thermal zone
- * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
- * @trip_type_attrs:	attributes for trip points for sysfs: trip type
- * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
- * @mode:		current mode of this thermal zone
- * @devdata:	private pointer for device private data
- * @trips:	an array of struct thermal_trip
- * @num_trips:	number of trip points the thermal zone supports
- * @trips_disabled;	bitmap for disabled trips
- * @passive_delay_jiffies: number of jiffies to wait between polls when
- *			performing passive cooling.
- * @polling_delay_jiffies: number of jiffies to wait between polls when
- *			checking whether trip points have been crossed (0 for
- *			interrupt driven systems)
- * @temperature:	current temperature.  This is only for core code,
- *			drivers should use thermal_zone_get_temp() to get the
- *			current temperature
- * @last_temperature:	previous temperature read
- * @emul_temperature:	emulated temperature when using CONFIG_THERMAL_EMULATION
- * @passive:		1 if you've crossed a passive trip point, 0 otherwise.
- * @prev_low_trip:	the low current temperature if you've crossed a passive
-			trip point.
- * @prev_high_trip:	the above current temperature if you've crossed a
-			passive trip point.
- * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
- * @ops:	operations this &thermal_zone_device supports
- * @tzp:	thermal zone parameters
- * @governor:	pointer to the governor for this thermal zone
- * @governor_data:	private pointer for governor data
- * @thermal_instances:	list of &struct thermal_instance of this thermal zone
- * @ida:	&struct ida to generate unique id for this zone's cooling
- *		devices
- * @lock:	lock to protect thermal_instances list
- * @node:	node in thermal_tz_list (in thermal_core.c)
- * @poll_queue:	delayed work for polling
- * @notify_event: Last notification event
- */
-struct thermal_zone_device {
-	int id;
-	char type[THERMAL_NAME_LENGTH];
-	struct device device;
-	struct attribute_group trips_attribute_group;
-	struct thermal_attr *trip_temp_attrs;
-	struct thermal_attr *trip_type_attrs;
-	struct thermal_attr *trip_hyst_attrs;
-	enum thermal_device_mode mode;
-	void *devdata;
-	struct thermal_trip *trips;
-	int num_trips;
-	unsigned long trips_disabled;	/* bitmap for disabled trips */
-	unsigned long passive_delay_jiffies;
-	unsigned long polling_delay_jiffies;
-	int temperature;
-	int last_temperature;
-	int emul_temperature;
-	int passive;
-	int prev_low_trip;
-	int prev_high_trip;
-	atomic_t need_update;
-	struct thermal_zone_device_ops *ops;
-	struct thermal_zone_params *tzp;
-	struct thermal_governor *governor;
-	void *governor_data;
-	struct list_head thermal_instances;
-	struct ida ida;
-	struct mutex lock;
-	struct list_head node;
-	struct delayed_work poll_queue;
-	enum thermal_notify_event notify_event;
-};
-
 /**
  * struct thermal_governor - structure that holds thermal governor information
  * @name:	name of the governor
-- 
2.34.1

