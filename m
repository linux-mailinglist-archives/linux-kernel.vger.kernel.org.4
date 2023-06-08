Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9BF7286A2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjFHRvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFHRvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:51:47 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0602D52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:51:45 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6260b578097so7109206d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686246704; x=1688838704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJEs83/HazzxZ3tGxgQ/SYu3azpSRI6recMD0zhZQxc=;
        b=FroF/C53tcVwV1IsQTZ7UAURuMvsfcAqWcoCpq/WW+Ie36s3XxlvAJa09ez0vZBIWZ
         gtzEMDKlWzljLTS3MrVsH3zjTzj4Cj6m6nGZmri9lajRW7mQW01AXMUv+INHarXDWEjb
         Oljgh8nuUF0ZqZXR9o4ztjgIER5FIfouxzuOQWdLfFIbHdYKny9M8V8xJZxESpdCcx2a
         wqzsHF16PrssQ41VfJpt/IlKvz7jexcfbAhwo73F/UB2pd7+tvOvXGkeHRpfQtxZJVwS
         1NRIhA+MYpDdLTPdKrG7GCBbGCCChH262tvS8y9/lqr7wBi6A1BqRpgjJI6z7fi00AUW
         JbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686246704; x=1688838704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJEs83/HazzxZ3tGxgQ/SYu3azpSRI6recMD0zhZQxc=;
        b=Te7nGbQOH4KIbuebnV7COephv2Ir5Xi5aAuuEsd55AEqjLdjTA5zQqHRIRx75ZKEJu
         0n55lH0ZJ0UqR/OUyadwXRJB5tAk6x+YnAN74zVrR1TtyTpUckKIL98Z5HZ4vTu6a0O6
         Ar3H1lE+A8emgcPsDvb/nS2z2Pw3NFeYNkG9uzOx1s2P+5UMEyuxidaPqFmkqpyFRFP1
         sY+7P7xUc1xg8jLwlddsgjLhmfI25EH/t4mO1NaxgTQEnGlOYeykLM6M5zRsxVxA4Wi4
         AykQ863MvXJTf83H6XRifnXnpEd9qYEh/U4JJRO56+ROwCja9Nlw8/eBLm3s+u586Gt7
         sz2w==
X-Gm-Message-State: AC+VfDwW7W/ujK+/CJiMg5eV2XQDTda6MiGH0QXe0VE+POKoJ24McE4r
        RoUKDzllV0VuiYuXwAEAslbS5SQvN4baUiEyMU0=
X-Google-Smtp-Source: ACHHUZ54F3OMtx02+WqBGogvo1r/GggPvBrI9fHQ8o0stXDhd+gLAT7hrVi0zKIx2sUibWNBWD8FOcN4K+tELvx+b90=
X-Received: by 2002:a05:6214:f2f:b0:625:aa48:e62f with SMTP id
 iw15-20020a0562140f2f00b00625aa48e62fmr2668295qvb.63.1686246704168; Thu, 08
 Jun 2023 10:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-6-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-6-cerasuolodomenico@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 8 Jun 2023 10:51:33 -0700
Message-ID: <CAKEwX=ORH2B3Xv0+oZptFi2Oz_tr5-=PSqNCvFfEcOt0KgWL8A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/7] mm: zswap: remove shrink from zpool interface
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
zsmalloc's shrink removal looks good to me.
Acked-by: Nhat Pham <nphamcs@gmail.com>
