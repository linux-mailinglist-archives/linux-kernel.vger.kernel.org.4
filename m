Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CFD635F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiKWN3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbiKWN3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:29:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8239D59FD4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:08:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so16571529pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWi6mZ6IeIfeEPlOxAtZAyKjM4+f66dl3p7cvZ+Vbjw=;
        b=PlqoSWMckN11XHTkaubhJVgJXMz2nLNOmPEXd2vV/zYDGJ2FDSA56j6J+nk9NuLjyt
         drDUniAkW+0jUuX9t9XuTxTfwX/jBkgWqiL1tjCX0G7csowTj8fvqGda/cNtQqZCk/jc
         X1SGjHaIEs7mnu3bBm/QEIExcdv+Z3QuJvclyJ5MuRw+gsto+ujGdgf6huig9O98HV99
         U3DX1GOqPjuPN515mnoG/ukRHWdPDQQcG3Sk5yPaSIdrDInioNb5zIXYVypRoVJdNR2A
         k9G1ttM6O2l43q10jiQ7gNMk5g3Vf8YiK4XkTT9tnD2pk6foNyx43A+lZjl3s/nyooaF
         b+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWi6mZ6IeIfeEPlOxAtZAyKjM4+f66dl3p7cvZ+Vbjw=;
        b=koBoI5O4rRu8LhUnUOVjfIxKmySIxwJaOgDCIgqi7zjmtWOPL199nLEn0SbX2vyFcW
         IOub1RGIaDPujx22IS7WWLRtRRoVLz8fauKgKnswslB4A5CNLsj9EiMxxuDlzH+EmWIM
         zNtsFHDnbiqeoTcH/mpHYnr6hgLFfqcCYJiA1zabilv+IUKcsw/WZuHxThIJoj558qVc
         29/OSRo9Qofhg7DyNXcEjpU4hnS9xxG8uZ8w6ih6QF01nCX0aZp8WCb4ZT2+BHxr/ovp
         eKsdEOqNk0mdJm2RmzCUNLJ+EBzBAIut/WUOm4wS2QA9PV6sALQreS9L9rUkUW3ZDQgm
         EcgA==
X-Gm-Message-State: ANoB5pm/788h7tCY83ACcQDAbxkBAg9RztawCAp3oJWftpAUryPVqLN0
        zs0BqCpCRjxAt2sflfrWOD/uWtuR9/X+NdIbyDU=
X-Google-Smtp-Source: AA0mqf6MpV4so7yPLvjWQj5rT39uCbNMcyE8kgJItIUFlazg9K4P0R8ARpdSpcRWIZzmq14ZnNKHP2CWP0wiZGqKbAE=
X-Received: by 2002:a17:90a:fc7:b0:218:aefe:60e3 with SMTP id
 65-20020a17090a0fc700b00218aefe60e3mr15715903pjz.47.1669208896980; Wed, 23
 Nov 2022 05:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20221123123159.2325763-1-feng.tang@intel.com> <20221123123159.2325763-2-feng.tang@intel.com>
