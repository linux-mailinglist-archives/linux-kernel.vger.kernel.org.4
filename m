Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4FE6FD3A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjEJBtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:49:50 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DA3A85
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:49:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ViDRxzG_1683683383;
Received: from 30.240.106.49(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0ViDRxzG_1683683383)
          by smtp.aliyun-inc.com;
          Wed, 10 May 2023 09:49:45 +0800
Message-ID: <432c0505-301f-9abb-6e99-0dc216913122@linux.alibaba.com>
Date:   Wed, 10 May 2023 09:49:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] migrate_pages_batch: simplify retrying and failure
 counting of large folios
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
References: <20230509022014.380493-1-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230509022014.380493-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/5/9 上午10:20, Huang Ying 写道:
> After recent changes to the retrying and failure counting in
> migrate_pages_batch(), it was found that it's unnecessary to count
> retrying and failure for normal, large, and THP folios separately.
> Because we don't use retrying and failure number of large folios
> directly.  So, in this patch, we simplified retrying and failure
> counting of large folios via counting retrying and failure of normal
> and large folios together.  This results in the reduced line number.
>
> This is just code cleanup, no functionality changes are expected.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Xin Hao <xhao@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> ---
>   mm/migrate.c | 103 +++++++++++++++++----------------------------------
>   1 file changed, 35 insertions(+), 68 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 01cac26a3127..10709aed76d3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1614,11 +1614,9 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		int nr_pass)
>   {
>   	int retry = 1;
> -	int large_retry = 1;
>   	int thp_retry = 1;
>   	int nr_failed = 0;
>   	int nr_retry_pages = 0;
> -	int nr_large_failed = 0;
>   	int pass = 0;
>   	bool is_large = false;
>   	bool is_thp = false;
> @@ -1631,9 +1629,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	VM_WARN_ON_ONCE(mode != MIGRATE_ASYNC &&
>   			!list_empty(from) && !list_is_singular(from));
>   
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>   		retry = 0;
> -		large_retry = 0;
>   		thp_retry = 0;
>   		nr_retry_pages = 0;
>   
> @@ -1660,7 +1657,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   			 * list is processed.
>   			 */
>   			if (!thp_migration_supported() && is_thp) {
> -				nr_large_failed++;
> +				nr_failed++;
>   				stats->nr_thp_failed++;
>   				if (!try_split_folio(folio, split_folios)) {
>   					stats->nr_thp_split++;
> @@ -1688,38 +1685,33 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				 * When memory is low, don't bother to try to migrate
>   				 * other folios, move unmapped folios, then exit.
>   				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -					/* Large folio NUMA faulting doesn't split to retry. */
> -					if (!nosplit) {
> -						int ret = try_split_folio(folio, split_folios);
> -
> -						if (!ret) {
> -							stats->nr_thp_split += is_thp;
> -							break;
> -						} else if (reason == MR_LONGTERM_PIN &&
> -							   ret == -EAGAIN) {
> -							/*
> -							 * Try again to split large folio to
> -							 * mitigate the failure of longterm pinning.
> -							 */
> -							large_retry++;
> -							thp_retry += is_thp;
> -							nr_retry_pages += nr_pages;
> -							/* Undo duplicated failure counting. */
> -							nr_large_failed--;
> -							stats->nr_thp_failed -= is_thp;
> -							break;
> -						}
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
> +				/* Large folio NUMA faulting doesn't split to retry. */
> +				if (is_large && !nosplit) {
> +					int ret = try_split_folio(folio, split_folios);
> +
> +					if (!ret) {
> +						stats->nr_thp_split += is_thp;
> +						break;
> +					} else if (reason == MR_LONGTERM_PIN &&
> +						   ret == -EAGAIN) {
> +						/*
> +						 * Try again to split large folio to
> +						 * mitigate the failure of longterm pinning.
> +						 */
> +						retry++;
> +						thp_retry += is_thp;
> +						nr_retry_pages += nr_pages;
> +						/* Undo duplicated failure counting. */
> +						nr_failed--;
> +						stats->nr_thp_failed -= is_thp;
> +						break;
>   					}
> -				} else {
> -					nr_failed++;
>   				}
>   
>   				stats->nr_failed_pages += nr_pages + nr_retry_pages;
>   				/* nr_failed isn't updated for not used */
> -				nr_large_failed += large_retry;
>   				stats->nr_thp_failed += thp_retry;
>   				rc_saved = rc;
>   				if (list_empty(&unmap_folios))
> @@ -1727,12 +1719,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				else
>   					goto move;
>   			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>   				nr_retry_pages += nr_pages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> @@ -1750,20 +1738,14 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				 * removed from migration folio list and not
>   				 * retried in the next outer loop.
>   				 */
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>   				stats->nr_failed_pages += nr_pages;
>   				break;
>   			}
>   		}
>   	}
>   	nr_failed += retry;
> -	nr_large_failed += large_retry;
>   	stats->nr_thp_failed += thp_retry;
>   	stats->nr_failed_pages += nr_retry_pages;
>   move:
> @@ -1771,17 +1753,15 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	try_to_unmap_flush();
>   
>   	retry = 1;
> -	for (pass = 0; pass < nr_pass && (retry || large_retry); pass++) {
> +	for (pass = 0; pass < nr_pass && retry; pass++) {
>   		retry = 0;
> -		large_retry = 0;
>   		thp_retry = 0;
>   		nr_retry_pages = 0;
>   
>   		dst = list_first_entry(&dst_folios, struct folio, lru);
>   		dst2 = list_next_entry(dst, lru);
>   		list_for_each_entry_safe(folio, folio2, &unmap_folios, lru) {
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>   			nr_pages = folio_nr_pages(folio);
>   
>   			cond_resched();
> @@ -1797,12 +1777,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   			 */
>   			switch(rc) {
>   			case -EAGAIN:
> -				if (is_large) {
> -					large_retry++;
> -					thp_retry += is_thp;
> -				} else {
> -					retry++;
> -				}
> +				retry++;
> +				thp_retry += is_thp;
>   				nr_retry_pages += nr_pages;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> @@ -1810,13 +1786,8 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				stats->nr_thp_succeeded += is_thp;
>   				break;
>   			default:
> -				if (is_large) {
> -					nr_large_failed++;
> -					stats->nr_thp_failed += is_thp;
> -				} else {
> -					nr_failed++;
> -				}
> -
> +				nr_failed++;
> +				stats->nr_thp_failed += is_thp;
>   				stats->nr_failed_pages += nr_pages;
>   				break;
>   			}
> @@ -1825,14 +1796,10 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		}
>   	}
>   	nr_failed += retry;
> -	nr_large_failed += large_retry;
>   	stats->nr_thp_failed += thp_retry;
>   	stats->nr_failed_pages += nr_retry_pages;
>   
> -	if (rc_saved)
> -		rc = rc_saved;
> -	else
> -		rc = nr_failed + nr_large_failed;
> +	rc = rc_saved ? : nr_failed;
>   out:
>   	/* Cleanup remaining folios */
>   	dst = list_first_entry(&dst_folios, struct folio, lru);

LGTM.

Reviewed-by: Xin Hao <xhao@linux.alibaba.com>

