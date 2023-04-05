Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D606D8311
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjDEQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDEQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:08:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF41E7E;
        Wed,  5 Apr 2023 09:08:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ps8fr3bRgz67bcp;
        Thu,  6 Apr 2023 00:07:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 5 Apr
 2023 17:08:35 +0100
Date:   Wed, 5 Apr 2023 17:08:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Liang Kan <kan.liang@linux.intel.com>, <linux-cxl@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <will@kernel.org>, <linuxarm@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230405170834.00000c44@Huawei.com>
In-Reply-To: <642c9c6e1f9df_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
        <20230330164556.31533-5-Jonathan.Cameron@huawei.com>
        <642c9c6e1f9df_21a829451@dwillia2-xfh.jf.intel.com.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for taking a look.

> > Development done with QEMU model which will be posted shortly.  
> 
> Per the comment on the cover letter is there a sense that set of
> counters supported in QEMU and this patchset are representative of a
> "common" set even if that is by convention and not specification?Just
> trying to get a sense of how many real world CXL PMU instances this
> might cover.

Good question.  Events wise, the driver supports all the Spec defined events
(for the Vendor defined ones they "work" but are not described in this initial
version so you have to know the magic numbers).  In discussion with Kan I think
we've established what discoverability will look like but it is a substantial
addition so I was planning that for a follow up series.

Features wise things I expect in hardware that don't 'yet' support include:
1) Implementations without freeze.  They require more complex handling of
   start / stop (and will never work as well as you can't start sets of
   counters with one register right).  Easy to see how to do this but
   postponed for a follow up set.
2) Free running counters.  Chances are we'll see these for vendor defined events
   as they are a cheap way of getting support for stuff that is really debug related.
   Again, well understood how to do this but adds more complexity to the driver
   so postponed for future work.

So after this series merges, I'd expect to see 3 follow-ups to add each of the
above features, probably in the order:

1) Discoverability.
2) Free running counters
3) Implementations without freeze.
(might do last two in one series)

Note that I haven't yet added configurability via command line to the the
QEMU model.  The hard coded emulation has a fairly random set of events
and counters meant to hit corner cases (overlapping sets, mixture of
configurable and not) rather than represent a typical real device.

Once that has an interface to specify the CPMU options it'll be easier
to have some 'normal' cases to test and some more insane ones to hit
the corners. 

> 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> One thing I would have liked to see is a sample perf command line and
> output.

Sure. I'll add one here and consider improving the docs on this.

> 
> One concern I have is how usable DPA based perf events is going to be
> for end users. Is there a concept of a synthetic event that can turn
> data gathered from all the devices in an interleave set into HPA
> relative data? Or do you expect that is the responsibility of the perf
> tool to grow that support in userspace?

Given we need to fuse counters from multiple devices up in userspace
I'd expect us to do cross device aggregation in perf tool.  Will be very
system dependent on whether such aggregation makes sense (if you can't monitor
what you need in host or at the HB level.).

> > ---
> >  drivers/cxl/Kconfig  |  13 +
> >  drivers/cxl/Makefile |   1 +
> >  drivers/cxl/cpmu.c   | 940 +++++++++++++++++++++++++++++++++++++++++++  
> 
> Yeah, this is a bunch of code and ABI that is more relevant to drivers/perf/
> than drivers/cxl/, so this wants to move to drivers/perf/cxl.c.
For consistency with other drivers in there it will be drivers/perf/cxl_pmu.c
with cxl_pmu.ko as module.


It's currently a little messy to get the includes from
../cxl/ but not bad enough that I think it's worth ripping those headers
apart to move some of the content to include/linux/cxl so I'll go with 
#include "../cxl/cxlpci.h" (needed for the DVSEC ID).
#include "../cxl/pmu.h" (with stuff drivers/cxl doesn't need pushed into the cxl_pmu.c)
#include "../cxl/cxl.h" (For cxl_driver)

Similar to done in drivers/dax/cxl.c

