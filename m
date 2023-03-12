Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7053B6B6562
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 12:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCLL0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 07:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCLL0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 07:26:33 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257EC31E05
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678620392; x=1710156392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mQHOwlRgDt6FqOy5qR8eaZ5q38UiDzAyW+c27c530ow=;
  b=LO2YoXVl4M+0i+vJbAwCEXvUe/7Q7dNFSRMdMcPymnyc11fPdWkI/9Q/
   9mKVOiobQdQATa31EeU0ggsHu+GbmwBBFcNY9lBrB7qAVMrEBfFMfppjr
   25p94o4gLEDBnMEZHQ9miiQSsyGAwnqss0zlHTXFLrrvmvXrPRB6GNGVh
   viDVJQBspzAnfJVio8X0N5+/AswzgkhsyQcqIkGV83QZzN3FkmOLaM1fC
   /n0yf/QkqRoZs0LnAFfzT6RFZ3YOINjeYla3IhxtSm9WtOIwJ5ICFAUt3
   ZzfFliIjcY8xU4wxfbcgMWLuXovhE6SyNfoRRy5bX+IWyp9LNBykD1Rcf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="339349937"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="339349937"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10646"; a="852438017"
X-IronPort-AV: E=Sophos;i="5.98,254,1673942400"; 
   d="scan'208";a="852438017"
Received: from nmoazzen-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.251.219.215])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2023 04:26:22 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 543AF103248; Sun, 12 Mar 2023 14:26:19 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv16 00/17] Linear Address Masking enabling
Date:   Sun, 12 Mar 2023 14:25:55 +0300
Message-Id: <20230312112612.31869-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

Linear Address Masking[1] (LAM) modifies the checking that is applied to
64-bit linear addresses, allowing software to use of the untranslated
address bits for metadata.

The capability can be used for efficient address sanitizers (ASAN)
implementation and for optimizations in JITs and virtual machines.

The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
this time.

Please review and consider applying.

git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

v16:
  - Add #include <linux/mmu_context.h> into fs/proc/array.c;
  - Whitespace fix;
  - Add Alexander's Tested-bys;
v15:
  - Replace static branch in untagged_addr() with alternative;
  - Drop unneeded READ_ONCE();
  - Acks from Peter;
v14:
  - Rework address range check in get_user() and put_user();
  - Introduce CONFIG_ADDRESS_MASKING;
  - Cache untag masking in per-CPU variable;
  - Reject LAM enabling via PTRACE_ARCH_PRCTL;
  - Fix locking around untagged_addr_remote();
  - Fix typo in MM_CONTEXT_ conversion patch;
  - Fix selftest;
v13:
  - Fix race between untagged_addr() and LAM enabling:
    + Do not allow to enable LAM after the process spawned the second thread;
    + untagged_addr() untags the address according to rules of the current
      process;
    + untagged_addr_remote() can be used for untagging addresses for foreign
      process. It requires mmap lock for the target process to be taken;
v12:
  - Rebased onto tip/x86/mm;
  - Drop VM_WARN_ON() that may produce false-positive on race between context
    switch and LAM enabling;
  - Adjust comments explain possible race;
  - User READ_ONCE() in mm_lam_cr3_mask();
  - Do not assume &init_mm == mm in initialize_tlbstate_and_flush();
  - Ack by Andy;
v11:
  - Move untag_mask to /proc/$PID/status;
  - s/SVM/SVA/g;
  - static inline arch_pgtable_dma_compat() instead of macros;
  - Replace pasid_valid() with mm_valid_pasid();
  - Acks from Ashok and Jacob (forgot to apply from v9);
v10:
  - Rebased to v6.1-rc1;
  - Add selftest for SVM vs LAM;
v9:
  - Fix race between LAM enabling and check that KVM memslot address doesn't
    have any tags;
  - Reduce untagged_addr() overhead until the first LAM user;
  - Clarify SVM vs. LAM semantics;
  - Use mmap_lock to serialize LAM enabling;
v8:
  - Drop redundant smb_mb() in prctl_enable_tagged_addr();
  - Cleanup code around build_cr3();
  - Fix commit messages;
  - Selftests updates;
  - Acked/Reviewed/Tested-bys from Alexander and Peter;
v7:
  - Drop redundant smb_mb() in prctl_enable_tagged_addr();
  - Cleanup code around build_cr3();
  - Fix commit message;
  - Fix indentation;
