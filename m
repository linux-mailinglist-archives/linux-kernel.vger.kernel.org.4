Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C78C69B820
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 06:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBRFYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 00:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 00:24:38 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7375BDB2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 21:24:37 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id r7so1066173ila.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 21:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhiJ1/D2QxeIv9bIqqR07iYwFrWIf3Mp0nK6fpVQfRM=;
        b=B5AHjdEs6uKyKkCTjXHEqP9qkra+r0YkBfV3Ukr+beq3Z6OGtNGJwX/QaX/xUX9g0N
         raOpNqCaVtBts85Vo5MW8/Ks0fMe0b5l2q9OkmzK86vDgZj3rI93CwNMW8VKUSyr3ptf
         MVTNg8Kdg+GWVNLJjuD09aM2KPg+Z9y/LjgQwsQZIqGIrUJCtqPfED1L/3esx1WBdw/9
         iwzc//b8ZSsiOqfjz98NZ0nberI0Vzo+d+4jEG5jCUBA3xUEaoGA+PzPVEY1xmt7sDP0
         bcC51FbUVOisA3gXZ3JSko8NNi0V+sLhChy+ITBOzExKoNOqO5bJTRlaosSMMuGUdPK7
         jR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhiJ1/D2QxeIv9bIqqR07iYwFrWIf3Mp0nK6fpVQfRM=;
        b=VaPXxcaDaTHxtR4ONGWcfclj1+SYm2hA5uwRvdJyww0GevGvrJbkx6DSvgUqeKkQFd
         uS1I0KJRFmoOD2bjwVKSsf5VhtVGKQNuSCCfwtHvkEYDlPZGppIZvnucQRnJxrEeGCAI
         UsIMGxwxzTRBEVAt5nbbLaly8R1lGYJhrN9Aw9XEr6RlJZViNSDdrjPO10X+Q3xaz9ze
         Me+WUb04mPbbTPkZzDwsUBkEsCNEn6/0OlKFaGAlR3HfpWi41UnLYm5iAKZcwDZdjKTn
         5yKd+P6qdUG/oJQlzEK0oCHJgz88lDpOvGoLKySKWuJiTreWTZB2O3Ho83f1GmLTYMpu
         63eg==
X-Gm-Message-State: AO0yUKXgfr93mM2Lfvae3bH71MfSCl7Hvff2YG9CizJisN3o1urel4r2
        7lOAxTKvA7iHcQur0VOs3qbiWwPZEm2VCDhVSO742w==
X-Google-Smtp-Source: AK7set9uUebKdPMIPLmMs9VdI2KWQs5nCUTc2SQqMGLHyxTtJHhuOxcrrzXZIsykp/XMPRMfctB57tbOTsBnLDXgf18=
X-Received: by 2002:a05:6e02:1311:b0:315:8f6c:50a6 with SMTP id
 g17-20020a056e02131100b003158f6c50a6mr1786793ilr.1.1676697876362; Fri, 17 Feb
 2023 21:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20230218002819.1486479-1-jthoughton@google.com> <20230218002819.1486479-12-jthoughton@google.com>
In-Reply-To: <20230218002819.1486479-12-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 17 Feb 2023 21:24:24 -0800
Message-ID: <CAHS8izMGR8MZW1dMCCWQagoCKBvHWBJNwvWZQyrCGzZAoQy0sw@mail.gmail.com>
Subject: Re: [PATCH v2 11/46] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Feb 17, 2023 at 4:28=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> After high-granularity mapping, page table entries for HugeTLB pages can
> be of any size/type. (For example, we can have a 1G page mapped with a
> mix of PMDs and PTEs.) This struct is to help keep track of a HugeTLB
> PTE after we have done a page table walk.
>
> Without this, we'd have to pass around the "size" of the PTE everywhere.
> We effectively did this before; it could be fetched from the hstate,
> which we pass around pretty much everywhere.
>
> hugetlb_pte_present_leaf is included here as a helper function that will
> be used frequently later on.
>
> Signed-off-by: James Houghton <jthoughton@google.com>
>

