Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3512C6F05A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243735AbjD0MVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbjD0MVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:21:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A96B131;
        Thu, 27 Apr 2023 05:21:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CB3A2F4;
        Thu, 27 Apr 2023 05:21:49 -0700 (PDT)
Received: from [10.57.23.190] (unknown [10.57.23.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3F53F5A1;
        Thu, 27 Apr 2023 05:21:03 -0700 (PDT)
Message-ID: <61e4c2ba-7549-2766-8c94-9de4fc27ecbd@arm.com>
Date:   Thu, 27 Apr 2023 13:20:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf: arm_cspmu: Separate Arm and vendor module
Content-Language: en-GB
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
References: <20230418062030.45620-1-bwicaksono@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230418062030.45620-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-18 07:20, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and vendor
> backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. Vendor module shall register to the main
> module on loading and trigger device reprobe.

I think it might be considerably cleaner and safer if the main driver 
retained at least some knowledge of the PMIIDR matches and used those to 
explicity request the relevant module. Otherwise, not only is there an 
awful lot of fiddly complexity here, but there's also quite a burden on 
the user to know which modules they have to load to get full 
functionality on any given system.

FYI I've just started working on adding devicetree support, and I do 
need the generic architectural functionality to keep working in the 
absence of any imp-def backend.

Thanks,
Robin.

> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
> 
> Changes from v1:
>   * Added separate Kconfig entry for nvidia backend
>   * Added lock to protect accesses to the lists
>   * Added support for matching subset devices from a vendor
>   * Added state tracking to avoid reprobe when a device is in use
> v1: ttps://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u
> 
> ---
>   drivers/perf/arm_cspmu/Kconfig        |   9 +-
>   drivers/perf/arm_cspmu/Makefile       |   6 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c    | 280 +++++++++++++++++++++++---
>   drivers/perf/arm_cspmu/arm_cspmu.h    |  32 ++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.c |  39 +++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 --
>   6 files changed, 325 insertions(+), 58 deletions(-)
>   delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
> 
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> index 0b316fe69a45..8ce7b45a0075 100644
> --- a/drivers/perf/arm_cspmu/Kconfig
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>   
>   config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>   	tristate "ARM Coresight Architecture PMU"
> @@ -11,3 +11,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>   	  based on ARM CoreSight PMU architecture. Note that this PMU
>   	  architecture does not have relationship with the ARM CoreSight
>   	  Self-Hosted Tracing.
> +
> +config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	tristate "NVIDIA Coresight Architecture PMU"
> +	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	help
> +	  Provides NVIDIA specific attributes for performance monitoring unit
> +	  (PMU) devices based on ARM CoreSight PMU architecture.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index fedb17df982d..f8ae22411d59 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -1,6 +1,6 @@
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>   #
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu.o
> +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e31302ab7e37..c55ea2b74454 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -16,7 +16,7 @@
>    * The user should refer to the vendor technical documentation to get details
>    * about the supported events.
>    *
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
> @@ -25,13 +25,14 @@
>   #include <linux/ctype.h>
>   #include <linux/interrupt.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/list.h>
>   #include <linux/module.h>
> +#include <linux/mutex.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
>   #include <acpi/processor.h>
>   
>   #include "arm_cspmu.h"
> -#include "nvidia_cspmu.h"
>   
>   #define PMUNAME "arm_cspmu"
>   #define DRVNAME "arm-cs-arch-pmu"
> @@ -117,11 +118,52 @@
>    */
>   #define HILOHI_MAX_POLL	1000
>   
> -/* JEDEC-assigned JEP106 identification code */
> -#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> -
>   static unsigned long arm_cspmu_cpuhp_state;
>   
> +/* List of Coresight PMU instances in the system. */
> +static LIST_HEAD(arm_cspmus);
> +
> +/* List of registered vendor backends. */
> +static LIST_HEAD(arm_cspmu_impls);
> +
> +static DEFINE_MUTEX(arm_cspmu_lock);
> +
> +/*
> + * State of the generic driver.
> + * 0 => registering backend.
> + * 1 => ready to use.
> + * 2 or more => in use.
> + */
> +#define ARM_CSPMU_STATE_REG	0
> +#define ARM_CSPMU_STATE_READY	1
> +static atomic_t arm_cspmu_state;
> +
> +static void arm_cspmu_state_ready(void)
> +{
> +	atomic_set(&arm_cspmu_state, ARM_CSPMU_STATE_READY);
> +}
> +
> +static bool try_arm_cspmu_state_reg(void)
> +{
> +	const int old = ARM_CSPMU_STATE_READY;
> +	const int new = ARM_CSPMU_STATE_REG;
> +
> +	return atomic_cmpxchg(&arm_cspmu_state, old, new) == old;
> +}
> +
> +static bool try_arm_cspmu_state_get(void)
> +{
> +	return atomic_inc_not_zero(&arm_cspmu_state);
> +}
> +
> +static void arm_cspmu_state_put(void)
> +{
> +	int ret;
> +
> +	ret = atomic_dec_if_positive(&arm_cspmu_state);
> +	WARN_ON(ret < 0);
> +}
> +
>   /*
>    * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
>    * counter register. The counter register can be implemented as 32-bit or 64-bit
> @@ -380,26 +422,161 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
>   };
>   
>   struct impl_match {
> -	u32 pmiidr;
> -	u32 mask;
> -	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> +	struct list_head next;
> +	struct arm_cspmu_impl_param param;
>   };
>   
> -static const struct impl_match impl_match[] = {
> -	{
> -	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> -	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> -	  .impl_init_ops = nv_cspmu_init_ops
> -	},
> -	{}
> -};
> +static struct arm_cspmu_impl_param to_impl_param(const struct arm_cspmu *cspmu)
> +{
> +	struct arm_cspmu_impl_param ret = {0};
> +	u32 pmiidr = cspmu->impl.pmiidr;
> +
> +	ret.impl_id = FIELD_GET(ARM_CSPMU_PMIIDR_IMPLEMENTER, pmiidr);
> +	ret.pvr = FIELD_GET(ARM_CSPMU_PMIIDR_PVR, pmiidr);
> +	ret.pvr_mask = GENMASK(31, 0);
> +
> +	return ret;
> +}
> +
> +static bool impl_param_match(const struct arm_cspmu_impl_param *A,
> +			     const struct arm_cspmu_impl_param *B)
> +{
> +	/*
> +	 * Match criteria:
> +	 * - Implementer id should match.
> +	 * - A's device id is within B's range, or vice versa. This allows
> +	 *   vendor to register backend for a range of devices.
> +	 */
> +	if ((A->impl_id == B->impl_id) &&
> +	    (((A->pvr & A->pvr_mask) == (B->pvr & A->pvr_mask)) ||
> +	     ((A->pvr & B->pvr_mask) == (B->pvr & B->pvr_mask))))
> +		return true;
> +
> +	return false;
> +}
> +
> +static struct impl_match *impl_match_find(
> +	const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct impl_match *impl_match;
> +
> +	list_for_each_entry(impl_match, &arm_cspmu_impls, next) {
> +		if (impl_param_match(impl_param, &impl_match->param))
> +			return impl_match;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int arm_cspmu_impl_reprobe(
> +	const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct arm_cspmu *cspmu, *temp;
> +	LIST_HEAD(reprobe_list);
> +	int ret = 0;
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	/* Move the matching devices to temp list to avoid recursive lock. */
> +	list_for_each_entry_safe(cspmu, temp, &arm_cspmus, next) {
> +		struct arm_cspmu_impl_param match_param = to_impl_param(cspmu);
> +
> +		if (impl_param_match(impl_param, &match_param))
> +			list_move(&cspmu->next, &reprobe_list);
> +	}
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +
> +	/* Reprobe the devices. */
> +	list_for_each_entry_safe(cspmu, temp, &reprobe_list, next) {
> +		ret = device_reprobe(cspmu->dev);
> +		if (ret) {
> +			pr_err("arm_cspmu fail reprobe err: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct impl_match *match;
> +	int ret = 0;
> +
> +	if (!try_arm_cspmu_state_reg()) {
> +		pr_err("arm_cspmu reg failed, device(s) is in use\n");
> +		return -EBUSY;
> +	}
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	match = impl_match_find(impl_param);
> +	if (match) {
> +		pr_err("arm_cspmu reg failed, impl: 0x%x, pvr: 0x%x, pvr_mask: 0x%x already exists\n",
> +			match->param.impl_id, match->param.pvr,
> +			match->param.pvr_mask);
> +		mutex_unlock(&arm_cspmu_lock);
> +		arm_cspmu_state_ready();
> +		return -EINVAL;
> +	}
> +
> +	match = kzalloc(sizeof(struct impl_match), GFP_KERNEL);
> +	if (!match) {
> +		mutex_unlock(&arm_cspmu_lock);
> +		arm_cspmu_state_ready();
> +		return -ENOMEM;
> +	}
> +
> +	memcpy(&match->param, impl_param, sizeof(match->param));
> +	list_add(&match->next, &arm_cspmu_impls);
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +
> +	/* Replace generic backend with vendor implementation. */
> +	ret = arm_cspmu_impl_reprobe(impl_param);
> +
> +	if (ret)
> +		arm_cspmu_impl_unregister(impl_param);
> +
> +	arm_cspmu_state_ready();
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
> +
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct impl_match *match;
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	match = impl_match_find(impl_param);
> +	if (!match) {
> +		pr_err("arm_cspmu unreg failed, unable to find impl: 0x%x, pvr: 0x%x, pvr_mask: 0x%x\n",
> +			impl_param->impl_id, impl_param->pvr,
> +			impl_param->pvr_mask);
> +		mutex_unlock(&arm_cspmu_lock);
> +		return;
> +	}
> +
> +	list_del(&match->next);
> +	kfree(match);
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +
> +	/* Re-attach devices to standard driver. */
> +	arm_cspmu_impl_reprobe(impl_param);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
>   
>   static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   {
> -	int ret;
> +	int ret = 0;
>   	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
>   	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	const struct impl_match *match = impl_match;
> +	struct arm_cspmu_impl_param match_param = {0};
> +	const struct impl_match *match;
>   
>   	/*
>   	 * Get PMU implementer and product id from APMT node.
> @@ -410,19 +587,23 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   		(apmt_node->impl_id) ? apmt_node->impl_id :
>   				       readl(cspmu->base0 + PMIIDR);
>   
> -	/* Find implementer specific attribute ops. */
> -	for (; match->pmiidr; match++) {
> -		const u32 mask = match->mask;
> +	cspmu->impl.module = THIS_MODULE;
>   
> -		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
> -			ret = match->impl_init_ops(cspmu);
> -			if (ret)
> -				return ret;
> +	mutex_lock(&arm_cspmu_lock);
>   
> -			break;
> -		}
> +	/* Find implementer specific attribute ops. */
> +	match_param = to_impl_param(cspmu);
> +	match = impl_match_find(&match_param);
> +	if (match) {
> +		cspmu->impl.module = match->param.module;
> +		ret = match->param.impl_init_ops(cspmu);
>   	}
>   
> +	mutex_unlock(&arm_cspmu_lock);
> +
> +	if (ret)
> +		return ret;
> +
>   	/* Use default callbacks if implementer doesn't provide one. */
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_format_attrs);
> @@ -639,6 +820,11 @@ static int arm_cspmu_event_init(struct perf_event *event)
>   	struct arm_cspmu *cspmu;
>   	struct hw_perf_event *hwc = &event->hw;
>   
> +	if (!try_arm_cspmu_state_get()) {
> +		pr_err("arm_cspmu event_init fail: driver is reprobing\n");
> +		return -EBUSY;
> +	}
> +
>   	cspmu = to_arm_cspmu(event->pmu);
>   
>   	/*
> @@ -648,12 +834,14 @@ static int arm_cspmu_event_init(struct perf_event *event)
>   	if (is_sampling_event(event)) {
>   		dev_dbg(cspmu->pmu.dev,
>   			"Can't support sampling events\n");
> +		arm_cspmu_state_put();
>   		return -EOPNOTSUPP;
>   	}
>   
>   	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK) {
>   		dev_dbg(cspmu->pmu.dev,
>   			"Can't support per-task counters\n");
> +		arm_cspmu_state_put();
>   		return -EINVAL;
>   	}
>   
> @@ -664,16 +852,21 @@ static int arm_cspmu_event_init(struct perf_event *event)
>   	if (!cpumask_test_cpu(event->cpu, &cspmu->associated_cpus)) {
>   		dev_dbg(cspmu->pmu.dev,
>   			"Requested cpu is not associated with the PMU\n");
> +		arm_cspmu_state_put();
>   		return -EINVAL;
>   	}
>   
>   	/* Enforce the current active CPU to handle the events in this PMU. */
>   	event->cpu = cpumask_first(&cspmu->active_cpu);
> -	if (event->cpu >= nr_cpu_ids)
> +	if (event->cpu >= nr_cpu_ids) {
> +		arm_cspmu_state_put();
>   		return -EINVAL;
> +	}
>   
> -	if (!arm_cspmu_validate_group(event))
> +	if (!arm_cspmu_validate_group(event)) {
> +		arm_cspmu_state_put();
>   		return -EINVAL;
> +	}
>   
>   	/*
>   	 * The logical counter id is tracked with hw_perf_event.extra_reg.idx.
> @@ -686,6 +879,8 @@ static int arm_cspmu_event_init(struct perf_event *event)
>   	hwc->extra_reg.idx = -1;
>   	hwc->config = cspmu->impl.ops.event_type(event);
>   
> +	arm_cspmu_state_put();
> +
>   	return 0;
>   }
>   
> @@ -864,13 +1059,22 @@ static int arm_cspmu_add(struct perf_event *event, int flags)
>   	struct hw_perf_event *hwc = &event->hw;
>   	int idx;
>   
> +	if (!try_arm_cspmu_state_get()) {
> +		pr_err("arm_cspmu event_init fail: driver is reprobing\n");
> +		return -EBUSY;
> +	}
> +
>   	if (WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(),
> -					   &cspmu->associated_cpus)))
> +					   &cspmu->associated_cpus))) {
> +		arm_cspmu_state_put();
>   		return -ENOENT;
> +	}
>   
>   	idx = arm_cspmu_get_event_idx(hw_events, event);
> -	if (idx < 0)
> +	if (idx < 0) {
> +		arm_cspmu_state_put();
>   		return idx;
> +	}
>   
>   	hw_events->events[idx] = event;
>   	hwc->idx = to_phys_idx(cspmu, idx);
> @@ -900,6 +1104,8 @@ static void arm_cspmu_del(struct perf_event *event, int flags)
>   	clear_bit(idx, hw_events->used_ctrs);
>   
>   	perf_event_update_userpage(event);
> +
> +	arm_cspmu_state_put();
>   }
>   
>   static void arm_cspmu_read(struct perf_event *event)
> @@ -1154,7 +1360,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
>   
>   	cspmu->pmu = (struct pmu){
>   		.task_ctx_nr	= perf_invalid_context,
> -		.module		= THIS_MODULE,
> +		.module		= cspmu->impl.module,
>   		.pmu_enable	= arm_cspmu_enable,
>   		.pmu_disable	= arm_cspmu_disable,
>   		.event_init	= arm_cspmu_event_init,
> @@ -1205,6 +1411,10 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	mutex_lock(&arm_cspmu_lock);
> +	list_add(&cspmu->next, &arm_cspmus);
> +	mutex_unlock(&arm_cspmu_lock);
> +
>   	return 0;
>   }
>   
> @@ -1212,6 +1422,10 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
>   {
>   	struct arm_cspmu *cspmu = platform_get_drvdata(pdev);
>   
> +	mutex_lock(&arm_cspmu_lock);
> +	list_del(&cspmu->next);
> +	mutex_unlock(&arm_cspmu_lock);
> +
>   	perf_pmu_unregister(&cspmu->pmu);
>   	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
>   
> @@ -1281,6 +1495,8 @@ static int __init arm_cspmu_init(void)
>   {
>   	int ret;
>   
> +	arm_cspmu_state_ready();
> +
>   	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>   					"perf/arm/cspmu:online",
>   					arm_cspmu_cpu_online,
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..cf3458d9fc63 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.h
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0
>    *
>    * ARM CoreSight Architecture PMU driver.
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
> @@ -68,7 +68,10 @@
>   
>   /* PMIIDR register field */
>   #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define ARM_CSPMU_PMIIDR_REVISION	GENMASK(15, 12)
> +#define ARM_CSPMU_PMIIDR_VARIANT	GENMASK(19, 16)
>   #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
> +#define ARM_CSPMU_PMIIDR_PVR		GENMASK(31, 12)
>   
>   struct arm_cspmu;
>   
> @@ -107,15 +110,36 @@ struct arm_cspmu_impl_ops {
>   					 struct attribute *attr, int unused);
>   };
>   
> +/* Vendor/implementer registration parameter. */
> +struct arm_cspmu_impl_param {
> +	/* JEDEC assigned implementer id of the vendor. */
> +	u32 impl_id;
> +	/*
> +	 * The pvr value and mask describes the device ids covered by the
> +	 * vendor backend. pvr contains the pattern of acceptable product,
> +	 * variant, and revision bits from device's PMIIDR. pvr_mask contains
> +	 * the relevant bits when comparing pvr. 0 value on the mask means any
> +	 * pvr value is supported.
> +	 */
> +	u32 pvr;
> +	u32 pvr_mask;
> +	/* Backend module. */
> +	struct module *module;
> +	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> +};
> +
>   /* Vendor/implementer descriptor. */
>   struct arm_cspmu_impl {
>   	u32 pmiidr;
>   	struct arm_cspmu_impl_ops ops;
> +	struct module *module;
>   	void *ctx;
>   };
>   
>   /* Coresight PMU descriptor. */
>   struct arm_cspmu {
> +	struct list_head next;
>   	struct pmu pmu;
>   	struct device *dev;
>   	struct acpi_apmt_node *apmt_node;
> @@ -148,4 +172,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
>   				    struct device_attribute *attr,
>   				    char *buf);
>   
> +/* Register vendor backend. */
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param);
> +
> +/* Unregister vendor backend. */
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param);
> +
>   #endif /* __ARM_CSPMU_H__ */
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 72ef80caa3c8..c179849ca893 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -1,14 +1,18 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
>   /* Support for NVIDIA specific attributes. */
>   
> +#include <linux/module.h>
>   #include <linux/topology.h>
>   
> -#include "nvidia_cspmu.h"
> +#include "arm_cspmu.h"
> +
> +/* JEDEC-assigned JEP106 identification code */
> +#define ARM_CSPMU_IMPL_ID_NVIDIA     0x36B
>   
>   #define NV_PCIE_PORT_COUNT           10ULL
>   #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
> @@ -351,7 +355,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>   	return name;
>   }
>   
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   {
>   	u32 prodid;
>   	struct nv_cspmu_ctx *ctx;
> @@ -395,6 +399,33 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
> +
> +/* Match all NVIDIA Coresight PMU devices */
> +static const struct arm_cspmu_impl_param nv_cspmu_param = {
> +	.module		= THIS_MODULE,
> +	.impl_id	= ARM_CSPMU_IMPL_ID_NVIDIA,
> +	.pvr		= 0,
> +	.pvr_mask	= 0,
> +	.impl_init_ops	= nv_cspmu_init_ops
> +};
> +
> +static int __init nvidia_cspmu_init(void)
> +{
> +	int ret;
> +
> +	ret = arm_cspmu_impl_register(&nv_cspmu_param);
> +	if (ret)
> +		pr_err("nvidia_cspmu backend registration error: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void __exit nvidia_cspmu_exit(void)
> +{
> +	arm_cspmu_impl_unregister(&nv_cspmu_param);
> +}
> +
> +module_init(nvidia_cspmu_init);
> +module_exit(nvidia_cspmu_exit);
>   
>   MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
> deleted file mode 100644
> index 71e18f0dc50b..000000000000
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0
> - *
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> - *
> - */
> -
> -/* Support for NVIDIA specific attributes. */
> -
> -#ifndef __NVIDIA_CSPMU_H__
> -#define __NVIDIA_CSPMU_H__
> -
> -#include "arm_cspmu.h"
> -
> -/* Allocate NVIDIA descriptor. */
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
> -
> -#endif /* __NVIDIA_CSPMU_H__ */
> 
> base-commit: 73f2c2a7e1d2b31fdd5faa6dfa151c437a6c0a5a
> prerequisite-patch-id: fb691dc01d87597bcbaa4d352073304287c20f73
