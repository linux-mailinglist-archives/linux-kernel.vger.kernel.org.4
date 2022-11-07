Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A83261F6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 16:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiKGPBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 10:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiKGPBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 10:01:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9B1E723
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F076B811C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195D4C433D6;
        Mon,  7 Nov 2022 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667833193;
        bh=aMJ3eX1FctDeegxcGYIINeuo3WnfnMGdOvWc5TPUKGY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ATRYo1baXrH3yXGRx4jcYqqNWn6x4QxwY3gbR9x11MUMH/98UAJpiu6b15gRAEdD7
         peFSAMGGzAMlHUdJggqAzVSHjmffjd1K5tBs0qfO+bHvlH0toCbDKvK7WkobkCCBLZ
         gc59eQyJX2uGpOZj6H4puN4OqGceqVUnuEfcyHsCrt4rTzgZ7JgCKsgiUmDOuNmKqx
         S8v50NCOwkaKs2rOqnZhv5dqsMpfl5BX3nrgODoNdgm0u6m07kEMfbdwAXP4HZKqvj
         76cVBcflSE2K/b0VucAG0boCA3UWoE8tya9KkDtEOU8fAuvyg2OZjbWDiHFVkCQOMq
         6TaRerfFkBIaQ==
Message-ID: <0108ab72-efca-1027-23e8-e5d445929943@kernel.org>
Date:   Mon, 7 Nov 2022 06:59:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCHv11 00/16] Linear Address Masking enabling
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        linux-kernel@vger.kernel.org
References: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20221025001722.17466-1-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 17:17, Kirill A. Shutemov wrote:
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
> 
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in JITs and virtual machines.
> 
> The patchset brings support for LAM for userspace addresses. Only LAM_U57 at
> this time.
> 
> Please review and consider applying.

I'm pretty happy with this series other than my two comments (switch_mm 
race and explaining why untagged_addr needs to preserve kernel addresses).

