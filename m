Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500F57397A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjFVGyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVGyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:54:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E9AB1A3;
        Wed, 21 Jun 2023 23:54:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8601042;
        Wed, 21 Jun 2023 23:54:51 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B1F03F59C;
        Wed, 21 Jun 2023 23:54:01 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH V13 00/10] arm64/perf: Enable branch stack sampling
Date:   Thu, 22 Jun 2023 12:23:41 +0530
Message-Id: <20230622065351.1092893-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables perf branch stack sampling support on arm64 platform
via a new arch feature called Branch Record Buffer Extension (BRBE). All
relevant register definitions could be accessed here.

https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers

This series applies on 6.4-rc7.

Changes in V13:

- Added branch callback stubs for aarch32 pmuv3 based platforms
- Updated the comments for capture_brbe_regset()
- Deleted the comments in __read_brbe_regset()
- Reversed the arguments order in capture_brbe_regset() and brbe_branch_save()
- Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in armv8pmu_branch_read()
- Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in capture_brbe_regset()

Changes in V12:

https://lore.kernel.org/all/20230615133239.442736-1-anshuman.khandual@arm.com/

- Replaced branch types with complete DIRECT/INDIRECT prefixes/suffixes
- Replaced branch types with complete INSN/ALIGN prefixes/suffixes
- Replaced return branch types as simple RET/ERET
- Replaced time field GST_PHYSICAL as GUEST_PHYSICAL
- Added 0 padding for BRBIDR0_EL1.NUMREC enum values
- Dropped helper arm_pmu_branch_stack_supported()
- Renamed armv8pmu_branch_valid() as armv8pmu_branch_attr_valid()
- Separated perf_task_ctx_cache setup from arm_pmu private allocation
- Collected changes to branch_records_alloc() in a single patch [5/10]
- Reworked and cleaned up branch_records_alloc()
- Reworked armv8pmu_branch_read() with new loop iterations in patch [6/10]
- Reworked capture_brbe_regset() with new loop iterations in patch [8/10]
- Updated the comment in branch_type_to_brbcr()
- Fixed the comment before stitch_stored_live_entries()
- Fixed BRBINFINJ_EL1 definition for VALID_FULL enum field
- Factored out helper __read_brbe_regset() from capture_brbe_regset()
- Dropped the helper copy_brbe_regset()
- Simplified stitch_stored_live_entries() with memcpy(), memmove()
- Reworked armv8pmu_probe_pmu() to bail out early with !probe.present
- Rework brbe_attributes_probe() without 'struct brbe_hw_attr'
- Dropped 'struct brbe_hw_attr' argument from capture_brbe_regset()
- Dropped 'struct brbe_hw_attr' argument from brbe_branch_save()
- Dropped arm_pmu->private and added arm_pmu->reg_trbidr instead

Changes in V11:

https://lore.kernel.org/all/20230531040428.501523-1-anshuman.khandual@arm.com/

- Fixed the crash for per-cpu events without event->pmu_ctx->task_ctx_data

Changes in V10:

https://lore.kernel.org/all/20230517022410.722287-1-anshuman.khandual@arm.com/

- Rebased the series on v6.4-rc2
- Moved ARMV8 PMUV3 changes inside drivers/perf/arm_pmuv3.c
- Moved BRBE driver changes inside drivers/perf/arm_brbe.[c|h]
- Moved the WARN_ON() inside the if condition in armv8pmu_handle_irq()

Changes in V9:

https://lore.kernel.org/all/20230315051444.1683170-1-anshuman.khandual@arm.com/

- Fixed build problem with has_branch_stack() in arm64 header
- BRBINF_EL1 definition has been changed from 'Sysreg' to 'SysregFields'
- Renamed all BRBINF_EL1 call sites as BRBINFx_EL1 
- Dropped static const char branch_filter_error_msg[]
- Implemented a positive list check for BRBE supported perf branch filters
- Added a comment in armv8pmu_handle_irq()
- Implemented per-cpu allocation for struct branch_record records
- Skipped looping through bank 1 if an invalid record is detected in bank 0
- Added comment in armv8pmu_branch_read() explaining prohibited region etc
- Added comment warning about erroneously marking transactions as aborted
- Replaced the first argument (perf_branch_entry) in capture_brbe_flags()
- Dropped the last argument (idx) in capture_brbe_flags()
- Dropped the brbcr argument from capture_brbe_flags()
- Used perf_sample_save_brstack() to capture branch records for perf_sample_data
- Added comment explaining rationale for setting BRBCR_EL1_FZP for user only traces
- Dropped BRBE prohibited state mechanism while in armv8pmu_branch_read()
- Implemented event task context based branch records save mechanism

