Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5D069923D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBPKw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBPKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:52:25 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19965FE3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:52:20 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id b81so999380vkf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oEQd7jKtfjkDP521IFDJ/bOVGMlJeesvhPBzQBaZufY=;
        b=MBONjx/CQoxZxvsZie0h8VsQp5wtU3jlMYbKzhLc1fkrj0rhk2bZC8SKMzCnzaha+K
         /l1fdMr15qix3H02AABwrkg2SoLQmYxhR5Ncb7Ik6wdrVtE4hD/y4CnwyB9+A46qka8m
         k7dS7nlRdJgIGxFFS1e9ddGBAF9025f2I1Pp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEQd7jKtfjkDP521IFDJ/bOVGMlJeesvhPBzQBaZufY=;
        b=yum00U8UrBMh6gMz2CyGGV3mis2DEDQooNnsYxjnkNSZH6Ut0dKPXeCYBhee9BF4cV
         mdr4y2whlzvWmIDr8ygbITXTaE/Zsd6gZ52YAr2U8BcqBxIlfxkNqIgdnBlSh0gU/vl4
         uvoulG/LbZRhyUB9ZF7BebZfPpTSX941yWa3qRud7md0mxEu2EZFZzwAct/srHsxrjXc
         KJMyVGtALuBa76HkQvkybRyaZfWm4H5o6X+aYO3EPI22zw5EReXqRPCS2Bph66ibItWu
         FtMbNR1NsgTm13ptG6E3PIcnVEGMDBUFDkRUhd2JDXQsE40SUBx1hgTI1mXRCxDdyYce
         F9yw==
X-Gm-Message-State: AO0yUKWtC2e8Qf/m5tIjX2ZnFAlNT/0vc8X3+aqgHepR5Fv4QFWsRHPU
        ETsRFqAoE9mufDGmnMParouKJVnzmOzvBMCBTJIV4w==
X-Google-Smtp-Source: AK7set9AjOKbZS9IzAUz3vPS9iUsRRRwH/SoE/NIBEh4aWMoY4lzsUo+k/EgzBOWmQCpAOZGitLG9bjJfVB6JejJI1E=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr839841vke.2.1676544739823; Thu, 16 Feb
 2023 02:52:19 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-24-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-24-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 18:52:08 +0800
Message-ID: <CAGXv+5EM9ME_M+euEUJcNaEVAaLi57WHGUETvEtzbiyfADcF7g@mail.gmail.com>
Subject: Re: [PATCH v2 23/47] clk: mediatek: mt7622: Move apmixedsys clock
 driver to its own file
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> In preparation for migrating mt7622 clocks to the common simple
> probe mechanism, move apmixedsys clocks to a different file.
> While at it, use the builtin_platform_driver() macro for it.

Implementing error handling deserves a separate patch, or at least a mention.

