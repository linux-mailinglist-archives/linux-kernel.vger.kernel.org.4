Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBE56E7386
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDSGw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjDSGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:52:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A193B55BE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:52:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a10so16362815ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681887168; x=1684479168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYgO2qxPOOmxEYT1A6CGSiRDNU0p1E1acMevYr1zcBg=;
        b=UpgJHSVFaB78lC7zhT1pQ4EDjU0oRHZaCw1y/byZY/Xd2OmeUX8++qwnQm39W8/gzB
         Z0LknLeQtyhuOJDHD058YuSvBBRi52v8r7zyFjeRYHSxlUEQUqQvY2n1hJFJhkZG2rek
         5Hmq42C76Q7ZWrifgtqf1HDzk6ncUkPrmLSwHiHRR10a9s92C9AaFJK/jCFapMILKQTY
         mlkeRqOFaV8mHW3LjpGouJaHJNA4iZKzf8RnVw8wXDdROi43dbHrS5nrAQ2mVNAN7Sn4
         XSFR1m3TxgkmdbEaWkuy4le5l20gw4wAsvVXjIwZOtdMO9FXDwU6KW4bfcMuReZM5S96
         hGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681887168; x=1684479168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYgO2qxPOOmxEYT1A6CGSiRDNU0p1E1acMevYr1zcBg=;
        b=afp/7Bp4mnDG7OhvJqF/MDAAukAobriUVMuU/0mGiapIdKwMLE0yypeHjL5Wab/Ujg
         WKRuaGTNCkmGnnIi8LP0v5PclV7/AP4GSg67AgPgwe4EHLCYwiHHl146ajI2AIYakwji
         boHTXZQmxIFscTfuGQT2bdGjDlx8wvdchpLA9rOdLxUprUZtsTgoQyBL2nPGrrC4psaU
         H3mU6JucdYpg8lQ3CWFx81LFk8VIQPEXSeI4MdxBFrN697+FpCTtRP9L2iwjDvCAfPCG
         cABBCLv2aE0wbytts+FkJKcvQKGYr8DFv0lWTy0O5w3CHafMvFkkjTEn/t7mD6NgNkPr
         IaKw==
X-Gm-Message-State: AAQBX9d/xw/HzB1VSirTPURNbDDdtdfJNR+BqpFszdZe14gAGOaag7VT
        h8irygFCXPP4HPnA/N/RIUk4AHFYODezJFM9yjO44iiH5Gk=
X-Google-Smtp-Source: AKy350Z63Q73FBkxmsGhsu7wFmJXYeWQ/E8UAk5YJJ84OmTZMwSzx6CiDFA8VURtd+xfPoUfpXwX3srnTbddTqFRWbo=
X-Received: by 2002:a2e:91c8:0:b0:2a8:bca1:bfa6 with SMTP id
 u8-20020a2e91c8000000b002a8bca1bfa6mr1763135ljg.24.1681887167607; Tue, 18 Apr
 2023 23:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <1681882824-17532-1-git-send-email-zhaoyang.huang@unisoc.com> <87pm80tnhu.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87pm80tnhu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 19 Apr 2023 14:52:25 +0800
Message-ID: <CAGWkznFbQARfoDpdUXbR6BOO9TU_-pkHtm7Q9M0x2=4KWcAqpg@mail.gmail.com>
Subject: Re: [PATCH] mm: skip CMA pages when they are not available
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

On Wed, Apr 19, 2023 at 2:07=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> "zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > It is wasting of effort to reclaim CMA pages if they are not availabe
> > for current context during direct reclaim. Skip them when under corresp=
onding
> > circumstance.
>
> Do you have any performance number for this change?
Sorry, No. This patch arised from bellowing OOM issue which is caused
by MIGRATE_CMA occupying almost 100 percent of zones free pages and
solved by "168676649 mm,page_alloc,cma: conditionally prefer cma
pageblocks for movable allocations". This could be a common scenario
for a zone that has a large proportion of CMA reserved page blocks
which need to be considered in both allocation and reclaiming
perspective.

04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page
allocation failure: order:0, mode:0xc00(GFP_NOIO),
nodemask=3D(null),cpuset=3Dforeground,mems_allowed=3D0
0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB
(C) 217*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C)
3*512kB (C) 0*1024kB 0*2048kB 0*4096kB =3D 35848kB
0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH)
49*8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB
1*512kB (H) 0*1024kB 0*2048kB 0*4096kB =3D 3236kB
......
041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to
allocate memory on node -1, gfp=3D0xa20(GFP_ATOMIC)
041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end,
object size: 64, buffer size: 64, default order: 0, min order: 0
041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,
objs: 3392, free: 0
>
> Best Regards,
> Huang, Ying
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/vmscan.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bd6637f..04424d9 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >       unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
> >       unsigned long skipped =3D 0;
> >       unsigned long scan, total_scan, nr_pages;
> > +     bool cma_cap =3D true;
> > +     struct page *page;
> >       LIST_HEAD(folios_skipped);
> >
> >       total_scan =3D 0;
> >       scan =3D 0;
> > +     if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> > +             && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE))
> > +             cma_cap =3D false;
> > +
> >       while (scan < nr_to_scan && !list_empty(src)) {
> >               struct list_head *move_to =3D src;
> >               struct folio *folio;
> > @@ -2239,7 +2245,10 @@ static unsigned long isolate_lru_folios(unsigned=
 long nr_to_scan,
> >               nr_pages =3D folio_nr_pages(folio);
> >               total_scan +=3D nr_pages;
> >
> > -             if (folio_zonenum(folio) > sc->reclaim_idx) {
> > +             page =3D &folio->page;
> > +
> > +             if (folio_zonenum(folio) > sc->reclaim_idx ||
> > +                     (get_pageblock_migratetype(page) =3D=3D MIGRATE_C=
MA && !cma_cap)) {
> >                       nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >                       move_to =3D &folios_skipped;
> >                       goto move;
