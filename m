Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668C646612
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLHAqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLHAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:46:29 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09F98DBDE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:46:28 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id 3so102655vsq.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 16:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BIw7NaxMlqZRuJd3JvVxKniDE1qFghGLpAfWUnuQmyg=;
        b=YCoigiVijSXgi0g70gvipylQr8/o8f9/vgZiOrAK5bsQfAjlyalnETlwr4oBqWO4Kp
         6oA/ptR/EqYj39I7qdWoFvCqBqJLV0O1emBjpnpVj6TEQThTp9PcqjYZCiDQ6wXIthh6
         SjQ5JlipNTDsWndi9LmBObgrFWXCuQLsfwcxsYMhUOjtQ8PTaeGCyhDSWBiRaSrbCUIz
         b0xNKgQTuYBZLUUEizRaJLGts0XrM/swCyuElCvfQQfXkrul7+P/e+WDMt9sAw4DJNhz
         RLdfVsAUBWlzFpHL6b0RcQi98T6wZAXsklAZ9qiuW/wLVxMwYb+sJwnhFlPB9yIvcbtw
         +NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIw7NaxMlqZRuJd3JvVxKniDE1qFghGLpAfWUnuQmyg=;
        b=ObCUipmSkOEcoRRQRGY7rmhPM/yQ2AP7sCSOc3Gx+atUymDSmflwMivWFDF2vD6QjY
         2TEE8pzR0XN1pwcHvB2Poztp5BoB9JXXO5fTUI2hfxGAoYeoazAO9pgHv858f2HviT+i
         VwF/5jT0Ll+9FIDwjbUxKZ6OVWAgvC+tLS5xyXLo5PLupdypSdMpIOUUEO4Gyog5956w
         JnGM/4NCVehVmgugNmeDJOCVatlG7q/W4gI23oDT7X15oR4JZ75uI73Jm+mLwIIflH03
         H70BfH8+szjBP4EXdQ6QI8HZlRdUFOAqHED9DdfQaL9UZSltIXZUtAvbnfJ/a+C+L5Hw
         ctiQ==
X-Gm-Message-State: ANoB5plmAsYD0wXCUC0GZUKx94uFJnlpoD6PnYgGLXQQOihHvwViAU4J
        TYp/mmhmP3T1OFmexqgDXqbPIK0KRpj7uhwGnHnZYw==
X-Google-Smtp-Source: AA0mqf7hjK9bZqtIrLbR1QFV8hkV8UwY43wqwiULUFLce+43tiZ2SqJh9fo4wj57lFTP4ztvMAFp1g1lqg1NSFBzYjc=
X-Received: by 2002:a05:6102:2758:b0:3b1:1962:24f9 with SMTP id
 p24-20020a056102275800b003b1196224f9mr12696662vsu.72.1670460387885; Wed, 07
 Dec 2022 16:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20221021163703.3218176-1-jthoughton@google.com> <20221021163703.3218176-11-jthoughton@google.com>
In-Reply-To: <20221021163703.3218176-11-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 7 Dec 2022 16:46:16 -0800
Message-ID: <CAHS8izPYvrviLbtVNkg+bnSXt5zvaXfJJV9+CAZ_0qESyMimBw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/47] hugetlb: add hugetlb_pte to track HugeTLB
 page table entries
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 21, 2022 at 9:37 AM James Houghton <jthoughton@google.com> wrote:
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
> ---
>  include/linux/hugetlb.h | 88 +++++++++++++++++++++++++++++++++++++++++
>  mm/hugetlb.c            | 29 ++++++++++++++
>  2 files changed, 117 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index db3ed6095b1c..d30322108b34 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -50,6 +50,75 @@ enum {
>         __NR_USED_SUBPAGE,
>  };
>
> +enum hugetlb_level {
> +       HUGETLB_LEVEL_PTE = 1,
> +       /*
> +        * We always include PMD, PUD, and P4D in this enum definition so that,
> +        * when logged as an integer, we can easily tell which level it is.
> +        */
> +       HUGETLB_LEVEL_PMD,
> +       HUGETLB_LEVEL_PUD,
> +       HUGETLB_LEVEL_P4D,
> +       HUGETLB_LEVEL_PGD,
> +};
> +

Don't we need to support CONTIG_PTE/PMD levels here for ARM64?

