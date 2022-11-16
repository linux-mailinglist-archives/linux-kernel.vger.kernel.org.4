Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4962B31E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKPGKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKPGKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:10:36 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954A45F4D;
        Tue, 15 Nov 2022 22:10:35 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2AG6A8vE031772;
        Wed, 16 Nov 2022 15:10:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2AG6A8vE031772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668579009;
        bh=HogbuWt6GLH1wU6Qo0cADstmt/2VA/cK7SuQhdbfOEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FJa7ICycpG33r/5ARL2tUoOR2Frto0TO6+iof7rgcbgZCwfVXWaR4cXn5AY/CBHM1
         TAkfqGJAXO5pTq9ubbOUpZffwfzwI7D2aEd2gTAAfROzdjsVurEK1PQTdmM67sFOKt
         l9PrDQ+mqX2mEObbfWrUchP62pr9cxCPMkTn6y5DH354O6+YTa/m9IZ/73zoDVQWsl
         7Xk9JOluajE463111WRs7+GrVzpDMCT5MSiG3tcOhS3hI2ibYGiPy+KHzd2Tg0+D6g
         hgj0DrJXLL1+YRm47xGnA73j9EWzd9O5nPr/UrQM2Z+Q6dHdb6Y+DeK6uRZszG1/g1
         v/AtUV5F09TZg==
X-Nifty-SrcIP: [209.85.167.172]
Received: by mail-oi1-f172.google.com with SMTP id q186so17406931oia.9;
        Tue, 15 Nov 2022 22:10:09 -0800 (PST)
X-Gm-Message-State: ANoB5plK3ijT3gReSm8ud3ZeF/l0Sd5jX5DdQlHU9/LYrPXPCiTlkRQS
        ydfaC7HMZqHAlnGg3pZU1pAuJQmHxKaYXr9uxHU=
X-Google-Smtp-Source: AA0mqf4sdlAsDjBFboPZ6GUN5+M5FIEJDe9GHX4LSNiMXhP5K1fRigaf8Qw/JrTgtm6CoK8+lBfWE1MTy15jcIU+6vY=
X-Received: by 2002:a05:6808:3009:b0:354:94a6:a721 with SMTP id
 ay9-20020a056808300900b0035494a6a721mr844011oib.194.1668579007968; Tue, 15
 Nov 2022 22:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20221115220453.3463096-1-maz@kernel.org>
In-Reply-To: <20221115220453.3463096-1-maz@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 16 Nov 2022 15:09:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNASC6f_=ngS4NW0prvwcOribumeajW1r4q57u3LGZvuEdA@mail.gmail.com>
Message-ID: <CAK7LNASC6f_=ngS4NW0prvwcOribumeajW1r4q57u3LGZvuEdA@mail.gmail.com>
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

On Wed, Nov 16, 2022 at 7:05 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Since 2df8220cc511 ("kbuild: build init/built-in.a just once"),
> generating Debian packages using 'make bindeb-pkg' results in
> packages that are stuck to the same .version, leading to unexpected
> behaviours (multiple packages with the same version).
>
> That's because the mkdebian script samples the build version
> before building the kernel, and forces the use of that version
> number for the actual build.
>
> Restore the previous behaviour by calling init/build-version
> instead of reading the .version file. This is likely to result
> in too many .version bumps, but this is what was happening before
> (although the bump was affecting builds made after the current one).


What do you mean by "too many .version bumps"?

Every "make bindeb-pkg" increments the version by one.

Is there any case where it increases more?





> Eventually, this script should be turned into something that
> is a bit less counter-intuitive (building the kernel first
> and only then generating the packaging artefacts).


How to achieve this?

The version is recorded in debian/chanegelog.
Without it, dpkg-buildpackage fails.

In my understanding, the version must be fixed before building the kernel.








>
> Fixes: 2df8220cc511 ("kbuild: build init/built-in.a just once")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> ---
>
> Notes:
>     v2: Drop the RPM version which was wrong, and make the path
>         relative to $srctree.
>
>  scripts/package/mkdebian | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> index 60a2a63a5e90..a3ac5a716e9f 100755
> --- a/scripts/package/mkdebian
> +++ b/scripts/package/mkdebian
> @@ -90,7 +90,7 @@ if [ -n "$KDEB_PKGVERSION" ]; then
>         packageversion=$KDEB_PKGVERSION
>         revision=${packageversion##*-}
>  else
> -       revision=$(cat .version 2>/dev/null||echo 1)
> +       revision=$($srctree/init/build-version)
>         packageversion=$version-$revision
>  fi
>  sourcename=$KDEB_SOURCENAME
> --
> 2.34.1
>


--
Best Regards
Masahiro Yamada
