Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A8B5F56A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJEOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJEOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4D641506
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 07:41:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6B86170B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D5FC433C1;
        Wed,  5 Oct 2022 14:41:19 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.1-rc1
Date:   Wed,  5 Oct 2022 15:41:16 +0100
Message-Id: <20221005144116.2256580-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates for 6.1-rc1. It's almost entirely
contained within arch/arm64/, drivers/perf/ and tools/testing/ with a
few additional changes in drivers/ due to more automatic sysreg
definitions generation. There is a trivial conflict with current
mainline removing the '__nocfi' annotation while the arm64 tree makes a
pointer const for the same function. I included my merge resolution
below.

Thanks.

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to d2995249a2f72333a4ab4922ff3c42a76c023791:

  arm64: alternatives: Use vdso/bits.h instead of linux/bits.h (2022-10-05 10:44:44 +0100)

diff --cc arch/arm64/kernel/alternative.c
index d2c66507398d,64045e3ef03a..80772986687a
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@@ -133,8 -139,9 +139,8 @@@ static void clean_dcache_range_nopatch(
  	} while (cur += d_size, cur < end);
  }
  
- static void __apply_alternatives(struct alt_region *region, bool is_module,
- 				 unsigned long *feature_mask)
 -static void __nocfi __apply_alternatives(const struct alt_region *region,
 -					 bool is_module,
 -					 unsigned long *feature_mask)
