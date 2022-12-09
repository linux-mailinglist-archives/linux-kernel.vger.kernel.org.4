Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9364818F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiLILZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiLILZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:25:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135876F0CC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:25:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BE7BB82867
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 11:25:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2089AC433D2;
        Fri,  9 Dec 2022 11:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670585106;
        bh=lm9ISjIPcC1R1y/cQzV0OnCZnpGV/Ehpg1rD2+TXuEA=;
        h=Date:From:To:Cc:Subject:From;
        b=aCexbFGeMbs7UPYar4B0nJ8HEmPjdLbOE/Pa/gt3TYo0Kg1dXu410+ec+YxYFk2gs
         Wlffc/r+9jMfPLBRH6G5MAVBP/PI7Ak93QGJmDNVvlBrpq02+wKvRwTb9I0LwYxfL9
         +Zo+M2Xjnr1odlOcpKbHkMm4u1hRNjZymlPrSnAd5tfR2UK+jLIbQCYROpvduDxjbh
         oNVfApQU+n8ly/YPueRp7L9CYaQycyorDDmfH+owsI30ht3dNtMQlFDVctRD/svYnJ
         G7ThqhQO2GlpifWMwsQF5CNUPDi52+ZPMl/49l6xD8WOJhHiVrUsA7v+zDKTfi8mDC
         VCl1ltr1f0uTw==
Date:   Fri, 9 Dec 2022 11:25:01 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org
Subject: [GIT PULL] arm64 updates for 6.2
Message-ID: <20221209112500.GA3116@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 updates for the 6.2 merge window.

There's the usual summary in the tag, with the highlights this time being
support for dynamically enabling/disabling Clang's Shadow Call Stack at
boot and a long-awaited optimisation to the way in which we handle the
SVE register state on system call entry to avoid taking unnecessary traps
from userspace.

A few small things to note:

  * for-next/sysregs is shared with the KVM tree, since it conflicts
    with some rework of the PMU handling code in the hypervisor.

  * We have some refactoring changes to the core ftrace code reworking
    FTRACE_WITH_REGS and fixing up PowerPC, S390 and x86 (acked by Steve
    and Masami). We build on top of this to enable FTRACE_WITH_ARGS on
    arm64.

  * We dropped for-next/uaccess fairly late in the cycle after Syzkaller
    ran into an issue with the fault handling in copy_to_user(). Hopefully
    we'll bring it back next time once we've got deterministic testing
    coverage of all the exception fixups.

It's all been sitting happily in -next for a while now.

Cheers,

Will

--->8

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 5f4c374760b031f06c69c2fdad1b0e981a1ad42f:

  Merge branch 'for-next/undef-traps' into for-next/core (2022-12-06 11:34:25 +0000)

----------------------------------------------------------------
arm64 updates for 6.2

ACPI:
	* Enable FPDT support for boot-time profiling
	* Fix CPU PMU probing to work better with PREEMPT_RT
	* Update SMMUv3 MSI DeviceID parsing to latest IORT spec
	* APMT support for probing Arm CoreSight PMU devices

CPU features:
	* Advertise new SVE instructions (v2.1)
	* Advertise range prefetch instruction
	* Advertise CSSC ("Common Short Sequence Compression") scalar
	  instructions, adding things like min, max, abs, popcount
	* Enable DIT (Data Independent Timing) when running in the kernel
	* More conversion of system register fields over to the generated
	  header

CPU misfeatures:
	* Workaround for Cortex-A715 erratum #2645198

Dynamic SCS:
	* Support for dynamic shadow call stacks to allow switching at
	  runtime between Clang's SCS implementation and the CPU's
	  pointer authentication feature when it is supported (complete
	  with scary DWARF parser!)

Tracing and debug:
	* Remove static ftrace in favour of, err, dynamic ftrace!
	* Seperate 'struct ftrace_regs' from 'struct pt_regs' in core
	  ftrace and existing arch code
	* Introduce and implement FTRACE_WITH_ARGS on arm64 to replace
	  the old FTRACE_WITH_REGS
	* Extend 'crashkernel=' parameter with default value and fallback
	  to placement above 4G physical if initial (low) allocation
	  fails

SVE:
	* Optimisation to avoid disabling SVE unconditionally on syscall
	  entry and just zeroing the non-shared state on return instead

Exceptions:
	* Rework of undefined instruction handling to avoid serialisation
	  on global lock (this includes emulation of user accesses to the
	  ID registers)