> 
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index ff4e78117b31..0be514b00b8f 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -139,4 +139,17 @@ config CXL_REGION_INVALIDATION_TEST
> >  	  If unsure, or if this kernel is meant for production environments,
> >  	  say N.
> >  
> > +config CXL_CPMU
> > +	tristate "CXL Performance Monitoring Unit"
> > +	default CXL_BUS
> > +	depends on PERF_EVENTS
> > +	help
> > +	  Support performance monitoring as defined in CXL rev 3.0
> > +	  section 13.2: Performance Monitoring. CXL components may have
> > +	  one or more CXL Performance Monitoring Units (CPMUs).
> > +
> > +	  Say 'y/m' to enable a driver that will attach to performance
> > +	  monitoring units and provide standard perf based interfaces.
> > +
> > +	  If unsure say 'm'.
> >  endif  
> 
> ...and this wants to move to drivers/perf/Kconfig as well.
> 
> It's similar to "CONFIG_DEV_DAX_CXL" as an external to drivers/cxl/
> cxl-driver.
Ah. I'd failed to notice that. Good example.
> 
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index db321f48ba52..024bb739554b 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
> >  obj-$(CONFIG_CXL_PORT) += cxl_port.o
> > +obj-$(CONFIG_CXL_CPMU) += cpmu.o
> >  
> >  cxl_mem-y := mem.o
> >  cxl_pci-y := pci.o
> > diff --git a/drivers/cxl/cpmu.c b/drivers/cxl/cpmu.c
> > new file mode 100644
> > index 000000000000..e6821771a4f6
> > --- /dev/null
> > +++ b/drivers/cxl/cpmu.c
> > @@ -0,0 +1,940 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +/*
> > + * Copyright(c) 2023 Huawei
> > + *
> > + * The CXL 3.0 specification includes a standard Performance Monitoring Unit,
> > + * called the CXL PMU, or CPMU. In order to allow a high degree of
> > + * implementation flexibility the specification provides a wide range of
> > + * options all of which are self describing.
> > + *
> > + * Details in CXL rev 3.0 section 8.2.7 CPMU Register Interface
> > + *
> > + * TODO
> > + * o Discoverability of counters. Allow perftool to provide summed counters
> > + *   and vendor defined counters.
> > + * o Support free running counters - copy the Intel uncore PMU handling for these.
> > + * o CPMUs which do not support freeze.  
> 
> Wouldn't this be driven by the arrival of hardware? I.e. is there

It's a really ugly limitation on hardware that chooses not to implement freeze +
write when frozen as it will introduce a lot of skid across different counters.
Where I have influence I'll be pushing for no one to make that choice as it
reduces the usefulness of the PMU (how much depends on how fast / variable
the thing being counted is)  There is an intermediate dance where you can only
write when disabled and it is more functional but the code more complex than
we have here.

Fairly easy to implement (I think we must need to walk all the individual enable
registers) but this initial submission is big enough already so I'm not
keen to add that until a follow up patch set.

I'll make it a bit more explicit in the cover letter than I expect this
to be only the initial submission and call out what I expect to be supported
via future patch sets.
 
> > + * o Add filter validation in cpmu_event_init() so problems are detected earlier.
> > + * o Reject configurations that the hardware is ignoring
> > + *   (e.g. invert when not invertible)
> > + * o Support CPMUs with no interrupts using an HRTIMER.  
> 
> Is it worthwhile to maintain the TODO list in the code? I just fear this
> getting stale over time.

There is already some text covering the most important of these in the patch
description so I'll drop it from here.  Patch descriptions shouldn't ever
be stale (says the person who just deleted the garbage that was stale in
previous patch... :(

> > +/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
> > +#define CPMU_GID_CLOCK_TICKS		0x00
> > +#define CPMU_GID_D2H_REQ		0x0010
> > +#define CPMU_GID_D2H_RSP		0x0011
> > +#define CPMU_GID_H2D_REQ		0x0012
> > +#define CPMU_GID_H2D_RSP		0x0013
> > +#define CPMU_GID_CACHE_DATA		0x0014
> > +#define CPMU_GID_M2S_REQ		0x0020
> > +#define CPMU_GID_M2S_RWD		0x0021
> > +#define CPMU_GID_M2S_BIRSP		0x0022
> > +#define CPMU_GID_S2M_BISNP		0x0023
> > +#define CPMU_GID_S2M_NDR		0x0024
> > +#define CPMU_GID_S2M_DRS		0x0025
> > +#define CPMU_GID_DDR			0x8000  
> 
> Last note about the naming quibble, I notice that CPMU exists in other
> places in the kernel, but CXL_PMU does not, so there is a small
> grep'ability win as well.

You mean unlike CXL in drivers/misc/cxl  :)

I was going to leave these definitions alone, but fair enough I'll do these as well.
Anyone with a narrow terminal can blame you for the line wraps ;).


> > +
> > +#define CPMU_MAX_COUNTERS 64
> > +struct cpmu_info {
> > +	struct pmu pmu;
> > +	void __iomem *base;
> > +	struct perf_event **hw_events;
> > +	struct list_head events_configurable;
> > +	struct list_head events_fixed;  
> 
> Linked lists? Didn't xarray kill the linked list?

No. Kan raised similar in an earlier review and I couldn't come
up with a way that worked (for the configurable ones anyway)

How would you index these given they are defined by a full 64
bits made up of VID, GID and MASK + we need to match in some
cases by exact mask (for events_fixed) and sometimes as a subset
(for events_configurable)?  I see below you say we could make
this dependent on 64BIT to handle the fixed counters list but
that seems ugly to me.

There might be some magic data structure I'm unaware of we could
use but why bother? Expectation is these will have only a small
number of elements so a list is fine.

Looking at it again the naming is a bit misleading.  These aren't
generally individual events but instead the "event capabilities".
Let me rename them to make that clear. event_caps_configurable,
even_caps_fixed + rename the struct cxl_pmu_event to cxl_pmu_ev_cap

As such the absolute maximum length of the sum of those two lists is
32.  Most like they'll be a lot shorter than that.

> 
> > +	DECLARE_BITMAP(used_counter_bm, CPMU_MAX_COUNTERS);
> > +	DECLARE_BITMAP(conf_counter_bm, CPMU_MAX_COUNTERS);
> > +	u16 counter_width;
> > +	u8 num_counters;
> > +	u8 num_event_capabilities;
> > +	int on_cpu;
> > +	struct hlist_node node;
> > +	bool freeze_for_enable;
> > +	bool filter_hdm;
> > +	int irq;
> > +};
> > +
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
> > + */
> > +static int cpmu_parse_caps(struct device *dev, struct cpmu_info *info)
> > +{
> > +	DECLARE_BITMAP(fixed_counter_event_cap_bm, 32) = {0};  
> 
> An 'unsigned long' is always at least 32-bits, and:
> 
> unsigned long fixed_counter_event_cap_bm = 0;
> 
> ...would not have interrupted my reading of the code.

Hmm. I'm in two minds about this. Given we are accessing it with 
bitmap walking macros and hence this bitmap being replace by
an unsigned long (unlike the bigger ones) requires a bunch of
&fixed_counter_event_cap_bm  I think it is messier to change.

Don't feel that strongly though so made the change.

> 
> > +	void __iomem *base = info->base;
> > +	u64 val, eval;
> > +	int i;
> > +
> > +	val = readq(base + CPMU_CAP_REG);
> > +	info->freeze_for_enable = FIELD_GET(CPMU_CAP_WRITEABLE_WHEN_FROZEN, val) &
> > +		FIELD_GET(CPMU_CAP_FREEZE, val);  
> 
> Why does 'struct cpmu_info' need to carry the freeze_for_enable flag if
> its only used to gate loading the driver?
> 
> When / if support for "freeze_for_enable == false" arrives then I can
> see 'struct cpmu_info' having a need to cache it.

Ok. I'll drop it for now.

> 
> > +	if (!info->freeze_for_enable) {
> > +		dev_err(dev, "Driver does not support CPMUs that do not support freeze for enable\n");  
> 
> Perhaps just:
> 
> "Counters not writable while frozen."
> 
> ...will suffice, no need to mention what the driver supports, that's
> implied.

Ok. I think it looses some subtlety but I guess it's enough for anyone
who hasn't spent far too long discussing this flow on zoom calls.


...


> > +static struct cpmu_event *cpmu_find_fixed_counter_event(struct cpmu_info *info,
> > +							int vid, int gid, int msk)
> > +{
> > +	struct cpmu_event *cpmu_ev;
> > +
> > +	list_for_each_entry(cpmu_ev, &info->events_fixed, node) {
> > +		if (vid != cpmu_ev->vid || gid != cpmu_ev->gid)
> > +			continue;
> > +
> > +		/* Precise match for fixed counter */
> > +		if (msk == cpmu_ev->msk)
> > +			return cpmu_ev;  
> 
> It looks like the lookup parameters fit in 64-bits which if using an
> xarray could do a direct lookup (assuming this driver 'depends on 64BIT'
> which is not unreasonable).

We can't do that for the configurable counters because of the more complex
matching and I'd rather keep these looking similar.
Also as noted above these are short lists but the naming implied
they were a lot longer than in reality by suggesting they were lists
of individual events supported.

> 
> > +	}
> > +
> > +	return ERR_PTR(-EINVAL);
> > +}
> > +

> > +
> > +static void cpmu_event_start(struct perf_event *event, int flags)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	void __iomem *base = info->base;
> > +	u64 cfg;
> > +
> > +	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
> > +		return;
> > +
> > +	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));  
> 
> Maybe a comment about why these warns will likely never fire in practice?