Only nits.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a1ceb9417f01..eeacadf3272b 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -26,6 +26,25 @@ typedef struct { unsigned long pd; } hugepd_t;
>  #define __hugepd(x) ((hugepd_t) { (x) })
>  #endif
>
> +enum hugetlb_level {
> +       HUGETLB_LEVEL_PTE =3D 1,
> +       /*
> +        * We always include PMD, PUD, and P4D in this enum definition so=
 that,
> +        * when logged as an integer, we can easily tell which level it i=
s.
> +        */
> +       HUGETLB_LEVEL_PMD,
> +       HUGETLB_LEVEL_PUD,
> +       HUGETLB_LEVEL_P4D,
> +       HUGETLB_LEVEL_PGD,
> +};
> +
> +struct hugetlb_pte {
> +       pte_t *ptep;
> +       unsigned int shift;
> +       enum hugetlb_level level;
> +       spinlock_t *ptl;
> +};
> +
>  #ifdef CONFIG_HUGETLB_PAGE
>
>  #include <linux/mempolicy.h>
> @@ -39,6 +58,20 @@ typedef struct { unsigned long pd; } hugepd_t;
>   */
>  #define __NR_USED_SUBPAGE 3
>
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +       return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +       return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)=
;
> +
>  struct hugepage_subpool {
>         spinlock_t lock;
>         long count;
> @@ -1234,6 +1267,45 @@ static inline spinlock_t *huge_pte_lock(struct hst=
ate *h,
>         return ptl;
>  }
>
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct hugetlb_pte *hpte)
> +{
> +       return hpte->ptl;
> +}

I find this helper unnecessary. I would remove it.

> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct hugetlb_pte *hpte)
> +{
> +       spinlock_t *ptl =3D hugetlb_pte_lockptr(hpte);
> +
> +       spin_lock(ptl);

Here 'spin_lock(hpte->ptl)' would be more immediately understandable
IMO, for example.

> +       return ptl;
> +}
> +
> +static inline
> +void __hugetlb_pte_init(struct hugetlb_pte *hpte, pte_t *ptep,
> +                       unsigned int shift, enum hugetlb_level level,
> +                       spinlock_t *ptl)
> +{
> +       /*
> +        * If 'shift' indicates that this PTE is contiguous, then @ptep m=
ust
> +        * be the first pte of the contiguous bunch.
> +        */

I would move the comment to above the function as a pseudo doc. It
seems to instruct the user of the function of how to use it.

> +       hpte->ptl =3D ptl;
> +       hpte->ptep =3D ptep;
> +       hpte->shift =3D shift;
> +       hpte->level =3D level;
> +}
> +
> +static inline
> +void hugetlb_pte_init(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +                     pte_t *ptep, unsigned int shift,
> +                     enum hugetlb_level level)
> +{
> +       __hugetlb_pte_init(hpte, ptep, shift, level,
> +                          huge_pte_lockptr(shift, mm, ptep));
> +}
> +
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>  extern void __init hugetlb_cma_reserve(int order);
>  #else
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5ca9eae0ac42..6c74adff43b6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1269,6 +1269,35 @@ static bool vma_has_reserves(struct vm_area_struct=
 *vma, long chg)
>         return false;
>  }
>
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)
> +{
> +       pgd_t pgd;
> +       p4d_t p4d;
> +       pud_t pud;
> +       pmd_t pmd;
> +
> +       switch (hpte->level) {
> +       case HUGETLB_LEVEL_PGD:
> +               pgd =3D __pgd(pte_val(pte));
> +               return pgd_present(pgd) && pgd_leaf(pgd);
> +       case HUGETLB_LEVEL_P4D:
> +               p4d =3D __p4d(pte_val(pte));
> +               return p4d_present(p4d) && p4d_leaf(p4d);
> +       case HUGETLB_LEVEL_PUD:
> +               pud =3D __pud(pte_val(pte));
> +               return pud_present(pud) && pud_leaf(pud);
> +       case HUGETLB_LEVEL_PMD:
> +               pmd =3D __pmd(pte_val(pte));
> +               return pmd_present(pmd) && pmd_leaf(pmd);
> +       case HUGETLB_LEVEL_PTE:
> +               return pte_present(pte);
> +       default:
> +               WARN_ON_ONCE(1);
> +               return false;
> +       }
> +}
> +
> +
>  static void enqueue_hugetlb_folio(struct hstate *h, struct folio *folio)
>  {
>         int nid =3D folio_nid(folio);
> --
> 2.39.2.637.g21b0678d19-goog
>
