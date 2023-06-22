Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31764739785
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFVGkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFVGkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:40:07 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413F8185
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:40:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-988689a5f44so534373566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687416003; x=1690008003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv9UsVgg9fbHRyw9vFcVO/IAcQzpHnhUOw/udmG8S1I=;
        b=WzcupkLR0sjm51+HzOWS6BXCJPzEFSg4ccXNy7pbRGZ4tEyrK2y/rXJ+WqGdBLruV+
         /9aP20WeiSLKo7Nqt5EZk4BPdEKNvwZpELwQ59U9ox6TcbtXauNlAcCXEKoiOh8g1DfX
         ey+kHgNXpVNrxdXLAy4QHPWVLAnqCHM2BWp36xqozuWnE8I3I/MV330ND2E/aID5To4M
         xR7s5FGEjvCJv0rTsrGS4A5jhQGFyjwXlkW4W0yX2eJJGaV8CjPXy2mTTVfie6Y6P8ig
         K+AewzaYp816VWuNo30aTqYdJucnftX0LZuQyDwRIxLk8Dplt5CNc61YSC0R785fmQpN
         +1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416003; x=1690008003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv9UsVgg9fbHRyw9vFcVO/IAcQzpHnhUOw/udmG8S1I=;
        b=iJUWO4xuHENkgk+IZ2BFTatnezgVn2KL2GdRumVjeLrqlO5w7KBOCfCYLYgAplT9cL
         AJ9HPz7qclvomDrJbAj7bw42PY5cvvqI1zkaBQ1q7dH+IxMBooJLwnycVUalCuPVqb5a
         dgzaHyFDxS0o2J73rO279fymuvHwWSHtemF1zoJB7ANocnx/eNVUCzIkUz03WrNR5WWJ
         gL7pmMxJA+iLmKc+JN+Iwxc/czNi4rJi5grVNhoCB1seRtYVW2uta8Q79OEaM2gx4vva
         JiNZXaQwcv3UItaeZPvkzhQ5g30mVrfZmvJyGKt5y6E4V93RnwKUdzQ2wAatDEsocHwB
         F52g==
X-Gm-Message-State: AC+VfDyuYpncun22bpcvlZQBnvN8oVD5f7OeMdIiOBHdNa+XmFb+wZX+
        vaHuJkIwJDKFvsn6Zn+iFBB5Pmwh2jleeHHw6+7tkg==
X-Google-Smtp-Source: ACHHUZ4xg4cv3atPrm/9EuRzjTjrcAhKnPRpZUSLrlRWkpNRLglzg2KFmcuUWRc6Pol/RKICA8o0nof4PRjR4ktKRiQ=
X-Received: by 2002:a17:906:7ce:b0:98d:4000:1bf9 with SMTP id
 m14-20020a17090607ce00b0098d40001bf9mr289161ejc.65.1687416003149; Wed, 21 Jun
 2023 23:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230621093009.637544-1-yosryahmed@google.com>
 <CA+CLi1gjRJ25HqDpqM3dUkddVbzRJnUhxO=bxq-rEjYz3dUhNA@mail.gmail.com>
 <CAJD7tkYGz3A3-mkzbZBfoHX5gATPseqiwZon0i3rug2h2M3jyg@mail.gmail.com>
 <CA+CLi1hPfvy_kJyi8N6ygNhY9hNH5J6-kN9i1pRZz76dX5b0Lg@mail.gmail.com>
 <CAJD7tkY3hQpPiWo5mJgvHPgObFdgTJqsTBq_H4c5kMF4F4qGpQ@mail.gmail.com> <CA+CLi1jZAqfjvDiWcQKJ_R02110Zyk=t2nyov2BCZnVm0B3muQ@mail.gmail.com>
In-Reply-To: <CA+CLi1jZAqfjvDiWcQKJ_R02110Zyk=t2nyov2BCZnVm0B3muQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 21 Jun 2023 23:39:26 -0700
Message-ID: <CAJD7tkZ0sORqJf0yp8AWjbTuK+ongRbV0AuOSeVGVXZHAud44g@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix double invalidate with exclusive loads
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
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

On Wed, Jun 21, 2023 at 11:33=E2=80=AFPM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Wed, Jun 21, 2023 at 11:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Wed, Jun 21, 2023 at 12:36=E2=80=AFPM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > On Wed, Jun 21, 2023 at 7:26=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > On Wed, Jun 21, 2023 at 3:20=E2=80=AFAM Domenico Cerasuolo
> > > > <cerasuolodomenico@gmail.com> wrote:
> > > > >
> > > > > On Wed, Jun 21, 2023 at 11:30=E2=80=AFAM Yosry Ahmed <yosryahmed@=
google.com> wrote:
> > > > > >
> > > > > > If exclusive loads are enabled for zswap, we invalidate the ent=
ry before
> > > > > > returning from zswap_frontswap_load(), after dropping the local
> > > > > > reference. However, the tree lock is dropped during decompressi=
on after
> > > > > > the local reference is acquired, so the entry could be invalida=
ted
> > > > > > before we drop the local ref. If this happens, the entry is fre=
ed once
> > > > > > we drop the local ref, and zswap_invalidate_entry() tries to in=
validate
> > > > > > an already freed entry.
> > > > > >
> > > > > > Fix this by:
> > > > > > (a) Making sure zswap_invalidate_entry() is always called with =
a local
> > > > > >     ref held, to avoid being called on a freed entry.
> > > > > > (b) Making sure zswap_invalidate_entry() only drops the ref if =
the entry
> > > > > >     was actually on the rbtree. Otherwise, another invalidation=
 could
