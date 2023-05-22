Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DEF70B401
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 06:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEVEIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 00:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEVEIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 00:08:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5A4DB
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0/snmGSuIpgVM93/uzUSc6arNhFDyaJVOF59ybeoIhM=; b=rtEMEeQlFvw19x+165/zWMjt+1
        4pXC2vcvKDZG1H6x8xWBBAbhNyDk8RSnjUivwdVgbtYpSIpiOS9FZ4I3u/pzrl8FzWxfi9gVSNuvw
        2D+qNY9EMovdN6SfvIfToN3/pp0ZvzP9x9frTSGbNOEh05pNp9LRgvWMwXgK1S3YNWkM/taSVfdhI
        5ioXaxvWspeLaHFIGpcPtXVNjZ+WR2I7fCyRVHitOknBub7dr8SY0AYyjjwdqAzbbRfcHXqpU6INr
        q4wB0b36VSOfDIDzqoKwMhIjijC6ohcO5DaCYisXfNUq6GTZzo4apCxjFVCGjGEQU9g3mmZ+J95aX
        UrMxiioA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q0wps-008kKO-1i; Mon, 22 May 2023 04:07:52 +0000
Date:   Mon, 22 May 2023 05:07:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv3] mm: skip CMA pages when they are not available
Message-ID: <ZGrqmOfdnhSz9sq9@casper.infradead.org>
References: <1684724882-22266-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1684724882-22266-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 11:08:02AM +0800, zhaoyang.huang wrote:
> +static bool skip_cma(struct page *page, struct scan_control *sc)
> +{
> +	if (!current_is_kswapd() && gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE
> +		&& get_pageblock_migratetype(page) == MIGRATE_CMA)
> +		return true;

Putting the 'return' at the same level of indentation as the second half
of the conditional is wrong.  It confuses the reader.  Also, the &&
needs to go at the end of the line not the beginning (read the
codingstyle documentation!)  Also there's no good reason to use such
long lines.  ie do this instead:

	if (!current_is_kswapd() &&
			gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
			get_pageblock_migratetype(page) == MIGRATE_CMA)
		return true;

if you prefer, this style of indent is also acceptable:

	if (!current_is_kswapd() &&
	    gfp_migratetype(sc->gfp_mask) != MIGRATE_MOVABLE &&
	    get_pageblock_migratetype(page) == MIGRATE_CMA)
		return true;

> @@ -2225,10 +2242,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  	unsigned long nr_skipped[MAX_NR_ZONES] = { 0, };
>  	unsigned long skipped = 0;
>  	unsigned long scan, total_scan, nr_pages;
> +	struct page *page;

No, don't do this.

>  	LIST_HEAD(folios_skipped);
>  
>  	total_scan = 0;
>  	scan = 0;
> +

Don't add this completely unrelated whitespace change either.

>  	while (scan < nr_to_scan && !list_empty(src)) {
>  		struct list_head *move_to = src;
>  		struct folio *folio;
> @@ -2239,12 +2258,14 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
>  		nr_pages = folio_nr_pages(folio);
>  		total_scan += nr_pages;
>  
> -		if (folio_zonenum(folio) > sc->reclaim_idx) {
> +		page = &folio->page;
> +
> +		if (folio_zonenum(folio) > sc->reclaim_idx
> +			|| skip_cma(page, sc)) {

Again, this is not where the || goes.

And skip_cma() should take a folio, not a page.  It's unreasonable
to ask you to convert get_pageblock_migratetype(),
get_pfnblock_flags_mask(), __get_pfnblock_flags_mask(), etc to
use a folio (... although someone looking for a project could do that
...).  Instead, you should do the folio->page conversion inside
skip_cma().

>  			nr_skipped[folio_zonenum(folio)] += nr_pages;
>  			move_to = &folios_skipped;
>  			goto move;
>  		}
> -

No unnecessary whitespace changes.

