Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E552E6BEBC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCQOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjCQOwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:52:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43AC081C;
        Fri, 17 Mar 2023 07:52:37 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PdRqB0WSbz6JB9B;
        Fri, 17 Mar 2023 22:49:26 +0800 (CST)
Received: from localhost (10.48.148.142) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 17 Mar
 2023 14:52:33 +0000
Date:   Fri, 17 Mar 2023 14:52:32 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jie Zhan <zhanjie9@hisilicon.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <zhangshaokun@hisilicon.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [RFC PATCH v1 2/4] drivers/perf: hisi: Add driver support for
 HiSilicon PMCU
Message-ID: <20230317145232.00001c38@Huawei.com>
In-Reply-To: <20230206065146.645505-3-zhanjie9@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
        <20230206065146.645505-3-zhanjie9@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.148.142]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 14:51:44 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
> PMU accesses from CPUs, handling the configuration, event switching, and
> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
> scheme may lose events or drop sampling frequency. With PMCU, users can
> reliably obtain the data of up to 240 PMU events with the sample interval
> of events down to 1ms, while the software overhead of accessing PMUs, as
> well as its impact on target workloads, is reduced.
> 
> This driver enables the usage of PMCU through the perf_event framework.
> PMCU is registered as a PMU device and utilises the AUX buffer to dump data
> directly. Users can start PMCU sampling through 'perf-record'. Event
> numbers are passed by a sysfs interface.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

Hi Jie,

A few minor comments inline.
Whilst I looked at this internally, that was a while back so I've
found a few new things to point out in what I think is a pretty good/clean driver.
The main thing here is the RFC questions you've raised in the cover letter
of course - particularly the one around mediating who has the counters between
this and the normal PMU driver.

Thanks,

Jonathan

> ---
>  drivers/perf/hisilicon/Kconfig     |   15 +
>  drivers/perf/hisilicon/Makefile    |    1 +
>  drivers/perf/hisilicon/hisi_pmcu.c | 1096 ++++++++++++++++++++++++++++
>  3 files changed, 1112 insertions(+)
>  create mode 100644 drivers/perf/hisilicon/hisi_pmcu.c
> 
> diff --git a/drivers/perf/hisilicon/Kconfig b/drivers/perf/hisilicon/Kconfig
> index 171bfc1b6bc2..d7728fbe8519 100644
> --- a/drivers/perf/hisilicon/Kconfig
> +++ b/drivers/perf/hisilicon/Kconfig
> @@ -24,3 +24,18 @@ config HNS3_PMU
>  	  devices.
>  	  Adds the HNS3 PMU into perf events system for monitoring latency,
>  	  bandwidth etc.
> +
> +config HISI_PMCU
> +	tristate "HiSilicon PMCU"
> +	depends on ARM64 && PID_IN_CONTEXTIDR
> +	help
> +	  Support for HiSilicon Performance Monitor Control Unit (PMCU).
> +	  HiSilicon Performance Monitor Control Unit (PMCU) is a device that
> +	  offloads PMU accesses from CPUs, handling the configuration, event
> +	  switching, and counter reading of core PMUs on Kunpeng SoC. It
> +	  facilitates fine-grained and multi-PMU-event CPU profiling, in which
> +	  scenario the current 'perf' scheme may lose events or drop sampling
> +	  frequency. With PMCU, users can reliably obtain the data of up to 240
> +	  PMU events with the sample interval of events down to 1ms, while the
> +	  software overhead of accessing PMUs, as well as its impact on target
> +	  workloads, is reduced.
> diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
> index 4d2c9abe3372..93e4e6f2816a 100644
> --- a/drivers/perf/hisilicon/Makefile
> +++ b/drivers/perf/hisilicon/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_HISI_PMU) += hisi_uncore_pmu.o hisi_uncore_l3c_pmu.o \
>  
>  obj-$(CONFIG_HISI_PCIE_PMU) += hisi_pcie_pmu.o
>  obj-$(CONFIG_HNS3_PMU) += hns3_pmu.o
> +obj-$(CONFIG_HISI_PMCU) += hisi_pmcu.o
> diff --git a/drivers/perf/hisilicon/hisi_pmcu.c b/drivers/perf/hisilicon/hisi_pmcu.c
> new file mode 100644
> index 000000000000..6ec5d6c31e1f
> --- /dev/null
> +++ b/drivers/perf/hisilicon/hisi_pmcu.c
> @@ -0,0 +1,1096 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HiSilicon Performance Monitor Control Unit (PMCU) driver
> + *
> + * Copyright (C) 2022 HiSilicon Limited
> + * Author: Jie Zhan <zhanjie9@hisilicon.com>
> + */
> +
> +#include <linux/acpi.h>