> > > > > >     have already happened, and the initial ref is already dropp=
ed.
> > > > > >
> > > > > > With these changes, there is no need to check that there is no =
need to
> > > > > > make sure the entry still exists in the tree in zswap_reclaim_e=
ntry()
> > > > > > before invalidating it, as zswap_reclaim_entry() will make this=
 check
> > > > > > internally.
> > > > > >
> > > > > > Fixes: b9c91c43412f ("mm: zswap: support exclusive loads")
> > > > > > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > > ---
> > > > > >  mm/zswap.c | 21 ++++++++++++---------
> > > > > >  1 file changed, 12 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > index 87b204233115..62195f72bf56 100644
> > > > > > --- a/mm/zswap.c
> > > > > > +++ b/mm/zswap.c
> > > > > > @@ -355,12 +355,14 @@ static int zswap_rb_insert(struct rb_root=
 *root, struct zswap_entry *entry,
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > -static void zswap_rb_erase(struct rb_root *root, struct zswap_=
entry *entry)
> > > > > > +static bool zswap_rb_erase(struct rb_root *root, struct zswap_=
entry *entry)
> > > > > >  {
> > > > > >         if (!RB_EMPTY_NODE(&entry->rbnode)) {
> > > > > >                 rb_erase(&entry->rbnode, root);
> > > > > >                 RB_CLEAR_NODE(&entry->rbnode);
> > > > > > +               return true;
> > > > > >         }
> > > > > > +       return false;
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > @@ -599,14 +601,16 @@ static struct zswap_pool *zswap_pool_find=
_get(char *type, char *compressor)
> > > > > >         return NULL;
> > > > > >  }
> > > > > >
> > > > > > +/*
> > > > > > + * If the entry is still valid in the tree, drop the initial r=
ef and remove it
> > > > > > + * from the tree. This function must be called with an additio=
nal ref held,
> > > > > > + * otherwise it may race with another invalidation freeing the=
 entry.
> > > > > > + */
> > > > >
> > > > > On re-reading this comment there's one thing I'm not sure I get, =
do we
> > > > > really need to hold an additional local ref to call this? As far =
as I
> > > > > understood, once we check that the entry was in the tree before p=
utting
> > > > > the initial ref, there's no need for an additional local one.
> > > >
> > > > I believe it is, but please correct me if I am wrong. Consider the
> > > > following scenario:
> > > >
> > > > // Initially refcount is at 1
> > > >
> > > > CPU#1:                                  CPU#2:
> > > > spin_lock(tree_lock)
> > > > zswap_entry_get() // 2 refs
> > > > spin_unlock(tree_lock)
> > > >                                             spin_lock(tree_lock)
> > > >                                             zswap_invalidate_entry(=
) // 1 ref
> > > >                                             spin_unlock(tree_lock)
> > > > zswap_entry_put() // 0 refs
> > > > zswap_invalidate_entry() // problem
> > > >
> > > > That last zswap_invalidate_entry() call in CPU#1 is problematic. Th=
e
> > > > entry would have already been freed. If we check that the entry is =
on
> > > > the tree by checking RB_EMPTY_NODE(&entry->rbnode), then we are
> > > > reading already freed and potentially re-used memory.
> > > >
> > > > We would need to search the tree to make sure the same entry still
> > > > exists in the tree (aka what zswap_reclaim_entry() currently does).
> > > > This is not ideal in the fault path to have to do the lookups twice=
.
> > >
> > > Thanks for the clarification, it is indeed needed in that case. I was=
 just
> > > wondering if the wording of the comment is exact, in that before call=
ing
> > > zswap_invalidate_entry one has to ensure that the entry has not been =
freed, not
> > > specifically by holding an additional reference, if a lookup can serv=
e the same
> > > purpose.
> >
> >
> > I am wondering if the scenario below is possible, in which case a
> > lookup would not be enough. Let me try to clarify. Let's assume in
> > zswap_reclaim_entry() we drop the local ref early (before we
> > invalidate the entry), and rely on the lookup to ensure that the entry
> > was not freed:
> >
> > - On CPU#1, in zswap_reclaim_entry() we release the lock during IO.
> > Let's assume we drop the local ref here and rely on the lookup to make
> > sure the zswap entry wasn't freed.
> > - On CPU#2, invalidates the swap entry. The zswap entry is freed
> > (returned to the slab allocator).
> > - On CPU#2, we try to reclaim another page, and allocates the same
> > swap slot (same type and offset).
> > - On CPU#2, a zswap entry is allocated, and the slab allocator happens
> > to hand us the same zswap_entry we just freed.
> > - On CPU#1, after IO is done, we lookup the tree to make sure that the
> > zswap entry was not freed. We find the same zswap entry (same address)
> > at the same offset, so we assume it was not freed.
> > - On CPU#1, we invalidate the zswap entry that was actually used by CPU=
#2.
> >
> > I am not entirely sure if this is possible, perhaps locking in the
> > swap layer will prevent the swap entry reuse, but it seems like
> > relying on the lookup can be fragile, and we should rely on the local
> > ref instead to reliably prevent freeing/reuse of the zswap entry.
> >
> > Please correct me if I missed something.
>
> I think it is, we definitely need an additional reference to pin down the=
 entry.
> Sorry if I was being pedantic, my original doubt was only about the wordi=
ng of
> the comment, where it says that an additional reference must be held. I w=
as
> wondering if it was strictly needed, and now I see that it is :)

