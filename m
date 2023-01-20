Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9994674FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjATIrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjATIrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:47:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B22D79E81;
        Fri, 20 Jan 2023 00:47:13 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B43A3660087F;
        Fri, 20 Jan 2023 08:47:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674204431;
        bh=/SK8ISCMrpGsFtSoxiSJpeLREJYNFoufne4NUgMTmHA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XUcohdPfeK625umviXPYsywtgCILi5Tt5xJieyZ6tdGB6ZXt3bF6Pk2VcBGA/DETo
         FEsJ+3LHqwVGuedCFX36QPm9lVV7jiGLFBD9557V88Muuvf0dVRFQjetywKnXcqqZV
         e0IC8j2+tO8F3BKYa8ucF1YrErnYjS9/k3hNUMJzLnx8/WEqcYtPbJwIzRg4T4lJQl
         dshsxKsDhjDKW6SPO2OOpc1CWaL+ielLTnwnbOZhY8rKFe6H0Ih6tudSAZMxe3BzN4
         mfB/LvcYTd2gSkJINvw0l5s1EKRorHyUmM4XeGap19/ECrsew/glo5cX9g9q9Z+Ax9
         ZIxuygQTbxR0g==
Message-ID: <0e8452bd-3c7f-57bf-2cef-b9b2411742c5@collabora.com>
Date:   Fri, 20 Jan 2023 09:47:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 3/3] clk: mediatek: add MT7981 clock support
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-armkernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674152610.git.daniel@makrotopia.org>
 <1f5749622816b9da315ac092cfa2be515b1d3505.1674152610.git.daniel@makrotopia.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1f5749622816b9da315ac092cfa2be515b1d3505.1674152610.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/01/23 02:27, Daniel Golle ha scritto:
> Add MT7986 clock support, include topckgen, apmixedsys, infracfg and
> ethernet subsystem clocks.
> 
> The drivers are based on clk-mt7981.c which can be found in MediaTek's
> SDK sources. To be fit for upstream inclusion the driver has been split
> into clock domains and the infracfg part has been significantly
> de-bloated by removing all the 1:1 factors (aliases).
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/clk/mediatek/Kconfig               |  17 +
>   drivers/clk/mediatek/Makefile              |   4 +
>   drivers/clk/mediatek/clk-mt7981-apmixed.c  | 103 +++++
>   drivers/clk/mediatek/clk-mt7981-eth.c      | 138 +++++++
>   drivers/clk/mediatek/clk-mt7981-infracfg.c | 236 ++++++++++++
>   drivers/clk/mediatek/clk-mt7981-topckgen.c | 423 +++++++++++++++++++++
>   6 files changed, 921 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-apmixed.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-eth.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt7981-topckgen.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index a40135f563777..c8f045a7f4aa8 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -388,6 +388,23 @@ config COMMON_CLK_MT7629_HIFSYS
>   	  This driver supports MediaTek MT7629 HIFSYS clocks providing
>   	  to PCI-E and USB.
>   
> +config COMMON_CLK_MT7981
> +	bool "Clock driver for MediaTek MT7981"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK
> +	help
> +	  This driver supports MediaTek MT7981 basic clocks and clocks
> +	  required for various peripherals found on this SoC.
> +
> +config COMMON_CLK_MT7981_ETHSYS
> +	bool "Clock driver for MediaTek MT7981 ETHSYS"

If you convert this to platform driver, you can change this bool to tristate
and compile ETHSYS as a module, as this is not a boot-critical clock driver.
Usually, you want to boot from eMMC/SD... but in case you really want to boot
from ethernet (nfs?) you can always either compile this as builtin or keep it
a module and provide a ramdisk(/initrd) that has this module inside.

Please, do so.


> diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
> new file mode 100644
> index 0000000000000..df41d2aa8706e
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
> @@ -0,0 +1,103 @@

..snip..

> +
> +static int clk_mt7981_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +
> +	clk_prepare_enable(clk_data->hws[CLK_APMIXED_ARMPLL]->clk);

No, this is not the right way of managing a clock that has to be always on.
The CLK_IS_CRITICAL flag is what you're looking for.

> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r) {
> +		pr_err("%s(): could not register clock provider: %d\n",
> +		       __func__, r);
> +		goto free_apmixed_data;
> +	}
> +	return r;
> +
> +free_apmixed_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static struct platform_driver clk_mt7981_apmixed_drv = {
> +	.probe = clk_mt7981_apmixed_probe,
> +	.driver = {
> +		.name = "clk-mt7981-apmixed",
> +		.of_match_table = of_match_clk_mt7981_apmixed,
> +	},
> +};
> +builtin_platform_driver(clk_mt7981_apmixed_drv);
> diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
> new file mode 100644
> index 0000000000000..ade7645c921ec
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7981-eth.c
> @@ -0,0 +1,138 @@

..snip..

> +
> +static void __init mtk_sgmiisys_0_init(struct device_node *node)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
> +
> +	mtk_clk_register_gates(NULL, node, sgmii0_clks, ARRAY_SIZE(sgmii0_clks),
> +			       clk_data);
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r)
> +		pr_err("%s(): could not register clock provider: %d\n",
> +		       __func__, r);
> +}
> +CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7981-sgmiisys_0",
> +	       mtk_sgmiisys_0_init);

Do you really need to use CLK_OF_DECLARE?

Is there any reason why SGMIISYS 0/1 and ETHSYS are not platform drivers?

Please, convert to platform drivers.

> diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
> new file mode 100644
> index 0000000000000..0cb301895c7bf
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
> @@ -0,0 +1,236 @@

..snip..


You can remove this probe function entirely:

static const struct mtk_clk_desc topck_desc = {
	.factor_clks = infra_divs,
	.num_factor_clks = ARRAY_SIZE(infra_divs),
	.mux_clks = infra_muxes,
	.num_mux_clks = ARRAY_SIZE(infra_muxes),
	.clks = infra_clks,
	.num_clks = ARRAY_SIZE(infra_clks),
	.clk_lock = &mt7981_clk_lock,
};

> +static int clk_mt7981_infracfg_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int r;
> +	void __iomem *base;
> +	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
> +		 ARRAY_SIZE(infra_clks);
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s(): ioremap failed\n", __func__);
> +		return -ENOMEM;
> +	}
> +
> +	clk_data = mtk_alloc_clk_data(nr);
> +
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
> +	mtk_clk_register_muxes(&pdev->dev, infra_muxes, ARRAY_SIZE(infra_muxes), node,
> +			       &mt7981_clk_lock, clk_data);
> +	mtk_clk_register_gates(&pdev->dev, node, infra_clks, ARRAY_SIZE(infra_clks),
> +			       clk_data);
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r) {
> +		pr_err("%s(): could not register clock provider: %d\n",
> +		       __func__, r);
> +		goto free_infracfg_data;
> +	}
> +	return r;
> +
> +free_infracfg_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +
> +}
> +
> +static const struct of_device_id of_match_clk_mt7981_infracfg[] = {
> +	{ .compatible = "mediatek,mt7981-infracfg", },
> +	{}

Please always end of_device_id arrays with

	{ /* sentinel */ }

> +};
> +
> +static struct platform_driver clk_mt7981_infracfg_drv = {
> +	.probe = clk_mt7981_infracfg_probe,
> +	.driver = {
> +		.name = "clk-mt7981-infracfg",
> +		.of_match_table = of_match_clk_mt7981_infracfg,
> +	},
> +};
> +builtin_platform_driver(clk_mt7981_infracfg_drv);
> diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> new file mode 100644
> index 0000000000000..e711c39993dd3
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
> @@ -0,0 +1,423 @@

..snip..

> +static const struct of_device_id of_match_clk_mt7981_topckgen[] = {
> +	{ .compatible = "mediatek,mt7981-topckgen", .data = &topck_desc },
> +	{}

	{ /* sentinel */ }

> +};
> +
> +static struct platform_driver clk_mt7981_topckgen_drv = {
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +

Please remove this unnecessary blank line.

> +	.driver = {
> +		.name = "clk-mt7981-topckgen",
> +		.of_match_table = of_match_clk_mt7981_topckgen,
> +	},
> +};
> +builtin_platform_driver(clk_mt7981_topckgen_drv);



