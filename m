Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449796290E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 04:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiKODhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 22:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiKODhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:37:13 -0500
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B306813EA2;
        Mon, 14 Nov 2022 19:37:12 -0800 (PST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 2AF3agF9022440;
        Tue, 15 Nov 2022 12:36:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 2AF3agF9022440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668483403;
        bh=oBttZhSIf70D6wOgqtArJRhEfxuGyhQuhT7IykI+c5U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r46cGzSsmIaSUCz+k4P2UvFK9znaVWmakaUSjUjwumWT4Q8tbQUEQtBQh8z58TuTJ
         PhaUrn64erXZ3HLV7wJP0OqATzJthnZMuwWscOIcOMgY9DG9yQNUq5ZZdF+NFi65nP
         M7uwYwBTMgFvihgGoFaS+LvGeF07DZYlzoy0BzYMo6y0dZFkMvTdVnI2E0eHespR8q
         MiajGtgBNaLhoPCg+Q5NILOJlk+d35L3tnL7eRaYgwfrHJCRQQkz1jdmovJqissLr/
         yU532ymxImYvXf9O3Tvs+TRzzS9sbPUWrSWFdSpq9RPiu0gNVShH0SPQ0UjF/xDiCE
         80Z2sTn5/zktg==
X-Nifty-SrcIP: [209.85.167.170]
Received: by mail-oi1-f170.google.com with SMTP id n186so13596057oih.7;
        Mon, 14 Nov 2022 19:36:42 -0800 (PST)
X-Gm-Message-State: ANoB5plgb2pCjE4mYmrCL7fvkNxkJAjdYQPDj6AvxXiEE8tPPnErUGvx
        SYcqGnVJEistLOnACosseK8UDakRg0vUSnVIJfo=
X-Google-Smtp-Source: AA0mqf7mqtN8YcQyFpHOOnlQguXH+pnYodUhzdIjcOeE4bXA+rHNuKEl6G0nqVdjVY+HLCP++OVNVRPPLGp6BYj2HyE=
X-Received: by 2002:a05:6808:1451:b0:354:94a6:a721 with SMTP id
 x17-20020a056808145100b0035494a6a721mr25034oiv.194.1668483401717; Mon, 14 Nov
 2022 19:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20221113160237.3152770-1-maz@kernel.org> <CAK7LNASoWbJ458zLTP6NuC+5Q+YHOdzVOeCKQ3MeyXQYrkjneg@mail.gmail.com>
In-Reply-To: <CAK7LNASoWbJ458zLTP6NuC+5Q+YHOdzVOeCKQ3MeyXQYrkjneg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 15 Nov 2022 12:36:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3KmNZD0Lw4F4aKF1k_No4ZeomChjy2t59WD1s8vESrw@mail.gmail.com>
Message-ID: <CAK7LNAT3KmNZD0Lw4F4aKF1k_No4ZeomChjy2t59WD1s8vESrw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Restore .version auto-increment behaviour for
 Debian/RPM packages
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

On Tue, Nov 15, 2022 at 9:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Mon, Nov 14, 2022 at 1:02 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
> > index 60a2a63a5e90..e5c983afddab 100755
> > --- a/scripts/package/mkdebian
> > +++ b/scripts/package/mkdebian
> > @@ -90,7 +90,7 @@ if [ -n "$KDEB_PKGVERSION" ]; then
> >         packageversion=$KDEB_PKGVERSION
> >         revision=${packageversion##*-}
> >  else
> > -       revision=$(cat .version 2>/dev/null||echo 1)
> > +       revision=$(init/build-version)
>
>
> This does not work for out-of-tree builds
> because init/build-version is a check-in source file.
>
>
>
> For example, "make O=/tmp/foo bindeb-pkg" fails with:
> .../linux/scripts/package/mkdebian: 93: init/build-version: not found
>
>
> The correct code is:
>
>
>           revision=$($srctree/init/build-version)
>
>
>
>
> >         packageversion=$version-$revision
> >  fi
> >  sourcename=$KDEB_SOURCENAME
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index 70392fd2fd29..9cbd45f497ba 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -42,7 +42,7 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
> >         Name: kernel
> >         Summary: The Linux Kernel
> >         Version: $__KERNELRELEASE
> > -       Release: $(cat .version 2>/dev/null || echo 1)
> > +       Release: $(init/build-version)
>
>
> Ditto.
>
>           Release: $($srctree/init/build-version)



No, mkspec needs no change because binrpm-pkg builds the kernel
_before_ generating the spec file.

If you increment the .version file here again, you would have
the revision mismatch between the package and the actual vmlinuz.



Please send the change for mkdebian only.



>
>
>
>
> >         License: GPL
> >         Group: System Environment/Kernel
> >         Vendor: The Linux Community
> > --
> > 2.34.1
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Best Regards
Masahiro Yamada
