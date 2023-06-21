Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5873902A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjFUTg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFUTgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:36:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598231726
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:36:53 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25e8b2931f2so4756770a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376213; x=1689968213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATxljAeXD3ZQLvgleYPWv/HICEiuHF7y2fCsQyw2v4s=;
        b=F04tWiHz1dnF4m/hyS3Rzz6lV/5n2cDeV8/AKRH6tjunNM+4W5plQtsvob1Rgktzd1
         B0U6V+EV7Zqk0UsqT6kayYbb0APEuSJ+ZbM3Z+ZrMVGN6HXu7ZGhVv9p1IX++NxiJJEb
         /5YLxHTmVdRDAXvIbRo2AmcF9RWoGF/TYVkriLxR/jzqqlCSMxh3mfRiXWKyvLNfalJl
         7xcnkfx4nI+RiK3QfK3/N2Wj+owWrgfGLVvIUJ8S9dsgcGlPg+HgCSARJWaGn1ieekl6
         IbLtssr6EFnfVBUiGYWlD2KXHwBrhk+2XYlZJV7KC2Omawd1+h1bg/F6TZu0bLVeXe2L
         wuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376213; x=1689968213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ATxljAeXD3ZQLvgleYPWv/HICEiuHF7y2fCsQyw2v4s=;
        b=VCFGQtrgAOSjAu7ljc0IV9afyvpxU9P4NpX36QFZRRoHz8aBKXBOnrkb40AooMybJK
         O7t/O5HXufGflsyNbHzCyhN1q9lLVFv6EscFXpdFDjx0HNOgJwoq9KpLjpNV8gRr8Jqc
         32dtT6QeikhJlq2Oy2fsf9nrwPe4Z5C+pDdMFFQ6hdNVOMc3BdHO2FMFCCH3GbJag2Ys
         4yK2MjQ2D3FoFHKA4Ti9AgY3aeb1qLnaxLcSKdnzmwmPQJo4nXCFO9jhSW1dnfMV1A7F
         lMFGv/Fq6lBmUt3jYvKQcLd1J1IF7a8SdtgONvmNGopM5hDSxWNeC8DXBUtw2tLSsXsw
         TsFw==
X-Gm-Message-State: AC+VfDy9XXXINrDTMIT2TlPVGisaI7i1tyPUN53BPzQrjjU856bhWEk3
        XKAgLA1uqfasL002SL0hw2Uh4cO2SvLwx+QhD1Q=
X-Google-Smtp-Source: ACHHUZ4gzECWFjd0U1mfwbl+t9yj2eAZd3Ldks7oZPeBVE/vceICr7tQsoMjCRzR74H0cY+940GEZFABs68Mjj8TRqw=
X-Received: by 2002:a17:90a:6b46:b0:25e:b3f6:a352 with SMTP id
 x6-20020a17090a6b4600b0025eb3f6a352mr16635989pjl.28.1687376212622; Wed, 21
 Jun 2023 12:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093009.637544-1-yosryahmed@google.com>
 <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com> <CAJD7tkYGz3A3-mkzbZBfoHX5gATPseqiwZon0i3rug2h2M3jyg@mail.gmail.com>
In-Reply-To: <CAJD7tkYGz3A3-mkzbZBfoHX5gATPseqiwZon0i3rug2h2M3jyg@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Wed, 21 Jun 2023 21:36:41 +0200
Message-ID: <CA+CLi1hPfvy_kJyi8N6ygNhY9hNH5J6-kN9i1pRZz76dX5b0Lg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix double invalidate with exclusive loads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 21, 2023 at 7:26=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Jun 21, 2023 at 3:20=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > On Wed, Jun 21, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > If exclusive loads are enabled for zswap, we invalidate the entry bef=
ore
> > > returning from zswap_frontswap_load(), after dropping the local
> > > reference. However, the tree lock is dropped during decompression aft=
er
> > > the local reference is acquired, so the entry could be invalidated
> > > before we drop the local ref. If this happens, the entry is freed onc=
e
> > > we drop the local ref, and zswap_invalidate_entry() tries to invalida=
te
> > > an already freed entry.
> > >
> > > Fix this by:
> > > (a) Making sure zswap_invalidate_entry() is always called with a loca=
l
> > >     ref held, to avoid being called on a freed entry.
> > > (b) Making sure zswap_invalidate_entry() only drops the ref if the en=
try
> > >     was actually on the rbtree. Otherwise, another invalidation could
> > >     have already happened, and the initial ref is already dropped.
> > >
> > > With these changes, there is no need to check that there is no need t=
o
> > > make sure the entry still exists in the tree in zswap_reclaim_entry()
> > > before invalidating it, as zswap_reclaim_entry() will make this check
> > > internally.
> > >
> > > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  mm/zswap.c | 21 ++++++++++++---------
> > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 87b204233115..62195f72bf56 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root *root=
, struct zswap_entry *entry,
> > >         return 0;
> > >  }
> > >
> > > -static void zswap_rb_erase(struct rb_root *root, struct zswap_entry =
*entry)
> > > +static bool zswap_rb_erase(struct rb_root *root, struct zswap_entry =
*entry)
> > >  {
> > >         if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > >                 rb_erase(&entry->rbnode, root);
> > >                 RB_CLEAR_NODE(&entry->rbnode);
> > > +               return true;
> > >         }
> > > +       return false;
> > >  }
> > >
> > >  /*
> > > @@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find_get(c=
har *type, char *compressor)
> > >         return NULL;
> > >  }
> > >
> > > +/*
> > > + * If the entry is still valid in the tree, drop the initial ref and=
 remove it
> > > + * from the tree. This function must be called with an additional re=
f held,
> > > + * otherwise it may race with another invalidation freeing the entry=
.
> > > + */
> >
> > On re-reading this comment there's one thing I'm not sure I get, do we
> > really need to hold an additional local ref to call this? As far as I
> > understood, once we check that the entry was in the tree before putting
> > the initial ref, there's no need for an additional local one.
>
> I believe it is, but please correct me if I am wrong. Consider the
> following scenario:
>
> // Initially refcount is at 1
>
> CPU#1:                                  CPU#2:
> spin_lock(tree_lock)
> zswap_entry_get() // 2 refs
> spin_unlock(tree_lock)
>                                             spin_lock(tree_lock)
>                                             zswap_invalidate_entry() // 1=
 ref
