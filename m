Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7F63E56C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 00:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiK3X1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 18:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiK3X0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 18:26:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25295C6E5F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 15:18:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9904CB81D67
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 23:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079C1C433D6;
        Wed, 30 Nov 2022 23:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1669850260;
        bh=RQRN7SmzZWd2GpwMsxqTSvoCTPL2eFNSddYPgz+lK90=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z5V2E+31AY3SkeFSOJZtMYFUCJHestOS4V/Vx0s6lnjc7i0Yuj/Yz+eYXy5G3oV6V
         SDGCl/sn+IJ/q5lCDKZUFUoR41rFeDURpqmeBxYKmMHjXMQPNSOQ890rKBCEsJPrGU
         vkncGSfhr9YvmWdhgpINW+BivuuqqRr7Ic4ZXlFo=
Date:   Wed, 30 Nov 2022 15:17:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Prakash Gupta <quic_guptap@quicinc.com>,
        Divyanand Rangu <quic_drangu@quicinc.com>
Subject: Re: [PATCH] mm/madvise: fix madvise_pageout for private file
 mappings
Message-Id: <20221130151739.a7771037aa83ff536ac2edd5@linux-foundation.org>
In-Reply-To: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
References: <1667971116-12900-1-git-send-email-quic_pkondeti@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Nov 2022 10:48:36 +0530 Pavankumar Kondeti <quic_pkondeti@quicinc.com> wrote:

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

Could we please have some reviewer input on this?

Thanks.

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
>  	struct mmu_gather *tlb;
>  	bool pageout;
> +	bool can_pageout_file;
>  };
>  
>  /*
> @@ -328,6 +329,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	struct madvise_walk_private *private = walk->private;
>  	struct mmu_gather *tlb = private->tlb;
>  	bool pageout = private->pageout;
> +	bool pageout_anon_only = pageout && !private->can_pageout_file;
>  	struct mm_struct *mm = tlb->mm;
>  	struct vm_area_struct *vma = walk->vma;
>  	pte_t *orig_pte, *pte, ptent;
> @@ -364,6 +366,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (page_mapcount(page) != 1)
>  			goto huge_unlock;
>  
> +		if (pageout_anon_only && !PageAnon(page))
> +			goto huge_unlock;
> +
>  		if (next - addr != HPAGE_PMD_SIZE) {
>  			int err;
>  
> @@ -432,6 +437,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (PageTransCompound(page)) {
>  			if (page_mapcount(page) != 1)
>  				break;
> +			if (pageout_anon_only && !PageAnon(page))
> +				break;
>  			get_page(page);
>  			if (!trylock_page(page)) {
>  				put_page(page);
> @@ -459,6 +466,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		if (!PageLRU(page) || page_mapcount(page) != 1)
>  			continue;
>  
> +		if (pageout_anon_only && !PageAnon(page))
> +			continue;
> +
>  		VM_BUG_ON_PAGE(PageTransCompound(page), page);
>  
>  		if (pte_young(ptent)) {
> @@ -541,11 +551,13 @@ static long madvise_cold(struct vm_area_struct *vma,
>  
>  static void madvise_pageout_page_range(struct mmu_gather *tlb,
>  			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end)
> +			     unsigned long addr, unsigned long end,
> +			     bool can_pageout_file)
>  {
>  	struct madvise_walk_private walk_private = {
>  		.pageout = true,
>  		.tlb = tlb,
> +		.can_pageout_file = can_pageout_file,
>  	};
>  
>  	tlb_start_vma(tlb, vma);
> @@ -553,10 +565,8 @@ static void madvise_pageout_page_range(struct mmu_gather *tlb,
>  	tlb_end_vma(tlb, vma);
>  }
>  
> -static inline bool can_do_pageout(struct vm_area_struct *vma)
> +static inline bool can_do_file_pageout(struct vm_area_struct *vma)
>  {
> -	if (vma_is_anonymous(vma))
> -		return true;
>  	if (!vma->vm_file)
>  		return false;
>  	/*
> @@ -576,17 +586,23 @@ static long madvise_pageout(struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct mmu_gather tlb;
> +	bool can_pageout_file;
>  
>  	*prev = vma;
>  	if (!can_madv_lru_vma(vma))
>  		return -EINVAL;
>  
> -	if (!can_do_pageout(vma))
> -		return 0;
> +	/*
> +	 * If the VMA belongs to a private file mapping, there can be private
> +	 * dirty pages which can be paged out if even this process is neither
> +	 * owner nor write capable of the file. Cache the file access check
> +	 * here and use it later during page walk.
> +	 */
> +	can_pageout_file = can_do_file_pageout(vma);
>  
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, mm);
> -	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr, can_pageout_file);
>  	tlb_finish_mmu(&tlb);
>  
>  	return 0;
> -- 
> 2.7.4
> 
