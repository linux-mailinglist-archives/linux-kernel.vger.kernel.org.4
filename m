Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601725EB13D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIZTZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIZTZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:25:31 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8CD3ED41;
        Mon, 26 Sep 2022 12:25:30 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id s9so4774245qkg.4;
        Mon, 26 Sep 2022 12:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4He6dfSdCqknqBDU+G53ABWcMnjBOoVQFLt3P6ZFFX0=;
        b=XInW/g1OBxiFD3yHGOzcjDnk8wXydiq/JSOgIgUGZBgr6gFTMFGtuhuu5WtTsHwFlL
         u0nfW7spU+GRyByPOwC3ZJ1+D7rc1kRxwhV4ZQZJvUTmqQ261cp1p7/wfenQqMOUFozS
         3qHSh7YZFXkTDx1Hug7UNcucFNmzZ1zIR7POiVvaiXJvYaQhngtM4o+U9P7bUI3Dtvhp
         uDPwvxGImtjrbrLb9sQ5g6qOGicxbGoFXcftHqgJs63M5uhhJEoJIs3xI6H57dBOPunj
         7wmUPz5Cw4SEPlrcDOcARJ5McGaSio/065r381Gi7+D9lOuHvtAhhjl+lS5etnI84Ioq
         mJow==
X-Gm-Message-State: ACrzQf2yY1mktyrQSe+VgPsq6ZkUKkUxu2lD8iOFSgc30k+dRdAKZm6U
        4HfNPteYcfibb7GVDhBDY39HdWjXrL/Z2X0wSGs=
X-Google-Smtp-Source: AMsMyM7YAL22JO7hSXglZT4P9VM4JRd0Qv+O7KzjeuP3b+Bja4P+dm+Y6SDP1r5Enq50NjoKJPgqA+ZWtKOx3WQ6Ods=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr15924460qko.480.1664220329581; Mon, 26
 Sep 2022 12:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org> <20220926140604.4173723-4-daniel.lezcano@linaro.org>
In-Reply-To: <20220926140604.4173723-4-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 21:25:18 +0200
Message-ID: <CAJZ5v0hJ7Tq1pU1hSqswPF_+KZOt1jNKvmqTeF5=1npReqmA3A@mail.gmail.com>
Subject: Re: [PATCH v5 03/30] thermal/core: Add a generic thermal_zone_set_trip()
 function
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
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

On Mon, Sep 26, 2022 at 4:06 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The thermal zone ops defines a set_trip callback where we can invoke
> the backend driver to set an interrupt for the next trip point
> temperature being crossed the way up or down, or setting the low level
> with the hysteresis.
>
> The ops is only called from the thermal sysfs code where the userspace
> has the ability to modify a trip point characteristic.
>
> With the effort of encapsulating the thermal framework core code,
> let's create a thermal_zone_set_trip() which is the writable side of
> the thermal_zone_get_trip() and put there all the ops encapsulation.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c  | 45 +++++++++++++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c | 48 +++++++++++----------------------
>  include/linux/thermal.h         |  3 +++
>  3 files changed, 64 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 903a858df35f..9f61b0ab57b7 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1212,6 +1212,51 @@ int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
>
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> +                         const struct thermal_trip *trip)
> +{
> +       struct thermal_trip t;
> +       int ret = -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +
> +       if (!tz->ops->set_trip_temp && !tz->ops->set_trip_hyst && !tz->trips)
> +               goto out;
> +
> +       ret = __thermal_zone_get_trip(tz, trip_id, &t);
> +       if (ret)
> +               goto out;
> +
> +       if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {

The inner parens are not needed here and below.

> +

And the extra empty line is not needed here (and below) too IMO.

> +               ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
> +
> +               ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       if (((t.temperature != trip->temperature) ||
> +            (t.hysteresis != trip->hysteresis)) && tz->trips)
> +               tz->trips[trip_id] = *trip;

I would write this as

if (tz->trips && (t.temperature != trip->temperature || t.hysteresis
!= trip->hysteresis))
        tz->trips[trip_id] = *trip;

But

1. Do we want to copy the trip type here too?
2. If tz->trips is set, do we still want to invoke ->set_trip_temp()
or ->set_trip_hyst() if they are present?

> +
> +out:
> +       mutex_unlock(&tz->lock);
> +
> +       if (!ret) {
> +               thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
> +                                             trip->temperature, trip->hysteresis);
> +               thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * thermal_zone_device_register_with_trips() - register a new thermal zone device
>   * @type:      the thermal zone device type
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 18cdd7cd0008..8d7b25ab67c2 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -115,31 +115,20 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>         struct thermal_trip trip;
>         int trip_id, ret;
>
> -       if (!tz->ops->set_trip_temp && !tz->trips)
> -               return -EPERM;
> -
>         if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>                 return -EINVAL;
>
> -       if (kstrtoint(buf, 10, &trip.temperature))
> -               return -EINVAL;
> -
> -       ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
> +       ret = thermal_zone_get_trip(tz, trip_id, &trip);
>         if (ret)
>                 return ret;
>
> -       if (tz->trips)
> -               tz->trips[trip_id].temperature = trip.temperature;
> +       if (kstrtoint(buf, 10, &trip.temperature))
> +               return -EINVAL;
>
> -       ret = thermal_zone_get_trip(tz, trip_id, &trip);
> +       ret = thermal_zone_set_trip(tz, trip_id, &trip);
>         if (ret)
>                 return ret;
>
> -       thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
> -                                     trip.temperature, trip.hysteresis);
> -
> -       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> -
>         return count;
>  }
>
> @@ -166,29 +155,24 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
>                       const char *buf, size_t count)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip, ret;
> -       int temperature;
> -
> -       if (!tz->ops->set_trip_hyst)
> -               return -EPERM;
> +       struct thermal_trip trip;
> +       int trip_id, ret;
>
> -       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
> +       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>                 return -EINVAL;
>
> -       if (kstrtoint(buf, 10, &temperature))
> -               return -EINVAL;
> +       ret = thermal_zone_get_trip(tz, trip_id, &trip);
> +       if (ret)
> +               return ret;
>
> -       /*
> -        * We are not doing any check on the 'temperature' value
> -        * here. The driver implementing 'set_trip_hyst' has to
> -        * take care of this.
> -        */
> -       ret = tz->ops->set_trip_hyst(tz, trip, temperature);
> +       if (kstrtoint(buf, 10, &trip.hysteresis))
> +               return -EINVAL;
>
> -       if (!ret)
> -               thermal_zone_set_trips(tz);
> +       ret = thermal_zone_set_trip(tz, trip_id, &trip);
> +       if (ret)
> +               return ret;
>
> -       return ret ? ret : count;
> +       return count;
>  }
>
>  static ssize_t
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 09dc09228717..5350a437f245 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -338,6 +338,9 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>  int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>                           struct thermal_trip *trip);
>
> +int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> +                         const struct thermal_trip *trip);
> +
>  int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>
>  #ifdef CONFIG_THERMAL
> --
> 2.34.1
>
