Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D086B0FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjCHRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:03:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41441ACE8;
        Wed,  8 Mar 2023 09:02:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7299F61884;
        Wed,  8 Mar 2023 17:02:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC109C433A0;
        Wed,  8 Mar 2023 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678294934;
        bh=DkU79AKVipq7kr1m0EQNgl7nWn1p4Q15rMlevpVdY+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOhApBaa9o56bpwKDrymjmHXC9E8tGEVIVx2Cdzu6zAEF3w1AouB3qtqX3Vt6LBo2
         Pxbrg8E5jOxLEiInPSlZRZYes+qY8ukKqG3F4TVfk24LrtZsiLC2mcz1cobiNkamRq
         ykPA3+EoWtjE4BDuFzJJ85Eo/GK+u6oXFkcNwuGn4NI5Wgcv6HVfHGIL/+nCO3d4G6
         DxCLIy8stNragk8Dk6DaSiId7sbKmiW2yUowLMyefc0hhBilImLZ7DXQ1f9cbHcPhb
         AFgjPirXSjAkuof67MX0yHNZi5TAR4giPTtM9+gvic7MZLQv+QSpkd2DbhwmFJigLJ
         kqV5MWgVgD4vg==
Received: by mail-oi1-f171.google.com with SMTP id bp19so12668398oib.4;
        Wed, 08 Mar 2023 09:02:14 -0800 (PST)
X-Gm-Message-State: AO0yUKVPtVph1plP8tCFe9XFrjMOymTGxDJ5p4pmKxcmcTBBy8Mo97Is
        YdBlfXI93l0whGEgSXG+nT9CPFA3M9qv6QpY2ww=
X-Google-Smtp-Source: AK7set8XRekgGrEkZddIOpeL1OcqW4OLs0bQFxIlHpFr+TfsX/ZoaBbffEqUOtkLRBlTtuA6B0eHtjbIOGMmdlbHIHM=
X-Received: by 2002:a05:6808:8d7:b0:384:65af:e554 with SMTP id
 k23-20020a05680808d700b0038465afe554mr6268686oij.1.1678294934110; Wed, 08 Mar
 2023 09:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20230215012034.403356-1-masahiroy@kernel.org> <20230215012034.403356-11-masahiroy@kernel.org>
 <444e7e7b-c576-38a9-9f85-b169b32c3807@linux.intel.com>
In-Reply-To: <444e7e7b-c576-38a9-9f85-b169b32c3807@linux.intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 9 Mar 2023 02:01:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6OwZB6bVHtTtzZa+2syKwGXid9MA_VTGe2ZTRyoHmoQ@mail.gmail.com>
Message-ID: <CAK7LNAT6OwZB6bVHtTtzZa+2syKwGXid9MA_VTGe2ZTRyoHmoQ@mail.gmail.com>
Subject: Re: [PATCH v6 11/12] kbuild: deb-pkg: improve the usability of source package
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>,
        "Vehmanen, Kai" <kai.vehmanen@intel.com>,
        "Girdwood, Liam R" <liam.r.girdwood@intel.com>
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

On Wed, Mar 8, 2023 at 9:29=E2=80=AFPM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
>
>
> On 15/02/2023 03:20, Masahiro Yamada wrote:
> > Improve the source package support in case the dpkg-buildpackage is
> > directly used to build binary packages.
> >
> > For cross-compiling, you can set CROSS_COMPILE via the environment
> > variable, but it is better to set it automatically - set it to
> > ${DEB_HOST_GNU_TYPE}- if we are cross-compiling but not from the top
> > Makefile.
> >
> > The generated source package may be carried to a different build
> > environment, which may have a different compiler installed.
> > Run olddefconfig first to set new CONFIG options to their default
> > values without prompting.
> >
> > Take KERNELRELEASE and KBUILD_BUILD_VERSION from the version field of
> > debian/changelog in case it is updated afterwards.
>
> I just arrived to this patch when trying to update the kernel for SOF
> from 6.2.0 base to 6.3.0-rc1:
> https://github.com/thesofproject/linux/pull/4223#issuecomment-1459997676
>
> Our CI is building a kernel deb package from PRs to test with this comman=
d:
> make bindeb-pkg LOCALVERSION=3D-$PRIDV-default KDEB_PKGVERSION=3D$(make
> kernelversion)-$GITSHA
>
> The files, directories and the name of the deb package follows the rule
> set up by scripts/setlocalversion, taking into account the LOCALVERSION,
> CONFIG_LOCALVERSION and CONFIG_LOCALVERSION_AUTO, but the built kernel
> is using the version derived from KDEB_PKGVERSION and the system is not
> able to boot up since the modules are in a different directory then they
> should be.
>
> Something like this:
> make bindeb-pkg LOCALVERSION=3D-testbuild
> vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty
> /lib/modules/6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty/
>
> strings vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty | grep 6.3
> 6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty
>
> Then with the KDEB_PKGVERSION:
> make bindeb-pkg LOCALVERSION=3D-testbuild KDEB_PKGVERSION=3D$(make
> kernelversion)-notworking
> vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty
> /lib/modules/6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty/
>
> strings vmlinuz-6.3.0-rc1-testbuild-05827-g863ad81a6aa9-dirty | grep 6.3
> 6.3.0-rc1
>
> in this case modprobe will not find the modules, it is looking for them
> under /lib/modules/6.3.0-rc1
>
> Reverting this patch makes the created  deb package usable, the system
> is bootable.
>
> We use the LOCALVERSION to feed in PR inforamtion and the
> KDEB_PKGVERSION is used fro additional information, like build ID.
>
> Do you have any suggestion on how to get the functionality back or we
> must stop using the KDEB_PKGVERSION altogether?


