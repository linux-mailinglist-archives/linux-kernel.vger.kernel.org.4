Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A0716F58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbjE3VFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjE3VFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:05:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9051F99
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:05:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af29b37bd7so54551411fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685480734; x=1688072734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRlag3IP6WRuvIKALTZZ5sR/28OhDehgXmzr30sFnqw=;
        b=IxRIhda7mJBVSqM0DNAHjz5FBFnKEO82bGPtbYgiu54O4JxFUWijDwy7RCJ5n0lBZh
         RSximn2kYVXe5wlwgIOZw+c7wslvrCEPRXQ4fPE4YLMSodyQd3dtFSLgFlYytEqDk7p4
         NayOoRfh7fA9QJp3m4Q7iZWDmKpU0MD+Sv2gZH6wkcpkS40NIIZrkwbLKHkfYcjyMP9s
         8ZY73CHtNG465ZcvLs8i1hePNiyLzoU8y4mcVBGGquosx5cXdjypGiKvOasm7iUFSNQz
         JvnGlqZymoyzPmliyqexvE2Xk0CoTIqxL7NqeiDLc4lOOaVIRnhibsoRMKpdyC0U7LgF
         a9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480734; x=1688072734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRlag3IP6WRuvIKALTZZ5sR/28OhDehgXmzr30sFnqw=;
        b=VhtcKAfJI/xTzdmaIbmr2TpwO+w41XN6ZSP9fa2vSc4uZRM511aJpgwmJKNzcGCkpN
         e9A+N/RD2+wg5qTVOzZN0xpAvzQf7yqmfZgQKB/amDSpHkWL1+cVQVU5r3bNsjlxSi3R
         dGYX/SOjNJzldj+lhxyAyRNLhzVQhGRE7JIQPdMh71Qh9+SVejF+tUnF4HRM4T+UkxdW
         MMsgv6ziY4HNuJSEkhG+RBhc2PmECm3+NPInw2W4iZNaWzfzFcRmyi9m2eCvliWr3fwP
         UtnbSiFBl8s2Irc8vlw4hS6sMplkekeP4JUxiKiKXsnxy67rjgjtXSCMhUVBO0ie9270
         CzHA==
X-Gm-Message-State: AC+VfDy7BDS3nSHCS6W3rsS1HIlZDPyDLbqO9exuhCKLjAHM+Wi3/jPi
        4qk7T89kFTwLh8F/HiApLko/FWfQ7rL8dwQw1ZK6sA==
X-Google-Smtp-Source: ACHHUZ7Zp8oJbHvSFe3mBEKaiZhOHzYy8+TmMS6BK/n3/7mGCMRkjrQTfTp2QOU+zAUjpV8u7O/KVADsqjHV60dyB7w=
X-Received: by 2002:a2e:8244:0:b0:2a8:ae7e:b9cb with SMTP id
 j4-20020a2e8244000000b002a8ae7eb9cbmr1570757ljh.42.1685480733570; Tue, 30 May
 2023 14:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <20230530180038.GC97194@cmpxchg.org> <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
 <20230530191336.GB101722@cmpxchg.org> <CAJD7tkb8BbPZfDR5=3eMmJ4=7E52mPAafuzeytsnxunDQGyEmg@mail.gmail.com>
 <20230530205940.GA102494@cmpxchg.org>
In-Reply-To: <20230530205940.GA102494@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 14:04:57 -0700
Message-ID: <CAJD7tkZA3L-Dpt4SvTK=J4TsN_OykazBMV110M4E3RK9J82G=g@mail.gmail.com>
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

On Tue, May 30, 2023 at 1:59=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, May 30, 2023 at 01:19:12PM -0700, Yosry Ahmed wrote:
> > On Tue, May 30, 2023 at 12:13=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Tue, May 30, 2023 at 11:41:32AM -0700, Yosry Ahmed wrote:
> > > > On Tue, May 30, 2023 at 11:00=E2=80=AFAM Johannes Weiner <hannes@cm=
pxchg.org> wrote:
> > > > >
> > > > > On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> > > > > > On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gmai=
l.com> wrote:
> > > > > > >
> > > > > > > Before storing a page, zswap first checks if the number of st=
ored pages
> > > > > > > exceeds the limit specified by memory.zswap.max, for each cgr=
oup in the
> > > > > > > hierarchy. If this limit is reached or exceeded, then zswap s=
hrinking is
> > > > > > > triggered and short-circuits the store attempt.
> > > > > > >
> > > > > > > However, if memory.zswap.max =3D 0 for a cgroup, no amount of=
 writeback
