Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186D8748466
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjGEMvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGEMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:51:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D99610EC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:51:09 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso4049625e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688561467; x=1691153467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=noF3Ta0PVHsT1dAI560cBu0m3xEmyMOxO2GSiAJv96w=;
        b=6+ZPkY1yjJwXTqbMFTMHCrK/T8datvgutZDhyMZnXhvNBxoAhfyIf+ANzHU6SA+iDF
         15NS7oWLkd9Dz2l5TeJzBOyR6g4cWuq7+9CRVGIlPqGmovYdrN46qlhvj2LMvArQl42N
         B90c3qixMrWpkPgNA6yM4gGINevXFByNktY/I8rXs4lmt0/ilHDdlYgMYQt5EM5USIO0
         TSfu6sRlGg/DMjejEgyIwHvQfF9dHhloReFNi8EKarKYcKCXCCa2PVpGXLJYojOIVHwk
         I8Mro2ud2P6fRx9BffNsFpWKrprg2At0+O0DS7a2oKpRCrgBFICFbsVqFSRIJJvCViGq
         kzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561467; x=1691153467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=noF3Ta0PVHsT1dAI560cBu0m3xEmyMOxO2GSiAJv96w=;
        b=eFg51KibGCfPjMATDPyHDXIhs0cGcD1kHgOXwyoqxT/Za0vq++SGViMXTeR+VWg1RN
         cKmeS/Sq4M2V3k+Yf1EQ4TxW8b8bgdTFoY6G0pUIpOlUMe9DoV0rsK4tk/pcVLPTIWCk
         kxyT8yJ+Qfd3C4z+MEh2s4UnB86lfbVs38AMufsT5VGRowprFWlfIYBDyNjtpxZpjaMN
         9yC+dc9ArxD56GvK1XfDZM7rpL0AF+1fAWo1bqJMvPu27/h0eRlIuSMgIPtAKVxmGnIO
         9vQii7WBMV18jbrF4o2DVSxysa1J/YEkLd2Veeg48tT1XHMlpEyRfOb8TvM5agIriE6g
         oNbw==
X-Gm-Message-State: AC+VfDw2I5Xy4xKenkXCaD77s6600lQNXVp7pw7yv6SuGCmsPTcZT6KY
        nndOonQO5TUNDw2Uywc6Q8QlML5Z/2LWNrpRpLjGew==
X-Google-Smtp-Source: ACHHUZ7mUyPyhRDfHd4CI2NmZWEHYRE1pLrvi+Khzyl+5wxz5EtXLb+GHQjp/Vq1Ggszq6SjK7AVmpc/kNaHlG+RQO8=
X-Received: by 2002:a1c:4c12:0:b0:3fb:b1af:a455 with SMTP id
 z18-20020a1c4c12000000b003fbb1afa455mr12792094wmf.5.1688561467416; Wed, 05
 Jul 2023 05:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com>
In-Reply-To: <678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 Jul 2023 14:50:30 +0200
Message-ID: <CANpmjNO+spktteYZezk7PGLFOyoeuFyziKiU-1GXbpeyKLZLPg@mail.gmail.com>
Subject: Re: [PATCH] kasan, slub: fix HW_TAGS zeroing with slub_debug
To:     andrey.konovalov@linux.dev
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Feng Tang <feng.tang@intel.com>, stable@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 14:44, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
> kmalloc space than requested") added precise kmalloc redzone poisoning
> to the slub_debug functionality.
>
> However, this commit didn't account for HW_TAGS KASAN fully initializing
> the object via its built-in memory initialization feature. Even though
> HW_TAGS KASAN memory initialization contains special memory initialization
> handling for when slub_debug is enabled, it does not account for in-object
> slub_debug redzones. As a result, HW_TAGS KASAN can overwrite these
> redzones and cause false-positive slub_debug reports.
>
> To fix the issue, avoid HW_TAGS KASAN memory initialization when slub_debug
> is enabled altogether. Implement this by moving the __slub_debug_enabled
> check to slab_post_alloc_hook. Common slab code seems like a more
> appropriate place for a slub_debug check anyway.
>
> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> Cc: <stable@vger.kernel.org>
> Reported-by: Mark Rutland <mark.rutland@arm.com>

Is it fixing this issue:

  https://lore.kernel.org/all/20230628154714.GB22090@willie-the-truck/

Or some other issue?

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Other than the question above, it looks sane:

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan.h | 12 ------------
>  mm/slab.h        | 16 ++++++++++++++--
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index b799f11e45dc..2e973b36fe07 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -466,18 +466,6 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
>
>         if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
>                 return;
> -       /*
> -        * Explicitly initialize the memory with the precise object size to
> -        * avoid overwriting the slab redzone. This disables initialization in
> -        * the arch code and may thus lead to performance penalty. This penalty
> -        * does not affect production builds, as slab redzones are not enabled
> -        * there.
> -        */
> -       if (__slub_debug_enabled() &&
> -           init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
> -               init = false;
> -               memzero_explicit((void *)addr, size);
> -       }
>         size = round_up(size, KASAN_GRANULE_SIZE);
>
>         hw_set_mem_tag_range((void *)addr, size, tag, init);
> diff --git a/mm/slab.h b/mm/slab.h
> index 6a5633b25eb5..9c0e09d0f81f 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -723,6 +723,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>                                         unsigned int orig_size)
>  {
>         unsigned int zero_size = s->object_size;
> +       bool kasan_init = init;
>         size_t i;
>
>         flags &= gfp_allowed_mask;
> @@ -739,6 +740,17 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>             (s->flags & SLAB_KMALLOC))
>                 zero_size = orig_size;
>
> +       /*
> +        * When slub_debug is enabled, avoid memory initialization integrated
> +        * into KASAN and instead zero out the memory via the memset below with
> +        * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
> +        * cause false-positive reports. This does not lead to a performance
> +        * penalty on production builds, as slub_debug is not intended to be
> +        * enabled there.
> +        */
> +       if (__slub_debug_enabled())
> +               kasan_init = false;
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_alloc and initialization memset must be
> @@ -747,8 +759,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>          * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
>          */
>         for (i = 0; i < size; i++) {
> -               p[i] = kasan_slab_alloc(s, p[i], flags, init);
> -               if (p[i] && init && !kasan_has_integrated_init())
> +               p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
> +               if (p[i] && init && (!kasan_init || !kasan_has_integrated_init()))
>                         memset(p[i], 0, zero_size);
>                 kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                          s->flags, flags);
> --
> 2.25.1
>
