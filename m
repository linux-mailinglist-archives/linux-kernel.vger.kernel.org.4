Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EEE726613
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjFGQeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFGQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:34:14 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08240196
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 09:34:13 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so1785853a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686155651; x=1688747651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nST2Md/+Z3od5CZcws3W9bn9v93QD0AgAvtu6ztY8xg=;
        b=UegRLrvz05yeGz6eWmz77+FqJutZvBeIx1d8R4Akm/4pOMNflRnR59fho+CdTVWuMu
         4DRnzeaxtLloI8NJy0SrLVsbgAEoq3PCs7WdwcCbRZ5zeoxg8VdieX/WN2SP3qO+7qnO
         grQeVqgqDBajpLERfIWSVSXaNKMOtJXK5V2al4qRVbbDz7UK0yoaK9l24aXxh/u8+3Vp
         XXW1GPpj8vziNQ6o8hf9nVVRxxbC1tXWz1g/Mk3AOCRy6NSmMR/EoR5DPEuLBU0otqFk
         /2ABQI64lxmWOIH18Vt22Vz2LLBc/wA5+/k/8Gxz4DGS5XRApcgwHZ79RS1ZozpLz/nJ
         Jp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686155651; x=1688747651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nST2Md/+Z3od5CZcws3W9bn9v93QD0AgAvtu6ztY8xg=;
        b=huYx0WeRBBTBqU4PhcVaEsNeZYVcB38q3czxuqp5P0p5+nLtyjbfZsYrTlTLp24rRr
         xuECPzo7EGjuNQqyd3dzP0/p1JkluwBy0wwgi+hGprTLLG7HSGi2voohceyLK+gZAp03
         6ZKsMO7MHG9pV2eDdaueE1+VGTYaf9itapBll3bcysHZSQO3tjudk56Y3UQtKZH3pezO
         9jFSNyl2Jqz0RpRDNBVl1KBXiJmIwsbQWJo0Zr+nxhLUy2W0QCV09+kpwzUOfKxhEmDj
         6EAbafHwaNoIEJzwuymPPCKiFMCaD53p78oRPX6TJeRfDrPw7eMWuawgdEiGXB1QL7cu
         bolQ==
X-Gm-Message-State: AC+VfDw0VOb00Bl4mEhtHPFZhr6/mwFtHeIzrbK+0HPm3Zs0ZZ6Pq5QZ
        wUbNRJ2nbPDUd0qkIVwns9ezeLI3QzTksx+GLaG5PA==
X-Google-Smtp-Source: ACHHUZ4gYt05yMVISGVpEL2tDzHWc2p/ubLtT6lvjSj1dd6u9DbqiiNPYZYRZTNvR0Zwell4MBL08Y2F53E7OlUporA=
X-Received: by 2002:a17:907:6e25:b0:94f:2d5f:6949 with SMTP id
 sd37-20020a1709076e2500b0094f2d5f6949mr6223367ejc.42.1686155651187; Wed, 07
 Jun 2023 09:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230530210251.493194-1-yosryahmed@google.com> <20230607141357.GA338934@cmpxchg.org>
In-Reply-To: <20230607141357.GA338934@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 7 Jun 2023 09:33:34 -0700
Message-ID: <CAJD7tkbHHVJfbybP0gqHGPp9J2t34-1NC0np6PgMdfxLmX-kpg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: support exclusive loads
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 7:13=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Tue, May 30, 2023 at 09:02:51PM +0000, Yosry Ahmed wrote:
> > @@ -46,6 +46,19 @@ config ZSWAP_DEFAULT_ON
> >         The selection made here can be overridden by using the kernel
> >         command line 'zswap.enabled=3D' option.
> >
> > +config ZSWAP_EXCLUSIVE_LOADS
> > +     bool "Invalidate zswap entries when pages are loaded"
> > +     depends on ZSWAP
> > +     help
> > +       If selected, when a page is loaded from zswap, the zswap entry =
is
> > +       invalidated at once, as opposed to leaving it in zswap until th=
e
> > +       swap entry is freed.
> > +
> > +       This avoids having two copies of the same page in memory
> > +       (compressed and uncompressed) after faulting in a page from zsw=
ap.
> > +       The cost is that if the page was never dirtied and needs to be
> > +       swapped out again, it will be re-compressed.
> > +
> >  choice
> >       prompt "Default compressor"
> >       depends on ZSWAP
> > diff --git a/mm/frontswap.c b/mm/frontswap.c
> > index 279e55b4ed87..e5d6825110f4 100644
> > --- a/mm/frontswap.c
> > +++ b/mm/frontswap.c
> > @@ -216,8 +216,13 @@ int __frontswap_load(struct page *page)
> >
> >       /* Try loading from each implementation, until one succeeds. */
> >       ret =3D frontswap_ops->load(type, offset, page);
> > -     if (ret =3D=3D 0)
> > +     if (ret =3D=3D 0) {
> >               inc_frontswap_loads();
> > +             if (frontswap_ops->exclusive_loads) {
> > +                     SetPageDirty(page);
> > +                     __frontswap_clear(sis, offset);
> > +             }
> > +     }
> >       return ret;
>
> This would be a much more accessible feature (distro kernels,
> experimenting, adapting to different workloads) if it were runtime
> switchable.
>
> That should be possible, right? As long as frontswap and zswap are
> coordinated, this can be done on a per-entry basis:
>
>         exclusive =3D READ_ONCE(frontswap_ops->exclusive_loads);
>         ret =3D frontswap_ops->load(type, offset, page, exclusive);
>         if (ret =3D=3D 0) {
>                 if (exclusive) {
>                         SetPageDirty(page);
>                         __frontswap_clear(sis, offset);
>                 }
>         }

Sure, I can do that. My thought was that this isn't something that
someone usually wants to change at runtime, but at least for
experimentation, it does make things a lot easier. I can add a zswap
module parameter.

I am guessing for consistency with other zswap settings and for
convenience, I can leave the config option to set the default value
with, aka CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON or something. Does
this make sense?
