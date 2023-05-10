Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA46FD520
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 06:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjEJEje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 00:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbjEJEja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 00:39:30 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA194218
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 21:39:26 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55d2e87048cso100411787b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 21:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683693566; x=1686285566;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pNtnMqwecxgAyJiNrU/av2u9SKsTTnkqGeLPsFfUGRY=;
        b=cNF0lopRgs5z+paNDd47dgtG8TBjwZyJSBqFjK6ksHmrX2HqmLMYrrKsDdWDE4galp
         I1RIa58CxJ4eWJPHfaXHtCDPLpNhfN/aCMBSDVyVUdoFoZEKW8H5uRAddSBQuOjqxl6G
         cijgVp5qOvAn/BuT5Kj3i7X1ZHy6xq4kMM1JJiMLi60Voi2WzpeuiP4d77oQFZQJJTpA
         DHkrQmjDtXwQxtNqUbLbFtn/koUU8sha9n5T/jPfXiKq7pKvhvnWuqWej7kSJ3OgTY5v
         znwXH+YUrN8s6GiaQCUoDOK5c9Mq29M3c3H1/3qfehC4bHIrJ+vibMAeHVK8iG01ICVy
         zeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683693566; x=1686285566;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNtnMqwecxgAyJiNrU/av2u9SKsTTnkqGeLPsFfUGRY=;
        b=IpJI0Ds0nVRMEODyrABk1fKfFRc5yjBgHzAsYVQ+MgeL2OKYmTDnFL9vPp95HMdYzf
         IjSFpS/EvRLMx9vrKNzWSgIwJMehs7yOSlvdHu03SEgf5GpcYVN764Le+fbpDRmYDuXe
         3uA5NjLdjZSOa77U3pJvspg1fqCbmrAUGl1Rcb9l+8Qwsd94v0CKOA87DP56x65CKybi
         aMYBXuRj0KEqxALFNW479JMckyre/01ls+8vCx/Vh8vKLPZv3ArV9t6/BVMDhy6TRKDo
         XkkGoaAjSpWInj4+V8xgWS4zzzGykL8m3+2P88t2HqcKRW5Lit0FOgl3BT/C2OPPtkwW
         Z0Zg==
X-Gm-Message-State: AC+VfDz90cKiQMtL5b1YqeiprPm4WVWkn+xr6Y1+wcUMMFluXbt15e4d
        mCWv9mMRTfr7f4lx0W2emooRKg==
X-Google-Smtp-Source: ACHHUZ4tMEgG7AqlQIxMPNzAEIonGfK8+PPQUmJOyuPgdF6IMlPRJRM0QpGl7CYyO+0nNXPmO2L3jg==
X-Received: by 2002:a0d:cc0b:0:b0:55a:9b56:acee with SMTP id o11-20020a0dcc0b000000b0055a9b56aceemr18605566ywd.38.1683693565918;
        Tue, 09 May 2023 21:39:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i185-20020a816dc2000000b0055d5c626be5sm3775822ywc.26.2023.05.09.21.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 21:39:25 -0700 (PDT)
Date:   Tue, 9 May 2023 21:39:13 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/23] arch: allow pte_offset_map[_lock]() to fail
Message-ID: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches to various architectures, based on v6.4-rc1:
preparing for changes expected to follow in mm, affecting pte_offset_map()
and pte_offset_map_lock().

In a week or two, I intend to post a separate series, of equivalent
preparations in mm.  These two series are "independent": neither depends
for build or correctness on the other, and the arch patches can be merged
separately via arch trees (stragglers picked up by akpm?); but both series
have to be in before a third series is added to make the effective changes
(and that will add a just a little more in powerpc, s390 and sparc).

What is it all about?  Some mmap_lock avoidance i.e. latency reduction.
Initially just for the case of collapsing shmem or file pages to THPs;
but likely to be relied upon later in other contexts e.g. freeing of
empty page tables (but that's not work I'm doing).  mmap_write_lock
avoidance when collapsing to anon THPs?  Perhaps, but again that's not
work I've done: a quick and easy attempt looked like it was going to
shift the load from mmap rwsem to pmd spinlock - not an improvement.

I would much prefer not to have to make these small but wide-ranging
changes for such a niche case; but failed to find another way, and
have heard that shmem MADV_COLLAPSE's usefulness is being limited by
that mmap_write_lock it currently requires.

These changes (though of course not these exact patches, and not all
of these architectures!) have been in Google's data centre kernel for
three years now: we do rely upon them.

What are the per-arch changes about?  Generally, two things.

One: the current mmap locking may not be enough to guard against that
tricky transition between pmd entry pointing to page table, and empty
pmd entry, and pmd entry pointing to huge page: pte_offset_map() will
have to validate the pmd entry for itself, returning NULL if no page
table is there.  What to do about that varies: often the nearby error
handling indicates just to skip it; but in some cases a "goto again"
looks appropriate (and if that risks an infinite loop, then there
must have been an oops, or pfn 0 mistaken for page table, before).

Deeper study of each site might show that 90% of them here in arch
code could only fail if there's corruption e.g. a transition to THP
would be surprising on an arch without HAVE_ARCH_TRANSPARENT_HUGEPAGE.
But given the likely extension to freeing empty page tables, I have
not limited this set of changes to THP; and it has been easier, and
sets a better example, if each site is given appropriate handling.

