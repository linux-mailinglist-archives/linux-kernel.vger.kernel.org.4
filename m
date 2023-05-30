Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA02716FEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjE3Vqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjE3Vqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:46:37 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6323AA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:35 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-6261a1a7454so31540206d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685483195; x=1688075195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RU77GmD/d34Gfv6f4V1oiMSEmCl6avPwtTX7fFsFv1w=;
        b=Sg/HA5RdBQ+gfjFLFA5KHfGQkz2K3vY24TSFIoteoRFGuS4IPeKgN8cuMgTMdhsOgg
         //6KimtFEuOxRZW/0r80I8Y1u63Fihzczs/sn27rbUt8FUXYA77fbFjspG2SzGVAT18I
         +ANndvDw+1yrRmpyYeYWGh4HXcY98yYNwUiThrBLK+0SZ6C7qgvxOyNHfjEtvs66vKHu
         vzRPMSMqL6qOFOkj4YNQAItThbHZCVOxzWuawW20cS11ykDRnjeWomb1A7C1Q59hJwLv
         kk4NPDlE3lC9fT9nUKUWXYlBLR0qLQHQRHrjtOMIhFlD2C7Zq6jzSYDsHhxeyVObHiah
         rMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685483195; x=1688075195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RU77GmD/d34Gfv6f4V1oiMSEmCl6avPwtTX7fFsFv1w=;
        b=e3uuzykg1/kVWKmYml0a+FakcCvGsSxEz/ES1xQk5SyQVCK5RQ3rQg2bYIJxLuFoR6
         NVQAOIt7LMH/7ECaV+7hCdOZTEhYJIf2D0dmOZ8Xr6zJfm6dmPe97koMqH4dEFmiTuBg
         pg5VT2R4LlqmeuB1SheR+qTS3dSzraijYrt3j4xol8GYYkLnjFLw4pHvOrhxw5bACVek
         +oNAYSx0xLB0c0rOAFvhhvC+JpwNiE3XUE4NojGXl9xJIZGMTz2krLtNubNqFXIr96Ie
         suZooUcKxFTENDebsdoF0WOIuqPJO5o2ZWGo0jXAi80g9brB7pPYNRI8CGctg36D7eGr
         zHAQ==
X-Gm-Message-State: AC+VfDxlzuQL/ATJM3/gko0AUfDmfai0kh7t81g2jh/5F71JAQWIHu9h
        J/PKngRSlz70/CvtZv2vrhidoMdslmzi3+E5HAo=
X-Google-Smtp-Source: ACHHUZ7DfNnlmTLcfiLt/y2c6iQNWB97DdnJqmPXOxQPpvyXEeVt94ZQ3RVncoZmSNLkich3wtkMTBXh1/P8H3sdsxo=
X-Received: by 2002:a05:6214:2245:b0:623:7707:5650 with SMTP id
 c5-20020a056214224500b0062377075650mr4973154qvc.15.1685483194741; Tue, 30 May
 2023 14:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <20230530180038.GC97194@cmpxchg.org> <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
 <20230530191336.GB101722@cmpxchg.org> <CAJD7tkb8BbPZfDR5=3eMmJ4=7E52mPAafuzeytsnxunDQGyEmg@mail.gmail.com>
 <20230530205940.GA102494@cmpxchg.org> <CAJD7tkZA3L-Dpt4SvTK=J4TsN_OykazBMV110M4E3RK9J82G=g@mail.gmail.com>
In-Reply-To: <CAJD7tkZA3L-Dpt4SvTK=J4TsN_OykazBMV110M4E3RK9J82G=g@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 30 May 2023 14:46:23 -0700
Message-ID: <CAKEwX=PrqV+cCGmdTcFPMqP-48Y=abQTkSOUzJnOWWpc4rR4cA@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Tue, May 30, 2023 at 2:05=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, May 30, 2023 at 1:59=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> >
> > On Tue, May 30, 2023 at 01:19:12PM -0700, Yosry Ahmed wrote:
> > > On Tue, May 30, 2023 at 12:13=E2=80=AFPM Johannes Weiner <hannes@cmpx=
chg.org> wrote:
> > > >
> > > > On Tue, May 30, 2023 at 11:41:32AM -0700, Yosry Ahmed wrote:
> > > > > On Tue, May 30, 2023 at 11:00=E2=80=AFAM Johannes Weiner <hannes@=
cmpxchg.org> wrote:
> > > > > >
> > > > > > On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> > > > > > > On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gm=
ail.com> wrote:
> > > > > > > >
> > > > > > > > Before storing a page, zswap first checks if the number of =
stored pages
> > > > > > > > exceeds the limit specified by memory.zswap.max, for each c=
group in the
> > > > > > > > hierarchy. If this limit is reached or exceeded, then zswap=
 shrinking is
