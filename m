Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCAB6E83CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 23:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjDSVcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 17:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjDSVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 17:32:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31FEB5FC0;
        Wed, 19 Apr 2023 14:32:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FD5C1424;
        Wed, 19 Apr 2023 14:32:45 -0700 (PDT)
Received: from [10.57.83.86] (unknown [10.57.83.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25DA43F587;
        Wed, 19 Apr 2023 14:32:00 -0700 (PDT)
Message-ID: <926a8f15-504e-c7a6-2686-c901f877a4dd@arm.com>
Date:   Wed, 19 Apr 2023 22:31:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2] perf: arm_cspmu: Separate Arm and vendor module
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
References: <20230418062030.45620-1-bwicaksono@nvidia.com>
 <122f0599-0ed4-6753-ef7a-5fed5c50fa1b@arm.com>
 <SJ0PR12MB5676B580F6EC210C53C4A9C3A09D9@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <SJ0PR12MB5676B580F6EC210C53C4A9C3A09D9@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 20:33, Besar Wicaksono wrote:
> Hi Suzuki,
> 
>> -----Original Message-----
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Sent: Tuesday, April 18, 2023 6:07 AM
>> To: Besar Wicaksono <bwicaksono@nvidia.com>; catalin.marinas@arm.com;
>> will@kernel.org; mark.rutland@arm.com
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
>> tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan
>> Hunter <jonathanh@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Richard
>> Wiley <rwiley@nvidia.com>; Eric Funsten <efunsten@nvidia.com>
>> Subject: Re: [PATCH v2] perf: arm_cspmu: Separate Arm and vendor module
>>
>> External email: Use caution opening links or attachments
>>
>>
>> On 18/04/2023 07:20, Besar Wicaksono wrote:
>>> Arm Coresight PMU driver consists of main standard code and vendor
>>> backend code. Both are currently built as a single module.
>>> This patch adds vendor registration API to separate the two to
>>> keep things modular. Vendor module shall register to the main
>>> module on loading and trigger device reprobe.
>>>
>>> Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
>>> ---
>>>
>>> Changes from v1:
>>>    * Added separate Kconfig entry for nvidia backend
>>>    * Added lock to protect accesses to the lists
>>>    * Added support for matching subset devices from a vendor
>>>    * Added state tracking to avoid reprobe when a device is in use
>>> v1: ttps://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-
>> bwicaksono@nvidia.com/T/#u
>>>
>>> ---
>>>    drivers/perf/arm_cspmu/Kconfig        |   9 +-
>>>    drivers/perf/arm_cspmu/Makefile       |   6 +-
>>>    drivers/perf/arm_cspmu/arm_cspmu.c    | 280
>> +++++++++++++++++++++++---
>>>    drivers/perf/arm_cspmu/arm_cspmu.h    |  32 ++-
>>>    drivers/perf/arm_cspmu/nvidia_cspmu.c |  39 +++-
>>>    drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 --
>>>    6 files changed, 325 insertions(+), 58 deletions(-)
>>>    delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
>>>
>>> diff --git a/drivers/perf/arm_cspmu/Kconfig
>> b/drivers/perf/arm_cspmu/Kconfig
>>> index 0b316fe69a45..8ce7b45a0075 100644
>>> --- a/drivers/perf/arm_cspmu/Kconfig
>>> +++ b/drivers/perf/arm_cspmu/Kconfig
>>> @@ -1,6 +1,6 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>>    #
>>> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>>
>>>    config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>>>        tristate "ARM Coresight Architecture PMU"
>>> @@ -11,3 +11,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>>>          based on ARM CoreSight PMU architecture. Note that this PMU
>>>          architecture does not have relationship with the ARM CoreSight
>>>          Self-Hosted Tracing.
>>> +
>>> +config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>>> +     tristate "NVIDIA Coresight Architecture PMU"
>>> +     depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>>> +     help
>>> +       Provides NVIDIA specific attributes for performance monitoring unit
>>> +       (PMU) devices based on ARM CoreSight PMU architecture.
>>> diff --git a/drivers/perf/arm_cspmu/Makefile
>> b/drivers/perf/arm_cspmu/Makefile
>>> index fedb17df982d..f8ae22411d59 100644
>>> --- a/drivers/perf/arm_cspmu/Makefile
>>> +++ b/drivers/perf/arm_cspmu/Makefile
>>> @@ -1,6 +1,6 @@
>>> -# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>> +# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>>    #
>>>    # SPDX-License-Identifier: GPL-2.0
>>>
>>> -obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=
>> arm_cspmu_module.o
>>> -arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
>>> +obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=
>> arm_cspmu.o
>>> +obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) +=
>> nvidia_cspmu.o
>>> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c
>> b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> index e31302ab7e37..c55ea2b74454 100644
>>> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
>>> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
>>> @@ -16,7 +16,7 @@
>>>     * The user should refer to the vendor technical documentation to get
>> details
>>>     * about the supported events.
>>>     *
>>> - * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>> + * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights
>> reserved.
>>>     *
>>>     */
>>>
>>> @@ -25,13 +25,14 @@
>>>    #include <linux/ctype.h>
>>>    #include <linux/interrupt.h>
>>>    #include <linux/io-64-nonatomic-lo-hi.h>
>>> +#include <linux/list.h>
>>>    #include <linux/module.h>
>>> +#include <linux/mutex.h>
>>>    #include <linux/perf_event.h>
>>>    #include <linux/platform_device.h>
>>>    #include <acpi/processor.h>
>>>
>>>    #include "arm_cspmu.h"
>>> -#include "nvidia_cspmu.h"
>>>
>>>    #define PMUNAME "arm_cspmu"
>>>    #define DRVNAME "arm-cs-arch-pmu"
>>> @@ -117,11 +118,52 @@
>>>     */
>>>    #define HILOHI_MAX_POLL     1000
>>>
>>> -/* JEDEC-assigned JEP106 identification code */
>>> -#define ARM_CSPMU_IMPL_ID_NVIDIA             0x36B
>>> -
>>>    static unsigned long arm_cspmu_cpuhp_state;
>>>
>>> +/* List of Coresight PMU instances in the system. */
>>> +static LIST_HEAD(arm_cspmus);
>>> +
>>> +/* List of registered vendor backends. */
>>> +static LIST_HEAD(arm_cspmu_impls);
>>> +
>>> +static DEFINE_MUTEX(arm_cspmu_lock);
>>> +
>>> +/*
>>> + * State of the generic driver.
>>> + * 0 => registering backend.
>>> + * 1 => ready to use.
>>> + * 2 or more => in use.
>>> + */
>>> +#define ARM_CSPMU_STATE_REG  0
>>> +#define ARM_CSPMU_STATE_READY        1
>>> +static atomic_t arm_cspmu_state;
>>> +
>>> +static void arm_cspmu_state_ready(void)
>>> +{
>>> +     atomic_set(&arm_cspmu_state, ARM_CSPMU_STATE_READY);
>>> +}
>>> +
>>> +static bool try_arm_cspmu_state_reg(void)
>>> +{
>>> +     const int old = ARM_CSPMU_STATE_READY;
>>> +     const int new = ARM_CSPMU_STATE_REG;
>>> +
>>> +     return atomic_cmpxchg(&arm_cspmu_state, old, new) == old;
>>> +}
>>> +
>>> +static bool try_arm_cspmu_state_get(void)
>>> +{
>>> +     return atomic_inc_not_zero(&arm_cspmu_state);
>>> +}
>>> +
>>> +static void arm_cspmu_state_put(void)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = atomic_dec_if_positive(&arm_cspmu_state);
>>> +     WARN_ON(ret < 0);
>>> +}
>>> +
>>
>> As long as the vendor module is set for the PMU instance, it won't be
>> unloaded as long as there are any perf events and thus the specific
>> driver cannot be unloaded. So, you don't need explicit refcount
>> maintenance for each pmu callbacks.
>>
> 
> The arm_cspmu_state mainly protects during new backend registration when
> the device is attached to standard implementation. All devices are attached to
> standard implementation initially when arm_cspmu module is loaded, since there
> is no backend yet. On backend registration, the standard impl is replaced by
> backend impl. However, the module unloading mechanism doesn't provide
> protection because standard impl is owned by arm_cspmu module, which
> is not unloaded during registration.
> 
> The refcount may not be required if the devices are not attached to standard
> Implementation by default, and the unreg doesn't fallback to it. But that makes
> the devices usable only when there is a vendor backend available.

