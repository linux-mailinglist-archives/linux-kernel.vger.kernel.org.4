Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C532B62CBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiKPVA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiKPVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:00:10 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7410F6B20B;
        Wed, 16 Nov 2022 12:57:42 -0800 (PST)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AGKvF1b003019;
        Thu, 17 Nov 2022 05:57:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AGKvF1b003019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668632236;
        bh=kGY0QSVAlr6bF4H3Uy9UfX0YWaSEIw4f7lOCzNlxzyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSkb9rsg/OfSCwMd/WfNsDuIUNLNPy7035aTXapdyJjS56OspyhIcfWYpqDS3nOPX
         Wu9o8OLMrY49bQbJ4bSA/5A5yBSyU7S8k1RvsZBQfb6HSkSboj+ptFUa+lZB8MkGSx
         zWjMU5ffRaK1lNr/KbuwNkkv7zKntNcIOTRRuiCyQF5rrVG8R9HZBgAJRjvM2dbgVb
         k0sj18AjJ80y3S7U3Hpz21gwO7uQdn9LJSqfNiiar/LA5aj6WCoC4AK5/qXNOfYFrn
         4EBbsAoPzDLspJ2J70kEEx5R1oH/9EPV1D5Jz/tHXa92Cvn6S26pk4fq1ZcRY5PoHn
         ZIO/MM8fqk3vg==
X-Nifty-SrcIP: [209.85.160.41]
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-13b103a3e5dso21600919fac.2;
        Wed, 16 Nov 2022 12:57:16 -0800 (PST)
X-Gm-Message-State: ANoB5pnqqrjEwHIZ4vkeIgwbdoRyhm5jorJEp/+gNm6DuzQc/p5/qSp9
        v2jjA9HHFW2P3/Ng7Qjtc5xbTIoqpz4OgvDNgSo=
X-Google-Smtp-Source: AA0mqf6OGwnSfTJ0Q/hSmVjKudJz0kAVmFAvwIe2mZZBOclVGg2DViPlgyQpb17WZEz/i50zIyOu+xeA+Eia2A9gyD8=
X-Received: by 2002:a05:6870:2a41:b0:13b:5d72:d2c6 with SMTP id
 jd1-20020a0568702a4100b0013b5d72d2c6mr2702184oab.287.1668632235014; Wed, 16
 Nov 2022 12:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20221115220453.3463096-1-maz@kernel.org> <CAK7LNASC6f_=ngS4NW0prvwcOribumeajW1r4q57u3LGZvuEdA@mail.gmail.com>
 <867czvozhn.wl-maz@kernel.org>
In-Reply-To: <867czvozhn.wl-maz@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Nov 2022 05:56:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNATLaT4uwhpT-2o54Z4QjnOcuBDfGwgi-6Jvdr3+SgVo7Q@mail.gmail.com>
Message-ID: <CAK7LNATLaT4uwhpT-2o54Z4QjnOcuBDfGwgi-6Jvdr3+SgVo7Q@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Restore .version auto-increment behaviour for
 Debian packages
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 9:28 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 16 Nov 2022 06:09:31 +0000,
> Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Nov 16, 2022 at 7:05 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Since 2df8220cc511 ("kbuild: build init/built-in.a just once"),
> > > generating Debian packages using 'make bindeb-pkg' results in
> > > packages that are stuck to the same .version, leading to unexpected
> > > behaviours (multiple packages with the same version).
> > >
> > > That's because the mkdebian script samples the build version
> > > before building the kernel, and forces the use of that version
> > > number for the actual build.
> > >
> > > Restore the previous behaviour by calling init/build-version
> > > instead of reading the .version file. This is likely to result
> > > in too many .version bumps, but this is what was happening before
> > > (although the bump was affecting builds made after the current one).
> >
> >
> > What do you mean by "too many .version bumps"?
> >
> > Every "make bindeb-pkg" increments the version by one.
>
> And isn't that a problem? We increase the build number pointlessly,
> even if there is *nothing* to change.


I think "make *-pkg" should increment the version every time.


The .version is incremented only when vmlinux is updated.

When you change module code, only *.ko is relinked.
The .version stays because it is embedded in vmlinux.


Even if you build the kernel first, and .version has no change,
the package contents may have some changes.





> >
> > Is there any case where it increases more?
>
> No, but that's bad enough IMHO.
>
> > > Eventually, this script should be turned into something that
> > > is a bit less counter-intuitive (building the kernel first
> > > and only then generating the packaging artefacts).
> >
> >
> > How to achieve this?
>
>
> By building the kernel *before* sampling the version number, just like
> RPM does.
>
> >
> > The version is recorded in debian/chanegelog.
> > Without it, dpkg-buildpackage fails.
>
> And again, nothing forces us to do it in that order.
>
> > In my understanding, the version must be fixed before building the kernel.
>
> Can't immediately see what mandates it, but I'm sure you know better.
>
> Anyway, the current situation needs fixing. If you're unhappy with the
> patch, feel free to replace it with something that you consider more
> appropriate.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



-- 
Best Regards
Masahiro Yamada