> +struct hugetlb_pte {
> +       pte_t *ptep;
> +       unsigned int shift;
> +       enum hugetlb_level level;

Is shift + level redundant? When would those diverge?

> +       spinlock_t *ptl;
> +};
> +
> +static inline
> +void hugetlb_pte_populate(struct hugetlb_pte *hpte, pte_t *ptep,
> +                         unsigned int shift, enum hugetlb_level level)
> +{
> +       WARN_ON_ONCE(!ptep);
> +       hpte->ptep = ptep;
> +       hpte->shift = shift;
> +       hpte->level = level;
> +       hpte->ptl = NULL;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_size(const struct hugetlb_pte *hpte)
> +{
> +       WARN_ON_ONCE(!hpte->ptep);
> +       return 1UL << hpte->shift;
> +}
> +
> +static inline
> +unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
> +{
> +       WARN_ON_ONCE(!hpte->ptep);
> +       return ~(hugetlb_pte_size(hpte) - 1);
> +}
> +
> +static inline
> +unsigned int hugetlb_pte_shift(const struct hugetlb_pte *hpte)
> +{
> +       WARN_ON_ONCE(!hpte->ptep);
> +       return hpte->shift;
> +}
> +
> +static inline
> +enum hugetlb_level hugetlb_pte_level(const struct hugetlb_pte *hpte)
> +{
> +       WARN_ON_ONCE(!hpte->ptep);
> +       return hpte->level;
> +}
> +
> +static inline
> +void hugetlb_pte_copy(struct hugetlb_pte *dest, const struct hugetlb_pte *src)
> +{
> +       dest->ptep = src->ptep;
> +       dest->shift = src->shift;
> +       dest->level = src->level;
> +       dest->ptl = src->ptl;
> +}
> +
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
> +
>  struct hugepage_subpool {
>         spinlock_t lock;
>         long count;
> @@ -1210,6 +1279,25 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
>         return ptl;
>  }
>
> +static inline
> +spinlock_t *hugetlb_pte_lockptr(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +
> +       BUG_ON(!hpte->ptep);

I think BUG_ON()s will be frowned upon. This function also doesn't
really need ptep. Maybe let hugetlb_pte_shift() decide to BUG_ON() if
necessary.


> +       if (hpte->ptl)
> +               return hpte->ptl;
> +       return huge_pte_lockptr(hugetlb_pte_shift(hpte), mm, hpte->ptep);

I don't know if this fallback to huge_pte_lockptr() should be obivous
to the reader. If not, a comment would help.

> +}
> +
> +static inline
> +spinlock_t *hugetlb_pte_lock(struct mm_struct *mm, struct hugetlb_pte *hpte)
> +{
> +       spinlock_t *ptl = hugetlb_pte_lockptr(mm, hpte);
> +
> +       spin_lock(ptl);
> +       return ptl;
> +}
> +
>  #if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
>  extern void __init hugetlb_cma_reserve(int order);
>  #else
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ef7662bd0068..a0e46d35dabc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1127,6 +1127,35 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
>         return false;
>  }
>
> +bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte)

I also don't know if this is obvious to other readers, but I'm quite
confused that we pass both hugetlb_pte and pte_t here, especially when
hpte has a pte_t inside of it. Maybe a comment would help.

> +{
> +       pgd_t pgd;
> +       p4d_t p4d;
> +       pud_t pud;
> +       pmd_t pmd;
> +
> +       WARN_ON_ONCE(!hpte->ptep);
> +       switch (hugetlb_pte_level(hpte)) {
> +       case HUGETLB_LEVEL_PGD:
> +               pgd = __pgd(pte_val(pte));
> +               return pgd_present(pgd) && pgd_leaf(pgd);
> +       case HUGETLB_LEVEL_P4D:
> +               p4d = __p4d(pte_val(pte));
> +               return p4d_present(p4d) && p4d_leaf(p4d);
> +       case HUGETLB_LEVEL_PUD:
> +               pud = __pud(pte_val(pte));
> +               return pud_present(pud) && pud_leaf(pud);
> +       case HUGETLB_LEVEL_PMD:
> +               pmd = __pmd(pte_val(pte));
> +               return pmd_present(pmd) && pmd_leaf(pmd);
> +       case HUGETLB_LEVEL_PTE:
> +               return pte_present(pte);
> +       default:
> +               WARN_ON_ONCE(1);
> +               return false;
> +       }
> +}
> +
>  static void enqueue_huge_page(struct hstate *h, struct page *page)
>  {
>         int nid = page_to_nid(page);
> --
> 2.38.0.135.g90850a2211-goog
>
