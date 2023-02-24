Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A276A1DDC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBXO5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:57:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725A64E2A;
        Fri, 24 Feb 2023 06:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1058F618E6;
        Fri, 24 Feb 2023 14:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D587C433EF;
        Fri, 24 Feb 2023 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677250636;
        bh=BX7ubvR3+x0sfXaoE8k2EQZkDXcr72I1hlLKxFfUneM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeQAyzUcx24i3ueMY7iYVCIa0WNjPNOdR2O9fKOX1Zw2ZioO/R0gDk8e4oc8g1Cvj
         FxSMJc0ZD84wdrZMaGSJHxOEhX2i0A3F1/CzWSIf0EpCEP7LoqN2Bq2I2hLN9xyH4Z
         S0rbr3SZAFB8DuO+TiQON/aD0nYjHLe6jn2JQZaEvlcf3XLSipn96yH68a+vD3ViXb
         QXOSRBREy4zXA1dbb+bpYd4pXYyDOmGJ+E0il+5z6x3VKBm0E0rsWkX8ivUqz9lJRR
         HFf0ngDbQYWzhbSk6ovc9LY+bnVvtNoRsPmb1TVo2pCiTab1TKvAejr4+H/pD7zJEn
         QkfMmKNjAIHhA==
Date:   Fri, 24 Feb 2023 07:57:13 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC RESEND 2/2] RISC-V: enable building the 64-bit kernels with
 rust support
Message-ID: <Y/jQSUpXH5XwQTqg@dev-arch.thelio-3990X>
References: <20230224135044.2882109-1-conor.dooley@microchip.com>
 <20230224135044.2882109-3-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224135044.2882109-3-conor.dooley@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On Fri, Feb 24, 2023 at 01:50:44PM +0000, Conor Dooley wrote:
> From: Miguel Ojeda <ojeda@kernel.org>
> 
> The rust modules work on 64-bit RISC-V, with no twiddling required.
> Select HAS_RUST and provide the required flags to kbuild so that the
> modules can be used.
> 32-bit is broken in core rust code, so support is limited to 64-bit
> only: ld.lld: error: undefined symbol: __udivdi3
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/rust/arch-support.rst | 2 ++
>  arch/riscv/Kconfig                  | 1 +
>  arch/riscv/Makefile                 | 3 ++-
>  3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
> index 6982b63775da..197919158596 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -15,5 +15,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
>  ============  ================  ==============================================
>  Architecture  Level of support  Constraints
>  ============  ================  ==============================================
> +``riscv``     Maintained        ``rv64`` only.
> +============  ================  ==============================================
>  ``x86``       Maintained        ``x86_64`` only.
>  ============  ================  ==============================================
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 81eb031887d2..73174157212d 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -115,6 +115,7 @@ config RISCV
>  	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_RSEQ
> +	select HAVE_RUST if 64BIT

Just a small drive by comment, you have 'if 64BIT' here...

>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IRQ_DOMAIN
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 76989561566b..0d6fc4e25221 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -29,8 +29,8 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
>  
>  	KBUILD_CFLAGS += -mabi=lp64
>  	KBUILD_AFLAGS += -mabi=lp64
> -
>  	KBUILD_LDFLAGS += -melf64lriscv
> +	KBUILD_RUSTFLAGS += -Ctarget-cpu=generic-rv64
>  else
>  	BITS := 32
>  	UTS_MACHINE := riscv32
> @@ -38,6 +38,7 @@ else
>  	KBUILD_CFLAGS += -mabi=ilp32
>  	KBUILD_AFLAGS += -mabi=ilp32
>  	KBUILD_LDFLAGS += -melf32lriscv
> +	KBUILD_RUSTFLAGS += -Ctarget-cpu=generic-rv32

but also add KBUILD_RUSTFLAGS for the !64BIT case. Seems like one of
those can be removed.

>  endif
>  
>  ifeq ($(CONFIG_LD_IS_LLD),y)
> -- 
> 2.39.2
> 

Cheers,
Nathan
