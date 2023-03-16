Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9E6BC3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 03:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCPCW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 22:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCPCWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 22:22:24 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB3B58485;
        Wed, 15 Mar 2023 19:22:12 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 89so300456uao.0;
        Wed, 15 Mar 2023 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678933331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bg0XROdODoB8eyMmTH4+ra/HdnODq0ggfSf7e2syi9M=;
        b=mTG5GJrracr0BcbjNJE8Gcj+LWtM2OPD6h8skU2aENmTqS4opQf0B3qgvqL/IY2EKj
         EXYAzXPboBFzj6ywxVRrO/A9qE9dpvoDXJ0kGqPlDZaVCBgJpcI4taiplUUOiOY0aSPj
         yEpfiVZCpPGkk9XEjxXw2W15MbInXFLgq+2gYGZwhZjY0l8rQ4799nUsNISGqBOHMuq2
         c0aQA8TBahCjnc+nXSWCqcpduz7nrA7xMXfj+lyt5yKr4rgKAd9tXHWgyJ9f7gEC6Lxt
         5CK73mCtfsJuKsC9kosCrk79FQ3e+HYBZytBIdzPZgR66npqlDwkKk89FNQt8GPWR0w7
         SaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678933331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bg0XROdODoB8eyMmTH4+ra/HdnODq0ggfSf7e2syi9M=;
        b=757aXl5eSBBmrY1InvboSc7aB50JEcxQ2YXHU3WBFra+kf0FF8qhCpVawGT90Ktl3U
         LSbq53eH4cZ/RznbAVmJhgNMu6RCgB3P1Vz8vj1NSfUu6CEjIzngBwWmOMcZiqh37z2a
         LEk76FqUflpEm8tr/W4CaqlAl1ASprc0ow1JnDxBKn1HHrr3/rZ8YZsqVJv61EuOWVYV
         D4CW4ZJq17NkoLq4iLH5MepPJZsy4vHZbd0yNF22doz+vGQRi1J+fJK8WdtXQYAwpgBP
         kh8Om0D9KfYBzIdkbDZWaD3+eUpsEZJIbTcExy02OEbtef8lr6wS91XqUnImf9ZEbAiT
         sgjQ==
X-Gm-Message-State: AO0yUKXlz+VhIFe0h3o3bLJ0PwjZBK/bYuMupGIZfKQk4w6FC8Yv5m0Z
        PYyYWT6He3wMqKh0QdSGvNqpwxVoq8WjA3bdq3k=
X-Google-Smtp-Source: AK7set/D2arbX7NL+qNnISH0POKzsK5NM81APoNKefuh3dkU2edE2aq6+fiwdA56agRtTMm296kysY8Of+jqVbt3iTw=
X-Received: by 2002:a05:6122:64a:b0:431:f19e:fdd with SMTP id
 h10-20020a056122064a00b00431f19e0fddmr8927712vkp.1.1678933331634; Wed, 15 Mar
 2023 19:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230315093008.17489-1-di.shen@unisoc.com>
In-Reply-To: <20230315093008.17489-1-di.shen@unisoc.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 16 Mar 2023 10:21:35 +0800
Message-ID: <CAAfSe-u_Ak2vQ9fU30G92SySRCqv6nihM+o46ErY8xngfAPfdA@mail.gmail.com>
Subject: Re: [PATCH V2] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2023 at 17:30, Di Shen <di.shen@unisoc.com> wrote:
>
> Commit <0952177f2a1f>(thermal/core/power_allocator: Update once
> cooling devices when temp is low) adds a update flag to avoid
> the thermal event is triggered when there is no need, and
> thermal cdev would be update once when temperature is low.
>
> But when the trips are writable, and switch_on_temp is set
> to be a higher value, the cooling device state may not be
> reset to 0, because last_temperature is smaller than the
> switch_on_temp.
>
> For example:
> First:
> swicth_on_temp=70 control_temp=85;
>
> Then userspace change the trip_temp:
> swicth_on_temp=45 control_temp=55 cur_temp=54
>
> Then userspace reset the trip_temp:
> swicth_on_temp=70 control_temp=85 cur_temp=57 last_temp=54
>
> At this time, the cooling device state should be reset to 0.
> However, because cur_temp(57) < switch_on_temp(70)
> last_temp(54) < swicth_on_temp(70)  ---->  update = false,
> update is false, the cooling device state can not be reset.
>
> This patch adds a function thermal_cdev_needs_update() to
> renew the update flag value only when the trips are writable,
> so that thermal cdev->state can be reset after switch_on_temp
> changed from low to high.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---

A change log should be provided under '---' to describe changes since
the last version, and add '---' at the end of the change log, that
will not be shown in the commit history after being applied.

Thanks,
Chunyan

>  drivers/thermal/gov_power_allocator.c | 39 ++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 0eaf1527d3e3..c9e1f3b15f15 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -59,6 +59,8 @@ static inline s64 div_frac(s64 x, s64 y)
>   *                     governor switches on when this trip point is crossed.
>   *                     If the thermal zone only has one passive trip point,
>   *                     @trip_switch_on should be INVALID_TRIP.
> + * @last_switch_on_temp:Record the last switch_on_temp only when trips
> +                       are writable.
>   * @trip_max_desired_temperature:      last passive trip point of the thermal
>   *                                     zone.  The temperature we are
>   *                                     controlling for.
> @@ -70,6 +72,9 @@ struct power_allocator_params {
>         s64 err_integral;
>         s32 prev_err;
>         int trip_switch_on;
> +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> +       int last_switch_on_temp;
> +#endif
>         int trip_max_desired_temperature;
>         u32 sustainable_power;
>  };
> @@ -554,6 +559,25 @@ static void get_governor_trips(struct thermal_zone_device *tz,
>         }
>  }
>
> +#ifdef CONFIG_THERMAL_WRITABLE_TRIPS
> +static bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
> +{
> +       bool update;
> +       struct power_allocator_params *params = tz->governor_data;
> +       int last_switch_on_temp = params->last_switch_on_temp;
> +
> +       update = (tz->last_temperature >= last_switch_on_temp);
> +       params->last_switch_on_temp = switch_on_temp;
> +
> +       return update;
> +}
> +#else
> +static inline bool thermal_cdev_needs_update(struct thermal_zone_device *tz, int switch_on_temp)
> +{
> +       return false;
> +}
> +#endif
> +
>  static void reset_pid_controller(struct power_allocator_params *params)
>  {
>         params->err_integral = 0;
> @@ -709,12 +733,15 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>                 return 0;
>
>         ret = __thermal_zone_get_trip(tz, params->trip_switch_on, &trip);
> -       if (!ret && (tz->temperature < trip.temperature)) {
> -               update = (tz->last_temperature >= trip.temperature);
> -               tz->passive = 0;
> -               reset_pid_controller(params);
> -               allow_maximum_power(tz, update);
> -               return 0;
> +       if (!ret) {
> +               update = thermal_cdev_needs_update(tz, trip.temperature);
> +               if (tz->temperature < trip.temperature) {
> +                       update |= (tz->last_temperature >= trip.temperature);
> +                       tz->passive = 0;
> +                       reset_pid_controller(params);
> +                       allow_maximum_power(tz, update);
> +                       return 0;
> +               }
>         }
>
>         tz->passive = 1;
> --
> 2.17.1
>
