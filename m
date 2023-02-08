Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225C468EE68
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBHMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBHMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:02:57 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DAB4614D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675857776; x=1707393776;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=IFmlH0YoCQ7yEt8hGVGvzaLAv3SmHwRR0zL6VgMa4Zo=;
  b=BFqghm3AhK2H0KMVSFXbBRGBY3ODGQZ5BplGPaWdNjmAMKOLBTccspKL
   4IbyyBEe0uJYWQl8Eoi6P4aRFBFo8WHbriBfE/LVf1PwpBS55hKvVZ8tH
   2RHAyOtia5zRlD12DXSJMzxGTSdPOd89qmXMaClss1x84F5JWZ59sFv2C
   0je5d4eZBhClKOmxebodv91bqylgqLRtcHqY+m8arKwx2st0+XditO3hw
   3ygOdRPaanUQNxIxqxt4PYzuaVuKK0j1k7Hq1XC5dmeQz6qKMjF1g40ax
   //LrY1aOCc1JUiEOIOzL91sjzKICLNRUuergaHOdzCoKljtM33rcvINCm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357170483"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357170483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 04:02:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="617194406"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="617194406"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 04:02:51 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Matthew Wilcox" <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH -v4 7/9] migrate_pages: share more code between _unmap
 and _move
References: <20230206063313.635011-1-ying.huang@intel.com>
        <20230206063313.635011-8-ying.huang@intel.com>
        <C4525F0D-C4DB-4584-A290-DFFC8F1BAE3C@nvidia.com>
Date:   Wed, 08 Feb 2023 20:02:02 +0800
In-Reply-To: <C4525F0D-C4DB-4584-A290-DFFC8F1BAE3C@nvidia.com> (Zi Yan's
        message of "Tue, 07 Feb 2023 09:50:56 -0500")
Message-ID: <87zg9ofjr9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 6 Feb 2023, at 1:33, Huang Ying wrote:
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
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> ---
>>  mm/migrate.c | 203 ++++++++++++++++++++-------------------------------
>>  1 file changed, 81 insertions(+), 122 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 23eb01cfae4c..9378fa2ad4a5 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1037,6 +1037,7 @@ static void __migrate_folio_extract(struct folio *dst,
>>  static void migrate_folio_undo_src(struct folio *src,
>>  				   int page_was_mapped,
>>  				   struct anon_vma *anon_vma,
>> +				   bool locked,
>>  				   struct list_head *ret)
>>  {
>>  	if (page_was_mapped)
>> @@ -1044,16 +1045,20 @@ static void migrate_folio_undo_src(struct folio *src,
>>  	/* Drop an anon_vma reference if we took one */
>>  	if (anon_vma)
>>  		put_anon_vma(anon_vma);
>> -	folio_unlock(src);
>> -	list_move_tail(&src->lru, ret);
>> +	if (locked)
>> +		folio_unlock(src);
>
> Having a comment would be better.
> /* A page that has not been migrated, move it to a list for later restoration */

Emm... the page state has been restored in the previous operations of
the function.  This is the last step and the page will be moved to
"return" list, then the caller of migrate_pages() will call
putback_movable_pages().

We have some comments for the function (migrate_folio_undo_src()) as
follows,

/* Restore the source folio to the original state upon failure */

>> +	if (ret)
>> +		list_move_tail(&src->lru, ret);
>>  }
>>
>>  /* Restore the destination folio to the original state upon failure */
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
>> @@ -1078,13 +1083,42 @@ static void migrate_folio_done(struct folio *src,
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
>>  {
>> +	struct folio *dst;
>>  	int rc = -EAGAIN;
>> +	struct page *newpage = NULL;
>>  	int page_was_mapped = 0;
>>  	struct anon_vma *anon_vma = NULL;
>>  	bool is_lru = !__PageMovable(&src->page);
>> +	bool locked = false;
>> +	bool dst_locked = false;
>> +
>> +	if (!thp_migration_supported() && folio_test_transhuge(src))
>> +		return -ENOSYS;
>> +
>> +	if (folio_ref_count(src) == 1) {
>> +		/* Folio was freed from under us. So we are done. */
>> +		folio_clear_active(src);
>> +		folio_clear_unevictable(src);
>> +		/* free_pages_prepare() will clear PG_isolated. */
>> +		list_del(&src->lru);
>> +		migrate_folio_done(src, reason);
>> +		return MIGRATEPAGE_SUCCESS;
>> +	}
>> +
>> +	newpage = get_new_page(&src->page, private);
>> +	if (!newpage)
>> +		return -ENOMEM;
>> +	dst = page_folio(newpage);
>> +	*dstp = dst;
>> +
>> +	dst->private = NULL;
>>
>>  	if (!folio_trylock(src)) {
>>  		if (!force || mode == MIGRATE_ASYNC)
>> @@ -1119,6 +1153,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>
>>  		folio_lock(src);
>>  	}
>> +	locked = true;
>>
>>  	if (folio_test_writeback(src)) {
>>  		/*
>> @@ -1133,10 +1168,10 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
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
>>
>> @@ -1166,7 +1201,8 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  	 * This is much like races on refcount of oldpage: just don't BUG().
>>  	 */
>>  	if (unlikely(!folio_trylock(dst)))
>> -		goto out_unlock;
>> +		goto out;
>> +	dst_locked = true;
>>
>>  	if (unlikely(!is_lru)) {
>>  		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> @@ -1188,7 +1224,7 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  	if (!src->mapping) {
>>  		if (folio_test_private(src)) {
>>  			try_to_free_buffers(src);
>> -			goto out_unlock_both;
>> +			goto out;
>>  		}
>>  	} else if (folio_mapped(src)) {
>>  		/* Establish migration ptes */
>> @@ -1203,74 +1239,26 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  		return MIGRATEPAGE_UNMAP;
>>  	}
>>
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
>
> This comment is stale. Probably should be
> /* Keep the folio and we will try it again later */

Good catch!  Will revise this in the next version.

Best Regards,
Huang, Ying

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
>> +	migrate_folio_undo_dst(dst, dst_locked, put_new_page, private);
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
>> @@ -1283,12 +1271,8 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	list_del(&dst->lru);
>>
>>  	rc = move_to_new_folio(dst, src, mode);
>> -
>> -	if (rc == -EAGAIN) {
>> -		list_add(&dst->lru, prev);
>> -		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> -		return rc;
>> -	}
>> +	if (rc)
>> +		goto out;
>>
>>  	if (unlikely(!is_lru))
>>  		goto out_unlock_both;
>> @@ -1302,70 +1286,45 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	 * unsuccessful, and other cases when a page has been temporarily
>>  	 * isolated from the unevictable LRU: but this case is the easiest.
>>  	 */
>> -	if (rc == MIGRATEPAGE_SUCCESS) {
>> -		folio_add_lru(dst);
>> -		if (page_was_mapped)
>> -			lru_add_drain();
>> -	}
>> +	folio_add_lru(dst);
>> +	if (page_was_mapped)
>> +		lru_add_drain();
>>
>>  	if (page_was_mapped)
>> -		remove_migration_ptes(src,
>> -			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
>> +		remove_migration_ptes(src, dst, false);
>>
>>  out_unlock_both:
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
>> +	/* Drop an anon_vma reference if we took one */
>> +	if (anon_vma)
>> +		put_anon_vma(anon_vma);
>> +	folio_unlock(src);
>> +	migrate_folio_done(src, reason);
>>
>> -		if (put_new_page)
>> -			put_new_page(&dst->page, private);
>> -		else
>> -			folio_put(dst);
>> +	return rc;
>> +out:
>> +	if (rc == -EAGAIN) {
>> +		list_add(&dst->lru, prev);
>> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		return rc;
>>  	}
>>
>> +	migrate_folio_undo_src(src, page_was_mapped, anon_vma, true, ret);
>> +	migrate_folio_undo_dst(dst, true, put_new_page, private);
>> +
>>  	return rc;
>>  }
>>
>> @@ -1897,9 +1856,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
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
>> -- 
>> 2.35.1
>
> Everything else looks good to me, just need to fix the two comments above.
> Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> --
> Best Regards,
> Yan, Zi
