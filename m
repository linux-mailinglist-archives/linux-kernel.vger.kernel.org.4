Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82D724A18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbjFFRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbjFFRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D299E42;
        Tue,  6 Jun 2023 10:21:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DC0633A1;
        Tue,  6 Jun 2023 17:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F7C433D2;
        Tue,  6 Jun 2023 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072110;
        bh=egf9nd46GWUqIZBqWwqTFmUpZW1v4tp/pYaaWrdTSN4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+DQTULTFjnGotsh6m4MW/H7OIbQUmL6g8PafBa/cFWWFgjEz2R9+NaKu6aKrIQOZ
         4xp46jvCOyMLddd8hEyev8dwX8N9IGoTee0aCav16X65u2c+5ho2RisTbV9bZoOqCR
         72VAZ2a6ql1ARX5+QNDYHCvJm0MwF6UPh+Kfqu9qTCsqpyAUBRvVe813jdTsJMItOD
         bpXx8bKlALXipO12pwtlJnk0jmn6nIlIKMwOql31H0CCQx9foDB+Nu12wQq661LJgV
         S3X8oU9cA1PjuWGKDOB3ociBbiUvTQO/fPTCjLrfU38tnHmbiTM5lJc58fWXYlKZ6+
         BkfL3rP8uY66Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-19f31d6b661so7002519fac.0;
        Tue, 06 Jun 2023 10:21:50 -0700 (PDT)
X-Gm-Message-State: AC+VfDyiU+fcmwomfbA5AVQy+wMHOxImv1j2yyMsLB6GKZHWcfiBHzAe
        Lt8axV5fBbTZu47EGZRKacvz7679vSlqu8SK6Q8=
X-Google-Smtp-Source: ACHHUZ7NxGNfFIJN+FbaGIZ7b3rk+jlcRXhyKCOY5mOiZf5LiCfG/XmjbvrjuNDmgWrsLj4iUV3GUZDwdvYkDILVjKI=
X-Received: by 2002:a05:6870:9c87:b0:19e:8f6a:84c1 with SMTP id
 pq7-20020a0568709c8700b0019e8f6a84c1mr3653127oab.52.1686072109501; Tue, 06
 Jun 2023 10:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230606094159.1910369-1-masahiroy@kernel.org> <CAKwvOdkfQiu-Y29xiOMERxnSy9aqN851AoogGYrnqdc4dcaHOA@mail.gmail.com>
In-Reply-To: <CAKwvOdkfQiu-Y29xiOMERxnSy9aqN851AoogGYrnqdc4dcaHOA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 7 Jun 2023 02:21:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNASheifemHTT-cNputbMv7th+NT8XUBu2a9ZMcu5jZMe3g@mail.gmail.com>
Message-ID: <CAK7LNASheifemHTT-cNputbMv7th+NT8XUBu2a9ZMcu5jZMe3g@mail.gmail.com>
Subject: Re: [PATCH] modpost: propagate W=1 build option to modpost
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 1:56=E2=80=AFAM Nick Desaulniers <ndesaulniers@googl=
e.com> wrote:
>
> On Tue, Jun 6, 2023 at 2:42=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > "No build warning" is a strong requirement these days, so you must fix
> > all issues before enabling a new warning flag.
> >
> > We often add a new warning to W=3D1 first so that the kbuild test robot
> > blocks new breakages.
> >
> > This commit allows modpost to show extra warnings only when W=3D1
> > (or KBUILD_EXTRA_WARN=3D1) is given.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Patch seems fine, but without anyone reading extra_warn, I'm curious
> what new extra warnings you had in mind were?


This one.

https://lore.kernel.org/linux-kbuild/CAK7LNAR0uMvf+k7LPXtMjigKFPeNu5m5EhAkv=
k2RVRHkdjdbdg@mail.gmail.com/T/#m0f41f2c8fe843133ce8100088443491a51d496af


> > ---
> >
> >  scripts/Makefile.modpost | 1 +
> >  scripts/mod/modpost.c    | 7 ++++++-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > index 0980c58d8afc..074e27c0c140 100644
> > --- a/scripts/Makefile.modpost
> > +++ b/scripts/Makefile.modpost
> > @@ -47,6 +47,7 @@ modpost-args =3D                                     =
                                           \
> >         $(if $(KBUILD_MODPOST_WARN),-w)                                =
                 \
> >         $(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))                    =
                 \
> >         $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_N=
SDEPS),-N)       \
> > +       $(if $(findstring 1, $(KBUILD_EXTRA_WARN)),-W)                 =
                 \
> >         -o $@
> >
> >  modpost-deps :=3D $(MODPOST)
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index d10f5bdcb753..3ea5eb2b1029 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -42,6 +42,8 @@ static bool allow_missing_ns_imports;
> >
> >  static bool error_occurred;
> >
> > +static bool extra_warn;
> > +
> >  /*
> >   * Cut off the warnings when there are too many. This typically occurs=
 when
> >   * vmlinux is missing. ('make modules' without building vmlinux.)
> > @@ -2199,7 +2201,7 @@ int main(int argc, char **argv)
> >         LIST_HEAD(dump_lists);
> >         struct dump_list *dl, *dl2;
> >
> > -       while ((opt =3D getopt(argc, argv, "ei:mnT:o:awENd:")) !=3D -1)=
 {
> > +       while ((opt =3D getopt(argc, argv, "ei:mnT:o:aWwENd:")) !=3D -1=
) {
> >                 switch (opt) {
> >                 case 'e':
> >                         external_module =3D true;
> > @@ -2224,6 +2226,9 @@ int main(int argc, char **argv)
> >                 case 'T':
> >                         files_source =3D optarg;
> >                         break;
> > +               case 'W':
> > +                       extra_warn =3D true;
> > +                       break;
> >                 case 'w':
> >                         warn_unresolved =3D true;
> >                         break;
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Best Regards
Masahiro Yamada
