Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2661F71867B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjEaPfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjEaPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:35:42 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D8C135
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:35:35 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b7f217dd0so197395ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685547335; x=1688139335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRRkvCZYbSlg4t8xNmIDDwHUKuhLfHD0cIrw3700dVo=;
        b=F3utUZ5jdPTR1x7kwep/a3O/M1O2FfEohIVXcz/CBMY94I7ghYAdOfOwmEteY9N+pu
         ArxO1ao1FFcwWZ2Ro9xw80509s0jHrC5OKiBRqA3UuPlOFCiAadD2rF+t7Izm6hDF3yJ
         EPiTxETDha4DPtB9+aejroYDKEjiCItrVP55/xj7j8umM0YMbdCstRaCk5tY7JllwJ9X
         P8r6ZqbUG90uBJZcbeKX9hyczmmujIw/7PhyCwbKan8AQ0AN6K8lxHE4PE178uEet/cV
         XYvgARLy0SyrigU58Rs1QqIihvIgtm0J45cpH119527xv3T4RALnMC4bstaRMr/TCn5P
         UInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685547335; x=1688139335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRRkvCZYbSlg4t8xNmIDDwHUKuhLfHD0cIrw3700dVo=;
        b=jP97honziwr5ftbW2/kRkWNKelIvVnhKtq3Ui8mBQ2nwmDFIteDsYZKWSvCfgUU0/g
         B+vL8YSbs/2NzvaGhVnwTmLFHm/1vkoKa1ZuIbbUepm5INs+NBQagTrF/Qiaqc1QQ5ge
         iqcSrh07aTi9cnLY6a49o0Fa8DVK1uvDWJ/H0Z0VRE35bBHFlpcmF+RFs0MfwSKT5IFH
         nwHpkVN5cWjb2/OUXZcdWYhJuDIYypa7nifv8d/8wiv/pCsZydF0Z+0LUus2/1O/D7cD
         80r6lwoUKvn7X0/QQAY3nQ2nU667EVE7mJQi271b0OlGlPaHKIB6Te5zJN351E9N6Js2
         sxTg==
X-Gm-Message-State: AC+VfDzX1bWsVDuCzLw4xZKcVMGP7ZNX7u9+/4iBkCJYbjVs5SVDeDqd
        MuDrtjGDa66ZXs4BfM9Cgdhq2+sskzjOMZODA3fjSQ==
X-Google-Smtp-Source: ACHHUZ4mNqVesHou0LfeMRx7lS528vvvhkrqWTEzo+XSDqTFvF5QDhctZ96+3EobWyEv8r+F1qci8LfCFS6OSAYqXto=
X-Received: by 2002:a05:6e02:1a26:b0:33b:3bf4:9f42 with SMTP id
 g6-20020a056e021a2600b0033b3bf49f42mr126993ile.19.1685547334866; Wed, 31 May
 2023 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <35e983f5-7ed3-b310-d949-9ae8b130cdab@google.com> <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
