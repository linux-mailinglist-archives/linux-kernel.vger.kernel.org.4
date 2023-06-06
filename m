Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB3272352C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbjFFCTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFFCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:19:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B607116
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:19:05 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977e0fbd742so222955866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686017944; x=1688609944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJV9fIm1sayCr3BzLeeW4kPhrtrzZ+XU13P7Fjc+e7s=;
        b=ZPbnFL21EdIjuB+MnUfSO8OwphWEwnD4KI7cPhKYSLZBxvEMq6xwm2ggnqk4I92IaQ
         /xAyjFj3tyfZgw8GGuZejguodcMZaO2IUVdSZv1TgcjKi/tEGCd4Blp92wped4IQ3znv
         3fiNZTj+26KHsv5YwWW/OTU/zAtPnU8wtqeN7n1Tkdet5G6qyqUtKk3d/tPADiHhoVJI
         FqhoBjwtoQqzw0JufcyqpKiE0g1N4KF9jdD2cYHEgHCVrjClKCr1eXTLgP4P6rpu4vsf
         2s2aWJHO5CBlzHP96kOsCz3PE5M+Er3sJq2bfHMOqbe0s2ZsKP+dq5lSUK5mqtsgLkdc
         bLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017944; x=1688609944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJV9fIm1sayCr3BzLeeW4kPhrtrzZ+XU13P7Fjc+e7s=;
        b=G9BeGIJXK3LLN4l+oGW8qSSmFwtTdTmBt6doPRrz8oVpHhHPmGotixwsULifmUzCuq
         Xd+Fjrvt8AkNZkr7wmmO97WarUut/FC63g/UyGU8N16LGpKTwx8Da1f9BxpNQlNTh4l4
         yLmXlP5Zlkn9/YiKtCA62BKACXqXD13/83HGTTcNa4hLub/eNuSrtpCsXVTLZpOF+HmO
         3oIele6HhVmQIRACZUhgGHW40Nn1Fuhk3AmmjkskUKTkEriyot20oLsfRk3P6vd7MvWj
         JtBNWI6KUWEOqvSvhTtfMderb3omdJAIBjNfwY9KqhQnaEyU6JgppJExyF+GbNlEUSAE
         7mGQ==
X-Gm-Message-State: AC+VfDynAqQsAjPgWxhELogFY0Syyo0vzuYGYbVWW96CFd3llw2lqE/v
        LJoviNIXsWgk4/Rr/4HPjYuWo9Ou5v2DgdTSnrTkXw==
X-Google-Smtp-Source: ACHHUZ7GYA4PLmnXdb+F4vQ7yj84a4GM1TXO74XULUMe43pi3cSc4R3CW3n/HEtnwTy0INYilIHjJx0zOE92w/R6KB0=
X-Received: by 2002:a17:907:720c:b0:974:6de:8a5e with SMTP id
 dr12-20020a170907720c00b0097406de8a5emr670871ejc.40.1686017943509; Mon, 05
 Jun 2023 19:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com> <20230605085419.44383-2-cerasuolodomenico@gmail.com>
In-Reply-To: <20230605085419.44383-2-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 5 Jun 2023 19:18:27 -0700
Message-ID: <CAJD7tka+_-MZDwbyt8vewvgRzRNg9jpFL7pxfu4ruceGpCkqCw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm: zswap: add pool shrinking mechanism
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

Hi Domenico,

