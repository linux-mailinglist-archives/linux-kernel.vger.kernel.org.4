Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69181734A69
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 04:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjFSC6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSC6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 22:58:15 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EE11B5;
        Sun, 18 Jun 2023 19:58:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VlO.Bk3_1687143483;
Received: from 30.221.149.0(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VlO.Bk3_1687143483)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 10:58:09 +0800
Message-ID: <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
Date:   Mon, 19 Jun 2023 10:58:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/6/16 下午7:41, John Garry 写道:
> On 15/06/2023 03:18, Jing Zhang wrote:
>>>>>> Unit is the format of the event_source device name. We should match based on that as well as compat. I need to check the code again to understand how that is done... it has changed a good bit in 3 years.
>>>>>>
>>>>> This situation only happens on uncore metric. I happened to write wrong Unit, but the metric still matches.
>>>>>
>>>> I'm just double checking this now. I think any possible fix should be easy enough for current code but may be tricky for backport with lots of metric code changes.
>>> I also have code to re-work sys event metric support such that we don't require "compat" or "Unit" values for a metric when the metric is described in terms of event aliases. That code is 2 years old, so may take a bit of time to rebase. I'll look to do that now.
>>>
>> Sounds good!
> 
> BTW, I am just looking at your cmn JSONs in this series, and we have something like this:
> 
> index 0000000..e70ac1a
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
> @@ -0,0 +1,74 @@
> +[
> +    {
> +        "MetricName": "slc_miss_rate",
> +        "BriefDescription": "The system level cache miss rate include.",
> +        "MetricGroup": "arm_cmn",
> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
> 
> So this expression uses event aliases hnf_cache_miss and hnf_slc_sf_cache_access - where are they defined in a JSON?
> 

Hi John,

I defined the aliases for these events in the JSON file during the RFC version. However, I later removed the alias
definitions for these events in subsequent versions due to the possibility of non-uniqueness and difficulty in defining
their EventCode. But this does not affect their usage in metrics. In other words, metrics can use the aliases without
defining event aliases in the JSON file.

In the past, I always thought that the function of the alias was to explain the meaning of these events in the perf list.
Or maybe I'm missing something?

Thanks,
Jing

> I could not see them. If they are not needed, then I may be missing something...
> 
> Thanks,
> John
> 
> 
