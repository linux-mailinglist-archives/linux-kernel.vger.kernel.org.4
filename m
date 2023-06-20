Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579AF736B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjFTLof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjFTLod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:44:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBC9D102;
        Tue, 20 Jun 2023 04:44:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3D741063;
        Tue, 20 Jun 2023 04:45:14 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD5E93F64C;
        Tue, 20 Jun 2023 04:44:29 -0700 (PDT)
Message-ID: <7a8c0ac8-4e5d-fd55-92bc-c42064d34a66@arm.com>
Date:   Tue, 20 Jun 2023 12:44:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/4] perf: arm_cspmu: Support implementation specific
 validation
Content-Language: en-GB
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230607083139.3498788-1-ilkka@os.amperecomputing.com>
 <20230607083139.3498788-4-ilkka@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230607083139.3498788-4-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 9:31 am, Ilkka Koskinen wrote:
> Some platforms may use e.g. different filtering mechanism and, thus,
> may need different way to validate the events and group.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   drivers/perf/arm_cspmu/arm_cspmu.c | 13 ++++++++++++-
>   drivers/perf/arm_cspmu/arm_cspmu.h |  4 ++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 72ca4f56347c..9021d1878250 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -559,7 +559,7 @@ static void arm_cspmu_disable(struct pmu *pmu)
>   static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>   				struct perf_event *event)
>   {
> -	int idx;
> +	int idx, ret;
>   	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>   
>   	if (supports_cycle_counter(cspmu)) {
> @@ -593,6 +593,12 @@ static int arm_cspmu_get_event_idx(struct arm_cspmu_hw_events *hw_events,
>   	if (idx >= cspmu->num_logical_ctrs)
>   		return -EAGAIN;
>   
> +	if (cspmu->impl.ops.validate_event) {
> +		ret = cspmu->impl.ops.validate_event(cspmu, event);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	set_bit(idx, hw_events->used_ctrs);
>   
>   	return idx;
> @@ -618,6 +624,7 @@ static bool arm_cspmu_validate_event(struct pmu *pmu,
>    */
>   static bool arm_cspmu_validate_group(struct perf_event *event)
>   {
> +	struct arm_cspmu *cspmu = to_arm_cspmu(event->pmu);
>   	struct perf_event *sibling, *leader = event->group_leader;
>   	struct arm_cspmu_hw_events fake_hw_events;
>   
> @@ -635,6 +642,10 @@ static bool arm_cspmu_validate_group(struct perf_event *event)
>   			return false;
>   	}
>   
> +	if (cspmu->impl.ops.validate_group &&
> +	    cspmu->impl.ops.validate_group(event))
> +		return false;

Hmm, this means that any driver wanting to use it has to duplicate all 
the group iteration logic, which isn't ideal. More than that, though, 
the way you've implemented it in patch #4 I'm not sure even does 
anything, since it only appears to be repeating the same checks that 
already happen in this path:

   arm_csmpu_validate_group()
     arm_cspmu_validate_event()
       arm_cspmu_get_event_idx()
         ops.validate_event() -> ampere_cspmu_validate_params()

so there's no need for the ops.validate_group hook to just call 
ampere_cspmu_validate_params() a second time when it's guaranteed to 
succeed (because otherwise we'd have bailed out already).

I think what we want overall is an "is this event config valid at all" 
hook from arm_cspmu_event_init() (which we don't really need to 
implement yet unless you want to start sanity-checking your actual 
rank/bank/threshold values), plus an "is this event schedulable in the 
given PMU context" hook from arm_cspmu_get_event_idx(), which should 
serve for both group validation via the fake context in event_init and 
actual scheduling in the real context in add.

Thanks,
Robin.

> +
>   	return arm_cspmu_validate_event(event->pmu, &fake_hw_events, event);
>   }
>   
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index f89ae2077164..291cedb196ea 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -106,6 +106,10 @@ struct arm_cspmu_impl_ops {
>   	void (*set_ev_filter)(struct arm_cspmu *cspmu,
>   			      struct hw_perf_event *hwc,
>   			      u32 filter);
> +	/* Implementation specific group validation */
> +	int (*validate_group)(struct perf_event *event);
> +	/* Implementation specific event validation */
> +	int (*validate_event)(struct arm_cspmu *cspmu, struct perf_event *new);
>   	/* Hide/show unsupported events */
>   	umode_t (*event_attr_is_visible)(struct kobject *kobj,
>   					 struct attribute *attr, int unused);
