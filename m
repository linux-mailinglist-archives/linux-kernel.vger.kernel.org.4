Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C23464BB42
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiLMRnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbiLMRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:42:59 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58FA23BD6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670953376; x=1702489376;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JbygnR+34aVP50LuHDGng6ylvUT5LCMJ5h3J6y1OskA=;
  b=AHEP32LK7KmqvZvJ2SY+P8Gf2PMirkAPWrgp2ROFcpwMOCoII/Ynhp7P
   B6HwvEGluzcvDFobiHPBw1Q5YbOmcQmk1pZs2J7kBQuJgYKNffBUqPyIj
   hPOKrU/9S39jXHW7y0h4Nh7QlUlwxU29MC8T72ffLrBNbAUiNMT55ekoL
   sb/6Oqb+lma3313Y8QQjzsAxagDgqCuGBzU2p2MRhK4gBElnX3SzVgtn4
   nXRfrX9NDT79EmZewqOhSY2IogC/Nf5O5VdKPROqUmwXQfdZVScjrVw4V
   2VzzAv7N5n5wGZs000JXn6CKfIJzwk4llg4hIER0q1adG0yKHH88o408d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320052685"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="320052685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 09:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="737460079"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="737460079"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Dec 2022 09:42:55 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Subject: [GIT PULL] x86/mm for 6.2
Date:   Tue, 13 Dec 2022 09:42:34 -0800
Message-Id: <20221213174234.688534-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/mm changes for 6.2.

This includes some new randomization of the per-cpu entry areas from
Peter Z.  Without it, these areas are a tasty target for attackers.
The entry code and mappings are especially tricky code and this has
caused some issues along the way, but they have settled down.

This also contains a new hardware feature: Linear Address Masking
(LAM).  It is similar conceptually to the ARM Top-Byte-Ignore (TBI)
feature and should allow userspace memory sanitizers to be used
with less overhead on x86.

LAM adds some pointer tag/untag functions which are used relatively
widely in the tree, but were just stubs on x86 until now.  The
new functions also unearthed a SCSI build issue.  There's a fix in
the SCSI tree for it:

	4e80eef45ad7 ("scsi: sg: Fix get_user() in call sg_scsi_ioctl()")

but this should not be pulled without that patch being in place
first.

Last, there is a merge conflict between the set_memory_rox() work
in this branch and x86/core.  I've included a suggested resolution
below from Ingo.

---

Merge branch 'x86/core' into x86/mm, to resolve conflicts

Resolve conflicts between this commit in tip:x86/core:

      4c4eb3ecc91f ("x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()")

    ... and this one in tip:x86/mm:

      1f6eae430528 mm: Introduce set_memory_rox()

The set_vm_flush_reset_perms() calls need to be removed in the
set_memory_rox()-simplified code too.

Conflicts:
	arch/x86/kernel/ftrace.c
	arch/x86/kernel/kprobes/core.c

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

