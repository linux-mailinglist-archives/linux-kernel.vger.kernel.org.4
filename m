Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14BF610197
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiJ0T13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiJ0T1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:27:25 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F567859B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:27:22 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u132so3581589oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T84PcfyuK8pgheltMcMu03qBrAz+3BklY2VEE5FFI7U=;
        b=cw+mLNmrIVhhvO5J2ckYx7/a6cvZ20lrNMZJcFIztLpoBDPd6rZ8HYM/hzJfmYOy2D
         w5X+BdbAaKQejTAQBjhEJalrpzK88iGAZxsT0Ty3Js1tJQnwiZCCajyHL2r8FVSTOczx
         ylXdj3xR1Hyx2C6oMOm4R5pKPUON2CVns02gk12kwf/TLhJt4a3l/jOxTRZRJbaI3/Ud
         Y0h7AG43X5XuHrZqRMw2N3zZnqRq815eJJELWk7FPS/H8yM6Ttyr2cDdQyF5cERd4WiO
         RMGr5PjAi9lQghNV+rcmMnl+U7sN/YkTWEqIve2fuYR1WNiemYvQRva6Iau9IgRdRlkr
         AzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T84PcfyuK8pgheltMcMu03qBrAz+3BklY2VEE5FFI7U=;
        b=oWm8ydN6ffalFp6GSRN0tJNw2wCAwwo8RQhAsAAeFCBMFXvDsHCcUt/+YfY/xRcefx
         IlEZ4cvNXvrLtrd9FMhfazjvTHiIFu20N4ec5CiECarsXc7/FgdKAC5Y/qbs8jMhpmu8
         q/hfnl5pZ3ldxxJ4LqB+lGidldc5iFQjOpCXoX7rl22APSfqofZeQBwTFcicGoUH94Qi
         wF7Te0An/2NGkGFyyBtMe4amoSJR+vgYo44Av9d2AR5rd9/Nsfko6dXMfKSNWu2xeAx/
         gTKIdL8iwm/VZ1VjKbTimjjUGlryt7vycIOccA1kU9XoiivSCdBdm504QgKHlZaQM45f
         hM/Q==
X-Gm-Message-State: ACrzQf047aHDaHgOE4HyezAi7l7wWhUnv/gQsVM9D9M0PvGQvNgNIz+l
        eDXTkimWiH2k5hNj9BQzlPZIjufVxzAOj6ehLAg=
X-Google-Smtp-Source: AMsMyM5LdYzwLq5KVOW5Sj2lTB1kEWKlwC1Ng32+mOEMkqM14wrvIPSDsJZUejChXfzz/jTvzIDYyMWf+qtWV7tf+3M=
X-Received: by 2002:a05:6808:2106:b0:355:d47:313 with SMTP id
 r6-20020a056808210600b003550d470313mr5550586oiw.34.1666898842407; Thu, 27 Oct
 2022 12:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221021032405.1825078-1-feng.tang@intel.com> <20221021032405.1825078-3-feng.tang@intel.com>
In-Reply-To: <20221021032405.1825078-3-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 27 Oct 2022 21:27:11 +0200
Message-ID: <CA+fCnZfJqH=dNsD+aNoGbf-LJ_qn=2fbr-U0nj8wi4u2+V3iEw@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] mm: kasan: Extend kasan_metadata_size() to also
 cover in-object size
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
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel test robot <oliver.sang@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
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
> When kasan is enabled for slab/slub, it may save kasan' free_meta
> data in the former part of slab object data area in slab object's
> free path, which works fine.
>
> There is ongoing effort to extend slub's debug function which will
> redzone the latter part of kmalloc object area, and when both of
> the debug are enabled, there is possible conflict, especially when
> the kmalloc object has small size, as caught by 0Day bot [1].
>
> To solve it, slub code needs to know the in-object kasan's meta
> data size. Currently, there is existing kasan_metadata_size()
> which returns the kasan's metadata size inside slub's metadata
> area, so extend it to also cover the in-object meta size by
> adding a boolean flag 'in_object'.
>
> There is no functional change to existing code logic.
>
> [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  include/linux/kasan.h |  5 +++--
>  mm/kasan/generic.c    | 19 +++++++++++++------
>  mm/slub.c             |  4 ++--
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d811b3d7d2a1..96c9d56e5510 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -302,7 +302,7 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>
>  #ifdef CONFIG_KASAN_GENERIC
>
> -size_t kasan_metadata_size(struct kmem_cache *cache);
> +size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
>  slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         slab_flags_t *flags);
> @@ -315,7 +315,8 @@ void kasan_record_aux_stack_noalloc(void *ptr);
>  #else /* CONFIG_KASAN_GENERIC */
>
>  /* Tag-based KASAN modes do not use per-object metadata. */
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache,
> +                                               bool in_object)
>  {
>         return 0;
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d8b5590f9484..b076f597a378 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -450,15 +450,22 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
>  }
>
> -size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>  {
> +       struct kasan_cache *info = &cache->kasan_info;
> +
>         if (!kasan_requires_meta())
>                 return 0;
> -       return (cache->kasan_info.alloc_meta_offset ?
> -               sizeof(struct kasan_alloc_meta) : 0) +
> -               ((cache->kasan_info.free_meta_offset &&
> -                 cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
> -                sizeof(struct kasan_free_meta) : 0);
> +
> +       if (in_object)
> +               return (info->free_meta_offset ?
> +                       0 : sizeof(struct kasan_free_meta));
> +       else
> +               return (info->alloc_meta_offset ?
> +                       sizeof(struct kasan_alloc_meta) : 0) +
> +                       ((info->free_meta_offset &&
> +                       info->free_meta_offset != KASAN_NO_FREE_META) ?
> +                       sizeof(struct kasan_free_meta) : 0);
>  }
>
>  static void __kasan_record_aux_stack(void *addr, bool can_alloc)
> diff --git a/mm/slub.c b/mm/slub.c
> index 17292c2d3eee..adff7553b54e 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -910,7 +910,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>         if (slub_debug_orig_size(s))
>                 off += sizeof(unsigned int);
>
> -       off += kasan_metadata_size(s);
> +       off += kasan_metadata_size(s, false);
>
>         if (off != size_from_object(s))
>                 /* Beginning of the filler is the free pointer */
> @@ -1070,7 +1070,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>                         off += sizeof(unsigned int);
>         }
>
> -       off += kasan_metadata_size(s);
> +       off += kasan_metadata_size(s, false);
>
>         if (size_from_object(s) == off)
>                 return 1;
> --
> 2.34.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
