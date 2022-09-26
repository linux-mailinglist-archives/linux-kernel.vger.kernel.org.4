Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00F5EB166
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiIZTea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiIZTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:34:26 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CA09E68C;
        Mon, 26 Sep 2022 12:34:25 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id y2so4764893qkl.11;
        Mon, 26 Sep 2022 12:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9qHHLR7Gz6nSrU4pdL3MTVlAvxhoAC5Bz+bU1eEpqSc=;
        b=ZYjSwqemHUktlT4dvaBvHt+X8ppYCWPEuXkqzhuOmmqH5huSDA+CGaQ0pDpJRFBnr3
         NnY9kh1feTZhpXo4vOispjCIwUDep5ijdjDig4l/2Me0PLFYp3EvM6xKSy8HLY2pFVLS
         tXfNVUBxT+tNj9nT5lRcjFstNCV0BaOVncesaIQSyojjEJb93+4yJE/2o86gXnhVdE2z
         xo+hS3UBzVtW6HT+w5NRBXTrsDfhhlXW+RRDMQ5q5REgtW5k5H31SRBdA/6pWiSooG1G
         8AT8hLbzKgEGpvK5iWPkDVmSgNvrrajmBpL6+GjaCikUZVGTmOyAoezWS7b3QLkYxH91
         Fqyw==
X-Gm-Message-State: ACrzQf2SquhSkt0EB0/l/T3bt+pdMFwD9nDE2Sp8iM0igYYjBLVN6ZUW
        PaeNotboDglOWvigCHgwXf/oSZxzIutLGWgrVQc=
X-Google-Smtp-Source: AMsMyM7D+7WHu1pYens9kw7owpgZ9M1EGlS+JDlpFjl3ZifpWFdoyePB97Hx2gC8XXSP5s57BzVcTsua+Wj92/z28yE=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr15954505qko.480.1664220864578; Mon, 26
 Sep 2022 12:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org> <20220926140604.4173723-6-daniel.lezcano@linaro.org>
In-Reply-To: <20220926140604.4173723-6-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Sep 2022 21:34:12 +0200
Message-ID: <CAJZ5v0ibt6nj6+E3onu4Ri74gX84VBob-hOWQPZiusGKb_Apjw@mail.gmail.com>
Subject: Re: [PATCH v5 05/30] thermal/core/governors: Use thermal_zone_get_trip()
 instead of ops functions
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
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
> The governors are using the ops->get_trip_* functions, Replace these
> calls with thermal_zone_get_trip().
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com> # IPA
> ---
>  drivers/thermal/gov_bang_bang.c       | 29 ++++++++-------
>  drivers/thermal/gov_fair_share.c      | 18 ++++------
>  drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
>  drivers/thermal/gov_step_wise.c       | 22 ++++++------
>  4 files changed, 53 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index a08bbe33be96..f5b85e5ea707 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -13,26 +13,25 @@
>
>  #include "thermal_core.h"
>
> -static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
> +static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
>  {
> -       int trip_temp, trip_hyst;
> +       struct thermal_trip trip;
>         struct thermal_instance *instance;
> +       int ret;
>
> -       tz->ops->get_trip_temp(tz, trip, &trip_temp);
> -
> -       if (!tz->ops->get_trip_hyst) {
> -               pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
> -                               "running with default hysteresis zero\n", tz->type);
> -               trip_hyst = 0;
> -       } else
> -               tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> +       if (ret)
> +               pr_warn_once("Failed to retrieve trip point %d\n", trip_id);

Does it even make sense to continue beyond this point if ret is nonzero?

All of the contents of trip can be garbage then AFAICS.

> +
> +       if (!trip.hysteresis)
> +               pr_warn_once("Zero hysteresis value for thermal zone %s\n", tz->type);

Why do you want to warn about this?  Haven't we declared already that
zero hysteresis is valid and normal?

>
>         dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
> -                               trip, trip_temp, tz->temperature,
> -                               trip_hyst);
> +                               trip_id, trip.temperature, tz->temperature,
> +                               trip.hysteresis);
>
>         list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
> -               if (instance->trip != trip)
> +               if (instance->trip != trip_id)
>                         continue;
>
>                 /* in case fan is in initial state, switch the fan off */
