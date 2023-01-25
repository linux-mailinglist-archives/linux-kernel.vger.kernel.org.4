Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3C667B1D0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjAYLnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAYLnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:43:10 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417E77D8F;
        Wed, 25 Jan 2023 03:43:08 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id os24so3155219ejb.8;
        Wed, 25 Jan 2023 03:43:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBTF1TSGiAaZRVBU0icYeRFxZfHVtTE6v0V1v8yFU4c=;
        b=jm6xJ022Q2spzqG8BMrma/rRBqfVlm8cAYhWNmgF2c01OwKKOg2Z7NCyJo4r/OwVJr
         TgqmwMLC20a12hN2uGFLKi9AtLgCtqwfB3wJykduaO+B+MIX1cVijG+fW4C+viC6/Ob8
         ZellhPGPlvj4ddXVwa5z3BO0B3nrNIf5ZusjJd2XBOb+1tp2zxtdLEzMi9uqk9BvTyFT
         nL9kVF3d4abWhqSPTPTFcGUgo8E7QfRvHgC1A7eZrQZP0v7QiArx+z+aYSaKp49JNo4z
         L+1JW1iwqThGPLViWrwdBhr6w+KW+v7W8RUcJJPNCRXKotSLbVSoY6jBG0gaQw3UoqS4
         dvnA==
X-Gm-Message-State: AFqh2krpmOUMsmZ+7joELjnqb64JNs7cOs3HUFsknYwUaksfPE6cXznC
        9Z0MoeklbfKRGilLWI3WgDlR8YEY6xnr1/mmiNphFP7R0AE=
X-Google-Smtp-Source: AMrXdXtIN2VSUNAsXl3bcSQXOPjSlAWUPOUH5zz0RIxZSUt+57CAf5mpRS0BvVtl3hMpSD6u9/AHyQEyPy0nSEedS34=
X-Received: by 2002:a17:906:514:b0:870:6768:ebcb with SMTP id
 j20-20020a170906051400b008706768ebcbmr4013130eja.13.1674646986531; Wed, 25
 Jan 2023 03:43:06 -0800 (PST)
