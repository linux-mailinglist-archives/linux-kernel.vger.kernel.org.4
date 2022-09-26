Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9135EB0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiIZTBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIZTBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:01:39 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FED18049B;
        Mon, 26 Sep 2022 12:01:37 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id p202so6018505iod.6;
        Mon, 26 Sep 2022 12:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HD3ASIn3Aq5MJ8UCARjnLJqq4IF1ZmxhHUf1H75+2AI=;
        b=5HZuEKzjzY8hkyxpjARGaz0C7zdzgwJVMdI9c8YR++hMrGgYMOlCipN05IWeA04or6
         YpgxPEqmt5f1s7QyOaJrNqgetEPNtCKpd3q2aAu05NGgF1zgvDhv3IHBjIrlAkUpbJx2
         b9Smr8zKBkqckKAK49kWpWcg4MZsNquJk5r+u7ppQ/EB4swSEni3X/92apVJ+uJem70G
         30fG59ON/qQoXUUvBmeHIyKBlAftVXkODLv713hSrKTqeGAJ4Duri7jme98vP6sYeKd8
         mO00TfMLu+KVh9ZxC0bnxB1BYEQqFyrTG33L/JX1+tK9JTGUeU8nqm/M7p5l5vI3LVQe
         no/Q==
X-Gm-Message-State: ACrzQf2CM88NNRgwdWvKDVF+vV2AyoYIgk2wug9s9/3E5DkZ511k9GES
        XPtwbeBJeGwsZpCQLyAsBuqcO0tystgvJ8B4jpw=
X-Google-Smtp-Source: AMsMyM5HupMZIAHSW2mbNY8pISLblzSI03bmXm3OLsegcdlnxxjdjJ550GGEEGSaIC3/QlX4WLzVyYex8hg6IWUaWmw=
X-Received: by 2002:a05:6638:3282:b0:33f:6ed0:4c83 with SMTP id
 f2-20020a056638328200b0033f6ed04c83mr12772899jav.96.1664218895763; Mon, 26
 Sep 2022 12:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org> <20220926140604.4173723-2-daniel.lezcano@linaro.org>
