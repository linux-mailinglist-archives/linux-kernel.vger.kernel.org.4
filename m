Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182E9725726
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbjFGIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239476AbjFGIPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:15:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D110EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 01:14:58 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62606e67c0dso60470046d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686125697; x=1688717697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8flZ91Hab9nU26QZFMLIP2yuNrFr8wIvvmC5oWYCK80=;
        b=Y43u05ncuo5qs8NAKcg0N4wOfW1VAITNsfcW/om5+ZPRA6d2Q4BRXRX/jzs39xtmZS
         wi8BehUcVylNS4QA+KOrBPc/LNlBjO7om+Ajm1tvAwa5B39Uy5RS5O7AH+GTTbFDJeDI
         FLPcm4k2mwkKlCNrupN/A84klILIlycI7gqBpoQz86xBEU69Zsqw+CE717KBkozAvL4Q
         ZXgRjCHJ7bNS7ST+wnX8nFUqdQkLEwjRE+iwSS9eE3i6dVYAvorx5fGV/2ln7+FQEivr
         vMEZwp4kCjgwJt2UZcALAHS2pBO4bHSlyiq0sUV9jSTj7mcO05oKjrCi8NBmR2NxZSSy
         MX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686125697; x=1688717697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8flZ91Hab9nU26QZFMLIP2yuNrFr8wIvvmC5oWYCK80=;
        b=B91KWKHSrbz+2qxVXei3Cb7o8LAZu1luWxAw0wNtwLJ2AxGW3hOlFi8cgdS3LAYlii
         Mv8ncql1XFgZDWbhDMLMC+7Lx1LTlabpMqCReu3mXx1O53cTx1yMnxLAI3cW4bvzf793
         gFD4TXNZs3wBsxGXHgnKxCjP7zoVnqxhatJ9+R8i0xChkDykEnp5slBWPJwO3CJQeDPg
         GSGezIJKHJZO4aYOF4DR2Y1ORbFCFJdYigqGcUDs+AJHK32P8ObEYr4rjt++kIQkqTzB
         uOkoQNQ1EsjAAhpfnpiFwrmAnu2ltqZYr6KQxdFosoOW/7BGtkoNUiFYV2M0FxVZGFO6
         Uw5w==
X-Gm-Message-State: AC+VfDwXJS6iReHzynFBD5XOxtnTUmQUUTPSHnc07kdSaW2hvv4QqxXh
        6XMrlNZtfM87fm4YMw7wSjTRRkST29DorK84PeZnvg==
X-Google-Smtp-Source: ACHHUZ6Nub8JhRQrwolXBigkZdMGU6kSAgM4AoXOr6NQOHqi0cRN3POTluYy8mqwDYFviRhH/bHVhHPiHnH6l8Dz74Y=
X-Received: by 2002:a05:6214:e48:b0:5f1:62d9:3368 with SMTP id
 o8-20020a0562140e4800b005f162d93368mr1882436qvc.30.1686125696889; Wed, 07 Jun
 2023 01:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-2-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-2-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 01:14:18 -0700
