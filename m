Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9E56327B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKUPTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiKUPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:19:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDB6CFEAB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:15:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w3-20020a17090a460300b00218524e8877so12232495pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4iomL/SuFm2qP/FaY1uaLFvnC19GQTDr6IrFZRdHZA=;
        b=RFEzHslJIPr3wKkoXOuVeTeiw7UtPt5iy5zU7+rfoTjUVr5qRjm/PWz/WqsxtxgOPj
         OPeYqCwIyS8doJX7QqnN8iDuTn2mDni7CkcEQerTHSevzpnozoEU2JEeGuiKLQrx8cd5
         85Fp6Y18uvvpYhRlVgLTipbyHch+XnBQFxiEt2A2uhAU9Xu+qu22MrbmoDg6+WsSn/wt
         xliA6Zt2TEqaGoXTAM+0xFRuJavVmM6B5YCmKiYZovnJQoNY5X1KOEnTOltkKGd2vsc+
         dddElnLPRCpen9DrgzTCdahGQhI94ZDiQm6KX7pmHCEjowj05LW7E/EoNKT4a3CqjLiQ
         GZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4iomL/SuFm2qP/FaY1uaLFvnC19GQTDr6IrFZRdHZA=;
        b=mmmEXIybaDeSmqXXppn+542ivv8Ovvil8pZzcQjc2A5C4JiOBU5J8dpZyPGtHykfVq
         fmX3iXe8YJz6jQRHG/uuBDQyizZHn1UcWpLj1KXAAGWYvYIvzgKsEY8qRyLsNIXcJRxE
         52clZ4TAbR3LgK1YkEyauUvTIe0z8Fro6XR+v2OZCiX47rM/+LjagXN3yfNQ/BRUCCG0
         uHRjrLx6nk38jpgyZnX31AD8k36txP5jDXsChqqfH+TYq0ksbdLFpjWJA2IFSf2nZCqt
         j9lMpTSfNQZWCfFqNerPu361FsdnkLNR8jwV/LEQRohhuaRwqapZkuQpEFb/BbolEyGm
         mXDA==
X-Gm-Message-State: ANoB5pkq63p6lZ3CsxUl48q0Iul3DF6s4PLcNdTTqW5KTGvOo/ksJV3b
        uNWbbBj7x102CiqWl13fWWinZKdq3v0sTi/vbQQ9StW3WBQ=
X-Google-Smtp-Source: AA0mqf71Kf/jCN7y1nl4PTcH28Uk6BtNQuC8mgTZ5dEqhq85VBIEuAvTzuT7TBYPlZmTLUdoBJeQryGeNjISQ9MLVhg=
X-Received: by 2002:a17:90a:5883:b0:218:f84:3f98 with SMTP id
 j3-20020a17090a588300b002180f843f98mr27389810pji.238.1669043743578; Mon, 21
 Nov 2022 07:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20221121135024.1655240-1-feng.tang@intel.com> <20221121135024.1655240-2-feng.tang@intel.com>
In-Reply-To: <20221121135024.1655240-2-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 21 Nov 2022 16:15:32 +0100
Message-ID: <CA+fCnZenKqb9_a2e5b25-DQ3uAKPgm=+tTDOP+D9c6wbDSjMNA@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] mm/kasan: simplify is_kmalloc check
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

On Mon, Nov 21, 2022 at 2:53 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Use new is_kmalloc_cache() to simplify the code of checking whether
> a kmem_cache is a kmalloc cache.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Hi Feng,

Nice simplification!

> ---
>  include/linux/kasan.h | 9 ---------
>  mm/kasan/common.c     | 9 ++-------
>  mm/slab_common.c      | 1 -
>  3 files changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index dff604912687..fc46f5d6f404 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -102,7 +102,6 @@ struct kasan_cache {
>         int alloc_meta_offset;
>         int free_meta_offset;
>  #endif
> -       bool is_kmalloc;
>  };

We can go even further here, and only define the kasan_cache struct
and add the kasan_info field to kmem_cache when CONFIG_KASAN_GENERIC
is enabled.

>
>  void __kasan_unpoison_range(const void *addr, size_t size);
> @@ -129,13 +128,6 @@ static __always_inline bool kasan_unpoison_pages(struct page *page,
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
> @@ -252,7 +244,6 @@ static inline void kasan_poison_pages(struct page *page, unsigned int order,
>                                       bool init) {}
>  static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
>                                         bool init) { return false; }
> -static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
>  static inline void kasan_poison_slab(struct slab *slab) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>                                         void *object) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1f30080a7a4c..f7e0e5067e7a 100644
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
> +       if (kasan_stack_collection_enabled() && is_kmalloc_cache(cache))
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
