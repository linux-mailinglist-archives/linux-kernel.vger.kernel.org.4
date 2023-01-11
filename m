Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087D9665246
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 04:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbjAKDUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 22:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjAKDT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:19:58 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C4D1740E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:19:29 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VZLIQyt_1673407165;
Received: from 30.97.48.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VZLIQyt_1673407165)
          by smtp.aliyun-inc.com;
          Wed, 11 Jan 2023 11:19:26 +0800
Message-ID: <9e004bfa-3349-b96d-11ad-4f846c6744b7@linux.alibaba.com>
Date:   Wed, 11 Jan 2023 11:19:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH -v2 3/9] migrate_pages: restrict number of pages to
 migrate in batch
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
References: <20230110075327.590514-1-ying.huang@intel.com>
 <20230110075327.590514-4-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230110075327.590514-4-ying.huang@intel.com>
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



On 1/10/2023 3:53 PM, Huang Ying wrote:
> This is a preparation patch to batch the folio unmapping and moving
> for non-hugetlb folios.
> 
> If we had batched the folio unmapping, all folios to be migrated would
> be unmapped before copying the contents and flags of the folios.  If
> the folios that were passed to migrate_pages() were too many in unit
> of pages, the execution of the processes would be stopped for too long
> time, thus too long latency.  For example, migrate_pages() syscall
> will call migrate_pages() with all folios of a process.  To avoid this
> possible issue, in this patch, we restrict the number of pages to be
> migrated to be no more than HPAGE_PMD_NR.  That is, the influence is
> at the same level of THP migration.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> ---
>   mm/migrate.c | 174 +++++++++++++++++++++++++++++++--------------------
>   1 file changed, 106 insertions(+), 68 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 04e6802c236c..4931dc4c1215 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1396,6 +1396,11 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>   	return rc;
>   }
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define NR_MAX_BATCHED_MIGRATION	HPAGE_PMD_NR
> +#else
> +#define NR_MAX_BATCHED_MIGRATION	512

We can have 64K page size on some architectures (e.g. ARM64), and I am 
not sure the batch size (64K * 512 = 32M) is suitable on these systems. 
I can do some measurement for the 64K page size if I find some time.

