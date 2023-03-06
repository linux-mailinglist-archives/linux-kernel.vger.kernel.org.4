Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9B76AC393
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCFOmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCFOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:42:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8348D233D5;
        Mon,  6 Mar 2023 06:41:54 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PVh8y1ZsYz6J7nS;
        Mon,  6 Mar 2023 22:41:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 6 Mar
 2023 14:41:25 +0000
Date:   Mon, 6 Mar 2023 14:41:24 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <bwidawsk@kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230306144124.00006b94@Huawei.com>
In-Reply-To: <b766b4ca-1255-3b33-864c-0e7f9ab00e15@linux.intel.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
        <20230303175022.10806-4-Jonathan.Cameron@huawei.com>
        <b766b4ca-1255-3b33-864c-0e7f9ab00e15@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Fri, 3 Mar 2023 16:56:10 -0500
"Liang, Kan" <kan.liang@linux.intel.com> wrote:

> On 2023-03-03 12:50 p.m., Jonathan Cameron wrote:
> > CXL rev 3.0 introduces a standard performance monitoring hardware
> > block to CXL. Instances are discovered using CXL Register Locator DVSEC
> > entries. Each CXL component may have multiple PMUs.
> > 
> > This initial driver supports on a subset of types of counter.
> > It support counters that are either fixed or configurable, but requires
> > that they support the ability to freeze and write value whilst frozen.
> > 
> > Development done with QEMU model which will be posted shortly.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
Hi Kan,

> > --
> > Questions:
> > - Where to put the driver. Previous discussions on similar drivers
> >   led to them being under drivers/perf (hisi_pcie_pmu) but in CXL
> >   case that means exposing a load of stuff current only visible
> >   in drivers/cxl
> > - How to handle vendor specific events. They are fully discoverable
> >   but we have no way to give them a pretty name.  
> 
> Besides hardcode them in the kernel driver, I think we may support
> different event lists in the user space perf tool, which should be more
> flxiable. Please see tools/perf/pmu-events/. You may also define the
> summed events in the perf tool as well.

