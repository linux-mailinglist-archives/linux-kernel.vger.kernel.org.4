Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5C6AD10C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCFWEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCFWEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:04:39 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B6516314;
        Mon,  6 Mar 2023 14:04:37 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pZIwO-0003I0-2Y;
        Mon, 06 Mar 2023 23:04:21 +0100
Date:   Mon, 6 Mar 2023 22:04:17 +0000
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v6 47/54] clk: mediatek: mt8192: Move apmixedsys clock
 driver to its own file
Message-ID: <ZAZjYTv4TLKSunFZ@makrotopia.org>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
 <20230306140543.1813621-48-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306140543.1813621-48-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 03:05:36PM +0100, AngeloGioacchino Del Regno wrote:
> This is the last man standing in clk-mt8192.c that won't allow us to
> use the module_platform_driver() macro, and for *no* good reason.
> Move it to clk-mt8192-apmixedsys.c and while at it, also add a
> .remove() callback for it.
> 
> Also, since the need for "clk-mt8192-simple" and "clk-mt8192" was
> just due to them being in the same file and probing different clocks,
> and since now there's just one platform_driver struct per file, it
> seemed natural to rename the `-simple` variant to just "clk-mt8192".
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Miles Chen <miles.chen@mediatek.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/clk/mediatek/Makefile                |   2 +-
>  drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 214 ++++++++++++++++++
>  drivers/clk/mediatek/clk-mt8192.c            | 221 +------------------
>  3 files changed, 219 insertions(+), 218 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt8192-apmixedsys.c

I've tried to apply this on clk-next (currently v6.3-rc1) and also
linux-next (next-20230306), on both this patch doesn't apply:

Applying: clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
error: patch failed: drivers/clk/mediatek/clk-mt8192.c:12
error: drivers/clk/mediatek/clk-mt8192.c: patch does not apply
Patch failed at 0047 clk: mediatek: mt8192: Move apmixedsys clock driver to its own file
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

