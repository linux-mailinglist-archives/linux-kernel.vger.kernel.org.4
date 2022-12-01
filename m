Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7371763EF10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiLALPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLALOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:14:24 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17FC25EB9;
        Thu,  1 Dec 2022 03:08:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=renyu.zj@linux.alibaba.com;NM=0;PH=DS;RN=20;SR=0;TI=SMTPD_---0VW8ayfo_1669892916;
Received: from 30.221.148.106(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VW8ayfo_1669892916)
          by smtp.aliyun-inc.com;
          Thu, 01 Dec 2022 19:08:38 +0800
Message-ID: <1a7fc9da-2589-1835-716f-d52027f0ecda@linux.alibaba.com>
Date:   Thu, 1 Dec 2022 19:08:33 +0800
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
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fV0WSTK=MT6K2nqsqYT6xCTg7Pv_rXahHFeRhV0ZHCiEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/1 上午2:58, Ian Rogers 写道:
> On Thu, Nov 24, 2022 at 9:15 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Add PE utilization related metrics.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 45 ++++++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> index 23c7d62..7b54819 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> @@ -189,5 +189,50 @@
>>          "MetricGroup": "Branch",
>>          "MetricName": "branch_miss_pred_rate",
>>          "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "instructions / CPU_CYCLES",
>> +        "PublicDescription": "The average number of instructions executed for each cycle.",
>> +        "BriefDescription": "Instructions per cycle",
>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "ipc"
>> +    },
> 
> A related useful metric is percentage of peak, so if the peak IPC is 8
> (usually a constant related to the number of functional units) then
> you can just compute the ratio of IPC with this.
> 

Glad to discuss these with you.
The peak ipc value of neoverse-n2 is 5. Maybe I should add an ipc_rate metric?

>> +    {
>> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
>> +        "PublicDescription": "Architecturally executed Instructions Per Cycle (IPC)",
>> +        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",
> 
> 
> The duplicated descriptions are unnecessary. Drop the public one for
> consistency with what we do for Intel:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L299
> 

Sounds good, will do.

>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "retired_ipc"
>> +    },
>> +    {
>> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
>> +        "PublicDescription": "Speculatively executed Instructions Per Cycle (IPC)",
>> +        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "spec_ipc"
>> +    },
>> +    {
>> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
>> +        "PublicDescription": "Fraction of operations retired",
>> +        "BriefDescription": "Fraction of operations retired",
> 
> Would instructions be clearer than operations here?
> 

operation and instruction are different. OP_RETIRED counts any operation (not instruction)
that has been architecturally executed, For example, speculatively executed operations that
have been abandoned for a branch mispredict will not be counted. So I think operation might
be more accurate.

>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "retired_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
> 
> Should OP_RETIRED be greater than OP_SPEC? In which case won't this
> metric be negative?
> 

OP_RETIRED will not be greater than OP_SPEC. OP_SPEC counts any operation that has been
speculatively executed. OP_SPEC is a superset of the OP_RETIRED event. There is a
description about OP_SPEC and OP_RETIRED in this neoverse-n2 document.
Link: https://documentation-service.arm.com/static/62cfe21e31ea212bb6627393?token=

>> +        "PublicDescription": "Fraction of operations wasted",
>> +        "BriefDescription": "Fraction of operations wasted",
>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "wasted_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * 5))",
>> +        "PublicDescription": "Utilization of CPU",
>> +        "BriefDescription": "Utilization of CPU",
> 
> Some more detail in the description would be useful.
> 

Ok, I'll describe it in more detail. CPU_utilization reflects the truly effective ratio of operation
executed by the CPU, which means that misprediction and stall are not included. Note that stall_slot
minus cpu_cycles is a correction to the stall_slot error count.

>> +        "MetricGroup": "PEutilization",
>> +        "MetricName": "cpu_utilization",
>> +        "ScaleUnit": "100%"
>>      }
>>  ]
>> --
>> 1.8.3.1
>>
