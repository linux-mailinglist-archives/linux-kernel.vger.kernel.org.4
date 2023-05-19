Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8E7091D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjESImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjESImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:42:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC07E7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:42:06 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so3601000e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684485725; x=1687077725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5255kXpZcvDfSbdEjjfj0wDzDYeZl9Iyd3E1JVL9e4M=;
        b=NNKcIZCOcfAL1PGgsRH7yRmuawCJbPolKfHcrOE8wSVubVMg/Wl03r6qGzKy32w2gL
         wlSJ3He2N5zgBzzw6KLTKxZqI+huyCi/7kf3eBCG/t2995mw8urZlF7SL2lTIgy+yW/9
         08+AZajAipppqJSfXjE+Jj6355rU/DoWHUOkmZ+UJml/6nIxK3wxY4wI6PKABEpfakS2
         BLfYfpF/ZvB9gVgNbmXGtih/oTexIVNDKLfTvNK1JIFyX1HII9xK0CQai04SlX8EuiWF
         uiC3sNmfdf4j77T5tFLxuc4iY7RuPbLX9bT/dPRNufj8IBzYPvtruE6jZgezqWTOMfoT
         g09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485725; x=1687077725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5255kXpZcvDfSbdEjjfj0wDzDYeZl9Iyd3E1JVL9e4M=;
        b=jpmNRpSx1M05YgSyW/iUHce0LZi37F+ZUoT1R0jJs7FaOkCCsHL56/dMeF/Q0tZN2K
         o8pdI50ZdwohsF0QqgRHKycZxTmM+dxrbTI6j/OQ9I0QhVv/WZRCsWqkVX503H6A7Rxk
         /G2IRtTuQFT5/Xf24MsOszSgevIYn/84mMHgnryGKjh9HaW42LoggKYICDpFcl7Bl8sw
         IVMjLyj3tLqvlLtohOf4yqsKz+yMOKxj79GJXIQFr0vVbu7cEqXqghc24HYPCVAQ06SI
         FbJTjdmBPyvo5rH59WkgQ1xzdJHHqqukUGosxFa7aZvmQ9VAe2211VkZIOxhloOpJOHG
         0yrg==
X-Gm-Message-State: AC+VfDx9DMfWunNFu9mD//3BnV0+4CBivltBssEmMZPYelFd1WXON1sb
        YRCAhx+5GfxfvNaw9b73M/AQpZqHKMdXMCN5GIc=
X-Google-Smtp-Source: ACHHUZ7MDVMgzAyPCUOAhics8HdICRUpTwMecIekZUumpEfCWXG5H/yhNcDNfxhjdaOZwmtG3bz/f+7DQsU/3xURbc4=
X-Received: by 2002:ac2:4c8a:0:b0:4f3:78e5:fe93 with SMTP id
 d10-20020ac24c8a000000b004f378e5fe93mr629179lfl.6.1684485724534; Fri, 19 May
 2023 01:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <1684143495-12872-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1684143495-12872-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 19 May 2023 16:41:41 +0800
Message-ID: <CAGWkznFVeCYUCXg4JZ78pjXp9gBUWAUzyGntVT+kkPRydxmS6A@mail.gmail.com>
Subject: Re: [Resend PATCHv2] mm: skip CMA pages when they are not available
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
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

any comments?

On Mon, May 15, 2023 at 5:40=E2=80=AFPM zhaoyang.huang
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
