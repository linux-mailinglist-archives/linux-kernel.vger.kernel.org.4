Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2761563F1ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLANqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiLANqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:46:49 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2206BF908
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:46:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z17so1920731pff.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=If3f63B2h04b254I9o4MKB84vjG8+jxVlrx/meu7X4Q=;
        b=EClEtH/ntnyU/neADIAgFPgnHmZXeChJhm37Axu3KuXbE1dTu0O3YWjGntXfHNWfkA
         UrbxYH2cZ/n2/uH4BK9lm7mxMwTsGYRMjgZ+oVcBECDySXkMbF7tX30n/N75T5KRfna9
         ldbJkAZ8XKhWWTEV0vjOAFiJfRh2HJjEsksdVySpPgj4cCLgSITukd7FTCJFi4VWnOjV
         UaSfH7BmrrkbeNyP/1okOoXcq/KOBlykgn4B6WdNuacwVQzM8EIKsAFo0U1ye5kknbu+
         FQhqpnWuQy1Kr3MhKjN9FoIDNBOBqwJJADYZToSLeOgDknqIBaDrbgw7pXyE9OM8Z9ze
         UxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=If3f63B2h04b254I9o4MKB84vjG8+jxVlrx/meu7X4Q=;
        b=k7TDclzrs0ENNR3wUoFXhGFueW6R2GWUdxiPUuugNKpQCbayDF9soQTmBbq9acDC1U
         SXffhJwQ/MzmmBR655LKZImGDUeb727JZTBncOcao8KsEjbmEUbu5fNRsQFIHJe7ZlFi
         sJnxKjii5RGQvhN3p9dERk5Bdh1RGVhEwgKurVLWEnjUn1ZCFaZ6k7rZOJIffw5PQOT5
         4yWicx2Cr19Xi//trv3VQLxDMyfax48BhTMSGe1szZd2lS+qMAohIebSwwz2GTSYuXcE
         7s3xzZz+6qJVQcUpotHuIl5CNmKT5DMPkPsFi1wLvwfqBsTtGMQ2OZbYPbO6/LkTwou/
         u0rQ==
X-Gm-Message-State: ANoB5pm1q4qcLevj0L0qh1nMMLtXDjY8AD/ou/VP/osrzkciCF5/uJwI
        cGQivssoO/StJ+QsZNEoZD9JnRAg29bh+6Iius5l3r1BgbA=
X-Google-Smtp-Source: AA0mqf7bG/X5stL6Dd2Hv8aBi5pAAIrx3BXCVyth6PhEVACscNTU53PS0x03AGRjcBFApsqp3WXipxXrns7ZwqHCfr0=
X-Received: by 2002:a63:4808:0:b0:46a:f646:13da with SMTP id
 v8-20020a634808000000b0046af64613damr40318638pga.621.1669902408052; Thu, 01
 Dec 2022 05:46:48 -0800 (PST)
MIME-Version: 1.0
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
In-Reply-To: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
From:   Mark Hemment <markhemm@googlemail.com>
Date:   Thu, 1 Dec 2022 13:46:36 +0000
Message-ID: <CANe_+Uidg=YuZG71VF7YnRhBtUHb-CGRMN45RGgp2PMn+SXGkg@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file mappings
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2022 at 05:19, Pavankumar Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
> When MADV_PAGEOUT is called on a private file mapping VMA region,
> we bail out early if the process is neither owner nor write capable
> of the file. However, this VMA may have both private/shared clean
> pages and private dirty pages. The opportunity of paging out the
> private dirty pages (Anon pages) is missed. Fix this by caching
> the file access check and use it later along with PageAnon() during
> page walk.
>
> We observe ~10% improvement in zram usage, thus leaving more available
> memory on a 4GB RAM system running Android.
>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Only scanned review the patch; the logic looks good (as does the
reasoning) but a couple of minor comments;


