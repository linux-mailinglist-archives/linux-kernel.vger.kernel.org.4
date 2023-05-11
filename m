Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0135D6FEB75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237012AbjEKGAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjEKGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:00:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C786448C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:59:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f13d8f74abso9183693e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683784796; x=1686376796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob7GWlTRgvWZ3pXLoalNHIlZFx5sCzWHAfObxgHzBLQ=;
        b=MbC0YPcN712jWen4x7kIlMBrUhrF/5Bld1BpEG7CIHbc3v9862gjnS2MCI88PXb4CF
         +050yeVT4cYIzsHmHTxcAuvfX6vwc9PEKFSgelcA4PIOSM/mbnAsiToFRR59w6Jm5msQ
         O/G9qRptHQJxOU1m/2FaF7PsVZGCSNViLl7qxgtyDBOcnqX+PT0GUqFzzMpNmksRvEIj
         E2LqH2IbIdFyYrAhIK5DzAEJFairEY9LtWc497htip4V//8D9GuxWogiZL2utN5jE/+S
         uJFvvA6vHAPScdNkOxbT9QOx02FX1WyvoyYdCJ6KGHBcfDo9NxA1nJ+o7s9FWWz21s0X
         AzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784796; x=1686376796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ob7GWlTRgvWZ3pXLoalNHIlZFx5sCzWHAfObxgHzBLQ=;
        b=YQXV2B6lm5bZ2lgcJsHJME8Hh7XT66BW44HDS1W+nzSuGLUnncsPw+503m9uGKa462
         ghMqICrEQLv0cBf29SABZgSeblPCAHniCgqBrfqxfcCKFB31Gzt7qUSxQ+SRaV4MxpXd
         UJ1CEK4Y37Vwj0SCrycPpOczEe5JOz+nlHiclgfZotIWK+msltja8s8vhECRdsiPByiP
         jDb/C4ds2nBYPDnRkhwkAt4+i1dwB0/AKU8/vtJKQNSZM67LyQiQ3vpa3SXl9Wt1BSoG
         yIH4MlMaRx6ubaJHnSUNjaAa+JTKmQCTsoBZmGsyFXX7tJsDA7huQYnrCN9v/KCLAzv9
         s6tQ==
X-Gm-Message-State: AC+VfDwWsuPkYdJPOSHthLtnoKBP6xWFSBpyRSR0oQj20yA6ansYJAhd
        /pgl6Rx2PMbqIcPh32S45N8V2RO1HFtkEf/aG0w=
X-Google-Smtp-Source: ACHHUZ6xNLZsaDCyh/KMjbZbeY+ZkovihJ5HXWgKfX+Sd+1H5LyClJymrRQw81Rs8x4JTtW0xmfkrnOX0fVC+GbYHYE=
X-Received: by 2002:ac2:42d1:0:b0:4e8:c5d:42a5 with SMTP id
 n17-20020ac242d1000000b004e80c5d42a5mr2358825lfl.24.1683784796346; Wed, 10
 May 2023 22:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <1683538383-19685-1-git-send-email-zhaoyang.huang@unisoc.com> <1683538383-19685-3-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1683538383-19685-3-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 11 May 2023 13:59:33 +0800
Message-ID: <CAGWkznEdrbenvczHcQbv94jOprg7OBEHmsgBtm4knZ7mRJvdLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: skip CMA pages when they are not available
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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

+Matthew Wilcox

On Mon, May 8, 2023 at 5:35=E2=80=AFPM zhaoyang.huang <zhaoyang.huang@uniso=
c.com> wrote:
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
> rmqueue.
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
