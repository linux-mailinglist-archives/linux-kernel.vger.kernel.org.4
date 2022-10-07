Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D1A5F77B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJGLym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJGLyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:54:39 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7404DD7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 04:54:35 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oglw0-0006tO-8L; Fri, 07 Oct 2022 13:54:32 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 4/8] riscv: cpufeature: extend riscv_cpufeature_patch_func to all ISA extensions
Date:   Fri, 07 Oct 2022 13:54:31 +0200
Message-ID: <3185764.oiGErgHkdL@diego>
In-Reply-To: <20221006070818.3616-5-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-5-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 6. Oktober 2022, 09:08:14 CEST schrieb Jisheng Zhang:
> make the riscv_cpufeature_patch_func() scan all ISA extensions rather
> than limited feature macros.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/errata_list.h |  9 ++--
>  arch/riscv/kernel/cpufeature.c       | 61 +++-------------------------
>  2 files changed, 9 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 19a771085781..722525f4fc96 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -6,6 +6,7 @@
>  #define ASM_ERRATA_LIST_H
>  
>  #include <asm/alternative.h>
> +#include <asm/hwcap.h>
>  #include <asm/vendorid_list.h>
>  
>  #ifdef CONFIG_ERRATA_SIFIVE
> @@ -20,10 +21,6 @@
>  #define	ERRATA_THEAD_NUMBER 2
>  #endif
>  
> -#define	CPUFEATURE_SVPBMT 0
> -#define	CPUFEATURE_ZICBOM 1
> -#define	CPUFEATURE_NUMBER 2
> -
>  #ifdef __ASSEMBLY__
>  
>  #define ALT_INSN_FAULT(x)						\
> @@ -53,7 +50,7 @@ asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
>  #define ALT_SVPBMT(_val, prot)						\
>  asm(ALTERNATIVE_2("li %0, 0\t\nnop",					\
>  		  "li %0, %1\t\nslli %0,%0,%3", 0,			\
> -			CPUFEATURE_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
> +			RISCV_ISA_EXT_SVPBMT, CONFIG_RISCV_ISA_SVPBMT,	\
>  		  "li %0, %2\t\nslli %0,%0,%4", THEAD_VENDOR_ID,	\
>  			ERRATA_THEAD_PBMT, CONFIG_ERRATA_THEAD_PBMT)	\
>  		: "=r"(_val)						\
> @@ -127,7 +124,7 @@ asm volatile(ALTERNATIVE_2(						\
>  	"add a0, a0, %0\n\t"						\
>  	"2:\n\t"							\
>  	"bltu a0, %2, 3b\n\t"						\
> -	"nop", 0, CPUFEATURE_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,		\
> +	"nop", 0, RISCV_ISA_EXT_ZICBOM, CONFIG_RISCV_ISA_ZICBOM,	\

hmm, would it make sense to also at the same time extend the errata_id
in the alternatives struct to unsigned long?

Right now it's a unsigned int, and we're already at bit30 with the current extensions.

Otherwise the idea is pretty neat of allowing easy handling for all extensions

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


>  	"mv a0, %1\n\t"							\
>  	"j 2f\n\t"							\
>  	"3:\n\t"							\
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index afa54635c180..2b1f18f97253 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -251,61 +251,11 @@ void __init riscv_fill_hwcap(void)
>  }
>  
>  #ifdef CONFIG_RISCV_ALTERNATIVE
> -static bool __init_or_module cpufeature_probe_svpbmt(unsigned int stage)
> -{
> -#ifdef CONFIG_RISCV_ISA_SVPBMT
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> -		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, SVPBMT);
> -	}
> -#endif
> -
> -	return false;
> -}
> -
> -static bool __init_or_module cpufeature_probe_zicbom(unsigned int stage)
> -{
> -#ifdef CONFIG_RISCV_ISA_ZICBOM
> -	switch (stage) {
> -	case RISCV_ALTERNATIVES_EARLY_BOOT:
> -		return false;
> -	default:
> -		return riscv_isa_extension_available(NULL, ZICBOM);
> -	}
> -#endif
> -
> -	return false;
> -}
> -
> -/*
> - * Probe presence of individual extensions.
> - *
> - * This code may also be executed before kernel relocation, so we cannot use
> - * addresses generated by the address-of operator as they won't be valid in
> - * this context.
> - */
> -static u32 __init_or_module cpufeature_probe(unsigned int stage)
> -{
> -	u32 cpu_req_feature = 0;
> -
> -	if (cpufeature_probe_svpbmt(stage))
> -		cpu_req_feature |= (1U << CPUFEATURE_SVPBMT);
> -
> -	if (cpufeature_probe_zicbom(stage))
> -		cpu_req_feature |= (1U << CPUFEATURE_ZICBOM);
> -
> -	return cpu_req_feature;
> -}
> -
>  void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  						  struct alt_entry *end,
>  						  unsigned int stage)
>  {
> -	u32 cpu_req_feature = cpufeature_probe(stage);
>  	struct alt_entry *alt;
> -	u32 tmp;
>  
>  	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
>  		return;
> @@ -313,15 +263,16 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>  	for (alt = begin; alt < end; alt++) {
>  		if (alt->vendor_id != 0)
>  			continue;
> -		if (alt->errata_id >= CPUFEATURE_NUMBER) {
> -			WARN(1, "This feature id:%d is not in kernel cpufeature list",
> +		if (alt->errata_id >= RISCV_ISA_EXT_ID_MAX) {
> +			WARN(1, "This extension id:%d is not in ISA extension list",
>  				alt->errata_id);
>  			continue;
>  		}
>  
> -		tmp = (1U << alt->errata_id);
> -		if (cpu_req_feature & tmp)
> -			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> +		if (!test_bit(alt->errata_id, riscv_isa))
> +			continue;
> +
> +		patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
>  	}
>  }
>  #endif
> 




