Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA299675987
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjATQIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjATQIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:08:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01683584;
        Fri, 20 Jan 2023 08:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58FE861FCD;
        Fri, 20 Jan 2023 16:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7346BC433D2;
        Fri, 20 Jan 2023 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674230891;
        bh=91Kqm9A91r+/RZojfxN8T1qhIyxXThsjoGKa4xt/GYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A9lK4tu7EYXTqre9nt0v/ZYgiV0PZR6+F4iSz82UDaHefFUDitqCnILQOPsuvR91d
         7+9NFCInoAgCR6jFwsf1elPH25I3N7Gm3VGWSrnJza6kiLiO59T0zQvN1Rip2Uur2e
         W6s5GA8sjzFc9R7+/KHoFENF3Zyb27MqKYThRY+9TCG42FkNocrMto4Yl1WLwOctLx
         RQdFyReZAHBo/AEC8N3t07DfpEiSkEpS4ESZgcqju9X25LRFE9qhYT7Ad6ICAXlH4r
         iIlVnI51PfMUUpbiMna0JG3BR+mm8KOc3uTE3+/CoO6lfDlSFFvoh/+pVLH1zEwnAR
         6ELz1hqvZ3Ylw==
Date:   Fri, 20 Jan 2023 09:08:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: remove CONFIG_MIPS_LD_CAN_LINK_VDSO
Message-ID: <Y8q8afLwmEs5RGyR@dev-arch.thelio-3990X>
References: <20230120063351.433502-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120063351.433502-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

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
> 