v6:
  - Rebased onto v6.0-rc1
  - LAM_U48 excluded from the patchet. Still available in the git tree;
  - add ARCH_GET_MAX_TAG_BITS;
  - Fix build without CONFIG_DEBUG_VM;
  - Update comments;
  - Reviewed/Tested-by from Alexander;
v5:
  - Do not use switch_mm() in enable_lam_func()
  - Use mb()/READ_ONCE() pair on LAM enabling;
  - Add self-test by Weihong Zhang;
  - Add comments;
v4:
  - Fix untagged_addr() for LAM_U48;
  - Remove no-threads restriction on LAM enabling;
  - Fix mm_struct access from /proc/$PID/arch_status
  - Fix LAM handling in initialize_tlbstate_and_flush()
  - Pack tlb_state better;
  - Comments and commit messages;
v3:
  - Rebased onto v5.19-rc1
  - Per-process enabling;
  - API overhaul (again);
  - Avoid branches and costly computations in the fast path;
  - LAM_U48 is in optional patch.
v2:
  - Rebased onto v5.18-rc1
  - New arch_prctl(2)-based API
  - Expose status of LAM (or other thread features) in
    /proc/$PID/arch_status

[1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368

Kirill A. Shutemov (12):
  x86/mm: Rework address range check in get_user() and put_user()
  x86: Allow atomic MM_CONTEXT flags setting
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  x86/mm: Handle LAM on context switch
  mm: Introduce untagged_addr_remote()
  x86/uaccess: Provide untagged_addr() and remove tags before address
    check
  x86/mm: Reduce untagged_addr() overhead for systems without LAM
  x86/mm: Provide arch_prctl() interface for LAM
  mm: Expose untagging mask in /proc/$PID/status
  iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
  x86/mm/iommu/sva: Make LAM and SVA mutually exclusive
  selftests/x86/lam: Add test cases for LAM vs thread creation

Weihong Zhang (5):
  selftests/x86/lam: Add malloc and tag-bits test cases for
    linear-address masking
  selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
    masking
  selftests/x86/lam: Add io_uring test cases for linear-address masking
  selftests/x86/lam: Add inherit test cases for linear-address masking
  selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for
    linear-address masking

 arch/arm64/include/asm/mmu_context.h        |    6 +
 arch/sparc/include/asm/mmu_context_64.h     |    6 +
 arch/sparc/include/asm/uaccess_64.h         |    2 +
 arch/x86/Kconfig                            |   11 +
 arch/x86/entry/vsyscall/vsyscall_64.c       |    2 +-
 arch/x86/include/asm/cpufeatures.h          |    1 +
 arch/x86/include/asm/disabled-features.h    |    8 +-
 arch/x86/include/asm/mmu.h                  |   18 +-
 arch/x86/include/asm/mmu_context.h          |   49 +-
 arch/x86/include/asm/processor-flags.h      |    2 +
 arch/x86/include/asm/tlbflush.h             |   48 +-
 arch/x86/include/asm/uaccess.h              |   58 +-
 arch/x86/include/uapi/asm/prctl.h           |    5 +
 arch/x86/include/uapi/asm/processor-flags.h |    6 +
 arch/x86/kernel/process.c                   |    6 +
 arch/x86/kernel/process_64.c                |   66 +-
 arch/x86/kernel/traps.c                     |    6 +-
 arch/x86/lib/getuser.S                      |   83 +-
 arch/x86/lib/putuser.S                      |   54 +-
 arch/x86/mm/init.c                          |    5 +
 arch/x86/mm/tlb.c                           |   53 +-
 drivers/iommu/iommu-sva.c                   |    8 +-
 drivers/vfio/vfio_iommu_type1.c             |    2 +-
 fs/proc/array.c                             |    7 +
 fs/proc/task_mmu.c                          |    9 +-
 include/linux/ioasid.h                      |    9 -
 include/linux/mm.h                          |   11 -
 include/linux/mmu_context.h                 |   14 +
 include/linux/sched/mm.h                    |    8 +-
 include/linux/uaccess.h                     |   22 +
 mm/gup.c                                    |    4 +-
 mm/madvise.c                                |    5 +-
 mm/migrate.c                                |   11 +-
 tools/testing/selftests/x86/Makefile        |    2 +-
 tools/testing/selftests/x86/lam.c           | 1241 +++++++++++++++++++
 35 files changed, 1699 insertions(+), 149 deletions(-)
 create mode 100644 tools/testing/selftests/x86/lam.c

-- 
2.39.2

