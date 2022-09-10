Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B6B5B4ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIJXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIJXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:12:19 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95968E083
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:12:17 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id u28so806130qku.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1qAOHyl0ZytUGK0LKmP2phdfOjsGHVNHqllONgN6fKY=;
        b=mwZQUBhTeAzkTF8xxYrlGo8hF8qHq4dcf2rSQVSfUettUq6InYxFR8fpF4QMoSceAN
         RoRZV4iOGW14ERDM/zH2z6/y5uwBgFJ6Vw5paH6adAvG6kDmcwmjzVHOW6t8l+6mzWhI
         19QkDWEILoadygJBRB6OpPDLGyvEhqUERYWp0a46U3cIb1YdZoghY3P764lvdzRqM7Yf
         Lq4omeoMa7H0Qtb3sTYu4tSj4l3gQ9WUseXQCyTXw06W65FOwhxeK/ic2ORpO/E+hnke
         LtV/7zzO1bSWM5vtsjEb2N09U7H0nGbYahtuGdbd5s7NQjPN8Rnq7ORAO5CC7BM+rLyc
         baFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1qAOHyl0ZytUGK0LKmP2phdfOjsGHVNHqllONgN6fKY=;
        b=S8dxVrEXBsVpb+e9xKLG2k1c9RN2n44eOjXv8QP0F3CbIZDbCst6SyI0i0Y9pAR902
         fpj80DsmD+j4x4YrZX6HlcPNRnKCBgOz8eVd0/D3TZ2U73ZWTORvHo1Hc+yunbrPXs2P
         yxIRL5RIwiZ0WQHZSz1Enwhe1b2XSs5NWyCURu/Kd6zrolOh7/c57Q5NLMx4VuDB6jge
         GL7b92kuw2RjuLPRjxWFBECjuiaBTX2p07vwrREOoIpMvoCytGnYRHqKZ3FeV6YOVkDY
         dfAAT5RBgJtGT7kVZ+8hEkMVu5e2mTroh7s3WpAMvIYlHPYZ51ieA7IihdpDWtkpBSSJ
         Tj0Q==
X-Gm-Message-State: ACgBeo0kGbWo1W9yoVrszO9tBAvWVVReyp2C9PX8hgA4vMjq8YCWqMhQ
        5waMZ4YzIY9PAmaN+LBaUmk+N6EFgcoZblky49g=
X-Google-Smtp-Source: AA6agR62AluZGb9Ks2brmA4j58myrTw8x2kq+ZKGD56YZvnh3QLJg0zqXmag9qouK4TB3QKuwjVqquVIveUPbmD+tDI=
X-Received: by 2002:a05:620a:25ca:b0:6b8:7633:baf with SMTP id
 y10-20020a05620a25ca00b006b876330bafmr15148666qko.515.1662851536678; Sat, 10
 Sep 2022 16:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071023.3838692-1-feng.tang@intel.com> <20220907071023.3838692-5-feng.tang@intel.com>
In-Reply-To: <20220907071023.3838692-5-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 01:12:05 +0200
Message-ID: <CA+fCnZfLCe8fhQ5UAyF1LwZuMCfbsoEXDmX3deaW6i_E5UE60g@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm/slub: extend redzone check to extra allocated
 kmalloc space than requested
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