Perf and PMU:
	* Support for TLP filters in Hisilicon's PCIe PMU device
	* Support for the DDR PMU present in Amlogic Meson G12 SoCs
	* Support for the terribly-named "CoreSight PMU" architecture
	  from Arm (and Nvidia's implementation of said architecture)

Misc:
	* Tighten up our boot protocol for systems with memory above
          52 bits physical
	* Const-ify static keys to satisty jump label asm constraints
	* Trivial FFA driver cleanups in preparation for v1.1 support
	* Export the kernel_neon_* APIs as GPL symbols
	* Harden our instruction generation routines against
	  instrumentation
	* A bunch of robustness improvements to our arch-specific selftests
	* Minor cleanups and fixes all over (kbuild, kprobes, kfence, PMU, ...)

----------------------------------------------------------------
Anshuman Khandual (9):
      arm64/mm: Drop ARM64_KERNEL_USES_PMD_MAPS
      arm64/mm: Simplify and document pte_to_phys() for 52 bit addresses
      arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)
      arm64/mm: Drop idmap_pg_end[] declaration
      arm64/mm: Drop unused restore_ttbr1
      arm64: Add Cortex-715 CPU part definition
      arm64: errata: Workaround possible Cortex-A715 [ESR|FAR]_ELx corruption
      arm64/perf: Replace PMU version number '0' with ID_AA64DFR0_EL1_PMUVer_NI
      arm_pmu: Drop redundant armpmu->map_event() in armpmu_event_init()

Ard Biesheuvel (5):
      arm64: Enable data independent timing (DIT) in the kernel
      arm64: unwind: add asynchronous unwind tables to kernel and modules
      scs: add support for dynamic shadow call stacks
      arm64: implement dynamic shadow call stack for Clang
      arm64: booting: Require placement within 48-bit addressable memory

Bagas Sanjaya (1):
      Documentation: perf: Indent filter options list of hisi-pcie-pmu

Besar Wicaksono (6):
      ACPI: ARM Performance Monitoring Unit Table (APMT) initial support
      ACPI: APMT: Fix kerneldoc and indentation
      perf: arm_cspmu: Add support for ARM CoreSight PMU driver
      perf: arm_cspmu: Add support for NVIDIA SCF and MCF attribute
      perf: arm_cspmu: Fix build failure on x86_64
      perf: arm_cspmu: Fix module cyclic dependency

James Morse (38):
      arm64/sysreg: Standardise naming for ID_MMFR0_EL1
      arm64/sysreg: Standardise naming for ID_MMFR4_EL1
      arm64/sysreg: Standardise naming for ID_MMFR5_EL1
      arm64/sysreg: Standardise naming for ID_ISAR0_EL1
      arm64/sysreg: Standardise naming for ID_ISAR4_EL1
      arm64/sysreg: Standardise naming for ID_ISAR5_EL1
      arm64/sysreg: Standardise naming for ID_ISAR6_EL1
      arm64/sysreg: Standardise naming for ID_PFR0_EL1
      arm64/sysreg: Standardise naming for ID_PFR1_EL1
      arm64/sysreg: Standardise naming for ID_PFR2_EL1
      arm64/sysreg: Standardise naming for ID_DFR0_EL1
      arm64/sysreg: Standardise naming for ID_DFR1_EL1
      arm64/sysreg: Standardise naming for MVFR0_EL1
      arm64/sysreg: Standardise naming for MVFR1_EL1
      arm64/sysreg: Standardise naming for MVFR2_EL1
      arm64/sysreg: Extend the maximum width of a register and symbol name
      arm64/sysreg: Convert ID_MMFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_MMFR1_EL1 to automatic generation
      arm64/sysreg: Convert ID_MMFR2_EL1 to automatic generation
      arm64/sysreg: Convert ID_MMFR3_EL1 to automatic generation
      arm64/sysreg: Convert ID_MMFR4_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR1_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR2_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR3_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR4_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR5_EL1 to automatic generation
      arm64/sysreg: Convert ID_ISAR6_EL1 to automatic generation
      arm64/sysreg: Convert ID_PFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_PFR1_EL1 to automatic generation
      arm64/sysreg: Convert ID_PFR2_EL1 to automatic generation
      arm64/sysreg: Convert MVFR0_EL1 to automatic generation
      arm64/sysreg: Convert MVFR1_EL1 to automatic generation
      arm64/sysreg: Convert MVFR2_EL1 to automatic generation
      arm64/sysreg: Convert ID_MMFR5_EL1 to automatic generation
      arm64/sysreg: Convert ID_AFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_DFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_DFR1_EL1 to automatic generation

