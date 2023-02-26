Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC146A3525
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjBZW4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjBZWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:55:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72451A672
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:37 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso2501724wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vHRlE4gW0G0XPdoOjf4Phl247vZu3Xaj6GOQBk8A4E=;
        b=A6LZOrlAVN+GzHJYwJ06W4bRMQ9VCiWoajvXTzMG6CK2hj1Xi/Vmqc5+jSO91pwHqw
         0EZY7wMul0fbcveD+eaGXc+qs/kpcSD792PXEEG7SlS3zlwDWuqrQny7lVWrB4LejVdD
         bCKWWLF8BPcJUf3F2a/XiMK0ehZXd2IXW6/WCtkaOswQ+BG4V1ENuzI1w/iD/zGUmBaj
         RwhJVijlWaAjzD/IkHStv1kf7kmA8D4En9TshN1wnxnODCUO+7uKzmYYmGDBIIWVQshd
         SGsA4pF/C1yyuVXZLbE5IoTVaIy6efJFsamL7oC6IhtVW7XqC4n3MTKJrih31HdUlb6h
         CEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vHRlE4gW0G0XPdoOjf4Phl247vZu3Xaj6GOQBk8A4E=;
        b=QdVNVMu3FeLs7RcdJlr3ctqUIYsYwMu50f1W3Ty2DUsbSjT+0p1LZr7hMwZNzFjZ4B
         /G7vxflPoLQSoz4Rsbgu0qn9IcamqR6OPckrpA5O7QxN1eCwyn94HY9kIAl4+qBYz2dk
         p+xSELMOsRzzvYzbVQvSVpxaWhi+1EoO6jLkYTy7SNhvjctNNTrjRzyw4Ycd1gof7vqs
         VyN1BNNq/masp0ppfXclI2vxMrmAN9Ghrh2x51aFlhzatTgprHNIwTk+iVHPZjUr83cb
         xiEHq9hj4VZD8lvIqFN+oRCp6unebY4S2WB5Rzh0BnXFEhYV+9iKQU395s8PLg5Vwxa9
         TVbg==
X-Gm-Message-State: AO0yUKVTc1GpDqf7/Ez8k8ch9xiJoa5HntrFipXPBOCwWdEUo09TT0iD
        Wbs3JlG5mDk0maSdIjb1EmH9HQ==
X-Google-Smtp-Source: AK7set+gh98ADYFHHJNmYfkq6fdJ7l360zTjP3VhXEH8nirAfkJhh+dORdFV5tdn1UY5zQFVwwUJkw==
X-Received: by 2002:a05:600c:1d10:b0:3e7:b17f:9af1 with SMTP id l16-20020a05600c1d1000b003e7b17f9af1mr15546106wms.22.1677452125225;
        Sun, 26 Feb 2023 14:55:25 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c3aca00b003eb369abd92sm6138074wms.2.2023.02.26.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 14:55:24 -0800 (PST)
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
Subject: [PATCH v3 20/20] thermal/traces: Replace the thermal zone structure parameter with the field value
Date:   Sun, 26 Feb 2023 23:54:06 +0100
Message-Id: <20230226225406.979703-21-daniel.lezcano@linaro.org>
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

In the work of the thermal zone device self-encapsulation, let's pass
the field value instead of dereferencing them in the traces which
force us to export publicly the thermal_zone_device structure.

No fonctionnal change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/gov_fair_share.c              |  4 +++-
 drivers/thermal/gov_power_allocator.c         |  6 +++--
 drivers/thermal/gov_step_wise.c               |  4 +++-
 drivers/thermal/thermal_core.c                |  8 +++++--
 include/trace/events/thermal.h                | 24 +++++++++----------
 .../trace/events/thermal_power_allocator.h    | 12 +++++-----
 6 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
index aad7d5fe3a14..cdddd593021d 100644
--- a/drivers/thermal/gov_fair_share.c
+++ b/drivers/thermal/gov_fair_share.c
@@ -35,7 +35,9 @@ static int get_trip_level(struct thermal_zone_device *tz)
 	 * point, in which case, trip_point = count - 1
 	 */
 	if (count > 0)
-		trace_thermal_zone_trip(tz, count - 1, trip.type);
+		trace_thermal_zone_trip(thermal_zone_device_type(tz),
+					thermal_zone_device_id(tz),
+					count - 1, trip.type);
 
 	return count;
 }
diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0eaf1527d3e3..bebab8b8694b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -266,7 +266,8 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 
 	power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
 
-	trace_thermal_power_allocator_pid(tz, frac_to_int(err),
+	trace_thermal_power_allocator_pid(thermal_zone_device_id(tz),
+					  frac_to_int(err),
 					  frac_to_int(params->err_integral),
 					  frac_to_int(p), frac_to_int(i),
 					  frac_to_int(d), power_range);
@@ -481,7 +482,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 		i++;
 	}
 
-	trace_thermal_power_allocator(tz, req_power, total_req_power,
+	trace_thermal_power_allocator(thermal_zone_device_id(tz),
+				      req_power, total_req_power,
 				      granted_power, total_granted_power,
 				      num_actors, power_range,
 				      max_allocatable_power, tz->temperature,
diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 31235e169c5a..81ef43a40f98 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -109,7 +109,9 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id
 
 	if (tz->temperature >= trip.temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip_id, trip.type);
+		trace_thermal_zone_trip(thermal_zone_device_type(tz),
+					thermal_zone_device_id(tz),
+					trip_id, trip.type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 46dedfe061df..c856ab911149 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -336,7 +336,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	if (trip_temp <= 0 || tz->temperature < trip_temp)
 		return;
 
-	trace_thermal_zone_trip(tz, trip, trip_type);
+	trace_thermal_zone_trip(thermal_zone_device_type(tz),
+				thermal_zone_device_id(tz),
+				trip, trip_type);
 
 	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
 		tz->ops->hot(tz);
@@ -387,7 +389,9 @@ static void update_temperature(struct thermal_zone_device *tz)
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
-	trace_thermal_temperature(tz);
+	trace_thermal_temperature(thermal_zone_device_type(tz),
+				  thermal_zone_device_id(tz),
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

