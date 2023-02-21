Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7C969E637
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjBURrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234347AbjBURrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:47:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115621A16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:47:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A945BB8103C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D373C4339C;
        Tue, 21 Feb 2023 17:46:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.3
Date:   Tue, 21 Feb 2023 17:46:53 +0000
Message-Id: <20230221174653.872251-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below. They are mostly contained within
the usual arm64 files and perf drivers, apart from a few changes under
kernel/ needed for the DYNAMIC_FTRACE_WITH_CALL_OPS. There are a couple
of minor conflicts with mainline, see my resolution below. Thanks.

diff --cc arch/arm64/Kconfig
index c5ccca26a408,619ab046744a..27b2592698b0
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@@ -184,6 -186,10 +186,8 @@@ config ARM6
  	select HAVE_DEBUG_KMEMLEAK
  	select HAVE_DMA_CONTIGUOUS
  	select HAVE_DYNAMIC_FTRACE
 -	select HAVE_DYNAMIC_FTRACE_WITH_ARGS \
 -		if $(cc-option,-fpatchable-function-entry=2)
+ 	select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
+ 		if (DYNAMIC_FTRACE_WITH_ARGS && !CFI_CLANG)
  	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
  		if DYNAMIC_FTRACE_WITH_ARGS
  	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --cc arch/arm64/kernel/ptrace.c
index 0c321ad23cd3,143a971d7511..d7f4f0d1ae12
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@@ -1357,9 -1402,10 +1402,10 @@@ enum aarch64_regset 
  #ifdef CONFIG_ARM64_SVE
  	REGSET_SVE,
  #endif
 -#ifdef CONFIG_ARM64_SVE
 +#ifdef CONFIG_ARM64_SME
  	REGSET_SSVE,
  	REGSET_ZA,
+ 	REGSET_ZT,
  #endif
  #ifdef CONFIG_ARM64_PTR_AUTH
  	REGSET_PAC_MASK,

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to d54170812ef1c80e0fa3ed3e554a0bbfc2920d9d:

  arm64: fix .idmap.text assertion for large kernels (2023-02-20 18:23:35 +0000)

----------------------------------------------------------------
arm64 updates for 6.3:

- Support for arm64 SME 2 and 2.1. SME2 introduces a new 512-bit
  architectural register (ZT0, for the look-up table feature) that Linux
  needs to save/restore.

- Include TPIDR2 in the signal context and add the corresponding
  kselftests.

- Perf updates: Arm SPEv1.2 support, HiSilicon uncore PMU updates, ACPI
  support to the Marvell DDR and TAD PMU drivers, reset DTM_PMU_CONFIG
  (ARM CMN) at probe time.

- Support for DYNAMIC_FTRACE_WITH_CALL_OPS on arm64.

- Permit EFI boot with MMU and caches on. Instead of cleaning the entire
  loaded kernel image to the PoC and disabling the MMU and caches before
  branching to the kernel bare metal entry point, leave the MMU and
  caches enabled and rely on EFI's cacheable 1:1 mapping of all of
  system RAM to populate the initial page tables.

- Expose the AArch32 (compat) ELF_HWCAP features to user in an arm64
  kernel (the arm32 kernel only defines the values).

- Harden the arm64 shadow call stack pointer handling: stash the shadow
  stack pointer in the task struct on interrupt, load it directly from
  this structure.

- Signal handling cleanups to remove redundant validation of size
  information and avoid reading the same data from userspace twice.

- Refactor the hwcap macros to make use of the automatically generated
  ID registers. It should make new hwcaps writing less error prone.

- Further arm64 sysreg conversion and some fixes.

- arm64 kselftest fixes and improvements.

- Pointer authentication cleanups: don't sign leaf functions, unify
  asm-arch manipulation.

- Pseudo-NMI code generation optimisations.

- Minor fixes for SME and TPIDR2 handling.

- Miscellaneous updates: ARCH_FORCE_MAX_ORDER is now selectable, replace
  strtobool() to kstrtobool() in the cpufeature.c code, apply dynamic
  shadow call stack in two passes, intercept pfn changes in set_pte_at()
  without the required break-before-make sequence, attempt to dump all
  instructions on unhandled kernel faults.

----------------------------------------------------------------
Amit Daniel Kachhap (7):
      arm64: Add compat hwcap FPHP and ASIMDHP
      arm64: Add compat hwcap ASIMDDP
      arm64: Add compat hwcap ASIMDFHM
      arm64: Add compat hwcap ASIMDBF16
      arm64: Add compat hwcap I8MM
      arm64: Add compat hwcap SB
      arm64: Add compat hwcap SSBS