Jeremy Linton (1):
      ACPI: Enable FPDT on arm64

Jiapeng Chong (1):
      perf/amlogic: Remove unused header inclusions of  <linux/version.h>

Jisheng Zhang (3):
      arm64: jump_label: mark arguments as const to satisfy asm constraints
      arm64: alternative: constify alternative_has_feature_* argument
      arm64: alternatives: add __init/__initconst to some functions/variables

Jiucheng Xu (4):
      perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver
      docs/perf: Add documentation for the Amlogic G12 DDR PMU
      dt-binding: perf: Add Amlogic DDR PMU
      perf/amlogic: Fix build error for x86_64 allmodconfig

Kang Minchul (1):
      kselftest/arm64: fix array_size.cocci warning

Mark Brown (29):
      arm64/asm: Remove unused enable_da macro
      arm64/booting: Add missing colon to FA64 entry
      kselftest/arm64: Check that all children are producing output in fp-stress
      kselftest/arm64: Provide progress messages when signalling children
      kselftest/arm64: Remove validation of extra_context from TODO
      kselftest/arm64: Print ASCII version of unknown signal frame magic values
      arm64/fpsimd: Make kernel_neon_ API _GPL
      arm64/hwcap: Add support for FEAT_CSSC
      kselftest/arm64: Add FEAT_CSSC to the hwcap selftest
      arm64/hwcap: Add support for FEAT_RPRFM
      kselftest/arm64: Add FEAT_RPRFM to the hwcap test
      arm64/hwcap: Add support for SVE 2.1
      kselftest/arm64: Add SVE 2.1 to hwcap test
      arm64/signal: Document our convention for choosing magic numbers
      kselftest/arm64: Use preferred form for predicate load/stores
      arm64/kpti: Move DAIF masking to C code
      arm64/asm: Remove unused assembler DAIF save/restore macros
      kselftest/arm64: Set test names prior to starting children
      KVM: arm64: Discard any SVE state when entering KVM guests
      arm64/fpsimd: Track the saved FPSIMD state type separately to TIF_SVE
      arm64/fpsimd: Have KVM explicitly say which FP registers to save
      arm64/fpsimd: Stop using TIF_SVE to manage register saving in KVM
      arm64/fpsimd: Load FP state based on recorded data type
      arm64/fpsimd: SME no longer requires SVE register state
      arm64/sve: Leave SVE enabled on syscall if we don't context switch
      arm64/fp: Use a struct to pass data to fpsimd_bind_state_to_cpu()
      kselftest/arm64: Hold fp-stress children until they're all spawned
      kselftest/arm64: Don't drain output while spawning children
      kselftest/arm64: Allow epoll_wait() to return more than one result

Mark Rutland (28):
      arm_pmu: acpi: factor out PMU<->CPU association
      arm_pmu: factor out PMU matching
      arm_pmu: rework ACPI probing
      arm_pmu: acpi: handle allocation failure
      arm64: atomics: lse: remove stale dependency on JUMP_LABEL
      arm64: make is_ttbrX_addr() noinstr-safe
      arm64: insn: remove aarch64_insn_gen_prefetch()
      arm64: insn: always inline predicates
      arm64: insn: simplify insn group identification
      arm64: insn: always inline hint generation
      arm64: mm: kfence: only handle translation faults
      arm64: allow kprobes on EL0 handlers
      arm64: split EL0/EL1 UNDEF handlers
      arm64: factor out EL1 SSBS emulation hook
      arm64: factor insn read out of call_undef_hook()
      arm64: rework EL0 MRS emulation
      arm64: armv8_deprecated: fold ops into insn_emulation
      arm64: armv8_deprecated move emulation functions
      arm64: armv8_deprecated: move aarch32 helper earlier
      arm64: armv8_deprecated: rework deprected instruction handling
      ftrace: pass fregs to arch_ftrace_set_direct_caller()
      ftrace: rename ftrace_instruction_pointer_set() -> ftrace_regs_set_instruction_pointer()
      ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
      ftrace: arm64: move from REGS to ARGS
      arm64: alternatives: make apply_alternatives_vdso() static
      arm64: remove current_top_of_stack()
      arm64: move on_thread_stack() to <asm/stacktrace.h>
      ftrace: arm64: remove static ftrace

