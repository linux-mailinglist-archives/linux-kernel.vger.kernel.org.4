Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E174712042
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbjEZGjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbjEZGjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:39:09 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8F2194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:39:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2d092d7aso3897171fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 23:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685083142; x=1687675142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aO8WcUZImZYEcXMmvb5XeqF4flNwtTh70ks9aqSmaXk=;
        b=mHpg5DEb3GzDpprV5V5IDZq6Js+9J/DwLwh7rGPqTyOA1iUCYHiduK96ziHf8J3ud1
         IsBlBQePcevpLOI/1WJHzRxO6uKJfGMCmrO0fTjtbSlJqpcw4dSKh970+24QqB8ihP4U
         Kip9o8xw3HSXbVr3y/Dxp2pDU3y9m7s8VKpKn8LXvQ2tfRKdNQxRT+bsrv3/DvYH6lKQ
         /ZhKBjI8ak5qpmW5kB6eegvGWGJxVVnFyyq11MBRg/cbkVQuYYgD+3cYliOhrMPfAkP1
         tLieujOrM6SzhoqpMhDu1oFhB12/M9qKsghIWauBNkpfBl54VlqmU8oqsc3wrRrXY3mU
         sMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685083142; x=1687675142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO8WcUZImZYEcXMmvb5XeqF4flNwtTh70ks9aqSmaXk=;
        b=TpOmYaBFRNM6mt82xYCL5gXapqSL0OC2W+oTXcCh+Io0R2h3D5zJMNE2RBRgcBAZi8
         DcrcdZLU7x1Yk+oj/C+qhyf0RahozEOmuvvrLa4wsL7C7Vok9xW67NU1NEWOV0rZIJYR
         x7oub0MIXzXZ/ssRsqEQHjLDddn0RjDkjsY2NSUPePWtWBGX7gQDvxDf1c5FqQvXVABL
         7ChiWh/SNYyYApeZdJHawlNv56OeauTgOYcfK6EiDlXdGns/slrBfmdpOMsleZzYRtHU
         ZXUfkr2oobjoSCHWBZFVpJpAsWPpNHuPHNZRkrzlXgEH6A7LBowYyCggd5a2DMvYEybh
         Yv1A==
X-Gm-Message-State: AC+VfDzQmUlM3s2ajIVSc/v+eZd8HZiPdniwTIfj7DFIn6ddSFqja8oU
        7re3CMrRKnEWhyphGrnET461npEfAZdNDkk1hgsexEnZJws=
X-Google-Smtp-Source: ACHHUZ5UoldH91dZI3YzbotUTq6j2XG/Af7GeLCC3BUtAVi76GKznZCJxzzD1sru2vfAwM4zUtc0PICptIDgFXeKA60=
X-Received: by 2002:a05:6512:14f:b0:4f3:3eeb:20dc with SMTP id
 m15-20020a056512014f00b004f33eeb20dcmr206839lfo.16.1685083142008; Thu, 25 May
 2023 23:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <1684919574-28368-1-git-send-email-zhaoyang.huang@unisoc.com> <20230525135407.GA31865@cmpxchg.org>
In-Reply-To: <20230525135407.GA31865@cmpxchg.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 26 May 2023 14:38:38 +0800
Message-ID: <CAGWkznE0bNS6bZE99s1PkWdC9UkTQCC0aWo0pS94n8_nkQv7Rg@mail.gmail.com>
Subject: Re: [PATCH] mm: deduct the number of pages reclaimed by madvise from workingset
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
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

On Thu, May 25, 2023 at 9:54=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, May 24, 2023 at 05:12:54PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The pages reclaimed by madvise_pageout are made of inactive and dropped=
 from LRU
> > forcefully, which lead to the coming up refault pages possess a large r=
efault
> > distance than it should be. These could affect the accuracy of thrashin=
g when
> > madvise_pageout is used as a common way of memory reclaiming as ANDROID=
 does now.
