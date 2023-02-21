Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2C469E9C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 22:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBUVzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 16:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBUVzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 16:55:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F28A5D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677016450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Brdb9PCr7A23HeU1GuCqJ3BEfkvI1UmYfLnZWb/xXjo=;
        b=FlNuAEy8p3ML/Diz8YAoSb7/jpgBbElb/RRQfDxzwUGrHKYsOIE4dHwqXVfRiR7Y5ID7CH
        W88+VibbNpgRoBmA3kTUvtP+v3GFAa+PwTK/FtVqFdyLCtFI7HYPCWIRxsGdYMy2vXoaa4
        uaseGnlsT4y+YK1ACEKchk29RFdGfEM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-XDroegEJOWye0m9mECRdpg-1; Tue, 21 Feb 2023 16:54:07 -0500
X-MC-Unique: XDroegEJOWye0m9mECRdpg-1
Received: by mail-qv1-f72.google.com with SMTP id pp11-20020a056214138b00b0056c228fa15cso2477221qvb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 13:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677016447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Brdb9PCr7A23HeU1GuCqJ3BEfkvI1UmYfLnZWb/xXjo=;
        b=K3sgpyjpBDBHb/grAAMkSUaNABBlELoHdoYmSjj9YiMahjBV7qdQCEUDldZvA/10+5
         fiZl5abpKTS3tVzF9oweMbuuKLwuup21ViRg81TWk3UR9yIYpb+4gOM644UDxnF5Vl7d
         Hu1GB5jziNWNmGhKEa7usAs7k+sZubqGXboi7a2uQ3IdjOp9GBQ4DjDexz/2wW+LcwGh
         u6HVOZ572r2tQFGMCZxYGQUciZnDm4tQPm7Ws3/M3JZzbX1TudEKtZwQERAqldZWgPMx
         kZzn6vTqojmRUwl7GdS2Ng1E1k+/zeedCi58M4KAAbfQC2U6NEAQwk5Ne8KAPl5ksXph
         0Ikg==
X-Gm-Message-State: AO0yUKUdgPO1OtHCTmRpvLhA6oV54CZCgBU1OObzX+f1yJa5cNe02YTn
        oNh9Y6Elftz7LcBihxGdKM7GCLLK7wKJnGLYwTLEDVFFv6CfZW/zJ2KKjuxa2xGn7rYtQE9x8xm
        Mi7/b5SkfdM9eB1jf/YJeyKbn
X-Received: by 2002:ac8:5a0c:0:b0:3bf:a60d:43b9 with SMTP id n12-20020ac85a0c000000b003bfa60d43b9mr4250918qta.4.1677016447106;
        Tue, 21 Feb 2023 13:54:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/BI2njRIWRcNdTMIK1mpGmgjDnnY1Ek67y/6GmgbYqOGneFOtzdi5c7Fn+86kWeJ6FQr4ybg==
X-Received: by 2002:ac8:5a0c:0:b0:3bf:a60d:43b9 with SMTP id n12-20020ac85a0c000000b003bfa60d43b9mr4250892qta.4.1677016446755;
        Tue, 21 Feb 2023 13:54:06 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id z13-20020ac8430d000000b003b9a50c8fa1sm1200878qtm.87.2023.02.21.13.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 13:54:05 -0800 (PST)
Date:   Tue, 21 Feb 2023 16:54:04 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm/khugepaged: refactor collapse_file control flow
Message-ID: <Y/U9fBxVJdhxiZ1v@x1n>
References: <20230217085439.2826375-1-stevensd@google.com>
 <20230217085439.2826375-2-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217085439.2826375-2-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 05:54:37PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Add a rollback label to deal with failure, instead of continuously
