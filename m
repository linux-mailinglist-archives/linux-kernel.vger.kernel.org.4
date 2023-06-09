Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39D728CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 02:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFIAyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjFIAyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 20:54:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9B41FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 17:54:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565e8d575cbso11502417b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 17:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686272085; x=1688864085;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AvnCOrwuaY2rmzNJkT8k0FR/HXMryivthKZ2+5Yd/oA=;
        b=ehhMhbujReyzXprCwJGokxPELOOtWqHbLZy6jzANpwrTDi9u2WU8c8eT1ezl9ksmIy
         FfqczreRsJfirhVnyj9XiviHqrZ/DnneNsKKnwHoxIdjlkxon5ucnm2trLEavavwmXBN
         eLvrXpYLZ7BdI9gurHhGeBbqhBziZ4dBH8PyxePC+KgF1GIqa1xdhaIBfVfHRFhEMY6z
         N/PuSDKPB2MzctPZ4CMe9pffGdCxBhoJLAfQhqk/NnVXfSy1IW+r5TGwbg/hNkd+oDwj
         DxG1pNC+HTNeMUFHjIjQp9ZHvK6689a6SMM5TX14jtR+2GgPRQMBY5Q6s43wZ7UE30xl
         dNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686272085; x=1688864085;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AvnCOrwuaY2rmzNJkT8k0FR/HXMryivthKZ2+5Yd/oA=;
        b=Kvqs+Na1MX1162rUIqv79No/S0Bag8NWPYCTOs5pv+/g5ts8InxFlBrV2ummLP5oEu
         rbwXezI0gbFwZvBSUbO9jEgcXclSuEmkiLmlJ/p3Vdlogw6J3xTpUeHFBTo+Iw3LxuyR
         7cRjUDp0bu4APAXNTL1bQ7uD45x0GcH/o38aoHnsGzYuyajYJuNg3ragJMrsS+iLr4ye
         w865R5khhN1rY9/z2qTrQeLEmoyYG/dCBu1PZotShtB2jgmQTW0B+q/qmTzwht6QMCsW
         QFYnJOR0OG17pQ65ATJtuMk+tqk1PwFn+HmlL/DE9ChE23NiQnrECMZDUXZ0wyttDOMN
         Q/Nw==
X-Gm-Message-State: AC+VfDz/Df0SmwWEvrpBOJeZ2MdLg12pKkAULsFjyc/ivdUOohM68r6o
        r6vkkwqJW2wc010EJnATLaf40g==
X-Google-Smtp-Source: ACHHUZ5MPJ5k4pHNxx8mhyLhl95Gkyg3v8w0SxrGvKoC1NK5X/Y4iC1FPMnyKBLJ8H3lRDppJkpN+A==
X-Received: by 2002:a81:5441:0:b0:565:f045:18c4 with SMTP id i62-20020a815441000000b00565f04518c4mr1554222ywb.4.1686272085320;
        Thu, 08 Jun 2023 17:54:45 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d63-20020a816842000000b0055a7ff0a5cdsm280518ywc.27.2023.06.08.17.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 17:54:44 -0700 (PDT)
Date:   Thu, 8 Jun 2023 17:54:33 -0700 (PDT)
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
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/32] mm: allow pte_offset_map[_lock]() to fail
Message-ID: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
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

Here is v2 series of patches to mm, based on v6.4-rc5: preparing for
v2 effective changes to follow, probably next week (when I hope s390
will be sorted), affecting pte_offset_map() and pte_offset_map_lock().
There are very few differences from v1: noted patch by patch below.

This follows on from the v2 "arch: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/a4963be9-7aa6-350-66d0-2ba843e1af44@google.com/
series of 23 posted on 2023-06-08,
replaces the v1 "mm: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com/
series of 31 posted on 2023-05-21,
which was followed by the v1 "mm: free retracted page table by RCU"
https://lore.kernel.org/linux-mm/35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com/
series of 12 posted on 2023-05-28.

The first two series are "independent":
neither depends for build or correctness on the other, but both series
must in before the third series is added to make the effective changes
(and it may be preferred to hold that one until the following release).

What is it all about?  Some mmap_lock avoidance i.e. latency reduction.
Initially just for the case of collapsing shmem or file pages to THPs;
but likely to be relied upon later in other contexts e.g. freeing of
empty page tables (but that's not work I'm doing).  mmap_write_lock
avoidance when collapsing to anon THPs?  Perhaps, but again that's not
work I've done: a quick attempt was not as easy as the shmem/file case.

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

This posting is based on v6.4-rc5, but good for any v6.4-rc; and good
for current mm-everything and linux-next, except for one minor clash in
mm/memory.c do_swap_page(), where Ryan Roberts and I fixed the same goto.

01/32 mm: use pmdp_get_lockless() without surplus barrier()
      v2: add acks from Yu Zhao and PeterX
02/32 mm/migrate: remove cruft from migration_entry_wait()s
      v2: add review from Alistair
03/32 mm/pgtable: kmap_local_page() instead of kmap_atomic()
      v2: same as v1
04/32 mm/pgtable: allow pte_offset_map[_lock]() to fail
      v2: same as v1
