Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504946BBA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjCOQmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbjCOQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83230E18D;
        Wed, 15 Mar 2023 09:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89B1A61DCF;
        Wed, 15 Mar 2023 16:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A9C4339C;
        Wed, 15 Mar 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678898426;
        bh=GoKDcW3PEXiUQkEhLcXPNC5nln9cFIUk2TQZkE/hlLI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m47Qxz/V2z25UzjJcHC8KlgbgeQV9iEdpdqI4hqtO9E0MMyN38ssiYS2UIQlM1VJN
         ab52icinFjNY/oXVSZQkYywFXQlRDeSfnk7vw0uIgOFzfJIaIx3X9KdkefJv7YrvPb
         c3XFF0Nml99aJq5PgRNoX5bqbWWDMpWkpBquGUCuT7dVENu6FRJFCet5szfWqlONjd
         VjyieP4NRUGT5Ej9qvgBXBEu8DPNwZ60az0l3o261F+Yag5Z+z3DV2WBdPviPlXnym
         SC6wRE0+pWp5dorWBPw/UfwCkOKFv4pko9hMwF2wEET6FiKLCuIJLJQc4cRpjOzA/e
         vt6gGzEKQjs6A==
Received: by mail-oi1-f182.google.com with SMTP id bh20so14601976oib.9;
        Wed, 15 Mar 2023 09:40:25 -0700 (PDT)
X-Gm-Message-State: AO0yUKUBa6y8F3s++TYmOgQvIDwmP7rWTwNZ2DLvLGyQKzASG2ar7CCa
        5/BlZkXGcR533pzxW21IjI0sZTj/PX/Me60uthM=
X-Google-Smtp-Source: AK7set/lTla/HwkXeedO1hEcTUCVWSBoxiooShJgbUeV6mIwhrUN9mrqK6GaeNHFfKPR8XoV2nFd+c6qfwr1PGgjIvs=
X-Received: by 2002:aca:2309:0:b0:383:c3d5:6c9f with SMTP id
 e9-20020aca2309000000b00383c3d56c9fmr1077057oie.11.1678898425250; Wed, 15 Mar
 2023 09:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230313171036.268407-1-bage@linutronix.de> <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
 <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de> <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
 <CA+icZUV1ng9-TurSfKFuYueuHUbdkCxy3hsMOM9DrtTVL0SsHA@mail.gmail.com>
In-Reply-To: <CA+icZUV1ng9-TurSfKFuYueuHUbdkCxy3hsMOM9DrtTVL0SsHA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 16 Mar 2023 01:39:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ+2fhZNhuCi_40V=4QN+pMC7y67MTYp2zO7HOVwMJH_Q@mail.gmail.com>
Message-ID: <CAK7LNAQ+2fhZNhuCi_40V=4QN+pMC7y67MTYp2zO7HOVwMJH_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
To:     sedat.dilek@gmail.com
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:57=E2=80=AFAM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> On Wed, Mar 15, 2023 at 3:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > On Tue, Mar 14, 2023 at 3:56=E2=80=AFAM Bastian Germann <bage@linutroni=
x.de> wrote:
> > >
> > > Am 13.03.23 um 18:59 schrieb Masahiro Yamada:
> > > > On Tue, Mar 14, 2023 at 2:10=E2=80=AFAM Bastian Germann <bage@linut=
ronix.de> wrote:
> > > >>
> > > >> Currently, the only way to build the deb-pkg generated package par=
allely
> > > >> is adding -jN to the MAKEFLAGS environment variable. The package i=
gnores
> > > >> the usual parallel build option that is described in Debian Policy=
 =C2=A74.9.1.
> > > >
> > > >
> > > >
> > > > "dpkg-buildpackage -b -j16" worked for me.
> > >
> > > This ends up in DEB_BUILD_OPTIONS=3Dparallel=3D16 being set and the c=
all:
> > > /usr/bin/make -f ./Makefile ARCH=3Dx86    KERNELRELEASE=3D6.3.0-rc2 K=
BUILD_BUILD_VERSION=3D1  olddefconfig all
> >
> >
> > "dpkb-buildpackage -j<N>" sets not only DEB_BUILD_OPTIONS
> > but also MAKEFLAGS.
> >
> >
> > This is clearly explained in "man dpkb-buildpackage".
> >
> >
> >  -j, --jobs[=3Djobs|auto]
> >    ...
> >   Will add itself to the MAKEFLAGS environment variable, which should
> >   cause all subsequent make invocations to inherit the option, thus
> >   forcing the parallel setting on the packaging ...
> >
> >
> >
> >
> > Your statement sounds like
> >
> >  'MAKEFLAGS=3D-j<N> dpkg-buildpackage'
> >
> > is the only way to build packages in parallel.
> >
> > Apparently, dpkg-buildpackage provides a much shorter way
> > and invokes internal Make in parallel.
> >
> >
> >
> >
> > >
> > > So it is not used to run the actual build, just the top level `make -=
f debian/rules` invocation.
> > > You can set --jobs-force=3D16, which ends up in MAKEFLAGS but the poi=
nt of the patch is that one can use
> > > the usual way of parallelizing.
> >
> >
> > What is the "usual" way in this context?
> >
> >
> > Do you mean
> > 'DEB_BUILD_OPTIONS=3Dparallel=3D16 dpkg-buildpackage -b'
> > is the usual way for parallel building?
> >
> > If so, I agree. This patch caters to this case.
> >
> >
> > But, I think your code should go to debian/rules
> > instead of scripts/package/deb-build-option.
> > Kbuild's "make clean" works much faster with the parallel option.
> >
> >
> > Also, the commit description should explain the
> > benefit of this patch.
> >
> >
> > >
> > > Side note: Without the patch, the build is run with -j1 regardless of=
 being called from the Linux Makefile
> > > or dpkg-buildpackage.
> >
> >
> > Try:
> >
> >  $ make deb-pkg -j16
> >
> > and
> >
> >  $ dpkg-buildpackage -b -j16
> >
> >
> > Both run the package building in parallel.
> >
> > You see a big difference in build speed w/wo the -j option.
> > (and the build logs are interleaved, since they
> > are emitted by multiple threads)
> >
> >
>
> I have no strong opinion in having a DEB_BUILD_OPTIONS...
>
> As you stated Masahiro I have seen it mostly in debian/rules.
>
> See the example from [1]:
>
> ifneq (,$(filter parallel=3D%,$(DEB_BUILD_OPTIONS)))
>     NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_BUI=
LD_OPTIONS)))
>     MAKEFLAGS +=3D -j$(NUMJOBS)
> endif
>

Yup, this code looks good to me.




--=20
Best Regards
Masahiro Yamada
