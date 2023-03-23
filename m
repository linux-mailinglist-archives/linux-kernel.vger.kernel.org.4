Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3A16C7155
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCWTwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCWTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:52:08 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3897920D3F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:52:06 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s8so7158537ois.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679601125;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dA0uThRsW2cr4sByCucjOZMV1mZ7yw0K4Dowgh98688=;
        b=qMdmcfnJmLHjjyQrcKEkqOG70E46fZJmY2r5fQ9Gk5cUjLT8NqytvC2G6SbP8ipSxb
         FSd/JklkIRDBaJ53nGvrkfE3/D5vI3cb8dK/2nkZUok+ncObfA05l1X6cUqLPhiwEIPj
         ikznRHU+vnF5ILKs9+5LANvvD7O8jlSL9673Z4Bpka5d/P41/RB3OmGHAR/8LMZKnI1T
         SqSSsQngbKGzgMs7NuWVXYmx1tPx222uSw2t69vNDN+ZJ5O83T5D50tjKGoihDVUCtmE
         kEnWGzSHZETuJfMCaT7uAo65HDYLuCmHXy9Wj6TKrNCsCvL6vs57VIJB0O2F5trEpTh5
         SzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679601125;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA0uThRsW2cr4sByCucjOZMV1mZ7yw0K4Dowgh98688=;
        b=dWBvyvd+ESZfRWmHh6NqjuRMummLCcbPu46REVEJWiqQS26N8qtGLROhrznXvFCoQB
         pTpWyWwVuMNQF84+rLezjKOv7jBeOy27tT/Y2h+EpSithZlFAcMmrAvQeFaUH+xmo3Ua
         egDBxq1k5mtYwvMFjsju1KGVm4dSu0Ry6LavsFyc3BrV2V2IHHnJ7b7/sXq/64Wi1Rq/
         SO5PQXTFnxda2maOtHznvY/Xy49hJTY7Igr4Ub0BYRkJ+CrdHX6wY3RX/kQina38t4Ha
         SZuesWXj8my4Heex2ZXklrIh7Sr/M0SCqS+Joj5BZaWPk64pWXeras1XxSIq2QnIJZ60
         uM+A==
X-Gm-Message-State: AO0yUKXRMtbTOJhaizd5rad7UIl8YkO9wsrY8cRB/ZMc7aAa2FWU0gnw
        9PIUa09pjP38TiQmH4QX6rHDSw==
X-Google-Smtp-Source: AK7set+1+f5IkYHLSVzSFkUCGB9noFTXJKEYTDhV1PLhevmSpvBjRowcQHTZBxIbn40GfTtRy2dEJw==
X-Received: by 2002:a54:4785:0:b0:360:cb13:e78a with SMTP id o5-20020a544785000000b00360cb13e78amr3597800oic.58.1679601125102;
        Thu, 23 Mar 2023 12:52:05 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w40-20020a4a97ab000000b00524f381f681sm7621315ooi.27.2023.03.23.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:52:04 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:51:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Stevens <stevensd@chromium.org>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mm/khugepaged: refactor collapse_file control
 flow
In-Reply-To: <20230307052036.1520708-2-stevensd@google.com>
Message-ID: <46f29fba-d35-c6a-74d0-38dc6aa15f15@google.com>
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-2-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023, David Stevens wrote:

> From: David Stevens <stevensd@chromium.org>
> 
> Add a rollback label to deal with failure, instead of continuously
> checking for RESULT_SUCCESS, to make it easier to add more failure
> cases. The refactoring also allows the collapse_file tracepoint to
> include hpage on success (instead of NULL).
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> Acked-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Yang Shi <shy828301@gmail.com>

This one looks like a nice de-indentation to me,
even if it's not followed by 2/3 and 3/3.

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/khugepaged.c | 219 ++++++++++++++++++++++++------------------------
>  1 file changed, 108 insertions(+), 111 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 3ea2aa55c2c5..b954e3c685e7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1907,6 +1907,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
> @@ -1919,16 +1925,10 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
> @@ -2145,129 +2145,126 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
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
> -			if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR),
> -					     page) > 0) {
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
> +		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page) > 0) {
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
> -		folio = page_folio(hpage);
> -		folio_mark_uptodate(folio);
> -		folio_ref_add(folio, HPAGE_PMD_NR - 1);
> +	folio = page_folio(hpage);
> +	folio_mark_uptodate(folio);
> +	folio_ref_add(folio, HPAGE_PMD_NR - 1);
>  
> -		if (is_shmem)
> -			folio_mark_dirty(folio);
> -		folio_add_lru(folio);
> +	if (is_shmem)
> +		folio_mark_dirty(folio);
> +	folio_add_lru(folio);
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
> +
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
> +	put_page(hpage);
>  
> -	if (hpage)
> -		unlock_page(hpage);
>  out:
>  	VM_BUG_ON(!list_empty(&pagelist));
> -	if (hpage)
> -		put_page(hpage);
> -
>  	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
>  	return result;
>  }
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
> 
> 
