Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE56F8786
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEERY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEERY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:24:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4328EE6C;
        Fri,  5 May 2023 10:24:53 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36BF91FB;
        Fri,  5 May 2023 10:25:37 -0700 (PDT)
Received: from [10.57.81.246] (unknown [10.57.81.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 545163F5A1;
        Fri,  5 May 2023 10:24:49 -0700 (PDT)
Message-ID: <09b2a614-b7e5-d4e4-bcd4-bd1c22470821@arm.com>
Date:   Fri, 5 May 2023 18:24:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] perf: arm_cspmu: Separate Arm and vendor module
Content-Language: en-GB
To:     Besar Wicaksono <bwicaksono@nvidia.com>, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, vsethi@nvidia.com, rwiley@nvidia.com,
        efunsten@nvidia.com
References: <20230505005956.22837-1-bwicaksono@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230505005956.22837-1-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-05 01:59, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and vendor
> backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. Main driver maintains a list of backend module
> and will request it when probing the device.
> 
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> ---
> 
> Changes from v2:
>   * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
>     registration API definition to a separate module so main driver and vendor
>     module are independent.
>   * The registration API now just sets the impl_init_ops callback, no reprobe.
>   * Add PMIIDR table that maps to the vendor module name. During device probe,
>     main driver requests the vendor module if PMIIDR is matching.
>   * Keeping the name of the main driver module as arm_cspmu_module.
> Thanks to Robin and Suzuki for the feedback.
> v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-bwicaksono@nvidia.com/T/#u
> 
> Changes from v1:
>   * Added separate Kconfig entry for nvidia backend
>   * Added lock to protect accesses to the lists
>   * Added support for matching subset devices from a vendor
>   * Added state tracking to avoid reprobe when a device is in use
> Thanks to Suzuki for the feedback.
> v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u
> 
> ---
>   drivers/perf/arm_cspmu/Kconfig          |   9 +-
>   drivers/perf/arm_cspmu/Makefile         |   7 +-
>   drivers/perf/arm_cspmu/arm_cspmu.c      |  86 ++++++------------
>   drivers/perf/arm_cspmu/arm_cspmu.h      |  55 ++++++++++--
>   drivers/perf/arm_cspmu/arm_cspmu_impl.c | 114 ++++++++++++++++++++++++
>   drivers/perf/arm_cspmu/nvidia_cspmu.c   |  35 +++++++-
>   drivers/perf/arm_cspmu/nvidia_cspmu.h   |  17 ----
>   7 files changed, 235 insertions(+), 88 deletions(-)
>   create mode 100644 drivers/perf/arm_cspmu/arm_cspmu_impl.c
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
> index fedb17df982d..602ecb99dc57 100644
> --- a/drivers/perf/arm_cspmu/Makefile
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -1,6 +1,9 @@
> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
>   #
>   # SPDX-License-Identifier: GPL-2.0
>   
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_impl.o

Not sure what's up with this... I have no complaint with keeping the 
impl infrastucture together in its own source file, but it still wants 
to end up as part of arm_cspmu_module. Doing otherwise just adds 
unnecessary overhead at many levels and invites more problems.

>   obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
> +arm_cspmu_module-y := arm_cspmu.o
> +
> +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index a3f1c410b417..04c318744f55 100644
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
> @@ -31,7 +31,6 @@
>   #include <acpi/processor.h>
>   
>   #include "arm_cspmu.h"
> -#include "nvidia_cspmu.h"
>   
>   #define PMUNAME "arm_cspmu"
>   #define DRVNAME "arm-cs-arch-pmu"
> @@ -117,9 +116,6 @@
>    */
>   #define HILOHI_MAX_POLL	1000
>   
> -/* JEDEC-assigned JEP106 identification code */
> -#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
> -
>   static unsigned long arm_cspmu_cpuhp_state;
>   
>   /*
> @@ -186,16 +182,6 @@ static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
>   	return (counter_size(cspmu) > 32);
>   }
>   
> -ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	struct dev_ext_attribute *eattr =
> -		container_of(attr, struct dev_ext_attribute, attr);
> -	return sysfs_emit(buf, "event=0x%llx\n",
> -			  (unsigned long long)eattr->var);
> -}
> -EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
> -
>   /* Default event list. */
>   static struct attribute *arm_cspmu_event_attrs[] = {
>   	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> @@ -231,16 +217,6 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
>   	return attr->mode;
>   }
>   
> -ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> -{
> -	struct dev_ext_attribute *eattr =
> -		container_of(attr, struct dev_ext_attribute, attr);
> -	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> -}
> -EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
> -

Is there a reason for moving these (other than bodging around issues 
caused by the Makefile mishap above)?

(also, I'm now wondering why they're exported in the first place, since 
a backend module is hardly going to need to override the default 
implementations with the default implementations...)

>   static struct attribute *arm_cspmu_format_attrs[] = {
>   	ARM_CSPMU_FORMAT_EVENT_ATTR,
>   	ARM_CSPMU_FORMAT_FILTER_ATTR,
> @@ -379,27 +355,12 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
>   	.attrs = arm_cspmu_cpumask_attrs,
>   };
>   
> -struct impl_match {
> -	u32 pmiidr;
> -	u32 mask;
> -	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> -};
> -
> -static const struct impl_match impl_match[] = {
> -	{
> -	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
> -	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> -	  .impl_init_ops = nv_cspmu_init_ops
> -	},
> -	{}
> -};
> -
>   static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   {
> -	int ret;
> +	int ret = 0;
>   	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
>   	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	const struct impl_match *match = impl_match;
> +	const struct arm_cspmu_impl_module *match;
>   
>   	/*
>   	 * Get PMU implementer and product id from APMT node.
> @@ -411,18 +372,21 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
>   				       readl(cspmu->base0 + PMIIDR);
>   
>   	/* Find implementer specific attribute ops. */
> -	for (; match->pmiidr; match++) {
> -		const u32 mask = match->mask;
> -
> -		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
> -			ret = match->impl_init_ops(cspmu);
> -			if (ret)
> -				return ret;
> -
> -			break;
> +	match = arm_cspmu_impl_match_module(cspmu->impl.pmiidr);
> +	if (match) {
> +		request_module(match->name);

Are we confident this can't deadlock when it's already in the middle of 
loading the main module?

I'm mostly just paranoid thanks to my plentiful experience of 
inadvertently making driver probe routines crash, leaving some lock held 
in the module loader which typically ends up in having to hard-reset the 
machine :(

> +
> +		if (match->param.module && match->param.impl_init_ops) {

The module handles can be NULL if everything is built-in, so 
impl_init_ops is our only useful indicator here.

> +			if (try_module_get(match->param.module)) {
> +				cspmu->impl.module = match->param.module;
> +				ret = match->param.impl_init_ops(cspmu);
> +			}

As mentioned previously, I think it might be appropriate to warn that 
we're falling back to the generic implementation when we've failed to 
find the ops for a match we *do* know about.

>   		}
>   	}
>   
> +	if (ret)
> +		return ret;
> +
>   	/* Use default callbacks if implementer doesn't provide one. */
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
>   	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_format_attrs);
> @@ -484,11 +448,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
>   	struct attribute_group **attr_groups = NULL;
>   	struct device *dev = cspmu->dev;
>   	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
> -	int ret;
> -
> -	ret = arm_cspmu_init_impl_ops(cspmu);
> -	if (ret)
> -		return NULL;
>   
>   	cspmu->identifier = impl_ops->get_identifier(cspmu);
>   	cspmu->name = impl_ops->get_name(cspmu);
> @@ -1203,11 +1162,21 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	ret = arm_cspmu_init_impl_ops(cspmu);
> +	if (ret)
> +		goto module_put;
> +
>   	ret = arm_cspmu_register_pmu(cspmu);
>   	if (ret)
> -		return ret;
> +		goto module_put;
>   
>   	return 0;
> +
> +module_put:
> +	if (cspmu->impl.module)

No need to check, module_put(NULL) is valid.

> +		module_put(cspmu->impl.module);
> +
> +	return ret;
>   }
>   
>   static int arm_cspmu_device_remove(struct platform_device *pdev)
> @@ -1217,6 +1186,9 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
>   	perf_pmu_unregister(&cspmu->pmu);
>   	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
>   
> +	if (cspmu->impl.module)

Ditto.

> +		module_put(cspmu->impl.module);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
> index 51323b175a4a..0b60165f770a 100644
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
> @@ -68,8 +68,13 @@
>   
>   /* PMIIDR register field */
>   #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
> +#define ARM_CSPMU_PMIIDR_REVISION	GENMASK(15, 12)
> +#define ARM_CSPMU_PMIIDR_VARIANT	GENMASK(19, 16)
>   #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
>   
> +/* JEDEC-assigned JEP106 identification code */
> +#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
> +
>   struct arm_cspmu;
>   
>   /* This tracks the events assigned to each counter in the PMU. */
> @@ -107,10 +112,28 @@ struct arm_cspmu_impl_ops {
>   					 struct attribute *attr, int unused);
>   };
>   
> +/* Vendor/implementer registration parameter. */
> +struct arm_cspmu_impl_param {
> +	/* Backend module. */
> +	struct module *module;
> +	/* PMIIDR value/mask. */
> +	u32 pmiidr_val;
> +	u32 pmiidr_mask;
> +	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
> +	int (*impl_init_ops)(struct arm_cspmu *cspmu);
> +};
> +
> +/* Vendor/implementer module. */
> +struct arm_cspmu_impl_module {
> +	const char *name;
> +	struct arm_cspmu_impl_param param;
> +};

Nit: FWIW I'd just have a single flat structure and call it something 
like arm_cspmu_impl_match.

> +
>   /* Vendor/implementer descriptor. */
>   struct arm_cspmu_impl {
>   	u32 pmiidr;
>   	struct arm_cspmu_impl_ops ops;
> +	struct module *module;
>   	void *ctx;
>   };
>   
> @@ -139,13 +162,31 @@ struct arm_cspmu {
>   };
>   
>   /* Default function to show event attribute in sysfs. */
> -ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> -				   struct device_attribute *attr,
> -				   char *buf);
> +static inline ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "event=0x%llx\n",
> +			  (unsigned long long)eattr->var);
> +}
>   
>   /* Default function to show format attribute in sysfs. */
> -ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf);
> +static inline ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
> +}
> +
> +/* Register vendor backend. */
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param);
> +
> +/* Unregister vendor backend. */
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param);
> +
> +/* Get matching vendor module compatible with /p pmiidr. */
> +const struct arm_cspmu_impl_module *arm_cspmu_impl_match_module(u32 pmiidr);
>   
>   #endif /* __ARM_CSPMU_H__ */
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu_impl.c b/drivers/perf/arm_cspmu/arm_cspmu_impl.c
> new file mode 100644
> index 000000000000..35e0f4c2410a
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_cspmu_impl.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Implementation specific backend registration.
> + *
> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
> + *
> + */
> +
> +#include <linux/mutex.h>
> +
> +#include "arm_cspmu.h"
> +
> +static DEFINE_MUTEX(arm_cspmu_lock);
> +
> +static struct arm_cspmu_impl_module module_list[] = {
> +	{
> +		.name = "nvidia_cspmu",
> +		.param = {
> +			.pmiidr_val = ARM_CSPMU_IMPL_ID_NVIDIA,
> +			.pmiidr_mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
> +		},
> +	},
> +	{}
> +};
> +
> +static struct arm_cspmu_impl_module *arm_cspmu_impl_find_module(
> +	const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct arm_cspmu_impl_module *module;
> +
> +	for (module = module_list; module->name; module++) {
> +		if (!strcmp(module->name, impl_param->module->name) &&
> +		    module->param.pmiidr_val == impl_param->pmiidr_val &&
> +		    module->param.pmiidr_mask == impl_param->pmiidr_mask)
> +			return module;
> +	}
> +
> +	return NULL;
> +}

