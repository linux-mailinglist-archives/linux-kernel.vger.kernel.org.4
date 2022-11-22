Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D646C633E45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiKVOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiKVOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:00:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11A0866CB6;
        Tue, 22 Nov 2022 06:00:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 217861FB;
        Tue, 22 Nov 2022 06:00:29 -0800 (PST)
Received: from [10.57.3.106] (unknown [10.57.3.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185633F73D;
        Tue, 22 Nov 2022 06:00:19 -0800 (PST)
Message-ID: <57315669-e6e7-08b8-a252-bc35d4fecc01@arm.com>
Date:   Tue, 22 Nov 2022 14:00:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
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
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
 <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
 <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
 <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
 <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
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



On 21/11/2022 17:55, John Garry wrote:
> On 21/11/2022 15:17, Jing Zhang wrote:
>> I'm sorry that I misunderstood the purpose of putting metric as
>> arch_std_event at first,
>> and now it works after the modification over your suggestion.
>>
>> But there are also a few questions:
>>
>> 1. The value of the slot in the topdownL1 is various in different
>> architectures, for example,
>> the slot is 5 on neoverse-n2. If I put topdownL1 metric as
>> arch_std_event, then I need to
>> specify the slot to 5 in n2. I can specify slot values in metric like
>> below, but is there any
>> other concise way to do this?
>>
>> diff --git
>> a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> index 8ff1dfe..b473baf 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> @@ -1,4 +1,23 @@
>> [
>> +       {
>> +               "MetricExpr": "5",
>> +               "PublicDescription": "A pipeline slot represents the
>> hardware resources needed to process one uOp",
>> +               "BriefDescription": "A pipeline slot represents the
>> hardware resources needed to process one uOp",
>> +               "MetricName": "slot"
> 
> Ehhh....I'm not sure if that is a good idea. Ian or anyone else have an
> opinion on this? It is possible to reuse metrics, so it should work, but...
> 
> One problem is that "slot" would show up as a metric, which you would
> not want.
> 
> Alternatively I was going to suggest that you can overwrite specific std
> arch event attributes. So for example of frontend_bound, you could have:

I would agree with not having this and just hard coding the 5 wherever
it's needed. Once we have a few different sets of metrics in place maybe
we can start to look at deduplication, but for now I don't see the value.

> 
> + b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -0,0 +1,30 @@
> [
>     {
>     "ArchStdEvent": "FRONTEND_BOUND",
>         "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 *
> cpu_cycles)",
>     },
> 
>> +       }
>> +       {
>> +               "ArchStdEvent": "FRONTEND_BOUND"
>> +       },
>> +       {
>> +               "ArchStdEvent": "BACKEND_BOUND"
>> +       },
>> +       {
>> +               "ArchStdEvent": "WASTED"
>> +       },
>> +       {
>> +               "ArchStdEvent": "RETIRING"
>> +       },
>>
>>
>> 2. Should I add the topdownL1 metric to
>> tools/perf/pmu-event/recommended.json,
>> or create a new json file to place the general metric?
> 
> It would not belong in recommended.json as that is specifically for
> arch-recommended events. It would really just depend on where the value
> comes from, i.e. arm arm or sbsa.
> 

For what we're going to publish shortly we'll be generating a
metrics.json file for each CPU. It will be autogenerated so I don't
think duplication will be an issue and I'm expecting that there will be
differences in the topdown metrics between CPUs anyway. So I would also
vote to not put it in recommended.json

>>
>> Looking forward to your reply.
> 
