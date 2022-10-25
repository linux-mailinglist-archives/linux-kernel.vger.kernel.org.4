Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30A60CA2F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiJYKg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbiJYKgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:36:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26322E9D4;
        Tue, 25 Oct 2022 03:36:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D14D366023A0;
        Tue, 25 Oct 2022 11:36:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666694177;
        bh=88jblz1wmZWqYd6CzvM6lyG5xtCcQ3zRGSsWSArI80U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lw7uR5PWo6cOI9fF+wmjXzJ0LfMvtyfiJls4R2fj8Hnwz8bSnSnhhjNWwyu0CBxLy
         OMR+YkJMOHJGQB5+bEuC5Ip21ANdHXEoZAlVKoTftbY57AkU3OPLgxpHv8iNmYJS7O
         IeMqNJ2RiPxc/Ryi79SgXDrQvj7KgzNYOWSPu64ie8GpakVzJv3Xs3NELfOA+WOeVB
         4NSAo71LzvZLBxrDVzl9d2kCzzIQ4AZWXFRHvBnrqOBfDGZAflgKJaQWjc3GBSYud+
         rD2G92aTgKRSN3Pdnqbl5V0UwlPdQ3WqbBH+aMCkVliU6O0OTuL2Hp4ANOSg93OSYl
         9RZjyGg4dKZtQ==
Message-ID: <8b73e38b-ae78-1f85-f5f0-f13bce6e45de@collabora.com>
Date:   Tue, 25 Oct 2022 12:36:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v6 1/3] reset: mediatek: Move MediaTek system clock reset
 to reset/mediatek
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, sboyd@kernel.org,
        mturquette@baylibre.com, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, nfraprado@collabora.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221021104804.21391-1-rex-bc.chen@mediatek.com>
 <20221021104804.21391-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221021104804.21391-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/10/22 12:48, Bo-Chen Chen ha scritto:
> To manager MediaTek system clock reset easier, we move the driver to
> drivers/reset/mediatek.
> 
> - Create reset/mediatek folder.
> - Move clk/mediatek/reset.c to reset/mediatek/reset-mediatek-sysclk.c
> - Because we don't want to build in unsed static variable, we use clk
>    KConfig to separate them. For example, when we use MT8186, we don't
>    want to build in the static constants for MT8195.
> - Move reset data which are scattered around the mediatek drivers to
>    reset-mtxxxx.c.
> - There are two version for mtk_reset_init because some mediatek clock
>    drivers (mt8135 and mt8173) are using device_node instead of device,
>    so we need to add two version for the init function.
> 
> Suggested-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/Kconfig                  |   1 +
>   drivers/clk/mediatek/Makefile                 |   2 +-
>   drivers/clk/mediatek/clk-mt2701-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701-g3d.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701-hif.c         |  10 +-
>   drivers/clk/mediatek/clk-mt2701.c             |  22 +-
>   drivers/clk/mediatek/clk-mt2712.c             |  22 +-
>   drivers/clk/mediatek/clk-mt6795-infracfg.c    |  22 +-
>   drivers/clk/mediatek/clk-mt6795-pericfg.c     |  20 +-
>   drivers/clk/mediatek/clk-mt7622-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt7622-hif.c         |  12 +-
>   drivers/clk/mediatek/clk-mt7622.c             |  22 +-
>   drivers/clk/mediatek/clk-mt7629-eth.c         |  10 +-
>   drivers/clk/mediatek/clk-mt7629-hif.c         |  12 +-
>   drivers/clk/mediatek/clk-mt8135.c             |  23 +-
>   drivers/clk/mediatek/clk-mt8173.c             |  22 +-
>   drivers/clk/mediatek/clk-mt8183.c             |  15 +-
>   drivers/clk/mediatek/clk-mt8186-infra_ao.c    |  23 +-
>   drivers/clk/mediatek/clk-mt8192.c             |  27 +-
>   drivers/clk/mediatek/clk-mt8195-infra_ao.c    |  28 +-
>   drivers/clk/mediatek/clk-mtk.c                |   5 +-
>   drivers/clk/mediatek/clk-mtk.h                |   5 +-
>   drivers/clk/mediatek/reset.c                  | 233 -----------
>   drivers/reset/Kconfig                         |   1 +
>   drivers/reset/Makefile                        |   1 +
>   drivers/reset/mediatek/Kconfig                |   5 +
>   drivers/reset/mediatek/Makefile               |  13 +
>   .../reset/mediatek/reset-mediatek-sysclk.c    | 388 ++++++++++++++++++
>   drivers/reset/mediatek/reset-mt2701.c         | 102 +++++
>   drivers/reset/mediatek/reset-mt2712.c         |  42 ++
>   drivers/reset/mediatek/reset-mt6795.c         |  61 +++
>   drivers/reset/mediatek/reset-mt7622.c         |  91 ++++
>   drivers/reset/mediatek/reset-mt7629.c         |  62 +++
>   drivers/reset/mediatek/reset-mt8135.c         |  43 ++
>   drivers/reset/mediatek/reset-mt8173.c         |  43 ++
>   drivers/reset/mediatek/reset-mt8183.c         |  31 ++
>   drivers/reset/mediatek/reset-mt8186.c         |  39 ++
>   drivers/reset/mediatek/reset-mt8192.c         |  43 ++
>   drivers/reset/mediatek/reset-mt8195.c         |  44 ++
>   .../linux/reset/reset-mediatek-sysclk.h       |  62 +--
>   40 files changed, 1080 insertions(+), 557 deletions(-)
>   delete mode 100644 drivers/clk/mediatek/reset.c
>   create mode 100644 drivers/reset/mediatek/Kconfig
>   create mode 100644 drivers/reset/mediatek/Makefile
>   create mode 100644 drivers/reset/mediatek/reset-mediatek-sysclk.c
>   create mode 100644 drivers/reset/mediatek/reset-mt2701.c
>   create mode 100644 drivers/reset/mediatek/reset-mt2712.c
>   create mode 100644 drivers/reset/mediatek/reset-mt6795.c
>   create mode 100644 drivers/reset/mediatek/reset-mt7622.c
>   create mode 100644 drivers/reset/mediatek/reset-mt7629.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8135.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8173.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8183.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8186.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8192.c
>   create mode 100644 drivers/reset/mediatek/reset-mt8195.c
>   rename drivers/clk/mediatek/reset.h => include/linux/reset/reset-mediatek-sysclk.h (59%)
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 843cea0c7a44..e372f145eada 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -8,6 +8,7 @@ menu "Clock driver for MediaTek SoC"
>   config COMMON_CLK_MEDIATEK
>   	tristate
>   	select RESET_CONTROLLER
> +	select RESET_MEDIATEK_SYSCLK
>   	help
>   	  MediaTek SoCs' clock support.
>   

