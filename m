Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B2724911
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbjFFQ1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbjFFQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:27:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC13A126;
        Tue,  6 Jun 2023 09:27:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28D8C2F4;
        Tue,  6 Jun 2023 09:28:19 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754013F6C4;
        Tue,  6 Jun 2023 09:27:31 -0700 (PDT)
Message-ID: <fb5d1641-0eb1-8282-6a2a-48b32ea6c804@arm.com>
Date:   Tue, 6 Jun 2023 17:27:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
Content-Language: en-GB
To:     John Garry <john.g.garry@oracle.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 5:20 pm, John Garry wrote:
> On 01/06/2023 09:58, Jing Zhang wrote:
>>>  From checking the driver, it seems that we have model names 
>>> "arm_cmn600" and "arm_cmn650". Are you saying that "arm_cmn600X" 
>>> would match for those? I am most curious about how "arm_cmn600X" 
>>> matches "arm_cmn650".
>>>
>> Hi John,
>>
>>  From patch #1 we have identifiers "arm_cmn600_0" and "arm_cmn650_0" etc. 
> 
> ok, I see. Your idea for the cmn driver HW identifier format is odd to 
> me. Your HW identifier is a mix of the HW IP model name (from 
> arm_cmn_device_data.model_name) with some the kernel revision identifier 
> (from cmn_revision). The kernel revision identifier is an enum, and I 
> don't think that it is a good idea to expose enum values through sysfs 
> files.
> 
> I assume that there is some ordering requirement for cmn_revision, 
> considering that we have equality operations on the revision in the driver.

That enum does actually follow the revision identifiers as provided by 
the hardware (see CMN_CFGM_PID2_REVISION), so I don't see any major 
issue with putting it into user ABI. And TBH I think I would prefer to 
just use a numeric value rather than have to maintain yet more tables of 
strings which given the usage model here would effectively only mangle a 
matchable value into a different matchable value anyway.

I am inclined to agree that the mix between part 
driver-generated-string, part hardware-value looks a little funky. I 
still need to check with the hardware team exactly how the part number 
field from PERIPH_ID_0/1 is "configuration-dependent", and whether there 
might actually be a chance of using that as well.

One nagging doubt that remains for metrics are any baked-in assumptions 
which may not always simply depend on the product version - for instance 
it happens to be the case currently that everything has a fixed flit 
size of 256 bits, hence the magic "32" in the bandwidth calculations, 
but if that ever became configurable in some future product, we may 
potentially have a problem guaranteeing a meaningful calculation.

>> The identifier consists of model_name and revision.
>> The compatible value "arm_cmn600;arm_cmn650" can match the identifier 
>> "arm_cmn600_0" or "arm_cmn650_0". Maybe the message log
>> is not clear enough.
>>
>> For example in patch #3 the metric "slc_miss_rate" is a generic metric 
>> for cmn-any. So we can define:
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
>> It can match identifiers "arm_cmn600_{0,1,2..X}" or 
>> "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 
>> 0,1,2..X}".
>> In other words, it can match all identifiers prefixed with 
>> “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
>>
>> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will 
>> not be matched, but if a new revision arm_cmn driver with identifier
>> "arm_cmn700_4", it can be matched.
> 
> OK, I see what you mean. My confusion came about though your commit 
> message on this same patch, which did not mention cmn650. I assumed that 
> the example event which you were describing was supported for arm_cmn650 
> and you intentionally omitted it.
> 
>>
>>
>>>> Tokens in Unit field are delimited by ';'.
>>> Thanks for taking a stab at solving this problem.
>>>
>>> I have to admit that I am not the biggest fan of having multiple 
>>> values to match in the "Compat" value possibly for every event. It 
>>> doesn't really scale.
>>>
>>> I would hope that there are at least some events which we are 
>>> guaranteed to always be present. From what Robin said on the v2 
>>> series, for the implementations which we care about, events are 
>>> generally added per subsequent version. So we should have some base 
>>> set of fixed events.

Note that there's a slight difference between "present" and "valid", 
e.g. in the current driver-internal aliases, all MTSX events are marked 
CMN_ANY, meaning they're considered valid on any CMN configuration with 
an MTSX node, regardless of model. The events don't exist on CMN-600 or 
CMN-650, but that's because the MTSX itself wasn't a thing yet, so for 
simplicity we don't have to bother considering the events invalid when 
we know they will always be non-present and thus filtered anyway.

>>> If we are confident that we have a fixed set of base set of events, 
>>> can we ensure that those events would not require this compat string 
>>> which needs each version explicitly stated?
>>>
>> If we are sure that some events will always exist in subsequent 
>> versions, we can set the Compat field to "arm_cmn;arm_ci". After that,
>> whether it is a different model or a different revision of the cmn 
>> PMU, it will be compatible. That is, it matches all whose identifier
>> is prefixed with “arm_cmn” or “arm_ci”.
> 
> Sure, we could do something like that. Or if we are super-confident that 
> every model and rev will support some event, then we can change perf 
> tool to just not check Compat for that event.

The majority of events have stayed unchanged since the introduction of 
their respective node type, so assuming we already have a basic match on 
the PMU name to know which JSON to be looking at in the first place, I'd 
imagine the Compat field could be optional, and only needed for events 
which first appear in a subsequent revision or model, or the fiddly 
cases like where DVM node events got entirely rewritten in CMN-650.

Thanks,
Robin.