Ok, thanks for the explanation. But I still think we :

  - Don't need a single global refcount for all the PMUs. Instead this
    could be per PMU instance (arm_cspmu), only when it is backed by
    "generic" backend, others get module refcount. If the refcount of
    "generic" PMU is positive, during the registration of a matching
    backend driver, we could simply mark that as pending reprobe.

  - And only do the refcount for the following call backs:

   pmu:: event_init -> hold the refcount
   pmu:: destroy -> drop the refcount and trigger a reprobe if one was
         pending (see above)

This would allow loading (unrelated) modules even when other PMUs are
active.

>>> +static bool impl_param_match(const struct arm_cspmu_impl_param *A,
>>> +                          const struct arm_cspmu_impl_param *B)
>>> +{
>>> +     /*
>>> +      * Match criteria:
>>> +      * - Implementer id should match.
>>> +      * - A's device id is within B's range, or vice versa. This allows
>>> +      *   vendor to register backend for a range of devices.
>>> +      */
>>> +     if ((A->impl_id == B->impl_id) &&
>>> +         (((A->pvr & A->pvr_mask) == (B->pvr & A->pvr_mask)) ||
>>> +          ((A->pvr & B->pvr_mask) == (B->pvr & B->pvr_mask))))
>>> +             return true;
>>> +
>>
>> nit: Please do not use CAPITAL letters for variable names. Could this
>> simply accept a pmiidr and a impl_match and match the fields with that
>> of the mask/value pair. See more below.
>>
> 
> The bitfield comparison in impl_param_match can be reused for different purposes:
> 1. Test between two mask/value pairs to check if device id ranges from
>       both pairs are intersecting. We use it during validation in (un)registration.
> 2. Along with to_impl_param, we can compare a pmiidr value with a
>       mask/value pair to check if a device is compatible with a backend. We use
>       it during reprobe and initializing impl_ops.

Ok.

Suzuki
