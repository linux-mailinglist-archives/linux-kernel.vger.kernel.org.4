Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CA7133BF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjE0JhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 05:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjE0JhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 05:37:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BF29C;
        Sat, 27 May 2023 02:37:12 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QSxVM3cL4zLmNn;
        Sat, 27 May 2023 17:35:39 +0800 (CST)
Received: from [10.67.103.44] (10.67.103.44) by dggpeml500002.china.huawei.com
 (7.185.36.158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sat, 27 May
 2023 17:37:10 +0800
Subject: Re: [PATCH 2/3] drivers/perf: hisi: Add support for HiSilicon UC PMU
 driver
To:     Yicong Yang <yangyicong@huawei.com>, <will@kernel.org>,
        <jonathan.cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>
References: <20230523131825.6102-1-hejunhao3@huawei.com>
 <20230523131825.6102-3-hejunhao3@huawei.com>
 <53d143fc-ce68-0d0b-1186-c8a5d87af0c5@huawei.com>
CC:     <yangyicong@hisilicon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linuxarm@huawei.com>,
        <shenyang39@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <be66d939-fcc1-4148-6fd8-96a5ab578f5b@huawei.com>
Date:   Sat, 27 May 2023 17:37:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <53d143fc-ce68-0d0b-1186-c8a5d87af0c5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.44]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Hi Yicong,


On 2023/5/25 21:39, Yicong Yang wrote:
> Hi Junhao,
>
> On 2023/5/23 21:18, Junhao He wrote:
>> On HiSilicon Hip09 platform, there is a UC (unified cache) module
>> on each chip SCCL (Super CPU Cluster). UC is a cache that provides
>> coherence between NUMA and UMA domains. It is located between L2
>> and Memory System. While PA uncore PMU model is the same as other
>> Hip09 PMU modules and many PMU events are supported. Let's support
>> the PMU driver using the HiSilicon uncore PMU framework.
>>
>> * rd_req_en : rd_req_en is the abbreviation of read request tracetag enable
>> and allows user to count only read operations.
>> details are listed in the hisi-pmu document.
>>
>> * srcid_en & srcid: allows user to filter statistics that come from
>> specific CPU/ICL by configuration source ID.
>>
>> * uring_channel: Allows users to filter statistical information based on
>> the specified tx request uring channel.
>> uring_channel only supported events: [0x47 ~ 0x59].
>>
> Just a quick glance and some minor comments below.

Thanks for your comments.