Anshuman Khandual (1):
      arm64/mm: Intercept pfn changes in set_pte_at()

Ard Biesheuvel (11):
      arm64: Always load shadow stack pointer directly from the task struct
      arm64: Stash shadow stack pointer in the task struct on interrupt
      arm64: head: Move all finalise_el2 calls to after __enable_mmu
      arm64: kernel: move identity map out of .text mapping
      arm64: head: record the MMU state at primary entry
      arm64: head: avoid cache invalidation when entering with the MMU on
      arm64: head: Clean the ID map and the HYP text to the PoC if needed
      efi: arm64: enter with MMU and caches enabled
      arm64: head: Switch endianness before populating the ID map
      arm64: Apply dynamic shadow call stack patching in two passes
      arm64: kprobes: Drop ID map text from kprobes blacklist

Catalin Marinas (5):
      Merge branches 'for-next/sysreg', 'for-next/compat-hwcap' and 'for-next/sme2' into for-next/sysreg-hwcaps
      Merge branches 'for-next/tpidr2' and 'for-next/sme2' into for-next/signal
      Merge branches 'for-next/sysreg', 'for-next/sme', 'for-next/kselftest', 'for-next/misc', 'for-next/sme2', 'for-next/tpidr2', 'for-next/scs', 'for-next/compat-hwcap', 'for-next/ftrace', 'for-next/efi-boot-mmu-on', 'for-next/ptrauth' and 'for-next/pseudo-nmi', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/sysreg-hwcaps' into for-next/core
      Merge branch 'for-next/signal' into for-next/core

Christophe JAILLET (1):
      arm64: cpufeature: Use kstrtobool() instead of strtobool()

Gabriel Krisman Bertazi (1):
      arm64: Avoid repeated AA64MMFR1_EL1 register read on pagefault path

Gowthami Thiagarajan (2):
      perf/marvell: Add ACPI support to DDR uncore driver
      perf/marvell: Add ACPI support to TAD uncore driver

Junhao He (3):
      drivers/perf: hisi: Advertise the PERF_PMU_CAP_NO_EXCLUDE capability
      drivers/perf: hisi: Simplify the parameters of hisi_pmu_init()
      drivers/perf: hisi: Extract initialization of "cpa_pmu->pmu"

Kefeng Wang (1):
      arm64: make ARCH_FORCE_MAX_ORDER selectable

Marc Zyngier (1):
      arm64/sme: Fix __finalise_el2 SMEver check