MIME-Version: 1.0
References: <5916342.lOV4Wx5bFT@kreacher> <2147918.irdbgypaU6@kreacher> <CAJZ5v0gjz+QrwKmU3FVGVpW2OXNgXPmuT7nXmMxzOsf-ZfTOxQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gjz+QrwKmU3FVGVpW2OXNgXPmuT7nXmMxzOsf-ZfTOxQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Jan 2023 12:42:55 +0100
Message-ID: <CAJZ5v0gQp0C7Vxn9THpn4Pnj+WN06D2AUhF=nykQStgdphqiRg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] thermal: intel: int340x: Use generic trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 9:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jan 23, 2023 at 7:41 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > The thermal framework gives the possibility to register the trip
> > points along with the thermal zone. When that is done, no get_trip_*
> > callbacks are needed and they can be removed.
> >
> > Convert the existing callbacks content logic into generic trip points
> > initialization code and register them along with the thermal zone.
> >
> > In order to consolidate the code, use ACPI trip library functions to
> > populate generic trip points.
> >
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> > [ rjw: Subject and changelog edits, rebase ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> This fix from Srinivas:
>
> https://lore.kernel.org/linux-pm/20230123172110.376549-1-srinivas.pandruvada@linux.intel.com/
>
> clearly shows that there are problems with this patch.
>
> > ---
> >  drivers/thermal/intel/int340x_thermal/Kconfig                |    1
> >  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |  172 ++---------
> >  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h |   10
> >  3 files changed, 48 insertions(+), 135 deletions(-)
> >
> > Index: linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/Kconfig
> > +++ linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
> > @@ -9,6 +9,7 @@ config INT340X_THERMAL
> >         select THERMAL_GOV_USER_SPACE
> >         select ACPI_THERMAL_REL
> >         select ACPI_FAN
> > +       select THERMAL_ACPI
> >         select INTEL_SOC_DTS_IOSF_CORE
> >         select INTEL_TCC
> >         select PROC_THERMAL_MMIO_RAPL if POWERCAP
> > Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> > @@ -37,65 +37,6 @@ static int int340x_thermal_get_zone_temp
> >         return 0;
> >  }
> >
> > -static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
> > -                                        int trip, int *temp)
> > -{
> > -       struct int34x_thermal_zone *d = zone->devdata;
> > -       int i;
> > -
> > -       if (trip < d->aux_trip_nr)
> > -               *temp = d->aux_trips[trip];
> > -       else if (trip == d->crt_trip_id)
> > -               *temp = d->crt_temp;
> > -       else if (trip == d->psv_trip_id)
> > -               *temp = d->psv_temp;
> > -       else if (trip == d->hot_trip_id)
> > -               *temp = d->hot_temp;
> > -       else {
> > -               for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
> > -                       if (d->act_trips[i].valid &&
> > -                           d->act_trips[i].id == trip) {
> > -                               *temp = d->act_trips[i].temp;
> > -                               break;
> > -                       }
> > -               }
> > -               if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
> > -                       return -EINVAL;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> > -static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
> > -                                        int trip,
> > -                                        enum thermal_trip_type *type)
> > -{
> > -       struct int34x_thermal_zone *d = zone->devdata;
> > -       int i;
> > -
> > -       if (trip < d->aux_trip_nr)
> > -               *type = THERMAL_TRIP_PASSIVE;
> > -       else if (trip == d->crt_trip_id)
> > -               *type = THERMAL_TRIP_CRITICAL;
> > -       else if (trip == d->hot_trip_id)
> > -               *type = THERMAL_TRIP_HOT;
> > -       else if (trip == d->psv_trip_id)
> > -               *type = THERMAL_TRIP_PASSIVE;
> > -       else {
> > -               for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
> > -                       if (d->act_trips[i].valid &&
> > -                           d->act_trips[i].id == trip) {
> > -                               *type = THERMAL_TRIP_ACTIVE;
> > -                               break;
> > -                       }
> > -               }
> > -               if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
> > -                       return -EINVAL;
> > -       }
> > -
> > -       return 0;
> > -}
> > -
> >  static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
> >                                       int trip, int temp)
> >  {
> > @@ -109,20 +50,15 @@ static int int340x_thermal_set_trip_temp
> >         if (ACPI_FAILURE(status))
> >                 return -EIO;
> >
> > -       d->aux_trips[trip] = temp;
> > -
> >         return 0;
> >  }
> >
> > -
> > -static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
> > -               int trip, int *temp)
> > +static int int340x_thermal_get_global_hyst(struct acpi_device *adev, int *temp)
> >  {
> > -       struct int34x_thermal_zone *d = zone->devdata;
> >         acpi_status status;
> >         unsigned long long hyst;
> >
> > -       status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
> > +       status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
> >         if (ACPI_FAILURE(status))
> >                 *temp = 0;
> >         else
> > @@ -131,6 +67,7 @@ static int int340x_thermal_get_trip_hyst
> >         return 0;
> >  }
> >
> > +
> >  static void int340x_thermal_critical(struct thermal_zone_device *zone)
> >  {
> >         dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
> > @@ -138,58 +75,36 @@ static void int340x_thermal_critical(str
> >
> >  static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
> >         .get_temp       = int340x_thermal_get_zone_temp,
> > -       .get_trip_temp  = int340x_thermal_get_trip_temp,
> > -       .get_trip_type  = int340x_thermal_get_trip_type,
> >         .set_trip_temp  = int340x_thermal_set_trip_temp,
> > -       .get_trip_hyst =  int340x_thermal_get_trip_hyst,
> >         .critical       = int340x_thermal_critical,
> >  };
> >
> > -static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
> > -                                     int *temp)
> > -{
> > -       unsigned long long r;
> > -       acpi_status status;
> > -
> > -       status = acpi_evaluate_integer(handle, name, NULL, &r);
> > -       if (ACPI_FAILURE(status))
> > -               return -EIO;
> > -
> > -       *temp = deci_kelvin_to_millicelsius(r);
> > -
> > -       return 0;
> > -}
> > -
> >  int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone)
>
> First of all, this function can be invoked from int3403_notify() to
> update the trip points in the case of a firmware notification.
>
> This, of course, can be racing with the thermal core's use of the trip
> points and I don't think that there is a way to synchronize that right
> now.
>
> Second, the hysteresis value set by int340x_thermal_zone_add() will be
> overwritten with zero by the new code below.
>
> I'm dropping this one for now (and the fix on top of it) and we'll
> need to revisit it.