Not seeing this used. Probably want mod_devicetable.h that
includes the struct acpi_device_id definition.

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cpumask.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/gfp_types.h>

It is very very rare for this to be included directly.
Normally just rely on indirect inclusion from slab.h or similar.
I would drop this one.

> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mm_types.h>
> +#include <linux/module.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/printk.h>

property.h

> +#include <linux/slab.h>
> +#include <linux/smp.h>
> +#include <linux/threads.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/sysreg.h>
> +
> +/* Registers */
> +#define HISI_PMCU_REG_FSM_STATUS	0x0000
> +#define HISI_PMCU_REG_FSM_CFG		0x0004
> +#define HISI_PMCU_REG_EVENT_BASE_H	0x0008
> +#define HISI_PMCU_REG_EVENT_BASE_L	0x000C
> +#define HISI_PMCU_REG_KILL_BASE_H	0x0010
> +#define HISI_PMCU_REG_KILL_BASE_L	0x0014
> +#define HISI_PMCU_REG_STORE_BASE_H	0x0018
> +#define HISI_PMCU_REG_STORE_BASE_L	0x001C
> +#define HISI_PMCU_REG_WAIT_CNT		0x0020
> +#define HISI_PMCU_REG_FSM_CTRL		0x0038
> +#define HISI_PMCU_REG_FSM_BRK		0x003C
> +#define HISI_PMCU_REG_COMP		0x0044
> +#define HISI_PMCU_REG_INT_EN		0x0100
> +#define HISI_PMCU_REG_INT_MSK		0x0104
> +#define HISI_PMCU_REG_INT_STAT		0x0108
> +#define HISI_PMCU_REG_INT_CLR		0x010C
> +#define HISI_PMCU_REG_PMCR		0x0200
> +#define HISI_PMCU_REG_PMCCFILTR		0x0204
> +
> +/* Register related configs */
> +#define HISI_PMCU_FSM_CFG_EV_LEN_MSK	GENMASK(7, 0)
> +#define HISI_PMCU_FSM_CFG_NR_LOOP_MSK	GENMASK(15, 8)
> +#define HISI_PMCU_FSM_CFG_NR_PMU_MSK	GENMASK(19, 16)
> +#define HISI_PMCU_FSM_CFG_MAX_EV_LEN	240

As this is used in various places that are only loosely assocated
with this register, I'd just rename it HISI_PMCU_MAX_EVN_LEN.
Similar probably applies to some of these others.

> +#define HISI_PMCU_FSM_CFG_MAX_NR_LOOP	255
> +#define HISI_PMCU_FSM_CFG_MAX_NR_PMU	8
> +#define HISI_PMCU_FSM_CFG_MAX_NR_PMU_C	5
> +#define HISI_PMCU_WAIT_CNT_DEFAULT	0x249F0
> +#define HISI_PMCU_FSM_CTRL_TRIGGER	BIT(0)
> +#define HISI_PMCU_FSM_BRK_BRK		BIT(0)
> +#define HISI_PMCU_COMP_HPMN_THR		3
> +#define HISI_PMCU_COMP_ENABLE		BIT(0)
> +#define HISI_PMCU_INT_DONE		BIT(0)
> +#define HISI_PMCU_INT_BRK		BIT(1)
> +#define HISI_PMCU_INT_ALL		GENMASK(1, 0)
> +#define HISI_PMCU_PMCR_DEFAULT		0xC1

How is this related to the architecture defined PMCR register?
Or just a coincidence of naming?

Either way, I'm assuming 0xC1 is probably multiple fields so if
possible can we break this down further with defines to show
where the value comes from.


> +#define HISI_PMCU_PMCCFILTR_MSK		GENMASK(31, 24)
...

