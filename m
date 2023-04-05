Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390436D7BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbjDELs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237704AbjDELsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:48:55 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87940C4;
        Wed,  5 Apr 2023 04:48:52 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pk1d2-0006eI-Mo; Wed, 05 Apr 2023 13:48:40 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v7 03/22] clk: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
Date:   Wed, 05 Apr 2023 13:48:39 +0200
Message-ID: <23535525.6Emhk5qWAg@diego>
In-Reply-To: <20230401111934.130844-4-hal.feng@starfivetech.com>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230401111934.130844-4-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 1. April 2023, 13:19:15 CEST schrieb Hal Feng:
> Using ARCH_FOO symbol is preferred than SOC_FOO.
> Set obj-y for starfive/ in Makefile, so the StarFive drivers
> can be compiled with COMPILE_TEST=y but ARCH_STARFIVE=n.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>

Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

> ---
>  drivers/clk/Makefile         | 2 +-
>  drivers/clk/starfive/Kconfig | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index e3ca0d058a25..3bed88d67a3a 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -117,7 +117,7 @@ obj-$(CONFIG_PLAT_SPEAR)		+= spear/
>  obj-y					+= sprd/
>  obj-$(CONFIG_ARCH_STI)			+= st/
>  obj-$(CONFIG_ARCH_STM32)		+= stm32/
> -obj-$(CONFIG_SOC_STARFIVE)		+= starfive/
> +obj-y					+= starfive/
>  obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
>  obj-y					+= sunxi-ng/
>  obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 003bd2d56ce7..ef3517f4a276 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -2,8 +2,8 @@
>  
>  config CLK_STARFIVE_JH7100
>  	bool "StarFive JH7100 clock support"
> -	depends on SOC_STARFIVE || COMPILE_TEST
> -	default SOC_STARFIVE
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	default ARCH_STARFIVE
>  	help
>  	  Say yes here to support the clock controller on the StarFive JH7100
>  	  SoC.
> @@ -11,7 +11,7 @@ config CLK_STARFIVE_JH7100
>  config CLK_STARFIVE_JH7100_AUDIO
>  	tristate "StarFive JH7100 audio clock support"
>  	depends on CLK_STARFIVE_JH7100
> -	default m if SOC_STARFIVE
> +	default m if ARCH_STARFIVE
>  	help
>  	  Say Y or M here to support the audio clocks on the StarFive JH7100
>  	  SoC.
> 




