Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B305EF078
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiI2I3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiI2I32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:29:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDBA813EAF8;
        Thu, 29 Sep 2022 01:29:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607DA1A9A;
        Thu, 29 Sep 2022 01:29:32 -0700 (PDT)
Received: from [10.57.66.102] (unknown [10.57.66.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CFBC3F73D;
        Thu, 29 Sep 2022 01:29:23 -0700 (PDT)
Message-ID: <f67bf3b6-c8ba-4134-5772-ce750f4bb4dd@arm.com>
Date:   Thu, 29 Sep 2022 09:29:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
To:     Besar Wicaksono <bwicaksono@nvidia.com>, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sudeep.holla@arm.com,
        thanu.rangarajan@arm.com, Michael.Williams@arm.com,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
 <20220928201830.45637-2-bwicaksono@nvidia.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20220928201830.45637-2-bwicaksono@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar

On 28/09/2022 21:18, Besar Wicaksono wrote:
> Add support for ARM CoreSight PMU driver framework and interfaces.
> The driver provides generic implementation to operate uncore PMU based
> on ARM CoreSight PMU architecture. The driver also provides interface
> to get vendor/implementation specific information, for example event
> attributes and formating.
> 
> The specification used in this implementation can be found below:
>   * ACPI Arm Performance Monitoring Unit table:
>          https://developer.arm.com/documentation/den0117/latest
>   * ARM Coresight PMU architecture:
>          https://developer.arm.com/documentation/ihi0091/latest
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>

Apologies for this late comment. Please find it below.

> ---
>   arch/arm64/configs/defconfig       |    1 +
>   drivers/perf/Kconfig               |    2 +
>   drivers/perf/Makefile              |    1 +
>   drivers/perf/arm_cspmu/Kconfig     |   13 +
>   drivers/perf/arm_cspmu/Makefile    |    6 +
>   drivers/perf/arm_cspmu/arm_cspmu.c | 1276 ++++++++++++++++++++++++++++
>   drivers/perf/arm_cspmu/arm_cspmu.h |  151 ++++
>   7 files changed, 1450 insertions(+)
>   create mode 100644 drivers/perf/arm_cspmu/Kconfig
>   create mode 100644 drivers/perf/arm_cspmu/Makefile
>   create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
>   create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7d1105343bc2..ee31c9159a5b 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1212,6 +1212,7 @@ CONFIG_PHY_UNIPHIER_USB3=y
>   CONFIG_PHY_TEGRA_XUSB=y
>   CONFIG_PHY_AM654_SERDES=m
>   CONFIG_PHY_J721E_WIZ=m
> +CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=y
>   CONFIG_ARM_SMMU_V3_PMU=m
>   CONFIG_FSL_IMX8_DDR_PMU=m
>   CONFIG_QCOM_L2_PMU=y
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 1e2d69453771..c94d3601eb48 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -192,4 +192,6 @@ config MARVELL_CN10K_DDR_PMU
>   	  Enable perf support for Marvell DDR Performance monitoring
>   	  event on CN10K platform.
>   
> +source "drivers/perf/arm_cspmu/Kconfig"
> +
>   endmenu
> diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
> index 57a279c61df5..3bc9323f0965 100644
> --- a/drivers/perf/Makefile
> +++ b/drivers/perf/Makefile
> @@ -20,3 +20,4 @@ obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
>   obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
>   obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
> diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
> new file mode 100644
> index 000000000000..c2c56ecafccb
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +
> +config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
> +	tristate "ARM Coresight Architecture PMU"
> +	depends on ACPI
> +	depends on ACPI_APMT || COMPILE_TEST
> +	help
> +	  Provides support for performance monitoring unit (PMU) devices
> +	  based on ARM CoreSight PMU architecture. Note that this PMU
> +	  architecture does not have relationship with the ARM CoreSight
> +	  Self-Hosted Tracing.
> diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
> new file mode 100644
> index 000000000000..cdc3455f74d8
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/Makefile
> @@ -0,0 +1,6 @@
> +# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
> +#
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += \
> +	arm_cspmu.o
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> new file mode 100644
> index 000000000000..0fa5f29bf1c6
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -0,0 +1,1276 @@


> +/* Default event list. */
> +static struct attribute *arm_cspmu_event_attrs[] = {
> +	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
> +	NULL,
> +};
> +
> +static struct attribute **
> +arm_cspmu_get_event_attrs(const struct arm_cspmu *cspmu)
> +{
> +	return arm_cspmu_event_attrs;
> +}

This would make all the "PMU" instances (which don't implement the
callback) share a non-const array. Could we instead return a copy of
the attrs to avoid drivers messing up with the array ?
The array could be allocated via devm_ on the specific device, thus
it gets cleaned up on the device tear down ?

...

> +static struct attribute **
> +arm_cspmu_get_format_attrs(const struct arm_cspmu *cspmu)
> +{
> +	return arm_cspmu_format_attrs;
> +}
> +

Same as above

Suzuki
