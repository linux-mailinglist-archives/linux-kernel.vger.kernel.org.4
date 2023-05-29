Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76663714194
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjE2BLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2BLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:11:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA87BB
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:11:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f37b860173so3141531e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685322694; x=1687914694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbRrYi5TvzfCqwcd+5rj5+lqfD5GauoLA2aWgDDS7KE=;
        b=C5pfUWAAL9Si6PymI4IeVtaju3lzI5dx4mz5BSNfbTtDaygqglBZcVw1vhI5p4ovKx
         T+2q/agVUhPApjzE7rg03ZMyiSEIJnHJFPNzxtRuvzib6pSxmyz9CYNAEtAKGRBzHmwr
         pOL27ap7v9e95KADXWUyJbWHytRol2IFhPOV5rqPhOZ0Mn935feBWVhkCC0nNU2MzXBk
         09fBI01fn7Quq1QTXZb2/fByuNN+DFl77QtAHI6EDFCKrUDriStDZROUh7o2HtU9Ie52
         64wxvWSm7QueGeRoCTproAlQB+PFn+a7OTmdMkOqgDDgqM/VGa1Pc208r0l0hh5K5sFW
         5reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685322694; x=1687914694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbRrYi5TvzfCqwcd+5rj5+lqfD5GauoLA2aWgDDS7KE=;
        b=D6r+dCqLD872RjfG7mkP63/nGlCsIJdyIc5pZL8H84MQCq4NfsBuEPLOr98xQjnZls
         ZZIk7QJtuw0qWJiBHBeDmrRyWU/2jBvJPPTGaKQRpi7dn3Nylgw59GfbYi5nBbvBffH5
         5S0IhRc1koceJAV9vllZlKrGvMhzJiIVTGllOABkyTv42utTaggCjnPq+DSNPJw9Snoe
         8s4DQRMXUT4xn2KZaKYKispzXnP2lQmCPy+Hrta3Mg25nLUm9+NSN9HsCbR2rNMj1Bl+
         JLlxvm7+cPKPmAlSJth1AqzO+FUzS74qcs3u8uUGopPRvcXLjhpd0aOjDNNeyPFIFxQY
         DUMQ==
X-Gm-Message-State: AC+VfDydoKP0K5AKodZ7ZB3kDisD2HgyVX47zRpa7cqGlwBHRfE+Qkvs
        Pizt+jhjUvH9ECpeeFT3OgXNARL5FSyjMh3hMb4=
X-Google-Smtp-Source: ACHHUZ6ewhQejH1JLeicLqTrxnr9b0G5tADXf3v3nrJL8pnC6kkouQjqBTeyzDpkMJqydnkwQ+3DaQzubuzg9w+VUTI=
X-Received: by 2002:ac2:5297:0:b0:4f0:1076:2682 with SMTP id
 q23-20020ac25297000000b004f010762682mr2770867lfm.42.1685322694030; Sun, 28
 May 2023 18:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com> <ZHE6uTZOVuYayet2@google.com>
In-Reply-To: <ZHE6uTZOVuYayet2@google.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 29 May 2023 09:11:10 +0800
Message-ID: <CAGWkznG-3q96cSe0rq-FCqkdfQ43CUDXYP6Eh-DvdxEJX8KAyA@mail.gmail.com>
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
To:     Minchan Kim <minchan@kernel.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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

On Sat, May 27, 2023 at 7:03=E2=80=AFAM Minchan Kim <minchan@kernel.org> wr=
ote:
>
> On Mon, May 22, 2023 at 02:36:03PM +0800, zhaoyang.huang wrote:
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
> >  mm/vmscan.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index bd6637f..20facec 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2193,6 +2193,26 @@ static __always_inline void update_lru_sizes(str=
uct lruvec *lruvec,
> >
> >  }
> >
> > +#ifdef CONFIG_CMA
> > +/*
> > + * It is waste of effort to scan and reclaim CMA pages if it is not av=
ailable
> > + * for current allocation context
> > + */
> > +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> > +{
> > +     if (!current_is_kswapd() &&
>
> The function is called by isolate_lru_folios which is used by both backgr=
ound
> and direct reclaims at the same time. And sc->reclaim_idx below to filter
> unproductive reclaim out is used for both cases but why does the cma is c=
onsidering
> only direct reclaim path?
Because kswapd's sc->gfp_mask =3D GFP_KERNEL which can not distinguish
this scenario
>
>
> > +                     gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABL=
E &&
> > +                     get_pageblock_migratetype(&folio->page) =3D=3D MI=
GRATE_CMA)
> > +             return true;
> > +     return false;
> > +}
> > +#else
> > +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> >  /*
> >   * Isolating page from the lruvec to fill in @dst list by nr_to_scan t=
imes.
> >   *
> > @@ -2239,7 +2259,8 @@ static unsigned long isolate_lru_folios(unsigned =
long nr_to_scan,
> >               nr_pages =3D folio_nr_pages(folio);
> >               total_scan +=3D nr_pages;
> >
> > -             if (folio_zonenum(folio) > sc->reclaim_idx) {
> > +             if (folio_zonenum(folio) > sc->reclaim_idx ||
> > +                             skip_cma(folio, sc)) {
> >                       nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >                       move_to =3D &folios_skipped;
> >                       goto move;
> > --
> > 1.9.1
> >
