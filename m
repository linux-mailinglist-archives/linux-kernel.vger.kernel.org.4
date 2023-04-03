Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89E6D4F02
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjDCRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDCRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:32:38 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55F91980;
        Mon,  3 Apr 2023 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680543154; x=1712079154;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Vl95koRXFQVA1DZWSdv03qafns/agAtqkEhJd3KIadI=;
  b=ZV4bS366A5LPHcyjHdfnjsWj1zKzLgJCwIayvk2FmX9GwGltlUqut3Nm
   sXwaDrSlSnNcZb5mwUZ/5wZS/nT3vb0nIzoxgi69jWCZHNtFtx+YGqN4Z
   BpHqQp67N7ENuhWFL0Tz+9gUfGj2LFuYNMDd9/2PkAlKbw+rsVszxIzi0
   rwp51GoA7clpK4pHqbLOCXsZprVmfc0zM2oQSQM2+FOJxjXvmF0ygq5EU
   efrGBgVilPEUoeIRVQJDoy3q01192Z4yka+0dBsjGmH4+Ooflzcn5xfSV
   Qu//2z8TRffnam3lsBmTB/6pf+UlS4miJwHzaWFnLeYSYsSz8Tws7zh8l
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="428256059"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="428256059"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 10:32:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="755337566"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="755337566"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 03 Apr 2023 10:32:09 -0700
Received: from [10.212.177.123] (kliang2-mobl1.ccr.corp.intel.com [10.212.177.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 991DE5804D9;
        Mon,  3 Apr 2023 10:32:07 -0700 (PDT)
Message-ID: <bcae8e21-0afc-9fc6-7f90-07afca412223@linux.intel.com>
Date:   Mon, 3 Apr 2023 13:32:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 4/5] cxl: CXL Performance Monitoring Unit driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-5-Jonathan.Cameron@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230330164556.31533-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-30 12:45 p.m., Jonathan Cameron wrote:
> CXL rev 3.0 introduces a standard performance monitoring hardware
> block to CXL. Instances are discovered using CXL Register Locator DVSEC
> entries. Each CXL component may have multiple PMUs.
> 
> This initial driver supports on a subset of types of counter.
> It support counters that are either fixed or configurable, but requires
> that they support the ability to freeze and write value whilst frozen.
> 
> Development done with QEMU model which will be posted shortly.
> 

So the patch series is only tested with QEMU. Is there a real hardware
which supports the CXL PMON?

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v4:
> - Add defines for masks used for config, config1 etc and reorder
>   code so those can be next to the attrs.  Note that one of the
>   bits was wrong showing the advantage of bring all this info
>   into one place.
> - Use enabled counter bitmap rather than pointer array to make the
>   fixed counter handling look more like the variable counter handling.
> - Drop PERF_EF_RELOAD handling that did nothing.
> - Simplify code as nothing special to do if the counting is already
>   up to date (no harm in setting the already set flag).
> ---
>  drivers/cxl/Kconfig  |  13 +
>  drivers/cxl/Makefile |   1 +
>  drivers/cxl/cpmu.c   | 940 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 954 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ff4e78117b31..0be514b00b8f 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -139,4 +139,17 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_CPMU
> +	tristate "CXL Performance Monitoring Unit"
> +	default CXL_BUS
> +	depends on PERF_EVENTS
> +	help
> +	  Support performance monitoring as defined in CXL rev 3.0
> +	  section 13.2: Performance Monitoring. CXL components may have
> +	  one or more CXL Performance Monitoring Units (CPMUs).
> +
> +	  Say 'y/m' to enable a driver that will attach to performance
> +	  monitoring units and provide standard perf based interfaces.
> +
> +	  If unsure say 'm'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index db321f48ba52..024bb739554b 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_CPMU) += cpmu.o
>  
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
> diff --git a/drivers/cxl/cpmu.c b/drivers/cxl/cpmu.c
> new file mode 100644
> index 000000000000..e6821771a4f6
> --- /dev/null
> +++ b/drivers/cxl/cpmu.c
> @@ -0,0 +1,940 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright(c) 2023 Huawei
> + *
> + * The CXL 3.0 specification includes a standard Performance Monitoring Unit,
> + * called the CXL PMU, or CPMU. In order to allow a high degree of
> + * implementation flexibility the specification provides a wide range of
> + * options all of which are self describing.
> + *
> + * Details in CXL rev 3.0 section 8.2.7 CPMU Register Interface
> + *
> + * TODO
> + * o Discoverability of counters. Allow perftool to provide summed counters
> + *   and vendor defined counters.
> + * o Support free running counters - copy the Intel uncore PMU handling for these.
> + * o CPMUs which do not support freeze.
> + * o Add filter validation in cpmu_event_init() so problems are detected earlier.
> + * o Reject configurations that the hardware is ignoring
> + *   (e.g. invert when not invertible)
> + * o Support CPMUs with no interrupts using an HRTIMER.
> + */
> +
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/perf_event.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/bits.h>
> +#include <linux/list.h>
> +#include <linux/bug.h>
> +#include <linux/pci.h>
> +
> +#include "cpmu.h"
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
> +#define CPMU_GID_CLOCK_TICKS		0x00
> +#define CPMU_GID_D2H_REQ		0x0010
> +#define CPMU_GID_D2H_RSP		0x0011
> +#define CPMU_GID_H2D_REQ		0x0012
> +#define CPMU_GID_H2D_RSP		0x0013
> +#define CPMU_GID_CACHE_DATA		0x0014
> +#define CPMU_GID_M2S_REQ		0x0020
> +#define CPMU_GID_M2S_RWD		0x0021
> +#define CPMU_GID_M2S_BIRSP		0x0022
> +#define CPMU_GID_S2M_BISNP		0x0023
> +#define CPMU_GID_S2M_NDR		0x0024
> +#define CPMU_GID_S2M_DRS		0x0025
> +#define CPMU_GID_DDR			0x8000
> +
> +static int cpmu_cpuhp_state_num;
> +
> +struct cpmu_event {
> +	u16 vid;
> +	u16 gid;
> +	u32 msk;
> +	union {
> +		int counter_idx; /* fixed counters */
> +		int event_idx; /* configurable counters */
> +	};
> +	struct list_head node;
> +};
> +
> +#define CPMU_MAX_COUNTERS 64
> +struct cpmu_info {
> +	struct pmu pmu;
> +	void __iomem *base;
> +	struct perf_event **hw_events;
> +	struct list_head events_configurable;
> +	struct list_head events_fixed;
> +	DECLARE_BITMAP(used_counter_bm, CPMU_MAX_COUNTERS);
> +	DECLARE_BITMAP(conf_counter_bm, CPMU_MAX_COUNTERS);
> +	u16 counter_width;
> +	u8 num_counters;
> +	u8 num_event_capabilities;
> +	int on_cpu;
> +	struct hlist_node node;
> +	bool freeze_for_enable;
> +	bool filter_hdm;
> +	int irq;
> +};
> +
> +#define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
> +
> +/*
> + * All CPMU counters are discoverable via the Event Capabilities Registers.
> + * Each Event Capability register contains a a VID / GroupID.
> + * A counter may then count any combination (by summing) of events in
> + * that group which are in the Supported Events Bitmask.
> + * However, there are some complexities to the scheme.
> + *  - Fixed function counters refer to an Event Capabilities register.
> + *    That event capability register is not then used for Configurable
> + *    counters.
> + */
> +static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
> +{
> +	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};
> +	void __iomem *base = info->base;
> +	u64 val, eval;
> +	int i;
> +
> +	val = readq(base + CPMU_CAP_REG);
> +	info->freeze_for_enable = FIELD_GET(CPMU_CAP_WRITEABLE_WHEN_FROZEN, val) &
> +		FIELD_GET(CPMU_CAP_FREEZE, val);
> +	if (!info->freeze_for_enable) {
> +		dev_err(dev, "Driver does not support CPMUs that do not support freeze for enable\n");
> +		return -ENODEV;
> +	}
> +
> +	info->num_counters = FIELD_GET(CPMU_CAP_NUM_COUNTERS_MSK, val) + 1;
> +	info->counter_width = FIELD_GET(CPMU_CAP_COUNTER_WIDTH_MSK, val);
> +	info->num_event_capabilities = FIELD_GET(CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
> +
> +	info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val) & CPMU_FILTER_HDM;
> +	if (FIELD_GET(CPMU_CAP_INT, val))
> +		info->irq = FIELD_GET(CPMU_CAP_MSI_N_MSK, val);
> +	else
> +		info->irq = -1;
> +
> +	/* First handle fixed function counters; note if configurable counters found */
> +	for (i = 0; i < info->num_counters; i++) {
> +		struct cpmu_event *cpmu_ev;
> +		u32 events_msk;
> +		u8 group_idx;
> +
> +		val = readq(base + CPMU_COUNTER_CFG_REG(i));
> +
> +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) ==
> +			CPMU_COUNTER_CFG_TYPE_CONFIGURABLE) {
> +			set_bit(i, info->conf_counter_bm);
> +		}
> +
> +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) !=
> +		    CPMU_COUNTER_CFG_TYPE_FIXED_FUN)
> +			continue;
> +
> +		/* In this case we know which fields are const */
> +		group_idx = FIELD_GET(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, val);
> +		events_msk = FIELD_GET(CPMU_COUNTER_CFG_EVENTS_MSK, val);
> +		eval = readq(base + CPMU_EVENT_CAP_REG(group_idx));
> +		cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> +		if (!cpmu_ev)
> +			return -ENOMEM;
> +
> +		cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> +		cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> +		/* For a fixed purpose counter use the events mask from the counter CFG */
> +		cpmu_ev->msk = events_msk;
> +		cpmu_ev->counter_idx = i;
> +		/* This list add is never unwound as all entries deleted on remove */
> +		list_add(&cpmu_ev->node, &info->events_fixed);
> +		/*
> +		 * Configurable counters must not use an Event Capability registers that
> +		 * is in use for a Fixed counter
> +		 */
> +		set_bit(group_idx, fixed_counter_event_cap_bm);
> +	}
> +
> +	if (!bitmap_empty(info->conf_counter_bm, CPMU_MAX_COUNTERS)) {
> +		struct cpmu_event *cpmu_ev;
> +		int j;
> +		/* Walk event capabilities unused by fixed counters */
> +		for_each_clear_bit(j, fixed_counter_event_cap_bm,
> +				   info->num_event_capabilities) {
> +			cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> +			if (!cpmu_ev)
> +				return -ENOMEM;
> +
> +			eval = readq(base + CPMU_EVENT_CAP_REG(j));
> +			cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> +			cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> +			cpmu_ev->msk = FIELD_GET(CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK, eval);
> +			cpmu_ev->event_idx = j;
> +			list_add(&cpmu_ev->node, &info->events_configurable);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static ssize_t cpmu_format_sysfs_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +#define CPMU_FORMAT_ATTR(_name, _format)\
> +	(&((struct dev_ext_attribute[]) {				\
> +		{							\
> +			.attr = __ATTR(_name, 0444,			\
> +				       cpmu_format_sysfs_show, NULL),	\
> +			.var = (void *)_format				\
> +		}							  \
> +		})[0].attr.attr)
> +
> +enum {
> +	cpmu_mask_attr,
> +	cpmu_gid_attr,
> +	cpmu_vid_attr,
> +	cpmu_threshold_attr,
> +	cpmu_invert_attr,
> +	cpmu_edge_attr,
> +	cpmu_hdm_filter_en_attr,
> +	cpmu_hdm_attr,
> +};
> +
> +static struct attribute *cpmu_format_attr[] = {
> +	[cpmu_mask_attr] = CPMU_FORMAT_ATTR(mask, "config:0-31"),
> +	[cpmu_gid_attr] = CPMU_FORMAT_ATTR(gid, "config:32-47"),
> +	[cpmu_vid_attr] = CPMU_FORMAT_ATTR(vid, "config:48-63"),
> +	[cpmu_threshold_attr] = CPMU_FORMAT_ATTR(threshold, "config1:0-15"),
> +	[cpmu_invert_attr] = CPMU_FORMAT_ATTR(invert, "config1:16"),
> +	[cpmu_edge_attr] = CPMU_FORMAT_ATTR(edge, "config1:17"),
> +	[cpmu_hdm_filter_en_attr] = CPMU_FORMAT_ATTR(hdm_filter_en, "config1:18"),
> +	[cpmu_hdm_attr] = CPMU_FORMAT_ATTR(hdm, "config2:0-15"),
> +	NULL
> +};
> +
> +#define CPMU_ATTR_CONFIG_MASK_MSK	GENMASK_ULL(63, 48)

(31, 0)?

> +#define CPMU_ATTR_CONFIG_GID_MSK	GENMASK_ULL(47, 32)
> +#define CPMU_ATTR_CONFIG_VID_MSK	GENMASK_ULL(63, 48)
> +#define CPMU_ATTR_CONFIG1_THRESHOLD_MSK	GENMASK_ULL(15, 0)
> +#define CPMU_ATTR_CONFIG1_INVERT_MSK	BIT(16)
> +#define CPMU_ATTR_CONFIG1_EDGE_MSK	BIT(17)
> +#define CPMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
> +#define CPMU_ATTR_CONFIG2_HDM_MSK	GENMASK(15, 0)
> +
> +static umode_t cpmu_format_is_visible(struct kobject *kobj, struct attribute *attr, int a)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cpmu_info *info = dev_get_drvdata(dev);
> +
> +	/*
> +	 * Filter capability at the CPMU level, so hide the attributes if the particular
> +	 * filter is not supported.
> +	 */
> +	if (attr == cpmu_format_attr[cpmu_hdm_filter_en_attr] ||
> +	    attr == cpmu_format_attr[cpmu_hdm_attr]) {
> +		if (info->filter_hdm)
> +			return 0444;
> +		else
> +			return 0;
> +	} else {
> +		return 0444;
> +	}
> +}
> +
> +static const struct attribute_group cpmu_format_group = {
> +	.name = "format",
> +	.attrs = cpmu_format_attr,
> +	.is_visible = cpmu_format_is_visible,
> +};
> +
> +static u32 cpmu_config_get_mask(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG_MASK_MSK, event->attr.config);
> +}
> +
> +static u16 cpmu_config_get_gid(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG_GID_MSK, event->attr.config);
> +}
> +
> +static u16 cpmu_config_get_vid(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG_VID_MSK, event->attr.config);
> +}
> +
> +static u8 cpmu_config1_get_threshold(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG1_THRESHOLD_MSK, event->attr.config1);
> +}
> +
> +static bool cpmu_config1_get_invert(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG1_INVERT_MSK, event->attr.config1);
> +}
> +
> +static bool cpmu_config1_get_edge(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG1_EDGE_MSK, event->attr.config1);
> +}
> +
> +/*
> + * CPMU specification allows for 8 filters, each with a 16 bit value...
> + * So we need to find 8x16bits to store it in.
> + * As the value used for disable is 0xffff, a separate enable switch
> + * is needed.
> + */
> +
> +static bool cpmu_config1_hdm_filter_en(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG1_FILTER_EN_MSK, event->attr.config1);
> +}
> +
> +static u16 cpmu_config2_get_hdm_decoder(struct perf_event *event)
> +{
> +	return FIELD_GET(CPMU_ATTR_CONFIG2_HDM_MSK, event->attr.config2);
> +}
> +
> +static ssize_t cpmu_event_sysfs_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(attr, struct perf_pmu_events_attr, attr);
> +
> +	return sysfs_emit(buf, "config=%#llx\n", pmu_attr->id);
> +}
> +
> +#define CPMU_PMU_EVENT_ATTR(_name, _vid, _gid, _msk)			\
> +	PMU_EVENT_ATTR_ID(_name, cpmu_event_sysfs_show,			\
> +			  ((u64)(_vid) << 48) | ((u64)(_gid) << 32) | (u64)(_msk))
> +
> +/* For CXL spec defined events */
> +#define CPMU_PMU_EVENT_CXL_ATTR(_name, _gid, _msk) \
> +	CPMU_PMU_EVENT_ATTR(_name, PCI_DVSEC_VENDOR_ID_CXL, _gid, _msk)
> +
> +static struct attribute *cpmu_event_attrs[] = {
> +	CPMU_PMU_EVENT_CXL_ATTR(clock_ticks,			CPMU_GID_CLOCK_TICKS, BIT(0)),
> +	/* CXL rev 3.0 Table 3-17 - Device to Host Requests */
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_rdcurr,			CPMU_GID_D2H_REQ, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_rdown,			CPMU_GID_D2H_REQ, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_rdshared,		CPMU_GID_D2H_REQ, BIT(3)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_rdany,			CPMU_GID_D2H_REQ, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_rdownnodata,		CPMU_GID_D2H_REQ, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_itomwr,			CPMU_GID_D2H_REQ, BIT(6)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_wrcurr,			CPMU_GID_D2H_REQ, BIT(7)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_clflush,		CPMU_GID_D2H_REQ, BIT(8)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_cleanevict,		CPMU_GID_D2H_REQ, BIT(9)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_dirtyevict,		CPMU_GID_D2H_REQ, BIT(10)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_cleanevictnodata,	CPMU_GID_D2H_REQ, BIT(11)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_wowrinv,		CPMU_GID_D2H_REQ, BIT(12)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_wowrinvf,		CPMU_GID_D2H_REQ, BIT(13)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_wrinv,			CPMU_GID_D2H_REQ, BIT(14)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_req_cacheflushed,		CPMU_GID_D2H_REQ, BIT(16)),
> +	/* CXL rev 3.0 Table 3-20 - D2H Repsonse Encodings */
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihiti,		CPMU_GID_D2H_RSP, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvhitv,		CPMU_GID_D2H_RSP, BIT(6)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihitse,		CPMU_GID_D2H_RSP, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspshitse,		CPMU_GID_D2H_RSP, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspsfwdm,		CPMU_GID_D2H_RSP, BIT(7)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspifwdm,		CPMU_GID_D2H_RSP, BIT(15)),
> +	CPMU_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvfwdv,		CPMU_GID_D2H_RSP, BIT(22)),
> +	/* CXL rev 3.0 Table 3-21 - CXL.cache - Mapping of H2D Requests to D2H Responses */
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_req_snpdata,		CPMU_GID_H2D_REQ, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_req_snpinv,			CPMU_GID_H2D_REQ, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_req_snpcur,			CPMU_GID_H2D_REQ, BIT(3)),
> +	/* CXL rev 3.0 Table 3-22 - H2D Response Opcode Encodings */
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_writepull,		CPMU_GID_H2D_RSP, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_go,			CPMU_GID_H2D_RSP, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepull,		CPMU_GID_H2D_RSP, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_extcmp,			CPMU_GID_H2D_RSP, BIT(6)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepulldrop,	CPMU_GID_H2D_RSP, BIT(8)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_fastgowritepull,	CPMU_GID_H2D_RSP, BIT(13)),
> +	CPMU_PMU_EVENT_CXL_ATTR(h2d_rsp_goerrwritepull,		CPMU_GID_H2D_RSP, BIT(15)),
> +	/* CXL rev 3.0 Table 13-5 directly lists these */
> +	CPMU_PMU_EVENT_CXL_ATTR(cachedata_d2h_data,		CPMU_GID_CACHE_DATA, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(cachedata_h2d_data,		CPMU_GID_CACHE_DATA, BIT(1)),
> +	/* CXL rev 3.0 Table 3-29 M2S Req Memory Opcodes */
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_meminv,			CPMU_GID_M2S_REQ, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memrd,			CPMU_GID_M2S_REQ, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memrddata,		CPMU_GID_M2S_REQ, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memrdfwd,		CPMU_GID_M2S_REQ, BIT(3)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CPMU_GID_M2S_REQ, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CPMU_GID_M2S_REQ, BIT(8)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CPMU_GID_M2S_REQ, BIT(9)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CPMU_GID_M2S_REQ, BIT(10)),
> +	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_rwd_memwr,			CPMU_GID_M2S_RWD, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptl,		CPMU_GID_M2S_RWD, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_rwd_biconflict,		CPMU_GID_M2S_RWD, BIT(4)),
> +	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CPMU_GID_M2S_BIRSP, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CPMU_GID_M2S_BIRSP, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_e,			CPMU_GID_M2S_BIRSP, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_iblk,			CPMU_GID_M2S_BIRSP, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_sblk,			CPMU_GID_M2S_BIRSP, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(m2s_birsp_eblk,			CPMU_GID_M2S_BIRSP, BIT(6)),
> +	/* CXL rev 3.0 Table 3-40 S2M BISnp Opcodes */
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_cur,			CPMU_GID_S2M_BISNP, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_data,			CPMU_GID_S2M_BISNP, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_inv,			CPMU_GID_S2M_BISNP, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CPMU_GID_S2M_BISNP, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CPMU_GID_S2M_BISNP, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CPMU_GID_S2M_BISNP, BIT(6)),
> +	/* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CPMU_GID_S2M_NDR, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CPMU_GID_S2M_NDR, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CPMU_GID_S2M_NDR, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CPMU_GID_S2M_NDR, BIT(3)),
> +	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,		CPMU_GID_S2M_DRS, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,		CPMU_GID_S2M_DRS, BIT(1)),
> +	/* CXL rev 3.0 Table 13-5 directly lists these */
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_act,			CPMU_GID_DDR, BIT(0)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_pre,			CPMU_GID_DDR, BIT(1)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_casrd,			CPMU_GID_DDR, BIT(2)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_caswr,			CPMU_GID_DDR, BIT(3)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_refresh,			CPMU_GID_DDR, BIT(4)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_selfrefreshent,		CPMU_GID_DDR, BIT(5)),
> +	CPMU_PMU_EVENT_CXL_ATTR(ddr_rfm,			CPMU_GID_DDR, BIT(6)),
> +	NULL
> +};
> +
> +static struct cpmu_event *cpmu_find_fixed_counter_event(struct cpmu_info *info,
> +							int vid, int gid, int msk)
> +{
> +	struct cpmu_event *cpmu_ev;
> +
> +	list_for_each_entry(cpmu_ev, &info->events_fixed, node) {
> +		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
> +			continue;
> +
> +		/* Precise match for fixed counter */
> +		if (msk == cpmu_ev->msk)
> +			return cpmu_ev;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static struct cpmu_event *cpmu_find_config_counter_event(struct cpmu_info *info,
> +							 int vid, int gid, int msk)
> +{
> +	struct cpmu_event *cpmu_ev;
> +
> +	list_for_each_entry(cpmu_ev, &info->events_configurable, node) {
> +		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
> +			continue;
> +
> +		/* Request mask must be subset of supported */
> +		if (msk & ~cpmu_ev->msk)
> +			continue;
> +
> +		return cpmu_ev;
> +	}
> +
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static umode_t cpmu_event_is_visible(struct kobject *kobj, struct attribute *attr, int a)
> +{
> +	struct device_attribute *dev_attr = container_of(attr, struct device_attribute, attr);
> +	struct perf_pmu_events_attr *pmu_attr =
> +		container_of(dev_attr, struct perf_pmu_events_attr, attr);
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cpmu_info *info = dev_get_drvdata(dev);
> +	int vid = FIELD_GET(CPMU_ATTR_CONFIG_VID_MSK, pmu_attr->id);
> +	int gid = FIELD_GET(CPMU_ATTR_CONFIG_GID_MSK, pmu_attr->id);
> +	int msk = FIELD_GET(CPMU_ATTR_CONFIG_MASK_MSK, pmu_attr->id);
> +
> +	if (!IS_ERR(cpmu_find_fixed_counter_event(info, vid, gid, msk)))
> +		return attr->mode;
> +
> +	if (!IS_ERR(cpmu_find_config_counter_event(info, vid, gid, msk)))
> +		return attr->mode;
> +
> +	return 0;
> +}
> +
> +static const struct attribute_group cpmu_events = {
> +	.name = "events",
> +	.attrs = cpmu_event_attrs,
> +	.is_visible = cpmu_event_is_visible,
> +};
> +
> +static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
> +			    char *buf)
> +{
> +	struct cpmu_info *info = dev_get_drvdata(dev);
> +
> +	return cpumap_print_to_pagebuf(true, buf, cpumask_of(info->on_cpu));
> +}
> +static DEVICE_ATTR_RO(cpumask);
> +
> +static struct attribute *cpmu_cpumask_attrs[] = {
> +	&dev_attr_cpumask.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cpmu_cpumask_group = {
> +	.attrs = cpmu_cpumask_attrs,
> +};
> +
> +static const struct attribute_group *cpmu_attr_groups[] = {
> +	&cpmu_events,
> +	&cpmu_format_group,
> +	&cpmu_cpumask_group,
> +	NULL
> +};
> +
> +/* If counter_idx == NULL, don't try to allocate a counter. */
> +static int cpmu_get_event_idx(struct perf_event *event, int *counter_idx, int *event_idx)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	DECLARE_BITMAP(configurable_and_free, CPMU_MAX_COUNTERS);
> +	struct cpmu_event *cpmu_ev;
> +	u32 mask;
> +	u16 gid, vid;
> +	int i;
> +
> +	vid = cpmu_config_get_vid(event);
> +	gid = cpmu_config_get_gid(event);
> +	mask = cpmu_config_get_mask(event);
> +
> +	cpmu_ev = cpmu_find_fixed_counter_event(info, vid, gid, mask);
> +	if (!IS_ERR(cpmu_ev)) {
> +		if (!counter_idx)
> +			return 0;
> +		if (!test_bit(cpmu_ev->counter_idx, info->used_counter_bm)) {
> +			*counter_idx = cpmu_ev->counter_idx;
> +			return 0;
> +		}
> +		/* Fixed counter is in use, but maybe a configurable one? */
> +	}
> +
> +	cpmu_ev = cpmu_find_config_counter_event(info, vid, gid, mask);
> +	if (!IS_ERR(cpmu_ev)) {
> +		if (!counter_idx)
> +			return 0;
> +
> +		bitmap_andnot(configurable_and_free, info->conf_counter_bm,
> +			info->used_counter_bm, CPMU_MAX_COUNTERS);
> +
> +		i = find_first_bit(configurable_and_free, CPMU_MAX_COUNTERS);
> +		if (i == CPMU_MAX_COUNTERS)
> +			return -EINVAL;
> +
> +		*counter_idx = i;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cpmu_event_init(struct perf_event *event)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +
> +	event->cpu = info->on_cpu;
> +	/* Top level type sanity check - is this a Hardware Event being requested */
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +	/* TODO: Validation of any filter */
> +
> +	/*
> +	 * Verify that it is possible to count what was requested. Either must
> +	 * be a fixed counter that is a precise match or a configurable counter
> +	 * where this is a subset.
> +	 */
> +	return cpmu_get_event_idx(event, NULL, NULL);
> +}
> +
> +static void cpmu_pmu_enable(struct pmu *pmu)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(pmu);
> +	void __iomem *base = info->base;
> +
> +	/* We don't have a global enable, but we 'might' have a global freeze which we can use */
> +	if (info->freeze_for_enable) {
> +		/* Can assume frozen at this stage */
> +		writeq(0, base + CPMU_FREEZE_REG);
> +
> +		return;
> +	}
> +}
> +
> +static void cpmu_pmu_disable(struct pmu *pmu)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(pmu);
> +	void __iomem *base = info->base;
> +
> +	if (info->freeze_for_enable) {
> +		/*
> +		 * Whilst bits above number of counters are RsvdZ
> +		 * they are unlikely to be repurposed given
> +		 * number of counters is allowed to be 64 leaving
> +		 * no reserved bits.  Hence this is only slightly
> +		 * naughty.
> +		 */
> +		writeq(GENMASK_ULL(63, 0), base + CPMU_FREEZE_REG);
> +		return;
> +	}
> +}
> +
> +static void cpmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	void __iomem *base = info->base;
> +	u64 cfg;
> +
> +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> +		return;
> +
> +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> +	hwc->state = 0;
> +
> +	/*
> +	 * Currently only hdm filter control is implemnted, this code will
> +	 * want generalizing when more filters are added.
> +	 */
> +	if (info->filter_hdm) {
> +		if (cpmu_config1_hdm_filter_en(event))
> +			cfg = cpmu_config2_get_hdm_decoder(event);
> +		else
> +			cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
> +		writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
> +	}
> +
> +	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));

