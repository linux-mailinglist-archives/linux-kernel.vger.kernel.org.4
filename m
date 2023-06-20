Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0487364DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjFTHiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjFTHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:37:50 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A961BF4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:36:47 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc492cb6475so3395276276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687246562; x=1689838562;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FpzqtsmXqE0VXfZTMUeJ78FSNoWcFIczYc6Ond/JfIk=;
        b=frIiNGSckxr3Ip2k31541GefYKavTMPsaGf7AN2ZQ/qeqt+B/jHeTqmNeuJin3omia
         nAE3yn/kfNy+6HOeAKgwKpHwASyLd9XuAgSOH7v9/C3CHYEt5CaPSEM+VVdRLz3Arj1O
         1MV9V/LQChOpWEI9pP0J0cw6jVVJL6Iu1QXbQ5ZfWl+32nsry7xWO3ybjTOFio3TkuYH
         GzINNRBUDJLfUTRZRl3zjXzV0fSEkZPaRdSVf9qkTwvAjySvDqnkKL/sr4BzQbYzqPUQ
         CyxCsy3C6a1tT4ChuzzxCy2ROctpNA35uBsJQXn7V0x/w2T1aFcY8JBVo5TvOp5j6A8C
         /jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687246562; x=1689838562;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FpzqtsmXqE0VXfZTMUeJ78FSNoWcFIczYc6Ond/JfIk=;
        b=Uv5xhT8FJd4xn0AfmM4id3NQbODXndJ47ZaoP7xeTJN7tsoKOHGTFkJz6W55fWtcqQ
         Tyb/H49EeS4bstyEgYtFJNjkU+PoBPXFbLiQjTc26FkTH6tb+ejD8hKp498flkgkCVUE
         3We7Bxvp7JcVA68hreK+6jc0CaNY4IKRWhhbQUkH+v/PAquOW0sW4zcgpXZjSc8D6wsj
         AEznDD7f5w+qF1st8atddKK6Eldqy/XUGwSgDw3g6/3vjOPe6jo97yJHtwiIrHzUoMek
         7eLsjMTULrQMToLBkYexIs4Z4Ciqfxl8dZoY2s099J/G5KePhAR7nz8n2cD/S2+SiiE4
         wIIg==
X-Gm-Message-State: AC+VfDyvFg1TIwX+xqNQomjBEqLZ+SjTsuRh9l6nHwWqsEQJd+VNWebM
        jeXcecdpRdwXoQtqTCNI4qJvaA==
X-Google-Smtp-Source: ACHHUZ7bq5s3dhMW3ZH11OR6RQmE3NYzsjKhQytjIcSskZHm6yt+ISQcBlLo4KPgUjAhZKGeadJUsA==
X-Received: by 2002:a5b:c4a:0:b0:bcb:65d1:a01 with SMTP id d10-20020a5b0c4a000000b00bcb65d10a01mr6119105ybr.12.1687246561605;
        Tue, 20 Jun 2023 00:36:01 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f124-20020a255182000000b00b9dfcc7a1fasm258265ybb.7.2023.06.20.00.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:36:01 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:35:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Shaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
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
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/12] mm: free retracted page table by RCU
Message-ID: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
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

Here is v2 third series of patches to mm (and a few architectures), based
on v6.4-rc5 with the preceding two series applied: in which khugepaged
takes advantage of pte_offset_map[_lock]() allowing for pmd transitions.
Differences from v1 are noted patch by patch below

This follows on from the v2 "arch: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/a4963be9-7aa6-350-66d0-2ba843e1af44@google.com/
series of 23 posted on 2023-06-08 (and now in mm-stable - thank you),
and the v2 "mm: allow pte_offset_map[_lock]() to fail"
https://lore.kernel.org/linux-mm/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com/
series of 32 posted on 2023-06-08 (and now in mm-stable - thank you),
and replaces the v1 "mm: free retracted page table by RCU"
https://lore.kernel.org/linux-mm/35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com/
series of 12 posted on 2023-05-28 (which was bad on powerpc and s390).

