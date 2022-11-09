Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE4623371
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiKIT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIT1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:27:11 -0500
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7F2648C;
        Wed,  9 Nov 2022 11:27:10 -0800 (PST)
Received: by mail-qv1-f50.google.com with SMTP id x13so12977294qvn.6;
        Wed, 09 Nov 2022 11:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=48urlYujnHGRZrXub9uIt/bJT10d08COXtC8DkRHiJs=;
        b=K9PdpHqsFtAyiqTONKhju9Podk++7xC3izpf09C0uhv75CYStr4SsM8WGe7l+I0WqM
         LofF2QmXx8mLE3sI2XfnkGiqNuGQWiS4bdrNWVulfRESMPnznY5c63Wuz27W3KRcU+rP
         jdPglf/c0W9XUYf6xi7YwMonJXr1Aofin35Pgz/Oa1PofWmvuGlmiu02PJZ7nAvuPcEf
         +wc6KBfQ4xBWuqwHXcH+whTBMTQYaLnMH74PmYwsK+W7fefMLWN0sWyVYtmxySoyqSS0
         e7kflq5huXBDHJQg8tqdEhBISXbmudRdQ/mIGr+7bOV8POZZfQrK2V5Bm0C16ir1Ci+7
         ZwfQ==
X-Gm-Message-State: ACrzQf2Im7LSW3EEs64tWM8abYKLsZnnDVm2CWC0ZMqba6l2bJAq0RYa
        K1AZSooLYYTtkV6oxsuA3pf/duF277jGinUZUyw=
X-Google-Smtp-Source: AMsMyM7iaetz/l2h4h7sUiQ+FTGvpzDQrT+kj2KOwTk3dbd2Z3YA0xF5qmBfZ4uRxZUlr3UudLOxkd7L/ivL0QLkY/8=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr47320055qvj.3.1668022029972; Wed, 09 Nov
 2022 11:27:09 -0800 (PST)
MIME-Version: 1.0
References: <20221017130910.2307118-1-linux@roeck-us.net> <20221017130910.2307118-8-linux@roeck-us.net>
In-Reply-To: <20221017130910.2307118-8-linux@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 20:26:59 +0100
Message-ID: <CAJZ5v0iiDBF5=NughubF+M-hPLKN++vusuWxvWWGC075oXPFbw@mail.gmail.com>
Subject: Re: [PATCH 7/9] thermal/core: Protect sysfs accesses to thermal
 operations with thermal zone mutex
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Protect access to thermal operations against thermal zone removal by
> acquiring the thermal zone device mutex. After acquiring the mutex, check
> if the thermal zone device is registered and abort the operation if not.
>
> With this change, we can call __thermal_zone_device_update() instead of
> thermal_zone_device_update() from trip_point_temp_store() and from
> emul_temp_store(). Similar, we can call __thermal_zone_set_trips() instead
> of thermal_zone_set_trips() from trip_point_hyst_store().
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/thermal/thermal_core.c  |  4 +-
>  drivers/thermal/thermal_core.h  |  2 +
>  drivers/thermal/thermal_sysfs.c | 77 ++++++++++++++++++++++++++++-----
>  3 files changed, 69 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9facd9c5b70f..b8e3b262b2bd 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -403,8 +403,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
>                 pos->initialized = false;
>  }
>
> -static void __thermal_zone_device_update(struct thermal_zone_device *tz,
> -                                        enum thermal_notify_event event)
> +void __thermal_zone_device_update(struct thermal_zone_device *tz,
> +                                 enum thermal_notify_event event)
>  {
>         int count;
>
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 1571917bd3c8..7b51b9a22e7e 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -109,6 +109,8 @@ int thermal_register_governor(struct thermal_governor *);
>  void thermal_unregister_governor(struct thermal_governor *);
>  int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
>  int thermal_build_list_of_policies(char *buf);
> +void __thermal_zone_device_update(struct thermal_zone_device *tz,
> +                                 enum thermal_notify_event event);
>
>  /* Helpers */
>  void thermal_zone_set_trips(struct thermal_zone_device *tz);
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index ec495c7dff03..68607e6070e8 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -92,7 +92,15 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
>         if (sscanf(attr->attr.name, "trip_point_%d_type", &trip) != 1)
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               mutex_unlock(&tz->lock);
> +               return -ENODEV;
> +       }
> +
>         result = tz->ops->get_trip_type(tz, trip, &type);
> +       mutex_unlock(&tz->lock);
>         if (result)
>                 return result;
>
> @@ -128,10 +136,17 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>         if (kstrtoint(buf, 10, &temperature))
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         if (tz->ops->set_trip_temp) {
>                 ret = tz->ops->set_trip_temp(tz, trip, temperature);
>                 if (ret)
> -                       return ret;
> +                       goto unlock;
>         }
>
>         if (tz->trips)
> @@ -140,18 +155,21 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>         if (tz->ops->get_trip_hyst) {
>                 ret = tz->ops->get_trip_hyst(tz, trip, &hyst);
>                 if (ret)
> -                       return ret;
> +                       goto unlock;
>         }
>
>         ret = tz->ops->get_trip_type(tz, trip, &type);
>         if (ret)
> -               return ret;
> +               goto unlock;
>
>         thermal_notify_tz_trip_change(tz->id, trip, type, temperature, hyst);
>
> -       thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +       __thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
>
> -       return count;
> +unlock:
> +       mutex_unlock(&tz->lock);
> +
> +       return ret ? ret : count;
>  }
>
>  static ssize_t
> @@ -168,12 +186,19 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
>         if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip) != 1)
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         ret = tz->ops->get_trip_temp(tz, trip, &temperature);
>

