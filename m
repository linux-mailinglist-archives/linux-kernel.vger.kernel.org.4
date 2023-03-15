Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997926BB5CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjCOOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjCOOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:19:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34E410A94;
        Wed, 15 Mar 2023 07:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C619B81DF4;
        Wed, 15 Mar 2023 14:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE19EC4339C;
        Wed, 15 Mar 2023 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678889945;
        bh=t0gHZGOhE6CFqv71AW1e+wxwTySxUPAEmU7Dj66hV70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=StZWe7/bxuewvn00Ekqo266QfV7lCneyK3i5R5uoJBBgG2XrFCswpGZlEqwTUFXjw
         oCgzD/uXlRVw/TWgo+ufpZz43KV6owoyBCgO756txp3O2aADAufrWRvKm5SWO24VeQ
         e5BT7iAQV2rkQD3hqiZjgprjoH5LV6XWEC9DCOUAIkscC3YM87+9MdKelKyK87Jdzu
         65xjBgcTELPO8kAhf2kT8SLQIDqouK4h+5LAxhpBL+d0wD7pODUX211AnhgFHOEV/9
         ocILYKz25dQu6OTPcicYqjs+F4zrvjOVPYY+zI6qaqhGklOXB8nrGR7kkweqO2sAh3
         IWHML2O80lbAg==
Received: by mail-oi1-f173.google.com with SMTP id c11so14275151oiw.2;
        Wed, 15 Mar 2023 07:19:05 -0700 (PDT)
X-Gm-Message-State: AO0yUKUeNSxAuKypHQLAcxAr5dfUVpy2VE4bswugClA0h6MavtX6zmdM
        vDC5IyZ7JC+IvZKfgJAbUrJ2wA0BgT/ZjwN0bEo=
X-Google-Smtp-Source: AK7set/nftaP7cjfp8+VPH3yvlqxTr9bAaUoyYivPgIWIeahPjwV5INWxOoGwzyO7Ai25tLB76/qvSIgO8r6jFUatYQ=
X-Received: by 2002:aca:2309:0:b0:384:2fd0:e1c8 with SMTP id
 e9-20020aca2309000000b003842fd0e1c8mr857069oie.11.1678889945104; Wed, 15 Mar
 2023 07:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230313171036.268407-1-bage@linutronix.de> <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com> <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de>
In-Reply-To: <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 15 Mar 2023 23:18:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
Message-ID: <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 3:56=E2=80=AFAM Bastian Germann <bage@linutronix.de=
> wrote:
>
> Am 13.03.23 um 18:59 schrieb Masahiro Yamada:
> > On Tue, Mar 14, 2023 at 2:10=E2=80=AFAM Bastian Germann <bage@linutroni=
x.de> wrote:
> >>
> >> Currently, the only way to build the deb-pkg generated package paralle=
ly
> >> is adding -jN to the MAKEFLAGS environment variable. The package ignor=
es
> >> the usual parallel build option that is described in Debian Policy =C2=
=A74.9.1.
> >
> >
> >
> > "dpkg-buildpackage -b -j16" worked for me.
>
> This ends up in DEB_BUILD_OPTIONS=3Dparallel=3D16 being set and the call:
> /usr/bin/make -f ./Makefile ARCH=3Dx86    KERNELRELEASE=3D6.3.0-rc2 KBUIL=
D_BUILD_VERSION=3D1  olddefconfig all


"dpkb-buildpackage -j<N>" sets not only DEB_BUILD_OPTIONS
but also MAKEFLAGS.


This is clearly explained in "man dpkb-buildpackage".


 -j, --jobs[=3Djobs|auto]
   ...
  Will add itself to the MAKEFLAGS environment variable, which should
  cause all subsequent make invocations to inherit the option, thus
  forcing the parallel setting on the packaging ...




Your statement sounds like

 'MAKEFLAGS=3D-j<N> dpkg-buildpackage'

is the only way to build packages in parallel.

Apparently, dpkg-buildpackage provides a much shorter way
and invokes internal Make in parallel.




>
> So it is not used to run the actual build, just the top level `make -f de=
bian/rules` invocation.
> You can set --jobs-force=3D16, which ends up in MAKEFLAGS but the point o=
f the patch is that one can use
> the usual way of parallelizing.


What is the "usual" way in this context?


Do you mean
'DEB_BUILD_OPTIONS=3Dparallel=3D16 dpkg-buildpackage -b'
is the usual way for parallel building?

If so, I agree. This patch caters to this case.


But, I think your code should go to debian/rules
instead of scripts/package/deb-build-option.
Kbuild's "make clean" works much faster with the parallel option.


Also, the commit description should explain the
benefit of this patch.


>
> Side note: Without the patch, the build is run with -j1 regardless of bei=
ng called from the Linux Makefile
> or dpkg-buildpackage.


Try:

 $ make deb-pkg -j16

and

 $ dpkg-buildpackage -b -j16


Both run the package building in parallel.

You see a big difference in build speed w/wo the -j option.
(and the build logs are interleaved, since they
are emitted by multiple threads)





--
Best Regards
Masahiro Yamada
