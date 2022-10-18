Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5019C602A50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 13:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJRLfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 07:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiJRLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 07:35:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B275748CA4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 04:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666092890; x=1697628890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uj83xpMN1i7Byi13u/y4I0Mcm1iychuckcdEJnPJRDs=;
  b=R0+BXrSg5UtKiMhLGuXC7hiiZMo/ECS8cUcH79CtfAhMzeBiXwljrhi3
   j1SzEvQd/NcnQtTEAp4TGBorCAzsE2LbDVszkYnOtvIuhQ54YLWTHPw1l
   Zz0Gl/BUgdT0HomORavmkPzM045O710iXXoZefJV9atdA6UBNb/qSpWgn
   5ALnTdD3+4z+1Hy5Bft+FYBFFFVrtJGEDxQdd2yu24xYuj4EqnDSuJbpz
   s7oRWuSVtJxO++w7V8M1YeG6V0uzIeuWTd0fEXli3BV+/isIiDGX1GWaT
   XaSwiv1bPXBVmB4oLISLkgsgyMQYRRnLX+GojDkY76VxrVjKjbqpPhJd5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="368105797"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="368105797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="691763143"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="691763143"
Received: from vhavel-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.51.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 04:34:06 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E5CF51046BC; Tue, 18 Oct 2022 14:34:03 +0300 (+03)
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
        Ashok Raj <ashok.raj@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv10 00/15] Linear Address Masking enabling
Date:   Tue, 18 Oct 2022 14:33:43 +0300
Message-Id: <20221018113358.7833-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
implementation and for optimizations in virtual machines.

The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
this time.

Please review and consider applying.

Results for the self-tests:

   ok 1 MALLOC: LAM_U57. Dereferencing pointer with metadata
   # Get segmentation fault(11).ok 2 MALLOC:[Negative] Disable LAM. Dereferencing pointer with metadata.
   ok 3 BITS: Check default tag bits
   ok 4 # SKIP MMAP: First mmap high address, then set LAM_U57.
   ok 5 # SKIP MMAP: First LAM_U57, then High address.
   ok 6 MMAP: First LAM_U57, then Low address.
   ok 7 SYSCALL: LAM_U57. syscall with metadata
   ok 8 SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.
   ok 9 URING: LAM_U57. Dereferencing pointer with metadata
   ok 10 URING:[Negative] Disable LAM. Dereferencing pointer with metadata.
   ok 11 FORK: LAM_U57, child process should get LAM mode same as parent
   ok 12 EXECVE: LAM_U57, child process should get disabled LAM mode
   open: Device or resource busy
   ok 13 PASID: [Negative] Execute LAM, PASID, SVM in sequence
   ok 14 PASID: Execute LAM, SVM, PASID in sequence
   ok 15 PASID: [Negative] Execute PASID, LAM, SVM in sequence
   ok 16 PASID: Execute PASID, SVM, LAM in sequence
   ok 17 PASID: Execute SVM, LAM, PASID in sequence
   ok 18 PASID: Execute SVM, PASID, LAM in sequence
   1..18

git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

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

Kirill A. Shutemov (10):
  x86/mm: Fix CR3_ADDR_MASK
  x86: CPUID and CR3/CR4 flags for Linear Address Masking
  mm: Pass down mm_struct to untagged_addr()
  x86/mm: Handle LAM on context switch
  x86/uaccess: Provide untagged_addr() and remove tags before address
    check
  KVM: Serialize tagged address check against tagging enabling
  x86/mm: Provide arch_prctl() interface for LAM
  x86/mm: Reduce untagged_addr() overhead until the first LAM user
  x86: Expose untagging mask in /proc/$PID/arch_status
  x86/mm, iommu/sva: Make LAM and SVM mutually exclusive

Weihong Zhang (5):
  selftests/x86/lam: Add malloc and tag-bits test cases for
    linear-address masking
  selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
    masking
  selftests/x86/lam: Add io_uring test cases for linear-address masking
  selftests/x86/lam: Add inherit test cases for linear-address masking
  selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVM test cases for
    linear-address masking

 arch/arm64/include/asm/memory.h               |    4 +-
 arch/arm64/include/asm/signal.h               |    2 +-
 arch/arm64/include/asm/uaccess.h              |    2 +-
 arch/arm64/kernel/hw_breakpoint.c             |    2 +-
 arch/arm64/kernel/traps.c                     |    4 +-
 arch/arm64/mm/fault.c                         |   10 +-
 arch/sparc/include/asm/pgtable_64.h           |    2 +-
 arch/sparc/include/asm/uaccess_64.h           |    2 +
 arch/x86/include/asm/cpufeatures.h            |    1 +
 arch/x86/include/asm/mmu.h                    |   12 +-
 arch/x86/include/asm/mmu_context.h            |   47 +
 arch/x86/include/asm/processor-flags.h        |    4 +-
 arch/x86/include/asm/tlbflush.h               |   35 +
 arch/x86/include/asm/uaccess.h                |   46 +-
 arch/x86/include/uapi/asm/prctl.h             |    5 +
 arch/x86/include/uapi/asm/processor-flags.h   |    6 +
 arch/x86/kernel/Makefile                      |    2 +
 arch/x86/kernel/fpu/xstate.c                  |   47 -
 arch/x86/kernel/proc.c                        |   60 +
 arch/x86/kernel/process.c                     |    3 +
 arch/x86/kernel/process_64.c                  |   82 +-
 arch/x86/mm/tlb.c                             |   48 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |    2 +-
 drivers/gpu/drm/radeon/radeon_gem.c           |    2 +-
 drivers/infiniband/hw/mlx4/mr.c               |    2 +-
 drivers/iommu/iommu-sva-lib.c                 |   12 +
 drivers/media/common/videobuf2/frame_vector.c |    2 +-
 drivers/media/v4l2-core/videobuf-dma-contig.c |    2 +-
 .../staging/media/atomisp/pci/hmm/hmm_bo.c    |    2 +-
 drivers/tee/tee_shm.c                         |    2 +-
 drivers/vfio/vfio_iommu_type1.c               |    2 +-
 fs/proc/task_mmu.c                            |    2 +-
 include/linux/mm.h                            |   11 -
 include/linux/mmu_context.h                   |    4 +
 include/linux/uaccess.h                       |   15 +
 lib/strncpy_from_user.c                       |    2 +-
 lib/strnlen_user.c                            |    2 +-
 mm/gup.c                                      |    6 +-
 mm/madvise.c                                  |    2 +-
 mm/mempolicy.c                                |    6 +-
 mm/migrate.c                                  |    2 +-
 mm/mincore.c                                  |    2 +-
 mm/mlock.c                                    |    4 +-
 mm/mmap.c                                     |    2 +-
 mm/mprotect.c                                 |    2 +-
 mm/mremap.c                                   |    2 +-
 mm/msync.c                                    |    2 +-
 tools/testing/selftests/x86/Makefile          |    2 +-
 tools/testing/selftests/x86/lam.c             | 1149 +++++++++++++++++
 virt/kvm/kvm_main.c                           |   14 +-
 51 files changed, 1563 insertions(+), 124 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c
 create mode 100644 tools/testing/selftests/x86/lam.c

-- 
2.38.0

