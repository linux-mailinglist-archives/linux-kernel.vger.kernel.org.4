Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE9736986
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjFTKjr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Jun 2023 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFTKjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:39:39 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C68187;
        Tue, 20 Jun 2023 03:39:28 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-988a4a7be58so63971466b.0;
        Tue, 20 Jun 2023 03:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687257567; x=1689849567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1n1kXu+nQ5Nxn8G6oU4vSP2FZpq1dRdfMZ9CJBaaQw=;
        b=HeGEMTAz1lnOGY37l5Y4PqfjxNk8MSDCZbicsw341OBtjwrmAGJX614yduvyapsY99
         Nfdqyqyxku6iV6icjQ0dbeYD3/IVKBwUU8ba4DjgLYCstIKI1BuQCmHm2ccdky960tNG
         Hwd+lzTYRmZaDplh14Sle+kRBZBz9DEuJB7cSJRymHJnC3UPW/GZvVtEK6j2bwi2237R
         k8i2t4Nm6RRDPRvRsbQwJgridC/Of0je4q80mXnXuXpO/6JX9RuPQWocZNRIdFk/YpYn
         wpvZNLhfQD2vXgdh2iIHhJS3clyd21E6br6G/aaRdcvbvRXGPwN9Gf2EQapEZTymnJIl
         RFNw==
X-Gm-Message-State: AC+VfDxbSYsvEWKoxgv2VXjVJYm/sMeHh3RqyZA4O3N8o1hqotL8gbkA
        bpInMfbA7eX58CldPZwPFRAYWgQT0Dfao4wG4sw=
X-Google-Smtp-Source: ACHHUZ4jAeQO/pXeMsHcHRY7M4XIZLifCp+i3JXq39n0tyTa2WZd6RDFnRRMraHkPuniu8F8X4wG/EKeKhTdCPD/puQ=
X-Received: by 2002:a17:906:100a:b0:987:81d:9d49 with SMTP id
 10-20020a170906100a00b00987081d9d49mr7517549ejm.7.1687257567174; Tue, 20 Jun
 2023 03:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com> <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com>
In-Reply-To: <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Jun 2023 12:39:10 +0200
Message-ID: <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, Di Shen <di.shen@unisoc.com>,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
>
> On 6/20/23 11:07, Rafael J. Wysocki wrote:
> > On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Mon, Jun 19, 2023 at 8:36 AM Di Shen <di.shen@unisoc.com> wrote:
> >>>
> >>> When the thermal trip point is changed, the governor should
> >>> be reset so that the policy algorithm be updated to adapt to the
> >>> new trip point.
> >>>
> >>> This patch adds an ops for thermal the governor structure to reset
> >>> the governor. The ops is called when the trip point is changed.
> >>> For power allocator, the parameters of pid controller and the states
> >>> of power cooling devices can be reset when the passive trip point
> >>> is changed.
> >>>
> >>> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >>>
> >>> ---
> >>> V4:
> >>> - Compared to V3, handle it in thermal core instead of in governor.
> >>>
> >>> - Add an ops to the governor structure, and call it when a trip
> >>>    point is changed.
> >>>
> >>> - Define reset ops for power allocator.
> >>>
> >>> V3:
> >>> - Add fix tag.
> >>>
> >>> V2:
> >>> - Compared to v1, do not revert.
> >>>
> >>> - Add a variable(last_switch_on_temp) in power_allocator_params
> >>>    to record the last switch_on_temp value.
> >>>
> >>> - Adds a function to renew the update flag and update the
> >>>    last_switch_on_temp when thermal trips are writable.
> >>>
> >>> V1:
> >>> - Revert commit 0952177f2a1f.
> >>> ---
> >>> ---
> >>>   drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
> >>>   drivers/thermal/thermal_trip.c        |  6 ++++++
> >>>   include/linux/thermal.h               |  1 +
> >>>   3 files changed, 28 insertions(+)
> >>>
> >>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> >>> index 8642f1096b91..41d155adc616 100644
> >>> --- a/drivers/thermal/gov_power_allocator.c
> >>> +++ b/drivers/thermal/gov_power_allocator.c
> >>> @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
> >>>          return allocate_power(tz, trip.temperature);
> >>>   }
> >>>
> >>> +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
> >>> +{
> >>> +       int ret = 0;
> >>> +       struct thermal_trip trip;
> >>> +       struct power_allocator_params *params = tz->governor_data;
> >>> +
> >>> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> >>> +       if (ret)
> >>> +               return ret;
> >>> +
> >>> +       /* Only need reset for passive trips */
> >>> +       if (trip.type != THERMAL_TRIP_PASSIVE)
> >>> +               return -EINVAL;
> >>> +
> >>> +       reset_pid_controller(params);
> >>> +       allow_maximum_power(tz, true);
> >>> +
> >>> +       return ret;
> >>> +}
> >>> +
> >>>   static struct thermal_governor thermal_gov_power_allocator = {
> >>>          .name           = "power_allocator",
> >>>          .bind_to_tz     = power_allocator_bind,
> >>>          .unbind_from_tz = power_allocator_unbind,
> >>>          .throttle       = power_allocator_throttle,
> >>> +       .reset          = power_allocator_reset,
> >>>   };
> >>>   THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> >>> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> >>> index 907f3a4d7bc8..52eb768fada8 100644
> >>> --- a/drivers/thermal/thermal_trip.c
> >>> +++ b/drivers/thermal/thermal_trip.c
> >>> @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> >>>          if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> >>>                  tz->trips[trip_id] = *trip;
> >>>
> >>> +       if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
> >>> +               ret = tz->governor->reset(tz, trip_id);
> >>> +               if (ret)
> >>> +                       pr_warn_once("Failed to reset thermal governor\n");
> >>
> >> I'm not really sure if it is useful to print this message here.
> >>
> >> First off, the governors may print more precise diagnostic messages if
> >> they care.
> >>
> >> Second, what is the sysadmin supposed to do in response to this message?
> >
> > In addition to the above, trip point temperatures may be updated in
> > other places too, for instance in response to notifications from
> > platform firmware and IMV this new callback should be also used in
> > those cases.  However, in those cases multiple trip points may change
> > at a time and the critical/hot trip point temperatures may be updated
> > too AFAICS.
>
> IIRC the critical/hot trip points are handled differently, not using the
> governors. The governors' 'throttle' callback would be called only
> after we pass the test of 'critical/hot' [1].

OK, but is it actually useful to return an error code from the
->reset() callback when passed a non-passive trip point?

> What Di is facing is in the issue under the bucket of
> 'handle_non_critical_trips()' when the governor just tries to
> work on stale data - old trip temp.

Well, fair enough, but what about the other governors?  Is this
problem limited to power_allocator?

> For the 2nd case IIUC the code, we pass the 'trip.temperature'
> and should be ready for what you said (modification of that value).

Generally speaking, it needs to be prepared for a simultaneous change
of multiple trip points (including active), in which case it may not
be useful to invoke the ->reset() callback for each of them
individually.

Moreover, Daniel wants trip points to be sorted by temperature
eventually and in that case indices may change overall even on one
trip point update.

> Furthermore, the critical/hot situation is handled w/o governor
> assistance, so we should be safe:
> tz->ops->critical(tz) or tz->ops->hot(tz) and not
> tz->governor->throttle(tz, trip)

That's fine.
