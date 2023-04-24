Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5055D6ED6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbjDXVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjDXVVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:21:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A865B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682371293; x=1713907293;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TU26IXMsM61swYhFhuzSkBBi4g6h/uia0f+spD5o+PY=;
  b=abDw42E58tCTABgc2ALGfAzOQ5blrwVgfOnfqtwKe2LYTIdhkXwnRQc9
   PZ4aXSgCUoDkNGyK7jY33GxDRSSlHeHyrBhjcMpDYL+Tzj4XE9IXHcWtd
   JRoUd8dlA3El7IoSOiKCcRWtUvXNm2a8uxOM9y/F/Az5XaAzIrq0QOeEm
   6g3hviVtR5X5U9yAUu6GsZngerK3e0y26LVuakriDa+hhmB8d0yDU/9vD
   BJH5FvrUZYBcwyfpYEtP6KHQJCPOWH9JHIo/SgfCzOnuPYS1yLDnxo3yJ
   IDU5YZ9EL/HnUOcjRZatnzJZDzeyFp0yzMBZT0i6ksmCgXdqIa4nlhDmK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345317940"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="345317940"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 14:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="1022856264"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="1022856264"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga005.fm.intel.com with ESMTP; 24 Apr 2023 14:21:31 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org,
        rick.p.edgecombe@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/shstk for 6.4
Date:   Mon, 24 Apr 2023 14:21:30 -0700
Message-Id: <20230424212130.590684-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull x86/shstk for 6.4.  This is the long-awaited Shadow Stack
support.  It is the most highly desired hardware security feature in a
long time.  Both AMD and Intel have (compatible) implementations.  It
has been present on the Intel side since the 11th-gen CPUs, but it had a
few stumbles on the way and is a bit tardy.

The trickiest part of this whole thing (IMNHO) was that shadow stacks
exist in a permission grey area.  A shadow stack PTE literally says
Write=0, but some instructions _can_ write to it.  The PTEs also can't
be read-only so they can't be COW'd.  They are oddballs.

The Write=0,Dirty=1 PTE permissions also mean that the dirty bit can not
be used as freely as before.  Those two things combine to create a fair
amount of PTE management churn.

A few more things you should know:

 1. There is a non-trivial amount of core mm churn.  It has acks from
    mm folks and I hope it's no surprise to Andrew.  These add a VMA
    argument to pte_mkwrite().  There is a new user in Andrew's
    pile[1*] which will need to get fixed up[2*] before this gets
    merged with the mm tree.
 2. There has been an unusual snarl of userspace compatibility issues
    with shadow stacks [3*]. While the move to new arch_prctl() values
    helped, we can still envision scenarios where this old code might
    bite us. The plan is try to ban any problematic apps from using
    shadow stack if anything comes up in practice.  We should obviously
    be on the lookout for these.
 3. This conflicts with the LAM code which is coming in x86/mm.  I'll
    discuss the resolution when I send x86/mm.

 [1*] 717f95b494ac36 ("mm: don't check VMA write permissions if the PTE/PMD indicates write permissions")
 [2*] https://lore.kernel.org/all/20230419182136.112974-1-broonie@kernel.org/
 [3*] https://lore.kernel.org/lkml/CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com/

--

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_shstk_for_6.4

for you to fetch changes up to 11c95c77eef6d56c1ef9f55d8afd83ceb6d99996:

  x86/shstk: Enforce only whole copies for ssp_set() (2023-03-27 17:55:51 -0700)

----------------------------------------------------------------
Add x86 shadow stack support.  Includes:
 * New arch_prctl() ABI for enable/disable/lock/debug
 * Plumbing to deal with the new Write=0,Dirty=1 PTE permissions
 * Core mm changes that allow some PTE write functions to take
   a VMA so they can tell if the VMA is for a shadow stack
 * Normal old selftest and documentation

----------------------------------------------------------------
Mike Rapoport (1):
      x86/shstk: Add ARCH_SHSTK_UNLOCK