ChenYu

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile                |   2 +-
>  drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 137 +++++++++++++++++++
>  drivers/clk/mediatek/clk-mt7622.c            |  87 ------------
>  3 files changed, 138 insertions(+), 88 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt7622-apmixedsys.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index 10038a0f25e0..c1bee331eebf 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -46,7 +46,7 @@ obj-$(CONFIG_COMMON_CLK_MT2712_MFGCFG) += clk-mt2712-mfg.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_MMSYS) += clk-mt2712-mm.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_VDECSYS) += clk-mt2712-vdec.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_VENCSYS) += clk-mt2712-venc.o
> -obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622.o
> +obj-$(CONFIG_COMMON_CLK_MT7622) += clk-mt7622.o clk-mt7622-apmixedsys.o
>  obj-$(CONFIG_COMMON_CLK_MT7622_ETHSYS) += clk-mt7622-eth.o
>  obj-$(CONFIG_COMMON_CLK_MT7622_HIFSYS) += clk-mt7622-hif.o
>  obj-$(CONFIG_COMMON_CLK_MT7622_AUDSYS) += clk-mt7622-aud.o
> diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
> new file mode 100644
> index 000000000000..497fada797b9
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Copyright (c) 2023 Collabora, Ltd.
> + *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#include <dt-bindings/clock/mt7622-clk.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-pll.h"
> +
> +#define MT7622_PLL_FMAX                (2500UL * MHZ)
> +#define CON0_MT7622_RST_BAR    BIT(27)
> +
> +#define PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,\
> +                       _pd_reg, _pd_shift, _tuner_reg, _pcw_reg,       \
> +                       _pcw_shift, _div_table, _parent_name) {         \
> +               .id = _id,                                              \
> +               .name = _name,                                          \
> +               .reg = _reg,                                            \
> +               .pwr_reg = _pwr_reg,                                    \
> +               .en_mask = _en_mask,                                    \
> +               .flags = _flags,                                        \
> +               .rst_bar_mask = CON0_MT7622_RST_BAR,                    \
> +               .fmax = MT7622_PLL_FMAX,                                \
> +               .pcwbits = _pcwbits,                                    \
> +               .pd_reg = _pd_reg,                                      \
> +               .pd_shift = _pd_shift,                                  \
> +               .tuner_reg = _tuner_reg,                                \
> +               .pcw_reg = _pcw_reg,                                    \
> +               .pcw_shift = _pcw_shift,                                \
> +               .div_table = _div_table,                                \
> +               .parent_name = _parent_name,                            \
> +       }
> +
> +#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,    \
> +                       _pd_reg, _pd_shift, _tuner_reg, _pcw_reg,       \
> +                       _pcw_shift)                                     \
> +       PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,\
> +                _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,  \
> +                NULL, "clkxtal")
> +
> +static const struct mtk_gate_regs apmixed_cg_regs = {
> +       .set_ofs = 0x8,
> +       .clr_ofs = 0x8,
> +       .sta_ofs = 0x8,
> +};
> +
> +#define GATE_APMIXED_AO(_id, _name, _parent, _shift)                   \
> +       GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs, _shift,   \
> +                &mtk_clk_gate_ops_no_setclr_inv, CLK_IS_CRITICAL)
> +
> +static const struct mtk_pll_data plls[] = {
> +       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0,
> +           PLL_AO, 21, 0x0204, 24, 0, 0x0204, 0),
> +       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0,
> +           HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
> +       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0,
> +           HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
> +       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0,
> +           0, 21, 0x0300, 1, 0, 0x0304, 0),
> +       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0,
> +           0, 21, 0x0314, 1, 0, 0x0318, 0),
> +       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0,
> +           0, 31, 0x0324, 1, 0, 0x0328, 0),
> +       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0,
> +           0, 31, 0x0334, 1, 0, 0x0338, 0),
> +       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0,
> +           0, 21, 0x0344, 1, 0, 0x0348, 0),
> +       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0,
> +           0, 21, 0x0358, 1, 0, 0x035C, 0),
> +};
> +
> +static const struct mtk_gate apmixed_clks[] = {
> +       GATE_APMIXED_AO(CLK_APMIXED_MAIN_CORE_EN, "main_core_en", "mainpll", 5),
> +};
> +
> +static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
> +{
> +       void __iomem *base;
> +       struct clk_hw_onecell_data *clk_data;
> +       struct device_node *node = pdev->dev.of_node;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +
> +       base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       clk_data = mtk_devm_alloc_clk_data(dev, CLK_APMIXED_NR_CLK);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +       if (ret)
> +               return ret;
> +
> +       ret = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
> +                                    ARRAY_SIZE(apmixed_clks), clk_data);
> +       if (ret)
> +               goto unregister_plls;
> +
> +       ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +       if (ret)
> +               goto unregister_gates;
> +
> +       return 0;
> +
> +unregister_gates:
> +       mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
> +unregister_plls:
> +       mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
> +       { .compatible = "mediatek,mt7622-apmixedsys" },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver clk_mt7622_apmixed_drv = {
> +       .probe = clk_mt7622_apmixed_probe,
> +       .driver = {
> +               .name = "clk-mt7622-apmixed",
> +               .of_match_table = of_match_clk_mt7622_apmixed,
> +       },
> +};
> +builtin_platform_driver(clk_mt7622_apmixed_drv)
> +
> +MODULE_DESCRIPTION("MediaTek MT7622 apmixedsys clocks driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
> index 1c0049fbeb69..6cf74c948ac7 100644
> --- a/drivers/clk/mediatek/clk-mt7622.c
> +++ b/drivers/clk/mediatek/clk-mt7622.c
> @@ -14,46 +14,10 @@
>  #include "clk-cpumux.h"
>  #include "clk-gate.h"
>  #include "clk-mtk.h"
> -#include "clk-pll.h"
>
>  #include <dt-bindings/clock/mt7622-clk.h>
>  #include <linux/clk.h> /* for consumer */
>
> -#define MT7622_PLL_FMAX                (2500UL * MHZ)
> -#define CON0_MT7622_RST_BAR    BIT(27)
> -
> -#define PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,\
> -                       _pd_reg, _pd_shift, _tuner_reg, _pcw_reg,       \
> -                       _pcw_shift, _div_table, _parent_name) {         \
> -               .id = _id,                                              \
> -               .name = _name,                                          \
> -               .reg = _reg,                                            \
> -               .pwr_reg = _pwr_reg,                                    \
> -               .en_mask = _en_mask,                                    \
> -               .flags = _flags,                                        \
> -               .rst_bar_mask = CON0_MT7622_RST_BAR,                    \
> -               .fmax = MT7622_PLL_FMAX,                                \
> -               .pcwbits = _pcwbits,                                    \
> -               .pd_reg = _pd_reg,                                      \
> -               .pd_shift = _pd_shift,                                  \
> -               .tuner_reg = _tuner_reg,                                \
> -               .pcw_reg = _pcw_reg,                                    \
> -               .pcw_shift = _pcw_shift,                                \
> -               .div_table = _div_table,                                \
> -               .parent_name = _parent_name,                            \
> -       }
> -
> -#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,    \
> -                       _pd_reg, _pd_shift, _tuner_reg, _pcw_reg,       \
> -                       _pcw_shift)                                     \
> -       PLL_xtal(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,\
> -                _pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift,  \
> -                NULL, "clkxtal")
> -
> -#define GATE_APMIXED_AO(_id, _name, _parent, _shift)                   \
> -       GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs, _shift,   \
> -                &mtk_clk_gate_ops_no_setclr_inv, CLK_IS_CRITICAL)
> -
>  #define GATE_INFRA(_id, _name, _parent, _shift)                                \
>         GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
>
> @@ -261,12 +225,6 @@ static const char * const peribus_ck_parents[] = {
>         "syspll1_d4"
>  };
>
> -static const struct mtk_gate_regs apmixed_cg_regs = {
> -       .set_ofs = 0x8,
> -       .clr_ofs = 0x8,
> -       .sta_ofs = 0x8,
> -};
> -
>  static const struct mtk_gate_regs infra_cg_regs = {
>         .set_ofs = 0x40,
>         .clr_ofs = 0x44,
> @@ -297,31 +255,6 @@ static const struct mtk_gate_regs peri1_cg_regs = {
>         .sta_ofs = 0x1C,
>  };
>
> -static const struct mtk_pll_data plls[] = {
> -       PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0200, 0x020C, 0,
> -           PLL_AO, 21, 0x0204, 24, 0, 0x0204, 0),
> -       PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0210, 0x021C, 0,
> -           HAVE_RST_BAR, 21, 0x0214, 24, 0, 0x0214, 0),
> -       PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0220, 0x022C, 0,
> -           HAVE_RST_BAR, 7, 0x0224, 24, 0, 0x0224, 14),
> -       PLL(CLK_APMIXED_ETH1PLL, "eth1pll", 0x0300, 0x0310, 0,
> -           0, 21, 0x0300, 1, 0, 0x0304, 0),
> -       PLL(CLK_APMIXED_ETH2PLL, "eth2pll", 0x0314, 0x0320, 0,
> -           0, 21, 0x0314, 1, 0, 0x0318, 0),
> -       PLL(CLK_APMIXED_AUD1PLL, "aud1pll", 0x0324, 0x0330, 0,
> -           0, 31, 0x0324, 1, 0, 0x0328, 0),
> -       PLL(CLK_APMIXED_AUD2PLL, "aud2pll", 0x0334, 0x0340, 0,
> -           0, 31, 0x0334, 1, 0, 0x0338, 0),
> -       PLL(CLK_APMIXED_TRGPLL, "trgpll", 0x0344, 0x0354, 0,
> -           0, 21, 0x0344, 1, 0, 0x0348, 0),
> -       PLL(CLK_APMIXED_SGMIPLL, "sgmipll", 0x0358, 0x0368, 0,
> -           0, 21, 0x0358, 1, 0, 0x035C, 0),
> -};
> -
> -static const struct mtk_gate apmixed_clks[] = {
> -       GATE_APMIXED_AO(CLK_APMIXED_MAIN_CORE_EN, "main_core_en", "mainpll", 5),
> -};
> -
>  static const struct mtk_gate infra_clks[] = {
>         GATE_INFRA(CLK_INFRA_DBGCLK_PD, "infra_dbgclk_pd", "axi_sel", 0),
>         GATE_INFRA(CLK_INFRA_TRNG, "trng_ck", "axi_sel", 2),
> @@ -652,23 +585,6 @@ static int mtk_infrasys_init(struct platform_device *pdev)
>         return 0;
>  }
>
> -static int mtk_apmixedsys_init(struct platform_device *pdev)
> -{
> -       struct clk_hw_onecell_data *clk_data;
> -       struct device_node *node = pdev->dev.of_node;
> -
> -       clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> -       if (!clk_data)
> -               return -ENOMEM;
> -
> -       mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls),
> -                             clk_data);
> -
> -       mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
> -                              ARRAY_SIZE(apmixed_clks), clk_data);
> -
> -       return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> -}
>
>  static int mtk_pericfg_init(struct platform_device *pdev)
>  {
> @@ -701,9 +617,6 @@ static int mtk_pericfg_init(struct platform_device *pdev)
>
>  static const struct of_device_id of_match_clk_mt7622[] = {
>         {
> -               .compatible = "mediatek,mt7622-apmixedsys",
> -               .data = mtk_apmixedsys_init,
> -       }, {
>                 .compatible = "mediatek,mt7622-infracfg",
>                 .data = mtk_infrasys_init,
>         }, {
> --
> 2.39.1
>
