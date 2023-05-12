Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB996FFF68
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 05:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239887AbjELDp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 23:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239902AbjELDpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 23:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA435581
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 20:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 450AB60DC0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 03:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E0C433D2;
        Fri, 12 May 2023 03:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683863138;
        bh=aIainonip+qTHVAfBQeJ+FebP9eJUCWa2fFmARG9MoA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wat+W9u7v76FAeSneppv2rF+l0B07wJ5+3MKSB7M8HkAYZ9iLOEgX5wgJgL8LWbJ4
         1cswwltkjvb94Tn+euoP2V3uzaXZ61/Zaef7zezZCCQ5Na0uxnoJmMYTsOLqh4Iex1
         JhXLZJT+iiugLjtWFLVawpl7DNjW9JCJmNjw2V7U=
Date:   Thu, 11 May 2023 20:45:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] mm, compaction: Skip all pinned pages during scan
Message-Id: <20230511204532.ceaf7adba0bc95d65372af07@linux-foundation.org>
In-Reply-To: <20230511165516.77957-1-khalid.aziz@oracle.com>
References: <20230511165516.77957-1-khalid.aziz@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 10:55:16 -0600 Khalid Aziz <khalid.aziz@oracle.com> wrote:

> Pinned pages can not be migrated. Currently as
> isolate_migratepages_block() scans pages for compaction, it skips
> any pinned anonymous pages. All pinned pages should be skipped and
> not just the anonymous pinned pages. This patch adds a check for
> pinned page by comparing its refcount with mapcount and accounts for
> possible extra refcounts. This was seen as a real issue on a
> customer workload where a large number of pages were pinned by vfio
> on the host and any attempts to allocate hugepages resulted in
> significant amount of cpu time spent in either direct compaction or
> in kcompatd scanning vfio pinned pages over and over again that can
> not be migrated.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  mm/compaction.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 5a9501e0ae01..d1371fd75391 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -764,6 +764,32 @@ static bool too_many_isolated(pg_data_t *pgdat)
>  	return too_many;
>  }
>  
> +/*
> + * Check if this base page should be skipped from isolation because
> + * it is pinned. This function is called for regular pages only, and not
> + * for THP or hugetlbfs pages. This code is inspired by similar code
> + * in migrate_vma_check_page(), can_split_folio() and
> + * folio_migrate_mapping()
> + */
> +static inline bool is_pinned_page(struct page *page)
> +{
> +	unsigned long extra_refs;
> +
> +	/* anonymous page can have extra ref from page cache */

"from swapcache"?

> +	if (page_mapping(page))
> +		extra_refs = 1 + page_has_private(page);
> +	else
> +		extra_refs = PageSwapCache(page) ? 1 : 0;
> +
> +	/*
> +	 * This is an admittedly racy check but good enough to determine
> +	 * if a page should be isolated

"cannot be migrated"?

> +	 */
> +	if ((page_count(page) - extra_refs) > page_mapcount(page))
> +		return true;
> +	return false;
> +}
> +
>  /**
>   * isolate_migratepages_block() - isolate all migrate-able pages within
>   *				  a single pageblock
> @@ -992,12 +1018,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>  			goto isolate_fail;
>  
>  		/*
> -		 * Migration will fail if an anonymous page is pinned in memory,
> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
> -		 * admittedly racy check.
> +		 * Migration will fail if a page is pinned in memory,
> +		 * so avoid taking lru_lock and isolating it unnecessarily
>  		 */
>  		mapping = page_mapping(page);
> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
> +		if (is_pinned_page(page))
>  			goto isolate_fail_put;
>  
>  		/*
> -- 
> 2.37.2