Rick Edgecombe (37):
      Documentation/x86: Add CET shadow stack description
      x86/shstk: Add Kconfig option for shadow stack
      x86/cpufeatures: Add CPU feature flags for shadow stacks
      x86/cpufeatures: Enable CET CR4 bit for shadow stack
      x86/fpu/xstate: Introduce CET MSR and XSAVES supervisor states
      x86/fpu: Add helper for modifying xstate
      x86/traps: Move control protection handler to separate file
      x86/shstk: Add user control-protection fault handler
      x86/mm: Remove _PAGE_DIRTY from kernel RO pages
      x86/mm: Move pmd_write(), pud_write() up in the file
      mm: Introduce pte_mkwrite_kernel()
      s390/mm: Introduce pmd_mkwrite_kernel()
      mm: Make pte_mkwrite() take a VMA
      x86/mm: Introduce _PAGE_SAVED_DIRTY
      x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
      x86/mm: Start actually marking _PAGE_SAVED_DIRTY
      x86/mm: Check shadow stack page fault errors
      x86/mm: Teach pte_mkwrite() about stack memory
      mm: Add guard pages around a shadow stack.
      mm/mmap: Add shadow stack pages to memory accounting
      mm: Don't allow write GUPs to shadow stack memory
      x86/mm: Introduce MAP_ABOVE4G
      mm: Warn on shadow stack memory in wrong vma
      x86/mm: Warn if create Write=0,Dirty=1 with raw prot
      x86: Introduce userspace API for shadow stack
      x86/shstk: Add user-mode shadow stack support
      x86/shstk: Handle thread shadow stack
      x86/shstk: Introduce routines modifying shstk
      x86/shstk: Handle signals for shadow stack
      x86/shstk: Introduce map_shadow_stack syscall
      x86/shstk: Support WRSS for userspace
      x86: Expose thread features in /proc/$PID/status
      x86/shstk: Wire in shadow stack interface
      selftests/x86: Add shadow stack test
      x86: Add PTRACE interface for shadow stack
      x86/shstk: Add ARCH_SHSTK_STATUS
      x86/shstk: Enforce only whole copies for ssp_set()

