Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48916F68A7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjEDJsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 05:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjEDJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 05:48:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D2359C4;
        Thu,  4 May 2023 02:48:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B65832F4;
        Thu,  4 May 2023 02:48:44 -0700 (PDT)
Received: from [10.57.83.11] (unknown [10.57.83.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A503F5A1;
        Thu,  4 May 2023 02:47:57 -0700 (PDT)
Message-ID: <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
Date:   Thu, 4 May 2023 10:47:53 +0100
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-01 13:38, John Garry wrote:
> On 24/04/2023 10:44, Jing Zhang wrote:
>> To allow userspace to identify the specific implementation of the device,
>> add an "identifier" sysfs file.
>>
>> The perf tool can match the arm CMN metric through the identifier.
>>
>> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
>> ---
>>   drivers/perf/arm-cmn.c | 49 
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>> index c968986..f425610 100644
>> --- a/drivers/perf/arm-cmn.c
>> +++ b/drivers/perf/arm-cmn.c
>> @@ -334,6 +334,7 @@ struct arm_cmn {
>>       struct pmu pmu;
>>       struct dentry *debug;
>> +    const char *identifier;
>>   };
>>   #define to_cmn(p)    container_of(p, struct arm_cmn, pmu)
>> @@ -1168,10 +1169,41 @@ static ssize_t arm_cmn_cpumask_show(struct 
>> device *dev,
>>       .attrs = arm_cmn_cpumask_attrs,
>>   };
>> +static ssize_t arm_cmn_identifier_show(struct device *dev,
>> +        struct device_attribute *attr, char *buf)
>> +{
>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>> +
>> +    return sysfs_emit(buf, "%s\n", cmn->identifier);
>> +}
>> +
>> +static umode_t arm_cmn_identifier_attr_visible(struct kobject *kobj,
>> +        struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct arm_cmn *cmn = to_cmn(dev_get_drvdata(dev));
>> +
>> +    if (cmn->identifier == NULL)
>> +        return 0;
> 
> nit: generally if (!val) is preferred

Although either way it can only be NULL in cases of memory corruption or 
developers making broken changes to the driver, neither of which are 
worth pretending to defend against.

>> +    return attr->mode;
>> +};
>> +
>> +static struct device_attribute arm_cmn_identifier_attr =
>> +__ATTR(identifier, 0444, arm_cmn_identifier_show, NULL);
>> +
>> +static struct attribute *arm_cmn_identifier_attrs[] = {
>> +    &arm_cmn_identifier_attr.attr,
>> +    NULL
>> +};
>> +
>> +static struct attribute_group arm_cmn_identifier_attr_group = {
>> +    .attrs = arm_cmn_identifier_attrs,
>> +    .is_visible = arm_cmn_identifier_attr_visible
>> +};
>> +
>>   static const struct attribute_group *arm_cmn_attr_groups[] = {
>>       &arm_cmn_event_attrs_group,
>>       &arm_cmn_format_attrs_group,
>>       &arm_cmn_cpumask_attr_group,
>> +    &arm_cmn_identifier_attr_group,
>>       NULL
>>   };
>> @@ -2241,6 +2273,22 @@ static int arm_cmn600_of_probe(struct 
>> device_node *np)
>>       return of_property_read_u32(np, "arm,root-node", &rootnode) ?: 
>> rootnode;
>>   }
>> +const char *arm_cmn_identifier(unsigned long model)
>> +{
>> +    switch (model) {
>> +    case CMN600:
>> +        return "cmn600";
>> +    case CMN650:
>> +        return "cmn650";
>> +    case CMN700:
>> +        return "cmn700";
>> +    case CI700:
>> +        return "ci700";
>> +    default:
>> +        return NULL;
>> +    }
> 
> nit: I think that it would be nicer to have this per-model string stored 
> statically in arm_cmn_acpi_match[].driver_data and 
> arm_cmn_of_match[].data, so we have a straight lookup

Again, I'm not really convinced how useful this coarse per-model scheme 
is - for instance, in terms of many events, CMN-600 r3 is closer to 
CMN-650 than it is to CMN-600 r1, so what exactly would "CMN-600" mean 
to the user?

Thanks,
Robin.

>> +}
>> +
>>   static int arm_cmn_probe(struct platform_device *pdev)
>>   {
>>       struct arm_cmn *cmn;
>> @@ -2254,6 +2302,7 @@ static int arm_cmn_probe(struct platform_device 
>> *pdev)
>>       cmn->dev = &pdev->dev;
>>       cmn->model = (unsigned long)device_get_match_data(cmn->dev);
>> +    cmn->identifier = arm_cmn_identifier(cmn->model);
>>       platform_set_drvdata(pdev, cmn);
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
