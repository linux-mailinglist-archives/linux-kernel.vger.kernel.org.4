Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD222637EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKXSZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXSZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:25:04 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8605FB5C43;
        Thu, 24 Nov 2022 10:25:01 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyGtz-0007HK-BN; Thu, 24 Nov 2022 19:24:47 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 3/7] riscv: errata: Add Andes alternative ports
Date:   Thu, 24 Nov 2022 19:24:46 +0100
Message-ID: <4542837.QJadu78ljV@diego>
In-Reply-To: <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221124172207.153718-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Am Donnerstag, 24. November 2022, 18:22:03 CET schrieb Prabhakar:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add required ports of the Alternative scheme for Andes CPU cores.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v3 -> v4
> * New patch
> ---

> diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
> index a1055965fbee..81828e80f6dc 100644
> --- a/arch/riscv/errata/Makefile
> +++ b/arch/riscv/errata/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
>  obj-$(CONFIG_ERRATA_THEAD) += thead/
> +obj-$(CONFIG_ERRATA_ANDES) += andes/

alphabetical sorting please


> diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
> new file mode 100644
> index 000000000000..ec3e052ca8c7
> --- /dev/null
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Erratas to be applied for Andes CPU cores
> + *
> + *  Copyright (C) 2022 Renesas Electronics Corporation.
> + *
> + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <asm/alternative.h>
> +#include <asm/cacheflush.h>
> +#include <asm/errata_list.h>
> +#include <asm/patch.h>
> +#include <asm/vendorid_list.h>
> +
> +static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
> +		return false;
> +
> +	if (arch_id != 0x8000000000008a45 || impid != 0x500)
> +		return false;
> +
> +	riscv_cbom_block_size = 1;

as this is mainly to make the core cbo code happy, maybe add a comment
above that line to explain.


> +	riscv_noncoherent_supported();
> +
> +	return true;
> +}
> +

> diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> index 6511dd73e812..d8012af30cbd 100644
> --- a/arch/riscv/include/asm/alternative.h
> +++ b/arch/riscv/include/asm/alternative.h
> @@ -46,6 +46,9 @@ void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
>  			     unsigned long archid, unsigned long impid,
>  			     unsigned int stage);
> +void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
> +			     unsigned long archid, unsigned long impid,
> +			     unsigned int stage);

again alphabetical please (i.e. above sifive)


> diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
> index 4180312d2a70..2ba7e6e74540 100644
> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -9,6 +9,11 @@
>  #include <asm/csr.h>
>  #include <asm/vendorid_list.h>
>  
> +#ifdef CONFIG_ERRATA_ANDES
> +#define ERRATA_ANDESTECH_NO_IOCP	0
> +#define ERRATA_ANDESTECH_NUMBER		1
> +#endif
> +
>  #ifdef CONFIG_ERRATA_SIFIVE
>  #define	ERRATA_SIFIVE_CIP_453 0
>  #define	ERRATA_SIFIVE_CIP_1200 1
> diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
> index a7d26a00beea..4ded3e9aa3bc 100644
> --- a/arch/riscv/kernel/alternative.c
> +++ b/arch/riscv/kernel/alternative.c
> @@ -47,6 +47,11 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
>  	case THEAD_VENDOR_ID:
>  		cpu_mfr_info->patch_func = thead_errata_patch_func;
>  		break;
> +#endif
> +#ifdef CONFIG_ERRATA_ANDES
> +	case ANDESTECH_VENDOR_ID:
> +		cpu_mfr_info->patch_func = andes_errata_patch_func;
> +		break;

and again alphabetical please


Thanks
Heiko


