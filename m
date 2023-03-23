Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9176B6C70C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjCWTI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjCWTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:08:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494084C3D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:08:07 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g9so14823953qvt.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679598484;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivi4IJmDGlMaUcj97G9bPWUboQ3UgQjoh4VHDGaJpfc=;
        b=CBJ+lvrgdwqXbnRaEFqUSluQmkERU+1Ly+yUdpQSYhoMZ/eZO1RTbRWPJjyDSl0+sE
         sNs6jBeiFFOukrToDd6JFSZnGxPzD3IJ21lbBgigJMdK3uDWn4AwkKHYdEFB/jp5wZLt
         VRJK9U8qbzs9kRRa5pO70XpyVsOhL5i1tNrwApaEp2r4KufkMS1QVJDytPS1TapSnE7Y
         ZwuBNMdxIM+V3k3tO8U6XaCV3bwaoUZNm+ioF8Fa5Y7GfLwIg0QN8oi4bpTkOFAfIhMo
         m5D5dp7uc9BvDoVYPYMAmL8Kkuk8j/8wvyboRfS0S5pKLfl169iJAtd/zRYz2RCweiQe
         rwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598484;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivi4IJmDGlMaUcj97G9bPWUboQ3UgQjoh4VHDGaJpfc=;
        b=o09f0XC/Wj/qFydke4gHT1ha4ABWvznxFgCZOq3bsOIyKskgfjAPxoOun0aMJVjPb0
         afeh5eiqXmw6aq3108IgAjj/PrQ7GeW3M/H2wJlXGAtrb1h/s9WZuzdE/y4jIq5eTOk2
         0hm9CxFgzLDm5q4u/nKO7REOsPmzL0hAlXSS9f0oW3kPMTak7KS+1AOw+C4fT3VCH0zO
         Ddv9w0d5ln2FLqFcGjytLsXEKTYvuF7i1QHWqGmPuaBIrZ2SEL2SUpucjnahthzQUpjg
         VDVMlRKGedB7yRlYdKpXT7Brv7jmdqIpSk8SmehriNK329QUaDsksccCIU7ONe7DkYzr
         BCyg==
X-Gm-Message-State: AO0yUKV8a6zY2IpN9ytViDO7wWJjPSETXMbepaimAkDgr04pXl6/cgsF
        2e34jJ/Hxo8RfVEcwK0MhY6Ktg==
X-Google-Smtp-Source: AK7set+odJ6gjkKr0lacZ1uUOnenCIQGBmh8pAGM48ffyg1NfSPc1f6nZV1Sm8rmtIZVFZQw+NiK1w==
X-Received: by 2002:a05:6214:2aaf:b0:5c7:31af:2ea2 with SMTP id js15-20020a0562142aaf00b005c731af2ea2mr15284360qvb.12.1679598484452;
        Thu, 23 Mar 2023 12:08:04 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id mn15-20020a0562145ecf00b005dd8b93458dsm74978qvb.37.2023.03.23.12.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:07:56 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:07:46 -0700 (PDT)
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
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate
 flag
In-Reply-To: <20230307052036.1520708-4-stevensd@google.com>
Message-ID: <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-4-stevensd@google.com>
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
> Make sure that collapse_file doesn't interfere with checking the
> uptodate flag in the page cache by only inserting hpage into the page
> cache after it has been updated and marked uptodate. This is achieved by
> simply not replacing present pages with hpage when iterating over the
> target range. The present pages are already locked, so replacing the
> with the locked hpage before the collapse is finalized is unnecessary.
> 
> This fixes a race where folio_seek_hole_data would mistake hpage for
> an fallocated but unwritten page. This race is visible to userspace via
> data temporarily disappearing from SEEK_DATA/SEEK_HOLE.
> 
> Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> Signed-off-by: David Stevens <stevensd@chromium.org>
> Acked-by: Peter Xu <peterx@redhat.com>

NAK to this patch, I'm afraid: it deadlocks.

What I know it to deadlock against, does not make the most persuasive
argument: cgroup v1 deprecated memcg moving, where mc_handle_file_pte()
uses filemap_get_incore_folio() while holding page table lock, and spins
around doing "goto repeat" in filemap_get_entry() while folio_try_get_rcu()
keeps failing because collapse_file()'s old page has been left in the
xarray with its refcount frozen to 0.  Meanwhile, collapse_file() is
spinning to get that page table lock, to unmap pte of a later page.

mincore()'s use of filemap_get_incore_folio() would be liable to hit
the same deadlock.  If we think for longer, we may find more examples.
But even when not actually deadlocking, it's wasting lots of CPU on
concurrent lookups (e.g. faults) spinning in filemap_get_entry().

I don't suppose it's entirely accurate, but think of keeping a folio
refcount frozen to 0 as like holding a spinlock (and this lock sadly out
of sight from lockdep).  The pre-existing code works because the old page
with refcount frozen to 0 is immediately replaced in the xarray by an
entry for the new hpage, so the old page is no longer discoverable:
and the new hpage is locked, not with a spinlock but the usual
folio/page lock, on which concurrent lookups will sleep.

