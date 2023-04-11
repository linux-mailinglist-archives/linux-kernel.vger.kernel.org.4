Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F98D6DE3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDKS0U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjDKS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:26:15 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FA59DA;
        Tue, 11 Apr 2023 11:26:13 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id sh8so22639311ejc.10;
        Tue, 11 Apr 2023 11:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681237572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gilSqaLH75Kwn14U7AXuNMAb4A5ZtykHNo56iDEJFIA=;
        b=EFAvvZz413DuUrhdtwBKgtr0ZAHs262Pcgoq2DYWAhBUgeTAw28COZQqcNjA+7mcIW
         V/ne1FrLTsHHkUSbnlOmiUBaeug6fJu41AqvQUfujpbrnrDRcAqrtKA42sVgk2nPVAW+
         JmdEhxv3v7CfflIib246fQSjvRC/ad+WD9xaLPyK7sDn6o2UavD3+xi0Un2Qt51f559A
         reACMtj/krELGR2Ldhjdfy6Jh2qhvig087XEI1OE9y0MKWRgTtO9ifd34AxVGaxk7cwY
         B+T1Wx6riFzKmyeY4vL1w5Yy+yZI4ORWiJ0n1ZM+G8E/MTnwy4DDbC/V6hUUHsC3b9kR
         Fncg==
X-Gm-Message-State: AAQBX9dMq9MD0SmmCTuixh/EIbSQGEZfSh/Ri7qSKvhISysZIw/hiEeJ
        1gWHzqf5XqKQGB9TzeQ50P/SDGy/qZJCwqHQ67A=
X-Google-Smtp-Source: AKy350YPEGwlG7daNVXhqJ7zE2BNiigplLpGV1d3lMesj/7tDeyYfGr4+pA14AYOz8D1FWVo67pP1KES3pCacHC8Uhw=
X-Received: by 2002:a17:907:6287:b0:93e:c1ab:ae67 with SMTP id
 nd7-20020a170907628700b0093ec1abae67mr6094508ejc.2.1681237572089; Tue, 11 Apr
 2023 11:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org> <20230410205305.1649678-7-daniel.lezcano@linaro.org>
In-Reply-To: <20230410205305.1649678-7-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:26:01 +0200
Message-ID: <CAJZ5v0hqqPQ0xQqt3KgyQ5b-xTRjPicgkKgyo=+p7jgB9BuZaQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] thermal/drivers/acpi: Make cross dev link optional
 by configuration
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI THERMAL DRIVER" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
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
> Let's make the code optional and disable it by default.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index 5763db4528b8..70f1d28810f2 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>         .critical = acpi_thermal_zone_device_critical,
>  };
>
> +#ifdef CONFIG_THERMAL_SYSFS_OBSOLETE_SINGULARITY

It is OK to move the code to the separate functions below, but it is
not OK to make it depend on the Kconfig option above.

The extra sysfs things were added in different drivers for different
reasons.  Making them all depend on one Kconfig option is just wrong.

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