Anyway, we can start from a simple way. The changes look good to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> +#endif
>   #define NR_MAX_MIGRATE_PAGES_RETRY	10
>   
>   struct migrate_pages_stats {
> @@ -1497,40 +1502,15 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>   	return nr_failed;
>   }
>   
> -/*
> - * migrate_pages - migrate the folios specified in a list, to the free folios
> - *		   supplied as the target for the page migration
> - *
> - * @from:		The list of folios to be migrated.
> - * @get_new_page:	The function used to allocate free folios to be used
> - *			as the target of the folio migration.
> - * @put_new_page:	The function used to free target folios if migration
> - *			fails, or NULL if no special handling is necessary.
> - * @private:		Private data to be passed on to get_new_page()
> - * @mode:		The migration mode that specifies the constraints for
> - *			folio migration, if any.
> - * @reason:		The reason for folio migration.
> - * @ret_succeeded:	Set to the number of folios migrated successfully if
> - *			the caller passes a non-NULL pointer.
> - *
> - * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
> - * are movable any more because the list has become empty or no retryable folios
> - * exist any more. It is caller's responsibility to call putback_movable_pages()
> - * to return folios to the LRU or free list only if ret != 0.
> - *
> - * Returns the number of {normal folio, large folio, hugetlb} that were not
> - * migrated, or an error code. The number of large folio splits will be
> - * considered as the number of non-migrated large folio, no matter how many
> - * split folios of the large folio are migrated successfully.
> - */
> -int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		free_page_t put_new_page, unsigned long private,
> -		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> +		struct migrate_pages_stats *stats)
>   {
>   	int retry = 1;
>   	int large_retry = 1;
>   	int thp_retry = 1;
> -	int nr_failed;
> +	int nr_failed = 0;
>   	int nr_retry_pages = 0;
>   	int nr_large_failed = 0;
>   	int pass = 0;
> @@ -1538,20 +1518,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	bool is_thp = false;
>   	struct folio *folio, *folio2;
>   	int rc, nr_pages;
> -	LIST_HEAD(ret_folios);
>   	LIST_HEAD(split_folios);
>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
>   	bool no_split_folio_counting = false;
> -	struct migrate_pages_stats stats;
> -
> -	trace_mm_migrate_pages_start(mode, reason);
> -
> -	memset(&stats, 0, sizeof(stats));
> -	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
> -			      &stats, &ret_folios);
> -	if (rc < 0)
> -		goto out;
> -	nr_failed = rc;
>   
>   split_folio_migration:
>   	for (pass = 0;
> @@ -1563,12 +1532,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		nr_retry_pages = 0;
>   
>   		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			/* Retried hugetlb folios will be kept in list  */
> -			if (folio_test_hugetlb(folio)) {
> -				list_move_tail(&folio->lru, &ret_folios);
> -				continue;
> -			}
> -
>   			/*
>   			 * Large folio statistics is based on the source large
>   			 * folio. Capture required information that might get
> @@ -1582,15 +1545,14 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   
>   			rc = unmap_and_move(get_new_page, put_new_page,
>   					    private, folio, pass > 2, mode,
> -					    reason, &ret_folios);
> +					    reason, ret_folios);
>   			/*
>   			 * The rules are:
>   			 *	Success: folio will be freed
>   			 *	-EAGAIN: stay on the from list
>   			 *	-ENOMEM: stay on the from list
>   			 *	-ENOSYS: stay on the from list
> -			 *	Other errno: put on ret_folios list then splice to
> -			 *		     from list
> +			 *	Other errno: put on ret_folios list
>   			 */
>   			switch(rc) {
>   			/*
> @@ -1607,17 +1569,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				/* Large folio migration is unsupported */
>   				if (is_large) {
>   					nr_large_failed++;
> -					stats.nr_thp_failed += is_thp;
> +					stats->nr_thp_failed += is_thp;
>   					if (!try_split_folio(folio, &split_folios)) {
> -						stats.nr_thp_split += is_thp;
> +						stats->nr_thp_split += is_thp;
>   						break;
>   					}
>   				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
>   
> -				stats.nr_failed_pages += nr_pages;
> -				list_move_tail(&folio->lru, &ret_folios);
> +				stats->nr_failed_pages += nr_pages;
> +				list_move_tail(&folio->lru, ret_folios);
>   				break;
>   			case -ENOMEM:
>   				/*
> @@ -1626,13 +1588,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				if (is_large) {
>   					nr_large_failed++;
> -					stats.nr_thp_failed += is_thp;
> +					stats->nr_thp_failed += is_thp;
>   					/* Large folio NUMA faulting doesn't split to retry. */
>   					if (!nosplit) {
>   						int ret = try_split_folio(folio, &split_folios);
>   
>   						if (!ret) {
> -							stats.nr_thp_split += is_thp;
> +							stats->nr_thp_split += is_thp;
>   							break;
>   						} else if (reason == MR_LONGTERM_PIN &&
>   							   ret == -EAGAIN) {
> @@ -1650,17 +1612,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					nr_failed++;
>   				}
>   
> -				stats.nr_failed_pages += nr_pages + nr_retry_pages;
> +				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>   				/*
>   				 * There might be some split folios of fail-to-migrate large
> -				 * folios left in split_folios list. Move them back to migration
> +				 * folios left in split_folios list. Move them to ret_folios
>   				 * list so that they could be put back to the right list by
>   				 * the caller otherwise the folio refcnt will be leaked.
>   				 */
> -				list_splice_init(&split_folios, from);
> +				list_splice_init(&split_folios, ret_folios);
>   				/* nr_failed isn't updated for not used */
>   				nr_large_failed += large_retry;
> -				stats.nr_thp_failed += thp_retry;
> +				stats->nr_thp_failed += thp_retry;
>   				goto out;
>   			case -EAGAIN:
>   				if (is_large) {
> @@ -1672,8 +1634,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				nr_retry_pages += nr_pages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> -				stats.nr_succeeded += nr_pages;
> -				stats.nr_thp_succeeded += is_thp;
> +				stats->nr_succeeded += nr_pages;
> +				stats->nr_thp_succeeded += is_thp;
>   				break;
>   			default:
>   				/*
> @@ -1684,20 +1646,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				if (is_large) {
>   					nr_large_failed++;
> -					stats.nr_thp_failed += is_thp;
> +					stats->nr_thp_failed += is_thp;
>   				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
>   
> -				stats.nr_failed_pages += nr_pages;
> +				stats->nr_failed_pages += nr_pages;
>   				break;
>   			}
>   		}
>   	}
>   	nr_failed += retry;
>   	nr_large_failed += large_retry;
> -	stats.nr_thp_failed += thp_retry;
> -	stats.nr_failed_pages += nr_retry_pages;
> +	stats->nr_thp_failed += thp_retry;
> +	stats->nr_failed_pages += nr_retry_pages;
>   	/*
>   	 * Try to migrate split folios of fail-to-migrate large folios, no
>   	 * nr_failed counting in this round, since all split folios of a
> @@ -1708,7 +1670,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
>   		 * retries) to ret_folios to avoid migrating them again.
>   		 */
> -		list_splice_init(from, &ret_folios);
> +		list_splice_init(from, ret_folios);
>   		list_splice_init(&split_folios, from);
>   		no_split_folio_counting = true;
>   		retry = 1;
> @@ -1716,6 +1678,82 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	}
>   
>   	rc = nr_failed + nr_large_failed;
> +out:
> +	return rc;
> +}
> +
> +/*
> + * migrate_pages - migrate the folios specified in a list, to the free folios
> + *		   supplied as the target for the page migration
> + *
> + * @from:		The list of folios to be migrated.
> + * @get_new_page:	The function used to allocate free folios to be used
> + *			as the target of the folio migration.
> + * @put_new_page:	The function used to free target folios if migration
> + *			fails, or NULL if no special handling is necessary.
> + * @private:		Private data to be passed on to get_new_page()
> + * @mode:		The migration mode that specifies the constraints for
> + *			folio migration, if any.
> + * @reason:		The reason for folio migration.
> + * @ret_succeeded:	Set to the number of folios migrated successfully if
> + *			the caller passes a non-NULL pointer.
> + *
> + * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
> + * are movable any more because the list has become empty or no retryable folios
> + * exist any more. It is caller's responsibility to call putback_movable_pages()
> + * to return folios to the LRU or free list only if ret != 0.
> + *
> + * Returns the number of {normal folio, large folio, hugetlb} that were not
> + * migrated, or an error code. The number of large folio splits will be
> + * considered as the number of non-migrated large folio, no matter how many
> + * split folios of the large folio are migrated successfully.
> + */
> +int migrate_pages(struct list_head *from, new_page_t get_new_page,
> +		free_page_t put_new_page, unsigned long private,
> +		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
> +{
> +	int rc, rc_gather;
> +	int nr_pages;
> +	struct folio *folio, *folio2;
> +	LIST_HEAD(folios);
> +	LIST_HEAD(ret_folios);
> +	struct migrate_pages_stats stats;
> +
> +	trace_mm_migrate_pages_start(mode, reason);
> +
> +	memset(&stats, 0, sizeof(stats));
> +
> +	rc_gather = migrate_hugetlbs(from, get_new_page, put_new_page, private,
> +				     mode, reason, &stats, &ret_folios);
> +	if (rc_gather < 0)
> +		goto out;
> +again:
> +	nr_pages = 0;
> +	list_for_each_entry_safe(folio, folio2, from, lru) {
> +		/* Retried hugetlb folios will be kept in list  */
> +		if (folio_test_hugetlb(folio)) {
> +			list_move_tail(&folio->lru, &ret_folios);
> +			continue;
> +		}
> +
> +		nr_pages += folio_nr_pages(folio);
> +		if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> +			break;
> +	}
> +	if (nr_pages > NR_MAX_BATCHED_MIGRATION)
> +		list_cut_before(&folios, from, &folio->lru);
> +	else
> +		list_splice_init(from, &folios);
> +	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> +				 mode, reason, &ret_folios, &stats);
> +	list_splice_tail_init(&folios, &ret_folios);
> +	if (rc < 0) {
> +		rc_gather = rc;
> +		goto out;
> +	}
> +	rc_gather += rc;
> +	if (!list_empty(from))
> +		goto again;
>   out:
>   	/*
>   	 * Put the permanent failure folio back to migration list, they
> @@ -1728,7 +1766,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	 * are migrated successfully.
>   	 */
>   	if (list_empty(from))
> -		rc = 0;
> +		rc_gather = 0;
>   
>   	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
>   	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
> @@ -1742,7 +1780,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	if (ret_succeeded)
>   		*ret_succeeded = stats.nr_succeeded;
>   
> -	return rc;
> +	return rc_gather;
>   }
>   
>   struct page *alloc_migration_target(struct page *page, unsigned long private)
