Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A7B69FAB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjBVSDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjBVSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:03:07 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA85FF11;
        Wed, 22 Feb 2023 10:03:04 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pUtRz-0008DW-1e;
        Wed, 22 Feb 2023 19:02:43 +0100
Date:   Wed, 22 Feb 2023 18:02:40 +0000
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
Subject: Re: [PATCH v5 34/54] clk: mediatek: mt7986-eth: Migrate to common
 probe mechanism
Message-ID: <Y/ZYwOoHhO0328qY@makrotopia.org>
References: <20230222092543.19187-1-angelogioacchino.delregno@collabora.com>
 <20230222092543.19187-35-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222092543.19187-35-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 10:25:23AM +0100, AngeloGioacchino Del Regno wrote:
> Convert this driver to use the common mtk_clk_simple_probe() mechanism.
> While at it, also remove __initconst annotations (as these structures
> are used also at runtime).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Tested-by: Daniel Golle <daniel@makrotopia.org>
(on BananaPi BPi-R3)

> ---
>  drivers/clk/mediatek/clk-mt7986-eth.c | 83 +++++++++++----------------
>  1 file changed, 32 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
> index e04bc6845ea6..138ba0a47221 100644
> --- a/drivers/clk/mediatek/clk-mt7986-eth.c
> +++ b/drivers/clk/mediatek/clk-mt7986-eth.c
> @@ -25,7 +25,7 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
>  #define GATE_SGMII0(_id, _name, _parent, _shift)		\
>  	GATE_MTK(_id, _name, _parent, &sgmii0_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
>  
> -static const struct mtk_gate sgmii0_clks[] __initconst = {
> +static const struct mtk_gate sgmii0_clks[] = {
>  	GATE_SGMII0(CLK_SGMII0_TX250M_EN, "sgmii0_tx250m_en", "top_xtal", 2),
>  	GATE_SGMII0(CLK_SGMII0_RX250M_EN, "sgmii0_rx250m_en", "top_xtal", 3),
>  	GATE_SGMII0(CLK_SGMII0_CDR_REF, "sgmii0_cdr_ref", "top_xtal", 4),
> @@ -41,7 +41,7 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
>  #define GATE_SGMII1(_id, _name, _parent, _shift)		\
>  	GATE_MTK(_id, _name, _parent, &sgmii1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
>  
> -static const struct mtk_gate sgmii1_clks[] __initconst = {
> +static const struct mtk_gate sgmii1_clks[] = {
>  	GATE_SGMII1(CLK_SGMII1_TX250M_EN, "sgmii1_tx250m_en", "top_xtal", 2),
>  	GATE_SGMII1(CLK_SGMII1_RX250M_EN, "sgmii1_rx250m_en", "top_xtal", 3),
>  	GATE_SGMII1(CLK_SGMII1_CDR_REF, "sgmii1_cdr_ref", "top_xtal", 4),
> @@ -57,7 +57,7 @@ static const struct mtk_gate_regs eth_cg_regs = {
>  #define GATE_ETH(_id, _name, _parent, _shift)			\
>  	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
>  
> -static const struct mtk_gate eth_clks[] __initconst = {
> +static const struct mtk_gate eth_clks[] = {
>  	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x_sel", 6),
>  	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m_sel", 7),
>  	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m_sel", 8),
> @@ -65,56 +65,37 @@ static const struct mtk_gate eth_clks[] __initconst = {
>  	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", "netsys_mcu_sel", 15),
>  };
>  
> -static void __init mtk_sgmiisys_0_init(struct device_node *node)
> -{
> -	struct clk_hw_onecell_data *clk_data;
> -	int r;
> -
> -	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
> -
> -	mtk_clk_register_gates(NULL, node, sgmii0_clks,
> -			       ARRAY_SIZE(sgmii0_clks), clk_data);
> -
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -	if (r)
> -		pr_err("%s(): could not register clock provider: %d\n",
> -		       __func__, r);
> -}
> -CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7986-sgmiisys_0",
> -	       mtk_sgmiisys_0_init);
> -
> -static void __init mtk_sgmiisys_1_init(struct device_node *node)
> -{
> -	struct clk_hw_onecell_data *clk_data;
> -	int r;
> -
> -	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
> -
> -	mtk_clk_register_gates(NULL, node, sgmii1_clks,
> -			       ARRAY_SIZE(sgmii1_clks), clk_data);
> -
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -
> -	if (r)
> -		pr_err("%s(): could not register clock provider: %d\n",
> -		       __func__, r);
> -}
> -CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7986-sgmiisys_1",
> -	       mtk_sgmiisys_1_init);
> +static const struct mtk_clk_desc eth_desc = {
> +	.clks = eth_clks,
> +	.num_clks = ARRAY_SIZE(eth_clks),
> +};
>  
> -static void __init mtk_ethsys_init(struct device_node *node)
> -{
> -	struct clk_hw_onecell_data *clk_data;
> -	int r;
> +static const struct mtk_clk_desc sgmii0_desc = {
> +	.clks = sgmii0_clks,
> +	.num_clks = ARRAY_SIZE(sgmii0_clks),
> +};
>  
> -	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
> +static const struct mtk_clk_desc sgmii1_desc = {
> +	.clks = sgmii1_clks,
> +	.num_clks = ARRAY_SIZE(sgmii1_clks),
> +};
>  
> -	mtk_clk_register_gates(NULL, node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
> +static const struct of_device_id of_match_clk_mt7986_eth[] = {
> +	{ .compatible = "mediatek,mt7986-ethsys", .data = &eth_desc },
> +	{ .compatible = "mediatek,mt7986-sgmiisys_0", .data = &sgmii0_desc },
> +	{ .compatible = "mediatek,mt7986-sgmiisys_1", .data = &sgmii1_desc },
> +	{ /* sentinel */ }
> +};
>  
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +static struct platform_driver clk_mt7986_eth_drv = {
> +	.driver = {
> +		.name = "clk-mt7986-eth",
> +		.of_match_table = of_match_clk_mt7986_eth,
> +	},
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
> +};
> +module_platform_driver(clk_mt7986_eth_drv);
>  
> -	if (r)
> -		pr_err("%s(): could not register clock provider: %d\n",
> -		       __func__, r);
> -}
> -CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt7986-ethsys", mtk_ethsys_init);
> +MODULE_DESCRIPTION("MediaTek MT7986 Ethernet clocks driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 
> 
