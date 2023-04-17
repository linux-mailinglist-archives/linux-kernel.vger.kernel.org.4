Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21E6E46E5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 07:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjDQLzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:55:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4967ED4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:54:42 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-504eccc8fc8so3812887a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681732464; x=1684324464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cItKBO+T06PzHqKskJtbZMH9b9s+HGyW1napsrYk6R4=;
        b=W3Z/9kFrMfz7ubLB3nwJYFEqJi3JzIX6K1/YcqvsQaT9VNbvVGsG/EtwdytaO8NF3j
         i4+tNUBAtQ0awyXQEzCMD5OXpasdzkW2wRwhnUzB9zLdK/2MO1GJczhwDaMEqNgDJfLW
         dB3RZGXSgQABzVEzvMzqKFZ31q/xx9ESkUzB3tEtC8fiBfwfOPqKR4uL/98kYdnmr8C3
         VunkYTYoahczoIPLmbYhtNiJlJyKF/jECvd0FbXZibXwlG//2PymGGfPtBmMemmxlu3I
         fQSyOr7KK1PaQrqkYlRquknleQD5KrDxXSwfOy5Vsxlwz05jFcswa81GGFJiD1UPje9C
         FxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732464; x=1684324464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cItKBO+T06PzHqKskJtbZMH9b9s+HGyW1napsrYk6R4=;
        b=SlZ+AQefjoUj1K/kSypeAjJqiENHUGdt64dJPICzf6SXlqbM/AOhPuZeefgJVLwxD2
         UgPIk3q9WKs5XXNzZAZ6RDa+33FC8Mz2/UGSr1dEI4EYzntgxF8JwzHSTXnOtfH22G8V
         utjNCL6IkbY6KhWpjfSuSJ34rOQUlszUChpnJK3t00mtI3e/xkANWiccxkcMfdSDUXce
         dgWFt5ZVtHwRGVntapfgiRFB5lWc4yK38mbNZMWEJJde//Xpdrm5dwQYWEQZVVquMm0x
         XGgYvvcpS3Gf3lRgzavtykeFwLjSPmgCfjT1LZ0lFz5Bh7ekAn9YyRWjIYJTt3RjWPP4
         BnxQ==
X-Gm-Message-State: AAQBX9fW4jhvGOnyBinoboE6cAkNYS/xxOiHFdQ6YkvnGGD6WQaRGKi8
        uq4BAkpvOaf4vMMaeA6lPdk4kQ60TaNoFB9sKImnDA==
X-Google-Smtp-Source: AKy350Z5VaMi4DZV2r44mU5qRMW+oXl5ZyrylP1sAAkuIU6UdJPateLg8U1655UGKVpVO4v1dWEvw6PoKWZttvBbZVw=
X-Received: by 2002:a50:9b0e:0:b0:504:7684:a23c with SMTP id
 o14-20020a509b0e000000b005047684a23cmr7159964edi.8.1681732463533; Mon, 17 Apr
 2023 04:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230417110259.1737315-1-senozhatsky@chromium.org>
In-Reply-To: <20230417110259.1737315-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 17 Apr 2023 04:53:47 -0700
Message-ID: <CAJD7tkbVnwV0t8BPqVcY7+gooW8NSs=nq2U0TuQC5ZP1xhVSNg@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: allow only one active pool compaction context
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Sergey,

On Mon, Apr 17, 2023 at 4:03=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zsmalloc pool can be compacted concurrently by many contexts,
> e.g.
>
>  cc1 handle_mm_fault()
>       do_anonymous_page()
>        __alloc_pages_slowpath()
>         try_to_free_pages()
>          do_try_to_free_pages(
>           lru_gen_shrink_node()
>            shrink_slab()
>             do_shrink_slab()
>              zs_shrinker_scan()
>               zs_compact()
>
> This creates unnecessary contention as all those processes
> compete for access to the same classes. A single compaction
> process is enough. Moreover contention that is created by
> multiple compaction processes impact other zsmalloc functions,
> e.g. zs_malloc(), since zsmalloc uses "global" pool->lock to
> synchronize access to pool.
>
> Introduce pool compaction mutex and permit only one compaction
> context at a time.

I am not sure what's the best practice here, but if the only use of
the mutex is a trylock, do we need a mutex here? It seems like a
simple atomic would do the trick. Perhaps something like:

static atomic_t ongoing_compaction =3D ATOMIC_INIT(0);
...
if (atomic_xchg(&ongoing_compaction, 1))
    return;
....
atomic_set(&ongoing_compaction, 0);

FWIW, I am suggesting this because it was recently brought up when one
of my patches was reviewed that locks should protect data not code
paths [1], so I am trying to apply what I learned there :)

[1]https://lore.kernel.org/lkml/20230323172732.GE739026@cmpxchg.org/

>
> /proc/lock-stat after make -j$((`nproc`+1)) linux kernel for
> &pool->lock#3:
>
>                 Base           Patched
> --------------------------------------
> con-bounces     9797655        8125860
> contentions     11131185       9242153
> waittime-min    0.09           0.10
> waittime-max    4171695.76     3926258.74
> waittime-total  506197629.16   417061026.20
> waittime-avg    45.48          45.13
> acq-bounces     13809103       11383480
> acquisitions    21145155       18049364
> holdtime-min    0.06           0.07
> holdtime-max    7379928.80     3926274.89
> holdtime-total  46273950.89    37279624.53
> holdtime-avg    2.19           2.07
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/zsmalloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index cc81dfba05a0..0e036ec56c3c 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -264,6 +264,7 @@ struct zs_pool {
>         struct work_struct free_work;
>  #endif
>         spinlock_t lock;
> +       struct mutex compact_lock;
>  };
>
>  struct zspage {
> @@ -2274,6 +2275,9 @@ unsigned long zs_compact(struct zs_pool *pool)
>         struct size_class *class;
>         unsigned long pages_freed =3D 0;
>
> +       if (!mutex_trylock(&pool->compact_lock))
> +               return 0;
> +
>         for (i =3D ZS_SIZE_CLASSES - 1; i >=3D 0; i--) {
>                 class =3D pool->size_class[i];
>                 if (class->index !=3D i)
> @@ -2281,6 +2285,7 @@ unsigned long zs_compact(struct zs_pool *pool)
>                 pages_freed +=3D __zs_compact(pool, class);
>         }
>         atomic_long_add(pages_freed, &pool->stats.pages_compacted);
> +       mutex_unlock(&pool->compact_lock);
>
>         return pages_freed;
>  }
> @@ -2388,6 +2393,7 @@ struct zs_pool *zs_create_pool(const char *name)
>
>         init_deferred_free(pool);
>         spin_lock_init(&pool->lock);
> +       mutex_init(&pool->compact_lock);
>
>         pool->name =3D kstrdup(name, GFP_KERNEL);
>         if (!pool->name)
> --
> 2.40.0.634.g4ca3ef3211-goog
>
