Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE1F73181E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbjFOMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344771AbjFOMEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:04:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD262978;
        Thu, 15 Jun 2023 05:02:52 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QhgM33RrkzqTt6;
        Thu, 15 Jun 2023 19:39:59 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 15 Jun
 2023 19:44:58 +0800
Subject: Re: [PATCH v4 1/3] drivers/perf: hisi: Add support for HiSilicon
 H60PA and PAv3 PMU driver
To:     Mark Rutland <mark.rutland@arm.com>
References: <20230609075608.36559-1-hejunhao3@huawei.com>
 <20230609075608.36559-2-hejunhao3@huawei.com> <ZILokkt17/yCPQQ2@FVFF77S0Q05N>
CC:     <will@kernel.org>, <jonathan.cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <1041ca74-9e63-f232-c0dd-fd14cc4b1e11@huawei.com>
Date:   Thu, 15 Jun 2023 19:44:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <ZILokkt17/yCPQQ2@FVFF77S0Q05N>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark

Thanks for your comments.

On 2023/6/9 16:53, Mark Rutland wrote:
> Hi,
>
> This generally looks ok, but I have a few minor comments.
>
> On Fri, Jun 09, 2023 at 03:56:06PM +0800, Junhao He wrote:
>> Compared to the original PA device, H60PA offers higher bandwidth.
>> The H60PA is a new device and we use HID to differentiate them.
>>
>> The events supported by PAv3 and PAv2 are different. They use the
>> same HID.
> That's a bit unfortunate -- doesn't that mean an older kernel that knows about
> v2 will try to probe v3 as v2? Presumably things will go wrong if it pokes the
> MMIO registers?
>
> I appreciate it may be too late to change that now, but it seems like something
> to consider in future (e.g. any changes not backwards compatible with v3 should
> use a new HID).

Yes, The older PA PMU driver will probe v3 as v2. And the PAv3 PMU removed
some events which are supported by PAv2 PMU. Therefore, the PA events
displayed by "perf list" cannot work properly.

We plan to add new HID for PAv3 PMU in next version.

Thanks.

>> The PMU version register is used in the driver to
>> distinguish different versions.
>>
>> For each H60PA PMU, except for the overflow interrupt register, other
>> functions of the H60PA PMU are the same as the original PA PMU module.
>> It has 8-programable counters and each counter is free-running.
>> Interrupt is supported to handle counter (64-bits) overflow.
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>   drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 142 +++++++++++++++++---
>>   drivers/perf/hisilicon/hisi_uncore_pmu.h    |   9 ++
>>   2 files changed, 136 insertions(+), 15 deletions(-)
>> @@ -284,6 +302,15 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
>>   
>>   	pa_pmu->identifier = readl(pa_pmu->base + PA_PMU_VERSION);
>>   
>> +	/* When running on v3 or later, returns the largest version supported */
>> +	if (pa_pmu->identifier >= HISI_PMU_V3)
>> +		pa_pmu->dev_info = &pa_pmu_info[2];
>> +	else if (pa_pmu->identifier == HISI_PMU_V2)
>> +		pa_pmu->dev_info = &pa_pmu_info[1];
>> +
>> +	if (!pa_pmu->dev_info || !pa_pmu->dev_info->name)
>> +		return -EINVAL;
>> +
> Why does this use indices '2' and '1'? What happened to '0'?
>
> It would be a bit clearer with something like:
>
> 	enum pmu_dev_info_idx {
> 		HISI_PMU_DEV_INFO_V2,
> 		HISI_PMU_DEV_INFO_V3,
> 		NR_HISI_PMU_DEV_INFO
> 	}
>
> Then the above can be:
>
> 	if (pa_pmu->identifier >= HISI_PMU_V3)
> 		pa_pmu->dev_info = &pa_pmu_info[PMU_DEV_INFO_V3];
> 	else if (pa_pmu->identifier == HISI_PMU_V2)
> 		pa_pmu->dev_info = &pa_pmu_info[PMU_DEV_INFO_V2];
> 	else
> 		return -EINVAL;
> 	
> 	if (!pa_pmu->dev_info->name)
> 		return -EINVAL;
>
> ... and when you define the dev_info instances:

