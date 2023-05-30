Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB85716CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjE3SoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjE3Snp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:43:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABA310C2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:43:13 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so210343a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685472191; x=1688064191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYlC6f1ptZM9RLLhM2nAeeNeJg2ua4dk7rTUSObgR8A=;
        b=eztyZFUdNTCsYWXIz8bXNkVgGqmeVODl99L+cyyUAHCyaDT66qPJExCC8yi4Fipu/G
         KzP7gwyLFSGrwT6y3UyLF5jFLFaRXlxWxIgxGTVLSDkEp44GgQz+UhNsrpXJyDybbp+2
         +9R5txif6Tq1Gshc+NQRqRyyj9cRFK4I4HPqrTgEIWd7LlKjDsnB2ZVO5rxIsRF2SuU/
         PORCSSdJk3V+njyKDZ9s3QdOMtKV09CmQyn8SLuAn7e0trk+5MHTt4VjvtV4AP9F4Tns
         U8x3pCsPQSMYYullXI5WBytvYTln9ewl6dSjFrtWu6H/T21edwMwaAGg23yP9LCru3WH
         agEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685472191; x=1688064191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYlC6f1ptZM9RLLhM2nAeeNeJg2ua4dk7rTUSObgR8A=;
        b=P4TNClMjhCeBiKMNlLLB8veM6E984wGHuM55thiXxfdgn/s8NXORa2TwRdAjuZIRaQ
         GGJL+90dZfsQH0lAwLtAQnc2nnsXEZafGomm3Yu2CDuDTtVftu9Uqt+vKwXRpEzfBkt+
         lMB928JR8EocSi5cBmxSg8h1GgjiCpBDVyAiNrTEjWupe6vuy7c7+F7B4Z/gXZlIQ0Iq
         DexcQjpQcgXICyksPRsOB9FAq9ODYuMRvUxoAa6vB2x1U+WDM8KmunoFaP4qrBNzJD5l
         120BVvteKOItOZoJ8KMZ4T4yL1byCGhNRdU4ftS1855nl6OrviL1JPWF6hugPIrcjRaE
         twwA==
X-Gm-Message-State: AC+VfDzthmSJTZzDcE3A6C1LHuiFj/XBO40v0wbZMLF21qxmuk8oM2Ad
        5tNNBs9iYfB2SBGfovXS7aZMIBf7ZkyswyF4bhQVpKBbUr5Omn7eNck=
X-Google-Smtp-Source: ACHHUZ4Up5j7j1dkGSw8jtZaye0oKfZ0iz4LLsDnW/efMFR9/mRGSpcrTUU9zlCHs3dveVNbfOkvYupOm5tj0mlvlms=
X-Received: by 2002:a17:907:9721:b0:94f:2916:7d7 with SMTP id
 jg33-20020a170907972100b0094f291607d7mr2884534ejc.19.1685472191237; Tue, 30
 May 2023 11:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162153.836565-1-nphamcs@gmail.com> <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
In-Reply-To: <CAKEwX=OK5qK9DTYLKZUefE0eq8KooygT-nbkgUZaYjK72SKzFQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 30 May 2023 11:42:34 -0700
Message-ID: <CAJD7tkZUc=h+h4f1a+nas8KruFBaGMuaq67jZLk+LkdbwZVqKQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
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

On Tue, May 30, 2023 at 11:27=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, May 30, 2023 at 9:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, May 30, 2023 at 9:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > Before storing a page, zswap first checks if the number of stored pag=
es
> > > exceeds the limit specified by memory.zswap.max, for each cgroup in t=
he
> > > hierarchy. If this limit is reached or exceeded, then zswap shrinking=
 is
