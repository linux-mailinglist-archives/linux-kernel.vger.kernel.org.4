Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986F3724B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238943AbjFFSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbjFFSit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:38:49 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65565125
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:38:48 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6260bb94363so37296666d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686076727; x=1688668727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwU+xSGrFSXiCAK1q09i+t8bSjZOmkBqLsisZ5TunnI=;
        b=iZ2ce1/x6sLmBVEP7zPE9JWAO2ql1Bo6I3zbANCh2FpDSORTt81z928cOZYTL6RIA5
         b39UL+xoL517/lYYY6twJudobbS2535ZyCpfuAe2OIGgfN6+ifmmDF8RLaY7eRKgs0EY
         Qtit84Q/a0Dt/XXR23g1kOK3MZ16fttmFbEavZGUJNRGp/+5Sog4EzaEobfrG6gjblwe
         h88BoglEyp3ocdaDpAaFprdDiTNd61coqFub6jYdREY043/gKKQpqZb6ufbk5/uCv0D/
         wIKy8VgFmEd3qA9/7jM19CQujCT/UrHML2VaAhKPEnF6OoQH8HENBCLMKOPZGqhXr3MJ
         cSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076727; x=1688668727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwU+xSGrFSXiCAK1q09i+t8bSjZOmkBqLsisZ5TunnI=;
        b=V7ASFN8xPcmMywj3Kcgv//MrMb6ju5gXXwWEpOeRV8Yzv7TaLckDTzF2QLO0+8/vJM
         u4ELQ7mL2kbBBxBef9ricbfNgHPAmvcLC2KkTPykFRinLq6iVdLOvPSIZsda/O18XthD
         dTYV2cWVAIYDL5Nd+2O7MZNNkdOwkdg3b4567VfnMHFW2adn9N8VpH3lLOIDenXzWCX3
         m81K/AH4nB+wObz2pnTsCVN6Svf/Ht02RjblPOVDyAPDq6JR8cbPDDEp2m0XY6GcQ9FT
         7wyylE6jXnNfNlHp12vjW1WCVsXNHu941Kz6ULT1X3hn42VAdRA/9Isne9TivW5DEF0D
         8BWQ==
X-Gm-Message-State: AC+VfDw/HuRLqlfrxHpKH6xkiRSZCl/W6L5fgPtY/6/CYm7CCGxu8PRN
        USXxQ17W15gzClEUTmet6+1Wpubhy4feSiSEVoZuGA==
X-Google-Smtp-Source: ACHHUZ6nzLPGnzZPboyCjfZB6dkHgwQ8o7cnJBZBAjEhvEwyZ8lAukKjmhYaxco0zZ6KKZvhESQvDxTx5qHEWEA7bLo=
X-Received: by 2002:a05:6214:27c7:b0:621:54d:23e1 with SMTP id
 ge7-20020a05621427c700b00621054d23e1mr512241qvb.14.1686076727359; Tue, 06 Jun
 2023 11:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230606094159.1910369-1-masahiroy@kernel.org>
 <CAKwvOdkfQiu-Y29xiOMERxnSy9aqN851AoogGYrnqdc4dcaHOA@mail.gmail.com> <CAK7LNASheifemHTT-cNputbMv7th+NT8XUBu2a9ZMcu5jZMe3g@mail.gmail.com>
In-Reply-To: <CAK7LNASheifemHTT-cNputbMv7th+NT8XUBu2a9ZMcu5jZMe3g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 6 Jun 2023 11:38:36 -0700
Message-ID: <CAKwvOdmxCQbgKoTZXFLNFmq6MCdJGcJaiWp0mrXHQS46tQ8uvA@mail.gmail.com>
Subject: Re: [PATCH] modpost: propagate W=1 build option to modpost
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Tue, Jun 6, 2023 at 10:21=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Wed, Jun 7, 2023 at 1:56=E2=80=AFAM Nick Desaulniers <ndesaulniers@goo=
gle.com> wrote:
> >
> > On Tue, Jun 6, 2023 at 2:42=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> > >
> > > "No build warning" is a strong requirement these days, so you must fi=
x
> > > all issues before enabling a new warning flag.
> > >
> > > We often add a new warning to W=3D1 first so that the kbuild test rob=
ot
> > > blocks new breakages.
> > >
> > > This commit allows modpost to show extra warnings only when W=3D1
> > > (or KBUILD_EXTRA_WARN=3D1) is given.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > Patch seems fine, but without anyone reading extra_warn, I'm curious
> > what new extra warnings you had in mind were?
>
>
> This one.
>
> https://lore.kernel.org/linux-kbuild/CAK7LNAR0uMvf+k7LPXtMjigKFPeNu5m5EhA=
kvk2RVRHkdjdbdg@mail.gmail.com/T/#m0f41f2c8fe843133ce8100088443491a51d496af

Yeah, ok so we'll guard that warning on this extra_warn then? Seems fine.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>
> > > ---
> > >
> > >  scripts/Makefile.modpost | 1 +
> > >  scripts/mod/modpost.c    | 7 ++++++-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> > > index 0980c58d8afc..074e27c0c140 100644
> > > --- a/scripts/Makefile.modpost
> > > +++ b/scripts/Makefile.modpost
> > > @@ -47,6 +47,7 @@ modpost-args =3D                                   =
                                             \
> > >         $(if $(KBUILD_MODPOST_WARN),-w)                              =
                   \
> > >         $(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))                  =
                   \
> > >         $(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD=
_NSDEPS),-N)       \
> > > +       $(if $(findstring 1, $(KBUILD_EXTRA_WARN)),-W)               =
                   \
> > >         -o $@
> > >
> > >  modpost-deps :=3D $(MODPOST)
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index d10f5bdcb753..3ea5eb2b1029 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -42,6 +42,8 @@ static bool allow_missing_ns_imports;
> > >
> > >  static bool error_occurred;
> > >
> > > +static bool extra_warn;
> > > +
> > >  /*
> > >   * Cut off the warnings when there are too many. This typically occu=
rs when
> > >   * vmlinux is missing. ('make modules' without building vmlinux.)
> > > @@ -2199,7 +2201,7 @@ int main(int argc, char **argv)
> > >         LIST_HEAD(dump_lists);
> > >         struct dump_list *dl, *dl2;
> > >
> > > -       while ((opt =3D getopt(argc, argv, "ei:mnT:o:awENd:")) !=3D -=
1) {
> > > +       while ((opt =3D getopt(argc, argv, "ei:mnT:o:aWwENd:")) !=3D =
-1) {
> > >                 switch (opt) {
> > >                 case 'e':
> > >                         external_module =3D true;
> > > @@ -2224,6 +2226,9 @@ int main(int argc, char **argv)
> > >                 case 'T':
> > >                         files_source =3D optarg;
> > >                         break;
> > > +               case 'W':
> > > +                       extra_warn =3D true;
> > > +                       break;
> > >                 case 'w':
> > >                         warn_unresolved =3D true;
> > >                         break;
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Thanks,
~Nick Desaulniers
