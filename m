Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4716B72C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCMJiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCMJhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:37:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78F892B600;
        Mon, 13 Mar 2023 02:36:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A8A2F4;
        Mon, 13 Mar 2023 02:36:15 -0700 (PDT)
Received: from [10.57.18.52] (unknown [10.57.18.52])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E32313F71A;
        Mon, 13 Mar 2023 02:35:29 -0700 (PDT)
Message-ID: <8727651b-88ec-efe7-eed2-1ff08faf22b8@arm.com>
Date:   Mon, 13 Mar 2023 09:35:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] thermal/core/power_allocator: avoid cdev->state can not
 be reset
Content-Language: en-US
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Di Shen <di.shen@unisoc.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, Qais Yousef <qyousef@layalina.io>
References: <20230309135515.1232-1-di.shen@unisoc.com>
 <db539c1e-22d5-2261-1248-07883dac12ee@arm.com>
 <CAB8ipk_T5RUZxD42d9wg_i8-3UXHFP=4Ffa_NH8Nm7FnyW2Ppw@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk_T5RUZxD42d9wg_i8-3UXHFP=4Ffa_NH8Nm7FnyW2Ppw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen,

On 3/13/23 01:40, Xuewen Yan wrote:
> Hi Lukasz
> 
> On Fri, Mar 10, 2023 at 11:56 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Di,
>>
>> On 3/9/23 13:55, Di Shen wrote:
>>> Commit 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
>>> add a update flag to update cooling device only once when temp is low.
>>> But when the switch_on_temp is set to be a higher value, the cooling device state
>>> may not be reset to max, because the last_temp is smaller than the switch_on_temp.
>>>
>>> For example:
>>> First:
>>> swicth_on_temp=70 control_temp=85;
>>>
>>> Then userspace change the trip_temp:
>>> swicth_on_temp=45 control_temp=55 cur_temp=54
>>>
>>> Then userspace reset the trip_temp:
>>> swicth_on_temp=70 control_temp=85 cur_temp=57 last_temp=54
>>>
>>> At this time, the cooling device state should be reset to be max.
>>> However, because cur_temp(57) < switch_on_temp(70)
>>> last_temp(54) < swicth_on_temp(70) --> update = false
>>> When update is false, the cooling device state can not be reset.
>>
>> That's a tricky use case. How is that now possible,
> 
> We use the trip_temp in the Android System. Often, we set different
> control temperatures in different scenarios,
> and when we change the switch_on_temp from small to bigger, we find
> the power can not be reset to be max.

I see, thanks for letting me know that this is Android.

> 
> 
>>>
>>> So delete the update condition, so that the cooling device state
>>> could be reset.
>>
>> IMO this is not the desired solution. Daniel reported the issue that
>> IPA triggers the event sent to user-space even when there is no need.
>> That's the motivation for the 0952177f2a1f change.
>>
>> To address your scenario properly, we need an interface which allows
>> to respond properly for such situation when someone from user-space
>> writes a new value to something fundamental as trip point.
>>
>> You also have a kernel config enabled:
>> CONFIG_THERMAL_WRITABLE_TRIPS
>> which IMO is only for debug kernels for system integrator (according
>> to the Kconfig description).
> 
>   Yes, we use it to meet the temperature control needs of different scenarios.
> And now in android with google's GKI2.0, the config must be opened.

OK

> 
>>
>> When you disable this config in your deploy/product kernel
>> than this issue would disappear.
>>
>>>
>>> Fixes: 0952177f2a1f (thermal/core/power_allocator: Update once cooling devices when temp is low)
>>> Signed-off-by: Di Shen <di.shen@unisoc.com>
>>> ---
>>>    drivers/thermal/gov_power_allocator.c | 9 +++------
>>>    1 file changed, 3 insertions(+), 6 deletions(-)
>>>
>>
>> That's why IMO this is not the solution.
> 
> Yes, but I think we should fix the bug, although the
> CONFIG_THERMAL_WRITABLE_TRIPS is just for debugging.
> How about record the last_trip_temp, and when the last_temp >
> last_trip_temp, set the update tobe true?

Yes, if that config is used in Android then we must fix it.

That last_trip_temp makes sense (but maybe name it last_switch_on_temp).
Please put that new field into the IPA local
struct power_allocator_params. We should store the trip temp
value there every time power_allocator_throttle() is called.
That can be called due to a write from user-space w/ a new trip point
value, so should be OK.

Regards,
Lukasz