++static void __apply_alternatives(const struct alt_region *region,
++				 bool is_module, unsigned long *feature_mask)
  {
  	struct alt_instr *alt;
  	__le32 *origptr, *updptr;

----------------------------------------------------------------
arm64 updates for 6.1:

- arm64 perf: DDR PMU driver for Alibaba's T-Head Yitian 710 SoC, SVE
  vector granule register added to the user regs together with SVE perf
  extensions documentation.

- SVE updates: add HWCAP for SVE EBF16, update the SVE ABI documentation
  to match the actual kernel behaviour (zeroing the registers on syscall
  rather than "zeroed or preserved" previously).

- More conversions to automatic system registers generation.

- vDSO: use self-synchronising virtual counter access in gettimeofday()
  if the architecture supports it.

- arm64 stacktrace cleanups and improvements.

- arm64 atomics improvements: always inline assembly, remove LL/SC
  trampolines.

- Improve the reporting of EL1 exceptions: rework BTI and FPAC exception
  handling, better EL1 undefs reporting.

- Cortex-A510 erratum 2658417: remove BF16 support due to incorrect
  result.

- arm64 defconfig updates: build CoreSight as a module, enable options
  necessary for docker, memory hotplug/hotremove, enable all PMUs
  provided by Arm.

- arm64 ptrace() support for TPIDR2_EL0 (register provided with the SME
  extensions).

- arm64 ftraces updates/fixes: fix module PLTs with mcount, remove
  unused function.

- kselftest updates for arm64: simple HWCAP validation, FP stress test
  improvements, validation of ZA regs in signal handlers, include larger
  SVE and SME vector lengths in signal tests, various cleanups.

- arm64 alternatives (code patching) improvements to robustness and
  consistency: replace cpucap static branches with equivalent
  alternatives, associate callback alternatives with a cpucap.

- Miscellaneous updates: optimise kprobe performance of patching
  single-step slots, simplify uaccess_mask_ptr(), move MTE registers
  initialisation to C, support huge vmalloc() mappings, run softirqs on
  the per-CPU IRQ stack, compat (arm32) misalignment fixups for
  multiword accesses.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: compat: Implement misalignment fixups for multiword loads

Catalin Marinas (4):
      Merge branches 'for-next/doc', 'for-next/sve', 'for-next/sysreg', 'for-next/gettimeofday', 'for-next/stacktrace', 'for-next/atomics', 'for-next/el1-exceptions', 'for-next/a510-erratum-2658417', 'for-next/defconfig', 'for-next/tpidr2_el0' and 'for-next/ftrace', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/kselftest' into for-next/core
      Merge branch 'for-next/alternatives' into for-next/core
      Merge branch 'for-next/misc' into for-next/core

Colin Ian King (1):
      kselftest/arm64: Fix spelling misakes of signal names

James Clark (3):
      perf: arm64: Add SVE vector granule register to user regs
      arm64/sve: Add Perf extensions documentation
      arm64: defconfig: Add Coresight as module

James Morse (3):
      arm64: cpufeature: Force HWCAP to be based on the sysreg visible to user-space
      arm64: cpufeature: Expose get_arm64_ftr_reg() outside cpufeature.c
      arm64: errata: remove BF16 HWCAP due to incorrect result on Cortex-A510

Joey Gouly (3):
      arm64: module: move find_section to header
      arm64: alternative: patch alternatives in the vDSO
      arm64: vdso: use SYS_CNTVCTSS_EL0 for gettimeofday

Kefeng Wang (3):
      arm64: support huge vmalloc mappings
      arm64: defconfig: Enable memory hotplug and hotremove config
      arm64: mm: handle ARM64_KERNEL_USES_PMD_MAPS in vmemmap_populate()

Kristina Martsenko (3):
      arm64: cache: Remove unused CTR_CACHE_MINLINE_MASK
      arm64/sysreg: Standardise naming for ID_AA64MMFR1_EL1 fields
      arm64/sysreg: Convert ID_AA64MMFR1_EL1 to automatic generation

Li Huafei (2):
      arm64: module: Make plt_equals_entry() static
      arm64: module: Remove unused plt_entry_is_initialized()

Liao Chang (1):
      arm64/kprobe: Optimize the performance of patching single-step slot

Liu Song (1):
      arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually

Mark Brown (65):
      kselftest/arm64: Add simple hwcap validation
      kselftest/arm64: Always encourage preemption for za-test
      kselftest/arm64: Count SIGUSR2 deliveries in FP stress tests
      arm64/sve: Document our actual ABI for clearing registers on syscall
      arm64/sysreg: Add hwcap for SVE EBF16
      kselftest/arm64: Install signal handlers before output in FP stress tests
      kselftest/arm64: kselftest harness for FP stress tests
      kselftest/arm64: Tighten up validation of ZA signal context
      kselftest/arm64: Add a test for signal frames with ZA disabled
      kselftest/arm64: Enumerate SME rather than SVE vector lengths for za_regs
      kselftest/arm64: Validate signal ucontext in place
      kselftest/arm64: Fix validatation termination record after EXTRA_CONTEXT
      kselftest/arm64: Fix validation of EXTRA_CONTEXT signal context location
      kselftest/arm64: Remove unneeded protype for validate_extra_context()
      kselftest/arm64: Only validate each signal context once
      kselftest/arm64: Validate contents of EXTRA_CONTEXT blocks
      kselftest/arm64: Preserve any EXTRA_CONTEXT in handle_signal_copyctx()
      kselftest/arm64: Allow larger buffers in get_signal_context()
      kselftest/arm64: Include larger SVE and SME VLs in signal tests
      kselftest/arm64: Correct buffer allocation for SVE Z registers
      kselftest/arm64: Enforce actual ABI for SVE syscalls
      arm64/sysreg: Remove stray SMIDR_EL1 defines
      arm64/sysreg: Describe ID_AA64SMFR0_EL1.SMEVer as an enumeration
      arm64/sysreg: Add _EL1 into ID_AA64MMFR0_EL1 definition names
      arm64/sysreg: Add _EL1 into ID_AA64MMFR2_EL1 definition names
      arm64/sysreg: Add _EL1 into ID_AA64PFR0_EL1 definition names
      arm64/sysreg: Add _EL1 into ID_AA64PFR1_EL1 constant names
      arm64/sysreg: Standardise naming of ID_AA64MMFR0_EL1.BigEnd
      arm64/sysreg: Standardise naming of ID_AA64MMFR0_EL1.ASIDBits
      arm64/sysreg: Standardise naming for ID_AA64MMFR2_EL1.VARange
      arm64/sysreg: Standardise naming for ID_AA64MMFR2_EL1.CnP
      arm64/sysreg: Standardise naming for ID_AA64PFR0_EL1 constants
      arm64/sysreg: Standardise naming for ID_AA64PFR0_EL1.AdvSIMD constants
      arm64/sysreg: Standardise naming for SSBS feature enumeration
      arm64/sysreg: Standardise naming for MTE feature enumeration
      arm64/sysreg: Standardise naming of ID_AA64PFR1_EL1 fractional version fields
      arm64/sysreg: Standardise naming of ID_AA64PFR1_EL1 BTI enumeration
      arm64/sysreg: Standardise naming of ID_AA64PFR1_EL1 SME enumeration
      arm64/sysreg: Convert HCRX_EL2 to automatic generation
      arm64/sysreg: Convert ID_AA64MMFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64MMFR2_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64PFR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64PFR1_EL1 to automatic generation
      arm64/sysreg: Convert TIPDR_EL1 to automatic generation
      arm64/sysreg: Convert SCXTNUM_EL1 to automatic generation
      arm64/sysreg: Add defintion for ALLINT
      arm64/sysreg: Align field names in ID_AA64DFR0_EL1 with architecture
      arm64/sysreg: Add _EL1 into ID_AA64DFR0_EL1 definition names
      arm64/sysreg: Use feature numbering for PMU and SPE revisions
      arm64/sysreg: Convert ID_AA64FDR0_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64DFR1_EL1 to automatic generation
      arm64/sysreg: Convert ID_AA64AFRn_EL1 to automatic generation
      kselftest/arm64: Add missing newline in hwcap output
      kselftest/arm64: Add SVE 2 to the tested hwcaps
      kselftest/arm64: Add hwcap test for RNG
      arm64: configs: Enable all PMUs provided by Arm
      kselftest/arm64: Add test coverage for NT_ARM_TLS
      arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
      arm64/ptrace: Support access to TPIDR2_EL0
      kselftest/arm64: Add coverage of TPIDR2_EL0 ptrace interface
      kselftest/arm64: Fix typo in hwcap check
      kselftest/arm64: Don't enable v8.5 for MTE selftest builds
      kselftest/arm64: Don't repeat termination handler for fp-stress
      kselftest/arm64: Flag fp-stress as exiting when we begin finishing up
      kselftest/arm64: Handle EINTR while reading data from children

Mark Rutland (28):
      arm64: stacktrace: fix kerneldoc comments
      arm64: stacktrace: simplify unwind_next_common()
      arm64: stacktrace: rename unwind_next_common() -> unwind_next_frame_record()
      arm64: stacktrace: move SDEI stack helpers to stacktrace code
      arm64: stacktrace: add stackinfo_on_stack() helper
      arm64: stacktrace: rework stack boundary discovery
      arm64: stacktrace: remove stack type from fp translator
      arm64: stacktrace: track all stack boundaries explicitly
      arm64: stacktrace: track hyp stacks in unwinder's address space
      arm64: atomics: remove LL/SC trampolines
      arm64: atomic: always inline the assembly
      arm64: report EL1 UNDEFs better
      arm64: die(): pass 'err' as long
      arm64: consistently pass ESR_ELx to die()
      arm64: rework FPAC exception handling
      arm64: rework BTI exception handling
      arm64: cpufeature: make cpus_have_cap() noinstr-safe
      arm64: alternatives: kvm: prepare for cap changes
      arm64: alternatives: proton-pack: prepare for cap changes
      arm64: alternatives: hoist print out of __apply_alternatives()
      arm64: alternatives: make alt_region const
      arm64: alternatives: have callbacks take a cap
      arm64: alternatives: add alternative_has_feature_*()
      arm64: alternatives: add shared NOP callback
      arm64: avoid BUILD_BUG_ON() in alternative-macros
      arm64: uaccess: simplify uaccess_mask_ptr()
      arm64: fix the build with binutils 2.27
      arm64: ftrace: fix module PLTs with mcount

Mike Rapoport (1):
      arm64/mm: fold check for KFENCE into can_set_direct_map()

Nathan Chancellor (2):
      arm64/sysreg: Fix a few missed conversions
      arm64: alternatives: Use vdso/bits.h instead of linux/bits.h

Peter Collingbourne (1):
      arm64: mte: move register initialization to C

Qi Zheng (1):
      arm64: run softirqs on the per-CPU IRQ stack

Shuai Xue (3):
      docs: perf: Add description for Alibaba's T-Head PMU driver
      drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC
      MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver

Vincenzo Frascino (1):
      arm64: Enable docker support in defconfig

Will Deacon (2):
      arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()
      arm64: asm/perf_regs.h: Avoid C++-style comment in UAPI header

Xiu Jianfeng (1):
      ARM64: reloc_test: add __init/__exit annotations to module init/exit funcs

 Documentation/admin-guide/kernel-parameters.txt    |   7 +-
 Documentation/admin-guide/perf/alibaba_pmu.rst     | 100 +++
 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/arm64/elf_hwcaps.rst                 |   3 +
 Documentation/arm64/silicon-errata.rst             |   2 +
 Documentation/arm64/sme.rst                        |   3 +
 Documentation/arm64/sve.rst                        |  22 +-
 MAINTAINERS                                        |   6 +
 arch/arm64/Kconfig                                 |  18 +
 arch/arm64/configs/defconfig                       |  23 +
 arch/arm64/include/asm/alternative-macros.h        |  66 +-
 arch/arm64/include/asm/assembler.h                 |  20 +-
 arch/arm64/include/asm/atomic_ll_sc.h              |  58 +-
 arch/arm64/include/asm/atomic_lse.h                |  46 +-
 arch/arm64/include/asm/cache.h                     |   4 -
 arch/arm64/include/asm/cpufeature.h                |  83 ++-
 arch/arm64/include/asm/el2_setup.h                 |  18 +-
 arch/arm64/include/asm/exception.h                 |   9 +-
 arch/arm64/include/asm/hw_breakpoint.h             |   4 +-
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/kvm_mmu.h                   |   5 +-
 arch/arm64/include/asm/kvm_pgtable.h               |   6 +-
 arch/arm64/include/asm/lse.h                       |   5 +-
 arch/arm64/include/asm/module.h                    |  15 +-
 arch/arm64/include/asm/mte.h                       |   5 +
 arch/arm64/include/asm/processor.h                 |   2 +-
 arch/arm64/include/asm/sdei.h                      |  17 -
 arch/arm64/include/asm/stacktrace.h                |  71 +-
 arch/arm64/include/asm/stacktrace/common.h         | 221 +++---
 arch/arm64/include/asm/stacktrace/nvhe.h           |   4 +-
 arch/arm64/include/asm/sysreg.h                    | 211 +-----
 arch/arm64/include/asm/system_misc.h               |   2 +-
 arch/arm64/include/asm/uaccess.h                   |  22 +-
 arch/arm64/include/asm/vdso.h                      |   3 +
 arch/arm64/include/asm/vdso/gettimeofday.h         |  19 +-
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/include/uapi/asm/perf_regs.h            |   7 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/alternative.c                    |  94 ++-
 arch/arm64/kernel/compat_alignment.c               | 387 ++++++++++
 arch/arm64/kernel/cpu_errata.c                     |  26 +
 arch/arm64/kernel/cpufeature.c                     | 325 +++++----
 arch/arm64/kernel/cpuinfo.c                        |   1 +
 arch/arm64/kernel/debug-monitors.c                 |   2 +-
 arch/arm64/kernel/entry-common.c                   |  32 +-
 arch/arm64/kernel/entry.S                          |   8 +-
 arch/arm64/kernel/ftrace.c                         |  17 +-
 arch/arm64/kernel/head.S                           |  10 +-
 arch/arm64/kernel/hyp-stub.S                       |   8 +-
 arch/arm64/kernel/idreg-override.c                 |  10 +-
 arch/arm64/kernel/image-vars.h                     |   5 +-
 arch/arm64/kernel/irq.c                            |  14 +
 arch/arm64/kernel/module-plts.c                    |   3 +-
 arch/arm64/kernel/module.c                         |  15 -
 arch/arm64/kernel/mte.c                            |  51 ++
 arch/arm64/kernel/perf_event.c                     |   8 +-
 arch/arm64/kernel/perf_regs.c                      |  30 +-
 arch/arm64/kernel/probes/kprobes.c                 |  27 +-
 arch/arm64/kernel/proton-pack.c                    |  16 +-
 arch/arm64/kernel/ptrace.c                         |  27 +-
 arch/arm64/kernel/reloc_test_core.c                |   4 +-
 arch/arm64/kernel/sdei.c                           |  32 -
 arch/arm64/kernel/stacktrace.c                     |  66 +-
 arch/arm64/kernel/suspend.c                        |   2 +
 arch/arm64/kernel/traps.c                          |  48 +-
 arch/arm64/kernel/vdso.c                           |   3 -
 arch/arm64/kernel/vdso/vdso.lds.S                  |   7 +
 arch/arm64/kvm/debug.c                             |   4 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   4 +-
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h     |  60 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c                     |  38 +-
 arch/arm64/kvm/hyp/nvhe/stacktrace.c               |  40 +-
 arch/arm64/kvm/hyp/nvhe/sys_regs.c                 |  10 +-
 arch/arm64/kvm/hyp/pgtable.c                       |   2 +-
 arch/arm64/kvm/pmu-emul.c                          |  16 +-
 arch/arm64/kvm/reset.c                             |  12 +-
 arch/arm64/kvm/stacktrace.c                        | 137 ++--
 arch/arm64/kvm/sys_regs.c                          |  48 +-
 arch/arm64/kvm/va_layout.c                         |   5 +-
 arch/arm64/mm/context.c                            |   6 +-
 arch/arm64/mm/dma-mapping.c                        |   2 +-
 arch/arm64/mm/fault.c                              |   3 +
 arch/arm64/mm/init.c                               |   2 +-
 arch/arm64/mm/mmu.c                                |  23 +-
 arch/arm64/mm/pageattr.c                           |   8 +-
 arch/arm64/mm/proc.S                               |  46 +-
 arch/arm64/tools/cpucaps                           |   3 +
 arch/arm64/tools/sysreg                            | 449 +++++++++++-
 drivers/firmware/efi/libstub/arm64-stub.c          |   4 +-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |   4 +-
 drivers/hwtracing/coresight/coresight-trbe.h       |   3 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c    |   6 +-
 drivers/irqchip/irq-gic-v4.c                       |   2 +-
 drivers/perf/Kconfig                               |   7 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c              | 810 +++++++++++++++++++++
 drivers/perf/arm_pmu.c                             |   2 +-
 drivers/perf/arm_spe_pmu.c                         |   6 +-
 tools/testing/selftests/arm64/abi/.gitignore       |   2 +
 tools/testing/selftests/arm64/abi/Makefile         |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c          | 336 +++++++++
 tools/testing/selftests/arm64/abi/ptrace.c         | 241 ++++++
 tools/testing/selftests/arm64/abi/syscall-abi.c    |  61 +-
 tools/testing/selftests/arm64/fp/.gitignore        |   1 +
 tools/testing/selftests/arm64/fp/Makefile          |   5 +-
 tools/testing/selftests/arm64/fp/asm-offsets.h     |   1 +
 tools/testing/selftests/arm64/fp/fp-stress.c       | 555 ++++++++++++++
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |  51 +-
 tools/testing/selftests/arm64/fp/sve-test.S        |  51 +-
 tools/testing/selftests/arm64/fp/za-test.S         |  58 +-
 tools/testing/selftests/arm64/mte/Makefile         |   5 +-
 tools/testing/selftests/arm64/mte/mte_helper.S     |   2 +
 .../selftests/arm64/signal/test_signals_utils.c    |  59 +-
 .../selftests/arm64/signal/test_signals_utils.h    |   5 +-
 .../signal/testcases/fake_sigreturn_bad_magic.c    |   2 +-
 .../signal/testcases/fake_sigreturn_bad_size.c     |   2 +-
 .../testcases/fake_sigreturn_bad_size_for_magic0.c |   2 +-
 .../testcases/fake_sigreturn_duplicated_fpsimd.c   |   2 +-
 .../testcases/fake_sigreturn_misaligned_sp.c       |   2 +-
 .../testcases/fake_sigreturn_missing_fpsimd.c      |   2 +-
 .../testcases/fake_sigreturn_sme_change_vl.c       |   2 +-
 .../testcases/fake_sigreturn_sve_change_vl.c       |   2 +-
 .../selftests/arm64/signal/testcases/sme_vl.c      |   2 +-
 .../selftests/arm64/signal/testcases/ssve_regs.c   |  25 +-
 .../selftests/arm64/signal/testcases/sve_regs.c    |  23 +-
 .../selftests/arm64/signal/testcases/sve_vl.c      |   2 +-
 .../selftests/arm64/signal/testcases/testcases.c   |  48 +-
 .../selftests/arm64/signal/testcases/testcases.h   |   9 +-
 .../selftests/arm64/signal/testcases/za_no_regs.c  | 119 +++
 .../selftests/arm64/signal/testcases/za_regs.c     |  44 +-
 130 files changed, 4615 insertions(+), 1260 deletions(-)
 create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst
 create mode 100644 arch/arm64/kernel/compat_alignment.c
 create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c
 create mode 100644 tools/testing/selftests/arm64/abi/hwcap.c
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/fp-stress.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c
