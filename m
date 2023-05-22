Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125FE70B42D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjEVEql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjEVEqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:46:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF2E0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:46:37 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba841216e92so8131788276.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684730796; x=1687322796;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PQWOt6gBc+CKDhx+TRiKDHcqxVuU7yFMtWFx3Old4wc=;
        b=xs7LnD3g01pC8tEgDYoSLWJNQiRFSCcFpPWkFQaxEplgFZwjHZdso8hybJ0lCp7R7o
         knFdhCFFwMz5GBWAhY+FVJASGIZDJoTFm7uwFtiukkYVNgYW+4Ll7KT25jalnATTLyNX
         PweKEETGzwyq818ek0NNVOc2y9iJNx1QaRZnN2ttWXNtj0c/cQN2RKbBzPbYr/gtj1xw
         IX/8mFVZyMhqbSediiSa3E+s9E4MTmxwiU/RrI5jKBlBSjlcT3NL1CJUNb+68ZO2AOcH
         Ddm9/MwfnfCIdgn2A45f+epy2MIvR5wmFZMQmVKYYNzXegUOBDieOb3S4X4/hX7vG2TI
         9DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684730796; x=1687322796;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQWOt6gBc+CKDhx+TRiKDHcqxVuU7yFMtWFx3Old4wc=;
        b=U8XJLIjKpL9I+u0KAT78R1mdfBBLxNlcXAanXVsEkcVnbp3XRsXtc0C8NJ1TkjU9bv
         v9/mEIYhs4y7zjjT1aGrPFYJXTFkPSNd0q0FIM4O1E2zqM4oCOV7MWfkSCTlSVM1G/8x
         CJFkl5jn/9NvKlhuIbdvxQ4uZNiPOItgw+XgiKNaU7zxqrB222VgLsMTf2qv3+LmaTd0
         NFdpunrdNybhoKb3IxNpzO4x8vVVMYfC7etZXPbzKyWTgv+1Mb5+irIEOTPiJvl0oiIB
         cExzjb6mHsYdsg+8FGjjmZFx8gD+nyml7cbdsr+agsj/CNPyaF2f1a37RDixFo8CvH8N
         WZag==
X-Gm-Message-State: AC+VfDybiGxqWftHBm22vhCC8AHEHRuyW+VAiTEh7d2DvL2bGqpOyR5u
        5NIj0XJVKAFsKqhS33pEaKXKKg==
X-Google-Smtp-Source: ACHHUZ5m9LLsR+uIw2+klOp58MI6kQmpKTJ2WRYOi9XUbXnhehZ8WAVxgEjjZAI/8TbxyyzIi8mmXw==
X-Received: by 2002:a25:ea01:0:b0:ba6:9eb7:c41 with SMTP id p1-20020a25ea01000000b00ba69eb70c41mr10240608ybd.52.1684730795969;
        Sun, 21 May 2023 21:46:35 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g1-20020a259341000000b00b9a7db655ecsm981325ybo.23.2023.05.21.21.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 21:46:35 -0700 (PDT)
Date:   Sun, 21 May 2023 21:46:25 -0700 (PDT)
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
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 00/31] mm: allow pte_offset_map[_lock]() to fail
Message-ID: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a series of patches to mm, based on v6.4-rc2: preparing for
changes to follow (mostly in mm/khugepaged.c) affecting pte_offset_map()
and pte_offset_map_lock().

This follows on from the "arch: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com/
series of 23 posted on 2023-05-09.  These two series are "independent":
neither depends for build or correctness on the other, but both series
have to be in before a third series is added to make the effective changes
- though I anticipate that people will want to see at least an initial
version of that third series soon, to complete the context for them all.

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

These changes (though of course not these exact patches) have been in
Google's data centre kernel for three years now: we do rely upon them.

What is this preparatory series about?

The current mmap locking will not be enough to guard against that
tricky transition between pmd entry pointing to page table, and empty
pmd entry, and pmd entry pointing to huge page: pte_offset_map() will
have to validate the pmd entry for itself, returning NULL if no page
table is there.  What to do about that varies: sometimes nearby error
handling indicates just to skip it; but in many cases an ACTION_AGAIN or
"goto again" is appropriate (and if that risks an infinite loop, then
there must have been an oops, or pfn 0 mistaken for page table, before).

Given the likely extension to freeing empty page tables, I have not
limited this set of changes to a THP config; and it has been easier,
and sets a better example, if each site is given appropriate handling:
even where deeper study might prove that failure could only happen if
the pmd table were corrupted.

