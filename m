Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719ED69E723
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBUSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjBUSI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:08:58 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC28A2F7A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:08:14 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k37so936678wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBQxQhehGUpTYEeuE7auUftubBPtTSpiFKbgKJmeYe0=;
        b=M5/YR06v8XKoA5Q/UoTpaqbXBVqZbdD2IROtSRVWOhLtQxYabaL3fKwfYFChTR1O+B
         00NHbgiEzDUXwoSC9QXThsyx7KIQCqlyxM4NFE8FZ6yvyuXcfG7xKKxk810Bk9BTrW0y
         c47nEfMKPQ+P8pmOJdZ6a7By1MvF6EYQ/4GzuL4GEv0DYuNNNg0Jlh6J7Zik1cbzD5U8
         cxYGD6lF7HIgOfTqF8MPnQmPVQRMgX82E2IjC2V6dDZ88GybLfyxo3tsX/mimyr5bsN1
         u7/E6I+cp6+N+YMLcjsj3GFW/MhgNmjIDb0G3JKkO839vYrClGwLThW7JZEDDbP+RhL1
         NcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBQxQhehGUpTYEeuE7auUftubBPtTSpiFKbgKJmeYe0=;
        b=krE1fPvyquHv+85vPhfmVbonumyI/F//F10ctZykm+enzt999RmiukZApvtl0QoTXA
         XSEXLrKMEZbBogh+pabMXEQYJWhLC9/B8OGVNjArhO0m4/L7OFo30mUnF6culhPDNuee
         nbuMXPf9wzh1Nx5teu8mqtepo+5uxO27n4HgueYM+Gvz6RRL6vuEez2KV5ZGmOc5Lvby
         cnwo7wO8MGPEu2yPj+rU7lHF94x6ek+Ijh+5xrHbulJAGjTpV++wlT8gana8OR3HJ4ko
         EfevQX5TPcyLseJLlO4422suWzqNdJ1/95VtS32OT1aDJ2ShkDZbDD1hIxyHvIL5bug0
         LbVw==
X-Gm-Message-State: AO0yUKVVWMyOfK//6oZfBsQXyCYBSND7mmSEiWzrdGwMag+bDBn8rOHk
        H1F0pyphyVptfspY5jOSOTZvRcwcLvMo0oGNMek=
X-Google-Smtp-Source: AK7set9lVxHhkhf1ppX34NYrkbDtoNSnsXgCq+nXCaNINiKxHjFWcx/v/qR2+MWrQlDMjv8QRcbgAA==
X-Received: by 2002:a05:600c:4a8f:b0:3dd:dd46:171b with SMTP id b15-20020a05600c4a8f00b003dddd46171bmr3414450wmp.10.1677002893206;
        Tue, 21 Feb 2023 10:08:13 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.gmail.com with ESMTPSA id c128-20020a1c3586000000b003e21558ee9dsm5107815wma.2.2023.02.21.10.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:08:12 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH v2 16/16] thermal/traces: Replace the thermal zone structure parameter with the field value
Date:   Tue, 21 Feb 2023 19:07:10 +0100
Message-Id: <20230221180710.2781027-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
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

In the work of the thermal zone device self-encapsulation, let's pass
the field value instead of dereferencing them in the traces which
force us to export publicly the thermal_zone_device structure.

No fonctionnal change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_fair_share.c              |  2 +-
 drivers/thermal/gov_power_allocator.c         |  4 ++--
 drivers/thermal/gov_step_wise.c               |  2 +-
 drivers/thermal/thermal_core.c                |  5 ++--
 include/trace/events/thermal.h                | 24 +++++++++----------
 .../trace/events/thermal_power_allocator.h    | 12 +++++-----
 6 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index aad7d5fe3a14..e6c21abaaa80 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -35,7 +35,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	 * point, in which case, trip_point = count - 1
 	 */
 	if (count > 0)
-		trace_thermal_zone_trip(tz, count - 1, trip.type);
+		trace_thermal_zone_trip(tz->type, tz->id, count - 1, trip.type);
 
 	return count;
 }
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0eaf1527d3e3..aaa8b57434ef 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -266,7 +266,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
 	power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
 
-	trace_thermal_power_allocator_pid(tz, frac_to_int(err),
+	trace_thermal_power_allocator_pid(tz->id, frac_to_int(err),
 					  frac_to_int(params->err_integral),
 					  frac_to_int(p), frac_to_int(i),
 					  frac_to_int(d), power_range);
@@ -481,7 +481,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 		i++;
 	}
 
