Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A547173BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjEaCdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEaCdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:33:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758D113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:33:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f588bc322so759418366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685500383; x=1688092383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycOjjIENXNvJocV8w4LDh5xDa7KlqAJ2wCXQ+HDSFhg=;
        b=2qbRJ7ZCmYiBQT7yP3WM/etaf52AqcwoZc9GyxNVw9OxHDWJJSyPIN2tPN0D+T7sOt
         FukoWYzt2EUkPB3mi2Y+8aW/hGFRAgbDYPO9Y1Qx4MmM9TRT8+r6wlEKTFq/YT+KqIjH
         cChnR+pTmWJA59Y/k11J0lUSAb0hhUsZS9Mjuq0pYTgQ/6XuyUbW66+7d3FRl8MWMfVp
         SClz2uSQMbV0Xq/aWyiG5HBF8lJlnN6MzMD5xuOFetyLyhjYd49aq60n++08kjJTJoi5
         CnZnoh82g0d6wcaoZjwSAesPBUtfwiTgwLBNuRclGVTciZRqxUljhhwcCHcp2q4NG5kL
         iAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685500383; x=1688092383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ycOjjIENXNvJocV8w4LDh5xDa7KlqAJ2wCXQ+HDSFhg=;
        b=gAisI8SlOHdTVKSZ/1caIkdkyacmFrOZwpyy3ercvew301qXRhTcJsQO5HL5EAUDZ1
         s9Lv3TZgGFZ8U7QVAyXyqCiTFZXfNImn/nnmcaSmLsAklq6Sk97Gs3pXdNRjENB4/zfM
         0prGPKqbAsvxuzG6l+9XKVFIQ413ERgkeuiQnTPL+jJjFLzOLSobqf/OT/HjTSgNlNLU
         Ln5z/0oU5E9YGWQQ7Zxtwuve22D2a7IWzlGF2DpGpULuAA5m/FTzzqiDY1sd+0fmJFva
         ooAQ5dpOBU0UwlJw5KiDGYOprLr7zcbaF4LtlQQXdtt1yZmz0ksqFj+5H0pg+1oaw8N7
         H8rA==
X-Gm-Message-State: AC+VfDxtLTTonf4ajfwIvY1ugym+EG+ES1crofpeF+Gy32ZqRhdNK9Ha
        mlMOcZYXFGdKPna4082W0IeoRvH7i84QWjMDsI+c1w==
X-Google-Smtp-Source: ACHHUZ4QZIi9ia5XG4HqEptTjiZIxVASVGdg9UOTazR3Uzfdh6kz+hnkE4jvrROlfUcGZbYC854Tnqy2TehqrhpdGtE=
X-Received: by 2002:a17:907:9716:b0:966:265d:edc7 with SMTP id
 jg22-20020a170907971600b00966265dedc7mr3807419ejc.69.1685500382919; Tue, 30
 May 2023 19:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531022911.1168524-1-yosryahmed@google.com>
