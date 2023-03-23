Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526BF6C714A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCWTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjCWTsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:48:35 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C29F940
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:48:30 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v14-20020a4ae6ce000000b0053b91ae6552so492765oot.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679600910;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N35dz8CtSqcUzH/58cNFAweIQmSF0nym2sZeFhKJMqk=;
        b=JtwntuK6C1YbVpjJrfwpjfEzQXbBzMQOXfLe/lJFtt9Xm1LZtrTlKVm/WWt9Zkrcas
         VE0bFS/AphuvAkcj4a/FGNLxrv1McNdjp1Ztd43ROPQgPWJfu1r8pYIX9+AT9ZETSgzJ
         C36WyktK7SpOTN+xFHWky9npsz/AyTLlfztiv0CATDDz2af1+BWcWCFYaERW0x9bYT9v
         4q4oAkSXoMBZnmqlZpBohbzl8PlBAz3M6khK8ujkLGC1O6fnQgwRq2K/1cKBI88kOK/A
         1EhekADK2ROu3DJkBiMWNjTQmmBJKHbiF2puT5xCm5PFxHzZsUTVgY4H0Ti0eqs3kekp
         6OZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679600910;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N35dz8CtSqcUzH/58cNFAweIQmSF0nym2sZeFhKJMqk=;
        b=Wvws0B874BBZ+aQFv7DUOCBK7FlbLMiLPgGl7dbQyZpFa20QTHDgZXB2V1C0wN22Dv
         a4IRsRfaOCfw5MCE/p5h3JqnKwJtRmUFMTEs5BoK+3C/FCzzFOcTDZX8FnhI9zG5dY6y
         cIMzIbmDzwViFtYjvC2Mk0T19g+SeliTBu7bKVmQPSOzJmcvxCar32XJ1mNDEQXHuguM
         CZBmp9BPZbEPr0fLrGC3xlk1xpsP3FtMiTmcBIwLt0O/0T5gynne3ZTQoocdcMmHKRqI
         IvZd1jjax+fj8Hbhpd4gUpXvX67RlgFKBWay07utrFRU9RIq9SJkEOsaRCLdXkRXGdkW
         hXlg==
X-Gm-Message-State: AO0yUKXIbH4M0vOFWKl/ojsRXP62VdWNvF4XL1lKRo4QRIYcUJa9LnjP
        a50ZNIys2CUCgVu0Ee86eMoYRg==
X-Google-Smtp-Source: AK7set+qB7fcQaq+yWzV7YGAHPD9rF5LmTnA6d09GVEqsBAZb+c2rUNA+IUJuxaVglpA3ZVI5LFxAw==
X-Received: by 2002:a4a:3315:0:b0:525:1903:5a70 with SMTP id q21-20020a4a3315000000b0052519035a70mr455379ooq.4.1679600909712;
        Thu, 23 Mar 2023 12:48:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v2-20020a0568301bc200b0068bb73bd95esm7855726ota.58.2023.03.23.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:48:28 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:48:19 -0700 (PDT)
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
        Jiaqi Yan <jiaqiyan@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/khugepaged: skip shmem with userfaultfd
In-Reply-To: <20230307052036.1520708-3-stevensd@google.com>
Message-ID: <28afde5c-a9e7-9d18-8375-4368eb137b5@google.com>
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-3-stevensd@google.com>
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
> Make sure that collapse_file respects any userfaultfds registered with
> MODE_MISSING. If userspace has any such userfaultfds registered, then
> for any page which it knows to be missing, it may expect a
> UFFD_EVENT_PAGEFAULT. This means collapse_file needs to be careful when
> collapsing a shmem range would result in replacing an empty page with a
> THP, to avoid breaking userfaultfd.
> 
> Synchronization when checking for userfaultfds in collapse_file is
> tricky because the mmap locks can't be used to prevent races with the
> registration of new userfaultfds. Instead, we provide synchronization by
> ensuring that userspace cannot observe the fact that pages are missing
> before we check for userfaultfds. Although this allows registration of a
> userfaultfd to race with collapse_file, it ensures that userspace cannot
> observe any pages transition from missing to present after such a race
> occurs. This makes such a race indistinguishable to the collapse
> occurring immediately before the userfaultfd registration.
> 
> The first step to provide this synchronization is to stop filling gaps
> during the loop iterating over the target range, since the page cache
> lock can be dropped during that loop. The second step is to fill the
> gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> time, to avoid races with accesses to the page cache that only take the
> RCU read lock.
> 
> The fact that we don't fill holes during the initial iteration means
> that collapse_file now has to handle faults occurring during the
> collapse. This is done by re-validating the number of missing pages
> after acquiring the page cache lock for the final time.
> 
> This fix is targeted at khugepaged, but the change also applies to
> MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> return EBUSY if there are any missing pages (instead of succeeding on
> shmem and returning EINVAL on anonymous memory). There is also now a
> window during MADV_COLLAPSE where a fault on a missing page will cause
> the syscall to fail with EAGAIN.
> 
> The fact that intermediate page cache state can no longer be observed
> before the rollback of a failed collapse is also technically a
> userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> is exceedingly unlikely that anything relies on being able to observe
> that transient state.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> Acked-by: Peter Xu <peterx@redhat.com>

