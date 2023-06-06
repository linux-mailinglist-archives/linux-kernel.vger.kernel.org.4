Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD92723D84
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjFFJcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFFJcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:32:02 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D610E0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:31:32 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso2289396a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686043889; x=1688635889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGB5JSG9rx1Pa8vA24dm2tcs/m8mttlL3JPTORrxJFo=;
        b=jaEdKFHOGPpn9j1MW9yA+oAhE1605UYGxpuSESr4ujYmZj0wSkW5lYr6wYFMTpuIB3
         apH0aXRcgZ0trTuBdq7j8/SX0ql8gLDfuq0SeXQpJJSEpoYehXx/6schUxLO3NxffCVi
         Zgf7OgXUnp+gmSm25koTNLqHhv95xmr7sGmtmG5+1y65N+MoKdXKpsGiOUeD9fpd7DYR
         7BbvZNrHr9sJOTT11JzjlvEFzOV2ZWhuNu58661XlZ0X8FSNoW/gjtYkPZwr8wTab6ZW
         T3VX4oS0v20SwOmfC/Xx+eomx9wJuZ9R3o0aVaVrQfvs91FHggtcdGQJnL3ShvInQeni
         +LRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043889; x=1688635889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGB5JSG9rx1Pa8vA24dm2tcs/m8mttlL3JPTORrxJFo=;
        b=DGGeyTGBmVHCxTTbojtUhpVbJ4aNP6DZPWiloxmgmXH9sTbne+OswxQlXIeJfTSrJ0
         5GhvHs/nzVLSFagiuuOZyvGxTO9BD2G/d1m9ZANEjaGj5fwsJyUZcfDJuPc97AnHAJYn
         iOZYQmNv4v54aU+HuGPAU4OgzDIKWYyHCyXp+Jxek6hSlNVNbYvXUaw6ksk3bpzZ2Z+A
         R0cC5hB73Fb+YZ/pgxml77Tq0AZ49NKd5LbgepkBMUv/Bt9SOdsZFHqrIS/yrtuuWUeH
         gWiGNeo5ngpG53c2vRY+WjEsej0e3DKKv/6Q4X6Y6Ej5GpnI4bfPp74OuzrTArM5Tswn
         2t6w==
X-Gm-Message-State: AC+VfDxZnB2mIYvEVop1DwP4bAm5tKPnMz7MmuPlUlCjUchkifoOoxi8
        A5ImGllTA8GlkyyL037uhO3P841azjegit+z3rs=
X-Google-Smtp-Source: ACHHUZ515qXRBQVs9QNSDBnIYcRfG3DR1BwSBNuXJPciIuCk1KIcjBRmnDmHIbNmS9biG5f2G2kV2v2qTj6IPv2qkYo=
X-Received: by 2002:a17:90a:5105:b0:259:9f25:9dd6 with SMTP id
 t5-20020a17090a510500b002599f259dd6mr289348pjh.24.1686043889424; Tue, 06 Jun
 2023 02:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
 <20230605085419.44383-2-cerasuolodomenico@gmail.com> <20230605152952.GA221380@cmpxchg.org>
In-Reply-To: <20230605152952.GA221380@cmpxchg.org>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Tue, 6 Jun 2023 11:31:18 +0200
Message-ID: <CA+CLi1h31BgE-kVpmAbPZnP5FqEKYVcoF-WS5SrHHFkkSNWVog@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm: zswap: add pool shrinking mechanism
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com,
        linux-mm@kvack.org, ddstreet@ieee.org, sjenning@redhat.com,
        nphamcs@gmail.com, akpm@linux-foundation.org,
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

