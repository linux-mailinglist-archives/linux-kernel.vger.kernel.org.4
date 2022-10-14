Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFE45FF529
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJNVUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNVUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:20:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3B34999
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D7464CE2792
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B918C433D7;
        Fri, 14 Oct 2022 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665782404;
        bh=37/4SOkpc1PTjHtkVxS8nJDWUdCatmn59b4YvJcSNds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WSklgKhoKuVbkvdEidXiptSIvdxW/0+UzkbKpXgeAbMj+ZgLo3TPJUz5COpf2zeHr
         OnE9IDEipT855r8+9pj3cEwmMuyLo6cK3cX7wdX97BfSIiyrR8kv59H1/5elpaEgQ+
         35WVgpTdhXgHU2PYMR5zOLWY5o4jloFTguwfp5+ygsbu4+RioxYRQhnpqauQ/2D0a+
         fnhTXCLskyyDzSt5S8wsqM9dgdceH1ijv2r+Z9+X35F5/rYEJzcH1akqicWi8Lb6FW
         mRML/mskCh5LUBY9Gv8WHVF97o5YXTAvL1/HTYF2ybQCmkfEHgEBOmZD/Ocwb2QiA0
         G8Bs5c4X/fKKQ==
Date:   Fri, 14 Oct 2022 14:20:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 3/4] ARM: only use -mtp=cp15 for the compiler
Message-ID: <Y0nSgpfZNPruGPhj@dev-arch.thelio-3990X>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201354.3190007-4-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:13:53PM -0700, Nick Desaulniers wrote:
> Avoids an error from the assembler for CONFIG_THUMB2 kernels:
> 
> clang-15: error: hardware TLS register is not supported for the thumbv4t
> sub-architecture
> 
> This flag only makes sense to pass to the compiler, not the assembler.
> 
> Perhaps CFLAGS_ABI can be renamed to CPPFLAGS_ABI to reflect that they
> will be passed to both the compiler and assembler for sources that
> require pre-processing.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 8dd943b50b7d..ee888070b2ff 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -111,7 +111,7 @@ CFLAGS_ABI	+= -meabi gnu
>  endif
>  
>  ifeq ($(CONFIG_CURRENT_POINTER_IN_TPIDRURO),y)
> -CFLAGS_ABI	+= -mtp=cp15
> +KBUILD_CFLAGS	+= -mtp=cp15
>  endif
>  
>  # Accept old syntax despite ".syntax unified"
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