This patch looks to me like a lot of unnecessary (and not very pretty)
change, with surprising use of XA_RETRY_ENTRY outside of xarray internals.

I think you probably worked on this one, knowing what you intended in 3/3
to follow.  But if 3/3 as such does not follow, why can't this one just
leave collapse_file()'s code flow unchanged, but insert the
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> +			if (userfaultfd_missing(vma)) {
you need somewhere just before copying and clearing the pages data?
Limited to CONFIG_USERFAULTFD=y and shmem and nr_none to minimize impact.
The locked !uptodate hpage in the xarray keeping others at bay as before.

Hmm, looking at that extract, is "start, start" correct?  And everywhere
else in mm/khugepaged.c is checking userfaultfd_armed(vma): I imagine
one or the other is more correct, but I'm not at all a userfaultfder.

And now I think that I was mistaken to Ack hch's "shmem: open code
the page cache lookup in shmem_get_folio_gfp" a few days ago: its
userfault_missing() case needs folio_lock() to be taken after
filemap_get_entry(), in order to exclude the race with collapse_file()
as it used to do.  I think.  He and I will sort that out in due course,
maybe mm/shmem.c wants its own replacement for what he's removing.

Hugh

> ---
>  include/trace/events/huge_memory.h |  3 +-
>  mm/khugepaged.c                    | 92 +++++++++++++++++++++++-------
>  2 files changed, 73 insertions(+), 22 deletions(-)
> 
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 46cce509957b..7ee85fff89a3 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -37,7 +37,8 @@
>  	EM( SCAN_CGROUP_CHARGE_FAIL,	"ccgroup_charge_failed")	\
>  	EM( SCAN_TRUNCATED,		"truncated")			\
>  	EM( SCAN_PAGE_HAS_PRIVATE,	"page_has_private")		\
> -	EMe(SCAN_COPY_MC,		"copy_poisoned_page")		\
> +	EM( SCAN_COPY_MC,		"copy_poisoned_page")		\
> +	EMe(SCAN_PAGE_FILLED,		"page_filled")			\
>  
>  #undef EM
>  #undef EMe
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b954e3c685e7..51ae399f2035 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -57,6 +57,7 @@ enum scan_result {
>  	SCAN_TRUNCATED,
>  	SCAN_PAGE_HAS_PRIVATE,
>  	SCAN_COPY_MC,
> +	SCAN_PAGE_FILLED,
>  };
>  
>  #define CREATE_TRACE_POINTS
> @@ -1873,8 +1874,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>   *  - allocate and lock a new huge page;
>   *  - scan page cache replacing old pages with the new one
>   *    + swap/gup in pages if necessary;
> - *    + fill in gaps;
>   *    + keep old pages around in case rollback is required;
> + *  - finalize updates to the page cache;
>   *  - if replacing succeeds:
>   *    + copy data over;
>   *    + free old pages;
> @@ -1952,13 +1953,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  						result = SCAN_TRUNCATED;
>  						goto xa_locked;
>  					}
> -					xas_set(&xas, index);
> +					xas_set(&xas, index + 1);
>  				}
>  				if (!shmem_charge(mapping->host, 1)) {
>  					result = SCAN_FAIL;
>  					goto xa_locked;
>  				}
> -				xas_store(&xas, hpage);
>  				nr_none++;
>  				continue;
>  			}
> @@ -2169,21 +2169,57 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		index++;
>  	}
>  
> -	/*
> -	 * Copying old pages to huge one has succeeded, now we
> -	 * need to free the old pages.
> -	 */
> -	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
> -		list_del(&page->lru);
> -		page->mapping = NULL;
> -		page_ref_unfreeze(page, 1);
> -		ClearPageActive(page);
> -		ClearPageUnevictable(page);
> -		unlock_page(page);
> -		put_page(page);
> +	if (nr_none) {
> +		struct vm_area_struct *vma;
> +		int nr_none_check = 0;
> +
> +		i_mmap_lock_read(mapping);
> +		xas_lock_irq(&xas);
> +
> +		xas_set(&xas, start);
> +		for (index = start; index < end; index++) {
> +			if (!xas_next(&xas)) {
> +				xas_store(&xas, XA_RETRY_ENTRY);
> +				nr_none_check++;
> +			}
> +		}
> +
> +		if (nr_none != nr_none_check) {
> +			result = SCAN_PAGE_FILLED;
> +			goto immap_locked;
> +		}
> +
> +		/*
> +		 * If userspace observed a missing page in a VMA with an armed
> +		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> +		 * that page, so we need to roll back to avoid suppressing such
> +		 * an event. Any userfaultfds armed after this point will not be
> +		 * able to observe any missing pages due to the previously
> +		 * inserted retry entries.
> +		 */
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> +			if (userfaultfd_missing(vma)) {
> +				result = SCAN_EXCEED_NONE_PTE;
> +				goto immap_locked;
> +			}
> +		}
> +
> +immap_locked:
> +		i_mmap_unlock_read(mapping);
> +		if (result != SCAN_SUCCEED) {
> +			xas_set(&xas, start);
> +			for (index = start; index < end; index++) {
> +				if (xas_next(&xas) == XA_RETRY_ENTRY)
> +					xas_store(&xas, NULL);
> +			}
> +
> +			xas_unlock_irq(&xas);
> +			goto rollback;
> +		}
> +	} else {
> +		xas_lock_irq(&xas);
>  	}
>  
> -	xas_lock_irq(&xas);
>  	if (is_shmem)
>  		__mod_lruvec_page_state(hpage, NR_SHMEM_THPS, nr);
>  	else
> @@ -2213,6 +2249,20 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	result = retract_page_tables(mapping, start, mm, addr, hpage,
>  				     cc);
>  	unlock_page(hpage);
> +
> +	/*
> +	 * The collapse has succeeded, so free the old pages.
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
> +
>  	goto out;
>  
>  rollback:
> @@ -2224,15 +2274,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	}
>  
>  	xas_set(&xas, start);
> -	xas_for_each(&xas, page, end - 1) {
> +	end = index;
> +	for (index = start; index < end; index++) {
> +		xas_next(&xas);
>  		page = list_first_entry_or_null(&pagelist,
>  				struct page, lru);
>  		if (!page || xas.xa_index < page->index) {
> -			if (!nr_none)
> -				break;
>  			nr_none--;
> -			/* Put holes back where they were */
> -			xas_store(&xas, NULL);
>  			continue;
>  		}
>  
> @@ -2750,12 +2798,14 @@ static int madvise_collapse_errno(enum scan_result r)
>  	case SCAN_ALLOC_HUGE_PAGE_FAIL:
>  		return -ENOMEM;
>  	case SCAN_CGROUP_CHARGE_FAIL:
> +	case SCAN_EXCEED_NONE_PTE:
>  		return -EBUSY;
>  	/* Resource temporary unavailable - trying again might succeed */
>  	case SCAN_PAGE_COUNT:
>  	case SCAN_PAGE_LOCK:
>  	case SCAN_PAGE_LRU:
>  	case SCAN_DEL_PAGE_LRU:
> +	case SCAN_PAGE_FILLED:
>  		return -EAGAIN;
>  	/*
>  	 * Other: Trying again likely not to succeed / error intrinsic to
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
