Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F71710CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241189AbjEYNFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241176AbjEYNFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:05:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDADE5C;
        Thu, 25 May 2023 06:04:51 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QRp9K5W8GzYsmK;
        Thu, 25 May 2023 21:01:57 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 21:04:05 +0800
CC:     <yangyicong@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/3] drivers/perf: hisi: Add support for HiSilicon H60PA
 and PAv3 PMU driver
To:     Junhao He <hejunhao3@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20230523131825.6102-1-hejunhao3@huawei.com>
 <20230523131825.6102-2-hejunhao3@huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <a7f03000-3f3f-efd3-9eec-e7f001b02742@huawei.com>
Date:   Thu, 25 May 2023 21:04:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230523131825.6102-2-hejunhao3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Junhao,

On 2023/5/23 21:18, Junhao He wrote:
> Compared to the original PA device, H60PA offers higher bandwidth.
> The H60PA is a new device and we use HID to differentiate them.
> 
> The events supported by PAv3 and PAv2 are different. They use the
> same HID. The PMU version register is used in the driver to
> distinguish different versions.
> 
> For each H60PA PMU, except for the overflow interrupt register, other
> functions of the H60PA PMU are the same as the original PA PMU module.
> It has 8-programable counters and each counter is free-running.
> Interrupt is supported to handle counter (64-bits) overflow.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>  drivers/perf/hisilicon/hisi_uncore_pa_pmu.c | 138 +++++++++++++++++---
>  drivers/perf/hisilicon/hisi_uncore_pmu.h    |  36 ++++-
>  2 files changed, 157 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> index 71b6687d6696..e7e8cb999911 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> +++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
> @@ -22,9 +22,14 @@
>  #define PA_TT_CTRL			0x1c08
>  #define PA_TGTID_CTRL			0x1c14
>  #define PA_SRCID_CTRL			0x1c18
> +/* H32 PA interrupt registers */
>  #define PA_INT_MASK			0x1c70
>  #define PA_INT_STATUS			0x1c78
>  #define PA_INT_CLEAR			0x1c7c
> +/* H60 PA interrupt registers */
> +#define H60PA_INT_STATUS		0x1c70
> +#define H60PA_INT_MASK			0x1c74
> +/* End interrupt registers */

It'll be better to extract these version specific registers to a different
block and get rid of this comment.

>  #define PA_EVENT_TYPE0			0x1c80
>  #define PA_PMU_VERSION			0x1cf0
>  #define PA_EVENT_CNT0_L			0x1d00
> @@ -46,6 +51,12 @@ HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_cmd, config1, 32, 22);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_msk, config1, 43, 33);
>  HISI_PMU_EVENT_ATTR_EXTRACTOR(tracetag_en, config1, 44, 44);
>  
> +struct hisi_pa_pmu_int_regs {
> +	u32 mask;
> +	u32 clear;
> +	u32 status;
> +};

These feels like values of the register but actually they're offset, it'll be clearer to
have a _offset suffix and a int_ prefix for "interrupt".

is the offset for irq clear register keep the same for different version? If so, just drop it.