> checking for RESULT_SUCCESS, to make it easier to add more failure
> cases. The refactoring also allows the collapse_file tracepoint to
> include hpage on success (instead of NULL).
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  mm/khugepaged.c | 223 ++++++++++++++++++++++++------------------------
>  1 file changed, 110 insertions(+), 113 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8dbc39896811..6a3d6d2e25e0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1885,6 +1885,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (result != SCAN_SUCCEED)
>  		goto out;
>  
> +	__SetPageLocked(hpage);
> +	if (is_shmem)
> +		__SetPageSwapBacked(hpage);
> +	hpage->index = start;
> +	hpage->mapping = mapping;
> +
>  	/*
>  	 * Ensure we have slots for all the pages in the range.  This is
>  	 * almost certainly a no-op because most of the pages must be present
> @@ -1897,16 +1903,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		xas_unlock_irq(&xas);
>  		if (!xas_nomem(&xas, GFP_KERNEL)) {
>  			result = SCAN_FAIL;
> -			goto out;
> +			goto rollback;
>  		}
>  	} while (1);
>  
> -	__SetPageLocked(hpage);
> -	if (is_shmem)
> -		__SetPageSwapBacked(hpage);
> -	hpage->index = start;
> -	hpage->mapping = mapping;
> -
>  	/*
>  	 * At this point the hpage is locked and not up-to-date.
>  	 * It's safe to insert it into the page cache, because nobody would
> @@ -2123,131 +2123,128 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	 */
>  	try_to_unmap_flush();
>  
> -	if (result == SCAN_SUCCEED) {
> -		/*
> -		 * Replacing old pages with new one has succeeded, now we
> -		 * attempt to copy the contents.
> -		 */
> -		index = start;
> -		list_for_each_entry(page, &pagelist, lru) {
> -			while (index < page->index) {
> -				clear_highpage(hpage + (index % HPAGE_PMD_NR));
> -				index++;
> -			}
> -			if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> -					 page) > 0) {
> -				result = SCAN_COPY_MC;
> -				break;
> -			}
> -			index++;
> -		}
> -		while (result == SCAN_SUCCEED && index < end) {
> +	if (result != SCAN_SUCCEED)
> +		goto rollback;
> +
> +	/*
> +	 * Replacing old pages with new one has succeeded, now we
> +	 * attempt to copy the contents.
> +	 */
> +	index = start;
> +	list_for_each_entry(page, &pagelist, lru) {
> +		while (index < page->index) {
>  			clear_highpage(hpage + (index % HPAGE_PMD_NR));
>  			index++;
>  		}
> +		if (copy_mc_page(hpage + (page->index % HPAGE_PMD_NR),
> +				 page) > 0) {
> +			result = SCAN_COPY_MC;
> +			goto rollback;
> +		}
> +		index++;
> +	}
> +	while (index < end) {
> +		clear_highpage(hpage + (index % HPAGE_PMD_NR));
> +		index++;
>  	}
>  
> -	if (result == SCAN_SUCCEED) {
> -		/*
> -		 * Copying old pages to huge one has succeeded, now we
> -		 * need to free the old pages.
> -		 */
> -		list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> -			list_del(&page->lru);
> -			page->mapping = NULL;
> -			page_ref_unfreeze(page, 1);
> -			ClearPageActive(page);
> -			ClearPageUnevictable(page);
> -			unlock_page(page);
> -			put_page(page);
> -		}
> +	/*
> +	 * Copying old pages to huge one has succeeded, now we
> +	 * need to free the old pages.
> +	 */
> +	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> +		list_del(&page->lru);
> +		page->mapping = NULL;
> +		page_ref_unfreeze(page, 1);
> +		ClearPageActive(page);
> +		ClearPageUnevictable(page);
> +		unlock_page(page);
> +		put_page(page);
> +	}
>  
> -		xas_lock_irq(&xas);
> -		if (is_shmem)
> -			__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> -		else
> -			__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> +	xas_lock_irq(&xas);
> +	if (is_shmem)
> +		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
> +	else
> +		__mod_lruvec_page_state(hpage, NR_FILE_THPS, nr);
> +
> +	if (nr_none) {
> +		__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> +		/* nr_none is always 0 for non-shmem. */
> +		__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> +	}
> +	/* Join all the small entries into a single multi-index entry. */
> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> +	xas_store(&xas, hpage);
> +	xas_unlock_irq(&xas);
>  
> -		if (nr_none) {
> -			__mod_lruvec_page_state(hpage, NR_FILE_PAGES, nr_none);
> -			/* nr_none is always 0 for non-shmem. */
> -			__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
> -		}
> -		/* Join all the small entries into a single multi-index entry. */
> -		xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> -		xas_store(&xas, hpage);
> -		xas_unlock_irq(&xas);
> +	folio = page_folio(hpage);
> +	folio_mark_uptodate(folio);
> +	folio_ref_add(folio, HPAGE_PMD_NR - 1);
>  
> -		folio = page_folio(hpage);
> -		folio_mark_uptodate(folio);
> -		folio_ref_add(folio, HPAGE_PMD_NR - 1);
> +	if (is_shmem)
> +		folio_mark_dirty(folio);
> +	folio_add_lru(folio);
>  
> -		if (is_shmem)
> -			folio_mark_dirty(folio);
> -		folio_add_lru(folio);
> +	/*
> +	 * Remove pte page tables, so we can re-fault the page as huge.
> +	 */
> +	result = retract_page_tables(mapping, start, mm, addr, hpage,
> +				     cc);
> +	unlock_page(hpage);
> +	goto out;
> +
> +rollback:
> +	/* Something went wrong: roll back page cache changes */
> +	xas_lock_irq(&xas);
> +	if (nr_none) {
> +		mapping->nrpages -= nr_none;
> +		shmem_uncharge(mapping->host, nr_none);
> +	}
>  
> -		/*
> -		 * Remove pte page tables, so we can re-fault the page as huge.
> -		 */
> -		result = retract_page_tables(mapping, start, mm, addr, hpage,
> -					     cc);
> -		unlock_page(hpage);
> -		hpage = NULL;
> -	} else {
> -		/* Something went wrong: roll back page cache changes */
> -		xas_lock_irq(&xas);
> -		if (nr_none) {
> -			mapping->nrpages -= nr_none;
> -			shmem_uncharge(mapping->host, nr_none);
> +	xas_set(&xas, start);
> +	xas_for_each(&xas, page, end - 1) {
> +		page = list_first_entry_or_null(&pagelist,
> +				struct page, lru);
> +		if (!page || xas.xa_index < page->index) {
> +			if (!nr_none)
> +				break;
> +			nr_none--;
> +			/* Put holes back where they were */
> +			xas_store(&xas, NULL);
> +			continue;
>  		}
>  
> -		xas_set(&xas, start);
> -		xas_for_each(&xas, page, end - 1) {
> -			page = list_first_entry_or_null(&pagelist,
> -					struct page, lru);
> -			if (!page || xas.xa_index < page->index) {
> -				if (!nr_none)
> -					break;
> -				nr_none--;
> -				/* Put holes back where they were */
> -				xas_store(&xas, NULL);
> -				continue;
> -			}
> +		VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>  
> -			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> +		/* Unfreeze the page. */
> +		list_del(&page->lru);
> +		page_ref_unfreeze(page, 2);
> +		xas_store(&xas, page);
> +		xas_pause(&xas);
> +		xas_unlock_irq(&xas);
> +		unlock_page(page);
> +		putback_lru_page(page);
> +		xas_lock_irq(&xas);
> +	}
> +	VM_BUG_ON(nr_none);
> +	/*
> +	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> +	 * This undo is not needed unless failure is due to SCAN_COPY_MC.
> +	 */
> +	if (!is_shmem && result == SCAN_COPY_MC)
> +		filemap_nr_thps_dec(mapping);
>  
> -			/* Unfreeze the page. */
> -			list_del(&page->lru);
> -			page_ref_unfreeze(page, 2);
> -			xas_store(&xas, page);
> -			xas_pause(&xas);
> -			xas_unlock_irq(&xas);
> -			unlock_page(page);
> -			putback_lru_page(page);
> -			xas_lock_irq(&xas);
> -		}
> -		VM_BUG_ON(nr_none);
> -		/*
> -		 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
> -		 * This undo is not needed unless failure is due to SCAN_COPY_MC.
> -		 */
> -		if (!is_shmem && result == SCAN_COPY_MC)
> -			filemap_nr_thps_dec(mapping);
> +	xas_unlock_irq(&xas);
>  
> -		xas_unlock_irq(&xas);
> +	hpage->mapping = NULL;
>  
> -		hpage->mapping = NULL;
> -	}
> +	unlock_page(hpage);
> +	mem_cgroup_uncharge(page_folio(hpage));
> +	put_page(hpage);
>  
> -	if (hpage)
> -		unlock_page(hpage);
>  out:
>  	VM_BUG_ON(!list_empty(&pagelist));
> -	if (hpage) {
> -		mem_cgroup_uncharge(page_folio(hpage));
> -		put_page(hpage);
> -	}

Moving this chunk seems wrong, as it can leak the huge page if
alloc_charge_hpage() failed on mem charging, iiuc.

And I found that keeping it seems wrong either, because if mem charge
failed we'll uncharge even without charging it before.  But that's nothing
about this patch alone.

Posted a patch for this:

https://lore.kernel.org/all/20230221214344.609226-1-peterx@redhat.com/

I _think_ this patch will make sense after rebasing to that fix if that's
correct, but please review it and double check.

Thanks,

> -
>  	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
>  	return result;
>  }
> -- 
> 2.39.2.637.g21b0678d19-goog
> 

-- 
Peter Xu

