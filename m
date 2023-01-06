Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701965FEB3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 11:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjAFKXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 05:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjAFKXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 05:23:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C21D69B2C;
        Fri,  6 Jan 2023 02:23:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB7511FB;
        Fri,  6 Jan 2023 02:24:03 -0800 (PST)
Received: from [10.57.44.230] (unknown [10.57.44.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99DD3F23F;
        Fri,  6 Jan 2023 02:23:19 -0800 (PST)
Message-ID: <8362ba75-db80-e427-b610-988f92c961a8@arm.com>
Date:   Fri, 6 Jan 2023 10:23:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V7 0/6] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230105031039.207972-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2023 03:10, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 

Hi Anshuman,

The missing cc for linux-perf-users@vger.kernel.org on the other patches
means that this looks incomplete on the lore page for linux-perf-users.
b4 still picks up the full set, so it's probably fine. But it might be
worth adding the same cc for all patches next time.

Thanks
James

> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v6.2-r2.
> 
> Changes in V7:
> 
> - Folded [PATCH 7/7] into [PATCH 3/7] which enables branch stack sampling event
> - Defined BRBFCR_EL1_BRANCH_FILTERS, BRBCR_EL1_DEFAULT_CONFIG in the header
> - Defined BRBFCR_EL1_DEFAULT_CONFIG in the header
> - Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_FZP
> - Defined BRBCR_EL1_DEFAULT_TS in the header
> - Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_DEFAULT_TS
> - Moved BRBCR_EL1_DEFAULT_CONFIG check inside branch_type_to_brbcr()
> - Moved down BRBCR_EL1_CC, BRBCR_EL1_MPRED later in branch_type_to_brbcr()
> - Also set BRBE in paused state in armv8pmu_branch_disable()
> - Dropped brbe_paused(), set_brbe_paused() helpers
> - Extracted error string via branch_filter_error_msg[] for armv8pmu_branch_valid()
> - Replaced brbe_v1p1 with brbe_version in struct brbe_hw_attr
> - Added valid_brbe_[cc, format, version]() helpers
> - Split a separate brbe_attributes_probe() from armv8pmu_branch_probe()
> - Capture event->attr.branch_sample_type earlier in armv8pmu_branch_valid()
> - Defined enum brbe_bank_idx with possible values for BRBE bank indices
> - Changed armpmu->hw_attr into armpmu->private
> - Added missing space in stub definition for armv8pmu_branch_valid()
> - Replaced both kmalloc() with kzalloc()
> - Added BRBE_BANK_MAX_ENTRIES
> - Updated comment for capture_brbe_flags()
> - Updated comment for struct brbe_hw_attr
> - Dropped space after type cast in couple of places
> - Replaced inverse with negation for testing BRBCR_EL1_FZP in armv8pmu_branch_read()
> - Captured cpuc->branches->branch_entries[idx] in a local variable
> - Dropped saved_priv from armv8pmu_branch_read()
> - Reorganize PERF_SAMPLE_BRANCH_NO_[CYCLES|NO_FLAGS] related configuration
> - Replaced with FIELD_GET() and FIELD_PREP() wherever applicable
> - Replaced BRBCR_EL1_TS_PHYSICAL with BRBCR_EL1_TS_VIRTUAL
> - Moved valid_brbe_nr(), valid_brbe_cc(), valid_brbe_format(), valid_brbe_version()
>   select_brbe_bank(), select_brbe_bank_index() helpers inside the C implementation
> - Reorganized brbe_valid_nr() and dropped the pr_warn() message
> - Changed probe sequence in brbe_attributes_probe()
> - Added 'brbcr' argument into capture_brbe_flags() to ascertain correct state
> - Disable BRBE before disabling the PMU event counter
> - Enable PERF_SAMPLE_BRANCH_HV filters when is_kernel_in_hyp_mode()
> - Guard armv8pmu_reset() & armv8pmu_sched_task() with arm_pmu_branch_stack_supported()
> 
> Changes in V6:
> 
> https://lore.kernel.org/linux-arm-kernel/20221208084402.863310-1-anshuman.khandual@arm.com/
> 
> - Restore the exception level privilege after reading the branch records
> - Unpause the buffer after reading the branch records
> - Decouple BRBCR_EL1_EXCEPTION/ERTN from perf event privilege level
> - Reworked BRBE implementation and branch stack sampling support on arm pmu
> - BRBE implementation is now part of overall ARMV8 PMU implementation
> - BRBE implementation moved from drivers/perf/ to inside arch/arm64/kernel/
> - CONFIG_ARM_BRBE_PMU renamed as CONFIG_ARM64_BRBE in arch/arm64/Kconfig
> - File moved - drivers/perf/arm_pmu_brbe.c -> arch/arm64/kernel/brbe.c
> - File moved - drivers/perf/arm_pmu_brbe.h -> arch/arm64/kernel/brbe.h
> - BRBE name has been dropped from struct arm_pmu and struct hw_pmu_events
> - BRBE name has been abstracted out as 'branches' in arm_pmu and hw_pmu_events
> - BRBE name has been abstracted out as 'branches' in ARMV8 PMU implementation
> - Added sched_task() callback into struct arm_pmu
> - Added 'hw_attr' into struct arm_pmu encapsulating possible PMU HW attributes
> - Dropped explicit attributes brbe_(v1p1, nr, cc, format) from struct arm_pmu
> - Dropped brbfcr, brbcr, registers scratch area from struct hw_pmu_events
> - Dropped brbe_users, brbe_context tracking in struct hw_pmu_events
> - Added 'features' tracking into struct arm_pmu with ARM_PMU_BRANCH_STACK flag
> - armpmu->hw_attr maps into 'struct brbe_hw_attr' inside BRBE implementation
> - Set ARM_PMU_BRANCH_STACK in 'arm_pmu->features' after successful BRBE probe
> - Added armv8pmu_branch_reset() inside armv8pmu_branch_enable()
> - Dropped brbe_supported() as events will be rejected via ARM_PMU_BRANCH_STACK
> - Dropped set_brbe_disabled() as well
> - Reformated armv8pmu_branch_valid() warnings while rejecting unsupported events
> 
> Changes in V5:
> 
> https://lore.kernel.org/linux-arm-kernel/20221107062514.2851047-1-anshuman.khandual@arm.com/
> 
> - Changed BRBCR_EL1.VIRTUAL from 0b1 to 0b01
> - Changed BRBFCR_EL1.EnL into BRBFCR_EL1.EnI
> - Changed config ARM_BRBE_PMU from 'tristate' to 'bool'
> 
> Changes in V4:
> 
> https://lore.kernel.org/all/20221017055713.451092-1-anshuman.khandual@arm.com/
> 
> - Changed ../tools/sysreg declarations as suggested
> - Set PERF_SAMPLE_BRANCH_STACK in data.sample_flags
> - Dropped perfmon_capable() check in armpmu_event_init()
> - s/pr_warn_once/pr_info in armpmu_event_init()
> - Added brbe_format element into struct pmu_hw_events
> - Changed v1p1 as brbe_v1p1 in struct pmu_hw_events
> - Dropped pr_info() from arm64_pmu_brbe_probe(), solved LOCKDEP warning
> 
> Changes in V3:
> 
> https://lore.kernel.org/all/20220929075857.158358-1-anshuman.khandual@arm.com/
> 
> - Moved brbe_stack from the stack and now dynamically allocated
> - Return PERF_BR_PRIV_UNKNOWN instead of -1 in brbe_fetch_perf_priv()
> - Moved BRBIDR0, BRBCR, BRBFCR registers and fields into tools/sysreg
> - Created dummy BRBINF_EL1 field definitions in tools/sysreg
> - Dropped ARMPMU_EVT_PRIV framework which cached perfmon_capable()
> - Both exception and exception return branche records are now captured
>   only if the event has PERF_SAMPLE_BRANCH_KERNEL which would already
>   been checked in generic perf via perf_allow_kernel()
> 
> Changes in V2:
> 
> https://lore.kernel.org/all/20220908051046.465307-1-anshuman.khandual@arm.com/
> 
> - Dropped branch sample filter helpers consolidation patch from this series 
> - Added new hw_perf_event.flags element ARMPMU_EVT_PRIV to cache perfmon_capable()
> - Use cached perfmon_capable() while configuring BRBE branch record filters
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-arm-kernel/20220613100119.684673-1-anshuman.khandual@arm.com/
> 
> - Added CONFIG_PERF_EVENTS wrapper for all branch sample filter helpers
> - Process new perf branch types via PERF_BR_EXTEND_ABI
> 
> Changes in RFC V2:
> 
> https://lore.kernel.org/linux-arm-kernel/20220412115455.293119-1-anshuman.khandual@arm.com/
> 
> - Added branch_sample_priv() while consolidating other branch sample filter helpers
> - Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
> - Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
> - Added documentation for struct arm_pmu changes, updated commit message
> - Updated commit message for BRBE detection infrastructure patch
> - PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
> - Branch privilege state capture mechanism has now moved inside the driver
> 
> Changes in RFC V1:
> 
> https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki Poulose <suzuki.poulose@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (6):
>   drivers: perf: arm_pmu: Add new sched_task() callback
>   arm64/perf: Add BRBE registers and fields
>   arm64/perf: Add branch stack support in struct arm_pmu
>   arm64/perf: Add branch stack support in struct pmu_hw_events
>   arm64/perf: Add branch stack support in ARMV8 PMU
>   arm64/perf: Enable branch stack events via FEAT_BRBE
> 
>  arch/arm64/Kconfig                  |  11 +
>  arch/arm64/include/asm/perf_event.h |  19 ++
>  arch/arm64/include/asm/sysreg.h     | 103 ++++++
>  arch/arm64/kernel/Makefile          |   1 +
>  arch/arm64/kernel/brbe.c            | 512 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/brbe.h            | 257 ++++++++++++++
>  arch/arm64/kernel/perf_event.c      |  35 ++
>  arch/arm64/tools/sysreg             | 161 +++++++++
>  drivers/perf/arm_pmu.c              |  12 +-
>  include/linux/perf/arm_pmu.h        |  19 ++
>  10 files changed, 1128 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/kernel/brbe.c
>  create mode 100644 arch/arm64/kernel/brbe.h
> 
