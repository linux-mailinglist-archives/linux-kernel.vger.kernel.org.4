Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24956DB7FF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 03:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjDHBdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 21:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDHBdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 21:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1755E04C;
        Fri,  7 Apr 2023 18:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CEEF60F28;
        Sat,  8 Apr 2023 01:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F4FC4339B;
        Sat,  8 Apr 2023 01:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680917581;
        bh=YM2f5mwIM0TVWbMMhe1fI12BEdYU6sF2tm35U8Rz+hk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SjN4FEhnqQ2mKeqE1exy7ultHT5VB9Yuz78hegJEWyrqyJBooEQd5hctSzF3XES7W
         xKtbAwc/yynKrfShJe0unKCHaN0R1d+QhxiMaQX+aCIKlG3k3Ezz/ngp9nJeaZAoqG
         gpCEblkv49ZBmNMdujBqObqCCSkjXwH5qVpsaM7IHbbRNeKXjK5jr1puMskknP+dS7
         Wz8wmVEbD6fnI99jCMwfZZw68VRbbRW5nngmQl82dHiHlvILsd5X58CAzDtnvFoGO9
         BKZfAfAGqLij1zsMwR5+PdLVEcQLfgpkalobaPfmFCdCk9auYD2YWQSvmEH2yfpSl1
         OBD3BqTqWLCgA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1842df7cb53so206712fac.10;
        Fri, 07 Apr 2023 18:33:01 -0700 (PDT)
X-Gm-Message-State: AAQBX9cXln+q5xRCfjmh5e0591M+NaCADRh2YsI9eIxnGLyTUgHlBqbF
        1OcSn/d83Ryg6050ru6LxNE/ZN2shEgntX+VM2I=
X-Google-Smtp-Source: AKy350acjZOsvxzGuPvApW0r+s7Y/1ha/u4F2rDPcCqXUjABhcqDDrnQtDU3Crd2w9grsXxA8UlAXNzhke0tp7vsSqA=
X-Received: by 2002:a05:6870:1258:b0:17f:84f8:1f44 with SMTP id
 24-20020a056870125800b0017f84f81f44mr1875481oao.11.1680917580858; Fri, 07 Apr
 2023 18:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-2-masahiroy@kernel.org> <20230407181105.GC1018455@dev-arch.thelio-3990X>
In-Reply-To: <20230407181105.GC1018455@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Apr 2023 10:32:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATnmZRXH5E+oPfsDyf=YhUKPBVHG01bosUbtqEDSy+3tQ@mail.gmail.com>
Message-ID: <CAK7LNATnmZRXH5E+oPfsDyf=YhUKPBVHG01bosUbtqEDSy+3tQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: do not create intermediate *.tar for source tarballs
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 8, 2023 at 3:11=E2=80=AFAM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> On Fri, Apr 07, 2023 at 07:16:28PM +0900, Masahiro Yamada wrote:
> > Since commit 05e96e96a315 ("kbuild: use git-archive for source package
> > creation"), source tarballs are created in two steps; create *.tar file
> > then compress it. I split the compression as a separate rule because I
> > just thought 'git archive' supported only gzip for compression. I admit
> > the unneeded *.tar file is annoying.
> >
> > For other compression algorithms, I could pipe the two commands:
> >
> >   $ git archive HEAD | xz > linux.tar.xz
> >
> > I read git-archive(1) carefully, and I realized GIT had provided a
> > more elegant way:
>
> Hooray for documentation :)
>
> >   $ git -c tar.tar.xz.command=3Dxz archive -o linux.tar.xz HEAD
> >
> > This commit uses 'tar.tar.*.command' configuration to specify the
> > compression backend so we can create a compressed tarball directly.
> >
> > GIT commit 767cf4579f0e ("archive: implement configurable tar filters")
> > is more than a decade old, so it should be available on almost all buil=
d
> > environments.
>
> git 1.7.7 it seems, certainly ancientware in my opinion. If people have
> issues with this, they can just upgrade git; even RHEL7 has git 1.8.x.
>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >
> >  scripts/Makefile.package | 24 +++++++++++++++++-------
> >  1 file changed, 17 insertions(+), 7 deletions(-)
> >
> > diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> > index a205617730c6..7707975f729b 100644
> > --- a/scripts/Makefile.package
> > +++ b/scripts/Makefile.package
> > @@ -57,16 +57,23 @@ check-git:
> >               false; \
> >       fi
> >
> > +archive-config-tar.gz  =3D -c tar.tar.gz.command=3D"$(KGZIP)"
> > +archive-config-tar.bz2 =3D -c tar.tar.bz2.command=3D"$(KBZIP2)"
> > +archive-config-tar.xz  =3D -c tar.tar.xz.command=3D"$(XZ)"
> > +archive-config-tar.zst =3D -c tar.tar.zst.command=3D"$(ZSTD)"
> > +
> >  quiet_cmd_archive =3D ARCHIVE $@
> > -      cmd_archive =3D git -C $(srctree) archive \
> > +      cmd_archive =3D git -C $(srctree) $(archive-config-tar$(suffix $=
@)) archive \
> >                      --output=3D$$(realpath $@) --prefix=3D$(basename $=
@)/ $(archive-args)
> >
> >  # Linux source tarball
> >  # --------------------------------------------------------------------=
-------
> >
> > -targets +=3D linux.tar
> > -linux.tar: archive-args =3D $$(cat $<)
> > -linux.tar: .tmp_HEAD FORCE
> > +linux-tarballs :=3D $(addprefix linux, .tar.gz)
>
> Is there any reason not to allow other compression formats for linux
> like you do for perf?


Currently, gzip is only allowed because there is no way to specify
the compression algorithm.
I already have a patch locally, but not submitted yet.

I prioritize groundwork, then add new features later.




--=20
Best Regards
Masahiro Yamada
