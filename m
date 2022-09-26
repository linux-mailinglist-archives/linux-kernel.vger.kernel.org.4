Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258255EB0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIZTLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIZTLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:11:38 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF456C76B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:11:36 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id j10so4742271qtv.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3CHGQtxrUEIPS7Vs0U1v3kZ+VKfNuIhTmwS0yCWeTpg=;
        b=lAXDle+Su5iIedDI7FHXawnjl90dFeb1jZZaEPLHvRqdvvLrpUFwWpTAVY25fmLQOo
         4UqnDHubQ2DL2NHIOND/oVWuuaaSS+tciU+nOIxjS66briKaoAMQhA/JsKJviEKHvpxK
         VoPhicVo4xeTSbj2FA6e/hcVCo+SjHlYV/1P+UnTM8YYfh8ghN2IF6fIWx03f5a9TxRv
         6rkfg0ti3tFPPZL6UaFZo/oabotXj2vQiVmGBuR5HR6780yknHkNlCMI5gIPm1D5uq0m
         +/1kW8l+XDPDs1nHJ3tGf4jjFOuSoexparptDEGwvXta01vU2fbTTkEJpO59bhDpHQ8t
         BxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3CHGQtxrUEIPS7Vs0U1v3kZ+VKfNuIhTmwS0yCWeTpg=;
        b=VJs/NnlWV4QvHnnVw/M1FpeygxxL3efoTpV79cLCLm8U67V0IBbVIJxGX7xF1sVc1J
         cQOA/pc3N/cSmqIGQw9/w92i3dUIv89YnBm+Ys1n4yPdazGk3pxdMCBPR06sBTXnjPYq
         pP2vZqtaHX9XOq1KSijW0EZab9P8X9yejhnFJ9KKHUywaTWF716pVMJgcyjZ8UJ92S6i
         yahSdW3nPR450r23bus7YSymWinMuDJpkiWdDlAmj1B1QuH/r/83R8zSc3midwZHLAuJ
         ntpHE31CFaIzOhjQGrzGWRoZ0VEaY5L1MPIDayLQ49b6AMMVwovedjdm99pxaOtwTrmG
         UZwA==
X-Gm-Message-State: ACrzQf1oyDLVZXLEsHQKo/BFBhdTNSOkKRoaiuhfKBxTudcEojSXpKpP
        jI3r9JkDDEOqpF/2nA/rxrPXznBLdIZ3GA+V3Qg=
X-Google-Smtp-Source: AMsMyM4DxEiz89ji3Lc5oRG5694dzQn/VGO0wux19LGYCQ/Ji2nrHLaaP4YOTlHUNfaV/dsBpicKj5oVEOjyRVFPt+8=
X-Received: by 2002:a05:622a:11cf:b0:35b:a369:cc3 with SMTP id
 n15-20020a05622a11cf00b0035ba3690cc3mr19317849qtk.11.1664219495572; Mon, 26
 Sep 2022 12:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220913065423.520159-1-feng.tang@intel.com> <20220913065423.520159-3-feng.tang@intel.com>
In-Reply-To: <20220913065423.520159-3-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 26 Sep 2022 21:11:24 +0200
Message-ID: <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
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
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
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

On Tue, Sep 13, 2022 at 8:54 AM Feng Tang <feng.tang@intel.com> wrote:
>

Hi Feng,

> kzalloc/kmalloc will round up the request size to a fixed size
> (mostly power of 2), so the allocated memory could be more than
> requested. Currently kzalloc family APIs will zero all the
> allocated memory.
>
> To detect out-of-bound usage of the extra allocated memory, only
> zero the requested part, so that sanity check could be added to
> the extra space later.

I still don't like the idea of only zeroing the requested memory and
not the whole object. Considering potential info-leak vulnerabilities.

Can we only do this when SLAB_DEBUG is enabled?

> Performance wise, smaller zeroing length also brings shorter
> execution time, as shown from test data on various server/desktop
> platforms.
>
> For kzalloc users who will call ksize() later and utilize this
> extra space, please be aware that the space is not zeroed any
> more.

CC Kees

>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.c |  7 ++++---
>  mm/slab.h |  5 +++--
>  mm/slub.c | 10 +++++++---
>  3 files changed, 14 insertions(+), 8 deletions(-)
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
> index d0ef9dd44b71..3cf5adf63f48 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -730,7 +730,8 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
>
>  static inline void slab_post_alloc_hook(struct kmem_cache *s,
>                                         struct obj_cgroup *objcg, gfp_t flags,
> -                                       size_t size, void **p, bool init)
> +                                       size_t size, void **p, bool init,
> +                                       unsigned int orig_size)
>  {
>         size_t i;
>
> @@ -746,7 +747,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
>         for (i = 0; i < size; i++) {
>                 p[i] = kasan_slab_alloc(s, p[i], flags, init);
>                 if (p[i] && init && !kasan_has_integrated_init())
> -                       memset(p[i], 0, s->object_size);
> +                       memset(p[i], 0, orig_size);

Note that when KASAN is enabled and has integrated init, it will
initialize the whole object, which leads to an inconsistency with this
change.

>                 kmemleak_alloc_recursive(p[i], s->object_size, 1,
>                                          s->flags, flags);
>         }
> diff --git a/mm/slub.c b/mm/slub.c
> index c8ba16b3a4db..6f823e99d8b4 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3376,7 +3376,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
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
> @@ -3833,11 +3837,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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