Masahiro Yamada (1):
      arm64: remove special treatment for the link order of head.o

Masami Hiramatsu (Google) (3):
      arm64: Prohibit instrumentation on arch_stack_walk()
      arm64: kprobes: Let arch do_page_fault() fix up page fault in user handler
      arm64: kprobes: Return DBG_HOOK_ERROR if kprobes can not handle a BRK

Mukesh Ojha (1):
      arm64: entry: Fix typo

Ren Zhijie (1):
      arm64: armv8_deprecated: fix unused-function error

Robin Murphy (1):
      ACPI/IORT: Update SMMUv3 DeviceID support

Shang XiaoJing (2):
      perf/arm_dmc620: Fix hotplug callback leak in dmc620_pmu_init()
      perf/smmuv3: Fix hotplug callback leak in arm_smmu_pmu_init()

Shaokun Zhang (1):
      MAINTAINERS: Update HiSilicon PMU maintainers

Usama Arif (1):
      arm64: paravirt: remove conduit check in has_pv_steal_clock

Will Deacon (25):
      perf: arm_cspmu: Fix modular builds due to missing MODULE_LICENSE()s
      Revert "arm64/mm: Drop redundant BUG_ON(!pgtable_alloc)"
      firmware: arm_ffa: Move constants to header file
      firmware: arm_ffa: Move comment before the field it is documenting
      arm64/sysreg: Remove duplicate definitions from asm/sysreg.h
      Merge branch 'for-next/acpi' into for-next/core
      Merge branch 'for-next/asm-const' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/dynamic-scs' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/ffa' into for-next/core
      Merge branch 'for-next/fpsimd' into for-next/core
      Merge branch 'for-next/ftrace' into for-next/core
      Merge branch 'for-next/insn' into for-next/core
      Merge branch 'for-next/kbuild' into for-next/core
      Merge branch 'for-next/kdump' into for-next/core
      Merge branch 'for-next/kprobes' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/stacks' into for-next/core
      Merge branch 'for-next/sve-state' into for-next/core
      Merge branch 'for-next/sysregs' into for-next/core
      Merge branch 'for-next/trivial' into for-next/core
      Merge branch 'for-next/undef-traps' into for-next/core

Yicong Yang (3):
      drivers/perf: hisi: Fix some event id for hisi-pcie-pmu
      docs: perf: Fix PMU instance name of hisi-pcie-pmu
      drivers/perf: hisi: Add TLP filter support

Yuan Can (2):
      perf: arm_dsu: Fix hotplug callback leak in dsu_pmu_init()
      drivers: perf: marvell_cn10k: Fix hotplug callback leak in tad_pmu_init()

Zhen Lei (2):
      arm64: kdump: Provide default size when crashkernel=Y,low is not specified
      arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones

junhua huang (1):
      arm64:uprobe fix the uprobe SWBP_INSN in big-endian

