Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52EF69FAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjBVSDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjBVSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:03:07 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B131024A;
        Wed, 22 Feb 2023 10:03:04 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtSC-0008Di-2T;
        Wed, 22 Feb 2023 19:02:56 +0100
Date:   Wed, 22 Feb 2023 18:02:53 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        wenst@chromium.org, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 33/54] clk: mediatek: mt7986-infracfg: Migrate to
 common probe mechanism
Message-ID: <Y/ZYzWr4DeWn3HFo@makrotopia.org>
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
 <20230222092543.19187-34-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222092543.19187-34-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:25:22AM +0100, AngeloGioacchino Del Regno wrote:
> Convert this driver to use the common mtk_clk_simple_probe() mechanism.
> While at it, also use module_platform_driver() instead, as this driver
> just gained a .remove() callback during the conversion.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: Daniel Golle <daniel@makrotopia.org>
(on BananaPi BPi-R3)

> ---
>  drivers/clk/mediatek/clk-mt7986-infracfg.c | 61 ++++++----------------
>  1 file changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7986-infracfg.c b/drivers/clk/mediatek/clk-mt7986-infracfg.c
> index 0a4bf87ee160..0299faad0733 100644
> --- a/drivers/clk/mediatek/clk-mt7986-infracfg.c
> +++ b/drivers/clk/mediatek/clk-mt7986-infracfg.c
> @@ -157,57 +157,30 @@ static const struct mtk_gate infra_clks[] = {
>  	GATE_INFRA2(CLK_INFRA_IPCIEB_CK, "infra_ipcieb", "sysaxi_sel", 15),
>  };
>  
> -static int clk_mt7986_infracfg_probe(struct platform_device *pdev)
> -{
> -	struct clk_hw_onecell_data *clk_data;
> -	struct device_node *node = pdev->dev.of_node;
> -	int r;
> -	void __iomem *base;
> -	int nr = ARRAY_SIZE(infra_divs) + ARRAY_SIZE(infra_muxes) +
> -		 ARRAY_SIZE(infra_clks);
> -
> -	base = of_iomap(node, 0);
> -	if (!base) {
> -		pr_err("%s(): ioremap failed\n", __func__);
> -		return -ENOMEM;
> -	}
> -
> -	clk_data = mtk_alloc_clk_data(nr);
> -
> -	if (!clk_data)
> -		return -ENOMEM;
> -
> -	mtk_clk_register_factors(infra_divs, ARRAY_SIZE(infra_divs), clk_data);
> -	mtk_clk_register_muxes(&pdev->dev, infra_muxes,
> -			       ARRAY_SIZE(infra_muxes), node,
> -			       &mt7986_clk_lock, clk_data);
> -	mtk_clk_register_gates(&pdev->dev, node, infra_clks,
> -			       ARRAY_SIZE(infra_clks), clk_data);
> -
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -	if (r) {
> -		pr_err("%s(): could not register clock provider: %d\n",
> -		       __func__, r);
> -		goto free_infracfg_data;
> -	}
> -	return r;
> -
> -free_infracfg_data:
> -	mtk_free_clk_data(clk_data);
> -	return r;
> -
> -}
> +static const struct mtk_clk_desc infra_desc = {
> +	.clks = infra_clks,
> +	.num_clks = ARRAY_SIZE(infra_clks),
> +	.factor_clks = infra_divs,
> +	.num_factor_clks = ARRAY_SIZE(infra_divs),
> +	.mux_clks = infra_muxes,
> +	.num_mux_clks = ARRAY_SIZE(infra_muxes),
> +	.clk_lock = &mt7986_clk_lock,
> +};
>  
>  static const struct of_device_id of_match_clk_mt7986_infracfg[] = {
> -	{ .compatible = "mediatek,mt7986-infracfg", },
> -	{}
> +	{ .compatible = "mediatek,mt7986-infracfg", .data = &infra_desc },
> +	{ /* sentinel */ }
>  };
>  
>  static struct platform_driver clk_mt7986_infracfg_drv = {
> -	.probe = clk_mt7986_infracfg_probe,
>  	.driver = {
>  		.name = "clk-mt7986-infracfg",
>  		.of_match_table = of_match_clk_mt7986_infracfg,
>  	},
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  };
> -builtin_platform_driver(clk_mt7986_infracfg_drv);
> +module_platform_driver(clk_mt7986_infracfg_drv);
> +
> +MODULE_DESCRIPTION("MediaTek MT7986 infracfg clocks driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 
> 