..snip..

> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 3e7e5fd633a8..5cef7ccc9a7d 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-y += core.o
>   obj-y += hisilicon/
> +obj-y += mediatek/

I'd be more for

obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/

as there's no reason to even compile these if MTK support isn't enabled at all.

>   obj-$(CONFIG_ARCH_STI) += sti/
>   obj-$(CONFIG_ARCH_TEGRA) += tegra/
>   obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
> diff --git a/drivers/reset/mediatek/Kconfig b/drivers/reset/mediatek/Kconfig
> new file mode 100644
> index 000000000000..a416cb938753
> --- /dev/null
> +++ b/drivers/reset/mediatek/Kconfig
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Similarly, we should at this point also do....

if ARCH_MEDIATEK

> +config RESET_MEDIATEK_SYSCLK
> +	tristate "MediaTek System Clock Reset Driver"
> +	help
> +	  This enables the system clock reset driver for MediaTek SoCs.

endif # ARCH_MEDIATEK

> diff --git a/drivers/reset/mediatek/Makefile b/drivers/reset/mediatek/Makefile
> new file mode 100644
> index 000000000000..83f26c2cecdd
> --- /dev/null
> +++ b/drivers/reset/mediatek/Makefile
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_RESET_MEDIATEK_SYSCLK) += reset-mediatek-sysclk.o
> +obj-$(CONFIG_COMMON_CLK_MT2701) += reset-mt2701.o
> +obj-$(CONFIG_COMMON_CLK_MT2712) += reset-mt2712.o
> +obj-$(CONFIG_COMMON_CLK_MT6795) += reset-mt6795.o
> +obj-$(CONFIG_COMMON_CLK_MT7622) += reset-mt7622.o
> +obj-$(CONFIG_COMMON_CLK_MT7629) += reset-mt7629.o
> +obj-$(CONFIG_COMMON_CLK_MT8135) += reset-mt8135.o
> +obj-$(CONFIG_COMMON_CLK_MT8173) += reset-mt8173.o
> +obj-$(CONFIG_COMMON_CLK_MT8183) += reset-mt8183.o
> +obj-$(CONFIG_COMMON_CLK_MT8186) += reset-mt8186.o
> +obj-$(CONFIG_COMMON_CLK_MT8192) += reset-mt8192.o
> +obj-$(CONFIG_COMMON_CLK_MT8195) += reset-mt8195.o
> diff --git a/drivers/reset/mediatek/reset-mediatek-sysclk.c b/drivers/reset/mediatek/reset-mediatek-sysclk.c
> new file mode 100644
> index 000000000000..9cf115e66a4d
> --- /dev/null
> +++ b/drivers/reset/mediatek/reset-mediatek-sysclk.c

