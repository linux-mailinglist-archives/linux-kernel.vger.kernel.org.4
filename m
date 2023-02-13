Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5546693E86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBMG4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:56:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D81D30EB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676271397; x=1707807397;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=8eAeqp37C62ToQXgFGOn3/lZYemJITHNJwYBmtqQUM8=;
  b=eYu1QA0xLjpz/VKxssU3U5aBt2w49MkvDldyDXj/g1wVf5Gcy38St6qU
   oNXzg77u1zpAYe+nqxImWEGL5CS4LBo3SiyFD2hvX6Y+kUVhnS4HFzmlJ
   /Ig192RNjNlqvWYES9wAZtBibUGQopW4Rd/sZY5yQ4Zr2bR7yaXC9fp6X
   0D+GbyF688zvA561bw/esoKlQAVr8X27Ee/A2AeehlMNhliQfQvtnnkaz
   mUwj4yRynw1sfC5oq1EnuyH7q1fvRfPD8kTSM0gLcxB+KnUKfzUX/VNH6
   cLdIRtcDabCpUSwnlMCZMoVB13OmM9H/HREejj/4YqO3qfG4DEtK+GVLL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="328531720"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="328531720"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 22:56:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="914208654"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="914208654"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 22:56:33 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Oscar Salvador" <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        "Bharata B Rao" <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH -v4 5/9] migrate_pages: batch _unmap and _move
References: <20230206063313.635011-1-ying.huang@intel.com>
        <20230206063313.635011-6-ying.huang@intel.com>
        <6324EC7A-5D44-49EB-82A8-89B0114FC5E6@nvidia.com>
Date:   Mon, 13 Feb 2023 14:55:45 +0800
In-Reply-To: <6324EC7A-5D44-49EB-82A8-89B0114FC5E6@nvidia.com> (Zi Yan's
        message of "Mon, 06 Feb 2023 11:10:24 -0500")
Message-ID: <875yc69hqm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zi Yan <ziy@nvidia.com> writes:

> On 6 Feb 2023, at 1:33, Huang Ying wrote:
>
>> In this patch the _unmap and _move stage of the folio migration is
>> batched.  That for, previously, it is,
>>
>>   for each folio
>>     _unmap()
>>     _move()
>>
>> Now, it is,
>>
>>   for each folio
>>     _unmap()
>>   for each folio
>>     _move()
>>
>> Based on this, we can batch the TLB flushing and use some hardware
>> accelerator to copy folios between batched _unmap and batched _move
>> stages.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
>> ---
>>  mm/migrate.c | 208 +++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 184 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 0428449149f4..fa7212330cb6 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1033,6 +1033,33 @@ static void __migrate_folio_extract(struct folio *dst,
>>  	dst->private = NULL;
>>  }
>>
>> +/* Restore the source folio to the original state upon failure */
>> +static void migrate_folio_undo_src(struct folio *src,
>> +				   int page_was_mapped,
>> +				   struct anon_vma *anon_vma,
>> +				   struct list_head *ret)
>> +{
>> +	if (page_was_mapped)
>> +		remove_migration_ptes(src, src, false);
>> +	/* Drop an anon_vma reference if we took one */
>> +	if (anon_vma)
>> +		put_anon_vma(anon_vma);
>> +	folio_unlock(src);
>> +	list_move_tail(&src->lru, ret);
>> +}
>> +
>> +/* Restore the destination folio to the original state upon failure */
>> +static void migrate_folio_undo_dst(struct folio *dst,
>> +				   free_page_t put_new_page,
>> +				   unsigned long private)
>> +{
>> +	folio_unlock(dst);
>> +	if (put_new_page)
>> +		put_new_page(&dst->page, private);
>> +	else
>> +		folio_put(dst);
>> +}
>> +
>>  /* Cleanup src folio upon migration success */
>>  static void migrate_folio_done(struct folio *src,
>>  			       enum migrate_reason reason)
>> @@ -1052,7 +1079,7 @@ static void migrate_folio_done(struct folio *src,
>>  }
>>
>>  static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>> -				int force, enum migrate_mode mode)
>> +				 int force, bool force_lock, enum migrate_mode mode)
>>  {
>>  	int rc = -EAGAIN;
>>  	int page_was_mapped = 0;
>> @@ -1079,6 +1106,17 @@ static int __migrate_folio_unmap(struct folio *src, struct folio *dst,
>>  		if (current->flags & PF_MEMALLOC)
>>  			goto out;
>>
>> +		/*
>> +		 * We have locked some folios, to avoid deadlock, we cannot
>> +		 * lock the folio synchronously.  Go out to process (and
>> +		 * unlock) all the locked folios.  Then we can lock the folio
>> +		 * synchronously.
>> +		 */
> The comment alone is quite confusing and the variable might be better
> renamed to avoid_force_lock, since there is a force variable to force
> lock folio already. And the variable intends to discourage force lock
> on a folio to avoid potential deadlock.
>
> How about? Since "lock synchronously" might not be as straightforward
> as wait to lock.
>
> /*
>  * We have locked some folios and are going to wait to lock this folio.
>  * To avoid a potential deadlock, let's bail out and not do that. The
>  * locked folios will be moved and unlocked, then we can wait to lock
>  * this folio
>  */
>
>> +		if (!force_lock) {
>> +			rc = -EDEADLOCK;
>> +			goto out;
>> +		}
>> +
>>  		folio_lock(src);
>>  	}
>>
>> @@ -1187,10 +1225,20 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  	int page_was_mapped = 0;
>>  	struct anon_vma *anon_vma = NULL;
>>  	bool is_lru = !__PageMovable(&src->page);
>> +	struct list_head *prev;
>>
>>  	__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>> +	prev = dst->lru.prev;
>> +	list_del(&dst->lru);
>>
>>  	rc = move_to_new_folio(dst, src, mode);
>> +
>> +	if (rc == -EAGAIN) {
>> +		list_add(&dst->lru, prev);
>> +		__migrate_folio_record(dst, page_was_mapped, anon_vma);
>> +		return rc;
>> +	}
>> +
>>  	if (unlikely(!is_lru))
>>  		goto out_unlock_both;
>>
>> @@ -1233,7 +1281,7 @@ static int __migrate_folio_move(struct folio *src, struct folio *dst,
>>  /* Obtain the lock on page, remove all ptes. */
>>  static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page,
>>  			       unsigned long private, struct folio *src,
>> -			       struct folio **dstp, int force,
>> +			       struct folio **dstp, int force, bool force_lock,
>>  			       enum migrate_mode mode, enum migrate_reason reason,
>>  			       struct list_head *ret)
>>  {
>> @@ -1261,7 +1309,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>>  	*dstp = dst;
>>
>>  	dst->private = NULL;
>> -	rc = __migrate_folio_unmap(src, dst, force, mode);
>> +	rc = __migrate_folio_unmap(src, dst, force, force_lock, mode);
>>  	if (rc == MIGRATEPAGE_UNMAP)
>>  		return rc;
>>
>> @@ -1270,7 +1318,7 @@ static int migrate_folio_unmap(new_page_t get_new_page, free_page_t put_new_page
>>  	 * references and be restored.
>>  	 */
>>  	/* restore the folio to right list. */
>> -	if (rc != -EAGAIN)
>> +	if (rc != -EAGAIN && rc != -EDEADLOCK)
>>  		list_move_tail(&src->lru, ret);
>>
>>  	if (put_new_page)
>> @@ -1309,9 +1357,8 @@ static int migrate_folio_move(free_page_t put_new_page, unsigned long private,
>>  	 */
>>  	if (rc == MIGRATEPAGE_SUCCESS) {
>>  		migrate_folio_done(src, reason);
>> -	} else {
>> -		if (rc != -EAGAIN)
>> -			list_add_tail(&src->lru, ret);
>> +	} else if (rc != -EAGAIN) {
>> +		list_add_tail(&src->lru, ret);
>>
>>  		if (put_new_page)
>>  			put_new_page(&dst->page, private);
>> @@ -1591,7 +1638,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  		enum migrate_mode mode, int reason, struct list_head *ret_folios,
>>  		struct migrate_pages_stats *stats)
>
> Like I said in my last comment to this patch, migrate_pages_batch() function
> deserves a detailed comment about its working flow including the error handling.
> Now you only put some in the git log, which is hard to access after several code
> changes later.
>
> How about?
>
> /*
>  * migrate_pages_batch() first unmaps pages in the from as many as possible,
>  * then migrates the unmapped pages. During unmap process, different situations
>  * are handled differently:
>  * 1. ENOSYS, unsupported large folio migration: move to ret_folios list
>  * 2. ENOMEM, lower memory at the destination: migrate existing unmapped folios
>  *    and stop, since existing unmapped folios have new pages allocated and can
>  *    be migrated
>  * 3. EDEADLOCK, to be unmapped page is locked by someone else, to avoid deadlock,
>  *    we migrate existing unmapped pages and try to lock again
>  * 4. MIGRATEPAGE_SUCCESS, the folios was freed under us: no action
>  * 5. MIGRATEPAGE_UNMAP, unmap succeeded: set avoid_force_lock to true to avoid
>  *    wait to lock a folio in the future to avoid deadlock.
>  *
>  * For folios unmapped but cannot be migrated, we will restore their original
>  * states during cleanup stage at the end.
>  */

Sorry, I didn't notice the above comments in the previous reply.

The comments appear to too detailed for me.  I think that it's better
for people to get the details from the code itself.  So, I want to use
the much simplified version as below.

/*
 * migrate_pages_batch() first unmaps folios in the from list as many as
 * possible, then move the unmapped folios.
 */

Best Regards,
Huang, Ying

>>  {
>> -	int retry = 1;
>> +	int retry;
>>  	int large_retry = 1;
>>  	int thp_retry = 1;
>>  	int nr_failed = 0;
>> @@ -1600,13 +1647,19 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	int pass = 0;
>>  	bool is_large = false;
>>  	bool is_thp = false;
>> -	struct folio *folio, *folio2, *dst = NULL;
>> -	int rc, nr_pages;
>> +	struct folio *folio, *folio2, *dst = NULL, *dst2;
>> +	int rc, rc_saved, nr_pages;
>>  	LIST_HEAD(split_folios);
>> +	LIST_HEAD(unmap_folios);
>> +	LIST_HEAD(dst_folios);
>>  	bool nosplit = (reason == MR_NUMA_MISPLACED);
>>  	bool no_split_folio_counting = false;
>> +	bool force_lock;
>>
>> -split_folio_migration:
>> +retry:
>> +	rc_saved = 0;
>> +	force_lock = true;
>> +	retry = 1;
>>  	for (pass = 0;
>>  	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>>  	     pass++) {
>> @@ -1628,16 +1681,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  			cond_resched();
>>
>>  			rc = migrate_folio_unmap(get_new_page, put_new_page, private,
>> -						 folio, &dst, pass > 2, mode,
>> -						 reason, ret_folios);
>> -			if (rc == MIGRATEPAGE_UNMAP)
>> -				rc = migrate_folio_move(put_new_page, private,
>> -							folio, dst, mode,
>> -							reason, ret_folios);
>> +						 folio, &dst, pass > 2, force_lock,
>> +						 mode, reason, ret_folios);
>>  			/*
>>  			 * The rules are:
>>  			 *	Success: folio will be freed
>> +			 *	Unmap: folio will be put on unmap_folios list,
>> +			 *	       dst folio put on dst_folios list
>>  			 *	-EAGAIN: stay on the from list
>> +			 *	-EDEADLOCK: stay on the from list
>>  			 *	-ENOMEM: stay on the from list
>>  			 *	-ENOSYS: stay on the from list
>>  			 *	Other errno: put on ret_folios list
>> @@ -1672,7 +1724,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  			case -ENOMEM:
>>  				/*
>>  				 * When memory is low, don't bother to try to migrate
>> -				 * other folios, just exit.
>> +				 * other folios, move unmapped folios, then exit.
>>  				 */
>>  				if (is_large) {
>>  					nr_large_failed++;
>> @@ -1711,7 +1763,19 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				/* nr_failed isn't updated for not used */
>>  				nr_large_failed += large_retry;
>>  				stats->nr_thp_failed += thp_retry;
>> -				goto out;
>> +				rc_saved = rc;
>> +				if (list_empty(&unmap_folios))
>> +					goto out;
>> +				else
>> +					goto move;
>> +			case -EDEADLOCK:
>> +				/*
>> +				 * The folio cannot be locked for potential deadlock.
>> +				 * Go move (and unlock) all locked folios.  Then we can
>> +				 * try again.
>> +				 */
>> +				rc_saved = rc;
>> +				goto move;
>>  			case -EAGAIN:
>>  				if (is_large) {
>>  					large_retry++;
>> @@ -1725,6 +1789,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  				stats->nr_succeeded += nr_pages;
>>  				stats->nr_thp_succeeded += is_thp;
>>  				break;
>> +			case MIGRATEPAGE_UNMAP:
>> +				/*
>> +				 * We have locked some folios, don't force lock
>> +				 * to avoid deadlock.
>> +				 */
>> +				force_lock = false;
>> +				list_move_tail(&folio->lru, &unmap_folios);
>> +				list_add_tail(&dst->lru, &dst_folios);
>> +				break;
>>  			default:
>>  				/*
>>  				 * Permanent failure (-EBUSY, etc.):
>> @@ -1748,12 +1821,95 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  	nr_large_failed += large_retry;
>>  	stats->nr_thp_failed += thp_retry;
>>  	stats->nr_failed_pages += nr_retry_pages;
>> +move:
>> +	retry = 1;
>> +	for (pass = 0;
>> +	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
>> +	     pass++) {
>> +		retry = 0;
>> +		large_retry = 0;
>> +		thp_retry = 0;
>> +		nr_retry_pages = 0;
>> +
>> +		dst = list_first_entry(&dst_folios, struct folio, lru);
>> +		dst2 = list_next_entry(dst, lru);
>> +		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>> +			is_large = folio_test_large(folio);
>> +			is_thp = is_large && folio_test_pmd_mappable(folio);
>> +			nr_pages = folio_nr_pages(folio);
>> +
>> +			cond_resched();
>> +
>> +			rc = migrate_folio_move(put_new_page, private,
>> +						folio, dst, mode,
>> +						reason, ret_folios);
>> +			/*
>> +			 * The rules are:
>> +			 *	Success: folio will be freed
>> +			 *	-EAGAIN: stay on the unmap_folios list
>> +			 *	Other errno: put on ret_folios list
>> +			 */
>> +			switch(rc) {
>> +			case -EAGAIN:
>> +				if (is_large) {
>> +					large_retry++;
>> +					thp_retry += is_thp;
>> +				} else if (!no_split_folio_counting) {
>> +					retry++;
>> +				}
>> +				nr_retry_pages += nr_pages;
>> +				break;
>> +			case MIGRATEPAGE_SUCCESS:
>> +				stats->nr_succeeded += nr_pages;
>> +				stats->nr_thp_succeeded += is_thp;
>> +				break;
>> +			default:
>> +				if (is_large) {
>> +					nr_large_failed++;
>> +					stats->nr_thp_failed += is_thp;
>> +				} else if (!no_split_folio_counting) {
>> +					nr_failed++;
>> +				}
>> +
>> +				stats->nr_failed_pages += nr_pages;
>> +				break;
>> +			}
>> +			dst = dst2;
>> +			dst2 = list_next_entry(dst, lru);
>> +		}
>> +	}
>> +	nr_failed += retry;
>> +	nr_large_failed += large_retry;
>> +	stats->nr_thp_failed += thp_retry;
>> +	stats->nr_failed_pages += nr_retry_pages;
>> +
>> +	if (rc_saved)
>> +		rc = rc_saved;
>> +	else
>> +		rc = nr_failed + nr_large_failed;
>> +out:
>> +	/* Cleanup remaining folios */
>> +	dst = list_first_entry(&dst_folios, struct folio, lru);
>> +	dst2 = list_next_entry(dst, lru);
>> +	list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
>> +		int page_was_mapped = 0;
>> +		struct anon_vma *anon_vma = NULL;
>> +
>> +		__migrate_folio_extract(dst, &page_was_mapped, &anon_vma);
>> +		migrate_folio_undo_src(folio, page_was_mapped, anon_vma,
>> +				       ret_folios);
>> +		list_del(&dst->lru);
>> +		migrate_folio_undo_dst(dst, put_new_page, private);
>> +		dst = dst2;
>> +		dst2 = list_next_entry(dst, lru);
>> +	}
>> +
>>  	/*
>>  	 * Try to migrate split folios of fail-to-migrate large folios, no
>>  	 * nr_failed counting in this round, since all split folios of a
>>  	 * large folio is counted as 1 failure in the first round.
>>  	 */
>> -	if (!list_empty(&split_folios)) {
>> +	if (rc >= 0 && !list_empty(&split_folios)) {
>>  		/*
>>  		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
>>  		 * retries) to ret_folios to avoid migrating them again.
>> @@ -1761,12 +1917,16 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>>  		list_splice_init(from, ret_folios);
>>  		list_splice_init(&split_folios, from);
>>  		no_split_folio_counting = true;
>> -		retry = 1;
>> -		goto split_folio_migration;
>> +		goto retry;
>>  	}
>>
>> -	rc = nr_failed + nr_large_failed;
>> -out:
>> +	/*
>> +	 * We have unlocked all locked folios, so we can force lock now, let's
>> +	 * try again.
>> +	 */
>> +	if (rc == -EDEADLOCK)
>> +		goto retry;
>> +
>>  	return rc;
>>  }
>>
>> -- 
>> 2.35.1
>
> After rename the variable (or give it a better name) and add the comments,
> you can add Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> Thanks.
>
> --
> Best Regards,
> Yan, Zi
