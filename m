Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A20725A73
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240022AbjFGJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbjFGJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:30:55 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781F19BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:30:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d7bdde43so83312366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686130241; x=1688722241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0zgFaNuQcABlLa+CTwGXRDPJZJRvb9S50Rqfd30V94=;
        b=dd7szx7k41G43KBm/a86dAGJAaPQLmdJdamkHxlEJzb0d0kNobqsdlaxAnL5DcK2TP
         B9mzPxvBcNE1fycquQg0sC/KmTkguVAAv7fBxhZIvTs89TehT7e8jzOhIVYx2gwCibIO
         ZOR1a/Kln82tfx5u4wEGSV715+5cA6nldnUNeJ2QJiIWPSC0+D3Vuk545GtzZMsblqBc
         VY+c4C5/A/KAgMhiTMNVIwyV0R8udwbxHzs37hsHxY4rWb+TXyj+NXqL/5uGQReVkE0P
         c0XnnWFHFDF/axno6XSYA8wEhJ5dLCXe74GqH2Ca8IU+f1UyNydlqvOaNIQtCf0ZTcim
         +wqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686130241; x=1688722241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0zgFaNuQcABlLa+CTwGXRDPJZJRvb9S50Rqfd30V94=;
        b=kO9ykIa/sT/btoHkmWzMpTBq04ZCNSJklCHD/Xbj1Eh7Lhu8aMJl4RtXgYs7sSAq7b
         sOcULSeLog21nXf0qSV6jM8InQ+qv600ZFzDfpy7N9OdqTIAvu49kMyZ/lvMiYHWGnca
         Xsx6+QLbzaMQrnDdf/WVwDkJ1JOXjCPdVqZM4/PrfuA74pw29KVmoa6lFPwfm2VoGzSv
         2Xej1S5SPdjKWHpd59oHTI5x4iA/8XeVGB2xNB+afXLM78ZJLUsIORm47IW60NIPj0RJ
         0Tew6evXLYtsf38f1qQVhl2N61KxuK+0qJcM0qRUnHBgGVJG4J44yzXgNJzrE+b7WVQh
         xvPg==
X-Gm-Message-State: AC+VfDx81N2IiLZCWuL3+T2DWLE5K0FpcYpUoJPRa22wzFzp6NV/Viqp
        XFM0z/xQY0P1aCF8LcJFa111X5prihXZyRrQo1trOA==
X-Google-Smtp-Source: ACHHUZ6dP0+GRDVU3RS0pq3FfZaKfF9ok/JvpmsJGnYI4zVk5QLA0qcIdaA2ON/hto583ordiiISon8g+1gfeCvCkeQ=
X-Received: by 2002:a17:907:9810:b0:94e:4285:390c with SMTP id
 ji16-20020a170907981000b0094e4285390cmr5445077ejc.10.1686130240644; Wed, 07
 Jun 2023 02:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <20230606145611.704392-8-cerasuolodomenico@gmail.com>
In-Reply-To: <20230606145611.704392-8-cerasuolodomenico@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 02:30:04 -0700
Message-ID: <CAJD7tkY2+PgCzViFEH2W3YefnrLx66HiN_MnkZg=usdt_E1Eqw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] mm: zswap: remove zswap_header
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
> Previously, zswap_header served the purpose of storing the swpentry
> within zpool pages. This allowed zpool implementations to pass relevant
> information to the writeback function. However, with the current
> implementation, writeback is directly handled within zswap.
> Consequently, there is no longer a necessity for zswap_header, as the
> swp_entry_t can be stored directly in zswap_entry.
>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Thanks for this cleanup. It gives us back some of the memory used by
list_head in zswap entry, and remove an unnecessary zpool map
operation.

