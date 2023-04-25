Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA166EDF4D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjDYJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjDYJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:32:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046161721
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:32:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B85B62D27
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901C7C433D2;
        Tue, 25 Apr 2023 09:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682415143;
        bh=xpD9hHn06Sr/Fy87RTueD2pMHhYICL01t40d2WfOQIs=;
        h=Date:From:To:Cc:Subject:From;
        b=EA/xJoUfgCDtyptcFDX7XfYD2Y/4G8hN5E+sSiqjHX5DZEw01mRpSZTWqPmPtq2d/
         adgzZnCH8OrkjmBKn/fKyV6+KQGw+HASO9AKl7L3vVI6yhai480Q2yL7SpZTKs9X6l
         RiTeJIidpTJFzk7wyN+GXwdPf8qZCP15HdRG8bD6wU2GOjC17P0qa/hw563ajjbEPs
         HEA0HHsibCbmocgjiFuaX6ustir0mnKVQ0sXERvys0AnKGCGC2j4mEXs7RaoFqrRCL
         XjP4vCEbvUWujE+6oz9ySTuyUFeBmFK1fIuqYKYKA5/rxIiPaFNmaQ4zuG9O5fQP4p
         94+VSDs9Zj6IQ==
Date:   Tue, 25 Apr 2023 10:32:19 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        maz@kernel.org, rostedt@goodmis.org
Subject: [GIT PULL] arm64 updates for 6.4
Message-ID: <20230425093218.GA7967@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this round of arm64 updates for 6.4. I've summarised the
topic branches in the tag commit, but the bulk of the code changes here
stem from a rework of the PMU driver so that PMUv3 hardware can be
driven on both 32-bit and 64-bit CPUs.

