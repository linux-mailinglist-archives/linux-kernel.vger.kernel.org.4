Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043D85E8EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiIXRgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiIXRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:36:18 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013376F557;
        Sat, 24 Sep 2022 10:36:16 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id c6so1931997qvn.6;
        Sat, 24 Sep 2022 10:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RxlSuwBTw10QIJQH+uv84AZU0CK1PdBkcx9kCHrAQXA=;
        b=uwiAEM7Qwq7jJMicGx6k1ezQGCOLi6sMelKcGDbLr6YTr2Ap8Um8PDNxz39gfB5ZLn
         NlgZ72Z+xy0cucilDWl/rElzxp7LEYpTIHjqRjH8p0Rld4zMVN6jWl7S9SyFqJhIdir8
         BdJR4O3FNJ/YgOA6yr8utzoQ9edSLrdnVIuYLDfO5a1YWgpje6sYBbTmsqyJxRrtQMnQ
         2ZB4lMfZeYsto5bb/nC4O/Kn0lP+RclDBlRlz9l6yZJ5V+ToV2rolf+hFltChjSM79sP
         Hc5lrX888gTbZWdAelUMt94NSLwWBOnxylUjuPliIZyZph6N47/PqV+fsP9hYlrAi86E
         3MNQ==
X-Gm-Message-State: ACrzQf0ToeaX7amET46PjCkx1GezTb/1ybl7nsH6JxhgcaoUjcT8yiOG
        kQDxckNFdfpmaxowWoMyOGNsQE/PjUvwBn8yAls=
X-Google-Smtp-Source: AMsMyM48g3wwHRQW3x6uPV9miTx7+gbPgXztvnj3mLdg0l1J2Qu/umMpl3AifGA63COMKunbYiE1Ip6KFTOjoBrQCgc=
X-Received: by 2002:a0c:da14:0:b0:4aa:aad9:e450 with SMTP id
 x20-20020a0cda14000000b004aaaad9e450mr11772891qvj.130.1664040975101; Sat, 24
 Sep 2022 10:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220906164720.330701-1-daniel.lezcano@linaro.org> <20220906164720.330701-30-daniel.lezcano@linaro.org>
In-Reply-To: <20220906164720.330701-30-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:36:04 +0200
Message-ID: <CAJZ5v0j+2UM9zONBZpLW=X2KKQU5mDd8r=o9DqTq3rqoigBqrw@mail.gmail.com>
Subject: Re: [PATCH v3 29/30] thermal/intel/int340x: Replace parameter to simplify
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Antoine Tenart <atenart@kernel.org>
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

On Tue, Sep 6, 2022 at 6:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> In the process of replacing the get_trip_* ops by the generic trip
> points, the current code has an 'override' property to add another
> indirection to a different ops.
>
> Rework this approach to prevent this indirection and make the code
> ready for the generic trip points conversion.
>
> Actually the get_temp() is different regarding the platform, so it is
> pointless to add a new set of ops but just create dynamically the ops
> at init time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

A fix has been posted for this one already:

https://patchwork.kernel.org/project/linux-pm/patch/20220923152009.1721739-1-nathan@kernel.org/

