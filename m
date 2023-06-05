Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130A721C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 04:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjFECqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 22:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjFECqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 22:46:49 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A8510A;
        Sun,  4 Jun 2023 19:46:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VkIV8ZJ_1685933200;
Received: from 30.221.149.40(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VkIV8ZJ_1685933200)
          by smtp.aliyun-inc.com;
          Mon, 05 Jun 2023 10:46:41 +0800
Message-ID: <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
Date:   Mon, 5 Jun 2023 10:46:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
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
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
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



在 2023/6/3 上午12:20, John Garry 写道:
> On 01/06/2023 09:58, Jing Zhang wrote:
>>>  From checking the driver, it seems that we have model names "arm_cmn600" and "arm_cmn650". Are you saying that "arm_cmn600X" would match for those? I am most curious about how "arm_cmn600X" matches "arm_cmn650".
>>>
>> Hi John,
>>
>>  From patch #1 we have identifiers "arm_cmn600_0" and "arm_cmn650_0" etc. 
> 
> ok, I see. Your idea for the cmn driver HW identifier format is odd to me. Your HW identifier is a mix of the HW IP model name (from arm_cmn_device_data.model_name) with some the kernel revision identifier (from cmn_revision). The kernel revision identifier is an enum, and I don't think that it is a good idea to expose enum values through sysfs files.
> 
> I assume that there is some ordering requirement for cmn_revision, considering that we have equality operations on the revision in the driver.
> 

Actually revision is a register value rather than an enumeration value. If I modify the revision to r0p0, etc., it is also possible, but I need
to convert the enumeration to a string.


>> The identifier consists of model_name and revision.
>> The compatible value "arm_cmn600;arm_cmn650" can match the identifier "arm_cmn600_0" or "arm_cmn650_0". Maybe the message log
>> is not clear enough.
>>
>> For example in patch #3 the metric "slc_miss_rate" is a generic metric for cmn-any. So we can define:
>>
>> +    {
>> +        "MetricName": "slc_miss_rate",
>> +        "BriefDescription": "The system level cache miss rate include.",
>> +        "MetricGroup": "arm_cmn",
>> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>> +        "ScaleUnit": "100%",
>> +        "Unit": "arm_cmn",
>> +        "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>> +    },
>>
>>
>> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
>> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
>>
>> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
>> "arm_cmn700_4", it can be matched.
> 
> OK, I see what you mean. My confusion came about though your commit message on this same patch, which did not mention cmn650. I assumed that the example event which you were describing was supported for arm_cmn650 and you intentionally omitted it.
> 

Yes, I didn't write cmn650 in the commit message, just because I omitted it. I will add it in a later version.

>>
>>
>>>> Tokens in Unit field are delimited by ';'.
>>> Thanks for taking a stab at solving this problem.
>>>
>>> I have to admit that I am not the biggest fan of having multiple values to match in the "Compat" value possibly for every event. It doesn't really scale.
>>>
>>> I would hope that there are at least some events which we are guaranteed to always be present. From what Robin said on the v2 series, for the implementations which we care about, events are generally added per subsequent version. So we should have some base set of fixed events.
>>>
>>> If we are confident that we have a fixed set of base set of events, can we ensure that those events would not require this compat string which needs each version explicitly stated?
>>>
>> If we are sure that some events will always exist in subsequent versions, we can set the Compat field to "arm_cmn;arm_ci". After that,
>> whether it is a different model or a different revision of the cmn PMU, it will be compatible. That is, it matches all whose identifier
>> is prefixed with “arm_cmn” or “arm_ci”.
> 
> Sure, we could do something like that. Or if we are super-confident that every model and rev will support some event, then we can change perf tool to just not check Compat for that event.
> 

Yes, I have also thought about this solution. If it is an event supported by all versions, as long as it meets the Unit match, it does not need
to check Compat. However, the current perf tools tool seems to ignore the "Unit" inspection for the metric event.

>>
>> Maybe it's not a perfect solution yet, looking forward to your suggestions.
> 
> Well first we need to define kernel HW identifier format. I don't know why we don't encode model and revision name, like "cmn650_r1p1". Robin?
> 

As mentioned earlier, revision is a register value rather than an enumeration value. If change revision to revision name, I need a more redundant
operation of converting enumeration value to string. If you think changing the naming method to "cmn650_r1p1" is clearer, of course
there is no problem.

Thanks,
Jing
