Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE97174C90D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 01:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGIXM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 19:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGIXM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 19:12:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B5106
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 16:12:54 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-345b347196cso13600465ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 16:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688944374; x=1691536374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD7xTN/m7qlsF7oXi2zA1JlpAOToI2h9pKehiXDtCwE=;
        b=krJDmOX9C4UkWeFmNn7S3LHUNQshwL4CLAYnuUCxu67lgrxr4se9QaUT3XY6VVEAfB
         8az771rlsiQiUygjJK6khM/yAkSk15VG6oG+dK8uCummeFJS4h43D4rwvd6oHp/A8356
         q4MzGdfhCNBVC4epCslBeQ+P4YD88Bjn/o7kR8Vfug8ReXdCOYoI7UJWal8Wwzn8Tywb
         4xLceOl6ZtKBYIDK+M/LdKKLLAvqbGoWE+d7tKZzEVKwcayOkZOHzdQsNVH15vgCqqHH
         WcqWmESwszAj8cmODdoCBivXvOUNJXPF2tR4bvXYNBBJzEpxMT1US7lnqr5I3MkvhTvy
         +xDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688944374; x=1691536374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD7xTN/m7qlsF7oXi2zA1JlpAOToI2h9pKehiXDtCwE=;
        b=XoozoDdU+lz7O2Z+sQytoe+H9Ap0oOxBzmHYuuQqA+HRASVZfOynAB9Jmxukq6+6Jz
         wt8y5YIBLEM0ai5SySsZumv+qOIq2wzS0qxl7pAnJ1jpv+QaUTeHD9RRFRQg48qhSgNS
         b3nHQPkrFbcb1/6x7k0rvPl8FnZ94xLzqx7ao+02dAQQ6TfkOj9Rh7nX8JEEIZVONAkR
         NmqZDRKa2rxMXWsxHyRbNatf51vVKlV2NRIwW0WgCE8q9c/vXyiSfSKUm2OqFSmqb+Zp
         pSY0dK/02P+LMu/kvdo8FqZ3yDktkuJNFBbiEJtTlRIcm4/A5K/2vW/qOTTMNJd0P2Cy
         vbZw==
X-Gm-Message-State: ABy/qLYlICjJ0PzljIUCmPQnAo3n+mtNMfcHbHvsV7Aes8QeX10ua8L+
        Q9/0OyebcDnnlb6alzDYzk72uNfws/f3LLU0y7A=
X-Google-Smtp-Source: APBJJlH+0I9ogeavnSEyTQYKXc7JJ+GkC5Z4enh/fenT1Mh/bd9yxovjFPV6aQCGwpj2m/BJF0+xEhUJ4e2oNMQA+84=
X-Received: by 2002:a05:6e02:610:b0:341:f920:4483 with SMTP id
 t16-20020a056e02061000b00341f9204483mr10138961ils.9.1688944373941; Sun, 09
 Jul 2023 16:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230620194644.3142384-1-yosryahmed@google.com>