Mark Brown (68):
      arm64/cpufeature: Fix field sign for DIT hwcap detection
      arm64/sysreg: Fix errors in 32 bit enumeration values
      arm64/cpufeature: Remove 4 bit assumption in ARM64_FEATURE_MASK()
      arm64/ptrace: Use system_supports_tpidr2() to check for TPIDR2 support
      arm64/sme: Don't use streaming mode to probe the maximum SME VL
      kselftest/arm64: Fix syscall-abi for systems without 128 bit SME
      kselftest/arm64: Only enumerate VLs once in syscall-abi
      kselftest/arm64: Verify SME only ABI in syscall-abi
      kselftest/arm64: Only enumerate power of two VLs in syscall-abi
      kselftest/arm64: Skip non-power of 2 SVE vector lengths in fp-stress
      arm64/sysreg: Add definition for ICC_NMIAR1_EL1
      arm64/sysreg: Add definition of ISR_EL1
      KVM: arm64: Use symbolic definition for ISR_EL1.A
      arm64/sme: Optimise SME exit on syscall entry
      kselftest/arm64: Fix test numbering when skipping tests
      kselftest/arm64: Run BTI selftests on systems without BTI
      arm64/sme: Rename za_state to sme_state
      arm64: Document boot requirements for SME 2
      arm64/sysreg: Update system registers for SME 2 and 2.1
      arm64/sme: Document SME 2 and SME 2.1 ABI
      arm64/esr: Document ISS for ZT0 being disabled
      arm64/sme: Manually encode ZT0 load and store instructions
      arm64/sme: Enable host kernel to access ZT0
      arm64/sme: Add basic enumeration for SME2
      arm64/sme: Provide storage for ZT0
      arm64/sme: Implement context switching for ZT0
      arm64/sme: Implement signal handling for ZT
      arm64/sme: Implement ZT0 ptrace support
      arm64/sme: Add hwcaps for SME 2 and 2.1 features
      kselftest/arm64: Add a stress test program for ZT0
      kselftest/arm64: Cover ZT in the FP stress test
      kselftest/arm64: Enumerate SME2 in the signal test utility code
      kselftest/arm64: Teach the generic signal context validation about ZT
      kselftest/arm64: Add test coverage for ZT register signal frames
      kselftest/arm64: Add SME2 coverage to syscall-abi
      kselftest/arm64: Add coverage of the ZT ptrace regset
      kselftest/arm64: Add coverage of SME 2 and 2.1 hwcaps
      arm64/sme: Document ABI for TPIDR2 signal information
      arm64/signal: Include TPIDR2 in the signal context
      kselftest/arm64: Add TPIDR2 to the set of known signal context records
      kselftest/arm64: Add test case for TPIDR2 signal frame records
      kselftest/arm64: Fix .pushsection for strings in FP tests
      kselftest/arm64: Remove redundant _start labels from FP tests
      kselftest/arm64: Don't pass headers to the compiler as source
      kselftest/arm64: Initialise current at build time in signal tests
      kselftest/arm64: Support build of MTE tests with clang
      kselftest/arm64: Remove spurious comment from MTE test Makefile
      kselftest/arm64: Verify that SSVE signal context has SVE_SIG_FLAG_SM set
      kselftest/arm64: Verify simultaneous SSVE and ZA context generation
      kselftest/arm64: Limit the maximum VL we try to set via ptrace
      kselftest/arm64: Remove redundant _start labels from zt-test
      kselftest/arm64: Don't require FA64 for streaming SVE tests
      kselftest/arm64: Fix enumeration of systems without 128 bit SME
      kselftest/arm64: Fix enumeration of systems without 128 bit SME for SSVE+ZA
      arm64/sysreg: Allow enumerations to be declared as signed or unsigned
      arm64/sysreg: Initial annotation of signed ID registers
      arm64/sysreg: Initial unsigned annotations for ID registers
      arm64/cpufeature: Always use symbolic name for feature value in hwcaps
      arm64/cpufeature: Use helper macros to specify hwcaps
      arm64/signal: Don't redundantly verify FPSIMD magic
      arm64/signal: Remove redundant size validation from parse_user_sigframe()
      arm64/signal: Make interface for restore_fpsimd_context() consistent
      arm64/signal: Avoid rereading context frame sizes
      arm64/signal: Only read new data when parsing the SVE context
      arm64/signal: Only read new data when parsing the ZA context
      arm64/signal: Only read new data when parsing the ZT context
      kselftest/arm64: Copy whole EXTRA context
      kselftest/arm64: Don't require FA64 for streaming SVE+ZA tests

Mark Rutland (18):
      ftrace: Add DYNAMIC_FTRACE_WITH_CALL_OPS
      Compiler attributes: GCC cold function alignment workarounds
      ACPI: Don't build ACPICA with '-Os'
      arm64: Extend support for CONFIG_FUNCTION_ALIGNMENT
      arm64: insn: Add helpers for BTI
      arm64: patching: Add aarch64_insn_write_literal_u64()
      arm64: ftrace: Update stale comment
      arm64: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
      arm64: avoid executing padding bytes during kexec / hibernation
      arm64: traps: attempt to dump all instructions
      arm64: unify asm-arch manipulation
      arm64: pauth: don't sign leaf functions
      arm64: rename ARM64_HAS_SYSREG_GIC_CPUIF to ARM64_HAS_GIC_CPUIF_SYSREGS
      arm64: rename ARM64_HAS_IRQ_PRIO_MASKING to ARM64_HAS_GIC_PRIO_MASKING
      arm64: make ARM64_HAS_GIC_PRIO_MASKING depend on ARM64_HAS_GIC_CPUIF_SYSREGS
      arm64: add ARM64_HAS_GIC_PRIO_RELAXED_SYNC cpucap
      arm64: irqflags: use alternative branches for pseudo-NMI logic
      arm64: fix .idmap.text assertion for large kernels

Prathu Baronia (1):
      arm64: el2_setup.h: fix spelling typo in comments

Randy Dunlap (2):
      arm64: Kconfig: fix spelling
      Documentation: arm64: correct spelling

