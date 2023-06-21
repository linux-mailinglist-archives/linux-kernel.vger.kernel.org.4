Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86547383CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjFUMa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFUMaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916CC19B6;
        Wed, 21 Jun 2023 05:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7C3161563;
        Wed, 21 Jun 2023 12:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AFCC433C8;
        Wed, 21 Jun 2023 12:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687350619;
        bh=8dPovHMHlki7kCvPUQn+9+NuCRp2YZT6fwDXNmnuMtk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SeQyL3t93QDnUk4F+UWMFfXbUp1aVhceLJWbCVxpPOVsfKPv0ZB4RD8GeB7xFIHaD
         yT1jZBa/Zy52BNF6frfMMWdnIk1YnBJEFkA5w64lHqmLgqaYRih/P6JLK6NCvCDgf0
         Xrxr18Gv/zhmRT598/IWPJ4VbZalwniAqA2i+Q75uGzMZhtmOoElVhDFfNUtt6dJ5D
         AJ1ctpeUGdeUiuDxuXsKUMf/lnIxvzGZ3RT5BSxcjKTv383xJiDPANrpm9W3WHHVIo
         9fKX3FbALDwlHQtuRk+H9CBBgj/hjXTWfEkjMGf4MeAUFuD4YMklr9e4DZ98tEvOpq
         2QoHA4aUHnaQg==
Date:   Wed, 21 Jun 2023 18:00:14 +0530
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
Subject: Re: [PATCH v5 2/3] phy: starfive: Add mipi dphy rx support
Message-ID: <ZJLtVoi2qpKOR1l6@matsya>
References: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
 <20230529121503.3544-3-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529121503.3544-3-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-23, 05:15, Changhuang Liang wrote:
> Add mipi dphy rx support for the StarFive JH7110 SoC. It is used to
> transfer CSI camera data.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  MAINTAINERS                                 |   7 +
>  drivers/phy/Kconfig                         |   1 +
>  drivers/phy/Makefile                        |   1 +
>  drivers/phy/starfive/Kconfig                |  13 +
>  drivers/phy/starfive/Makefile               |   2 +
>  drivers/phy/starfive/phy-starfive-dphy-rx.c | 300 ++++++++++++++++++++
>  6 files changed, 324 insertions(+)
>  create mode 100644 drivers/phy/starfive/Kconfig
>  create mode 100644 drivers/phy/starfive/Makefile
>  create mode 100644 drivers/phy/starfive/phy-starfive-dphy-rx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92c7076c4fed..a5fac3f015b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20092,6 +20092,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>  F:	drivers/net/ethernet/stmicro/stmmac/dwmac-starfive.c
>  
> +STARFIVE JH7110 DPHY RX DRIVER
> +M:	Jack Zhu <jack.zhu@starfivetech.com>
> +M:	Changhuang Liang <changhuang.liang@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> +F:	drivers/phy/starfive/phy-starfive-dphy-rx.c
> +
>  STARFIVE JH7110 MMC/SD/SDIO DRIVER
>  M:	William Qiu <william.qiu@starfivetech.com>
>  S:	Supported
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index f46e3148d286..0000149edbc4 100644
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
> index 000000000000..f989b8ff8bcb
> --- /dev/null
> +++ b/drivers/phy/starfive/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Phy drivers for StarFive platforms
> +#
> +
> +config PHY_STARFIVE_DPHY_RX
> +	tristate "StarFive D-PHY RX Support"
> +	select GENERIC_PHY
> +	select GENERIC_PHY_MIPI_DPHY
> +	help
> +	  Choose this option if you have a StarFive D-PHY in your
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
> index 000000000000..6974ed904d0d
> --- /dev/null
> +++ b/drivers/phy/starfive/phy-starfive-dphy-rx.c
> @@ -0,0 +1,300 @@
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
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#define STF_DPHY_APBCFGSAIF_SYSCFG(x)		(x)
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
> +#define STF_MAP_LANES_NUM			6
> +
> +struct regval {
> +	u32 addr;
> +	u32 val;
> +};
> +
> +struct stf_dphy_info {
> +	/**
> +	 * @maps:
> +	 *
> +	 * Physical lanes and logic lanes mapping table.
> +	 *
> +	 * The default order is:
> +	 * [clk lane0, data lane 0, data lane 1, data lane 2, date lane 3, clk lane 1]
> +	 */
> +	u8 maps[STF_MAP_LANES_NUM];
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
> +	const struct stf_dphy_info *info;
> +};
> +
> +static const struct regval stf_dphy_init_list[] = {
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(4), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(8), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(12), 0x0000fff0 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(16), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(20), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(24), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(28), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(32), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(36), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(40), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(40), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(48), 0x24000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(52), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(56), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(60), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(64), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(68), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(72), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(76), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(80), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(84), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(88), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(92), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(96), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(100), 0x02000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(104), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(108), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(112), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(116), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(120), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(124), 0x0000000c },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(128), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(132), 0xcc500000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(136), 0x000000cc },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(140), 0x00000000 },
> +	{ STF_DPHY_APBCFGSAIF_SYSCFG(144), 0x00000000 },
> +};
> +
> +static int stf_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	const struct stf_dphy_info *info = dphy->info;
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
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(0));
> +
> +	writel(FIELD_PREP(STF_DPHY_DATA_BUS16_8, 0) |
> +	       FIELD_PREP(STF_DPHY_DEBUG_MODE_SEL, 0x5a),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(184));

bunch of magic numbers here and previous one..?

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
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK, info->maps[0]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_CLK1, info->maps[5]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN0, info->maps[1]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN1, info->maps[2]),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(188));
> +
> +	writel(FIELD_PREP(STF_DPHY_LANE_SWAP_LAN2, info->maps[3]) |
> +	       FIELD_PREP(STF_DPHY_LANE_SWAP_LAN3, info->maps[4]) |
> +	       FIELD_PREP(STF_DPHY_MP_TEST_EN, 0) |
> +	       FIELD_PREP(STF_DPHY_MP_TEST_MODE_SEL, 0) |
> +	       FIELD_PREP(STF_DPHY_PLL_CLK_SEL, 0x37c) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK, 8),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(192));
> +
> +	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_CLK1, 8) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN0, 7) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN1, 7) |
> +	       FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN2, 7),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(196));
> +
> +	writel(FIELD_PREP(STF_DPHY_PRECOUNTER_IN_LAN3, 7) |
> +	       FIELD_PREP(STF_DPHY_RX_1C2C_SEL, 0),
> +	       dphy->regs + STF_DPHY_APBCFGSAIF_SYSCFG(200));
> +
> +	return 0;
> +}
> +
> +static int stf_dphy_power_on(struct phy *phy)
> +{
> +	struct stf_dphy *dphy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	pm_runtime_get_sync(dphy->dev);

no error check?

> +
> +	ret = regulator_enable(dphy->mipi_0p9);
> +	if (ret)
> +		return ret;

should you not drop the pm reference on error here?

-- 
~Vinod
