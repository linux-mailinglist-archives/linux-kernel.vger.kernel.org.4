Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4583469FC81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjBVTwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjBVTwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:52:43 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038036FCB;
        Wed, 22 Feb 2023 11:52:19 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id ck15so36308878edb.0;
        Wed, 22 Feb 2023 11:52:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZwPQRuLQP6UL5up9fDO+Qcq5MFiciPgHxE8AhXBJug=;
        b=N6nLKaLVOmP2Kx4J6GVIaGlO28iPihZPof8JrbgIR5sj181cl9yN1OM+lQrYW6KkxK
         obK701UcrQh7ffUBCLugC/ldoXfymiEs+doXs8t3++/7lyZv2oCn9NkmsAmsKz6fz9Fb
         oLHnB3u2Lcca7C36mUkxbml8EXy0KmxNLpxcrRFromARnQrDazUhvWi99wQtJ/SaAUT0
         u2n/xOxfhkgg46PWuTe2QFDdt+J/UnTh44R81zQTZvh/+HjZO76DMZLSy8faTACCfTyh
         zZQf3P692/8IWsaGCDxSqZgcucVsZxlaGUgvrHBfC1MmDUUGAD4lFRKImzKSTxFwWmH0
         Imxw==
X-Gm-Message-State: AO0yUKWgxmYdSJ9ZLelo7b1N6OiBLMT4UDl+PUUyDF/Q2KH3mpTW0/wW
        C4KVLe7NIv+CFgzAy3js4zskV47tRK0V5yM6mCg=
X-Google-Smtp-Source: AK7set8vPU50z4GYuEhi2ZAWC7tAxiu/28GekNga1+JS1mfI2IMf/S8qE2OeDtEe+WUcihGhnlhIZ3YRibE/wEmNV+k=
X-Received: by 2002:a50:c310:0:b0:4ad:7482:cd3b with SMTP id
 a16-20020a50c310000000b004ad7482cd3bmr5612552edb.6.1677095517224; Wed, 22 Feb
 2023 11:51:57 -0800 (PST)
MIME-Version: 1.0
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org> <20230221180710.2781027-17-daniel.lezcano@linaro.org>
In-Reply-To: <20230221180710.2781027-17-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 20:51:46 +0100
Message-ID: <CAJZ5v0jfZ2_LyPC9ArnSfHpYgr379HBhk5ODyESoewL_ee1wYw@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] thermal/traces: Replace the thermal zone
 structure parameter with the field value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 7:08 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> In the work of the thermal zone device self-encapsulation, let's pass
> the field value instead of dereferencing them in the traces which
> force us to export publicly the thermal_zone_device structure.
>
> No fonctionnal change intended.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/gov_fair_share.c              |  2 +-
>  drivers/thermal/gov_power_allocator.c         |  4 ++--
>  drivers/thermal/gov_step_wise.c               |  2 +-
>  drivers/thermal/thermal_core.c                |  5 ++--
>  include/trace/events/thermal.h                | 24 +++++++++----------
>  .../trace/events/thermal_power_allocator.h    | 12 +++++-----
>  6 files changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/thermal/gov_fair_share.c b/drivers/thermal/gov_fair_share.c
> index aad7d5fe3a14..e6c21abaaa80 100644
> --- a/drivers/thermal/gov_fair_share.c
> +++ b/drivers/thermal/gov_fair_share.c
> @@ -35,7 +35,7 @@ static int get_trip_level(struct thermal_zone_device *tz)
>          * point, in which case, trip_point = count - 1
>          */
>         if (count > 0)
> -               trace_thermal_zone_trip(tz, count - 1, trip.type);
> +               trace_thermal_zone_trip(tz->type, tz->id, count - 1, trip.type);

Haven't you introduced an accessor for tz->id in this series?  Why not
use it here?

And there can be an analogous accessor for tz->type.

If there are accessors like that, they should be used consistently
everywhere as applicable IMO.

