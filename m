Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF66C1203
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCTMh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjCTMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B975E24BC4;
        Mon, 20 Mar 2023 05:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3245B614CD;
        Mon, 20 Mar 2023 12:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EB6C433EF;
        Mon, 20 Mar 2023 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679315870;
        bh=JVJHvlbT4Notda38fkVV7buddbXthk09NJdXdenPzUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GSQbBVDA9dPgaYyTiar/ja1f5cPQNp8eEImq06AkgqJhGhFqgrMjzDJ20FotZ+EXT
         9aKvWajegpIZnWo8TPa1C1GqNAelkYrfpwN/vlcvqNZt8zmwoUfasxecTU8UzmDGwt
         ZV/mwXGYpMDoJ6y8DfTPecgKQYVBLxtk3RfqaTjabb6mUFsA7iGz7J+JVHlQ2p1EJH
         VSh2N0nG1lSAqdIYyC81+ZX/qGgw7sCQ1blpIDG/FWxdDTMsfxnrk81+hYOYj+zzuC
         EL0a0Lb9rdFf0mKB05jdwPFFj/yAmaBbDYbiPbUXeQm2SAF//+0ZHmw8RSjKmIWxD5
         ILvkuBAvgzu7Q==
Date:   Mon, 20 Mar 2023 18:07:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/3] phy: starfive: Add mipi dphy rx support
Message-ID: <ZBhTmTEcrV59oaw3@matsya>
References: <20230223015952.201841-1-changhuang.liang@starfivetech.com>
 <20230223015952.201841-3-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223015952.201841-3-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-23, 17:59, Changhuang Liang wrote:
> Add mipi dphy rx support for the Starfive JH7110 SoC. It is used to
> transfer CSI camera data.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/phy/Kconfig                         |   1 +
>  drivers/phy/Makefile                        |   1 +
>  drivers/phy/starfive/Kconfig                |  13 +
>  drivers/phy/starfive/Makefile               |   2 +
>  drivers/phy/starfive/phy-starfive-dphy-rx.c | 362 ++++++++++++++++++++
>  6 files changed, 386 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-starfive-dphy-rx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e70c9f21989..8ddef8669efb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19952,6 +19952,13 @@ F:	Documentation/devicetree/bindings/power/starfive*
>  F:	drivers/soc/starfive/jh71xx_pmu.c
>  F:	include/dt-bindings/power/starfive,jh7110-pmu.h
>  
> +STARFIVE JH7110 DPHY RX DRIVER
> +M:	Jack Zhu <jack.zhu@starfivetech.com>
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> +F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
> +
>  STATIC BRANCH/CALL
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 7bd00a11d074..c4b2a86e2afb 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -91,6 +91,7 @@ source "drivers/phy/rockchip/Kconfig"
>  source "drivers/phy/samsung/Kconfig"
>  source "drivers/phy/socionext/Kconfig"
>  source "drivers/phy/st/Kconfig"
> +source "drivers/phy/starfive/Kconfig"
>  source "drivers/phy/sunplus/Kconfig"
>  source "drivers/phy/tegra/Kconfig"
>  source "drivers/phy/ti/Kconfig"
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 54f312c10a40..fb3dc9de6111 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
>  					   samsung/	\
>  					   socionext/	\
>  					   st/		\
> +					   starfive/	\
>  					   sunplus/	\
>  					   tegra/	\
>  					   ti/		\
> diff --git a/drivers/phy/starfive/Kconfig b/drivers/phy/starfive/Kconfig
> new file mode 100644
> index 000000000000..e449a662acf5
> --- /dev/null
> +++ b/drivers/phy/starfive/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Phy drivers for Starfive platforms
> +#
> +
> +config PHY_STARFIVE_DPHY_RX
> +	tristate "Starfive D-PHY RX Support"
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Choose this option if you have a Starfive D-PHY in your
> +	  system. If M is selected, the module will be called
> +	  phy-starfive-dphy-rx.
> diff --git a/drivers/phy/starfive/Makefile b/drivers/phy/starfive/Makefile
> new file mode 100644
> index 000000000000..7ec576cb30ae
> --- /dev/null
> +++ b/drivers/phy/starfive/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PHY_STARFIVE_DPHY_RX)      += phy-starfive-dphy-rx.o
> diff --git a/drivers/phy/starfive/phy-starfive-dphy-rx.c b/drivers/phy/starfive/phy-starfive-dphy-rx.c
> new file mode 100644
> index 000000000000..2a7c5453f4ce
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-starfive-dphy-rx.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * DPHY driver for the StarFive JH7110 SoC
> + *
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#define STF_DPHY_APBCFGSAIF__SYSCFG(x)		(x)

