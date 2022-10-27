Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79014610196
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiJ0T1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbiJ0T1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:27:20 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF9785A1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:27:19 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u132so3581330oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o482CCSS2t5cpOMDg/QGNflnp9GjmK74VY4pwqBErkk=;
        b=QcfHLCvLcdDcNSS9JcyWsrQWJbT7Jc+6SF6HcUvkKjgVVCcFVUFqO3HlWPWjne7V1C
         gfT0VPSund4Lr96tMV2GhVNUM2EpbX3YbJ5oiuvdPTXqTogbHDCxJ9dMNP2wTKUvk3J2
         uvFr94PoHHx/dwlKsNTzbl5h7lPXaU0KqF/Yz7GZrwakBovHByDYxp3xEMzsGlvJM+Qe
         tZ6yn8P/Q+mferkMK7XA6MCteWeO+Uoh2lgErz52R6Lat2RdgRT3zwMDXG819D7VF5M2
         Mf6WLUjdNy06VyNf2e80/6nEgMGasSxg+BwmRPnSjoFWxYOfwt6+vepFfjb1riDcmxyg
         kB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o482CCSS2t5cpOMDg/QGNflnp9GjmK74VY4pwqBErkk=;
        b=6tgLMD0fYt/Y5JSxP+3PhrQwK0f9+bIZq1NbtlGbBQKh0WahC4DrbWdR+Cgb+IYkiG
         F2isF4I+BpLtEia/IbQ8FuMepoTvPFSSDAJ6FOd/ItG57Bb4kIjXqDbphQ3VB+6o8R3U
         iDJouvlG+zc1ZgO+dVrJ/cFIxIF/ZciQNzFwhpe5LhN2oTPsMpsy66Bi/ukWAcLLQ/Kc
         Pp/3mk8G0KXedCYg8Q6dTZKDZfmo3Vf4BaCTdkjFJ/rO3JHY3033KRQ51eqcd9hgF4El
         9HF6b4CeW8Inj/ecTN+swGates+pqsjLI9lL6KF8awAGg3KO7opPCcObX+YMtItt360o
         myTQ==
X-Gm-Message-State: ACrzQf15x7xipYfbfS7SQCQyszb7vNl3fC3Einzmjbi520NnXiB6sEM9
        mOrvMWMG5M2pRCAwVRUMKx8a6az22JMFHs1h/Hg=
X-Google-Smtp-Source: AMsMyM4b1HQd3inUE2h4UCjePESVxawpcJmPy1KHG+3ZdeaLK6CDEkcNyyBshtmKKT4N0IYLmhagnRYn5aIUr/lE+3U=
X-Received: by 2002:a05:6808:1404:b0:355:4cd4:b10b with SMTP id
 w4-20020a056808140400b003554cd4b10bmr5744997oiv.207.1666898838501; Thu, 27
 Oct 2022 12:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221021032405.1825078-1-feng.tang@intel.com> <20221021032405.1825078-2-feng.tang@intel.com>
In-Reply-To: <20221021032405.1825078-2-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 27 Oct 2022 21:27:07 +0200
Message-ID: <CA+fCnZcx4TP7Sn28XMxJL09_K_nzZyZe1xt_Zhoh+61h=5xneQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] mm/slub: only zero requested size of buffer for
 kzalloc when debug enabled
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
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
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

On Fri, Oct 21, 2022 at 5:24 AM Feng Tang <feng.tang@intel.com> wrote:
>
> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
>
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that redzone sanity check could be
> added to the extra space later.
>
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more when debug is enabled. (Thanks to Kees Cook's effort to
> sanitize all ksize() user cases [1], this won't be a big issue).
>
> [1]. https://lore.kernel.org/all/20220922031013.2150682-1-keescook@chromium.org/#r
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.c |  7 ++++---
>  mm/slab.h | 18 ++++++++++++++++--
>  mm/slub.c | 10 +++++++---
>  3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index a5486ff8362a..4594de0e3d6b 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3253,7 +3253,8 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>         init = slab_want_init_on_alloc(flags, cachep);
>
>  out:
> -       slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +       slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init,
> +                               cachep->object_size);
>         return objp;
>  }
>
> @@ -3506,13 +3507,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>          * Done outside of the IRQ disabled section.
>          */
>         slab_post_alloc_hook(s, objcg, flags, size, p,
> -                               slab_want_init_on_alloc(flags, s));
> +                       slab_want_init_on_alloc(flags, s), s->object_size);
>         /* FIXME: Trace call missing. Christoph would like a bulk variant */
>         return size;
>  error:
>         local_irq_enable();
>         cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -       slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +       slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>         kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index 0202a8c2f0d2..8b4ee02fc14a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -720,12 +720,26 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>                                         struct obj_cgroup *objcg, gfp_t flags,
> -                                       size_t size, void **p, bool init)
> +                                       size_t size, void **p, bool init,
> +                                       unsigned int orig_size)
>  {
> +       unsigned int zero_size = s->object_size;
>         size_t i;
>
>         flags &= gfp_allowed_mask;
>
> +       /*
> +        * For kmalloc object, the allocated memory size(object_size) is likely
> +        * larger than the requested size(orig_size). If redzone check is
> +        * enabled for the extra space, don't zero it, as it will be redzoned
> +        * soon. The redzone operation for this extra space could be seen as a
> +        * replacement of current poisoning under certain debug option, and
> +        * won't break other sanity checks.
> +        */
> +       if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
> +           (s->flags & SLAB_KMALLOC))
> +               zero_size = orig_size;
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_alloc and initialization memset must be
> @@ -736,7 +750,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>         for (i = 0; i < size; i++) {
>                 p[i] = kasan_slab_alloc(s, p[i], flags, init);
>                 if (p[i] && init && !kasan_has_integrated_init())
> -                       memset(p[i], 0, s->object_size);
> +                       memset(p[i], 0, zero_size);
>                 kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                          s->flags, flags);
>                 kmsan_slab_alloc(s, p[i], flags);
> diff --git a/mm/slub.c b/mm/slub.c
> index 12354fb8d6e4..17292c2d3eee 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3395,7 +3395,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>         init = slab_want_init_on_alloc(gfpflags, s);
>
>  out:
> -       slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +       /*
> +        * When init equals 'true', like for kzalloc() family, only
> +        * @orig_size bytes will be zeroed instead of s->object_size
> +        */
> +       slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>
>         return object;
>  }
> @@ -3852,11 +3856,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>          * Done outside of the IRQ disabled fastpath loop.
>          */
>         slab_post_alloc_hook(s, objcg, flags, size, p,
> -                               slab_want_init_on_alloc(flags, s));
> +                       slab_want_init_on_alloc(flags, s), s->object_size);
>         return i;
>  error:
>         slub_put_cpu_ptr(s->cpu_slab);
> -       slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +       slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
>         kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
> --
> 2.34.1
>

For the KASAN part:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