>                                             spin_unlock(tree_lock)
> zswap_entry_put() // 0 refs
> zswap_invalidate_entry() // problem
>
> That last zswap_invalidate_entry() call in CPU#1 is problematic. The
> entry would have already been freed. If we check that the entry is on
> the tree by checking RB_EMPTY_NODE(&entry->rbnode), then we are
> reading already freed and potentially re-used memory.
>
> We would need to search the tree to make sure the same entry still
> exists in the tree (aka what zswap_reclaim_entry() currently does).
> This is not ideal in the fault path to have to do the lookups twice.

Thanks for the clarification, it is indeed needed in that case. I was just
wondering if the wording of the comment is exact, in that before calling
zswap_invalidate_entry one has to ensure that the entry has not been freed,=
 not
specifically by holding an additional reference, if a lookup can serve the =
same
purpose.

>
> Also, in zswap_reclaim_entry(), would it be possible if we call
> zswap_invalidate_entry() after we drop the local ref that the swap
> entry has been reused for a different page? I didn't look closely, but
> if yes, then the slab allocator may have repurposed the zswap_entry
> and we may find the entry in the tree for the same offset, even though
> it is referring to a different page now. This sounds practically
> unlikely but perhaps theoretically possible.

I'm not sure I understood the scenario, in zswap_reclaim_entry we keep a lo=
cal
reference until the end in order to avoid a free.

>
> I think it's more reliable to call zswap_invalidate_entry() on an
> entry that we know is valid before dropping the local ref. Especially
> that it's easy to do today by just moving a few lines around.
>
>
>
>
> >
> > >  static void zswap_invalidate_entry(struct zswap_tree *tree,
> > >                                    struct zswap_entry *entry)
> > >  {
> > > -       /* remove from rbtree */
> > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > -
> > > -       /* drop the initial reference from entry creation */
> > > -       zswap_entry_put(tree, entry);
> > > +       if (zswap_rb_erase(&tree->rbroot, entry))
> > > +               zswap_entry_put(tree, entry);
> > >  }
> > >
> > >  static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap_pool =
*pool)
> > >          * swapcache. Drop the entry from zswap - unless invalidate a=
lready
> > >          * took it out while we had the tree->lock released for IO.
> > >          */
> > > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffset))
> > > -               zswap_invalidate_entry(tree, entry);
> > > +       zswap_invalidate_entry(tree, entry);
> > >
> > >  put_unlock:
> > >         /* Drop local reference */
> > > @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> > >                 count_objcg_event(entry->objcg, ZSWPIN);
> > >  freeentry:
> > >         spin_lock(&tree->lock);
> > > -       zswap_entry_put(tree, entry);
> > >         if (!ret && zswap_exclusive_loads_enabled) {
> > >                 zswap_invalidate_entry(tree, entry);
> > >                 *exclusive =3D true;
> > > @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned type, =
pgoff_t offset,
> > >                 list_move(&entry->lru, &entry->pool->lru);
> > >                 spin_unlock(&entry->pool->lru_lock);
> > >         }
> > > +       zswap_entry_put(tree, entry);
> > >         spin_unlock(&tree->lock);
> > >
> > >         return ret;
> > > --
> > > 2.41.0.162.gfafddb0af9-goog
> > >