What is the purpose of this? also whats with __ ?

> +
> +#define STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_EN BIT(6)
> +#define STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_IN GENMASK(12, 7)
> +#define STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_EN BIT(19)
> +#define STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_IN GENMASK(25, 20)
> +
> +#define STF_DPHY_DATA_BUS16_8			BIT(8)
> +#define STF_DPHY_DEBUG_MODE_SEL			GENMASK(15, 9)
> +
> +#define STF_DPHY_ENABLE_CLK			BIT(6)
> +#define STF_DPHY_ENABLE_CLK1			BIT(7)
> +#define STF_DPHY_ENABLE_LAN0			BIT(8)
> +#define STF_DPHY_ENABLE_LAN1			BIT(9)
> +#define STF_DPHY_ENABLE_LAN2			BIT(10)
> +#define STF_DPHY_ENABLE_LAN3			BIT(11)
> +#define STF_DPHY_GPI_EN				GENMASK(17, 12)
> +#define STF_DPHY_HS_FREQ_CHANGE_CLK		BIT(18)
> +#define STF_DPHY_HS_FREQ_CHANGE_CLK1		BIT(19)
> +#define STF_DPHY_LANE_SWAP_CLK			GENMASK(22, 20)
> +#define STF_DPHY_LANE_SWAP_CLK1			GENMASK(25, 23)
> +#define STF_DPHY_LANE_SWAP_LAN0			GENMASK(28, 26)
> +#define STF_DPHY_LANE_SWAP_LAN1			GENMASK(31, 29)
> +
> +#define STF_DPHY_LANE_SWAP_LAN2			GENMASK(2, 0)
> +#define STF_DPHY_LANE_SWAP_LAN3			GENMASK(5, 3)
> +#define STF_DPHY_MP_TEST_EN			BIT(6)
> +#define STF_DPHY_MP_TEST_MODE_SEL		GENMASK(11, 7)
> +#define STF_DPHY_PLL_CLK_SEL			GENMASK(21, 12)
> +#define STF_DPHY_PRECOUNTER_IN_CLK		GENMASK(29, 22)
> +
> +#define STF_DPHY_PRECOUNTER_IN_CLK1		GENMASK(7, 0)
> +#define STF_DPHY_PRECOUNTER_IN_LAN0		GENMASK(15, 8)
> +#define STF_DPHY_PRECOUNTER_IN_LAN1		GENMASK(23, 16)
> +#define STF_DPHY_PRECOUNTER_IN_LAN2		GENMASK(31, 24)
> +
> +#define STF_DPHY_PRECOUNTER_IN_LAN3		GENMASK(7, 0)
> +#define STF_DPHY_RX_1C2C_SEL			BIT(8)
> +
> +struct regval_t {

regval should be okay, no?

> +	u32 addr;
> +	u32 val;
> +};
> +
> +struct stf_dphy {
> +	struct device *dev;
> +	void __iomem *regs;
> +	struct clk *cfg_clk;
> +	struct clk *ref_clk;
> +	struct clk *tx_clk;
> +	struct reset_control *rstc;
> +	struct regulator *mipi_0p9;
> +	struct phy *phy;
> +	struct regmap *stf_aon_syscon;
> +	unsigned int aon_gp_reg;
> +};
> +
> +struct stf_dphy_info {
> +	bool external_support;
> +	int (*external_get)(struct stf_dphy *dphy);
> +	void (*external_init)(struct stf_dphy *dphy);
> +	void (*external_exit)(struct stf_dphy *dphy);
> +};
> +
> +static const struct stf_dphy_info *stf_dphy_info;
> +
> +static const struct regval_t stf_dphy_init_list[] = {
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(4), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(8), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(12), 0x0000fff0 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(16), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(20), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(24), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(28), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(32), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(36), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(40), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(48), 0x24000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(52), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(56), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(60), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(64), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(68), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(72), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(76), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(80), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(84), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(88), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(92), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(96), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(100), 0x02000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(104), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(108), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(112), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(116), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(120), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(124), 0x0000000c },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(128), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(132), 0xcc500000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(136), 0x000000cc },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(140), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF__SYSCFG(144), 0x00000000 },
> +};
> +
> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int map[6] = {4, 0, 1, 2, 3, 5};

