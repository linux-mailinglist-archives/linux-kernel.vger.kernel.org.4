Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D3D73E6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFZRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFZRom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1DAC2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80D5A60F12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 17:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716C9C433C0;
        Mon, 26 Jun 2023 17:44:37 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 updates for 6.5
Date:   Mon, 26 Jun 2023 18:44:35 +0100
Message-Id: <20230626174435.1791242-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 updates below for 6.5. Notable features are
user-space support for the memcpy/memset instructions and the permission
indirection extension. Depending on the order you receive/merge the pull
requests, there is a conflict in linux-next for Documentation/arm64/
(Jon is moving those files under Documentation/arch/) and another
trivial conflict with the kvmarm tree (I think Oliver already pulled
some of the relevant arm64 branches where the resolution was not
obvious).

Thanks.

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

for you to fetch changes up to abc17128c81ae8d6a091f24348c63cbe8fe59724:

  Merge branch 'for-next/feat_s1pie' into for-next/core (2023-06-23 18:34:16 +0100)

----------------------------------------------------------------
arm64 updates for 6.5:

- Support for the Armv8.9 Permission Indirection Extensions. While this
  feature doesn't add new functionality, it enables future support for
  Guarded Control Stacks (GCS) and Permission Overlays.

- User-space support for the Armv8.8 memcpy/memset instructions.

- arm64 perf: support the HiSilicon SoC uncore PMU, Arm CMN sysfs
  identifier, support for the NXP i.MX9 SoC DDRC PMU, fixes and
  cleanups.

- Removal of superfluous ISBs on context switch (following retrospective
  architecture tightening).

- Decode the ISS2 register during faults for additional information to
  help with debugging.

- KPTI clean-up/simplification of the trampoline exit code.

- Addressing several -Wmissing-prototype warnings.

- Kselftest improvements for signal handling and ptrace.

- Fix TPIDR2_EL0 restoring on sigreturn

- Clean-up, robustness improvements of the module allocation code.

- More sysreg conversions to the automatic register/bitfields
  generation.

- CPU capabilities handling cleanup.

- Arm documentation updates: ACPI, ptdump.

----------------------------------------------------------------
Anshuman Khandual (14):
      arm64/sysreg: Rename TRBLIMITR_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBPTR_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBBASER_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBSR_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBMAR_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBTRG_EL1 fields per auto-gen tools format
      arm64/sysreg: Rename TRBIDR_EL1 fields per auto-gen tools format
      arm64/sysreg: Convert TRBLIMITR_EL1 register to automatic generation
      arm64/sysreg: Convert TRBPTR_EL1 register to automatic generation
      arm64/sysreg: Convert TRBBASER_EL1 register to automatic generation
      arm64/sysreg: Convert TRBSR_EL1 register to automatic generation
      arm64/sysreg: Convert TRBMAR_EL1 register to automatic generation
      arm64/sysreg: Convert TRBTRG_EL1 register to automatic generation
      arm64/sysreg: Convert TRBIDR_EL1 register to automatic generation

Ard Biesheuvel (2):
      arm64: entry: Preserve/restore X29 even for compat tasks
      arm64: entry: Simplify tramp_alias macro and tramp_exit routine

Arnd Bergmann (15):
      arm64: xor-neon: mark xor_arm64_neon_*() static
      arm64: add scs_patch_vmlinux prototype
      arm64: avoid prototype warnings for syscalls
      arm64: move cpu_suspend_set_dbg_restorer() prototype to header
      arm64: spectre: provide prototypes for internal functions
      arm64: kvm: add prototypes for functions called in asm
      arm64: cpuidle: fix #ifdef for acpi functions
      arm64: efi: add efi_handle_corrupted_x18 prototype
      arm64: hide unused is_valid_bugaddr()
      arm64: module-plts: inline linux/moduleloader.h
      arm64: flush: include linux/libnvdimm.h
      arm64: kaslr: add kaslr_early_init() declaration
      arm64: signal: include asm/exception.h
      arm64: move early_brk64 prototype to header
      arm64: add alt_cb_patch_nops prototype

