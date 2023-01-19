Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7F6739BD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjASNRB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Jan 2023 08:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjASNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:16:33 -0500
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58906273B;
        Thu, 19 Jan 2023 05:16:04 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id hw16so5512543ejc.10;
        Thu, 19 Jan 2023 05:16:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuPJLNGabGsbrlhOcRlric/iKXyS+94jimdrGMQDzRE=;
        b=3ay//uwSRm4bvKkKKm3HECMN2gdhLqJGLzK5y5oXcz5D2qf9ukl6Y6bDXdgiFgFqjf
         N3CfUa7bbGmS456SMhYokfkdSYaVpBAwJx4mePpM0uY3gVHVgaPvGg2zOI9VAeo3kXA5
         pK7571tS2ZeUsaFdptREICkSPlQmf/HwhYtSbVRv7a8zX8rN61EjKIybqf+MefjzEoHu
         vvdW+5frlT5AVDv+1ntM7ZZlomLaps5jpMxyrGj2KIuAeDiFlsjNJff8oTHRKQqdztSN
         Ie8PidHluP9pNjIjdkQu6DPyP19YmNmlzSRwXguXmyxcyAdQXH6CqOpEmZH6zxD7vRVu
         9aTg==
X-Gm-Message-State: AFqh2kr+71It4lMiLMcu+qZj7wccAqiZwC0POn9W+oPQhsMXsIcSk1ZQ
        56pskvtd/tfSNou0TXrBfkforCdoNRnBzmhEISA=
X-Google-Smtp-Source: AMrXdXtOG5Q7pPaecvDpTIChm1p3y9e1jZJMVt2IIBa/XY1dr4U4h/3wyHk7G/kRC5FQymcC4cIkmjFw5tOuEVroZ8I=
X-Received: by 2002:a17:906:a20c:b0:7c1:5ff0:6cc2 with SMTP id
 r12-20020a170906a20c00b007c15ff06cc2mr914845ejy.246.1674134162844; Thu, 19
 Jan 2023 05:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org> <20230113180235.1604526-2-daniel.lezcano@linaro.org>
In-Reply-To: <20230113180235.1604526-2-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 14:15:51 +0100
Message-ID: <CAJZ5v0jDF9qrQAQM1AhT-Q4A3Nzyht9XxZoZyS1afoAPt1h_=A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] thermal/acpi: Add ACPI trip point routines
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rui.zhang@intel.com,
        christophe.jaillet@wanadoo.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 7:02 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The ACPI specification describes the trip points, the device tree
> bindings as well.
>
> The OF code uses the generic trip point structures.
>
> The ACPI has their own trip points structure and uses the get_trip_*
> ops to retrieve them.
>
> We can do the same as the OF code and create a set of ACPI functions
> to retrieve a trip point description. Having a common code for ACPI
> will help to cleanup the remaining Intel drivers and get rid of the
> get_trip_* functions.
>
> These changes add the ACPI thermal calls to retrieve the basic
> information we need to be reused in the thermal ACPI and Intel
> drivers.
>
> The different ACPI functions have the generic trip point structure
> passed as parameter where it is filled.
>
> This structure aims to be the one used by all the thermal drivers and
> the thermal framework.
>
> After this series, a couple of Intel drivers and the ACPI thermal
> driver will still have their own trip points definition but a new
> series on top of this one will finish the conversion to the generic
> trip point handling.
>
> This series depends on the generic trip point added to the thermal
> framework and available in the thermal/linux-next branch.
>
>  https://lkml.org/lkml/2022/10/3/456
>
> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.

Some names of the functions defined below can be less cryptic IMO.
Please see the following comments.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/thermal/Kconfig        |   4 +
>  drivers/thermal/Makefile       |   1 +
>  drivers/thermal/thermal_acpi.c | 209 +++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |   8 ++
>  4 files changed, 222 insertions(+)
>  create mode 100644 drivers/thermal/thermal_acpi.c
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index e052dae614eb..eaeb2b2ee6e9 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -76,6 +76,10 @@ config THERMAL_OF
>           Say 'Y' here if you need to build thermal infrastructure
>           based on device tree.
>
> +config THERMAL_ACPI
> +       depends on ACPI
> +       bool
> +
>  config THERMAL_WRITABLE_TRIPS
>         bool "Enable writable trip points"
>         help
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index 2506c6c8ca83..60f0dfa9aae2 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)         += thermal_netlink.o
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)            += thermal_hwmon.o
>  thermal_sys-$(CONFIG_THERMAL_OF)               += thermal_of.o
> +thermal_sys-$(CONFIG_THERMAL_ACPI)             += thermal_acpi.o
>
>  # governors
>  thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)   += gov_fair_share.o
> diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
> new file mode 100644
> index 000000000000..ef6f10713650
> --- /dev/null
> +++ b/drivers/thermal/thermal_acpi.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2022 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * ACPI thermal configuration
> + */
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/units.h>
> +#include <uapi/linux/thermal.h>
> +
> +#include "thermal_core.h"
> +
> +/*
> + * An hysteresis value below zero is invalid and we can consider a
> + * value greater than 20°K/°C is invalid too.
> + */
> +#define HYSTERESIS_MIN_DECIK   0
> +#define HYSTERESIS_MAX_DECIK   200

