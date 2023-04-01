Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500796D31A8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDAO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDAO4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:56:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937A7EC75;
        Sat,  1 Apr 2023 07:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB230CE069F;
        Sat,  1 Apr 2023 14:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2203EC433D2;
        Sat,  1 Apr 2023 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680360981;
        bh=awcFRuybsjG7V1yoOQEq6yxMywQiexUnZztIgCkbuvY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JI6fuOOhku3cIQOC0Yi3p1FXZ7n4ue733hjNAVA5OYou31YtDRPhzOvbP6qSVrjE4
         cK2RSNgG3FreD/wU9MRjyktHWqvv4Y1Oslny+5dQvV4sX9osP3eMu889PaizVIDXyg
         uEULaQBdF1CLO3R8gg/GU22ehCjSiljQEMW6gsdM2gpjonpSfJnd5xNEnXBh8dB0Mm
         SF++bTVCtqcTBy6ufoR/3yyBtAAd0lWv7AO6DitDX+W5dhMiHN6ahZr9V6qP8Mx9/r
         AgO4sPZRmbBs03uVQ/uf75y5+McgCMlh9IUrHQ7mnH1YRikSQPXwXsVikXzjOVQg1a
         KHvf7YXcJhc3Q==
Received: by mail-oi1-f173.google.com with SMTP id l18so18771532oic.13;
        Sat, 01 Apr 2023 07:56:21 -0700 (PDT)
X-Gm-Message-State: AO0yUKUZSrWmFDednvlwtRWBbJ5f+WnkJVjqmAm2hBJo0t90WPmoZO+8
        g2y2rBpnOMpW+dFz6YbL4ZZaljEEq7PVCbxekO4=
X-Google-Smtp-Source: AK7set/z+Qyl7BV15iR6ZUhSwy58as3xR/sboEmcPD5Lw3p41yW4lgoZ7JKyI1NGJDvPfrTn5Nj9Y0qdVCa2VBtgHgY=
X-Received: by 2002:a05:6808:638b:b0:386:d70b:d67c with SMTP id
 ec11-20020a056808638b00b00386d70bd67cmr7830623oib.11.1680360980348; Sat, 01
 Apr 2023 07:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230325141909.2512452-1-masahiroy@kernel.org> <ZCSZTLjhLshLBKWM@bergen.fjasle.eu>
In-Reply-To: <ZCSZTLjhLshLBKWM@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 1 Apr 2023 23:55:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkKE8X3n6Tyw1oX2g-TsLqpY54yi=ObCHfARdm02Gvyw@mail.gmail.com>
Message-ID: <CAK7LNAQkKE8X3n6Tyw1oX2g-TsLqpY54yi=ObCHfARdm02Gvyw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix package build error due to broken symlinks
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 5:02=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sat 25 Mar 2023 23:19:09 GMT, Masahiro Yamada wrote:
> > 'make deb-pkg' and 'make rpm-pkg' fail if a broken symlink exists in
> > a dirty source tree. Handle symlinks properly, and also, keep the
> > executable permission.
> >
> > Fixes: 05e96e96a315 ("kbuild: use git-archive for source package creati=
on")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/package/gen-diff-patch | 36 +++++++++++++++++++++++++---------
> >  1 file changed, 27 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-=
patch
> > index f842ab50a780..23551de92e1b 100755
> > --- a/scripts/package/gen-diff-patch
> > +++ b/scripts/package/gen-diff-patch
> > @@ -23,16 +23,34 @@ fi
> >  git -C ${srctree} status --porcelain --untracked-files=3Dall |
> >  while read stat path
> >  do
> > -     if [ "${stat}" =3D '??' ]; then
> > -
> > -             if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &=
&
> > -                     ! head -n1 .tmp_diff | grep -q "Binary files"; th=
en
> > -                     {
> > -                             echo "--- /dev/null"
> > -                             echo "+++ linux/$path"
> > -                             cat .tmp_diff | tail -n +3
> > -                     } >> ${untracked_patch}
> > +     if [ "${stat}" !=3D '??' ]; then
> > +             continue
> > +     fi
> > +
> > +     if [ -L "${path}" ]; then
> > +             {
> > +                     echo "diff --git a/${path} b/${path}"
> > +                     echo "new file mode 120000"
> > +                     echo "--- /dev/null"
> > +                     echo "+++ b/$path"
> > +                     echo "@@ -0,0 +1 @@"
> > +                     printf "+"; readlink ${path}
>
> Better quote "${path}"?


Thanks for the suggestion.

Quoting variables are correct in most cases.
But, that is not enough to generate a valid
patch when a file path contains spaces.



'git format-patch' produces a patch that
is accepted by GNU patch and also by dpkg-source.

I learned a trick from GIT source code.


If you are interested, what GIT does [1].


[1] https://github.com/git/git/commit/1a9eb3b9d50367bee8fe85022684d812816fe=
531


I will send v2 later, where I made some more efforts
to fix several corner cases even if that is not perfect.








--=20
Best Regards
Masahiro Yamada
