Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8D36D403A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjDCJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjDCJWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:22:43 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B280BEFB5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:22:14 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id y85so12540608iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680513731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AK7BPbsHL4WuhYBXq1AZIp6CGkn7dRfiNDxu4r9Cdnk=;
        b=kDlt0pG8XREdIpVFLQpT990PUScpFo82e1tXp5/XIZavQhukK2IRMbHxvb9oL9Nyni
         ODSdcGOyO400bOdOiexHQbl/LYjS+rzEDVOyexTY+33z3Km8als930FyJf7VRI/8b47L
         ghbgMbKx09axoRhmGxi+IjSLePdrM79B+HSdIin+nlM4asuYP6V0dkvMbgyUbZf4gE9P
         4O6peh9H9AKEWk+NvmMlI+RH6/F61ev31oxfxE3+AZ6qKoDjVJgmnMs5KMPWUPfehbL+
         Br874k/7SsbG8+vE180CmxeOA9GQd8HjFnSkrTQQvH4zSZh7J7sAt2VplWlgS9pV0bjP
         SxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513731;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK7BPbsHL4WuhYBXq1AZIp6CGkn7dRfiNDxu4r9Cdnk=;
        b=qQEXPlXqqNZkCD98J4Qj4TsvCjIix1AMZTix/IZEU+UQiPXdvApSxlKGgdEx8G5pSt
         uVp8Wcyk8t/0fdlPuTX8Qdunia1i4XJFV0wOecnENfAFgflq8IYYkMUdte115ijCNJuk
         YiaYkkiEKMjnu+eU+JNaQygQ/B5HH5J5fhKZwLv9Itpg+9HzK0rrDm2Xa8Qiz4Pq7cCc
         xYLWTMl5WZVBQ8wWfOYSS5oCKYoe5nc3bbWxtUp6ss/0kDqveRGji37fZsWI3ACBRsPY
         +FL+jsMsYvzu9aWYm5k3nnD3Irxtt4y7DoVWdwDlmMPGBvMnVTz0UWdtKgwk5mX+cTUM
         23Ig==
X-Gm-Message-State: AO0yUKVV00H/gosrm1TLc5yqkBMFKdAubyxGReuRn/Q97Msl50hp+cNo
        v+Dm3g3v7PxnoZR8kY6K9r3IifgIltmfEcGBxMmjfA==
X-Google-Smtp-Source: AK7set8rqffKKx3qqlvmrW2CdIADhVfl0IriM3ou5zAqZGcZWNEZ8T6JlvO1CG0iR1XZpTfoy65eyD6r25LTzDyZboc=
X-Received: by 2002:a05:6602:192:b0:753:2cc5:c8b7 with SMTP id
 m18-20020a056602019200b007532cc5c8b7mr23217242ioo.3.1680513730984; Mon, 03
 Apr 2023 02:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230403062757.74057-1-zhangpeng.00@bytedance.com>
In-Reply-To: <20230403062757.74057-1-zhangpeng.00@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 3 Apr 2023 11:21:34 +0200
Message-ID: <CANpmjNMOJ9_AU++eNF=F9hwCveeJmM7r0sEQAf0a=0pOa=dGfg@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: Improve the performance of __kfence_alloc()
 and __kfence_free()
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

On Mon, 3 Apr 2023 at 08:28, Peng Zhang <zhangpeng.00@bytedance.com> wrote:
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
> Before playing patch:
> __kfence_alloc:
> avg = 5055 nsecs, total: 5515252 nsecs, count: 1091
> __kfence_free:
> avg = 5319 nsecs, total: 9735130 nsecs, count: 1830
>
> After playing patch:
> __kfence_alloc:
> avg = 3597 nsecs, total: 6428491 nsecs, count: 1787
> __kfence_free:
> avg = 3046 nsecs, total: 3415390 nsecs, count: 1121

Seems like a nice improvement!

> The numbers indicate that there is ~30% - ~40% performance improvement.
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  mm/kfence/core.c   | 71 +++++++++++++++++++++++++++++++++-------------
>  mm/kfence/kfence.h | 10 ++++++-
>  mm/kfence/report.c |  2 +-
>  3 files changed, 62 insertions(+), 21 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 79c94ee55f97..0b1b1298c738 100644
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
> @@ -323,11 +316,27 @@ static inline bool check_canary_byte(u8 *addr)
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
>          * We'll iterate over each canary byte per-side until fn() returns

This comment is now out-of-date ("fn" no longer exists).

> @@ -339,14 +348,38 @@ static __always_inline void for_each_canary(const struct kfence_metadata *meta,
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
> +        * If the canary is damaged in a certain 64 bytes, or the canay memory

"damaged" -> "corrupted"
"canay" -> "canary"

> +        * cannot be completely covered by multiple consecutive 64 bytes, it
> +        * needs to be checked one by one.
> +        */
> +       for (; addr < meta->addr; addr++) {
> +               if (unlikely(!check_canary_byte((u8 *)addr)))
> +                       break;
> +       }
> +
> +       /*
> +        * Apply to right of object.
> +        * For easier implementation, check from high address to low address.
> +        */
> +       addr = pageaddr + PAGE_SIZE - sizeof(u64);
> +       for (; addr >= meta->addr + meta->size ; addr -= sizeof(u64)) {
> +               if (unlikely(*((u64 *)addr) != KFENCE_CANARY_PATTERN_U64))
> +                       break;
> +       }
> +
> +       /*
> +        * Same as above, checking byte by byte, but here is the reverse of
> +        * the above.
> +        */
> +       addr = addr + sizeof(u64) - 1;
> +       for (; addr >= meta->addr + meta->size; addr--) {

The re-checking should forward-check i.e. not in reverse, otherwise
the report might not include some corrupted bytes that had in the
previous version been included. I think you need to check from low to
high address to start with above.

> +               if (unlikely(!check_canary_byte((u8 *)addr)))
>                         break;
>         }
>  }
> @@ -434,7 +467,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>  #endif
>
>         /* Memory initialization. */
> -       for_each_canary(meta, set_canary_byte);
> +       set_canary(meta);
>
>         /*
>          * We check slab_want_init_on_alloc() ourselves, rather than letting
> @@ -495,7 +528,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>         alloc_covered_add(meta->alloc_stack_hash, -1);
>
>         /* Check canary bytes for memory corruption. */
> -       for_each_canary(meta, check_canary_byte);
> +       check_canary(meta);
>
>         /*
>          * Clear memory if init-on-free is set. While we protect the page, the
> @@ -751,7 +784,7 @@ static void kfence_check_all_canary(void)
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
>
