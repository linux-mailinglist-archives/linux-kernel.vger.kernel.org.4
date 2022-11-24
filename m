Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4186379DB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKXNXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKXNXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:23:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7478CF1A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:23:51 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id a16so1220200pfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8y/808AEnHwi3gKJBM+uetYeo4u9vQ49H82jeAEWhHU=;
        b=V+QjrA/U7ScHxJ9ZYpE7O3RSWmSkzchs2ANjV8VzLrCCY/niTxtyQWGpPbyM9XkmyW
         WUZzaMIhKqFZFU8oxa222F3tpEq3Y1YS3msg7uTrIWc7lZ5zVT2Av3x39VFIhcPpBlAk
         G0hZmwyYAAjE6+KaJbFb3EiDMmTQzATe/MJ+UHCfocUWVLNcKAVFKgrP36sOAkUgFzeN
         HMPL3Zi3SO02hDye9/9wyECt8ctuhmRJx2U+jb9AdWcny/T0kfhMZgTavulYELFx/8oW
         VsVdiUQYGBOJ3nWlF4RTajvzflna4ZgeRJ+Q76rY2eJeasSHYJVyRRfSiXuq/KwD/6Ym
         Brfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y/808AEnHwi3gKJBM+uetYeo4u9vQ49H82jeAEWhHU=;
        b=3Bc13o53dJt4zeE18YSp2Zo+axZsONqqNVKjQ+Apuu4Bre66FbhOUxMQzXTNzPD4KK
         oC+5CVZHMGUhw0ElPP2iNzqW+m9Tu5Meu1COZ2/D0MEa5d9kAfrIbQq+g3QoIH0YNhRp
         gH/AP4BgoS8xZwH/ylbOwS7WmAJAhzYRROFcNEd9ke99rG/2ILn4PbG3MHuEu8y5WlL3
         SNwI1qmjKnz0V9wPE+aBRdZJXRkqxfGXcsmPur60PAfO2dCCL4yJcJEiLECQpDr87hNc
         n5jSAuTEia69iRQjbe01oSyl1+YoJdWjrcM4aKCaMDQpSx5radL+I5BijEk4vaRCaJhW
         woaQ==
X-Gm-Message-State: ANoB5plhL8TzoL/3T2yqXNDMxXy1KS5BzX0mkhVWHhqsM97Gh+a97Pho
        KDFQZqu011I2MQMwBKdEUPc=
X-Google-Smtp-Source: AA0mqf4TyZNNwzl3rHjI/din13NVJjNuRxJ1olfSN/enVVVxr/ZPBliA6gHtprrBtvgwnZY7JQPUMg==
X-Received: by 2002:a63:4c4b:0:b0:46f:f112:e782 with SMTP id m11-20020a634c4b000000b0046ff112e782mr11630314pgl.219.1669296230710;
        Thu, 24 Nov 2022 05:23:50 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id ik16-20020a170902ab1000b00172f6726d8esm1229687plb.277.2022.11.24.05.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:23:49 -0800 (PST)
Date:   Thu, 24 Nov 2022 22:23:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
 CONFIG_SLUB_TINY
Message-ID: <Y39wYPl5y3apKbD2@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-7-vbabka@suse.cz>
 <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77498f8-b15f-9dae-1803-2d2bbb99da50@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 02:53:43PM +0100, Vlastimil Babka wrote:
> On 11/21/22 18:11, Vlastimil Babka wrote:
> > Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
> > by grouping pages by mobility, but on tiny systems the extra memory
> > overhead of separate set of kmalloc-rcl caches will probably be worse,
> > and mobility grouping likely disabled anyway.
> > 
> > Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
> > regular ones.
> > 
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Fixed up in response to lkp report for a MEMCG_KMEM+SLUB_TINY combo:
> ---8<---
> From c1ec0b924850a2863d061f316615d596176f15bb Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 15 Nov 2022 18:19:28 +0100
> Subject: [PATCH 06/12] mm, slub: don't create kmalloc-rcl caches with
>  CONFIG_SLUB_TINY
> 
> Distinguishing kmalloc(__GFP_RECLAIMABLE) can help against fragmentation
> by grouping pages by mobility, but on tiny systems the extra memory
> overhead of separate set of kmalloc-rcl caches will probably be worse,
> and mobility grouping likely disabled anyway.
> 
> Thus with CONFIG_SLUB_TINY, don't create kmalloc-rcl caches and use the
> regular ones.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h |  9 +++++++--
>  mm/slab_common.c     | 10 ++++++++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 45efc6c553b8..ae2d19ec8467 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -336,12 +336,17 @@ enum kmalloc_cache_type {
>  #endif
>  #ifndef CONFIG_MEMCG_KMEM
>  	KMALLOC_CGROUP = KMALLOC_NORMAL,
> -#else
> -	KMALLOC_CGROUP,
>  #endif
> +#ifdef CONFIG_SLUB_TINY
> +	KMALLOC_RECLAIM = KMALLOC_NORMAL,
> +#else
>  	KMALLOC_RECLAIM,
> +#endif
>  #ifdef CONFIG_ZONE_DMA
>  	KMALLOC_DMA,
> +#endif
> +#ifdef CONFIG_MEMCG_KMEM
> +	KMALLOC_CGROUP,
>  #endif
>  	NR_KMALLOC_TYPES
>  };
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a8cb5de255fc..907d52963806 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -770,10 +770,16 @@ EXPORT_SYMBOL(kmalloc_size_roundup);
>  #define KMALLOC_CGROUP_NAME(sz)
>  #endif
>  
> +#ifndef CONFIG_SLUB_TINY
> +#define KMALLOC_RCL_NAME(sz)	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #sz,
> +#else
> +#define KMALLOC_RCL_NAME(sz)
> +#endif
> +
>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>  {								\
>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
> -	.name[KMALLOC_RECLAIM] = "kmalloc-rcl-" #__short_size,	\
> +	KMALLOC_RCL_NAME(__short_size)				\
>  	KMALLOC_CGROUP_NAME(__short_size)			\
>  	KMALLOC_DMA_NAME(__short_size)				\
>  	.size = __size,						\
> @@ -859,7 +865,7 @@ void __init setup_kmalloc_cache_index_table(void)
>  static void __init
>  new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
>  {
> -	if (type == KMALLOC_RECLAIM) {
> +	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {

for consistency this can be:
	if (IS_ENABLED(CONFIG_SLUB_TINY) && (type == KMALLOC_RECLAIM)) {

But yeah, it's not a big deal.

>  		flags |= SLAB_RECLAIM_ACCOUNT;
>  	} else if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_CGROUP)) {
>  		if (mem_cgroup_kmem_disabled()) {
> -- 
> 2.38.1
> 

For either case:

Looks good to me.
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