Baoquan He (3):
      arm64: kdump: simplify the reservation behaviour of crashkernel=,high
      Documentation: add kdump.rst to present crashkernel reservation on arm64
      arm64: add kdump.rst into index.rst

Catalin Marinas (2):
      Merge branches 'for-next/kpti', 'for-next/missing-proto-warn', 'for-next/iss2-decode', 'for-next/kselftest', 'for-next/misc', 'for-next/feat_mops', 'for-next/module-alloc', 'for-next/sysreg', 'for-next/cpucap', 'for-next/acpi', 'for-next/kdump', 'for-next/acpi-doc', 'for-next/doc' and 'for-next/tpidr2-fix', remote-tracking branch 'arm64/for-next/perf' into for-next/core
      Merge branch 'for-next/feat_s1pie' into for-next/core

Chaitanya S Prakash (1):
      Documentation/arm64: Add ptdump documentation

Christophe JAILLET (2):
      perf/arm-cci: Slightly optimize cci_pmu_sync_counters()
      perf: qcom_l2_pmu: Make l2_cache_pmu_probe_cluster() more robust

Eric Chan (1):
      arm64: lockdep: enable checks for held locks when returning to userspace

Guo Hui (1):
      arm64: syscall: unmask DAIF for tracing status

Ilkka Koskinen (2):
      perf: arm_cspmu: Set irq affinitiy only if overflow interrupt is used
      perf: arm_cspmu: Add missing MODULE_DEVICE_TABLE

Jamie Iles (1):
      arm64/mm: remove now-superfluous ISBs from TTBR writes

Joey Gouly (20):
      arm64/sysreg: Add ID register ID_AA64MMFR3
      arm64/sysreg: add system registers TCR2_ELx
      arm64/sysreg: update HCRX_EL2 register
      arm64/sysreg: add PIR*_ELx registers
      arm64: cpufeature: add system register ID_AA64MMFR3
      arm64: cpufeature: add TCR2 cpucap
      arm64: cpufeature: add Permission Indirection Extension cpucap
      KVM: arm64: Save/restore TCR2_EL1
      KVM: arm64: Save/restore PIE registers
      KVM: arm64: expose ID_AA64MMFR3_EL1 to guests
      arm64: add PTE_UXN/PTE_WRITE to SWAPPER_*_FLAGS
      arm64: add PTE_WRITE to PROT_SECT_NORMAL
      arm64: reorganise PAGE_/PROT_ macros
      arm64: disable EL2 traps for PIE
      arm64: add encodings of PIRx_ELx registers
      arm64: enable Permission Indirection Extension (PIE)
      arm64: transfer permission indirection settings to EL2
      arm64: Document boot requirements for PIE
      KVM: selftests: get-reg-list: support ID register features
      KVM: selftests: get-reg-list: add Permission Indirection registers

Jose Marinho (3):
      Documentation/arm64: Update ARM and arch reference
      Documentation/arm64: Update references in arm-acpi
      Documentation/arm64: Update ACPI tables from BBR

Junhao He (4):
      drivers/perf: hisi: Don't migrate perf to the CPU going to teardown
      drivers/perf: hisi: Add support for HiSilicon H60PA and PAv3 PMU driver
      drivers/perf: hisi: Add support for HiSilicon UC PMU driver
      docs: perf: Add new description for HiSilicon UC PMU

Kristina Martsenko (11):
      KVM: arm64: initialize HCRX_EL2
      arm64: cpufeature: detect FEAT_HCX
      KVM: arm64: switch HCRX_EL2 between host and guest
      arm64: mops: document boot requirements for MOPS
      arm64: mops: don't disable host MOPS instructions from EL2
      KVM: arm64: hide MOPS from guests
      arm64: mops: handle MOPS exceptions
      arm64: mops: handle single stepping after MOPS exception
      arm64: mops: detect and enable FEAT_MOPS
      arm64: mops: allow disabling MOPS from the kernel command line
      kselftest/arm64: add MOPS to hwcap test

