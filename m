Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40C641B42
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 08:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLDHKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 02:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiLDHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 02:10:50 -0500
Received: from out30-8.freemail.mail.aliyun.com (out30-8.freemail.mail.aliyun.com [115.124.30.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B4013CE9;
        Sat,  3 Dec 2022 23:10:45 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VWJBzxR_1670137838;
Received: from 192.168.0.101(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VWJBzxR_1670137838)
          by smtp.aliyun-inc.com;
          Sun, 04 Dec 2022 15:10:40 +0800
Message-ID: <b3d6add4-a535-0652-c0e8-bb56126a6d2d@linux.alibaba.com>
Date:   Sun, 4 Dec 2022 15:10:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3 5/6] perf vendor events arm64: Add PE utilization
 metrics for neoverse-n2
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fV0WSTK=MT6K2nqsqYT6xCTg7Pv_rXahHFeRhV0ZHCiEQ@mail.gmail.com>
 <1a7fc9da-2589-1835-716f-d52027f0ecda@linux.alibaba.com>
 <CAP-5=fUT=u7N4GP9Y6r7dv5yTKtLqPYxYE73d7Rj8fXQ+YQidA@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fUT=u7N4GP9Y6r7dv5yTKtLqPYxYE73d7Rj8fXQ+YQidA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/3 上午4:05, Ian Rogers 写道:
> On Thu, Dec 1, 2022 at 3:08 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2022/12/1 上午2:58, Ian Rogers 写道:
>>> On Thu, Nov 24, 2022 at 9:15 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>>>
>>>> Add PE utilization related metrics.
>>>>
>>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>>> ---
>>>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 45 ++++++++++++++++++++++
>>>>  1 file changed, 45 insertions(+)
>>>>
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> index 23c7d62..7b54819 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>>> @@ -189,5 +189,50 @@
>>>>          "MetricGroup": "Branch",
>>>>          "MetricName": "branch_miss_pred_rate",
>>>>          "ScaleUnit": "100%"
>>>> +    },
>>>> +    {
>>>> +        "MetricExpr": "instructions / CPU_CYCLES",
>>>> +        "PublicDescription": "The average number of instructions executed for each cycle.",
>>>> +        "BriefDescription": "Instructions per cycle",
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "ipc"
>>>> +    },
>>>
>>> A related useful metric is percentage of peak, so if the peak IPC is 8
>>> (usually a constant related to the number of functional units) then
>>> you can just compute the ratio of IPC with this.
>>>
>>
>> Glad to discuss these with you.
>> The peak ipc value of neoverse-n2 is 5. Maybe I should add an ipc_rate metric?
>>
>>>> +    {
>>>> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
>>>> +        "PublicDescription": "Architecturally executed Instructions Per Cycle (IPC)",
>>>> +        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",
>>>
>>>
>>> The duplicated descriptions are unnecessary. Drop the public one for
>>> consistency with what we do for Intel:
>>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L299
>>>
>>
>> Sounds good, will do.
>>
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "retired_ipc"
>>>> +    },
>>>> +    {
>>>> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
>>>> +        "PublicDescription": "Speculatively executed Instructions Per Cycle (IPC)",
>>>> +        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "spec_ipc"
>>>> +    },
>>>> +    {
>>>> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
>>>> +        "PublicDescription": "Fraction of operations retired",
>>>> +        "BriefDescription": "Fraction of operations retired",
>>>
>>> Would instructions be clearer than operations here?
>>>
>>
>> operation and instruction are different. OP_RETIRED counts any operation (not instruction)
>> that has been architecturally executed, For example, speculatively executed operations that
>> have been abandoned for a branch mispredict will not be counted. So I think operation might
>> be more accurate.
> 
> Thanks, I see this note in the N2 PMU guide:
> 
> """
> For PMU event definitions, some events specifically count
> instructions, while other events count micro-operations (which are
> referred to as operations). Please be aware of the use of the word
> "operations" or "instructions" in the event description.
> """
> 
> From your explanation I wasn't sure if operation was a superset of
> instruction that included both retired and speculated ones, or whether
> operation had another meaning. I don't see operation being used in the
> micro-operation sense elsewhere in the ARM perf json, I think
> micro-operation is more consistent and also clearer:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/arm64/arm/cortex-a75/pipeline.json?h=perf/core#n27
> 
> Perhaps the description can be something like:
> Of all the micro-operations issued, what percentage were retired. A
> lower number indicates bad speculation.
> 
> An alternate way to add documentation is the perf wiki's glossary:
> https://perf.wiki.kernel.org/index.php/Glossary
> 
> I added the Neoverse N2 PMU Guide to:
> https://perf.wiki.kernel.org/index.php/Useful_Links#Manuals
> 

Thanks.

The operation here is micro-operation, perhaps it is more accurate to change it to micro-operation.

Description of op_retired and op_spec:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/arm64/common-and-microarch.json?h=perf/core#n315

The event of op_retired counts Micro-operation architecturally executed. The counter counts each
operation counted by OP_SPEC that would be executed in a simple sequential execution of the program.

The event of op_spec counts Micro-operation speculatively executed. The counter counts the number
of operations executed by the processing element, including those that are executed speculatively
and would not be executed in a simple sequential execution of the program.

So "op_retired/op_spec" is indeed "of all the micro-operations issued, what percentage were retired".
But not "a lower number indicates bad speculation". I think "retired" here means "committed".

In the N2 PMU guide:
"""
If the branch is mispredicted, and the instructions are speculatively executed, they will not be
considered architecturally executed. The Arm® Architecture Reference Manual also refers to
architecturally executed instructions as “retired” or “committed”. Speculatively executed instructions
that are not architecturally executed will be abandoned; that is, their results will be discarded and
not counted as part of the program flow.
"""

> 
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "retired_rate",
>>>> +        "ScaleUnit": "100%"
>>>> +    },
>>>> +    {
>>>> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
>>>
>>> Should OP_RETIRED be greater than OP_SPEC? In which case won't this
>>> metric be negative?
>>>
>>
>> OP_RETIRED will not be greater than OP_SPEC. OP_SPEC counts any operation that has been
>> speculatively executed. OP_SPEC is a superset of the OP_RETIRED event. There is a
>> description about OP_SPEC and OP_RETIRED in this neoverse-n2 document.
>> Link: https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=
>>
>>>> +        "PublicDescription": "Fraction of operations wasted",
>>>> +        "BriefDescription": "Fraction of operations wasted",
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "wasted_rate",
>>>> +        "ScaleUnit": "100%"
>>>> +    },
>>>> +    {
>>>> +        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * 5))",
>>>> +        "PublicDescription": "Utilization of CPU",
>>>> +        "BriefDescription": "Utilization of CPU",
>>>
>>> Some more detail in the description would be useful.
>>>
>>
>> Ok, I'll describe it in more detail. CPU_utilization reflects the truly effective ratio of operation
>> executed by the CPU, which means that misprediction and stall are not included. Note that stall_slot
>> minus cpu_cycles is a correction to the stall_slot error count.
>>
>>>> +        "MetricGroup": "PEutilization",
>>>> +        "MetricName": "cpu_utilization",
>>>> +        "ScaleUnit": "100%"
>>>>      }
>>>>  ]
>>>> --
>>>> 1.8.3.1
>>>>
