Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737FD5FC9B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJLREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJLREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:04:00 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510E41CB25;
        Wed, 12 Oct 2022 10:03:59 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 29CH3imf029337;
        Thu, 13 Oct 2022 02:03:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 29CH3imf029337
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665594225;
        bh=gJFvJD5Toog9MSkzt/sgw8zJUGXxC6L2j5lcvOuhyvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FPmni/c29hTC74FYjRoka6FdYhSZe1ihxsJcxid+CqNTlumTIoOtwq6V26BPasqOF
         Y6hCNg2y2XJcTAinAXX+SVQolNxlQcUfdwjnbEqd3pezUewn1IwNUCr7hOJfKGZmXA
         190G8iCtMC50y6EZiIGSmCNyctcDTvV7/Ef8rxY35p9KwS7T+cCs86GVXKJto13u2q
         692V2pSsOjOTpvEe1OE/IRQp+Bru+guE/U5agL58do/PSF53oVjlzGT0Zor7ba6TH2
         FWolRNggit22kwZQ+6lVmtUeUF6QnPeF7jgb1v7kfMiUl8pBGgCAXO/xN5EYuS/Pk0
         imsVLXZtyjFBg==
X-Nifty-SrcIP: [209.85.167.180]
Received: by mail-oi1-f180.google.com with SMTP id u15so13822917oie.2;
        Wed, 12 Oct 2022 10:03:45 -0700 (PDT)
X-Gm-Message-State: ACrzQf38LyT4f3HK9bTAfCbDnNUMb5fly6id6M0JfP9Em9eQQZ6ww2UA
        InwOSWh1XRK8JsR/Dkhy9KPn2NCfWS3tXGiTg4I=
X-Google-Smtp-Source: AMsMyM77GatT3gECuVsuDHWuGP7T8aoZ5IGgwm+DSWdTKTNVGyt2580CFjAUOuEjW2JlMjodOZGrHfbZ4tPWgTbS6qc=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr2622350oib.194.1665594224127; Wed, 12
 Oct 2022 10:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221004162905.24997-1-masahiroy@kernel.org> <20221004162905.24997-2-masahiroy@kernel.org>
In-Reply-To: <20221004162905.24997-2-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 13 Oct 2022 02:03:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNASeVxHhgdmSWadqF_t-zNPfuZa-NADg37pbosZGOikK-A@mail.gmail.com>
Message-ID: <CAK7LNASeVxHhgdmSWadqF_t-zNPfuZa-NADg37pbosZGOikK-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] Kconfig.debug: add toolchain checks for DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT does not give explicit
> -gdwarf-* flag. The actual DWARF version is up to the toolchain.
>
> The combination of GCC and GAS works fine, and Clang with the integrated
> assembler is good too.
>
> The combination of Clang and GAS is tricky, but at least, the -g flag
> works for Clang <=13, which defaults to DWARF v4.
>
> Clang 14 switched its default to DWARF v5.
>
> Now, CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT has the same issue as
> addressed by commit 98cd6f521f10 ("Kconfig: allow explicit opt in to
> DWARF v5").
>
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y for Clang >= 14 and
> GAS < 2.35 produces a ton of errors like follows:
>
>   /tmp/main-c2741c.s: Assembler messages:
>   /tmp/main-c2741c.s:109: Error: junk at end of line, first unrecognized character is `"'
>   /tmp/main-c2741c.s:109: Error: file number less than one
>
> Add 'depends on' to check toolchains.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> ---

Applied to linux-kbuild.



> (no changes since v1)
>
>  lib/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f4b2165f24db..cc90414d492e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -253,6 +253,7 @@ config DEBUG_INFO_NONE
>  config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
>         bool "Rely on the toolchain's implicit default DWARF version"
>         select DEBUG_INFO
> +       depends on !CC_IS_CLANG || AS_IS_LLVM || CLANG_VERSION < 140000 || (AS_IS_GNU && AS_VERSION >= 23502)
>         help
>           The implicit default version of DWARF debug info produced by a
>           toolchain changes over time.
> --
> 2.34.1
>


-- 
Best Regards
Masahiro Yamada