>> Signed-off-by: Junhao He <hejunhao3@huawei.com>
>> ---
>>   drivers/perf/hisilicon/Makefile             |   2 +-
>>   drivers/perf/hisilicon/hisi_uncore_pmu.c    |   5 +-
>>   drivers/perf/hisilicon/hisi_uncore_pmu.h    |   6 +
>>   drivers/perf/hisilicon/hisi_uncore_uc_pmu.c | 581 ++++++++++++++++++++
>>   4 files changed, 592 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>>
>> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
>> index 4d2c9abe3372..48dcc8381ea7 100644
>> --- a/drivers/perf/hisilicon/Makefile
>> +++ b/drivers/perf/hisilicon/Makefile
>> @@ -1,7 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>>   			  hisi_uncore_hha_pmu.o hisi_uncore_ddrc_pmu.o hisi_uncore_sllc_pmu.o \
>> -			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o
>> +			  hisi_uncore_pa_pmu.o hisi_uncore_cpa_pmu.o hisi_uncore_uc_pmu.o
>>   
>>   obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
>>   obj-$(CONFIG_HNS3_PMU) += hns3_pmu.o
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> index 2823f381930d..c5ac1c1a9fc1 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
>> @@ -20,7 +20,6 @@
>>   
>>   #include "hisi_uncore_pmu.h"
>>   
>> -#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
>>   #define HISI_MAX_PERIOD(nr) (GENMASK_ULL((nr) - 1, 0))
>>   
>>   /*
>> @@ -226,6 +225,10 @@ int hisi_uncore_pmu_event_init(struct perf_event *event)
>>   	hwc->idx		= -1;
>>   	hwc->config_base	= event->attr.config;
>>   
>> +	if (hisi_pmu->ops->check_format)
>> +		if (hisi_pmu->ops->check_format(event))
> It can be merged into one if.

Yes, I will do that.

>> +			return -EINVAL;
>> +
>>   	/* Enforce to use the same CPU for all events in this PMU */
>>   	event->cpu = hisi_pmu->on_cpu;
>>   
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> index 73574cc0a243..af6529e99c13 100644
>> --- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
>> @@ -49,9 +49,15 @@ enum hisi_pmu_version {
>>   	HISI_PMU_MAX
>>   };
>>   
>> +#define HISI_GET_EVENTID(ev) (ev->hw.config_base & 0xff)
>> +
>> +#define HISI_PMU_EVTYPE_BITS		8
>> +#define HISI_PMU_EVTYPE_SHIFT(idx)	((idx) % 4 * HISI_PMU_EVTYPE_BITS)
>> +
>>   struct hisi_pmu;
>>   
>>   struct hisi_uncore_ops {
>> +	int (*check_format)(struct perf_event *event);
>>   	void (*write_evtype)(struct hisi_pmu *, int, u32);
>>   	int (*get_event_idx)(struct perf_event *);
>>   	u64 (*read_counter)(struct hisi_pmu *, struct hw_perf_event *);
>> diff --git a/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> new file mode 100644
>> index 000000000000..385966eab816
>> --- /dev/null
>> +++ b/drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
>> @@ -0,0 +1,581 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * HiSilicon SoC UC (unified cache) uncore Hardware event counters support
>> + *
>> + * Copyright (C) 2023 HiSilicon Limited
>> + *
>> + * This code is based on the uncore PMUs like hisi_uncore_l3c_pmu.
>> + */
>> +#include <linux/cpuhotplug.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/list.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/property.h>
>> +
>> +#include "hisi_uncore_pmu.h"
>> +
>> +/* Dynamic CPU hotplug state used by UC PMU */
>> +static enum cpuhp_state hisi_uc_pmu_online;
>> +
>> +/* UC register definition */
>> +#define HISI_UC_INT_MASK_REG		0x0800
>> +#define HISI_UC_INT_STS_REG		0x0808
>> +#define HISI_UC_INT_CLEAR_REG		0x080c
>> +#define HISI_UC_TRACETAG_CTRL_REG	0x1b2c
>> +#define HISI_UC_TRACETAG_REQ_MSK	GENMASK(9, 7)
>> +#define HISI_UC_TRACETAG_MARK_EN	BIT(0)
>> +#define HISI_UC_TRACETAG_REQ_EN		(HISI_UC_TRACETAG_MARK_EN | BIT(2))
>> +#define HISI_UC_TRACETAG_SRCID_EN	BIT(3)
>> +#define HISI_UC_SRCID_CTRL_REG		0x1b40
>> +#define HISI_UC_SRCID_MSK		GENMASK(14, 1)
>> +#define HISI_UC_EVENT_CTRL_REG		0x1c00
>> +#define HISI_UC_EVENT_TRACETAG_EN	BIT(29)
>> +#define HISI_UC_EVENT_URING_MSK		GENMASK(28, 27)
>> +#define HISI_UC_EVENT_GLB_EN		BIT(26)
>> +#define HISI_UC_VERSION_REG		0x1cf0
>> +#define HISI_UC_EVTYPE0_REG		0x1d00
>> +#define HISI_UC_EVTYPE_REG(n)		(HISI_UC_EVTYPE0_REG + (n) * 4)
>> +#define HISI_UC_EVTYPE_MASK		GENMASK(7, 0)
>> +#define HISI_UC_CNTR0_REG		0x1e00
>> +#define HISI_UC_CNTR_REG(n)		(HISI_UC_CNTR0_REG + (n) * 8)
>> +
>> +#define HISI_UC_NR_COUNTERS		0x8
>> +#define HISI_UC_V2_NR_EVENTS		0xFF
>> +#define HISI_UC_CNTR_REG_BITS		64
>> +
>> +#define HISI_UC_RD_REQ_TRACETAG		0x4
>> +#define HISI_UC_URING_EVENT_MIN		0x47
>> +#define HISI_UC_URING_EVENT_MAX		0x59
>> +
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(rd_req_en, config1, 0, 0);
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(uring_channel, config1, 5, 4);
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid, config1, 19, 6);
>> +HISI_PMU_EVENT_ATTR_EXTRACTOR(srcid_en, config1, 20, 20);
>> +
>> +static int hisi_uc_pmu_check_format(struct perf_event *event)
> check_config or check_event will be clearer.

Sure, Will fix in next version.