In-Reply-To: <2e9996fa-d238-e7c-1194-834a2bd1f60@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 31 May 2023 17:34:58 +0200
Message-ID: <CAG48ez0aF1Rf1apSjn9YcnfyFQ4YqSd4GqB6f2wfhF7jMdi5Hg@mail.gmail.com>
Subject: Re: [PATCH 09/12] mm/khugepaged: retract_page_tables() without mmap
 or vma lock
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 8:25=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
> -static int retract_page_tables(struct address_space *mapping, pgoff_t pg=
off,
> -                              struct mm_struct *target_mm,
> -                              unsigned long target_addr, struct page *hp=
age,
> -                              struct collapse_control *cc)
> +static void retract_page_tables(struct address_space *mapping, pgoff_t p=
goff)
>  {
>         struct vm_area_struct *vma;
> -       int target_result =3D SCAN_FAIL;
>
> -       i_mmap_lock_write(mapping);
> +       i_mmap_lock_read(mapping);
>         vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> -               int result =3D SCAN_FAIL;
> -               struct mm_struct *mm =3D NULL;
> -               unsigned long addr =3D 0;
> -               pmd_t *pmd;
> -               bool is_target =3D false;
> +               struct mm_struct *mm;
> +               unsigned long addr;
> +               pmd_t *pmd, pgt_pmd;
> +               spinlock_t *pml;
> +               spinlock_t *ptl;
>
>                 /*
>                  * Check vma->anon_vma to exclude MAP_PRIVATE mappings th=
at
> -                * got written to. These VMAs are likely not worth invest=
ing
> -                * mmap_write_lock(mm) as PMD-mapping is likely to be spl=
it
> -                * later.
> +                * got written to. These VMAs are likely not worth removi=
ng
> +                * page tables from, as PMD-mapping is likely to be split=
 later.
>                  *
> -                * Note that vma->anon_vma check is racy: it can be set u=
p after
> -                * the check but before we took mmap_lock by the fault pa=
th.
> -                * But page lock would prevent establishing any new ptes =
of the
> -                * page, so we are safe.
> -                *
> -                * An alternative would be drop the check, but check that=
 page
> -                * table is clear before calling pmdp_collapse_flush() un=
der
> -                * ptl. It has higher chance to recover THP for the VMA, =
but
> -                * has higher cost too. It would also probably require lo=
cking
> -                * the anon_vma.
> +                * Note that vma->anon_vma check is racy: it can be set a=
fter
> +                * the check, but page locks (with XA_RETRY_ENTRYs in hol=
es)
> +                * prevented establishing new ptes of the page. So we are=
 safe
> +                * to remove page table below, without even checking it's=
 empty.

This "we are safe to remove page table below, without even checking
it's empty" assumes that the only way to create new anonymous PTEs is
to use existing file PTEs, right? What about private shmem VMAs that
are registered with userfaultfd as VM_UFFD_MISSING? I think for those,
the UFFDIO_COPY ioctl lets you directly insert anonymous PTEs without
looking at the mapping and its pages (except for checking that the
insertion point is before end-of-file), protected only by mmap_lock
(shared) and pte_offset_map_lock().


>                  */
> -               if (READ_ONCE(vma->anon_vma)) {
> -                       result =3D SCAN_PAGE_ANON;
> -                       goto next;
> -               }
> +               if (READ_ONCE(vma->anon_vma))
> +                       continue;
> +
>                 addr =3D vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE=
_SHIFT);
>                 if (addr & ~HPAGE_PMD_MASK ||
> -                   vma->vm_end < addr + HPAGE_PMD_SIZE) {
> -                       result =3D SCAN_VMA_CHECK;
> -                       goto next;
> -               }
> -               mm =3D vma->vm_mm;
> -               is_target =3D mm =3D=3D target_mm && addr =3D=3D target_a=
ddr;
> -               result =3D find_pmd_or_thp_or_none(mm, addr, &pmd);
> -               if (result !=3D SCAN_SUCCEED)
> -                       goto next;
> -               /*
> -                * We need exclusive mmap_lock to retract page table.
> -                *
> -                * We use trylock due to lock inversion: we need to acqui=
re
> -                * mmap_lock while holding page lock. Fault path does it =
in
> -                * reverse order. Trylock is a way to avoid deadlock.
> -                *
> -                * Also, it's not MADV_COLLAPSE's job to collapse other
> -                * mappings - let khugepaged take care of them later.
> -                */
> -               result =3D SCAN_PTE_MAPPED_HUGEPAGE;
> -               if ((cc->is_khugepaged || is_target) &&
> -                   mmap_write_trylock(mm)) {
> -                       /* trylock for the same lock inversion as above *=
/
> -                       if (!vma_try_start_write(vma))
> -                               goto unlock_next;
> -
> -                       /*
> -                        * Re-check whether we have an ->anon_vma, becaus=
e
> -                        * collapse_and_free_pmd() requires that either n=
o
> -                        * ->anon_vma exists or the anon_vma is locked.
> -                        * We already checked ->anon_vma above, but that =
check
> -                        * is racy because ->anon_vma can be populated un=
der the
> -                        * mmap lock in read mode.
> -                        */
> -                       if (vma->anon_vma) {
> -                               result =3D SCAN_PAGE_ANON;
> -                               goto unlock_next;
> -                       }
> -                       /*
> -                        * When a vma is registered with uffd-wp, we can'=
t
> -                        * recycle the pmd pgtable because there can be p=
te
> -                        * markers installed.  Skip it only, so the rest =
mm/vma
> -                        * can still have the same file mapped hugely, ho=
wever
> -                        * it'll always mapped in small page size for uff=
d-wp
> -                        * registered ranges.
> -                        */
> -                       if (hpage_collapse_test_exit(mm)) {
> -                               result =3D SCAN_ANY_PROCESS;
> -                               goto unlock_next;
> -                       }
> -                       if (userfaultfd_wp(vma)) {
> -                               result =3D SCAN_PTE_UFFD_WP;
> -                               goto unlock_next;
> -                       }
> -                       collapse_and_free_pmd(mm, vma, addr, pmd);

The old code called collapse_and_free_pmd(), which involves MMU
notifier invocation...

> -                       if (!cc->is_khugepaged && is_target)
> -                               result =3D set_huge_pmd(vma, addr, pmd, h=
page);
> -                       else
> -                               result =3D SCAN_SUCCEED;
> -
> -unlock_next:
> -                       mmap_write_unlock(mm);
> -                       goto next;
> -               }
> -               /*
> -                * Calling context will handle target mm/addr. Otherwise,=
 let
> -                * khugepaged try again later.
> -                */
> -               if (!is_target) {
> -                       khugepaged_add_pte_mapped_thp(mm, addr);
> +                   vma->vm_end < addr + HPAGE_PMD_SIZE)
>                         continue;
> -               }
> -next:
> -               if (is_target)
> -                       target_result =3D result;
> +
> +               mm =3D vma->vm_mm;
> +               if (find_pmd_or_thp_or_none(mm, addr, &pmd) !=3D SCAN_SUC=
CEED)
> +                       continue;
> +
> +               if (hpage_collapse_test_exit(mm))
> +                       continue;
> +               /*
> +                * When a vma is registered with uffd-wp, we cannot recyc=
le
> +                * the page table because there may be pte markers instal=
led.
> +                * Other vmas can still have the same file mapped hugely,=
 but
> +                * skip this one: it will always be mapped in small page =
size
> +                * for uffd-wp registered ranges.
> +                *
> +                * What if VM_UFFD_WP is set a moment after this check?  =
No
> +                * problem, huge page lock is still held, stopping new ma=
ppings
> +                * of page which might then get replaced by pte markers: =
only
> +                * existing markers need to be protected here.  (We could=
 check
> +                * after getting ptl below, but this comment distracting =
there!)
> +                */
> +               if (userfaultfd_wp(vma))
> +                       continue;
> +
> +               /* Huge page lock is still held, so page table must be em=
pty */
> +               pml =3D pmd_lock(mm, pmd);
> +               ptl =3D pte_lockptr(mm, pmd);
> +               if (ptl !=3D pml)
> +                       spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
> +               pgt_pmd =3D pmdp_collapse_flush(vma, addr, pmd);

