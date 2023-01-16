Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2453266B5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 03:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjAPC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 21:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjAPC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 21:59:17 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA577A94;
        Sun, 15 Jan 2023 18:59:14 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZbc4Zt_1673837948;
Received: from 30.221.147.208(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZbc4Zt_1673837948)
          by smtp.aliyun-inc.com;
          Mon, 16 Jan 2023 10:59:09 +0800
Message-ID: <f9669e86-3133-328b-9df6-72b78414eabb@linux.alibaba.com>
Date:   Mon, 16 Jan 2023 10:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
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
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com>
 <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
 <CAP-5=fVQC=cBxN_-23KRRQGpQieMt1CA2N1UL60X9SXobV3x8w@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVQC=cBxN_-23KRRQGpQieMt1CA2N1UL60X9SXobV3x8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/1/15 上午6:40, Ian Rogers 写道:
> On Fri, Jan 13, 2023 at 8:32 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>>
>>
>> 在 2023/1/13 下午5:59, John Garry 写道:
>>> On 13/01/2023 09:22, Jing Zhang wrote:
>>>> Changes since v6:
>>>> - Split patch #1 into 3 smaller patches as suggested by Ian.
>>>> - Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
>>>>    per John's suggestion;
>>>> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
>>>>    function, per John's suggestion;
>>>> - Factor out pmu_core__find_same function, per John's suggestion.
>>>> - Link:https://urldefense.com/v3/__https://lore.kernel.org/all/1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99hQ!LhBq67uDCOsz1k7ZF4aQPHF0Bp8FsMr-ZNgCnBSUKF4qJTFODfnkId7lw_NXqB4qZUCpu-jbY8z8LTckoqFGz2Q8bA$
>>>
>>> This looks fine. But for this code:
>>>
>>> On 13/01/2023 09:22, Jing Zhang wrote:
>>>> +double perf_pmu__cpu_slots_per_cycle(void)
>>>> +{
>>>> +    char path[PATH_MAX];
>>>> +    unsigned long long slots = 0;
>>>
>>> I would prefer if this returned NAN (and not 0) for when we can't find a pmu or the value from ./caps/slots is zero, but I am not going to get too hung up on that.
>>>
>>
>> Ok, I like this way too.
>>
>>> For series:
>>>
>>> Reviewed-by: John Garry <john.g.garry@oracle.com>
>>
>> Thank you very much indeed!
> 
> Aside a naming nit in 1/9 for series:
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 

Thank you sincerely!

> Thanks,
> Ian