Marc Zyngier (1):
      drivers/perf: apple_m1: Force 63bit counters for M2 CPUs

Mark Brown (15):
      arm64/esr: Use GENMASK() for the ISS mask
      arm64/esr: Add decode of ISS2 to data abort reporting
      kselftest/arm64: Add a smoke test for ptracing hardware break/watch points
      arm64/cpufeature: Use helper for ECV CNTPOFF cpufeature
      arm64/sysreg: Convert MDCCINT_EL1 to automatic register generation
      arm64/sysreg: Convert MDSCR_EL1 to automatic register generation
      arm64/sysreg: Standardise naming of bitfield constants in OSL[AS]R_EL1
      arm64/sysreg: Convert OSLAR_EL1 to automatic generation
      arm64/sysreg: Convert OSDTRRX_EL1 to automatic generation
      arm64/sysreg: Convert OSDTRTX_EL1 to automatic generation
      arm64/sysreg: Convert OSECCR_EL1 to automatic generation
      arm64/fpsimd: Exit streaming mode when flushing tasks
      kselftest/arm64: Log signal code and address for unexpected signals
      arm64/signal: Restore TPIDR2 register rather than memory state
      kselftest/arm64: Add a test case for TPIDR2 restore

Mark Rutland (12):
      arm64: module: remove old !KASAN_VMALLOC logic
      arm64: kasan: remove !KASAN_VMALLOC remnants
      arm64: kaslr: split kaslr/module initialization
      arm64: module: move module randomization to module.c
      arm64: module: mandate MODULE_PLTS
      arm64: module: rework module VA range selection
      arm64: standardise cpucap bitmap names
      arm64: alternatives: use cpucap naming
      arm64: cpufeature: use cpucap naming
      arm64: cpufeature: fold cpus_set_cap() into update_cpu_capabilities()
      arm64: mm: fix VA-range sanity check
      arm64: alternatives: make clean_dcache_range_nopatch() noinstr-safe

Prathu Baronia (1):
      arm64/cpucaps: increase string width to properly format cpucaps.h

Robin Murphy (7):
      perf/arm-cmn: Fix DTC reset
      perf/arm_cspmu: Fix event attribute type
      ACPI/APMT: Don't register invalid resource
      perf/arm_cspmu: Clean up ACPI dependency
      perf/arm_cspmu: Decouple APMT dependency
      perf/arm-cmn: Revamp model detection
      perf/arm-cmn: Add sysfs identifier

Russell King (1):
      arm64: consolidate rox page protection logic

Song Shuai (1):
      arm64: hibernate: remove WARN_ON in save_processor_state

Sudeep Holla (1):
      ACPI: bus: Consolidate all arm specific initialisation into acpi_arm_init()

Will Deacon (1):
      docs: perf: Fix warning from 'make htmldocs' in hisi-pmu.rst

Xin Yang (1):
      perf/arm_dmc620: Add cpumask

Xu Yang (2):
      drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver
      dt-bindings: perf: fsl-imx-ddr: Add i.MX93 compatible

