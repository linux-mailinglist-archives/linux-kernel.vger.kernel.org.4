Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF9B65FAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjAFEUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAFETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:19:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3788A19283
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672978782; x=1704514782;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=nHf+G1ozFI6ijzSIKDhRcT2sVNcCI9OauZ9QNYyp79Y=;
  b=eLFwXtTJxNUefr8CteZxvg5g59LOv1gfgOuZ9ZyvC1Rd+6qIEnQe4wWz
   5JxtQNrNy9wAqU6zLZYBw3o3TOw7IadKJGh9H0vaZc/ZjZg41CzBq4gl2
   enSNgsC9xmVZjgDu58wmsu8zjaXoYOhAxNi1IbBR9XLB1UuBD94nKcrK1
   XO+cQwURyk2x/jTnFODE/yD24C6CDMUdwXTi6XyYpbms7ZVwEVWnhLNgM
   ehmy0s6ThJQvQVYbxMjoJSaH4CdZIpDwfVyt9XgSqU2EHuSL+n/2DBDGn
   4fGF1DTOvInCXUuXvTCp0jG7qyBD2zwCsYwzkgPdwP/xS49Y/aKaMxy4q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="305920228"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="305920228"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 20:19:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="984549383"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="984549383"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 20:19:38 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Bharata B Rao" <bharata@amd.com>, haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH 7/8] migrate_pages: share more code between _unmap and
 _move
References: <20221227002859.27740-1-ying.huang@intel.com>
        <20221227002859.27740-8-ying.huang@intel.com>
        <87pmbur99h.fsf@nvidia.com>
Date:   Fri, 06 Jan 2023 12:15:24 +0800
In-Reply-To: <87pmbur99h.fsf@nvidia.com> (Alistair Popple's message of "Wed,
        04 Jan 2023 18:12:09 +1100")
Message-ID: <87cz7s8fj7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> This is a code cleanup patch to reduce the duplicated code between the
>> _unmap and _move stages of migrate_pages().  No functionality change
>> is expected.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Bharata B Rao <bharata@amd.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: haoxin <xhao@linux.alibaba.com>
>> ---
>>  mm/migrate.c | 208 ++++++++++++++++++++-------------------------------
>>  1 file changed, 82 insertions(+), 126 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 70b987391296..70a40b8fee1f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1030,21 +1030,26 @@ static void __migrate_folio_extract(struct folio *dst,
>>  static void migrate_folio_undo_src(struct folio *src,
>>  				   int page_was_mapped,
>>  				   struct anon_vma *anon_vma,
>> +				   bool locked,
>>  				   struct list_head *ret)
>>  {
>>  	if (page_was_mapped)
>>  		remove_migration_ptes(src, src, false);
>>  	if (anon_vma)
>>  		put_anon_vma(anon_vma);
>> -	folio_unlock(src);
>> -	list_move_tail(&src->lru, ret);
>> +	if (locked)
>> +		folio_unlock(src);
>> +	if (ret)
>> +		list_move_tail(&src->lru, ret);
>>  }
>>  
>>  static void migrate_folio_undo_dst(struct folio *dst,
>> +				   bool locked,
>>  				   free_page_t put_new_page,
>>  				   unsigned long private)
>>  {
>> -	folio_unlock(dst);
>> +	if (locked)
>> +		folio_unlock(dst);
>>  	if (put_new_page)
>>  		put_new_page(&dst->page, private);
>>  	else
>> @@ -1068,14 +1073,44 @@ static void migrate_folio_done(struct folio *src,
>>  		folio_put(src);
>>  }
>>  
>> -static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>> -				 int force, bool force_lock, enum migrate_mode mode)
>> +/* Obtain the lock on page, remove all ptes. */
>> +static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
>> +			       unsigned long private, struct folio *src,
>> +			       struct folio **dstp, int force, bool force_lock,
>> +			       enum migrate_mode mode, enum migrate_reason reason,
>> +			       struct list_head *ret)
>
> Overall I think this should be refactored into some smaller, simpler
> functions as the error handling and the giant switch statement in
> migrate_pages_batch() is making my head hurt :-)

Yes.  Well-defined smaller functions are good.

From another point of view, code cleanup isn't the main purpose of the
patchset.  We can try to clean up the code after this patchset too.  And
we may have some new idea at that time.

>>  {
>> -	int rc = -EAGAIN;
>> +	struct folio *dst;
>> +	int rc = MIGRATEPAGE_UNMAP;
>> +	struct page *newpage = NULL;
>>  	int page_was_mapped = 0;
>>  	struct anon_vma *anon_vma = NULL;
>>  	bool is_lru = !__PageMovable(&src->page);
>> +	bool locked = false;
>> +	bool dst_locked = false;
>> +
>> +	if (!thp_migration_supported() && folio_test_transhuge(src))
>> +		return -ENOSYS;
>
> This would be easier to follow if it was just moved to the caller and
> the -ENOSYS switch case removed.

Good idea!  I tried this, it can reduce the line number in
migrate_pages_batch().

>> +	if (folio_ref_count(src) == 1) {
>> +		/* Folio was freed from under us. So we are done. */
>> +		folio_clear_active(src);
>> +		folio_clear_unevictable(src);
>> +		/* free_pages_prepare() will clear PG_isolated. */
>> +		list_del(&src->lru);
>> +		migrate_folio_done(src, reason);
>> +		return MIGRATEPAGE_SUCCESS;
>> +	}
>
> This is the only case that returns MIGRATEPAGE_SUCCESS so would also be
> clearer if moved to the caller eliminating another switch case.

This can reduce the line number of migrate_folio_unmap(), but it will
increase the line number of migrate_pages_batch(), which is a long
function already.  I am hesitated to make it even longer.

>> +
>> +	newpage = get_new_page(&src->page, private);
>> +	if (!newpage)
>> +		return -ENOMEM;
>> +	dst = page_folio(newpage);
>> +	*dstp = dst;
>> +
>> +	dst->private = NULL;
>
> This could be moved until after the folio_test_writeback(), which might
> make the split I suggest below easier.
>
>>  
>> +	rc = -EAGAIN;
>
> We can just initialise rc to -EAGAIN.

OK.

>>  	if (!folio_trylock(src)) {
>>  		if (!force || mode == MIGRATE_ASYNC)
>>  			goto out;
>> @@ -1103,6 +1138,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  
>>  		folio_lock(src);
>>  	}
>> +	locked = true;
>
> A seperate helper for locking the folio would be better IMHO.
>
>>  
>>  	if (folio_test_writeback(src)) {
>>  		/*
>> @@ -1117,10 +1153,10 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  			break;
>>  		default:
>>  			rc = -EBUSY;
>> -			goto out_unlock;
>> +			goto out;
>>  		}
>>  		if (!force)
>> -			goto out_unlock;
>> +			goto out;
>>  		folio_wait_writeback(src);
>>  	}
>
> This is the only path that return -EBUSY, so could be integrated into
> the helper suggested above for locking the folio.
>   
>> @@ -1150,7 +1186,8 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  	 * This is much like races on refcount of oldpage: just don't BUG().
>>  	 */
>>  	if (unlikely(!folio_trylock(dst)))
>> -		goto out_unlock;
>> +		goto out;
>> +	dst_locked = true;
>
> So how about splitting migrate_folio_unmap() into two functions:
>
> /*
>  * Prepare a folio for migration by locking the source, ensuring
>  * writeback is complete and allocating and locking a new destination
>  * page.
>  */
> migrate_folio_prepare(new_page_t get_new_page, free_page_t put_new_page,
>                       unsigned long private, struct folio *src,
> 	              struct folio **dstp, int force, bool force_lock)
>
> migrate_folio_unmap(struct folio *src, struct folio *dst,
>                     enum migrate_mode mode, enum migrate_reason reason)
>
> Obviously we still have the various failure scenarios to deal with, but
> I think it would be more readable if these were limited to undoing the
> migrate_folio_prepare() step in the caller. I think the list
> manipulation would also be more obvious if left to the caller.

migrate_folio_prepare() doesn't looks like a good abstraction for me.
And I am hesitated to increase the line number of migrate_pages_batch()
further.

>>  	if (unlikely(!is_lru)) {
>>  		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> @@ -1172,7 +1209,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  	if (!src->mapping) {
>>  		if (folio_test_private(src)) {
>>  			try_to_free_buffers(src);
>> -			goto out_unlock_both;
>> +			goto out;
>>  		}
>>  	} else if (folio_mapped(src)) {
>>  		/* Establish migration ptes */
>> @@ -1187,75 +1224,27 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  		return MIGRATEPAGE_UNMAP;
>
> I reaslise this is pre-existing but the mixing of setting rc or
> returning codes directly is a bit hard to follow.

In fact this is the success case, the below is error processing code.
Setting rc and gotoing is for failure case.  I can change all failure
case to set rc and goto.

Best Regards,
Huang, Ying

>>  	}
>>  
>> -
>> -	if (page_was_mapped)
>> -		remove_migration_ptes(src, src, false);
>> -
>> -out_unlock_both:
>> -	folio_unlock(dst);
>> -out_unlock:
>> -	/* Drop an anon_vma reference if we took one */
>> -	if (anon_vma)
>> -		put_anon_vma(anon_vma);
>> -	folio_unlock(src);
>>  out:
>> -
>> -	return rc;
>> -}
>> -
>> -/* Obtain the lock on page, remove all ptes. */
>> -static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
>> -			       unsigned long private, struct folio *src,
>> -			       struct folio **dstp, int force, bool force_lock,
>> -			       enum migrate_mode mode, enum migrate_reason reason,
>> -			       struct list_head *ret)
>> -{
>> -	struct folio *dst;
>> -	int rc = MIGRATEPAGE_UNMAP;
>> -	struct page *newpage = NULL;
>> -
>> -	if (!thp_migration_supported() && folio_test_transhuge(src))
>> -		return -ENOSYS;
>> -
>> -	if (folio_ref_count(src) == 1) {
>> -		/* Folio was freed from under us. So we are done. */
>> -		folio_clear_active(src);
>> -		folio_clear_unevictable(src);
>> -		/* free_pages_prepare() will clear PG_isolated. */
>> -		list_del(&src->lru);
>> -		migrate_folio_done(src, reason);
>> -		return MIGRATEPAGE_SUCCESS;
>> -	}
>> -
>> -	newpage = get_new_page(&src->page, private);
>> -	if (!newpage)
>> -		return -ENOMEM;
>> -	dst = page_folio(newpage);
>> -	*dstp = dst;
>> -
>> -	dst->private = NULL;
>> -	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
>> -	if (rc == MIGRATEPAGE_UNMAP)
>> -		return rc;
>> -
>>  	/*
>>  	 * A page that has not been migrated will have kept its
>>  	 * references and be restored.
>>  	 */
>>  	/* restore the folio to right list. */
>> -	if (rc != -EAGAIN && rc != -EDEADLOCK)
>> -		list_move_tail(&src->lru, ret);
>> +	if (rc == -EAGAIN || rc == -EDEADLOCK)
>> +		ret = NULL;
>>  
>> -	if (put_new_page)
>> -		put_new_page(&dst->page, private);
>> -	else
>> -		folio_put(dst);
>> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, locked, ret);
>> +	if (dst)
>> +		migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
>>  
>>  	return rc;
>>  }
>>  
>> -static int __migrate_folio_move(struct folio *src, struct folio *dst,
>> -				enum migrate_mode mode)
>> +/* Migrate the folio to the newly allocated folio in dst. */
>> +static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>> +			      struct folio *src, struct folio *dst,
>> +			      enum migrate_mode mode, enum migrate_reason reason,
>> +			      struct list_head *ret)
>>  {
>>  	int rc;
>>  	int page_was_mapped = 0;
>> @@ -1264,9 +1253,10 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>  
>>  	rc = move_to_new_folio(dst, src, mode);
>> +	if (rc)
>> +		goto out;
>>  
>> -	if (rc != -EAGAIN)
>> -		list_del(&dst->lru);
>> +	list_del(&dst->lru);
>>  	/*
>>  	 * When successful, push dst to LRU immediately: so that if it
>>  	 * turns out to be an mlocked page, remove_migration_ptes() will
>> @@ -1276,74 +1266,40 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	 * unsuccessful, and other cases when a page has been temporarily
>>  	 * isolated from the unevictable LRU: but this case is the easiest.
>>  	 */
>> -	if (rc == MIGRATEPAGE_SUCCESS) {
>> -		folio_add_lru(dst);
>> -		if (page_was_mapped)
>> -			lru_add_drain();
>> -	}
>> -
>> -	if (rc == -EAGAIN) {
>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> -		return rc;
>> -	}
>> -
>> +	folio_add_lru(dst);
>>  	if (page_was_mapped)
>> -		remove_migration_ptes(src,
>> -			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
>> +		lru_add_drain();
>>  
>> +	if (page_was_mapped)
>> +		remove_migration_ptes(src, dst, false);
>>  	folio_unlock(dst);
>> -	/* Drop an anon_vma reference if we took one */
>> -	if (anon_vma)
>> -		put_anon_vma(anon_vma);
>> -	folio_unlock(src);
>> +	set_page_owner_migrate_reason(&dst->page, reason);
>>  	/*
>>  	 * If migration is successful, decrease refcount of dst,
>>  	 * which will not free the page because new page owner increased
>>  	 * refcounter.
>>  	 */
>> -	if (rc == MIGRATEPAGE_SUCCESS)
>> -		folio_put(dst);
>> -
>> -	return rc;
>> -}
>> -
>> -/* Migrate the folio to the newly allocated folio in dst. */
>> -static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>> -			      struct folio *src, struct folio *dst,
>> -			      enum migrate_mode mode, enum migrate_reason reason,
>> -			      struct list_head *ret)
>> -{
>> -	int rc;
>> -
>> -	rc = __migrate_folio_move(src, dst, mode);
>> -	if (rc == MIGRATEPAGE_SUCCESS)
>> -		set_page_owner_migrate_reason(&dst->page, reason);
>> -
>> -	if (rc != -EAGAIN) {
>> -		/*
>> -		 * A folio that has been migrated has all references
>> -		 * removed and will be freed. A folio that has not been
>> -		 * migrated will have kept its references and be restored.
>> -		 */
>> -		list_del(&src->lru);
>> -	}
>> +	folio_put(dst);
>>  
>>  	/*
>> -	 * If migration is successful, releases reference grabbed during
>> -	 * isolation. Otherwise, restore the folio to right list unless
>> -	 * we want to retry.
>> +	 * A page that has been migrated has all references removed
>> +	 * and will be freed.
>>  	 */
>> -	if (rc == MIGRATEPAGE_SUCCESS) {
>> -		migrate_folio_done(src, reason);
>> -	} else if (rc != -EAGAIN) {
>> -		list_add_tail(&src->lru, ret);
>> +	list_del(&src->lru);
>> +	migrate_folio_undo_src(src, 0, anon_vma, true, NULL);
>> +	migrate_folio_done(src, reason);
>>  
>> -		if (put_new_page)
>> -			put_new_page(&dst->page, private);
>> -		else
>> -			folio_put(dst);
>> +	return rc;
>> +out:
>> +	if (rc == -EAGAIN) {
>> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		return rc;
>>  	}
>>  
>> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
>> +	list_del(&dst->lru);
>> +	migrate_folio_undo_dst(dst, true, put_new_page, private);
>> +
>>  	return rc;
>>  }
>>  
>> @@ -1849,9 +1805,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  
>>  		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>>  		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>> -				       ret_folios);
>> +				       true, ret_folios);
>>  		list_del(&dst->lru);
>> -		migrate_folio_undo_dst(dst, put_new_page, private);
>> +		migrate_folio_undo_dst(dst, true, put_new_page, private);
>>  		dst = dst2;
>>  		dst2 = list_next_entry(dst, lru);
>>  	}
