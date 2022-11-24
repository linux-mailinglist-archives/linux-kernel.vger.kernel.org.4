Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556EA637ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiKXSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiKXSGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:06:34 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80D85A2E;
        Thu, 24 Nov 2022 10:06:31 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oyGc0-0007BX-HW; Thu, 24 Nov 2022 19:06:12 +0100
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
Subject: Re: [PATCH v4 1/7] riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
Date:   Thu, 24 Nov 2022 19:06:11 +0100
Message-ID: <11335542.nUPlyArG6x@diego>
In-Reply-To: <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221124172207.153718-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Am Donnerstag, 24. November 2022, 18:22:01 CET schrieb Prabhakar:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Introduce ALTERNATIVE_3() macro.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/alternative-macros.h | 94 +++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index ec2f3f1b836f..1caf4306b3d6 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -69,6 +69,34 @@
>  				   new_c_2, vendor_id_2, errata_id_2,	\
>  					IS_ENABLED(CONFIG_k_2)
>  
> +.macro __ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
> +				  new_c_2, vendor_id_2, errata_id_2, enable_2, \
> +				  new_c_3, vendor_id_3, errata_id_3, enable_3
> +886 :
> +	.option push
> +	.option norvc
> +	.option norelax
> +	\old_c
> +	.option pop
> +887 :
> +	ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
> +	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> +	ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> +.endm
> +
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +	__ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					IS_ENABLED(CONFIG_k_1),		\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					IS_ENABLED(CONFIG_k_2),		\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					IS_ENABLED(CONFIG_k_3)
> +
>  #else /* !__ASSEMBLY__ */
>  
>  #include <asm/asm.h>
> @@ -135,6 +163,36 @@
>  				   new_c_2, vendor_id_2, errata_id_2,	\
>  					IS_ENABLED(CONFIG_k_2))
>  
> +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					enable_1,			\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					enable_2,			\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					enable_3)			\
> +	"886 :\n"							\
> +	".option push\n"						\
> +	".option norvc\n"						\
> +	".option norelax\n"						\
> +	old_c "\n"							\
> +	".option pop\n"							\
> +	"887 :\n"							\
> +	ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)	\
> +	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)	\
> +	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> +
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					IS_ENABLED(CONFIG_k_1),		\
> +				   new_c_2, vendor_id_2, errata_id_2,	\
> +					IS_ENABLED(CONFIG_k_2),	\
> +				   new_c_3, vendor_id_3, errata_id_3,	\
> +					IS_ENABLED(CONFIG_k_3))
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #else /* CONFIG_RISCV_ALTERNATIVE */
> @@ -153,6 +211,14 @@
>  					CONFIG_k_2)			\
>         __ALTERNATIVE_CFG old_c
>  
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3)			\
> +       __ALTERNATIVE_CFG old_c
> +
>  #else /* !__ASSEMBLY__ */
>  
>  #define __ALTERNATIVE_CFG(old_c)  \
> @@ -167,6 +233,14 @@
>  					CONFIG_k_2) \
>         __ALTERNATIVE_CFG(old_c)
>  
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1,	\
> +					CONFIG_k_1,			\
> +				  new_c_2, vendor_id_2, errata_id_2,	\
> +					CONFIG_k_2,			\
> +				  new_c_3, vendor_id_3, errata_id_3,	\
> +					CONFIG_k_3) \
> +       __ALTERNATIVE_CFG(old_c)
> +
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_RISCV_ALTERNATIVE */
>  
> @@ -202,4 +276,24 @@
>  					new_content_2, vendor_id_2,	\
>  					    errata_id_2, CONFIG_k_2)
>  
> +/*
> + * A vendor wants to replace an old_content, but another vendor has used
> + * ALTERNATIVE_2() to patch its customized content at the same location. In
> + * this case, this vendor can create a new macro ALTERNATIVE_3() based
> + * on the following sample code and then replace ALTERNATIVE_2() with
> + * ALTERNATIVE_3() to append its customized content.
> + */
> +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1,		\
> +					errata_id_1, CONFIG_k_1,	\
> +				   new_content_2, vendor_id_2,		\
> +					errata_id_2, CONFIG_k_2,	\
> +				   new_content_3, vendor_id_3,		\
> +					errata_id_3, CONFIG_k_3)	\
> +	_ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1,	\
> +					    errata_id_1, CONFIG_k_1,	\
> +					new_content_2, vendor_id_2,	\
> +					    errata_id_2, CONFIG_k_2,	\
> +					new_content_3, vendor_id_3,	\
> +					    errata_id_3, CONFIG_k_3)
> +
>  #endif
> 




