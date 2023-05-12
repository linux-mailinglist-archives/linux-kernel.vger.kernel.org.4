Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03DB700C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 17:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241492AbjELPxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbjELPxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 11:53:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB73C2F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 08:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9PtRxZ5aZFbDSn+K6JjNYaJc4xVjLjlpJ8ds1gSxwQc=; b=l5AHP/BXmHK3iaUJnWAkTMjbSZ
        oZ0XRVbKepuGju6sGxIsUZXQOBdC7+Cyqz9/qbrX7v7dB2GAYxO7LuoZeXa1qnfpn6xPB/6DJdD3U
        qnf8YrB84PiKTLBmGiSxLPIhjdLAGduMoJRe8vH7FHOnk1aSlJwDCCK7u+GMbkLQQpr62rZhwMC6q
        IfPizzLXzicavrPhqrqyWJEq3dTLW0EdL7hu8if5UqE8Oza5rlABFHMSLoMxuvDfmpMvi1XjM47Hz
        C85CFJEhXNod9iu4sTWt/0Uksz/wZOUTiUK3G8E8V/rnrVj/T3OhXhOmjaLL1Hvl1JIXLVlUoIYXI
        8qa0qz0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pxV4o-000oxB-53; Fri, 12 May 2023 15:53:02 +0000
Date:   Fri, 12 May 2023 16:53:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH] mm, compaction: Skip all pinned pages during scan
Message-ID: <ZF5g3p+FFc4Gkw69@casper.infradead.org>
References: <20230511165516.77957-1-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511165516.77957-1-khalid.aziz@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 10:55:16AM -0600, Khalid Aziz wrote:
> +/*
> + * Check if this base page should be skipped from isolation because
> + * it is pinned. This function is called for regular pages only, and not
> + * for THP or hugetlbfs pages. This code is inspired by similar code
> + * in migrate_vma_check_page(), can_split_folio() and
> + * folio_migrate_mapping()
> + */
> +static inline bool is_pinned_page(struct page *page)

... yet another reminder this file hasn't been converted to folios :-(
This part is particularly hard because we don't have a refcount on the
page yet, so it may be allocated or freed while we're looking at it
which means we can't use folios _here_ because the Tail flag may get
set which would cause the folio code to drop BUGs all over us.

> +{
> +	unsigned long extra_refs;
> +
> +	/* anonymous page can have extra ref from page cache */
> +	if (page_mapping(page))

We already did the work of calling page_mapping() in the caller.
Probably best to pass it in here.

> +		extra_refs = 1 + page_has_private(page);

page_has_private() is wrong.  That's for determining if we need to call
the release function.  Filesystems don't increment the refcount when
they set PG_private_2.  This should just be PagePrivate().

> +	else
> +		extra_refs = PageSwapCache(page) ? 1 : 0;
> +
> +	/*
> +	 * This is an admittedly racy check but good enough to determine
> +	 * if a page should be isolated
> +	 */
> +	if ((page_count(page) - extra_refs) > page_mapcount(page))

page_count() includes a hidden call to compound_head(); you probably
meant page_ref_count() here.

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

"pinned" now has two meanings when applied to pages, alas.  Better to
say "If there are extra references to this page beyond those from the
page/swap cache and page tables".

So it's probably also unwise to call it is_pinned_page().  Maybe

		if (page_extra_refcounts(page)) ?
