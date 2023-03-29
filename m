Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145036CDA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjC2NLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjC2NLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:11:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7949E8;
        Wed, 29 Mar 2023 06:11:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pmn2F6NPsz6J79f;
        Wed, 29 Mar 2023 21:09:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 29 Mar
 2023 14:11:03 +0100
Date:   Wed, 29 Mar 2023 14:11:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
CC:     <linux-cxl@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <will@kernel.org>, <dan.j.williams@intel.com>,
        <linuxarm@huawei.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 4/5] cxl: CXL Performance Monitoring Unit driver
Message-ID: <20230329141102.000079a1@Huawei.com>
In-Reply-To: <4f3c101b-415c-bbe5-e99e-f775236b624f@linux.intel.com>
References: <20230324171313.18448-1-Jonathan.Cameron@huawei.com>
        <20230324171313.18448-5-Jonathan.Cameron@huawei.com>
        <4f3c101b-415c-bbe5-e99e-f775236b624f@linux.intel.com>
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


Hi Kan,

Thanks for another quick review.

A few comments on how I responded to feedback inline, but in short
I accepted all of it and made the obvious changes.

> > +static u16 cpmu_config_get_vid(struct perf_event *event)
> > +{
> > +	return FIELD_GET(GENMASK_ULL(63, 48), event->attr.config);
> > +}
> > +  
> 
> There should be at least two places which use GENMASK_ULL(63, 48), and
> also git, mask. It's better to replace them by macros.
> 
> Ideally, we can use macros to replace all these magic numbers for the
> format and define the macros close to cpmu_format_attr[]?
> In case, we will change the bits for a format later. We will not miss
> any places.
> 

Good idea and lo and behold one of them was mismatched.
(Filter enable was described as bit 18 of config1 but bit 14 was read).

...


> > +static const struct attribute_group *cpmu_attr_groups[] = {
> > +	&cpmu_events,
> > +	&cpmu_format_group,
> > +	&cpmu_cpumask_group,
> > +	NULL
> > +};
> > +
> > +/* If counter_idx == NULL, don't try to allocate a counter. */
> > +static int cpmu_get_event_idx(struct perf_event *event, int *counter_idx, int *event_idx)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +	DECLARE_BITMAP(configurable_and_free, CPMU_MAX_COUNTERS);
> > +	struct cpmu_event *cpmu_ev;
> > +	u32 mask;
> > +	u16 gid, vid;
> > +	int i;
> > +
> > +	vid = cpmu_config_get_vid(event);
> > +	gid = cpmu_config_get_gid(event);
> > +	mask = cpmu_config_get_mask(event);
> > +
> > +	cpmu_ev = cpmu_find_fixed_counter_event(info, vid, gid, mask);
> > +	if (!IS_ERR(cpmu_ev)) {
> > +		if (!counter_idx)
> > +			return 0;
> > +		if (!info->hw_events[cpmu_ev->counter_idx]) {  
> 
> Use info->used_counter_bm?

I guess that's more obviously similar with the handling below and possibly
a small performance saving, so sure.

> 
> > +			*counter_idx = cpmu_ev->counter_idx;
> > +			return 0;
> > +		}
> > +		/* Fixed counter is in use, but maybe a configurable one? */
> > +	}
> > +
> > +	cpmu_ev = cpmu_find_config_counter_event(info, vid, gid, mask);
> > +	if (!IS_ERR(cpmu_ev)) {
> > +		if (!counter_idx)
> > +			return 0;
> > +
> > +		bitmap_andnot(configurable_and_free, info->conf_counter_bm,
> > +			info->used_counter_bm, CPMU_MAX_COUNTERS);
> > +
> > +		i = find_first_bit(configurable_and_free, CPMU_MAX_COUNTERS);
> > +		if (i == CPMU_MAX_COUNTERS)
> > +			return -EINVAL;
> > +
> > +		*counter_idx = i;
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +

...


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
> > +	 * Currently only hdm filter control is implemnted, this code will
> > +	 * want generalizing when more filters are added.
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
> > +
> > +	if (flags & PERF_EF_RELOAD) {
> > +		prev_cnt = local64_read(&hwc->prev_count);
> > +		writeq(prev_cnt, base + CPMU_COUNTER_REG(hwc->idx));
> > +	}  
> 
> The hwc->prev_count is already unconditionally set to 0.

Good spot.  This driver has been evolving for too long so I'm missing
silly thing like this. I'll drop the PERF_EF_RELOAD handling as
it doesn't do anything useful and it seems to be a bit random
if uncore drivers have support or not.

> 
> > +
> > +	perf_event_update_userpage(event);
> > +}
...

> > +static void cpmu_event_stop(struct perf_event *event, int flags)
> > +{
> > +	struct cpmu_info *info = pmu_to_cpmu_info(event->pmu);
> > +	void __iomem *base = info->base;
> > +	struct hw_perf_event *hwc = &event->hw;
> > +	u64 cfg;
> > +
> > +	cpmu_read(event);
> > +	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
> > +	hwc->state |= PERF_HES_STOPPED;
> > +
> > +	cfg = readq(base + CPMU_COUNTER_CFG_REG(hwc->idx));
> > +	cfg &= ~(FIELD_PREP(CPMU_COUNTER_CFG_INT_ON_OVRFLW, 1) |
> > +		 FIELD_PREP(CPMU_COUNTER_CFG_ENABLE, 1));
> > +	writeq(cfg, base + CPMU_COUNTER_CFG_REG(hwc->idx));
> > +
> > +	if (hwc->state & PERF_HES_UPTODATE)
> > +		return;  
> 
> The PERF_HES_UPTODATE is used to update the event count if there is a
> request and the !(hwc->state & PERF_HES_UPTODATE). It can avoid a read
> if no PERF_HES_UPTODATE is requested.
> Since the read is invoked unconditionally above, I guess you don't need
> the check.

Dropped.  Even looking very locally we set the bit on the next line anyway
and setting an already set bit is harmless.

> 
> Thanks,
> Kan


