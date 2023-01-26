Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD867D214
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjAZQrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjAZQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:47:50 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB533A91;
        Thu, 26 Jan 2023 08:47:47 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id bk15so6641988ejb.9;
        Thu, 26 Jan 2023 08:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVtxoYcAJiNZA/xK4oj3uHYKyVzBhkS4aamUvP5k4So=;
        b=wWKqY2USF0eaxGQx7jeJBfbatlWb7yCGbkjtp04oEH19u3+t7iXk0HgkM+c235F4AB
         mtcWpiIiztQMxG0Z2vNFKJTnUDHeuXHrLrOjOa0HSy0rLgbJZqwtJIavzUEb+y9I7Kxm
         0nS0smo1/0Sz5LLSF1gcsoq4couBoDXIs9T1Z06FkDw1JsfG4E/1v0em6RSmhkV1fP4k
         ZU+lfYIFUriIDKzLLNOU1wYIusfaPDgYLJmxGzlJSifa5Omq88phMveoP11197oLtNlA
         ej2RvjjuWvkZIxutDiLb7QEVL8zR4+Kjh5/TJNBypQcUxtLC/QFMvWyluF323OGdJb9u
         M9NA==
X-Gm-Message-State: AFqh2kos9Qiz6X2Au7h+SlqIhLlTrbAlyvfLX/IXP3HMpBj1gxBj5fDF
        wHs9vgVA+++IrsR0h6XDqlimjFIpgBKp5DDLFRk=
X-Google-Smtp-Source: AMrXdXtLNQgRLnkWewPCvyuMjfKKVUnX2TdqXxFc3uMk23jqDgCN/knZnC+Aqcyt4vOf9Qs9Dtj/UOOAuMESPJ7nw4M=
X-Received: by 2002:a17:907:d10f:b0:872:be4b:1b65 with SMTP id
 uy15-20020a170907d10f00b00872be4b1b65mr5357694ejc.125.1674751665699; Thu, 26
 Jan 2023 08:47:45 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org> <20230118181622.33335-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230118181622.33335-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 17:47:34 +0100