In-Reply-To: <20230620194644.3142384-1-yosryahmed@google.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sun, 9 Jul 2023 16:12:43 -0700
Message-ID: <CAKEwX=OLR02MazB31wR-nphjZJvBHrm5Zy7hLPByZ3ubgO8mjw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: zswap: multiple zpools support
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 12:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Support using multiple zpools of the same type in zswap, for concurrency
> purposes. A fixed number of 32 zpools is suggested by this commit, which
> was determined empirically. It can be later changed or made into a
> config option if needed.
>
> On a setup with zswap and zsmalloc, comparing a single zpool to 32
> zpools shows improvements in the zsmalloc lock contention, especially on
> the swap out path.
>
> The following shows the perf analysis of the swapout path when 10
> workloads are simultaneously reclaiming and refaulting tmpfs pages.
> There are some improvements on the swap in path as well, but less
> significant.
>
> 1 zpool:
>
>  |--28.99%--zswap_frontswap_store
>        |
>        <snip>
>        |
>        |--8.98%--zpool_map_handle
>        |     |
>        |      --8.98%--zs_zpool_map
>        |           |
>        |            --8.95%--zs_map_object
>        |                 |
>        |                  --8.38%--_raw_spin_lock
>        |                       |
>        |                        --7.39%--queued_spin_lock_slowpath
>        |
>        |--8.82%--zpool_malloc
>        |     |
>        |      --8.82%--zs_zpool_malloc
>        |           |
>        |            --8.80%--zs_malloc
>        |                 |
>        |                 |--7.21%--_raw_spin_lock
>        |                 |     |
>        |                 |      --6.81%--queued_spin_lock_slowpath
>        <snip>
>
> 32 zpools:
>
>  |--16.73%--zswap_frontswap_store
>        |
>        <snip>
>        |
>        |--1.81%--zpool_malloc
>        |     |
>        |      --1.81%--zs_zpool_malloc
>        |           |
>        |            --1.79%--zs_malloc
>        |                 |
>        |                  --0.73%--obj_malloc
>        |
>        |--1.06%--zswap_update_total_size
>        |
>        |--0.59%--zpool_map_handle
>        |     |
>        |      --0.59%--zs_zpool_map
>        |           |
>        |            --0.57%--zs_map_object
>        |                 |
>        |                  --0.51%--_raw_spin_lock
>        <snip>
>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>
> v2 -> v3:
> - Removed config option (Johannes Weiner). Now it's a constant.
> - Fixed spelling typos (Yu Zhao).
>
> v1 -> v2:
> - Prettified perf graph in commit log.
> - Changed zswap_nr_zpools to a macro, changed zswap_pool->zpools to a
>   fixed size array instead of a flex array.
> - Removed stale comment.
>
> ---
>  mm/zswap.c | 81 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 54 insertions(+), 27 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 87b204233115..6ee7028497b8 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -142,6 +142,9 @@ static bool zswap_exclusive_loads_enabled =3D IS_ENAB=
LED(
>                 CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
>  module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool,=
 0644);
