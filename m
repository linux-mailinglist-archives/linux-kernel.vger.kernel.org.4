Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757F8716E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjE3UT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjE3UTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:19:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06E0F7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:19:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f6a9131fdso749456866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685477989; x=1688069989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arqdhnroav2wBIJ4Y396wfJZa5CQpssf1Zd+RMr/0mc=;
        b=oPW+uTgOw6AIw/J5KbTB+EU+PIXZn9MZEeCkvD2nEMFORiAmGRRw+UHhmNOIe7jbWd
         TOyycGUEfsohBNMy4L1NbbB/mnDeDezjzerQulzZSUlqU2ypIQYqusyJJpVuzEFxcG/q
         uP5Aa5klZRDVZAn05QAlf66KBrmfEYoUYWbx4htTm2babsKBGP+gKan1L5BWxzg/htzM
         Q4Epbtk/OL8LkbzUKOAHJbOfRjlwTgdvOV8/yH0cFfC+CVXHrxqJQNAz4Fh+9drgUDrl
         H3+7veUiFUrkbOmwaTQrpS8bRLyf9o3fFS8/8c8mraJVJi4cWgAaiNJUkNSkvef/4VCv
         mT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685477989; x=1688069989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arqdhnroav2wBIJ4Y396wfJZa5CQpssf1Zd+RMr/0mc=;
        b=H0F0DQoGQ1oxuoTeyHAbYa1Wcpngt1VBu74AmmZZfruP5qbmBKARbH0XdG1vKrdpwL
         V8bW7dIpxCWZBsy6jaIbGOP2hn+yklU2X/1wIfUiLU8p0N3sD8PEmGVnnUdojFW638Ok
         qQlyo3lwx1k6ap715kbDLK9bfYjAY9M/cLj7OQszLCR9+1EQ1uJBFUPt/MF7jxOmVmEK
         c/vnbW7KY44GLK+j/l1ky4ltfvqfCbjf8tWFmbgfiyA6wjpULfS3NHNi/2+MqdPznroc
         SB0DfekbwlmkSrP6uUpEaulcfCDSzFc4Zzx1bgOzUUX/jcNGA+BQuKcuFUB8eApysDg6
         LI/Q==
X-Gm-Message-State: AC+VfDyCuUoGxop7AsYlhUOv3mA9YjKj4ZutH2NEmSN2zCG+TyX5qTO3
        MYt49Psubsj2Fzv05SQNCjyoiEoosSKeLHofbOVP7Q==
X-Google-Smtp-Source: ACHHUZ6pUJkrK5ZHx0RgimEMwHO0s7D/e7mLH9S2R2xU6VVowT5ZLsv6lb0GdjoPHK0UsO6GZxDbuIWRBOQ9vWiQ+nE=
X-Received: by 2002:a17:907:6e8a:b0:96b:559d:ff19 with SMTP id
 sh10-20020a1709076e8a00b0096b559dff19mr4289040ejc.21.1685477988992; Tue, 30
 May 2023 13:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <20230530180038.GC97194@cmpxchg.org> <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
 <20230530191336.GB101722@cmpxchg.org>
In-Reply-To: <20230530191336.GB101722@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 13:19:12 -0700
Message-ID: <CAJD7tkb8BbPZfDR5=3eMmJ4=7E52mPAafuzeytsnxunDQGyEmg@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Tue, May 30, 2023 at 12:13=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, May 30, 2023 at 11:41:32AM -0700, Yosry Ahmed wrote:
> > On Tue, May 30, 2023 at 11:00=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> > > > On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.co=
m> wrote:
> > > > >
> > > > > Before storing a page, zswap first checks if the number of stored=
 pages
> > > > > exceeds the limit specified by memory.zswap.max, for each cgroup =
in the
> > > > > hierarchy. If this limit is reached or exceeded, then zswap shrin=
king is
> > > > > triggered and short-circuits the store attempt.
> > > > >
> > > > > However, if memory.zswap.max =3D 0 for a cgroup, no amount of wri=
teback
> > > > > will allow future store attempts from processes in this cgroup to
> > > > > succeed. Furthermore, this create a pathological behavior in a sy=
stem
> > > > > where some cgroups have memory.zswap.max =3D 0 and some do not: t=
he
> > > > > processes in the former cgroups, under memory pressure, will evic=
t pages
> > > > > stored by the latter continually, until the need for swap ceases =
or the
> > > > > pool becomes empty.
> > > > >
> > > > > As a result of this, we observe a disproportionate amount of zswa=
p
> > > > > writeback and a perpetually small zswap pool in our experiments, =
even
> > > > > though the pool limit is never hit.
> > > > >
> > > > > This patch fixes the issue by rejecting zswap store attempt witho=
ut
> > > > > shrinking the pool when memory.zswap.max is 0.
> > > > >
> > > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > ---
> > > > >  include/linux/memcontrol.h | 6 +++---
> > > > >  mm/memcontrol.c            | 8 ++++----
> > > > >  mm/zswap.c                 | 9 +++++++--
> > > > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontro=
l.h
> > > > > index 222d7370134c..507bed3a28b0 100644
> > > > > --- a/include/linux/memcontrol.h
> > > > > +++ b/include/linux/memcontrol.h
> > > > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(stru=
ct obj_cgroup *objcg,
> > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > >
> > > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t si=
ze);
> > > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t =
size);
> > > > >  #else
> > > > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg=
)
> > > > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > >  {
> > > > > -       return true;
> > > > > +       return 0;
> > > > >  }
> > > > >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *ob=
jcg,
> > > > >                                            size_t size)
> > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > index 4b27e245a055..09aad0e6f2ea 100644
> > > > > --- a/mm/memcontrol.c
> > > > > +++ b/mm/memcontrol.c
> > > > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =3D {
> > > > >   * spending cycles on compression when there is already no room =
left
> > > > >   * or zswap is disabled altogether somewhere in the hierarchy.
> > > > >   */
> > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > >  {
> > > > >         struct mem_cgroup *memcg, *original_memcg;
> > > > > -       bool ret =3D true;
> > > > > +       int ret =3D 0;
> > > > >
> > > > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > >                 return true;
> > > > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup=
 *objcg)
> > > > >                 if (max =3D=3D PAGE_COUNTER_MAX)
> > > > >                         continue;
> > > > >                 if (max =3D=3D 0) {
> > > > > -                       ret =3D false;
> > > > > +                       ret =3D -ENODEV;
> > > > >                         break;
> > > > >                 }
> > > > >
> > > > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup=
 *objcg)
