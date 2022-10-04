Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F15F42F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiJDMa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJDMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA051D641
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A46B60765
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D55CC433C1;
        Tue,  4 Oct 2022 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664886613;
        bh=rx2frixyc5Te5j8Sw/gyPUpvVto2dBti0m4sZqVyRa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9uw1HzlHYYWLLleKlcwX5JPZtqTEgda9vZNsYb/h2gM9lmDnatfcAdCBBa0q+297
         wSnjbQk66fbku2ZmQq6fNsXz4miL8/sFyHZQVjK4rwI2IDBrd+APdHA/v94+kqXTLL
         L6h1QATiGCO1SWUEczp0kWoRi1XhnVh5v9jDHT6lWxf02OWI669P/p/NXya8THD962
         w0yOwACLZZ7ek+DX4IpGJ+UIoB5AZ9f6MBS2jFbVgdMRXHqdGKqGQwwqa0vPTxAr5b
         FqQ9Dy0HSDFtOgXebX2BA+KLoKR/+t2XBFwDfbMzHEMaGkwWs4XUEZyKAEsrdwjEbu
         Di0Wz9eVfT+9A==
Date:   Tue, 4 Oct 2022 13:30:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH -next] arm64: alternatives: Use vdso/bits.h instead of
 linux/bits.h
Message-ID: <20221004123008.GA23822@willie-the-truck>
References: <20221003193759.1141709-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003193759.1141709-1-nathan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 12:37:59PM -0700, Nathan Chancellor wrote:
> When building with CONFIG_LTO after commit ba00c2a04fa5 ("arm64: fix the
> build with binutils 2.27"), the following build error occurs:
> 
>   In file included from arch/arm64/kernel/module-plts.c:6:
>   In file included from include/linux/elf.h:6:
>   In file included from arch/arm64/include/asm/elf.h:8:
>   In file included from arch/arm64/include/asm/hwcap.h:9:
>   In file included from arch/arm64/include/asm/cpufeature.h:9:
>   In file included from arch/arm64/include/asm/alternative-macros.h:5:
>   In file included from include/linux/bits.h:22:
>   In file included from include/linux/build_bug.h:5:
>   In file included from include/linux/compiler.h:248:
>   In file included from arch/arm64/include/asm/rwonce.h:71:
>   include/asm-generic/rwonce.h:67:9: error: expected string literal in 'asm'
>           return __READ_ONCE(*(unsigned long *)addr);
>                 ^
>   arch/arm64/include/asm/rwonce.h:43:16: note: expanded from macro '__READ_ONCE'
>                   asm volatile(__LOAD_RCPC(b, %w0, %1)                    \
>                               ^
>   arch/arm64/include/asm/rwonce.h:17:2: note: expanded from macro '__LOAD_RCPC'
>           ALTERNATIVE(                                                    \
>           ^
> 
> Similar to the issue resolved by commit 0072dc1b53c3 ("arm64: avoid
> BUILD_BUG_ON() in alternative-macros"), there is a circular include
> dependency through <linux/bits.h> when CONFIG_LTO is enabled due to
> <asm/rwonce.h> appearing in the include chain before the contents of
> <asm/alternative-macros.h>, which results in ALTERNATIVE() not getting
> expanded properly because it has not been defined yet.
> 
> Avoid this issue by including <vdso/bits.h>, which includes the
> definition of the BIT() macro, instead of <linux/bits.h>, as BIT() is the
> only macro from bits.h that is relevant to this header.
> 
> Fixes: ba00c2a04fa5 ("arm64: fix the build with binutils 2.27")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1728
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/arm64/include/asm/alternative-macros.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
> index b5ac0b85c9bb..3622e9f4fb44 100644
> --- a/arch/arm64/include/asm/alternative-macros.h
> +++ b/arch/arm64/include/asm/alternative-macros.h
> @@ -2,8 +2,8 @@
>  #ifndef __ASM_ALTERNATIVE_MACROS_H
>  #define __ASM_ALTERNATIVE_MACROS_H
>  
> -#include <linux/bits.h>
>  #include <linux/const.h>
> +#include <vdso/bits.h>
>  
>  #include <asm/cpucaps.h>
>  #include <asm/insn-def.h>
> 
> base-commit: ba00c2a04fa5431d204a4183062b30372c062aa7

The 'vdso' namespace is a bit of a misnomer, but that's not your fault and I
can confirm that this fixes the build on for-next/core with defconfig + thin
LTO, so:

Tested-by: Will Deacon <will@kernel.org>

Thanks!

Will
