Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E7637179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKXEZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiKXEZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:25:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CEC9ABD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ARI/pAXuozIsa/5PtEK9I/KIIipzW+PxI1+kaLb328A=; b=H5CAv9Z+wnZ7BI/YJrxryjfUU7
        7QsrwnB7u9Q6yO4cSgpIr+fDqGaQucxq518AmWN4Bf6uFMS6itdqHHNgE/swvOg9WSPFmE2K+Ea8V
        VAXznQ20BSkS2GlGDhp3rhvvJOdUyUmwiBr4VnfOQzPdO4GXaOyLcFOgJseW+vO5K/601WEHOowKM
        b9UNOzc5DNCcolnwEzH397znXt+WPDDtEAa2URoA/hFfNyml03dQQyKwRcjkuRsolhSFae5Okx6oF
        PjJDdhCfUG4oFz+yAj0+DGS6RhB9ey4myZqe3GEJCJ+GrLUKdcvMeyf0Q2QMuz03gpJwICR9OSlPJ
        YPZ7Gc5g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy3nh-008NCq-Ea; Thu, 24 Nov 2022 04:25:25 +0000
Date:   Thu, 24 Nov 2022 04:25:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Add check for KMEM_CACHE
Message-ID: <Y37yNRs/43WKnHxO@casper.infradead.org>
References: <20221124040226.17953-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124040226.17953-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:02:26PM +0800, Jiasheng Jiang wrote:
> As KMEM_CACHE may return NULL pointer, it should
> be better to check the return value in order to
> avoid NULL pointer dereference in kmem_cache_zalloc.

You've made the code more complex.  And for what?  If that
call fails, the system will not boot under any circumstances.

NAK this patch, and any more like it.

> Fixes: 68ad4a330433 ("mm/vmalloc.c: keep track of free blocks for vmap allocation")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  mm/vmalloc.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ccaa461998f3..df3e59f614cc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2426,15 +2426,17 @@ void __init vmalloc_init(void)
>  	}
>  
>  	/* Import existing vmlist entries. */
> -	for (tmp = vmlist; tmp; tmp = tmp->next) {
> -		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> -		if (WARN_ON_ONCE(!va))
> -			continue;
> +	if (!WARN_ON_ONCE(!vmap_area_cachep)) {
> +		for (tmp = vmlist; tmp; tmp = tmp->next) {
> +			va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
> +			if (WARN_ON_ONCE(!va))
> +				continue;
>  
> -		va->va_start = (unsigned long)tmp->addr;
> -		va->va_end = va->va_start + tmp->size;
> -		va->vm = tmp;
> -		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +			va->va_start = (unsigned long)tmp->addr;
> +			va->va_end = va->va_start + tmp->size;
> +			va->vm = tmp;
> +			insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
> +		}
>  	}
>  
>  	/*
> -- 
> 2.25.1
> 
> 