>
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +
>> +	if (hisi_get_srcid_en(event) && !hisi_get_rd_req_en(event)) {
>> +		dev_err(uc_pmu->dev,
>> +			"Failed to set srcid: depending on read request enabled!\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!hisi_get_uring_channel(event))
>> +		return 0;
>> +
>> +	if ((HISI_GET_EVENTID(event) < HISI_UC_URING_EVENT_MIN) ||
>> +	    (HISI_GET_EVENTID(event) > HISI_UC_URING_EVENT_MAX))
>> +		dev_warn(uc_pmu->dev,
>> +			 "Only events: [%#x ~ %#x] support channel filtering!",
>> +			 HISI_UC_URING_EVENT_MIN, HISI_UC_URING_EVENT_MAX);
>> +
>> +	return 0;
>> +}
>> +
>> +static void hisi_uc_pmu_config_req_tracetag(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 val;
>> +
>> +	if (!hisi_get_rd_req_en(event))
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	/* The request-type has been configured */
>> +	if (FIELD_GET(HISI_UC_TRACETAG_REQ_MSK, val) == HISI_UC_RD_REQ_TRACETAG)
>> +		return;
>> +
>> +	/* Set request-type for tracetag, only read request is supported! */
>> +	val &= ~HISI_UC_TRACETAG_REQ_MSK;
>> +	val |= FIELD_PREP(HISI_UC_TRACETAG_REQ_MSK, HISI_UC_RD_REQ_TRACETAG);
>> +	val |= HISI_UC_TRACETAG_REQ_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_clear_req_tracetag(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 val;
>> +
>> +	if (!hisi_get_rd_req_en(event))
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	/* Do nothing, the request-type tracetag has been cleaned up */
>> +	if (FIELD_GET(HISI_UC_TRACETAG_REQ_MSK, val) == 0)
>> +		return;
>> +
>> +	/* Clear request-type */
>> +	val &= ~HISI_UC_TRACETAG_REQ_MSK;
>> +	val &= ~HISI_UC_TRACETAG_REQ_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_config_srcid_tracetag(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 val;
>> +
>> +	if (!hisi_get_srcid_en(event))
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	/* Do nothing, the source id has been configured */
>> +	if (FIELD_GET(HISI_UC_TRACETAG_SRCID_EN, val))
>> +		return;
>> +
>> +	/* Enable source id tracetag */
>> +	val |= HISI_UC_TRACETAG_SRCID_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_SRCID_CTRL_REG);
>> +	val &= ~HISI_UC_SRCID_MSK;
>> +	val |= FIELD_PREP(HISI_UC_SRCID_MSK, hisi_get_srcid(event));
>> +	writel(val, uc_pmu->base + HISI_UC_SRCID_CTRL_REG);
>> +
>> +	/* Depend on request-type tracetag enabled */
>> +	hisi_uc_pmu_config_req_tracetag(event);
>> +}
>> +
>> +static void hisi_uc_pmu_clear_srcid_tracetag(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 val;
>> +
>> +	if (!hisi_get_srcid_en(event))
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	/* Do nothing, the source id has been cleaned up */
>> +	if (FIELD_GET(HISI_UC_TRACETAG_SRCID_EN, val) == 0)
>> +		return;
>> +
>> +	hisi_uc_pmu_clear_req_tracetag(event);
>> +
>> +	/* Disable source id tracetag */
>> +	val &= ~HISI_UC_TRACETAG_SRCID_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_TRACETAG_CTRL_REG);
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_SRCID_CTRL_REG);
>> +	val &= ~HISI_UC_SRCID_MSK;
>> +	writel(val, uc_pmu->base + HISI_UC_SRCID_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_config_uring_channel(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 uring_channel = hisi_get_uring_channel(event);
>> +	u32 val;
>> +
>> +	/* Do nothing if not being set or is set explicitly to zero (default) */
>> +	if (uring_channel == 0)
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +
>> +	/* Do nothing, the uring_channel has been configured */
>> +	if (uring_channel == FIELD_GET(HISI_UC_EVENT_URING_MSK, val))
>> +		return;
>> +
>> +	val &= ~HISI_UC_EVENT_URING_MSK;
>> +	val |= FIELD_PREP(HISI_UC_EVENT_URING_MSK, uring_channel);
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_clear_uring_channel(struct perf_event *event)
>> +{
>> +	struct hisi_pmu *uc_pmu = to_hisi_pmu(event->pmu);
>> +	u32 val;
>> +
>> +	/* Do nothing if not being set or is set explicitly to zero (default) */
>> +	if (hisi_get_uring_channel(event) == 0)
>> +		return;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +
>> +	/* Do nothing, the uring_channel has been cleaned up */
>> +	if (FIELD_GET(HISI_UC_EVENT_URING_MSK, val) == 0)
>> +		return;
>> +
>> +	val &= ~HISI_UC_EVENT_URING_MSK;
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_enable_filter(struct perf_event *event)
>> +{
>> +	if (event->attr.config1 == 0)
>> +		return;
>> +
>> +	hisi_uc_pmu_config_uring_channel(event);
>> +	hisi_uc_pmu_config_req_tracetag(event);
>> +	hisi_uc_pmu_config_srcid_tracetag(event);
>> +}
>> +
>> +static void hisi_uc_pmu_disable_filter(struct perf_event *event)
>> +{
>> +	if (event->attr.config1 == 0)
>> +		return;
>> +
>> +	hisi_uc_pmu_clear_srcid_tracetag(event);
>> +	hisi_uc_pmu_clear_req_tracetag(event);
>> +	hisi_uc_pmu_clear_uring_channel(event);
>> +}
>> +
>> +static void hisi_uc_pmu_write_evtype(struct hisi_pmu *uc_pmu, int idx, u32 type)
>> +{
>> +	u32 val;
>> +
>> +	/*
>> +	 * Select the appropriate event select register.
>> +	 * There are 2 32-bit event select registers for the
>> +	 * 8 hardware counters, each event code is 8-bit wide.
>> +	 */
>> +	val = readl(uc_pmu->base + HISI_UC_EVTYPE_REG(idx / 4));
>> +	val &= ~(HISI_UC_EVTYPE_MASK << HISI_PMU_EVTYPE_SHIFT(idx));
>> +	val |= (type << HISI_PMU_EVTYPE_SHIFT(idx));
>> +	writel(val, uc_pmu->base + HISI_UC_EVTYPE_REG(idx / 4));
>> +}
>> +
>> +static void hisi_uc_pmu_start_counters(struct hisi_pmu *uc_pmu)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +	val |= HISI_UC_EVENT_GLB_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_stop_counters(struct hisi_pmu *uc_pmu)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +	val &= ~HISI_UC_EVENT_GLB_EN;
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_enable_counter(struct hisi_pmu *uc_pmu,
>> +					struct hw_perf_event *hwc)
>> +{
>> +	u32 val;
>> +
>> +	/* Enable counter index */
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +	val |= (1 << hwc->idx);
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_disable_counter(struct hisi_pmu *uc_pmu,
>> +					struct hw_perf_event *hwc)
>> +{
>> +	u32 val;
>> +
>> +	/* Clear counter index */
>> +	val = readl(uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +	val &= ~(1 << hwc->idx);
>> +	writel(val, uc_pmu->base + HISI_UC_EVENT_CTRL_REG);
>> +}
>> +
>> +static u64 hisi_uc_pmu_read_counter(struct hisi_pmu *uc_pmu,
>> +				    struct hw_perf_event *hwc)
>> +{
>> +	return readq(uc_pmu->base + HISI_UC_CNTR_REG(hwc->idx));
>> +}
>> +
>> +static void hisi_uc_pmu_write_counter(struct hisi_pmu *uc_pmu,
>> +				      struct hw_perf_event *hwc, u64 val)
>> +{
>> +	hisi_uc_pmu_start_counters(uc_pmu);
>> +	writeq(val, uc_pmu->base + HISI_UC_CNTR_REG(hwc->idx));
>> +}
>> +
>> +static void hisi_uc_pmu_enable_counter_int(struct hisi_pmu *uc_pmu,
>> +					   struct hw_perf_event *hwc)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_INT_MASK_REG);
>> +	/* Write 0 to enable interrupt */
> The comment here and below maybe redundant. The code is self explanatory

Ok, i will drop this

>
>> +	val &= ~(1 << hwc->idx);
>> +	writel(val, uc_pmu->base + HISI_UC_INT_MASK_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_disable_counter_int(struct hisi_pmu *uc_pmu,
>> +					    struct hw_perf_event *hwc)
>> +{
>> +	u32 val;
>> +
>> +	val = readl(uc_pmu->base + HISI_UC_INT_MASK_REG);
>> +	/* Write 1 to mask interrupt */
>> +	val |= (1 << hwc->idx);
>> +	writel(val, uc_pmu->base + HISI_UC_INT_MASK_REG);
>> +}
>> +
>> +static u32 hisi_uc_pmu_get_int_status(struct hisi_pmu *uc_pmu)
>> +{
>> +	return readl(uc_pmu->base + HISI_UC_INT_STS_REG);
>> +}
>> +
>> +static void hisi_uc_pmu_clear_int_status(struct hisi_pmu *uc_pmu, int idx)
>> +{
>> +	writel(1 << idx, uc_pmu->base + HISI_UC_INT_CLEAR_REG);
>> +}
>> +
>> +static int hisi_uc_pmu_init_data(struct platform_device *pdev,
>> +				 struct hisi_pmu *uc_pmu)
>> +{
>> +	/*
>> +	 * Use the SCCL_ID and CCL_ID to identify the UC PMU, while
>> +	 * SCCL_ID is in MPIDR[aff2] and CCL_ID is in MPIDR[aff1].
>> +	 */
> The comment doesn't match what you've done here, these information
> is gotten from device properties rather than MPIDR.
>
> Thanks.

Will update the comment
Thanks.


Best regards,
Junhao.