If the full word "hysteresis" is used here, it should also be used in
the hysteresis-related names below.

I would use the "hyst" abbreviation here and elsewhere where applicable.

> +
> +/*
> + * Minimum temperature for full military grade is 218°K (-55°C) and
> + * max temperature is 448°K (175°C). We can consider those values as
> + * the boundaries for the [trips] temperature returned by the
> + * firmware. Any values out of these boundaries can be considered
> + * bogus and we can assume the firmware has no data to provide.
> + */
> +#define TEMPERATURE_MIN_DECIK  2180
> +#define TEMPERATURE_MAX_DECIK  4480

Like the above, but regarding "temperature" and "temp" instead of
"hysteresis" and "hyst", respectively.

> +
> +static int thermal_acpi_get_temperature_object(struct acpi_device *adev,
> +                                              char *object, int *temperature)

So this would become thermal_acpi_get_temp_object(). or even
thermal_acpi_get_temp() because it really returns the temperature
value.

I also don't particularly like returning values via pointers, which is
entirely avoidable here, because the temperature value obtained from
the ACPI control methods must be a positive number.

So I would make it

static int thermal_acpi_get_temp(struct acpi_device *adev, char *object_name)
{

which would be consistent with the definition of the hysteresis
function below (which returns the value directly).

> +{
> +       unsigned long long temp;
> +       acpi_status status;
> +
> +       status = acpi_evaluate_integer(adev->handle, object, NULL, &temp);
> +       if (ACPI_FAILURE(status)) {
> +               acpi_handle_debug(adev->handle, "No temperature object '%s'\n", object);

This message may not be true, because status need not be AE_NOT_FOUND.

> +               return -ENODEV;
> +       }
> +
> +       if (temp < TEMPERATURE_MIN_DECIK || temp >= TEMPERATURE_MAX_DECIK) {
> +               acpi_handle_info(adev->handle, "Invalid temperature '%llu deci°K' for object '%s'\n",
> +                                temp, object);

I think that the message can be debug-level as well and I would just
say "Invalid value %llu returned by %s\n" in it.

> +               return -ENODATA;

And I'm not sure if the difference between -ENODEV and -ENODATA
matters here.  Maybe return -ENODATA in all error cases?

> +       }
> +
> +       *temperature = deci_kelvin_to_millicelsius(temp);
> +
> +       return 0;
> +}
> +
> +/**
> + * thermal_acpi_trip_gtsh() - Get the global hysteresis value

thermal_acpi_global_hyst() please.

> + * @adev: the acpi device to get the description from
> + *
> + * Get the global hysteresis value for the trip points. If any call
> + * fail, we shall return a zero hysteresis value.
> + *
> + * Return: An integer between %HYSTERESIS_MIN_DECIK and %HYSTERESIS_MAX_DECIK
> + */
> +int thermal_acpi_trip_gtsh(struct acpi_device *adev)
> +{
> +       unsigned long long hyst;
> +       acpi_status status;
> +
> +       status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);

GTSH is not a standard ACPI thing.

AFAICS, it's int3403 specific, so using it in a generic ACPI library
is questionable.

> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       if (hyst < HYSTERESIS_MIN_DECIK || hyst >= HYSTERESIS_MAX_DECIK) {
> +               acpi_handle_info(adev->handle, "Invalid hysteresis '%llu deci°K' for object 'GTSH'\n",
> +                                hyst);
> +               return 0;
> +       }
> +
> +       return deci_kelvin_to_millicelsius(hyst);
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_gtsh);
> +
> +/**
> + * thermal_acpi_trip_act() - Get the specified active trip point

thermal_acpi_active_trip_temp, please.

> + * @adev: the acpi device to get the description from

Please spell ACPI in capitals in all comments.

And I would say

@adev: Thermal zone ACPI device object

> + * @trip: a &struct thermal_trip to be filled if the function succeed

@trip: Trip point structure to be populated on success

> + * @id: an integer speciyfing the active trip point id

@id: Active cooling level (0 - 9)

> + *
> + * The function calls the ACPI framework to get the "_ACTx" objects
> + * which describe the active trip points.

No, it doesn't do that.  What it really does can be described as

"Evaluate the _ACx object for the thermal zone represented by @adev to
obtain the temperature of the active cooling trip point corresponding
to the active cooling level given by @id and initialize @trip as an
active trip point using that temperature value"

> The @id builds the "_ACTx"
> + * string with the numbered active trip point name. Then it fills the
> + * @trip structure with the information retrieved from those objects.
> + *
> + * Return:
> + * * 0 - Success
> + * * -ENODEV - Failed to retrieve the ACPI object
> + * * -ENODATA - The ACPI object value appears to be inconsistent
> + */
> +int thermal_acpi_trip_act(struct acpi_device *adev,
> +                         struct thermal_trip *trip, int id)
> +{
> +       char name[5];

char name[] = "_AC0";

> +       int ret;

int temp;

if (id < 0 || id > 9)
        return -EINVAL;

name[3] += id;

> +
> +       sprintf(name, "_AC%d", id);
> +
> +       ret = thermal_acpi_get_temperature_object(adev, name, &trip->temperature);
> +       if (ret)
> +               return ret;

temp = thermal_acpi_get_temp(adev, name);
if (temp < 0)
        return temp;

trip->temperature = temp;

And analogously below.

> +
> +       trip->hysteresis = 0;
> +       trip->type = THERMAL_TRIP_ACTIVE;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_act);
> +
> +/**
> + * thermal_acpi_trip_psv() - Get the passive trip point

thermal_acpi_passive_trip_temp, please.

> + * @adev: the acpi device to get the description from
> + * @trip: a &struct thermal_trip to be filled if the function succeed

The same comments as above apply.

> + *
> + * The function calls the ACPI framework to get the "_PSV" object
> + * which describe the passive trip point. Then it fills the @trip
> + * structure with the information retrieved from those objects.

"Evaluate the _PSV object for the thermal zone represented by @adev to
obtain the temperature of the passive cooling trip point and
initialize @trip as a passive trip point using that temperature
value."

> + *
> + * Return:
> + * * 0 - Success
> + * * -ENODEV - Failed to retrieve the ACPI object
> + * * -ENODATA - The ACPI object value appears to be inconsistent
> + */
> +int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +       int ret;
> +
> +       ret = thermal_acpi_get_temperature_object(adev, "_PSV", &trip->temperature);
> +       if (ret)
> +               return ret;
> +
> +       trip->hysteresis = 0;
> +       trip->type = THERMAL_TRIP_PASSIVE;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_psv);
> +
> +/**
> + * thermal_acpi_trip_hot() - Get the near critical trip point

thermal_acpi_hot_trip_temp, please.

> + * @adev: the acpi device to get the description from
> + * @trip: a &struct thermal_trip to be filled if the function succeed

The same comments as above apply.

> + *
> + * The function calls the ACPI framework to get the "_HOT" object
> + * which describe the hot trip point. Then it fills the @trip
> + * structure with the information retrieved from those objects.

"Evaluate the _HOT object for the thermal zone represented by @adev to
obtain the temperature of the trip point at which the system is
expected to be put into the S4 sleep state and initialize @trip as a
hot trip point using that temperature value."

> + *
> + * Return:
> + * * 0 - Success
> + * * -ENODEV - Failed to retrieve the ACPI object
> + * * -ENODATA - The ACPI object appears to be inconsistent
> + */
> +int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +       int ret;
> +
> +       ret = thermal_acpi_get_temperature_object(adev, "_HOT", &trip->temperature);
> +       if (ret)
> +               return ret;
> +
> +       trip->hysteresis = 0;
> +       trip->type = THERMAL_TRIP_HOT;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_hot);
> +
> +/**
> + * thermal_acpi_trip_crit() - Get the critical trip point

thermal_acpi_crit_trip_temp, please.

> + * @adev: the acpi device to get the description from
> + * @trip: a &struct thermal_trip to be filled if the function succeed

The same comments as above apply.

> + *
> + * The function calls the ACPI framework to get the "_CRT" object
> + * which describe the critical trip point. Then it fills the @trip
> + * structure with the information retrieved from this object.

"Evaluate the _CRT object for the thermal zone represented by @adev to
obtain the temperature of the critical cooling trip point and
initialize @trip as a critical trip point using that temperature
value."

> + *
> + * Return:
> + * * 0 - Success
> + * * -ENODEV - Failed to retrieve the ACPI object
> + * * -ENODATA - The ACPI object value appears to be inconsistent
> + */
> +int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip)
> +{
> +       int ret;
> +
> +       ret = thermal_acpi_get_temperature_object(adev, "_CRT", &trip->temperature);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The hysteresis value has no sense here because critical
> +        * trip point has no u-turn
> +        */
> +       trip->hysteresis = 0;
> +       trip->type = THERMAL_TRIP_CRITICAL;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_crit);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 30353e4b1424..ba2d5d4c23e2 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -334,6 +334,14 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
>  }
>  #endif
>
> +#ifdef CONFIG_THERMAL_ACPI
> +int thermal_acpi_trip_gtsh(struct acpi_device *adev);
> +int thermal_acpi_trip_crit(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_hot(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_psv(struct acpi_device *adev, struct thermal_trip *trip);
> +int thermal_acpi_trip_act(struct acpi_device *adev, struct thermal_trip *trip, int id);
> +#endif
> +
>  int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
>                             struct thermal_trip *trip);
>  int thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
> --