Changes in V8:

https://lore.kernel.org/all/20230123125956.1350336-1-anshuman.khandual@arm.com/

- Replaced arm_pmu->features as arm_pmu->has_branch_stack, updated its helper
- Added a comment and line break before arm_pmu->private element 
- Added WARN_ON_ONCE() in helpers i.e armv8pmu_branch_[read|valid|enable|disable]()
- Dropped comments in armv8pmu_enable_event() and armv8pmu_disable_event()
- Replaced open bank encoding in BRBFCR_EL1 with SYS_FIELD_PREP()
- Changed brbe_hw_attr->brbe_version from 'bool' to 'int'
- Updated pr_warn() as pr_warn_once() with values in brbe_get_perf_[type|priv]()
- Replaced all pr_warn_once() as pr_debug_once() in armv8pmu_branch_valid()
- Added a comment in branch_type_to_brbcr() for the BRBCR_EL1 privilege settings
- Modified the comment related to BRBINFx_EL1.LASTFAILED in capture_brbe_flags()   
- Modified brbe_get_perf_entry_type() as brbe_set_perf_entry_type()
- Renamed brbe_valid() as brbe_record_is_complete()
- Renamed brbe_source() as brbe_record_is_source_only()
- Renamed brbe_target() as brbe_record_is_target_only()
- Inverted checks for !brbe_record_is_[target|source]_only() for info capture
- Replaced 'fetch' with 'get' in all helpers that extract field value
- Dropped 'static int brbe_current_bank' optimization in select_brbe_bank()
- Dropped select_brbe_bank_index() completely, added capture_branch_entry()
- Process captured branch entries in two separate loops one for each BRBE bank
- Moved branch_records_alloc() inside armv8pmu_probe_pmu()
- Added a forward declaration for the helper has_branch_stack()
- Added new callbacks armv8pmu_private_alloc() and armv8pmu_private_free()
- Updated armv8pmu_probe_pmu() to allocate the private structure before SMP call

Changes in V7:

https://lore.kernel.org/all/20230105031039.207972-1-anshuman.khandual@arm.com/

- Folded [PATCH 7/7] into [PATCH 3/7] which enables branch stack sampling event
- Defined BRBFCR_EL1_BRANCH_FILTERS, BRBCR_EL1_DEFAULT_CONFIG in the header
- Defined BRBFCR_EL1_DEFAULT_CONFIG in the header
- Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_FZP
- Defined BRBCR_EL1_DEFAULT_TS in the header
- Updated BRBCR_EL1_DEFAULT_CONFIG with BRBCR_EL1_DEFAULT_TS
- Moved BRBCR_EL1_DEFAULT_CONFIG check inside branch_type_to_brbcr()
- Moved down BRBCR_EL1_CC, BRBCR_EL1_MPRED later in branch_type_to_brbcr()
- Also set BRBE in paused state in armv8pmu_branch_disable()
- Dropped brbe_paused(), set_brbe_paused() helpers
- Extracted error string via branch_filter_error_msg[] for armv8pmu_branch_valid()
- Replaced brbe_v1p1 with brbe_version in struct brbe_hw_attr
- Added valid_brbe_[cc, format, version]() helpers
- Split a separate brbe_attributes_probe() from armv8pmu_branch_probe()
- Capture event->attr.branch_sample_type earlier in armv8pmu_branch_valid()
- Defined enum brbe_bank_idx with possible values for BRBE bank indices
- Changed armpmu->hw_attr into armpmu->private
- Added missing space in stub definition for armv8pmu_branch_valid()
- Replaced both kmalloc() with kzalloc()
- Added BRBE_BANK_MAX_ENTRIES
- Updated comment for capture_brbe_flags()
- Updated comment for struct brbe_hw_attr
- Dropped space after type cast in couple of places
- Replaced inverse with negation for testing BRBCR_EL1_FZP in armv8pmu_branch_read()
- Captured cpuc->branches->branch_entries[idx] in a local variable
- Dropped saved_priv from armv8pmu_branch_read()
- Reorganize PERF_SAMPLE_BRANCH_NO_[CYCLES|NO_FLAGS] related configuration
- Replaced with FIELD_GET() and FIELD_PREP() wherever applicable
- Replaced BRBCR_EL1_TS_PHYSICAL with BRBCR_EL1_TS_VIRTUAL
- Moved valid_brbe_nr(), valid_brbe_cc(), valid_brbe_format(), valid_brbe_version()
  select_brbe_bank(), select_brbe_bank_index() helpers inside the C implementation