Message-ID: <CAJZ5v0jbHR03UyJBMmBBYnSsZmGG0OXqLJvMfXxXKVn4Np4Egw@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> From: Daniel Lezcano <daniel.lezcano@kernel.org>
>
> The thermal framework gives the possibility to register the trip
> points with the thermal zone. When that is done, no get_trip_* ops are
> needed and they can be removed.
>
> Convert ops content logic into generic trip points and register them with the
> thermal zone.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/intel/intel_soc_dts_iosf.c | 58 ++++++++--------------
>  drivers/thermal/intel/intel_soc_dts_iosf.h |  2 +-
>  2 files changed, 23 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
> index 342b0bb5a56d..130c416ec601 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.c
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
> @@ -71,20 +71,13 @@ static int get_tj_max(u32 *tj_max)
>         return err;
>  }
>
> -static int sys_get_trip_temp(struct thermal_zone_device *tzd, int trip,
> -                            int *temp)
> +static int get_trip_temp(struct intel_soc_dts_sensors *sensors, int trip, int *temp)
>  {
>         int status;
>         u32 out;
> -       struct intel_soc_dts_sensor_entry *dts;
> -       struct intel_soc_dts_sensors *sensors;
>
> -       dts = tzd->devdata;
> -       sensors = dts->sensors;
> -       mutex_lock(&sensors->dts_update_lock);
>         status = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
>                                SOC_DTS_OFFSET_PTPS, &out);
> -       mutex_unlock(&sensors->dts_update_lock);
>         if (status)
>                 return status;
>
> @@ -173,8 +166,13 @@ static int update_trip_temp(struct intel_soc_dts_sensor_entry *dts,
>         if (status)
>                 goto err_restore_te_out;
>
> -       dts->trip_types[thres_index] = trip_type;
> -
> +       status = get_trip_temp(sensors, thres_index, &temp);
> +       if (status)
> +               goto err_restore_te_out;
> +
> +       dts->trips[thres_index].type = trip_type;
> +       dts->trips[thres_index].temperature = temp;

This change doesn't look correct to me, because this function takes
temp as an argument and it is used to populate the trip with it at
least in some cases.

Why should temp be overwritten here?

> +
>         return 0;
>  err_restore_te_out:
>         iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> @@ -202,24 +200,12 @@ static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
>
>         mutex_lock(&sensors->dts_update_lock);
>         status = update_trip_temp(tzd->devdata, trip, temp,
> -                                 dts->trip_types[trip]);
> +                                 dts->trips[trip].type);
>         mutex_unlock(&sensors->dts_update_lock);
>
>         return status;
>  }
>
> -static int sys_get_trip_type(struct thermal_zone_device *tzd,
> -                            int trip, enum thermal_trip_type *type)
> -{
> -       struct intel_soc_dts_sensor_entry *dts;
> -
> -       dts = tzd->devdata;
> -
> -       *type = dts->trip_types[trip];
> -
> -       return 0;
> -}
> -
>  static int sys_get_curr_temp(struct thermal_zone_device *tzd,
>                              int *temp)
>  {
> @@ -245,8 +231,6 @@ static int sys_get_curr_temp(struct thermal_zone_device *tzd,
>
>  static struct thermal_zone_device_ops tzone_ops = {
>         .get_temp = sys_get_curr_temp,
> -       .get_trip_temp = sys_get_trip_temp,
> -       .get_trip_type = sys_get_trip_type,
>         .set_trip_temp = sys_set_trip_temp,
>  };
>
> @@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>         dts->trip_mask = trip_mask;
>         dts->trip_count = trip_count;
>         snprintf(name, sizeof(name), "soc_dts%d", id);
> -       dts->tzone = thermal_zone_device_register(name,
> +       dts->tzone = thermal_zone_device_register_with_trips(name,
> +                                                 dts->trips,
>                                                   trip_count,
>                                                   trip_mask,
>                                                   dts, &tzone_ops,
> @@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
>                 notification = false;
>         else
>                 notification = true;
> -       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> -               sensors->soc_dts[i].sensors = sensors;
> -               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
> -                                          notification, trip_count,
> -                                          read_only_trip_count);
> -               if (ret)
> -                       goto err_free;
> -       }
>
>         for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
>                 ret = update_trip_temp(&sensors->soc_dts[i], 0, 0,
>                                        THERMAL_TRIP_PASSIVE);
>                 if (ret)
> -                       goto err_remove_zone;
> +                       goto err_free;
>
>                 ret = update_trip_temp(&sensors->soc_dts[i], 1, 0,
>                                        THERMAL_TRIP_PASSIVE);
>                 if (ret)
> -                       goto err_remove_zone;
> +                       goto err_free;
>         }
>
> +       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
> +               sensors->soc_dts[i].sensors = sensors;
> +               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
> +                                          notification, trip_count,
> +                                          read_only_trip_count);
> +               if (ret)
> +                       goto err_remove_zone;
> +       }
> +
>         return sensors;
>  err_remove_zone:
>         for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i)
> diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.h b/drivers/thermal/intel/intel_soc_dts_iosf.h
> index c54945748200..ee0a39e3edd3 100644
> --- a/drivers/thermal/intel/intel_soc_dts_iosf.h
> +++ b/drivers/thermal/intel/intel_soc_dts_iosf.h
> @@ -27,7 +27,7 @@ struct intel_soc_dts_sensor_entry {
>         u32 store_status;
>         u32 trip_mask;
>         u32 trip_count;
> -       enum thermal_trip_type trip_types[2];
> +       struct thermal_trip trips[2];
>         struct thermal_zone_device *tzone;
>         struct intel_soc_dts_sensors *sensors;
>  };
> --
> 2.34.1
>