> > > > > > > will allow future store attempts from processes in this cgrou=
p to
> > > > > > > succeed. Furthermore, this create a pathological behavior in =
a system
> > > > > > > where some cgroups have memory.zswap.max =3D 0 and some do no=
t: the
> > > > > > > processes in the former cgroups, under memory pressure, will =
evict pages
> > > > > > > stored by the latter continually, until the need for swap cea=
ses or the
> > > > > > > pool becomes empty.
> > > > > > >
> > > > > > > As a result of this, we observe a disproportionate amount of =
zswap
> > > > > > > writeback and a perpetually small zswap pool in our experimen=
ts, even
> > > > > > > though the pool limit is never hit.
> > > > > > >
> > > > > > > This patch fixes the issue by rejecting zswap store attempt w=
ithout
> > > > > > > shrinking the pool when memory.zswap.max is 0.
> > > > > > >
> > > > > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > > > ---
> > > > > > >  include/linux/memcontrol.h | 6 +++---
> > > > > > >  mm/memcontrol.c            | 8 ++++----
> > > > > > >  mm/zswap.c                 | 9 +++++++--
> > > > > > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > > > > > >
> > > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memco=
ntrol.h
> > > > > > > index 222d7370134c..507bed3a28b0 100644
> > > > > > > --- a/include/linux/memcontrol.h
> > > > > > > +++ b/include/linux/memcontrol.h
> > > > > > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(=
struct obj_cgroup *objcg,
> > > > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > > > >
> > > > > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_=
t size);
> > > > > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, siz=
e_t size);
> > > > > > >  #else
> > > > > > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *o=
bjcg)
> > > > > > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *ob=
jcg)
> > > > > > >  {
> > > > > > > -       return true;
> > > > > > > +       return 0;
> > > > > > >  }
> > > > > > >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup=
 *objcg,
> > > > > > >                                            size_t size)
> > > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > > index 4b27e245a055..09aad0e6f2ea 100644
> > > > > > > --- a/mm/memcontrol.c
> > > > > > > +++ b/mm/memcontrol.c
> > > > > > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =
=3D {
> > > > > > >   * spending cycles on compression when there is already no r=
oom left
> > > > > > >   * or zswap is disabled altogether somewhere in the hierarch=
y.
> > > > > > >   */
> > > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > >  {
> > > > > > >         struct mem_cgroup *memcg, *original_memcg;
> > > > > > > -       bool ret =3D true;
> > > > > > > +       int ret =3D 0;
> > > > > > >
> > > > > > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > > > >                 return true;
> > > > > > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cg=
roup *objcg)
> > > > > > >                 if (max =3D=3D PAGE_COUNTER_MAX)
> > > > > > >                         continue;
> > > > > > >                 if (max =3D=3D 0) {
> > > > > > > -                       ret =3D false;
> > > > > > > +                       ret =3D -ENODEV;
> > > > > > >                         break;
> > > > > > >                 }
> > > > > > >
> > > > > > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cg=
roup *objcg)
> > > > > > >                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP=
_B) / PAGE_SIZE;
> > > > > > >                 if (pages < max)
> > > > > > >                         continue;
> > > > > > > -               ret =3D false;
> > > > > > > +               ret =3D -ENOMEM;
> > > > > > >                 break;
> > > > > > >         }
> > > > > > >         mem_cgroup_put(original_memcg);
> > > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > > index 59da2a415fbb..7b13dc865438 100644
> > > > > > > --- a/mm/zswap.c
> > > > > > > +++ b/mm/zswap.c
> > > > > > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsig=
ned type, pgoff_t offset,
> > > > > > >         }
> > > > > > >
> > > > > > >         objcg =3D get_obj_cgroup_from_page(page);
> > > > > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > > > -               goto shrink;
> > > > > > > +       if (objcg) {
> > > > > > > +               ret =3D obj_cgroup_may_zswap(objcg);
> > > > > > > +               if (ret =3D=3D -ENODEV)
> > > > > > > +                       goto reject;
> > > > > > > +               if (ret =3D=3D -ENOMEM)
> > > > > > > +                       goto shrink;
> > > > > > > +       }
> > > > > >
> > > > > > I wonder if we should just make this:
> > > > > >
> > > > > > if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > >         goto reject;
> > > > > >
> > > > > > Even if memory.zswap.max is > 0, if the limit is hit, shrinking=
 the
