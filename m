Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E893725D02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbjFGLZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjFGLZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:25:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942D910DE;
        Wed,  7 Jun 2023 04:25:12 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Qbkm93n4jz18M3t;
        Wed,  7 Jun 2023 18:56:09 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 7 Jun
 2023 19:00:57 +0800
Subject: Re: [PATCH v2 2/3] drivers/perf: hisi: Add support for HiSilicon UC
 PMU driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230531104625.18296-1-hejunhao3@huawei.com>
 <20230531104625.18296-3-hejunhao3@huawei.com>
 <20230531165908.000022b0@Huawei.com>
CC:     <will@kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <yangyicong@huawei.com>, <shenyang39@huawei.com>,
        <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <e78b951f-eecc-8ac1-0784-695ca8027234@huawei.com>
Date:   Wed, 7 Jun 2023 19:00:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20230531165908.000022b0@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Hi Jonathan,


On 2023/5/31 23:59, Jonathan Cameron wrote:
> On Wed, 31 May 2023 18:46:24 +0800
> Junhao He <hejunhao3@huawei.com> wrote:
>
> Hi Junhao,
>
> A few small comments inline.
>
>> On HiSilicon Hip09 platform, there is a UC (unified cache) module
>> on each chip SCCL (Super CPU Cluster). UC is a cache that provides
>> coherence between NUMA and UMA domains. It is located between L2
>> and Memory System. While PA uncore PMU model is the same as other
>> Hip09 PMU modules and many PMU events are supported.
> I don't follow what this sentence means.  Normally you'd have
> While A, B is different..
>

Ok, will fix it.

>> Let's support
>> the PMU driver using the HiSilicon uncore PMU framework.
>>
>> * rd_req_en : rd_req_en is the abbreviation of read request tracetag enable
>> and allows user to count only read operations.
>> details are listed in the hisi-pmu document.
> Details are .. Also no need for the ine break
>    and allows user to count only read operations. Details are listed
>    in the hisi-pmu document at ....

Thanks, I'm going to replace this

>> * srcid_en & srcid: allows user to filter statistics that come from
> Allows
> for consistency with the uring_channel description that follows.

Yes, I will do that.

>> specific CPU/ICL by configuration source ID.
>>
>> * uring_channel: Allows users to filter statistical information based on
>> the specified tx request uring channel.
>> uring_channel only supported events: [0x47 ~ 0x59].
>>
>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> new file mode 100644
>> index 000000000000..d27f28584fd7
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> @@ -0,0 +1,577 @@
> ...
>
>
>
>
>> +static int hisi_uc_pmu_init_data(struct platform_device *pdev,
>> +				 struct hisi_pmu *uc_pmu)
>> +{
>> +	/*
>> +	 * Use SCCL (Super CPU Cluster) ID and CCL (CPU Cluster) ID to
>> +	 * identify the topology information of UC PMU devices in the chip.
>> +	 */
> >From patch description, I'd assume there is only one of these
> per sccl so why do we care about the cluster level or the sub-id?
> Perhaps that description is missleading?

They have some CCLs per SCCL and then 4 uc pmu per CCL.
The patch description is misleading and I will fix this in the next release.
Thanks.

>> +	if (device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
>> +				     &uc_pmu->sccl_id)) {
>> +		dev_err(&pdev->dev, "Can not read uc sccl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (device_property_read_u32(&pdev->dev, "hisilicon,ccl-id",
>> +				     &uc_pmu->ccl_id)) {
>> +		dev_err(&pdev->dev, "Can not read uc ccl-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (device_property_read_u32(&pdev->dev, "hisilicon,sub-id",
>> +				     &uc_pmu->sub_id)) {
>> +		dev_err(&pdev->dev, "Can not read sub-id!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	uc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(uc_pmu->base)) {
>> +		dev_err(&pdev->dev, "ioremap failed for uc_pmu resource\n");
>> +		return PTR_ERR(uc_pmu->base);
>> +	}
>> +
>> +	uc_pmu->identifier = readl(uc_pmu->base + HISI_UC_VERSION_REG);
>> +
>> +	return 0;
>> +}
>
>> +static struct platform_driver hisi_uc_pmu_driver = {
>> +	.driver = {
>> +		.name = "hisi_uc_pmu",
>> +		.acpi_match_table = hisi_uc_pmu_acpi_match,
>> +		/*
>> +		 * We have not worked out a safe bind/unbind process,
>> +		 * so this is not supported yet.
> If you can reference more info on this that would be great.
> Perhaps a thread talking about why?
forcefully unbinding during sampling will lead to a
kernel panic, because the perf upper-layer framework
call a NULL pointer in this situation.

Best regards,
Junhao.
>> +		 */
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = hisi_uc_pmu_probe,
>> +};
> .
>