> ---
>  .../int340x_thermal/int340x_thermal_zone.c    | 31 ++++++++-----------
>  .../int340x_thermal/int340x_thermal_zone.h    |  4 +--
>  .../processor_thermal_device.c                | 10 ++----
>  3 files changed, 18 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> index 62c0aa5d0783..10731b9a140a 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
> @@ -18,9 +18,6 @@ static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
>         unsigned long long tmp;
>         acpi_status status;
>
> -       if (d->override_ops && d->override_ops->get_temp)
> -               return d->override_ops->get_temp(zone, temp);
> -
>         status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
>         if (ACPI_FAILURE(status))
>                 return -EIO;
> @@ -46,9 +43,6 @@ static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
>         struct int34x_thermal_zone *d = zone->devdata;
>         int i;
>
> -       if (d->override_ops && d->override_ops->get_trip_temp)
> -               return d->override_ops->get_trip_temp(zone, trip, temp);
> -
>         if (trip < d->aux_trip_nr)
>                 *temp = d->aux_trips[trip];
>         else if (trip == d->crt_trip_id)
> @@ -79,9 +73,6 @@ static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
>         struct int34x_thermal_zone *d = zone->devdata;
>         int i;
>
> -       if (d->override_ops && d->override_ops->get_trip_type)
> -               return d->override_ops->get_trip_type(zone, trip, type);
> -
>         if (trip < d->aux_trip_nr)
>                 *type = THERMAL_TRIP_PASSIVE;
>         else if (trip == d->crt_trip_id)
> @@ -112,9 +103,6 @@ static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
>         acpi_status status;
>         char name[10];
>
> -       if (d->override_ops && d->override_ops->set_trip_temp)
> -               return d->override_ops->set_trip_temp(zone, trip, temp);
> -
>         snprintf(name, sizeof(name), "PAT%d", trip);
>         status = acpi_execute_simple_method(d->adev->handle, name,
>                         millicelsius_to_deci_kelvin(temp));
> @@ -134,9 +122,6 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
>         acpi_status status;
>         unsigned long long hyst;
>
> -       if (d->override_ops && d->override_ops->get_trip_hyst)
> -               return d->override_ops->get_trip_hyst(zone, trip, temp);
> -
>         status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
>         if (ACPI_FAILURE(status))
>                 *temp = 0;
> @@ -217,7 +202,7 @@ static struct thermal_zone_params int340x_thermal_params = {
>  };
>
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
> -                               struct thermal_zone_device_ops *override_ops)
> +                                                    int (*get_temp) (struct thermal_zone_device *, int *))
>  {
>         struct int34x_thermal_zone *int34x_thermal_zone;
>         acpi_status status;
> @@ -231,8 +216,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
>                 return ERR_PTR(-ENOMEM);
>
>         int34x_thermal_zone->adev = adev;
> -       int34x_thermal_zone->override_ops = override_ops;
>
> +       int34x_thermal_zone->ops = kmemdup(&int340x_thermal_zone_ops,
> +                                          sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
> +       if (!int34x_thermal_zone->ops)
> +               goto err_ops_alloc;
> +
> +       if (get_temp)
> +               int34x_thermal_zone->ops->get_temp = get_temp;
> +
>         status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
>         if (ACPI_FAILURE(status))
>                 trip_cnt = 0;
> @@ -262,7 +254,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
>                                                 acpi_device_bid(adev),
>                                                 trip_cnt,
>                                                 trip_mask, int34x_thermal_zone,
> -                                               &int340x_thermal_zone_ops,
> +                                               int34x_thermal_zone->ops,
>                                                 &int340x_thermal_params,
>                                                 0, 0);
>         if (IS_ERR(int34x_thermal_zone->zone)) {
> @@ -281,6 +273,8 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
>         acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
>         kfree(int34x_thermal_zone->aux_trips);
>  err_trip_alloc:
> +       kfree(int34x_thermal_zone->ops);
> +err_ops_alloc:
>         kfree(int34x_thermal_zone);
>         return ERR_PTR(ret);
>  }
> @@ -292,6 +286,7 @@ void int340x_thermal_zone_remove(struct int34x_thermal_zone
>         thermal_zone_device_unregister(int34x_thermal_zone->zone);
>         acpi_lpat_free_conversion_table(int34x_thermal_zone->lpat_table);
>         kfree(int34x_thermal_zone->aux_trips);
> +       kfree(int34x_thermal_zone->ops);
>         kfree(int34x_thermal_zone);
>  }
>  EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
> diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> index 3b4971df1b33..e28ab1ba5e06 100644
> --- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> +++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
> @@ -29,13 +29,13 @@ struct int34x_thermal_zone {
>         int hot_temp;
>         int hot_trip_id;
>         struct thermal_zone_device *zone;
> -       struct thermal_zone_device_ops *override_ops;
> +       struct thermal_zone_device_ops *ops;
>         void *priv_data;
>         struct acpi_lpat_conversion_table *lpat_table;
>  };
>
>  struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
> -                               struct thermal_zone_device_ops *override_ops);
> +                               int (*get_temp) (struct thermal_zone_device *, int *));
>  void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
>  int int340x_thermal_read_trips(struct int34x_thermal_zone *int34x_zone);
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index a8d98f1bd6c6..317703027ce9 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -207,10 +207,6 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
>         return ret;
>  }
>
> -static struct thermal_zone_device_ops proc_thermal_local_ops = {
> -       .get_temp       = proc_thermal_get_zone_temp,
> -};
> -
>  static int proc_thermal_read_ppcc(struct proc_thermal_device *proc_priv)
>  {
>         int i;
> @@ -285,7 +281,7 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
>         struct acpi_device *adev;
>         acpi_status status;
>         unsigned long long tmp;
> -       struct thermal_zone_device_ops *ops = NULL;
> +       int (*get_temp) (struct thermal_zone_device *, int *) = NULL;
>         int ret;
>
>         adev = ACPI_COMPANION(dev);
> @@ -304,10 +300,10 @@ int proc_thermal_add(struct device *dev, struct proc_thermal_device *proc_priv)
>                 /* there is no _TMP method, add local method */
>                 stored_tjmax = get_tjmax();
>                 if (stored_tjmax > 0)
> -                       ops = &proc_thermal_local_ops;
> +                       get_temp = proc_thermal_get_zone_temp;
>         }
>
> -       proc_priv->int340x_zone = int340x_thermal_zone_add(adev, ops);
> +       proc_priv->int340x_zone = int340x_thermal_zone_add(adev, get_temp);
>         if (IS_ERR(proc_priv->int340x_zone)) {
>                 return PTR_ERR(proc_priv->int340x_zone);
>         } else
> --
> 2.34.1
>