Message-ID: <CAJD7tkYvGeDMHobekqzJJOQuvZM3S6eNq-HCRJQ8UQE6_tmwSA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
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
>  mm/zswap.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 91 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index bcb82e09eb64..c99bafcefecf 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -150,6 +150,12 @@ struct crypto_acomp_ctx {
>         struct mutex *mutex;
>  };
>
> +/*
> + * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
> + * The only case where lru_lock is not acquired while holding tree.lock =
is
> + * when a zswap_entry is taken off the lru for writeback, in that case i=
t
> + * needs to be verified that it's still valid in the tree.
> + */
>  struct zswap_pool {
>         struct zpool *zpool;
>         struct crypto_acomp_ctx __percpu *acomp_ctx;
> @@ -159,6 +165,8 @@ struct zswap_pool {
>         struct work_struct shrink_work;
>         struct hlist_node node;
>         char tfm_name[CRYPTO_MAX_ALG_NAME];
> +       struct list_head lru;
> +       spinlock_t lru_lock;
>  };
>
>  /*
> @@ -176,10 +184,12 @@ struct zswap_pool {
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
> @@ -192,6 +202,7 @@ struct zswap_entry {
>                 unsigned long value;
>         };
>         struct obj_cgroup *objcg;
> +       struct list_head lru;
>  };
>
>  struct zswap_header {
> @@ -364,6 +375,12 @@ static void zswap_free_entry(struct zswap_entry *ent=
ry)
>         if (!entry->length)
>                 atomic_dec(&zswap_same_filled_pages);
>         else {
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> +               if (!zpool_evictable(entry->pool->zpool)) {
> +                       spin_lock(&entry->pool->lru_lock);
> +                       list_del(&entry->lru);
> +                       spin_unlock(&entry->pool->lru_lock);
> +               }
>                 zpool_free(entry->pool->zpool, entry->handle);
>                 zswap_pool_put(entry->pool);
>         }
> @@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char =
*type, char *compressor)
>         return NULL;
>  }
>
> +static int zswap_shrink(struct zswap_pool *pool)

Nit: rename to zswap_shrink_one() so that it's clear we always
writeback one entry per call?

> +{
> +       struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> +       struct zswap_header *zhdr;
> +       struct zswap_tree *tree;
> +       int swpoffset;
> +       int ret;
> +
> +       /* get a reclaimable entry from LRU */
> +       spin_lock(&pool->lru_lock);
> +       if (list_empty(&pool->lru)) {
> +               spin_unlock(&pool->lru_lock);
> +               return -EINVAL;
> +       }
> +       lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> +       list_del_init(&lru_entry->lru);
> +       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_M=
M_RO);
> +       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> +       zpool_unmap_handle(pool->zpool, lru_entry->handle);
> +       /*
> +        * Once the pool lock is dropped, the lru_entry might get freed. =
The

Nit: lru lock*

> +        * swpoffset is copied to the stack, and lru_entry isn't deref'd =
again
> +        * until the entry is verified to still be alive in the tree.
> +        */
> +       swpoffset =3D swp_offset(zhdr->swpentry);
> +       spin_unlock(&pool->lru_lock);
> +
> +       /* hold a reference from tree so it won't be freed during writeba=
ck */
> +       spin_lock(&tree->lock);
> +       tree_entry =3D zswap_entry_find_get(&tree->rbroot, swpoffset);
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
> +               spin_lock(&pool->lru_lock);
> +               list_move(&lru_entry->lru, &pool->lru);
> +               spin_unlock(&pool->lru_lock);
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
ted */
>         do {
> -               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               if (zpool_evictable(pool->zpool))
> +                       ret =3D zpool_shrink(pool->zpool, 1, NULL);
> +               else
> +                       ret =3D zswap_shrink(pool);
>                 if (ret) {
>                         zswap_reject_reclaim_fail++;
>                         if (ret !=3D -EAGAIN)
> @@ -655,6 +728,8 @@ static struct zswap_pool *zswap_pool_create(char *typ=
e, char *compressor)
>          */
>         kref_init(&pool->kref);
>         INIT_LIST_HEAD(&pool->list);
> +       INIT_LIST_HEAD(&pool->lru);
> +       spin_lock_init(&pool->lru_lock);
>         INIT_WORK(&pool->shrink_work, shrink_worker);
>
>         zswap_pool_debug("created", pool);
> @@ -1270,7 +1345,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>         }
>
>         /* store */
> -       hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> +       hlen =3D sizeof(zhdr);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(entry->pool->zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> @@ -1313,6 +1388,12 @@ static int zswap_frontswap_store(unsigned type, pg=
off_t offset,
>                         zswap_entry_put(tree, dupentry);
>                 }
>         } while (ret =3D=3D -EEXIST);
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +               spin_lock(&entry->pool->lru_lock);
> +               list_add(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lru_lock);
> +       }
>         spin_unlock(&tree->lock);
>
>         /* update stats */
> @@ -1384,8 +1465,7 @@ static int zswap_frontswap_load(unsigned type, pgof=
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
> @@ -1415,6 +1495,12 @@ static int zswap_frontswap_load(unsigned type, pgo=
ff_t offset,
>  freeentry:
>         spin_lock(&tree->lock);
>         zswap_entry_put(tree, entry);
> +       /* zpool_evictable will be removed once all 3 backends have migra=
ted */
> +       if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> +               spin_lock(&entry->pool->lru_lock);
> +               list_move(&entry->lru, &entry->pool->lru);
> +               spin_unlock(&entry->pool->lru_lock);
> +       }

It's not really this patch's fault, but when merged with commit
fe1d1f7d0fb5 ("mm: zswap: support exclusive loads") from mm-unstable
[1], and with CONFIG_ZSWAP_EXCLUSIVE_LOADS=3Dy, this causes a crash.

This happens because fe1d1f7d0fb5 makes the loads exclusive, so
zswap_entry_put(tree, entry) above the added code causes the entry to
be freed, then we go ahead and deference multiple fields within it in
the added chunk. Moving the chunk above zswap_entry_put() (and
consequently also above zswap_invalidate_entry() from fe1d1f7d0fb5)
makes this work correctly.

Perhaps it would be useful to rebase on top of fe1d1f7d0fb5 for your
next version(s), if any.

Maybe the outcome would be something like:

zswap_entry_put(tree, entry);
if (!ret && IS_ENABLED(CONFIG_ZSWAP_EXCLUSIVE_LOADS)) {
        zswap_invalidate_entry(tree, entry);
} else if (entry->length && !zpool_evictable(entry->pool->zpool)) {
        spin_lock(&entry->pool->lru_lock);
        list_move(&entry->lru, &entry->pool->lru);
        spin_unlock(&entry->pool->lru_lock);
}

I am assuming if we are going to invalidate the entry anyway there is
no need to move it to the front of the lru -- but I didn't really
think it through.

[1]https://lore.kernel.org/lkml/20230530210251.493194-1-yosryahmed@google.c=
om/

>         spin_unlock(&tree->lock);
>
>         return ret;
> --
> 2.34.1
>
