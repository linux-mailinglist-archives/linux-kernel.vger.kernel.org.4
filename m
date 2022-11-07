Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9228961ECB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiKGIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiKGIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:14:02 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0262AC2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 00:14:00 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VU9Cusf_1667808837;
Received: from 30.97.48.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VU9Cusf_1667808837)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 16:13:58 +0800
Message-ID: <ec7e78a3-5f4f-1a17-580f-f52cca3cdbf3@linux.alibaba.com>
Date:   Mon, 7 Nov 2022 16:13:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] migrate: convert migrate_pages() to use folios
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20221104083020.155835-1-ying.huang@intel.com>
 <20221104083020.155835-3-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221104083020.155835-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2022 4:30 PM, Huang Ying wrote:
> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.
> 
> THP specific code are converted to be large folio.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   mm/migrate.c | 201 +++++++++++++++++++++++++++------------------------
>   1 file changed, 107 insertions(+), 94 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f6dd749dd2f8..b41289ef3b65 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1373,218 +1373,231 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>   	return rc;
>   }
>   
> -static inline int try_split_thp(struct page *page, struct list_head *split_pages)
> +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
>   {
>   	int rc;
>   
> -	lock_page(page);
> -	rc = split_huge_page_to_list(page, split_pages);
> -	unlock_page(page);
> +	folio_lock(folio);
> +	rc = split_folio_to_list(folio, split_folios);
> +	folio_unlock(folio);
>   	if (!rc)
> -		list_move_tail(&page->lru, split_pages);
> +		list_move_tail(&folio->lru, split_folios);
>   
>   	return rc;
>   }
>   
>   /*
> - * migrate_pages - migrate the pages specified in a list, to the free pages
> + * migrate_pages - migrate the folios specified in a list, to the free folios
>    *		   supplied as the target for the page migration
>    *
> - * @from:		The list of pages to be migrated.
> - * @get_new_page:	The function used to allocate free pages to be used
> - *			as the target of the page migration.
> - * @put_new_page:	The function used to free target pages if migration
> + * @from:		The list of folios to be migrated.
> + * @get_new_page:	The function used to allocate free folios to be used
> + *			as the target of the folio migration.
> + * @put_new_page:	The function used to free target folios if migration
>    *			fails, or NULL if no special handling is necessary.
>    * @private:		Private data to be passed on to get_new_page()
>    * @mode:		The migration mode that specifies the constraints for
> - *			page migration, if any.
> - * @reason:		The reason for page migration.
> - * @ret_succeeded:	Set to the number of normal pages migrated successfully if
> + *			folio migration, if any.
> + * @reason:		The reason for folio migration.
> + * @ret_succeeded:	Set to the number of folios migrated successfully if
>    *			the caller passes a non-NULL pointer.
>    *
> - * The function returns after 10 attempts or if no pages are movable any more
> - * because the list has become empty or no retryable pages exist any more.
> - * It is caller's responsibility to call putback_movable_pages() to return pages
> + * The function returns after 10 attempts or if no folios are movable any more
> + * because the list has become empty or no retryable folios exist any more.
> + * It is caller's responsibility to call putback_movable_pages() to return folios
>    * to the LRU or free list only if ret != 0.
>    *
> - * Returns the number of {normal page, THP, hugetlb} that were not migrated, or
> - * an error code. The number of THP splits will be considered as the number of
> - * non-migrated THP, no matter how many subpages of the THP are migrated successfully.
> + * Returns the number of {normal folio, large folio, hugetlb} that were not
> + * migrated, or an error code. The number of large folio splits will be
> + * considered as the number of non-migrated large folio, no matter how many
> + * split folios of the large folio are migrated successfully.
>    */
>   int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		free_page_t put_new_page, unsigned long private,
>   		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>   {
>   	int retry = 1;
> +	int large_retry = 1;
>   	int thp_retry = 1;
>   	int nr_failed = 0;
>   	int nr_failed_pages = 0;
>   	int nr_retry_pages = 0;
>   	int nr_succeeded = 0;
>   	int nr_thp_succeeded = 0;
> +	int nr_large_failed = 0;
>   	int nr_thp_failed = 0;
>   	int nr_thp_split = 0;
>   	int pass = 0;
> +	bool is_large = false;
>   	bool is_thp = false;
> -	struct page *page;
> -	struct page *page2;
> -	int rc, nr_subpages;
> -	LIST_HEAD(ret_pages);
> -	LIST_HEAD(thp_split_pages);
> +	struct folio *folio, *folio2;
> +	int rc, nr_pages;
> +	LIST_HEAD(ret_folios);
> +	LIST_HEAD(split_folios);
>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
> -	bool no_subpage_counting = false;
> +	bool no_split_folio_counting = false;
>   
>   	trace_mm_migrate_pages_start(mode, reason);
>   
> -thp_subpage_migration:
> -	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
> +split_folio_migration:
> +	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>   		retry = 0;
> +		large_retry = 0;
>   		thp_retry = 0;
>   		nr_retry_pages = 0;
>   
> -		list_for_each_entry_safe(page, page2, from, lru) {
> +		list_for_each_entry_safe(folio, folio2, from, lru) {
>   			/*
> -			 * THP statistics is based on the source huge page.
> -			 * Capture required information that might get lost
> -			 * during migration.
> +			 * large folio statistics is based on the source large

Nit: s/large/Large

> +			 * folio. Capture required information that might get
> +			 * lost during migration.
>   			 */
> -			is_thp = PageTransHuge(page) && !PageHuge(page);
> -			nr_subpages = compound_nr(page);
> +			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
> +			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			nr_pages = folio_nr_pages(folio);
>   			cond_resched();
>   
> -			if (PageHuge(page))
> +			if (folio_test_hugetlb(folio))
>   				rc = unmap_and_move_huge_page(get_new_page,
> -						put_new_page, private, page,
> -						pass > 2, mode, reason,
> -						&ret_pages);
> +						put_new_page, private,
> +						&folio->page, pass > 2, mode,
> +						reason,
> +						&ret_folios);
>   			else
>   				rc = unmap_and_move(get_new_page, put_new_page,
> -						private, page_folio(page), pass > 2, mode,
> -						reason, &ret_pages);
> +						private, folio, pass > 2, mode,
> +						reason, &ret_folios);
>   			/*
>   			 * The rules are:
> -			 *	Success: non hugetlb page will be freed, hugetlb
> -			 *		 page will be put back
> +			 *	Success: non hugetlb folio will be freed, hugetlb
> +			 *		 folio will be put back
>   			 *	-EAGAIN: stay on the from list
>   			 *	-ENOMEM: stay on the from list
>   			 *	-ENOSYS: stay on the from list
> -			 *	Other errno: put on ret_pages list then splice to
> +			 *	Other errno: put on ret_folios list then splice to
>   			 *		     from list
>   			 */
>   			switch(rc) {
>   			/*
> -			 * THP migration might be unsupported or the
> -			 * allocation could've failed so we should
> -			 * retry on the same page with the THP split
> -			 * to base pages.
> +			 * Large folio migration might be unsupported or
> +			 * the allocation could've failed so we should retry
> +			 * on the same folio with the large folio split
> +			 * to normal folios.
>   			 *
> -			 * Sub-pages are put in thp_split_pages, and
> +			 * Split folios are put in split_folios, and
>   			 * we will migrate them after the rest of the
>   			 * list is processed.
>   			 */
>   			case -ENOSYS:
> -				/* THP migration is unsupported */
> -				if (is_thp) {
> -					nr_thp_failed++;
> -					if (!try_split_thp(page, &thp_split_pages)) {
> -						nr_thp_split++;
> +				/* Large folio migration is unsupported */
> +				if (is_large) {
> +					nr_large_failed++;
> +					nr_thp_failed += is_thp;
> +					if (!try_split_folio(folio, &split_folios)) {
> +						nr_thp_split += is_thp;
>   						break;
>   					}
>   				/* Hugetlb migration is unsupported */
> -				} else if (!no_subpage_counting) {
> +				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
>   
> -				nr_failed_pages += nr_subpages;
> -				list_move_tail(&page->lru, &ret_pages);
> +				nr_failed_pages += nr_pages;
> +				list_move_tail(&folio->lru, &ret_folios);
>   				break;
>   			case -ENOMEM:
>   				/*
>   				 * When memory is low, don't bother to try to migrate
> -				 * other pages, just exit.
> +				 * other folios, just exit.
>   				 */
> -				if (is_thp) {
> -					nr_thp_failed++;
> -					/* THP NUMA faulting doesn't split THP to retry. */
> -					if (!nosplit && !try_split_thp(page, &thp_split_pages)) {
> -						nr_thp_split++;
> +				if (is_large) {
> +					nr_large_failed++;
> +					nr_thp_failed += is_thp;
> +					/* Large folio NUMA faulting doesn't split to retry. */
> +					if (!nosplit && !try_split_folio(folio, &split_folios)) {

I am not sure if need to add a is_thp validation before calling 
try_split_folio()?

BTW, you should rebase on the mm-unstable branch, since I've added a 
retry for THP split.

> +						nr_thp_split += is_thp;
>   						break;
>   					}
> -				} else if (!no_subpage_counting) {
> +				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
>   
> -				nr_failed_pages += nr_subpages + nr_retry_pages;
> +				nr_failed_pages += nr_pages + nr_retry_pages;
>   				/*
> -				 * There might be some subpages of fail-to-migrate THPs
> -				 * left in thp_split_pages list. Move them back to migration
> +				 * There might be some split folios of fail-to-migrate large
> +				 * folios left in split_folios list. Move them back to migration
>   				 * list so that they could be put back to the right list by
> -				 * the caller otherwise the page refcnt will be leaked.
> +				 * the caller otherwise the folio refcnt will be leaked.
>   				 */
> -				list_splice_init(&thp_split_pages, from);
> +				list_splice_init(&split_folios, from);
>   				/* nr_failed isn't updated for not used */
> +				nr_large_failed += large_retry;
>   				nr_thp_failed += thp_retry;
>   				goto out;
>   			case -EAGAIN:
> -				if (is_thp)
> -					thp_retry++;
> -				else if (!no_subpage_counting)
> +				if (is_large) {
> +					large_retry++;
> +					thp_retry += is_thp;
> +				} else if (!no_split_folio_counting) {
>   					retry++;
> -				nr_retry_pages += nr_subpages;
> +				}
> +				nr_retry_pages += nr_pages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> -				nr_succeeded += nr_subpages;
> -				if (is_thp)
> -					nr_thp_succeeded++;
> +				nr_succeeded += nr_pages;
> +				nr_thp_succeeded += is_thp;
>   				break;
>   			default:
>   				/*
>   				 * Permanent failure (-EBUSY, etc.):
> -				 * unlike -EAGAIN case, the failed page is
> -				 * removed from migration page list and not
> +				 * unlike -EAGAIN case, the failed folio is
> +				 * removed from migration folio list and not
>   				 * retried in the next outer loop.
>   				 */
> -				if (is_thp)
> -					nr_thp_failed++;
> -				else if (!no_subpage_counting)
> +				if (is_large) {
> +					nr_large_failed++;
> +					nr_thp_failed += is_thp;
> +				} else if (!no_split_folio_counting) {
>   					nr_failed++;
> +				}
>   
> -				nr_failed_pages += nr_subpages;
> +				nr_failed_pages += nr_pages;
>   				break;
>   			}
>   		}
>   	}
>   	nr_failed += retry;
> +	nr_large_failed += large_retry;
>   	nr_thp_failed += thp_retry;
>   	nr_failed_pages += nr_retry_pages;
>   	/*
> -	 * Try to migrate subpages of fail-to-migrate THPs, no nr_failed
> -	 * counting in this round, since all subpages of a THP is counted
> -	 * as 1 failure in the first round.
> +	 * Try to migrate split folios of fail-to-migrate large folios, no
> +	 * nr_failed counting in this round, since all split folios of a
> +	 * large folio is counted as 1 failure in the first round.
>   	 */
> -	if (!list_empty(&thp_split_pages)) {
> +	if (!list_empty(&split_folios)) {
>   		/*
> -		 * Move non-migrated pages (after 10 retries) to ret_pages
> +		 * Move non-migrated folios (after 10 retries) to ret_folios
>   		 * to avoid migrating them again.
>   		 */
> -		list_splice_init(from, &ret_pages);
> -		list_splice_init(&thp_split_pages, from);
> -		no_subpage_counting = true;
> +		list_splice_init(from, &ret_folios);
> +		list_splice_init(&split_folios, from);
> +		no_split_folio_counting = true;
>   		retry = 1;
> -		goto thp_subpage_migration;
> +		goto split_folio_migration;
>   	}
>   
> -	rc = nr_failed + nr_thp_failed;
> +	rc = nr_failed + nr_large_failed;
>   out:
>   	/*
> -	 * Put the permanent failure page back to migration list, they
> +	 * Put the permanent failure folio back to migration list, they
>   	 * will be put back to the right list by the caller.
>   	 */
> -	list_splice(&ret_pages, from);
> +	list_splice(&ret_folios, from);
>   
>   	/*
> -	 * Return 0 in case all subpages of fail-to-migrate THPs are
> -	 * migrated successfully.
> +	 * Return 0 in case all split folios of fail-to-migrate large folios
> +	 * are migrated successfully.
>   	 */
>   	if (list_empty(from))
>   		rc = 0;
