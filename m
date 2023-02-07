Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60968DDF4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjBGQ24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjBGQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:28:55 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4699012
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 08:28:51 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vb8Hzuq_1675787323;
Received: from 30.25.212.190(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0Vb8Hzuq_1675787323)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 00:28:45 +0800
Message-ID: <bdfe2b45-a67c-7a7a-3803-210c59a18a42@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 00:28:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH -v4 1/9] migrate_pages: organize stats with struct
 migrate_pages_stats
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20230206063313.635011-1-ying.huang@intel.com>
 <20230206063313.635011-2-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230206063313.635011-2-ying.huang@intel.com>
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
> Define struct migrate_pages_stats to organize the various statistics
> in migrate_pages().  This makes it easier to collect and consume the
> statistics in multiple functions.  This will be needed in the
> following patches in the series.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: haoxin <xhao@linux.alibaba.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
>   mm/migrate.c | 60 +++++++++++++++++++++++++++++-----------------------
>   1 file changed, 34 insertions(+), 26 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a4d3fc65085f..ef388a9e4747 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1396,6 +1396,16 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>   	return rc;
>   }
>   
> +struct migrate_pages_stats {
> +	int nr_succeeded;	/* Normal and large folios migrated successfully, in
> +				   units of base pages */
> +	int nr_failed_pages;	/* Normal and large folios failed to be migrated, in
> +				   units of base pages.  Untried folios aren't counted */
> +	int nr_thp_succeeded;	/* THP migrated successfully */
> +	int nr_thp_failed;	/* THP failed to be migrated */
> +	int nr_thp_split;	/* THP split before migrating */
> +};
> +
>   /*
>    * migrate_pages - migrate the folios specified in a list, to the free folios
>    *		   supplied as the target for the page migration
> @@ -1430,13 +1440,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	int large_retry = 1;
>   	int thp_retry = 1;
>   	int nr_failed = 0;
> -	int nr_failed_pages = 0;
>   	int nr_retry_pages = 0;
> -	int nr_succeeded = 0;
> -	int nr_thp_succeeded = 0;
>   	int nr_large_failed = 0;
> -	int nr_thp_failed = 0;
> -	int nr_thp_split = 0;
>   	int pass = 0;
>   	bool is_large = false;
>   	bool is_thp = false;
> @@ -1446,9 +1451,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	LIST_HEAD(split_folios);
>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
>   	bool no_split_folio_counting = false;
> +	struct migrate_pages_stats stats;
>   
>   	trace_mm_migrate_pages_start(mode, reason);
>   
> +	memset(&stats, 0, sizeof(stats));
>   split_folio_migration:
>   	for (pass = 0; pass < 10 && (retry || large_retry); pass++) {
>   		retry = 0;
> @@ -1502,9 +1509,9 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				/* Large folio migration is unsupported */
>   				if (is_large) {
>   					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>   					if (!try_split_folio(folio, &split_folios)) {
> -						nr_thp_split += is_thp;
> +						stats.nr_thp_split += is_thp;
>   						break;
>   					}
>   				/* Hugetlb migration is unsupported */
> @@ -1512,7 +1519,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					nr_failed++;
>   				}
>   
> -				nr_failed_pages += nr_pages;
> +				stats.nr_failed_pages += nr_pages;
>   				list_move_tail(&folio->lru, &ret_folios);
>   				break;
>   			case -ENOMEM:
> @@ -1522,13 +1529,13 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				if (is_large) {
>   					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>   					/* Large folio NUMA faulting doesn't split to retry. */
>   					if (!nosplit) {
>   						int ret = try_split_folio(folio, &split_folios);
>   
>   						if (!ret) {
> -							nr_thp_split += is_thp;
> +							stats.nr_thp_split += is_thp;
>   							break;
>   						} else if (reason == MR_LONGTERM_PIN &&
>   							   ret == -EAGAIN) {
> @@ -1546,7 +1553,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					nr_failed++;
>   				}
>   
> -				nr_failed_pages += nr_pages + nr_retry_pages;
> +				stats.nr_failed_pages += nr_pages + nr_retry_pages;
>   				/*
>   				 * There might be some split folios of fail-to-migrate large
>   				 * folios left in split_folios list. Move them back to migration
> @@ -1556,7 +1563,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				list_splice_init(&split_folios, from);
>   				/* nr_failed isn't updated for not used */
>   				nr_large_failed += large_retry;
> -				nr_thp_failed += thp_retry;
> +				stats.nr_thp_failed += thp_retry;
>   				goto out;
>   			case -EAGAIN:
>   				if (is_large) {
> @@ -1568,8 +1575,8 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				nr_retry_pages += nr_pages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> -				nr_succeeded += nr_pages;
> -				nr_thp_succeeded += is_thp;
> +				stats.nr_succeeded += nr_pages;
> +				stats.nr_thp_succeeded += is_thp;
>   				break;
>   			default:
>   				/*
> @@ -1580,20 +1587,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 */
>   				if (is_large) {
>   					nr_large_failed++;
> -					nr_thp_failed += is_thp;
> +					stats.nr_thp_failed += is_thp;
>   				} else if (!no_split_folio_counting) {
>   					nr_failed++;
>   				}
>   
> -				nr_failed_pages += nr_pages;
> +				stats.nr_failed_pages += nr_pages;
>   				break;
>   			}
>   		}
>   	}
>   	nr_failed += retry;
>   	nr_large_failed += large_retry;
> -	nr_thp_failed += thp_retry;
> -	nr_failed_pages += nr_retry_pages;
> +	stats.nr_thp_failed += thp_retry;
> +	stats.nr_failed_pages += nr_retry_pages;
>   	/*
>   	 * Try to migrate split folios of fail-to-migrate large folios, no
>   	 * nr_failed counting in this round, since all split folios of a
> @@ -1626,16 +1633,17 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	if (list_empty(from))
>   		rc = 0;
>   
> -	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> -	count_vm_events(PGMIGRATE_FAIL, nr_failed_pages);
> -	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> -	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> -	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed_pages, nr_thp_succeeded,
> -			       nr_thp_failed, nr_thp_split, mode, reason);
> +	count_vm_events(PGMIGRATE_SUCCESS, stats.nr_succeeded);
> +	count_vm_events(PGMIGRATE_FAIL, stats.nr_failed_pages);
> +	count_vm_events(THP_MIGRATION_SUCCESS, stats.nr_thp_succeeded);
> +	count_vm_events(THP_MIGRATION_FAIL, stats.nr_thp_failed);
> +	count_vm_events(THP_MIGRATION_SPLIT, stats.nr_thp_split);
> +	trace_mm_migrate_pages(stats.nr_succeeded, stats.nr_failed_pages,
> +			       stats.nr_thp_succeeded, stats.nr_thp_failed,
> +			       stats.nr_thp_split, mode, reason);
>   
>   	if (ret_succeeded)
> -		*ret_succeeded = nr_succeeded;
> +		*ret_succeeded = stats.nr_succeeded;
>   
>   	return rc;
>   }
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