... while the new code only does pmdp_collapse_flush(), which clears
the pmd entry and does a TLB flush, but AFAICS doesn't use MMU
notifiers. My understanding is that that's problematic - maybe (?) it
is sort of okay with regards to classic MMU notifier users like KVM,
but it's probably wrong for IOMMUv2 users, where an IOMMU directly
consumes the normal page tables?

(FWIW, last I looked, there also seemed to be some other issues with
MMU notifier usage wrt IOMMUv2, see the thread
<https://lore.kernel.org/linux-mm/Yzbaf9HW1%2FreKqR8@nvidia.com/>.)


> +               if (ptl !=3D pml)
> +                       spin_unlock(ptl);
> +               spin_unlock(pml);
> +
> +               mm_dec_nr_ptes(mm);
> +               page_table_check_pte_clear_range(mm, addr, pgt_pmd);
> +               pte_free_defer(mm, pmd_pgtable(pgt_pmd));
>         }
> -       i_mmap_unlock_write(mapping);
> -       return target_result;
> +       i_mmap_unlock_read(mapping);
>  }
>
>  /**
> @@ -2261,9 +2210,11 @@ static int collapse_file(struct mm_struct *mm, uns=
igned long addr,
>
>         /*
>          * Remove pte page tables, so we can re-fault the page as huge.
> +        * If MADV_COLLAPSE, adjust result to call collapse_pte_mapped_th=
p().
>          */
> -       result =3D retract_page_tables(mapping, start, mm, addr, hpage,
> -                                    cc);
> +       retract_page_tables(mapping, start);
> +       if (cc && !cc->is_khugepaged)
> +               result =3D SCAN_PTE_MAPPED_HUGEPAGE;
>         unlock_page(hpage);
>
>         /*
> --
> 2.35.3
>
