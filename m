Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5955F7615
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJGJWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:22:17 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB59CA8BB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 02:22:15 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1ogjYY-00063C-EQ; Fri, 07 Oct 2022 11:22:10 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 3/8] riscv: hwcap: make ISA extension ids can be used in asm
Date:   Fri, 07 Oct 2022 11:22:09 +0200
Message-ID: <13539612.RDIVbhacDa@diego>
In-Reply-To: <20221006070818.3616-4-jszhang@kernel.org>
References: <20221006070818.3616-1-jszhang@kernel.org> <20221006070818.3616-4-jszhang@kernel.org>
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

Am Donnerstag, 6. Oktober 2022, 09:08:13 CEST schrieb Jisheng Zhang:
> We will make use of ISA extension in asm files, so make the multi-letter
> RISC-V ISA extension IDs macros rather than enums and move them and
> those base ISA extension IDs to suitable place.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/hwcap.h | 45 +++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 6f59ec64175e..6cf445653911 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -12,20 +12,6 @@
>  #include <linux/bits.h>
>  #include <uapi/asm/hwcap.h>
>  
> -#ifndef __ASSEMBLY__
> -#include <linux/jump_label.h>
> -/*
> - * This yields a mask that user programs can use to figure out what
> - * instruction set this cpu supports.
> - */
> -#define ELF_HWCAP		(elf_hwcap)
> -
> -enum {
> -	CAP_HWCAP = 1,
> -};
> -
> -extern unsigned long elf_hwcap;
> -
>  #define RISCV_ISA_EXT_a		('a' - 'a')
>  #define RISCV_ISA_EXT_c		('c' - 'a')
>  #define RISCV_ISA_EXT_d		('d' - 'a')
> @@ -46,21 +32,36 @@ extern unsigned long elf_hwcap;
>  #define RISCV_ISA_EXT_BASE 26
>  
>  /*
> - * This enum represent the logical ID for each multi-letter RISC-V ISA extension.
> + * These macros represent the logical ID for each multi-letter RISC-V ISA extension.
>   * The logical ID should start from RISCV_ISA_EXT_BASE and must not exceed
>   * RISCV_ISA_EXT_MAX. 0-25 range is reserved for single letter
>   * extensions while all the multi-letter extensions should define the next
>   * available logical extension id.
>   */
> -enum riscv_isa_ext_id {
> -	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> -	RISCV_ISA_EXT_SVPBMT,
> -	RISCV_ISA_EXT_ZICBOM,
> -	RISCV_ISA_EXT_ZIHINTPAUSE,
> -	RISCV_ISA_EXT_SSTC,
> -	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
> +#define RISCV_ISA_EXT_SSCOFPMF 		26
> +#define RISCV_ISA_EXT_SVPBMT		27
> +#define RISCV_ISA_EXT_ZICBOM		28
> +#define RISCV_ISA_EXT_ZIHINTPAUSE	29
> +#define RISCV_ISA_EXT_SSTC		30
> +
> +#define RISCV_ISA_EXT_ID_MAX		RISCV_ISA_EXT_MAX
> +
> +

nit: double empty line

> +#ifndef __ASSEMBLY__
> +#include <linux/jump_label.h>
> +/*
> + * This yields a mask that user programs can use to figure out what
> + * instruction set this cpu supports.
> + */
> +#define ELF_HWCAP		(elf_hwcap)
> +
> +enum {
> +	CAP_HWCAP = 1,
>  };
>  
> +extern unsigned long elf_hwcap;
> +
> +

nit: double empty line, otherwise

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

>  /*
>   * This enum represents the logical ID for each RISC-V ISA extension static
>   * keys. We can use static key to optimize code path if some ISA extensions
> 




