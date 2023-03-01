Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D56A664D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCADIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjCADIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:08:34 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E76A5F3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:08:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VcmORIu_1677640100;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VcmORIu_1677640100)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 11:08:21 +0800
Message-ID: <a0c24dfe-3a07-fe9e-7edf-b51877d96c32@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 11:08:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 3/3] migrate_pages: try migrate in batch asynchronously
 firstly
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
 <20230224141145.96814-4-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230224141145.96814-4-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 10:11 PM, Huang Ying wrote:
> When we have locked more than one folios, we cannot wait the lock or
> bit (e.g., page lock, buffer head lock, writeback bit) synchronously.
> Otherwise deadlock may be triggered.  This make it hard to batch the
> synchronous migration directly.
> 
> This patch re-enables batching synchronous migration via trying to
> migrate in batch asynchronously firstly.  And any folios that are
> failed to be migrated asynchronously will be migrated synchronously
> one by one.
> 
> Test shows that this can restore the TLB flushing batching performance
> for synchronous migration effectively.
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
>   mm/migrate.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 55 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 91198b487e49..c17ce5ee8d92 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1843,6 +1843,51 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	return rc;
>   }
>   
> +static int migrate_pages_sync(struct list_head *from, new_page_t get_new_page,
> +		free_page_t put_new_page, unsigned long private,
> +		enum migrate_mode mode, int reason, struct list_head *ret_folios,
> +		struct list_head *split_folios, struct migrate_pages_stats *stats)
> +{
> +	int rc, nr_failed = 0;
> +	LIST_HEAD(folios);
> +	struct migrate_pages_stats astats;
> +
> +	memset(&astats, 0, sizeof(astats));
> +	/* Try to migrate in batch with MIGRATE_ASYNC mode firstly */
> +	rc = migrate_pages_batch(from, get_new_page, put_new_page, private, MIGRATE_ASYNC,
> +				 reason, &folios, split_folios, &astats,
> +				 NR_MAX_MIGRATE_PAGES_RETRY);
> +	stats->nr_succeeded += astats.nr_succeeded;
> +	stats->nr_thp_succeeded += astats.nr_thp_succeeded;
> +	stats->nr_thp_split += astats.nr_thp_split;
> +	if (rc < 0) {
> +		stats->nr_failed_pages += astats.nr_failed_pages;
> +		stats->nr_thp_failed += astats.nr_thp_failed;
> +		list_splice_tail(&folios, ret_folios);
> +		return rc;
> +	}
> +	stats->nr_thp_failed += astats.nr_thp_split;
> +	nr_failed += astats.nr_thp_split;
> +	/*
> +	 * Fall back to migrate all failed folios one by one synchronously. All
> +	 * failed folios except split THPs will be retried, so their failure
> +	 * isn't counted
> +	 */
> +	list_splice_tail_init(&folios, from);
> +	while (!list_empty(from)) {
> +		list_move(from->next, &folios);
> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page,
> +					 private, mode, reason, ret_folios,
> +					 split_folios, stats, NR_MAX_MIGRATE_PAGES_RETRY);
> +		list_splice_tail_init(&folios, ret_folios);
> +		if (rc < 0)
> +			return rc;
> +		nr_failed += rc;
> +	}
> +
> +	return nr_failed;
> +}
> +
>   /*
>    * migrate_pages - migrate the folios specified in a list, to the free folios
>    *		   supplied as the target for the page migration
> @@ -1874,7 +1919,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		enum migrate_mode mode, int reason, unsigned int *ret_succeeded)
>   {
>   	int rc, rc_gather;
> -	int nr_pages, batch;
> +	int nr_pages;
>   	struct folio *folio, *folio2;
>   	LIST_HEAD(folios);
>   	LIST_HEAD(ret_folios);
> @@ -1890,10 +1935,6 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   	if (rc_gather < 0)
>   		goto out;
>   
> -	if (mode == MIGRATE_ASYNC)
> -		batch = NR_MAX_BATCHED_MIGRATION;
> -	else
> -		batch = 1;
>   again:
>   	nr_pages = 0;
>   	list_for_each_entry_safe(folio, folio2, from, lru) {
> @@ -1904,16 +1945,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		}
>   
>   		nr_pages += folio_nr_pages(folio);
> -		if (nr_pages >= batch)
> +		if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>   			break;
>   	}
> -	if (nr_pages >= batch)
> +	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
>   		list_cut_before(&folios, from, &folio2->lru);
>   	else
>   		list_splice_init(from, &folios);
> -	rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> -				 mode, reason, &ret_folios, &split_folios, &stats,
> -				 NR_MAX_MIGRATE_PAGES_RETRY);
> +	if (mode == MIGRATE_ASYNC)
> +		rc = migrate_pages_batch(&folios, get_new_page, put_new_page, private,
> +					 mode, reason, &ret_folios, &split_folios, &stats,
> +					 NR_MAX_MIGRATE_PAGES_RETRY);
> +	else
> +		rc = migrate_pages_sync(&folios, get_new_page, put_new_page, private,
> +					mode, reason, &ret_folios, &split_folios, &stats);

For split folios, it seems also reasonable to use migrate_pages_sync() 
instead of always using fixed MIGRATE_ASYNC mode?

>   	list_splice_tail_init(&folios, &ret_folios);
>   	if (rc < 0) {
>   		rc_gather = rc;
