Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C58063A957
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiK1NUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiK1NUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:20:20 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E90922D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:19:27 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c15so1127320pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2I2ksH5hcxruZfreywgq7pidAV/0mu8zfYab9h+BkA=;
        b=XK6ygKE5iglL7w95u3VCz7wr6UE81S0x4emEPBh90kiX3Oe0gnMON+2O9Gof9M/x5C
         c7DqpaX9PjNk20fK+KfSHQZ2ew5WkcAOFNL/JF9aXyRXjN9dbk3e8XuyICtCmHrf7KIf
         CcuGRUvZYdicuSLp+eIVcW/7uMHHoDkk2rNpPOJnu5pi1qxiUyjG/o/OYdhHrF2x9W6L
         Yt0oxSPtKSPnElk+5W8pt8HcFMubgrSmClSCrn3D2GqqVUtcD3XtO+A/Fcb1THKTmUw/
         gaWmPGLiHzlJRH4aho3sXXxwjtkSR6JTl0dnKc9/KDZb0ZkiZCKhO8ercLw+racUzrol
         ZHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2I2ksH5hcxruZfreywgq7pidAV/0mu8zfYab9h+BkA=;
        b=nhsJa7i2WRRCDM8pLW7hOo0WAQxtYnzZJhP/pyC4JHoQk+4FyUXd7AgqWeXjofY65C
         xXb9f6S5CeWNCIKuJRxafiyQqL1V6nE7ylnEHwu+enMc1COkCmpNRt1HwhlDmJQWkgqd
         pHWEchQUn+9kExjRKJyFGGVx9QbbjvuHKNj1gaZ9ossPo1DfGoO0ijna3liWq1b+XCnO
         V/n2foL2h8J6PE7HcvMDOeUf9Jbdg0vM0gp9LPv2aPL1TgQZ3riWsyJUGhgmmEPocYAy
         vUga1px0FjFJdw2jGZkRXjTjQwiqGJtM+AYQN/hk7c2SkRhWSOC//uNGWr0KpXY3w4IJ
         vfwQ==
X-Gm-Message-State: ANoB5pm7x0fFtxwmbNmzo9XAS7X/FXW5O4zeNHMxgZSSgS0aJ/76a6c3
        T5yEyZhmQlsOVPVMPKLTXdU=
X-Google-Smtp-Source: AA0mqf7DLSfwoEsdbA4QuKrOJVQUkrv+NqyBy5ZIm19QUA5xWknOkU8q6icj7VOL6HxmLj3MK9recg==
X-Received: by 2002:aa7:9388:0:b0:56d:4c7e:777a with SMTP id t8-20020aa79388000000b0056d4c7e777amr54006766pfe.0.1669641566562;
        Mon, 28 Nov 2022 05:19:26 -0800 (PST)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id t123-20020a625f81000000b005747b59fc54sm8271954pfb.172.2022.11.28.05.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:19:25 -0800 (PST)
Date:   Mon, 28 Nov 2022 22:19:19 +0900
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
Subject: Re: [PATCH 11/12] mm, slub: don't aggressively inline with
 CONFIG_SLUB_TINY
Message-ID: <Y4S1V9MNglgserVG@hyeyoo>
References: <20221121171202.22080-1-vbabka@suse.cz>
 <20221121171202.22080-12-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121171202.22080-12-vbabka@suse.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:12:01PM +0100, Vlastimil Babka wrote:
> SLUB fastpaths use __always_inline to avoid function calls. With
> CONFIG_SLUB_TINY we would rather save the memory. Add a
> __fastpath_inline macro that's __always_inline normally but empty with
> CONFIG_SLUB_TINY.
> 
> bloat-o-meter results on x86_64 mm/slub.o:
> 
> add/remove: 3/1 grow/shrink: 1/8 up/down: 865/-1784 (-919)
> Function                                     old     new   delta
> kmem_cache_free                               20     281    +261
> slab_alloc_node.isra                           -     245    +245
> slab_free.constprop.isra                       -     231    +231
> __kmem_cache_alloc_lru.isra                    -     128    +128
> __kmem_cache_release                          88      83      -5
> __kmem_cache_create                         1446    1436     -10
> __kmem_cache_free                            271     142    -129
> kmem_cache_alloc_node                        330     127    -203
> kmem_cache_free_bulk.part                    826     613    -213
> __kmem_cache_alloc_node                      230      10    -220
> kmem_cache_alloc_lru                         325      12    -313
> kmem_cache_alloc                             325      10    -315
> kmem_cache_free.part                         376       -    -376
> Total: Before=26103, After=25184, chg -3.52%
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 7f1cd702c3b4..d54466e76503 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -187,6 +187,12 @@ do {					\
>  #define USE_LOCKLESS_FAST_PATH()	(false)
>  #endif
>  
> +#ifndef CONFIG_SLUB_TINY
> +#define __fastpath_inline __always_inline
> +#else
> +#define __fastpath_inline
> +#endif
> +
>  #ifdef CONFIG_SLUB_DEBUG
>  #ifdef CONFIG_SLUB_DEBUG_ON
>  DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
> @@ -3386,7 +3392,7 @@ static __always_inline void maybe_wipe_obj_freeptr(struct kmem_cache *s,
>   *
>   * Otherwise we can simply pick the next object from the lockless free list.
>   */
> -static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
> +static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list_lru *lru,
>  		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
>  {
>  	void *object;
> @@ -3412,13 +3418,13 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>  	return object;
>  }
>  
> -static __always_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
> +static __fastpath_inline void *slab_alloc(struct kmem_cache *s, struct list_lru *lru,
>  		gfp_t gfpflags, unsigned long addr, size_t orig_size)
>  {
>  	return slab_alloc_node(s, lru, gfpflags, NUMA_NO_NODE, addr, orig_size);
>  }
>  
> -static __always_inline
> +static __fastpath_inline
>  void *__kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
>  			     gfp_t gfpflags)
>  {
> @@ -3733,7 +3739,7 @@ static void do_slab_free(struct kmem_cache *s,
>  }
>  #endif /* CONFIG_SLUB_TINY */
>  
> -static __always_inline void slab_free(struct kmem_cache *s, struct slab *slab,
> +static __fastpath_inline void slab_free(struct kmem_cache *s, struct slab *slab,
>  				      void *head, void *tail, void **p, int cnt,
>  				      unsigned long addr)
>  {
> -- 
> 2.38.1

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Thanks,
Hyeonggon
