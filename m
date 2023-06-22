Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E753873A834
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjFVS1a convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 22 Jun 2023 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjFVS12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:27:28 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009B2100;
        Thu, 22 Jun 2023 11:27:26 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-988a4a7be58so134836866b.0;
        Thu, 22 Jun 2023 11:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458444; x=1690050444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FllJ13nyodNap3hKrgtIx3uSstQ6jTk0v3dlQlAF1hY=;
        b=lXB8hLVz3vpW9p6Wnluns/aox4xKsFwNM6ueaQ7pgDdxAkO0a9MogpvtSej2o1r2Ka
         hFRNj9s9sq6tan3vLSOTB6oICjj41slsc9NsxguDCaU3xuOsmyvzKpkocLwudJzZkDDE
         Po4KaMwYex0U63OBZPox+dJV6kEPjsl64t5xoTs4LVU9IOMdTx+zx0iH5XChd6vuyj2y
         YZNOIq/tNmaVl72CLDhdYnQyCXvstjn92U7mfAhyS0pXq01oMYMVMNlB025bbBStoAMj
         gy0Gp1OSVIxZ87x456cJxwyOHhgIzgr8+nP7W0TOPBorT22c9t9eLIHpfENcD+DglqxT
         PQAg==
X-Gm-Message-State: AC+VfDzZzclVr5IQ22v1UCeC/cdqIjsZQfPTYTP/M38AZisL8S4S2vtP
        X/6NfE5RWUIeD+3H2j5kwUoCEN+JFaggVBe5pw0=
X-Google-Smtp-Source: ACHHUZ6g8DxwNg8/efK+WrD6zAzMQtXwChsSrp1gUP5/KwIgsUzyY85CNYdCfsiGWuW7QasIk76BzolA/49LrAgHOgA=
X-Received: by 2002:a17:906:7a5e:b0:987:6960:36c6 with SMTP id
 i30-20020a1709067a5e00b00987696036c6mr12257854ejo.5.1687458444208; Thu, 22
 Jun 2023 11:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com> <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
 <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com> <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
 <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com>
In-Reply-To: <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Jun 2023 20:27:12 +0200
Message-ID: <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 1:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 6/20/23 11:39, Rafael J. Wysocki wrote:
> > On Tue, Jun 20, 2023 at 12:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >>
> >> On 6/20/23 11:07, Rafael J. Wysocki wrote:
> >>> On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>>
> >>>> On Mon, Jun 19, 2023 at 8:36 AM Di Shen <di.shen@unisoc.com> wrote:
> >>>>>
> >>>>> When the thermal trip point is changed, the governor should
> >>>>> be reset so that the policy algorithm be updated to adapt to the
> >>>>> new trip point.
> >>>>>
> >>>>> This patch adds an ops for thermal the governor structure to reset
> >>>>> the governor. The ops is called when the trip point is changed.
> >>>>> For power allocator, the parameters of pid controller and the states
> >>>>> of power cooling devices can be reset when the passive trip point
> >>>>> is changed.
> >>>>>
> >>>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
> >>>>>
> >>>>> ---
> >>>>> V4:
> >>>>> - Compared to V3, handle it in thermal core instead of in governor.
> >>>>>
> >>>>> - Add an ops to the governor structure, and call it when a trip
> >>>>>     point is changed.
> >>>>>
> >>>>> - Define reset ops for power allocator.
> >>>>>
> >>>>> V3:
> >>>>> - Add fix tag.
> >>>>>
> >>>>> V2:
> >>>>> - Compared to v1, do not revert.
> >>>>>
> >>>>> - Add a variable(last_switch_on_temp) in power_allocator_params
> >>>>>     to record the last switch_on_temp value.
> >>>>>
> >>>>> - Adds a function to renew the update flag and update the
> >>>>>     last_switch_on_temp when thermal trips are writable.
> >>>>>
> >>>>> V1:
> >>>>> - Revert commit 0952177f2a1f.
> >>>>> ---
> >>>>> ---
> >>>>>    drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
> >>>>>    drivers/thermal/thermal_trip.c        |  6 ++++++
> >>>>>    include/linux/thermal.h               |  1 +
> >>>>>    3 files changed, 28 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
> >>>>> index 8642f1096b91..41d155adc616 100644
> >>>>> --- a/drivers/thermal/gov_power_allocator.c
> >>>>> +++ b/drivers/thermal/gov_power_allocator.c
> >>>>> @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
> >>>>>           return allocate_power(tz, trip.temperature);
> >>>>>    }
> >>>>>
> >>>>> +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
> >>>>> +{
> >>>>> +       int ret = 0;
> >>>>> +       struct thermal_trip trip;
> >>>>> +       struct power_allocator_params *params = tz->governor_data;
> >>>>> +
> >>>>> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
> >>>>> +       if (ret)
> >>>>> +               return ret;
> >>>>> +
> >>>>> +       /* Only need reset for passive trips */
> >>>>> +       if (trip.type != THERMAL_TRIP_PASSIVE)
> >>>>> +               return -EINVAL;
> >>>>> +
> >>>>> +       reset_pid_controller(params);
> >>>>> +       allow_maximum_power(tz, true);
> >>>>> +
> >>>>> +       return ret;
> >>>>> +}
> >>>>> +
> >>>>>    static struct thermal_governor thermal_gov_power_allocator = {
> >>>>>           .name           = "power_allocator",
> >>>>>           .bind_to_tz     = power_allocator_bind,
> >>>>>           .unbind_from_tz = power_allocator_unbind,
> >>>>>           .throttle       = power_allocator_throttle,
> >>>>> +       .reset          = power_allocator_reset,
> >>>>>    };
> >>>>>    THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
> >>>>> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
> >>>>> index 907f3a4d7bc8..52eb768fada8 100644
> >>>>> --- a/drivers/thermal/thermal_trip.c
> >>>>> +++ b/drivers/thermal/thermal_trip.c
> >>>>> @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
> >>>>>           if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
> >>>>>                   tz->trips[trip_id] = *trip;
> >>>>>
> >>>>> +       if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
> >>>>> +               ret = tz->governor->reset(tz, trip_id);
> >>>>> +               if (ret)
> >>>>> +                       pr_warn_once("Failed to reset thermal governor\n");
> >>>>
> >>>> I'm not really sure if it is useful to print this message here.
> >>>>
> >>>> First off, the governors may print more precise diagnostic messages if
> >>>> they care.
> >>>>
> >>>> Second, what is the sysadmin supposed to do in response to this message?
> >>>
> >>> In addition to the above, trip point temperatures may be updated in
> >>> other places too, for instance in response to notifications from
> >>> platform firmware and IMV this new callback should be also used in
> >>> those cases.  However, in those cases multiple trip points may change
> >>> at a time and the critical/hot trip point temperatures may be updated
> >>> too AFAICS.
> >>
> >> IIRC the critical/hot trip points are handled differently, not using the
> >> governors. The governors' 'throttle' callback would be called only
> >> after we pass the test of 'critical/hot' [1].
> >
> > OK, but is it actually useful to return an error code from the
> > ->reset() callback when passed a non-passive trip point?
>
> It will depend on the governor code. In our case the setup code
> w.r.t. trip types is quite confusing (to fit into many possible
> configurations). The non-passive trip point would be only
> possible to bind when there are not other passive trip points.
> That's is a really corner case and probably never used on any
> device. Therefore, IMO we can just bail out in such situation
> when then someone tries to update such single non-passive
> trip point (probably not aware what is doing with IPA?).

