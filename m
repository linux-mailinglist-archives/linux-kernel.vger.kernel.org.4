Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892686E6617
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDRNie convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Apr 2023 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDRNic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:38:32 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718C76BE;
        Tue, 18 Apr 2023 06:38:30 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-94f161ee14fso44036566b.0;
        Tue, 18 Apr 2023 06:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825109; x=1684417109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwewGy9LaTkUu8wcsC7k9mG2Kvb92vDbhG2D69lhsoM=;
        b=JmvMPrHM2HgoMaNIzRLaynOPkn2wZgiWWgRpfH5T/Eb2O8m6+hhRps3Zqs205obwGh
         h83lkQ6MwB+Q3Kj55LrqfFiSs6+n+z+j2XzM6IaFZFnRIPjhlOWoXyu+htgprm90N5sy
         FYzKeIGK4w8WUCMjcliDDU1o/tzXkh6QN1vGE/Ao/NXp68/j7qo1n2Bd3BS64anMBbJ9
         3GenNEQXgAenWCU/C8qRzFsmx43Oc5f/ENqvMwMKKQwwy7SmzcTfKogl2lGxe0oUMzVW
         S/8QswOtIhBMHQ2kYMUMXNaQo4pRjKmAys0cz/q0UlBE3NI89/Jgo4Y/Jk1vhBYrgZvx
         GH4Q==
X-Gm-Message-State: AAQBX9evVwx198ZtYA6nSkGaDOBPCWUHnFxUo6bGY+Mo7/s3hokvkdI4
        ANqq4zAcfYnLAa/sa1YHLIu09Soe4vmSDfv7M0I=
X-Google-Smtp-Source: AKy350aNuO3YOywcpBu+2omv9Du3sqUWvljqNyZxsgxVAyUKm1XDnyqv1N1ELt/0kq9+RK51TLoB/lg0a9Du0Mquzb8=
X-Received: by 2002:a17:906:24f:b0:931:4285:ea1d with SMTP id
 15-20020a170906024f00b009314285ea1dmr12535566ejl.5.1681825109277; Tue, 18 Apr
 2023 06:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org> <20230413114647.3878792-6-daniel.lezcano@linaro.org>
In-Reply-To: <20230413114647.3878792-6-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Apr 2023 15:38:18 +0200
Message-ID: <CAJZ5v0jqB18c1u-eqcEiXW+fOH=nX=Uu3xi5sp2F9udsFUrYew@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] thermal/drivers/acpi: Make cross dev link optional
 by configuration
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 1:47 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> The ACPI thermal driver creates a link in the thermal zone device
> sysfs directory pointing to the device sysfs directory. At the same
> time, it creates a back pointer link from the device to the thermal
> zone device sysfs directory.
>
> From a generic perspective, having a device pointer in the sysfs
> thermal zone directory may make sense. But the opposite is not true as
> the same driver can be related to multiple thermal zones.
>
> The usage of these information is very specific to ACPI and it is
> questionable if they are really needed.
>
> Let's make the code optional and disable it by default. If it hurts,
> we will revert this change.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/Kconfig   | 13 +++++++++
>  drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
>  2 files changed, 55 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ccbeab9500ec..7df4e18f06ef 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -336,6 +336,19 @@ config ACPI_THERMAL
>           To compile this driver as a module, choose M here:
>           the module will be called thermal.
>
> +config ACPI_THERMAL_SYSFS_ADDON
> +       bool "Enable thermal sysfs addon"
> +       depends on ACPI_THERMAL
> +       def_bool n
> +       help
> +        Enable sysfs extra information added in the thermal zone and
> +        the driver specific sysfs directories. That could be a link
> +        to the associated thermal zone as well as a link pointing to
> +        the device from the thermal zone. By default those are
> +        disabled and are candidate for removal, if you need these
> +        information anyway, enable the option or upgrade the
> +        userspace program using them.
> +

I don't think that the Kconfig option is appropriate and the help text
above isn't really helpful.

>  config ACPI_PLATFORM_PROFILE
>         tristate
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 5763db4528b8..30fe189d04f8 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>         .critical = acpi_thermal_zone_device_critical,
>  };
>
> +#ifdef CONFIG_ACPI_THERMAL_SYSFS_ADDON

I agree with moving the code in question to separate functions, but I
don't agree with putting it under the Kconfig option.

> +static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
> +{
> +       struct device *tzdev = thermal_zone_device(tz->thermal_zone);
> +       int ret;
> +
> +       ret = sysfs_create_link(&tz->device->dev.kobj,
> +                               &tzdev->kobj, "thermal_zone");
> +       if (ret)
> +               return ret;
> +
> +       ret = sysfs_create_link(&tzdev->kobj,
> +                                  &tz->device->dev.kobj, "device");
> +       if (ret)
> +               sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> +
> +       return ret;
> +}
> +
> +static void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
> +{
> +       struct device *tzdev = thermal_zone_device(tz->thermal_zone);
> +
> +       sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> +       sysfs_remove_link(&tzdev->kobj, "device");
> +}
> +#else
> +static inline int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
> +{
> +       return 0;
> +}
> +static inline void acpi_thermal_zone_sysfs_remove(struct acpi_thermal *tz)
> +{
> +}
> +#endif
> +
>  static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>  {
> -       struct device *tzdev;
>         int trips = 0;
>         int result;
>         acpi_status status;
> @@ -821,23 +856,15 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>         if (IS_ERR(tz->thermal_zone))
>                 return -ENODEV;
>
> -       tzdev = thermal_zone_device(tz->thermal_zone);
> -
> -       result = sysfs_create_link(&tz->device->dev.kobj,
> -                                  &tzdev->kobj, "thermal_zone");
> +       result = acpi_thermal_zone_sysfs_add(tz);
>         if (result)
>                 goto unregister_tzd;
> -
> -       result = sysfs_create_link(&tzdev->kobj,
> -                                  &tz->device->dev.kobj, "device");
> -       if (result)
> -               goto remove_tz_link;
> -
> +
>         status =  acpi_bus_attach_private_data(tz->device->handle,
>                                                tz->thermal_zone);
>         if (ACPI_FAILURE(status)) {
>                 result = -ENODEV;
> -               goto remove_dev_link;
> +               goto remove_links;
>         }
>
>         result = thermal_zone_device_enable(tz->thermal_zone);
> @@ -851,10 +878,8 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>
>  acpi_bus_detach:
>         acpi_bus_detach_private_data(tz->device->handle);
> -remove_dev_link:
> -       sysfs_remove_link(&tzdev->kobj, "device");
> -remove_tz_link:
> -       sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> +remove_links:
> +       acpi_thermal_zone_sysfs_remove(tz);
>  unregister_tzd:
>         thermal_zone_device_unregister(tz->thermal_zone);
>
> @@ -863,10 +888,7 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
>
>  static void acpi_thermal_unregister_thermal_zone(struct acpi_thermal *tz)
>  {
> -       struct device *tzdev = thermal_zone_device(tz->thermal_zone);
> -
> -       sysfs_remove_link(&tz->device->dev.kobj, "thermal_zone");
> -       sysfs_remove_link(&tzdev->kobj, "device");
> +       acpi_thermal_zone_sysfs_remove(tz);
>         thermal_zone_device_unregister(tz->thermal_zone);
>         tz->thermal_zone = NULL;
>         acpi_bus_detach_private_data(tz->device->handle);
> --
> 2.34.1
>