what does this mean?

> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(stf_dphy_init_list); i++)
> +		writel(stf_dphy_init_list[i].val,
> +		       dphy->regs + stf_dphy_init_list[i].addr);
> +
> +	writel(FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_EN, 1) |
> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL0_2D1C_EFUSE_IN, 0x1b) |
> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_EN, 1) |
> +	       FIELD_PREP(STF_DPHY_DA_CDPHY_R100_CTRL1_2D1C_EFUSE_IN, 0x1b),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(0));
> +
> +	writel(FIELD_PREP(STF_DPHY_DATA_BUS16_8, 0) |
> +	       FIELD_PREP(STF_DPHY_DEBUG_MODE_SEL, 0x5a),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(184));
> +
> +	writel(FIELD_PREP(STF_DPHY_ENABLE_CLK, 1) |
> +	       FIELD_PREP(STF_DPHY_ENABLE_CLK1, 1) |
> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN0, 1) |
> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN1, 1) |
> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN2, 1) |
> +	       FIELD_PREP(STF_DPHY_ENABLE_LAN3, 1) |
> +	       FIELD_PREP(STF_DPHY_GPI_EN, 0) |
> +	       FIELD_PREP(STF_DPHY_HS_FREQ_CHANGE_CLK, 0) |
> +	       FIELD_PREP(STF_DPHY_HS_FREQ_CHANGE_CLK1, 0) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK, map[0]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK1, map[5]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN0, map[1]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN1, map[2]),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(188));
> +
> +	writel(FIELD_PREP(STF_DPHY_LANE_SWAP_LAN2, map[3]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN3, map[4]) |
> +	       FIELD_PREP(STF_DPHY_MP_TEST_EN, 0) |
> +	       FIELD_PREP(STF_DPHY_MP_TEST_MODE_SEL, 0) |
> +	       FIELD_PREP(STF_DPHY_PLL_CLK_SEL, 0x37c) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK, 8),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(192));
> +
> +	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK1, 8) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN0, 7) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN1, 7) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN2, 7),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(196));
> +
> +	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN3, 7) |
> +	       FIELD_PREP(STF_DPHY_RX_1C2C_SEL, 0),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF__SYSCFG(200));
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_init(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = regulator_enable(dphy->mipi_0p9);
> +	if (ret)
> +		goto err_0p9;
> +
> +	if (stf_dphy_info->external_support && stf_dphy_info->external_init)
> +		stf_dphy_info->external_init(dphy);
> +
> +	return 0;
> +
> +err_0p9:
> +	return ret;
> +}
> +
> +static int stf_dphy_exit(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +
> +	if (stf_dphy_info->external_support && stf_dphy_info->external_exit)
> +		stf_dphy_info->external_exit(dphy);
> +
> +	regulator_disable(dphy->mipi_0p9);
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_power_on(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +
> +	clk_set_rate(dphy->cfg_clk, 99000000);
> +	clk_set_rate(dphy->ref_clk, 49500000);
> +	clk_set_rate(dphy->tx_clk, 19800000);
> +	reset_control_deassert(dphy->rstc);
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_power_off(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +
> +	reset_control_assert(dphy->rstc);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops stf_dphy_ops = {
> +	.init      = stf_dphy_init,
> +	.exit      = stf_dphy_exit,
> +	.configure = stf_dphy_configure,
> +	.power_on  = stf_dphy_power_on,
> +	.power_off = stf_dphy_power_off,
> +};
> +
> +static int stf_dphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct stf_dphy *dphy;
> +	int ret;
> +
> +	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
> +	if (!dphy)
> +		return -ENOMEM;
> +	stf_dphy_info = of_device_get_match_data(&pdev->dev);
> +	dev_set_drvdata(&pdev->dev, dphy);
> +	dphy->dev = &pdev->dev;
> +
> +	dphy->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dphy->regs))
> +		return PTR_ERR(dphy->regs);
> +
> +	dphy->cfg_clk = devm_clk_get(&pdev->dev, "cfg");
> +	if (IS_ERR(dphy->cfg_clk))
> +		return PTR_ERR(dphy->cfg_clk);
> +
> +	dphy->ref_clk = devm_clk_get(&pdev->dev, "ref");
> +	if (IS_ERR(dphy->ref_clk))
> +		return PTR_ERR(dphy->ref_clk);
> +
> +	dphy->tx_clk = devm_clk_get(&pdev->dev, "tx");
> +	if (IS_ERR(dphy->tx_clk))
> +		return PTR_ERR(dphy->tx_clk);
> +
> +	dphy->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
> +	if (IS_ERR(dphy->rstc))
> +		return PTR_ERR(dphy->rstc);
> +
> +	dphy->mipi_0p9 = devm_regulator_get(&pdev->dev, "mipi_0p9");
> +	if (IS_ERR(dphy->mipi_0p9))
> +		return PTR_ERR(dphy->mipi_0p9);
> +
> +	if (stf_dphy_info->external_support && stf_dphy_info->external_get) {
> +		ret = stf_dphy_info->external_get(dphy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "Failed to get PHY external info\n");
> +			return ret;
> +		}
> +	}
> +
> +	dphy->phy = devm_phy_create(&pdev->dev, NULL, &stf_dphy_ops);
> +	if (IS_ERR(dphy->phy)) {
> +		dev_err(&pdev->dev, "Failed to create PHY\n");
> +		return PTR_ERR(dphy->phy);
> +	}
> +
> +	phy_set_drvdata(dphy->phy, dphy);
> +	phy_provider = devm_of_phy_provider_register(&pdev->dev,
> +						     of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static int stf_external_get(struct stf_dphy *dphy)
> +{
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	ret = of_parse_phandle_with_fixed_args(dphy->dev->of_node,
> +					       "starfive,aon-syscon",
> +					       1, 0, &args);
> +	if (ret < 0) {
> +		dev_err(dphy->dev, "Failed to parse starfive,aon-syscon\n");
> +		return -EINVAL;
> +	}
> +
> +	dphy->stf_aon_syscon = syscon_node_to_regmap(args.np);
> +	of_node_put(args.np);
> +	if (IS_ERR(dphy->stf_aon_syscon))
> +		return PTR_ERR(dphy->stf_aon_syscon);
> +
> +	dphy->aon_gp_reg = args.args[0];
> +
> +	return 0;
> +}
> +
> +static void stf_external_init(struct stf_dphy *dphy)
> +{
> +	regmap_update_bits(dphy->stf_aon_syscon, dphy->aon_gp_reg,
> +			   BIT(31), BIT(31));
> +}
> +
> +static void stf_external_exit(struct stf_dphy *dphy)
> +{
> +	regmap_update_bits(dphy->stf_aon_syscon, dphy->aon_gp_reg,
> +			   BIT(31), 0);
> +}
> +
> +static const struct stf_dphy_info starfive_dphy_info = {
> +	.external_support = true,
> +	.external_get = stf_external_get,
> +	.external_init = stf_external_init,
> +	.external_exit = stf_external_exit,
> +};
> +
> +static const struct of_device_id stf_dphy_dt_ids[] = {
> +	{
> +		.compatible = "starfive,jh7110-dphy-rx",
> +		.data = &starfive_dphy_info,

is there a plan to support multiple versions which need different
get/init/exit methods?

> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, stf_dphy_dt_ids);
> +
> +static struct platform_driver stf_dphy_driver = {
> +	.probe = stf_dphy_probe,
> +	.driver = {
> +		.name	= "starfive-dphy-rx",
> +		.of_match_table = stf_dphy_dt_ids,
> +	},
> +};
> +module_platform_driver(stf_dphy_driver);
> +
> +MODULE_AUTHOR("Jack Zhu <jack.zhu@starfivetech.com>");
> +MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
> +MODULE_DESCRIPTION("Starfive DPHY RX driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1

-- 
~Vinod
