Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89525739AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjFVIwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVIvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:51:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F35C1BDA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:51:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QmvDd1sKgz67K8h;
        Thu, 22 Jun 2023 16:49:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 09:51:44 +0100
Date:   Thu, 22 Jun 2023 09:51:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] perf: arm_cspmu: ampere_cspmu: Add support for
 Ampere SoC PMU
Message-ID: <20230622095143.0000009f@Huawei.com>
In-Reply-To: <20230622011141.328029-5-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
        <20230622011141.328029-5-ilkka@os.amperecomputing.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2023 18:11:41 -0700
Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:

> Ampere SoC PMU follows CoreSight PMU architecture. It uses implementation
> specific registers to filter events rather than PMEVFILTnR registers.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Hi Ilkka,

Drive by review so not super detailed (I was curious) but a few questions/comments inline.

Jonathan

> ---
>  .../admin-guide/perf/ampere_cspmu.rst         |  29 +++
>  drivers/perf/arm_cspmu/Makefile               |   2 +-
>  drivers/perf/arm_cspmu/ampere_cspmu.c         | 232 ++++++++++++++++++
>  drivers/perf/arm_cspmu/ampere_cspmu.h         |  17 ++
>  drivers/perf/arm_cspmu/arm_cspmu.c            |   7 +
>  5 files changed, 286 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/admin-guide/perf/ampere_cspmu.rst
>  create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.c
>  create mode 100644 drivers/perf/arm_cspmu/ampere_cspmu.h
> 
> diff --git a/Documentation/admin-guide/perf/ampere_cspmu.rst b/Documentation/admin-guide/perf/ampere_cspmu.rst
> new file mode 100644
> index 000000000000..bf86bffeef63
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/ampere_cspmu.rst
> @@ -0,0 +1,29 @@

> +
> +Example for perf tool use::
> +
> +  / # perf list ampere
> +
> +    ampere_mcu_pmu_0/act_sent/                         [Kernel PMU event]
> +    <...>
> +    ampere_mcu_pmu_1/rd_sent/                          [Kernel PMU event]
> +    <...>
> +
> +  / # perf stat -a -e ampere_mcu_pmu_0/act_sent,filter_enable=3,bank=5,rank=3,threshold=2/,ampere_mcu_pmu_1/rd_sent/ \
> +        sleep 1

Why filter_enable=3?



> +static u32 ampere_cspmu_event_filter(const struct perf_event *event)
> +{

Whilst lots of other comments on this - perhaps add another one here to
why this is a noop.

> +	return 0;
> +}
> +
> +static void ampere_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				       struct hw_perf_event *hwc,
> +				       u32 filter)
> +{
> +	struct perf_event *event;
> +	unsigned int idx;
> +	u32 threshold, rank, bank;
> +
> +	/*
> +	 * At this point, all the events have the same filter settings.
> +	 * Therefore, take the first event and use its configuration.
> +	 */
> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
> +			     cspmu->cycle_counter_logical_idx);
> +
> +	event = cspmu->hw_events.events[idx];
> +
> +	threshold	= get_threshold(event);
> +	rank		= get_rank(event);
> +	bank		= get_bank(event);
> +
> +	writel(threshold, cspmu->base0 + PMAUXR0);
> +	writel(rank, cspmu->base0 + PMAUXR1);
> +	writel(bank, cspmu->base0 + PMAUXR2);
> +}
> +
> +static int ampere_cspmu_validate_configs(struct perf_event *event,
> +					 struct perf_event *event2)
> +{
> +	if (get_threshold(event) != get_threshold(event2) ||
> +	    get_rank(event) != get_rank(event2) ||
> +	    get_bank(event) != get_bank(event2))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ampere_cspmu_validate_event(struct arm_cspmu *cspmu,
> +				       struct perf_event *new)
> +{
> +	struct perf_event *curr, *leader = new->group_leader;
> +	unsigned int idx;
> +	int ret;
> +
> +	ret = ampere_cspmu_validate_configs(new, leader);
> +	if (ret)
> +		return ret;
> +
> +	/* We compare the global filter settings to existing events */
> +	idx = find_first_bit(cspmu->hw_events.used_ctrs,
> +			     cspmu->cycle_counter_logical_idx);
> +
> +	/* This is the first event */

Maybe add why that matters to the comment?

> +	if (idx == cspmu->cycle_counter_logical_idx)
> +		return 0;
> +
> +	curr = cspmu->hw_events.events[idx];
> +
> +	return ampere_cspmu_validate_configs(curr, new);
> +}
> +
> +static char *ampere_cspmu_format_name(const struct arm_cspmu *cspmu,
> +				      const char *name_pattern)
> +{
> +	struct device *dev = cspmu->dev;
> +	static atomic_t pmu_generic_idx = {0};

Why not an ida?

If the pmu drivers ever become easy to unbind then you won't get ID
reusage like this an eventually you will run into overflow problems.

> +
> +	return devm_kasprintf(dev, GFP_KERNEL, name_pattern,
> +			      atomic_fetch_inc(&pmu_generic_idx));
> +}
> +
> +int ampere_cspmu_init_ops(struct arm_cspmu *cspmu)
> +{
> +	struct device *dev = cspmu->dev;
> +	struct ampere_cspmu_ctx *ctx;
> +	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> +
> +	ctx = devm_kzalloc(dev, sizeof(struct ampere_cspmu_ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->event_attr		= ampereone_mcu_pmu_event_attrs;
> +	ctx->format_attr	= ampereone_mcu_format_attrs;
> +	ctx->name		= ampere_cspmu_format_name(cspmu,
> +							   "ampere_mcu_pmu_%u");

Long line and need to break avoided if you don't bother trying to align the = signs...
Personally I don't like this style as it causes a lot of churn as drivers
evolve, but meh, it's up to you.

Given the result is confusing if the allocation fails (name not what is expected)
I would also check that allocation and error out if it fails.  Obviously it won't
under realistic circumstances, but a bit of paranoia never hurt anyone.

> +	cspmu->impl.ctx = ctx;
> +
> +	impl_ops->event_filter		= ampere_cspmu_event_filter;
> +	impl_ops->set_ev_filter		= ampere_cspmu_set_ev_filter;
> +	impl_ops->validate_event	= ampere_cspmu_validate_event;
> +	impl_ops->get_name		= ampere_cspmu_get_name;
> +	impl_ops->get_event_attrs	= ampere_cspmu_get_event_attrs;
> +	impl_ops->get_format_attrs	= ampere_cspmu_get_format_attrs;
> +
> +	return 0;
> +}
> +
> +MODULE_LICENSE("GPL v2");

...

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 471d6d7ac81a..587515eea0b4 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -29,6 +29,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/platform_device.h>
>  
> +#include "ampere_cspmu.h"

I'd be tempted to keep the generic header in a separate block then
follow with the vendor ones.  Not particularly important though.

>  #include "arm_cspmu.h"
>  #include "nvidia_cspmu.h"
>  
> @@ -114,6 +115,7 @@
>  
>  /* JEDEC-assigned JEP106 identification code */
>  #define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> +#define ARM_CSPMU_IMPL_ID_AMPERE		0xA16
>  
>  static unsigned long arm_cspmu_cpuhp_state;
>  
> @@ -388,6 +390,11 @@ static const struct impl_match impl_match[] = {
>  	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
>  	  .impl_init_ops = nv_cspmu_init_ops
>  	},
> +	{
> +	  .pmiidr = ARM_CSPMU_IMPL_ID_AMPERE,
> +	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +	  .impl_init_ops = ampere_cspmu_init_ops
> +	},
>  	{}
>  };
>  

