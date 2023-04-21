Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A66EA681
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjDUJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDUJFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:05:40 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529FB902D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682067938; x=1713603938;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=ZJoYa/AXWIJW8/H4efRh+74qEMHSA59/EWCE4cBJ92I=;
  b=dLyiXhpo/MuepBFjrW74bmCKkgLN6lJLUalKmYP/gfAYj8BTju7jYc27
   V4WxMl1qidaNfGEqMHn4TnG6vTu2shwPAjznD7JDnK+SR9iMF1hZ2jGjk
   gCn5vyd5D83F1VIyDLfBVOvDitvgykEVlSTef7nl6TdHTdWCJNoS4fGnw
   PxbX/B0QiZpF6Q+RCwXTyPmED8T6jJtIOE+lKc1a91S1C5q7m4hax7VEq
   8kRCxg/LkLlbOkCADPzH4QrG+HoW+Bu9FRwg7FaD6PfP9eHClvbekuhr9
   4JjmwTd+3tmY4ty92pC2DDXbD+/5ogjlJUEv74Us7EFDCi22GWypfBQzN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="334826280"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="334826280"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="816355993"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="816355993"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 02:05:36 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv2] mm: skip CMA pages when they are not available
References: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
        <87v8hpspge.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAGWkznEt1mNWwA0aVmyH=oVFdVw4TCZYH+BYgim=V4z+4=oVvw@mail.gmail.com>
Date:   Fri, 21 Apr 2023 17:02:12 +0800
In-Reply-To: <CAGWkznEt1mNWwA0aVmyH=oVFdVw4TCZYH+BYgim=V4z+4=oVvw@mail.gmail.com>
        (Zhaoyang Huang's message of "Fri, 21 Apr 2023 17:00:04 +0800")
Message-ID: <87mt31sj57.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhaoyang Huang <huangzhaoyang@gmail.com> writes:

> On Fri, Apr 21, 2023 at 2:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> "zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:
>>
>> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> >
>> > This patch fixes unproductive reclaiming of CMA pages by skipping them=
 when they
>> > are not available for current context. It is arise from bellowing OOM =
issue, which
>> > caused by large proportion of MIGRATE_CMA pages among free pages. Ther=
e has been
>> > commit(168676649) to fix it by trying CMA pages first instead of fallb=
ack in
>> > rmqueue. I would like to propose another one from reclaiming perspecti=
ve.
>> >
>> > 04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page a=
llocation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=3D(null),cpuset=
=3Dforeground,mems_allowed=3D0
>> > 0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C=
) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB =
(C) 0*1024kB 0*2048kB 0*4096kB =3D 35848kB
>> > 0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) =
49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB=
 (H) 0*1024kB 0*2048kB 0*4096kB =3D 3236kB
>> >       ......
>> > 041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocat=
e memory on node -1, gfp=3D0xa20(GFP_ATOMIC)
>> > 041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, obj=
ect size: 64, buffer size: 64, default order: 0, min order: 0
>> > 041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs:=
 3392, free: 0
>>
>> From the above description, you are trying to resolve an issue that has
>> been resolved already.  If so, why do we need your patch?  What is the
>> issue it try to resolve in current upstream kernel?
>
> Please consider this bellowing sequence as __perform_reclaim() return
> with reclaiming 32 CMA pages successfully and then lead to
> get_page_from_freelist failure if MIGRATE_CMA is NOT over 1/2 number
> of free pages which will then unreserve H pageblocks and drain percpu
> pageset. right? Furthermore, this could also introduce OOM as
> direct_reclaim is the final guard for alloc_pages.
>
> *did_some_progress =3D __perform_reclaim(gfp_mask, order, ac);
>
> retry:
> page =3D get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
>
> if (!page && !drained) {
> unreserve_highatomic_pageblock(ac, false);
> drain_all_pages(NULL);
> drained =3D true;
> goto retry;
> }

If you think OOM can be triggered, please try to reproduce it.

Best Regards,
Huang, Ying

> return page;
>>
>> At the first glance, I don't think your patch doesn't make sense.  But
>> you really need to show the value of the patch.
>>
>> Best Regards,
>> Huang, Ying
>>
>> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>> > ---
>> > v2: update commit message and fix build error when CONFIG_CMA is not s=
et
>> > ---
>> > ---
>> >  mm/vmscan.c | 15 +++++++++++++--
>> >  1 file changed, 13 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/mm/vmscan.c b/mm/vmscan.c
>> > index bd6637f..19fb445 100644
>> > --- a/mm/vmscan.c
>> > +++ b/mm/vmscan.c
>> > @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsign=
ed long nr_to_scan,
>> >       unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
>> >       unsigned long skipped =3D 0;
>> >       unsigned long scan, total_scan, nr_pages;
>> > +     bool cma_cap =3D true;
>> > +     struct page *page;
>> >       LIST_HEAD(folios_skipped);
>> >
>> >       total_scan =3D 0;
>> >       scan =3D 0;
>> > +     if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
>> > +             && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE))
>> > +             cma_cap =3D false;
>> > +
>> >       while (scan < nr_to_scan && !list_empty(src)) {
>> >               struct list_head *move_to =3D src;
>> >               struct folio *folio;
>> > @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsign=
ed long nr_to_scan,
>> >               nr_pages =3D folio_nr_pages(folio);
>> >               total_scan +=3D nr_pages;
>> >
>> > -             if (folio_zonenum(folio) > sc->reclaim_idx) {
>> > +             page =3D &folio->page;
>> > +
>> > +             if ((folio_zonenum(folio) > sc->reclaim_idx)
>> > +#ifdef CONFIG_CMA
>> > +                     || (get_pageblock_migratetype(page) =3D=3D MIGRA=
TE_CMA && !cma_cap)
>> > +#endif
>> > +             ) {
>> >                       nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>> >                       move_to =3D &folios_skipped;
>> >                       goto move;
>> >               }
>> > -
>> >               /*
>> >                * Do not count skipped folios because that makes the fu=
nction
>> >                * return with no isolated folios if the LRU mostly cont=
ains
