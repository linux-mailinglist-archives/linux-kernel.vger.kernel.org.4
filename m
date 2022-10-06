Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287BD5F68AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJFN7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJFN7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:59:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106AC9411E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:58:59 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n74so2302483yba.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 06:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+YuoZmT4CdVaeJmCXtamdo4wpT48j9SRuR7X/Obpi8=;
        b=k4hRQcSXX5JjQYo+iakkHH05fcSOAuDnx2fZhjDqWO7F66LLlOstMRbBHxBhZbXY2P
         JbkaJ7cuc5WyaeM08s2NpgtwjHQOmsAL/NBLaHhwfm4BNEXkY55kaId1Dc5+sFdeAbJM
         OPF2vOSwGK77xi31bSpXePSyBjiOKNXbG91WCyetFoRMYou23+GrzSCt1tiIXNc5043l
         seCdkLL1gAwgKSMi7oeApt6/NZ9yVFKjIdxbM0dxlbMD1iPevoy/x3aY+kgN7JdwL53m
         5/46p+SHXUU2wH/QZFv/arSfy0FOl1FrzJdvxcNI7ek+De5GzFmj++zw/4x2JP2BoG+R
         A29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+YuoZmT4CdVaeJmCXtamdo4wpT48j9SRuR7X/Obpi8=;
        b=Z2uQUnBU1Sp9MPD6/RzIre7iEX0sfqkMyorjyydhGMwCVcVM/wl41BUNUa2EGnbFQh
         lssJBhlIwF8EYbbbA7gjpca3yeEeTdqtpm7ygb3V1lSEjA6vsC3O3XUbRufutZMCS2Hl
         AqSBFDzptgFWD3gq9YwMczzpMnDbed+eMUI7eI4d31X6j1mLi+L+7PpgNXdiVW1nKkhb
         kNFG8mgAj3eY2EMWtut8lmP7jCRtrZGSoy0OtOqeuEi8evLlpZhE1ssJpLle+OzjaiHJ
         M6gDavHG9K4IHWp7pLhc2S/yICxfZLTtartYduKrmp6BZHYApxmvyjVqHFyjCpby662Q
         yniA==
X-Gm-Message-State: ACrzQf02hzZHV/XscYzpLicXw30WsXY+oCdYQ3bhaSLyEpQM3lKLWoNk
        Ca6a3+HPZl6Ys1e+l0yzonO9TCQNfcw/DzF1eYPZew==
X-Google-Smtp-Source: AMsMyM6569uzjp7wIOkVrIiK3+Cucvhc4vsxZ0OCzNx1LMALdMvzKbWwnh2I4uFeAWJEVnPX5/tLRpWfgwfx3GodvBY=
X-Received: by 2002:a25:9d0a:0:b0:6bc:2641:19d4 with SMTP id
 i10-20020a259d0a000000b006bc264119d4mr4444038ybp.388.1665064737939; Thu, 06
 Oct 2022 06:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20220930144758.30232-1-kirill.shutemov@linux.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 6 Oct 2022 15:58:21 +0200
Message-ID: <CAG_fn=X0xfY-5DS+YSpaLy8mHhAoJoceTq0vb2xmGBxB75wGMA@mail.gmail.com>
Subject: Re: [PATCHv9 00/14] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 4:48 PM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Linear Address Masking[1] (LAM) modifies the checking that is applied to
> 64-bit linear addresses, allowing software to use of the untranslated
> address bits for metadata.
>
> The capability can be used for efficient address sanitizers (ASAN)
> implementation and for optimizations in virtual machines.
>
> The patchset brings support for LAM for userspace addresses. Only LAM_U57=
 at
> this time.
>
> Please review and consider applying.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git lam

Not a big deal, but this tree contains LAM_U48 patches, and after
skipping those the SVM patch does not apply cleanly.

