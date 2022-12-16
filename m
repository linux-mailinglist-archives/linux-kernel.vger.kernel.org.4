Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE364F4EE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiLPXVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPXVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:21:16 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA8FAF1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 15:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671232875; x=1702768875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T57g2iM57jrrMul3z/WuF6D4fY7Ozau8sG7UpCRDA3E=;
  b=MpnpwCVlenEf3DNtQ4KxqufVNP25l7mJaiCdpVrJCTDvcrwxI4NVu5X9
   UwBu06FKU4jigYKb3Yt+KRkFElScJh6R7TIjswp0zSjXbgPLBEk5ShMsL
   K9ziL2ly1PFER5AZs7m3ZwpRcAhJzokiubDdByfvSOZJLTtMVoF+5Y4sS
   jIgT2BfOAnUbg4i6esg9BBc8XrONj4rIZyft0+Ruey5OdJ5cG7zJnRK3e
   hFeK8sik3AU4ToYXMJ4rZsgDAlP2yMBFfRVJ/bdt61mjBtKHorzEpUN47
   5lmBrvXOKRdcxAaayO1B4nqotrMXcxHGSeoKJkF+8/58opXVUJ4ONzv+4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="319129654"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="319129654"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 15:21:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="895422490"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="895422490"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2022 15:21:14 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com
Subject: [GIT PULL] x86/mm for 6.2 (try #2)
Date:   Fri, 16 Dec 2022 15:21:08 -0800
Message-Id: <20221216232108.1325224-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/mm changes for 6.2.

This is identical to the first pull request, except that virtually
all the LAM work has been removed (there's one small cleanup that's
useful on its own).  We'll rework LAM and give it another shot for
6.3.

The non-LAM content is identical:

This includes some new randomization of the per-cpu entry areas from
Peter Z.  Without it, these areas are a tasty target for attackers.
The entry code and mappings are especially tricky code and this has
caused some issues along the way, but they have settled down.

There's also a smattering of smaller cleanups.

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

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.2_v2

for you to fetch changes up to 3e844d842d49cdbe61a4b338bdd512654179488a:

  x86/mm: Ensure forced page table splitting (2022-12-15 10:37:28 -0800)

----------------------------------------------------------------
New Feature:
* Randomize the per-cpu entry areas
Cleanups:
* Have CR3_ADDR_MASK use PHYSICAL_PAGE_MASK instead of open
  coding it
* Move to "native" set_memory_rox() helper
* Clean up pmd_get_atomic() and i386-PAE
* Remove some unused page table size macros

----------------------------------------------------------------
Andrey Ryabinin (1):
      x86/kasan: Map shadow for percpu pages on demand

Dave Hansen (1):
      x86/mm: Ensure forced page table splitting

Kirill A. Shutemov (1):
      x86/mm: Fix CR3_ADDR_MASK

Pasha Tatashin (1):
      x86/mm: Remove P*D_PAGE_MASK and P*D_PAGE_SIZE macros

Peter Zijlstra (26):
      x86/mm: Randomize per-cpu entry area
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

 arch/arm/mach-omap1/sram-init.c              |   8 +-
 arch/arm/mach-omap2/sram.c                   |   8 +-
 arch/mips/Kconfig                            |   2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h |   2 +-
 arch/powerpc/kernel/kprobes.c                |   9 +-
 arch/sh/Kconfig                              |   2 +-
 arch/sh/include/asm/pgtable-3level.h         |  10 +-
 arch/um/include/asm/pgtable-3level.h         |   8 --
 arch/x86/Kconfig                             |   2 +-
 arch/x86/include/asm/cmpxchg_32.h            |  28 -----
 arch/x86/include/asm/cmpxchg_64.h            |   5 -
 arch/x86/include/asm/cpu_entry_area.h        |   4 -
 arch/x86/include/asm/kasan.h                 |   3 +
 arch/x86/include/asm/page_types.h            |  12 +-
 arch/x86/include/asm/pgtable-3level.h        | 171 ++++++---------------------
 arch/x86/include/asm/pgtable-3level_types.h  |   7 ++
 arch/x86/include/asm/pgtable_64_types.h      |   1 +
 arch/x86/include/asm/pgtable_areas.h         |   8 +-
 arch/x86/include/asm/pgtable_types.h         |   4 +-
 arch/x86/include/asm/processor-flags.h       |   2 +-
 arch/x86/include/asm/set_memory.h            |   3 +
 arch/x86/kernel/alternative.c                |  10 --
 arch/x86/kernel/amd_gart_64.c                |   2 +-
 arch/x86/kernel/ftrace.c                     |   6 +-
 arch/x86/kernel/head64.c                     |   2 +-
 arch/x86/kernel/hw_breakpoint.c              |   2 +-
 arch/x86/kernel/kprobes/core.c               |   9 +-
 arch/x86/mm/cpu_entry_area.c                 |  50 +++++++-
 arch/x86/mm/init.c                           |   2 +-
 arch/x86/mm/kasan_init_64.c                  |  53 ++++++---
 arch/x86/mm/mem_encrypt_boot.S               |   4 +-
 arch/x86/mm/mem_encrypt_identity.c           |  18 +--
 arch/x86/mm/pat/set_memory.c                 | 105 ++++++++++------
 arch/x86/mm/pti.c                            |   2 +-
 drivers/iommu/intel/irq_remapping.c          |  13 +-
 drivers/misc/sram-exec.c                     |   7 +-
 include/linux/filter.h                       |   3 +-
 include/linux/pgtable.h                      |  73 +++++++-----
 include/linux/sched/task.h                   |   2 +-
 include/linux/set_memory.h                   |  10 ++
 init/main.c                                  |   4 +-
 kernel/bpf/bpf_struct_ops.c                  |   3 +-
 kernel/bpf/core.c                            |   6 +-
 kernel/bpf/trampoline.c                      |   3 +-
 kernel/events/core.c                         |   2 +-
 kernel/fork.c                                |  37 +++---
 mm/Kconfig                                   |   2 +-
 mm/gup.c                                     |   2 +-
 mm/hmm.c                                     |   3 +-
 mm/khugepaged.c                              |   2 +-
 mm/mapping_dirty_helpers.c                   |   2 +-
 mm/mprotect.c                                |   2 +-
 mm/userfaultfd.c                             |   2 +-
 mm/vmscan.c                                  |   5 +-
 net/bpf/bpf_dummy_struct_ops.c               |   3 +-
 55 files changed, 356 insertions(+), 394 deletions(-)