> +
>  static void hisi_pa_pmu_enable_tracetag(struct perf_event *event)
>  {
>  	struct hisi_pmu *pa_pmu = to_hisi_pmu(event->pmu);
> @@ -219,44 +230,51 @@ static void hisi_pa_pmu_disable_counter(struct hisi_pmu *pa_pmu,
>  static void hisi_pa_pmu_enable_counter_int(struct hisi_pmu *pa_pmu,
>  					   struct hw_perf_event *hwc)
>  {
> +	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->present;
>  	u32 val;
>  
>  	/* Write 0 to enable interrupt */
> -	val = readl(pa_pmu->base + PA_INT_MASK);
> +	val = readl(pa_pmu->base + regs->mask);
>  	val &= ~(1 << hwc->idx);
> -	writel(val, pa_pmu->base + PA_INT_MASK);
> +	writel(val, pa_pmu->base + regs->mask);
>  }
>  
>  static void hisi_pa_pmu_disable_counter_int(struct hisi_pmu *pa_pmu,
>  					    struct hw_perf_event *hwc)
>  {
> +	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->present;
>  	u32 val;
>  
>  	/* Write 1 to mask interrupt */
> -	val = readl(pa_pmu->base + PA_INT_MASK);
> +	val = readl(pa_pmu->base + regs->mask);
>  	val |= 1 << hwc->idx;
> -	writel(val, pa_pmu->base + PA_INT_MASK);
> +	writel(val, pa_pmu->base + regs->mask);
>  }
>  
>  static u32 hisi_pa_pmu_get_int_status(struct hisi_pmu *pa_pmu)
>  {
> -	return readl(pa_pmu->base + PA_INT_STATUS);
> +	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->present;
> +
> +	return readl(pa_pmu->base + regs->status);
>  }
>  
>  static void hisi_pa_pmu_clear_int_status(struct hisi_pmu *pa_pmu, int idx)
>  {
> -	writel(1 << idx, pa_pmu->base + PA_INT_CLEAR);
> -}
> +	struct hisi_pa_pmu_int_regs *regs = pa_pmu->dev_info->present;
>  
> -static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
> -	{ "HISI0273", },
> -	{}
> -};
> -MODULE_DEVICE_TABLE(acpi, hisi_pa_pmu_acpi_match);
> +	writel(1 << idx, pa_pmu->base + regs->clear);
> +}
>  
>  static int hisi_pa_pmu_init_data(struct platform_device *pdev,
>  				   struct hisi_pmu *pa_pmu)
>  {
> +	const struct hisi_pmu_dev_info *pa_pmu_info;
> +	int idx;
> +
> +	pa_pmu_info = device_get_match_data(&pdev->dev);
> +	if (!pa_pmu_info)
> +		return -ENODEV;
> +

How can it happen? Every supported HID has attached a data pointer. If you do
need this add some message here, it'll be useful to see where's wrong.

>  	/*
>  	 * As PA PMU is in a SICL, use the SICL_ID and the index ID
>  	 * to identify the PA PMU.
> @@ -284,6 +302,11 @@ static int hisi_pa_pmu_init_data(struct platform_device *pdev,
>  
>  	pa_pmu->identifier = readl(pa_pmu->base + PA_PMU_VERSION);
>  
> +	idx = hisi_uncore_pmu_ver2idx(pa_pmu);
> +	pa_pmu->dev_info = &pa_pmu_info[idx];
> +	if (!pa_pmu->dev_info || !pa_pmu->dev_info->name)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -314,6 +337,32 @@ static const struct attribute_group hisi_pa_pmu_v2_events_group = {
>  	.attrs = hisi_pa_pmu_v2_events_attr,
>  };
>  
> +static struct attribute *hisi_pa_pmu_v3_events_attr[] = {
> +	HISI_PMU_EVENT_ATTR(tx_req,	0x0),
> +	HISI_PMU_EVENT_ATTR(tx_dat,	0x1),
> +	HISI_PMU_EVENT_ATTR(tx_snp,	0x2),
> +	HISI_PMU_EVENT_ATTR(rx_req,	0x7),
> +	HISI_PMU_EVENT_ATTR(rx_dat,	0x8),
> +	HISI_PMU_EVENT_ATTR(rx_snp,	0x9),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_pa_pmu_v3_events_group = {
> +	.name = "events",
> +	.attrs = hisi_pa_pmu_v3_events_attr,
> +};
> +
> +static struct attribute *hisi_h60pa_pmu_events_attr[] = {
> +	HISI_PMU_EVENT_ATTR(rx_flit,	0x50),
> +	HISI_PMU_EVENT_ATTR(tx_flit,	0x65),
> +	NULL
> +};
> +
> +static const struct attribute_group hisi_h60pa_pmu_events_group = {
> +	.name = "events",
> +	.attrs = hisi_h60pa_pmu_events_attr,
> +};
> +
>  static DEVICE_ATTR(cpumask, 0444, hisi_cpumask_sysfs_show, NULL);
>  
>  static struct attribute *hisi_pa_pmu_cpumask_attrs[] = {
> @@ -345,6 +394,57 @@ static const struct attribute_group *hisi_pa_pmu_v2_attr_groups[] = {
>  	NULL
>  };
>  
> +static const struct attribute_group *hisi_pa_pmu_v3_attr_groups[] = {
> +	&hisi_pa_pmu_v2_format_group,
> +	&hisi_pa_pmu_v3_events_group,
> +	&hisi_pa_pmu_cpumask_attr_group,
> +	&hisi_pa_pmu_identifier_group,
> +	NULL
> +};
> +
> +static struct hisi_pa_pmu_int_regs hisi_pa_pmu_regs = {
> +	.mask = PA_INT_MASK,
> +	.clear = PA_INT_CLEAR,
> +	.status = PA_INT_STATUS,
> +};
> +
> +static const struct hisi_pmu_dev_info hisi_h32pa[] = {
> +	[1] = {
> +		.name = "pa",
> +		.attr_groups = hisi_pa_pmu_v2_attr_groups,
> +		.present = &hisi_pa_pmu_regs,
> +	},
> +	[2] = {
> +		.name = "pa",
> +		.attr_groups = hisi_pa_pmu_v3_attr_groups,
> +		.present = &hisi_pa_pmu_regs,
> +	},
> +	{}
> +};
> +
> +static const struct attribute_group *hisi_h60pa_pmu_attr_groups[] = {
> +	&hisi_pa_pmu_v2_format_group,
> +	&hisi_h60pa_pmu_events_group,
> +	&hisi_pa_pmu_cpumask_attr_group,
> +	&hisi_pa_pmu_identifier_group,
> +	NULL
> +};
> +
> +static struct hisi_pa_pmu_int_regs hisi_h60pa_pmu_regs = {
> +	.mask = H60PA_INT_MASK,
> +	.clear = H60PA_INT_STATUS, /* Clear on write */
> +	.status = H60PA_INT_STATUS,
> +};
> +
> +static const struct hisi_pmu_dev_info hisi_h60pa[] = {
> +	[1] = {
> +		.name = "h60pa",
> +		.attr_groups = hisi_h60pa_pmu_attr_groups,
> +		.present = &hisi_h60pa_pmu_regs,
> +	},
> +	{}
> +};
> +
>  static const struct hisi_uncore_ops hisi_uncore_pa_ops = {
>  	.write_evtype		= hisi_pa_pmu_write_evtype,
>  	.get_event_idx		= hisi_uncore_pmu_get_event_idx,
> @@ -375,7 +475,7 @@ static int hisi_pa_pmu_dev_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> -	pa_pmu->pmu_events.attr_groups = hisi_pa_pmu_v2_attr_groups;
> +	pa_pmu->pmu_events.attr_groups = pa_pmu->dev_info->attr_groups;
>  	pa_pmu->num_counters = PA_NR_COUNTERS;
>  	pa_pmu->ops = &hisi_uncore_pa_ops;
>  	pa_pmu->check_event = 0xB0;
> @@ -400,8 +500,9 @@ static int hisi_pa_pmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%u_pa%u",
> -			      pa_pmu->sicl_id, pa_pmu->index_id);
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "hisi_sicl%d_%s%u",
> +			      pa_pmu->sicl_id, pa_pmu->dev_info->name,
> +			      pa_pmu->index_id);
>  	if (!name)
>  		return -ENOMEM;
>  
> @@ -435,6 +536,13 @@ static int hisi_pa_pmu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct acpi_device_id hisi_pa_pmu_acpi_match[] = {
> +	{ "HISI0273", (kernel_ulong_t)hisi_h32pa },
> +	{ "HISI0274", (kernel_ulong_t)hisi_h60pa },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, hisi_pa_pmu_acpi_match);
> +
>  static struct platform_driver hisi_pa_pmu_driver = {
>  	.driver = {
>  		.name = "hisi_pa_pmu",
> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> index 07890a8e96ca..73574cc0a243 100644
> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
> @@ -23,7 +23,6 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt)     "hisi_pmu: " fmt
>  
> -#define HISI_PMU_V2		0x30
>  #define HISI_MAX_COUNTERS 0x10
>  #define to_hisi_pmu(p)	(container_of(p, struct hisi_pmu, pmu))
>  
> @@ -43,6 +42,13 @@
>  		return FIELD_GET(GENMASK_ULL(hi, lo), event->attr.config);  \
>  	}
>  
> +enum hisi_pmu_version {
> +	HISI_PMU_V1,
> +	HISI_PMU_V2 = 0x30,
> +	HISI_PMU_V3 = 0x40,
> +	HISI_PMU_MAX
> +};
> +
>  struct hisi_pmu;
>  
>  struct hisi_uncore_ops {
> @@ -62,6 +68,13 @@ struct hisi_uncore_ops {
>  	void (*disable_filter)(struct perf_event *event);
>  };
>  
> +/* Describes the HISI PMU chip features information */
> +struct hisi_pmu_dev_info {
> +	const char *name;
> +	const struct attribute_group **attr_groups;
> +	void *present;

present is unclear. Better for another name.

> +};
> +
>  struct hisi_pmu_hwevents {
>  	struct perf_event *hw_events[HISI_MAX_COUNTERS];
>  	DECLARE_BITMAP(used_mask, HISI_MAX_COUNTERS);
> @@ -72,6 +85,7 @@ struct hisi_pmu_hwevents {
>  struct hisi_pmu {
>  	struct pmu pmu;
>  	const struct hisi_uncore_ops *ops;
> +	const struct hisi_pmu_dev_info *dev_info;
>  	struct hisi_pmu_hwevents pmu_events;
>  	/* associated_cpus: All CPUs associated with the PMU */
>  	cpumask_t associated_cpus;
> @@ -92,7 +106,7 @@ struct hisi_pmu {
>  	int counter_bits;
>  	/* check event code range */
>  	int check_event;
> -	u32 identifier;
> +	enum hisi_pmu_version identifier;
>  };
>  
>  int hisi_uncore_pmu_get_event_idx(struct perf_event *event);
> @@ -122,4 +136,22 @@ int hisi_uncore_pmu_init_irq(struct hisi_pmu *hisi_pmu,
>  			     struct platform_device *pdev);
>  
>  void hisi_pmu_init(struct hisi_pmu *hisi_pmu, struct module *module);
> +
> +int hisi_uncore_pmu_ver2idx(struct hisi_pmu *pmu)

may need a "static inline" qualifier. This function is used only in the pa pmu,
don't need to put it in the header.

> +{
> +	int idx;
> +
> +	switch (pmu->identifier) {

I see no advantage for defining the versions as enum, use macro is ok. You just
read the identifiers from the hardware and have no other handling. And this
function makes things even complex, just handle it as simple as possible is
preferred. maybe:

switch (pmu->identifier) {
	case HISI_PMU_V1:
		pa_pmu->device_info = hisi_h32pa_v1;
		break;
	case HISI_PMU_V2:
		pa_pmu->device_info = hisi_h32pa_v2;
		break;
[...]

Thanks.

> +	case HISI_PMU_V1:
> +		idx = 0; break;
> +	case HISI_PMU_V2:
> +		idx = 1; break;
> +	case HISI_PMU_V3:
> +	/* When running on later version, returns the largest supported version */
> +	default:
> +		idx = 2;
> +	}
> +
> +	return idx;
> +}
>  #endif /* __HISI_UNCORE_PMU_H__ */
> 
