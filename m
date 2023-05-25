Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF5710DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241586AbjEYODB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbjEYOCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:02:48 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E942E1B0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30a95ec7744so2115259f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685023331; x=1687615331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlMjiYWjIod1M5ysecwWR9Zw02vJku0YSHje4x3URRI=;
        b=w1RsQ+stlMrNo0+vFPex2i/zi2qhFPU+CG+4wI4u4KpQiT7VBQ6e3KEg8o5ksT22h5
         2rWiRy33QN4BFcZxdsBLNxdSk0xC4y6NjDXQYitf8YgGuLluXosBbSmIKQA8ph9Fl45R
         oTIPz/Od566ZvOtUFKDcJn3tBUsIjj6LxWHBEYAwkJfh8sVd2xc0lRvTwoMYDLgSw5XN
         uSlV7pXP3ezzS56NM2yclfL5Q+71pi3xDuWsMCLCDcHsq2ZtebcR4QGrsWcoLm6nNVqa
         S8+V+FKrddJIkmwQVwgEnPYxzRJWSz6xCRwKMnpi56Ip1M6a6Z2WWNs+9jb2S9wG/83c
         aBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023331; x=1687615331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xlMjiYWjIod1M5ysecwWR9Zw02vJku0YSHje4x3URRI=;
        b=AJ+cr6et718rPdnqMo2et/McXnSVe3Mo14kk3CQMDTd3jW8yWSfgIAuSQEBdfpdG5q
         ZzA8j/UbnhXUqI1MsyM4P1In8uAifqmdbi9hc4OB2v0O2GN/uQofy0hEhBtHKps2EVF3
         Yic+3lDqz31z4rIsWoJgQdftbtJOQH+AZFcQdah7mc/IE2JDR2Lh9zgWUSNxUnnXxapA
         tV2owLY3+42YZFdzqDlcus6j0FX+BlZMt0Vxz9t7O7BVdd3fh6HbTe1m+rhEHX+nnKN/
         B/7GOzt8Ws68pT3p5XqRMp1MhpNEMiXUw36rL7Rp25Tgi7LNM3/cZoMk40lwkdP/s1hp
         3T+w==
X-Gm-Message-State: AC+VfDwWdj3JgcabllYO2tLCfsdR4mIeWlYEXkIQHn+krwLaSlbaRaoe
        N75J6UoMEAnCpKIOvZTV+WtKvA==
X-Google-Smtp-Source: ACHHUZ6VTuTPHdSAz9DsUXXmuiMQweDChxDD2cBuim7IKj+jS9IGjmwrEViGz+Z1wiMrdyCg6dK5UQ==
X-Received: by 2002:adf:f348:0:b0:306:3381:67fe with SMTP id e8-20020adff348000000b00306338167femr2737955wrp.27.1685023331567;
        Thu, 25 May 2023 07:02:11 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5aef:8608:89d7:7961])
        by smtp.gmail.com with ESMTPSA id u4-20020adfdd44000000b003063176ef09sm1944866wrm.6.2023.05.25.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:02:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] thermal/core: Move the thermal zone structure to the private core header
Date:   Thu, 25 May 2023 16:01:35 +0200
Message-Id: <20230525140135.3589917-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
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

No functional changes intented.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/thermal_core.h | 75 ++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        | 75 ----------------------------------
 2 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index c27a9930f904..b93386640799 100644
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
index 83937256a01c..0ea2da5c33ac 100644
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