Because this is up to the governor, the core has no clue what to do
with the return value from ->reset() and so there should be none.

As I said, governors can print whatever diagnostic messages they like
in that callback, but returning anything from it to the core is just
not useful IMV.

> For the rest of the governors - it's up to them what they
> report in case non-passive trip is updated...

Sure.

> >
> >> What Di is facing is in the issue under the bucket of
> >> 'handle_non_critical_trips()' when the governor just tries to
> >> work on stale data - old trip temp.
> >
> > Well, fair enough, but what about the other governors?  Is this
> > problem limited to power_allocator?
>
> IIUC the core fwk code - non of the governors would be needed
> to handle the critical/hot trips. For the rest of the trip types
> I would say it's up to the governor. In our IPA case this stale
> data is used for power budget estimation - quite fundamental
> step. Therefore, the reset and start from scratch would make more
> sense.
>
> I think other governors don't try to 'estimate' such
> abstract power headroom based on temperature - so probably
> they don't have to even implement the 'reset()' callback
> (I don't know their logic that well).

So there seems to be a claim that IPA is the only governor needing the
->reset() callback, but I have not seen any solid analysis confirming
that.  It very well may be the case, but then the changelog should
clearly explain why this is the case IMO.

> >
> >> For the 2nd case IIUC the code, we pass the 'trip.temperature'
> >> and should be ready for what you said (modification of that value).
> >
> > Generally speaking, it needs to be prepared for a simultaneous change
> > of multiple trip points (including active), in which case it may not
> > be useful to invoke the ->reset() callback for each of them
> > individually.
>
> Although, that looks more cleaner IMO. Resetting one by one in
> a temperature order would be easily maintainable, won't be?

I wouldn't call it maintainable really.

First of all, the trips may not be ordered.  There are no guarantees
whatsoever that they will be ordered, so the caller may have to
determine the temperature order in the first place.  This would be an
extra requirement that currently is not there.

Apart from this, I don't see any fundamental difference between the
case when trip points are updated via sysfs and when they are updated
by the driver.  The governor should reset itself in any of those cases
and even if one trip point changes, the temperature order of all of
them may change, so the governor reset mechanism should be able to
handle the case when multiple trip points are updated at the same
time.  While you may argue that this is theoretical, the ACPI spec
clearly states that this is allowed to happen, for example.

If you want a generic reset callback for governors, that's fine, but
make it generic and not specific to a particular use case.
