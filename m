Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4877712B17
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjEZQyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjEZQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 12:54:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7EA3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:54:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-96f0678de80so160127066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685120053; x=1687712053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NPcxpgoR2MwPm4rLZ08HhomwG+MXwkfyot6ezD6NGg=;
        b=dM9mfExV4md884D88weBSKv89TNEmu+x/+96dzi7SusZ93rrrSI82c5WUzV8loJhRG
         TcVYyJFk7QX0XNBWTA/7C36KKWpRjuBm8M7w0pyq0ChXtKkrGJ32RinnKgQjqF0Ycj1f
         EiFsyZTzwlvP4GxciJeAKqU/kssSElVK+loKnq6yIuvMz0alR9Xs4DSOFQqZ791CD2EY
         qIDIgsjeP0ztWVUrQ6nQgjZekE1nrIQk5l7VuVFdkquHg+L1XnD1Br8bsq/OVTGvtZbY
         YtlFkyIT7iVJ3sBAAPJOWFDumw13c9viQ7tV+9rWxKv5H/zJPPzoxCMZrxF5LNWantz4
         DlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120053; x=1687712053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NPcxpgoR2MwPm4rLZ08HhomwG+MXwkfyot6ezD6NGg=;
        b=CpWSSNY+8qWCSS44GrFknDLx8HO95ZC2KoIZz6xdOVAPy1dyxTAi4ptO7+gN1SF9Ww
         pkeCA92BTCWInyAsBxA38j81vA2vi17WiCP5a9iCM0EaUHU0CRQ+jGJGxC2hKNREmWP3
         DULmoYl6x9bf8v8Dg1lnaEsKsu2MMmweB6+oO2L6p4zXzOM25aHYiroH8+hfpw335Ene
         y7x/MwD+YrIqkwjurgKcuyYO4RUXe3RzlFKwpSMAlBusi7m0qve7gtV3TBPUwnHPVUBJ
         s4gBduw9iUVJFQv1S5dE2r1BI9wPiVbEDrGTeZGOaRdL3BH2xzduxnCSIbiKGeS25nme
         xtTQ==
X-Gm-Message-State: AC+VfDwlwFBQ0bxuQncZtcc15Rgv2LeDQ3L4jUbQYL3GK4qWXbGGEwCV
        F6sSqVizQdq693VJAQu2PVp82fHk/GsQJIwKU9Q9ug==
X-Google-Smtp-Source: ACHHUZ4b9SF5gT4ngi9y+3MZs/6uHy7fjrjXhhtp/2XCa2pN8VqjsNG1YPKlIGyzqFstVEPtDErAE5aOwvZEaeGZumM=
X-Received: by 2002:a17:907:7d8f:b0:96b:e93:3aa8 with SMTP id
 oz15-20020a1709077d8f00b0096b0e933aa8mr2550911ejc.21.1685120052606; Fri, 26
 May 2023 09:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230524065051.6328-1-cerasuolodomenico@gmail.com>
 <CAJD7tkY0j4xzstf=OCX-k-mujzbXf_nt=H4F5JCZNZ8N1iEEcg@mail.gmail.com>
 <CA+CLi1gzVop3=kmARn09NKKh6yW=bt9KYrzc0AfXB64J0r-9Ew@mail.gmail.com>
 <CAJD7tkaJAPhHVwepUeiAmSwomNmUKiYUR2gixsvLwHxB6k7UZA@mail.gmail.com> <CA+CLi1i02o+ZzWEgK-U=wftqQ9DgijZWUnEAeGNAZ17SeBh9ig@mail.gmail.com>
In-Reply-To: <CA+CLi1i02o+ZzWEgK-U=wftqQ9DgijZWUnEAeGNAZ17SeBh9ig@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 09:53:36 -0700
Message-ID: <CAJD7tka_fc7VP8hJMY4H71pq7wWuFdyU0ciWzsfGXNLeUReAKg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: shrink until can accept
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        hannes@cmpxchg.org, kernel-team@fb.com
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