Yu-cheng Yu (3):
      mm: Move VM_UFFD_MINOR_BIT from 37 to 38
      mm: Introduce VM_SHADOW_STACK for shadow stack memory
      mm: Re-introduce vm_flags to do_mmap()

 Documentation/filesystems/proc.rst              |   1 +
 Documentation/mm/arch_pgtable_helpers.rst       |   9 +-
 Documentation/x86/index.rst                     |   1 +
 Documentation/x86/shstk.rst                     | 179 ++++++
 arch/alpha/include/asm/pgtable.h                |   6 +-
 arch/arc/include/asm/hugepage.h                 |   2 +-
 arch/arc/include/asm/pgtable-bits-arcv2.h       |   7 +-
 arch/arm/include/asm/pgtable-3level.h           |   7 +-
 arch/arm/include/asm/pgtable.h                  |   2 +-
 arch/arm/kernel/signal.c                        |   2 +-
 arch/arm64/include/asm/pgtable.h                |   9 +-
 arch/arm64/kernel/signal.c                      |   2 +-
 arch/arm64/kernel/signal32.c                    |   2 +-
 arch/arm64/mm/trans_pgd.c                       |   4 +-
 arch/csky/include/asm/pgtable.h                 |   2 +-
 arch/hexagon/include/asm/pgtable.h              |   2 +-
 arch/ia64/include/asm/pgtable.h                 |   2 +-
 arch/loongarch/include/asm/pgtable.h            |   4 +-
 arch/m68k/include/asm/mcf_pgtable.h             |   2 +-
 arch/m68k/include/asm/motorola_pgtable.h        |   6 +-
 arch/m68k/include/asm/sun3_pgtable.h            |   6 +-
 arch/microblaze/include/asm/pgtable.h           |   2 +-
 arch/mips/include/asm/pgtable.h                 |   6 +-
 arch/nios2/include/asm/pgtable.h                |   2 +-
 arch/openrisc/include/asm/pgtable.h             |   2 +-
 arch/parisc/include/asm/pgtable.h               |   6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h    |   2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h    |   4 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h    |   2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h    |   2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h    |   2 +-
 arch/riscv/include/asm/pgtable.h                |   6 +-
 arch/s390/include/asm/hugetlb.h                 |   4 +-
 arch/s390/include/asm/pgtable.h                 |  14 +-
 arch/s390/mm/pageattr.c                         |   4 +-
 arch/sh/include/asm/pgtable_32.h                |  10 +-
 arch/sparc/include/asm/pgtable_32.h             |   2 +-
 arch/sparc/include/asm/pgtable_64.h             |   6 +-
 arch/sparc/kernel/signal32.c                    |   2 +-
 arch/sparc/kernel/signal_64.c                   |   2 +-
 arch/um/include/asm/pgtable.h                   |   2 +-
 arch/x86/Kconfig                                |  24 +
 arch/x86/Kconfig.assembler                      |   5 +
 arch/x86/entry/syscalls/syscall_64.tbl          |   1 +
 arch/x86/include/asm/cpufeatures.h              |   2 +
 arch/x86/include/asm/disabled-features.h        |  16 +-
 arch/x86/include/asm/fpu/api.h                  |   9 +
 arch/x86/include/asm/fpu/regset.h               |   7 +-
 arch/x86/include/asm/fpu/sched.h                |   3 +-
 arch/x86/include/asm/fpu/types.h                |  16 +-
 arch/x86/include/asm/fpu/xstate.h               |   6 +-
 arch/x86/include/asm/idtentry.h                 |   2 +-
 arch/x86/include/asm/mmu_context.h              |   2 +
 arch/x86/include/asm/pgtable.h                  | 322 +++++++++--
 arch/x86/include/asm/pgtable_types.h            |  56 +-
 arch/x86/include/asm/processor.h                |   8 +
 arch/x86/include/asm/shstk.h                    |  38 ++
 arch/x86/include/asm/special_insns.h            |  13 +
 arch/x86/include/asm/tlbflush.h                 |   3 +-
 arch/x86/include/asm/trap_pf.h                  |   2 +
 arch/x86/include/asm/traps.h                    |  12 +
 arch/x86/include/uapi/asm/mman.h                |   4 +
 arch/x86/include/uapi/asm/prctl.h               |  12 +
 arch/x86/kernel/Makefile                        |   4 +
 arch/x86/kernel/cet.c                           | 152 ++++++
 arch/x86/kernel/cpu/common.c                    |  35 +-
 arch/x86/kernel/cpu/cpuid-deps.c                |   1 +
 arch/x86/kernel/cpu/proc.c                      |  23 +
 arch/x86/kernel/fpu/core.c                      |  54 +-
 arch/x86/kernel/fpu/regset.c                    |  81 +++
 arch/x86/kernel/fpu/xstate.c                    |  90 ++-
 arch/x86/kernel/idt.c                           |   2 +-
 arch/x86/kernel/process.c                       |  21 +-
 arch/x86/kernel/process_64.c                    |   9 +-
 arch/x86/kernel/ptrace.c                        |  12 +
 arch/x86/kernel/shstk.c                         | 499 +++++++++++++++++
 arch/x86/kernel/signal.c                        |   1 +
 arch/x86/kernel/signal_32.c                     |   2 +-
 arch/x86/kernel/signal_64.c                     |   8 +-
 arch/x86/kernel/sys_x86_64.c                    |   6 +-
 arch/x86/kernel/traps.c                         |  87 ---
 arch/x86/mm/fault.c                             |  22 +
 arch/x86/mm/pat/set_memory.c                    |   4 +-
 arch/x86/mm/pgtable.c                           |  38 ++
 arch/x86/xen/enlighten_pv.c                     |   2 +-
 arch/x86/xen/mmu_pv.c                           |   2 +-
 arch/x86/xen/xen-asm.S                          |   2 +-
 arch/xtensa/include/asm/pgtable.h               |   2 +-
 fs/aio.c                                        |   2 +-
 fs/proc/array.c                                 |   6 +
 fs/proc/task_mmu.c                              |   3 +
 include/asm-generic/hugetlb.h                   |   4 +-
 include/linux/mm.h                              |  65 ++-
 include/linux/mman.h                            |   4 +
 include/linux/pgtable.h                         |  14 +
 include/linux/proc_fs.h                         |   2 +
 include/linux/syscalls.h                        |   1 +
 include/uapi/asm-generic/siginfo.h              |   3 +-
 include/uapi/asm-generic/unistd.h               |   2 +-
 include/uapi/linux/elf.h                        |   2 +
 ipc/shm.c                                       |   2 +-
 kernel/sys_ni.c                                 |   1 +
 mm/debug_vm_pgtable.c                           |  16 +-
 mm/gup.c                                        |   2 +-
 mm/huge_memory.c                                |   7 +-
 mm/hugetlb.c                                    |   4 +-
 mm/internal.h                                   |   4 +-
 mm/memory.c                                     |   5 +-
 mm/migrate_device.c                             |   2 +-
 mm/mmap.c                                       |  10 +-
 mm/mprotect.c                                   |   2 +-
 mm/nommu.c                                      |   4 +-
 mm/userfaultfd.c                                |   2 +-
 mm/util.c                                       |   2 +-
 tools/testing/selftests/x86/Makefile            |   2 +-
 tools/testing/selftests/x86/test_shadow_stack.c | 695 ++++++++++++++++++++++++
 116 files changed, 2615 insertions(+), 314 deletions(-)
 create mode 100644 Documentation/x86/shstk.rst
 create mode 100644 arch/x86/include/asm/shstk.h
 create mode 100644 arch/x86/kernel/cet.c
 create mode 100644 arch/x86/kernel/shstk.c
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c