From a logistical perspective, we've got a couple of interesting
cross-tree interations:

 (1) We have a shared tracing branch with Steve (pulled from his
     'trace-direct-v6.3-rc3' tag) so that the arm64 support for direct
     calls can be implemented on top. This then ends up conflicting
     with a fix that landed after -rc3 in 2a2d8c51defb ("ftrace: Fix
     issue that 'direct->addr' not restored in modify_ftrace_direct()").

     The code changed by the fix is removed by the tag from Steve in
     8788ca164eba ("ftrace: Remove the legacy _ftrace_direct API") and
     the only part that needs fixing up is the definition of 'MULTI_FLAGS'
     to use 'FTRACE_OPS_FL_SAVE_ARGS' instead of 'FTRACE_OPS_FL_SAVE_REGS'.

 (2) Moving the PMUv3 driver out into drivers/perf/ triggered a latent
     probe-ordering bug with (p)KVM, so we're carrying a fix for that
     here with Marc's Ack.

Cheers,

Will

--->8

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to eeb3557cc188e42ae7f7bef2d6dc5bf0e078412e:

  Merge branch 'for-next/sysreg' into for-next/core (2023-04-20 18:03:07 +0100)

----------------------------------------------------------------
arm64 updates for 6.4

ACPI:
	* Improve error reporting when failing to manage SDEI on AGDI device
	  removal

Assembly routines:
	* Improve register constraints so that the compiler can make use of
	  the zero register instead of moving an immediate #0 into a GPR

	* Allow the compiler to allocate the registers used for CAS
	  instructions

CPU features and system registers:
	* Cleanups to the way in which CPU features are identified from the
	  ID register fields

	* Extend system register definition generation to handle Enum types
	  when defining shared register fields

	* Generate definitions for new _EL2 registers and add new fields
	  for ID_AA64PFR1_EL1

	* Allow SVE to be disabled separately from SME on the kernel
	  command-line

Tracing:
	* Support for "direct calls" in ftrace, which enables BPF tracing
	  for arm64

Kdump:
	* Don't bother unmapping the crashkernel from the linear mapping,
	  which then allows us to use huge (block) mappings and reduce
	  TLB pressure when a crashkernel is loaded.

Memory management:
	* Try again to remove data cache invalidation from the coherent DMA
	  allocation path

	* Simplify the fixmap code by mapping at page granularity

	* Allow the kfence pool to be allocated early, preventing the rest
	  of the linear mapping from being forced to page granularity

Perf and PMU:
	* Move CPU PMU code out to drivers/perf/ where it can be reused
	  by the 32-bit ARM architecture when running on ARMv8 CPUs

	* Fix race between CPU PMU probing and pKVM host de-privilege

	* Add support for Apple M2 CPU PMU

	* Adjust the generic PERF_COUNT_HW_BRANCH_INSTRUCTIONS event
	  dynamically, depending on what the CPU actually supports

	* Minor fixes and cleanups to system PMU drivers

Stack tracing:
	* Use the XPACLRI instruction to strip PAC from pointers, rather
	  than rolling our own function in C

	* Remove redundant PAC removal for toolchains that handle this in
	  their builtins

	* Make backtracing more resilient in the face of instrumentation

Miscellaneous:
	* Fix single-step with KGDB

	* Remove harmless warning when 'nokaslr' is passed on the kernel
	  command-line

	* Minor fixes and cleanups across the board

----------------------------------------------------------------
Baoquan He (3):
      arm64: kdump : take off the protection on crashkernel memory region
      arm64: kdump: do not map crashkernel region specifically
      arm64: kdump: defer the crashkernel reservation for platforms with no DMA memory zones

Besar Wicaksono (1):
      perf: arm_cspmu: Fix variable dereference warning

Dan Carpenter (1):
      arm64: delete dead code in this_cpu_set_vectors()

Dongxu Sun (3):
      arm64/signal: Use system_supports_tpidr2() to check TPIDR2
      arm64/signal: Alloc tpidr2 sigframe after checking system_supports_tpidr2()
      arm64/sme: Fix some comments of ARM SME

Florent Revest (8):
      ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
      ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
      ftrace: Remove the legacy _ftrace_direct API
      ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
      ftrace: Store direct called addresses in their ops
      ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
      arm64: ftrace: Add direct call support
      arm64: ftrace: Simplify get_ftrace_plt

Ilkka Koskinen (1):
      perf/arm-cmn: Move overlapping wp_combine field

Ira Weiny (1):
      arm: uaccess: Remove memcpy_page_flushcache()

Janne Grunau (2):
      dt-bindings: arm-pmu: Add PMU compatible strings for Apple M2 cores
      drivers/perf: apple_m1: Add Apple M2 support

Jiucheng Xu (1):
      perf/amlogic: Fix config1/config2 parsing issue

Junhao He (2):
      drivers/perf: hisi: Remove redundant initialized of pmu->name
      drivers/perf: hisi: add NULL check for name

Marc Zyngier (5):
      arm64: perf: Move PMUv3 driver to drivers/perf
      arm64: perf: Abstract system register accesses away
      ARM: Make CONFIG_CPU_V7 valid for 32bit ARMv8 implementations
      ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
      ARM: mach-virt: Select PMUv3 driver by default

Mark Brown (7):
      arm64/sysreg: Convert HFG[RW]TR_EL2 to automatic generation
      arm64/sysreg: Update ID_AA64PFR1_EL1 for DDI0601 2022-12
      arm64/idreg: Don't disable SME when disabling SVE
      arm64/sysreg: Convert HFGITR_EL2 to automatic generation
      arm64/cpufeature: Pull out helper for CPUID register definitions
      arm64/cpufeature: Consistently use symbolic constants for min_field_value
      arm64/cpufeature: Use helper macro to specify ID register for capabilites

Mark Rutland (15):
      ftrace: selftest: remove broken trace_direct_tramp
      arm64: atomics: lse: improve cmpxchg implementation
      arm64: uaccess: permit __smp_store_release() to use zero register
      arm64: uaccess: permit put_{user,kernel} to use zero register
      arm64: uaccess: remove unnecessary earlyclobber
      arm64/sysreg: allow *Enum blocks in SysregFields blocks
      arm64: stacktrace: recover return address for first entry
      arm64: stacktrace: move dump functions to end of file
      arm64: stacktrace: always inline core stacktrace functions
      arm64: add FIXADDR_TOT_{START,SIZE}
      arm64: mm: move fixmap code to its own file
      arm64: mm: always map fixmap at page granularity
      arm64: avoid redundant PAC stripping in __builtin_return_address()
      arm64: use XPACLRI to strip PAC
      arm64: move PAC masks to <asm/pointer_auth.h>

Nick Alcock (1):
      kbuild, drivers/perf: remove MODULE_LICENSE in non-modules

Pavankumar Kondeti (1):
      arm64: kernel: Fix kernel warning when nokaslr is passed to commandline

Pierre Gondois (1):
      firmware: arm_sdei: Fix sleep from invalid context BUG

Robin Murphy (2):
      perf/arm-cmn: Validate cycles events fully
      perf/arm-cmn: Fix port detection for CMN-700

Simon Horman (1):
      arm64: kexec: include reboot.h

Stephane Eranian (1):
      arm64: pmuv3: dynamically map PERF_COUNT_HW_BRANCH_INSTRUCTIONS

Sumit Garg (1):
      arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

Teo Couprie Diaz (1):
      arm64: compat: Remove defines now in asm-generic

Uwe Kleine-König (1):
      ACPI: AGDI: Improve error reporting for problems during .remove()

Will Deacon (14):
      Revert "ARM: mach-virt: Select PMUv3 driver by default"
      Revert "Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()""
      Merge tag 'trace-direct-v6.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace into for-next/ftrace
      Merge branch 'for-next/acpi' into for-next/core
      Merge branch 'for-next/asm' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/ftrace' into for-next/core
      Merge branch 'for-next/kdump' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      KVM: arm64: Ensure CPU PMU probes before pKVM host de-privilege
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/stacktrace' into for-next/core
      Merge branch 'for-next/sysreg' into for-next/core

Yang Li (3):
      perf: arm: Use devm_platform_get_and_ioremap_resource()
      perf: qcom: Use devm_platform_get_and_ioremap_resource()
      drivers/perf: Use devm_platform_get_and_ioremap_resource()

Yu Zhe (2):
      arm64: armv8_deprecated: remove unnecessary (void*) conversions
      arm64: kexec: remove unnecessary (void*) conversions

Zaid Al-Bassam (3):
      perf: pmuv3: Abstract PMU version checks
      perf: pmuv3: Move inclusion of kvm_host.h to the arch-specific helper
      perf: pmuv3: Change GENMASK to GENMASK_ULL

Zhenhua Huang (1):
      mm,kfence: decouple kfence from page granularity mapping judgement

 Documentation/devicetree/bindings/arm/pmu.yaml     |   2 +
 arch/arm/include/asm/arm_pmuv3.h                   | 247 ++++++++++++
 arch/arm/mm/Kconfig                                |   2 +-
 arch/arm64/Kconfig                                 |  18 +
 arch/arm64/include/asm/arm_pmuv3.h                 | 155 ++++++++
 arch/arm64/include/asm/atomic_lse.h                |  17 +-
 arch/arm64/include/asm/barrier.h                   |  10 +-
 arch/arm64/include/asm/compat.h                    |   4 -
 arch/arm64/include/asm/compiler.h                  |  36 +-
 arch/arm64/include/asm/debug-monitors.h            |   1 +
 arch/arm64/include/asm/fixmap.h                    |  22 +-
 arch/arm64/include/asm/ftrace.h                    |  22 ++
 arch/arm64/include/asm/kernel-pgtable.h            |   5 +-
 arch/arm64/include/asm/kexec.h                     |   6 -
 arch/arm64/include/asm/kfence.h                    |  10 +
 arch/arm64/include/asm/memory.h                    |   5 -
 arch/arm64/include/asm/mmu.h                       |   2 +
 arch/arm64/include/asm/perf_event.h                | 249 ------------
 arch/arm64/include/asm/pointer_auth.h              |  13 +-
 arch/arm64/include/asm/sysreg.h                    |   9 -
 arch/arm64/include/asm/uaccess.h                   |   6 +-
 arch/arm64/kernel/Makefile                         |   1 -
 arch/arm64/kernel/armv8_deprecated.c               |   4 +-
 arch/arm64/kernel/asm-offsets.c                    |   6 +
 arch/arm64/kernel/cpufeature.c                     | 272 +++----------
 arch/arm64/kernel/crash_core.c                     |   1 +
 arch/arm64/kernel/debug-monitors.c                 |   5 +
 arch/arm64/kernel/entry-ftrace.S                   |  90 ++++-
 arch/arm64/kernel/fpsimd.c                         |   4 +-
 arch/arm64/kernel/ftrace.c                         |  46 ++-
 arch/arm64/kernel/idreg-override.c                 |   9 +-
 arch/arm64/kernel/kgdb.c                           |   2 +
 arch/arm64/kernel/machine_kexec.c                  |  23 +-
 arch/arm64/kernel/perf_callchain.c                 |   2 +-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/arm64/kernel/proton-pack.c                    |   3 -
 arch/arm64/kernel/signal.c                         |  18 +-
 arch/arm64/kernel/stacktrace.c                     | 144 +++----
 arch/arm64/kvm/arm.c                               |  45 ---
 arch/arm64/kvm/pkvm.c                              |  47 +++
 arch/arm64/lib/uaccess_flushcache.c                |   6 -
 arch/arm64/mm/Makefile                             |   2 +-
 arch/arm64/mm/dma-mapping.c                        |  17 +-
 arch/arm64/mm/fixmap.c                             | 203 ++++++++++
 arch/arm64/mm/init.c                               |  34 +-
 arch/arm64/mm/mmu.c                                | 288 +++-----------
 arch/arm64/mm/pageattr.c                           |   7 +-
 arch/arm64/mm/ptdump.c                             |   2 +-
 arch/arm64/tools/gen-sysreg.awk                    |  95 +++--
 arch/arm64/tools/sysreg                            | 165 +++++++-
 arch/s390/kernel/mcount.S                          |   5 +
 arch/x86/kernel/ftrace_32.S                        |   5 +
 arch/x86/kernel/ftrace_64.S                        |   4 +
 drivers/acpi/arm64/agdi.c                          |  13 +-
 drivers/firmware/arm_sdei.c                        |  37 +-
 drivers/perf/Kconfig                               |  10 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c              |   3 +-
 drivers/perf/amlogic/meson_ddr_pmu_core.c          |   8 +-
 drivers/perf/apple_m1_cpu_pmu.c                    |  15 +-
 drivers/perf/arm-cmn.c                             |  61 +--
 drivers/perf/arm_cspmu/arm_cspmu.c                 |   6 +-
 drivers/perf/arm_dmc620_pmu.c                      |   3 +-
 .../perf_event.c => drivers/perf/arm_pmuv3.c       | 158 +++-----
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |  19 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   9 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |  13 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c        |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c           |   4 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h           |   3 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c      |   2 +-
 drivers/perf/qcom_l3_pmu.c                         |   3 +-
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/cpuhotplug.h                         |   1 -
 include/linux/ftrace.h                             |  61 +--
 include/linux/perf/arm_pmuv3.h                     | 303 ++++++++++++++
 kernel/bpf/trampoline.c                            |  12 +-
 kernel/trace/Kconfig                               |   2 +-
 kernel/trace/ftrace.c                              | 438 ++-------------------
 kernel/trace/trace_selftest.c                      |  19 +-
 mm/kfence/core.c                                   |   4 +
 samples/Kconfig                                    |   2 +-
 samples/ftrace/ftrace-direct-modify.c              |  10 +-
 samples/ftrace/ftrace-direct-multi-modify.c        |   9 +-
 samples/ftrace/ftrace-direct-multi.c               |   5 +-
 samples/ftrace/ftrace-direct-too.c                 |  10 +-
 samples/ftrace/ftrace-direct.c                     |  10 +-
 88 files changed, 1936 insertions(+), 1722 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/mm/fixmap.c
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (92%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