Hmm. Good question (I cut and paste without thinking about these :)

start is only either called:
a) from cxl_pmu_event_add() where these flags are set directly
b) from a few places in kernel/events/core.c
   __perf_event_stop() (with restart set)
   perf_adjust_period().
      there pmu->stop() is called with PERF_EF_UPDATE and we set
      the flags in our callback.

   perf_adjust_freq_unthr_context()
      One path calls pmu->stop() as above.      
      One path perf_pmu_disable() has just been called.
       this is only path I can find that might leave these two flags not set
       but I am fairly sure we can't trigger it because (in common with most
       drivers in drivers/perf) we aren't counting interrupts as necessary to
       trigger this path.

If anyone more familiar with perf can confirm / correct my logic
it would be much appreciated.

For now I'll just add a comment that we should only reach here via
the stop call or with the state explicitly set and hence these flags should
be set appropriately.

...

> 
> > +	if (rc)
> > +		return rc;
> > +	info->irq = irq;
> > +
> > +	rc = cpuhp_state_add_instance(cpmu_cpuhp_state_num, &info->node);
> > +	if (rc)
> > +		return rc;
> > +
> > +	rc = perf_pmu_register(&info->pmu, info->pmu.name, -1);
> > +	if (rc)
> > +		return rc;
> > +
> > +	dev_set_drvdata(dev, info);  
> 
> Is it really the case that drvdata can be set after the pmu is already
> registered and live, or maybe just getting lucky with accessing the ABI
> after probe returns?

