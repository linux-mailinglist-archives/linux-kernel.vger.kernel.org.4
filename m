Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8526468DE1D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjBGQme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjBGQmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:42:31 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBF51A4AA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:42:18 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vb8COGO_1675788132;
Received: from 30.25.212.190(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Vb8COGO_1675788132)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 00:42:13 +0800
Message-ID: <840f6621-5a43-9cc2-6620-6d149ea712cd@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 00:42:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH -v4 2/9] migrate_pages: separate hugetlb folios migration
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-3-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230206063313.635011-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/2/6 下午2:33, Huang Ying 写道:
> This is a preparation patch to batch the folio unmapping and moving
> for the non-hugetlb folios.  Based on that we can batch the TLB
> shootdown during the folio migration and make it possible to use some
> hardware accelerator for the folio copying.
>
> In this patch the hugetlb folios and non-hugetlb folios migration is
> separated in migrate_pages() to make it easy to change the non-hugetlb
> folios migration implementation.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>   mm/migrate.c | 141 +++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 119 insertions(+), 22 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ef388a9e4747..be7f37523463 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1396,6 +1396,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>   	return rc;
>   }
>   
> +#define NR_MAX_MIGRATE_PAGES_RETRY	10
> +
>   struct migrate_pages_stats {
>   	int nr_succeeded;	/* Normal and large folios migrated successfully, in
>   				   units of base pages */
> @@ -1406,6 +1408,95 @@ struct migrate_pages_stats {
>   	int nr_thp_split;	/* THP split before migrating */
>   };
>   
> +/*
> + * Returns the number of hugetlb folios that were not migrated, or an error code
> + * after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no hugetlb folios are movable
> + * any more because the list has become empty or no retryable hugetlb folios
> + * exist any more. It is caller's responsibility to call putback_movable_pages()
> + * only if ret != 0.
> + */
> +static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
> +			    free_page_t put_new_page, unsigned long private,
> +			    enum migrate_mode mode, int reason,
> +			    struct migrate_pages_stats *stats,
> +			    struct list_head *ret_folios)
> +{
> +	int retry = 1;
> +	int nr_failed = 0;
> +	int nr_retry_pages = 0;
> +	int pass = 0;
> +	struct folio *folio, *folio2;
> +	int rc, nr_pages;
> +
> +	for (pass = 0; pass < NR_MAX_MIGRATE_PAGES_RETRY && retry; pass++) {
> +		retry = 0;
> +		nr_retry_pages = 0;
> +
> +		list_for_each_entry_safe(folio, folio2, from, lru) {
> +			if (!folio_test_hugetlb(folio))
> +				continue;
> +
> +			nr_pages = folio_nr_pages(folio);
> +
> +			cond_resched();
Just curious, why put  cond_resched() here,  it makes  "nr_pages = 
folio_nr_pages(folio)" looks Separately  with below codes.
> +
> +			rc = unmap_and_move_huge_page(get_new_page,
> +						      put_new_page, private,
> +						      &folio->page, pass > 2, mode,
> +						      reason, ret_folios);
> +			/*
> +			 * The rules are:
> +			 *	Success: hugetlb folio will be put back
> +			 *	-EAGAIN: stay on the from list
> +			 *	-ENOMEM: stay on the from list
> +			 *	-ENOSYS: stay on the from list
> +			 *	Other errno: put on ret_folios list
> +			 */
> +			switch(rc) {
> +			case -ENOSYS:
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				list_move_tail(&folio->lru, ret_folios);
> +				break;
> +			case -ENOMEM:
> +				/*
> +				 * When memory is low, don't bother to try to migrate
> +				 * other folios, just exit.
> +				 */
> +				stats->nr_failed_pages += nr_pages + nr_retry_pages;
> +				return -ENOMEM;
> +			case -EAGAIN:
> +				retry++;
> +				nr_retry_pages += nr_pages;
> +				break;
> +			case MIGRATEPAGE_SUCCESS:
> +				stats->nr_succeeded += nr_pages;
> +				break;
> +			default:
> +				/*
> +				 * Permanent failure (-EBUSY, etc.):
> +				 * unlike -EAGAIN case, the failed folio is
> +				 * removed from migration folio list and not
> +				 * retried in the next outer loop.
> +				 */
> +				nr_failed++;
> +				stats->nr_failed_pages += nr_pages;
> +				break;
> +			}
> +		}
> +	}
> +	/*
> +	 * nr_failed is number of hugetlb folios failed to be migrated.  After
> +	 * NR_MAX_MIGRATE_PAGES_RETRY attempts, give up and count retried hugetlb
> +	 * folios as failed.
> +	 */
> +	nr_failed += retry;
> +	stats->nr_failed_pages += nr_retry_pages;
> +
> +	return nr_failed;
> +}
> +
>   /*
>    * migrate_pages - migrate the folios specified in a list, to the free folios
>    *		   supplied as the target for the page migration
> @@ -1422,10 +1513,10 @@ struct migrate_pages_stats {
>    * @ret_succeeded:	Set to the number of folios migrated successfully if
>    *			the caller passes a non-NULL pointer.
>    *
> - * The function returns after 10 attempts or if no folios are movable any more
> - * because the list has become empty or no retryable folios exist any more.
> - * It is caller's responsibility to call putback_movable_pages() to return folios
> - * to the LRU or free list only if ret != 0.
> + * The function returns after NR_MAX_MIGRATE_PAGES_RETRY attempts or if no folios
> + * are movable any more because the list has become empty or no retryable folios
> + * exist any more. It is caller's responsibility to call putback_movable_pages()
> + * only if ret != 0.
>    *
>    * Returns the number of {normal folio, large folio, hugetlb} that were not
>    * migrated, or an error code. The number of large folio splits will be
> @@ -1439,7 +1530,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	int retry = 1;
>   	int large_retry = 1;
>   	int thp_retry = 1;
> -	int nr_failed = 0;
> +	int nr_failed;
>   	int nr_retry_pages = 0;
>   	int nr_large_failed = 0;
>   	int pass = 0;
> @@ -1456,38 +1547,45 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	trace_mm_migrate_pages_start(mode, reason);
>   
>   	memset(&stats, 0, sizeof(stats));
> +	rc = migrate_hugetlbs(from, get_new_page, put_new_page, private, mode, reason,
> +			      &stats, &ret_folios);
> +	if (rc < 0)
> +		goto out;
> +	nr_failed = rc;
> +
>   split_folio_migration:
> -	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
> +	for (pass = 0;
> +	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
> +	     pass++) {
>   		retry = 0;
>   		large_retry = 0;
>   		thp_retry = 0;
>   		nr_retry_pages = 0;
>   
>   		list_for_each_entry_safe(folio, folio2, from, lru) {
> +			/* Retried hugetlb folios will be kept in list  */
> +			if (folio_test_hugetlb(folio)) {
> +				list_move_tail(&folio->lru, &ret_folios);
> +				continue;
> +			}
> +
>   			/*
>   			 * Large folio statistics is based on the source large
>   			 * folio. Capture required information that might get
>   			 * lost during migration.
>   			 */
> -			is_large = folio_test_large(folio) && !folio_test_hugetlb(folio);
> +			is_large = folio_test_large(folio);
>   			is_thp = is_large && folio_test_pmd_mappable(folio);
>   			nr_pages = folio_nr_pages(folio);
> +
>   			cond_resched();
>   
> -			if (folio_test_hugetlb(folio))
> -				rc = unmap_and_move_huge_page(get_new_page,
> -						put_new_page, private,
> -						&folio->page, pass > 2, mode,
> -						reason,
> -						&ret_folios);
> -			else
> -				rc = unmap_and_move(get_new_page, put_new_page,
> -						private, folio, pass > 2, mode,
> -						reason, &ret_folios);
> +			rc = unmap_and_move(get_new_page, put_new_page,
> +					    private, folio, pass > 2, mode,
> +					    reason, &ret_folios);
>   			/*
>   			 * The rules are:
> -			 *	Success: non hugetlb folio will be freed, hugetlb
> -			 *		 folio will be put back
> +			 *	Success: folio will be freed
>   			 *	-EAGAIN: stay on the from list
>   			 *	-ENOMEM: stay on the from list
>   			 *	-ENOSYS: stay on the from list
> @@ -1514,7 +1612,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   						stats.nr_thp_split += is_thp;
>   						break;
>   					}
> -				/* Hugetlb migration is unsupported */
>   				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
> @@ -1608,8 +1705,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	 */
>   	if (!list_empty(&split_folios)) {
>   		/*
> -		 * Move non-migrated folios (after 10 retries) to ret_folios
> -		 * to avoid migrating them again.
> +		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
> +		 * retries) to ret_folios to avoid migrating them again.
>   		 */
>   		list_splice_init(from, &ret_folios);
>   		list_splice_init(&split_folios, from);
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
