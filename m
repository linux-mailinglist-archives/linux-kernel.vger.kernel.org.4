Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C78A69C0F7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjBSOjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBSOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:38:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6D81117E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c17so335054wrx.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 06:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQDbrZzTyIu0DglbWKhFLaeyxSO75uKLoMfSjkuf9YI=;
        b=JmC/4sBikepuW2JL9s0EDARnxaYc9IhDcSSyd6fyTgOXblmVe2B7Cw4NdEaUve7mnf
         kOd6Nls86ri95KMu6WGE0bWwE2DHHdvx2fO4PaoebjorROd8/s0yz8rUdE97FQz4N1q/
         WOYl+CLeNIpT/GfpXmGwr76XysM7kty0PsloJSBr4Vz/JRh+3oNv4nEzZTMUD5nPAKPU
         bMay40lxp632XH2jOvoakMsN6ai82/dY2oY8W3b11A794yUhGGNe4WNJJwi2i+mRBe2C
         YJUIUysF3CeGyMNpf3yk6QTIk4Ayt9ERqe28tXPFnM7rF+Vl0J7DGvTO9G6qnWCU2NNi
         IweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQDbrZzTyIu0DglbWKhFLaeyxSO75uKLoMfSjkuf9YI=;
        b=0jVMyftdAL5H6EkhK3YqRLE2m8T7ECB1d/z4QDCR2NsePf+6U+NeQ0sWY9cxAIMxEa
         P3qaKzfFq2VnXvgmr7aZKAuanRZB3bLoWPfpI841oQQAVgIE2QFtGyU9J4lAcJwgAGKE
         5G2Mn3/xZbA9H3gGQhYM9mS2HuuHYkRnNk5szUoI1kygWj1M+2UcTLkPbhZGlOlCU3Kh
         7indVdyp6nOjGVwslQkRZ1iV6RryOpIN1erDYaE4HvGzNv23MDTqk1NWZnHMb2cj6M6L
         qQmvUWfHJVhaBWnGYpGTyABui2TVhiM837WADWUUBTs+Ub3+oJ/jYfzd6FQF5eoUNMHV
         Xrhg==
X-Gm-Message-State: AO0yUKWmOl20LBwFE+5lg0Vn2jb2yxm/YddRWI6JsiqOy1pxBQtm8Dzc
        NyhMoRtAE885TzihUXTHpNpkmA==
X-Google-Smtp-Source: AK7set9FPJDzm1Vj7zrXvpQzx9aw3H/dbD9ad4OcovBUQOY/lXbpxGaorLf2uPObOVPYJr4I3dCEiA==
X-Received: by 2002:a5d:6502:0:b0:2c6:85ef:3cd2 with SMTP id x2-20020a5d6502000000b002c685ef3cd2mr221046wru.33.1676817499495;
        Sun, 19 Feb 2023 06:38:19 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:6f43:b92:7670:463])
        by smtp.gmail.com with ESMTPSA id a18-20020adfe5d2000000b002be505ab59asm86176wrn.97.2023.02.19.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:38:19 -0800 (PST)
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
Subject: [PATCH v1 17/17] thermal/traces: Replace the thermal zone structure parameter with the field value
Date:   Sun, 19 Feb 2023 15:36:57 +0100
Message-Id: <20230219143657.241542-18-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230219143657.241542-1-daniel.lezcano@linaro.org>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
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
index e06c76b38c04..0f6af8ab2f41 100644
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

