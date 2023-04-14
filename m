Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE476E26BE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjDNPVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDNPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:21:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98F4810C2;
        Fri, 14 Apr 2023 08:21:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E28A2F4;
        Fri, 14 Apr 2023 08:21:49 -0700 (PDT)
Received: from [10.57.19.153] (unknown [10.57.19.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02D153F6C4;
        Fri, 14 Apr 2023 08:21:02 -0700 (PDT)
Message-ID: <6022d391-9ae8-2bb4-0f81-2c99466dc556@arm.com>
Date:   Fri, 14 Apr 2023 16:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Di Shen <di.shen@unisoc.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, zhanglyra@gmail.com, orsonzhai@gmail.com,
        rui.zhang@intel.com, amitk@kernel.org, rafael@kernel.org,
        Di Shen <cindygm567@gmail.com>
References: <20230320095620.7480-1-di.shen@unisoc.com>
 <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org>
 <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
 <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
 <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
 <6aad180f-410c-5b11-b30b-c7bc02cbe054@linaro.org>
 <e31da1fa-168d-9a85-cdb3-66192d887d83@arm.com>
 <ce9b3b01-e496-9e02-5583-41893b7154c7@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ce9b3b01-e496-9e02-5583-41893b7154c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/23 16:06, Daniel Lezcano wrote:
> On 14/04/2023 16:18, Lukasz Luba wrote:
>>
>>
>> On 4/14/23 12:12, Daniel Lezcano wrote:
>>> On 13/04/2023 10:40, Di Shen wrote:
>>>> We have discussed this question in patch-v1:
>>>> https://lore.kernel.org/all/f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com/
>>>>
>>>> Simply put, we use the trip_temp in the Android System; set different
>>>> trip_temp for thermal control of different scenarios.
>>>
>>> The changes are dealing with the trip points and trying to detect the 
>>> threshold. That part should be handled in the thermal core or thermal 
>>> trip side, not in the governor.
>>>
>>> AFAICT, if a trip point is changed, then the power allocator should 
>>> be reset, including the cdev state.
>>>
>>> It would be more convenient to add an ops to the governor ops 
>>> structure to reset the governor and then call it when a trip point is 
>>> changed in thermal_zone_set_trip()
>>>
>>>
>>
>> Sounds reasonable to have a proper API and fwk handling this corner
>> case scenario.
>> Although, if there is a need for a 'easy-to-backport' fix for IPA only,
>> I agree with this patch, since it's straight forward to put in some
>> Android kernel. We can later fix the framework to handle this properly.
>> Anyway, both ways are OK to me.
> 
> Unfortunately, we can not do the maintenance of the Linux kernel based 
> on an 'easy-to-backport' policy to Android.
> 
> This patch could be applied from-list to Android as a hotfix. But for 
> Linux the fix should be more elaborated. One solution is to add a 
> 'reset' ops and call it from the trip point update function.

Fair enough.

> 
> Did you double check the issue is not impacting the other governors too ?

No, unfortunately, I haven't checked other governors.
