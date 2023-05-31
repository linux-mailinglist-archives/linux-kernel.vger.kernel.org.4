Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B7C71886B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjEaRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjEaRZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:25:40 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA9611D
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:25:38 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so7375ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685553938; x=1688145938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9rDw2v1LEmye3RLuD/RrrSGCh1UZ3V6JVzZJFvjbWQ=;
        b=CM0AuU72AcPSh131wQ9crT8iFbojgiYaMR0ZSQFK8kjs45mw5usLlAIhaun5lyvIUt
         wExvZsnF+Y/c9O0ViQtZ375xekAQOkC2l0fk18AOQisyVPMzkPiJ8zi/btsm+NPYxju7
         MI1ropBml9khGIMtFqvQZ5ZFA3RSM2ZviNcgn5VbSlXa3ytpJTdH7HofVwJ9/2Qen4WS
         051PVAgJXvJkegFFklqRVDPy83wUzSBjxxDFu56mRAEtSP4gKFxiSBA/OEyqTU1LUHUg
         0l6Uv5BmErx3H0lthWvCFUBb1ELtXAQOYfj1Gs6CU2Pgsoh6ZNLfoKpQiBo5nt9UKPZF
         HrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553938; x=1688145938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9rDw2v1LEmye3RLuD/RrrSGCh1UZ3V6JVzZJFvjbWQ=;
        b=DsHynUuEMdOZ95n5UF8y03X2QgUK901sICVpxVvWnjoUZZaWrhgRCmwNc8zsEhmQqy
         iBH6len5bwq5aeAKX66DKWWLmI+vGZoz3W8WW6rvztLpBxKTPUaej3z/z+NG11u7Foiu
         c1gH2JOsIqu1RirO6wSi7gjP6Y9zctgnt5646t7IZp2TLsGmdzU3K60tOdvAfW712+19
         4vuv+KkIeV7pOfTdZqG1Z1M3z+pmos8+IJ1EOxwEADobTkq3pxA9IVxtWAG/BCjAY3+H
         WtoBUGUYNtKRSVKhH7JOTb3/tzipARmqQDR1bMUrrVOPf0+DB047lDOJIrSLiBeOUYqX
         5t6A==
X-Gm-Message-State: AC+VfDxDE9oT7OuyyFqayW/w0ej0TbZSOgMWS+U9dENgc1Z0FyAgzPP5
        2uOnmCjBNHyZxbKYCaFBa3HYtcwf1gb5sXJjd9JYxQ==
X-Google-Smtp-Source: ACHHUZ6Afl+xZKFHZomNksLJA//ac6T4P12fNCTRCN7NynywZdGagjN9pdDeftj4IADrAcP1/u34lNvJe8J80I1ISvg=
X-Received: by 2002:a05:6e02:1a44:b0:33a:e716:a76e with SMTP id
 u4-20020a056e021a4400b0033ae716a76emr187444ilv.28.1685553937544; Wed, 31 May
 2023 10:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <563340a4-7ac9-7cc8-33d8-f7cc6ef19ea6@google.com>
In-Reply-To: <563340a4-7ac9-7cc8-33d8-f7cc6ef19ea6@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 May 2023 19:25:01 +0200
Message-ID: <CAG48ez2X5oZyxaFniZ-HeGHDGjNuPBewGTjZLEHPWkBbBCaigg@mail.gmail.com>
Subject: Re: [PATCH 10/12] mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 29, 2023 at 8:26=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> Bring collapse_and_free_pmd() back into collapse_pte_mapped_thp().
> It does need mmap_read_lock(), but it does not need mmap_write_lock(),
> nor vma_start_write() nor i_mmap lock nor anon_vma lock.  All racing
> paths are relying on pte_offset_map_lock() and pmd_lock(), so use those.

I think there's a weirdness in the existing code, and this change
probably turns that into a UAF bug.

collapse_pte_mapped_thp() can be called on an address that might not
be associated with a VMA anymore, and after this change, the page
tables for that address might be in the middle of page table teardown
in munmap(), right? The existing mmap_write_lock() guards against
concurrent munmap() (so in the old code we are guaranteed to either
see a normal VMA or not see the page tables anymore), but
mmap_read_lock() only guards against the part of munmap() up to the
mmap_write_downgrade() in do_vmi_align_munmap(), and unmap_region()
(including free_pgtables()) happens after that.

So we can now enter collapse_pte_mapped_thp() and race with concurrent
free_pgtables() such that a PUD disappears under us while we're
walking it or something like that:


int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
          bool install_pmd)
{
  struct mmu_notifier_range range;
  unsigned long haddr =3D addr & HPAGE_PMD_MASK;
  struct vm_area_struct *vma =3D vma_lookup(mm, haddr); // <<< returns NULL
  struct page *hpage;
  pte_t *start_pte, *pte;
  pmd_t *pmd, pgt_pmd;
  spinlock_t *pml, *ptl;
  int nr_ptes =3D 0, result =3D SCAN_FAIL;
  int i;

  mmap_assert_locked(mm);

  /* Fast check before locking page if already PMD-mapped */
  result =3D find_pmd_or_thp_or_none(mm, haddr, &pmd); // <<< PUD UAF in he=
re
  if (result =3D=3D SCAN_PMD_MAPPED)
    return result;

  if (!vma || !vma->vm_file || // <<< bailout happens too late
      !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
    return SCAN_VMA_CHECK;


I guess the right fix here is to make sure that at least the basic VMA
revalidation stuff (making sure there still is a VMA covering this
range) happens before find_pmd_or_thp_or_none()? Like:


diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 301c0e54a2ef..5db365587556 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1481,15 +1481,15 @@ int collapse_pte_mapped_thp(struct mm_struct
*mm, unsigned long addr,

         mmap_assert_locked(mm);

+        if (!vma || !vma->vm_file ||
+            !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
+                return SCAN_VMA_CHECK;
+
         /* Fast check before locking page if already PMD-mapped */
         result =3D find_pmd_or_thp_or_none(mm, haddr, &pmd);
         if (result =3D=3D SCAN_PMD_MAPPED)
                 return result;

-        if (!vma || !vma->vm_file ||
-            !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
-                return SCAN_VMA_CHECK;
-
         /*
          * If we are here, we've succeeded in replacing all the native pag=
es
          * in the page cache with a single hugepage. If a mm were to fault=
-in