I don't think we want different logic for this - probe has to be able to 
get an unambiguous match from a PMIIDR value alone, therefore it must be 
sufficient for backend registration to do the same, e.g. 
arm_cspmu_impl_match_module(ARM_CSPMU_IMPL_ID_NVIDIA). Haveing different 
match conditions makes it all to easy to let subtle bugs in.

> +
> +const struct arm_cspmu_impl_module *arm_cspmu_impl_match_module(u32 pmiidr)
> +{
> +	struct arm_cspmu_impl_module *module;

Nit: just initialise to NULL...

> +	mutex_lock(&arm_cspmu_lock);
> +
> +	for (module = module_list; module->name; module++) {
> +		u32 mask = module->param.pmiidr_mask;
> +
> +		if ((module->param.pmiidr_val & mask) == (pmiidr & mask)) {

...and break here.

> +			mutex_unlock(&arm_cspmu_lock);
> +			return module;
> +		}
> +	}
> +
> +	mutex_unlock(&arm_cspmu_lock);

However, this locking doesn't work anyway - module_list and the 
pmiidr_{mask,val} values are static, so there is no need to protect the 
match lookup itself. The potential race which does exist is between 
arm_cspmu_impl_register() writing to module/impl_init_ops and 
arm_cspmu_init_impl_ops() reading them, which is not covered.

> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_match_module);
> +
> +int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param)