On Mon, Jun 5, 2023 at 1:54=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
> function, which is called from zpool_shrink. However, with this commit,
> a unified shrink function is added to zswap. The ultimate goal is to
> eliminate the need for zpool_shrink once all zpool implementations have
> dropped their shrink code.
>
> To ensure the functionality of each commit, this change focuses solely
> on adding the mechanism itself. No modifications are made to
> the backends, meaning that functionally, there are no immediate changes.
> The zswap mechanism will only come into effect once the backends have
> removed their shrink code. The subsequent commits will address the
> modifications needed in the backends.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 78 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index bcb82e09eb64..80d7780bf066 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -159,6 +159,8 @@ struct zswap_pool {
>         struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +       struct list_head lru;
> +       spinlock_t lock;

If this lock is only protecting the lru then I believe it's better to
call in lru_lock to make it explicit.

>  };
>
>  /*
> @@ -176,10 +178,12 @@ struct zswap_pool {
>   *            be held while changing the refcount.  Since the lock must
>   *            be held, there is no reason to also make refcount atomic.
>   * length - the length in bytes of the compressed page data.  Needed dur=
ing
> - *          decompression. For a same value filled page length is 0.
> + *          decompression. For a same value filled page length is 0, and=
 both
> + *          pool and lru are invalid and must be ignored.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
>   * value - value of the same-value filled pages which have same content
> + * lru - handle to the pool's lru used to evict pages.
>   */
>  struct zswap_entry {
>         struct rb_node rbnode;
> @@ -192,6 +196,7 @@ struct zswap_entry {
>                 unsigned long value;
>         };
>         struct obj_cgroup *objcg;
> +       struct list_head lru;
>  };
>
>  struct zswap_header {
> @@ -364,6 +369,9 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> +               spin_lock(&entry->pool->lock);
> +               list_del_init(&entry->lru);
> +               spin_unlock(&entry->pool->lock);

I think we should document the lock ordering somewhere (tree lock ->
lru lock), otherwise we may run into an ABBA deadlock down the road.

>                 zpool_free(entry->pool->zpool, entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
> @@ -584,14 +592,65 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
>         return NULL;
>  }
>
> +static int zswap_shrink(struct zswap_pool *pool)
> +{
> +       struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> +       struct zswap_header *zhdr;
> +       struct zswap_tree *tree;
> +       swp_entry_t swpentry;
> +       int ret;
> +
> +       /* get a reclaimable entry from LRU */
> +       spin_lock(&pool->lock);
> +       if (list_empty(&pool->lru)) {
> +               spin_unlock(&pool->lock);
> +               return -EINVAL;
> +       }
> +       lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> +       list_del_init(&lru_entry->lru);
> +       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_M=
M_RO);
> +       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> +       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> +       swpentry =3D zhdr->swpentry;
> +       spin_unlock(&pool->lock);
> +
> +       /* hold a reference from tree so it won't be freed during writeba=
ck */
> +       spin_lock(&tree->lock);
> +       tree_entry =3D zswap_entry_find_get(&tree->rbroot, swp_offset(swp=
entry));
> +       if (tree_entry !=3D lru_entry) {
> +               if (tree_entry)
> +                       zswap_entry_put(tree, tree_entry);
> +               spin_unlock(&tree->lock);
> +               return -EAGAIN;
> +       }
> +       spin_unlock(&tree->lock);
> +
> +       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> +
> +       spin_lock(&tree->lock);
> +       if (ret) {
> +               spin_lock(&pool->lock);
> +               list_move(&lru_entry->lru, &pool->lru);
> +               spin_unlock(&pool->lock);
> +       }
> +       zswap_entry_put(tree, tree_entry);
> +       spin_unlock(&tree->lock);
> +
> +       return ret ? -EAGAIN : 0;
> +}
> +
>  static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
>         int ret, failures =3D 0;
>
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted*/
>         do {
> -               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (zpool_evictable(pool->zpool))
> +                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               else
> +                       ret =3D zswap_shrink(pool);
>                 if (ret) {
>                         zswap_reject_reclaim_fail++;
>                         if (ret !=3D -EAGAIN)
> @@ -655,6 +714,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> +       INIT_LIST_HEAD(&pool->lru);
> +       spin_lock_init(&pool->lock);
>         INIT_WORK(&pool->shrink_work, shrink_worker);
>
>         zswap_pool_debug("created", pool);
> @@ -1270,7 +1331,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         }
>
>         /* store */
> -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> +       hlen =3D sizeof(zhdr);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(entry->pool->zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> @@ -1313,6 +1374,13 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>                         zswap_entry_put(tree, dupentry);
>                 }
>         } while (ret =3D=3D -EEXIST);
> +       INIT_LIST_HEAD(&entry->lru);
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted*/
> +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +               spin_lock(&entry->pool->lock);
> +               list_add(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lock);
> +       }
>         spin_unlock(&tree->lock);
>
>         /* update stats */
> @@ -1384,8 +1452,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         /* decompress */
>         dlen =3D PAGE_SIZE;
>         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL=
_MM_RO);
> -       if (zpool_evictable(entry->pool->zpool))
> -               src +=3D sizeof(struct zswap_header);
> +       src +=3D sizeof(struct zswap_header);
>
>         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
>                 memcpy(tmp, src, entry->length);
> @@ -1415,6 +1482,12 @@ static int zswap_frontswap_load(unsigned type, pgo=
ff_t offset,
>  freeentry:
>         spin_lock(&tree->lock);
>         zswap_entry_put(tree, entry);
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted*/
> +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +               spin_lock(&entry->pool->lock);
> +               list_move(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lock);
> +       }
>         spin_unlock(&tree->lock);
>
>         return ret;
> --
> 2.34.1
>