> > > > >                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) =
/ PAGE_SIZE;
> > > > >                 if (pages < max)
> > > > >                         continue;
> > > > > -               ret =3D false;
> > > > > +               ret =3D -ENOMEM;
> > > > >                 break;
> > > > >         }
> > > > >         mem_cgroup_put(original_memcg);
> > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > index 59da2a415fbb..7b13dc865438 100644
> > > > > --- a/mm/zswap.c
> > > > > +++ b/mm/zswap.c
> > > > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned =
type, pgoff_t offset,
> > > > >         }
> > > > >
> > > > >         objcg =3D get_obj_cgroup_from_page(page);
> > > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > -               goto shrink;
> > > > > +       if (objcg) {
> > > > > +               ret =3D obj_cgroup_may_zswap(objcg);
> > > > > +               if (ret =3D=3D -ENODEV)
> > > > > +                       goto reject;
> > > > > +               if (ret =3D=3D -ENOMEM)
> > > > > +                       goto shrink;
> > > > > +       }
> > > >
> > > > I wonder if we should just make this:
> > > >
> > > > if (objcg && !obj_cgroup_may_zswap(objcg))
> > > >         goto reject;
> > > >
> > > > Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> > > > zswap pool will only help if we happen to writeback a page from the
> > > > same memcg that hit its limit. Keep in mind that we will only
> > > > writeback one page every time we observe that the limit is hit (eve=
n
> > > > with Domenico's patch, because zswap_can_accept() should be true).
> > > >
> > > > On a system with a handful of memcgs,
> > > > it seems likely that we wrongfully writeback pages from other memcg=
s
> > > > because of this. Achieving nothing for this memcg, while hurting
> > > > others. OTOH, without invoking writeback when the limit is hit, the
> > > > memcg will just not be able to use zswap until some pages are
> > > > faulted back in or invalidated.
> > > >
> > > > I am not sure which is better, just thinking out loud.
> > >
> > > You're absolutely right.
> > >
> > > Currently the choice is writing back either everybody or nobody,
> > > meaning between writeback and cgroup containment. They're both so poo=
r
> > > that I can't say I strongly prefer one over the other.
> > >
> > > However, I have a lame argument in favor of this patch:
> > >
> > > The last few fixes from Nhat and Domenico around writeback show that
> > > few people, if anybody, are actually using writeback. So it might not
> > > actually matter that much in practice which way we go with this patch=
.
> > > Per-memcg LRUs will be necessary for it to work right.
> > >
> > > However, what Nhat is proposing is how we want the behavior down the
> > > line. So between two equally poor choices, I figure we might as well
> > > go with the one that doesn't require another code change later on.
> > >
> > > Doesn't that fill you with radiant enthusiasm?
> >
> > If we have per-memcg LRUs, and memory.zswap.max =3D=3D 0, then we shoul=
d
> > be in one of two situations:
> >
> > (a) memory.zswap.max has always been 0, so the LRU for this memcg is
> > empty, so we don't really need the special case for memory.zswap.max
> > =3D=3D 0.
> >
> > (b) memory.zswap.max was reduced to 0 at some point, and some pages
> > are already in zswap. In this case, I don't think shrinking the memcg
> > is such a bad idea, we would be lazily enforcing the limit.
> >
> > In that sense I am not sure that this change won't require another
> > code change. It feels like special casing memory.zswap.max =3D=3D 0 is
> > only needed now due to the lack of per-memcg LRUs.
>
> Good point. And I agree down the line we should just always send the
> shrinker off optimistically on the cgroup's lru list.
>
> So I take back my lame argument. But that then still leaves us with
> the situation that both choices are equal here, right?
>
> If so, my vote would be to go with the patch as-is.

I *think* it's better to punish the memcg that exceeded its limit by
not allowing it to use zswap until its usage goes down, rather than
punish random memcgs on the machine because one memcg hit its limit.
It also seems to me that on a system with a handful of memcgs, it is
statistically more likely for zswap shrinking to writeback a page from
the wrong memcg.

The code would also be simpler if obj_cgroup_may_zswap() just returns
a boolean and we do not shrink at all if it returns false. If it no
longer returns a boolean we should at least rename it.

Did you try just not shrinking at all if the memcg limit is hit in
your experiments?

I don't feel strongly, but my preference would be to just not shrink
at all if obj_cgroup_may_zswap() returns false.
