Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE938740BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjF1ImY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbjF1IjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1C0358A;
        Wed, 28 Jun 2023 01:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF2E6131F;
        Wed, 28 Jun 2023 07:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7459C433CC;
        Wed, 28 Jun 2023 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687936222;
        bh=anrABNLH1B5VmYnoNV4fxFNHWXz9Qs7iNp8YB+h3NDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SVGhRdHc7voHRN7iPtu1K0UNzNEpyXh+VA44LNjfLfDbV1iW+9/Kf4od9Cbwhe59O
         yOuOzknF3g0Mx2pCfFhsttHmmGD34pzMCB2s9Y4JEDDX+deWPwSvTVK1Zq0EEVVG7U
         a6nnBdl5RtU1RXDA8UKZMz80mw3RHUHU4gH+uSvrt7qf0MZIivHlxYygFgYrVe2807
         bHWvbMaMXh7WipkXvLsIEEgfRx3++riD9RHQhV3xqNopNCtv4X5AiwYdIL+6lOE0x8
         /ERGKkjmbl5WQrkFM+qYBWteqxdHl6KoFHhS+G30PD33NM7bpcQFIDu/ZehyYqiWpd
         GoMAq3CDZJocw==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-39eab4bbe8aso3903697b6e.1;
        Wed, 28 Jun 2023 00:10:22 -0700 (PDT)
X-Gm-Message-State: AC+VfDzVLtzdZtaeovf3coL8w8KQ/D7NehjO2NIT2mSYYT2t6zLaGS+k
        M7p4P78IMCtsx+BuyVhnakOps5yuST8GIO6L1YE=
X-Google-Smtp-Source: ACHHUZ4NupDIdxy4l7CGyjCTJaoOVdc4PpoS++lnjD56J+LwueuzJxCVgOU0PYXIaPH4Hhr4mxylAGJEn9GYJImoJnE=
X-Received: by 2002:a05:6808:1141:b0:3a3:69de:d385 with SMTP id
 u1-20020a056808114100b003a369ded385mr249269oiu.6.1687936222114; Wed, 28 Jun
 2023 00:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230626233014.66549-1-masahiroy@kernel.org> <20230626233014.66549-3-masahiroy@kernel.org>
In-Reply-To: <20230626233014.66549-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 28 Jun 2023 16:09:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtUBZo0bczb=bQyQ6UrXbK7V4Bp058+wzZQp3QREfniQ@mail.gmail.com>
Message-ID: <CAK7LNATtUBZo0bczb=bQyQ6UrXbK7V4Bp058+wzZQp3QREfniQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] kbuild: respect GNU Make -w flag
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nicolas Schier <n.schier@avm.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, Jun 27, 2023 at 8:30=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Currently, -w (--print-directory) option is ignored, but it is better
> to respect the user's choice.
>
> This commit changes the behavior of "Entering directory ..." logging.
>
> If -w (or --print-directory) is given via the command line or the
> MAKEFLAGS environment variable, print "Entering directory ..." for every
> sub make.
>
> If --no-print-directory is given via the command line or the MAKEFLAGS
> environment variable, suppress "Entering directory ..." completely.
>
> If none of them is given, print "Entering directory ..." when Kbuild
> changes the working directory at the start of building. (default)
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Nicolas Schier <n.schier@avm.de>
> ---


As it turns out, this patch does not work for GNU Make <=3D 4.3

I will drop (and give up) this patch.






>
> (no changes since v2)
>
> Changes in v2:
>   - new patch
>
>  Makefile | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 7edb00603b7e..c9864f83a3d2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -38,6 +38,12 @@ __all:
>  # descending is started. They are now explicitly listed as the
>  # prepare rule.
>
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts :=3D $(firstword -$(MAKEFLAGS))
> +else
> +short-opts :=3D $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
>  this-makefile :=3D $(lastword $(MAKEFILE_LIST))
>  export abs_srctree :=3D $(realpath $(dir $(this-makefile)))
>  export abs_objtree :=3D $(CURDIR)
> @@ -95,12 +101,6 @@ endif
>  # commands
>  # make-4.0 (and later) keep single letter options in the 1st word of MAK=
EFLAGS.
>
> -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> -short-opts :=3D $(firstword -$(MAKEFLAGS))
> -else
> -short-opts :=3D $(filter-out --%,$(MAKEFLAGS))
> -endif
> -
>  ifneq ($(findstring s,$(short-opts)),)
>  quiet=3Dsilent_
>  override KBUILD_VERBOSE :=3D
> @@ -215,12 +215,16 @@ else
>  need-sub-make :=3D 1
>  endif
>
> +ifeq ($(findstring w, $(short-opts)),)
>  ifeq ($(filter --no-print-directory, $(MAKEFLAGS)),)
>  # If --no-print-directory is unset, recurse once again to set it.
>  # You may end up recursing into __sub-make twice. This is needed due to =
the
>  # behavior change in GNU Make 4.4.1.
>  need-sub-make :=3D 1
>  endif
> +else
> +no-print-directory :=3D
> +endif
>
>  ifeq ($(need-sub-make),1)
>
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
