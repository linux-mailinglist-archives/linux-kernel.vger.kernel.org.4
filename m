Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682917259F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbjFGJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbjFGJTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:19:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B01F11F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:19:50 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9745ba45cd1so932522566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686129589; x=1688721589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsO2fDCCjU12t+1l8gk19vN8ug8CqsIXdQ0D1R6pv2k=;
        b=sX2QchexK4Akrf10SCldWV3tVY5RiwBpTASrE4IvPCofcygUSyvvDjpXKpVfYMscBB
         Cj1OwvNOlFHkE9WtbKVCguFfTlBiM6qNKY52Wcez3HDoVZlOGrWYw2kpfXyDFqACP7Cj
         mHHj9oOmt0fIX+M2SQJeHn0m70QRFpJT8SvMkzAnOlbUykBIQ9JJvZ9WIbeuMEnlr8iG
         EJPwTjPUBfzSCJ0OccUMiVhCsIY6R6Dg1+3/XdZrUjSsydY5ycdnxkUek+fAbq678tH6
         lLcAAgbXrhkTQYuSnPUbpgxhoiBIg5f/pienl7w85CqZYcaFVpzWuOlbigo6+WpOy/8f
         9PmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129589; x=1688721589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsO2fDCCjU12t+1l8gk19vN8ug8CqsIXdQ0D1R6pv2k=;
        b=G/tlGU8PIex4I67c2GYULmU9K831DHMFkB7Wikud2f2HAl8UUyNFbiBTzGQA6WzOjU
         jw64jMGtxvN/bMpUVqcHWlY5V504VNFkepPLchbqn3oiO84P4E8FBXYfqljjZ+/mencH
         6zP8ktNOMcaZWv/FJZs3L9p7Pq2L8VOBKP7buA9v/oMsXFDpqkU/XE3BR6Ap+zq/o5ED
         pWtBxNbQsQKt15hKaHkZl7XkpGWQoCmv4TNASw2bCN5FqNZoIIuBG5zzmcubKrtjIvU+
         T2WLxBTPZOW8h63IV+94EtWh4oCm/EfcULevg4prjBQ0dMKMiQWCwj5T2Kf/zG52mF+x
         pTTQ==
X-Gm-Message-State: AC+VfDzmO/HwlQ8INj0C5Q9E4IoKQKGVZfIIfnvJy+vr0c9G8vGe9Wjz
        thI1f/xeDXHWLUJry8DKVLYl5Aryw5KXqH6Q5Oni+Q==
X-Google-Smtp-Source: ACHHUZ6eDA3AR3JLPZD0jZP/NB5HflhkvQl9YvDv+fV2Dyn//K9es2B4Mm+dhqkOexNxa0oStxuLvvrGMcTTkfRsjRo=
X-Received: by 2002:a17:907:1609:b0:974:1ced:6a59 with SMTP id
 hb9-20020a170907160900b009741ced6a59mr6155886ejc.3.1686129588776; Wed, 07 Jun
 2023 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-6-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-6-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:19:12 -0700
Message-ID: <CAJD7tkZ7jyf--LviZiRXTaXjvW+duHZ2CVK9TZy0bb9w97n0pw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] mm: zswap: remove shrink from zpool interface
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

On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Now that all three zswap backends have removed their shrink code, it is
> no longer necessary for the zpool interface to include shrink/writeback
> endpoints.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