The first two series were "independent": neither depending for build or
correctness on the other, but both series had to be in before this third
series is added to make the effective changes; and it would probably be
best to hold this series back until the following release, since it might
now reveal missed imbalances which the first series hoped to fix.

What is it all about?  Some mmap_lock avoidance i.e. latency reduction.
Initially just for the case of collapsing shmem or file pages to THPs:
the usefulness of MADV_COLLAPSE on shmem is being limited by that
mmap_write_lock it currently requires.

Likely to be relied upon later in other contexts e.g. freeing of
empty page tables (but that's not work I'm doing).  mmap_write_lock
avoidance when collapsing to anon THPs?  Perhaps, but again that's not
work I've done: a quick attempt was not as easy as the shmem/file case.

These changes (though of course not these exact patches) have been in
Google's data centre kernel for three years now: we do rely upon them.

Based on the preceding two series over v6.4-rc5, or any v6.4-rc; and
almost good on current mm-everything or current linux-next - just one
patch conflicts, the 10/12: I'll reply to that one with its
mm-everything or linux-next equivalent (ptent replacing *pte).

01/12 mm/pgtable: add rcu_read_lock() and rcu_read_unlock()s
      v2: same as v1
02/12 mm/pgtable: add PAE safety to __pte_offset_map()
      v2: rename to pmdp_get_lockless_start/end() per Matthew;
          so use inlines without _irq_save(flags) macro oddity;
          add pmdp_get_lockless_sync() for use later in 09/12.
03/12 arm: adjust_pte() use pte_offset_map_nolock()
      v2: same as v1
04/12 powerpc: assert_pte_locked() use pte_offset_map_nolock()
      v2: same as v1
05/12 powerpc: add pte_free_defer() for pgtables sharing page
      v2: fix rcu_head usage to cope with concurrent deferrals;
          add para to commit message explaining rcu_head issue.
06/12 sparc: add pte_free_defer() for pte_t *pgtable_t
      v2: use page_address() instead of less common page_to_virt();
          add para to commit message explaining simple conversion;
          changed title since sparc64 pgtables do not share page.
07/12 s390: add pte_free_defer() for pgtables sharing page
      v2: complete rewrite, integrated with s390's existing pgtable
          management; temporarily using a global mm_pgtable_list_lock,
          to be restored to per-mm spinlock in a later followup patch.
08/12 mm/pgtable: add pte_free_defer() for pgtable as page
      v2: add comment on rcu_head to "Page table pages", per JannH
09/12 mm/khugepaged: retract_page_tables() without mmap or vma lock
      v2: repeat checks under ptl because UFFD, per PeterX and JannH;
          bring back mmu_notifier calls for PMD, per JannH and Jason;
          pmdp_get_lockless_sync() to issue missing interrupt if PAE.
10/12 mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
      v2: first check VMA, in case page tables torn down, per JannH;
          pmdp_get_lockless_sync() to issue missing interrupt if PAE;
          moved mmu_notifier after step 1, reworked final goto labels.
11/12 mm/khugepaged: delete khugepaged_collapse_pte_mapped_thps()
      v2: same as v1
12/12 mm: delete mmap_write_trylock() and vma_try_start_write()
      v2: same as v1

 arch/arm/mm/fault-armv.c            |   3 +-
 arch/powerpc/include/asm/pgalloc.h  |   4 +
 arch/powerpc/mm/pgtable-frag.c      |  51 ++++
 arch/powerpc/mm/pgtable.c           |  16 +-
 arch/s390/include/asm/pgalloc.h     |   4 +
 arch/s390/mm/pgalloc.c              | 205 +++++++++----
 arch/sparc/include/asm/pgalloc_64.h |   4 +
 arch/sparc/mm/init_64.c             |  16 +
 include/linux/mm.h                  |  17 --
 include/linux/mm_types.h            |   6 +-
 include/linux/mmap_lock.h           |  10 -
 include/linux/pgtable.h             |  10 +-
 mm/khugepaged.c                     | 481 +++++++++++-------------------
 mm/pgtable-generic.c                |  53 +++-
 14 files changed, 467 insertions(+), 413 deletions(-)

Hugh
