Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C445F6F6AF8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjEDMPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEDMPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:15:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DF7C5FD3;
        Thu,  4 May 2023 05:15:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915662F4;
        Thu,  4 May 2023 05:16:15 -0700 (PDT)
Received: from [10.57.83.11] (unknown [10.57.83.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0B143F67D;
        Thu,  4 May 2023 05:15:28 -0700 (PDT)
Message-ID: <6bb7eaee-2d00-46f5-89ff-95133aea9a5d@arm.com>
Date:   Thu, 4 May 2023 13:15:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
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
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
 <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
 <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
 <da55ef21-e199-79c3-5b65-d51edb2e754b@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <da55ef21-e199-79c3-5b65-d51edb2e754b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-04 12:02, John Garry wrote:
> On 04/05/2023 10:47, Robin Murphy wrote:
>>> nit: generally if (!val) is preferred
> 
> Hi Robin,
> 
>>
>> Although either way it can only be NULL in cases of memory corruption 
>> or developers making broken changes to the driver, neither of which 
>> are worth pretending to defend against.
> 
> If there was some broken code for setting this identifier, then we would 
> just not show the identifier file, rather than show it containing "NULL" 
> - that seems better. However, there may be other implications from that 
> same broken code, so you maintainers and contributors please decide.

Yeah, from the usage point of view, if there should be an identifier at 
all then there should always be one, so it makes little sense to pretend 
to accommodate a case where there wouldn't be. And it would be trivially 
obvious to see in review if someone adds a new model enum without any 
necessary identifier updates at the same time (far more so than spotting 
whether all the subtle functional differences of the new model have been 
accounted for).

>>>> +    return attr->mode;
>>>> +};
>>>> +
>>>> +static struct device_attribute arm_cmn_identifier_attr =
>>>> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
>>>> +
>>>> +static struct attribute *arm_cmn_identifier_attrs[] = {
>>>> +    &arm_cmn_identifier_attr.attr,
>>>> +    NULL
>>>> +};
>>>> +
>>>> +static struct attribute_group arm_cmn_identifier_attr_group = {
>>>> +    .attrs = arm_cmn_identifier_attrs,
>>>> +    .is_visible = arm_cmn_identifier_attr_visible
>>>> +};
>>>> +
>>>>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>>>>       &arm_cmn_event_attrs_group,
>>>>       &arm_cmn_format_attrs_group,
>>>>       &arm_cmn_cpumask_attr_group,
>>>> +    &arm_cmn_identifier_attr_group,
>>>>       NULL
>>>>   };
>>>> @@ -2241,6 +2273,22 @@ static int arm_cmn600_of_probe(struct 
>>>> device_node *np)
>>>>       return of_property_read_u32(np, "arm,root-node", &rootnode) ?: 
>>>> rootnode;
>>>>   }
>>>> +const char *arm_cmn_identifier(unsigned long model)
>>>> +{
>>>> +    switch (model) {
>>>> +    case CMN600:
>>>> +        return "cmn600";
>>>> +    case CMN650:
>>>> +        return "cmn650";
>>>> +    case CMN700:
>>>> +        return "cmn700";
>>>> +    case CI700:
>>>> +        return "ci700";
>>>> +    default:
>>>> +        return NULL;
>>>> +    }
>>>
>>> nit: I think that it would be nicer to have this per-model string 
>>> stored statically in arm_cmn_acpi_match[].driver_data and 
>>> arm_cmn_of_match[].data, so we have a straight lookup
>>
>> Again, I'm not really convinced how useful this coarse per-model 
>> scheme is - for instance, in terms of many events, CMN-600 r3 is 
>> closer to CMN-650 than it is to CMN-600 r1, so what exactly would 
>> "CMN-600" mean to the user?
> 
> ok, I see, that's what I was asking about in the cmn-700 JSON review; 
> and from what you say, it is not the case that we always have the same 
> events for every revision. So we need a more fine-grained identifier.

Yes, it's mostly just a case of new events getting added as the 
microarchitecture evolves over the product's lifetime, but there has 
been at least one event ID which had a meaning in very early versions of 
CMN-600, was subsequently removed, and then got reused for a *different* 
event a couple of revisions after that. Thankfully I believe those 
earliest versions only ever existed on FPGA internally, and the TRMs 
were never made public, so upstream doesn't care about that specific case.

> For DT support, I suppose per-revision compat strings could be added, 
> but I would not be sure what to do about ACPI.

We know the version from the ID registers, that's no problem - it's 
already used to manage visibility of the sysfs event aliases. In 
principle we *should* have a model code in CFGM_PERIPH_ID_0 as well, and 
be able to compose an identifier exactly the same way as 
smmu_pmu_get_iidr() does in the SMMUv3 PMCG driver, but as I mentioned 
before I'm not entirely confident in the implementation: I do happen to 
know what codes have been nominally assigned for each product, but the 
TRMs claim otherwise :(

> BTW, My comment was more about coding style of case a, case b, case c, 
> ... case z, does not scale well.

Indeed, it's probably the nature of the switch statement that leads to 
the perceived need for a not-practically-meaningful "default" case in 
the first place.

Thanks,
Robin.