Your discovery of the SEEK_DATA/SEEK_HOLE issue is important - thank
you - but I believe collapse_file() should be left as is, and the fix
made instead in mapping_seek_hole_data() or folio_seek_hole_data():
I believe that should not jump to assume that a !uptodate folio is a
hole (as was reasonable to assume for shmem, before collapsing to huge
got added), but should lock the folio if !uptodate, and check again
after getting the lock - if still !uptodate, it's a shmem hole, not
a transient race with collapse_file().

I was (pleased but) a little surprised when Matthew found in 5.12 that
shmem_seek_hole_data() could be generalized to filemap_seek_hole_data():
he will have a surer grasp of what's safe or unsafe to assume of
!uptodate in non-shmem folios.

On an earlier audit, for different reasons, I did also run across
lib/buildid.c build_id_parse() using find_get_page() without checking
PageUptodate() - looks as if it might do the wrong thing if it races
with khugepaged collapsing text to huge, and should probably have a
similar fix.

Hugh

> ---
>  mm/khugepaged.c | 50 ++++++++++++-------------------------------------
>  1 file changed, 12 insertions(+), 38 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 51ae399f2035..bdde0a02811b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1930,12 +1930,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  	} while (1);
>  
> -	/*
> -	 * At this point the hpage is locked and not up-to-date.
> -	 * It's safe to insert it into the page cache, because nobody would
> -	 * be able to map it or use it in another way until we unlock it.
> -	 */
> -
>  	xas_set(&xas, start);
>  	for (index = start; index < end; index++) {
>  		page = xas_next(&xas);
> @@ -2104,13 +2098,9 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  
>  		/*
> -		 * Add the page to the list to be able to undo the collapse if
> -		 * something go wrong.
> +		 * Accumulate the pages that are being collapsed.
>  		 */
>  		list_add_tail(&page->lru, &pagelist);
> -
> -		/* Finally, replace with the new page. */
> -		xas_store(&xas, hpage);
>  		continue;
>  out_unlock:
>  		unlock_page(page);
> @@ -2149,8 +2139,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		goto rollback;
>  
>  	/*
> -	 * Replacing old pages with new one has succeeded, now we
> -	 * attempt to copy the contents.
> +	 * The old pages are locked, so they won't change anymore.
>  	 */
>  	index = start;
>  	list_for_each_entry(page, &pagelist, lru) {
> @@ -2230,11 +2219,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		/* nr_none is always 0 for non-shmem. */
>  		__mod_lruvec_page_state(hpage, NR_SHMEM, nr_none);
>  	}
> -	/* Join all the small entries into a single multi-index entry. */
> -	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> -	xas_store(&xas, hpage);
> -	xas_unlock_irq(&xas);
>  
> +	/*
> +	 * Mark hpage as uptodate before inserting it into the page cache so
> +	 * that it isn't mistaken for an fallocated but unwritten page.
> +	 */
>  	folio = page_folio(hpage);
>  	folio_mark_uptodate(folio);
>  	folio_ref_add(folio, HPAGE_PMD_NR - 1);
> @@ -2243,6 +2232,11 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		folio_mark_dirty(folio);
>  	folio_add_lru(folio);
>  
> +	/* Join all the small entries into a single multi-index entry. */
> +	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
> +	xas_store(&xas, hpage);
> +	xas_unlock_irq(&xas);
> +
>  	/*
>  	 * Remove pte page tables, so we can re-fault the page as huge.
>  	 */
> @@ -2267,36 +2261,18 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  
>  rollback:
>  	/* Something went wrong: roll back page cache changes */
> -	xas_lock_irq(&xas);
>  	if (nr_none) {
>  		mapping->nrpages -= nr_none;
>  		shmem_uncharge(mapping->host, nr_none);
>  	}
>  
> -	xas_set(&xas, start);
> -	end = index;
> -	for (index = start; index < end; index++) {
> -		xas_next(&xas);
> -		page = list_first_entry_or_null(&pagelist,
> -				struct page, lru);
> -		if (!page || xas.xa_index < page->index) {
> -			nr_none--;
> -			continue;
> -		}
> -
> -		VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> -
> +	list_for_each_entry_safe(page, tmp, &pagelist, lru) {
>  		/* Unfreeze the page. */
>  		list_del(&page->lru);
>  		page_ref_unfreeze(page, 2);
> -		xas_store(&xas, page);
> -		xas_pause(&xas);
> -		xas_unlock_irq(&xas);
>  		unlock_page(page);
>  		putback_lru_page(page);
> -		xas_lock_irq(&xas);
>  	}
> -	VM_BUG_ON(nr_none);
>  	/*
>  	 * Undo the updates of filemap_nr_thps_inc for non-SHMEM file only.
>  	 * This undo is not needed unless failure is due to SCAN_COPY_MC.
> @@ -2304,8 +2280,6 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	if (!is_shmem && result == SCAN_COPY_MC)
>  		filemap_nr_thps_dec(mapping);
>  
> -	xas_unlock_irq(&xas);
> -
>  	hpage->mapping = NULL;
>  
>  	unlock_page(hpage);
> -- 
> 2.40.0.rc0.216.gc4246ad0f0-goog