> +/**
> + * struct hisi_pmcu_events - PMCU events and sampling configuration
> + * @nr_pmu:		number of core PMU counters that run in parallel
> + * @padding:		number of padding events in a sample
> + * @nr_ev:		number of events passed by users in a sample
> + * @nr_ev_per_sample:	number of events passed to hardware for a sample
> + *			This equals nr_ev + padding and should be evenly
> + *			divisible by nr_pmu.
> + * @max_sample_loop:	max number of samples that can be done in a loop
> + * @ev_len:		event length for hardware to read in a loop
> + * @nr_loop:		number of loops in one trigger
> + * @comp_mode:		compatibility mode
> + * @nr_sample:		number of samples that the current trigger takes
> + * @nr_pending_sample:	number of pending samples
> + * @subsample_size:	size of a subsample
> + * @sample_size:	size of a sample
> + * @output_size:	size of output from one trigger
> + * @sample_period:	sample period passed to hardware
> + * @nr_cpu:		number of hardware threads (logical CPUs)
> + * @events:		event IDs passed from users

Maybe say what they are for rather than where they come from?
event IDs to sample.

> + */
> +struct hisi_pmcu_events {
> +	u8 nr_pmu;
> +	u8 padding;
> +	u8 nr_ev;
> +	u8 nr_ev_per_sample;
> +	u8 max_sample_loop;
> +	u8 ev_len;
> +	u8 nr_loop;
> +	u8 comp_mode;

Could you use the enum hisi_pmcu_comp_mode type for this?

> +	u32 nr_sample;
> +	u32 nr_pending_sample;
> +	u32 subsample_size;
> +	u32 sample_size;
> +	u32 output_size;
> +	u32 sample_period;
> +	u32 nr_cpu;
> +	u32 events[HISI_PMCU_FSM_CFG_MAX_EV_LEN];
> +};
> +

...


> +static const struct attribute_group hisi_pmcu_format_attr_group = {
> +	.name = "format",
> +	.attrs = hisi_pmcu_format_attrs,
> +};
> +
> +static ssize_t monitored_cpus_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "%d-%d\n",
> +			  cpumask_first(&hisi_pmcu->cpus),
> +			  cpumask_last(&hisi_pmcu->cpus));

What does this do about offline CPUs?
Should it include them or not?

> +}
> +
> +static DEVICE_ATTR_ADMIN_RO(monitored_cpus);



> +static ssize_t user_events_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(dev_get_drvdata(dev));
> +	struct hisi_pmcu_user_events *user_ev = &hisi_pmcu->user_ev;
> +	u32 head, tail, nr_ev;
> +	char *line;
> +	int err;
> +
> +	line = kcalloc(count + 1, sizeof(*line), GFP_KERNEL);

Doesn't seem to be freed anywhere.

> +	nr_ev = 0;
> +	head = 0;
> +	tail = 0;
> +	while (nr_ev < HISI_PMCU_FSM_CFG_MAX_EV_LEN) {
> +		while (head < count && isspace(buf[head]))
> +			head++;
> +		if (!isxdigit(buf[head]))
> +			break;
> +		tail = head + 1;
> +
> +		while (tail < count && isalnum(buf[tail]))
> +			tail++;
> +
> +		strncpy(line, buf + head, tail - head);
> +		line[tail - head] = '\0';
> +		err = kstrtou16(line, 16, &user_ev->ev[nr_ev]);
> +		if (err) {
> +			user_ev->nr_ev = 0;
> +			return err;
> +		}
> +		nr_ev++;
> +		head = tail;
> +	}
> +	user_ev->nr_ev = nr_ev;
> +
> +	return count;
> +}
> +
> +static int hisi_pmcu_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
> +	struct hisi_pmcu_events *ev = &hisi_pmcu->ev;
> +	void __iomem *base = hisi_pmcu->regbase;
> +	u64 cfg;
> +	u32 val;
> +
> +	if (event->attr.type != hisi_pmcu->pmu.type)
> +		return -ENOENT;
> +
> +	if (hisi_pmcu->busy)
> +		return -EBUSY;
> +
> +	cfg = event->attr.config;
> +
> +	val = FIELD_GET(HISI_PMCU_PERF_ATTR_NR_SAMPLE, cfg);

val gets used for a lot of different things in this function.
I would use as set of new local variables with names that make it more
obvious what they are.

> +	ev->nr_pending_sample = val ? val : HISI_PMCU_PERF_NR_SAMPLE_DEFAULT;
local variable isn't that useful here and makes the whole reuse of value
issue worse.

	ev->nr_pending_sample = FIELD_GET(...);
	if (ev->nr_pending_sample == 0)
		ev->nr_pending_sample = HISI...

> +
> +	val = FIELD_GET(HISI_PMCU_PERF_ATTR_SAMPLE_PERIOD_MS, cfg);
> +	if (val > HISI_PMCU_PERF_MAX_SAMPLE_PERIOD_MS) {
> +		dev_err(hisi_pmcu->dev, "sample period too long (max=0x%x)\n",
> +			HISI_PMCU_PERF_MAX_SAMPLE_PERIOD_MS);
> +		return -EINVAL;
> +	}
> +	ev->sample_period = val ? val * HISI_PMCU_PERF_MS_TO_WAIT_CNT :
> +				  HISI_PMCU_WAIT_CNT_DEFAULT;
> +
> +	cfg = event->attr.config1;
> +
> +	val = FIELD_GET(HISI_PMCU_PERF_ATTR_PMCCFILTR, cfg);
> +	val = FIELD_PREP(HISI_PMCU_PMCCFILTR_MSK, val);
> +	writel(val, base + HISI_PMCU_REG_PMCCFILTR);
> +
> +	return 0;
> +}
> +