On Fri, May 26, 2023 at 1:52=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> On Thu, May 25, 2023 at 9:10=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Thu, May 25, 2023 at 9:53=E2=80=AFAM Domenico Cerasuolo
> > <cerasuolodomenico@gmail.com> wrote:
> > >
> > > On Thu, May 25, 2023 at 2:59=E2=80=AFAM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > Hi Domenico,
> > > >
> > > > On Tue, May 23, 2023 at 11:50=E2=80=AFPM Domenico Cerasuolo
> > > > <cerasuolodomenico@gmail.com> wrote:
> > > > >
> > > > > This update addresses an issue with the zswap reclaim mechanism, =
which
> > > > > hinders the efficient offloading of cold pages to disk, thereby
> > > > > compromising the preservation of the LRU order and consequently
> > > > > diminishing, if not inverting, its performance benefits.
> > > > >
> > > > > The functioning of the zswap shrink worker was found to be inadeq=
uate,
> > > > > as shown by basic benchmark test. For the test, a kernel build wa=
s
> > > > > utilized as a reference, with its memory confined to 1G via a cgr=
oup and
> > > > > a 5G swap file provided. The results are presented below, these a=
re
> > > > > averages of three runs without the use of zswap:
> > > > >
> > > > > real 46m26s
> > > > > user 35m4s
> > > > > sys 7m37s
> > > > >
> > > > > With zswap (zbud) enabled and max_pool_percent set to 1 (in a 32G
> > > > > system), the results changed to:
> > > > >
> > > > > real 56m4s
> > > > > user 35m13s
> > > > > sys 8m43s
> > > > >
> > > > > written_back_pages: 18
> > > > > reject_reclaim_fail: 0
> > > > > pool_limit_hit:1478
> > > > >
> > > > > Besides the evident regression, one thing to notice from this dat=
a is
> > > > > the extremely low number of written_back_pages and pool_limit_hit=
.
> > > > >
> > > > > The pool_limit_hit counter, which is increased in zswap_frontswap=
_store
> > > > > when zswap is completely full, doesn't account for a particular
> > > > > scenario: once zswap hits his limit, zswap_pool_reached_full is s=
et to
> > > > > true; with this flag on, zswap_frontswap_store rejects pages if z=
swap is
> > > > > still above the acceptance threshold. Once we include the rejecti=
ons due
> > > > > to zswap_pool_reached_full && !zswap_can_accept(), the number goe=
s from
> > > > > 1478 to a significant 21578266.
> > > > >
> > > > > Zswap is stuck in an undesirable state where it rejects pages bec=
ause
> > > > > it's above the acceptance threshold, yet fails to attempt memory
> > > > > reclaimation. This happens because the shrink work is only queued=
 when
> > > > > zswap_frontswap_store detects that it's full and the work itself =
only
> > > > > reclaims one page per run.
> > > > >
> > > > > This state results in hot pages getting written directly to disk,
> > > > > while cold ones remain memory, waiting only to be invalidated. Th=
e LRU
> > > > > order is completely broken and zswap ends up being just an overhe=
ad
> > > > > without providing any benefits.
> > > > >
> > > > > This commit applies 2 changes: a) the shrink worker is set to rec=
laim
> > > > > pages until the acceptance threshold is met and b) the task is al=
so
> > > > > enqueued when zswap is not full but still above the threshold.
> > > > >
> > > > > Testing this suggested update showed much better numbers:
> > > > >
> > > > > real 36m37s
> > > > > user 35m8s
> > > > > sys 9m32s
> > > > >
> > > > > written_back_pages: 10459423
> > > > > reject_reclaim_fail: 12896
> > > > > pool_limit_hit: 75653
> > > >
> > > > Impressive numbers, and great find in general!
> > > >
> > > > I wonder how other workloads benefit/regress from this change.
> > > > Anything else that you happened to run? :)
> > > >
> > > Hi Yosry,
> > >
> > > thanks for the quick feedback!
> > >
> > > Besides stressers, I haven't tested any other actual workload, we don=
't have
> > > writeback in production yet so I can't provide any data from there. I=
 was
> > > wondering what kind of actual workload I could use to test this on my=
 desktop,
> > > but I couldn't think of anything relevant, I'm open to suggestions th=
ough :)
> >
> > Nothing in mind in particular as well. Perhaps others have ideas.
> >
> > > > >
> > > > > Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if po=
ol limit is hit")
> > > > > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > > > ---
> > > > >  mm/zswap.c | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index 59da2a415fbb..2ee0775d8213 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -587,9 +587,13 @@ static void shrink_worker(struct work_struct=
 *w)