I don't think we need the previous value. Just overwrite it.


> +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
> +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1);
> +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EDGE, cpmu_config1_get_edge(event) ? 1 : 0);
> +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INVERT, cpmu_config1_get_invert(event) ? 1 : 0);
> +
> +	/* Fixed purpose counters have next two fields RO */
> +	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
> +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENTS_MSK, cpmu_config_get_mask(event));
> +	}
> +	cfg &= ~CPMU_COUNTER_CFG_THRESHOLD_MSK;
> +	/*
> +	 * For events that generate only 1 count per clock the CXL 3.0 spec
> +	 * states the threshold shall be set to 1 but if set to 0 it will
> +	 * count the raw value anwyay?
> +	 * There is no definition of what events will count multiple per cycle
> +	 * and hence to which non 1 values of threshold can apply.
> +	 * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
> +	 */
> +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_THRESHOLD_MSK,
> +			  cpmu_config1_get_threshold(event));
> +	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
> +
> +	local64_set(&hwc->prev_count, 0);
> +	writeq(0, base + CPMU_COUNTER_REG(hwc->idx));

The counter is reset twice. The other is in add()->cpmu_reset_counter().
I think you can remove the one in add().

> +
> +	perf_event_update_userpage(event);
> +}
> +
> +static u64 cpmu_read_counter(struct perf_event *event)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	void __iomem *base = info->base;
> +
> +	return readq(base + CPMU_COUNTER_REG(event->hw.idx));
> +}
> +
> +static void __cpmu_read(struct perf_event *event, bool overflow)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 new_cnt, prev_cnt, delta;
> +
> +	do {
> +		prev_cnt = local64_read(&hwc->prev_count);
> +		new_cnt = cpmu_read_counter(event);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) != prev_cnt);
> +
> +	/*
> +	 * If we know an overflow occur then take that into account.
> +	 * Note counter is not reset as that would lose events
> +	 */
> +	delta = (new_cnt - prev_cnt) & GENMASK_ULL(info->counter_width - 1, 0);
> +	if (overflow && delta < GENMASK_ULL(info->counter_width - 1, 0))
> +		delta += (1UL << info->counter_width);
> +
> +	local64_add(delta, &event->count);
> +}
> +
> +static void cpmu_read(struct perf_event *event)
> +{
> +	__cpmu_read(event, false);
> +}
> +
> +static void cpmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	void __iomem *base = info->base;
> +	struct hw_perf_event *hwc = &event->hw;
> +	u64 cfg;
> +
> +	cpmu_read(event);
> +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> +	hwc->state |= PERF_HES_STOPPED;
> +
> +	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
> +	cfg &= ~(FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1) |
> +		 FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1));
> +	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
> +
> +	hwc->state |= PERF_HES_UPTODATE;
> +}
> +
> +/*
> + * Reset ensures no possibility of any information leaking to wrong
> + * counter. Note that all fields written during start()
> + */
> +static void cpmu_reset_counter(struct cpmu_info *info, int idx)
> +{
> +	void __iomem *base = info->base;
> +
> +	/* Much of this register is read only */
> +	writeq(0, base + CPMU_EVENT_CAP_REG(idx));


CPMU_COUNTER_CFG_REG?

I don't think we need to reset the config here, since it will be rewrite
in cpmu_event_start().


> +	/* Filters are not per counter, so no reset here */
> +	writeq(0, base + CPMU_COUNTER_REG(idx));
> +}
> +
> +static int cpmu_event_add(struct perf_event *event, int flags)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +	int idx, rc;
> +	int event_idx = 0;
> +
> +	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +
> +	rc = cpmu_get_event_idx(event, &idx, &event_idx);
> +	if (rc < 0)
> +		return rc;
> +
> +	hwc->idx = idx;
> +
> +	/* Only set for configurable counters */
> +	hwc->event_base = event_idx;
> +	info->hw_events[idx] = event;
> +	set_bit(idx, info->used_counter_bm);
> +
> +	cpmu_reset_counter(info, idx);
> +
> +	if (flags & PERF_EF_START)
> +		cpmu_event_start(event, PERF_EF_RELOAD);
> +
> +	return 0;
> +}
> +
> +static void cpmu_event_del(struct perf_event *event, int flags)
> +{
> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> +	struct hw_perf_event *hwc = &event->hw;
> +
> +	cpmu_event_stop(event, PERF_EF_UPDATE);
> +	clear_bit(hwc->idx, info->used_counter_bm);
> +	info->hw_events[hwc->idx] = NULL;
> +	perf_event_update_userpage(event);
> +}
> +
> +static irqreturn_t cpmu_irq(int irq, void *data)
> +{
> +	struct cpmu_info *info = data;
> +	void __iomem *base = info->base;
> +	u64 overflowed;
> +	DECLARE_BITMAP(overflowedbm, 64);
> +	int i;
> +
> +	overflowed = readq(base + CPMU_OVERFLOW_REG);
> +
> +	/* Interrupt may be shared, so maybe it isn't ours */
> +	if (!overflowed)
> +		return IRQ_NONE;
> +
> +	bitmap_from_arr64(overflowedbm, &overflowed, 64);
> +	for_each_set_bit(i, overflowedbm, info->num_counters) {
> +		struct perf_event *event = info->hw_events[i];
> +
> +		if (!event) {
> +			dev_dbg(info->pmu.dev,
> +				"overflow but on non enabled counter %d\n", i);
> +			continue;
> +		}
> +
> +		__cpmu_read(event, true);
> +	}
> +
> +	writeq(overflowed, base + CPMU_OVERFLOW_REG);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cxl_cpmu_probe(struct device *dev)
> +{
> +	struct cxl_cpmu *cpmu = to_cxl_cpmu(dev);
> +	struct pci_dev *pdev = to_pci_dev(dev->parent);
> +	struct cpmu_info *info;
> +	char *irq_name;
> +	int rc, irq;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&info->events_fixed);
> +	INIT_LIST_HEAD(&info->events_configurable);
> +
> +	info->base = cpmu->base;
> +
> +	info->on_cpu = -1;
> +	rc = cpmu_parse_caps(dev, info);
> +	if (rc)
> +		return rc;
> +
> +	info->hw_events = devm_kcalloc(dev, sizeof(*info->hw_events),
> +				       info->num_counters, GFP_KERNEL);
> +	if (!info->hw_events)
> +		return -ENOMEM;
> +
> +	info->pmu = (struct pmu) {
> +		.name = dev_name(dev),
> +		.parent = dev,

I don't see the PMU parent is used anywhere.
Please remove this and drop the Patch 2 from this series.

If there will be other followup patches, please add the PMU parent
support there.

Thanks,
Kan

> +		.module = THIS_MODULE,
> +		.event_init = cpmu_event_init,
> +		.pmu_enable = cpmu_pmu_enable,
> +		.pmu_disable = cpmu_pmu_disable,
> +		.add = cpmu_event_add,
> +		.del = cpmu_event_del,
> +		.start = cpmu_event_start,
> +		.stop = cpmu_event_stop,
> +		.read = cpmu_read,
> +		.task_ctx_nr = perf_invalid_context,
> +		.attr_groups = cpmu_attr_groups,
> +		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
> +	};
> +
> +	if (info->irq <= 0)
> +		return -EINVAL;
> +
> +	rc = pci_irq_vector(pdev, info->irq);
> +	if (rc < 0)
> +		return rc;
> +	irq = rc;
> +
> +	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name(dev));
> +	if (!irq_name)
> +		return -ENOMEM;
> +
> +	rc = devm_request_irq(dev, irq, cpmu_irq, IRQF_SHARED, irq_name, info);
> +	if (rc)
> +		return rc;
> +	info->irq = irq;
> +
> +	rc = cpuhp_state_add_instance(cpmu_cpuhp_state_num, &info->node);
> +	if (rc)
> +		return rc;
> +
> +	rc = perf_pmu_register(&info->pmu, info->pmu.name, -1);
> +	if (rc)
> +		return rc;
> +
> +	dev_set_drvdata(dev, info);
> +
> +	return 0;
> +}
> +
> +static void cxl_cpmu_remove(struct device *dev)
> +{
> +	struct cpmu_info *info = dev_get_drvdata(dev);
> +
> +	perf_pmu_unregister(&info->pmu);
> +	cpuhp_state_remove_instance_nocalls(cpmu_cpuhp_state_num, &info->node);
> +}
> +
> +static struct cxl_driver cxl_cpmu_driver = {
> +	.name = "cxl_cpmu",
> +	.probe = cxl_cpmu_probe,
> +	.remove = cxl_cpmu_remove,
> +	.id = CXL_DEVICE_CPMU,
> +};
> +
> +static int cpmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
> +
> +	if (info->on_cpu != -1)
> +		return 0;
> +
> +	info->on_cpu = cpu;
> +	WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));
> +
> +	return 0;
> +}
> +
> +static int cpmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
> +	unsigned int target;
> +
> +	if (info->on_cpu != cpu)
> +		return 0;
> +
> +	info->on_cpu = -1;
> +	target = cpumask_first(cpu_online_mask);
> +	if (target >= nr_cpu_ids) {
> +		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> +		return 0;
> +	}
> +
> +	perf_pmu_migrate_context(&info->pmu, cpu, target);
> +	info->on_cpu = target;
> +	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
> +
> +	return 0;
> +}
> +
> +static __init int cxl_cpmu_init(void)
> +{
> +	int rc;
> +
> +	rc = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				     "AP_PERF_CPMU_ONLINE",
> +				     cpmu_online_cpu, cpmu_offline_cpu);
> +	if (rc < 0)
> +		return rc;
> +	cpmu_cpuhp_state_num = rc;
> +
> +	rc = cxl_driver_register(&cxl_cpmu_driver);
> +	if (rc)
> +		cpuhp_remove_multi_state(cpmu_cpuhp_state_num);
> +
> +	return rc;
> +}
> +
> +static __exit void cxl_cpmu_exit(void)
> +{
> +	cxl_driver_unregister(&cxl_cpmu_driver);
> +	cpuhp_remove_multi_state(cpmu_cpuhp_state_num);
> +}
> +
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(CXL);
> +module_init(cxl_cpmu_init);
> +module_exit(cxl_cpmu_exit);
> +MODULE_ALIAS_CXL(CXL_DEVICE_CPMU);