Ah, I see, this explains the structure split. I reckon it would be fine 
to either just pass the PMIIDR value, module handle and impl_init_ops as 
explicit arguments here, or a whole dummy match template with only those 
fields filled in.

> +{
> +	struct arm_cspmu_impl_module *module;
> +	int ret = 0;
> +
> +	if (!impl_param->module || !impl_param->impl_init_ops) {

Again, this module check prevents it from working with the whole driver 
+ backend built-in.

> +		pr_err("arm_cspmu reg failed, invalid module or init_ops\n");

If anything, probably just WARN_ON() impl_init_ops being NULL here, 
since that would mean the backend module is fundamentally broken. 
However it would effectvely already be covered if we had a more general 
user warning based on not finding the ops for a known match at probe, as 
suggested earlier. The corner case of loading a broken module and *not* 
trying to use it doesn't seem worth bothering about.

> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	module = arm_cspmu_impl_find_module(impl_param);
> +	if (module) {
> +		module->param.module = impl_param->module;
> +		module->param.impl_init_ops = impl_param->impl_init_ops;
> +	} else {

I do however think it might be worth also checking if a match is found 
but the ops are already set. That would mean our match table is broken 
and contains a non-unique PMIIDR match, which isn't going to be easily 
caught anywhere else, and the implications might be subtle and only show 
up for other users later.

> +		pr_err("arm_cspmu reg failed, unable to find pmiidr: 0x%x, mask: 0x%x, module: %s\n",
> +			impl_param->pmiidr_val,
> +			impl_param->pmiidr_mask,
> +			impl_param->module->name);
> +
> +		ret = -EINVAL;
> +	}
> +
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
> +
> +void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param)
> +{
> +	struct arm_cspmu_impl_module *module;
> +
> +	mutex_lock(&arm_cspmu_lock);
> +
> +	module = arm_cspmu_impl_find_module(impl_param);
> +	if (module) {

I think it's reasonable to have a usage model where unregister should 
only be called if register succeeded, and thus we can assume this lookup 
never fails. That certainly fits if the expectation is that 
register/unregister are tied to module_init/module_exit.

Thanks,
Robin.

> +		module->param.module = NULL;
> +		module->param.impl_init_ops = NULL;
> +	} else
> +		pr_err("arm_cspmu unreg failed, unable to find pmiidr: 0x%x, mask: 0x%x, module: %s\n",
> +			impl_param->pmiidr_val,
> +			impl_param->pmiidr_mask,
> +			impl_param->module->name);
> +
> +	mutex_unlock(&arm_cspmu_lock);
> +}
> +EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> index 72ef80caa3c8..7ac8f17de116 100644
> --- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
> +++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
> @@ -1,14 +1,15 @@
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
>   
>   #define NV_PCIE_PORT_COUNT           10ULL
>   #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
> @@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
>   	return name;
>   }
>   
> -int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
> +static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   {
>   	u32 prodid;
>   	struct nv_cspmu_ctx *ctx;
> @@ -395,6 +396,32 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
> +
> +/* Match all NVIDIA Coresight PMU devices */
> +static const struct arm_cspmu_impl_param nv_cspmu_param = {
> +	.module		= THIS_MODULE,
> +	.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
> +	.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
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
> base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