>
>         return count;
>  }
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 0eaf1527d3e3..aaa8b57434ef 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -266,7 +266,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
>
>         power_range = clamp(power_range, (s64)0, (s64)max_allocatable_power);
>
> -       trace_thermal_power_allocator_pid(tz, frac_to_int(err),
> +       trace_thermal_power_allocator_pid(tz->id, frac_to_int(err),
>                                           frac_to_int(params->err_integral),
>                                           frac_to_int(p), frac_to_int(i),
>                                           frac_to_int(d), power_range);
> @@ -481,7 +481,7 @@ static int allocate_power(struct thermal_zone_device *tz,
>                 i++;
>         }
>
> -       trace_thermal_power_allocator(tz, req_power, total_req_power,
> +       trace_thermal_power_allocator(tz->id, req_power, total_req_power,
>                                       granted_power, total_granted_power,
>                                       num_actors, power_range,
>                                       max_allocatable_power, tz->temperature,
> diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
> index 31235e169c5a..f469e04770fe 100644
> --- a/drivers/thermal/gov_step_wise.c
> +++ b/drivers/thermal/gov_step_wise.c
> @@ -109,7 +109,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id
>
>         if (tz->temperature >= trip.temperature) {
>                 throttle = true;
> -               trace_thermal_zone_trip(tz, trip_id, trip.type);
> +               trace_thermal_zone_trip(tz->type, tz->id, trip_id, trip.type);
>         }
>
>         dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 73b7a060f768..48987129b20d 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -336,7 +336,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>         if (trip_temp <= 0 || tz->temperature < trip_temp)
>                 return;
>
> -       trace_thermal_zone_trip(tz, trip, trip_type);
> +       trace_thermal_zone_trip(tz->type, tz->id, trip, trip_type);
>
>         if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
>                 tz->ops->hot(tz);
> @@ -387,7 +387,8 @@ static void update_temperature(struct thermal_zone_device *tz)
>         tz->last_temperature = tz->temperature;
>         tz->temperature = temp;
>
> -       trace_thermal_temperature(tz);
> +       trace_thermal_temperature(tz->type, tz->id,
> +                                 tz->last_temperature, tz->temperature);
>
>         thermal_genl_sampling_temp(tz->id, temp);
>  }
> diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
> index e58bf3072f32..50c7d2e1526d 100644
> --- a/include/trace/events/thermal.h
> +++ b/include/trace/events/thermal.h
> @@ -23,22 +23,22 @@ TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
>
>  TRACE_EVENT(thermal_temperature,
>
> -       TP_PROTO(struct thermal_zone_device *tz),
> +       TP_PROTO(const char *type, int id, int temp_prev, int temp),
>
> -       TP_ARGS(tz),
> +       TP_ARGS(type, id, temp_prev, temp),
>
>         TP_STRUCT__entry(
> -               __string(thermal_zone, tz->type)
> +               __string(thermal_zone, type)
>                 __field(int, id)
>                 __field(int, temp_prev)
>                 __field(int, temp)
>         ),
>
>         TP_fast_assign(
> -               __assign_str(thermal_zone, tz->type);
> -               __entry->id = tz->id;
> -               __entry->temp_prev = tz->last_temperature;
> -               __entry->temp = tz->temperature;
> +               __assign_str(thermal_zone, type);
> +               __entry->id = id;
> +               __entry->temp_prev = temp_prev;
> +               __entry->temp = temp;
>         ),
>
>         TP_printk("thermal_zone=%s id=%d temp_prev=%d temp=%d",
> @@ -67,21 +67,21 @@ TRACE_EVENT(cdev_update,
>
>  TRACE_EVENT(thermal_zone_trip,
>
> -       TP_PROTO(struct thermal_zone_device *tz, int trip,
> +       TP_PROTO(const char *type, int id, int trip,
>                 enum thermal_trip_type trip_type),
>
> -       TP_ARGS(tz, trip, trip_type),
> +       TP_ARGS(type, id, trip, trip_type),
>
>         TP_STRUCT__entry(
> -               __string(thermal_zone, tz->type)
> +               __string(thermal_zone, type)
>                 __field(int, id)
>                 __field(int, trip)
>                 __field(enum thermal_trip_type, trip_type)
>         ),
>
>         TP_fast_assign(
> -               __assign_str(thermal_zone, tz->type);
> -               __entry->id = tz->id;
> +               __assign_str(thermal_zone, type);
> +               __entry->id = id;
>                 __entry->trip = trip;
>                 __entry->trip_type = trip_type;
>         ),
> diff --git a/include/trace/events/thermal_power_allocator.h b/include/trace/events/thermal_power_allocator.h
> index 1c8fb95544f9..7ac049e7e3cf 100644
> --- a/include/trace/events/thermal_power_allocator.h
> +++ b/include/trace/events/thermal_power_allocator.h
> @@ -8,12 +8,12 @@
>  #include <linux/tracepoint.h>
>
>  TRACE_EVENT(thermal_power_allocator,
> -       TP_PROTO(struct thermal_zone_device *tz, u32 *req_power,
> +       TP_PROTO(int id, u32 *req_power,
>                  u32 total_req_power, u32 *granted_power,
>                  u32 total_granted_power, size_t num_actors,
>                  u32 power_range, u32 max_allocatable_power,
>                  int current_temp, s32 delta_temp),
> -       TP_ARGS(tz, req_power, total_req_power, granted_power,
> +       TP_ARGS(id, req_power, total_req_power, granted_power,
>                 total_granted_power, num_actors, power_range,
>                 max_allocatable_power, current_temp, delta_temp),
>         TP_STRUCT__entry(
> @@ -29,7 +29,7 @@ TRACE_EVENT(thermal_power_allocator,
>                 __field(s32,           delta_temp               )
>         ),
>         TP_fast_assign(
> -               __entry->tz_id = tz->id;
> +               __entry->tz_id = id;
>                 memcpy(__get_dynamic_array(req_power), req_power,
>                         num_actors * sizeof(*req_power));
>                 __entry->total_req_power = total_req_power;
> @@ -56,9 +56,9 @@ TRACE_EVENT(thermal_power_allocator,
>  );
>
>  TRACE_EVENT(thermal_power_allocator_pid,
> -       TP_PROTO(struct thermal_zone_device *tz, s32 err, s32 err_integral,
> +       TP_PROTO(int id, s32 err, s32 err_integral,
>                  s64 p, s64 i, s64 d, s32 output),
> -       TP_ARGS(tz, err, err_integral, p, i, d, output),
> +       TP_ARGS(id, err, err_integral, p, i, d, output),
>         TP_STRUCT__entry(
>                 __field(int, tz_id       )
>                 __field(s32, err         )
> @@ -69,7 +69,7 @@ TRACE_EVENT(thermal_power_allocator_pid,
>                 __field(s32, output      )
>         ),
>         TP_fast_assign(
> -               __entry->tz_id = tz->id;
> +               __entry->tz_id = id;
>                 __entry->err = err;
>                 __entry->err_integral = err_integral;
>                 __entry->p = p;
> --
> 2.34.1
>
