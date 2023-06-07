Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B111725A51
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbjFGJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjFGJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:27:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011E1725
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:27:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso888792a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686130033; x=1688722033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeOVyyzx2aFg+HiDo8xoGuPCyLIjyDb2msJx9kNdD80=;
        b=wCuhghmjcdqhSltrPabDz96VMoaq3h7gnM8P3G85h5r+4H1Bg8PiV1KggTHgHUS5Ps
         H24m3Yehlh0P/v7kPkX2BcyJyhk/bJuQmtVT2jYC99ZX2i22T7iE97RRsROtEKoYN63v
         GV3oH5JXO2kHz4uc0jGOfVlgQ+HEE9QNDsAoOQxWb9L0YcZZ4xpAl/yGD+K9K3Sy6y7V
         lpyyCoDwPdpOlFJlgn13YVr6Tr/HLsZY0GgIF7/rL9RPpInQGdfMot0t59qmnpy+lcyQ
         YZWETC7zKGNfWlIHHjUCeEM891MwyVX+LHA1xWHelZn5YefVCWFYVv3K1dAGh+qLIYKA
         CNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130033; x=1688722033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeOVyyzx2aFg+HiDo8xoGuPCyLIjyDb2msJx9kNdD80=;
        b=U/RPcb089GyQYjA1rTiO9idVMJZMSLlgwBbSxbc1iZBN4BDhW//6UBq2DLxC18Rdsf
         EfIEbjHrykKWTTcUE1l8vhb3I4+U5RZDAwEI3LCO1K/Z2nbs3JRJ4BssmNG6FZ3OGox4
         O/5qJWBKfOFEyll1swYIfg/xqiaDEMQGjBPmCC7E33MOUkLSV28PEwcREi9K7NxAl/r9
         srx2HpTUv1S/oXNV3yEb7IHO6qPiyTPp6a2bwSoOXKTgoJBJ09BWpN1Ggnygi2VK/hIG
         zwFdEZBPytT3kGMd/fYVKyl3RMwJ1MmH5CPu4prG7XLS25aoCJ2GNsLLny8pyhJ4Q+0C
         wxFA==
X-Gm-Message-State: AC+VfDyJhyGSI/wyZRRzxVMFxgfh8ChG/FzR8Kf1vvb2nliFcsEcfB8V
        uNxL77LHcMl/w15etcEYB0u3rDASmLND5des8moNNg==
X-Google-Smtp-Source: ACHHUZ6Rb3Tred2Ry6K0iwQMFvAK9MVGZ16UUCiLX1gNCkFNCO/mOM00ePKvztpPtrOgoNhRAMGyP7KKCBZTuQN/2fc=
X-Received: by 2002:a17:907:eaa:b0:973:e69d:c720 with SMTP id
 ho42-20020a1709070eaa00b00973e69dc720mr6689340ejc.51.1686130033219; Wed, 07
 Jun 2023 02:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-7-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-7-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:26:37 -0700
Message-ID: <CAJD7tkY09KvHGGVwQqSj7XHvHe+z5iC1-Ghj97gHbbWnDk1_kg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] mm: zswap: simplify writeback function
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
        TVD_PH_BODY_ACCOUNTS_PRE,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> Previously, in zswap, the writeback function was passed to zpool drivers
