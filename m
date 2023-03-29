Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734E76CF15E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjC2Rry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjC2Rrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:47:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B71E6525E;
        Wed, 29 Mar 2023 10:47:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E4A2F4;
        Wed, 29 Mar 2023 10:48:34 -0700 (PDT)
Received: from [10.57.56.187] (unknown [10.57.56.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBC5A3F6C4;
        Wed, 29 Mar 2023 10:47:47 -0700 (PDT)
Message-ID: <091d5b8d-6ea7-e6ff-3421-63612797ac60@arm.com>
Date:   Wed, 29 Mar 2023 18:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC 1/4] driver/perf: Add identifier sysfs file for CMN
Content-Language: en-GB
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1679885172-95021-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1679885172-95021-2-git-send-email-renyu.zj@linux.alibaba.com>
 <72246c5e-6ba5-098b-a979-e90738cc7509@oracle.com>
 <8ba831ae-4568-32af-3fd1-fd51a7c13dcd@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8ba831ae-4568-32af-3fd1-fd51a7c13dcd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29 12:53, Jing Zhang wrote:
> 
> 
> 在 2023/3/27 下午3:55, John Garry 写道:
>> On 27/03/2023 03:46, Jing Zhang wrote:
>>> To allow userspace to identify the specific implementation of the device,
>>> add an "identifier" sysfs file.
>>>
>>> The perf tool can match the arm CMN metric through the identifier.
>>>
>>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>>> ---
>>>    drivers/perf/arm-cmn.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>>>    1 file changed, 43 insertions(+)
>>>
>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>>> index c968986..0c138ad 100644
>>> --- a/drivers/perf/arm-cmn.c
>>> +++ b/drivers/perf/arm-cmn.c
>>> @@ -1168,10 +1168,53 @@ static ssize_t arm_cmn_cpumask_show(struct device *dev,
>>>        .attrs = arm_cmn_cpumask_attrs,
>>>    };
>>>    +static ssize_t arm_cmn_identifier_show(struct device *dev,
>>> +        struct device_attribute *attr, char *buf)
>>> +{
>>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>>> +    if (cmn->model == CMN700) {
>>> +        return sysfs_emit(buf, "%s\n", "CMN700");
>>
>> Is it possible to have a pointer to this string in struct arm_cmn, such that we don't have to do this model to identifier lookup here? If-else chains like this are not scalable.
>>
> Will do.
> 
>> BTW, does this HW have some HW identifier register, like iidr? I think that using that may be preferable.
>>
> 
> I didn't find the relevant identifier register.
> 
> Do Illka and Robin know that there is such a register that can identify different CMN versions? Looking forward to your suggestions.

In principle the "part number" fields from CFGM_PERIPH_ID_0/1 are 
supposed to identify the model, but for various reasons I'm suspicious 
of that being unreliable (not least that no actual values are 
documented, only "configuration-dependent"). That's why I went down the 
route of making sure we have explicit ACPI/DT identifiers for every model.

However, the model alone seems either too specific or not specific 
enough for a jevents identifier. The defined metrics are pretty trivial 
and should have no real reason not to be common to *any* CMN PMU where 
the underlying events are present. On the other hand, if we want to get 
down to the level of specific events in JSON then we'd need to consider 
the revision as well, since there are several events which only exist on 
certain revisions of a given model (but often are also common to later 
models).

This actually foreshadows a question I was planning to bring up in the 
context of another driver I'm working on - for this one I would rather 
like to try using jevents rather than have to maintain another sprawl of 
event tables in a driver, but it's still going to have the same thing of 
wanting model/revision matching along the lines of what 
arm_cmn_event_attr_is_visible() is doing for CMN events. AFAICS this 
would need jevents to grow a rather more flexible way of encoding and 
matching identifiers, since having dozens of almost-identical copies of 
event definitions for every exact identifier value is clearly 
unworkable. Does anyone happen to have any thoughts or preferences 
around how that might be approached?

>>> +    }
>>> +    else if (cmn->model == CMN650) {
>>> +        return sysfs_emit(buf, "%s\n", "CMN650");
>>
>> I'd use lowercase names
>>
> Ok.
> 
>>> +    }
>>> +    else if (cmn->model == CMN600) {
>>> +        return sysfs_emit(buf, "%s\n", "CMN600");
>>> +    }
>>> +    else if (cmn->model == CI700) {
>>> +        return sysfs_emit(buf, "%s\n", "CI700");
>>> +    }
>>> +    return sysfs_emit(buf, "%s\n", "UNKNOWN");
>>
>> can we have a "is_visble" attr to just no show this when unknown?

No need - it will never be unknown unless someone goes out of their way 
to break the probing code and/or match_data.

>>
> 
> Ok.
> 
>>> +}
>>> +
>>> +static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
>>> +        struct attribute *attr, int n)
>>> +{
>>> +    struct device *dev = kobj_to_dev(kobj);
>>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>>> +    if (cmn->model <= 0)
>>> +        return 0;
>>> +    return attr->mode;
>>> +};

As above, "cmn->model <= 0" can never be true.

Thanks,
Robin.

>>> +
>>> +static struct device_attribute arm_cmn_identifier_attr =
>>> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
>>> +
>>> +static struct attribute *arm_cmn_identifier_attrs[] = {
>>> +    &arm_cmn_identifier_attr.attr,
>>> +    NULL,
>>
>> nit: no need for trailing ',' on a sentinel
>>
> 
> Ok, Will do.
> 
>>> +};
>>> +
>>> +static struct attribute_group arm_cmn_identifier_attr_group = {
>>> +    .attrs = arm_cmn_identifier_attrs,
>>> +    .is_visible = arm_cmn_identifier_attr_visible,
>>> +};
>>> +
>>>    static const struct attribute_group *arm_cmn_attr_groups[] = {
>>>        &arm_cmn_event_attrs_group,
>>>        &arm_cmn_format_attrs_group,
>>>        &arm_cmn_cpumask_attr_group,
>>> +    &arm_cmn_identifier_attr_group,
>>>        NULL
>>>    };
>>>    