Several of the patches are, or include, cleanup on the way; and by the
end, pmd_trans_unstable() and suchlike are deleted: pte_offset_map() and
pte_offset_map_lock() then handle those original races and more.  Most
uses of pte_lockptr() are deprecated, with pte_offset_map_nolock()
taking its place.

Based on v6.4-rc2, but also good for -rc1, -rc3,
current mm-everything and linux-next.

01/31 mm: use pmdp_get_lockless() without surplus barrier()
02/31 mm/migrate: remove cruft from migration_entry_wait()s
03/31 mm/pgtable: kmap_local_page() instead of kmap_atomic()
04/31 mm/pgtable: allow pte_offset_map[_lock]() to fail
05/31 mm/filemap: allow pte_offset_map_lock() to fail
06/31 mm/page_vma_mapped: delete bogosity in page_vma_mapped_walk()
07/31 mm/page_vma_mapped: reformat map_pte() with less indentation
08/31 mm/page_vma_mapped: pte_offset_map_nolock() not pte_lockptr()
09/31 mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails
10/31 mm/pagewalk: walk_pte_range() allow for pte_offset_map()
11/31 mm/vmwgfx: simplify pmd & pud mapping dirty helpers
12/31 mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
13/31 mm/hmm: retry if pte_offset_map() fails
14/31 fs/userfaultfd: retry if pte_offset_map() fails
15/31 mm/userfaultfd: allow pte_offset_map_lock() to fail
16/31 mm/debug_vm_pgtable,page_table_check: warn pte map fails
17/31 mm/various: give up if pte_offset_map[_lock]() fails
18/31 mm/mprotect: delete pmd_none_or_clear_bad_unless_transhuge()
19/31 mm/mremap: retry if either pte_offset_map_*lock() fails
20/31 mm/madvise: clean up pte_offset_map_lock() scans
21/31 mm/madvise: clean up force_shm_swapin_readahead()
22/31 mm/swapoff: allow pte_offset_map[_lock]() to fail
23/31 mm/mglru: allow pte_offset_map_nolock() to fail
24/31 mm/migrate_device: allow pte_offset_map_lock() to fail
25/31 mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
26/31 mm/huge_memory: split huge pmd under one pte_offset_map()
27/31 mm/khugepaged: allow pte_offset_map[_lock]() to fail
28/31 mm/memory: allow pte_offset_map[_lock]() to fail
29/31 mm/memory: handle_pte_fault() use pte_offset_map_nolock()
30/31 mm/pgtable: delete pmd_trans_unstable() and friends
31/31 perf/core: Allow pte_offset_map() to fail

 Documentation/mm/split_page_table_lock.rst |  17 +-
 fs/proc/task_mmu.c                         |  32 ++--
 fs/userfaultfd.c                           |  21 +--
 include/linux/migrate.h                    |   4 +-
 include/linux/mm.h                         |  27 ++-
 include/linux/pgtable.h                    | 142 +++-----------
 include/linux/swapops.h                    |  17 +-
 kernel/events/core.c                       |   4 +
 mm/damon/vaddr.c                           |  12 +-
 mm/debug_vm_pgtable.c                      |   9 +-
 mm/filemap.c                               |  25 +--
 mm/gup.c                                   |  34 ++--
 mm/hmm.c                                   |   4 +-
 mm/huge_memory.c                           |  33 ++--
 mm/khugepaged.c                            |  83 +++++----
 mm/ksm.c                                   |  10 +-
 mm/madvise.c                               | 146 ++++++++-------
 mm/mapping_dirty_helpers.c                 |  34 +---
 mm/memcontrol.c                            |   8 +-
 mm/memory-failure.c                        |   8 +-
 mm/memory.c                                | 224 ++++++++++-------------
 mm/mempolicy.c                             |   7 +-
 mm/migrate.c                               |  40 ++--
 mm/migrate_device.c                        |  31 +---
 mm/mincore.c                               |   9 +-
 mm/mlock.c                                 |   4 +
 mm/mprotect.c                              |  79 ++------
 mm/mremap.c                                |  28 ++-
 mm/page_table_check.c                      |   2 +
 mm/page_vma_mapped.c                       |  97 +++++-----
 mm/pagewalk.c                              |  33 +++-
 mm/pgtable-generic.c                       |  56 ++++++
 mm/swap_state.c                            |   3 +
 mm/swapfile.c                              |  38 ++--
 mm/userfaultfd.c                           |  10 +-
 mm/vmalloc.c                               |   3 +-
 mm/vmscan.c                                |  16 +-
 37 files changed, 641 insertions(+), 709 deletions(-)

Hugh
