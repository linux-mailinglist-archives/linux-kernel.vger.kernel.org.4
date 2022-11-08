Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9E621BE9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKHSau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiKHSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:30:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C955B866
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:30:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9371461710
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 18:30:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69817C433C1;
        Tue,  8 Nov 2022 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667932242;
        bh=0Ilpd65+BqZHkJQ6ZzbRrBM6rJYVbLuq+YBsux3JXtU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV+UF3UaA6L7a+E88bOAIYaofBJsNItjRIIp3Jlu2QNTC3apAw8yYtAk+CVMTfgm5
         rz0hygtGXgPBOAoF4MHtAuwdzOfIB0vXZAqJuzLsY/gZpH89buSqCV2iVsFlUSLWlm
         zxEgViHEw+iFEVPiVmw5K9HJjmCfsj3S1fmT1RYmrNfe9R4EgFFSboeR/hsEFBnvHj
         KUJjN23BnQNWUe9p2Y7n9sEqrx5N+htE8lNqd+OO8m4NSir4tKZxDUS/pZ7Mv9dP48
         85XsYet31gQhw49YZlx4eaXtlDURRhZntRbD7MozZtqekekKjIEY7v5TZvNcy7k6k5
         CUY/yfbKcuWUA==
Date:   Tue, 8 Nov 2022 11:30:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/4] ARM: use .arch directives instead of assembler
 command line flags
Message-ID: <Y2qgTyFcPdnNfkpj@dev-arch.thelio-3990X>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-3-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201354.3190007-3-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

On Fri, Oct 14, 2022 at 01:13:52PM -0700, Nick Desaulniers wrote:
> Similar to commit a6c30873ee4a ("ARM: 8989/1: use .fpu assembler
> directives instead of assembler arguments").
> 
> GCC and GNU binutils support setting the "sub arch" via -march=,
> -Wa,-march, target function attribute, and .arch assembler directive.
> 
> Clang was missing support for -Wa,-march=, but this was implemented in
> clang-13.
> 
> The behavior of both GCC and Clang is to
> prefer -Wa,-march= over -march= for assembler and assembler-with-cpp
> sources, but Clang will warn about the -march= being unused.
> 
> clang: warning: argument unused during compilation: '-march=armv6k'
> [-Wunused-command-line-argument]
> 
> Since most assembler is non-conditionally assembled with one sub arch
> (modulo arch/arm/delay-loop.S which conditionally is assembled as armv4
> based on CONFIG_ARCH_RPC, and arch/arm/mach-at91/pm-suspend.S which is
> conditionally assembled as armv7-a based on CONFIG_CPU_V7), prefer the
> .arch assembler directive.
> 
> Add a few more instances found in compile testing as found by Arnd and
> Nathan.
> 
> Link: https://github.com/llvm/llvm-project/commit/1d51c699b9e2ebc5bcfdbe85c74cc871426333d4
> Link: https://bugs.llvm.org/show_bug.cgi?id=48894
> Link: https://github.com/ClangBuiltLinux/linux/issues/1195
> Link: https://github.com/ClangBuiltLinux/linux/issues/1315
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes v3 -> v4:
> * Add .arch armv7-a to arch/arm/mach-tegra/sleep.S as per Nathan.
>   https://github.com/ClangBuiltLinux/linux/issues/1315#issuecomment-1255646893
> * Add Nathan's SB tag.

I noticed that this series appears to be partially applied in
next-20221108:

59247fe730db ARM: 9265/1: pass -march= only to compiler
bc21212c5564 ARM: 9264/1: only use -mtp=cp15 for the compiler
5aa4860eb50f ARM: 9262/1: remove lazy evaluation in Makefile

This patch (submitted as 9263/1) is needed by 9265/1; without it, builds
are going to break:

https://builds.tuxbuild.com/2HGSpQMAKxJuaMAz2ZZc1UgUvvu/build.log

Was there a problem with applying this patch or just an oversight? It
would be great to get this whole series applied so that we can turn
-Wunused-command-line-argument into a hard error.

Cheers,
Nathan