> ---
>  mm/zswap.c | 52 ++++++++++++++++++++++------------------------------
>  1 file changed, 22 insertions(+), 30 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ef8604812352..f689444dd5a7 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -193,7 +193,7 @@ struct zswap_pool {
>   */
>  struct zswap_entry {
>         struct rb_node rbnode;
> -       pgoff_t offset;
> +       swp_entry_t swpentry;
>         int refcount;
>         unsigned int length;
>         struct zswap_pool *pool;
> @@ -205,10 +205,6 @@ struct zswap_entry {
>         struct list_head lru;
>  };
>
> -struct zswap_header {
> -       swp_entry_t swpentry;
> -};
> -
>  /*
>   * The tree lock in the zswap_tree struct protects a few things:
>   * - the rbtree
> @@ -250,7 +246,7 @@ static bool zswap_has_pool;
>         pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,         \
>                  zpool_get_type((p)->zpool))
>
> -static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap=
_header *zhdr,
> +static int zswap_writeback_entry(struct zswap_entry *entry,
>                                  struct zswap_tree *tree);
>  static int zswap_pool_get(struct zswap_pool *pool);
>  static void zswap_pool_put(struct zswap_pool *pool);
> @@ -311,12 +307,14 @@ static struct zswap_entry *zswap_rb_search(struct r=
b_root *root, pgoff_t offset)
>  {
>         struct rb_node *node =3D root->rb_node;
>         struct zswap_entry *entry;
> +       pgoff_t entry_offset;
>
>         while (node) {
>                 entry =3D rb_entry(node, struct zswap_entry, rbnode);
> -               if (entry->offset > offset)
> +               entry_offset =3D swp_offset(entry->swpentry);
> +               if (entry_offset > offset)
>                         node =3D node->rb_left;
> -               else if (entry->offset < offset)
> +               else if (entry_offset < offset)
>                         node =3D node->rb_right;
>                 else
>                         return entry;
> @@ -333,13 +331,15 @@ static int zswap_rb_insert(struct rb_root *root, st=
ruct zswap_entry *entry,
>  {
>         struct rb_node **link =3D &root->rb_node, *parent =3D NULL;
>         struct zswap_entry *myentry;
> +       pgoff_t myentry_offset, entry_offset =3D swp_offset(entry->swpent=
ry);
>
>         while (*link) {
>                 parent =3D *link;
>                 myentry =3D rb_entry(parent, struct zswap_entry, rbnode);
> -               if (myentry->offset > entry->offset)
> +               myentry_offset =3D swp_offset(myentry->swpentry);
> +               if (myentry_offset > entry_offset)
>                         link =3D &(*link)->rb_left;
> -               else if (myentry->offset < entry->offset)
> +               else if (myentry_offset < entry_offset)

This whole myentry thing is very confusing to me. I initially thought
myentry would be the entry passed in as an argument. Can we change the
naming here to make it more consistent with zswap_rb_search() naming?

>                         link =3D &(*link)->rb_right;
>                 else {
>                         *dupentry =3D myentry;
> @@ -598,7 +598,6 @@ static struct zswap_pool *zswap_pool_find_get(char *t=
ype, char *compressor)
>  static int zswap_shrink(struct zswap_pool *pool)
>  {
>         struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> -       struct zswap_header *zhdr;
>         struct zswap_tree *tree;
>         int swpoffset;
>         int ret;
> @@ -611,15 +610,13 @@ static int zswap_shrink(struct zswap_pool *pool)
>         }
>         lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
>         list_del_init(&lru_entry->lru);
> -       zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_M=
M_RO);
> -       tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> -       zpool_unmap_handle(pool->zpool, lru_entry->handle);
>         /*
>          * Once the pool lock is dropped, the lru_entry might get freed. =
The
>          * swpoffset is copied to the stack, and lru_entry isn't deref'd =
again
>          * until the entry is verified to still be alive in the tree.
>          */
> -       swpoffset =3D swp_offset(zhdr->swpentry);
> +       swpoffset =3D swp_offset(lru_entry->swpentry);
> +       tree =3D zswap_trees[swp_type(lru_entry->swpentry)];
>         spin_unlock(&pool->lru_lock);
>
>         /* hold a reference from tree so it won't be freed during writeba=
ck */
> @@ -633,7 +630,7 @@ static int zswap_shrink(struct zswap_pool *pool)
>         }
>         spin_unlock(&tree->lock);
>
> -       ret =3D zswap_writeback_entry(lru_entry, zhdr, tree);
> +       ret =3D zswap_writeback_entry(lru_entry, tree);
>
>         spin_lock(&tree->lock);
>         if (ret) {
> @@ -1046,10 +1043,10 @@ static int zswap_get_swap_cache_page(swp_entry_t =
entry,
>   * the swap cache, the compressed version stored by zswap can be
>   * freed.
>   */
> -static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap=
_header *zhdr,
> +static int zswap_writeback_entry(struct zswap_entry *entry,
>                                  struct zswap_tree *tree)
>  {
> -       swp_entry_t swpentry =3D zhdr->swpentry;
> +       swp_entry_t swpentry =3D entry->swpentry;
>         struct page *page;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> @@ -1089,7 +1086,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry, struct zswap_header
>                  * writing.
>                  */
>                 spin_lock(&tree->lock);
> -               if (zswap_rb_search(&tree->rbroot, entry->offset) !=3D en=
try) {
> +               if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpe=
ntry)) !=3D entry) {
>                         spin_unlock(&tree->lock);
>                         delete_from_swap_cache(page_folio(page));
>                         ret =3D -ENOMEM;
> @@ -1101,8 +1098,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry, struct zswap_header
>                 acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
>                 dlen =3D PAGE_SIZE;
>
> -               zhdr =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_R=
O);
> -               src =3D (u8 *)zhdr + sizeof(struct zswap_header);
> +               src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO=
);
>                 if (!zpool_can_sleep_mapped(pool)) {
>                         memcpy(tmp, src, entry->length);
>                         src =3D tmp;
> @@ -1196,11 +1192,10 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>         struct obj_cgroup *objcg =3D NULL;
>         struct zswap_pool *pool;
>         int ret;
> -       unsigned int hlen, dlen =3D PAGE_SIZE;
> +       unsigned int dlen =3D PAGE_SIZE;
>         unsigned long handle, value;
>         char *buf;
>         u8 *src, *dst;
> -       struct zswap_header zhdr =3D { .swpentry =3D swp_entry(type, offs=
et) };
>         gfp_t gfp;
>
>         /* THP isn't supported */
> @@ -1245,7 +1240,7 @@ static int zswap_frontswap_store(unsigned type, pgo=
ff_t offset,
>                 src =3D kmap_atomic(page);
>                 if (zswap_is_page_same_filled(src, &value)) {
>                         kunmap_atomic(src);
> -                       entry->offset =3D offset;
> +                       entry->swpentry =3D swp_entry(type, offset);
>                         entry->length =3D 0;
>                         entry->value =3D value;
>                         atomic_inc(&zswap_same_filled_pages);
> @@ -1299,11 +1294,10 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>         }
>
>         /* store */
> -       hlen =3D sizeof(zhdr);
>         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
>         if (zpool_malloc_support_movable(entry->pool->zpool))
>                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> -       ret =3D zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handl=
e);
> +       ret =3D zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
>         if (ret =3D=3D -ENOSPC) {
>                 zswap_reject_compress_poor++;
>                 goto put_dstmem;
> @@ -1313,13 +1307,12 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
>                 goto put_dstmem;
>         }
>         buf =3D zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO)=
;
> -       memcpy(buf, &zhdr, hlen);
> -       memcpy(buf + hlen, dst, dlen);
> +       memcpy(buf, dst, dlen);
>         zpool_unmap_handle(entry->pool->zpool, handle);
>         mutex_unlock(acomp_ctx->mutex);
>
>         /* populate entry */
> -       entry->offset =3D offset;
> +       entry->swpentry =3D swp_entry(type, offset);
>         entry->handle =3D handle;
>         entry->length =3D dlen;
>
> @@ -1418,7 +1411,6 @@ static int zswap_frontswap_load(unsigned type, pgof=
f_t offset,
>         /* decompress */
>         dlen =3D PAGE_SIZE;
>         src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL=
_MM_RO);
> -       src +=3D sizeof(struct zswap_header);
>
>         if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
>                 memcpy(tmp, src, entry->length);
> --
> 2.34.1
>
