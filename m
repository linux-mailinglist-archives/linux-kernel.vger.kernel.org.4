Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A175FF523
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJNVSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiJNVSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DDAF88EE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 232BB61B8D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 21:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C5EC433C1;
        Fri, 14 Oct 2022 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665782288;
        bh=J6PgskZaAY1qyGHi1l6L6dU7ZAigdju+rA7uW8rvJK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwXHMijSjb74jNvLdzhT4c+M0NTILDkkhwY1rh1MZwqVvxOoDiIClA8F9b6uN8zsQ
         RrufGW9bGPu17NRSqJyM/Apv6sGywatUPt4w+r7jSGECot2Njyl8+5vdZ7IDRgQfao
         jpS8pGDS4NJV9MQrTu7tcAZcF7o63jjYUqu7TSCYu4YUOBgugkE5hDfcqrTYgzPpxH
         EuxS97FL2NY1riU9ZqbsrA3APgt7zEg0lWXP5y6LGcFevg5BoQ+x4b1EpSLUXhHNiJ
         WgJQ0tdAI+ID1ar20Fi5RYccfExXmf3kawsjGNNqU3lGPdz2DwGPClU1m85oL1RsfE
         kHEQz383xLBTw==
Date:   Fri, 14 Oct 2022 14:18:06 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v4 1/4] ARM: remove lazy evaluation in Makefile
Message-ID: <Y0nSDuEumerVwyHT@dev-arch.thelio-3990X>
References: <20221014201354.3190007-1-ndesaulniers@google.com>
 <20221014201354.3190007-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014201354.3190007-2-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 01:13:51PM -0700, Nick Desaulniers wrote:
> arch-y and tune-y used lazy evaluation since they used to contain
> cc-option checks. They don't any longer, so just eagerly evaluate these
> command line flags.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> No change from v3.
> 
>  arch/arm/Makefile | 60 +++++++++++++++++++++--------------------------
>  1 file changed, 27 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index c846119c448f..8dd943b50b7d 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -63,44 +63,38 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
>  # Note that GCC does not numerically define an architecture version
>  # macro, but instead defines a whole series of macros which makes
>  # testing for a specific architecture or later rather impossible.
> -arch-$(CONFIG_CPU_32v7M)	=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
> -arch-$(CONFIG_CPU_32v7)		=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
> -arch-$(CONFIG_CPU_32v6)		=-D__LINUX_ARM_ARCH__=6 -march=armv6
> -# Only override the compiler option if ARMv6. The ARMv6K extensions are
> +arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m
> +arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 -march=armv7-a
> +arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 -march=armv6
> +# Only override the compiler opt:ion if ARMv6. The ARMv6K extensions are
>  # always available in ARMv7
>  ifeq ($(CONFIG_CPU_32v6),y)
> -arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 -march=armv6k
> +arch-$(CONFIG_CPU_32v6K)	:=-D__LINUX_ARM_ARCH__=6 -march=armv6k
>  endif
> -arch-$(CONFIG_CPU_32v5)		=-D__LINUX_ARM_ARCH__=5 -march=armv5te
> -arch-$(CONFIG_CPU_32v4T)	=-D__LINUX_ARM_ARCH__=4 -march=armv4t
> -arch-$(CONFIG_CPU_32v4)		=-D__LINUX_ARM_ARCH__=4 -march=armv4
> -arch-$(CONFIG_CPU_32v3)		=-D__LINUX_ARM_ARCH__=3 -march=armv3m
> -
> -# Evaluate arch cc-option calls now
> -arch-y := $(arch-y)
> +arch-$(CONFIG_CPU_32v5)		:=-D__LINUX_ARM_ARCH__=5 -march=armv5te
> +arch-$(CONFIG_CPU_32v4T)	:=-D__LINUX_ARM_ARCH__=4 -march=armv4t
> +arch-$(CONFIG_CPU_32v4)		:=-D__LINUX_ARM_ARCH__=4 -march=armv4
> +arch-$(CONFIG_CPU_32v3)		:=-D__LINUX_ARM_ARCH__=3 -march=armv3m
>  
>  # This selects how we optimise for the processor.
> -tune-$(CONFIG_CPU_ARM7TDMI)	=-mtune=arm7tdmi
> -tune-$(CONFIG_CPU_ARM720T)	=-mtune=arm7tdmi
> -tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
> -tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_ARM940T)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_ARM946E)	=-mtune=arm9e
> -tune-$(CONFIG_CPU_ARM920T)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_ARM922T)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_ARM925T)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_ARM926T)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_FA526)	=-mtune=arm9tdmi
> -tune-$(CONFIG_CPU_SA110)	=-mtune=strongarm110
> -tune-$(CONFIG_CPU_SA1100)	=-mtune=strongarm1100
> -tune-$(CONFIG_CPU_XSCALE)	=-mtune=xscale
> -tune-$(CONFIG_CPU_XSC3)		=-mtune=xscale
> -tune-$(CONFIG_CPU_FEROCEON)	=-mtune=xscale
> -tune-$(CONFIG_CPU_V6)		=-mtune=arm1136j-s
> -tune-$(CONFIG_CPU_V6K)		=-mtune=arm1136j-s
> -
> -# Evaluate tune cc-option calls now
> -tune-y := $(tune-y)
> +tune-$(CONFIG_CPU_ARM7TDMI)	:=-mtune=arm7tdmi
> +tune-$(CONFIG_CPU_ARM720T)	:=-mtune=arm7tdmi
> +tune-$(CONFIG_CPU_ARM740T)	:=-mtune=arm7tdmi
> +tune-$(CONFIG_CPU_ARM9TDMI)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_ARM940T)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_ARM946E)	:=-mtune=arm9e
> +tune-$(CONFIG_CPU_ARM920T)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_ARM922T)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_ARM925T)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_ARM926T)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_FA526)	:=-mtune=arm9tdmi
> +tune-$(CONFIG_CPU_SA110)	:=-mtune=strongarm110
> +tune-$(CONFIG_CPU_SA1100)	:=-mtune=strongarm1100
> +tune-$(CONFIG_CPU_XSCALE)	:=-mtune=xscale
> +tune-$(CONFIG_CPU_XSC3)		:=-mtune=xscale
> +tune-$(CONFIG_CPU_FEROCEON)	:=-mtune=xscale
> +tune-$(CONFIG_CPU_V6)		:=-mtune=arm1136j-s
> +tune-$(CONFIG_CPU_V6K)		:=-mtune=arm1136j-s
>  
>  ifeq ($(CONFIG_AEABI),y)
>  CFLAGS_ABI	:=-mabi=aapcs-linux -mfpu=vfp
> -- 
> 2.38.0.413.g74048e4d9e-goog
> 
> 
