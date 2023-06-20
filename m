Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53465736B71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjFTL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFTL4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:56:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAD1218C;
        Tue, 20 Jun 2023 04:56:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7001063;
        Tue, 20 Jun 2023 04:57:20 -0700 (PDT)
Received: from [10.57.26.18] (unknown [10.57.26.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8E7B3F71E;
        Tue, 20 Jun 2023 04:56:34 -0700 (PDT)
Message-ID: <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com>
Date:   Tue, 20 Jun 2023 12:56:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Di Shen <di.shen@unisoc.com>, amitk@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com
References: <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <20230619063534.12831-1-di.shen@unisoc.com>
 <CAJZ5v0i9fyfNYyhAMqr0iYPbUNwrcvL7mxK1rMo+00mNRWKV6w@mail.gmail.com>
 <CAJZ5v0gHBxbU7Q0KYKsSVk+9nzSxot_JxUkcaAXrDxQx5_a7_Q@mail.gmail.com>
 <dbfe2b14-794a-e4d9-caf4-15d69ef86091@arm.com>
 <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iOSWDBU0d4QPpsKwAW9N2u1mf-BLdKCtJ_49e8P0ZD7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 11:39, Rafael J. Wysocki wrote:
> On Tue, Jun 20, 2023 at 12:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>>
>> On 6/20/23 11:07, Rafael J. Wysocki wrote:
>>> On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>>
>>>> On Mon, Jun 19, 2023 at 8:36 AM Di Shen <di.shen@unisoc.com> wrote:
>>>>>
>>>>> When the thermal trip point is changed, the governor should
>>>>> be reset so that the policy algorithm be updated to adapt to the
>>>>> new trip point.
>>>>>
>>>>> This patch adds an ops for thermal the governor structure to reset
>>>>> the governor. The ops is called when the trip point is changed.
>>>>> For power allocator, the parameters of pid controller and the states
>>>>> of power cooling devices can be reset when the passive trip point
>>>>> is changed.
>>>>>
>>>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>>>>>
>>>>> ---
>>>>> V4:
>>>>> - Compared to V3, handle it in thermal core instead of in governor.
>>>>>
>>>>> - Add an ops to the governor structure, and call it when a trip
>>>>>     point is changed.
>>>>>
>>>>> - Define reset ops for power allocator.
>>>>>
>>>>> V3:
>>>>> - Add fix tag.
>>>>>
>>>>> V2:
>>>>> - Compared to v1, do not revert.
>>>>>
>>>>> - Add a variable(last_switch_on_temp) in power_allocator_params
>>>>>     to record the last switch_on_temp value.
>>>>>
>>>>> - Adds a function to renew the update flag and update the
>>>>>     last_switch_on_temp when thermal trips are writable.
>>>>>
>>>>> V1:
>>>>> - Revert commit 0952177f2a1f.
>>>>> ---
>>>>> ---
>>>>>    drivers/thermal/gov_power_allocator.c | 21 +++++++++++++++++++++
>>>>>    drivers/thermal/thermal_trip.c        |  6 ++++++
>>>>>    include/linux/thermal.h               |  1 +
>>>>>    3 files changed, 28 insertions(+)
>>>>>
>>>>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>>>>> index 8642f1096b91..41d155adc616 100644
>>>>> --- a/drivers/thermal/gov_power_allocator.c
>>>>> +++ b/drivers/thermal/gov_power_allocator.c
>>>>> @@ -729,10 +729,31 @@ static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_id)
>>>>>           return allocate_power(tz, trip.temperature);
>>>>>    }
>>>>>
>>>>> +static int power_allocator_reset(struct thermal_zone_device *tz, int trip_id)
>>>>> +{
>>>>> +       int ret = 0;
>>>>> +       struct thermal_trip trip;
>>>>> +       struct power_allocator_params *params = tz->governor_data;
>>>>> +
>>>>> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       /* Only need reset for passive trips */
>>>>> +       if (trip.type != THERMAL_TRIP_PASSIVE)
>>>>> +               return -EINVAL;
>>>>> +
>>>>> +       reset_pid_controller(params);
>>>>> +       allow_maximum_power(tz, true);
>>>>> +
>>>>> +       return ret;
>>>>> +}
>>>>> +
>>>>>    static struct thermal_governor thermal_gov_power_allocator = {
>>>>>           .name           = "power_allocator",
>>>>>           .bind_to_tz     = power_allocator_bind,
>>>>>           .unbind_from_tz = power_allocator_unbind,
>>>>>           .throttle       = power_allocator_throttle,
>>>>> +       .reset          = power_allocator_reset,
>>>>>    };
>>>>>    THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
>>>>> diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
>>>>> index 907f3a4d7bc8..52eb768fada8 100644
>>>>> --- a/drivers/thermal/thermal_trip.c
>>>>> +++ b/drivers/thermal/thermal_trip.c
>>>>> @@ -173,6 +173,12 @@ int thermal_zone_set_trip(struct thermal_zone_device *tz, int trip_id,
>>>>>           if (tz->trips && (t.temperature != trip->temperature || t.hysteresis != trip->hysteresis))
>>>>>                   tz->trips[trip_id] = *trip;
>>>>>
>>>>> +       if (t.temperature != trip->temperature && tz->governor && tz->governor->reset) {
>>>>> +               ret = tz->governor->reset(tz, trip_id);
>>>>> +               if (ret)
>>>>> +                       pr_warn_once("Failed to reset thermal governor\n");
>>>>
>>>> I'm not really sure if it is useful to print this message here.
>>>>
>>>> First off, the governors may print more precise diagnostic messages if
>>>> they care.
>>>>
>>>> Second, what is the sysadmin supposed to do in response to this message?
>>>
>>> In addition to the above, trip point temperatures may be updated in
>>> other places too, for instance in response to notifications from
>>> platform firmware and IMV this new callback should be also used in
>>> those cases.  However, in those cases multiple trip points may change
>>> at a time and the critical/hot trip point temperatures may be updated
>>> too AFAICS.
>>
>> IIRC the critical/hot trip points are handled differently, not using the
>> governors. The governors' 'throttle' callback would be called only
>> after we pass the test of 'critical/hot' [1].
> 
> OK, but is it actually useful to return an error code from the
> ->reset() callback when passed a non-passive trip point?

It will depend on the governor code. In our case the setup code
w.r.t. trip types is quite confusing (to fit into many possible
configurations). The non-passive trip point would be only
possible to bind when there are not other passive trip points.
That's is a really corner case and probably never used on any
device. Therefore, IMO we can just bail out in such situation
when then someone tries to update such single non-passive
trip point (probably not aware what is doing with IPA?).

For the rest of the governors - it's up to them what they
report in case non-passive trip is updated...

> 
>> What Di is facing is in the issue under the bucket of
>> 'handle_non_critical_trips()' when the governor just tries to
>> work on stale data - old trip temp.
> 
> Well, fair enough, but what about the other governors?  Is this
> problem limited to power_allocator?

IIUC the core fwk code - non of the governors would be needed
to handle the critical/hot trips. For the rest of the trip types
I would say it's up to the governor. In our IPA case this stale
data is used for power budget estimation - quite fundamental
step. Therefore, the reset and start from scratch would make more
sense.

I think other governors don't try to 'estimate' such
abstract power headroom based on temperature - so probably
they don't have to even implement the 'reset()' callback
(I don't know their logic that well).

> 
>> For the 2nd case IIUC the code, we pass the 'trip.temperature'
>> and should be ready for what you said (modification of that value).
> 
> Generally speaking, it needs to be prepared for a simultaneous change
> of multiple trip points (including active), in which case it may not
> be useful to invoke the ->reset() callback for each of them
> individually.

Although, that looks more cleaner IMO. Resetting one by one in
a temperature order would be easily maintainable, won't be?

> 
> Moreover, Daniel wants trip points to be sorted by temperature
> eventually and in that case indices may change overall even on one
> trip point update.

It's more complicated I think that this $subject, but very useful.


> 
>> Furthermore, the critical/hot situation is handled w/o governor
>> assistance, so we should be safe:
>> tz->ops->critical(tz) or tz->ops->hot(tz) and not
>> tz->governor->throttle(tz, trip)
> 
> That's fine.