- Reorganized brbe_valid_nr() and dropped the pr_warn() message
- Changed probe sequence in brbe_attributes_probe()
- Added 'brbcr' argument into capture_brbe_flags() to ascertain correct state
- Disable BRBE before disabling the PMU event counter
- Enable PERF_SAMPLE_BRANCH_HV filters when is_kernel_in_hyp_mode()
- Guard armv8pmu_reset() & armv8pmu_sched_task() with arm_pmu_branch_stack_supported()

Changes in V6:

https://lore.kernel.org/linux-arm-kernel/20221208084402.863310-1-anshuman.khandual@arm.com/

- Restore the exception level privilege after reading the branch records
- Unpause the buffer after reading the branch records
- Decouple BRBCR_EL1_EXCEPTION/ERTN from perf event privilege level
- Reworked BRBE implementation and branch stack sampling support on arm pmu
- BRBE implementation is now part of overall ARMV8 PMU implementation
- BRBE implementation moved from drivers/perf/ to inside arch/arm64/kernel/
- CONFIG_ARM_BRBE_PMU renamed as CONFIG_ARM64_BRBE in arch/arm64/Kconfig
- File moved - drivers/perf/arm_pmu_brbe.c -> arch/arm64/kernel/brbe.c
- File moved - drivers/perf/arm_pmu_brbe.h -> arch/arm64/kernel/brbe.h
- BRBE name has been dropped from struct arm_pmu and struct hw_pmu_events
- BRBE name has been abstracted out as 'branches' in arm_pmu and hw_pmu_events
- BRBE name has been abstracted out as 'branches' in ARMV8 PMU implementation
- Added sched_task() callback into struct arm_pmu
- Added 'hw_attr' into struct arm_pmu encapsulating possible PMU HW attributes
- Dropped explicit attributes brbe_(v1p1, nr, cc, format) from struct arm_pmu
- Dropped brbfcr, brbcr, registers scratch area from struct hw_pmu_events
- Dropped brbe_users, brbe_context tracking in struct hw_pmu_events
- Added 'features' tracking into struct arm_pmu with ARM_PMU_BRANCH_STACK flag
- armpmu->hw_attr maps into 'struct brbe_hw_attr' inside BRBE implementation
- Set ARM_PMU_BRANCH_STACK in 'arm_pmu->features' after successful BRBE probe
- Added armv8pmu_branch_reset() inside armv8pmu_branch_enable()
- Dropped brbe_supported() as events will be rejected via ARM_PMU_BRANCH_STACK
- Dropped set_brbe_disabled() as well
- Reformated armv8pmu_branch_valid() warnings while rejecting unsupported events

Changes in V5:

https://lore.kernel.org/linux-arm-kernel/20221107062514.2851047-1-anshuman.khandual@arm.com/

- Changed BRBCR_EL1.VIRTUAL from 0b1 to 0b01
- Changed BRBFCR_EL1.EnL into BRBFCR_EL1.EnI
- Changed config ARM_BRBE_PMU from 'tristate' to 'bool'

Changes in V4:

https://lore.kernel.org/all/20221017055713.451092-1-anshuman.khandual@arm.com/