We can do that (e.g. similar to what is done for ARM's vendor defined events)
but I still think we need more here because the hardware is exporting a
description of what is supported and there is no standard interface by which
the userspace tooling can discover that.

Not a lot of point in discoverable hardware if we have to hard code what
is being described in the tooling.  Also, given it's fully described
there is no reason a device would do anything extra to advertise new
facilities (i.e. we would have no way to match against a particular
implementation).

A hybrid approach of exposing the VID / GID / Mask sets to userspace that
then deals with pretty naming etc would work though.

For summed events we also don't have enough information without similar
exports of VID / GID / Mask.

We can't use the fact that events are exposed which 'might' be summable in
hardware because we may have only subsets supported by the hardware.

E.g.

VID / GID / Mask

19e5 / 1 / 0x1
19e5 / 1 / 0xe

etc 

There are going to be a lot of CXL device implementations so I think we need
to find a sensible interface to pass this information to perf tool.

Currently I'm thinking a new sysfs ABI that has

event_groupX_vid, event_groupX_gid, event_groupX_msk, event_groupX_fixed 
with one set of entries for every event group.

Using that, perf tool can apply various rules to figure out sensible subsets
to advertise.

> > +#define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
> > +
> > +/*
> > + * All CPMU counters are discoverable via the Event Capabilities Registers.
> > + * Each Event Capability register contains a a VID / GroupID.
> > + * A counter may then count any combination (by summing) of events in
> > + * that group which are in the Supported Events Bitmask.
> > + * However, there are some complexities to the scheme.
> > + *  - Fixed function counters refer to an Event Capabilities register.
> > + *    That event capability register is not then used for Configurable
> > + *    counters.
> > + * TODO: Support summed events.
> > + */
> > +static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
> > +{
> > +	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};
> > +	void __iomem *base = info->base;
> > +	u64 val, eval;
> > +	int i;
> > +
> > +	val = readq(base + CPMU_CAP_REG);
> > +	info->freeze_for_enable = FIELD_GET(CPMU_CAP_WRITEABLE_WHEN_FROZEN, val) &
> > +		FIELD_GET(CPMU_CAP_FREEZE, val);
> > +	if (!info->freeze_for_enable) {
> > +		dev_err(dev, "Driver does not support CPMUs that do not support freeze for enable\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	info->num_counters = FIELD_GET(CPMU_CAP_NUM_COUNTERS_MSK, val) + 1;
> > +	info->counter_width = FIELD_GET(CPMU_CAP_COUNTER_WIDTH_MSK, val);
> > +	info->num_event_capabilities = FIELD_GET(CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
> > +
> > +	info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val);  
> 
> Assign the whole mask to a bool?

Good spot. This is also missing the fact there is a second defined filter ID - though
I'll leave supporting the channel, rank, bank group filter for a future patch set. 

info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val) & BIT(0)
//with an appropriate define

> 
> > +	if (FIELD_GET(CPMU_CAP_INT, val))
> > +		info->irq = FIELD_GET(CPMU_CAP_MSI_N_MSK, val);
> > +	else
> > +		info->irq = -1;
> > +
> > +	/* First handle fixed function counters; note if configurable counters found */
> > +	for (i = 0; i < info->num_counters; i++) {
> > +		struct cpmu_event *cpmu_ev;
> > +		u32 events_msk;
> > +		u8 group_idx;
> > +
> > +		val = readq(base + CPMU_COUNTER_CFG_REG(i));
> > +
> > +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) ==
> > +			CPMU_COUNTER_CFG_TYPE_CONFIGURABLE) {
> > +			set_bit(i, info->conf_counter_bm);
> > +		}
> > +
> > +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) !=
> > +		    CPMU_COUNTER_CFG_TYPE_FIXED_FUN)
> > +			continue;
> > +
> > +		/* In this case we know which fields are const */
> > +		group_idx = FIELD_GET(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, val);
> > +		events_msk = FIELD_GET(CPMU_COUNTER_CFG_EVENTS_MSK, val);
> > +		eval = readq(base + CPMU_EVENT_CAP_REG(group_idx));
> > +		cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> > +		if (!cpmu_ev)
> > +			return -ENOMEM;
> > +
> > +		cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> > +		cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> > +		/* For a fixed purpose counter use the events mask from the counter CFG */
> > +		cpmu_ev->msk = events_msk;
> > +		cpmu_ev->configurable = false;
> > +		cpmu_ev->counter_idx = i;
> > +		/* This list add is never unwound as all entries deleted on remove */
> > +		list_add(&cpmu_ev->node, &info->cpmu_events);
> > +		/*
> > +		 * Configurable counters must not use an Event Capability registers that
> > +		 * is in use for a Fixed counter
> > +		 */
> > +		set_bit(group_idx, fixed_counter_event_cap_bm);
> > +	}
> > +
> > +	if (!bitmap_empty(info->conf_counter_bm, CPMU_MAX_COUNTERS)) {
> > +		struct cpmu_event *cpmu_ev;
> > +		int j;
> > +		/* Walk event capabilities unused by fixed counters */
> > +		for_each_clear_bit(j, fixed_counter_event_cap_bm,
> > +				   info->num_event_capabilities) {
> > +			cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> > +			if (!cpmu_ev)
> > +				return -ENOMEM;
> > +
> > +			eval = readq(base + CPMU_EVENT_CAP_REG(j));
> > +			cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> > +			cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> > +			cpmu_ev->msk = FIELD_GET(CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK, eval);
> > +			cpmu_ev->event_idx = j;
> > +			cpmu_ev->configurable = true;
> > +			list_add(&cpmu_ev->node, &info->cpmu_events);
> > +		}
> > +	}
> > +  
> 
> So each fixed counter has a dedicated event cap reg.
> All the configurable counters share the rest of the event cap regs.
> Is my understanding correct?

Yes.

> 
> To check the event cap, you have to go through the whole list, which
> seems not efficient. Have you consisdered to use other structure, e.g.,
> rb-tree to store the event capability information.

Whilst this is a fairly short list for a given CPMU (max 32 elements),
there is no harm in having something cleaner. 

However I'm struggling a bit on what that structure should be.
There are two forms of indexing used.
1. VID, GID and MASK all match precisely - could use an xarray, but
   the index created from these is too large, so I guess an RB tree.
2. VID, GID and subset of MASK (no constraints on mask combinations)

Can't index by just VID/GID as there may well be multiple entries.

Can't index by VID/GID/MASK as whilst that is either unique (or there is
duplication we can ignore) there is no obvious way to search for
a subset of mask.  Could have a red black tree with lists for the nodes
but that's pretty ugly.