> > > > > > > > triggered and short-circuits the store attempt.
> > > > > > > >
> > > > > > > > However, if memory.zswap.max =3D 0 for a cgroup, no amount =
of writeback
> > > > > > > > will allow future store attempts from processes in this cgr=
oup to
> > > > > > > > succeed. Furthermore, this create a pathological behavior i=
n a system
> > > > > > > > where some cgroups have memory.zswap.max =3D 0 and some do =
not: the
> > > > > > > > processes in the former cgroups, under memory pressure, wil=
l evict pages
> > > > > > > > stored by the latter continually, until the need for swap c=
eases or the
> > > > > > > > pool becomes empty.
> > > > > > > >
> > > > > > > > As a result of this, we observe a disproportionate amount o=
f zswap
> > > > > > > > writeback and a perpetually small zswap pool in our experim=
ents, even
> > > > > > > > though the pool limit is never hit.
> > > > > > > >
> > > > > > > > This patch fixes the issue by rejecting zswap store attempt=
 without
> > > > > > > > shrinking the pool when memory.zswap.max is 0.
> > > > > > > >
> > > > > > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > > > > ---
> > > > > > > >  include/linux/memcontrol.h | 6 +++---
> > > > > > > >  mm/memcontrol.c            | 8 ++++----
> > > > > > > >  mm/zswap.c                 | 9 +++++++--
> > > > > > > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/mem=
control.h
> > > > > > > > index 222d7370134c..507bed3a28b0 100644
> > > > > > > > --- a/include/linux/memcontrol.h
> > > > > > > > +++ b/include/linux/memcontrol.h
> > > > > > > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_even=
t(struct obj_cgroup *objcg,
> > > > > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > > > > >
> > > > > > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, siz=
e_t size);
> > > > > > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, s=
ize_t size);
> > > > > > > >  #else
> > > > > > > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup =
*objcg)
> > > > > > > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *=
objcg)
> > > > > > > >  {
> > > > > > > > -       return true;
> > > > > > > > +       return 0;
> > > > > > > >  }
> > > > > > > >  static inline void obj_cgroup_charge_zswap(struct obj_cgro=
up *objcg,
> > > > > > > >                                            size_t size)
> > > > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > > > index 4b27e245a055..09aad0e6f2ea 100644
> > > > > > > > --- a/mm/memcontrol.c
> > > > > > > > +++ b/mm/memcontrol.c
> > > > > > > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =
=3D {
> > > > > > > >   * spending cycles on compression when there is already no=
 room left
> > > > > > > >   * or zswap is disabled altogether somewhere in the hierar=
chy.
> > > > > > > >   */
> > > > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > > >  {
> > > > > > > >         struct mem_cgroup *memcg, *original_memcg;
> > > > > > > > -       bool ret =3D true;
> > > > > > > > +       int ret =3D 0;
> > > > > > > >
> > > > > > > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > > > > >                 return true;
> > > > > > > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_=
cgroup *objcg)
> > > > > > > >                 if (max =3D=3D PAGE_COUNTER_MAX)
> > > > > > > >                         continue;
> > > > > > > >                 if (max =3D=3D 0) {
> > > > > > > > -                       ret =3D false;
> > > > > > > > +                       ret =3D -ENODEV;
> > > > > > > >                         break;
> > > > > > > >                 }
> > > > > > > >
> > > > > > > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_=
cgroup *objcg)
> > > > > > > >                 pages =3D memcg_page_state(memcg, MEMCG_ZSW=
AP_B) / PAGE_SIZE;
> > > > > > > >                 if (pages < max)
> > > > > > > >                         continue;
> > > > > > > > -               ret =3D false;
> > > > > > > > +               ret =3D -ENOMEM;
> > > > > > > >                 break;
> > > > > > > >         }
> > > > > > > >         mem_cgroup_put(original_memcg);
> > > > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > > > index 59da2a415fbb..7b13dc865438 100644
> > > > > > > > --- a/mm/zswap.c
> > > > > > > > +++ b/mm/zswap.c
> > > > > > > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(uns=
igned type, pgoff_t offset,
> > > > > > > >         }
> > > > > > > >
> > > > > > > >         objcg =3D get_obj_cgroup_from_page(page);
> > > > > > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > > > > -               goto shrink;
> > > > > > > > +       if (objcg) {
> > > > > > > > +               ret =3D obj_cgroup_may_zswap(objcg);
> > > > > > > > +               if (ret =3D=3D -ENODEV)
> > > > > > > > +                       goto reject;
> > > > > > > > +               if (ret =3D=3D -ENOMEM)
> > > > > > > > +                       goto shrink;
> > > > > > > > +       }
> > > > > > >
> > > > > > > I wonder if we should just make this:
> > > > > > >
> > > > > > > if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > > >         goto reject;
> > > > > > >
> > > > > > > Even if memory.zswap.max is > 0, if the limit is hit, shrinki=
ng the
> > > > > > > zswap pool will only help if we happen to writeback a page fr=
om the
> > > > > > > same memcg that hit its limit. Keep in mind that we will only
> > > > > > > writeback one page every time we observe that the limit is hi=
t (even
> > > > > > > with Domenico's patch, because zswap_can_accept() should be t=
rue).
> > > > > > >
> > > > > > > On a system with a handful of memcgs,
> > > > > > > it seems likely that we wrongfully writeback pages from other=
 memcgs