> > > triggered and short-circuits the store attempt.
> > >
> > > However, if memory.zswap.max =3D 0 for a cgroup, no amount of writeba=
ck
> > > will allow future store attempts from processes in this cgroup to
> > > succeed. Furthermore, this create a pathological behavior in a system
> > > where some cgroups have memory.zswap.max =3D 0 and some do not: the
> > > processes in the former cgroups, under memory pressure, will evict pa=
ges
> > > stored by the latter continually, until the need for swap ceases or t=
he
> > > pool becomes empty.
> > >
> > > As a result of this, we observe a disproportionate amount of zswap
> > > writeback and a perpetually small zswap pool in our experiments, even
> > > though the pool limit is never hit.
> > >
> > > This patch fixes the issue by rejecting zswap store attempt without
> > > shrinking the pool when memory.zswap.max is 0.
> > >
> > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h | 6 +++---
> > >  mm/memcontrol.c            | 8 ++++----
> > >  mm/zswap.c                 | 9 +++++++--
> > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 222d7370134c..507bed3a28b0 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct o=
bj_cgroup *objcg,
> > >  #endif /* CONFIG_MEMCG_KMEM */
> > >
> > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size=
);
> > >  #else
> > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > >  {
> > > -       return true;
> > > +       return 0;
> > >  }
> > >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
> > >                                            size_t size)
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 4b27e245a055..09aad0e6f2ea 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] =3D {
> > >   * spending cycles on compression when there is already no room left
> > >   * or zswap is disabled altogether somewhere in the hierarchy.
> > >   */
> > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > >  {
> > >         struct mem_cgroup *memcg, *original_memcg;
> > > -       bool ret =3D true;
> > > +       int ret =3D 0;
> > >
> > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > >                 return true;
> > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *ob=
jcg)
> > >                 if (max =3D=3D PAGE_COUNTER_MAX)
> > >                         continue;
> > >                 if (max =3D=3D 0) {
> > > -                       ret =3D false;
> > > +                       ret =3D -ENODEV;
> > >                         break;
> > >                 }
> > >
> > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *ob=
jcg)
> > >                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PA=
GE_SIZE;
> > >                 if (pages < max)
> > >                         continue;
> > > -               ret =3D false;
> > > +               ret =3D -ENOMEM;
> > >                 break;
> > >         }
> > >         mem_cgroup_put(original_memcg);
> > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > index 59da2a415fbb..7b13dc865438 100644
> > > --- a/mm/zswap.c
> > > +++ b/mm/zswap.c
> > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type=
, pgoff_t offset,
> > >         }
> > >
> > >         objcg =3D get_obj_cgroup_from_page(page);
> > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > -               goto shrink;
> > > +       if (objcg) {
> > > +               ret =3D obj_cgroup_may_zswap(objcg);
> > > +               if (ret =3D=3D -ENODEV)
> > > +                       goto reject;
> > > +               if (ret =3D=3D -ENOMEM)
> > > +                       goto shrink;
> > > +       }
> >
> > I wonder if we should just make this:
> >
> > if (objcg && !obj_cgroup_may_zswap(objcg))
> >         goto reject;
> >
> > Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> > zswap pool will only help if we happen to writeback a page from the
> > same memcg that hit its limit. Keep in mind that we will only
> > writeback one page every time we observe that the limit is hit (even
> > with Domenico's patch, because zswap_can_accept() should be true).
> >
> > On a system with a handful of memcgs,
> > it seems likely that we wrongfully writeback pages from other memcgs
> > because of this. Achieving nothing for this memcg, while hurting
> > others. OTOH, without invoking writeback when the limit is hit, the
> > memcg will just not be able to use zswap until some pages are
> > faulted back in or invalidated.
> >
> > I am not sure which is better, just thinking out loud.
> >
> > Seems like this can be solved by having per-memcg LRUs, or at least
> > providing an argument to the shrinker of which memcg to reclaim from.
> > This would only be possible when the LRU is moved to zswap.
>
> I totally agree! This seems like the logical next step in zswap's evoluti=
on.
> I actually proposed this fix with this future development in mind - with
> a per-memcg LRU, we can trigger memcg-specific shrinking in
> place of this indiscriminate writeback. It seems less drastic a change
> (compared to removing shrinking here now, then reintroducing it later).

As I stated in my reply to Johannes, I am just not sure that we will
need to special case memory.zswap.max =3D=3D 0 when we have proper
writeback. WDYT?

>
> Thanks for the feedback, Yosry!
>
> >
> >
> > >
> > >         /* reclaim space if needed */
> > >         if (zswap_is_full()) {
> > > --
> > > 2.34.1
> > >
> > >
