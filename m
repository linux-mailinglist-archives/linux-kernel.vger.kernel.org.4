Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5546411DB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbiLCAQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiLCAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:16:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EFA9D80E6;
        Fri,  2 Dec 2022 16:16:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D2423A;
        Fri,  2 Dec 2022 16:16:47 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299303F73B;
        Fri,  2 Dec 2022 16:16:39 -0800 (PST)
Date:   Sat, 3 Dec 2022 00:14:57 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/5] clk: sunxi-ng: Remove duplicate ARCH_SUNXI
 dependencies
Message-ID: <20221203001439.64284671@slackpad.lan>
In-Reply-To: <20221126191319.6404-2-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
        <20221126191319.6404-2-samuel@sholland.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Nov 2022 13:13:15 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi,

thanks for addressing this!

> SUNXI_CCU already depends on ARCH_SUNXI, so adding the dependency to
> individual SoC drivers is redundant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/clk/sunxi-ng/Kconfig | 43 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 461537679c04..64cfa022e320 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -14,43 +14,43 @@ config SUNIV_F1C100S_CCU
>  
>  config SUN20I_D1_CCU
>  	tristate "Support for the Allwinner D1 CCU"
> -	default RISCV && ARCH_SUNXI
> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
> +	default RISCV
> +	depends on RISCV || COMPILE_TEST

I agree on the "depends" part: Indeed the guard symbol already covers
that, so it's redundant.
However I am not so sure about the "default" part: When ARCH_SUNXI is
deselected, but COMPILE_TEST in enabled, we default to every CCU driver
being built-in. I am not sure this is the intention, or at least
expected when doing compile testing?

>  
>  config SUN20I_D1_R_CCU
>  	tristate "Support for the Allwinner D1 PRCM CCU"
> -	default RISCV && ARCH_SUNXI
> -	depends on (RISCV && ARCH_SUNXI) || COMPILE_TEST
> +	default RISCV
> +	depends on RISCV || COMPILE_TEST
>  
>  config SUN50I_A64_CCU
>  	tristate "Support for the Allwinner A64 CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST

I wonder if this "depends" line was always wrong and should be fixed:
We can compile a 32-bit ARM kernel and run it on an A64. Granted this
requires a special bootloader or a hacked U-Boot (tried that), and
reveals some other issues with the decompressor, but technically there
is no 64-bit dependency in here.
The same goes for all the other ARM64 CCUs: Cortex-A53s can run AArch32
in all exception levels.
So shall we just completely remove the "depends" line for those, and
let SUNXI_CCU do that job? Or use use !RISCV || COMPILE_TEST?

Cheers,
Andre

>  
>  config SUN50I_A100_CCU
>  	tristate "Support for the Allwinner A100 CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST
>  
>  config SUN50I_A100_R_CCU
>  	tristate "Support for the Allwinner A100 PRCM CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST
>  
>  config SUN50I_H6_CCU
>  	tristate "Support for the Allwinner H6 CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST
>  
>  config SUN50I_H616_CCU
>  	tristate "Support for the Allwinner H616 CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST
>  
>  config SUN50I_H6_R_CCU
>  	tristate "Support for the Allwinner H6 and H616 PRCM CCU"
> -	default ARM64 && ARCH_SUNXI
> -	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default ARM64
> +	depends on ARM64 || COMPILE_TEST
>  
>  config SUN4I_A10_CCU
>  	tristate "Support for the Allwinner A10/A20 CCU"
> @@ -71,8 +71,7 @@ config SUN6I_A31_CCU
>  
>  config SUN6I_RTC_CCU
>  	tristate "Support for the Allwinner H616/R329 RTC CCU"
> -	default ARCH_SUNXI
> -	depends on ARCH_SUNXI || COMPILE_TEST
> +	default y
>  
>  config SUN8I_A23_CCU
>  	tristate "Support for the Allwinner A23 CCU"
> @@ -91,8 +90,8 @@ config SUN8I_A83T_CCU
>  
>  config SUN8I_H3_CCU
>  	tristate "Support for the Allwinner H3 CCU"
> -	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> -	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> +	default MACH_SUN8I || ARM64
> +	depends on MACH_SUN8I || ARM64 || COMPILE_TEST
>  
>  config SUN8I_V3S_CCU
>  	tristate "Support for the Allwinner V3s CCU"
> @@ -101,7 +100,7 @@ config SUN8I_V3S_CCU
>  
>  config SUN8I_DE2_CCU
>  	tristate "Support for the Allwinner SoCs DE2 CCU"
> -	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> +	default MACH_SUN8I || ARM64
>  
>  config SUN8I_R40_CCU
>  	tristate "Support for the Allwinner R40 CCU"
> @@ -115,6 +114,6 @@ config SUN9I_A80_CCU
>  
>  config SUN8I_R_CCU
>  	tristate "Support for Allwinner SoCs' PRCM CCUs"
> -	default MACH_SUN8I || (ARCH_SUNXI && ARM64)
> +	default MACH_SUN8I || ARM64
>  
>  endif

