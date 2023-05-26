Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9F8711DF4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 04:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbjEZCat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 22:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZCas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 22:30:48 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2F9B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:30:46 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f380cd1019so182842e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685068245; x=1687660245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQLcHKq7/SFjER0eIjTkSMaREA3ODO65yBluaNQD8EA=;
        b=EZV208abTNd9TSPooerBLlxyXcfd+Opf8CGUyoSkfhfuFTEcGdyaRdfMrhYo2K2GvD
         x0T6VxwdOIYMlgY++qFCXSNFKdZO7xAlFqr3XxFGgdFy1hw3OxTf51cfsZsO51WaFX7B
         SvgShDqqKjd1jgsqMYoNv9hCdY3/P5z9ZlyRo5vRDh/TYkTkhhcdUTkUQfL0vMKMLzb0
         SspAL3TvkimtnGUb+yzV7VIWICPDkyW0SRHTcOCTBY8j/AEa+pCs+i5jFPM77wl+QZAs
         /TdTiCcAbosXP0XA3b9+b6gQxnJUETETgDh1wKsI27u2ZtsXSd94Wdzt22juCv6dN7Qa
         nlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685068245; x=1687660245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQLcHKq7/SFjER0eIjTkSMaREA3ODO65yBluaNQD8EA=;
        b=BmA5G6UhVsU6qomAyfoYH+EhzCGb0+LDrE9daPxJSLAcqAdeQurTYZ6PwRgL3JjZ+S
         n+F+o2YmZPJIkyRPMMipnH2ry5LrREsYMlucKV+mhMe0cLMpJNTPVqRs49Gt+zTqa92K
         KTB3yOWpUF7xgjLjayaAote7nWtRKKiKK9VTq9BQIJP9GAycsvN+JFgcgjg1YNa9HOjH
         01eO+88nWQwx6NTfamZJ0UUNiVq/KrXLCJ1kwn1+Y4uXo/27MpvXKWHKvG5DP3PGp8VI
         j21R8/AUzlMxD/hkyf9nd4Afyp0EQcJVCYmMGhFtWPChZuKOw5pP9xl8bICmww/yUhrp
         msWQ==
X-Gm-Message-State: AC+VfDyQg/nSybwFU/DIl3dvwDbDoREkvCV1HjwL4QUjcGLSLyc+T/G/
        XHIO5u6bOAJNeSrjgJMNtDhKMbNEfvctKWRNXwSReKIsNlw=
X-Google-Smtp-Source: ACHHUZ5O0sUYgDgsHbvuem0g7AvqkZ0BzVDg9gOMDb4/e/UAj6vTL4IFg8jL5KNEont+m/BZSsfjl7ES7RNZ9JEuAqg=
X-Received: by 2002:ac2:5ec7:0:b0:4f3:822e:f025 with SMTP id
 d7-20020ac25ec7000000b004f3822ef025mr41535lfq.49.1685068244415; Thu, 25 May
 2023 19:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <1684737363-31554-1-git-send-email-zhaoyang.huang@unisoc.com> <ZG+/EW9NzGsAcGfF@casper.infradead.org>
In-Reply-To: <ZG+/EW9NzGsAcGfF@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 26 May 2023 10:30:20 +0800
Message-ID: <CAGWkznGz6w-56wye-0XG=bZMPLY21g33mcAHuWqYvpaHQJUJEw@mail.gmail.com>
Subject: Re: [PATCHv4] mm: skip CMA pages when they are not available
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, May 26, 2023 at 4:03=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, May 22, 2023 at 02:36:03PM +0800, zhaoyang.huang wrote:
> > +#ifdef CONFIG_CMA
> > +/*
> > + * It is waste of effort to scan and reclaim CMA pages if it is not av=
ailable
> > + * for current allocation context
> > + */
> > +static bool skip_cma(struct folio *folio, struct scan_control *sc)
> > +{
> > +     if (!current_is_kswapd() &&
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
>
> I have no idea if what this patch is trying to accomplish is correct,
> but I no longer object to how it is doing it.
IMO, this is necessary as there could be such weird scenario, that is
an GFP_KERNEL allocation might get 32 MIGRATE_CMA pages via
direct_reclaim which lead to a low PSI_MEM/vmpressure value but return
a NULL pointer
