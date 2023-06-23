Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B673B214
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjFWHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjFWHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 03:49:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51E812729;
        Fri, 23 Jun 2023 00:48:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD0E6C14;
        Fri, 23 Jun 2023 00:43:43 -0700 (PDT)
Received: from [10.57.27.57] (unknown [10.57.27.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE22B3F64C;
        Fri, 23 Jun 2023 00:42:57 -0700 (PDT)
Message-ID: <2884a54e-4db0-bf47-3b8a-0deb337208d8@arm.com>
Date:   Fri, 23 Jun 2023 08:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
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
 <62c35d1c-7dcd-7bf2-253e-65cdfd6e92cc@arm.com>
 <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iX2WYVjXWecJHVB_w1HAAOLDJvFLTMALGQF3pfv-rKSw@mail.gmail.com>
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



On 6/22/23 19:27, Rafael J. Wysocki wrote:
> On Tue, Jun 20, 2023 at 1:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 6/20/23 11:39, Rafael J. Wysocki wrote:
>>> On Tue, Jun 20, 2023 at 12:19 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>>
>>>> On 6/20/23 11:07, Rafael J. Wysocki wrote:
>>>>> On Tue, Jun 20, 2023 at 11:46 AM Rafael J. Wysocki <rafael@kernel.org> wrote:

[snip]

> 
> Because this is up to the governor, the core has no clue what to do
> with the return value from ->reset() and so there should be none.
> 
> As I said, governors can print whatever diagnostic messages they like
> in that callback, but returning anything from it to the core is just
> not useful IMV.
> 
>> For the rest of the governors - it's up to them what they
>> report in case non-passive trip is updated...
> 
> Sure.
> 
>>>
>>>> What Di is facing is in the issue under the bucket of
>>>> 'handle_non_critical_trips()' when the governor just tries to
>>>> work on stale data - old trip temp.
>>>
>>> Well, fair enough, but what about the other governors?  Is this
>>> problem limited to power_allocator?
>>
>> IIUC the core fwk code - non of the governors would be needed
>> to handle the critical/hot trips. For the rest of the trip types
>> I would say it's up to the governor. In our IPA case this stale
>> data is used for power budget estimation - quite fundamental
>> step. Therefore, the reset and start from scratch would make more
>> sense.
>>
>> I think other governors don't try to 'estimate' such
>> abstract power headroom based on temperature - so probably
>> they don't have to even implement the 'reset()' callback
>> (I don't know their logic that well).
> 
> So there seems to be a claim that IPA is the only governor needing the
> ->reset() callback, but I have not seen any solid analysis confirming
> that.  It very well may be the case, but then the changelog should
> clearly explain why this is the case IMO.

I agree, the patch header doesn't explain that properly. Here is the
explanation for this Intelligent Power Allocator (IPA):

The IPA controls temperature using PID mechanism. It's a closed
feedback loop. That algorithm can 'learn' from the 'observed'
in the past reaction for it's control decisions and accumulates that
information in the part called 'error integral'. Those accumulated
'error' gaps are the differences between the set target value and the
actually achieved value. In our case the target value is the target
temperature which is coming from the trip point. That part is then used
with the 'I' (of PID) component, so we can compensate for those
'learned' mistakes.
Now, when you change the target temperature value - all your previous
learned errors won't help you. That's why Intelligent Power Allocator
should reset previously accumulated history.

> 
>>>
>>>> For the 2nd case IIUC the code, we pass the 'trip.temperature'
>>>> and should be ready for what you said (modification of that value).
>>>
>>> Generally speaking, it needs to be prepared for a simultaneous change
>>> of multiple trip points (including active), in which case it may not
>>> be useful to invoke the ->reset() callback for each of them
>>> individually.
>>
>> Although, that looks more cleaner IMO. Resetting one by one in
>> a temperature order would be easily maintainable, won't be?
> 
> I wouldn't call it maintainable really.
> 
> First of all, the trips may not be ordered.  There are no guarantees
> whatsoever that they will be ordered, so the caller may have to
> determine the temperature order in the first place.  This would be an
> extra requirement that currently is not there.
> 
> Apart from this, I don't see any fundamental difference between the
> case when trip points are updated via sysfs and when they are updated
> by the driver.  The governor should reset itself in any of those cases
> and even if one trip point changes, the temperature order of all of
> them may change, so the governor reset mechanism should be able to
> handle the case when multiple trip points are updated at the same
> time.  While you may argue that this is theoretical, the ACPI spec
> clearly states that this is allowed to happen, for example.
> 
> If you want a generic reset callback for governors, that's fine, but
> make it generic and not specific to a particular use case.

I think we agree here, but probably having slightly different
implementation in mind. Based on you explanation I think you
want simply this API:
void (*reset)(struct thermal_zone_device *tz);

1. no return value
2. no specific trip ID as argument

Do you agree?
IMO such implementation and API would also work for this IPA
purpose. Would that work for the ACPI use case as well?
