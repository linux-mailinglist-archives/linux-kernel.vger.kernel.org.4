Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC786A6570
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCACXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCACXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:23:44 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6D30D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 18:23:41 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VclkV32_1677637417;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VclkV32_1677637417)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 10:23:37 +0800
Message-ID: <e820f68a-d1c7-c552-b924-56d97fb0b927@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 10:23:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/3] migrate_pages: move split folios processing out of
 migrate_pages_batch()
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        "Xu, Pengfei" <pengfei.xu@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Stefan Roesch <shr@devkernel.io>, Tejun Heo <tj@kernel.org>,
        Xin Hao <xhao@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230224141145.96814-1-ying.huang@intel.com>
 <20230224141145.96814-3-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230224141145.96814-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 10:11 PM, Huang Ying wrote:
> To simplify the code logic and reduce the line number.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: "Xu, Pengfei" <pengfei.xu@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Stefan Roesch <shr@devkernel.io>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/migrate.c | 76 ++++++++++++++++++----------------------------------
>   1 file changed, 26 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7ac37dbbf307..91198b487e49 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1605,9 +1605,10 @@ static int migrate_hugetlbs(struct list_head *from, new_page_t get_new_page,
>   static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		free_page_t put_new_page, unsigned long private,
>   		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> -		struct migrate_pages_stats *stats)
> +		struct list_head *split_folios, struct migrate_pages_stats *stats,
> +		int nr_pass)
>   {
> -	int retry;
> +	int retry = 1;
>   	int large_retry = 1;
>   	int thp_retry = 1;
>   	int nr_failed = 0;
> @@ -1617,19 +1618,12 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	bool is_large = false;
>   	bool is_thp = false;
>   	struct folio *folio, *folio2, *dst = NULL, *dst2;
> -	int rc, rc_saved, nr_pages;
> -	LIST_HEAD(split_folios);
> +	int rc, rc_saved = 0, nr_pages;
>   	LIST_HEAD(unmap_folios);
>   	LIST_HEAD(dst_folios);
>   	bool nosplit = (reason == MR_NUMA_MISPLACED);
> -	bool no_split_folio_counting = false;
>   
> -retry:
> -	rc_saved = 0;
> -	retry = 1;
> -	for (pass = 0;
> -	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
> -	     pass++) {
> +	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>   		retry = 0;
>   		large_retry = 0;
>   		thp_retry = 0;
> @@ -1660,7 +1654,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   			if (!thp_migration_supported() && is_thp) {
>   				nr_large_failed++;
>   				stats->nr_thp_failed++;
> -				if (!try_split_folio(folio, &split_folios)) {
> +				if (!try_split_folio(folio, split_folios)) {
>   					stats->nr_thp_split++;
>   					continue;
>   				}
> @@ -1692,7 +1686,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   					stats->nr_thp_failed += is_thp;
>   					/* Large folio NUMA faulting doesn't split to retry. */
>   					if (!nosplit) {
> -						int ret = try_split_folio(folio, &split_folios);
> +						int ret = try_split_folio(folio, split_folios);
>   
>   						if (!ret) {
>   							stats->nr_thp_split += is_thp;
> @@ -1709,18 +1703,11 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   							break;
>   						}
>   					}
> -				} else if (!no_split_folio_counting) {
> +				} else {
>   					nr_failed++;
>   				}
>   
>   				stats->nr_failed_pages += nr_pages + nr_retry_pages;
> -				/*
> -				 * There might be some split folios of fail-to-migrate large
> -				 * folios left in split_folios list. Move them to ret_folios
> -				 * list so that they could be put back to the right list by
> -				 * the caller otherwise the folio refcnt will be leaked.
> -				 */
> -				list_splice_init(&split_folios, ret_folios);
>   				/* nr_failed isn't updated for not used */
>   				nr_large_failed += large_retry;
>   				stats->nr_thp_failed += thp_retry;
> @@ -1733,7 +1720,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				if (is_large) {
>   					large_retry++;
>   					thp_retry += is_thp;
> -				} else if (!no_split_folio_counting) {
> +				} else {
>   					retry++;
>   				}
>   				nr_retry_pages += nr_pages;
> @@ -1756,7 +1743,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				if (is_large) {
>   					nr_large_failed++;
>   					stats->nr_thp_failed += is_thp;
> -				} else if (!no_split_folio_counting) {
> +				} else {
>   					nr_failed++;
>   				}
>   
> @@ -1774,9 +1761,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	try_to_unmap_flush();
>   
>   	retry = 1;
> -	for (pass = 0;
> -	     pass < NR_MAX_MIGRATE_PAGES_RETRY && (retry || large_retry);
> -	     pass++) {
> +	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
>   		retry = 0;
>   		large_retry = 0;
>   		thp_retry = 0;
> @@ -1805,7 +1790,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				if (is_large) {
>   					large_retry++;
>   					thp_retry += is_thp;
> -				} else if (!no_split_folio_counting) {
> +				} else {
>   					retry++;
>   				}
>   				nr_retry_pages += nr_pages;
> @@ -1818,7 +1803,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				if (is_large) {
>   					nr_large_failed++;
>   					stats->nr_thp_failed += is_thp;
> -				} else if (!no_split_folio_counting) {
> +				} else {
>   					nr_failed++;
>   				}
>   
> @@ -1855,27 +1840,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		dst2 = list_next_entry(dst, lru);
>   	}
>   
> -	/*
> -	 * Try to migrate split folios of fail-to-migrate large folios, no
> -	 * nr_failed counting in this round, since all split folios of a
> -	 * large folio is counted as 1 failure in the first round.
> -	 */
> -	if (rc >= 0 && !list_empty(&split_folios)) {
> -		/*
> -		 * Move non-migrated folios (after NR_MAX_MIGRATE_PAGES_RETRY
> -		 * retries) to ret_folios to avoid migrating them again.
> -		 */
> -		list_splice_init(from, ret_folios);
> -		list_splice_init(&split_folios, from);
> -		/*
> -		 * Force async mode to avoid to wait lock or bit when we have
> -		 * locked more than one folios.
> -		 */
> -		mode = MIGRATE_ASYNC;
> -		no_split_folio_counting = true;
> -		goto retry;
> -	}
> -
>   	return rc;
>   }
>   
> @@ -1914,6 +1878,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	struct folio *folio, *folio2;
>   	LIST_HEAD(folios);
>   	LIST_HEAD(ret_folios);
> +	LIST_HEAD(split_folios);
>   	struct migrate_pages_stats stats;
>   
>   	trace_mm_migrate_pages_start(mode, reason);
> @@ -1947,12 +1912,23 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	else
>   		list_splice_init(from, &folios);
>   	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> -				 mode, reason, &ret_folios, &stats);
> +				 mode, reason, &ret_folios, &split_folios, &stats,
> +				 NR_MAX_MIGRATE_PAGES_RETRY);
>   	list_splice_tail_init(&folios, &ret_folios);
>   	if (rc < 0) {
>   		rc_gather = rc;
> +		list_splice_tail(&split_folios, &ret_folios);

Can we still keep the original comments? Which can help to understand 
the case, at least for me:)
  /*
   * There might be some split folios of fail-to-migrate large
   * folios left in split_folios list. Move them to ret_folios
   * list so that they could be put back to the right list by
   * the caller otherwise the folio refcnt will be leaked.
   */

>   		goto out;
>   	}
> +	if (!list_empty(&split_folios)) {
> +		/*
> +		 * Failure isn't counted since all split folios of a large folio
> +		 * is counted as 1 failure already.
> +		 */
> +		migrate_pages_batch(&split_folios, get_new_page, put_new_page, private,
> +				    MIGRATE_ASYNC, reason, &ret_folios, NULL, &stats, 1);

Better to copy the original comments to explain why force to 
MIGRATE_ASYNC mode for split folios.

Thanks for the simplification, and please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
