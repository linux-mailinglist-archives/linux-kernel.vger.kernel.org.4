Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54670D277
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjEWDmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjEWDm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:42:27 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FB394
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 20:42:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VjIRpOt_1684813339;
Received: from 30.97.48.45(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VjIRpOt_1684813339)
          by smtp.aliyun-inc.com;
          Tue, 23 May 2023 11:42:20 +0800
Message-ID: <4453e142-f2c5-7016-acc0-3c861b8d0a0d@linux.alibaba.com>
Date:   Tue, 23 May 2023 11:42:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] mm, compaction: Skip all non-migratable pages during
 scan
To:     Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, steven.sistare@oracle.com,
        ying.huang@intel.com, mgorman@techsingularity.net,
        khalid@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230517161555.84776-1-khalid.aziz@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230517161555.84776-1-khalid.aziz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 12:15 AM, Khalid Aziz wrote:
> Pages pinned in memory through extra refcounts can not be migrated.
> Currently as isolate_migratepages_block() scans pages for
> compaction, it skips any pinned anonymous pages. All non-migratable
> pages should be skipped and not just the anonymous pinned pages.
> This patch adds a check for extra refcounts on a page to determine
> if the page can be migrated.  This was seen as a real issue on a
> customer workload where a large number of pages were pinned by vfio
> on the host and any attempts to allocate hugepages resulted in
> significant amount of cpu time spent in either direct compaction or
> in kcompactd scanning vfio pinned pages over and over again that can
> not be migrated.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
> ---
> v3:
> 	- Account for extra ref added by get_page_unless_zero() earlier
> 	  in isolate_migratepages_block() (Suggested by Huang, Ying)
> 	- Clean up computation of extra refs to be consistent
> 	  (Suggested by Huang, Ying)
> 
> v2:
> 	- Update comments in the code (Suggested by Andrew)
> 	- Use PagePrivate() instead of page_has_private() (Suggested
> 	  by Matthew)
> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
> 	- Use page_ref_count() (Suggested by Matthew)
> 	- Rename is_pinned_page() to reflect its function more
> 	  accurately (Suggested by Matthew)
> 
>   mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>   1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..f04c00981172 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>   	return too_many;
>   }
>   
> +/*
> + * Check if this base page should be skipped from isolation because
> + * it has extra refcounts that will prevent it from being migrated.
> + * This function is called for regular pages only, and not
> + * for THP or hugetlbfs pages. This code is inspired by similar code
> + * in migrate_vma_check_page(), can_split_folio() and
> + * folio_migrate_mapping()
> + */
> +static inline bool page_has_extra_refs(struct page *page)
> +{
> +	/* caller holds a ref already from get_page_unless_zero() */
> +	unsigned long extra_refs = 1;
> +
> +	/* anonymous page can have extra ref from swap cache */
> +	if (PageAnon(page))
> +		extra_refs += PageSwapCache(page) ? 1 : 0;
> +	else
> +		extra_refs += 1 + PagePrivate(page);
> +
> +	/*
> +	 * This is an admittedly racy check but good enough to determine
> +	 * if a page is pinned and can not be migrated
> +	 */
> +	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))

Could you explain why changing total_mapcount() to page_mapcount()? The 
original commit 829ae0f81ce0 ("mm: migrate: fix THP's mapcount on 
isolation") did fix a THP's mapcount issue with converting to 
total_mapcount().

> +		return true;
> +	return false;
> +}
> +
>   /**
>    * isolate_migratepages_block() - isolate all migrate-able pages within
>    *				  a single pageblock
> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>   			goto isolate_fail;
>   
>   		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * Migration will fail if a page has extra refcounts
> +		 * preventing it from migrating, so avoid taking
> +		 * lru_lock and isolating it unnecessarily
>   		 */
>   		mapping = page_mapping(page);
> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
> +		if (page_has_extra_refs(page))
>   			goto isolate_fail_put;
>   
>   		/*