diff --cc arch/x86/kernel/ftrace.c
index 03579460d0ec,cf15ef5aecff..3d883eb989c7
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@@ -413,9 -421,9 +421,8 @@@ create_trampoline(struct ftrace_ops *op
  	/* ALLOC_TRAMP flags lets us know we created it */
  	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
  
- 	set_vm_flush_reset_perms(trampoline);
- 
 -	if (likely(system_state != SYSTEM_BOOTING))
 -		set_memory_ro((unsigned long)trampoline, npages);
 -	set_memory_x((unsigned long)trampoline, npages);
 +	set_memory_rox((unsigned long)trampoline, npages);
++
  	return (unsigned long)trampoline;
  fail:
  	tramp_free(trampoline);
diff --cc arch/x86/kernel/kprobes/core.c
index e7b7ca64acdf,01b8d956aa76..66299682b6b7
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@@ -414,8 -414,12 +414,6 @@@ void *alloc_insn_page(void
  	if (!page)
  		return NULL;
  
- 	set_vm_flush_reset_perms(page);
 -	/*
 -	 * First make the page read-only, and only then make it executable to
 -	 * prevent it from being W+X in between.
 -	 */
 -	set_memory_ro((unsigned long)page, 1);
--
  	/*
  	 * TODO: Once additional kernel code protection mechanisms are set, ensure
  	 * that the page was not maliciously altered and it is still zeroed.

--
The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.2

for you to fetch changes up to ce66a02538f39f071443bac9bc6ff8f3a780ab92:

  x86/mm: Fix sparse warnings in untagged_ptr() (2022-11-28 15:12:25 -0800)

----------------------------------------------------------------
New Features:
* Introduce Hardware-based Linear Address Masking (LAM)
* Randomize the per-cpu entry areas
Cleanups:
* Move to "native" set_memory_rox() helper
* Clean up pmd_get_atomic() and i386-PAE
* Remove some unused page table size macros

----------------------------------------------------------------
Andrey Ryabinin (1):
      x86/kasan: Map shadow for percpu pages on demand

Dave Hansen (1):
      x86/mm: Ensure forced page table splitting

Kirill A. Shutemov (12):
      x86/mm: Fix CR3_ADDR_MASK
      x86: CPUID and CR3/CR4 flags for Linear Address Masking
      mm: Pass down mm_struct to untagged_addr()
      x86/mm: Handle LAM on context switch
      x86/uaccess: Provide untagged_addr() and remove tags before address check
      KVM: Serialize tagged address check against tagging enabling
      x86/mm: Provide arch_prctl() interface for LAM
      x86/mm: Reduce untagged_addr() overhead until the first LAM user
      mm: Expose untagging mask in /proc/$PID/status
      iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
      x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
      x86/mm: Fix sparse warnings in untagged_ptr()

Pasha Tatashin (1):
      x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

Peter Zijlstra (27):
      x86/mm: Randomize per-cpu entry area
      Merge branch 'v6.1-rc3'
      mm: Move mm_cachep initialization to mm_init()
      x86/mm: Use mm_alloc() in poking_init()
      x86/mm: Initialize text poking earlier
      x86/ftrace: Remove SYSTEM_BOOTING exceptions
      x86/mm: Do verify W^X at boot up
      mm: Introduce set_memory_rox()
      x86/mm: Implement native set_memory_rox()
      mm: Update ptep_get_lockless()'s comment
      x86/mm/pae: Make pmd_t similar to pte_t
      sh/mm: Make pmd_t similar to pte_t
      mm: Fix pmd_read_atomic()
      mm: Rename GUP_GET_PTE_LOW_HIGH
      mm: Rename pmd_read_atomic()
      mm/gup: Fix the lockless PMD access
      x86/mm/pae: Don't (ab)use atomic64
      x86/mm/pae: Use WRITE_ONCE()
      x86/mm/pae: Be consistent with pXXp_get_and_clear()
      x86_64: Remove pointless set_64bit() usage
      x86/mm/pae: Get rid of set_64bit()
      mm: Remove pointless barrier() after pmdp_get_lockless()
      mm: Convert __HAVE_ARCH_P..P_GET to the new style
      x86/mm: Add a few comments
      x86/mm: Untangle __change_page_attr_set_clr(.checkalias)
      x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()
      x86/mm: Rename __change_page_attr_set_clr(.checkalias)

Sean Christopherson (5):
      x86/mm: Recompute physical address for every page of per-CPU CEA mapping
      x86/mm: Populate KASAN shadow for entire per-CPU range of CPU entry area
      x86/kasan: Rename local CPU_ENTRY_AREA variables to shorten names
      x86/kasan: Add helpers to align shadow addresses up and down
      x86/kasan: Populate shadow for shared chunk of the CPU entry area

Weihong Zhang (5):
      selftests/x86/lam: Add malloc and tag-bits test cases for linear-address masking
      selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address masking
      selftests/x86/lam: Add io_uring test cases for linear-address masking
      selftests/x86/lam: Add inherit test cases for linear-address masking
      selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for linear-address masking

 arch/arm/mach-omap1/sram-init.c                  |    8 +-
 arch/arm/mach-omap2/sram.c                       |    8 +-
 arch/arm64/include/asm/memory.h                  |    4 +-
 arch/arm64/include/asm/mmu_context.h             |    6 +
 arch/arm64/include/asm/signal.h                  |    2 +-
 arch/arm64/include/asm/uaccess.h                 |    2 +-
 arch/arm64/kernel/hw_breakpoint.c                |    2 +-
 arch/arm64/kernel/traps.c                        |    4 +-
 arch/arm64/mm/fault.c                            |   10 +-
 arch/mips/Kconfig                                |    2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h     |    2 +-
 arch/powerpc/kernel/kprobes.c                    |    9 +-
 arch/sh/Kconfig                                  |    2 +-
 arch/sh/include/asm/pgtable-3level.h             |   10 +-
 arch/sparc/include/asm/mmu_context_64.h          |    6 +
 arch/sparc/include/asm/pgtable_64.h              |    2 +-
 arch/sparc/include/asm/uaccess_64.h              |    2 +
 arch/um/include/asm/pgtable-3level.h             |    8 -
 arch/x86/Kconfig                                 |    2 +-
 arch/x86/include/asm/cmpxchg_32.h                |   28 -
 arch/x86/include/asm/cmpxchg_64.h                |    5 -
 arch/x86/include/asm/cpu_entry_area.h            |    4 -
 arch/x86/include/asm/cpufeatures.h               |    1 +
 arch/x86/include/asm/kasan.h                     |    3 +
 arch/x86/include/asm/mmu.h                       |   12 +-
 arch/x86/include/asm/mmu_context.h               |   47 +
 arch/x86/include/asm/page_types.h                |   12 +-
 arch/x86/include/asm/pgtable-3level.h            |  171 +---
 arch/x86/include/asm/pgtable-3level_types.h      |    7 +
 arch/x86/include/asm/pgtable_64_types.h          |    1 +
 arch/x86/include/asm/pgtable_areas.h             |    8 +-
 arch/x86/include/asm/pgtable_types.h             |    4 +-
 arch/x86/include/asm/processor-flags.h           |    4 +-
 arch/x86/include/asm/set_memory.h                |    3 +
 arch/x86/include/asm/tlbflush.h                  |   34 +
 arch/x86/include/asm/uaccess.h                   |   42 +-
 arch/x86/include/uapi/asm/prctl.h                |    5 +
 arch/x86/include/uapi/asm/processor-flags.h      |    6 +
 arch/x86/kernel/alternative.c                    |   10 -
 arch/x86/kernel/amd_gart_64.c                    |    2 +-
 arch/x86/kernel/ftrace.c                         |    6 +-
 arch/x86/kernel/head64.c                         |    2 +-
 arch/x86/kernel/hw_breakpoint.c                  |    2 +-
 arch/x86/kernel/kprobes/core.c                   |    9 +-
 arch/x86/kernel/process.c                        |    3 +
 arch/x86/kernel/process_64.c                     |   87 +-
 arch/x86/kernel/traps.c                          |    6 +-
 arch/x86/mm/cpu_entry_area.c                     |   50 +-
 arch/x86/mm/init.c                               |    2 +-
 arch/x86/mm/kasan_init_64.c                      |   53 +-
 arch/x86/mm/mem_encrypt_boot.S                   |    4 +-
 arch/x86/mm/mem_encrypt_identity.c               |   18 +-
 arch/x86/mm/pat/set_memory.c                     |  105 +-
 arch/x86/mm/pti.c                                |    2 +-
 arch/x86/mm/tlb.c                                |   53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          |    2 +-
 drivers/gpu/drm/radeon/radeon_gem.c              |    2 +-
 drivers/infiniband/hw/mlx4/mr.c                  |    2 +-
 drivers/iommu/intel/irq_remapping.c              |   13 +-
 drivers/iommu/iommu-sva-lib.c                    |   16 +-
 drivers/media/common/videobuf2/frame_vector.c    |    2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c    |    2 +-
 drivers/misc/sram-exec.c                         |    7 +-
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c   |    2 +-
 drivers/tee/tee_shm.c                            |    2 +-
 drivers/vfio/vfio_iommu_type1.c                  |    2 +-
 fs/proc/array.c                                  |    6 +
 fs/proc/task_mmu.c                               |    2 +-
 include/linux/filter.h                           |    3 +-
 include/linux/ioasid.h                           |    9 -
 include/linux/mm.h                               |   11 -
 include/linux/mmu_context.h                      |   14 +
 include/linux/pgtable.h                          |   73 +-
 include/linux/sched/mm.h                         |    8 +-
 include/linux/sched/task.h                       |    2 +-
 include/linux/set_memory.h                       |   10 +
 include/linux/uaccess.h                          |   15 +
 init/main.c                                      |    4 +-
 kernel/bpf/bpf_struct_ops.c                      |    3 +-
 kernel/bpf/core.c                                |    6 +-
 kernel/bpf/trampoline.c                          |    3 +-
 kernel/events/core.c                             |    2 +-
 kernel/fork.c                                    |   37 +-
 lib/strncpy_from_user.c                          |    2 +-
 lib/strnlen_user.c                               |    2 +-
 mm/Kconfig                                       |    2 +-
 mm/gup.c                                         |    8 +-
 mm/hmm.c                                         |    3 +-
 mm/khugepaged.c                                  |    2 +-
 mm/madvise.c                                     |    2 +-
 mm/mapping_dirty_helpers.c                       |    2 +-
 mm/mempolicy.c                                   |    6 +-
 mm/migrate.c                                     |    2 +-
 mm/mincore.c                                     |    2 +-
 mm/mlock.c                                       |    4 +-
 mm/mmap.c                                        |    2 +-
 mm/mprotect.c                                    |    4 +-
 mm/mremap.c                                      |    2 +-
 mm/msync.c                                       |    2 +-
 mm/userfaultfd.c                                 |    2 +-
 mm/vmscan.c                                      |    5 +-
 net/bpf/bpf_dummy_struct_ops.c                   |    3 +-
 tools/testing/selftests/x86/Makefile             |    2 +-
 tools/testing/selftests/x86/lam.c                | 1149 ++++++++++++++++++++++
 virt/kvm/kvm_main.c                              |   14 +-
 106 files changed, 1901 insertions(+), 485 deletions(-)
 create mode 100644 tools/testing/selftests/x86/lam.c