> > > > >  {
> > > > >         struct zswap_pool *pool =3D container_of(w, typeof(*pool)=
,
> > > > >                                                 shrink_work);
> > > > > +       int ret;
> > > > >
> > > > > -       if (zpool_shrink(pool->zpool, 1, NULL))
> > > > > -               zswap_reject_reclaim_fail++;
> > > > > +       do {
> > > > > +               ret =3D zpool_shrink(pool->zpool, 1, NULL);
> > > > > +               if (ret)
> > > > > +                       zswap_reject_reclaim_fail++;
> > > > > +       } while (!zswap_can_accept() && ret !=3D -EINVAL);
> > > >
> > > > One question/comment here about the retry logic.
> > > >
> > > > So I looked through the awfully convoluted writeback code, and ther=
e
> > > > are multiple layers, and some of them tend to overwrite the return
> > > > value of the layer underneath :(
> > > >
> > > > For zsmalloc (as an example):
> > > > zpool_shrink()->zs_zpool_shrink()->zs_reclaim_page()->zpool_ops.evi=
ct()->zswap_writeback_entry().
> > > >
> > > > First of all, that zpool_ops is an unnecessarily confusing
> > > > indirection, but anyway.
> > > >
> > > > - zswap_writeback_entry() will either return -ENOMEM or -EEXIST on =
error
> > > > - zs_reclaim_page()/zbud_reclaim_page() will return -EINVAL if the =
lru
> > > > is empty, and -EAGAIN on other errors.
> > > > - zs_zpool_shrink()/zbud_zpool_shrink() will mostly propagate the
> > > > return value of  zs_reclaim_page()/zbud_reclaim_page().
> > > > - zpool_shrink() will return -EINVAL if the driver does not support
> > > > shrinking, otherwise it will propagate the return value from the
> > > > driver.
> > > >
> > > > So it looks like we will get -EINVAL only if the driver lru is empt=
y
> > > > or the driver does not support writeback, so rightfully we should n=
ot
> > > > retry.
> > > >
> > > > If zswap_writeback_entry() returns -EEXIST, it probably means that =
we
> > > > raced with another task decompressing the page, so rightfully we
> > > > should retry to writeback another page instead.
> > > >
> > > > If zswap_writeback_entry() returns -ENOMEM, it doesn't necessarily
> > > > mean that we couldn't allocate memory (unfortunately), it looks lik=
e
> > > > we will return -ENOMEM in other cases as well. Arguably, we can ret=
ry
> > > > in all cases, because even if we were actually out of memory, we ar=
e
> > > > trying to make an allocation that will eventually free more memory.
> > > >
> > > > In all cases, I think it would be nicer if we retry if ret =3D=3D -=
EAGAIN
> > > > instead. It is semantically more sane. In this specific case it is
> > > > functionally NOP as zs_reclaim_page()/zbud_reclaim_page() will most=
ly
> > > > return -EAGAIN anyway, but in case someone tries to use saner errno=
s
> > > > in the future, this will age better.
> > > Retrying if ret =3D=3D -EAGAIN seems much nicer indeed, will change i=
t.
> > > >
> > > > Also, do we intentionally want to keep retrying forever on failure?=
 Do
> > > > we want to add a max number of retries?
> > > If the drivers guaranteed that zpool_shrink will remove at least an e=
ntry
> > > from their LRU, the retry wouldn't be needed because the LRU will
> > > eventually be emptied. But this is an assumption on the implementatio=
n of
> >
> > I don't think any zpool driver can guarantee to writeback at least one
> > page. It can fail for reasons beyond their control (e.g. cannot
> > allocate a page to decompress to).
> >
> > > the zpool, so yes, we could use a max retries. I think that being a s=
anity
> > > check, it should overshoot the required number of iterations in order=
 to
> > > avoid a premature break, what about retrying a max of
> > > zswap_stored_pages times?
> >
> > Why is it just a sanity check? Consider a case where the system is
> > under extreme memory pressure that the drivers cannot allocate pages
> > to decompress to. The drivers would be continuously competing with all
> > other allocations on the machine. I think we should give up at some
> > point. In any case, you changed the zswap_frontswap_store() to goto
> > shrink if !zswap_can_accept(), so next time we try to compress a page
> > to zswap we will invoke try again anyway -- perhaps under better
> > circumstances.
> >
> > I think zswap_stored_pages is too much, keep in mind that it also
> > includes same-filled pages which are not even stored in the zpool
> > drivers. Maybe we should allow a fixed number of failures. If
> > zpool_shrink() is successful, keep going until zswap_can_accept().
> > Otherwise allow a fixed number of failures before giving up.
> >
>
> Yes, I think I got carried away by a writeback frenzy, while testing the =
LRU
> refactor I had to fight to get a decent amount of writebacks, and ended u=
p
> being too afraid the shrink work would stop.
> What about using MAX_RECLAIM_RETRIES? I like the idea of putting a limit =
but
> I wouldn't know how to pick a fixed number.

In a sense, shrinking zswap is a form of reclaim, and is triggered by
reclaim, so MAX_RECLAIM_RETRIES sounds reasonable to me. We can always
revisit if needed.

>
> > Maybe we can improve the error codes propagated through the writeback
> > code as well to improve the retry logic. For example, if
> > zswap_writeback_entry() returns EEXIST then retrying should be
> > harmless, but ENOMEM might be harmful. Both of which are propagated as
> > EAGAIN from zs_zpool_shrink()/zbud_zpool_shrink().
> >
>
> That would be a nice improvement indeed, I'd queue it after the LRU refac=
tor
> though.

Great!

>
> > > >
> > > > >         zswap_pool_put(pool);
> > > > >  }
> > > > >
> > > > > @@ -1188,7 +1192,7 @@ static int zswap_frontswap_store(unsigned t=
ype, pgoff_t offset,
> > > > >         if (zswap_pool_reached_full) {
> > > > >                if (!zswap_can_accept()) {
> > > > >                         ret =3D -ENOMEM;
> > > > > -                       goto reject;
> > > > > +                       goto shrink;
> > > > >                 } else
> > > > >                         zswap_pool_reached_full =3D false;
> > > > >         }
> > > > > --
> > > > > 2.34.1
> > > > >
