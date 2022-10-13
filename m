Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4927D5FE358
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJMUdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJMUdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:33:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC715B32C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F2961957
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 20:33:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF408C433D6;
        Thu, 13 Oct 2022 20:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665693215;
        bh=cSSJTqzgPesRuaxrVBjmPJJmSoU2tk6WXgmwyLF4KUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fxKhUWkosvn02pMtaowGkfeHCAuBxrc16nys1xE/ClyoOqh4QnFvMBZcMUhbxBXb1
         My04/JtbibN8rD9dv3woDfvxUAs9zJRS/WKh9tr+q0YLsFZZ09o0KmnOF6kpCdOmw0
         QHHfPsYTdvPIhHqmbkB23mctoQHuoC6+epLvFGtAh3luGTSbJizyONbsc8Zmn6u03U
         vfwUz99GnU/deRe3OK0kIneTrysBhxb1p4J8YbZuvba0Iw8qqOBscdSNFGdfuEXZNR
         KyrTfHdcLlLsFtqJeo5y824B6JDuXMk5bb/ZoXGmDABtFwS0e6GHkaQ6Px93MVsW/O
         2paKIVQlKAWhA==
Date:   Thu, 13 Oct 2022 21:33:29 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/2] riscv: fix detection of toolchain Zicbom support
Message-ID: <Y0h2GVhYwj8UEJV2@spud>
References: <20221006173520.1785507-1-conor@kernel.org>
 <20221006173520.1785507-2-conor@kernel.org>
 <Y0hzl75d11uWC+f3@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0hzl75d11uWC+f3@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 01:22:47PM -0700, Nathan Chancellor wrote:
> On Thu, Oct 06, 2022 at 06:35:20PM +0100, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > It is not sufficient to check if a toolchain supports a particular
> > extension without checking if the linker supports that extension too.
> > For example, Clang 15 supports Zicbom but GNU bintutils 2.35.2 does
> > not, leading build errors like so:
> > 
> > riscv64-linux-gnu-ld: -march=rv64i2p0_m2p0_a2p0_c2p0_zicbom1p0_zihintpause2p0: Invalid or unknown z ISA extension: 'zicbom'
> > 
> > Convert CC_HAS_ZICBOM to TOOLCHAIN_HAS_ZICBOM & check if the linker
> > also supports Zicbom.
> > 
> > Reported-by: Kevin Hilman <khilman@baylibre.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1714
> > Link: https://storage.kernelci.org/next/master/next-20220920/riscv/defconfig+CONFIG_EFI=n/clang-16/logs/kernel.log
> > Fixes: 1631ba1259d6 ("riscv: Add support for non-coherent devices using zicbom extension")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> 
> The versions look correct to me. I see the LLVM zicbom commit [1] in
> llvmorg-15.0.0 and I see the binutils zicbom commit [2] in
> binutils-2_39.
> 
> FWIW, if we are adding explicit tool versions to the Kconfig, could you
> not also drop the cc-option checks? Typically, cc-option is only used
> when dynamically checking for a feature, in lieu of statically checking
> a version. No strong opinion though.

Ehh, the explicit version checks are for linker support, but it could be
that your linker supports it but other things do not. The compilers
support can still be checked with cc-option, no?

This error here happens when the compiler does support it, so the string
containing zicbom is emitted in the object files. That can't be checked
dynamically. For the opposite situation, dynamic checking is possible so
I tried retained them. If it's convention to do one or the other, I can
easily switch.

I'm out of my comfort zone when it comes to kbuild plumbing so please,
please lmk if I'm missing something...

> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> 
> [1]: https://github.com/llvm/llvm-project/commit/4f40ca53cefb725aca6564585d0ec4836a79e21a
> [2]: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=41d6ac5da655a2e78109848f2db47e53552fd61a
> 
> > ---
> >  arch/riscv/Kconfig  | 10 ++++++----
> >  arch/riscv/Makefile |  3 +--
> >  2 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index d557cc50295d..6da36553158b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -401,14 +401,16 @@ config RISCV_ISA_SVPBMT
> >  
> >  	   If you don't know what to do here, say Y.
> >  
> > -config CC_HAS_ZICBOM
> > +config TOOLCHAIN_HAS_ZICBOM
> >  	bool
> > -	default y if 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
> > -	default y if 32BIT && $(cc-option,-mabi=ilp32 -march=rv32ima_zicbom)
> > +	default y
> > +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
> > +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zicbom)
> > +	depends on LLD_VERSION >= 150000 || LD_VERSION >= 23900
> >  
> >  config RISCV_ISA_ZICBOM
> >  	bool "Zicbom extension support for non-coherent DMA operation"
> > -	depends on CC_HAS_ZICBOM
> > +	depends on TOOLCHAIN_HAS_ZICBOM
> >  	depends on !XIP_KERNEL && MMU
> >  	select RISCV_DMA_NONCOHERENT
> >  	select RISCV_ALTERNATIVE
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 3fa8ef336822..3607d38edb4f 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -57,8 +57,7 @@ toolchain-need-zicsr-zifencei := $(call cc-option-yn, -march=$(riscv-march-y)_zi
> >  riscv-march-$(toolchain-need-zicsr-zifencei) := $(riscv-march-y)_zicsr_zifencei
> >  
> >  # Check if the toolchain supports Zicbom extension
> > -toolchain-supports-zicbom := $(call cc-option-yn, -march=$(riscv-march-y)_zicbom)
> > -riscv-march-$(toolchain-supports-zicbom) := $(riscv-march-y)_zicbom
> > +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICBOM) := $(riscv-march-y)_zicbom
> >  
> >  # Check if the toolchain supports Zihintpause extension
> >  toolchain-supports-zihintpause := $(call cc-option-yn, -march=$(riscv-march-y)_zihintpause)
> > -- 
> > 2.37.3
> > 
> > 
