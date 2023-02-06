Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43468C833
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjBFVDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFVDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:03:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606C5BA0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675717370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lT/t97DdkIMgb9qhfnXTuR1mlXFAu5r6VUP5tQl8fLs=;
        b=eQ9AlBsCpPpiZ7zmdbcD57nWI7gKRDZfDzmIuy5VZXrK3JRBpGFn+Q+7gx/lCX0ADjaKAi
        HV41ZZwkZaSMGJS1TtED7FEs/SGoCh6SAM80ffgMlpZwv3/KBEsJAfYD8WYRVOStzAyJwl
        jAZ3o+A4BOAdH7/yvdhCljyS8z9ePG8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-gPs5jJFUMLasjT51BjqZnQ-1; Mon, 06 Feb 2023 16:02:47 -0500
X-MC-Unique: gPs5jJFUMLasjT51BjqZnQ-1
Received: by mail-qv1-f72.google.com with SMTP id jh2-20020a0562141fc200b004c74bbb0affso6568161qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 13:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT/t97DdkIMgb9qhfnXTuR1mlXFAu5r6VUP5tQl8fLs=;
        b=x75x1AQRMi8e4veRYovwH4dWo+XRUnuMP1QTAI+pKpivOj0uvOl4n65pZdZPPnCPjN
         4CS1kSIGVumpN8sLXUDBOkBftV4tkWRUYmhsoUds+bd09m92UeSnryA03DpWjlu2iPsD
         Gf5wGs4OheNIQjv7tYgOHJ5uyAr9NzjIJ9AWj4i/x0p30hgLebwn6dK0HGLG8cWAk08B
         DUFWnDKHviNw7fb4MWM6NqjgII14NFTjB1bLYZDejJ6Y6kLg/PsGMTSORkuD61a1RkKs
         Vaat8qZkD+a63ozk3tX2NxF/I49E0hO5HSEcEcuoe/0ckbIWmDYL8Cv2eshW7yKjP5IF
         fxJA==
X-Gm-Message-State: AO0yUKVI534nKuU0bBgb8H11FN/GyrLDVnqCS198/qk3Zd+K3JxyWmk9
        fDKJrByA1pX2Z79ipauXlnqLvJEhJRvo+smGab6cmjLpTmJdzszSAn8oShKi2N6iBqgX73zQ4Ua
        hcSE3byKNmVSnomfcwLjMGqts
X-Received: by 2002:ac8:4e8d:0:b0:3b8:5f47:aac2 with SMTP id 13-20020ac84e8d000000b003b85f47aac2mr1652538qtp.1.1675717364407;
        Mon, 06 Feb 2023 13:02:44 -0800 (PST)
X-Google-Smtp-Source: AK7set+XKPcRB961EMdtG7Ywry4tipCNZTGwJ0Vf/CYdZcb0JOglrmr1RrBGooj0ym/GazIEeN+1dA==
X-Received: by 2002:ac8:4e8d:0:b0:3b8:5f47:aac2 with SMTP id 13-20020ac84e8d000000b003b85f47aac2mr1652499qtp.1.1675717364042;
        Mon, 06 Feb 2023 13:02:44 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id o11-20020ac87c4b000000b003b9a426d626sm8044886qtv.22.2023.02.06.13.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:02:43 -0800 (PST)
Date:   Mon, 6 Feb 2023 16:02:42 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+Fq8lwsl7RXwlNS@x1n>
References: <20230206112856.1802547-1-stevensd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206112856.1802547-1-stevensd@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> Collapsing memory will result in any empty pages in the target range
> being filled by the new THP. If userspace has a userfaultfd registered
> with MODE_MISSING, for any page which it knows to be missing after
> registering the userfaultfd, it may expect a UFFD_EVENT_PAGEFAULT.
> Taking these two facts together, khugepaged needs to take care when
> collapsing pages in shmem to make sure it doesn't break the userfaultfd
> API.
> 
> This change first makes sure that the intermediate page cache state
> during collapse is not visible by moving when gaps are filled to after
> the page cache lock is acquired for the final time. This is necessary
> because the synchronization provided by locking hpage is insufficient
> for functions which operate on the page cache without actually locking
> individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> 
> This refactoring allows us to iterate over i_mmap to check for any VMAs
> with userfaultfds and then finalize the collapse if no such VMAs exist,
> all while holding the page cache lock. Since no mm locks are held, it is
> necessary to add smb_rmb/smb_wmb to ensure that userfaultfd updates to
> vm_flags are visible to khugepaged. However, no further locking of
> userfaultfd state is necessary. Although new userfaultfds can be
> registered concurrently with finalizing the collapse, any missing pages
> that are being replaced can no longer be observed by userspace, so there
> is no data race.
> 
> This fix is targeted at khugepaged, but the change also applies to
> MADV_COLLAPSE. The fact that the intermediate page cache state before
> the rollback of a failed collapse can no longer be observed is
> technically a userspace-visible change (via at least SEEK_DATA and
> SEEK_END), but it is exceedingly unlikely that anything relies on being
> able to observe that transient state.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  fs/userfaultfd.c |  2 ++
>  mm/khugepaged.c  | 67 ++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 59 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index cc694846617a..6ddfcff11920 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -114,6 +114,8 @@ static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
>  	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
>  
>  	vma->vm_flags = flags;
> +	/* Pairs with smp_rmb() in khugepaged's collapse_file() */
> +	smp_wmb();

Could you help to explain why this is needed?  What's the operation to
serialize against updating vm_flags?

