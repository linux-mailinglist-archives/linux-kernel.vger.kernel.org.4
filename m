Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5656E6D18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjDRTtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjDRTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:49:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B88E26AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:49:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so3335519a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681847383; x=1684439383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+idvV1ZL7adh1tpSu7+KapwbbNDiWxo1F9MvrHJLdoc=;
        b=OFJ6WwQLO7SICgDFMBXffF0MATElUMHNcqz4ua6vO99x+SYQA/FF3LB/p2ia6NrXgl
         0GIj4ZEHCJR4oX7CjDTCAQvWf6sl20KRZRac2D0pHeBicFPl3r+I0gbjUV1/rifepD+i
         DDB6cy2SHfy/kD7VjaheXL6hs0pnJnZrF/S47Y1sHTYFeoLyf4Gxk+DTWK6oxnugae5b
         XbZ9UBkfxiX/9sOUqGXHxb7TaTv3ykL4q3xHZ+4SgV9/xmHiyPtJk/4m3f85+PzDJaab
         HuZv6nM+J2PNizj2XGdYrUiqpiZnkraE6HcRh07xwde0L3KvqvY42G7s8qOPjXXALvXP
         ziyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847383; x=1684439383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+idvV1ZL7adh1tpSu7+KapwbbNDiWxo1F9MvrHJLdoc=;
        b=Zv4Y1zNrozBiujzwrqeRLzVgYMNCjw0G52xjwA+sbIMtwK2Rkx+Xk+Ll/27ihVIwN2
         IWNMXiZzY1Bfv99Fs1x0u9lAuqJg+VfdkXHlMmYOc1B0pRaBtLuQE0TpY4S84lDnBBPr
         pcp16X4EQTRgIuJi3mpvgFEnqgQVy1O5S8UO/lfJg2LA0/7gh5yg4BV6a6t20uITch2f
         G48MxEF9y80f8o4UzICuZYDBUOILerXBnT2AqBr/Sh6ekGSQCGU7Npn9mdPFcFkZIC9F
         q/uejtBK27xSohuePSKmUK1DOPe4LNuokmnkmXx/IT9z7R2j6WwaAvTAHRokW3TbPnDh
         PYkQ==
X-Gm-Message-State: AAQBX9fyESLDacZANT/mRiNyp3jK6tNuSPASEzTmd+QzJGsv9Q/H4FOs
        uNvlgZI5c3LCt9+dTp54gTYo1OpoKhQ/wXLLXEie7A==
X-Google-Smtp-Source: AKy350Yql5FPZb553sRiA3/h+BlHZ1wWmDZ+4b29lpRpyfAaYBY3rDQ6MNcq2kY2M4edUhVueFstRsapT9LJSREEwzQ=
X-Received: by 2002:a05:6402:520b:b0:506:771a:60d6 with SMTP id
 s11-20020a056402520b00b00506771a60d6mr42683edd.1.1681847382934; Tue, 18 Apr
 2023 12:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230418074639.1903197-1-senozhatsky@chromium.org>
In-Reply-To: <20230418074639.1903197-1-senozhatsky@chromium.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Apr 2023 12:49:04 -0700
Message-ID: <CAJD7tka8HxkFkXST_DRD6VCgCvvABZNt+aSWSjxOzBC3DXOUSQ@mail.gmail.com>
Subject: Re: [PATCHv3] zsmalloc: allow only one active pool compaction context
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

On Tue, Apr 18, 2023 at 12:46=E2=80=AFAM Sergey Senozhatsky
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
> Pool compaction is currently (basically) single-threaded as
> it is performed under pool->lock. Having multiple compaction
> threads results in unnecessary contention, as each thread
> competes for pool->lock. This, in turn, affects all zsmalloc
> operations such as zs_malloc(), zs_map_object(), zs_free(), etc.
>
> Introduce the pool->compaction_in_progress atomic variable,
> which ensures that only one compaction context can run at a
> time. This reduces overall pool->lock contention in (corner)
> cases when many contexts attempt to shrink zspool simultaneously.
>
> Fixes: c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and si=
ze_class's locks")
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>


Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zsmalloc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index cc81dfba05a0..44ddaf5d601e 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -264,6 +264,7 @@ struct zs_pool {
>         struct work_struct free_work;
>  #endif
>         spinlock_t lock;
> +       atomic_t compaction_in_progress;
>  };
>
>  struct zspage {
> @@ -2274,6 +2275,15 @@ unsigned long zs_compact(struct zs_pool *pool)
>         struct size_class *class;
>         unsigned long pages_freed =3D 0;
>
> +       /*
> +        * Pool compaction is performed under pool->lock so it is basical=
ly
> +        * single-threaded. Having more than one thread in __zs_compact()
> +        * will increase pool->lock contention, which will impact other
> +        * zsmalloc operations that need pool->lock.
> +        */
> +       if (atomic_xchg(&pool->compaction_in_progress, 1))
> +               return 0;
> +
>         for (i =3D ZS_SIZE_CLASSES - 1; i >=3D 0; i--) {
>                 class =3D pool->size_class[i];
>                 if (class->index !=3D i)
> @@ -2281,6 +2291,7 @@ unsigned long zs_compact(struct zs_pool *pool)
>                 pages_freed +=3D __zs_compact(pool, class);
>         }
>         atomic_long_add(pages_freed, &pool->stats.pages_compacted);
> +       atomic_set(&pool->compaction_in_progress, 0);
>
>         return pages_freed;
>  }
> @@ -2388,6 +2399,7 @@ struct zs_pool *zs_create_pool(const char *name)
>
>         init_deferred_free(pool);
>         spin_lock_init(&pool->lock);
> +       atomic_set(&pool->compaction_in_progress, 0);
>
>         pool->name =3D kstrdup(name, GFP_KERNEL);
>         if (!pool->name)
> --
> 2.40.0.634.g4ca3ef3211-goog
>