Rob Herring (9):
      perf: arm_spe: Use feature numbering for PMSEVFR_EL1 defines
      arm64: Drop SYS_ from SPE register defines
      arm64/sysreg: Convert SPE registers to automatic generation
      perf: arm_spe: Drop BIT() and use FIELD_GET/PREP accessors
      perf: arm_spe: Use new PMSIDR_EL1 register enums
      perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
      perf: Add perf_event_attr::config3
      perf: arm_spe: Add support for SPEv1.2 inverted event filtering
      perf: arm_spe: Print the version of SPE detected

Robin Murphy (1):
      perf/arm-cmn: Reset DTM_PMU_CONFIG at probe

Sascha Hauer (1):
      drivers/perf: fsl_imx8_ddr_perf: Remove set-but-not-used variable

Zenghui Yu (2):
      kselftest/arm64: Remove the local NUM_VL definition
      kselftest/arm64: Correct buffer size for SME ZA storage

 Documentation/arm64/booting.rst                    |  12 +-
 Documentation/arm64/elf_hwcaps.rst                 |  20 +-
 Documentation/arm64/sme.rst                        |  55 +-
 Documentation/arm64/sve.rst                        |   4 +-
 arch/arm/include/asm/arch_gicv3.h                  |   5 +
 arch/arm64/Kconfig                                 |  25 +-
 arch/arm64/Kconfig.platforms                       |   2 +-
 arch/arm64/Makefile                                |  70 ++-
 arch/arm64/include/asm/arch_gicv3.h                |   5 +
 arch/arm64/include/asm/barrier.h                   |  11 +-
 arch/arm64/include/asm/cpufeature.h                |  14 +-
 arch/arm64/include/asm/efi.h                       |   2 +
 arch/arm64/include/asm/el2_setup.h                 |   8 +-
 arch/arm64/include/asm/esr.h                       |   1 +
 arch/arm64/include/asm/fpsimd.h                    |  30 +-
 arch/arm64/include/asm/fpsimdmacros.h              |  22 +
 arch/arm64/include/asm/ftrace.h                    |  15 +-
 arch/arm64/include/asm/hwcap.h                     |  14 +
 arch/arm64/include/asm/insn.h                      |   1 +
 arch/arm64/include/asm/irqflags.h                  | 191 ++++---
 arch/arm64/include/asm/linkage.h                   |   4 +-
 arch/arm64/include/asm/patching.h                  |   2 +
 arch/arm64/include/asm/pgtable.h                   |   8 +-
 arch/arm64/include/asm/processor.h                 |   2 +-
 arch/arm64/include/asm/ptrace.h                    |   2 +-
 arch/arm64/include/asm/scs.h                       |   7 +-
 arch/arm64/include/asm/sysreg.h                    | 106 +---
 arch/arm64/include/uapi/asm/hwcap.h                |   6 +
 arch/arm64/include/uapi/asm/sigcontext.h           |  27 +
 arch/arm64/kernel/asm-offsets.c                    |   4 +
 arch/arm64/kernel/cpufeature.c                     | 293 ++++++-----
 arch/arm64/kernel/cpuinfo.c                        |  14 +
 arch/arm64/kernel/entry-fpsimd.S                   |  30 +-
 arch/arm64/kernel/entry-ftrace.S                   |  32 +-
 arch/arm64/kernel/entry.S                          |  41 +-
 arch/arm64/kernel/fpsimd.c                         |  52 +-
 arch/arm64/kernel/ftrace.c                         | 158 +++++-
 arch/arm64/kernel/head.S                           | 116 ++++-
 arch/arm64/kernel/hyp-stub.S                       |   7 +
 arch/arm64/kernel/idreg-override.c                 |   1 +
 arch/arm64/kernel/image-vars.h                     |   7 +-
 arch/arm64/kernel/patch-scs.c                      |  11 +-
 arch/arm64/kernel/patching.c                       |  17 +
 arch/arm64/kernel/probes/kprobes.c                 |   4 -
 arch/arm64/kernel/process.c                        |  21 +-
 arch/arm64/kernel/ptrace.c                         |  64 ++-
 arch/arm64/kernel/setup.c                          |  17 +-
 arch/arm64/kernel/signal.c                         | 259 ++++++++--
 arch/arm64/kernel/sleep.S                          |   6 +-
 arch/arm64/kernel/syscall.c                        |   8 +-
 arch/arm64/kernel/traps.c                          |   6 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   8 +-
 arch/arm64/kvm/debug.c                             |   2 +-
 arch/arm64/kvm/fpsimd.c                            |   2 +-
 arch/arm64/kvm/hyp/entry.S                         |   2 +-
 arch/arm64/kvm/hyp/nvhe/debug-sr.c                 |   2 +-
 arch/arm64/mm/cache.S                              |   1 +
 arch/arm64/mm/mmu.c                                |   8 +-
 arch/arm64/mm/proc.S                               |   2 -
 arch/arm64/tools/cpucaps                           |   6 +-
 arch/arm64/tools/gen-sysreg.awk                    |  29 ++
 arch/arm64/tools/sysreg                            | 560 ++++++++++++++-------
 drivers/acpi/acpica/Makefile                       |   2 +-
 drivers/firmware/efi/libstub/Makefile              |   4 +-
 drivers/firmware/efi/libstub/arm64-entry.S         |  67 ---
 drivers/firmware/efi/libstub/arm64-stub.c          |  26 +-
 drivers/firmware/efi/libstub/arm64.c               |  41 +-
 drivers/irqchip/irq-gic-v3.c                       |  19 +-
 drivers/irqchip/irq-gic.c                          |   2 +-
 drivers/perf/arm-cmn.c                             |   1 +
 drivers/perf/arm_spe_pmu.c                         | 160 +++---
 drivers/perf/fsl_imx8_ddr_perf.c                   |   3 -
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c       |  16 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   9 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |   4 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   2 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c               |  10 +
 drivers/perf/marvell_cn10k_tad_pmu.c               |  22 +-
 include/linux/compiler_attributes.h                |   6 -
 include/linux/compiler_types.h                     |  27 +
 include/linux/ftrace.h                             |  18 +-
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/perf_event.h                    |   3 +
 kernel/exit.c                                      |   9 +-
 kernel/trace/Kconfig                               |   7 +
 kernel/trace/ftrace.c                              | 109 +++-
 tools/testing/selftests/arm64/abi/hwcap.c          | 115 +++++
 .../testing/selftests/arm64/abi/syscall-abi-asm.S  |  57 ++-
 tools/testing/selftests/arm64/abi/syscall-abi.c    | 179 ++++---
 tools/testing/selftests/arm64/bti/test.c           |  25 +-
 tools/testing/selftests/arm64/fp/.gitignore        |   2 +
 tools/testing/selftests/arm64/fp/Makefile          |   5 +
 tools/testing/selftests/arm64/fp/assembler.h       |   2 +-
 tools/testing/selftests/arm64/fp/fp-pidbench.S     |   1 -
 tools/testing/selftests/arm64/fp/fp-stress.c       |  34 +-
 tools/testing/selftests/arm64/fp/fpsimd-test.S     |   1 -
 tools/testing/selftests/arm64/fp/sme-inst.h        |  20 +
 tools/testing/selftests/arm64/fp/sve-ptrace.c      |  14 +-
 tools/testing/selftests/arm64/fp/sve-test.S        |   1 -
 tools/testing/selftests/arm64/fp/za-ptrace.c       |  14 +-
 tools/testing/selftests/arm64/fp/za-test.S         |   1 -
 tools/testing/selftests/arm64/fp/zt-ptrace.c       | 365 ++++++++++++++
 tools/testing/selftests/arm64/fp/zt-test.S         | 316 ++++++++++++
 tools/testing/selftests/arm64/mte/Makefile         |  21 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   2 +
 tools/testing/selftests/arm64/signal/Makefile      |   8 +-
 .../testing/selftests/arm64/signal/test_signals.c  |   4 +-
 .../testing/selftests/arm64/signal/test_signals.h  |   2 +
 .../selftests/arm64/signal/test_signals_utils.c    |   9 +-
 .../selftests/arm64/signal/testcases/ssve_regs.c   |  16 +-
 .../arm64/signal/testcases/ssve_za_regs.c          | 161 ++++++
 .../selftests/arm64/signal/testcases/testcases.c   |  40 ++
 .../selftests/arm64/signal/testcases/testcases.h   |   1 +
 .../arm64/signal/testcases/tpidr2_siginfo.c        |  90 ++++
 .../selftests/arm64/signal/testcases/za_regs.c     |   4 +
 .../selftests/arm64/signal/testcases/zt_no_regs.c  |  51 ++
 .../selftests/arm64/signal/testcases/zt_regs.c     |  85 ++++
 121 files changed, 3632 insertions(+), 1051 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/arm64-entry.S
 create mode 100644 tools/testing/selftests/arm64/fp/zt-ptrace.c
 create mode 100644 tools/testing/selftests/arm64/fp/zt-test.S
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/ssve_za_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/tpidr2_siginfo.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_regs.c
