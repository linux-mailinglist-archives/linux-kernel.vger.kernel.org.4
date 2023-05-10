Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EB6FD3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 03:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjEJBuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 21:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjEJBuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 21:50:17 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA563A9A
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 18:50:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ViDQE-W_1683683410;
Received: from 30.240.106.49(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0ViDQE-W_1683683410)
          by smtp.aliyun-inc.com;
          Wed, 10 May 2023 09:50:11 +0800
Message-ID: <3104080d-549b-8aa8-0265-371d4d33cfe6@linux.alibaba.com>
Date:   Wed, 10 May 2023 09:50:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] migrate_pages_batch: code cleanup: remove is_large
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Alistair Popple <apopple@nvidia.com>
References: <20230509022014.380493-1-ying.huang@intel.com>
 <20230509022014.380493-2-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20230509022014.380493-2-ying.huang@intel.com>
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
> Previously, in migrate_pages_batch we need to track whether the source
> folio is large/THP before splitting.  So is_large is used to cache
> folio_test_large() result.  Now, we don't need that variable any more
> because we don't count retrying and failure of large folios (only
> counting that of THP folios).  So, in this patch, is_large is removed
> to simplify the code.
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
>   mm/migrate.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 10709aed76d3..2ac927a82bbc 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1618,7 +1618,6 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   	int nr_failed = 0;
>   	int nr_retry_pages = 0;
>   	int pass = 0;
> -	bool is_large = false;
>   	bool is_thp = false;
>   	struct folio *folio, *folio2, *dst = NULL, *dst2;
>   	int rc, rc_saved = 0, nr_pages;
> @@ -1635,13 +1634,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   		nr_retry_pages = 0;
>   
>   		list_for_each_entry_safe(folio, folio2, from, lru) {
> -			/*
> -			 * Large folio statistics is based on the source large
> -			 * folio. Capture required information that might get
> -			 * lost during migration.
> -			 */
> -			is_large = folio_test_large(folio);
> -			is_thp = is_large && folio_test_pmd_mappable(folio);
> +			is_thp = folio_test_large(folio) && folio_test_pmd_mappable(folio);
>   			nr_pages = folio_nr_pages(folio);
>   
>   			cond_resched();
> @@ -1688,7 +1681,7 @@ static int migrate_pages_batch(struct list_head *from, new_page_t get_new_page,
>   				nr_failed++;
>   				stats->nr_thp_failed += is_thp;
>   				/* Large folio NUMA faulting doesn't split to retry. */
> -				if (is_large && !nosplit) {
> +				if (folio_test_large(folio) && !nosplit) {
>   					int ret = try_split_folio(folio, split_folios);
>   
>   					if (!ret) {
LGTM.
Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
