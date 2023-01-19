Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33568674341
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjASUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjASUE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:04:57 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1F917C6;
        Thu, 19 Jan 2023 12:04:56 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id y11so4220373edd.6;
        Thu, 19 Jan 2023 12:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVMdR0BjzfJmEICL+5SSx1r2ex/vjlCSfm19tGq42RM=;
        b=mnN0TTTAkeHrrn3JQ+iT1JyNe/MfycnM6DiCVVE7fD4j5ra7B81yU7QF9hxe9i5PJv
         +LM0WbLYhEhLVBeAu7rfjgCx/b/M5/PAE66JVVprPuAcPuFKSKhxCuKeoSNdF0o62BGI
         mzWFNN9p6da+DR3W1QT2g7t5PrJ+3IExBHSLwHk+FrF8MBiuWBSkkKpKX3Vhc8BIz7O5
         Vm8HDtpFvVEUyP1kEGxwt0cUvjR2tXMEnykg+TRPcIfH7pNXOuyJK7V9YAnW88XHtktJ
         mAE0VGSlxh5QpZCHEYBa1FKYMuG3hegjJnR4djnHIxBhHDstJUtgF9YBvSC5U6LcC5CX
         GcVA==
X-Gm-Message-State: AFqh2kqNxtg1I2x0HOYdaTYeyUP29IDQdBodlF0zYSZg+aADN/JlFFoB
        EfrVI/JPU5Fz0Qrm9rmnKv/q6JcQJOHmAhfk6jQ=
X-Google-Smtp-Source: AMrXdXtBZdgI/Hh6TetNuEgyIYo1C+IHq7d11QyhzD+OC8k6+JPG53vY2RXyUuKZuKB1fEFqTfwXGOQXjokRNdtmOu4=
X-Received: by 2002:a05:6402:2218:b0:499:b433:ec1a with SMTP id
 cq24-20020a056402221800b00499b433ec1amr1451712edb.222.1674158694701; Thu, 19
 Jan 2023 12:04:54 -0800 (PST)
MIME-Version: 1.0
References: <20230118181622.33335-1-daniel.lezcano@linaro.org> <20230118181622.33335-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230118181622.33335-3-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 21:04:43 +0100
Message-ID: <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for intel_soc_dts_iosf
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
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

How is this change related to the rest of the patch?

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
