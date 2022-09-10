Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2832E5B4AC9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIJXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIJXLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:11:31 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E3D33347
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:11:30 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id g12so3458805qts.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jLcAZDQOWnQUWa/zS3ZhETCWwFUmZvMcvW1wH6uC4IQ=;
        b=kKI9Y/dPFSJwHLDiuiQWqjNNMjhCyEC8V1S4USUXFNjeHZGF9Zn78Bt6kDVLjHocBI
         DK8RqRrndEqsvUB5s46w8aV00WkG195asL5ML1DCBCfSRHXiNPpbHJxtJ9c5odZQEsrp
         3Xf3SDWGyNWnfzDkE6szl94+SwkZ1S1Bdl8zHQrStphM0cXSSsQduPun0GDfJh8mFzPi
         0Dm8DRqynE6wcTffvSVNrEY5bU2FqsLqUJG/r6kSbFtxpeE1+fqzEBvSsdA1c4XSVBkJ
         96p109S0N1+GRuwCnixAo6AxACnar2QLaInwtgTxH3FSwMZL+yXQ5G/IelbYGxDevbU3
         9eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jLcAZDQOWnQUWa/zS3ZhETCWwFUmZvMcvW1wH6uC4IQ=;
        b=uN7KWdX7NvmMJ3LEia+WW32MS86qJmV2vm4u/Dd71H3EyMRnxvdHk1+YMXP8NpkuUE
         OO5bSdwjeIkru2OCEodPgdRLJOn75sfsMV9diW6fIXdr6HU6iyOjQTInaYHOvrAQgGUk
         sVWVQXrL5gv43Wsc5yTeF9MJzdmNrT1zw4nji4WvhMgc9thmz5C0SMqjeCkXDMYd6ETV
         ScgYZaCVV1+13Dx6RQMMqsm1/T1ocBZ9KtJmWzr1R7yqO6Qawi98FrWUtOirPPysYMxR
         eP0kb0S+RDlDoZMkhAYc6yrSkuGjk2wRfDudoVQs05BsGLpgVNtldzp9q+rYZfExZ3+z
         oulQ==
X-Gm-Message-State: ACgBeo1RvCFADI+UubO7S0Pp0BPdwHqz5rohD2XocWDHekyK2CnIOT0H
        xi+4Ypj2T/ciZx8JYV6hnImGr5YK4QrH9q5N5Ac=
X-Google-Smtp-Source: AA6agR4u/97xa/Pmb0INvHCCAaWtQSAbkJM0/G/XmWbAS+CmgzasYU+TUZmO9xD4qFLYZfTiXWz25WrO1DvAzeIvuyc=
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id
 n15-20020a05622a11cf00b0035ba3690cc3mr7113419qtk.11.1662851489754; Sat, 10
 Sep 2022 16:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071023.3838692-1-feng.tang@intel.com> <20220907071023.3838692-3-feng.tang@intel.com>
In-Reply-To: <20220907071023.3838692-3-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 01:11:18 +0200
Message-ID: <CA+fCnZdSUi6mC1e42bztst2tvhc-sLZdnj=Sr=doqxOokXmwTg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
To:     Feng Tang <feng.tang@intel.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 9:10 AM Feng Tang <feng.tang@intel.com> wrote:
>
> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
>
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that sanity check could be added to
> the extra space later.
>
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.c | 6 +++---
>  mm/slab.h | 9 +++++++--
>  mm/slub.c | 6 +++---
>  3 files changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index a5486ff8362a..73ecaa7066e1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3253,7 +3253,7 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
>         init = slab_want_init_on_alloc(flags, cachep);
>
>  out:
> -       slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> +       slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
>         return objp;
>  }
>
> @@ -3506,13 +3506,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>          * Done outside of the IRQ disabled section.
>          */
>         slab_post_alloc_hook(s, objcg, flags, size, p,
> -                               slab_want_init_on_alloc(flags, s));
> +                               slab_want_init_on_alloc(flags, s), 0);
>         /* FIXME: Trace call missing. Christoph would like a bulk variant */
>         return size;
>  error:
>         local_irq_enable();
>         cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> -       slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +       slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>         kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
> diff --git a/mm/slab.h b/mm/slab.h
> index d0ef9dd44b71..20f9e2a9814f 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -730,12 +730,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>                                         struct obj_cgroup *objcg, gfp_t flags,
> -                                       size_t size, void **p, bool init)
> +                                       size_t size, void **p, bool init,
> +                                       unsigned int orig_size)
>  {
>         size_t i;
>
>         flags &= gfp_allowed_mask;
>
> +       /* If original request size(kmalloc) is not set, use object_size */
> +       if (!orig_size)
> +               orig_size = s->object_size;
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_alloc and initialization memset must be
> @@ -746,7 +751,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>         for (i = 0; i < size; i++) {
>                 p[i] = kasan_slab_alloc(s, p[i], flags, init);
>                 if (p[i] && init && !kasan_has_integrated_init())
> -                       memset(p[i], 0, s->object_size);
> +                       memset(p[i], 0, orig_size);

Arguably, with slab_want_init_on_alloc(), all allocated memory should
be zeroed to prevent possibility of info-leaks, even unused paddings.
Perhaps, Alexander can give his opinion here.

Thanks!


>                 kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                          s->flags, flags);
>         }
> diff --git a/mm/slub.c b/mm/slub.c
> index effd994438e6..f523601d3fcf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3376,7 +3376,7 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
>         init = slab_want_init_on_alloc(gfpflags, s);
>
>  out:
> -       slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
> +       slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
>
>         return object;
>  }
> @@ -3833,11 +3833,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
>          * Done outside of the IRQ disabled fastpath loop.
>          */
>         slab_post_alloc_hook(s, objcg, flags, size, p,
> -                               slab_want_init_on_alloc(flags, s));
> +                               slab_want_init_on_alloc(flags, s), 0);
>         return i;
>  error:
>         slub_put_cpu_ptr(s->cpu_slab);
> -       slab_post_alloc_hook(s, objcg, flags, i, p, false);
> +       slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
>         kmem_cache_free_bulk(s, i, p);
>         return 0;
>  }
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220907071023.3838692-3-feng.tang%40intel.com.