> ---
>  mm/madvise.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index c7105ec..b6b88e2 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -40,6 +40,7 @@
>  struct madvise_walk_private {
>         struct mmu_gather *tlb;
>         bool pageout;
> +       bool can_pageout_file;
>  };
>
>  /*
> @@ -328,6 +329,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>         struct madvise_walk_private *private = walk->private;
>         struct mmu_gather *tlb = private->tlb;
>         bool pageout = private->pageout;
> +       bool pageout_anon_only = pageout && !private->can_pageout_file;
>         struct mm_struct *mm = tlb->mm;
>         struct vm_area_struct *vma = walk->vma;
>         pte_t *orig_pte, *pte, ptent;
> @@ -364,6 +366,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>                 if (page_mapcount(page) != 1)
>                         goto huge_unlock;
>
> +               if (pageout_anon_only && !PageAnon(page))
> +                       goto huge_unlock;
> +
>                 if (next - addr != HPAGE_PMD_SIZE) {
>                         int err;
>
> @@ -432,6 +437,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>                 if (PageTransCompound(page)) {
>                         if (page_mapcount(page) != 1)
>                                 break;
> +                       if (pageout_anon_only && !PageAnon(page))
> +                               break;
>                         get_page(page);
>                         if (!trylock_page(page)) {
>                                 put_page(page);
> @@ -459,6 +466,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>                 if (!PageLRU(page) || page_mapcount(page) != 1)
>                         continue;
>
> +               if (pageout_anon_only && !PageAnon(page))
> +                       continue;
> +

The added PageAnon()s probably do not have a measurable performance
impact, but not ideal when walking a large anonymous mapping (as
'->can_pageout_file' is zero for anon mappings).
Could the code be re-structured so that PageAnon() is only tested when
filtering is needed? Say;
    if (pageout_anon_only_filter && !PageAnon(page)) {
        continue;
    }
where 'pageout_anon_only_filter' is only set for a private named
mapping when do not have write perms on backing object.  It would not
be set for anon mappings.


>                 VM_BUG_ON_PAGE(PageTransCompound(page), page);
>
>                 if (pte_young(ptent)) {
> @@ -541,11 +551,13 @@ static long madvise_cold(struct vm_area_struct *vma,
>
>  static void madvise_pageout_page_range(struct mmu_gather *tlb,
>                              struct vm_area_struct *vma,
> -                            unsigned long addr, unsigned long end)
> +                            unsigned long addr, unsigned long end,
> +                            bool can_pageout_file)
>  {
>         struct madvise_walk_private walk_private = {
>                 .pageout = true,
>                 .tlb = tlb,
> +               .can_pageout_file = can_pageout_file,
>         };
>
>         tlb_start_vma(tlb, vma);
> @@ -553,10 +565,8 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
>         tlb_end_vma(tlb, vma);
>  }
>
> -static inline bool can_do_pageout(struct vm_area_struct *vma)
> +static inline bool can_do_file_pageout(struct vm_area_struct *vma)
>  {
> -       if (vma_is_anonymous(vma))
> -               return true;
>         if (!vma->vm_file)
>                 return false;
>         /*
> @@ -576,17 +586,23 @@ static long madvise_pageout(struct vm_area_struct *vma,
>  {
>         struct mm_struct *mm = vma->vm_mm;
>         struct mmu_gather tlb;
> +       bool can_pageout_file;
>
>         *prev = vma;
>         if (!can_madv_lru_vma(vma))
>                 return -EINVAL;
>
> -       if (!can_do_pageout(vma))
> -               return 0;

The removal of this test results in a process, which cannot get write
perms for a shared named mapping, performing a 'walk'.  As such a
mapping cannot have anon pages, this walk will be a no-op.  Not sure
why a well-behaved program would do a MADV_PAGEOUT on such a mapping,
but if one does this could be considered a (minor performance)
regression. As madvise_pageout() can easily filter this case, might be
worth adding a check.


> +       /*
> +        * If the VMA belongs to a private file mapping, there can be private
> +        * dirty pages which can be paged out if even this process is neither
> +        * owner nor write capable of the file. Cache the file access check
> +        * here and use it later during page walk.
> +        */
> +       can_pageout_file = can_do_file_pageout(vma);
>
>         lru_add_drain();
>         tlb_gather_mmu(&tlb, mm);
> -       madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +       madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
>         tlb_finish_mmu(&tlb);
>
>         return 0;
> --
> 2.7.4
>
>

Cheers,
Mark
