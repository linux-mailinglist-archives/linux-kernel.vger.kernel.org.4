Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6EE6361BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiKWO2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiKWO1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:27:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35CC66B237;
        Wed, 23 Nov 2022 06:26:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C1D1FB;
        Wed, 23 Nov 2022 06:26:26 -0800 (PST)
Received: from [10.32.36.24] (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01FFC3F73B;
        Wed, 23 Nov 2022 06:26:15 -0800 (PST)
Message-ID: <279545ee-1758-c60d-fdc3-2b15bcc4be6d@arm.com>
Date:   Wed, 23 Nov 2022 14:26:14 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>,
        Nick Forrington <Nick.Forrington@arm.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
 <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
 <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
 <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
 <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
 <57315669-e6e7-08b8-a252-bc35d4fecc01@arm.com>
 <180a34c2-f68d-6f4d-da74-7bbb80e9e65c@linux.alibaba.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <180a34c2-f68d-6f4d-da74-7bbb80e9e65c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2022 15:41, Jing Zhang wrote:
> 
> 
> 在 2022/11/22 下午10:00, James Clark 写道:
>>
>>
>> On 21/11/2022 17:55, John Garry wrote:
>>> On 21/11/2022 15:17, Jing Zhang wrote:
>>>> I'm sorry that I misunderstood the purpose of putting metric as
>>>> arch_std_event at first,
>>>> and now it works after the modification over your suggestion.
>>>>
>>>> But there are also a few questions:
>>>>
>>>> 1. The value of the slot in the topdownL1 is various in different
>>>> architectures, for example,
>>>> the slot is 5 on neoverse-n2. If I put topdownL1 metric as
>>>> arch_std_event, then I need to
>>>> specify the slot to 5 in n2. I can specify slot values in metric like
>>>> below, but is there any
>>>> other concise way to do this?
>>>>
>>>> diff --git
>>>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> index 8ff1dfe..b473baf 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> @@ -1,4 +1,23 @@
>>>> [
>>>> +       {
>>>> +               "MetricExpr": "5",
>>>> +               "PublicDescription": "A pipeline slot represents the
>>>> hardware resources needed to process one uOp",
>>>> +               "BriefDescription": "A pipeline slot represents the
>>>> hardware resources needed to process one uOp",
>>>> +               "MetricName": "slot"
>>>
>>> Ehhh....I'm not sure if that is a good idea. Ian or anyone else have an
>>> opinion on this? It is possible to reuse metrics, so it should work, but...
>>>
>>> One problem is that "slot" would show up as a metric, which you would
>>> not want.
>>>
>>> Alternatively I was going to suggest that you can overwrite specific std
>>> arch event attributes. So for example of frontend_bound, you could have:
>>
>> I would agree with not having this and just hard coding the 5 wherever
>> it's needed. Once we have a few different sets of metrics in place maybe
>> we can start to look at deduplication, but for now I don't see the value.
>>
>>>
>>> + b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>> @@ -0,0 +1,30 @@
>>> [
>>>     {
>>>     "ArchStdEvent": "FRONTEND_BOUND",
>>>         "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 *
>>> cpu_cycles)",
>>>     },
>>>
>>>> +       }
>>>> +       {
>>>> +               "ArchStdEvent": "FRONTEND_BOUND"
>>>> +       },
>>>> +       {
>>>> +               "ArchStdEvent": "BACKEND_BOUND"
>>>> +       },
>>>> +       {
>>>> +               "ArchStdEvent": "WASTED"
>>>> +       },
>>>> +       {
>>>> +               "ArchStdEvent": "RETIRING"
>>>> +       },
>>>>
>>>>
>>>> 2. Should I add the topdownL1 metric to
>>>> tools/perf/pmu-event/recommended.json,
>>>> or create a new json file to place the general metric?
>>>
>>> It would not belong in recommended.json as that is specifically for
>>> arch-recommended events. It would really just depend on where the value
>>> comes from, i.e. arm arm or sbsa.
>>>
>>
>> For what we're going to publish shortly we'll be generating a
>> metrics.json file for each CPU. It will be autogenerated so I don't
>> think duplication will be an issue and I'm expecting that there will be
>> differences in the topdown metrics between CPUs anyway. So I would also
>> vote to not put it in recommended.json
>>
> 
> I will create a new sbsa.json file in tools/perf/pmu-events/arch/arm64/
> to place metrics that may be common between some CPUs, just like arch_std_event.

Because this would apply to all CPUs rather than just N2, I still think
it's best to wait for our metrics repo to be published. Otherwise Arm
will start publishing metrics with names and group names for all future
CPUs that have different names to the common ones added as part of this
change.

It's something that we've been working on for quite a while and we've
taken care to make sure that it applies to future products and is scalable.

It would be easier to add these right now only for N2, and then
afterwards we can start to look at what is common and could be factored
out into the top level folder.

> If the topdown metrics are different in other CPUs, we can overwrite the
> metric expression.

True, but with different group names and metric names and units it could
get slightly complicated.

> 
> For example:
> 
> +++ b/tools/perf/pmu-events/arch/arm64/sbsa.json
> @@ -0,0 +1,9 @@
> +[
> +    {
> +        "MetricExpr": "stall_slot_frontend / (slot * cpu_cycles)",
> +        "PublicDescription": "Frontend bound L1 topdown metric",
> +        "BriefDescription": "Frontend bound L1 topdown metric",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "FRONTEND_BOUND"
> +    }
> +]
> 
> + b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -0,0 +1,30 @@
> +[
> +   {
> +   	"ArchStdEvent": "FRONTEND_BOUND",
> +        "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 * cpu_cycles)",
> +   }
> +]
> 

With the auto generation of metrics file I don't really see too much
benefit of doing it this way.

You also run into the issue where if a platform happens to define all of
the events required by a metric, will that metric appear automatically,
even if it's not valid?

> 
> In addition, I can also add TLB, Cache, Branch, InstructionMix, PEutilization
> and other metric groups into sbsa.json, because they are also applicable to
> neoverse-n1. Above metrics are described in the documentation of neoverse-n1:
> https://developer.arm.com/documentation/PJDOC-466751330-547673/r4p1/
> 
> 
> Thanks,
> Jing
> 
> 
>>>>
>>>> Looking forward to your reply.
>>>