In-Reply-To: <20230531022911.1168524-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 19:32:26 -0700
Message-ID: <CAJD7tkam+RFB7+QCA4rh4Pmc9yZucWQOeDgKxpDf2KidxHx1aQ@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: multiple zpool support
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, May 30, 2023 at 7:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Support using multiple zpools of the same type in zswap, for concurrency
> purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
> zpools. The order is specific by the config rather than the absolute
> number to guarantee a power of 2. This is useful so that we can use
> deterministically link each entry to a zpool by hashing the zswap_entry
> pointer.
>
> On a setup with zswap and zsmalloc, comparing a single zpool (current
> default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=3D32) show=
s
> improvements in the zsmalloc lock contention, especially on the swap out
> path.
>
> The following shows the perf analysis of the swapout path when 10
> workloads are simulatenously reclaiming and refaulting tmpfs pages.
> There are some improvements on the swapin path as well, but much less
> significant.
>
> 1 zpool:
>
>  |--28.99%--zswap_frontswap_store
>        |     |
>        <snip>
>        |     |
>        |     |--8.98%--zpool_map_handle
>        |     |     |
>        |     |      --8.98%--zs_zpool_map
>        |     |           |
>        |     |            --8.95%--zs_map_object
>        |     |                 |
>        |     |                  --8.38%--_raw_spin_lock
>        |     |                       |
>        |     |                        --7.39%--queued_spin_lock_slowpath
>        |     |
>        |     |--8.82%--zpool_malloc
>        |     |     |
>        |     |      --8.82%--zs_zpool_malloc
>        |     |           |
>        |     |            --8.80%--zs_malloc
>        |     |                 |
>        |     |                 |--7.21%--_raw_spin_lock
>        |     |                 |     |
>        |     |                 |      --6.81%--queued_spin_lock_slowpath
>        <snip>
>
> 32 zpools:
>
>  |--16.73%--zswap_frontswap_store
>        |     |
>        <snip>
>        |     |
>        |     |--1.81%--zpool_malloc
>        |     |     |
>        |     |      --1.81%--zs_zpool_malloc
>        |     |           |
>        |     |            --1.79%--zs_malloc
>        |     |                 |
>        |     |                  --0.73%--obj_malloc
>        |     |
>        |     |--1.06%--zswap_update_total_size
>        |     |
>        |     |--0.59%--zpool_map_handle
>        |     |     |
>        |     |      --0.59%--zs_zpool_map
>        |     |           |
>        |     |            --0.57%--zs_map_object
>        |     |                 |
>        |     |                  --0.51%--_raw_spin_lock
>        <snip>
>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/Kconfig | 12 +++++++
>  mm/zswap.c | 95 ++++++++++++++++++++++++++++++++++++------------------
>  2 files changed, 76 insertions(+), 31 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 92c30879bf67..de1da56d2c07 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
>           The cost is that if the page was never dirtied and needs to be
>           swapped out again, it will be re-compressed.
>
> +config ZSWAP_NR_ZPOOLS_ORDER
> +       int "Number of zpools in zswap, as power of 2"
> +       default 0
> +       depends on ZSWAP
> +       help
> +         This options determines the number of zpools to use for zswap, =
it
> +         will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
> +
> +         Having multiple zpools helps with concurrency and lock contenti=
on
> +         on the swap in and swap out paths, but uses a little bit of ext=
ra
> +         space.
> +
>  choice
>         prompt "Default compressor"
>         depends on ZSWAP
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fba80330afd1..7111036f8aa5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -137,6 +137,9 @@ static bool zswap_non_same_filled_pages_enabled =3D t=
rue;
>  module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_=
pages_enabled,
>                    bool, 0644);
>
> +/* Order of zpools for global pool when memcg is enabled */

This comment is an artifact of an older implementation, please ignore.

