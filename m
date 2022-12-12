Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE9649EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiLLMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 07:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiLLMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 07:33:01 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF8910FCB;
        Mon, 12 Dec 2022 04:32:51 -0800 (PST)
Received: from p57b7793f.dip0.t-ipconnect.de ([87.183.121.63] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1p4hyl-00033o-D8; Mon, 12 Dec 2022 13:32:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Guo Ren <guoren@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 1/6] riscv: asm: alternative-macros: Introduce ALTERNATIVE_3() macro
Date:   Mon, 12 Dec 2022 13:32:17 +0100
Message-ID: <8194084.DvuYhMxLoT@phil>
In-Reply-To: <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221212115505.36770-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221212115505.36770-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Am Montag, 12. Dezember 2022, 12:55:00 CET schrieb Prabhakar:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Introduce ALTERNATIVE_3() macro.
> 
> A vendor wants to replace an old_content, but another vendor has used
> ALTERNATIVE_2() to patch its customized content at the same location.
> In this case, this vendor can use macro ALTERNATIVE_3() and then replace
> ALTERNATIVE_2() with ALTERNATIVE_3() to append its customized content.
> 
> While at it update comment above ALTERNATIVE_2() macro and make it generic
> so that the comment holds good for any new addition of ALTERNATIVE_X()
> macros.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

> ---
> v4->v5
> * Rebased the patch on top of Andrew's series (now in Palmers for next-branch)
> * Updated comment for ALTERNATIVE_x() as suggested by Heiko
> 
> RFC v3 -> v4
> * New patch
> ---
>  arch/riscv/include/asm/alternative-macros.h | 46 ++++++++++++++++++---
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 7226e2462584..a5b4691520da 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -50,8 +50,17 @@
>  	ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
>  .endm
>  
> +.macro ALTERNATIVE_CFG_3 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
> +				new_c_2, vendor_id_2, errata_id_2, enable_2,	\
> +				new_c_3, vendor_id_3, errata_id_3, enable_3
> +       ALTERNATIVE_CFG_2 \old_c, \new_c_1, \vendor_id_1, \errata_id_1, \enable_1,	\
> +                                 \new_c_2, \vendor_id_2, \errata_id_2, \enable_2
> +       ALT_NEW_CONTENT \vendor_id_3, \errata_id_3, \enable_3, \new_c_3
> +.endm
> +
>  #define __ALTERNATIVE_CFG(...)		ALTERNATIVE_CFG __VA_ARGS__
>  #define __ALTERNATIVE_CFG_2(...)	ALTERNATIVE_CFG_2 __VA_ARGS__
> +#define __ALTERNATIVE_CFG_3(...)	ALTERNATIVE_CFG_3 __VA_ARGS__
>  
>  #else /* !__ASSEMBLY__ */
>  
> @@ -98,6 +107,13 @@
>  	__ALTERNATIVE_CFG(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1)	\
>  	ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
>  
> +#define __ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
> +				   new_c_2, vendor_id_2, errata_id_2, enable_2,	\
> +				   new_c_3, vendor_id_3, errata_id_3, enable_3)	\
> +	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, enable_1,	\
> +                                   new_c_2, vendor_id_2, errata_id_2, enable_2)	\
> +	ALT_NEW_CONTENT(vendor_id_3, errata_id_3, enable_3, new_c_3)
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k)	\
> @@ -108,6 +124,13 @@
>  	__ALTERNATIVE_CFG_2(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),	\
>  				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2))
>  
> +#define _ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
> +				  new_c_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
> +				  new_c_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
> +	__ALTERNATIVE_CFG_3(old_c, new_c_1, vendor_id_1, errata_id_1, IS_ENABLED(CONFIG_k_1),	\
> +				   new_c_2, vendor_id_2, errata_id_2, IS_ENABLED(CONFIG_k_2),	\
> +				   new_c_3, vendor_id_3, errata_id_3, IS_ENABLED(CONFIG_k_3))
> +
>  #else /* CONFIG_RISCV_ALTERNATIVE */
>  #ifdef __ASSEMBLY__
>  
> @@ -152,15 +175,28 @@
>  	_ALTERNATIVE_CFG(old_content, new_content, vendor_id, errata_id, CONFIG_k)
>  
>  /*
> - * A vendor wants to replace an old_content, but another vendor has used
> - * ALTERNATIVE() to patch its customized content at the same location. In
> - * this case, this vendor can create a new macro ALTERNATIVE_2() based
> - * on the following sample code and then replace ALTERNATIVE() with
> - * ALTERNATIVE_2() to append its customized content.
> + * ALTERNATIVE_x macros allow providing multiple replacement options
> + * for an ALTERNATIVE code section. This is helpful if multiple
> + * implementation variants for the same functionality exist for
> + * different cpu cores.
> + *
> + * Usage:
> + *   ALTERNATIVE_x(old_content,
> + *      new_content1, vendor_id1, errata_id1, CONFIG_k1,
> + *      new_content2, vendor_id2, errata_id2, CONFIG_k2,
> + *      ...
> + *      new_contentx, vendor_idx, errata_idx, CONFIG_kx)
>   */
>  #define ALTERNATIVE_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
>  				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)		\
>  	_ALTERNATIVE_CFG_2(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,	\
>  					new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2)
>  
> +#define ALTERNATIVE_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,		\
> +				   new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,		\
> +				   new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)		\
> +       _ALTERNATIVE_CFG_3(old_content, new_content_1, vendor_id_1, errata_id_1, CONFIG_k_1,	\
> +                                       new_content_2, vendor_id_2, errata_id_2, CONFIG_k_2,	\
> +                                       new_content_3, vendor_id_3, errata_id_3, CONFIG_k_3)
> +
>  #endif
> 




