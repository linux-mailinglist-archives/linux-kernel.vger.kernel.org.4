Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD46412CB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiLCAuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiLCAtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:49:51 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CD861F60F;
        Fri,  2 Dec 2022 16:42:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E724023A;
        Fri,  2 Dec 2022 16:42:47 -0800 (PST)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437743F73B;
        Fri,  2 Dec 2022 16:42:39 -0800 (PST)
Date:   Sat, 3 Dec 2022 00:40:53 +0000
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
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Fabien Poussin <fabien.poussin@gmail.com>
Subject: Re: [PATCH 5/5] clk: sunxi-ng: d1: Add CAN bus gates and resets
Message-ID: <20221203004053.1be69003@slackpad.lan>
In-Reply-To: <20221126191319.6404-6-samuel@sholland.org>
References: <20221126191319.6404-1-samuel@sholland.org>
        <20221126191319.6404-6-samuel@sholland.org>
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

On Sat, 26 Nov 2022 13:13:19 -0600
Samuel Holland <samuel@sholland.org> wrote:

Hi,

> From: Fabien Poussin <fabien.poussin@gmail.com>
> 
> The D1 CCU contains gates and resets for two CAN buses. While the CAN
> bus controllers are only documented for the T113 SoC, the CCU is the
> same across all SoC variants.

So my version of the T113 manual only barely mentions the existence of
CAN controllers, but doesn't list any details, not even a base address
or those clock gates.
However I can confirm that the two lowest bits are implemented in
+0x92c. I also verified that the bits and numbers below match up.

> Signed-off-by: Fabien Poussin <fabien.poussin@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
> 
>  drivers/clk/sunxi-ng/ccu-sun20i-d1.c      | 11 +++++++++++
>  drivers/clk/sunxi-ng/ccu-sun20i-d1.h      |  2 +-
>  include/dt-bindings/clock/sun20i-d1-ccu.h |  2 ++
>  include/dt-bindings/reset/sun20i-d1-ccu.h |  2 ++
>  4 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
> index c5a7df93602c..48a8fb2c43b7 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
> @@ -469,6 +469,11 @@ static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws,
>  static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws,
>  			  0x91c, BIT(3), 0);
>  
> +static SUNXI_CCU_GATE_HWS(bus_can0_clk, "bus-can0", apb1_hws,
> +			  0x92c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HWS(bus_can1_clk, "bus-can1", apb1_hws,
> +			  0x92c, BIT(1), 0);
> +
>  static const struct clk_parent_data spi_parents[] = {
>  	{ .fw_name = "hosc" },
>  	{ .hw = &pll_periph0_clk.hw },
> @@ -997,6 +1002,8 @@ static struct ccu_common *sun20i_d1_ccu_clks[] = {
>  	&bus_i2c1_clk.common,
>  	&bus_i2c2_clk.common,
>  	&bus_i2c3_clk.common,
> +	&bus_can0_clk.common,
> +	&bus_can1_clk.common,
>  	&spi0_clk.common,
>  	&spi1_clk.common,
>  	&bus_spi0_clk.common,
> @@ -1147,6 +1154,8 @@ static struct clk_hw_onecell_data sun20i_d1_hw_clks = {
>  		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
>  		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
>  		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
> +		[CLK_BUS_CAN0]		= &bus_can0_clk.common.hw,
> +		[CLK_BUS_CAN1]		= &bus_can1_clk.common.hw,
>  		[CLK_SPI0]		= &spi0_clk.common.hw,
>  		[CLK_SPI1]		= &spi1_clk.common.hw,
>  		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
> @@ -1252,6 +1261,8 @@ static struct ccu_reset_map sun20i_d1_ccu_resets[] = {
>  	[RST_BUS_I2C1]		= { 0x91c, BIT(17) },
>  	[RST_BUS_I2C2]		= { 0x91c, BIT(18) },
>  	[RST_BUS_I2C3]		= { 0x91c, BIT(19) },
> +	[RST_BUS_CAN0]		= { 0x92c, BIT(16) },
> +	[RST_BUS_CAN1]		= { 0x92c, BIT(17) },
>  	[RST_BUS_SPI0]		= { 0x96c, BIT(16) },
>  	[RST_BUS_SPI1]		= { 0x96c, BIT(17) },
>  	[RST_BUS_EMAC]		= { 0x97c, BIT(16) },
> diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.h b/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
> index e303176f0d4e..b14da36e2537 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.h
> @@ -10,6 +10,6 @@
>  #include <dt-bindings/clock/sun20i-d1-ccu.h>
>  #include <dt-bindings/reset/sun20i-d1-ccu.h>
>  
> -#define CLK_NUMBER		(CLK_FANOUT2 + 1)
> +#define CLK_NUMBER		(CLK_BUS_CAN1 + 1)
>  
>  #endif /* _CCU_SUN20I_D1_H_ */
> diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
> index e3ac53315e1a..e143b9929763 100644
> --- a/include/dt-bindings/clock/sun20i-d1-ccu.h
> +++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
> @@ -152,5 +152,7 @@
>  #define CLK_FANOUT0		142
>  #define CLK_FANOUT1		143
>  #define CLK_FANOUT2		144
> +#define CLK_BUS_CAN0		145
> +#define CLK_BUS_CAN1		146
>  
>  #endif /* _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_ */
> diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
> index de9ff5203239..f8001cf50bf1 100644
> --- a/include/dt-bindings/reset/sun20i-d1-ccu.h
> +++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
> @@ -73,5 +73,7 @@
>  #define RST_BUS_DSP_CFG		63
>  #define RST_BUS_DSP_DBG		64
>  #define RST_BUS_RISCV_CFG	65
> +#define RST_BUS_CAN0		66
> +#define RST_BUS_CAN1		67
>  
>  #endif /* _DT_BINDINGS_RST_SUN20I_D1_CCU_H_ */

