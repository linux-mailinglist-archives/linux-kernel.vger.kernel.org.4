Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972A76E5802
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDREQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjDREQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:16:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD146BF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:16:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y24so1056720ljm.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681791401; x=1684383401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxdxKq/32CCtowAPIubpFnwofkATJc7V1iVpirtu27w=;
        b=jwtjjdmgHbfoBaMWcTZ7kc/zoWiLA64ABwCz7E6pD6AxAJiAWdWG1gjla1pyurFoLq
         Z3/7z8S9HvVHAd9hsx7uoh18w+z96cg8IaRi220JxpPj0kiNSUVoyhJtQ5LyMBHKHPyy
         Z9A0Lw/dMgwxgFMCqrCyPUhAus6CoT8/dg060ANuPhGpgpvztFG4n5xfk6LbqHiyFsZm
         oCIophkoVqNbK64Az3MT4qZw/3qcuy+MhG9i7A1I2DaUM3yQPcJHkN725u1Q9KtBxcHC
         ntgo/8sgU2TVzRNRkbvKGiEzjEO4XPdRBua96Svc51KxTsaljFokebCrEW8hZnJgXOaX
         nPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681791401; x=1684383401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxdxKq/32CCtowAPIubpFnwofkATJc7V1iVpirtu27w=;
        b=h3HfF6LX+ZCN9pfmqMCN2FCEJIx5kx0MGEULwDOg7miUpdBAORShLbxv5YzW5bvn1x
         AS0B2D41ES7oo+YnPFHpFQdtNmGg0bYfjW84l4gpnmyZfi3B4UZVRf9DmxkoJY0lHQvG
         ieuFV5AhSdBjtP3xOB7w5N+V7CDWfAP3bQqBCW6TICyew4T3HWe0S8yFRgGPh9lGdXmq
         OMbG5x1ENFPBJXjY0znGqyLW6YkHiaEyjnCDF3qfXHclZf4bm/0mvQLPWxaKZmqDOhfY
         k0zwPaOVOsNeaEEhLOQ6yh6nhRD3XQIWzgN7H1JgfaK6pA4c/zLUKOUa3nKyMSGxFzJA
         yrbg==
X-Gm-Message-State: AAQBX9fSu2KxI7j+UjiZh1E5tH6svEdx5Arect2rHp5x+j4YrsTAXajh
        hZWE1ZDO4WzxP4vaqVRpNfLlOvsCfVpISePdmSpkfu7K
X-Google-Smtp-Source: AKy350ZF1kAdHZGxxjn3MUKBsFDMKApVmpNWiASwQIcMyvXjgL6i/yn1DzdYO1mHttL8L6EIEE+mNE/I4mafi2Dj3HY=
X-Received: by 2002:a2e:9c13:0:b0:2a0:69e0:9f7a with SMTP id
 s19-20020a2e9c13000000b002a069e09f7amr206920lji.41.1681791401028; Mon, 17 Apr
 2023 21:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <1681788789-19679-1-git-send-email-zhaoyang.huang@unisoc.com> <ZD4QsGd0DwHa83K1@casper.infradead.org>
In-Reply-To: <ZD4QsGd0DwHa83K1@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 18 Apr 2023 12:16:19 +0800
Message-ID: <CAGWkznHHMSWpEJ1xjfgnA7k04AeO2hNpa=BRgCmKop0sJMTbsw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix printk format within cma
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

On Tue, Apr 18, 2023 at 11:38=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Apr 18, 2023 at 11:33:09AM +0800, zhaoyang.huang wrote:
> > cma and page pointer printed via %p are hash value which make debug to =
be hard.
> > change them to %px.
>
> Why does printing the page pointer make any sense at all?  Surely the
> PFN makes much more sense.
either pfn or a correct page pointer makes sense for debugging, while
page could be more safe than pfn which expose the paddr directly
>
> > [63321.482751] [c7] cma: cma_alloc(): memory range at 000000000b5e462c =
is busy, retrying
> > [63321.482786] [c7] cma: cma_alloc(): memory range at 000000000f7d6fae =
is busy, retrying
> > [63321.482823] [c7] cma: cma_alloc(): memory range at 00000000e653b59b =
is busy, retrying
> > [63322.378890] [c7] cma: cma_release(page 00000000dd53cf48)
> > [63322.378913] [c7] cma: cma_release(page 00000000315f703d)
> > [63322.378925] [c7] cma: cma_release(page 00000000791e3a5f)
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  mm/cma.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 4a978e0..dfe9813 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -435,7 +435,7 @@ struct page *cma_alloc(struct cma *cma, unsigned lo=
ng count,
> >       if (!cma || !cma->count || !cma->bitmap)
> >               goto out;
> >
> > -     pr_debug("%s(cma %p, count %lu, align %d)\n", __func__, (void *)c=
ma,
> > +     pr_debug("%s(cma %px, count %lu, align %d)\n", __func__, (void *)=
cma,
> >                count, align);
> >
> >       if (!count)
> > @@ -534,7 +534,7 @@ bool cma_pages_valid(struct cma *cma, const struct =
page *pages,
> >       pfn =3D page_to_pfn(pages);
> >
> >       if (pfn < cma->base_pfn || pfn >=3D cma->base_pfn + cma->count) {
> > -             pr_debug("%s(page %p, count %lu)\n", __func__,
> > +             pr_debug("%s(page %px, count %lu)\n", __func__,
> >                                               (void *)pages, count);
> >               return false;
> >       }
> > @@ -560,7 +560,7 @@ bool cma_release(struct cma *cma, const struct page=
 *pages,
> >       if (!cma_pages_valid(cma, pages, count))
> >               return false;
> >
> > -     pr_debug("%s(page %p, count %lu)\n", __func__, (void *)pages, cou=
nt);
> > +     pr_debug("%s(page %px, count %lu)\n", __func__, (void *)pages, co=
unt);
> >
> >       pfn =3D page_to_pfn(pages);
> >
> > --
> > 1.9.1
> >
> >