In-Reply-To: <20221123123159.2325763-2-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 23 Nov 2022 14:08:05 +0100
Message-ID: <CA+fCnZdCvsk-PST__zFrH0h1QNVYATEUAdLkq7WJpN-NXYj6EA@mail.gmail.com>
Subject: Re: [PATCH v2 -next 2/2] mm/kasan: simplify and refine kasan_cache code
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 1:35 PM Feng Tang <feng.tang@intel.com> wrote:
>
> struct 'kasan_cache' has a member 'is_kmalloc' indicating whether
> its host kmem_cache is a kmalloc cache. With newly introduced
> is_kmalloc_cache() helper, 'is_kmalloc' and its related function can
> be replaced and removed.
>
> Also 'kasan_cache' is only needed by KASAN generic mode, and not by
> SW/HW tag modes, so refine its protection macro accordingly, suggested
> by Andrey Konoval.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changlog:
>
>   Since v1
>   * Use CONFIG_KASAN_GENERIC instead of CONFIG_KASAN for 'kasan_cache',
>     as suggested by Andrey Konovalov
>
>  include/linux/kasan.h    | 22 +++++-----------------
>  include/linux/slab_def.h |  2 +-
>  include/linux/slub_def.h |  2 +-
>  mm/kasan/common.c        |  9 ++-------
>  mm/slab_common.c         |  1 -
>  5 files changed, 9 insertions(+), 27 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dff604912687..0ff382f79f80 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -96,15 +96,6 @@ static inline bool kasan_has_integrated_init(void)
>  }
>
>  #ifdef CONFIG_KASAN
> -
> -struct kasan_cache {
> -#ifdef CONFIG_KASAN_GENERIC
> -       int alloc_meta_offset;
> -       int free_meta_offset;
> -#endif
> -       bool is_kmalloc;
> -};
> -
>  void __kasan_unpoison_range(const void *addr, size_t size);
>  static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
>  {
> @@ -129,13 +120,6 @@ static __always_inline bool kasan_unpoison_pages(struct page *page,
>         return false;
>  }
>
> -void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
> -static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
> -{
> -       if (kasan_enabled())
> -               __kasan_cache_create_kmalloc(cache);
> -}
> -
>  void __kasan_poison_slab(struct slab *slab);
>  static __always_inline void kasan_poison_slab(struct slab *slab)
>  {
> @@ -252,7 +236,6 @@ static inline void kasan_poison_pages(struct page *page, unsigned int order,
>                                       bool init) {}
>  static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
>                                         bool init) { return false; }
> -static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
>  static inline void kasan_poison_slab(struct slab *slab) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>                                         void *object) {}
> @@ -303,6 +286,11 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>
>  #ifdef CONFIG_KASAN_GENERIC
>
> +struct kasan_cache {
> +       int alloc_meta_offset;
> +       int free_meta_offset;
> +};
> +
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
>  slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index f0ffad6a3365..39f7f1f95de2 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -72,7 +72,7 @@ struct kmem_cache {
>         int obj_offset;
>  #endif /* CONFIG_DEBUG_SLAB */
>
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>         struct kasan_cache kasan_info;
>  #endif
>
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index f9c68a9dac04..4e7cdada4bbb 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -132,7 +132,7 @@ struct kmem_cache {
>         unsigned int *random_seq;
>  #endif
>
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>         struct kasan_cache kasan_info;
>  #endif
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1f30080a7a4c..6e265beefc27 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -122,11 +122,6 @@ void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
>                              KASAN_PAGE_FREE, init);
>  }
>
> -void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
> -{
> -       cache->kasan_info.is_kmalloc = true;
> -}
> -
>  void __kasan_poison_slab(struct slab *slab)
>  {
>         struct page *page = slab_page(slab);
> @@ -326,7 +321,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
>         kasan_unpoison(tagged_object, cache->object_size, init);
>
>         /* Save alloc info (if possible) for non-kmalloc() allocations. */
> -       if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
> +       if (kasan_stack_collection_enabled() && !is_kmalloc_cache(cache))
>                 kasan_save_alloc_info(cache, tagged_object, flags);
>
>         return tagged_object;
> @@ -372,7 +367,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
>          * Save alloc info (if possible) for kmalloc() allocations.
>          * This also rewrites the alloc info when called from kasan_krealloc().
>          */
> -       if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
> +       if (kasan_stack_collection_enabled() && is_kmalloc_cache(cache))
>                 kasan_save_alloc_info(cache, (void *)object, flags);
>
>         /* Keep the tag that was set by kasan_slab_alloc(). */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8276022f0da4..a5480d67f391 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -663,7 +663,6 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
>
>         create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
>                                                                 usersize);
> -       kasan_cache_create_kmalloc(s);
>         list_add(&s->list, &slab_caches);
>         s->refcount = 1;
>         return s;
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