Any thoughts on what would work here?

 
> 
> > +	return 0;
> > +}
> > +
> > +static ssize_t cpmu_event_sysfs_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	struct perf_pmu_events_attr *pmu_attr =
> > +		container_of(attr, struct perf_pmu_events_attr, attr);
> > +
> > +	return sysfs_emit(buf, "config=%#llx\n", pmu_attr->id);
> > +}
> > +
> > +#define CPMU_PMU_EVENT_ATTR(_name, _vid, _gid, _msk)			\
> > +	PMU_EVENT_ATTR_ID(_name, cpmu_event_sysfs_show,			\
> > +			  ((u64)(_vid) << 48) | ((u64)(_gid) << 32) | (u64)(_msk))
> > +
> > +static struct attribute *cpmu_event_attrs[] = {
> > +	CPMU_PMU_EVENT_ATTR(clock_ticks,	0x1e98, CPMU_GID_CLOCK_TICKS, BIT(0)),  
> 
> It may be a naive question. Is 0x1e98 stands for standard events which
> avialble for all venders, or for specific venders.
> We should need a macro for the megic number.

0x1e98 is the "Vendor ID" for CXL so these are the events in the CXL spec.
Can use the (rather misnamed - there is legal complexity around this)
PCI_DVSEC_VENDOR_ID_CXL in cxlmem.h

Note however that there is nothing stopping a vendor using events defined
by a different vendor.  This is similar to the intent of DVSEC in PCIe.
A group of vendors can decide to use one common definition to reduce fragmentation
etc.  Also often applies if they are using IP licensed from someone else for
some part of their CXL device.

To keep line lengths sensible I'll add another macro
CPMU_PMU_EVENT_CXL_ATTR() that fills in the VID.

...


> > +static ssize_t cpmu_format_sysfs_show(struct device *dev,
> > +				      struct device_attribute *attr, char *buf)
> > +{
> > +	struct dev_ext_attribute *eattr;
> > +
> > +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> > +
> > +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> > +}
> > +


...

> > +
> > +static int cpmu_event_init(struct perf_event *event)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +
> > +	event->cpu = info->on_cpu;
> > +	/* Top level type sanity check - is this a Hardware Event being requested */
> > +	if (event->attr.type != event->pmu->type)
> > +		return -ENOENT;
> > +
> > +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> > +		return -EOPNOTSUPP;
> > +	/* TODO: Validation of any filter */  
> 
> It's better to move all the event cap related check here. If it's
> impossible to find a counter, we should error out earlier.

I've moved the idx from the return value to an optional parameter to cpmu_get_event_idx()
so that I can use that function here to just check if counting the event is possible.
Also noted that adding the ability to stash the event_idx in hwc->event_base in
the event_add() callback removes the need to look it up later at all (for the
configurable counters, never needed to look it up for fixed ones).

That lets me drop cpmu_find_matching_event_cap() at the cost of a slightly more
complex cpmu_get_event_idx()
More importantly it means we only walk the list once to set up a counter.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void cpmu_pmu_enable(struct pmu *pmu)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(pmu);
> > +	void __iomem *base = info->base;
> > +	int num;
> > +
> > +	/* We don't have a global enable, but we 'might' have a global freeze which we can use */
> > +	if (info->freeze_for_enable) {
> > +		/* Check if something is enabled */
> > +		for (num = 0; num < info->num_counters; num++) {
> > +			if (info->hw_events[num])
> > +				break;
> > +		}
> > +		if (num == info->num_counters)
> > +			return;
> > +  
> 
> The individial counter should also be controlled by per-counter en bit.
> So I don't think we need to above check.
Dropped.

> 
> > +		/* Can assume frozen at this stage */
> > +		writeq(0, base + CPMU_FREEZE_REG);
> > +
> > +		return;
> > +	}
> > +}
> > +
+

> > +
> > +static void cpmu_event_start(struct perf_event *event, int flags)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	void __iomem *base = info->base;
> > +	u64 cfg, prev_cnt;
> > +
> > +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> > +		return;
> > +
> > +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
> > +	hwc->state = 0;
> > +
> > +	/*
> > +	 * Currently only hdm filter is defined, this code will
> > +	 * want generalizing when more are defined.
> > +	 */
> > +	if (info->filter_hdm) {
> > +		if (cpmu_config1_hdm_filter_en(event))
> > +			cfg = cpmu_config2_get_hdm_decoder(event);
> > +		else
> > +			cfg = GENMASK(15, 0);
> > +		writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
> > +	}
> > +
> > +	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EDGE, cpmu_config1_get_edge(event) ? 1 : 0);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INVERT, cpmu_config1_get_invert(event) ? 1 : 0);
> > +
> > +	/* Fixed purpose counters have next two fields RO */
> > +	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> > +		int event_idx = cpmu_find_matching_event_cap(info, event);
> > +  
> 
> I think we should check the event_cap in the event_init. So we can error
> out earlier.

Done. 