wangkailong@jari.cn (1):
      kselftest/arm64: fix array_size.cocci warning

 Documentation/admin-guide/kernel-parameters.txt    |   15 +-
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst   |  112 +-
 Documentation/admin-guide/perf/index.rst           |    2 +
 Documentation/admin-guide/perf/meson-ddr-pmu.rst   |   70 ++
 Documentation/admin-guide/perf/nvidia-pmu.rst      |  299 +++++
 Documentation/arm64/acpi_object_usage.rst          |    2 +-
 Documentation/arm64/booting.rst                    |    7 +-
 Documentation/arm64/elf_hwcaps.rst                 |    9 +
 Documentation/arm64/silicon-errata.rst             |    2 +
 Documentation/arm64/sve.rst                        |    1 +
 .../bindings/perf/amlogic,g12-ddr-pmu.yaml         |   54 +
 MAINTAINERS                                        |   12 +-
 Makefile                                           |    2 +
 arch/Kconfig                                       |    7 +
 arch/arm64/Kconfig                                 |   49 +-
 arch/arm64/Makefile                                |   17 +-
 arch/arm64/include/asm/alternative-macros.h        |    4 +-
 arch/arm64/include/asm/assembler.h                 |   33 +-
 arch/arm64/include/asm/cpufeature.h                |    3 +-
 arch/arm64/include/asm/cputype.h                   |    2 +
 arch/arm64/include/asm/exception.h                 |    7 +-
 arch/arm64/include/asm/fpsimd.h                    |   17 +-
 arch/arm64/include/asm/ftrace.h                    |   72 +-
 arch/arm64/include/asm/hugetlb.h                   |    9 +
 arch/arm64/include/asm/hwcap.h                     |    3 +
 arch/arm64/include/asm/insn.h                      |  156 ++-
 arch/arm64/include/asm/jump_label.h                |    8 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   11 +-
 arch/arm64/include/asm/kvm_host.h                  |   12 +-
 arch/arm64/include/asm/lse.h                       |    1 -
 arch/arm64/include/asm/mmu_context.h               |   10 +
 arch/arm64/include/asm/module.lds.h                |    8 +
 arch/arm64/include/asm/pgtable-hwdef.h             |    1 +
 arch/arm64/include/asm/pgtable.h                   |   14 +-
 arch/arm64/include/asm/processor.h                 |   24 +-
 arch/arm64/include/asm/scs.h                       |   49 +
 arch/arm64/include/asm/spectre.h                   |    2 +
 arch/arm64/include/asm/stacktrace.h                |    2 +
 arch/arm64/include/asm/sysreg.h                    |  150 +--
 arch/arm64/include/asm/traps.h                     |   19 +-
 arch/arm64/include/asm/uprobes.h                   |    2 +-
 arch/arm64/include/uapi/asm/hwcap.h                |    3 +
 arch/arm64/include/uapi/asm/sigcontext.h           |    4 +
 arch/arm64/kernel/Makefile                         |    2 +
 arch/arm64/kernel/alternative.c                    |    6 +-
 arch/arm64/kernel/armv8_deprecated.c               |  567 +++++----
 arch/arm64/kernel/asm-offsets.c                    |   13 +
 arch/arm64/kernel/cpu_errata.c                     |    7 +
 arch/arm64/kernel/cpufeature.c                     |  253 ++--
 arch/arm64/kernel/cpuinfo.c                        |    3 +
 arch/arm64/kernel/entry-common.c                   |   24 +-
 arch/arm64/kernel/entry-ftrace.S                   |  156 +--
 arch/arm64/kernel/entry.S                          |    3 +
 arch/arm64/kernel/fpsimd.c                         |  169 ++-
 arch/arm64/kernel/ftrace.c                         |   87 +-
 arch/arm64/kernel/head.S                           |    3 +
 arch/arm64/kernel/irq.c                            |   11 +-
 arch/arm64/kernel/module.c                         |   11 +-
 arch/arm64/kernel/paravirt.c                       |    4 -
 arch/arm64/kernel/patch-scs.c                      |  257 ++++
 arch/arm64/kernel/perf_event.c                     |    3 +-
 arch/arm64/kernel/pi/Makefile                      |    1 +
 arch/arm64/kernel/probes/decode-insn.c             |    2 +-
 arch/arm64/kernel/probes/kprobes.c                 |   86 +-
 arch/arm64/kernel/process.c                        |    2 +
 arch/arm64/kernel/proton-pack.c                    |   26 +-
 arch/arm64/kernel/ptrace.c                         |    5 +-
 arch/arm64/kernel/sdei.c                           |    2 +-
 arch/arm64/kernel/setup.c                          |    4 +
 arch/arm64/kernel/signal.c                         |    7 +-
 arch/arm64/kernel/stacktrace.c                     |   10 +-
 arch/arm64/kernel/suspend.c                        |    2 +
 arch/arm64/kernel/syscall.c                        |   19 +-
 arch/arm64/kernel/traps.c                          |   93 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   13 +
 arch/arm64/kvm/fpsimd.c                            |   26 +-
 arch/arm64/kvm/hyp/nvhe/Makefile                   |    1 +
 arch/arm64/kvm/sys_regs.c                          |    4 +-
 arch/arm64/lib/insn.c                              |  165 ---
 arch/arm64/lib/mte.S                               |    2 +-
 arch/arm64/mm/fault.c                              |    8 +-
 arch/arm64/mm/hugetlbpage.c                        |   21 +
 arch/arm64/mm/init.c                               |   25 +-
 arch/arm64/mm/mmu.c                                |   23 +-
 arch/arm64/mm/proc.S                               |    4 -
 arch/arm64/tools/cpucaps                           |    2 +
 arch/arm64/tools/gen-sysreg.awk                    |    2 +-
 arch/arm64/tools/sysreg                            |  766 +++++++++++-
 arch/powerpc/include/asm/ftrace.h                  |   24 +-
 arch/s390/include/asm/ftrace.h                     |   29 +-
 arch/x86/include/asm/ftrace.h                      |   49 +-
 drivers/acpi/Kconfig                               |    2 +-
 drivers/acpi/arm64/Kconfig                         |    3 +
 drivers/acpi/arm64/Makefile                        |    1 +
 drivers/acpi/arm64/apmt.c                          |  178 +++
 drivers/acpi/arm64/iort.c                          |   16 +-
 drivers/acpi/bus.c                                 |    2 +
 drivers/firmware/arm_ffa/driver.c                  |  101 +-
 drivers/firmware/efi/libstub/Makefile              |    1 +
 drivers/perf/Kconfig                               |    4 +
 drivers/perf/Makefile                              |    2 +
 drivers/perf/amlogic/Kconfig                       |   10 +
 drivers/perf/amlogic/Makefile                      |    5 +
 drivers/perf/amlogic/meson_ddr_pmu_core.c          |  561 +++++++++
 drivers/perf/amlogic/meson_g12_ddr_pmu.c           |  394 ++++++
 drivers/perf/arm_cspmu/Kconfig                     |   13 +
 drivers/perf/arm_cspmu/Makefile                    |    6 +
 drivers/perf/arm_cspmu/arm_cspmu.c                 | 1303 ++++++++++++++++++++
 drivers/perf/arm_cspmu/arm_cspmu.h                 |  151 +++
 drivers/perf/arm_cspmu/nvidia_cspmu.c              |  400 ++++++
 drivers/perf/arm_cspmu/nvidia_cspmu.h              |   17 +
 drivers/perf/arm_dmc620_pmu.c                      |    8 +-
 drivers/perf/arm_dsu_pmu.c                         |    6 +-
 drivers/perf/arm_pmu.c                             |   20 +-
 drivers/perf/arm_pmu_acpi.c                        |  114 +-
 drivers/perf/arm_smmuv3_pmu.c                      |    8 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   22 +-
 drivers/perf/marvell_cn10k_tad_pmu.c               |    6 +-
 include/asm-generic/vmlinux.lds.h                  |    9 +-
 include/linux/acpi_apmt.h                          |   19 +
 include/linux/arm_ffa.h                            |   85 +-
 include/linux/ftrace.h                             |   47 +-
 include/linux/perf/arm_pmu.h                       |    1 -
 include/linux/scs.h                                |   18 +
 include/soc/amlogic/meson_ddr_pmu.h                |   66 +
 kernel/livepatch/patch.c                           |    2 +-
 kernel/scs.c                                       |   14 +-
 kernel/trace/Kconfig                               |    6 +-
 kernel/trace/ftrace.c                              |    3 +-
 scripts/head-object-list.txt                       |    1 -
 scripts/module.lds.S                               |    6 +
 tools/testing/selftests/arm64/abi/hwcap.c          |   32 +
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |    4 +-
 tools/testing/selftests/arm64/fp/fp-stress.c       |  120 +-
 .../selftests/arm64/mte/check_buffer_fill.c        |   12 +-
 .../selftests/arm64/mte/check_mmap_options.c       |    9 +-
 .../testing/selftests/arm64/signal/testcases/TODO  |    1 -
 .../selftests/arm64/signal/testcases/testcases.c   |   21 +-
 138 files changed, 6535 insertions(+), 1583 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/meson-ddr-pmu.rst
 create mode 100644 Documentation/admin-guide/perf/nvidia-pmu.rst
 create mode 100644 Documentation/devicetree/bindings/perf/amlogic,g12-ddr-pmu.yaml
 create mode 100644 arch/arm64/kernel/patch-scs.c
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 drivers/perf/amlogic/Kconfig
 create mode 100644 drivers/perf/amlogic/Makefile
 create mode 100644 drivers/perf/amlogic/meson_ddr_pmu_core.c
 create mode 100644 drivers/perf/amlogic/meson_g12_ddr_pmu.c
 create mode 100644 drivers/perf/arm_cspmu/Kconfig
 create mode 100644 drivers/perf/arm_cspmu/Makefile
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu.h
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.c
 create mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h
 create mode 100644 include/linux/acpi_apmt.h
 create mode 100644 include/soc/amlogic/meson_ddr_pmu.h
