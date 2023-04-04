Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED6F6D5D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjDDK3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbjDDK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:29:32 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E2D1BD6
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:29:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k13so5283071iov.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680604169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4EmkZjYvZJVj3QnIxJ1/YfnG3WC3vCHhD00FgzBktzc=;
        b=UT/fEhLm0SC/fiIsmvTNeoOgXz8ZErqOQFzejfAdFEvfdEfjgHfylVxuCGYJnFUJD7
         VztWelG82Vzgkg2W03Zc0/ORaguOUDfPMG0Ul3sN9Jo1kIaior/siMoErdhdWtnOFhlY
         +sn4xUXe/pRvKOStXyh3o8TwB/kMxWLqE0kI5VcMySufwTC1hCSfYNww0DRoNA8yn1CT
         0iQA4hExGURB1QR/ZLJc92CWj/OB+2Ur+EhomhjsPrAXvwSXoELaSyxolnSzRNdymJpz
         Mqb/qHNqAvLcv+8tv4F7OnW4/KrsCtNKKAG/aHMb9cwWyGL2B6MiMz3hFZ9SZ6ZrC9Cd
         nPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680604169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4EmkZjYvZJVj3QnIxJ1/YfnG3WC3vCHhD00FgzBktzc=;
        b=Yk89f5QkNL8ZaT09vOcNYYtj2tFavEDgFPFSmxeCbwr3MIe6J7eOFrSu9MSkePbGIA
         QOfI/khbUY5FblziV7RL68vXAzAyR73mrCjwUuRPbMDgouADq7Y+v50qsJPtDiBOOYos
         Yh4N2UxIjDzIgdK+yjDVO0WiiSew09uRYVQFx0FjchFtOVXNA57LGL5WHs5hllrQV1TV
         77D84xwF1M22Dgud/MUMarftZ8yhqeRLo2H5eeIN+xQL1p9AutJ4NEnjPoJ+ZUvY8W0B
         hLJ2KzQyFvyquy3az4dMzgpvIAtKihOtoHK16s4l0rP63bZoPA6x6CitHT3+vqPYiiSz
         YS8A==
X-Gm-Message-State: AAQBX9fxPkYMh0Jvppw1vR8xEGuev7QppEKipum4aq3WXrJC9SBRceje
        z3jy0QZAqodKdw2Q8imJRQVZMx/3tI9Kxs0b7eixDupYhWsWXLWDhcs=
X-Google-Smtp-Source: AKy350awmYuEjUdfWn5va245UWflf0zZx/dwv6y8E/EYdNes0zj/Q+XcXS4dcKFkmbTVXdB6Y7z6Xb0t/VHgYkRttGw=
X-Received: by 2002:a5d:9b0a:0:b0:753:ee63:3dc with SMTP id
 y10-20020a5d9b0a000000b00753ee6303dcmr1835631ion.20.1680604169337; Tue, 04
 Apr 2023 03:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230403122738.6006-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230403122738.6006-1-zhangpeng.00@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 Apr 2023 12:28:52 +0200
