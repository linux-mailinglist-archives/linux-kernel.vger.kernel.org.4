Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F2062D5B1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiKQI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbiKQI7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:59:19 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCB556D7E;
        Thu, 17 Nov 2022 00:59:18 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AH8wx4s015816;
        Thu, 17 Nov 2022 17:58:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AH8wx4s015816
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668675539;
        bh=DwReWRRBQvnY3volxy4AZ31eV3pKyKyp4FPNo9lsjeA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GtwXEgFDVDuI6YvQ3d1JBpQe+s48kcjtEpLGzLY5UK/D+ljtFrFjZSyWv80myF+vH
         1TKEuT36CGtoocSlU1X57RIFtsiOt4qYmON2KGVYnb1+j3Y2WS2txer7NZ2+zkqu5O
         GDNzEeiEYIs8PLLknZI95AAJz1J2wA4uI2mzXPdnmxeIOfRz2hTjIMhUtZ+2xVAzAM
         cM84fuvNA0QPmQCwGqVaRA2noHzS+ZWBkKq+0JKk60IusRxptv4pq1V/CP+YkY3VoQ
         YDgDM9fLAOJ0m4BZLDsphpDAwgsTPeUpH6Q0oIp3Uje+DkQ9HFjm4LKJsCpeZyTKmW
         JMVgdw9qsA9gA==
X-Nifty-SrcIP: [209.85.167.176]
Received: by mail-oi1-f176.google.com with SMTP id e205so1160481oif.11;
        Thu, 17 Nov 2022 00:58:59 -0800 (PST)
X-Gm-Message-State: ANoB5pm/EH2VGx9xp2lXlsSxvitfvMAKfMQApJPXoctoiyyk+LXxztRk
        g1jAs6hn3+zRvFtVouM2njiWzC3HgcVo06LmE5s=
X-Google-Smtp-Source: AA0mqf5QL0+rvczIlVQ+5Er3ul7Of3smU0ASw4xaDAt+aEHuRuB4U1f8Z9A7q0tAnSpcjYyxAhIqVOG/hyLvaSoQzgA=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr3440284oib.194.1668675538547; Thu, 17
 Nov 2022 00:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20221115220453.3463096-1-maz@kernel.org> <CAK7LNASC6f_=ngS4NW0prvwcOribumeajW1r4q57u3LGZvuEdA@mail.gmail.com>
 <867czvozhn.wl-maz@kernel.org> <CAK7LNATLaT4uwhpT-2o54Z4QjnOcuBDfGwgi-6Jvdr3+SgVo7Q@mail.gmail.com>
 <865yfepoi3.wl-maz@kernel.org>
In-Reply-To: <865yfepoi3.wl-maz@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 17 Nov 2022 17:58:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNATQzYPgmzfu16V0eKX1oQCUfAewZnAxOhKt9yVJB=RVtw@mail.gmail.com>
Message-ID: <CAK7LNATQzYPgmzfu16V0eKX1oQCUfAewZnAxOhKt9yVJB=RVtw@mail.gmail.com>
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

On Thu, Nov 17, 2022 at 6:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 16 Nov 2022 20:56:38 +0000,
> Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Wed, Nov 16, 2022 at 9:28 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 16 Nov 2022 06:09:31 +0000,
> > > Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > On Wed, Nov 16, 2022 at 7:05 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > Since 2df8220cc511 ("kbuild: build init/built-in.a just once"),
> > > > > generating Debian packages using 'make bindeb-pkg' results in
> > > > > packages that are stuck to the same .version, leading to unexpected
> > > > > behaviours (multiple packages with the same version).
> > > > >
> > > > > That's because the mkdebian script samples the build version
> > > > > before building the kernel, and forces the use of that version
> > > > > number for the actual build.
> > > > >
> > > > > Restore the previous behaviour by calling init/build-version
> > > > > instead of reading the .version file. This is likely to result
> > > > > in too many .version bumps, but this is what was happening before
> > > > > (although the bump was affecting builds made after the current one).
> > > >
> > > >
> > > > What do you mean by "too many .version bumps"?
> > > >
> > > > Every "make bindeb-pkg" increments the version by one.
> > >
> > > And isn't that a problem? We increase the build number pointlessly,
> > > even if there is *nothing* to change.
> >
> >
> > I think "make *-pkg" should increment the version every time.
>
> But that's not what the rpm package builder does.
>
> >
> >
> > The .version is incremented only when vmlinux is updated.
> >
> > When you change module code, only *.ko is relinked.
> > The .version stays because it is embedded in vmlinux.
> >
> >
> > Even if you build the kernel first, and .version has no change,
> > the package contents may have some changes.
>
> And again, isn't that an inconsistency?


Yes, it is inconsistent.
Basically, I want all *-pkg targets working in the same way.
Changing binrpm-pkg is easy (Bump the version first),
but the opposite way is impossible (at least, I cannot come
up with a good solution).


>
> Anyway, enough idle arguing. What do want me to do about this bug?
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.


I dropped the last paragraph, and applied. Thanks.






-- 
Best Regards
Masahiro Yamada
