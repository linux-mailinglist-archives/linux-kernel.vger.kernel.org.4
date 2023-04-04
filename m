Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD116D5CB0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjDDKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjDDKIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:08:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E5A910C7;
        Tue,  4 Apr 2023 03:08:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50100D75;
        Tue,  4 Apr 2023 03:09:29 -0700 (PDT)
Received: from [10.57.58.41] (unknown [10.57.58.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A0463F6C4;
        Tue,  4 Apr 2023 03:08:42 -0700 (PDT)
Message-ID: <3f8147b6-3362-c35b-3605-45e63cb2ddc6@arm.com>
Date:   Tue, 4 Apr 2023 11:08:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] perf: arm_cspmu: Separate Arm and vendor module
To:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
References: <20230403163905.20354-1-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230403163905.20354-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar


On 03/04/2023 17:39, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and vendor
> backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. Vendor module shall register to the main
> module on loading and trigger device reprobe.

Thanks for working on this.

> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
>   drivers/perf/arm_cspmu/Makefile       |   3 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c    | 113 +++++++++++++++++++++-----
>   drivers/perf/arm_cspmu/arm_cspmu.h    |  10 ++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.c |  24 +++++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ----
>   5 files changed, 124 insertions(+), 43 deletions(-)
>   delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
> 
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> index fedb17df982d..2514ad34aaf0 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -2,5 +2,4 @@
>   #
>   # SPDX-License-Identifier: GPL-2.0
>   
> -obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu.o nvidia_cspmu.o

Now that we have a mechanism to add the NVIDIA CSPMU driver, please 
could we make it a separate Kconfig ?

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index e31302ab7e37..6dbcd46d9fdf 100644
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
> @@ -25,13 +25,13 @@
>   #include <linux/ctype.h>
>   #include <linux/interrupt.h>
>   #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/list.h>
>   #include <linux/module.h>
>   #include <linux/perf_event.h>
>   #include <linux/platform_device.h>
>   #include <acpi/processor.h>
>   
>   #include "arm_cspmu.h"
> -#include "nvidia_cspmu.h"
>   
>   #define PMUNAME "arm_cspmu"
>   #define DRVNAME "arm-cs-arch-pmu"
> @@ -117,11 +117,14 @@
>    */
>   #define HILOHI_MAX_POLL	1000
>   
> -/* JEDEC-assigned JEP106 identification code */
> -#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> -
>   static unsigned long arm_cspmu_cpuhp_state;
>   
> +/* List of Coresight PMU instances in the system. */
> +static LIST_HEAD(cspmus);
> +
> +/* List of registered vendor backends. */
> +static LIST_HEAD(cspmu_impls);
> +
>   /*
>    * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
>    * counter register. The counter register can be implemented as 32-bit or 64-bit
> @@ -380,26 +383,94 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
>   };
>   
>   struct impl_match {
> -	u32 pmiidr;
> -	u32 mask;
> +	struct list_head next;
> +	u32 pmiidr_impl;

Do we need something more flexible here ? i.e.,

u32 pmiidr_val;
u32 pmiidr_mask;

So that, a single backend could support multiple/reduced
set of devices.


>   	int (*impl_init_ops)(struct arm_cspmu *cspmu); >   };
>   
> -static const struct impl_match impl_match[] = {
> -	{
> -	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> -	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> -	  .impl_init_ops = nv_cspmu_init_ops
> -	},
> -	{}
> -};
> +static struct impl_match *arm_cspmu_get_impl_match(u32 pmiidr_impl)
> +{
> +	struct impl_match *impl_match;
> +
> +	list_for_each_entry(impl_match, &cspmu_impls, next) {
> +		if (impl_match->pmiidr_impl == pmiidr_impl)

And this could be:
	((pmiidr_impl & impl_match->pmiidr_mask) == match->pmiidr_val)
> +			return impl_match;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int arm_cspmu_device_reprobe(u32 pmiidr_impl)
> +{
> +	int ret;
> +	struct arm_cspmu *cspmu, *temp;
> +
> +	/* Reprobe all arm_cspmu devices associated with implementer id. */
> +	list_for_each_entry_safe(cspmu, temp, &cspmus, next) {
> +		const u32 impl_id = FIELD_GET(ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +					cspmu->impl.pmiidr);
> +
> +		if (pmiidr_impl == impl_id) {
> +			ret = device_reprobe(cspmu->dev);
> +			if (ret) {
> +				dev_err(cspmu->dev, "Failed reprobe %s\n",
> +					cspmu->name);
> +				return ret;
> +			}

			break here  ?

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +int arm_cspmu_impl_register(u32 pmiidr_impl,
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu))
> +{
> +	struct impl_match *impl;
> +
> +	if (arm_cspmu_get_impl_match(pmiidr_impl)) {
> +		pr_err("ARM CSPMU implementer: 0x%x is already registered\n",
> +			pmiidr_impl);
> +		return -EEXIST;
> +	}
> +
> +	impl = kzalloc(sizeof(struct impl_match), GFP_KERNEL);
> +
> +	list_add(&impl->next, &cspmu_impls);

Don't we need a lock protect this one ?

> +
> +	impl->pmiidr_impl = pmiidr_impl;
> +	impl->impl_init_ops = impl_init_ops;

Would be good to do these steps before we actually add it to the
list. Anyways, the lock is still needed to prevent races.

> +
> +	return arm_cspmu_device_reprobe(pmiidr_impl);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
> +
> +void arm_cspmu_impl_unregister(u32 pmiidr_impl)
> +{
> +	struct impl_match *impl;
> +
> +	impl = arm_cspmu_get_impl_match(pmiidr_impl);
> +	if (!impl) {
> +		pr_err("Unable to find ARM CSPMU implementer: 0x%x\n",
> +			pmiidr_impl);
> +		return;
> +	}
> +
> +	list_del(&impl->next);
> +	kfree(impl);
> +
> +	if (arm_cspmu_device_reprobe(pmiidr_impl))
> +		pr_err("ARM CSPMU failed reprobe implementer: 0x%x\n",
> +			pmiidr_impl);

Is this for falling back to the generic driver ?

> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
>   
>   static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   {
>   	int ret;
>   	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
>   	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	const struct impl_match *match = impl_match;
> +	const struct impl_match *match;
>   
>   	/*
>   	 * Get PMU implementer and product id from APMT node.
> @@ -411,10 +482,11 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   				       readl(cspmu->base0 + PMIIDR);
>   
>   	/* Find implementer specific attribute ops. */
> -	for (; match->pmiidr; match++) {
> -		const u32 mask = match->mask;
> +	list_for_each_entry(match, &cspmu_impls, next) {
> +		const u32 impl_id = FIELD_GET(ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +						cspmu->impl.pmiidr);
>   
> -		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
> +		if (match->pmiidr_impl == impl_id) {

match = arm_cspmu_get_impl_match(); ?

>   			ret = match->impl_init_ops(cspmu);
>   			if (ret)
>   				return ret;
> @@ -924,6 +996,8 @@ static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
>   	if (!cspmu)
>   		return NULL;
>   
> +	list_add(&cspmu->next, &cspmus);
> +
>   	cspmu->dev = dev;
>   	cspmu->apmt_node = apmt_node;
>   
> @@ -1214,6 +1288,7 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
>   
>   	perf_pmu_unregister(&cspmu->pmu);
>   	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
> +	list_del(&cspmu->next);
>   
>   	return 0;
>   }
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..64c3b565f1b1 100644
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
> @@ -116,6 +116,7 @@ struct arm_cspmu_impl {
>   
>   /* Coresight PMU descriptor. */
>   struct arm_cspmu {
> +	struct list_head next;
>   	struct pmu pmu;
>   	struct device *dev;
>   	struct acpi_apmt_node *apmt_node;
> @@ -148,4 +149,11 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
>   				    struct device_attribute *attr,
>   				    char *buf);
>   
> +/* Register vendor backend. */
> +int arm_cspmu_impl_register(u32 pmiidr_impl,
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu));

May be pack it in the structure ?


Suzuki

> +
> +/* Unregister vendor backend. */
> +void arm_cspmu_impl_unregister(u32 pmiidr_impl);
> +
>   #endif /* __ARM_CSPMU_H__ */
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 72ef80caa3c8..d7083fed135d 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>    *
>    */
>   
> @@ -8,7 +8,10 @@
>   
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
> @@ -351,7 +354,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>   	return name;
>   }
>   
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   {
>   	u32 prodid;
>   	struct nv_cspmu_ctx *ctx;
> @@ -395,6 +398,19 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
> +
> +static int __init nvidia_cspmu_init(void)
> +{
> +	return arm_cspmu_impl_register(ARM_CSPMU_IMPL_ID_NVIDIA,
> +		nv_cspmu_init_ops);
> +}
> +
> +static void __exit nvidia_cspmu_exit(void)
> +{
> +	arm_cspmu_impl_unregister(ARM_CSPMU_IMPL_ID_NVIDIA);
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