Lucky. Fixed.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void cxl_cpmu_remove(struct device *dev)
> > +{
> > +	struct cpmu_info *info = dev_get_drvdata(dev);
> > +
> > +	perf_pmu_unregister(&info->pmu);
> > +	cpuhp_state_remove_instance_nocalls(cpmu_cpuhp_state_num, &info->node);  
> 
> How about add devm_add_action_or_reset() calls for these and delete
> cxl_cpmu_remove()?

I agree. Though first time this gets done in a subsystem tends to be
'interesting'.  Guess I'll give it a go.

> 
> > +}
> > +
> > +static struct cxl_driver cxl_cpmu_driver = {
> > +	.name = "cxl_cpmu",
> > +	.probe = cxl_cpmu_probe,
> > +	.remove = cxl_cpmu_remove,
> > +	.id = CXL_DEVICE_CPMU,
> > +};
> > +
> > +static int cpmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
> > +
> > +	if (info->on_cpu != -1)
> > +		return 0;
> > +
> > +	info->on_cpu = cpu;
> > +	WARN_ON(irq_set_affinity(info->irq, cpumask_of(cpu)));  
> 

> Is this really a kernel crashable scenario for folks that have
> panic_on_warn() set? If it's a "should never" happen type situation then
> maybe a comment, otherwise pr_warn().

Will see if I can come up with a comment beyond "shouldn't happen" as
if a hotplug notifier says it's online it better still be online within
that notifier callback.

I think the key here is these are called with the cpuhp lock held and as
such there is no race and we shoul always be able to set the irq affinity
appropriately.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int cpmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> > +{
> > +	struct cpmu_info *info = hlist_entry_safe(node, struct cpmu_info, node);
> > +	unsigned int target;
> > +
> > +	if (info->on_cpu != cpu)
> > +		return 0;
> > +
> > +	info->on_cpu = -1;
> > +	target = cpumask_first(cpu_online_mask);

Bug noticed here whilst chasing down the comment for below. Should be cpumask_any_but()
as at time of calling the cpu that is going offline is still in the cpu_online_mask()

> > +	if (target >= nr_cpu_ids) {
> > +		dev_err(info->pmu.dev, "Unable to find a suitable CPU\n");
> > +		return 0;
> > +	}
> > +
> > +	perf_pmu_migrate_context(&info->pmu, cpu, target);
> > +	info->on_cpu = target;
> > +	WARN_ON(irq_set_affinity(info->irq, cpumask_of(target)));
> > +
> > +	return 0;
> > +}

...

> > 2.37.2
> >   
> 
> This looks good to me, I'd be happy to take it through the CXL tree when
> it finalizes with perf folks acks, just let me know.
> 
Thanks

Jonathan