> v9:
>   - Fix race between LAM enabling and check that KVM memslot address does=
n't
>     have any tags;
>   - Reduce untagged_addr() overhead until the first LAM user;
>   - Clarify SVM vs. LAM semantics;
>   - Use mmap_lock to serialize LAM enabling;
> v8:
>   - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>   - Cleanup code around build_cr3();
>   - Fix commit messages;
>   - Selftests updates;
>   - Acked/Reviewed/Tested-bys from Alexander and Peter;
> v7:
>   - Drop redundant smb_mb() in prctl_enable_tagged_addr();
>   - Cleanup code around build_cr3();
>   - Fix commit message;
>   - Fix indentation;
> v6:
>   - Rebased onto v6.0-rc1
>   - LAM_U48 excluded from the patchet. Still available in the git tree;
>   - add ARCH_GET_MAX_TAG_BITS;
>   - Fix build without CONFIG_DEBUG_VM;
>   - Update comments;
>   - Reviewed/Tested-by from Alexander;
> v5:
>   - Do not use switch_mm() in enable_lam_func()
>   - Use mb()/READ_ONCE() pair on LAM enabling;
>   - Add self-test by Weihong Zhang;
>   - Add comments;
> v4:
>   - Fix untagged_addr() for LAM_U48;
>   - Remove no-threads restriction on LAM enabling;
>   - Fix mm_struct access from /proc/$PID/arch_status
>   - Fix LAM handling in initialize_tlbstate_and_flush()
>   - Pack tlb_state better;
>   - Comments and commit messages;
> v3:
>   - Rebased onto v5.19-rc1
>   - Per-process enabling;
>   - API overhaul (again);
>   - Avoid branches and costly computations in the fast path;
>   - LAM_U48 is in optional patch.
> v2:
>   - Rebased onto v5.18-rc1
>   - New arch_prctl(2)-based API
>   - Expose status of LAM (or other thread features) in
>     /proc/$PID/arch_status
>
> [1] ISE, Chapter 10. https://cdrdv2.intel.com/v1/dl/getContent/671368
>
> Kirill A. Shutemov (10):
>   x86/mm: Fix CR3_ADDR_MASK
>   x86: CPUID and CR3/CR4 flags for Linear Address Masking
>   mm: Pass down mm_struct to untagged_addr()
>   x86/mm: Handle LAM on context switch
>   x86/uaccess: Provide untagged_addr() and remove tags before address
>     check
>   KVM: Serialize tagged address check against tagging enabling
>   x86/mm: Provide arch_prctl() interface for LAM
>   x86/mm: Reduce untagged_addr() overhead until the first LAM user
>   x86: Expose untagging mask in /proc/$PID/arch_status
>   x86/mm, iommu/sva: Make LAM and SVM mutually exclusive
>
> Weihong Zhang (4):
>   selftests/x86/lam: Add malloc and tag-bits test cases for
>     linear-address masking
>   selftests/x86/lam: Add mmap and SYSCALL test cases for linear-address
>     masking
>   selftests/x86/lam: Add io_uring test cases for linear-address masking
>   selftests/x86/lam: Add inherit test cases for linear-address masking
>
>  arch/arm64/include/asm/memory.h               |   4 +-
>  arch/arm64/include/asm/signal.h               |   2 +-
>  arch/arm64/include/asm/uaccess.h              |   4 +-
>  arch/arm64/kernel/hw_breakpoint.c             |   2 +-
>  arch/arm64/kernel/traps.c                     |   4 +-
>  arch/arm64/mm/fault.c                         |  10 +-
>  arch/sparc/include/asm/pgtable_64.h           |   2 +-
>  arch/sparc/include/asm/uaccess_64.h           |   2 +
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/mmu.h                    |  12 +-
>  arch/x86/include/asm/mmu_context.h            |  47 +
>  arch/x86/include/asm/processor-flags.h        |   4 +-
>  arch/x86/include/asm/tlbflush.h               |  35 +
>  arch/x86/include/asm/uaccess.h                |  46 +-
>  arch/x86/include/uapi/asm/prctl.h             |   5 +
>  arch/x86/include/uapi/asm/processor-flags.h   |   6 +
>  arch/x86/kernel/Makefile                      |   2 +
>  arch/x86/kernel/fpu/xstate.c                  |  47 -
>  arch/x86/kernel/proc.c                        |  60 ++
>  arch/x86/kernel/process.c                     |   3 +
>  arch/x86/kernel/process_64.c                  |  82 +-
>  arch/x86/mm/tlb.c                             |  48 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +-
>  drivers/gpu/drm/radeon/radeon_gem.c           |   2 +-
>  drivers/infiniband/hw/mlx4/mr.c               |   2 +-
>  drivers/iommu/iommu-sva-lib.c                 |  12 +
>  drivers/media/common/videobuf2/frame_vector.c |   2 +-
>  drivers/media/v4l2-core/videobuf-dma-contig.c |   2 +-
>  .../staging/media/atomisp/pci/hmm/hmm_bo.c    |   2 +-
>  drivers/tee/tee_shm.c                         |   2 +-
>  drivers/vfio/vfio_iommu_type1.c               |   2 +-
>  fs/proc/task_mmu.c                            |   2 +-
>  include/linux/mm.h                            |  11 -
>  include/linux/mmu_context.h                   |   4 +
>  include/linux/uaccess.h                       |  15 +
>  lib/strncpy_from_user.c                       |   2 +-
>  lib/strnlen_user.c                            |   2 +-
>  mm/gup.c                                      |   6 +-
>  mm/madvise.c                                  |   2 +-
>  mm/mempolicy.c                                |   6 +-
>  mm/migrate.c                                  |   2 +-
>  mm/mincore.c                                  |   2 +-
>  mm/mlock.c                                    |   4 +-
>  mm/mmap.c                                     |   2 +-
>  mm/mprotect.c                                 |   2 +-
>  mm/mremap.c                                   |   2 +-
>  mm/msync.c                                    |   2 +-
>  tools/testing/selftests/x86/Makefile          |   2 +-
>  tools/testing/selftests/x86/lam.c             | 916 ++++++++++++++++++
>  virt/kvm/kvm_main.c                           |  14 +-
>  51 files changed, 1331 insertions(+), 125 deletions(-)
>  create mode 100644 arch/x86/kernel/proc.c
>  create mode 100644 tools/testing/selftests/x86/lam.c
>
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