>
> This alludes to, but doesn't explain, a real world usecase.
More block io(wait_on_page_bit_common) observed during APP start in
latest android version where user space memory reclaiming changes from
in-kernel PPR to madvise_pageout. We believe that it could be related
with inaccuracy of workingset.
>
> Yes, madvise_pageout() will record non-resident entries today. This
> means refault and thrash detection is on for user-driven reclaim.
>
> So why is that undesirable?
Let's raise an extreme scenario, that is, the tail page of LRU could
experience a given refault distance without any in-kernel reclaiming
and be wrongly deemed as inactive and get less protection.
>
> Today we measure and report the cost of reclaim and memory pressure
> for physical memory shortages, cgroup limits, and user-driven cgroup
> reclaim. Why should we not do the same for madv_pageout()? If the
> userspace code that drives pageout has a bug and the result is extreme
> thrashing, wouldn't you want to know that?
Actually, the pages evicted by madv_cold/pageout from active_lru are
not marked as WORKINGSET, which will surpass the thrashing account
when it faults back and gets struck by IO. I think they should be
treated in the same way in terms of SetPageWorkingset and
lruvec->non-resident. Please refer to my previous patch "mm: mark
folio as workingset in lru_deactivate_fn index 70e2063..4d1c14f
100644"


>
> Please explain the idea here better.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/swap.h | 2 +-
> >  mm/madvise.c         | 4 ++--
> >  mm/vmscan.c          | 8 +++++++-
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2787b84..0312142 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -428,7 +428,7 @@ extern unsigned long mem_cgroup_shrink_node(struct =
mem_cgroup *mem,
> >  extern int vm_swappiness;
> >  long remove_mapping(struct address_space *mapping, struct folio *folio=
);
> >
> > -extern unsigned long reclaim_pages(struct list_head *page_list);
> > +extern unsigned long reclaim_pages(struct mm_struct *mm, struct list_h=
ead *page_list);
> >  #ifdef CONFIG_NUMA
> >  extern int node_reclaim_mode;
> >  extern int sysctl_min_unmapped_ratio;
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index b6ea204..61c8d7b 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -420,7 +420,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >  huge_unlock:
> >               spin_unlock(ptl);
> >               if (pageout)
> > -                     reclaim_pages(&page_list);
> > +                     reclaim_pages(mm, &page_list);
> >               return 0;
> >       }
> >
> > @@ -516,7 +516,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
> >       arch_leave_lazy_mmu_mode();
> >       pte_unmap_unlock(orig_pte, ptl);
> >       if (pageout)
> > -             reclaim_pages(&page_list);
> > +             reclaim_pages(mm, &page_list);
> >       cond_resched();
> >
> >       return 0;
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 20facec..048c10b 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2741,12 +2741,14 @@ static unsigned int reclaim_folio_list(struct l=
ist_head *folio_list,
> >       return nr_reclaimed;
> >  }
> >
> > -unsigned long reclaim_pages(struct list_head *folio_list)
> > +unsigned long reclaim_pages(struct mm_struct *mm, struct list_head *fo=
lio_list)
> >  {
> >       int nid;
> >       unsigned int nr_reclaimed =3D 0;
> >       LIST_HEAD(node_folio_list);
> >       unsigned int noreclaim_flag;
> > +     struct lruvec *lruvec;
> > +     struct mem_cgroup *memcg =3D get_mem_cgroup_from_mm(mm);
> >
> >       if (list_empty(folio_list))
> >               return nr_reclaimed;
> > @@ -2764,10 +2766,14 @@ unsigned long reclaim_pages(struct list_head *f=
olio_list)
> >               }
> >
> >               nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NO=
DE_DATA(nid));
> > +             lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > +             workingset_age_nonresident(lruvec, -nr_reclaimed);
> >               nid =3D folio_nid(lru_to_folio(folio_list));
> >       } while (!list_empty(folio_list));
> >
> >       nr_reclaimed +=3D reclaim_folio_list(&node_folio_list, NODE_DATA(=
nid));
> > +     lruvec =3D &memcg->nodeinfo[nid]->lruvec;
> > +     workingset_age_nonresident(lruvec, -nr_reclaimed);
>
> The task might have moved cgroups in between, who knows what kind of
> artifacts it will introduce if you wind back the wrong clock.
>
> If there are reclaim passes that shouldn't participate in non-resident
> tracking, that should be plumbed through the stack to __remove_mapping
> (which already has that bool reclaimed param to not record entries).