> for their usage in calling the writeback operation. However, since the
> drivers did not possess references to entries and the function was
> specifically designed to work with handles, the writeback process has
> been modified to occur directly within zswap. Consequently, this change
> allows for some simplification of the writeback function, taking into
> account the updated workflow.
>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> ---
>  mm/zswap.c | 69 ++++++++++++++----------------------------------------
>  1 file changed, 17 insertions(+), 52 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 2831bf56b168..ef8604812352 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -250,7 +250,8 @@ static bool zswap_has_pool;
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpool))
>
> -static int zswap_writeback_entry(struct zpool *pool, unsigned long handl=
e);
> +static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap=
_header *zhdr,
> +                                struct zswap_tree *tree);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
>
> @@ -632,15 +633,21 @@ static int zswap_shrink(struct zswap_pool *pool)
>         }
>         spin_unlock(&tree->lock);
>
> -       ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> +       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
>
>         spin_lock(&tree->lock);
>         if (ret) {
>                 spin_lock(&pool->lru_lock);
>                 list_move(&lru_entry->lru, &pool->lru);
>                 spin_unlock(&pool->lru_lock);
> +               zswap_entry_put(tree, tree_entry);
> +       } else {
> +               /* free the local reference */
> +               zswap_entry_put(tree, tree_entry);
> +               /* free the entry if it's not been invalidated*/
> +               if (lru_entry =3D=3D zswap_rb_search(&tree->rbroot, swpof=
fset))
> +                       zswap_entry_put(tree, tree_entry);

The comment that was here about the 2 possible cases was useful imo,
maybe keep it?

Also, I am not sure why we need to do a tree search vs. just reading
the refcount here before the first put. We can even make
zswap_entry_put() return the refcount after the put to know if we need
the additional put or not.

Can anyone think of any reason why we need to explicitly search the tree he=
re?

>         }
> -       zswap_entry_put(tree, tree_entry);
>         spin_unlock(&tree->lock);
>
>         return ret ? -EAGAIN : 0;
> @@ -1039,16 +1046,14 @@ static int zswap_get_swap_cache_page(swp_entry_t =
entry,
>   * the swap cache, the compressed version stored by zswap can be
>   * freed.
>   */
> -static int zswap_writeback_entry(struct zpool *pool, unsigned long handl=
e)
> +static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap=
_header *zhdr,
> +                                struct zswap_tree *tree)
>  {
> -       struct zswap_header *zhdr;
> -       swp_entry_t swpentry;
> -       struct zswap_tree *tree;
> -       pgoff_t offset;
> -       struct zswap_entry *entry;
> +       swp_entry_t swpentry =3D zhdr->swpentry;
>         struct page *page;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> +       struct zpool *pool =3D entry->pool->zpool;
>
>         u8 *src, *tmp =3D NULL;
>         unsigned int dlen;
> @@ -1063,25 +1068,6 @@ static int zswap_writeback_entry(struct zpool *poo=
l, unsigned long handle)
>                         return -ENOMEM;
>         }
>
> -       /* extract swpentry from data */
> -       zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> -       swpentry =3D zhdr->swpentry; /* here */
> -       tree =3D zswap_trees[swp_type(swpentry)];
> -       offset =3D swp_offset(swpentry);
> -       zpool_unmap_handle(pool, handle);
> -
> -       /* find and ref zswap entry */
> -       spin_lock(&tree->lock);
> -       entry =3D zswap_entry_find_get(&tree->rbroot, offset);
> -       if (!entry) {
> -               /* entry was invalidated */
> -               spin_unlock(&tree->lock);
> -               kfree(tmp);
> -               return 0;
> -       }
> -       spin_unlock(&tree->lock);
> -       BUG_ON(offset !=3D entry->offset);
> -
>         /* try to allocate swap cache page */
>         switch (zswap_get_swap_cache_page(swpentry, &page)) {
>         case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
> @@ -1115,12 +1101,12 @@ static int zswap_writeback_entry(struct zpool *po=
ol, unsigned long handle)
>                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>                 dlen =3D PAGE_SIZE;
>
> -               zhdr =3D zpool_map_handle(pool, handle, ZPOOL_MM_RO);
> +               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_R=
O);
>                 src =3D (u8 *)zhdr + sizeof(struct zswap_header);
>                 if (!zpool_can_sleep_mapped(pool)) {
>                         memcpy(tmp, src, entry->length);
>                         src =3D tmp;
> -                       zpool_unmap_handle(pool, handle);
> +                       zpool_unmap_handle(pool, entry->handle);
>                 }
>
>                 mutex_lock(acomp_ctx->mutex);
> @@ -1135,7 +1121,7 @@ static int zswap_writeback_entry(struct zpool *pool=
, unsigned long handle)
>                 if (!zpool_can_sleep_mapped(pool))
>                         kfree(tmp);
>                 else
> -                       zpool_unmap_handle(pool, handle);
> +                       zpool_unmap_handle(pool, entry->handle);
>
>                 BUG_ON(ret);
>                 BUG_ON(dlen !=3D PAGE_SIZE);
> @@ -1152,23 +1138,7 @@ static int zswap_writeback_entry(struct zpool *poo=
l, unsigned long handle)
>         put_page(page);
>         zswap_written_back_pages++;
>
> -       spin_lock(&tree->lock);
> -       /* drop local reference */
> -       zswap_entry_put(tree, entry);
> -
> -       /*
> -       * There are two possible situations for entry here:
> -       * (1) refcount is 1(normal case),  entry is valid and on the tree
> -       * (2) refcount is 0, entry is freed and not on the tree
> -       *     because invalidate happened during writeback
> -       *  search the tree and free the entry if find entry
> -       */
> -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, offset))
> -               zswap_entry_put(tree, entry);
> -       spin_unlock(&tree->lock);
> -
>         return ret;
> -
>  fail:
>         if (!zpool_can_sleep_mapped(pool))
>                 kfree(tmp);
> @@ -1177,13 +1147,8 @@ static int zswap_writeback_entry(struct zpool *poo=
l, unsigned long handle)
>         * if we get here due to ZSWAP_SWAPCACHE_EXIST
>         * a load may be happening concurrently.
>         * it is safe and okay to not free the entry.
> -       * if we free the entry in the following put
>         * it is also okay to return !0
>         */
> -       spin_lock(&tree->lock);
> -       zswap_entry_put(tree, entry);
> -       spin_unlock(&tree->lock);
> -
>         return ret;
>  }
>
> --
> 2.34.1
>
