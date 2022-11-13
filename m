Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D13626F15
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 11:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiKMK45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 05:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbiKMK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 05:56:55 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA66DF77;
        Sun, 13 Nov 2022 02:56:53 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2ADAuOqj025190;
        Sun, 13 Nov 2022 19:56:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2ADAuOqj025190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1668336984;
        bh=3lroTYPLdZ6KmdOa3X3ieElkYRU7E3cRWhwiDGRC/Xs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=reaMttsHfQELxhSCXtKGaEgPpb2BKmS8OOLZSAJnMksPKUVBDQ9u2uhYDKw1S98Io
         2P/crtM0II+Kpw8dULgLeclga5KL7XHNsPwOT5nB7whviZKfG3UdvAO5b7/CT7fngt
         ddmKx1Cvda4bHLNnVuvOU8kZXbNddlbOIcIJtdiLYmwyChLG4vHVFjLZWxHyphH67m
         xz0CWH56zvEHPql+vTydpleXuq1XLmZGXeEt4/uhEsZw3PJ/jTkl3XvETUAdt+aGsx
         5Q499mco8ZTAvelEIEPfXqLo6eSYx2hPx5lhVD0DjvCbwo7dEoVds28ff0Qr4ztrmH
         Yx8SWdmCL4O2A==
X-Nifty-SrcIP: [209.85.167.178]
Received: by mail-oi1-f178.google.com with SMTP id r76so8881676oie.13;
        Sun, 13 Nov 2022 02:56:24 -0800 (PST)
X-Gm-Message-State: ANoB5plOBUYvCiyp6cfrBWL8AZMYHBdlXKMKujrWgnw4+xNJNVT69Ftf
        5FBjdOrpHUhnyUEnJ7QkHAQo+WMASoJGZ666yw0=
X-Google-Smtp-Source: AA0mqf7lS2bqisgYU1s4FVkKaHvvwU217yoaddBFVyl3nCpq3flH/juqwqhZbsDEDwuOFbLRjBbagcSxAyOL+lYmoLI=
X-Received: by 2002:a05:6808:208c:b0:354:94a6:a721 with SMTP id
 s12-20020a056808208c00b0035494a6a721mr3937365oiw.194.1668336983486; Sun, 13
 Nov 2022 02:56:23 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUW83H0H-oQkE5vyURWu6bD-OGYpTsNMwU1if5r=7+tpDA@mail.gmail.com>
 <20221110195932.377841-1-ndesaulniers@google.com>
In-Reply-To: <20221110195932.377841-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 13 Nov 2022 19:55:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATtt9Ot5D2rJLC=gpvBFEE70Vct+gX4UKw13F7=UqO1XQ@mail.gmail.com>
Message-ID: <CAK7LNATtt9Ot5D2rJLC=gpvBFEE70Vct+gX4UKw13F7=UqO1XQ@mail.gmail.com>
Subject: Re: [PATCH v3] Makefile.debug: support for -gz=zstd
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Fangrui Song <maskray@google.com>,
        Sedat Dilek <sedat.dilek@dhl.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Terrell <terrelln@fb.com>, Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Gow <davidgow@google.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 5:00 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Make DEBUG_INFO_COMPRESSED a choice; DEBUG_INFO_COMPRESSED_NONE is the
> default, DEBUG_INFO_COMPRESSED_ZLIB uses zlib,
> DEBUG_INFO_COMPRESSED_ZSTD uses zstd.
>
> This renames the existing KConfig option DEBUG_INFO_COMPRESSED to
> DEBUG_INFO_COMPRESSED_ZLIB so users upgrading may need to reset the new
> Kconfigs.
>
> Some quick N=1 measurements with du, /usr/bin/time -v, and bloaty:
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_NONE=y:
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:55.43
> 488M vmlinux
> 27.6%   136Mi   0.0%       0    .debug_info
>  6.1%  30.2Mi   0.0%       0    .debug_str_offsets
>  3.5%  17.2Mi   0.0%       0    .debug_line
>  3.3%  16.3Mi   0.0%       0    .debug_loclists
>  0.9%  4.62Mi   0.0%       0    .debug_str
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZLIB=y:
> Elapsed (wall clock) time (h:mm:ss or m:ss): 1:00.35
> 385M vmlinux
> 21.8%  85.4Mi   0.0%       0    .debug_info
>  2.1%  8.26Mi   0.0%       0    .debug_str_offsets
>  2.1%  8.24Mi   0.0%       0    .debug_loclists
>  1.9%  7.48Mi   0.0%       0    .debug_line
>  0.5%  1.94Mi   0.0%       0    .debug_str
>
> clang-16, x86_64 defconfig plus
> CONFIG_DEBUG_INFO=y CONFIG_DEBUG_INFO_COMPRESSED_ZSTD=y:
> Elapsed (wall clock) time (h:mm:ss or m:ss): 0:59.69
> 373M vmlinux
> 21.4%  81.4Mi   0.0%       0    .debug_info
>  2.3%  8.85Mi   0.0%       0    .debug_loclists
>  1.5%  5.71Mi   0.0%       0    .debug_line
>  0.5%  1.95Mi   0.0%       0    .debug_str_offsets
>  0.4%  1.62Mi   0.0%       0    .debug_str
>
> That's only a 3.11% overall binary size savings over zlib, but at no
> performance regression.
>
> Link: https://maskray.me/blog/2022-09-09-zstd-compressed-debug-sections
> Link: https://maskray.me/blog/2022-01-23-compressed-debug-sections
> Suggested-by: Sedat Dilek (DHL Supply Chain) <sedat.dilek@dhl.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---




