Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C365CE79
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjADIkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjADIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:40:23 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF91A058;
        Wed,  4 Jan 2023 00:40:19 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VYr1l.B_1672821614;
Received: from 30.221.147.98(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYr1l.B_1672821614)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 16:40:15 +0800
Message-ID: <d90c35db-c801-02ba-d9ea-148324a1de13@linux.alibaba.com>
Date:   Wed, 4 Jan 2023 16:40:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/6] perf vendor events arm64: Add TLB metrics for
 neoverse-n2
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
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
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVP_=FcEQChQwVpis9iyZsdb6NrVJQUo4GJA4_j=knfcA@mail.gmail.com>
 <14a2ca08-e946-f319-e2a8-f5f91e1eb8e6@linux.alibaba.com>
In-Reply-To: <14a2ca08-e946-f319-e2a8-f5f91e1eb8e6@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/4 下午1:21, Jing Zhang 写道:
> 
> 
> 在 2023/1/4 上午1:14, Ian Rogers 写道:
>> On Tue, Jan 3, 2023 at 3:39 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>>
>>> Add TLB related metrics.
>>>
>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>> Acked-by: Ian Rogers <irogers@google.com>
>>> ---
>>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 49 ++++++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>> index c126f1bc..8a74e07 100644
>>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>>> @@ -26,5 +26,54 @@
>>>          "MetricGroup": "TopdownL1",
>>>          "MetricName": "backend_bound",
>>>          "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
>>> +        "BriefDescription": "The rate of L1D TLB refill to the overall L1D TLB lookups",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "l1d_tlb_miss_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
>>> +        "BriefDescription": "The rate of L1I TLB refill to the overall L1I TLB lookups",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "l1i_tlb_miss_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
>>> +        "BriefDescription": "The rate of L2D TLB refill to the overall L2D TLB lookups",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "l2_tlb_miss_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
>>> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "dtlb_mpki",
>>> +        "ScaleUnit": "MPKI"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
>>> +        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "dtlb_walk_rate",
>>> +        "ScaleUnit": "100%"
>>> +    },
>>> +    {
>>> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
>>> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for instruction accesses",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "itlb_mpki",
>>> +        "ScaleUnit": "MPKI"
>>
>> Did you test this? IIRC if there is no number in the ScaleUnit then
>> the scale factor becomes 0 and the metric value is always multiplied
>> by zero. Perhaps:
>>
>> "MetricName": "itlb_miss_rate",
>> "MetricExpr": "ITLB / INST_RETIRED"
>> "ScaleUnit": "1000MPKI"
>>
>> Thanks,
>> Ian
>>
> 
> You are absolutely right, I only tested TLB metrics. Sorry for not double checking. I will repost the corrected patches.
> 

I rethought it. I want to change the ScaleUnit to "1MPKI" and keep the MetricExpr multiplied by 1000,
so that the "MetricExpr" expresses the value of per kilo instruciton, which can be consistent with the
description in "BriefDescription". Like:
   {
        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
        "MetricGroup": "TLB",
        "MetricName": "dtlb_mpki",
        "ScaleUnit": "1MPKI"
    },


In addition, I think it is more reasonable for ScaleUnit to have a default scale factor of 1 when there
is no number. I want to try to fix this bug.

Ian, what's your opnion?


>>> +    },
>>> +    {
>>> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
>>> +        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
>>> +        "MetricGroup": "TLB",
>>> +        "MetricName": "itlb_walk_rate",
>>> +        "ScaleUnit": "100%"
>>>      }
>>>  ]
>>> --
>>> 1.8.3.1
>>>
