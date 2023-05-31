Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D2718D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjEaVgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEaVgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5311B3;
        Wed, 31 May 2023 14:34:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B3A960FF8;
        Wed, 31 May 2023 21:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BE1C433EF;
        Wed, 31 May 2023 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685568801;
        bh=h+y0cHYshxYDyUqi8jMQww3RoC+yaMerNeilVKWV3J8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8Z/EBi7d1y0GwIJpptTpZZ9jyfElmAqg8q79C6VyGjdQGuKSL7dQC61gVo2oI5KE
         qIBt4bNrVoNn7nUBMCfJRYkQG38/06JRgX7HsvRFEDHSVNaE1dRa/XQUpgFXEJ5YGB
         tGDKHGzcBOa5ItIoXSIhVnsGJCp67i3kKYSWIcUyHaGjgfTGbtyNgWPPDAY461trH3
         UG4MMhQNMjXaatYsJvw3rfPUtbHDfwa+WXbSOzvv6m7aOnhxjcuHspGTbkMFSanFgK
         4rXl00d+K/jIxpr+zUzXhgTO2Oa/uj/XEDlhINa/5iwyo9TZHslwWHOpYRzr6yA1OM
         ZJ3PSwDz36D/g==
Date:   Wed, 31 May 2023 14:33:19 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rini <trini@konsulko.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH] kbuild: add $(CLANG_CFLAGS) to KBUILD_CPPFLAGS
Message-ID: <20230531213319.GA2201875@dev-arch.thelio-3990X>
References: <20230409145358.2538266-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230409145358.2538266-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sun, Apr 09, 2023 at 11:53:57PM +0900, Masahiro Yamada wrote:
> When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
> not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.
> 
> As a result, the linker script is preprocessed with predefined macros
> for the build host instead of the target.
> 
> Assuming you use an x86 build machine, compare the following:
> 
>  $ clang -dM -E -x c /dev/null
>  $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu
> 
> There is no actual problem presumably because our linker scripts do not
> rely on such predefined macros, but it is better to define correct ones.
> 
> Move $(CFLAGS_CFLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
> will be processed with the proper target triple.
> 
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/Makefile.clang | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
> index 70b354fa1cb4..93ca059cc3b8 100644
> --- a/scripts/Makefile.clang
> +++ b/scripts/Makefile.clang
> @@ -38,6 +38,5 @@ CLANG_FLAGS	+= -Werror=unknown-warning-option
>  CLANG_FLAGS	+= -Werror=ignored-optimization-argument
>  CLANG_FLAGS	+= -Werror=option-ignored
>  CLANG_FLAGS	+= -Werror=unused-command-line-argument
> -KBUILD_CFLAGS	+= $(CLANG_FLAGS)
> -KBUILD_AFLAGS	+= $(CLANG_FLAGS)
> +KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
>  export CLANG_FLAGS
> -- 
> 2.37.2
> 

I am doubling back to this change, as the lack of '--target' in
KBUILD_CPPFLAGS is now an active bug with clang-17 due to a new change
that rejects '-mbig-endian' and '-mlittle-endian' when not supported by
the target, which breaks the arm64 vDSO build when preprocessing its
linker script:

  # Turn on CONFIG_CPU_BIG_ENDIAN in menuconfig
  $ make -skj"$(nproc)" ARCH=arm64 LLVM=1 O=build mrproper virtconfig menuconfig arch/arm64/kernel/vdso/
  ...
  clang: error: unsupported option '-mbig-endian' for target 'x86_64-pc-linux-gnu'
  make[3]: *** [.../scripts/Makefile.build:387: arch/arm64/kernel/vdso/vdso.lds] Error 1
  ...

  https://github.com/llvm/llvm-project/commit/d81ce04587c006b6731198956c522c93d0df1050
  https://github.com/ClangBuiltLinux/linux/issues/1859

This change resolves that issue. I was able to figure out why those new
warnings appeared for ARCH=mips, it is the shell invocation for
CHECKFLAGS. The following diff resolves it for me:

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index a7a4ee66a9d3..ef7b05ae92ce 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -346,7 +346,7 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_LDFLAGS		+= -m $(ld-emul)
 
 ifdef CONFIG_MIPS
-CHECKFLAGS += $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
+CHECKFLAGS += $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM -E -x c /dev/null | \
 	grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
 	sed -e "s/^\#define /-D'/" -e "s/ /'='/" -e "s/$$/'/" -e 's/\$$/&&/g')
 endif

I will run this change plus that diff through my build matrix to see if
any other issues pop up. If not, I will respond with some tags and
perhaps this could be taken as a fix for 6.4 so that it could
potentially be backported?

Cheers,
Nathan