> 
> Results for the self-tests:
> 
>     ok 1 MALLOC: LAM_U57. Dereferencing pointer with metadata
>     # Get segmentation fault(11).ok 2 MALLOC:[Negative] Disable LAM. Dereferencing pointer with metadata.
>     ok 3 BITS: Check default tag bits
>     ok 4 # SKIP MMAP: First mmap high address, then set LAM_U57.
>     ok 5 # SKIP MMAP: First LAM_U57, then High address.
>     ok 6 MMAP: First LAM_U57, then Low address.
>     ok 7 SYSCALL: LAM_U57. syscall with metadata
>     ok 8 SYSCALL:[Negative] Disable LAM. Dereferencing pointer with metadata.
>     ok 9 URING: LAM_U57. Dereferencing pointer with metadata
>     ok 10 URING:[Negative] Disable LAM. Dereferencing pointer with metadata.
>     ok 11 FORK: LAM_U57, child process should get LAM mode same as parent
>     ok 12 EXECVE: LAM_U57, child process should get disabled LAM mode
>     open: Device or resource busy
>     ok 13 PASID: [Negative] Execute LAM, PASID, SVA in sequence
>     ok 14 PASID: Execute LAM, SVA, PASID in sequence
>     ok 15 PASID: [Negative] Execute PASID, LAM, SVA in sequence
>     ok 16 PASID: Execute PASID, SVA, LAM in sequence
>     ok 17 PASID: Execute SVA, LAM, PASID in sequence
>     ok 18 PASID: Execute SVA, PASID, LAM in sequence
>     1..18
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam
> 
> v11:
>    - Move untag_mask to /proc/$PID/status;
>    - s/SVM/SVA/g;
>    - static inline arch_pgtable_dma_compat() instead of macros;
>    - Replace pasid_valid() with mm_valid_pasid();
>    - Acks from Ashok and Jacob (forgot to apply from v9);
> v10:
>    - Rebased to v6.1-rc1;
>    - Add selftest for SVM vs LAM;
> v9:
>    - Fix race between LAM enabling and check that KVM memslot address doesn't
>      have any tags;
>    - Reduce untagged_addr() overhead until the first LAM user;
>    - Clarify SVM vs. LAM semantics;
>    - Use mmap_lock to serialize LAM enabling;
> v8:
>    - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>    - Cleanup code around build_cr3();
>    - Fix commit messages;
>    - Selftests updates;
>    - Acked/Reviewed/Tested-bys from Alexander and Peter;
> v7:
>    - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>    - Cleanup code around build_cr3();
>    - Fix commit message;
>    - Fix indentation;
> v6:
>    - Rebased onto v6.0-rc1
>    - LAM_U48 excluded from the patchet. Still available in the git tree;
>    - add ARCH_GET_MAX_TAG_BITS;
>    - Fix build without CONFIG_DEBUG_VM;
>    - Update comments;
>    - Reviewed/Tested-by from Alexander;
> v5:
>    - Do not use switch_mm() in enable_lam_func()
>    - Use mb()/READ_ONCE() pair on LAM enabling;
>    - Add self-test by Weihong Zhang;
>    - Add comments;
> v4:
>    - Fix untagged_addr() for LAM_U48;
>    - Remove no-threads restriction on LAM enabling;
>    - Fix mm_struct access from /proc/$PID/arch_status
>    - Fix LAM handling in initialize_tlbstate_and_flush()
>    - Pack tlb_state better;
>    - Comments and commit messages;
> v3:
>    - Rebased onto v5.19-rc1
>    - Per-process enabling;
>    - API overhaul (again);
>    - Avoid branches and costly computations in the fast path;
>    - LAM_U48 is in optional patch.
> v2:
>    - Rebased onto v5.18-rc1
>    - New arch_prctl(2)-based API
>    - Expose status of LAM (or other thread features) in
>      /proc/$PID/arch_status
> 
> [1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368
> Kirill A. Shutemov (11):
>    x86/mm: Fix CR3_ADDR_MASK
>    x86: CPUID and CR3/CR4 flags for Linear Address Masking
>    mm: Pass down mm_struct to untagged_addr()
>    x86/mm: Handle LAM on context switch
>    x86/uaccess: Provide untagged_addr() and remove tags before address
>      check
>    KVM: Serialize tagged address check against tagging enabling
>    x86/mm: Provide arch_prctl() interface for LAM
>    x86/mm: Reduce untagged_addr() overhead until the first LAM user
>    mm: Expose untagging mask in /proc/$PID/status
>    iommu/sva: Replace pasid_valid() helper with mm_valid_pasid()
>    x86/mm, iommu/sva: Make LAM and SVA mutually exclusive
> 
> Weihong Zhang (5):
>    selftests/x86/lam: Add malloc and tag-bits test cases for
>      linear-address masking
>    selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
>      masking
>    selftests/x86/lam: Add io_uring test cases for linear-address masking
>    selftests/x86/lam: Add inherit test cases for linear-address masking
>    selftests/x86/lam: Add ARCH_FORCE_TAGGED_SVA test cases for
>      linear-address masking
> 
>   arch/arm64/include/asm/memory.h               |    4 +-
>   arch/arm64/include/asm/mmu_context.h          |    6 +
>   arch/arm64/include/asm/signal.h               |    2 +-
>   arch/arm64/include/asm/uaccess.h              |    2 +-
>   arch/arm64/kernel/hw_breakpoint.c             |    2 +-
>   arch/arm64/kernel/traps.c                     |    4 +-
>   arch/arm64/mm/fault.c                         |   10 +-
>   arch/sparc/include/asm/mmu_context_64.h       |    6 +
>   arch/sparc/include/asm/pgtable_64.h           |    2 +-
>   arch/sparc/include/asm/uaccess_64.h           |    2 +
>   arch/x86/include/asm/cpufeatures.h            |    1 +
>   arch/x86/include/asm/mmu.h                    |   12 +-
>   arch/x86/include/asm/mmu_context.h            |   47 +
>   arch/x86/include/asm/processor-flags.h        |    4 +-
>   arch/x86/include/asm/tlbflush.h               |   34 +
>   arch/x86/include/asm/uaccess.h                |   46 +-
>   arch/x86/include/uapi/asm/prctl.h             |    5 +
>   arch/x86/include/uapi/asm/processor-flags.h   |    6 +
>   arch/x86/kernel/process.c                     |    3 +
>   arch/x86/kernel/process_64.c                  |   81 +-
>   arch/x86/kernel/traps.c                       |    6 +-
>   arch/x86/mm/tlb.c                             |   48 +-
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |    2 +-
>   drivers/gpu/drm/radeon/radeon_gem.c           |    2 +-
>   drivers/infiniband/hw/mlx4/mr.c               |    2 +-
>   drivers/iommu/iommu-sva-lib.c                 |   16 +-
>   drivers/media/common/videobuf2/frame_vector.c |    2 +-
>   drivers/media/v4l2-core/videobuf-dma-contig.c |    2 +-
>   .../staging/media/atomisp/pci/hmm/hmm_bo.c    |    2 +-
>   drivers/tee/tee_shm.c                         |    2 +-
>   drivers/vfio/vfio_iommu_type1.c               |    2 +-
>   fs/proc/array.c                               |    6 +
>   fs/proc/task_mmu.c                            |    2 +-
>   include/linux/ioasid.h                        |    9 -
>   include/linux/mm.h                            |   11 -
>   include/linux/mmu_context.h                   |   14 +
>   include/linux/sched/mm.h                      |    8 +-
>   include/linux/uaccess.h                       |   15 +
>   lib/strncpy_from_user.c                       |    2 +-
>   lib/strnlen_user.c                            |    2 +-
>   mm/gup.c                                      |    6 +-
>   mm/madvise.c                                  |    2 +-
>   mm/mempolicy.c                                |    6 +-
>   mm/migrate.c                                  |    2 +-
>   mm/mincore.c                                  |    2 +-
>   mm/mlock.c                                    |    4 +-
>   mm/mmap.c                                     |    2 +-
>   mm/mprotect.c                                 |    2 +-
>   mm/mremap.c                                   |    2 +-
>   mm/msync.c                                    |    2 +-
>   tools/testing/selftests/x86/Makefile          |    2 +-
>   tools/testing/selftests/x86/lam.c             | 1149 +++++++++++++++++
>   virt/kvm/kvm_main.c                           |   14 +-
>   54 files changed, 1539 insertions(+), 92 deletions(-)
>   create mode 100644 tools/testing/selftests/x86/lam.c
> 

