Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11016291D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 07:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbiKOG2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 01:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiKOG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 01:28:35 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB729FF5;
        Mon, 14 Nov 2022 22:28:32 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VUs.4Oo_1668493707;
Received: from 30.221.131.168(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VUs.4Oo_1668493707)
          by smtp.aliyun-inc.com;
          Tue, 15 Nov 2022 14:28:29 +0800
Message-ID: <f832ac1f-5874-50f4-334f-5c4fb68cea7d@linux.alibaba.com>
Date:   Tue, 15 Nov 2022 14:28:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [RFC PATCH v2 3/6] perf vendor events arm64: Add cache metrics
 for neoverse-n2
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <1668411720-3581-4-git-send-email-renyu.zj@linux.alibaba.com>
 <b39171e6-4af3-6102-2207-aad57dc92226@linux.intel.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <b39171e6-4af3-6102-2207-aad57dc92226@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/14 下午4:35, Xing Zhengjun 写道:
> 
> 
> On 11/14/2022 3:41 PM, Jing Zhang wrote:
>> Add cache related metrics.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>   .../arch/arm64/arm/neoverse-n2/metrics.json        | 77 ++++++++++++++++++++++
>>   1 file changed, 77 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> index 324ca12..1690ef6 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> @@ -54,5 +54,82 @@
>>           "BriefDescription": "The rate of DTLB Walks to the overall TLB lookups",
>>           "MetricGroup": "TLB",
>>           "MetricName": "dtlb_walk_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "L1I_CACHE_REFILL / INST_RETIRED * 1000",
>> +        "PublicDescription": "The rate of L1 I-Cache misses per kilo instructions",
>> +        "BriefDescription": "The rate of L1 I-Cache misses per kilo instructions",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l1i_cache_mpki"
>> +    },
>> +    {
>> +        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
>> +        "PublicDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
>> +        "BriefDescription": "The rate of L1 I-Cache misses to the overall L1 I-Cache",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l1i_cache_miss_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "L1D_CACHE_REFILL / INST_RETIRED * 1000",
>> +        "PublicDescription": "The rate of L1 D-Cache misses per kilo instructions",
>> +        "BriefDescription": "The rate of L1 D-Cache misses per kilo instructions",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l1d_cache_mpki"
>> +    },
>> +    {
>> +        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
>> +        "PublicDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
>> +        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l1d_cache_miss_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "L2D_CACHE_REFILL / INST_RETIRED * 1000",
>> +        "PublicDescription": "The rate of L2 D-Cache misses per kilo instructions",
>> +        "BriefDescription": "The rate of L2 D-Cache misses per kilo instructions",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l2d_cache_mpki"
>> +    },
>> +    {
>> +        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
>> +        "PublicDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
>> +        "BriefDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l2d_cache_miss_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "L3D_CACHE_REFILL / INST_RETIRED * 1000",
>> +        "PublicDescription": "The rate of L3 D-Cache misses per kilo instructions",
>> +        "BriefDescription": "The rate of L3 D-Cache misses per kilo instructions",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l3d_cache_mpki"
>> +    },
>> +    {
>> +        "MetricExpr": "L3D_CACHE_REFILL / L3D_CACHE",
>> +        "PublicDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
>> +        "BriefDescription": "The rate of L3 D-Cache misses to the overall L3 D-Cache",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "l3d_cache_miss_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "LL_CACHE_MISS_RD / INST_RETIRED * 1000",
>> +        "PublicDescription": "The rate of LL Cache read misses per kilo instructions",
>> +        "BriefDescription": "The rate of LL Cache read misses per kilo instructions",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "ll_cache_read_mpki"
>> +    },
>> +    {
>> +        "MetricExpr": "LL_CACHE_MISS_RD / LL_CACHE_RD",
>> +        "PublicDescription": "The rate of LL Cache read misses to the overall LL Cache read",
>> +        "BriefDescription": "The rate of LL Cache read misses to the overall LL Cache read",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "ll_cache_read_miss_rate"
>> +    },
>> +    {
>> +        "MetricExpr": "(LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD",
>> +        "PublicDescription": "The rate of LL Cache read hit to the overall LL Cache read",
>> +        "BriefDescription": "The rate of LL Cache read hit to the overall LL Cache read",
>> +        "MetricGroup": "Cache",
>> +        "MetricName": "ll_cache_read_hit_rate"
>>       }
>>   ]
>> \ No newline at end of file
> 
> It is better to fix this by adding a newline at the end of the file.
> 
OK, thanks for pointing it out.

