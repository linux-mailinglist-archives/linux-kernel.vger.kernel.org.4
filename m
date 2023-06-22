Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5E7399DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjFVIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFVIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:33:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17410D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:33:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmtqg5lpkz6GD3t;
        Thu, 22 Jun 2023 16:30:55 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 09:33:39 +0100
Date:   Thu, 22 Jun 2023 09:33:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf: arm_cspmu: Support implementation specific
 filters
Message-ID: <20230622093338.0000420f@Huawei.com>
In-Reply-To: <20230622011141.328029-3-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
        <20230622011141.328029-3-ilkka@os.amperecomputing.com>
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

On Wed, 21 Jun 2023 18:11:39 -0700
Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:

> Generic filters aren't used in all the platforms. Instead, the platforms
> may use different means to filter events. Add support for implementation
> specific filters.

If the specification allows explicitly for non standard ways of controlling filters
it would be good to add a specification reference to this.

Otherwise one question inline.
> 
> Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
>  drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 0f517152cb4e..fafd734c3218 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -117,6 +117,9 @@
>  
>  static unsigned long arm_cspmu_cpuhp_state;
>  
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +				    struct hw_perf_event *hwc, u32 filter);
> +
>  static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
>  {
>  	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
> @@ -426,6 +429,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>  	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
>  	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
>  	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
> +	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
>  
>  	return 0;
>  }
> @@ -792,7 +796,7 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
>  	writel(hwc->config, cspmu->base0 + offset);
>  }
>  
> -static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
> +static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>  					   struct hw_perf_event *hwc,
>  					   u32 filter)
>  {
> @@ -826,7 +830,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
>  		arm_cspmu_set_cc_filter(cspmu, filter);
>  	} else {
>  		arm_cspmu_set_event(cspmu, hwc);
> -		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
> +		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);

Optional callback so don't you need either provide a default, or check
it isn't null?

>  	}
>  
>  	hwc->state = 0;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 83df53d1c132..d6d88c246a23 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -101,6 +101,9 @@ struct arm_cspmu_impl_ops {
>  	u32 (*event_type)(const struct perf_event *event);
>  	/* Decode filter value from configs */
>  	u32 (*event_filter)(const struct perf_event *event);
> +	/* Set event filter */
> +	void (*set_ev_filter)(struct arm_cspmu *cspmu,
> +			      struct hw_perf_event *hwc, u32 filter);
>  	/* Hide/show unsupported events */
>  	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>  					 struct attribute *attr, int unused);