Well, this is a pattern I've already talked about twice, so let me
just mention it here.

> -       if (ret)
> -               return ret;
> +unlock:
> +       mutex_unlock(&tz->lock);
>
> -       return sprintf(buf, "%d\n", temperature);
> +       return ret ? ret : sprintf(buf, "%d\n", temperature);

And I wouldn't change this (like in the other patch I've commented).

>  }
>
>  static ssize_t
> @@ -193,6 +218,13 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
>         if (kstrtoint(buf, 10, &temperature))
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         /*
>          * We are not doing any check on the 'temperature' value
>          * here. The driver implementing 'set_trip_hyst' has to
> @@ -201,7 +233,10 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
>         ret = tz->ops->set_trip_hyst(tz, trip, temperature);
>
>         if (!ret)
> -               thermal_zone_set_trips(tz);
> +               __thermal_zone_set_trips(tz);
> +
> +unlock:
> +       mutex_unlock(&tz->lock);
>
>         return ret ? ret : count;
>  }
> @@ -220,8 +255,18 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
>         if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip) != 1)
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         ret = tz->ops->get_trip_hyst(tz, trip, &temperature);

Same pattern again.

> +unlock:
> +       mutex_unlock(&tz->lock);
> +
>         return ret ? ret : sprintf(buf, "%d\n", temperature);
>  }
>
> @@ -269,16 +314,24 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
>         if (kstrtoint(buf, 10, &temperature))
>                 return -EINVAL;
>
> +       mutex_lock(&tz->lock);
> +
> +       if (!device_is_registered(dev)) {
> +               ret = -ENODEV;
> +               goto unlock;
> +       }
> +
>         if (!tz->ops->set_emul_temp) {
> -               mutex_lock(&tz->lock);
>                 tz->emul_temperature = temperature;
> -               mutex_unlock(&tz->lock);
>         } else {
>                 ret = tz->ops->set_emul_temp(tz, temperature);
>         }

Drop the leftover braces that are not necessary now?

>
>         if (!ret)
> -               thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +               __thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
> +
> +unlock:
> +       mutex_unlock(&tz->lock);
>
>         return ret ? ret : count;
>  }
> --
