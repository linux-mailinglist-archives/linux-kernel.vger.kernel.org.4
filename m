Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3855570CF66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbjEWAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 20:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjEWARu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 20:17:50 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814AD1987
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:35:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25332422531so3074457a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684798549; x=1687390549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLmCuy21+rPe8wgn0OHZOYds1k+J9dWSGBzctzYhcE8=;
        b=fI5qJBcIvptknKxPI4Cv5bhukMTzxZ5aQAX2MqkNIZz6Ru9j6nE9Pyvlp24mE2ESe/
         ZqHBMZRDNknvNtNdh9novi9SzVZiAuvx6JjDqwOIe+DVWQqmJubCoNA+lv56GgjVijH1
         MDRZ1MpFuupCh7XK9IlZii1TzWNHbdRCgUopsygbqcmQvC7RLtAMCgSYiXqL+fIaYQJm
         CCDizhRp94Om1/zNF8pgdxG/EzoJzrGAX9j9K7MvaBgbgIjXL4K42Lp/UD2eiybKo+KK
         fgwGkpMtvUOQpOoqCav6oPmSPrplUIt0kN9w/8TYLyiIgI/6+eCbdPUj40kpB4TKEgx2
         3OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684798549; x=1687390549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mLmCuy21+rPe8wgn0OHZOYds1k+J9dWSGBzctzYhcE8=;
        b=in6qhSPB79A518flNWfkUfnFeSFZOd6dyWRaq6fjLAhH8PrUYmGDrfsyfnUuuZs3cy
         x58fCs6Ro5QpHycMbYormnicqICpsZsobrDyHhf2WJ+bFbyMQpXF985cpLFuwZQp3rkc
         XidBUXwYsdK48h7zf2qiUukswZ82NwK4j1/Oo3lmk8Do+BYVnSgkiiEQPXB3gigF1aYR
         T5cw4BtHLi+A+hTWQUXBwpaW3fn7liuYOt5R4hHhKyzsUUIwqkjdkKmheqaTW7LWL71z
         5MW+ZSPi7C8UYgGvGyQ1iJVu8xMl3/2n06ktjmzwXvxUInTpD0B9U3j4qtMzjoiKravW
         l/KQ==
X-Gm-Message-State: AC+VfDwR/9lP4fAHaTsJbduSEY7yc/bZBIgjLBCoQlMPSzVL+GiQrl+b
        G3B5Jq/EL9bEvmiIBFH//Pg1ZTENhfiHPwHcMjc=
X-Google-Smtp-Source: ACHHUZ55j6Ipp0XXkA7Zs+JztD8+N+YYfcUbdHbU0Cr1sBy7SfiDFrQodWiXZqkiIF1hMY2qu9vwoFg6sq5hdPkJpwA=
X-Received: by 2002:a17:90b:160e:b0:253:4f8f:52fb with SMTP id
 la14-20020a17090b160e00b002534f8f52fbmr18320957pjb.10.1684798548695; Mon, 22
 May 2023 16:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <68a97fbe-5c1e-7ac6-72c-7b9c6290b370@google.com> <3f442a9c-af6d-573d-1ad1-f6f413b1abc9@google.com>