In-Reply-To: <20220926140604.4173723-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 21:01:24 +0200
Message-ID: <CAJZ5v0jpy8hqkHZ+OZ+t7ZmV9tOXpHeYKk9JZS9xEBH4RGZ9yQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/30] thermal/core: Add a generic thermal_zone_get_trip()
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
> The thermal_zone_device_ops structure defines a set of ops family,
> get_trip_temp(), get_trip_hyst(), get_trip_type(). Each of them is
> returning a property of a trip point.
>
> The result is the code is calling the ops everywhere to get a trip
> point which is supposed to be defined in the backend driver. It is a
> non-sense as a thermal trip can be generic and used by the backend
> driver to declare its trip points.
>
> Part of the thermal framework has been changed and all the OF thermal
> drivers are using the same definition for the trip point and use a
> thermal zone registration variant to pass those trip points which are
> part of the thermal zone device structure.
>
> Consequently, we can use a generic function to get the trip points
> when they are stored in the thermal zone device structure.
>
> This approach can be generalized to all the drivers and we can get rid
> of the ops->get_trip_*. That will result to a much more simpler code
> and make possible to rework how the thermal trip are handled in the
> thermal core framework as discussed previously.
>
> This change adds a function thermal_zone_get_trip() where we get the
> thermal trip point structure which contains all the properties (type,
> temp, hyst) instead of doing multiple calls to ops->get_trip_*.
>
> That opens the door for trip point extension with more attributes. For
> instance, replacing the trip points disabled bitmask with a 'disabled'
> field in the structure.
>
> Here we replace all the calls to ops->get_trip_* in the thermal core
> code with a call to the thermal_zone_get_trip() function.
>
> While at it, add the thermal_zone_get_num_trips() to encapsulate the
> code more and reduce the grip with the thermal framework internals.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c    | 115 ++++++++++++++++++++++++------
>  drivers/thermal/thermal_core.h    |   2 +
>  drivers/thermal/thermal_helpers.c |  28 ++++----
>  drivers/thermal/thermal_netlink.c |  21 +++---
>  drivers/thermal/thermal_sysfs.c   |  66 +++++++----------
>  include/linux/thermal.h           |   5 ++
>  6 files changed, 148 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 99c0c19fa5a6..903a858df35f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -341,35 +341,31 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>                 tz->ops->critical(tz);
>  }
>
> -static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
> +static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
>  {
> -       enum thermal_trip_type type;
> -       int trip_temp, hyst = 0;
> +       struct thermal_trip trip;
>
>         /* Ignore disabled trip points */
> -       if (test_bit(trip, &tz->trips_disabled))
> +       if (test_bit(trip_id, &tz->trips_disabled))
>                 return;
>
> -       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -       tz->ops->get_trip_type(tz, trip, &type);
> -       if (tz->ops->get_trip_hyst)
> -               tz->ops->get_trip_hyst(tz, trip, &hyst);
> +       __thermal_zone_get_trip(tz, trip_id, &trip);
>
>         if (tz->last_temperature != THERMAL_TEMP_INVALID) {
> -               if (tz->last_temperature < trip_temp &&
> -                   tz->temperature >= trip_temp)
> -                       thermal_notify_tz_trip_up(tz->id, trip,
> +               if (tz->last_temperature < trip.temperature &&
> +                   tz->temperature >= trip.temperature)
> +                       thermal_notify_tz_trip_up(tz->id, trip_id,
>                                                   tz->temperature);
> -               if (tz->last_temperature >= trip_temp &&
> -                   tz->temperature < (trip_temp - hyst))
> -                       thermal_notify_tz_trip_down(tz->id, trip,
> +               if (tz->last_temperature >= trip.temperature &&
> +                   tz->temperature < (trip.temperature - trip.hysteresis))
> +                       thermal_notify_tz_trip_down(tz->id, trip_id,
>                                                     tz->temperature);
>         }
>
> -       if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
> -               handle_critical_trips(tz, trip, trip_temp, type);
> +       if (trip.type == THERMAL_TRIP_CRITICAL || trip.type == THERMAL_TRIP_HOT)
> +               handle_critical_trips(tz, trip_id, trip.temperature, trip.type);
>         else
> -               handle_non_critical_trips(tz, trip);
> +               handle_non_critical_trips(tz, trip_id);
>  }
>
>  static void update_temperature(struct thermal_zone_device *tz)
> @@ -1142,6 +1138,80 @@ static void thermal_set_delay_jiffies(unsigned long *delay_jiffies, int delay_ms
>                 *delay_jiffies = round_jiffies(*delay_jiffies);
>  }
>
> +int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
> +{
> +       return tz->num_trips;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
> +
> +int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
> +{
> +       int i, ret = 0;

int i, ret = -EINVAL;

> +
> +       if (tz->ops->get_crit_temp)
> +               return tz->ops->get_crit_temp(tz, temp);
> +
> +       if (!tz->trips)
> +               return -EINVAL;
> +
> +       mutex_lock(&tz->lock);
> +
> +       for (i = 0; i < tz->num_trips; i++) {
> +               if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
> +                       *temp = tz->trips[i].temperature;
> +                       goto out;

ret = 0;
break;

instead of the goto.

> +               }
> +       }
> +
> +       ret = -EINVAL;
> +out:

And the two lines above go away.

> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);

The rest of the patch looks fine to me.

> +
> +int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> +                           struct thermal_trip *trip)
> +{
> +       int ret;
> +
> +       if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
> +               return -EINVAL;
> +
> +       if (tz->trips) {
> +               *trip = tz->trips[trip_id];
> +               return 0;
> +       }
> +
> +       if (tz->ops->get_trip_hyst) {
> +               ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               trip->hysteresis = 0;
> +       }
> +
> +       ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
> +       if (ret)
> +               return ret;
> +
> +       return tz->ops->get_trip_type(tz, trip_id, &trip->type);
> +}
> +
> +int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> +                         struct thermal_trip *trip)
> +{
> +       int ret;
> +
> +       mutex_lock(&tz->lock);
> +       ret = __thermal_zone_get_trip(tz, trip_id, trip);
> +       mutex_unlock(&tz->lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_get_trip);
> +
>  /**
>   * thermal_zone_device_register_with_trips() - register a new thermal zone device
>   * @type:      the thermal zone device type
> @@ -1174,8 +1244,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                                         int polling_delay)
>  {
>         struct thermal_zone_device *tz;
> -       enum thermal_trip_type trip_type;
> -       int trip_temp;
>         int id;
>         int result;
>         int count;
> @@ -1202,7 +1270,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp))
> +       if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
>                 return ERR_PTR(-EINVAL);
>
>         tz = kzalloc(sizeof(*tz), GFP_KERNEL);
> @@ -1252,9 +1320,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                 goto release_device;
>
>         for (count = 0; count < num_trips; count++) {
> -               if (tz->ops->get_trip_type(tz, count, &trip_type) ||
> -                   tz->ops->get_trip_temp(tz, count, &trip_temp) ||
> -                   !trip_temp)
> +               struct thermal_trip trip;
> +
> +               result = thermal_zone_get_trip(tz, count, &trip);
> +               if (result)
>                         set_bit(count, &tz->trips_disabled);
>         }
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 1571917bd3c8..879e91a48435 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -113,6 +113,8 @@ int thermal_build_list_of_policies(char *buf);
>  /* Helpers */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz);
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz);
> +int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> +                           struct thermal_trip *trip);
>  int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>
>  /* sysfs I/F */
> diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> index c65cdce8f856..06dded36e95e 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -69,7 +69,7 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>         int ret = -EINVAL;
>         int count;
>         int crit_temp = INT_MAX;
> -       enum thermal_trip_type type;
> +       struct thermal_trip trip;
>
>         lockdep_assert_held(&tz->lock);
>
> @@ -80,10 +80,9 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>
>         if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
>                 for (count = 0; count < tz->num_trips; count++) {
> -                       ret = tz->ops->get_trip_type(tz, count, &type);
> -                       if (!ret && type == THERMAL_TRIP_CRITICAL) {
> -                               ret = tz->ops->get_trip_temp(tz, count,
> -                                               &crit_temp);
> +                       ret = __thermal_zone_get_trip(tz, count, &trip);
> +                       if (!ret && trip.type == THERMAL_TRIP_CRITICAL) {
> +                               crit_temp = trip.temperature;
>                                 break;
>                         }
>                 }
> @@ -124,29 +123,30 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
>
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz)
>  {
> -       int low = -INT_MAX;
> -       int high = INT_MAX;
> -       int trip_temp, hysteresis;
> +       struct thermal_trip trip;
> +       int low = -INT_MAX, high = INT_MAX;
>         int i, ret;
>
>         lockdep_assert_held(&tz->lock);
>
> -       if (!tz->ops->set_trips || !tz->ops->get_trip_hyst)
> +       if (!tz->ops->set_trips)
>                 return;
>
>         for (i = 0; i < tz->num_trips; i++) {
>                 int trip_low;
>
> -               tz->ops->get_trip_temp(tz, i, &trip_temp);
> -               tz->ops->get_trip_hyst(tz, i, &hysteresis);
> +               ret = __thermal_zone_get_trip(tz, i , &trip);
> +               if (ret)
> +                       return;
>
> -               trip_low = trip_temp - hysteresis;
> +               trip_low = trip.temperature - trip.hysteresis;
>
>                 if (trip_low < tz->temperature && trip_low > low)
>                         low = trip_low;
>
> -               if (trip_temp > tz->temperature && trip_temp < high)
> -                       high = trip_temp;
> +               if (trip.temperature > tz->temperature &&
> +                   trip.temperature < high)
> +                       high = trip.temperature;
>         }
>
>         /* No need to change trip points */
> diff --git a/drivers/thermal/thermal_netlink.c b/drivers/thermal/thermal_netlink.c
> index 050d243a5fa1..2a3190d55358 100644
> --- a/drivers/thermal/thermal_netlink.c
> +++ b/drivers/thermal/thermal_netlink.c
> @@ -452,7 +452,8 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
>         struct sk_buff *msg = p->msg;
>         struct thermal_zone_device *tz;
>         struct nlattr *start_trip;
> -       int i, id;
> +       struct thermal_trip trip;
> +       int ret, i, id;
>
>         if (!p->attrs[THERMAL_GENL_ATTR_TZ_ID])
>                 return -EINVAL;
> @@ -471,18 +472,14 @@ static int thermal_genl_cmd_tz_get_trip(struct param *p)
>
>         for (i = 0; i < tz->num_trips; i++) {
>
> -               enum thermal_trip_type type;
> -               int temp, hyst = 0;
> -
> -               tz->ops->get_trip_type(tz, i, &type);
> -               tz->ops->get_trip_temp(tz, i, &temp);
> -               if (tz->ops->get_trip_hyst)
> -                       tz->ops->get_trip_hyst(tz, i, &hyst);
> -
> +               ret = __thermal_zone_get_trip(tz, i, &trip);
> +               if (ret)
> +                       goto out_cancel_nest;
> +
>                 if (nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_ID, i) ||
> -                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, type) ||
> -                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, temp) ||
> -                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, hyst))
> +                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TYPE, trip.type) ||
> +                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_TEMP, trip.temperature) ||
> +                   nla_put_u32(msg, THERMAL_GENL_ATTR_TZ_TRIP_HYST, trip.hysteresis))
>                         goto out_cancel_nest;
>         }
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 78c5841bdfae..75f6b151a58b 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -83,20 +83,17 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       enum thermal_trip_type type;
> -       int trip, result;
> +       struct thermal_trip trip;
> +       int trip_id, result;
>
> -       if (!tz->ops->get_trip_type)
> -               return -EPERM;
> -
> -       if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
> +       if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
>                 return -EINVAL;
>
> -       result = tz->ops->get_trip_type(tz, trip, &type);
> +       result = thermal_zone_get_trip(tz, trip_id, &trip);
>         if (result)
>                 return result;
>
> -       switch (type) {
> +       switch (trip.type) {
>         case THERMAL_TRIP_CRITICAL:
>                 return sprintf(buf, "critical\n");
>         case THERMAL_TRIP_HOT:
> @@ -115,37 +112,31 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>                       const char *buf, size_t count)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip, ret;
> -       int temperature, hyst = 0;
> -       enum thermal_trip_type type;
> +       struct thermal_trip trip;
> +       int trip_id, ret;
>
>         if (!tz->ops->set_trip_temp && !tz->trips)
>                 return -EPERM;
>
> -       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
> +       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>                 return -EINVAL;
>
> -       if (kstrtoint(buf, 10, &temperature))
> +       if (kstrtoint(buf, 10, &trip.temperature))
>                 return -EINVAL;
>
> -       ret = tz->ops->set_trip_temp(tz, trip, temperature);
> +       ret = tz->ops->set_trip_temp(tz, trip_id, trip.temperature);
>         if (ret)
>                 return ret;
>
>         if (tz->trips)
> -               tz->trips[trip].temperature = temperature;
> -
> -       if (tz->ops->get_trip_hyst) {
> -               ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
> -               if (ret)
> -                       return ret;
> -       }
> +               tz->trips[trip_id].temperature = trip.temperature;
>
> -       ret = tz->ops->get_trip_type(tz, trip, &type);
> +       ret = thermal_zone_get_trip(tz, trip_id, &trip);
>         if (ret)
>                 return ret;
>
> -       thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
> +       thermal_notify_tz_trip_change(tz->id, trip_id, trip.type,
> +                                     trip.temperature, trip.hysteresis);
>
>         thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> @@ -157,21 +148,17 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip, ret;
> -       int temperature;
> -
> -       if (!tz->ops->get_trip_temp)
> -               return -EPERM;
> +       struct thermal_trip trip;
> +       int trip_id, ret;
>
> -       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
> +       if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
>                 return -EINVAL;
>
> -       ret = tz->ops->get_trip_temp(tz, trip, &temperature);
> -
> +       ret = thermal_zone_get_trip(tz, trip_id, &trip);
>         if (ret)
>                 return ret;
>
> -       return sprintf(buf, "%d\n", temperature);
> +       return sprintf(buf, "%d\n", trip.temperature);
>  }
>
>  static ssize_t
> @@ -209,18 +196,17 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
>                      char *buf)
>  {
>         struct thermal_zone_device *tz = to_thermal_zone(dev);
> -       int trip, ret;
> -       int temperature;
> +       struct thermal_trip trip;
> +       int trip_id, ret;
>
> -       if (!tz->ops->get_trip_hyst)
> -               return -EPERM;
> -
> -       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
> +       if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
>                 return -EINVAL;
>
> -       ret = tz->ops->get_trip_hyst(tz, trip, &temperature);
> +       ret = thermal_zone_get_trip(tz, trip_id, &trip);
> +       if (ret)
> +               return ret;
>
> -       return ret ? ret : sprintf(buf, "%d\n", temperature);
> +       return ret ? ret : sprintf(buf, "%d\n", trip.hysteresis);
>  }
>
>  static ssize_t
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a5a18351a898..09dc09228717 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -335,6 +335,11 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>  }
>  #endif
>
> +int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> +                         struct thermal_trip *trip);
> +
> +int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
> +
>  #ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
> --
> 2.34.1
>