-	trace_thermal_power_allocator(tz, req_power, total_req_power,
+	trace_thermal_power_allocator(tz->id, req_power, total_req_power,
 				      granted_power, total_granted_power,
 				      num_actors, power_range,
 				      max_allocatable_power, tz->temperature,
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 31235e169c5a..f469e04770fe 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -109,7 +109,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id
 
 	if (tz->temperature >= trip.temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip_id, trip.type);
+		trace_thermal_zone_trip(tz->type, tz->id, trip_id, trip.type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 73b7a060f768..48987129b20d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -336,7 +336,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
 
-	trace_thermal_zone_trip(tz, trip, trip_type);
+	trace_thermal_zone_trip(tz->type, tz->id, trip, trip_type);
 
 	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
 		tz->ops->hot(tz);
@@ -387,7 +387,8 @@ static void update_temperature(struct thermal_zone_device *tz)
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
-	trace_thermal_temperature(tz);
+	trace_thermal_temperature(tz->type, tz->id,
+				  tz->last_temperature, tz->temperature);
 
 	thermal_genl_sampling_temp(tz->id, temp);
 }
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index e58bf3072f32..50c7d2e1526d 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -23,22 +23,22 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
 
 TRACE_EVENT(thermal_temperature,
 
-	TP_PROTO(struct thermal_zone_device *tz),
+	TP_PROTO(const char *type, int id, int temp_prev, int temp),
 
-	TP_ARGS(tz),
+	TP_ARGS(type, id, temp_prev, temp),
 
 	TP_STRUCT__entry(
-		__string(thermal_zone, tz->type)
+		__string(thermal_zone, type)
 		__field(int, id)
 		__field(int, temp_prev)
 		__field(int, temp)
 	),
 
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
-		__entry->id = tz->id;
-		__entry->temp_prev = tz->last_temperature;
-		__entry->temp = tz->temperature;
+		__assign_str(thermal_zone, type);
+		__entry->id = id;
+		__entry->temp_prev = temp_prev;
+		__entry->temp = temp;
 	),
 
 	TP_printk("thermal_zone=%s id=%d temp_prev=%d temp=%d",
@@ -67,21 +67,21 @@ TRACE_EVENT(cdev_update,
 
 TRACE_EVENT(thermal_zone_trip,
 
-	TP_PROTO(struct thermal_zone_device *tz, int trip,
+	TP_PROTO(const char *type, int id, int trip,
 		enum thermal_trip_type trip_type),
 
-	TP_ARGS(tz, trip, trip_type),
+	TP_ARGS(type, id, trip, trip_type),
 
 	TP_STRUCT__entry(
-		__string(thermal_zone, tz->type)
+		__string(thermal_zone, type)
 		__field(int, id)
 		__field(int, trip)
 		__field(enum thermal_trip_type, trip_type)
 	),
 
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
-		__entry->id = tz->id;
+		__assign_str(thermal_zone, type);
+		__entry->id = id;
 		__entry->trip = trip;
 		__entry->trip_type = trip_type;
 	),
diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
index 1c8fb95544f9..7ac049e7e3cf 100644
--- a/include/trace/events/thermal_power_allocator.h
+++ b/include/trace/events/thermal_power_allocator.h
@@ -8,12 +8,12 @@
 #include <linux/tracepoint.h>
 
 TRACE_EVENT(thermal_power_allocator,
-	TP_PROTO(struct thermal_zone_device *tz, u32 *req_power,
+	TP_PROTO(int id, u32 *req_power,
 		 u32 total_req_power, u32 *granted_power,
 		 u32 total_granted_power, size_t num_actors,
 		 u32 power_range, u32 max_allocatable_power,
 		 int current_temp, s32 delta_temp),
-	TP_ARGS(tz, req_power, total_req_power, granted_power,
+	TP_ARGS(id, req_power, total_req_power, granted_power,
 		total_granted_power, num_actors, power_range,
 		max_allocatable_power, current_temp, delta_temp),
 	TP_STRUCT__entry(
@@ -29,7 +29,7 @@ TRACE_EVENT(thermal_power_allocator,
 		__field(s32,           delta_temp               )
 	),
 	TP_fast_assign(
-		__entry->tz_id = tz->id;
+		__entry->tz_id = id;
 		memcpy(__get_dynamic_array(req_power), req_power,
 			num_actors * sizeof(*req_power));
 		__entry->total_req_power = total_req_power;
@@ -56,9 +56,9 @@ TRACE_EVENT(thermal_power_allocator,
 );
 
 TRACE_EVENT(thermal_power_allocator_pid,
-	TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
+	TP_PROTO(int id, s32 err, s32 err_integral,
 		 s64 p, s64 i, s64 d, s32 output),
-	TP_ARGS(tz, err, err_integral, p, i, d, output),
+	TP_ARGS(id, err, err_integral, p, i, d, output),
 	TP_STRUCT__entry(
 		__field(int, tz_id       )
 		__field(s32, err         )
@@ -69,7 +69,7 @@ TRACE_EVENT(thermal_power_allocator_pid,
 		__field(s32, output      )
 	),
 	TP_fast_assign(
-		__entry->tz_id = tz->id;
+		__entry->tz_id = id;
 		__entry->err = err;
 		__entry->err_integral = err_integral;
 		__entry->p = p;
-- 
2.34.1