- Changed ../tools/sysreg declarations as suggested
- Set PERF_SAMPLE_BRANCH_STACK in data.sample_flags
- Dropped perfmon_capable() check in armpmu_event_init()
- s/pr_warn_once/pr_info in armpmu_event_init()
- Added brbe_format element into struct pmu_hw_events
- Changed v1p1 as brbe_v1p1 in struct pmu_hw_events
- Dropped pr_info() from arm64_pmu_brbe_probe(), solved LOCKDEP warning

Changes in V3:

https://lore.kernel.org/all/20220929075857.158358-1-anshuman.khandual@arm.com/

- Moved brbe_stack from the stack and now dynamically allocated
- Return PERF_BR_PRIV_UNKNOWN instead of -1 in brbe_fetch_perf_priv()
- Moved BRBIDR0, BRBCR, BRBFCR registers and fields into tools/sysreg
- Created dummy BRBINF_EL1 field definitions in tools/sysreg
- Dropped ARMPMU_EVT_PRIV framework which cached perfmon_capable()
- Both exception and exception return branche records are now captured
  only if the event has PERF_SAMPLE_BRANCH_KERNEL which would already
  been checked in generic perf via perf_allow_kernel()

Changes in V2:

https://lore.kernel.org/all/20220908051046.465307-1-anshuman.khandual@arm.com/

- Dropped branch sample filter helpers consolidation patch from this series 
- Added new hw_perf_event.flags element ARMPMU_EVT_PRIV to cache perfmon_capable()
- Use cached perfmon_capable() while configuring BRBE branch record filters

Changes in V1:

https://lore.kernel.org/linux-arm-kernel/20220613100119.684673-1-anshuman.khandual@arm.com/

- Added CONFIG_PERF_EVENTS wrapper for all branch sample filter helpers
- Process new perf branch types via PERF_BR_EXTEND_ABI

Changes in RFC V2:

https://lore.kernel.org/linux-arm-kernel/20220412115455.293119-1-anshuman.khandual@arm.com/

- Added branch_sample_priv() while consolidating other branch sample filter helpers
- Changed all SYS_BRBXXXN_EL1 register definition encodings per Marc
- Changed the BRBE driver as per proposed BRBE related perf ABI changes (V5)
- Added documentation for struct arm_pmu changes, updated commit message
- Updated commit message for BRBE detection infrastructure patch
- PERF_SAMPLE_BRANCH_KERNEL gets checked during arm event init (outside the driver)
- Branch privilege state capture mechanism has now moved inside the driver

Changes in RFC V1:

https://lore.kernel.org/all/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Anshuman Khandual (10):
  drivers: perf: arm_pmu: Add new sched_task() callback
  arm64/perf: Add BRBE registers and fields
  arm64/perf: Add branch stack support in struct arm_pmu
  arm64/perf: Add branch stack support in struct pmu_hw_events
  arm64/perf: Add branch stack support in ARMV8 PMU
  arm64/perf: Enable branch stack events via FEAT_BRBE
  arm64/perf: Add PERF_ATTACH_TASK_DATA to events with has_branch_stack()
  arm64/perf: Add struct brbe_regset helper functions
  arm64/perf: Implement branch records save on task sched out
  arm64/perf: Implement branch records save on PMU IRQ

 arch/arm/include/asm/arm_pmuv3.h    |  12 +
 arch/arm64/include/asm/perf_event.h |  46 ++
 arch/arm64/include/asm/sysreg.h     | 103 ++++
 arch/arm64/tools/sysreg             | 158 ++++++
 drivers/perf/Kconfig                |  11 +
 drivers/perf/Makefile               |   1 +
 drivers/perf/arm_brbe.c             | 716 ++++++++++++++++++++++++++++
 drivers/perf/arm_brbe.h             | 270 +++++++++++
 drivers/perf/arm_pmu.c              |  12 +-
 drivers/perf/arm_pmuv3.c            | 110 ++++-
 include/linux/perf/arm_pmu.h        |  19 +-
 11 files changed, 1431 insertions(+), 27 deletions(-)
 create mode 100644 drivers/perf/arm_brbe.c
 create mode 100644 drivers/perf/arm_brbe.h

-- 
2.25.1