> > > > > > zswap pool will only help if we happen to writeback a page from=
 the
> > > > > > same memcg that hit its limit. Keep in mind that we will only
> > > > > > writeback one page every time we observe that the limit is hit =
(even
> > > > > > with Domenico's patch, because zswap_can_accept() should be tru=
e).
> > > > > >
> > > > > > On a system with a handful of memcgs,
> > > > > > it seems likely that we wrongfully writeback pages from other m=
emcgs
> > > > > > because of this. Achieving nothing for this memcg, while hurtin=
g
> > > > > > others. OTOH, without invoking writeback when the limit is hit,=
 the
> > > > > > memcg will just not be able to use zswap until some pages are
> > > > > > faulted back in or invalidated.
> > > > > >
> > > > > > I am not sure which is better, just thinking out loud.
> > > > >
> > > > > You're absolutely right.
> > > > >
> > > > > Currently the choice is writing back either everybody or nobody,
> > > > > meaning between writeback and cgroup containment. They're both so=
 poor
> > > > > that I can't say I strongly prefer one over the other.
> > > > >
> > > > > However, I have a lame argument in favor of this patch:
> > > > >
> > > > > The last few fixes from Nhat and Domenico around writeback show t=
hat
> > > > > few people, if anybody, are actually using writeback. So it might=
 not
> > > > > actually matter that much in practice which way we go with this p=
atch.
> > > > > Per-memcg LRUs will be necessary for it to work right.
> > > > >
> > > > > However, what Nhat is proposing is how we want the behavior down =
the
> > > > > line. So between two equally poor choices, I figure we might as w=
ell
> > > > > go with the one that doesn't require another code change later on=
.
> > > > >
> > > > > Doesn't that fill you with radiant enthusiasm?
> > > >
> > > > If we have per-memcg LRUs, and memory.zswap.max =3D=3D 0, then we s=
hould
> > > > be in one of two situations:
> > > >
> > > > (a) memory.zswap.max has always been 0, so the LRU for this memcg i=
s
> > > > empty, so we don't really need the special case for memory.zswap.ma=
x
> > > > =3D=3D 0.
> > > >
> > > > (b) memory.zswap.max was reduced to 0 at some point, and some pages
> > > > are already in zswap. In this case, I don't think shrinking the mem=
cg
> > > > is such a bad idea, we would be lazily enforcing the limit.
> > > >
> > > > In that sense I am not sure that this change won't require another
> > > > code change. It feels like special casing memory.zswap.max =3D=3D 0=
 is
> > > > only needed now due to the lack of per-memcg LRUs.
> > >
> > > Good point. And I agree down the line we should just always send the
> > > shrinker off optimistically on the cgroup's lru list.
> > >
> > > So I take back my lame argument. But that then still leaves us with
> > > the situation that both choices are equal here, right?
> > >
> > > If so, my vote would be to go with the patch as-is.
> >
> > I *think* it's better to punish the memcg that exceeded its limit by
> > not allowing it to use zswap until its usage goes down, rather than
> > punish random memcgs on the machine because one memcg hit its limit.
> > It also seems to me that on a system with a handful of memcgs, it is
> > statistically more likely for zswap shrinking to writeback a page from
> > the wrong memcg.
>
> Right, but in either case a hybrid zswap + swap setup with cgroup
> isolation is broken anyway. Without it being usable, I'm assuming
> there are no users - maybe that's optimistic of me ;)
>
> However, if you think it's better to just be conservative about taking
> action in general, that's fine by me as well.

Exactly, I just prefer erroring on the conservative side.

>
> > The code would also be simpler if obj_cgroup_may_zswap() just returns
> > a boolean and we do not shrink at all if it returns false. If it no
> > longer returns a boolean we should at least rename it.
> >
> > Did you try just not shrinking at all if the memcg limit is hit in
> > your experiments?
> >
> > I don't feel strongly, but my preference would be to just not shrink
> > at all if obj_cgroup_may_zswap() returns false.
>
> Sounds reasonable to me. Basically just replace the goto shrink with
> goto reject for now. Maybe a comment that says "XXX: Writeback/reclaim
> does not work with cgroups yet. Needs a cgroup-aware entry LRU first,
> or we'd push out entries system-wide based on local cgroup limits."

Yeah, exactly -- if Nhat agrees of course.

>
> Nhat, does that sound good to you?
