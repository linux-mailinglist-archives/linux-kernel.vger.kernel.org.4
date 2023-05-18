Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4970819B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 14:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjERMnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjERMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 08:43:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 886BC1708;
        Thu, 18 May 2023 05:42:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD8951FB;
        Thu, 18 May 2023 05:43:26 -0700 (PDT)
Received: from [10.57.23.99] (unknown [10.57.23.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066533F73F;
        Thu, 18 May 2023 05:42:40 -0700 (PDT)
Message-ID: <8035fedb-820b-2a98-a1af-3a4a8971bcd1@arm.com>
Date:   Thu, 18 May 2023 13:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] sched/documentation: elaborate on uclamp limitations
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230505152440.142265-1-hongyan.xia2@arm.com>
 <20230518113000.pvboekaba7vspjyn@airbuntu>
Content-Language: en-US
From:   Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20230518113000.pvboekaba7vspjyn@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 2023-05-18 12:30, Qais Yousef wrote:
> Please CC sched maintainers (Ingo + Peter) next time as they should pick this
> up ultimately and they won't see it from the list only.

Will do. I was using the get_maintainers script and I thought that gave 
me all the CCs.

> On 05/05/23 16:24, Hongyan Xia wrote:
>> The story in 5.2 about util_avg abruptly jumping from 300 when
>> Fmax/Fmin == 3 to 1024 when Fmax/Fmin == 4 hides some details about how
>> clock_pelt works behind the scenes. Explicitly mention it to make it
>> easier for readers to follow.
>>
>> Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>
>> Cc: Qais Yousef <qyousef@layalina.io>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>   Documentation/scheduler/sched-util-clamp.rst | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
>> index 74d5b7c6431d..524df07bceba 100644
>> --- a/Documentation/scheduler/sched-util-clamp.rst
>> +++ b/Documentation/scheduler/sched-util-clamp.rst
>> @@ -669,6 +669,19 @@ but not proportional to Fmax/Fmin.
>>   
>>           p0->util_avg = 300 + small_error
>>   
>> +The reason why util_avg is around 300 even though it runs for 900 at Fmin is:
>> +Although running at Fmin reduces the rate of rq_clock_pelt() to 1/3 thus
>> +accumulates util_sum at 1/3 of the rate at Fmax, the clock period
>> +(rq_clock_pelt() now minus previous rq_clock_pelt()) in:
>> +
>> +::
>> +
>> +        util_sum / clock period = util_avg
>> +
>> +does not shrink to 1/3, since rq->clock_pelt is periodically synchronized with
>> +rq->clock_task as long as there's idle time. As a result, we get util_avg of
>> +about 300, not 900.
>> +
> 
> I feel neutral about these changes. It does answer some questions, but poses
> more questions like what is clock_pelt. So we might end up in recursive
> regression of explaining the explanation.
> 
> I don't think we have a doc about clock_pelt. Worth adding one and just add
> a reference to it from here for those interested in understanding more details
> on why we need to go to idle to correct util_avg? I think our code has
> explanation, a reference to update_rq_clock_pelt() might suffice too.
> 
> Vincent, do you have an opinion here?

Sounds reasonable. I don't mind drafting a doc or just a couple of 
paragraphs for clock_pelt (or all the different clocks like clock, 
clock_task, clock_idle_*), if that's what we can agree on.

Hongyan