Youngmin Nam (1):
      arm64: set __exception_irq_entry with __irq_entry as a default

 Documentation/admin-guide/kernel-parameters.txt    |   3 +
 Documentation/admin-guide/perf/hisi-pmu.rst        |  40 +-
 Documentation/arm64/acpi_object_usage.rst          |  81 ++-
 Documentation/arm64/arm-acpi.rst                   | 165 +++--
 Documentation/arm64/booting.rst                    |  32 +
 Documentation/arm64/cpu-feature-registers.rst      |   2 +
 Documentation/arm64/elf_hwcaps.rst                 |   3 +
 Documentation/arm64/index.rst                      |   2 +
 Documentation/arm64/kdump.rst                      |  92 +++
 Documentation/arm64/memory.rst                     |   8 +-
 Documentation/arm64/ptdump.rst                     |  96 +++
 .../devicetree/bindings/perf/fsl-imx-ddr.yaml      |   3 +-
 arch/arm64/Kconfig                                 |  28 +-
 arch/arm64/include/asm/alternative-macros.h        |  54 +-
 arch/arm64/include/asm/alternative.h               |   7 +-
 arch/arm64/include/asm/archrandom.h                |   2 +
 arch/arm64/include/asm/asm-uaccess.h               |   2 -
 arch/arm64/include/asm/compat.h                    |   2 +
 arch/arm64/include/asm/cpu.h                       |   1 +
 arch/arm64/include/asm/cpufeature.h                |  24 +-
 arch/arm64/include/asm/efi.h                       |   2 +
 arch/arm64/include/asm/el2_setup.h                 |  31 +-
 arch/arm64/include/asm/esr.h                       |  30 +-
 arch/arm64/include/asm/exception.h                 |   6 +-
 arch/arm64/include/asm/hw_breakpoint.h             |   8 +
 arch/arm64/include/asm/hwcap.h                     |   1 +
 arch/arm64/include/asm/irqflags.h                  |   2 +-
 arch/arm64/include/asm/kernel-pgtable.h            |   8 +-
 arch/arm64/include/asm/kvm_arm.h                   |   4 +
 arch/arm64/include/asm/kvm_asm.h                   |  18 +
 arch/arm64/include/asm/kvm_host.h                  |   7 +-
 arch/arm64/include/asm/lse.h                       |   2 +-
 arch/arm64/include/asm/memory.h                    |  16 +-
 arch/arm64/include/asm/mmu_context.h               |  10 +-
 arch/arm64/include/asm/module.h                    |   8 -
 arch/arm64/include/asm/module.lds.h                |   2 -
 arch/arm64/include/asm/pgtable-hwdef.h             |   8 +
 arch/arm64/include/asm/pgtable-prot.h              | 122 +++-
 arch/arm64/include/asm/scs.h                       |   1 +
 arch/arm64/include/asm/spectre.h                   |  16 +
 arch/arm64/include/asm/syscall_wrapper.h           |   4 +
 arch/arm64/include/asm/sysreg.h                    |  85 +--
 arch/arm64/include/asm/traps.h                     |   2 +
 arch/arm64/include/asm/uaccess.h                   |   2 -
 arch/arm64/include/uapi/asm/hwcap.h                |   1 +
 arch/arm64/kernel/Makefile                         |   3 +-
 arch/arm64/kernel/alternative.c                    |  27 +-
 arch/arm64/kernel/cpufeature.c                     | 106 ++-
 arch/arm64/kernel/cpuidle.c                        |   2 +-
 arch/arm64/kernel/cpuinfo.c                        |   2 +
 arch/arm64/kernel/entry-common.c                   |  17 +-
 arch/arm64/kernel/entry.S                          |  57 +-
 arch/arm64/kernel/fpsimd.c                         |   1 +
 arch/arm64/kernel/ftrace.c                         |   8 +-
 arch/arm64/kernel/head.S                           |   8 +-
 arch/arm64/kernel/hibernate.c                      |   1 -
 arch/arm64/kernel/hw_breakpoint.c                  |   8 -
 arch/arm64/kernel/hyp-stub.S                       |  18 +
 arch/arm64/kernel/idreg-override.c                 |   2 +
 arch/arm64/kernel/kaslr.c                          |  83 +--
 arch/arm64/kernel/module-plts.c                    |   1 +
 arch/arm64/kernel/module.c                         | 153 +++--
 arch/arm64/kernel/setup.c                          |   2 +
 arch/arm64/kernel/signal.c                         |   3 +-
 arch/arm64/kernel/syscall.c                        |   2 -
 arch/arm64/kernel/traps.c                          |  61 +-
 arch/arm64/kvm/debug.c                             |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h            |   6 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h         |  12 +
 arch/arm64/kvm/hyp/nvhe/debug-sr.c                 |   2 +-
 arch/arm64/kvm/sys_regs.c                          |  16 +-
 arch/arm64/lib/xor-neon.c                          |   8 +-
 arch/arm64/mm/context.c                            |   2 +-
 arch/arm64/mm/fault.c                              |  20 +-
 arch/arm64/mm/flush.c                              |   1 +
 arch/arm64/mm/init.c                               |  44 +-
 arch/arm64/mm/kasan_init.c                         |  17 +-
 arch/arm64/mm/mmu.c                                |  13 +-
 arch/arm64/mm/proc.S                               |  19 +-
 arch/arm64/tools/cpucaps                           |   4 +
 arch/arm64/tools/gen-cpucaps.awk                   |   4 +-
 arch/arm64/tools/sysreg                            | 297 ++++++++-
 drivers/acpi/arm64/Makefile                        |   2 +-
 drivers/acpi/arm64/agdi.c                          |   2 +-
 drivers/acpi/arm64/apmt.c                          |  12 +-
 drivers/acpi/arm64/init.c                          |  13 +
 drivers/acpi/arm64/init.h                          |   6 +
 drivers/acpi/arm64/iort.c                          |   1 +
 drivers/acpi/bus.c                                 |   7 +-
 drivers/hwtracing/coresight/coresight-trbe.c       |  33 +-
 drivers/hwtracing/coresight/coresight-trbe.h       |  38 +-
 drivers/perf/Kconfig                               |   8 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/apple_m1_cpu_pmu.c                    |  30 +-
 drivers/perf/arm-cci.c                             |   4 +-
 drivers/perf/arm-cmn.c                             | 172 +++--
 drivers/perf/arm_cspmu/Kconfig                     |   3 +-
 drivers/perf/arm_cspmu/arm_cspmu.c                 |  89 +--
 drivers/perf/arm_cspmu/arm_cspmu.h                 |   5 +-
 drivers/perf/arm_dmc620_pmu.c                      |  22 +
 drivers/perf/arm_pmu.c                             |   2 +
 drivers/perf/fsl_imx9_ddr_perf.c                   | 711 +++++++++++++++++++++
 drivers/perf/hisilicon/Makefile                    |   2 +-
 drivers/perf/hisilicon/hisi_pcie_pmu.c             |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        | 127 +++-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   4 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |  14 +
 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c        | 578 +++++++++++++++++
 drivers/perf/qcom_l2_pmu.c                         |   2 +-
 include/linux/acpi.h                               |   6 +
 include/linux/acpi_agdi.h                          |  13 -
 include/linux/acpi_apmt.h                          |  19 -
 include/linux/acpi_iort.h                          |   2 -
 include/linux/perf/arm_pmu.h                       |   2 +
 tools/testing/selftests/arm64/abi/hwcap.c          |  22 +
 tools/testing/selftests/arm64/abi/ptrace.c         |  32 +-
 tools/testing/selftests/arm64/signal/.gitignore    |   2 +-
 .../selftests/arm64/signal/test_signals_utils.c    |   3 +-
 .../arm64/signal/testcases/tpidr2_restore.c        |  86 +++
 tools/testing/selftests/kvm/aarch64/get-reg-list.c |  53 +-
 120 files changed, 3424 insertions(+), 781 deletions(-)
 create mode 100644 Documentation/arm64/kdump.rst
 create mode 100644 Documentation/arm64/ptdump.rst
 create mode 100644 drivers/acpi/arm64/init.c
 create mode 100644 drivers/acpi/arm64/init.h
 create mode 100644 drivers/perf/fsl_imx9_ddr_perf.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_uc_pmu.c
 delete mode 100644 include/linux/acpi_agdi.h
 delete mode 100644 include/linux/acpi_apmt.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/tpidr2_restore.c
