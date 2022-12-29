Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FDF65932B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiL2X23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiL2X2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56009167E4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 15:28:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3F5E61985
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E15C433EF;
        Thu, 29 Dec 2022 23:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672356503;
        bh=hN/O7/DsuJPZHbYIvsoTEdsXX7zDNtXmGUbeZYQ3mIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SUK0ZE5BGDKMs5/xALYV1saOFeKVO2nJ8FAJznkv7TQsU68qSa07W/sYlc1kPR6pj
         dytmpDxpqcnK3icXGgVcwh4PKI62Maekws6/7SIxfdhfet9Ps0PfqZd9YbEMq+BvTZ
         WFbuwIgw4im7BqFkB2o8w4LQjrikOasuiYlP1OVw=
Date:   Thu, 29 Dec 2022 15:28:22 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>
Subject: Re: [PATCH] mm: huge_memory: convert split_huge_pages_all() to use
 a folio
Message-Id: <20221229152822.a283198e5df331caaac88a55@linux-foundation.org>
In-Reply-To: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
References: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Dec 2022 20:25:03 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Straightforwardly convert split_huge_pages_all() to use a folio.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/huge_memory.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 266c4b557946..c8cbe7f62eaa 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2932,6 +2932,7 @@ static void split_huge_pages_all(void)
>  {
>  	struct zone *zone;
>  	struct page *page;
> +	struct folio *folio;
>  	unsigned long pfn, max_zone_pfn;
>  	unsigned long total = 0, split = 0;
>  
> @@ -2944,24 +2945,32 @@ static void split_huge_pages_all(void)
>  			int nr_pages;
>  
>  			page = pfn_to_online_page(pfn);
> -			if (!page || !get_page_unless_zero(page))
> +			if (!page || PageTail(page))
> +				continue;

Why is the PageTail() test added?

> +			folio = page_folio(page);
> +			if (!folio_try_get(folio))
>  				continue;
>  
> -			if (zone != page_zone(page))
> +			if (unlikely(page_folio(page) != folio))

And this?

> +				goto next;
> +
> +			if (zone != folio_zone(folio))
>  				goto next;
>  
> -			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
> +			if (!folio_test_large(folio)
> +				|| folio_test_hugetlb(folio)
> +				|| !folio_test_lru(folio))
>  				goto next;
>  
>  			total++;
> -			lock_page(page);
> -			nr_pages = thp_nr_pages(page);
> -			if (!split_huge_page(page))
> +			folio_lock(folio);
> +			nr_pages = folio_nr_pages(folio);
> +			if (!split_folio(folio))
>  				split++;
>  			pfn += nr_pages - 1;
> -			unlock_page(page);
> +			folio_unlock(folio);
>  next:
> -			put_page(page);
> +			folio_put(folio);
>  			cond_resched();
>  		}
>  	}