On Mon, Jun 5, 2023 at 5:29=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> Hi Domenico,
>
> On Mon, Jun 05, 2023 at 10:54:13AM +0200, Domenico Cerasuolo wrote:
> > @@ -364,6 +369,9 @@ static void zswap_free_entry(struct zswap_entry *en=
try)
> >       if (!entry->length)
> >               atomic_dec(&zswap_same_filled_pages);
> >       else {
> > +             spin_lock(&entry->pool->lock);
> > +             list_del_init(&entry->lru);
> > +             spin_unlock(&entry->pool->lock);
>
> This should be list_del(), as the entry is freed right after this and
> the list isn't reused anymore.
>
> The slab memory is recycled, but the allocation site (commented on
> below) doesn't need the list initialized.
>
> However, I think it also needs to check !zpool_evictable(). If
> alloc/store doesn't do the list_add(), this would be a double delete.
>

Thanks Johannes, I'm addressing all of your comments in the series in a V2.

> > @@ -584,14 +592,65 @@ static struct zswap_pool *zswap_pool_find_get(cha=
r *type, char *compressor)
> >       return NULL;
> >  }
> >
> > +static int zswap_shrink(struct zswap_pool *pool)
> > +{
> > +     struct zswap_entry *lru_entry, *tree_entry =3D NULL;
> > +     struct zswap_header *zhdr;
> > +     struct zswap_tree *tree;
> > +     swp_entry_t swpentry;
> > +     int ret;
> > +
> > +     /* get a reclaimable entry from LRU */
> > +     spin_lock(&pool->lock);
> > +     if (list_empty(&pool->lru)) {
> > +             spin_unlock(&pool->lock);
> > +             return -EINVAL;
> > +     }
> > +     lru_entry =3D list_last_entry(&pool->lru, struct zswap_entry, lru=
);
> > +     list_del_init(&lru_entry->lru);
> > +     zhdr =3D zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_M=
M_RO);
> > +     tree =3D zswap_trees[swp_type(zhdr->swpentry)];
> > +     zpool_unmap_handle(pool->zpool, lru_entry->handle);
> > +     swpentry =3D zhdr->swpentry;
> > +     spin_unlock(&pool->lock);
>
> Once the pool lock is dropped, the lru_entry might get freed. But the
> swpentry is copied to the stack, and lru_entry isn't deref'd again
> until the entry is verified to still be alive in the tree.
>
> This could use a comment.
>
> > +     /* hold a reference from tree so it won't be freed during writeba=
ck */
> > +     spin_lock(&tree->lock);
> > +     tree_entry =3D zswap_entry_find_get(&tree->rbroot, swp_offset(swp=
entry));
> > +     if (tree_entry !=3D lru_entry) {
> > +             if (tree_entry)
> > +                     zswap_entry_put(tree, tree_entry);
> > +             spin_unlock(&tree->lock);
> > +             return -EAGAIN;
> > +     }
> > +     spin_unlock(&tree->lock);
>
> It's pretty outrageous how much simpler this is compared to the
> <backend>_reclaim_page() functions! The backends have to jump through
> a lot of hoops to serialize against freeing, whereas zswap can simply
> hold a reference. This is clearly a much better design.
>
> > +     ret =3D zswap_writeback_entry(pool->zpool, lru_entry->handle);
> > +
> > +     spin_lock(&tree->lock);
> > +     if (ret) {
> > +             spin_lock(&pool->lock);
> > +             list_move(&lru_entry->lru, &pool->lru);
> > +             spin_unlock(&pool->lock);
> > +     }
> > +     zswap_entry_put(tree, tree_entry);
> > +     spin_unlock(&tree->lock);
> > +
> > +     return ret ? -EAGAIN : 0;
> > +}
> > +
> >  static void shrink_worker(struct work_struct *w)
> >  {
> >       struct zswap_pool *pool =3D container_of(w, typeof(*pool),
> >                                               shrink_work);
> >       int ret, failures =3D 0;
> >
> > +     /* zpool_evictable will be removed once all 3 backends have migra=
ted*/
>
> Missing space between text and */
>
> >       do {
> > -             ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +             if (zpool_evictable(pool->zpool))
> > +                     ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > +             else
> > +                     ret =3D zswap_shrink(pool);
> >               if (ret) {
> >                       zswap_reject_reclaim_fail++;
> >                       if (ret !=3D -EAGAIN)
> > @@ -655,6 +714,8 @@ static struct zswap_pool *zswap_pool_create(char *t=
ype, char *compressor)
> >        */
> >       kref_init(&pool->kref);
> >       INIT_LIST_HEAD(&pool->list);
> > +     INIT_LIST_HEAD(&pool->lru);
> > +     spin_lock_init(&pool->lock);
> >       INIT_WORK(&pool->shrink_work, shrink_worker);
> >
> >       zswap_pool_debug("created", pool);
> > @@ -1270,7 +1331,7 @@ static int zswap_frontswap_store(unsigned type, p=
goff_t offset,
> >       }
> >
> >       /* store */
> > -     hlen =3D zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
> > +     hlen =3D sizeof(zhdr);
> >       gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >       if (zpool_malloc_support_movable(entry->pool->zpool))
> >               gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1313,6 +1374,13 @@ static int zswap_frontswap_store(unsigned type, =
pgoff_t offset,
> >                       zswap_entry_put(tree, dupentry);
> >               }
> >       } while (ret =3D=3D -EEXIST);
> > +     INIT_LIST_HEAD(&entry->lru);
>
> The list_add() below initializes the entry, so this shouldn't be
> needed.
>
> > +     /* zpool_evictable will be removed once all 3 backends have migra=
ted*/
> > +     if (entry->length && !zpool_evictable(entry->pool->zpool)) {
> > +             spin_lock(&entry->pool->lock);
> > +             list_add(&entry->lru, &entry->pool->lru);
> > +             spin_unlock(&entry->pool->lock);
> > +     }
> >       spin_unlock(&tree->lock);
> >
> >       /* update stats */