In-Reply-To: <3f442a9c-af6d-573d-1ad1-f6f413b1abc9@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 22 May 2023 16:35:36 -0700
Message-ID: <CAHbLzkosPTuxnkLRwukyUVNryj-Ci6_dbkM8MFFzn4q9bRmy2w@mail.gmail.com>
Subject: Re: [PATCH 26/31] mm/huge_memory: split huge pmd under one pte_offset_map()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 10:23=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> __split_huge_zero_page_pmd() use a single pte_offset_map() to sweep the
> extent: it's already under pmd_lock(), so this is no worse for latency;
> and since it's supposed to have full control of the just-withdrawn page
> table, here choose to VM_BUG_ON if it were to fail.  And please don't
> increment haddr by PAGE_SIZE, that should remain huge aligned: declare
> a separate addr (not a bugfix, but it was deceptive).
>
> __split_huge_pmd_locked() likewise (but it had declared a separate addr);
> and change its BUG_ON(!pte_none) to VM_BUG_ON, for consistency with zero
> (those deposited page tables are sometimes victims of random corruption).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d4bd5fa7c823..839c13fa0bbe 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2037,6 +2037,8 @@ static void __split_huge_zero_page_pmd(struct vm_ar=
ea_struct *vma,
>         struct mm_struct *mm =3D vma->vm_mm;
>         pgtable_t pgtable;
>         pmd_t _pmd, old_pmd;
> +       unsigned long addr;
> +       pte_t *pte;
>         int i;
>
>         /*
> @@ -2052,17 +2054,20 @@ static void __split_huge_zero_page_pmd(struct vm_=
area_struct *vma,
>         pgtable =3D pgtable_trans_huge_withdraw(mm, pmd);
>         pmd_populate(mm, &_pmd, pgtable);
>
> -       for (i =3D 0; i < HPAGE_PMD_NR; i++, haddr +=3D PAGE_SIZE) {
> -               pte_t *pte, entry;
> -               entry =3D pfn_pte(my_zero_pfn(haddr), vma->vm_page_prot);
> +       pte =3D pte_offset_map(&_pmd, haddr);
> +       VM_BUG_ON(!pte);
> +       for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PA=
GE_SIZE) {
> +               pte_t entry;
> +
> +               entry =3D pfn_pte(my_zero_pfn(addr), vma->vm_page_prot);
>                 entry =3D pte_mkspecial(entry);
>                 if (pmd_uffd_wp(old_pmd))
>                         entry =3D pte_mkuffd_wp(entry);
> -               pte =3D pte_offset_map(&_pmd, haddr);
>                 VM_BUG_ON(!pte_none(*pte));
> -               set_pte_at(mm, haddr, pte, entry);
> -               pte_unmap(pte);
> +               set_pte_at(mm, addr, pte, entry);
> +               pte++;
>         }
> +       pte_unmap(pte - 1);
>         smp_wmb(); /* make pte visible before pmd */
>         pmd_populate(mm, pmd, pgtable);
>  }
> @@ -2077,6 +2082,7 @@ static void __split_huge_pmd_locked(struct vm_area_=
struct *vma, pmd_t *pmd,
>         bool young, write, soft_dirty, pmd_migration =3D false, uffd_wp =
=3D false;
>         bool anon_exclusive =3D false, dirty =3D false;
>         unsigned long addr;
> +       pte_t *pte;
>         int i;
>
>         VM_BUG_ON(haddr & ~HPAGE_PMD_MASK);
> @@ -2205,8 +2211,10 @@ static void __split_huge_pmd_locked(struct vm_area=
_struct *vma, pmd_t *pmd,
>         pgtable =3D pgtable_trans_huge_withdraw(mm, pmd);
>         pmd_populate(mm, &_pmd, pgtable);
>
> +       pte =3D pte_offset_map(&_pmd, haddr);
> +       VM_BUG_ON(!pte);
>         for (i =3D 0, addr =3D haddr; i < HPAGE_PMD_NR; i++, addr +=3D PA=
GE_SIZE) {
> -               pte_t entry, *pte;
> +               pte_t entry;
>                 /*
>                  * Note that NUMA hinting access restrictions are not
>                  * transferred to avoid any possibility of altering
> @@ -2249,11 +2257,11 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
>                                 entry =3D pte_mkuffd_wp(entry);
>                         page_add_anon_rmap(page + i, vma, addr, false);
>                 }
> -               pte =3D pte_offset_map(&_pmd, addr);
> -               BUG_ON(!pte_none(*pte));
> +               VM_BUG_ON(!pte_none(*pte));
>                 set_pte_at(mm, addr, pte, entry);
> -               pte_unmap(pte);
> +               pte++;
>         }
> +       pte_unmap(pte - 1);
>
>         if (!pmd_migration)
>                 page_remove_rmap(page, vma, true);
> --
> 2.35.3
>