On Wed, Sep 7, 2022 at 9:11 AM Feng Tang <feng.tang@intel.com> wrote:
>
> kmalloc will round up the request size to a fixed size (mostly power
> of 2), so there could be a extra space than what is requested, whose
> size is the actual buffer size minus original request size.
>
> To better detect out of bound access or abuse of this space, add
> redzone sanity check for it.
>
> And in current kernel, some kmalloc user already knows the existence
> of the space and utilizes it after calling 'ksize()' to know the real
> size of the allocated buffer. So we skip the sanity check for objects
> which have been called with ksize(), as treating them as legitimate
> users.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  mm/slab.h        |  4 ++++
>  mm/slab_common.c |  4 ++++
>  mm/slub.c        | 57 +++++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/mm/slab.h b/mm/slab.h
> index 20f9e2a9814f..0bc91b30b031 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -885,4 +885,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
>  }
>  #endif
>
> +#ifdef CONFIG_SLUB_DEBUG
> +void skip_orig_size_check(struct kmem_cache *s, const void *object);
> +#endif
> +
>  #endif /* MM_SLAB_H */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8e13e3aac53f..5106667d6adb 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1001,6 +1001,10 @@ size_t __ksize(const void *object)
>                 return folio_size(folio);
>         }
>
> +#ifdef CONFIG_SLUB_DEBUG
> +       skip_orig_size_check(folio_slab(folio)->slab_cache, object);
> +#endif
> +
>         return slab_ksize(folio_slab(folio)->slab_cache);
>  }
>
> diff --git a/mm/slub.c b/mm/slub.c
> index f523601d3fcf..2f0302136604 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -812,12 +812,27 @@ static inline void set_orig_size(struct kmem_cache *s,
>         if (!slub_debug_orig_size(s))
>                 return;
>
> +#ifdef CONFIG_KASAN_GENERIC
> +       /*
> +        * KASAN could save its free meta data in the start part of object
> +        * area, so skip the redzone check if kasan's meta data size is
> +        * bigger enough to possibly overlap with kmalloc redzone
> +        */
> +       if (s->kasan_info.free_meta_size_in_object * 2 >= s->object_size)

Why is free_meta_size_in_object multiplied by 2? Looks cryptic,
probably needs a comment.

Thanks!

> +               orig_size = s->object_size;
> +#endif
> +
>         p += get_info_end(s);
>         p += sizeof(struct track) * 2;
>
>         *(unsigned int *)p = orig_size;
>  }
>
> +void skip_orig_size_check(struct kmem_cache *s, const void *object)
> +{
> +       set_orig_size(s, (void *)object, s->object_size);
> +}
> +
>  static unsigned int get_orig_size(struct kmem_cache *s, void *object)
>  {
>         void *p = kasan_reset_tag(object);
> @@ -949,13 +964,34 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
>         u8 *p = kasan_reset_tag(object);
> +       unsigned int orig_size = s->object_size;
>
> -       if (s->flags & SLAB_RED_ZONE)
> +       if (s->flags & SLAB_RED_ZONE) {
>                 memset(p - s->red_left_pad, val, s->red_left_pad);
>
> +               if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +                       unsigned int zone_start;
> +
> +                       orig_size = get_orig_size(s, object);
> +                       zone_start = orig_size;
> +
> +                       if (!freeptr_outside_object(s))
> +                               zone_start = max_t(unsigned int, orig_size,
> +                                               s->offset + sizeof(void *));
> +
> +                       /*
> +                        * Redzone the extra allocated space by kmalloc
> +                        * than requested.
> +                        */
> +                       if (zone_start < s->object_size)
> +                               memset(p + zone_start, val,
> +                                       s->object_size - zone_start);
> +               }
> +       }
> +
>         if (s->flags & __OBJECT_POISON) {
> -               memset(p, POISON_FREE, s->object_size - 1);
> -               p[s->object_size - 1] = POISON_END;
> +               memset(p, POISON_FREE, orig_size - 1);
> +               p[orig_size - 1] = POISON_END;
>         }
>
>         if (s->flags & SLAB_RED_ZONE)
> @@ -1103,6 +1139,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>  {
>         u8 *p = object;
>         u8 *endobject = object + s->object_size;
> +       unsigned int orig_size;
>
>         if (s->flags & SLAB_RED_ZONE) {
>                 if (!check_bytes_and_report(s, slab, object, "Left Redzone",
> @@ -1112,6 +1149,20 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
>                 if (!check_bytes_and_report(s, slab, object, "Right Redzone",
>                         endobject, val, s->inuse - s->object_size))
>                         return 0;
> +
> +               if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
> +                       orig_size = get_orig_size(s, object);
> +
> +                       if (!freeptr_outside_object(s))
> +                               orig_size = max_t(unsigned int, orig_size,
> +                                               s->offset + sizeof(void *));
> +                       if (s->object_size > orig_size  &&
> +                               !check_bytes_and_report(s, slab, object,
> +                                       "kmalloc Redzone", p + orig_size,
> +                                       val, s->object_size - orig_size)) {
> +                               return 0;
> +                       }
> +               }
>         } else {
>                 if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
>                         check_bytes_and_report(s, slab, p, "Alignment padding",
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220907071023.3838692-5-feng.tang%40intel.com.