..snip..

> +
> +static struct mtk_rst_id mtk_sysclk_reset_ids[] = {

..snip..

> +	{
> +		.name = "mt2712-peri-rst",
> +		.driver_data = MTK_RST_ID_MT2712_PERI,
> +	},
> +	{
> +		.name = "mt6795-ifa",

Keep the names consistent please... "mt6795-infra-rst"

> +		.driver_data = MTK_RST_ID_MT6795_INFRA,
> +	},
> +	{
> +		.name = "mt6795-peri",

mt6795-peri-rst

> +		.driver_data = MTK_RST_ID_MT6795_PERI,
> +	},
> +	{
> +		.name = "mt7622-eth-rst",
> +		.driver_data = MTK_RST_ID_MT7622_ETH,
> +	},
> +	{
> +		.name = "mt7622-usb-rst",
> +		.driver_data = MTK_RST_ID_MT7622_SSUSBSYS,
> +	},
> +	{
> +		.name = "mt7622-pcie-rst",
> +		.driver_data = MTK_RST_ID_MT7622_PCIESYS,
> +	},
> +	{
> +		.name = "mt7622-infrasys-rst",
> +		.driver_data = MTK_RST_ID_MT7622_INFRASYS,
> +	},
> +	{
> +		.name = "mt7622-pericfg-rst",
> +		.driver_data = MTK_RST_ID_MT7622_PERICFG,
> +	},
> +	{
> +		.name = "mt7629-ethsys-rst",
> +		.driver_data = MTK_RST_ID_MT7629_ETHSYS,
> +	},
> +	{
> +		.name = "mt7629-usb-rst",
> +		.driver_data = MTK_RST_ID_MT7629_SSUSBSYS,
> +	},
> +	{
> +		.name = "mt7629-pcie-rst",
> +		.driver_data = MTK_RST_ID_MT7629_PCIESYS,
> +	},
> +	{
> +		.name = "clk_mt8135.mt8135-infrasys-rst",

Why do we have this "clk_mt8135." prefix here (and also mt8173), when all of
the others don't have any prefix?

That's not consistent and shall be changed, unless there's a valid reason not to.

> +		.driver_data = MTK_RST_ID_MT8135_INFRASYS,
> +	},
> +	{
> +		.name = "clk_mt8135.mt8135-pericfg-rst",
> +		.driver_data = MTK_RST_ID_MT8135_PERICFG,
> +	},
> +	{
> +		.name = "clk_mt8173.mt8173-infracfg-rst",
> +		.driver_data = MTK_RST_ID_MT8173_INFRACFG,
> +	},
> +	{
> +		.name = "clk_mt8173.mt8173-pericfg-rst",
> +		.driver_data = MTK_RST_ID_MT8173_PERICFG,
> +	},
> +	{
> +		.name = "mt8183-infra-rst",
> +		.driver_data = MTK_RST_ID_MT8183_INFRA,
> +	},
> +	{
> +		.name = "mt8186-infra-ao-rst",
> +		.driver_data = MTK_RST_ID_MT8186_INFRA_AO,
> +	},
> +	{
> +		.name = "mt8192-infra-rst",
> +		.driver_data = MTK_RST_ID_MT8192_INFRA,
> +	},
> +	{
> +		.name = "mt8195-infra-ao-rst",
> +		.driver_data = MTK_RST_ID_MT8195_INFRA_AO,
> +	},
> +	{
> +	},
> +};
> +

..snip..

> +
> +int mtk_rst_register_clk_rst_data(u32 index, struct mtk_clk_rst_data *data)
> +{
> +	if (index >= MTK_RST_ID_MAX)
> +		return -EINVAL;
> +
> +	p_clk_rst_data[index] = data;
> +
> +	pr_info("%s, register mediatek sysclock reset(%d).\n", __func__, index);

Is this really informative?
There's sysfs telling you infos about drivers that has been (or hasn't been yet)
registered... so, please change that to a pr_debug() instead.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_rst_register_clk_rst_data);
> +

Apart from that, looks good.

Regards,
Angelo
