Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178656657D0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjAKJmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbjAKJlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:41:10 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0413CC1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:36:51 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i65so7499713pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgxbe9iy/UIiGBDGt6X9MleqRSYp4HVx7CIEeTI4ufU=;
        b=UEEhg/SX/TFPKsEVPlR4oEk9BfADyFg+Ym5uadlWJdA88dymfbQzGUqUcv53K8Ot9S
         LEp/mjVABk63mEPJWe6twp4CnQX4OOte386K/jBXBW+qze5DQcEfgSzLZ/tD+MpZLCWd
         3Z0x67zTLBAUoSf5VT7ZcrdGrSuoNtT7m2M5H47O6pS+g9AyI13IGMhhYojTWkCETSLZ
         n2Us3htJCeH0cZhlEqifBRXkRUF4V6Dts9iPqfT8nTpIlGE8UKUraXaoI+cGizRUzwJ1
         dSOfxS50WvQ/pM8Q3FZDdJ1BEw5ew9Fn5+8sSsQBoj5pFNOHC1BQhvjCoxFKy6SS8dqg
         w5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgxbe9iy/UIiGBDGt6X9MleqRSYp4HVx7CIEeTI4ufU=;
        b=CJQAPysvEgj3HYbt1lyzQ40PnrZThswxoK+s7dy69iy6SZjF36e3+xe/XhJADptO0V
         3L4whuZPg5oEGYaP/+5Djn9HTs32GJUSyFKRGtbHBUpQh4GzOYvjWXJeJvkjCLI3j2nV
         exgfBSm7gubxxr/LYtjjAiBdH8Stqoh9wfRz6xIYvEBZk4CNopYD9o4Y0cQYgHzuKFU4
         nZb/6AZIcm+8WhnNEN8bSvEYWY/O+xVQ+w5a50sMdS+7nOwLQglEhuGgb86RMlNehE7x
         sbdKDLHTMnU3pDXunqfSaFwmh+sY+INFUFah3EUUnlKwYpAncbASoCrHWMVLONlqAAEv
         JNQQ==
X-Gm-Message-State: AFqh2krRa1PuS+NfLyyWlCSqXpvQKzvpffYRNwSfnzNXCDS0siiMFGiv
        LG5JsRgFaX46gUsr88YQaII=
X-Google-Smtp-Source: AMrXdXub5iyH1ER+/F6NZA6+AIJbsgt/6RPVVs6/bQTrKDKEAgPi27tls3bG1gM8jLpGoV+qdfLY9Q==
X-Received: by 2002:a05:6a00:72a:b0:57d:56f1:6ae7 with SMTP id 10-20020a056a00072a00b0057d56f16ae7mr60870508pfm.33.1673429810487;
        Wed, 11 Jan 2023 01:36:50 -0800 (PST)
Received: from localhost ([2400:8902::f03c:93ff:fe27:642a])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b005821db4fd84sm9536546pfk.131.2023.01.11.01.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:36:48 -0800 (PST)
Date:   Wed, 11 Jan 2023 09:36:44 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/sl{a,u}b: fix wrong usages of folio_page() for
 getting head pages
Message-ID: <Y76DLDEHyeyGTPD8@localhost>
References: <20230110005124.1609-1-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110005124.1609-1-sj@kernel.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 12:51:24AM +0000, SeongJae Park wrote:
> The standard idiom for getting head page of a given folio is
> '&folio->page', but some are wrongly using 'folio_page(folio, 0)' for
> the purpose.  Fix those to use the idiom.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/slab.c | 4 ++--
>  mm/slub.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index b77be9c6d6b1..a5398676dc60 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1389,7 +1389,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  
>  	BUG_ON(!folio_test_slab(folio));
>  	__slab_clear_pfmemalloc(slab);
> -	page_mapcount_reset(folio_page(folio, 0));
> +	page_mapcount_reset(&folio->page);
>  	folio->mapping = NULL;
>  	/* Make the mapping reset visible before clearing the flag */
>  	smp_wmb();
> @@ -1398,7 +1398,7 @@ static void kmem_freepages(struct kmem_cache *cachep, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += 1 << order;
>  	unaccount_slab(slab, order, cachep);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>  }
>  
>  static void kmem_rcu_free(struct rcu_head *head)
> diff --git a/mm/slub.c b/mm/slub.c
> index 67020074ecb4..d5f20c062004 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2066,7 +2066,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
>  	if (current->reclaim_state)
>  		current->reclaim_state->reclaimed_slab += pages;
>  	unaccount_slab(slab, order, s);
> -	__free_pages(folio_page(folio, 0), order);
> +	__free_pages(&folio->page, order);
>  }
>  
>  static void rcu_free_slab(struct rcu_head *h)
> -- 
> 2.25.1
> 
>

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!
