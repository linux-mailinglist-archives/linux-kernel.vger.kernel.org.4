Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCA4636C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 22:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbiKWVTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 16:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237514AbiKWVTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 16:19:05 -0500
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E686153D;
        Wed, 23 Nov 2022 13:19:03 -0800 (PST)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 2ANLIZtB011371;
        Thu, 24 Nov 2022 06:18:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 2ANLIZtB011371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669238316;
        bh=JaNFLVtpV/R2YcJ5P3G75gE6eDlCUl66VDKvTIO+Uto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nm4BQHt/aNubjM0c0XRsqsGCStBmXbgMiUQduWj4yG/7odqRlLtx3FB/UqvtEuuml
         D94xgG8JGi8Wzl9hK9CSZOAWhaPUMp2HFrfzMh7Sl9qhcSp0whk8sgwZgoSG3ixeU3
         ITYjV5becHZGev8v59yUYNCnaPnt55Z+JQX8M5DON5mMIafwhXTJYQKCJ1kIOSywQ1
         k0sX61l3Bd1hpRMrTi56qUxwQytnU8FfpE1FISy9kO4Hq/PgTwmW3XgKJdsZw/VCH1
         Mo7KhZkDkaXJooN19rr6atSI/LvVcpjm2WWdOIibv1j/En8Qm6ikYX3WVdSR9OBpwZ
         ZlBLjJgmnszRg==
X-Nifty-SrcIP: [209.85.160.47]
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-14286d5ebc3so18981557fac.3;
        Wed, 23 Nov 2022 13:18:36 -0800 (PST)
X-Gm-Message-State: ANoB5pnCWLO5H94JWa3G3huPOtA6vc/vlkxAkfOahfzb/+/RLrYrMlLW
        UoqoXb90wI/tZxJJ+qu/b7y49iojrhPJrOaS5JA=
X-Google-Smtp-Source: AA0mqf5+9n103gtVjj2U0+Y5pS++GUYYMT8oQPohQ8QyssNwg8NbY1AtMDegi1EXNw5mYeZhkWoEM+JWSjjEDJ2ODjA=
X-Received: by 2002:a05:6870:ea8e:b0:13b:a31f:45fd with SMTP id
 s14-20020a056870ea8e00b0013ba31f45fdmr19803930oap.194.1669238315233; Wed, 23
 Nov 2022 13:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20221123151828.509565-1-masahiroy@kernel.org> <20221123151828.509565-2-masahiroy@kernel.org>
 <Y36Ef3ie05YO1moS@bergen.fjasle.eu>
In-Reply-To: <Y36Ef3ie05YO1moS@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Nov 2022 06:17:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT+aNeG6FDdQw8=ZUpmbVUjr9DgwMMF4gOCTczECMTRGA@mail.gmail.com>
Message-ID: <CAK7LNAT+aNeG6FDdQw8=ZUpmbVUjr9DgwMMF4gOCTczECMTRGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kbuild: implement {gcc,clang}-min-version only
 with built-in functions
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 5:37 AM Nicolas Schier <nicolas@fjasle.eu> wrote:
>
> On Thu 24 Nov 2022 00:18:25 GMT, Masahiro Yamada wrote:
> > Converting clang-min-version is straightforward because the versions
> > are always 6-digit.
> >
> > gcc-min-version is somewhat tricky because the minimal GCC version
> > is GCC 5.2; prepend '0' to the version that is less than 10 so that
> > test-ge is always passed with 6-digit versions.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v2:
> >   - Covert gcc-min-version in a different way
> >
> >  scripts/Makefile.compiler | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
> > index 20d353dcabfb..cd75f81e88ef 100644
> > --- a/scripts/Makefile.compiler
> > +++ b/scripts/Makefile.compiler
> > @@ -63,11 +63,15 @@ cc-disable-warning = $(call try-run,\
> >
> >  # gcc-min-version
> >  # Usage: cflags-$(call gcc-min-version, 70100) += -foo
> > -gcc-min-version = $(shell [ $(CONFIG_GCC_VERSION)0 -ge $(1)0 ] && echo y)
> > +
> > +# Preprend 0 to the version that is less than 10 so test-ge works.
> > +gcc-min-version = $(call test-ge, \
> > +                  $(or $(filter 1%, $(CONFIG_GCC_VERSION)), 0$(CONFIG_GCC_VERSION)), \
> > +                  $(or $(filter 1%, $1), 0$(strip $1)))
>
> Hm, this silently expects a gcc version < 20, which we should expect in
> about seven-eight years [1].   I am thinking about the possibility of
> silent (but unlikely) breaks when someone in far future uses a gcc 20
> against a kernel with this line.  Probably we should not care about
> that today, yet, right?

Yeah, I thought of it.

It depends on which of the following two will happen first.

 (a) We raise the min gcc version to 10.0.0 and remove this hack
 (b) GCC 20 is released

I am guessing (a) will occur first, so we do not need to care about (b).


If (b) happens first, we will need to add "2%".
It means that the window of supported GCC versions will get larger than 10.
Presumably, we do not want to support such a wide range of compiler
versions.


GCC 5.1 was released in 2015.
So, the current window of GCC versions is 7 years.
I hope it will not get even larger...





-- 
Best Regards
Masahiro Yamada
