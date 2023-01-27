Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F267EAEA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjA0Q27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbjA0Q24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:28:56 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9876B21A11;
        Fri, 27 Jan 2023 08:28:54 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pLRav-0002kp-03; Fri, 27 Jan 2023 17:28:53 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3A4C6C2638; Fri, 27 Jan 2023 17:28:30 +0100 (CET)
Date:   Fri, 27 Jan 2023 17:28:30 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] MIPS: remove CONFIG_MIPS_LD_CAN_LINK_VDSO
Message-ID: <20230127162830.GD6090@alpha.franken.de>
References: <20230120063351.433502-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120063351.433502-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 03:33:51PM +0900, Masahiro Yamada wrote:
> Given commit e4412739472b ("Documentation: raise minimum supported
> version of binutils to 2.25"), CONFIG_MIPS_LD_CAN_LINK_VDSO is always
> 'y'.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/mips/vdso/Kconfig  | 14 +-------------
>  arch/mips/vdso/Makefile |  3 ---
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/arch/mips/vdso/Kconfig b/arch/mips/vdso/Kconfig
> index a665f6108cb5..70140248da72 100644
> --- a/arch/mips/vdso/Kconfig
> +++ b/arch/mips/vdso/Kconfig
> @@ -1,18 +1,6 @@
> -# For the pre-R6 code in arch/mips/vdso/vdso.h for locating
> -# the base address of VDSO, the linker will emit a R_MIPS_PC32
> -# relocation in binutils > 2.25 but it will fail with older versions
> -# because that relocation is not supported for that symbol. As a result
> -# of which we are forced to disable the VDSO symbols when building
> -# with < 2.25 binutils on pre-R6 kernels. For more references on why we
> -# can't use other methods to get the base address of VDSO please refer to
> -# the comments on that file.
> -#
>  # GCC (at least up to version 9.2) appears to emit function calls that make use
>  # of the GOT when targeting microMIPS, which we can't use in the VDSO due to
>  # the lack of relocations. As such, we disable the VDSO for microMIPS builds.
>  
> -config MIPS_LD_CAN_LINK_VDSO
> -	def_bool LD_VERSION >= 22500 || LD_IS_LLD
> -
>  config MIPS_DISABLE_VDSO
> -	def_bool CPU_MICROMIPS || (!CPU_MIPSR6 && !MIPS_LD_CAN_LINK_VDSO)
> +	def_bool CPU_MICROMIPS
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 1f7d5c6c10b0..18af9474ed0e 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -52,9 +52,6 @@ endif
>  CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE)
>  
>  ifdef CONFIG_MIPS_DISABLE_VDSO
> -  ifndef CONFIG_MIPS_LD_CAN_LINK_VDSO
> -    $(warning MIPS VDSO requires binutils >= 2.25)
> -  endif
>    obj-vdso-y := $(filter-out vgettimeofday.o, $(obj-vdso-y))
>  endif
>  
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