Message-ID: <CANpmjNN4SAbJ7mRLJHZ1azOEp6e2HyL1FNZH_Qi1+2xc4rgXfw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: Improve the performance of
 __kfence_alloc() and __kfence_free()
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Apr 2023 at 14:27, 'Peng Zhang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> In __kfence_alloc() and __kfence_free(), we will set and check canary.
> Assuming that the size of the object is close to 0, nearly 4k memory
> accesses are required because setting and checking canary is executed
> byte by byte.
>
> canary is now defined like this:
> KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))
>
> Observe that canary is only related to the lower three bits of the
> address, so every 8 bytes of canary are the same. We can access 8-byte
> canary each time instead of byte-by-byte, thereby optimizing nearly 4k
> memory accesses to 4k/8 times.
>
> Use the bcc tool funclatency to measure the latency of __kfence_alloc()
> and __kfence_free(), the numbers (deleted the distribution of latency)
> is posted below. Though different object sizes will have an impact on the
> measurement, we ignore it for now and assume the average object size is
> roughly equal.
>
> Before patching:
> __kfence_alloc:
> avg = 5055 nsecs, total: 5515252 nsecs, count: 1091
> __kfence_free:
> avg = 5319 nsecs, total: 9735130 nsecs, count: 1830
>
> After patching:
> __kfence_alloc:
> avg = 3597 nsecs, total: 6428491 nsecs, count: 1787
> __kfence_free:
> avg = 3046 nsecs, total: 3415390 nsecs, count: 1121
>
> The numbers indicate that there is ~30% - ~40% performance improvement.
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c   | 70 ++++++++++++++++++++++++++++++++--------------
>  mm/kfence/kfence.h | 10 ++++++-
>  mm/kfence/report.c |  2 +-
>  3 files changed, 59 insertions(+), 23 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 79c94ee55f97..b7fe2a2493a0 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -297,20 +297,13 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>         WRITE_ONCE(meta->state, next);
>  }
>
> -/* Write canary byte to @addr. */
> -static inline bool set_canary_byte(u8 *addr)
> -{
> -       *addr = KFENCE_CANARY_PATTERN(addr);
> -       return true;
> -}
> -
>  /* Check canary byte at @addr. */
>  static inline bool check_canary_byte(u8 *addr)
>  {
>         struct kfence_metadata *meta;
>         unsigned long flags;
>
> -       if (likely(*addr == KFENCE_CANARY_PATTERN(addr)))
> +       if (likely(*addr == KFENCE_CANARY_PATTERN_U8(addr)))
>                 return true;
>
>         atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> @@ -323,15 +316,31 @@ static inline bool check_canary_byte(u8 *addr)
>         return false;
>  }
>
> -/* __always_inline this to ensure we won't do an indirect call to fn. */
> -static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
> +static inline void set_canary(const struct kfence_metadata *meta)
>  {
>         const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
> -       unsigned long addr;
> +       unsigned long addr = pageaddr;
> +
> +       /*
> +        * The canary may be written to part of the object memory, but it does
> +        * not affect it. The user should initialize the object before using it.
> +        */
> +       for (; addr < meta->addr; addr += sizeof(u64))
> +               *((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
> +
> +       addr = ALIGN_DOWN(meta->addr + meta->size, sizeof(u64));
> +       for (; addr - pageaddr < PAGE_SIZE; addr += sizeof(u64))
> +               *((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
> +}
> +
> +static inline void check_canary(const struct kfence_metadata *meta)
> +{
> +       const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
> +       unsigned long addr = pageaddr;
>
>         /*
> -        * We'll iterate over each canary byte per-side until fn() returns
> -        * false. However, we'll still iterate over the canary bytes to the
> +        * We'll iterate over each canary byte per-side until a corrupted byte
> +        * is found. However, we'll still iterate over the canary bytes to the
>          * right of the object even if there was an error in the canary bytes to
>          * the left of the object. Specifically, if check_canary_byte()
>          * generates an error, showing both sides might give more clues as to
> @@ -339,16 +348,35 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
>          */
>
>         /* Apply to left of object. */
> -       for (addr = pageaddr; addr < meta->addr; addr++) {
> -               if (!fn((u8 *)addr))
> +       for (; meta->addr - addr >= sizeof(u64); addr += sizeof(u64)) {
> +               if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64))
>                         break;
>         }
>
> -       /* Apply to right of object. */
> -       for (addr = meta->addr + meta->size; addr < pageaddr + PAGE_SIZE; addr++) {
> -               if (!fn((u8 *)addr))
> +       /*
> +        * If the canary is corrupted in a certain 64 bytes, or the canary
> +        * memory cannot be completely covered by multiple consecutive 64 bytes,
> +        * it needs to be checked one by one.
> +        */
> +       for (; addr < meta->addr; addr++) {
> +               if (unlikely(!check_canary_byte((u8 *)addr)))
>                         break;
>         }
> +
> +       /* Apply to right of object. */
> +       for (addr = meta->addr + meta->size; addr % sizeof(u64) != 0; addr++) {
> +               if (unlikely(!check_canary_byte((u8 *)addr)))
> +                       return;
> +       }
> +       for (; addr - pageaddr < PAGE_SIZE; addr += sizeof(u64)) {
> +               if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64)) {
> +

Unnecessary blank line, remove.

> +                       for (; addr - pageaddr < PAGE_SIZE; addr++) {
> +                               if (!check_canary_byte((u8 *)addr))
> +                                       return;
> +                       }
> +               }
> +       }
>  }
>
>  static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t gfp,
> @@ -434,7 +462,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  #endif
>
>         /* Memory initialization. */
> -       for_each_canary(meta, set_canary_byte);
> +       set_canary(meta);
>
>         /*
>          * We check slab_want_init_on_alloc() ourselves, rather than letting
> @@ -495,7 +523,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>         alloc_covered_add(meta->alloc_stack_hash, -1);
>
>         /* Check canary bytes for memory corruption. */
> -       for_each_canary(meta, check_canary_byte);
> +       check_canary(meta);
>
>         /*
>          * Clear memory if init-on-free is set. While we protect the page, the
> @@ -751,7 +779,7 @@ static void kfence_check_all_canary(void)
>                 struct kfence_metadata *meta = &kfence_metadata[i];
>
>                 if (meta->state == KFENCE_OBJECT_ALLOCATED)
> -                       for_each_canary(meta, check_canary_byte);
> +                       check_canary(meta);
>         }
>  }
>
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 600f2e2431d6..2aafc46a4aaf 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -21,7 +21,15 @@
>   * lower 3 bits of the address, to detect memory corruptions with higher
>   * probability, where similar constants are used.
>   */
> -#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))
> +#define KFENCE_CANARY_PATTERN_U8(addr) ((u8)0xaa ^ (u8)((unsigned long)(addr) & 0x7))
> +
> +/*
> + * Define a continuous 8-byte canary starting from a multiple of 8. The canary
> + * of each byte is only related to the lowest three bits of its address, so the
> + * canary of every 8 bytes is the same. 64-bit memory can be filled and checked
> + * at a time instead of byte by byte to improve performance.
> + */
> +#define KFENCE_CANARY_PATTERN_U64 ((u64)0xaaaaaaaaaaaaaaaa ^ (u64)(0x0706050403020100))
>
>  /* Maximum stack depth for reports. */
>  #define KFENCE_STACK_DEPTH 64
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 60205f1257ef..197430a5be4a 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -168,7 +168,7 @@ static void print_diff_canary(unsigned long address, size_t bytes_to_show,
>
>         pr_cont("[");
>         for (cur = (const u8 *)address; cur < end; cur++) {
> -               if (*cur == KFENCE_CANARY_PATTERN(cur))
> +               if (*cur == KFENCE_CANARY_PATTERN_U8(cur))
>                         pr_cont(" .");
>                 else if (no_hash_pointers)
>                         pr_cont(" 0x%02x", *cur);
> --
> 2.20.1
