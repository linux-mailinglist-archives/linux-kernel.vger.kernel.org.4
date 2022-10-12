Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F8A5FC9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiJLRBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJLRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:01:43 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A033FE76A;
        Wed, 12 Oct 2022 10:01:38 -0700 (PDT)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 29CH1ISF017124;
        Thu, 13 Oct 2022 02:01:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 29CH1ISF017124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665594079;
        bh=9saPNRzuvDvRHK1YNv59X/1+gtLiAZaFDJ8ppwKaEVI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yufBU1EF+ZwKQNflOvempvO3JaUkYwCxAWnDlawRuJay+ILp5aiUBCHsfo3VmBnT5
         NE20Js4zPU4rpaKvKWColwCUesnKF2NFRFUi2OzQwHDwHTpkY3AiuUeM6VNJaehhW3
         nDFf5DZcmQappTzjW1ouM/+HupEWvvDxTPV4UjelP8Pjht5DYKLHLJ6UucPkdQWh20
         PQDxusvtfNH7Z4nxL+aB+I1ZL7/e4t6sgSUYdLJ8Zk81DGcjQWN1mYgB21HlbgkSiT
         EdV9xRlJ0PnzPnZ5RzQxYIdEeCNeWgo69qNPpjIn06RISyfwS8E5UyClB9xttAUwU+
         fZEFFZ0bjmg0g==
X-Nifty-SrcIP: [209.85.167.171]
Received: by mail-oi1-f171.google.com with SMTP id n83so19693667oif.11;
        Wed, 12 Oct 2022 10:01:18 -0700 (PDT)
X-Gm-Message-State: ACrzQf0SB5r/Rjg++y3+I4841diZDplNnVFHROxelEHKATE1V1a2AmEe
        AyK4yQ8zFPRjDpdLGc7iuQLsKDroi28to5peD8A=
X-Google-Smtp-Source: AMsMyM6gS8lYK3kcRtzIRG0CGUW5YKNXxxcLA5mQfjShIzxVS+My7E5iySiw0PqqG1YXRHCXzLvs9eL9P5hXj4yfPUs=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr2614501oib.194.1665594077719; Wed, 12
 Oct 2022 10:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221004162905.24997-1-masahiroy@kernel.org> <20221004162905.24997-3-masahiroy@kernel.org>
In-Reply-To: <20221004162905.24997-3-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Oct 2022 02:00:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQHo_BvGfp=V-TNAmUjOxgbL5xbVh7C6e0puUnThcK7Lw@mail.gmail.com>
Message-ID: <CAK7LNAQHo_BvGfp=V-TNAmUjOxgbL5xbVh7C6e0puUnThcK7Lw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Kconfig.debug: split debug-level and DWARF-version
 into separate choices
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote=
:
>
> Commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from
> a choice") added CONFIG_DEBUG_INFO_NONE into the DWARF version choice,
> but it should rather belong to the debug level choice.
>
> This commit consolidates CONFIG options into two choices:
>
>  - Debug info level (NONE / REDUCED / DEFAULT)
>
>  - DWARF format (DWARF_TOOLCHAIN_DEFAULT / DWARF4 / DWARF5)
>
> This is more consistent with compilers' policy because the -g0 compiler
> flag means "no debug info".
>
>   GCC manual:
>
>     -g<level>
>
>       Request debugging information and also use level to specify how
>       much information. The default level is 2.
>
>       Level 0 produces no debug information at all. Thus, -g0 negates -g.
>
>       Level 1 produces minimal information, enough for making backtraces
>       in parts of the program that you don=E2=80=99t plan to debug. ...
>
>       Level 3 includes extra information, such as all the macro
>       definitions present in the program. ...
>
>   Rustc Codegen manual:
>
>     debuginfo
>
>       This flag controls the generation of debug information. It takes
>       one of the following values:
>
>       0: no debug info at all (the default).
>       1: line tables only.
>       2: full debug info.
>
> I moved CONFIG_DEBUG_INFO_REDUCED into the debug level choice.
>
> This change will make it easier to add another debug info level if
> necessary.



The intent of this patch was a ground-work for adding
CONFIG_DEBUG_LEVEL_FULL or something, but
Dmitrii retracted the patch for macro debugging. [1]

I will not apply this for now.
If we get into a situation that needs more debug info,
let's revisit it.


[1] https://lore.kernel.org/linux-kbuild/CANXV_XwgZMCGXijfoUyZ9+KyM6Rgeqiq-=
sCfubyj_16d-2CN=3DA@mail.gmail.com/T/#m9309ac112b5b449da7401838841e619e06d1=
566c




>
> Update defconfig files accordingly. This includes the fixes for commit
> f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO selectable from a choice").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> ---


--=20
Best Regards
Masahiro Yamada