05/32 mm/filemap: allow pte_offset_map_lock() to fail
      v2: same as v1
06/32 mm/page_vma_mapped: delete bogosity in page_vma_mapped_walk()
      v2: same as v1
07/32 mm/page_vma_mapped: reformat map_pte() with less indentation
      v2: same as v1
08/32 mm/page_vma_mapped: pte_offset_map_nolock() not pte_lockptr()
      v2: same as v1
09/32 mm/pagewalkers: ACTION_AGAIN if pte_offset_map_lock() fails
      v2: add review from SeongJae for mm/damon part
10/32 mm/pagewalk: walk_pte_range() allow for pte_offset_map()
      v2: same as v1
11/32 mm/vmwgfx: simplify pmd & pud mapping dirty helpers
      v2: same as v1
12/32 mm/vmalloc: vmalloc_to_page() use pte_offset_kernel()
      v2: add review from Lorenzo
13/32 mm/hmm: retry if pte_offset_map() fails
      v2: add review from Alistair
14/32 fs/userfaultfd: retry if pte_offset_map() fails
      v2: add ack from PeterX
15/32 mm/userfaultfd: allow pte_offset_map_lock() to fail
      v2: use -EAGAIN instead of -EFAULT from PeterX
16/32 mm/debug_vm_pgtable,page_table_check: warn pte map fails
      v2: same as v1
17/32 mm/various: give up if pte_offset_map[_lock]() fails
      v2: removed mm/swap_state.c mod to a separate patch 31/32
18/32 mm/mprotect: delete pmd_none_or_clear_bad_unless_transhuge()
      v2: same as v1
19/32 mm/mremap: retry if either pte_offset_map_*lock() fails
      v2: same as v1
20/32 mm/madvise: clean up pte_offset_map_lock() scans
      v2: same as v1
21/32 mm/madvise: clean up force_shm_swapin_readahead()
      v2: same as v1
22/32 mm/swapoff: allow pte_offset_map[_lock]() to fail
      v2: same as v1
23/32 mm/mglru: allow pte_offset_map_nolock() to fail
      v2: add ack from Yu Zhao
24/32 mm/migrate_device: allow pte_offset_map_lock() to fail
      v2: add review from Alistair
25/32 mm/gup: remove FOLL_SPLIT_PMD use of pmd_trans_unstable()
      v2: add comment on -EBUSY from Yang Shi
26/32 mm/huge_memory: split huge pmd under one pte_offset_map()
      v2: add review from Yang Shi
27/32 mm/khugepaged: allow pte_offset_map[_lock]() to fail
      v2: add review from Yang Shi
28/32 mm/memory: allow pte_offset_map[_lock]() to fail
      v2: same as v1
29/32 mm/memory: handle_pte_fault() use pte_offset_map_nolock()
      v2: same as v1
30/32 mm/pgtable: delete pmd_trans_unstable() and friends
      v2: same as v1
31/32 mm/swap: swap_vma_readahead() do the pte_offset_map()
      v2: new patch replacing last part of v1 17/31
32/32 perf/core: Allow pte_offset_map() to fail
      v2: same as v1 31/31

 Documentation/mm/split_page_table_lock.rst |  17 ++-
 fs/proc/task_mmu.c                         |  32 ++---
 fs/userfaultfd.c                           |  21 +--
 include/linux/migrate.h                    |   4 +-
 include/linux/mm.h                         |  27 ++--
 include/linux/pgtable.h                    | 142 +++---------------
 include/linux/swap.h                       |  19 ---
 include/linux/swapops.h                    |  17 +--
 kernel/events/core.c                       |   4 +
 mm/damon/vaddr.c                           |  12 +-
 mm/debug_vm_pgtable.c                      |   9 +-
 mm/filemap.c                               |  25 ++--
 mm/gup.c                                   |  34 ++---
 mm/hmm.c                                   |   4 +-
 mm/huge_memory.c                           |  33 +++--
 mm/khugepaged.c                            |  83 ++++++-----
 mm/ksm.c                                   |  10 +-
 mm/madvise.c                               | 146 ++++++++++---------
 mm/mapping_dirty_helpers.c                 |  34 ++---
 mm/memcontrol.c                            |   8 +-
 mm/memory-failure.c                        |   8 +-
 mm/memory.c                                | 224 +++++++++++++----------------
 mm/mempolicy.c                             |   7 +-
 mm/migrate.c                               |  40 +++---
 mm/migrate_device.c                        |  31 +---
 mm/mincore.c                               |   9 +-
 mm/mlock.c                                 |   4 +
 mm/mprotect.c                              |  79 +++-------
 mm/mremap.c                                |  28 ++--
 mm/page_table_check.c                      |   2 +
 mm/page_vma_mapped.c                       |  97 +++++++------
 mm/pagewalk.c                              |  33 +++--
 mm/pgtable-generic.c                       |  56 ++++++++
 mm/swap_state.c                            |  45 +++---
 mm/swapfile.c                              |  38 ++---
 mm/userfaultfd.c                           |   8 ++
 mm/vmalloc.c                               |   3 +-
 mm/vmscan.c                                |  16 +--
 38 files changed, 662 insertions(+), 747 deletions(-)

Hugh
