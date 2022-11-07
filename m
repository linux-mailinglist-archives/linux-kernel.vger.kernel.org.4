Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859F161EBE6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKGH0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiKGH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:26:21 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF8CFE7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:26:17 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VU8EpIc_1667805973;
Received: from 30.97.48.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VU8EpIc_1667805973)
          by smtp.aliyun-inc.com;
          Mon, 07 Nov 2022 15:26:14 +0800
Message-ID: <63a8f509-6acb-48b5-1aa1-c278deaaa719@linux.alibaba.com>
Date:   Mon, 7 Nov 2022 15:26:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] migrate: convert unmap_and_move() to use folios
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20221104083020.155835-1-ying.huang@intel.com>
 <20221104083020.155835-2-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221104083020.155835-2-ying.huang@intel.com>
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

LGTM. Please feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---
>   mm/migrate.c | 54 ++++++++++++++++++++++++++--------------------------
>   1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dff333593a8a..f6dd749dd2f8 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1150,79 +1150,79 @@ static int __unmap_and_move(struct folio *src, struct folio *dst,
>   }
>   
>   /*
> - * Obtain the lock on page, remove all ptes and migrate the page
> - * to the newly allocated page in newpage.
> + * Obtain the lock on folio, remove all ptes and migrate the folio
> + * to the newly allocated folio in dst.
>    */
>   static int unmap_and_move(new_page_t get_new_page,
>   				   free_page_t put_new_page,
> -				   unsigned long private, struct page *page,
> +				   unsigned long private, struct folio *src,
>   				   int force, enum migrate_mode mode,
>   				   enum migrate_reason reason,
>   				   struct list_head *ret)
>   {
> -	struct folio *dst, *src = page_folio(page);
> +	struct folio *dst;
>   	int rc = MIGRATEPAGE_SUCCESS;
>   	struct page *newpage = NULL;
>   
> -	if (!thp_migration_supported() && PageTransHuge(page))
> +	if (!thp_migration_supported() && folio_test_transhuge(src))
>   		return -ENOSYS;
>   
> -	if (page_count(page) == 1) {
> -		/* Page was freed from under us. So we are done. */
> -		ClearPageActive(page);
> -		ClearPageUnevictable(page);
> +	if (folio_ref_count(src) == 1) {
> +		/* Folio was freed from under us. So we are done. */
> +		folio_clear_active(src);
> +		folio_clear_unevictable(src);
>   		/* free_pages_prepare() will clear PG_isolated. */
>   		goto out;
>   	}
>   
> -	newpage = get_new_page(page, private);
> +	newpage = get_new_page(&src->page, private);
>   	if (!newpage)
>   		return -ENOMEM;
>   	dst = page_folio(newpage);
>   
> -	newpage->private = 0;
> +	dst->private = 0;
>   	rc = __unmap_and_move(src, dst, force, mode);
>   	if (rc == MIGRATEPAGE_SUCCESS)
> -		set_page_owner_migrate_reason(newpage, reason);
> +		set_page_owner_migrate_reason(&dst->page, reason);
>   
>   out:
>   	if (rc != -EAGAIN) {
>   		/*
> -		 * A page that has been migrated has all references
> -		 * removed and will be freed. A page that has not been
> +		 * A folio that has been migrated has all references
> +		 * removed and will be freed. A folio that has not been
>   		 * migrated will have kept its references and be restored.
>   		 */
> -		list_del(&page->lru);
> +		list_del(&src->lru);
>   	}
>   
>   	/*
>   	 * If migration is successful, releases reference grabbed during
> -	 * isolation. Otherwise, restore the page to right list unless
> +	 * isolation. Otherwise, restore the folio to right list unless
>   	 * we want to retry.
>   	 */
>   	if (rc == MIGRATEPAGE_SUCCESS) {
>   		/*
> -		 * Compaction can migrate also non-LRU pages which are
> +		 * Compaction can migrate also non-LRU folios which are
>   		 * not accounted to NR_ISOLATED_*. They can be recognized
> -		 * as __PageMovable
> +		 * as __folio_test_movable
>   		 */
> -		if (likely(!__PageMovable(page)))
> -			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
> -					page_is_file_lru(page), -thp_nr_pages(page));
> +		if (likely(!__folio_test_movable(src)))
> +			mod_node_page_state(folio_pgdat(src), NR_ISOLATED_ANON +
> +					folio_is_file_lru(src), -folio_nr_pages(src));
>   
>   		if (reason != MR_MEMORY_FAILURE)
>   			/*
> -			 * We release the page in page_handle_poison.
> +			 * We release the folio in page_handle_poison.
>   			 */
> -			put_page(page);
> +			folio_put(src);
>   	} else {
>   		if (rc != -EAGAIN)
> -			list_add_tail(&page->lru, ret);
> +			list_add_tail(&src->lru, ret);
>   
>   		if (put_new_page)
> -			put_new_page(newpage, private);
> +			put_new_page(&dst->page, private);
>   		else
> -			put_page(newpage);
> +			folio_put(dst);
>   	}
>   
>   	return rc;
> @@ -1459,7 +1459,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   						&ret_pages);
>   			else
>   				rc = unmap_and_move(get_new_page, put_new_page,
> -						private, page, pass > 2, mode,
> +						private, page_folio(page), pass > 2, mode,
>   						reason, &ret_pages);
>   			/*
>   			 * The rules are:
