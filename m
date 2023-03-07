Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F866ADA17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCGJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjCGJTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:19:43 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F93472B28;
        Tue,  7 Mar 2023 01:19:40 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PW8z80r6qz6J7Q4;
        Tue,  7 Mar 2023 17:19:32 +0800 (CST)
Received: from localhost (10.126.173.40) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 7 Mar
 2023 09:19:36 +0000
Date:   Tue, 7 Mar 2023 09:19:36 +0000
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
Message-ID: <20230307091936.000055be@Huawei.com>
In-Reply-To: <52abbd9a-3a63-3dde-c20f-99787225200e@linux.intel.com>
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
        <20230303175022.10806-4-Jonathan.Cameron@huawei.com>
        <b766b4ca-1255-3b33-864c-0e7f9ab00e15@linux.intel.com>
        <20230306144124.00006b94@Huawei.com>
        <52abbd9a-3a63-3dde-c20f-99787225200e@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.40]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

...

> >>> Questions:
> >>> - Where to put the driver. Previous discussions on similar drivers
> >>>   led to them being under drivers/perf (hisi_pcie_pmu) but in CXL
> >>>   case that means exposing a load of stuff current only visible
> >>>   in drivers/cxl
> >>> - How to handle vendor specific events. They are fully discoverable
> >>>   but we have no way to give them a pretty name.    
> >>
> >> Besides hardcode them in the kernel driver, I think we may support
> >> different event lists in the user space perf tool, which should be more
> >> flxiable. Please see tools/perf/pmu-events/. You may also define the
> >> summed events in the perf tool as well.  
> > 
> > We can do that (e.g. similar to what is done for ARM's vendor defined events)
> > but I still think we need more here because the hardware is exporting a
> > description of what is supported and there is no standard interface by which
> > the userspace tooling can discover that.
> > 
> > Not a lot of point in discoverable hardware if we have to hard code what
> > is being described in the tooling.  Also, given it's fully described
> > there is no reason a device would do anything extra to advertise new
> > facilities (i.e. we would have no way to match against a particular
> > implementation).  
> 
> A "caps" folder can be created in sysfs for a PMU. The hardware
> capabilities can be descripted there. Currently, both X86 core PMU and
> intel_pt PMU utilize it.

Thanks for the pointer, I'll take a look at how that is used.

> 
> > 
> > A hybrid approach of exposing the VID / GID / Mask sets to userspace that
> > then deals with pretty naming etc would work though.
> >
> > For summed events we also don't have enough information without similar
> > exports of VID / GID / Mask.
> > 
> > We can't use the fact that events are exposed which 'might' be summable in
> > hardware because we may have only subsets supported by the hardware.
> > 
> > E.g.
> > 
> > VID / GID / Mask
> > 
> > 19e5 / 1 / 0x1
> > 19e5 / 1 / 0xe
> > 
> > etc 
> > 
> > There are going to be a lot of CXL device implementations so I think we need
> > to find a sensible interface to pass this information to perf tool.
> > 
> > Currently I'm thinking a new sysfs ABI that has
> > 
> > event_groupX_vid, event_groupX_gid, event_groupX_msk, event_groupX_fixed 
> > with one set of entries for every event group.
> > 
> > Using that, perf tool can apply various rules to figure out sensible subsets
> > to advertise.
> >  
> 
> Usually, we only hardcode the generic/architectural or some widely used
> events in the kernel. The perf tool should be the place for the vender
> specific/device specific events.
> 
> We may not want to expose the counter constraints information to the
> user space. It's better to keep the information in the kernel. We can
> use it to check whether the user input is valid in the event_init.
> 
> For a specific device, the constraint information should be fixed. We
> may create a dedicate event list file in perf tool for each device.
> 
> For example, with your example, you can define the below events in the
> event list file. (just demonstrate the idea. It should be in JSON format
> in the file.)
> Event Name / VID / GID / Mask
> A          / 19e5 / 1 / 0x1
> B          / 19e5 / 1 / 0x2
> C          / 19e5 / 1 / 0x4
> D          / 19e5 / 1 / 0x8
> BC         / 19e5 / 1 / 0x6
> BD         / 19e5 / 1 / 0xa
> CD         / 19e5 / 1 / 0xc
> BCD        / 19e5 / 1 / 0xe
> 
> perf stat -e BD will give you the summed event B + D.

To me, that seems to be a non starter.  We will have 100s to 1000s of
device variants, each of which may have several instances of CPMU with
different events. The available events on some devices will be
firmware version dependent.

The explosion in json files will rapidly become unmanageable.
Given PMU capabilities are fully discoverable we should use that.

We'd then need json to describe what groups make sense, but not which
ones the particular hardware supports.  Thus we'd need one set of
data for a particular VID/GID pair, instead of one for every device
with it's own mix of multiple masks for each VID/GID pair.

In a similar fashion to metrics, not all combinations are likely to be
useful things to measure so we can describe just the ones that seem
reasonable.



> 
> 
> >>> +#define pmu_to_cpmu_info(_pmu) container_of(_pmu, struct cpmu_info, pmu)
> >>> +
> >>> +/*
> >>> + * All CPMU counters are discoverable via the Event Capabilities Registers.
> >>> + * Each Event Capability register contains a a VID / GroupID.
> >>> + * A counter may then count any combination (by summing) of events in
> >>> + * that group which are in the Supported Events Bitmask.
> >>> + * However, there are some complexities to the scheme.
> >>> + *  - Fixed function counters refer to an Event Capabilities register.
> >>> + *    That event capability register is not then used for Configurable
> >>> + *    counters.
> >>> + * TODO: Support summed events.
> >>> + */
> >>> +static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
> >>> +{
> >>> +	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};
> >>> +	void __iomem *base = info->base;
> >>> +	u64 val, eval;
> >>> +	int i;
> >>> +
> >>> +	val = readq(base + CPMU_CAP_REG);
> >>> +	info->freeze_for_enable = FIELD_GET(CPMU_CAP_WRITEABLE_WHEN_FROZEN, val) &
> >>> +		FIELD_GET(CPMU_CAP_FREEZE, val);
> >>> +	if (!info->freeze_for_enable) {
> >>> +		dev_err(dev, "Driver does not support CPMUs that do not support freeze for enable\n");
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	info->num_counters = FIELD_GET(CPMU_CAP_NUM_COUNTERS_MSK, val) + 1;
> >>> +	info->counter_width = FIELD_GET(CPMU_CAP_COUNTER_WIDTH_MSK, val);
> >>> +	info->num_event_capabilities = FIELD_GET(CPMU_CAP_NUM_EVN_CAP_REG_SUP_MSK, val) + 1;
> >>> +
> >>> +	info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val);    
> >>
> >> Assign the whole mask to a bool?  
> > 
> > Good spot. This is also missing the fact there is a second defined filter ID - though
> > I'll leave supporting the channel, rank, bank group filter for a future patch set. 
> > 
> > info->filter_hdm = FIELD_GET(CPMU_CAP_FILTERS_SUP_MSK, val) & BIT(0)
> > //with an appropriate define
> >   
> >>  
> >>> +	if (FIELD_GET(CPMU_CAP_INT, val))
> >>> +		info->irq = FIELD_GET(CPMU_CAP_MSI_N_MSK, val);
> >>> +	else
> >>> +		info->irq = -1;
> >>> +
> >>> +	/* First handle fixed function counters; note if configurable counters found */
> >>> +	for (i = 0; i < info->num_counters; i++) {
> >>> +		struct cpmu_event *cpmu_ev;
> >>> +		u32 events_msk;
> >>> +		u8 group_idx;
> >>> +
> >>> +		val = readq(base + CPMU_COUNTER_CFG_REG(i));
> >>> +
> >>> +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) ==
> >>> +			CPMU_COUNTER_CFG_TYPE_CONFIGURABLE) {
> >>> +			set_bit(i, info->conf_counter_bm);
> >>> +		}
> >>> +
> >>> +		if (FIELD_GET(CPMU_COUNTER_CFG_TYPE_MSK, val) !=
> >>> +		    CPMU_COUNTER_CFG_TYPE_FIXED_FUN)
> >>> +			continue;
> >>> +
> >>> +		/* In this case we know which fields are const */
> >>> +		group_idx = FIELD_GET(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, val);
> >>> +		events_msk = FIELD_GET(CPMU_COUNTER_CFG_EVENTS_MSK, val);
> >>> +		eval = readq(base + CPMU_EVENT_CAP_REG(group_idx));
> >>> +		cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> >>> +		if (!cpmu_ev)
> >>> +			return -ENOMEM;
> >>> +
> >>> +		cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> >>> +		cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> >>> +		/* For a fixed purpose counter use the events mask from the counter CFG */
> >>> +		cpmu_ev->msk = events_msk;
> >>> +		cpmu_ev->configurable = false;
> >>> +		cpmu_ev->counter_idx = i;
> >>> +		/* This list add is never unwound as all entries deleted on remove */
> >>> +		list_add(&cpmu_ev->node, &info->cpmu_events);
> >>> +		/*
> >>> +		 * Configurable counters must not use an Event Capability registers that
> >>> +		 * is in use for a Fixed counter
> >>> +		 */
> >>> +		set_bit(group_idx, fixed_counter_event_cap_bm);
> >>> +	}
> >>> +
> >>> +	if (!bitmap_empty(info->conf_counter_bm, CPMU_MAX_COUNTERS)) {
> >>> +		struct cpmu_event *cpmu_ev;
> >>> +		int j;
> >>> +		/* Walk event capabilities unused by fixed counters */
> >>> +		for_each_clear_bit(j, fixed_counter_event_cap_bm,
> >>> +				   info->num_event_capabilities) {
> >>> +			cpmu_ev = devm_kzalloc(dev, sizeof(*cpmu_ev), GFP_KERNEL);
> >>> +			if (!cpmu_ev)
> >>> +				return -ENOMEM;
> >>> +
> >>> +			eval = readq(base + CPMU_EVENT_CAP_REG(j));
> >>> +			cpmu_ev->vid = FIELD_GET(CPMU_EVENT_CAP_VENDOR_ID_MSK, eval);
> >>> +			cpmu_ev->gid = FIELD_GET(CPMU_EVENT_CAP_GROUP_ID_MSK, eval);
> >>> +			cpmu_ev->msk = FIELD_GET(CPMU_EVENT_CAP_SUPPORTED_EVENTS_MSK, eval);
> >>> +			cpmu_ev->event_idx = j;
> >>> +			cpmu_ev->configurable = true;
> >>> +			list_add(&cpmu_ev->node, &info->cpmu_events);
> >>> +		}
> >>> +	}
> >>> +    
> >>
> >> So each fixed counter has a dedicated event cap reg.
> >> All the configurable counters share the rest of the event cap regs.
> >> Is my understanding correct?  
> > 
> > Yes.
> >   
> >>
> >> To check the event cap, you have to go through the whole list, which
> >> seems not efficient. Have you consisdered to use other structure, e.g.,
> >> rb-tree to store the event capability information.  
> > 
> > Whilst this is a fairly short list for a given CPMU (max 32 elements),
> > there is no harm in having something cleaner. 
> > 
> > However I'm struggling a bit on what that structure should be.
> > There are two forms of indexing used.
> > 1. VID, GID and MASK all match precisely - could use an xarray, but
> >    the index created from these is too large, so I guess an RB tree.
> > 2. VID, GID and subset of MASK (no constraints on mask combinations)
> > 
> > Can't index by just VID/GID as there may well be multiple entries.
> > 
> > Can't index by VID/GID/MASK as whilst that is either unique (or there is
> > duplication we can ignore) there is no obvious way to search for
> > a subset of mask.  Could have a red black tree with lists for the nodes
> > but that's pretty ugly.
> > 
> > Any thoughts on what would work here?  
> 
> If it's a short list, I think it should be OK.
> But I think we may want to split the list into a fixed counter list and
> a configurable counter list. I don't see a reason to mix them in one
> list. It should further reduce the list. I think we may further factor
> out a wrapper e.g., cpmu_events_find_fixed_counter(vid,gid,mask),
> cpmu_events_find_config_counter(vid,gid,mask).

