Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382A963BF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiK2Lxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiK2Lxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:53:42 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8971155A87
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:53:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so12008684pjo.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kdr4qqlcDI/C93KNdQRixFidR215xARpd9gca61oCW8=;
        b=IYWVhThXpeOBdgTAf4CZcma2/HYD9mVPKvq70DQdaREb42zfZ4X8jUCUp8Xcwz2mqG
         uSti/5atO+xgqDNwbpZN2XpIbDLxZ1KjIGUh3Cn3YJaTDObTos63C+DFDX/tWAGGniNr
         cS65A7Be80SZZ4eJt9prLujUrkqJS4bEhDic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdr4qqlcDI/C93KNdQRixFidR215xARpd9gca61oCW8=;
        b=Q/EN25BYam+ZbjQPxW2JwxnNgEaKJk1aAfNiNDdXvsIp1qrgBN8+DxvpxA28HT9WY0
         o9yKZRqHyrFreZkb26aPBJFwl4j/DaZwg6Ca0tiiPAX5GoJXMfdKVBq9hCqAnFJUEwZ5
         PU/AxL90xl3ls5KW/shLHAAsmpPozGjsnkKJfUQnTu4x7sSCYEhUTGa6Bg8dZtNZ65os
         jI1NOvj0kT5+Eks0uMjbNUV1LJAYN8qP9Vu9DzfItUUK/6R5IBsHDY6XGxJyIFqseD7A
         q2PXhIpA1w44h6NiMv0jMYBnAHG/mPSgSV66F4d/RPR5q8AVW0csHkPBU9RSeFUeU9F4
         Cfew==
X-Gm-Message-State: ANoB5pkAxjIGysGwSImY5JHwcaDVEJqUi8hK6GWWoI3N3b85UUpm6vZx
        ftnkni3g9OrNyM0ZWMPAuiRfSc0zZBZD2wS+5rRZ7s2EPW0c6g==
X-Google-Smtp-Source: AA0mqf7QVFpK5qVliFVVzpjCWhALK8q6Yi2gWV5WFWKFjlfkiWqWFL3UMvyWpK0PekfmGrXyPTajL5gnSxG7CQ28LxI=
X-Received: by 2002:a17:90a:fa16:b0:218:f998:a9c0 with SMTP id
 cm22-20020a17090afa1600b00218f998a9c0mr27160673pjb.185.1669722821039; Tue, 29
 Nov 2022 03:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20221128191616.1261026-1-nphamcs@gmail.com> <20221128191616.1261026-5-nphamcs@gmail.com>
In-Reply-To: <20221128191616.1261026-5-nphamcs@gmail.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Tue, 29 Nov 2022 12:53:30 +0100
Message-ID: <CAM4kBB+7boz+PZfPODbS-KMGOPZpa2QO5xZMoP2q_ZfGyqmQTA@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 8:16 PM Nhat Pham <nphamcs@gmail.com> wrote:
>
> This helps determines the coldest zspages as candidates for writeback.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zsmalloc.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 5427a00a0518..b1bc231d94a3 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -239,6 +239,11 @@ struct zs_pool {
>         /* Compact classes */
>         struct shrinker shrinker;
>
> +#ifdef CONFIG_ZPOOL
> +       /* List tracking the zspages in LRU order by most recently added object */
> +       struct list_head lru;
> +#endif
> +
>  #ifdef CONFIG_ZSMALLOC_STAT
>         struct dentry *stat_dentry;
>  #endif
> @@ -260,6 +265,12 @@ struct zspage {
>         unsigned int freeobj;
>         struct page *first_page;
>         struct list_head list; /* fullness list */
> +
> +#ifdef CONFIG_ZPOOL
> +       /* links the zspage to the lru list in the pool */
> +       struct list_head lru;
> +#endif
> +
>         struct zs_pool *pool;
>  #ifdef CONFIG_COMPACTION
>         rwlock_t lock;
> @@ -953,6 +964,9 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
>         }
>
>         remove_zspage(class, zspage, ZS_EMPTY);
> +#ifdef CONFIG_ZPOOL
> +       list_del(&zspage->lru);
> +#endif
>         __free_zspage(pool, class, zspage);
>  }
>
> @@ -998,6 +1012,10 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
>                 off %= PAGE_SIZE;
>         }
>
> +#ifdef CONFIG_ZPOOL
> +       INIT_LIST_HEAD(&zspage->lru);
> +#endif
> +
>         set_freeobj(zspage, 0);
>  }
>
> @@ -1270,6 +1288,31 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
>         obj_to_location(obj, &page, &obj_idx);
>         zspage = get_zspage(page);
>
> +#ifdef CONFIG_ZPOOL
> +       /*
> +        * Move the zspage to front of pool's LRU.
> +        *
> +        * Note that this is swap-specific, so by definition there are no ongoing
> +        * accesses to the memory while the page is swapped out that would make
> +        * it "hot". A new entry is hot, then ages to the tail until it gets either
> +        * written back or swaps back in.
> +        *
> +        * Furthermore, map is also called during writeback. We must not put an
> +        * isolated page on the LRU mid-reclaim.
> +        *
> +        * As a result, only update the LRU when the page is mapped for write
> +        * when it's first instantiated.
> +        *
> +        * This is a deviation from the other backends, which perform this update
> +        * in the allocation function (zbud_alloc, z3fold_alloc).
> +        */
> +       if (mm == ZS_MM_WO) {
> +               if (!list_empty(&zspage->lru))
> +                       list_del(&zspage->lru);
> +               list_add(&zspage->lru, &pool->lru);
> +       }
> +#endif
> +
>         /*
>          * migration cannot move any zpages in this zspage. Here, pool->lock
>          * is too heavy since callers would take some time until they calls
> @@ -1988,6 +2031,9 @@ static void async_free_zspage(struct work_struct *work)
>                 VM_BUG_ON(fullness != ZS_EMPTY);
>                 class = pool->size_class[class_idx];
>                 spin_lock(&pool->lock);
> +#ifdef CONFIG_ZPOOL
> +               list_del(&zspage->lru);
> +#endif
>                 __free_zspage(pool, class, zspage);
>                 spin_unlock(&pool->lock);
>         }
> @@ -2299,6 +2345,10 @@ struct zs_pool *zs_create_pool(const char *name)
>          */
>         zs_register_shrinker(pool);
>
> +#ifdef CONFIG_ZPOOL
> +       INIT_LIST_HEAD(&pool->lru);
> +#endif

I think the amount of #ifdefs here becomes absolutely overwhelming.
Not that zsmalloc code was very readable before, but now it is
starting to look like a plain disaster.

Thanks,
Vitaly

> +
>         return pool;
>
>  err:
> --
> 2.30.2
