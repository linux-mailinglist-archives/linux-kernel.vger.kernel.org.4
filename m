Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F273D41B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 22:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjFYUaM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Jun 2023 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYUaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 16:30:10 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B159B;
        Sun, 25 Jun 2023 13:30:09 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-97ea801b0d0so53788466b.1;
        Sun, 25 Jun 2023 13:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687725008; x=1690317008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vDu07I6hDycUTSXbH6KDnP5ibSoUgPCPXzsR/4W9Tw=;
        b=CoMi31rEPHxxgUIh8eaWxQhiiGokndMzwkFb9dJd6ZGw5rCZmuAX+bkS/dVwFTuLSA
         9U79ZdOZnj6QD8jHhahQDDT/UhbZhj8xfrIWsAJIHiT+6nLF87QDGVceBz8jjwqE34Nx
         uTJDQ53UKn+LA2AZ48vQLXWMN+kcYZw7sWgpQIRPAEicjdqOiU4suBKvkq8+sRflutxP
         aeS13dzxw1D0s4MXrDmYh2wVf2+qgtSpCN67if87wBJlDUEWi3Q1v3m4s5Mlf6dBkAKW
         O7b7/6e2y2vCwiLTSLXfSBwf18HA+0q+4rtuEjtLOrh0Sq9I6Q8M/sDauto41CPt5dhu
         +fjw==
X-Gm-Message-State: AC+VfDyVZlDCFVUPgHr7UdqzYlx91BxGUl1GBHMm7j/JpoZtPWzffS5+
        0lPF4J6awCdbrFQy6cpWxTYeuutqqRLxEivS9G4=
X-Google-Smtp-Source: ACHHUZ42MV8w/9YwIqsO7JhQJuwGZkIMmENHXY/WQQRvRl4+X+8um2cekZrv/MMkqna+Y9p5g89e+5esQKwTY3uDVYM=
X-Received: by 2002:a17:906:73dd:b0:989:1ed3:d00b with SMTP id
 n29-20020a17090673dd00b009891ed3d00bmr13002150ejl.4.1687725007494; Sun, 25
 Jun 2023 13:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org> <20230525140135.3589917-5-daniel.lezcano@linaro.org>
In-Reply-To: <20230525140135.3589917-5-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 25 Jun 2023 22:29:55 +0200
Message-ID: <CAJZ5v0ivyJydE_Six4baLLZzJABOhH5eS2QFCaM-nG3Rt0s1Ww@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
>
> Note, no code has been found where the trip points update leads to a
> refresh of the trip points in sysfs, so it is very unlikey the number
> of trip points changes. However, for the sake of consistency it would
> be nicer to have the trip points being refreshed in sysfs also, but
> that could be done in a separate set of changes.
>
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

Lest I forget, if I'm not mistaken, the above change would break the
int3403 driver that uses int340x_thermal_update_trips() to update trip
points in int3403_notify(), which handles notifications from the
platform firmware, and it updates them through the driver's private
pointer to the trips array used by the core with the assumption that
the core will notice the changes.

So it looks like at least this particular driver would need to be
updated before the $subject patch can be applied.

That said, I think that the ACPI thermal driver won't really need to
access the trips array after passing it to
thermal_zone_device_register_with_trips() and it may create a new
trips table every time the trip points are updated by the platform
firmware, but I'm not convinced about this design.