Applied to linux-kbuild.
Thanks.




> Changes v2 -> v3:
> * Fix scripts/Makefile.debug as per Sedat.
> * Update commit message as per Nicolas.
>
> Changes v1 -> v2:
> * Remove `depends on DEBUG_KERNEL` as per Nathan.
> * Rename Kconfigs as per Sedat and Masahiro.
> * Add note about renamed Kconfigs to commit message.
> * Add more help text to DEBUG_INFO_COMPRESSED_ZSTD.
>
>
>  lib/Kconfig.debug      | 29 +++++++++++++++++++++++++++--
>  scripts/Makefile.debug |  6 +++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 29280072dc0e..7c28a8fba02e 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -312,8 +312,21 @@ config DEBUG_INFO_REDUCED
>           DEBUG_INFO build and compile times are reduced too.
>           Only works with newer gcc versions.
>
> -config DEBUG_INFO_COMPRESSED
> -       bool "Compressed debugging information"
> +choice
> +       prompt "Compressed Debug information"
> +       help
> +         Compress the resulting debug info. Results in smaller debug info sections,
> +         but requires that consumers are able to decompress the results.
> +
> +         If unsure, choose DEBUG_INFO_COMPRESSED_NONE.
> +
> +config DEBUG_INFO_COMPRESSED_NONE
> +       bool "Don't compress debug information"
> +       help
> +         Don't compress debug info sections.
> +
> +config DEBUG_INFO_COMPRESSED_ZLIB
> +       bool "Compress debugging information with zlib"
>         depends on $(cc-option,-gz=zlib)
>         depends on $(ld-option,--compress-debug-sections=zlib)
>         help
> @@ -327,6 +340,18 @@ config DEBUG_INFO_COMPRESSED
>           preferable to setting $KDEB_COMPRESS to "none" which would be even
>           larger.
>
> +config DEBUG_INFO_COMPRESSED_ZSTD
> +       bool "Compress debugging information with zstd"
> +       depends on $(cc-option,-gz=zstd)
> +       depends on $(ld-option,--compress-debug-sections=zstd)
> +       help
> +         Compress the debug information using zstd.  This may provide better
> +         compression than zlib, for about the same time costs, but requires newer
> +         toolchain support.  Requires GCC 13.0+ or Clang 16.0+, binutils 2.40+, and
> +         zstd.
> +
> +endchoice # "Compressed Debug information"
> +
>  config DEBUG_INFO_SPLIT
>         bool "Produce split debuginfo in .dwo files"
>         depends on $(cc-option,-gsplit-dwarf)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 332c486f705f..059ff38fe0cb 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -27,10 +27,14 @@ else
>  DEBUG_RUSTFLAGS        += -Cdebuginfo=2
>  endif
>
> -ifdef CONFIG_DEBUG_INFO_COMPRESSED
> +ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZLIB
>  DEBUG_CFLAGS   += -gz=zlib
>  KBUILD_AFLAGS  += -gz=zlib
>  KBUILD_LDFLAGS += --compress-debug-sections=zlib
> +else ifdef CONFIG_DEBUG_INFO_COMPRESSED_ZSTD
> +DEBUG_CFLAGS   += -gz=zstd
> +KBUILD_AFLAGS  += -gz=zstd
> +KBUILD_LDFLAGS += --compress-debug-sections=zstd
>  endif
>
>  KBUILD_CFLAGS  += $(DEBUG_CFLAGS)
>
> base-commit: 1767a722a708f1fa3b9af39eb091d79101f8c086
> --
> 2.38.1.431.g37b22c650d-goog
>


-- 
Best Regards
Masahiro Yamada