>  	/*
>  	 * For shared mappings, we want to enable writenotify while
>  	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 79be13133322..97435c226b18 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -55,6 +55,7 @@ enum scan_result {
>  	SCAN_CGROUP_CHARGE_FAIL,
>  	SCAN_TRUNCATED,
>  	SCAN_PAGE_HAS_PRIVATE,
> +	SCAN_PAGE_FILLED,
>  };
>  
>  #define CREATE_TRACE_POINTS
> @@ -1725,8 +1726,8 @@ static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
>   *  - allocate and lock a new huge page;
>   *  - scan page cache replacing old pages with the new one
>   *    + swap/gup in pages if necessary;
> - *    + fill in gaps;
>   *    + keep old pages around in case rollback is required;
> + *  - finalize updates to the page cache;
>   *  - if replacing succeeds:
>   *    + copy data over;
>   *    + free old pages;
> @@ -1747,6 +1748,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
>  	int nr_none = 0, result = SCAN_SUCCEED;
>  	bool is_shmem = shmem_file(file);
> +	bool i_mmap_locked = false;
>  	int nr = 0;
>  
>  	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
> @@ -1780,8 +1782,14 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  
>  	/*
>  	 * At this point the hpage is locked and not up-to-date.
> -	 * It's safe to insert it into the page cache, because nobody would
> -	 * be able to map it or use it in another way until we unlock it.
> +	 *
> +	 * While iterating, we may drop the page cache lock multiple times. It
> +	 * is safe to replace pages in the page cache with hpage while doing so
> +	 * because nobody is able to map or otherwise access the content of
> +	 * hpage until we unlock it. However, we cannot insert hpage into empty
> +	 * indicies until we know we won't have to drop the page cache lock
> +	 * again, as doing so would let things which only check the presence
> +	 * of pages in the page cache see a state that may yet be rolled back.
>  	 */
>  
>  	xas_set(&xas, start);
> @@ -1802,13 +1810,12 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  						result = SCAN_TRUNCATED;
>  						goto xa_locked;
>  					}
> -					xas_set(&xas, index);
> +					xas_set(&xas, index + 1);

I failed to figure out why this index needs a shift here... It seems to me
it'll ignore the initial empty page cache, is that what the patch wanted?

>  				}
>  				if (!shmem_charge(mapping->host, 1)) {
>  					result = SCAN_FAIL;
>  					goto xa_locked;
>  				}
> -				xas_store(&xas, hpage);

[I raised a question in the other thread on whether it's legal to not
 populate page cache holes at all.  We can keep the discussion there]

>  				nr_none++;
>  				continue;
>  			}
> @@ -1967,6 +1974,46 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		put_page(page);
>  		goto xa_unlocked;
>  	}
> +
> +	if (nr_none) {
> +		struct vm_area_struct *vma;
> +		int nr_none_check = 0;
> +
> +		xas_unlock_irq(&xas);
> +		i_mmap_lock_read(mapping);
> +		i_mmap_locked = true;
> +		xas_lock_irq(&xas);
> +
> +		xas_set(&xas, start);
> +		for (index = start; index < end; index++) {
> +			if (!xas_next(&xas))
> +				nr_none_check++;
> +		}
> +
> +		if (nr_none != nr_none_check) {
> +			result = SCAN_PAGE_FILLED;
> +			goto xa_locked;
> +		}
> +
> +		/*
> +		 * If userspace observed a missing page in a VMA with an armed
> +		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for
> +		 * that page, so we need to roll back to avoid suppressing such
> +		 * an event. Any userfaultfds armed after this point will not be
> +		 * able to observe any missing pages, since the page cache is
> +		 * locked until after the collapse is completed.
> +		 *
> +		 * Pairs with smp_wmb() in userfaultfd_set_vm_flags().
> +		 */
> +		smp_rmb();
> +		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> +			if (userfaultfd_missing(vma)) {
> +				result = SCAN_EXCEED_NONE_PTE;
> +				goto xa_locked;
> +			}
> +		}
> +	}

Thanks for writting the patch, but I am still confused why this can avoid
race conditions of uffd missing mode.

I assume UFFDIO_REGISTER is defined as: after UFFDIO_REGISTER ioctl
succeeded on a specific shmem VMA, any page faults due to missing page
cache on this vma should generate a page fault.  If not, it's violating the
userfaultfd semantics.

Here, I don't see what stops a new vma from registering MISSING mode right
away in parallel of collapsing.

When registration completes, it means we should report uffd missing
messages on the holes that collapse_file() scanned previously.  However
they'll be filled very possibly later with the thp which means the messages
can be lost.  Then the issue can still happen, while this patch only makes
it very unlikely to happen, or am I wrong?

Thanks,

> +
>  	nr = thp_nr_pages(hpage);
>  
>  	if (is_shmem)
> @@ -2000,6 +2047,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  	xas_store(&xas, hpage);
>  xa_locked:
>  	xas_unlock_irq(&xas);
> +	if (i_mmap_locked)
> +		i_mmap_unlock_read(mapping);
>  xa_unlocked:
>  
>  	/*
> @@ -2065,15 +2114,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
>  		}
>  
>  		xas_set(&xas, start);
> -		xas_for_each(&xas, page, end - 1) {
> +		end = index;
> +		for (index = start; index < end; index++) {
> +			xas_next(&xas);
>  			page = list_first_entry_or_null(&pagelist,
>  					struct page, lru);
>  			if (!page || xas.xa_index < page->index) {
> -				if (!nr_none)
> -					break;
>  				nr_none--;
> -				/* Put holes back where they were */
> -				xas_store(&xas, NULL);
>  				continue;
>  			}
>  
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 

-- 
Peter Xu