> 
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 6186bf4a5ed9..048a150a7637 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -100,7 +100,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186_MMSYS) += clk-mt8186-mm.o
>  obj-$(CONFIG_COMMON_CLK_MT8186_VDECSYS) += clk-mt8186-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT8186_VENCSYS) += clk-mt8186-venc.o
>  obj-$(CONFIG_COMMON_CLK_MT8186_WPESYS) += clk-mt8186-wpe.o
> -obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
> +obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
>  obj-$(CONFIG_COMMON_CLK_MT8192_IMGSYS) += clk-mt8192-img.o
> diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> new file mode 100644
> index 000000000000..1e6988d5289a
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
> @@ -0,0 +1,214 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + *               Chun-Jie Chen <chun-jie.chen@mediatek.com>
> + * Copyright (c) 2023 Collabora Ltd.
> + *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt8192-clk.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include "clk-fhctl.h"
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +#include "clk-pllfh.h"
> +
> +static const struct mtk_gate_regs apmixed_cg_regs = {
> +	.set_ofs = 0x14,
> +	.clr_ofs = 0x14,
> +	.sta_ofs = 0x14,
> +};
> +
> +#define GATE_APMIXED(_id, _name, _parent, _shift)	\
> +	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> +
> +static const struct mtk_gate apmixed_clks[] = {
> +	GATE_APMIXED(CLK_APMIXED_MIPID26M, "mipid26m", "clk26m", 16),
> +};
> +
> +#define MT8192_PLL_FMAX		(3800UL * MHZ)
> +#define MT8192_PLL_FMIN		(1500UL * MHZ)
> +#define MT8192_INTEGER_BITS	8
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
> +			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> +			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> +			_pcw_reg, _pcw_shift, _pcw_chg_reg,		\
> +			_en_reg, _pll_en_bit) {				\
> +		.id = _id,						\
> +		.name = _name,						\
> +		.reg = _reg,						\
> +		.pwr_reg = _pwr_reg,					\
> +		.en_mask = _en_mask,					\
> +		.flags = _flags,					\
> +		.rst_bar_mask = _rst_bar_mask,				\
> +		.fmax = MT8192_PLL_FMAX,				\
> +		.fmin = MT8192_PLL_FMIN,				\
> +		.pcwbits = _pcwbits,					\
> +		.pcwibits = MT8192_INTEGER_BITS,			\
> +		.pd_reg = _pd_reg,					\
> +		.pd_shift = _pd_shift,					\
> +		.tuner_reg = _tuner_reg,				\
> +		.tuner_en_reg = _tuner_en_reg,				\
> +		.tuner_en_bit = _tuner_en_bit,				\
> +		.pcw_reg = _pcw_reg,					\
> +		.pcw_shift = _pcw_shift,				\
> +		.pcw_chg_reg = _pcw_chg_reg,				\
> +		.en_reg = _en_reg,					\
> +		.pll_en_bit = _pll_en_bit,				\
> +	}
> +
> +#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
> +			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> +			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> +			_pcw_reg, _pcw_shift)				\
> +		PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
> +			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> +			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> +			_pcw_reg, _pcw_shift, 0, 0, 0)
> +
> +static const struct mtk_pll_data plls[] = {
> +	PLL_B(CLK_APMIXED_MAINPLL, "mainpll", 0x0340, 0x034c, 0xff000000,
> +	      HAVE_RST_BAR, BIT(23), 22, 0x0344, 24, 0, 0, 0, 0x0344, 0),
> +	PLL_B(CLK_APMIXED_UNIVPLL, "univpll", 0x0308, 0x0314, 0xff000000,
> +	      HAVE_RST_BAR, BIT(23), 22, 0x030c, 24, 0, 0, 0, 0x030c, 0),
> +	PLL(CLK_APMIXED_USBPLL, "usbpll", 0x03c4, 0x03cc, 0x00000000,
> +	    0, 0, 22, 0x03c4, 24, 0, 0, 0, 0x03c4, 0, 0x03c4, 0x03cc, 2),
> +	PLL_B(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0350, 0x035c, 0x00000000,
> +	      0, 0, 22, 0x0354, 24, 0, 0, 0, 0x0354, 0),
> +	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0360, 0x036c, 0xff000000,
> +	      HAVE_RST_BAR, BIT(23), 22, 0x0364, 24, 0, 0, 0, 0x0364, 0),
> +	PLL_B(CLK_APMIXED_ADSPPLL, "adsppll", 0x0370, 0x037c, 0xff000000,
> +	      HAVE_RST_BAR, BIT(23), 22, 0x0374, 24, 0, 0, 0, 0x0374, 0),
> +	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0268, 0x0274, 0x00000000,
> +	      0, 0, 22, 0x026c, 24, 0, 0, 0, 0x026c, 0),
> +	PLL_B(CLK_APMIXED_TVDPLL, "tvdpll", 0x0380, 0x038c, 0x00000000,
> +	      0, 0, 22, 0x0384, 24, 0, 0, 0, 0x0384, 0),
> +	PLL_B(CLK_APMIXED_APLL1, "apll1", 0x0318, 0x0328, 0x00000000,
> +	      0, 0, 32, 0x031c, 24, 0x0040, 0x000c, 0, 0x0320, 0),
> +	PLL_B(CLK_APMIXED_APLL2, "apll2", 0x032c, 0x033c, 0x00000000,
> +	      0, 0, 32, 0x0330, 24, 0, 0, 0, 0x0334, 0),
> +};
> +
> +enum fh_pll_id {
> +	FH_ARMPLL_LL,
> +	FH_ARMPLL_BL0,
> +	FH_ARMPLL_BL1,
> +	FH_ARMPLL_BL2,
> +	FH_ARMPLL_BL3,
> +	FH_CCIPLL,
> +	FH_MFGPLL,
> +	FH_MEMPLL,
> +	FH_MPLL,
> +	FH_MMPLL,
> +	FH_MAINPLL,
> +	FH_MSDCPLL,
> +	FH_ADSPPLL,
> +	FH_APUPLL,
> +	FH_TVDPLL,
> +	FH_NR_FH,
> +};
> +
> +#define FH(_pllid, _fhid, _offset) {					\
> +		.data = {						\
> +			.pll_id = _pllid,				\
> +			.fh_id = _fhid,					\
> +			.fh_ver = FHCTL_PLLFH_V2,			\
> +			.fhx_offset = _offset,				\
> +			.dds_mask = GENMASK(21, 0),			\
> +			.slope0_value = 0x6003c97,			\
> +			.slope1_value = 0x6003c97,			\
> +			.sfstrx_en = BIT(2),				\
> +			.frddsx_en = BIT(1),				\
> +			.fhctlx_en = BIT(0),				\
> +			.tgl_org = BIT(31),				\
> +			.dvfs_tri = BIT(31),				\
> +			.pcwchg = BIT(31),				\
> +			.dt_val = 0x0,					\
> +			.df_val = 0x9,					\
> +			.updnlmt_shft = 16,				\
> +			.msk_frddsx_dys = GENMASK(23, 20),		\
> +			.msk_frddsx_dts = GENMASK(19, 16),		\
> +		},							\
> +	}
> +
> +static struct mtk_pllfh_data pllfhs[] = {
> +	FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
> +	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
> +	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
> +	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
> +	FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x12c),
> +	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0x154),
> +};
> +
> +static const struct of_device_id of_match_clk_mt8192_apmixed[] = {
> +	{ .compatible = "mediatek,mt8192-apmixedsys" },
> +	{ /* sentinel */ }
> +};
> +
> +static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	const u8 *fhctl_node = "mediatek,mt8192-fhctl";
> +	int r;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> +
> +	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> +				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
> +	if (r)
> +		goto free_clk_data;
> +
> +	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
> +				   ARRAY_SIZE(apmixed_clks), clk_data);
> +	if (r)
> +		goto unregister_plls;
> +
> +	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (r)
> +		goto unregister_gates;
> +
> +	return r;
> +
> +unregister_gates:
> +	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +unregister_plls:
> +	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
> +				  ARRAY_SIZE(pllfhs), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +	return r;
> +}
> +
> +static int clk_mt8192_apmixed_remove(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
> +
> +	of_clk_del_provider(node);
> +	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
> +				  ARRAY_SIZE(pllfhs), clk_data);
> +	mtk_free_clk_data(clk_data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver clk_mt8192_apmixed_drv = {
> +	.driver = {
> +		.name = "clk-mt8192-apmixed",
> +		.of_match_table = of_match_clk_mt8192_apmixed,
> +	},
> +	.probe = clk_mt8192_apmixed_probe,
> +	.remove = clk_mt8192_apmixed_remove,
> +};
> +module_platform_driver(clk_mt8192_apmixed_drv);
> +MODULE_DESCRIPTION("MediaTek MT8192 apmixed clocks driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
> index 35afe496b1c1..45eccda51471 100644
> --- a/drivers/clk/mediatek/clk-mt8192.c
> +++ b/drivers/clk/mediatek/clk-mt8192.c
> @@ -12,12 +12,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -#include "clk-fhctl.h"
>  #include "clk-gate.h"
>  #include "clk-mtk.h"
>  #include "clk-mux.h"
> -#include "clk-pll.h"
> -#include "clk-pllfh.h"
>  
>  #include <dt-bindings/clock/mt8192-clk.h>
>  #include <dt-bindings/reset/mt8192-resets.h>
> @@ -714,19 +711,6 @@ static struct mtk_composite top_muxes[] = {
>  	DIV_GATE(CLK_TOP_APLL12_DIV9, "apll12_div9", "apll_i2s9_m_sel", 0x320, 10, 0x338, 8, 16),
>  };
>  
> -static const struct mtk_gate_regs apmixed_cg_regs = {
> -	.set_ofs = 0x14,
> -	.clr_ofs = 0x14,
> -	.sta_ofs = 0x14,
> -};
> -
> -#define GATE_APMIXED(_id, _name, _parent, _shift)	\
> -	GATE_MTK(_id, _name, _parent, &apmixed_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
> -
> -static const struct mtk_gate apmixed_clks[] = {
> -	GATE_APMIXED(CLK_APMIXED_MIPID26M, "mipid26m", "clk26m", 16),
> -};
> -
>  static const struct mtk_gate_regs infra0_cg_regs = {
>  	.set_ofs = 0x80,
>  	.clr_ofs = 0x84,
> @@ -980,121 +964,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
>  	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
>  };
>  
> -#define MT8192_PLL_FMAX		(3800UL * MHZ)
> -#define MT8192_PLL_FMIN		(1500UL * MHZ)
> -#define MT8192_INTEGER_BITS	8
> -
> -#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
> -			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> -			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> -			_pcw_reg, _pcw_shift, _pcw_chg_reg,		\
> -			_en_reg, _pll_en_bit) {				\
> -		.id = _id,						\
> -		.name = _name,						\
> -		.reg = _reg,						\
> -		.pwr_reg = _pwr_reg,					\
> -		.en_mask = _en_mask,					\
> -		.flags = _flags,					\
> -		.rst_bar_mask = _rst_bar_mask,				\
> -		.fmax = MT8192_PLL_FMAX,				\
> -		.fmin = MT8192_PLL_FMIN,				\
> -		.pcwbits = _pcwbits,					\
> -		.pcwibits = MT8192_INTEGER_BITS,			\
> -		.pd_reg = _pd_reg,					\
> -		.pd_shift = _pd_shift,					\
> -		.tuner_reg = _tuner_reg,				\
> -		.tuner_en_reg = _tuner_en_reg,				\
> -		.tuner_en_bit = _tuner_en_bit,				\
> -		.pcw_reg = _pcw_reg,					\
> -		.pcw_shift = _pcw_shift,				\
> -		.pcw_chg_reg = _pcw_chg_reg,				\
> -		.en_reg = _en_reg,					\
> -		.pll_en_bit = _pll_en_bit,				\
> -	}
> -
> -#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
> -			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> -			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> -			_pcw_reg, _pcw_shift)				\
> -		PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
> -			_rst_bar_mask, _pcwbits, _pd_reg, _pd_shift,	\
> -			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
> -			_pcw_reg, _pcw_shift, 0, 0, 0)
> -
> -static const struct mtk_pll_data plls[] = {
> -	PLL_B(CLK_APMIXED_MAINPLL, "mainpll", 0x0340, 0x034c, 0xff000000,
> -	      HAVE_RST_BAR, BIT(23), 22, 0x0344, 24, 0, 0, 0, 0x0344, 0),
> -	PLL_B(CLK_APMIXED_UNIVPLL, "univpll", 0x0308, 0x0314, 0xff000000,
> -	      HAVE_RST_BAR, BIT(23), 22, 0x030c, 24, 0, 0, 0, 0x030c, 0),
> -	PLL(CLK_APMIXED_USBPLL, "usbpll", 0x03c4, 0x03cc, 0x00000000,
> -	    0, 0, 22, 0x03c4, 24, 0, 0, 0, 0x03c4, 0, 0x03c4, 0x03cc, 2),
> -	PLL_B(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0350, 0x035c, 0x00000000,
> -	      0, 0, 22, 0x0354, 24, 0, 0, 0, 0x0354, 0),
> -	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0360, 0x036c, 0xff000000,
> -	      HAVE_RST_BAR, BIT(23), 22, 0x0364, 24, 0, 0, 0, 0x0364, 0),
> -	PLL_B(CLK_APMIXED_ADSPPLL, "adsppll", 0x0370, 0x037c, 0xff000000,
> -	      HAVE_RST_BAR, BIT(23), 22, 0x0374, 24, 0, 0, 0, 0x0374, 0),
> -	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0268, 0x0274, 0x00000000,
> -	      0, 0, 22, 0x026c, 24, 0, 0, 0, 0x026c, 0),
> -	PLL_B(CLK_APMIXED_TVDPLL, "tvdpll", 0x0380, 0x038c, 0x00000000,
> -	      0, 0, 22, 0x0384, 24, 0, 0, 0, 0x0384, 0),
> -	PLL_B(CLK_APMIXED_APLL1, "apll1", 0x0318, 0x0328, 0x00000000,
> -	      0, 0, 32, 0x031c, 24, 0x0040, 0x000c, 0, 0x0320, 0),
> -	PLL_B(CLK_APMIXED_APLL2, "apll2", 0x032c, 0x033c, 0x00000000,
> -	      0, 0, 32, 0x0330, 24, 0, 0, 0, 0x0334, 0),
> -};
> -
> -enum fh_pll_id {
> -	FH_ARMPLL_LL,
> -	FH_ARMPLL_BL0,
> -	FH_ARMPLL_BL1,
> -	FH_ARMPLL_BL2,
> -	FH_ARMPLL_BL3,
> -	FH_CCIPLL,
> -	FH_MFGPLL,
> -	FH_MEMPLL,
> -	FH_MPLL,
> -	FH_MMPLL,
> -	FH_MAINPLL,
> -	FH_MSDCPLL,
> -	FH_ADSPPLL,
> -	FH_APUPLL,
> -	FH_TVDPLL,
> -	FH_NR_FH,
> -};
> -
> -#define FH(_pllid, _fhid, _offset) {					\
> -		.data = {						\
> -			.pll_id = _pllid,				\
> -			.fh_id = _fhid,					\
> -			.fh_ver = FHCTL_PLLFH_V2,			\
> -			.fhx_offset = _offset,				\
> -			.dds_mask = GENMASK(21, 0),			\
> -			.slope0_value = 0x6003c97,			\
> -			.slope1_value = 0x6003c97,			\
> -			.sfstrx_en = BIT(2),				\
> -			.frddsx_en = BIT(1),				\
> -			.fhctlx_en = BIT(0),				\
> -			.tgl_org = BIT(31),				\
> -			.dvfs_tri = BIT(31),				\
> -			.pcwchg = BIT(31),				\
> -			.dt_val = 0x0,					\
> -			.df_val = 0x9,					\
> -			.updnlmt_shft = 16,				\
> -			.msk_frddsx_dys = GENMASK(23, 20),		\
> -			.msk_frddsx_dts = GENMASK(19, 16),		\
> -		},							\
> -	}
> -
> -static struct mtk_pllfh_data pllfhs[] = {
> -	FH(CLK_APMIXED_MFGPLL, FH_MFGPLL, 0xb4),
> -	FH(CLK_APMIXED_MMPLL, FH_MMPLL, 0xf0),
> -	FH(CLK_APMIXED_MAINPLL, FH_MAINPLL, 0x104),
> -	FH(CLK_APMIXED_MSDCPLL, FH_MSDCPLL, 0x118),
> -	FH(CLK_APMIXED_ADSPPLL, FH_ADSPPLL, 0x12c),
> -	FH(CLK_APMIXED_TVDPLL, FH_TVDPLL, 0x154),
> -};
> -
>  /* Register mux notifier for MFG mux */
>  static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
>  {
> @@ -1117,70 +986,6 @@ static int clk_mt8192_reg_mfg_mux_notifier(struct device *dev, struct clk *clk)
>  	return devm_mtk_clk_mux_notifier_register(dev, clk, mfg_mux_nb);
>  }
>  
> -static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
> -{
> -	struct clk_hw_onecell_data *clk_data;
> -	struct device_node *node = pdev->dev.of_node;
> -	const u8 *fhctl_node = "mediatek,mt8192-fhctl";
> -	int r;
> -
> -	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> -	if (!clk_data)
> -		return -ENOMEM;
> -
> -	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
> -
> -	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
> -				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
> -	if (r)
> -		goto free_clk_data;
> -
> -	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
> -				   ARRAY_SIZE(apmixed_clks), clk_data);
> -	if (r)
> -		goto unregister_plls;
> -
> -	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -	if (r)
> -		goto unregister_gates;
> -
> -	return r;
> -
> -unregister_gates:
> -	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> -unregister_plls:
> -	mtk_clk_unregister_pllfhs(plls, ARRAY_SIZE(plls), pllfhs,
> -				  ARRAY_SIZE(pllfhs), clk_data);
> -free_clk_data:
> -	mtk_free_clk_data(clk_data);
> -	return r;
> -}
> -
> -static const struct of_device_id of_match_clk_mt8192[] = {
> -	{
> -		.compatible = "mediatek,mt8192-apmixedsys",
> -		.data = clk_mt8192_apmixed_probe,
> -	}, {
> -		/* sentinel */
> -	}
> -};
> -
> -static int clk_mt8192_probe(struct platform_device *pdev)
> -{
> -	int (*clk_probe)(struct platform_device *pdev);
> -	int r;
> -
> -	clk_probe = of_device_get_match_data(&pdev->dev);
> -	if (!clk_probe)
> -		return -EINVAL;
> -
> -	r = clk_probe(pdev);
> -	if (r)
> -		dev_err(&pdev->dev, "could not register clock provider: %s: %d\n", pdev->name, r);
> -
> -	return r;
> -}
> -
>  static const struct mtk_clk_desc infra_desc = {
>  	.clks = infra_clks,
>  	.num_clks = ARRAY_SIZE(infra_clks),
> @@ -1208,38 +1013,20 @@ static const struct mtk_clk_desc topck_desc = {
>  	.mfg_clk_idx = CLK_TOP_MFG_PLL_SEL,
>  };
>  
> -static const struct of_device_id of_match_clk_mt8192_simple[] = {
> +static const struct of_device_id of_match_clk_mt8192[] = {
>  	{ .compatible = "mediatek,mt8192-infracfg", .data = &infra_desc },
>  	{ .compatible = "mediatek,mt8192-pericfg", .data = &peri_desc },
>  	{ .compatible = "mediatek,mt8192-topckgen", .data = &topck_desc },
>  	{ /* sentinel */ }
>  };
>  
> -static struct platform_driver clk_mt8192_simple_drv = {
> -	.probe = mtk_clk_simple_probe,
> -	.remove = mtk_clk_simple_remove,
> -	.driver = {
> -		.name = "clk-mt8192-simple",
> -		.of_match_table = of_match_clk_mt8192_simple,
> -	},
> -};
> -
>  static struct platform_driver clk_mt8192_drv = {
> -	.probe = clk_mt8192_probe,
>  	.driver = {
>  		.name = "clk-mt8192",
>  		.of_match_table = of_match_clk_mt8192,
>  	},
> +	.probe = mtk_clk_simple_probe,
> +	.remove = mtk_clk_simple_remove,
>  };
> -
> -static int __init clk_mt8192_init(void)
> -{
> -	int ret = platform_driver_register(&clk_mt8192_drv);
> -
> -	if (ret)
> -		return ret;
> -	return platform_driver_register(&clk_mt8192_simple_drv);
> -}
> -
> -arch_initcall(clk_mt8192_init);
> +module_platform_driver(clk_mt8192_drv);
>  MODULE_LICENSE("GPL");
> -- 
> 2.39.2
> 
> 
