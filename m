Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623B4736AED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjFTL3J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 07:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjFTL3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:29:07 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EA81BB;
        Tue, 20 Jun 2023 04:29:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98771dde617so109563966b.1;
        Tue, 20 Jun 2023 04:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260544; x=1689852544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xODbMfx6D4nCy/O1L+zgQFKO3V5CADY+cFzLyMMMZyc=;
        b=fF94DE1n9PYkcDcZUAIrwaPecolawwba+g0ysrBYQoZeZWulPay/fsu5OKRdm7OREu
         DSrxc2snb46yHD4ut3B3O5XsNvkAxnQLZimI7ZTvaAlHbFKs6Q15+M+8lBTZqn4YLU/h
         tFpy74Icpe531HX5bOt5BxTuftq/ZbbD5QTsk+S9i/uPJncmjpiMjof6OYDsCaiYIdFv
         MUhjuW9KAtIxtCpXanuHlDvbERn5jIHIrDqzKEwywfg9CuQDaImRANrlzkgATqs6Q7CQ
         HbYGLUmGZU3Mlb8u0ECcaMZReCU+BNtM3Wi7lUEDNXbP/3eo6XmnDkxtPa9xLx+ixZg1
         zYIQ==
X-Gm-Message-State: AC+VfDyqumZZ4RCCN9nzhQi7UuxWqpul+1b60StBuMVnydA3ewn2yzZz
        2v6ZumD3teK/2xeBCfkX/GvkejOPTEro5zPqrH8=
X-Google-Smtp-Source: ACHHUZ5DC0EOjmCMCMVELc2xDMe0iFSfU2lKxGY5T4milOLSdtOTyI8EGbgNZ9jdytPnfFcTrAvJpXOKqpKEjNipnNY=
X-Received: by 2002:a17:906:64cc:b0:987:115d:ba05 with SMTP id
 p12-20020a17090664cc00b00987115dba05mr9232791ejn.3.1687260544023; Tue, 20 Jun
 2023 04:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org> <20230525140135.3589917-5-daniel.lezcano@linaro.org>
In-Reply-To: <20230525140135.3589917-5-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 13:28:47 +0200
Message-ID: <CAJZ5v0iv6HkxmV08JyUO3K1YMPXerEb5qNobVkUNv2zW+qVh+w@mail.gmail.com>
Subject: Re: [PATCH 4/8] thermal/core: Update the generic trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        thierry.reding@gmail.com, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 4:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> At this point, the generic trip points rework allows to create a
> thermal zone with a fixed number of trip points. This usage satisfy
> almost all of the existing drivers.
>
> A few remaining drivers have a mechanism where the firmware updates
> the trip points. But there is no such update mechanism for the generic
> trip points, thus those drivers can not be converted to the generic
> approach.
>
> This patch provides a function 'thermal_zone_trips_update()' allowing
> to change the trip points of a thermal zone.
>
> At the same time, with the logic the trip points array is passed as a
> parameter to the thermal zone at creation time, we make our own
> private trip points array by copying the one passed as parameter.

So the design seems to require the caller to create a new array of
trip points and pass it to thermal_zone_trips_update(), so it can
replace the zone's trips array with it.

If only one trip point changes and there are multiple defined, this is
rather not efficient.

Do you want to prevent the core from using stale trip points this way?
 If so, it should be stated here.

Moreover, at least in the cases when num_trips doesn't change, it
might be more efficient to walk the new trips[] array and only copy
the ones that have changed over their old versions.

I am also not sure if this interface is going to be convenient from
the user's perspective, especially if the trips get sorted by the core
(in the future).  They would need to recreate the entire trips array
every time from scratch, even if only one trip point changes, which
means quite a bit of churn for thermal zones with many trip points.

It might be better to allow them to update trips in place and notify
the core about the change, all under the zone lock to prevent the core
from using trips simultaneously.

And arguably, changing num_trips would be questionable due to the
sysfs consistency reasons mentioned below.

> Note, no code has been found where the trip points update leads to a
> refresh of the trip points in sysfs, so it is very unlikey the number
> of trip points changes. However, for the sake of consistency it would
> be nicer to have the trip points being refreshed in sysfs also, but
> that could be done in a separate set of changes.

So at this point user space has already enumerated the trip points, so
it may fail if some of them go away or it may not be able to use any
new trip points appearing in sysfs.