> > > > > > > because of this. Achieving nothing for this memcg, while hurt=
ing
> > > > > > > others. OTOH, without invoking writeback when the limit is hi=
t, the
> > > > > > > memcg will just not be able to use zswap until some pages are
> > > > > > > faulted back in or invalidated.
> > > > > > >
> > > > > > > I am not sure which is better, just thinking out loud.
> > > > > >
> > > > > > You're absolutely right.
> > > > > >
> > > > > > Currently the choice is writing back either everybody or nobody=
,
> > > > > > meaning between writeback and cgroup containment. They're both =
so poor
> > > > > > that I can't say I strongly prefer one over the other.
> > > > > >
> > > > > > However, I have a lame argument in favor of this patch:
> > > > > >
> > > > > > The last few fixes from Nhat and Domenico around writeback show=
 that
> > > > > > few people, if anybody, are actually using writeback. So it mig=
ht not
> > > > > > actually matter that much in practice which way we go with this=
 patch.
> > > > > > Per-memcg LRUs will be necessary for it to work right.
> > > > > >
> > > > > > However, what Nhat is proposing is how we want the behavior dow=
n the
> > > > > > line. So between two equally poor choices, I figure we might as=
 well
> > > > > > go with the one that doesn't require another code change later =
on.
> > > > > >
> > > > > > Doesn't that fill you with radiant enthusiasm?
> > > > >
> > > > > If we have per-memcg LRUs, and memory.zswap.max =3D=3D 0, then we=
 should
> > > > > be in one of two situations:
> > > > >
> > > > > (a) memory.zswap.max has always been 0, so the LRU for this memcg=
 is
> > > > > empty, so we don't really need the special case for memory.zswap.=
max
> > > > > =3D=3D 0.
> > > > >
> > > > > (b) memory.zswap.max was reduced to 0 at some point, and some pag=
es
> > > > > are already in zswap. In this case, I don't think shrinking the m=
emcg
> > > > > is such a bad idea, we would be lazily enforcing the limit.
> > > > >
> > > > > In that sense I am not sure that this change won't require anothe=
r
> > > > > code change. It feels like special casing memory.zswap.max =3D=3D=
 0 is
> > > > > only needed now due to the lack of per-memcg LRUs.
> > > >
> > > > Good point. And I agree down the line we should just always send th=
e
> > > > shrinker off optimistically on the cgroup's lru list.
> > > >
> > > > So I take back my lame argument. But that then still leaves us with
> > > > the situation that both choices are equal here, right?
> > > >
> > > > If so, my vote would be to go with the patch as-is.
> > >
> > > I *think* it's better to punish the memcg that exceeded its limit by
> > > not allowing it to use zswap until its usage goes down, rather than
> > > punish random memcgs on the machine because one memcg hit its limit.
> > > It also seems to me that on a system with a handful of memcgs, it is
> > > statistically more likely for zswap shrinking to writeback a page fro=
m
> > > the wrong memcg.
> >
> > Right, but in either case a hybrid zswap + swap setup with cgroup
> > isolation is broken anyway. Without it being usable, I'm assuming
> > there are no users - maybe that's optimistic of me ;)
> >
> > However, if you think it's better to just be conservative about taking
> > action in general, that's fine by me as well.
>
> Exactly, I just prefer erroring on the conservative side.
>
> >
> > > The code would also be simpler if obj_cgroup_may_zswap() just returns
> > > a boolean and we do not shrink at all if it returns false. If it no
> > > longer returns a boolean we should at least rename it.
> > >
> > > Did you try just not shrinking at all if the memcg limit is hit in
> > > your experiments?
> > >
> > > I don't feel strongly, but my preference would be to just not shrink
> > > at all if obj_cgroup_may_zswap() returns false.
> >
> > Sounds reasonable to me. Basically just replace the goto shrink with
> > goto reject for now. Maybe a comment that says "XXX: Writeback/reclaim
> > does not work with cgroups yet. Needs a cgroup-aware entry LRU first,
> > or we'd push out entries system-wide based on local cgroup limits."
>
> Yeah, exactly -- if Nhat agrees of course.

Sounds good to me! I don't have a strong opinion on this either. I was
just trying to make minimal behavioral change to fix this (i.e keep the
shrinking behavior where possible, but definitely reject where it does
not make sense to shrink).

But this works too, and is actually a smaller change code-wise. We
can revisit this piece of code when the per-memcg LRU comes in.

I'll send a new version with the proposed change (and documentation)
shortly. Thanks for the review and suggestion, everyone!



>
> >
> > Nhat, does that sound good to you?
