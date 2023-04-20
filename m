Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963956E8D64
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjDTJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbjDTI7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:59:47 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00DC4C1F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:56:06 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id l15so1940979ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 01:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681980963; x=1684572963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDoRV5tcV4ZLbo8bWLcQ8xGavuIx9pc5Dsyn6+Jg8jU=;
        b=Z9Au6FhL2zZcCfxk3Vg49XyZaJhsV+1G6HIC1zZ6IXs5r9e8qePR4i4vUBD5nWSR3x
         wtflzNMT2axG6I+DhEBb+ca3Wkn1CwQQFINDeXmvcnLZ/Yxpr+PWRbruJ6bXipij6Xj7
         /XLYETFSUpYxKt6/1YfjnAuq8HfaN9nILBy3BIddpubClCiQahXXsGKouIuMVbSE+krZ
         7NOnqSNCfkuVGFR3CwG4gB7GyfT1euYaa5X+Bfy6WZ1PYUh2RqI0s6Nzg/uatkO3VsfK
         oOW/JhhBpp9T3WJPGTtH80AVpnkGeselgRIci254i1RRDLj3qicDwGEt6M9BYq97nYBk
         r30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681980963; x=1684572963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDoRV5tcV4ZLbo8bWLcQ8xGavuIx9pc5Dsyn6+Jg8jU=;
        b=Kg6/6nuUJPFTeyWkJIGiv+NbPkJLjSIDYlDaS5g4FIC+aQuIGI0M2fSaiEM1nFR3pi
         zuDLKX9pfH2ljrhRR8UFnEiOhnBX3d+XyEVN+MniwkZ+0oWGqCnTrQ0rHnsLsCDWR+/3
         EQBDHxcFroVi1VGesfkQdnMyZc9ipFfHWmOLTqmfhP1qWi8/exb3Sm2mwVX8Z9zpEiOA
         qmb+8ilaOgskwLQs+Qtx2L/sM0Ugc+DKfaW0alVPTmkdgveRsLUArd/h96/Z/hks1RPi
         LziuiLrwZXAtzjXHhJ2CpIwAzT4dOSVatvJurBwieoCS5SEiDGEuaY/iG+VBlpH+AxAn
         qc7g==
X-Gm-Message-State: AAQBX9cGM/9rbV+v1U3yi8I68TOzm2BNZ+HwozmtU/SYz/YdI5R4n55e
        fWQid5i0hg8SohEt4EgSFaDypZF8fQiqm/M1vwD4rRYq
X-Google-Smtp-Source: AKy350Y592dYlVHKp5FQfJ0AtiEMF9NldYZPYTj5qdStROYO2WVptcRlnvulWQNPF0lTh87Xg2gvJRog6FD0xAuddDA=
X-Received: by 2002:a2e:721a:0:b0:2a8:c513:7577 with SMTP id
 n26-20020a2e721a000000b002a8c5137577mr182705ljc.51.1681980963361; Thu, 20 Apr
 2023 01:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1681979577-11360-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 20 Apr 2023 16:55:41 +0800
Message-ID: <CAGWkznGBEi8q5v_xE2K2p0+JOPo2JV_nvB-_0K3Sy6B2sTaJXA@mail.gmail.com>
Subject: Re: [PATCHv2] mm: skip CMA pages when they are not available
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

This patch could be more helpful when large cma reserved areas reside
in a single zone(etc. 500MB among a 2GB zone), where a lot of CMA
pages spread in LRU allocated by fallback of GFP_MOVABLE allocation.

On Thu, Apr 20, 2023 at 4:33=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> This patch fixes unproductive reclaiming of CMA pages by skipping them wh=
en they
> are not available for current context. It is arise from bellowing OOM iss=
ue, which
> caused by large proportion of MIGRATE_CMA pages among free pages. There h=
as been
> commit(168676649) to fix it by trying CMA pages first instead of fallback=
 in
> rmqueue. I would like to propose another one from reclaiming perspective.
>
> 04166 < 4> [   36.172486] [03-19 10:05:52.172] ActivityManager: page allo=
cation failure: order:0, mode:0xc00(GFP_NOIO), nodemask=3D(null),cpuset=3Df=
oreground,mems_allowed=3D0
> 0419C < 4> [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 2=
17*16kB (C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C)=
 0*1024kB 0*2048kB 0*4096kB =3D 35848kB
> 0419D < 4> [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*=
8kB (MEH) 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H=
) 0*1024kB 0*2048kB 0*4096kB =3D 3236kB
>         ......
> 041EA < 4> [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate m=
emory on node -1, gfp=3D0xa20(GFP_ATOMIC)
> 041EB < 4> [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object=
 size: 64, buffer size: 64, default order: 0, min order: 0
> 041EC < 4> [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 33=
92, free: 0
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: update commit message and fix build error when CONFIG_CMA is not set
> ---
> ---
>  mm/vmscan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd6637f..19fb445 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2225,10 +2225,16 @@ static unsigned long isolate_lru_folios(unsigned =
long nr_to_scan,
>         unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
>         unsigned long skipped =3D 0;
>         unsigned long scan, total_scan, nr_pages;
> +       bool cma_cap =3D true;
> +       struct page *page;
>         LIST_HEAD(folios_skipped);
>
>         total_scan =3D 0;
>         scan =3D 0;
> +       if ((IS_ENABLED(CONFIG_CMA)) && !current_is_kswapd()
> +               && (gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE))
> +               cma_cap =3D false;
> +
>         while (scan < nr_to_scan && !list_empty(src)) {
>                 struct list_head *move_to =3D src;
>                 struct folio *folio;
> @@ -2239,12 +2245,17 @@ static unsigned long isolate_lru_folios(unsigned =
long nr_to_scan,
>                 nr_pages =3D folio_nr_pages(folio);
>                 total_scan +=3D nr_pages;
>
> -               if (folio_zonenum(folio) > sc->reclaim_idx) {
> +               page =3D &folio->page;
> +
> +               if ((folio_zonenum(folio) > sc->reclaim_idx)
> +#ifdef CONFIG_CMA
> +                       || (get_pageblock_migratetype(page) =3D=3D MIGRAT=
E_CMA && !cma_cap)
> +#endif
> +               ) {
>                         nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
>                         move_to =3D &folios_skipped;
>                         goto move;
>                 }
> -
>                 /*
>                  * Do not count skipped folios because that makes the fun=
ction
>                  * return with no isolated folios if the LRU mostly conta=
ins
> --
> 1.9.1
>