Ok. Two lists should work and the separation of the two find functions
that results is a nice advantage.

> 
> > 
> >    
> >>  
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static ssize_t cpmu_event_sysfs_show(struct device *dev,
> >>> +				     struct device_attribute *attr, char *buf)
> >>> +{
> >>> +	struct perf_pmu_events_attr *pmu_attr =
> >>> +		container_of(attr, struct perf_pmu_events_attr, attr);
> >>> +
> >>> +	return sysfs_emit(buf, "config=%#llx\n", pmu_attr->id);
> >>> +}
> >>> +
> >>> +#define CPMU_PMU_EVENT_ATTR(_name, _vid, _gid, _msk)			\
> >>> +	PMU_EVENT_ATTR_ID(_name, cpmu_event_sysfs_show,			\
> >>> +			  ((u64)(_vid) << 48) | ((u64)(_gid) << 32) | (u64)(_msk))
> >>> +
> >>> +static struct attribute *cpmu_event_attrs[] = {
> >>> +	CPMU_PMU_EVENT_ATTR(clock_ticks,	0x1e98, CPMU_GID_CLOCK_TICKS, BIT(0)),    
> >>
> >> It may be a naive question. Is 0x1e98 stands for standard events which
> >> avialble for all venders, or for specific venders.
> >> We should need a macro for the megic number.  
> > 
> > 0x1e98 is the "Vendor ID" for CXL so these are the events in the CXL spec.
> > Can use the (rather misnamed - there is legal complexity around this)
> > PCI_DVSEC_VENDOR_ID_CXL in cxlmem.h
> > 
> > Note however that there is nothing stopping a vendor using events defined
> > by a different vendor.  This is similar to the intent of DVSEC in PCIe.
> > A group of vendors can decide to use one common definition to reduce fragmentation
> > etc.  Also often applies if they are using IP licensed from someone else for
> > some part of their CXL device.  
> 
> OK. I assume that all the different CXL devices rely on this CXL PMU
> driver to manipulate the counters. They don't register a PMU in some
> place like their specfic driver if there is one.
> 
> I assume that the events with VID 0x1e98 should be the events with a
> common definition by a group of vendors, right?

In this case the group is the CXL consortium itself - they are in the CXL r3.0
specification.  So that particular vendor ID is special as many (perhaps most)
CPMU instances will support some of these.

Over time we might get other sets that are common enough to support in driver,
but mostly it probably makes sense to just push them to perftool which can
work out what they are.

> 
> > 
> > To keep line lengths sensible I'll add another macro
> > CPMU_PMU_EVENT_CXL_ATTR() that fills in the VID.
> > 

...

> >>> +
> >>> +static int cpmu_get_event_idx(struct perf_event *event)
> >>> +{
> >>> +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> >>> +	struct cpmu_event *cpmu_ev;
> >>> +	u32 mask;
> >>> +	u16 gid, vid;
> >>> +
> >>> +	vid = cpmu_config_get_vid(event);
> >>> +	gid = cpmu_config_get_gid(event);
> >>> +	mask = cpmu_config_get_mask(event);
> >>> +
> >>> +	list_for_each_entry(cpmu_ev, &info->cpmu_events, node) {
> >>> +		int idx;
> >>> +
> >>> +		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
> >>> +			continue;
> >>> +
> >>> +		/*
> >>> +		 * For fixed counters, must match exactly.
> >>> +		 * No need to support duplicates so if first in use
> >>> +		 * return an error.
> >>> +		 */
> >>> +		if (!cpmu_ev->configurable) {
> >>> +			if (cpmu_ev->msk != mask)
> >>> +				continue;
> >>> +			if (info->hw_events[cpmu_ev->counter_idx])
> >>> +				return -EINVAL;
> >>> +    
> >>
> >> Is it possible that an event group can be counted by either fixed
> >> counter or configurable counters? If yes, maybe we should try
> >> configurable counters if the fixed counter is occupied.  
> > 
> > Yes it is possible for there to be a two overlapping event capabilities
> > one used for the fixed counter and another one that lets you count
> > the same thing. However if a fixed counter is occupied,
> > we are already counting whatever it is, so why would we enable
> > counting it again?  The code should allow for summed counters including
> > something already being counted via a fixed counter. That's probably
> > not going to be a common thing to see in implementations but there is
> > no harm in supporting it.  
> 
> There may be multiple users. The User A and User B may read two similar
> events (Same VID/GID, but slitely different mask). If a fixed counter is
> assigned to the User A. I think we may want to assign a configurable
> counter to the User B if possible.

Let me see how hard this is to support.  If it turns out to be non trivial
I'll be tempted to leave it as a feature we'll implement when hardware / usecase
shows up.

Given expense of the hardware involved I'd be surprised if we see
many implementations doing this but it might happen if people are using
IP blocks that support choosing mixture of fixed and configurable counters
at RTL generation time.

> > ...
> >   
> >>> +static irqreturn_t cpmu_irq(int irq, void *data)
> >>> +{
> >>> +	struct cpmu_info *info = data;
> >>> +	void __iomem *base = info->base;
> >>> +	u64 overflowed;
> >>> +	DECLARE_BITMAP(overflowedbm, 64);
> >>> +	int i;
> >>> +
> >>> +	overflowed = readq(base + CPMU_OVERFLOW_REG);
> >>> +
> >>> +	/* Interrupt may be shared, so maybe it isn't ours */
> >>> +	if (!overflowed)
> >>> +		return IRQ_NONE;
> >>> +
> >>> +	bitmap_from_arr64(overflowedbm, &overflowed, 64);
> >>> +	for_each_set_bit(i, overflowedbm, info->num_counters) {
> >>> +		struct perf_event *event = info->hw_events[i];
> >>> +
> >>> +		if (!event) {
> >>> +			dev_dbg(info->pmu.dev,
> >>> +				"overflow but on non enabled counter %d\n", i);
> >>> +			continue;
> >>> +		}
> >>> +
> >>> +		__cpmu_read(event, true);
> >>> +	}
> >>> +
> >>> +	writeq(overflowed, base + CPMU_OVERFLOW_REG);    
> >>
> >> Is it possible that other counters are overflowed right after we read
> >> the CPMU_OVERFLOW_REG?
> >> If so, we probably want to freez all counters when handling the overflow
> >> or re-check the CPMU_OVERFLOW_REG here.  
> > 
> > We get an MSI/MSIX on every overflow. So if there is more than one we'll
> > just come here again.  It's a RW1C register so by writing overflowed
> > back we are only clearing bits that we have dealt with.
> >    
> 
> OK. It looks good as long as every MSI/MSIX is not dropped and the bit
> is not accidentally overwritten.
> 
> Thanks,
> Kan
> 
Thanks

Jonathan