Because of add new HID for PAv3, I'm going to replace the code with the 
following:

     pa_pmu->dev_info = pa_pmu_info;

>> +static const struct hisi_pmu_dev_info hisi_h32pa[] = {
>> +	[1] = {
>> +		.name = "pa",
>> +		.attr_groups = hisi_pa_pmu_v2_attr_groups,
>> +		.private = &hisi_pa_pmu_regs,
>> +	},
>> +	[2] = {
>> +		.name = "pa",
>> +		.attr_groups = hisi_pa_pmu_v3_attr_groups,
>> +		.private = &hisi_pa_pmu_regs,
>> +	},
>> +	{}
>> +};
> ... you could have:
>
> 	static const struct hisi_pmu_dev_info hisi_h32pa[NR_HISI_PMU_DEV_INFO] = {
> 		[HISI_PMU_DEV_INFO_V2] = {
> 			.name = "pa",
> 			.attr_groups = hisi_pa_pmu_v2_attr_groups,
> 			.private = &hisi_pa_pmu_regs,
> 		},
> 		[HISI_PMU_DEV_INFO_V3] = {
> 			.name = "pa",
> 			.attr_groups = hisi_pa_pmu_v3_attr_groups,
> 			.private = &hisi_pa_pmu_regs,
> 		},
> 	};
>
> ... which would clearly match up with the probe path, and would ensure the
> arrays are always correctly sized if there's a v4, etc.

and the initialization of the xxx_dev_info structure is as follows:

         struct hisi_pmu_dev_info hisi_h32pa_v2 = {
                 ...
         }

         struct hisi_pmu_dev_info hisi_h32pa_v3 = {
                 ...
         }

>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> index 07890a8e96ca..a8d6d6905f3f 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> @@ -24,6 +24,7 @@
>>   #define pr_fmt(fmt)     "hisi_pmu: " fmt
>>   
>>   #define HISI_PMU_V2		0x30
>> +#define HISI_PMU_V3		0x40
>>   #define HISI_MAX_COUNTERS 0x10
>>   #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
>>   
>> @@ -62,6 +63,13 @@ struct hisi_uncore_ops {
>>   	void (*disable_filter)(struct perf_event *event);
>>   };
>>   
>> +/* Describes the HISI PMU chip features information */
>> +struct hisi_pmu_dev_info {
>> +	const char *name;
>> +	const struct attribute_group **attr_groups;
>> +	void *private;
>> +};
>> +
>>   struct hisi_pmu_hwevents {
>>   	struct perf_event *hw_events[HISI_MAX_COUNTERS];
>>   	DECLARE_BITMAP(used_mask, HISI_MAX_COUNTERS);
>> @@ -72,6 +80,7 @@ struct hisi_pmu_hwevents {
>>   struct hisi_pmu {
>>   	struct pmu pmu;
>>   	const struct hisi_uncore_ops *ops;
>> +	const struct hisi_pmu_dev_info *dev_info;
>>   	struct hisi_pmu_hwevents pmu_events;
>>   	/* associated_cpus: All CPUs associated with the PMU */
>>   	cpumask_t associated_cpus;
> Will other hisi pmu drivers use the hisi_pmu_dev_info field in future?

yes, It is. and the member of private is also a general interface.
If other uncore PMU have private implementations in registers
or other, this member can also be used.

Best regards,
Junhao.

>
> I ask because otherwise you could make this local to hisi_uncore_pa_pmu.c if
> you structured this as:
>
> struct hisi_pa_pmu {
> 	struct hisi_pmu;
> 	const char *name;
> 	const struct attribute_group **attr_groups;
> 	const struct hisi_pa_pmu_int_regs *regs;
> }
>
> ... which would give you some additional type-safety.
>
> Thanks,
> Mark
>
> .
>