...

> +static void hisi_pmcu_hw_sample_start(struct hisi_pmcu *hisi_pmcu,
> +				      struct hisi_pmcu_buf *buf)
> +{
> +	struct hisi_pmcu_sbuf *sbuf = &buf->sbuf[buf->cur_buf];
> +	struct hisi_pmcu_events *ev = &hisi_pmcu->ev;
> +	void __iomem *base = hisi_pmcu->regbase;
> +	u64 addr, end;
> +	u32 val;
> +
> +	/* FSM CFG */
> +	val = FIELD_PREP(HISI_PMCU_FSM_CFG_EV_LEN_MSK, ev->ev_len);
> +	val |= FIELD_PREP(HISI_PMCU_FSM_CFG_NR_LOOP_MSK, ev->nr_loop);
> +	val |= FIELD_PREP(HISI_PMCU_FSM_CFG_NR_PMU_MSK, ev->nr_pmu);
> +	writel(val, base + HISI_PMCU_REG_FSM_CFG);
> +
> +	/* Sample period */
> +	writel(ev->sample_period, base + HISI_PMCU_REG_WAIT_CNT);
> +
> +	/* Event ID base */
> +	addr = virt_to_phys(ev->events);
> +	val = upper_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_EVENT_BASE_H);

No point in using the local variable val here that I can see.
	writel(upper_32_bits(addr), base + ...)

> +	val = lower_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_EVENT_BASE_L);
same with this one.

> +
> +	/* sbuf end */
> +	end = page_to_phys(sbuf->page) + sbuf->size;
> +
> +	/* Data output address */
> +	addr = end - sbuf->remain;
> +	val = upper_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_STORE_BASE_H);
and this one.

> +	val = lower_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_STORE_BASE_L);
and another. etc..

> +
> +	/* Stop data output if sbuf end is reached (abnormally) */
> +	addr = end;
> +	val = upper_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_KILL_BASE_H);
> +	val = lower_32_bits(addr);
> +	writel(val, base + HISI_PMCU_REG_KILL_BASE_L);
> +
> +	/* Trigger */
> +	writel(HISI_PMCU_FSM_CTRL_TRIGGER, base + HISI_PMCU_REG_FSM_CTRL);
> +}
> +

