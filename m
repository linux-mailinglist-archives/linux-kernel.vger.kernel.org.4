Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3C7399E6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFVIfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjFVIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:34:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE4EA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:34:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmttx4TWNz6H8F1;
        Thu, 22 Jun 2023 16:33:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 09:34:51 +0100
Date:   Thu, 22 Jun 2023 09:34:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] perf: arm_cspmu: Support implementation specific
 validation
Message-ID: <20230622093450.00004ede@Huawei.com>
In-Reply-To: <20230622011141.328029-4-ilkka@os.amperecomputing.com>
References: <20230622011141.328029-1-ilkka@os.amperecomputing.com>
        <20230622011141.328029-4-ilkka@os.amperecomputing.com>
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

On Wed, 21 Jun 2023 18:11:40 -0700
Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:

> Some platforms may use e.g. different filtering mechanism and, thus,
> may need different way to validate the events and group.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
FWIW given it's so simple...
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/perf/arm_cspmu/arm_cspmu.c | 8 +++++++-
>  drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index fafd734c3218..471d6d7ac81a 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -553,7 +553,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
>  static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>  				struct perf_event *event)
>  {
> -	int idx;
> +	int idx, ret;
>  	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>  
>  	if (supports_cycle_counter(cspmu)) {
> @@ -587,6 +587,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>  	if (idx >= cspmu->num_logical_ctrs)
>  		return -EAGAIN;
>  
> +	if (cspmu->impl.ops.validate_event) {
> +		ret = cspmu->impl.ops.validate_event(cspmu, event);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	set_bit(idx, hw_events->used_ctrs);
>  
>  	return idx;
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index d6d88c246a23..5070d34c2285 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -104,6 +104,9 @@ struct arm_cspmu_impl_ops {
>  	/* Set event filter */
>  	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>  			      struct hw_perf_event *hwc, u32 filter);
> +	/* Implementation specific event validation */
> +	int (*validate_event)(struct arm_cspmu *cspmu,
> +			      struct perf_event *event);
>  	/* Hide/show unsupported events */
>  	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>  					 struct attribute *attr, int unused);

