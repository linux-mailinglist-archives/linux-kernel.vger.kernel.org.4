Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E374F7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGKSFk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGKSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:05:38 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B325B10D2;
        Tue, 11 Jul 2023 11:05:37 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3145fcecef6so1286629f8f.0;
        Tue, 11 Jul 2023 11:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689098736; x=1689703536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN4aAUtnCM1PMkPeyFKL9GEE0yIi4I315hV3adntXQQ=;
        b=cQTtPWtuAXSc5Sb7Dezk6Q70atT8nC4y+lcDiFvlIKMqCiL+lx96IxiyV8yCXPBitE
         CmdGWGHJl/YvB9v1TY+dCI6cqs23YXbqNrOEydd/CBdljHjwcKCpoCNbEw9qopbQYDCC
         O7Kt6G1w8uidbOmb0f/M2aMKaLkxwsDWyqZNCPkXm19e69PZpXykls29sdL5EwSL1AyR
         7ZOV4lQNA42rZgDz7O5/A3gcYlsMLv1mAld5KysFO4ga/wzsDObwQwJbv+cyn6xnXeSq
         /G4siGauTKZeAtE72yMkYwQUT2TnY8liCXCzzfXbHdI/Uel4PQtygRVqNxt/Sk0BfNBj
         OSkg==
X-Gm-Message-State: ABy/qLZzDU4eUrdNzqe2jBDHYGJ6mOCDFOwQJYffb6QUV7DjEE6XEet5
        uU175wbWxd9nYDqc6yPfku/iGWD42mnq/01lSSQ=
X-Google-Smtp-Source: APBJJlFmMOy5GRp17SG0GzxU/8aBXeeFTTrPAluCrUjPtiK7fzAge2wfiPvLTTBvTIXdxh2MfIW4Azgvf4F1qKQDdWQ=
X-Received: by 2002:adf:cd86:0:b0:314:1af1:4ea6 with SMTP id
 q6-20020adfcd86000000b003141af14ea6mr15669150wrj.5.1689098735993; Tue, 11 Jul
 2023 11:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230708112720.2897484-1-a.fatoum@pengutronix.de> <20230708112720.2897484-2-a.fatoum@pengutronix.de>
In-Reply-To: <20230708112720.2897484-2-a.fatoum@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Jul 2023 20:05:24 +0200
Message-ID: <CAJZ5v0jS-VVjj7AS-W4dGNY2E=hAiXS-ZtNbj6mNSzCVFXxCwg@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: of: fix double-free on unregistration
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, kernel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 1:27 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Since commit 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal
> zone parameters structure"), thermal_zone_device_register() allocates
> a copy of the tzp argument and frees it when unregistering, so
> thermal_of_zone_register() now ends up leaking its original tzp and
> double-freeing the tzp copy. Fix this by locating tzp on stack instead.
>
> Fixes: 3d439b1a2ad3 ("thermal/core: Alloc-copy-free the thermal zone parameters structure")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

Daniel, this looks like a genuine fix to me, so I'm inclined to pick
it up directly.

Any objections?

> ---
>  drivers/thermal/thermal_of.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 6fb14e521197..bc07ae1c284c 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -238,17 +238,13 @@ static int thermal_of_monitor_init(struct device_node *np, int *delay, int *pdel
>         return 0;
>  }
>
> -static struct thermal_zone_params *thermal_of_parameters_init(struct device_node *np)
> +static void thermal_of_parameters_init(struct device_node *np,
> +                                      struct thermal_zone_params *tzp)
>  {
> -       struct thermal_zone_params *tzp;
>         int coef[2];
>         int ncoef = ARRAY_SIZE(coef);
>         int prop, ret;
>
> -       tzp = kzalloc(sizeof(*tzp), GFP_KERNEL);
> -       if (!tzp)
> -               return ERR_PTR(-ENOMEM);
> -
>         tzp->no_hwmon = true;
>
>         if (!of_property_read_u32(np, "sustainable-power", &prop))
> @@ -267,8 +263,6 @@ static struct thermal_zone_params *thermal_of_parameters_init(struct device_node
>
>         tzp->slope = coef[0];
>         tzp->offset = coef[1];
> -
> -       return tzp;
>  }
>
>  static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_device *tz)
> @@ -442,13 +436,11 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
>  static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
>  {
>         struct thermal_trip *trips = tz->trips;
> -       struct thermal_zone_params *tzp = tz->tzp;
>         struct thermal_zone_device_ops *ops = tz->ops;
>
>         thermal_zone_device_disable(tz);
>         thermal_zone_device_unregister(tz);
>         kfree(trips);
> -       kfree(tzp);
>         kfree(ops);
>  }
>
> @@ -477,7 +469,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>  {
>         struct thermal_zone_device *tz;
>         struct thermal_trip *trips;
> -       struct thermal_zone_params *tzp;
> +       struct thermal_zone_params tzp = {};
>         struct thermal_zone_device_ops *of_ops;
>         struct device_node *np;
>         int delay, pdelay;
> @@ -509,12 +501,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>                 goto out_kfree_trips;
>         }
>
> -       tzp = thermal_of_parameters_init(np);
> -       if (IS_ERR(tzp)) {
> -               ret = PTR_ERR(tzp);
> -               pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
> -               goto out_kfree_trips;
> -       }
> +       thermal_of_parameters_init(np, &tzp);
>
>         of_ops->bind = thermal_of_bind;
>         of_ops->unbind = thermal_of_unbind;
> @@ -522,12 +509,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>         mask = GENMASK_ULL((ntrips) - 1, 0);
>
>         tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
> -                                                    mask, data, of_ops, tzp,
> +                                                    mask, data, of_ops, &tzp,
>                                                      pdelay, delay);
>         if (IS_ERR(tz)) {
>                 ret = PTR_ERR(tz);
>                 pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
> -               goto out_kfree_tzp;
> +               goto out_kfree_trips;
>         }
>
>         ret = thermal_zone_device_enable(tz);
> @@ -540,8 +527,6 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
>
>         return tz;
>
> -out_kfree_tzp:
> -       kfree(tzp);
>  out_kfree_trips:
>         kfree(trips);
>  out_kfree_of_ops:
> --
