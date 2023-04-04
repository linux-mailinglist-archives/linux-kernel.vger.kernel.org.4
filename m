Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ABB6D692F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjDDQst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDDQss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:48:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1D61A1;
        Tue,  4 Apr 2023 09:48:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PrYbc5y35z67T1b;
        Wed,  5 Apr 2023 00:47:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 4 Apr
 2023 17:48:42 +0100
Date:   Tue, 4 Apr 2023 17:48:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230404174841.000045a7@Huawei.com>
In-Reply-To: <bcae8e21-0afc-9fc6-7f90-07afca412223@linux.intel.com>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
        <20230330164556.31533-5-Jonathan.Cameron@huawei.com>
        <bcae8e21-0afc-9fc6-7f90-07afca412223@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Mon, 3 Apr 2023 13:32:06 -0400
"Liang, Kan" <kan.liang@linux.intel.com> wrote:

> On 2023-03-30 12:45 p.m., Jonathan Cameron wrote:
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
> 
> So the patch series is only tested with QEMU. Is there a real hardware
> which supports the CXL PMON?

In common with a lot of CXL stuff (and in general new standards based
architecture features), nothing that anyone is willing to talk about
except in general terms at this stage (this is a CXL 3.0 feature so
pretty recent).  Much of the existing kernel CXL support has been written
against emulation of one type or another (and we've shaken out a lot of
bugs that aren't yet seen with real hardware. Switches are very
rare for example - I've not yet registered PMUs for those, but that's
on the todo list after we get this merged). 

For this particular feature it's likely that initial devices will only
exercise some parts of the driver support. It's much easier to poke
the interesting corner cases with emulation given how extreme the
design space allowed by the CPMU specification is. To that end there
are a lot more features to add to this driver once we have a basic version
in place. One example is that we've had a request for fixed free running counter
support combined with vendor defined events as that's particularly useful
for debugging of new devices.

Note that there is still work to be done on the emulation to make it
easier to vary what is being emulated as right now I end up hacking it
to hit particular interesting cases and that's not going to be great
for CI testing this.

> 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 

> > +
> > +#define CPMU_ATTR_CONFIG_MASK_MSK	GENMASK_ULL(63, 48)  
> 
> (31, 0)?

Indeed. You'd have thought that having them right next
to the definition would have made that obvious when I messed
up the cut and paste. *sigh*

> 
> > +#define CPMU_ATTR_CONFIG_GID_MSK	GENMASK_ULL(47, 32)
> > +#define CPMU_ATTR_CONFIG_VID_MSK	GENMASK_ULL(63, 48)
> > +#define CPMU_ATTR_CONFIG1_THRESHOLD_MSK	GENMASK_ULL(15, 0)
> > +#define CPMU_ATTR_CONFIG1_INVERT_MSK	BIT(16)
> > +#define CPMU_ATTR_CONFIG1_EDGE_MSK	BIT(17)
> > +#define CPMU_ATTR_CONFIG1_FILTER_EN_MSK	BIT(18)
> > +#define CPMU_ATTR_CONFIG2_HDM_MSK	GENMASK(15, 0)

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
> > +	hwc->state = 0;
> > +
> > +	/*
> > +	 * Currently only hdm filter control is implemnted, this code will
> > +	 * want generalizing when more filters are added.
> > +	 */
> > +	if (info->filter_hdm) {
> > +		if (cpmu_config1_hdm_filter_en(event))
> > +			cfg = cpmu_config2_get_hdm_decoder(event);
> > +		else
> > +			cfg = GENMASK(15, 0); /* No filtering if 0xFFFF_FFFF */
> > +		writeq(cfg, base + CPMU_FILTER_CFG_REG(hwc->idx, 0));
> > +	}
> > +
> > +	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));  
> 
> I don't think we need the previous value. Just overwrite it.

Some bits are hwinit or RO.  Whilst we can probably get away with just writing
random garbage (zeros) to those bits, but I'd prefer to write their
value back to them.

> 
> 
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EDGE, cpmu_config1_get_edge(event) ? 1 : 0);
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_INVERT, cpmu_config1_get_invert(event) ? 1 : 0);
> > +
> > +	/* Fixed purpose counters have next two fields RO */
> > +	if (test_bit(hwc->idx, info->conf_counter_bm)) {
> > +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENT_GRP_ID_IDX_MSK, hwc->event_base);
> > +		cfg |= FIELD_PREP(CPMU_COUNTER_CFG_EVENTS_MSK, cpmu_config_get_mask(event));
> > +	}
> > +	cfg &= ~CPMU_COUNTER_CFG_THRESHOLD_MSK;
> > +	/*
> > +	 * For events that generate only 1 count per clock the CXL 3.0 spec
> > +	 * states the threshold shall be set to 1 but if set to 0 it will
> > +	 * count the raw value anwyay?
> > +	 * There is no definition of what events will count multiple per cycle
> > +	 * and hence to which non 1 values of threshold can apply.
> > +	 * (CXL 3.0 8.2.7.2.1 Counter Configuration - threshold field definition)
> > +	 */
> > +	cfg |= FIELD_PREP(CPMU_COUNTER_CFG_THRESHOLD_MSK,
> > +			  cpmu_config1_get_threshold(event));
> > +	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
> > +
> > +	local64_set(&hwc->prev_count, 0);
> > +	writeq(0, base + CPMU_COUNTER_REG(hwc->idx));  
> 
> The counter is reset twice. The other is in add()->cpmu_reset_counter().
> I think you can remove the one in add().

After some tracing I think you are correct. This seems to be always called immediately
after add anyway so no point in doing it twice.

> 
> > +
> > +	perf_event_update_userpage(event);
> > +}
> > +
...


> > +
> > +/*
> > + * Reset ensures no possibility of any information leaking to wrong
> > + * counter. Note that all fields written during start()
> > + */
> > +static void cpmu_reset_counter(struct cpmu_info *info, int idx)
> > +{
> > +	void __iomem *base = info->base;
> > +
> > +	/* Much of this register is read only */
> > +	writeq(0, base + CPMU_EVENT_CAP_REG(idx));  
> 
> 
> CPMU_COUNTER_CFG_REG?
> 
> I don't think we need to reset the config here, since it will be rewrite
> in cpmu_event_start().

You are correct.  The above write is clearly a noop as that's a read only register
and as you have observed cpmu_event_start() writes almost all the bits that
are not HWInit. I'll make it write the remaining one as well.

As above this whole function can then go away.



> 
> 
> > +	/* Filters are not per counter, so no reset here */
> > +	writeq(0, base + CPMU_COUNTER_REG(idx));
> > +}


> > +	info->pmu = (struct pmu) {
> > +		.name = dev_name(dev),
> > +		.parent = dev,  
> 
> I don't see the PMU parent is used anywhere.
> Please remove this and drop the Patch 2 from this series.

No.  As per the discussion of v4, without this the driver is incorrectly
resulting in the device being listed in /sys/devices rather than
/sys/bus/devices/pcie0000:0c/0000:0c:00.0/0000:0d:00.0/cpmu0/cpmu0

I do not want to introduce more ABI that will then need fixing up later.

This issue is common with a lot of other drivers hence the series
https://lore.kernel.org/all/20230404134225.13408-1-Jonathan.Cameron@huawei.com/
to correct it for all drivers that should have a simple parent set.

> 
> If there will be other followup patches, please add the PMU parent
> support there.
> 
> Thanks,
> Kan

Thanks again for looking at this so quickly.

Jonathan