> +static unsigned int zswap_nr_zpools =3D 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDE=
R;
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -150,7 +153,6 @@ struct crypto_acomp_ctx {
>  };
>
>  struct zswap_pool {
> -       struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>         struct kref kref;
>         struct list_head list;
> @@ -158,6 +160,7 @@ struct zswap_pool {
>         struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +       struct zpool *zpools[];
>  };
>
>  /*
> @@ -236,7 +239,7 @@ static bool zswap_has_pool;
>
>  #define zswap_pool_debug(msg, p)                               \
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> -                zpool_get_type((p)->zpool))
> +                zpool_get_type((p)->zpools[0]))
>
>  static int zswap_writeback_entry(struct zpool *pool, unsigned long handl=
e);
>  static int zswap_pool_get(struct zswap_pool *pool);
> @@ -263,11 +266,13 @@ static void zswap_update_total_size(void)
>  {
>         struct zswap_pool *pool;
>         u64 total =3D 0;
> +       int i;
>
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(pool, &zswap_pools, list)
> -               total +=3D zpool_get_total_size(pool->zpool);
> +               for (i =3D 0; i < zswap_nr_zpools; i++)
> +                       total +=3D zpool_get_total_size(pool->zpools[i]);
>
>         rcu_read_unlock();
>
> @@ -350,6 +355,16 @@ static void zswap_rb_erase(struct rb_root *root, str=
uct zswap_entry *entry)
>         }
>  }
>
> +static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> +{
> +       int i;
> +
> +       i =3D zswap_nr_zpools =3D=3D 1 ? 0 :
> +           hash_ptr(entry, ilog2(zswap_nr_zpools));
> +
> +       return entry->pool->zpools[i];
> +}
> +
>  /*
>   * Carries out the common pattern of freeing and entry's zpool allocatio=
n,
>   * freeing the entry itself, and decrementing the number of stored pages=
.
> @@ -363,7 +378,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> -               zpool_free(entry->pool->zpool, entry->handle);
> +               zpool_free(zswap_find_zpool(entry), entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
>         zswap_entry_cache_free(entry);
> @@ -572,7 +587,8 @@ static struct zswap_pool *zswap_pool_find_get(char *t=
ype, char *compressor)
>         list_for_each_entry_rcu(pool, &zswap_pools, list) {
>                 if (strcmp(pool->tfm_name, compressor))
>                         continue;
> -               if (strcmp(zpool_get_type(pool->zpool), type))
> +               /* all zpools share the same type */
> +               if (strcmp(zpool_get_type(pool->zpools[0]), type))
>                         continue;
>                 /* if we can't get it, it's about to be destroyed */
>                 if (!zswap_pool_get(pool))
> @@ -587,14 +603,17 @@ static void shrink_worker(struct work_struct *w)
>  {
>         struct zswap_pool *pool =3D container_of(w, typeof(*pool),
>                                                 shrink_work);
> +       int i;
>
> -       if (zpool_shrink(pool->zpool, 1, NULL))
> -               zswap_reject_reclaim_fail++;
> +       for (i =3D 0; i < zswap_nr_zpools; i++)
> +               if (zpool_shrink(pool->zpools[i], 1, NULL))
> +                       zswap_reject_reclaim_fail++;
>         zswap_pool_put(pool);
>  }
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> +       int i;
>         struct zswap_pool *pool;
>         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> @@ -611,19 +630,25 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>                         return NULL;
>         }
>
> -       pool =3D kzalloc(sizeof(*pool), GFP_KERNEL);
> +       pool =3D kzalloc(sizeof(*pool) +
> +                      sizeof(pool->zpools[0]) * zswap_nr_zpools,
> +                      GFP_KERNEL);
>         if (!pool)
>                 return NULL;
>
> -       /* unique name for each pool specifically required by zsmalloc */
> -       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_coun=
t));
> +       for (i =3D 0; i < zswap_nr_zpools; i++) {
> +               /* unique name for each pool specifically required by zsm=
alloc */
> +               snprintf(name, 38, "zswap%x",
> +                        atomic_inc_return(&zswap_pools_count));
>
> -       pool->zpool =3D zpool_create_pool(type, name, gfp, &zswap_zpool_o=
ps);
> -       if (!pool->zpool) {
> -               pr_err("%s zpool not available\n", type);
> -               goto error;
> +               pool->zpools[i] =3D zpool_create_pool(type, name, gfp,
> +                                                   &zswap_zpool_ops);
> +               if (!pool->zpools[i]) {
> +                       pr_err("%s zpool not available\n", type);
> +                       goto error;
> +               }
>         }
> -       pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
> +       pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
>
>         strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
>
> @@ -653,8 +678,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>  error:
>         if (pool->acomp_ctx)
>                 free_percpu(pool->acomp_ctx);
> -       if (pool->zpool)
> -               zpool_destroy_pool(pool->zpool);
> +       while (i--)
> +               zpool_destroy_pool(pool->zpools[i]);
>         kfree(pool);
>         return NULL;
>  }
> @@ -703,11 +728,14 @@ static struct zswap_pool *__zswap_pool_create_fallb=
ack(void)
>
>  static void zswap_pool_destroy(struct zswap_pool *pool)
>  {
> +       int i;
> +
>         zswap_pool_debug("destroying", pool);
>
>         cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->no=
de);
>         free_percpu(pool->acomp_ctx);
> -       zpool_destroy_pool(pool->zpool);
> +       for (i =3D 0; i < zswap_nr_zpools; i++)
> +               zpool_destroy_pool(pool->zpools[i]);
>         kfree(pool);
>  }
>
> @@ -1160,6 +1188,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         unsigned long handle, value;
>         char *buf;
>         u8 *src, *dst;
> +       struct zpool *zpool;
>         struct zswap_header zhdr =3D { .swpentry =3D swp_entry(type, offs=
et) };
>         gfp_t gfp;
>
> @@ -1259,11 +1288,13 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>         }
>
>         /* store */
> -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> +       zpool =3D zswap_find_zpool(entry);
> +       hlen =3D zpool_evictable(zpool) ? sizeof(zhdr) : 0;
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> -       if (zpool_malloc_support_movable(entry->pool->zpool))
> +       if (zpool_malloc_support_movable(zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> -       ret =3D zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handl=
e);
> +       ret =3D zpool_malloc(zpool, hlen + dlen, gfp, &handle);
> +
>         if (ret =3D=3D -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
> @@ -1272,10 +1303,10 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>                 zswap_reject_alloc_fail++;
>                 goto put_dstmem;
>         }
> -       buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO)=
;
> +       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>         memcpy(buf, &zhdr, hlen);
>         memcpy(buf + hlen, dst, dlen);
> -       zpool_unmap_handle(entry->pool->zpool, handle);
> +       zpool_unmap_handle(zpool, handle);
>         mutex_unlock(acomp_ctx->mutex);
>
>         /* populate entry */
> @@ -1353,6 +1384,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         u8 *src, *dst, *tmp;
>         unsigned int dlen;
>         int ret;
> +       struct zpool *zpool;
>
>         /* find */
>         spin_lock(&tree->lock);
> @@ -1372,7 +1404,8 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>                 goto stats;
>         }
>
> -       if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> +       zpool =3D zswap_find_zpool(entry);
> +       if (!zpool_can_sleep_mapped(zpool)) {
>                 tmp =3D kmalloc(entry->length, GFP_KERNEL);
>                 if (!tmp) {
>                         ret =3D -ENOMEM;
> @@ -1382,14 +1415,14 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
>
>         /* decompress */
>         dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL=
_MM_RO);
> -       if (zpool_evictable(entry->pool->zpool))
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       if (zpool_evictable(zpool))
>                 src +=3D sizeof(struct zswap_header);
>
> -       if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
> +       if (!zpool_can_sleep_mapped(zpool)) {
>                 memcpy(tmp, src, entry->length);
>                 src =3D tmp;
> -               zpool_unmap_handle(entry->pool->zpool, entry->handle);
> +               zpool_unmap_handle(zpool, entry->handle);
>         }
>
>         acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> @@ -1401,8 +1434,8 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);
>         mutex_unlock(acomp_ctx->mutex);
>
> -       if (zpool_can_sleep_mapped(entry->pool->zpool))
> -               zpool_unmap_handle(entry->pool->zpool, entry->handle);
> +       if (zpool_can_sleep_mapped(zpool))
> +               zpool_unmap_handle(zpool, entry->handle);
>         else
>                 kfree(tmp);
>
> @@ -1558,7 +1591,7 @@ static int zswap_setup(void)
>         pool =3D __zswap_pool_create_fallback();
>         if (pool) {
>                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> -                       zpool_get_type(pool->zpool));
> +                       zpool_get_type(pool->zpools[0]));
>                 list_add(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
>         } else {
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>
