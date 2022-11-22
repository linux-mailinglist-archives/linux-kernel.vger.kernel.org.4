Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C3263384D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiKVJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiKVJZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:25:08 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7D53FB9A;
        Tue, 22 Nov 2022 01:25:06 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VVRfUdC_1669109100;
Received: from 30.221.132.69(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VVRfUdC_1669109100)
          by smtp.aliyun-inc.com;
          Tue, 22 Nov 2022 17:25:02 +0800
Message-ID: <a37ca1e6-7d22-3c80-98be-0dec37d76c9b@linux.alibaba.com>
Date:   Tue, 22 Nov 2022 17:24:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
To:     John Garry <john.g.garry@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
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
 <d904734a-e7c1-ca8e-7705-63fc4864ac4f@linux.alibaba.com>
 <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <75c4f0e6-3f28-a748-e891-7be6016ca28e@oracle.com>
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



在 2022/11/22 上午1:55, John Garry 写道:
> On 21/11/2022 15:17, Jing Zhang wrote:
>> I'm sorry that I misunderstood the purpose of putting metric as arch_std_event at first,
>> and now it works after the modification over your suggestion.
>>
>> But there are also a few questions:
>>
>> 1. The value of the slot in the topdownL1 is various in different architectures, for example,
>> the slot is 5 on neoverse-n2. If I put topdownL1 metric as arch_std_event, then I need to
>> specify the slot to 5 in n2. I can specify slot values in metric like below, but is there any
>> other concise way to do this?
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> index 8ff1dfe..b473baf 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> @@ -1,4 +1,23 @@
>> [
>> +       {
>> +               "MetricExpr": "5",
>> +               "PublicDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
>> +               "BriefDescription": "A pipeline slot represents the hardware resources needed to process one uOp",
>> +               "MetricName": "slot"
> 
> Ehhh....I'm not sure if that is a good idea. Ian or anyone else have an opinion on this? It is possible to reuse metrics, so it should work, but...
> 
> One problem is that "slot" would show up as a metric, which you would not want.
> 
> Alternatively I was going to suggest that you can overwrite specific std arch event attributes. So for example of frontend_bound, you could have:
> 
> + b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -0,0 +1,30 @@
> [
>     {
>     "ArchStdEvent": "FRONTEND_BOUND",
>         "MetricExpr": "(stall_slot_frontend - cpu_cycles) / (5 * cpu_cycles)",
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
>> 2. Should I add the topdownL1 metric to tools/perf/pmu-event/recommended.json,
>> or create a new json file to place the general metric?
> 
> It would not belong in recommended.json as that is specifically for arch-recommended events. It would really just depend on where the value comes from, i.e. arm arm or sbsa.
> 


Thanks for your suggestion, I will send next patchset as you suggested.
