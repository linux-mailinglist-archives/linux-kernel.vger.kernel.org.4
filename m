Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64274DC8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjGJRdX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 13:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjGJRdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:33:20 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFB9CA;
        Mon, 10 Jul 2023 10:33:19 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-98e2865e2f2so136844866b.0;
        Mon, 10 Jul 2023 10:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689010398; x=1691602398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW7gIWoXz+75O82v0in9rOdnCFb2N1IDml+dDmi5wIg=;
        b=RxHF0x56rGb4ij+aJg1D7q+g9dzGHrWTo5mO437HgBbmogPYys9/GSsVkphHH2kKnR
         1o7HoK2q2XogldiENEY6LQP3GwwnpTA61fRx8m24L7rcBuF0F40ii7OmLqhqJ2ndGyAV
         a+Gh8uNw2Zram32gUC6EjTtk5Xr9JFjR00C015jbHLztJyADorD8Ikl0HY2waJq8dM7b
         ifkyt5CEb1NewJNVFjjoW0on61vyCbjtqn1W8nA6XLF/RDk5YjyDbSrAnx7r1b5PJJTT
         opx+ndkOv+otbVTEixerg+9wSBzo0/QAW15ICHOwtocw330m4NbXiUtdJL+eZt/4FXQ8
         SCkA==
X-Gm-Message-State: ABy/qLaGT+1HEjw8ScW0GpffUA0pf5HidP75yiKRqushXvXstDxrySHK
        BFZruOh0Smw6UFWSSbUnIjxCA9Pwn3OefZZQ4ao=
X-Google-Smtp-Source: APBJJlGrFWckOpq6F+U2Dl/Hd7X1UmYvh0fkh/4EhV8ipIPJo+zhkLpCh1ZKPllZ5JtsB8HAZ9lnMlofZYItVc7OVGQ=
X-Received: by 2002:a17:906:64d8:b0:988:815c:ba09 with SMTP id
 p24-20020a17090664d800b00988815cba09mr11678904ejn.4.1689010397756; Mon, 10
 Jul 2023 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
In-Reply-To: <20230708112720.2897484-1-a.fatoum@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jul 2023 19:33:06 +0200
Message-ID: <CAJZ5v0h6_jzOBxhmd2b8WL5nVOvZ03AD5fzdtc9ACXGiCKEmOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: core: constify params in thermal_zone_device_register
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 1:27 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone
> parameters structure"), thermal_zone_device_register() allocates a copy
> of the tzp argument and callers need not explicitly manage its lifetime.
>
> This means the function no longer cares about the parameter being
> mutable, so constify it.
>
> No functional change.
>
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")

Why is this particular patch regarded as a fix?

> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  include/linux/thermal.h        | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 842f678c1c3e..cc2b5e81c620 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1203,7 +1203,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
>  struct thermal_zone_device *
>  thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
>                                         void *devdata, struct thermal_zone_device_ops *ops,
> -                                       struct thermal_zone_params *tzp, int passive_delay,
> +                                       const struct thermal_zone_params *tzp, int passive_delay,
>                                         int polling_delay)
>  {
>         struct thermal_zone_device *tz;
> @@ -1371,7 +1371,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
>
>  struct thermal_zone_device *thermal_zone_device_register(const char *type, int ntrips, int mask,
>                                                          void *devdata, struct thermal_zone_device_ops *ops,
> -                                                        struct thermal_zone_params *tzp, int passive_delay,
> +                                                        const struct thermal_zone_params *tzp, int passive_delay,
>                                                          int polling_delay)
>  {
>         return thermal_zone_device_register_with_trips(type, NULL, ntrips, mask,
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..dee66ade89a0 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -301,14 +301,14 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
>  #ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
> -               struct thermal_zone_params *, int, int);
> +               const struct thermal_zone_params *, int, int);
>
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>
>  struct thermal_zone_device *
>  thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int, int,
>                                         void *, struct thermal_zone_device_ops *,
> -                                       struct thermal_zone_params *, int, int);
> +                                       const struct thermal_zone_params *, int, int);
>
>  void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>  const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
> @@ -348,7 +348,7 @@ void thermal_zone_device_critical(struct thermal_zone_device *tz);
>  static inline struct thermal_zone_device *thermal_zone_device_register(
>         const char *type, int trips, int mask, void *devdata,
>         struct thermal_zone_device_ops *ops,
> -       struct thermal_zone_params *tzp,
> +       const struct thermal_zone_params *tzp,
>         int passive_delay, int polling_delay)
>  { return ERR_PTR(-ENODEV); }
>  static inline void thermal_zone_device_unregister(
> --
> 2.39.2
>