>
> +/* Number of zpools in zswap_pool (empirically determined for scalabilit=
y) */
> +#define ZSWAP_NR_ZPOOLS 32
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -161,7 +164,7 @@ struct crypto_acomp_ctx {
>   * needs to be verified that it's still valid in the tree.
>   */
>  struct zswap_pool {
> -       struct zpool *zpool;
> +       struct zpool *zpools[ZSWAP_NR_ZPOOLS];
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
>         struct kref kref;
>         struct list_head list;
> @@ -248,7 +251,7 @@ static bool zswap_has_pool;
>
>  #define zswap_pool_debug(msg, p)                               \
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
> -                zpool_get_type((p)->zpool))
> +                zpool_get_type((p)->zpools[0]))
>
>  static int zswap_writeback_entry(struct zswap_entry *entry,
>                                  struct zswap_tree *tree);
> @@ -272,11 +275,13 @@ static void zswap_update_total_size(void)
>  {
>         struct zswap_pool *pool;
>         u64 total =3D 0;
> +       int i;
>
>         rcu_read_lock();
>
>         list_for_each_entry_rcu(pool, &zswap_pools, list)
> -               total +=3D zpool_get_total_size(pool->zpool);
> +               for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +                       total +=3D zpool_get_total_size(pool->zpools[i]);
>
>         rcu_read_unlock();
>
> @@ -363,6 +368,16 @@ static void zswap_rb_erase(struct rb_root *root, str=
uct zswap_entry *entry)
>         }
>  }
>
> +static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
> +{
> +       int i =3D 0;
> +
> +       if (ZSWAP_NR_ZPOOLS > 1)
> +               i =3D hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));
> +
> +       return entry->pool->zpools[i];
> +}
> +
>  /*
>   * Carries out the common pattern of freeing and entry's zpool allocatio=
n,
>   * freeing the entry itself, and decrementing the number of stored pages=
.
> @@ -379,7 +394,7 @@ static void zswap_free_entry(struct zswap_entry *entr=
y)
>                 spin_lock(&entry->pool->lru_lock);
>                 list_del(&entry->lru);
>                 spin_unlock(&entry->pool->lru_lock);
> -               zpool_free(entry->pool->zpool, entry->handle);
> +               zpool_free(zswap_find_zpool(entry), entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
>         zswap_entry_cache_free(entry);
> @@ -588,7 +603,8 @@ static struct zswap_pool *zswap_pool_find_get(char *t=
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
> @@ -692,6 +708,7 @@ static void shrink_worker(struct work_struct *w)
>
>  static struct zswap_pool *zswap_pool_create(char *type, char *compressor=
)
>  {
> +       int i;
>         struct zswap_pool *pool;
>         char name[38]; /* 'zswap' + 32 char (max) num + \0 */
>         gfp_t gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM=
;
> @@ -712,15 +729,18 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
>         if (!pool)
>                 return NULL;
>
> -       /* unique name for each pool specifically required by zsmalloc */
> -       snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_coun=
t));
> +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++) {
> +               /* unique name for each pool specifically required by zsm=
alloc */
> +               snprintf(name, 38, "zswap%x",
> +                        atomic_inc_return(&zswap_pools_count));
>
> -       pool->zpool =3D zpool_create_pool(type, name, gfp);
> -       if (!pool->zpool) {
> -               pr_err("%s zpool not available\n", type);
> -               goto error;
> +               pool->zpools[i] =3D zpool_create_pool(type, name, gfp);
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
> @@ -752,8 +772,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
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
> @@ -802,11 +822,14 @@ static struct zswap_pool *__zswap_pool_create_fallb=
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
> +       for (i =3D 0; i < ZSWAP_NR_ZPOOLS; i++)
> +               zpool_destroy_pool(pool->zpools[i]);
>         kfree(pool);
>  }
>
> @@ -1070,7 +1093,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         struct page *page;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       struct zpool *pool =3D entry->pool->zpool;
> +       struct zpool *pool =3D zswap_find_zpool(entry);
>
>         u8 *src, *tmp =3D NULL;
>         unsigned int dlen;
> @@ -1211,6 +1234,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct obj_cgroup *objcg =3D NULL;
>         struct zswap_pool *pool;
> +       struct zpool *zpool;
>         int ret;
>         unsigned int dlen =3D PAGE_SIZE;
>         unsigned long handle, value;
> @@ -1321,10 +1345,11 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>         }
>
>         /* store */
> +       zpool =3D zswap_find_zpool(entry);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> -       if (zpool_malloc_support_movable(entry->pool->zpool))
> +       if (zpool_malloc_support_movable(zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> -       ret =3D zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
> +       ret =3D zpool_malloc(zpool, dlen, gfp, &handle);
>         if (ret =3D=3D -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
> @@ -1333,9 +1358,9 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>                 zswap_reject_alloc_fail++;
>                 goto put_dstmem;
>         }
> -       buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO)=
;
> +       buf =3D zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
>         memcpy(buf, dst, dlen);
> -       zpool_unmap_handle(entry->pool->zpool, handle);
> +       zpool_unmap_handle(zpool, handle);
>         mutex_unlock(acomp_ctx->mutex);
>
>         /* populate entry */
> @@ -1406,6 +1431,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         u8 *src, *dst, *tmp;
> +       struct zpool *zpool;
>         unsigned int dlen;
>         int ret;
>
> @@ -1427,7 +1453,8 @@ static int zswap_frontswap_load(unsigned type, pgof=
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
> @@ -1437,12 +1464,12 @@ static int zswap_frontswap_load(unsigned type, pg=
off_t offset,
>
>         /* decompress */
>         dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL=
_MM_RO);
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
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
> @@ -1454,8 +1481,8 @@ static int zswap_frontswap_load(unsigned type, pgof=
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
> @@ -1616,7 +1643,7 @@ static int zswap_setup(void)
>         pool =3D __zswap_pool_create_fallback();
>         if (pool) {
>                 pr_info("loaded using pool %s/%s\n", pool->tfm_name,
> -                       zpool_get_type(pool->zpool));
> +                       zpool_get_type(pool->zpools[0]));
>                 list_add(&pool->list, &zswap_pools);
>                 zswap_has_pool =3D true;
>         } else {
> --
> 2.41.0.162.gfafddb0af9-goog
>

In terms of correctness, the code LGTM.
However, I do share Johannes' concern about this change.

May I ask how sensitive is the system performance to the number of pools?
i.e during the tuning process, did you see lots of performance
variability as you vary the number of pools? Is 32 a number that
works well across workloads, hardware, etc?

Personally, I prefer the per-CPU pool idea - or some way to automatically
determine the number of pools that are more generic than this 32 value
(what if we have new hardware with more CPUs? Would 32 still be valid,
or do we have to change it?).

I'm experimenting with some other zswap changes - if I have
extra cycles and resources I'll try to apply this patch and see how the
numbers play out.

I'll defer to Johannes and other reviewers for further comments.