I will leave reviewing the driver-specific patches to the respective
maintainers, but this cleanup LGTM otherwise.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/zpool.h | 19 ++---------------
>  mm/z3fold.c           |  5 +----
>  mm/zbud.c             |  5 +----
>  mm/zpool.c            | 48 ++-----------------------------------------
>  mm/zsmalloc.c         |  5 +----
>  mm/zswap.c            | 27 +++++++-----------------
>  6 files changed, 14 insertions(+), 95 deletions(-)
>
> diff --git a/include/linux/zpool.h b/include/linux/zpool.h
> index e8997010612a..6b15a4213de5 100644
> --- a/include/linux/zpool.h
> +++ b/include/linux/zpool.h
> @@ -14,10 +14,6 @@
>
>  struct zpool;
>
> -struct zpool_ops {
> -       int (*evict)(struct zpool *pool, unsigned long handle);
> -};
> -
>  /*
>   * Control how a handle is mapped.  It will be ignored if the
>   * implementation does not support it.  Its use is optional.
> @@ -40,7 +36,7 @@ enum zpool_mapmode {
>  bool zpool_has_pool(char *type);
>
>  struct zpool *zpool_create_pool(const char *type, const char *name,
> -                       gfp_t gfp, const struct zpool_ops *ops);
> +                       gfp_t gfp);
>
>  const char *zpool_get_type(struct zpool *pool);
>
> @@ -53,9 +49,6 @@ int zpool_malloc(struct zpool *pool, size_t size, gfp_t=
 gfp,
>
>  void zpool_free(struct zpool *pool, unsigned long handle);
>
> -int zpool_shrink(struct zpool *pool, unsigned int pages,
> -                       unsigned int *reclaimed);
> -
>  void *zpool_map_handle(struct zpool *pool, unsigned long handle,
>                         enum zpool_mapmode mm);
>
> @@ -72,7 +65,6 @@ u64 zpool_get_total_size(struct zpool *pool);
>   * @destroy:   destroy a pool.
>   * @malloc:    allocate mem from a pool.
>   * @free:      free mem from a pool.
> - * @shrink:    shrink the pool.
>   * @sleep_mapped: whether zpool driver can sleep during map.
>   * @map:       map a handle.
>   * @unmap:     unmap a handle.
> @@ -87,10 +79,7 @@ struct zpool_driver {
>         atomic_t refcount;
>         struct list_head list;
>
> -       void *(*create)(const char *name,
> -                       gfp_t gfp,
> -                       const struct zpool_ops *ops,
> -                       struct zpool *zpool);
> +       void *(*create)(const char *name, gfp_t gfp);
>         void (*destroy)(void *pool);
>
>         bool malloc_support_movable;
> @@ -98,9 +87,6 @@ struct zpool_driver {
>                                 unsigned long *handle);
>         void (*free)(void *pool, unsigned long handle);
>
> -       int (*shrink)(void *pool, unsigned int pages,
> -                               unsigned int *reclaimed);
> -
>         bool sleep_mapped;
>         void *(*map)(void *pool, unsigned long handle,
>                                 enum zpool_mapmode mm);
> @@ -113,7 +99,6 @@ void zpool_register_driver(struct zpool_driver *driver=
);
>
>  int zpool_unregister_driver(struct zpool_driver *driver);
>
> -bool zpool_evictable(struct zpool *pool);
>  bool zpool_can_sleep_mapped(struct zpool *pool);
>
>  #endif
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4af8741553ac..e84de91ecccb 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1364,9 +1364,7 @@ static const struct movable_operations z3fold_mops =
=3D {
>   * zpool
>   ****************/
>
> -static void *z3fold_zpool_create(const char *name, gfp_t gfp,
> -                              const struct zpool_ops *zpool_ops,
> -                              struct zpool *zpool)
> +static void *z3fold_zpool_create(const char *name, gfp_t gfp)
>  {
>         return z3fold_create_pool(name, gfp);
>  }
> @@ -1409,7 +1407,6 @@ static struct zpool_driver z3fold_zpool_driver =3D =
{
>         .destroy =3D      z3fold_zpool_destroy,
>         .malloc =3D       z3fold_zpool_malloc,
>         .free =3D         z3fold_zpool_free,
> -       .shrink =3D       NULL,
>         .map =3D          z3fold_zpool_map,
>         .unmap =3D        z3fold_zpool_unmap,
>         .total_size =3D   z3fold_zpool_total_size,
> diff --git a/mm/zbud.c b/mm/zbud.c
> index 19bc662ef5e9..2190cc1f37b3 100644
> --- a/mm/zbud.c
> +++ b/mm/zbud.c
> @@ -380,9 +380,7 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
>   * zpool
>   ****************/
>
> -static void *zbud_zpool_create(const char *name, gfp_t gfp,
> -                              const struct zpool_ops *zpool_ops,
> -                              struct zpool *zpool)
> +static void *zbud_zpool_create(const char *name, gfp_t gfp)
>  {
>         return zbud_create_pool(gfp);
>  }
> @@ -425,7 +423,6 @@ static struct zpool_driver zbud_zpool_driver =3D {
>         .destroy =3D      zbud_zpool_destroy,
>         .malloc =3D       zbud_zpool_malloc,
>         .free =3D         zbud_zpool_free,
> -       .shrink =3D       NULL,
>         .map =3D          zbud_zpool_map,
>         .unmap =3D        zbud_zpool_unmap,
>         .total_size =3D   zbud_zpool_total_size,
> diff --git a/mm/zpool.c b/mm/zpool.c
> index 6a19c4a58f77..846410479c2f 100644
> --- a/mm/zpool.c
> +++ b/mm/zpool.c
> @@ -133,7 +133,6 @@ EXPORT_SYMBOL(zpool_has_pool);
>   * @type:      The type of the zpool to create (e.g. zbud, zsmalloc)
>   * @name:      The name of the zpool (e.g. zram0, zswap)
>   * @gfp:       The GFP flags to use when allocating the pool.
> - * @ops:       The optional ops callback.
>   *
>   * This creates a new zpool of the specified type.  The gfp flags will b=
e
>   * used when allocating memory, if the implementation supports it.  If t=
he
> @@ -145,8 +144,7 @@ EXPORT_SYMBOL(zpool_has_pool);
>   *
>   * Returns: New zpool on success, NULL on failure.
>   */
> -struct zpool *zpool_create_pool(const char *type, const char *name, gfp_=
t gfp,
> -               const struct zpool_ops *ops)
> +struct zpool *zpool_create_pool(const char *type, const char *name, gfp_=
t gfp)
>  {
>         struct zpool_driver *driver;
>         struct zpool *zpool;
> @@ -173,7 +171,7 @@ struct zpool *zpool_create_pool(const char *type, con=
st char *name, gfp_t gfp,
>         }
>
>         zpool->driver =3D driver;
> -       zpool->pool =3D driver->create(name, gfp, ops, zpool);
> +       zpool->pool =3D driver->create(name, gfp);
>
>         if (!zpool->pool) {
>                 pr_err("couldn't create %s pool\n", type);
> @@ -279,30 +277,6 @@ void zpool_free(struct zpool *zpool, unsigned long h=
andle)
>         zpool->driver->free(zpool->pool, handle);
>  }
>
> -/**
> - * zpool_shrink() - Shrink the pool size
> - * @zpool:     The zpool to shrink.
> - * @pages:     The number of pages to shrink the pool.
> - * @reclaimed: The number of pages successfully evicted.
> - *
> - * This attempts to shrink the actual memory size of the pool
> - * by evicting currently used handle(s).  If the pool was
> - * created with no zpool_ops, or the evict call fails for any
> - * of the handles, this will fail.  If non-NULL, the @reclaimed
> - * parameter will be set to the number of pages reclaimed,
> - * which may be more than the number of pages requested.
> - *
> - * Implementations must guarantee this to be thread-safe.
> - *
> - * Returns: 0 on success, negative value on error/failure.
> - */
> -int zpool_shrink(struct zpool *zpool, unsigned int pages,
> -                       unsigned int *reclaimed)
> -{
> -       return zpool->driver->shrink ?
> -              zpool->driver->shrink(zpool->pool, pages, reclaimed) : -EI=
NVAL;
> -}
> -
>  /**
>   * zpool_map_handle() - Map a previously allocated handle into memory
>   * @zpool:     The zpool that the handle was allocated from
> @@ -359,24 +333,6 @@ u64 zpool_get_total_size(struct zpool *zpool)
>         return zpool->driver->total_size(zpool->pool);
>  }
>
> -/**
> - * zpool_evictable() - Test if zpool is potentially evictable
> - * @zpool:     The zpool to test
> - *
> - * Zpool is only potentially evictable when it's created with struct
> - * zpool_ops.evict and its driver implements struct zpool_driver.shrink.
> - *
> - * However, it doesn't necessarily mean driver will use zpool_ops.evict
> - * in its implementation of zpool_driver.shrink. It could do internal
> - * defragmentation instead.
> - *
> - * Returns: true if potentially evictable; false otherwise.
> - */
> -bool zpool_evictable(struct zpool *zpool)
> -{
> -       return zpool->driver->shrink;
> -}
> -
>  /**
>   * zpool_can_sleep_mapped - Test if zpool can sleep when do mapped.
>   * @zpool:     The zpool to test
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 75386283dba0..634daa19b6c2 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -351,9 +351,7 @@ static void record_obj(unsigned long handle, unsigned=
 long obj)
>
>  #ifdef CONFIG_ZPOOL
>
> -static void *zs_zpool_create(const char *name, gfp_t gfp,
> -                            const struct zpool_ops *zpool_ops,
> -                            struct zpool *zpool)
> +static void *zs_zpool_create(const char *name, gfp_t gfp)
>  {
>         /*
>          * Ignore global gfp flags: zs_malloc() may be invoked from
> @@ -420,7 +418,6 @@ static struct zpool_driver zs_zpool_driver =3D {
>         .malloc_support_movable =3D true,
>         .malloc =3D                 zs_zpool_malloc,
>         .free =3D                   zs_zpool_free,
> -       .shrink =3D                 NULL,
>         .map =3D                    zs_zpool_map,
>         .unmap =3D                  zs_zpool_unmap,
>         .total_size =3D             zs_zpool_total_size,
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c99bafcefecf..2831bf56b168 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -254,10 +254,6 @@ static int zswap_writeback_entry(struct zpool *pool,=
 unsigned long handle);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
>
> -static const struct zpool_ops zswap_zpool_ops =3D {
> -       .evict =3D zswap_writeback_entry
> -};
> -
>  static bool zswap_is_full(void)
>  {
>         return totalram_pages() * zswap_max_pool_percent / 100 <
> @@ -375,12 +371,9 @@ static void zswap_free_entry(struct zswap_entry *ent=
ry)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> -       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> -               if (!zpool_evictable(entry->pool->zpool)) {
> -                       spin_lock(&entry->pool->lru_lock);
> -                       list_del(&entry->lru);
> -                       spin_unlock(&entry->pool->lru_lock);
> -               }
> +               spin_lock(&entry->pool->lru_lock);
> +               list_del(&entry->lru);
> +               spin_unlock(&entry->pool->lru_lock);
>                 zpool_free(entry->pool->zpool, entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
> @@ -659,12 +652,8 @@ static void shrink_worker(struct work_struct *w)
>                                                 shrink_work);
>         int ret, failures =3D 0;
>
> -       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
>         do {
> -               if (zpool_evictable(pool->zpool))
> -                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> -               else
> -                       ret =3D zswap_shrink(pool);
> +               ret =3D zswap_shrink(pool);
>                 if (ret) {
>                         zswap_reject_reclaim_fail++;
>                         if (ret !=3D -EAGAIN)
> @@ -702,7 +691,7 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>         /* unique name for each pool specifically required by zsmalloc */
>         snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_coun=
t));
>
> -       pool->zpool =3D zpool_create_pool(type, name, gfp, &zswap_zpool_o=
ps);
> +       pool->zpool =3D zpool_create_pool(type, name, gfp);
>         if (!pool->zpool) {
>                 pr_err("%s zpool not available\n", type);
>                 goto error;
> @@ -1388,8 +1377,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>                         zswap_entry_put(tree, dupentry);
>                 }
>         } while (ret =3D=3D -EEXIST);
> -       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> -       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +       if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_add(&entry->lru, &entry->pool->lru);
>                 spin_unlock(&entry->pool->lru_lock);
> @@ -1495,8 +1483,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>  freeentry:
>         spin_lock(&tree->lock);
>         zswap_entry_put(tree, entry);
> -       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> -       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +       if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
>                 list_move(&entry->lru, &entry->pool->lru);
>                 spin_unlock(&entry->pool->lru_lock);
> --
> 2.34.1
>
