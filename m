Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1ED6327B7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKUPUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKUPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:20:14 -0500
Received: from out199-10.us.a.mail.aliyun.com (out199-10.us.a.mail.aliyun.com [47.90.199.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C6175B6;
        Mon, 21 Nov 2022 07:17:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VVOOPHM_1669043831;
Received: from 30.120.171.189(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VVOOPHM_1669043831)
          by smtp.aliyun-inc.com;
          Mon, 21 Nov 2022 23:17:13 +0800
Message-ID: <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
Date:   Mon, 21 Nov 2022 23:17:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Ian Rogers <irogers@google.com>
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
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
 <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
 <f3823c3e-d45e-40ce-1981-e726b4b6be62@linux.alibaba.com>
 <f6e26e2d-2f10-e973-6c9f-47594da2fc99@oracle.com>
 <cd016aa9-d43d-c585-0b77-a2e112777ec1@linux.alibaba.com>
 <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <abebb42b-62c1-30d7-ad9a-5fbf6c0edce1@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/21 下午6:22, John Garry 写道:
> 
>>
>>
>> #./perf stat -e FRONTEND_BOUND sleep 1
>> event syntax error: 'FRONTEND_BOUND'
> 
> For metrics, use -M, not -e
> 
> If this doesn't help, verify generated pmu-events/pmu-events.c is same after you make the change to try to use std arch events for metrics. Note that I never tested running my change.
> 
> Thanks,
> John
> 
>>                       \___ parser error
>> Run 'perf list' for a list of valid events
>>
>>   Usage: perf stat [<options>] [<command>]
>>
>>      -e, --event <event>   event selector. use 'perf list' to list available events
>>
>>
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeli
>> index f9fae15..1089ca0 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/pipeline.json
>> @@ -6,18 +6,24 @@
>>           "ArchStdEvent": "STALL_BACKEND"
>>       },
>>       {
>> -        "ArchStdEvent": "STALL_SLOT_FRONTEND"
>> +        "ArchStdEvent": "STALL_SLOT_FRONTEND",
>> +        "MetricExpr": "STALL_SLOT_FRONTEND - CPU_CYCLES"
>>       },
>>       {
>>


I'm sorry that I misunderstood the purpose of putting metric as arch_std_event at first,
and now it works after the modification over your suggestion.

But there are also a few questions:

1. The value of the slot in the topdownL1 is various in different architectures, for example,
the slot is 5 on neoverse-n2. If I put topdownL1 metric as arch_std_event, then I need to
specify the slot to 5 in n2. I can specify slot values in metric like below, but is there any
other concise way to do this?

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
index 8ff1dfe..b473baf 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
@@ -1,4 +1,23 @@
[
+       {
+               "MetricExpr": "5",
+               "PublicDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
+               "BriefDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
+               "MetricName": "slot"
+       },
+       {
+               "ArchStdEvent": "FRONTEND_BOUND"
+       },
+       {
+               "ArchStdEvent": "BACKEND_BOUND"
+       },
+       {
+               "ArchStdEvent": "WASTED"
+       },
+       {
+               "ArchStdEvent": "RETIRING"
+       },


2. Should I add the topdownL1 metric to tools/perf/pmu-event/recommended.json,
or create a new json file to place the general metric?

Looking forward to your reply.

Thanks,
Jing