Fortunately, it looks like tz->lock is held around all invocations of
__thermal_zone_get_trip(), or at least it should be, so in principle
int3403_notify() can be made acquire tz->lock around trip updates too,
so the local mutex won't be needed any more.

Now, int3403_notify() cannot just call int340x_thermal_read_trips() as
it does now, because the trips have already been exposed via sysfs at
that point and they pretty much have to continue to be what they are,
only the temperature may change (or become invalid).

Let me try to sort this out before we continue with the transition to
the trips table.

> >  {
> > -       int trip_cnt = int34x_zone->aux_trip_nr;
> > -       int i;
> > +       int trip_cnt;
> > +       int i, ret;
> >
> > -       int34x_zone->crt_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_CRT",
> > -                                            &int34x_zone->crt_temp))
> > -               int34x_zone->crt_trip_id = trip_cnt++;
> > -
> > -       int34x_zone->hot_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_HOT",
> > -                                            &int34x_zone->hot_temp))
> > -               int34x_zone->hot_trip_id = trip_cnt++;
> > -
> > -       int34x_zone->psv_trip_id = -1;
> > -       if (!int340x_thermal_get_trip_config(int34x_zone->adev->handle, "_PSV",
> > -                                            &int34x_zone->psv_temp))
> > -               int34x_zone->psv_trip_id = trip_cnt++;
> > +       trip_cnt = int34x_zone->aux_trip_nr;
> > +
> > +       ret = thermal_acpi_trip_critical(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> > +
> > +       ret = thermal_acpi_trip_hot(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> > +
> > +       ret = thermal_acpi_trip_passive(int34x_zone->adev, &int34x_zone->trips[trip_cnt]);
> > +       if (!ret)
> > +               trip_cnt++;
> >
> >         for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
> > -               char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
> >
> > -               if (int340x_thermal_get_trip_config(int34x_zone->adev->handle,
> > -                                       name,
> > -                                       &int34x_zone->act_trips[i].temp))
> > +               ret = thermal_acpi_trip_active(int34x_zone->adev, i, &int34x_zone->trips[trip_cnt]);
> > +               if (ret)
> >                         break;
> >
> > -               int34x_zone->act_trips[i].id = trip_cnt++;
> > -               int34x_zone->act_trips[i].valid = true;
> > +               trip_cnt++;
> >         }
> >
> >         return trip_cnt;
> > @@ -208,7 +123,7 @@ struct int34x_thermal_zone *int340x_ther
> >         acpi_status status;
> >         unsigned long long trip_cnt;
> >         int trip_mask = 0;
> > -       int ret;
> > +       int i, ret;
> >
> >         int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
> >                                       GFP_KERNEL);
> > @@ -228,32 +143,35 @@ struct int34x_thermal_zone *int340x_ther
> >                 int34x_thermal_zone->ops->get_temp = get_temp;
> >
> >         status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
> > -       if (ACPI_FAILURE(status))
> > -               trip_cnt = 0;
> > -       else {
> > -               int i;
> > -
> > -               int34x_thermal_zone->aux_trips =
> > -                       kcalloc(trip_cnt,
> > -                               sizeof(*int34x_thermal_zone->aux_trips),
> > -                               GFP_KERNEL);
> > -               if (!int34x_thermal_zone->aux_trips) {
> > -                       ret = -ENOMEM;
> > -                       goto err_trip_alloc;
> > -               }
> > -               trip_mask = BIT(trip_cnt) - 1;
> > +       if (!ACPI_FAILURE(status)) {
> >                 int34x_thermal_zone->aux_trip_nr = trip_cnt;
> > -               for (i = 0; i < trip_cnt; ++i)
> > -                       int34x_thermal_zone->aux_trips[i] = THERMAL_TEMP_INVALID;
> > +               trip_mask = BIT(trip_cnt) - 1;
> > +       }
> > +
> > +       int34x_thermal_zone->trips = kzalloc(sizeof(*int34x_thermal_zone->trips) *
> > +                                            (INT340X_THERMAL_MAX_TRIP_COUNT + trip_cnt),
> > +                                             GFP_KERNEL);
> > +       if (!int34x_thermal_zone->trips) {
> > +               ret = -ENOMEM;
> > +               goto err_trips_alloc;
> >         }
> >
> >         trip_cnt = int340x_thermal_read_trips(int34x_thermal_zone);
> >
> > +       for (i = 0; i < trip_cnt; ++i)
> > +               int340x_thermal_get_global_hyst(adev, &int34x_thermal_zone->trips[i].hysteresis);
> > +
> > +       for (i = 0; i < int34x_thermal_zone->aux_trip_nr; i++) {
> > +               int34x_thermal_zone->trips[i].type = THERMAL_TRIP_PASSIVE;
> > +               int34x_thermal_zone->trips[i].temperature = THERMAL_TEMP_INVALID;
> > +       }
> > +
> >         int34x_thermal_zone->lpat_table = acpi_lpat_get_conversion_table(
> >                                                                 adev->handle);
> >
> > -       int34x_thermal_zone->zone = thermal_zone_device_register(
> > +       int34x_thermal_zone->zone = thermal_zone_device_register_with_trips(
> >                                                 acpi_device_bid(adev),
> > +                                               int34x_thermal_zone->trips,
> >                                                 trip_cnt,
> >                                                 trip_mask, int34x_thermal_zone,
> >                                                 int34x_thermal_zone->ops,
> > @@ -272,9 +190,9 @@ struct int34x_thermal_zone *int340x_ther
> >  err_enable:
> >         thermal_zone_device_unregister(int34x_thermal_zone->zone);
> >  err_thermal_zone:
> > +       kfree(int34x_thermal_zone->trips);
> >         acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
> > -       kfree(int34x_thermal_zone->aux_trips);
> > -err_trip_alloc:
> > +err_trips_alloc:
> >         kfree(int34x_thermal_zone->ops);
> >  err_ops_alloc:
> >         kfree(int34x_thermal_zone);
> > @@ -287,7 +205,7 @@ void int340x_thermal_zone_remove(struct
> >  {
> >         thermal_zone_device_unregister(int34x_thermal_zone->zone);
> >         acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
> > -       kfree(int34x_thermal_zone->aux_trips);
> > +       kfree(int34x_thermal_zone->trips);
> >         kfree(int34x_thermal_zone->ops);
> >         kfree(int34x_thermal_zone);
> >  }
> > Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > ===================================================================
> > --- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > +++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> > @@ -10,6 +10,7 @@
> >  #include <acpi/acpi_lpat.h>
> >
> >  #define INT340X_THERMAL_MAX_ACT_TRIP_COUNT     10
> > +#define INT340X_THERMAL_MAX_TRIP_COUNT INT340X_THERMAL_MAX_ACT_TRIP_COUNT + 3
> >
> >  struct active_trip {
> >         int temp;
> > @@ -19,15 +20,8 @@ struct active_trip {
> >
> >  struct int34x_thermal_zone {
> >         struct acpi_device *adev;
> > -       struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
> > -       unsigned long *aux_trips;
> > +       struct thermal_trip *trips;
> >         int aux_trip_nr;
> > -       int psv_temp;
> > -       int psv_trip_id;
> > -       int crt_temp;
> > -       int crt_trip_id;
> > -       int hot_temp;
> > -       int hot_trip_id;
> >         struct thermal_zone_device *zone;
> >         struct thermal_zone_device_ops *ops;
> >         void *priv_data;
> >
> >
> >
