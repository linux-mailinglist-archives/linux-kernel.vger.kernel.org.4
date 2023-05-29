Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D655B714171
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjE2BCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2BCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:02:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14380BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:02:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f4f757d575so1311605e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685322166; x=1687914166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAOt4oPartPpVs7vXsp6wFuAa9Ek5s4xyJ3hrSVbVOU=;
        b=rVTEkTtnG+GrdW1F+fDgHzrXaUR1GaSlS6ciAD57OSTWwfNzbO8LU0jRTg3tnBFlYc
         JEpIHdHD92XFqWlEkmD6jNPNuWfbmtKAZ8IvVQGp6AS57kdNzyvkOsDCg2irWyiIq3Pj
         fO6LHc7f0I9srhYAObHirfVX/NiQqrKBRO6+cgTAhde1Yz2+SjiLHpBv+dyC3Tm+u2TQ
         TVMTH1P6DrtEFwz8Kg2bzjSRVLzOgrzNGch7+A3kyhqWMKsASa3k0TlHU5COLR2cKxk7
         iA71B5+JNBqHDE2jH/FxczTxejr5AR6ILvIRfC9NSDrdw+jLPgh3g2xFXCT2MzHri0kG
         c2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685322166; x=1687914166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAOt4oPartPpVs7vXsp6wFuAa9Ek5s4xyJ3hrSVbVOU=;
        b=Iq7EgfwRNAF0h00Q5ruQY2420qFs6OVBzkhv55DnvFlUAa2vCdEdbEpyJ5UazueGVd
         h42imKGcgBpXdEbHqQwYX4DexRh058kad78E7qM/zAYk2VvE8X1Kyi32haS0v7LSOLQE
         gamiDgLeAZspN0iX0AY2bhHZYhaXnYUVZQFU5H6hZa+qjog02JY921zGd7WBzYIaySWU
         DDAs5HYBvMCKxns+3AXOUxdYkdIDRr23SH8fZRNsqpfcEIihWIHYxZWzCO7WAUThEs8e
         gKW3iM5GLTEk+bWrQZINvShDTHVWqfUpkGswywct8OG0QaZlt0tt66MiPf7zp9ZhiFmB
         wk8w==
X-Gm-Message-State: AC+VfDxkkeV3BXAD95w/5vMhgGDu2McCSUEXSge2xQrfzAHLJg/Cxtop
        Mnajqq9p3k46+DVOoAHetkrd0/cW18nl6cGG4Ysyfhzz
X-Google-Smtp-Source: ACHHUZ51+MI8VdUitklbGDRvhdM0M9Kgj0kEd8qnZI+fpI1g3YEiJzoT/ShqA8Bj9VXiy2w6GGri4ILmDEQWDe3DAUc=
X-Received: by 2002:ac2:4c0b:0:b0:4f1:2ebf:536f with SMTP id
 t11-20020ac24c0b000000b004f12ebf536fmr2463186lfq.16.1685322166039; Sun, 28
 May 2023 18:02:46 -0700 (PDT)
MIME-Version: 1.0
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com> <c1bd0983-219d-e279-2630-c38329e59140@redhat.com>
In-Reply-To: <c1bd0983-219d-e279-2630-c38329e59140@redhat.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 29 May 2023 09:02:22 +0800
Message-ID: <CAGWkznFDdycWy-637hfkg-Vj=tur-BUts-cpXTQdckZ2UxKLhg@mail.gmail.com>
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Sat, May 27, 2023 at 3:36=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 22.05.23 08:36, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > This patch fixes unproductive reclaiming of CMA pages by skipping them =
when they
> > are not available for current context. It is arise from bellowing OOM i=
ssue, which
> > caused by large proportion of MIGRATE_CMA pages among free pages.
> >
> > [   36.172486] [03-19 10:05:52.172] ActivityManager: page allocation fa=
ilure: order:0, mode:0xc00(GFP_NOIO), nodemask=3D(null),cpuset=3Dforeground=
,mems_allowed=3D0
> > [   36.189447] [03-19 10:05:52.189] DMA32: 0*4kB 447*8kB (C) 217*16kB (=
C) 124*32kB (C) 136*64kB (C) 70*128kB (C) 22*256kB (C) 3*512kB (C) 0*1024kB=
 0*2048kB 0*4096kB =3D 35848kB
> > [   36.193125] [03-19 10:05:52.193] Normal: 231*4kB (UMEH) 49*8kB (MEH)=
 14*16kB (H) 13*32kB (H) 8*64kB (H) 2*128kB (H) 0*256kB 1*512kB (H) 0*1024k=
B 0*2048kB 0*4096kB =3D 3236kB
> > ...
> > [   36.234447] [03-19 10:05:52.234] SLUB: Unable to allocate memory on =
node -1, gfp=3D0xa20(GFP_ATOMIC)
> > [   36.234455] [03-19 10:05:52.234] cache: ext4_io_end, object size: 64=
, buffer size: 64, default order: 0, min order: 0
> > [   36.234459] [03-19 10:05:52.234] node 0: slabs: 53,objs: 3392, free:=
 0
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> > v2: update commit message and fix build error when CONFIG_CMA is not se=
t
> > v3,v4: update code and comments
> > ---
> > ---
> >   mm/vmscan.c | 23 ++++++++++++++++++++++-
> >   1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bd6637f..20facec 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2193,6 +2193,26 @@ static __always_inline void update_lru_sizes(str=
uct lruvec *lruvec,
> >
> >   }
> >
> > +#ifdef CONFIG_CMA
> > +/*
> > + * It is waste of effort to scan and reclaim CMA pages if it is not av=
ailable
> > + * for current allocation context
> > + */
>
> /*
>   * Only movable allocations may end up on MIGRATE_CMA pageblocks. If
>   * we're not dealing with a movable allocation, it doesn't make sense to
>   * reclaim from these pageblocks: the reclaimed memory is unusable for
>   * this allocation.
>   */
>
> Did I get it right?
Yes, it is right.
>
> > +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> > +{
> > +     if (!current_is_kswapd() &&
> > +                     gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABL=
E &&
> > +                     get_pageblock_migratetype(&folio->page) =3D=3D MI=
GRATE_CMA)
> > +             return true;
> > +     return false;
>
>         return !current_is_kswapd() &&
>                gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE &&
>                get_pageblock_migratetype(&folio->page) =3D=3D MIGRATE_CMA=
;
ok, thanks
>
>
> --
> Thanks,
>
> David / dhildenb
>