I am aware of this issue.

KERNELVERSION does not need to match the package version.

I should have taken it from the <abiver> in the package name
(linux-image-<abiver>_<origver>-<rev>_<arch>.deb)
if I had wanted to do this dynamically by debian/control.

I wrongly took it from <origver>.

I will change this when I solve another issue required by Linus Tolvalds.


Please wait.






>
> Thank you,
> --
> P=C3=A9ter
>
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v6:
> >   - New patch
> >
> >  scripts/package/deb-build-option | 16 ++++++++++++++++
> >  scripts/package/mkdebian         |  9 ++++-----
> >  2 files changed, 20 insertions(+), 5 deletions(-)
> >  create mode 100755 scripts/package/deb-build-option
> >
> > diff --git a/scripts/package/deb-build-option b/scripts/package/deb-bui=
ld-option
> > new file mode 100755
> > index 000000000000..b079b0d121d4
> > --- /dev/null
> > +++ b/scripts/package/deb-build-option
> > @@ -0,0 +1,16 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# Set up CROSS_COMPILE if we are cross-compiling, but not called from =
the
> > +# kernel toplevel Makefile
> > +if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" !=
=3D "${DEB_BUILD_ARCH}" ]; then
> > +     echo CROSS_COMPILE=3D${DEB_HOST_GNU_TYPE}-
> > +fi
> > +
> > +version=3D$(dpkg-parsechangelog -S Version)
> > +version_upstream=3D"${version%-*}"
> > +debian_revision=3D"${version#${version_upstream}}"
> > +debian_revision=3D"${debian_revision#*-}"
> > +
> > +echo KERNELRELEASE=3D${version_upstream}
> > +echo KBUILD_BUILD_VERSION=3D${debian_revision}
> > diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> > index eef20d5dc288..f74380036bb5 100755
> > --- a/scripts/package/mkdebian
> > +++ b/scripts/package/mkdebian
> > @@ -90,10 +90,8 @@ rm -rf debian
> >  version=3D$KERNELRELEASE
> >  if [ -n "$KDEB_PKGVERSION" ]; then
> >       packageversion=3D$KDEB_PKGVERSION
> > -     revision=3D${packageversion##*-}
> >  else
> > -     revision=3D$($srctree/init/build-version)
> > -     packageversion=3D$version-$revision
> > +     packageversion=3D$version-$($srctree/init/build-version)
> >  fi
> >  sourcename=3D${KDEB_SOURCENAME:-linux-upstream}
> >
> > @@ -244,8 +242,9 @@ srctree ?=3D .
> >
> >  build-indep:
> >  build-arch:
> > -     \$(MAKE) KERNELRELEASE=3D${version} ARCH=3D${ARCH} \
> > -     KBUILD_BUILD_VERSION=3D${revision} -f \$(srctree)/Makefile
> > +     \$(MAKE) -f \$(srctree)/Makefile ARCH=3D${ARCH} \
> > +     \$(shell \$(srctree)/scripts/package/deb-build-option) \
> > +     olddefconfig all
> >
> >  build: build-arch
> >
>
> --
> P=C3=A9ter



--=20
Best Regards
Masahiro Yamada