> 
> > +		if (event_idx < 0) {
> > +			dev_dbg(info->pmu.dev, "Could not find matching event capability\n");
> > +			return;
> > +		}
> > +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, event_idx);
> > +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENTS_MSK, cpmu_config_get_mask(event));
> > +	}
> > +	cfg &= ~CPMU_COUNTER_CFG_THRESHOLD_MSK;
> > +	/*
> > +	 * For events that generate only 1 count per clock the CXL 3.0 spec
> > +	 * states the threshold shall be set to 1 but if set to 0 it will
> > +	 * count the raw value anwyay?
> > +	 * There is definition of what events will count multiple per cycle
> > +	 * and hence to which non 1 values of threshold can apply.
> > +	 * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
> > +	 */
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_THRESHOLD_MSK,
> > +			  cpmu_config1_get_threshold(event));
> > +	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
> > +
> > +	local64_set(&hwc->prev_count, 0);
> > +	writeq(0, base + CPMU_COUNTER_REG(hwc->idx));
> > +
> > +	if (flags & PERF_EF_RELOAD) {
> > +		prev_cnt = local64_read(&hwc->prev_count);
> > +		writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
> > +	}
> > +
> > +	perf_event_update_userpage(event);
> > +}
> > +


> > +
> > +static int cpmu_get_event_idx(struct perf_event *event)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +	struct cpmu_event *cpmu_ev;
> > +	u32 mask;
> > +	u16 gid, vid;
> > +
> > +	vid = cpmu_config_get_vid(event);
> > +	gid = cpmu_config_get_gid(event);
> > +	mask = cpmu_config_get_mask(event);
> > +
> > +	list_for_each_entry(cpmu_ev, &info->cpmu_events, node) {
> > +		int idx;
> > +
> > +		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
> > +			continue;
> > +
> > +		/*
> > +		 * For fixed counters, must match exactly.
> > +		 * No need to support duplicates so if first in use
> > +		 * return an error.
> > +		 */
> > +		if (!cpmu_ev->configurable) {
> > +			if (cpmu_ev->msk != mask)
> > +				continue;
> > +			if (info->hw_events[cpmu_ev->counter_idx])
> > +				return -EINVAL;
> > +  
> 
> Is it possible that an event group can be counted by either fixed
> counter or configurable counters? If yes, maybe we should try
> configurable counters if the fixed counter is occupied.

Yes it is possible for there to be a two overlapping event capabilities
one used for the fixed counter and another one that lets you count
the same thing. However if a fixed counter is occupied,
we are already counting whatever it is, so why would we enable
counting it again?  The code should allow for summed counters including
something already being counted via a fixed counter. That's probably
not going to be a common thing to see in implementations but there is
no harm in supporting it.

> 
> 
> > +			return cpmu_ev->counter_idx;
> > +		}
> > +
> > +		/* Requested mask needs to be subset of available */
> > +		if (~cpmu_ev->msk & mask)
> > +			continue;
> > +
> > +		/* Found the group, now see if any configurable counters left */
> > +		for_each_set_bit(idx, info->conf_counter_bm, 64) {
> > +			if (!info->hw_events[idx])
> > +				return idx;
> > +		}  
> 
> I think it may be better to use a mask to track the availability of the
> counters. find_next_bit() can be used to retrieve the available idx.

Sure.  Whilst it feels a bit like overkill to do so for this one search path
(all the others need the hw_events[idx] value anyway) but it isn't
a lot of code, particularly with bitmap_andnot() to mean we are doing
find_first_bit() on a bitmap only containing the configurable counters
not yet allocated.  Hence I've made the change.

Also curiously whilst doing it, noticed that the max counters define was set
to 32 not 64.  So this ran clean off the end. 


...

> > +static irqreturn_t cpmu_irq(int irq, void *data)
> > +{
> > +	struct cpmu_info *info = data;
> > +	void __iomem *base = info->base;
> > +	u64 overflowed;
> > +	DECLARE_BITMAP(overflowedbm, 64);
> > +	int i;
> > +
> > +	overflowed = readq(base + CPMU_OVERFLOW_REG);
> > +
> > +	/* Interrupt may be shared, so maybe it isn't ours */
> > +	if (!overflowed)
> > +		return IRQ_NONE;
> > +
> > +	bitmap_from_arr64(overflowedbm, &overflowed, 64);
> > +	for_each_set_bit(i, overflowedbm, info->num_counters) {
> > +		struct perf_event *event = info->hw_events[i];
> > +
> > +		if (!event) {
> > +			dev_dbg(info->pmu.dev,
> > +				"overflow but on non enabled counter %d\n", i);
> > +			continue;
> > +		}
> > +
> > +		__cpmu_read(event, true);
> > +	}
> > +
> > +	writeq(overflowed, base + CPMU_OVERFLOW_REG);  
> 
> Is it possible that other counters are overflowed right after we read
> the CPMU_OVERFLOW_REG?
> If so, we probably want to freez all counters when handling the overflow
> or re-check the CPMU_OVERFLOW_REG here.

We get an MSI/MSIX on every overflow. So if there is more than one we'll
just come here again.  It's a RW1C register so by writing overflowed
back we are only clearing bits that we have dealt with.
 
Thanks for reviewing, particularly doing it so quickly!

Jonathan

> 
> Thanks,
> Kan
