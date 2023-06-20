Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F1D736846
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 11:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjFTJrY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjFTJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 05:47:14 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEDF4;
        Tue, 20 Jun 2023 02:47:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-987f13f8d21so94023466b.0;
        Tue, 20 Jun 2023 02:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254431; x=1689846431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=678iX/0daXathQyEd3asdFsAaFEqxxHdrElHGgAtu/w=;
        b=QK9ZnP5n3dvePQnqkrkHD98NiF0VvpDG3HQorHIb1/GarKBQG/NPKFtHIsHtt7/E2y
         Y4qOSW5NVEBg/ffrrHILyW09pGX5LZX6+wOZwvVjSZmiLIhIC2aZghLDq01xKnlIuffV
         3UfrahF0iXPyaErl06UwkN9e9wbXJkogX782pYNtPaokoJbXym/NYzdU+SAQ4pDx6Idn
         apE7fwTVjexqyTmY9CtifBwtErzEsMOsScXubyogK5jqU4piWwVUsfmdXE0A+5JlvQPI
         jrQU/EdG6Ym70+BVIpfQBQMA0Oa1Oi3b66Dz/6WFhpbl70vZn7Re2uBvEFCaseGpJT/Z
         MlCA==
X-Gm-Message-State: AC+VfDxMZkSXe6vAsu4mOUyrBr1EDNj+mQ/TgWNuj/vtKuFCe35BR9aP
        r9Mc/cKIsX5vRBuT8HnxcW3FD+MwWReftSVSBUg=
X-Google-Smtp-Source: ACHHUZ48F70wencUcteTm50n7DCD8Gu9yTDy6E0zfZ+1xmA0NBBjFxPhHwEVytJVAUFlNuhNrvsHEXSX5s/oOfE4jrI=
X-Received: by 2002:a17:906:4e:b0:987:6960:36cb with SMTP id
 14-20020a170906004e00b00987696036cbmr6979531ejg.6.1687254430711; Tue, 20 Jun
 2023 02:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org> <20230619063534.12831-1-di.shen@unisoc.com>
In-Reply-To: <20230619063534.12831-1-di.shen@unisoc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 11:46:53 +0200
Message-ID: <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Di Shen <di.shen@unisoc.com>
Cc:     lukasz.luba@arm.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
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

On Mon, Jun 19, 2023 at 8:36 AM Di Shen <di.shen@unisoc.com> wrote:
>
> When the thermal trip point is changed, the governor should
> be reset so that the policy algorithm be updated to adapt to the
> new trip point.
>
> This patch adds an ops for thermal the governor structure to reset
> the governor. The ops is called when the trip point is changed.
> For power allocator, the parameters of pid controller and the states
> of power cooling devices can be reset when the passive trip point
> is changed.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
>
> ---
> V4:
> - Compared to V3, handle it in thermal core instead of in governor.
>
> - Add an ops to the governor structure, and call it when a trip
>   point is changed.
>
> - Define reset ops for power allocator.
>
> V3:
> - Add fix tag.
>
> V2:
> - Compared to v1, do not revert.
>
> - Add a variable(last_switch_on_temp) in power_allocator_params
>   to record the last switch_on_temp value.
>
> - Adds a function to renew the update flag and update the
>   last_switch_on_temp when thermal trips are writable.
>
> V1:
> - Revert commit 0952177f2a1f.
> ---
> ---
>  drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
>  drivers/thermal/thermal_trip.c        |  6 ++++++
>  include/linux/thermal.h               |  1 +
>  3 files changed, 28 insertions(+)
>
> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> index 8642f1096b91..41d155adc616 100644
> --- a/drivers/thermal/gov_power_allocator.c
> +++ b/drivers/thermal/gov_power_allocator.c
> @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>         return allocate_power(tz, trip.temperature);
>  }
>
> +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
> +{
> +       int ret = 0;
> +       struct thermal_trip trip;
> +       struct power_allocator_params *params = tz->governor_data;
> +
> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> +       if (ret)
> +               return ret;
> +
> +       /* Only need reset for passive trips */
> +       if (trip.type != THERMAL_TRIP_PASSIVE)
> +               return -EINVAL;
> +
> +       reset_pid_controller(params);
> +       allow_maximum_power(tz, true);
> +
> +       return ret;
> +}
> +
>  static struct thermal_governor thermal_gov_power_allocator = {
>         .name           = "power_allocator",
>         .bind_to_tz     = power_allocator_bind,
>         .unbind_from_tz = power_allocator_unbind,
>         .throttle       = power_allocator_throttle,
> +       .reset          = power_allocator_reset,
>  };
>  THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> index 907f3a4d7bc8..52eb768fada8 100644
> --- a/drivers/thermal/thermal_trip.c
> +++ b/drivers/thermal/thermal_trip.c
> @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>         if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
>                 tz->trips[trip_id] = *trip;
>
> +       if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
> +               ret = tz->governor->reset(tz, trip_id);
> +               if (ret)
> +                       pr_warn_once("Failed to reset thermal governor\n");

I'm not really sure if it is useful to print this message here.

First off, the governors may print more precise diagnostic messages if
they care.

Second, what is the sysadmin supposed to do in response to this message?

> +       }
> +
>         thermal_notify_tz_trip_change(tz->id, trip_id, trip->type,
>                                       trip->temperature, trip->hysteresis);
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 87837094d549..155ce2291fa5 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -204,6 +204,7 @@ struct thermal_governor {
>         int (*bind_to_tz)(struct thermal_zone_device *tz);
>         void (*unbind_from_tz)(struct thermal_zone_device *tz);
>         int (*throttle)(struct thermal_zone_device *tz, int trip);
> +       int (*reset)(struct thermal_zone_device *tz, int trip);
>         struct list_head        governor_list;
>  };
>
> --
> 2.17.1
>