> +
> +static void hisi_pmcu_write_auxtrace_header(struct hisi_pmcu_events *ev,
> +					    struct hisi_pmcu_buf *buf)
> +{
> +	struct hisi_pmcu_auxtrace_header header;
> +	struct hisi_pmcu_sbuf *sbuf;
> +	u32 *data;
> +	u32 sz;
> +
> +	sbuf = &buf->sbuf[buf->cur_buf];
> +
> +	header.buffer_size = sbuf->size;
> +	header.nr_pmu = ev->nr_pmu;
> +	header.nr_cpu = ev->nr_cpu;
> +	header.comp_mode = ev->comp_mode;
> +	header.subsample_size = ev->subsample_size;
> +	header.nr_subsample_per_sample = ev->nr_ev_per_sample / ev->nr_pmu;
> +	header.nr_event = ev->nr_ev_per_sample;

Might be nicer to read as as

	struct hisi_pmcu_sbuf *sbuf = &buf->sbuf[buf->cur_buf];
	struct hisi_pmcu_auxtrace_header header = {
		.buffer_size = sbuf->size,
		.nr_pmu = ev->nr_pmu,
		.nr_cpu = ev->nr_cpu,
		...
	};

		
> +
> +	data = page_to_virt(sbuf->page);
> +	memcpy(data, &header, sizeof(header));
> +	memcpy(data + sizeof(header) / sizeof(*data), ev->events,
> +	       ev->nr_ev_per_sample * sizeof(u32));

I'm not sure why data is a u32 *
A few things that would make this neater.

* write the header directly.

	struct hisi_pmcu_auxtrace_header *header = page_to_virt(sbuf->page);

	*header = (struct hisi_pmcu_auxtrace_header) {
		.buffer_size = sbuf->size,
		.nr_pmu = ev->nr_pmu,
		.nr_cpu = ev->nr_cpu,
		...
	};
* Use header + 1 to get to the address just after it.
	memcpy(header + 1, ev->events, ev->nr_ev_per_sample * sizeof(u32));

* Instead add teh data to the structure (maybe rename it)
struct hisi_pmcu_auxtrace_header {
	u32 buffer_size;
	u32 nr_pmu;
	u32 nr_cpu;
	u32 comp_mode;
	u32 subsample_size;
	u32 nr_subsample_per_sample;
	u32 nr_event;
	u32 data[];
};

> +
> +	sz = sizeof(header) + ev->nr_ev_per_sample * sizeof(u32);

with above augmented header structure, struct_size()
 
> +	sz = round_up(sz, HISI_PMCU_AUX_HEADER_ALIGN);
> +
> +	sbuf->remain -= sz;
> +}
> +
> +static void hisi_pmcu_pmu_start(struct perf_event *event, int flags)
> +{
> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
> +	struct perf_output_handle *handle = &hisi_pmcu->handle;
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct hisi_pmcu_buf *buf;
> +	int err;
> +
> +	spin_lock(&hisi_pmcu->lock);
> +
> +	if (hisi_pmcu->busy) {
> +		dev_info(hisi_pmcu->dev,
> +			 "Sampling is running, pmu->start() ignored\n");

I'm not sure on perf convention on this, but I'd have though dev_dbg
enough for this.  If this is normal thing to do then feel free to leave it.


> +		goto out;
> +	}
> +
...


> +
> +static void hisi_pmcu_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct hisi_pmcu *hisi_pmcu = to_hisi_pmcu(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	struct perf_output_handle *handle;
> +	struct hisi_pmcu_sbuf *sbuf;
> +	struct hisi_pmcu_buf *buf;
> +	int err;
> +
> +	spin_lock(&hisi_pmcu->lock);
> +
> +	handle = &hisi_pmcu->handle;
> +
> +	/* If PMCU is running, break it */
> +	if (hisi_pmcu->busy) {
> +		dev_info(hisi_pmcu->dev, "Stopping PMCU sampling\n");

Is this useful?  dev_dbg maybe?

> +		err = hisi_pmcu_hw_sample_stop(hisi_pmcu);
> +		if (err)
> +			dev_err(hisi_pmcu->dev,
> +				"Timed out for stopping PMCU!\n");
> +	}
> +
> +	buf = perf_get_aux(handle);
> +	sbuf = &buf->sbuf[buf->cur_buf];
> +	perf_aux_output_end(handle, sbuf->size - sbuf->remain);
> +
> +	spin_unlock(&hisi_pmcu->lock);
> +
> +	hwc->state |= PERF_HES_STOPPED;
> +	perf_event_update_userpage(event);
> +}

...

> +static int hisi_pmcu_init_data(struct platform_device *pdev,
> +			       struct hisi_pmcu *hisi_pmcu)
> +{
> +	int ret;
> +
> +	hisi_pmcu->regbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(hisi_pmcu->regbase))
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "Failed to map device register space\n");
> +
> +	ret = device_property_read_u32(&pdev->dev, "hisilicon,scl-id",
> +				       &hisi_pmcu->scclid);

These need linux/property.h to be included (mentioned above)

> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to read sccl-id!\n");
> +
> +	/*
> +	 * Obtain the number of CPUs that contributes to the sample size.
> +	 * NR_CPU_CLUSTER is now hard coded as the hardware accesses a certain
> +	 * number of CPUs in a cluster regardless of how many CPUs are actually
> +	 * implemented/available.
> +	 */
> +	ret = device_property_read_u32(&pdev->dev, "hisilicon,nr-cluster",
> +				       &hisi_pmcu->ev.nr_cpu);
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "Failed to read nr-cluster!\n");
> +	hisi_pmcu->ev.nr_cpu *= NR_CPU_CLUSTER;
> +
> +	return 0;
> +}




> +static struct platform_driver hisi_pmcu_driver = {
> +	.driver = {
> +		.name = HISI_PMCU_DRV_NAME,
> +		.acpi_match_table = hisi_pmcu_acpi_match,
> +		/*
> +		 * Unbinding driver is not yet supported as we have not worked
> +		 * out a safe bind/unbind process.

I'd add a note on this to the cover letter and the above
patch description.  It's definitely something we should
make work for this driver.

> +		 */
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = hisi_pmcu_probe,
> +};
> +
..

I'm very interested to see what this hardware/driver gets used for.

Thanks,

Jonathan
