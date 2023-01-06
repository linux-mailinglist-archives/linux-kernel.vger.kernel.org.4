Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613F660A38
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 00:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjAFXX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 18:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAFXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 18:23:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4226D77D0B
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 15:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0A8561F9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 23:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0AC433EF;
        Fri,  6 Jan 2023 23:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673047434;
        bh=3vR6NKS+8/yDQjacQCEJb90byWuxg5F7fZOgQOiReDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6hoVNwOsxR3O9WTuGhqKa+r81MHV/aTvBqWvil5PnvOy5xGqsZ9nMgVfiK9mGT5I
         r+XdOGgbyG75OkC1/VVdK+To2F5z7zoNXFTXt1csLg7QZqsWkTOW0KDDPQwcy86EDl
         xpbZmfWQuK+Ob6smVigQePpwaSh7IHgJlsHmFIJj3tjJIruOMEoGqyBxZ+2vYZRqq7
         6y42FY2OFq/avhdsaAV26tUoPv1m5eHiymgKti95A/rtEZD6iV8vjO8zrdtOBLvUWJ
         i9KmIwjAEoKdKXWOyZTsOaoOOCohixJvFM5wKeuOrVOoB4kPQy7U7LdawdCRVkMvEy
         fyuVr4ncJs40g==
From:   SeongJae Park <sj@kernel.org>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz, sj@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH mm-unstable] mm: introduce folio_is_pfmemalloc
Date:   Fri,  6 Jan 2023 23:23:52 +0000
Message-Id: <20230106232352.1520-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106215251.599222-1-sidhartha.kumar@oracle.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sidhartha,


On Fri, 6 Jan 2023 15:52:51 -0600 Sidhartha Kumar <sidhartha.kumar@oracle.com> wrote:

> Add a folio equivalent for page_is_pfmemalloc. This removes two instances
> of page_is_pfmemalloc(folio_page(folio, 0)) so the folio can be used
> directly.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  include/linux/mm.h | 15 +++++++++++++++
>  mm/slab.c          |  2 +-
>  mm/slub.c          |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index c37f9330f14e..79d5a0cbf4c3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1906,6 +1906,21 @@ static inline bool page_is_pfmemalloc(const struct page *page)
>  	return (uintptr_t)page->lru.next & BIT(1);
>  }
>  
> +/*
> + * Return true only if the folio has been allocated with
> + * ALLOC_NO_WATERMARKS and the low watermark was not
> + * met implying that the system is under some pressure.
> + */
> +static inline bool folio_is_pfmemalloc(const struct folio *folio)
> +{
> +	/*
> +	 * lru.next has bit 1 set if the page is allocated from the
> +	 * pfmemalloc reserves.  Callers may simply overwrite it if
> +	 * they do not need to preserve that information.
> +	 */
> +	return (uintptr_t)folio->lru.next & BIT(1);
> +}
> +
>  /*
>   * Only to be called by the page allocator on a freshly allocated
>   * page.
> diff --git a/mm/slab.c b/mm/slab.c
> index 7a269db050ee..01291ecbc0d8 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1373,7 +1373,7 @@ static struct slab *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  	/* Make the flag visible before any changes to folio->mapping */
>  	smp_wmb();
>  	/* Record if ALLOC_NO_WATERMARKS was set when allocating the slab */
> -	if (sk_memalloc_socks() && page_is_pfmemalloc(folio_page(folio, 0)))
> +	if (sk_memalloc_socks() && folio_is_pfmemalloc(folio))
>  		slab_set_pfmemalloc(slab);
>  
>  	return slab;
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..0cbe6eff23fa 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1859,7 +1859,7 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
>  	__folio_set_slab(folio);
>  	/* Make the flag visible before any changes to folio->mapping */
>  	smp_wmb();
> -	if (page_is_pfmemalloc(folio_page(folio, 0)))
> +	if (folio_is_pfmemalloc(folio))
>  		slab_set_pfmemalloc(slab);
>  
>  	return slab;
> -- 
> 2.39.0
> 
> 