Not at all! Questions and comments are always welcome (and
encouraged), at least for me :)

>
> >
> > >
> > >
> > > >
> > > > Also, in zswap_reclaim_entry(), would it be possible if we call
> > > > zswap_invalidate_entry() after we drop the local ref that the swap
> > > > entry has been reused for a different page? I didn't look closely, =
but
> > > > if yes, then the slab allocator may have repurposed the zswap_entry
> > > > and we may find the entry in the tree for the same offset, even tho=
ugh
> > > > it is referring to a different page now. This sounds practically
> > > > unlikely but perhaps theoretically possible.
> > >
> > > I'm not sure I understood the scenario, in zswap_reclaim_entry we kee=
p a local
> > > reference until the end in order to avoid a free.
> >
> >
> > Right, I was just trying to reason about what might happen if we call
> > zswap_invalidate_entry() after dropping the local ref, as I mentioned
> > above.
> >
> >
> > >
> > >
> > > >
> > > > I think it's more reliable to call zswap_invalidate_entry() on an
> > > > entry that we know is valid before dropping the local ref. Especial=
ly
> > > > that it's easy to do today by just moving a few lines around.
> > > >
> > > >
> > > >
> > > >
> > > > >
> > > > > >  static void zswap_invalidate_entry(struct zswap_tree *tree,
> > > > > >                                    struct zswap_entry *entry)
> > > > > >  {
> > > > > > -       /* remove from rbtree */
> > > > > > -       zswap_rb_erase(&tree->rbroot, entry);
> > > > > > -
> > > > > > -       /* drop the initial reference from entry creation */
> > > > > > -       zswap_entry_put(tree, entry);
> > > > > > +       if (zswap_rb_erase(&tree->rbroot, entry))
> > > > > > +               zswap_entry_put(tree, entry);
> > > > > >  }
> > > > > >
> > > > > >  static int zswap_reclaim_entry(struct zswap_pool *pool)
> > > > > > @@ -659,8 +663,7 @@ static int zswap_reclaim_entry(struct zswap=
_pool *pool)
> > > > > >          * swapcache. Drop the entry from zswap - unless invali=
date already
> > > > > >          * took it out while we had the tree->lock released for=
 IO.
> > > > > >          */
> > > > > > -       if (entry =3D=3D zswap_rb_search(&tree->rbroot, swpoffs=
et))
> > > > > > -               zswap_invalidate_entry(tree, entry);
> > > > > > +       zswap_invalidate_entry(tree, entry);
> > > > > >
> > > > > >  put_unlock:
> > > > > >         /* Drop local reference */
> > > > > > @@ -1466,7 +1469,6 @@ static int zswap_frontswap_load(unsigned =
type, pgoff_t offset,
> > > > > >                 count_objcg_event(entry->objcg, ZSWPIN);
> > > > > >  freeentry:
> > > > > >         spin_lock(&tree->lock);
> > > > > > -       zswap_entry_put(tree, entry);
> > > > > >         if (!ret && zswap_exclusive_loads_enabled) {
> > > > > >                 zswap_invalidate_entry(tree, entry);
> > > > > >                 *exclusive =3D true;
> > > > > > @@ -1475,6 +1477,7 @@ static int zswap_frontswap_load(unsigned =
type, pgoff_t offset,
> > > > > >                 list_move(&entry->lru, &entry->pool->lru);
> > > > > >                 spin_unlock(&entry->pool->lru_lock);
> > > > > >         }
> > > > > > +       zswap_entry_put(tree, entry);
> > > > > >         spin_unlock(&tree->lock);
> > > > > >
> > > > > >         return ret;
> > > > > > --
> > > > > > 2.41.0.162.gfafddb0af9-goog
> > > > > >
>
> Reviewed-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Thanks!