For this reason, until there is a way to notify user space about the
need to re-enumerate trip points (and user space indicates support for
it), the only trip point property that may change in sysfs is the
temperature.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 40 ++++++++---------
>  drivers/thermal/thermal_core.h |  3 ++
>  drivers/thermal/thermal_trip.c | 78 ++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  4 ++
>  4 files changed, 102 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index afcd4197babd..3688b06401c8 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1224,32 +1224,11 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       /*
> -        * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
> -        * For example, shifting by 32 will result in compiler warning:
> -        * warning: right shift count >= width of type [-Wshift-count- overflow]
> -        *
> -        * Also "mask >> num_trips" will always be true with 32 bit shift.
> -        * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
> -        * mask >> 32 = 0x80000000
> -        * This will result in failure for the below condition.
> -        *
> -        * Check will be true when the bit 31 of the mask is set.
> -        * 32 bit shift will cause overflow of 4 byte integer.
> -        */
> -       if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
> -               pr_err("Incorrect number of thermal trips\n");
> -               return ERR_PTR(-EINVAL);
> -       }
> -
>         if (!ops) {
>                 pr_err("Thermal zone device ops not defined\n");
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
> -               return ERR_PTR(-EINVAL);
> -
>         if (!thermal_class)
>                 return ERR_PTR(-ENODEV);
>
> @@ -1283,8 +1262,22 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
>         tz->ops = ops;
>         tz->device.class = thermal_class;
>         tz->devdata = devdata;
> -       tz->trips = trips;
> -       tz->num_trips = num_trips;
> +
> +       if (trips) {
> +               result = __thermal_zone_trips_update(tz, trips, num_trips, mask);
> +               if (result)
> +                       goto remove_id;
> +       } else {
> +               /*
> +                * Legacy trip point handling
> +                */
> +               if ((!tz->ops->get_trip_type || !tz->ops->get_trip_temp) && num_trips) {
> +                       result = -EINVAL;
> +                       goto remove_id;
> +               }
> +
> +               tz->num_trips = num_trips;
> +       }
>
>         thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
>         thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
> @@ -1451,6 +1444,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>         mutex_unlock(&tz->lock);
>
>         kfree(tz->tzp);
> +       kfree(tz->trips);
>
>         put_device(&tz->device);
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 84ada34ff079..c27a9930f904 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -125,6 +125,9 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
>  void __thermal_zone_set_trips(struct thermal_zone_device *tz);
>  int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>                             struct thermal_trip *trip);
> +int __thermal_zone_trips_update(struct thermal_zone_device *tz,
> +                               struct thermal_trip *trips,
> +                               int num_trips, int mask);
>  int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
>
>  /* sysfs I/F */
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 61d927c35776..171b1902c01c 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -7,6 +7,8 @@
>   *
>   * Thermal trips handling
>   */
> +#include <linux/slab.h>
> +
>  #define THERMAL_CORE_SUBSYS
>  #include "thermal_core.h"
>
> @@ -181,3 +183,79 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>
>         return 0;
>  }
> +
> +int __thermal_zone_trips_update(struct thermal_zone_device *tz, struct thermal_trip *trips,
> +                               int num_trips, int mask)
> +{
> +       struct thermal_trip *new_trips;
> +
> +       /*
> +        * Legacy trip point handling is incompatible with this
> +        * function
> +        */
> +       if (tz->ops->get_trip_type || tz->ops->get_trip_temp) {
> +               pr_err("Legacy trip points use incompatible function '%s'\n", __func__);
> +               return -ENOSYS;
> +       }
> +
> +       /*
> +        * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
> +        * For example, shifting by 32 will result in compiler warning:
> +        * warning: right shift count >= width of type [-Wshift-count- overflow]
> +        *
> +        * Also "mask >> num_trips" will always be true with 32 bit shift.
> +        * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
> +        * mask >> 32 = 0x80000000
> +        * This will result in failure for the below condition.
> +        *
> +        * Check will be true when the bit 31 of the mask is set.
> +        * 32 bit shift will cause overflow of 4 byte integer.
> +        */
> +       if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
> +               pr_err("Incorrect number of thermal trips\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * New generic trip point handling
> +        */
> +       if (num_trips > 0 && !trips) {
> +               pr_err("Inconsistent parameters\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Allocate our private trip points array structure
> +        */
> +       new_trips = kmemdup(trips, sizeof(*trips) * num_trips, GFP_KERNEL);
> +       if (!new_trips)
> +               return -ENOMEM;
> +
> +       /*
> +        * Newly allocated thermal zone will have the 'trips' field
> +        * NULL, kfree() is immune against that
> +        */
> +       kfree(tz->trips);
> +       tz->trips = new_trips;
> +       tz->num_trips = num_trips;
> +
> +       return 0;
> +}
> +
> +int thermal_zone_trips_update(struct thermal_zone_device *tz, struct thermal_trip *trips,
> +                             int num_trips, int mask)
> +{
> +       int ret;
> +
> +       mutex_lock(&tz->lock);
> +       ret = __thermal_zone_trips_update(tz, trips, num_trips, mask);
> +       mutex_unlock(&tz->lock);
> +
> +       if (ret)
> +               return ret;
> +
> +       __thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);

This is called under tz->lock in other places AFAICS.  Why not here?

> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_trips_update);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..83937256a01c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -291,6 +291,10 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
>
>  int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
>
> +int thermal_zone_trips_update(struct thermal_zone_device *tz,
> +                             struct thermal_trip *trips,
> +                             int num_trips, int mask);
> +
>  #ifdef CONFIG_THERMAL_ACPI
>  int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
>  int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
> --
