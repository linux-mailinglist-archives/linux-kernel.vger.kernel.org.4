Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A737B68A799
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjBDBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjBDBqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:46:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD8BA9D5F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 17:46:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD7EB82C1C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 01:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D175C433EF;
        Sat,  4 Feb 2023 01:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675475161;
        bh=H/i6B4QCS1pFRvxe1XgeIybEfQ/L4+Kf60VEnVS8tmY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1oN/7nLVldsnrQpC9YZxwmNErwjbLUG9DWnrTudXeEqJGK4UBu+8UvWq8MyrHjj74
         Ty3HyyfXRj9Eih4rxLptMt9uVRgdGZSSP3x0P/vUY4P/EuSzNCCil1rxDzg+D4HR44
         aHdJiTEvFS1bJH1DtJgK4R84UU0rsNHs1jWNVHvQ=
Date:   Fri, 3 Feb 2023 17:46:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>, <tony.luck@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] mm: hwposion: support recovery from
 ksm_might_need_to_copy()
Message-Id: <20230203174600.fd5a60663ae1d98cb44ea5e3@linux-foundation.org>
In-Reply-To: <20230201074433.96641-1-wangkefeng.wang@huawei.com>
References: <20230201074433.96641-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Feb 2023 15:44:33 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> When the kernel copy a page from ksm_might_need_to_copy(), but runs
> into an uncorrectable error, it will crash since poisoned page is
> consumed by kernel, this is similar to the issue recently fixed by
> Copy-on-write poison recovery.
> 
> When an error is detected during the page copy, return VM_FAULT_HWPOISON
> in do_swap_page(), and install a hwpoison entry in unuse_pte() when
> swapoff, which help us to avoid system crash. Note, memory failure on
> a KSM page will be skipped, but still call memory_failure_queue() to
> be consistent with general memory failure process, and we could support
> KSM page recovery in the feature.
> 

Some review input would be helpful.

Are we able to identify a Fixes: target for this?

I assume that a -stable backport is desirable?

Thanks.

> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2629,8 +2629,11 @@ struct page *ksm_might_need_to_copy(struct page *page,
>  		new_page = NULL;
>  	}
>  	if (new_page) {
> -		copy_user_highpage(new_page, page, address, vma);
> -
> +		if (copy_mc_user_highpage(new_page, page, address, vma)) {
> +			put_page(new_page);
> +			memory_failure_queue(page_to_pfn(page), 0);
> +			return ERR_PTR(-EHWPOISON);
> +		}
>  		SetPageDirty(new_page);
>  		__SetPageUptodate(new_page);
>  		__SetPageLocked(new_page);
> diff --git a/mm/memory.c b/mm/memory.c
> index aad226daf41b..5b2c137dfb2a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3840,6 +3840,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		if (unlikely(!page)) {
>  			ret = VM_FAULT_OOM;
>  			goto out_page;
> +		} else if (unlikely(PTR_ERR(page) == -EHWPOISON)) {
> +			ret = VM_FAULT_HWPOISON;
> +			goto out_page;
>  		}
>  		folio = page_folio(page);
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 908a529bca12..3ef2468d7130 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1763,12 +1763,15 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  	struct page *swapcache;
>  	spinlock_t *ptl;
>  	pte_t *pte, new_pte;
> +	bool hwposioned = false;
>  	int ret = 1;
>  
>  	swapcache = page;
>  	page = ksm_might_need_to_copy(page, vma, addr);
>  	if (unlikely(!page))
>  		return -ENOMEM;
> +	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
> +		hwposioned = true;
>  
>  	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
>  	if (unlikely(!pte_same_as_swp(*pte, swp_entry_to_pte(entry)))) {
> @@ -1776,15 +1779,19 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		goto out;
>  	}
>  
> -	if (unlikely(!PageUptodate(page))) {
> -		pte_t pteval;
> +	if (unlikely(hwposioned || !PageUptodate(page))) {
> +		swp_entry_t swp_entry;
>  
>  		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> -		pteval = swp_entry_to_pte(make_swapin_error_entry());
> -		set_pte_at(vma->vm_mm, addr, pte, pteval);
> -		swap_free(entry);
> +		if (hwposioned) {
> +			swp_entry = make_hwpoison_entry(swapcache);
> +			page = swapcache;
> +		} else {
> +			swp_entry = make_swapin_error_entry();
> +		}
> +		new_pte = swp_entry_to_pte(swp_entry);
>  		ret = 0;
> -		goto out;
> +		goto setpte;
>  	}
>  
>  	/* See do_swap_page() */
> @@ -1816,6 +1823,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		new_pte = pte_mksoft_dirty(new_pte);
>  	if (pte_swp_uffd_wp(*pte))
>  		new_pte = pte_mkuffd_wp(new_pte);
> +setpte:
>  	set_pte_at(vma->vm_mm, addr, pte, new_pte);
>  	swap_free(entry);
>  out:
> -- 
> 2.35.3
> 
