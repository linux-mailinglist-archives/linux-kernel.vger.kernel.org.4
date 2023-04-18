Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610D36E57E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDRDiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDRDiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:38:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D346211C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhlSV7mwlecSkzDT1ht6NiuOggNho9wGWb49Qm4q5Uc=; b=b3nBOLBu3U2OnswmTGhD7y78cn
        njYxcT9bJC8E58gdiYUDpwiWjn6Swl7NwuIxeoy95MMxeY1w65jMh6W/BT2FZTX5vRBbnnb7Ytm/F
        1VorRdyadHj+qadmUYVjf+qyOQU84SYCEM0um+cSEq+GkTUid/ygFXdKoZQ6QTdWZYCql9kt1VLaw
        oRrA3b8RBNarmlM7rgM48n7oRab6KU+JnDFMqjYIJhWhRTY8qPk4OkqW0zFAWa////CiyZOkLNqhw
        bGlzhMVpwZ8irdZKuFU6GFlubxEas5Bx4FzedOEtkWjR33zeAh6k1QOqFGDtrQH7fTEyojwcuhu3w
        IuoxQnOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pocAi-00BvyK-OA; Tue, 18 Apr 2023 03:38:24 +0000
Date:   Tue, 18 Apr 2023 04:38:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: fix printk format within cma
Message-ID: <ZD4QsGd0DwHa83K1@casper.infradead.org>
References: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 11:33:09AM +0800, zhaoyang.huang wrote:
> cma and page pointer printed via %p are hash value which make debug to be hard.
> change them to %px.

Why does printing the page pointer make any sense at all?  Surely the
PFN makes much more sense.

> [63321.482751] [c7] cma: cma_alloc(): memory range at 000000000b5e462c is busy, retrying
> [63321.482786] [c7] cma: cma_alloc(): memory range at 000000000f7d6fae is busy, retrying
> [63321.482823] [c7] cma: cma_alloc(): memory range at 00000000e653b59b is busy, retrying
> [63322.378890] [c7] cma: cma_release(page 00000000dd53cf48)
> [63322.378913] [c7] cma: cma_release(page 00000000315f703d)
> [63322.378925] [c7] cma: cma_release(page 00000000791e3a5f)
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/cma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 4a978e0..dfe9813 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -435,7 +435,7 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  	if (!cma || !cma->count || !cma->bitmap)
>  		goto out;
>  
> -	pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)cma,
> +	pr_debug("%s(cma %px, count %lu, align %d)\n", __func__, (void *)cma,
>  		 count, align);
>  
>  	if (!count)
> @@ -534,7 +534,7 @@ bool cma_pages_valid(struct cma *cma, const struct page *pages,
>  	pfn = page_to_pfn(pages);
>  
>  	if (pfn < cma->base_pfn || pfn >= cma->base_pfn + cma->count) {
> -		pr_debug("%s(page %p, count %lu)\n", __func__,
> +		pr_debug("%s(page %px, count %lu)\n", __func__,
>  						(void *)pages, count);
>  		return false;
>  	}
> @@ -560,7 +560,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  	if (!cma_pages_valid(cma, pages, count))
>  		return false;
>  
> -	pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, count);
> +	pr_debug("%s(page %px, count %lu)\n", __func__, (void *)pages, count);
>  
>  	pfn = page_to_pfn(pages);
>  
> -- 
> 1.9.1
> 
> 