Two: pte_offset_map() will need to do an rcu_read_lock(), with the
corresponding rcu_read_unlock() in pte_unmap().  But most architectures
never supported CONFIG_HIGHPTE, so some don't always call pte_unmap()
after pte_offset_map(), or have used userspace pte_offset_map() where
pte_offset_kernel() is more correct.  No problem in the current tree,
but a problem once an rcu_read_unlock() will be needed to keep balance.

A common special case of that comes in arch/*/mm/hugetlbpage.c, if
the architecture supports hugetlb pages down at the lowest PTE level.
huge_pte_alloc() uses pte_alloc_map(), but generic hugetlb code does
no corresponding pte_unmap(); similarly for huge_pte_offset().
Thanks to Mike Kravetz and Andrew Morton, v6.4-rc1 already provides
pte_alloc_huge() and pte_offset_huge() to help fix up those cases.

01/23 arm: allow pte_offset_map[_lock]() to fail
02/23 arm64: allow pte_offset_map() to fail
03/23 arm64/hugetlb: pte_alloc_huge() pte_offset_huge()
04/23 ia64/hugetlb: pte_alloc_huge() pte_offset_huge()
05/23 m68k: allow pte_offset_map[_lock]() to fail
06/23 microblaze: allow pte_offset_map() to fail
07/23 mips: update_mmu_cache() can replace __update_tlb()
08/23 parisc: add pte_unmap() to balance get_ptep()
09/23 parisc: unmap_uncached_pte() use pte_offset_kernel()
10/23 parisc/hugetlb: pte_alloc_huge() pte_offset_huge()
11/23 powerpc: kvmppc_unmap_free_pmd() pte_offset_kernel()
12/23 powerpc: allow pte_offset_map[_lock]() to fail
13/23 powerpc/hugetlb: pte_alloc_huge()
14/23 riscv/hugetlb: pte_alloc_huge() pte_offset_huge()
15/23 s390: allow pte_offset_map_lock() to fail
16/23 s390: gmap use pte_unmap_unlock() not spin_unlock()
17/23 sh/hugetlb: pte_alloc_huge() pte_offset_huge()
18/23 sparc/hugetlb: pte_alloc_huge() pte_offset_huge()
19/23 sparc: allow pte_offset_map() to fail
20/23 sparc: iounit and iommu use pte_offset_kernel()
21/23 x86: Allow get_locked_pte() to fail
22/23 x86: sme_populate_pgd() use pte_offset_kernel()
23/23 xtensa: add pte_unmap() to balance pte_offset_map()

 arch/arm/lib/uaccess_with_memcpy.c      |  3 ++
 arch/arm/mm/fault-armv.c                |  5 ++-
 arch/arm/mm/fault.c                     |  3 ++
 arch/arm64/mm/fault.c                   |  3 ++
 arch/arm64/mm/hugetlbpage.c             | 11 ++----
 arch/ia64/mm/hugetlbpage.c              |  4 +--
 arch/m68k/include/asm/mmu_context.h     |  6 ++--
 arch/m68k/kernel/sys_m68k.c             |  2 ++
 arch/m68k/mm/mcfmmu.c                   | 52 +++++++++++----------------
 arch/microblaze/kernel/signal.c         |  5 +--
 arch/mips/include/asm/pgtable.h         | 15 ++------
 arch/mips/mm/tlb-r3k.c                  |  5 +--
 arch/mips/mm/tlb-r4k.c                  |  9 ++---
 arch/parisc/kernel/cache.c              | 26 +++++++++++---
 arch/parisc/kernel/pci-dma.c            |  2 +-
 arch/parisc/mm/hugetlbpage.c            |  4 +--
 arch/powerpc/kvm/book3s_64_mmu_radix.c  |  2 +-
 arch/powerpc/mm/book3s64/hash_tlb.c     |  4 +++
 arch/powerpc/mm/book3s64/subpage_prot.c |  2 ++
 arch/powerpc/mm/hugetlbpage.c           |  2 +-
 arch/powerpc/xmon/xmon.c                |  5 ++-
 arch/riscv/mm/hugetlbpage.c             |  4 +--
 arch/s390/kernel/uv.c                   |  2 ++
 arch/s390/mm/gmap.c                     | 24 +++++++------
 arch/s390/mm/pgtable.c                  | 12 +++++--
 arch/sh/mm/hugetlbpage.c                |  4 +--
 arch/sparc/kernel/signal32.c            |  2 ++
 arch/sparc/mm/fault_64.c                |  3 ++
 arch/sparc/mm/hugetlbpage.c             |  4 +--
 arch/sparc/mm/io-unit.c                 |  2 +-
 arch/sparc/mm/iommu.c                   |  2 +-
 arch/sparc/mm/tlb.c                     |  2 ++
 arch/x86/kernel/ldt.c                   |  6 ++--
 arch/x86/mm/mem_encrypt_identity.c      |  2 +-
 arch/xtensa/mm/tlb.c                    |  5 ++-
 35 files changed, 140 insertions(+), 104 deletions(-)

Hugh
