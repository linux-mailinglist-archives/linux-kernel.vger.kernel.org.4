Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E526C3EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjCUXmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUXmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:42:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD815577;
        Tue, 21 Mar 2023 16:42:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3926261ECD;
        Tue, 21 Mar 2023 23:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78981C433EF;
        Tue, 21 Mar 2023 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442127;
        bh=WIRUnQQm2gOJG15SxkNTYY7sFnyLdPMcKtw100IXt0Y=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fEQMFkvMsIVcHUCnpC5nzaWCCsG6W3uBO45s2pRHfTEdSVX65dyZEkFmRskj5dH9R
         p7Sbhk+Q3mwZPFdA5+kiV1gX02dC6d5YQaB+wCD59qXv8XSirYWxPywq2HEhAHhgPZ
         nxki0T3AcRYC2fSr0QpNsy+24AT27N8Ji4BvkMtfDRbA2SRXcZ2c1lEDn6ybizsQHl
         I17MkHFdXqOd8BATlDmEZisR8A7Wv1A5Wncp0F8AOtyTe/c5QpHkFAodaeEIL4HT6V
         QyyQljYNhM2LBuRZfQ3gIeQ5SIlXlKoiYyUeG6r1QYaW2WAkcaBDw6o6tJY2sgRegr
         wls1EIsIy1n5A==
Message-ID: <26c4712672de6c4f70f88c6846bc892f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230321130710.20236-2-zhuyinbo@loongson.cn>
References: <20230321130710.20236-1-zhuyinbo@loongson.cn> <20230321130710.20236-2-zhuyinbo@loongson.cn>
Subject: Re: [PATCH v15 2/2] clk: clk-loongson2: add clock controller driver support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 21 Mar 2023 16:42:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yinbo Zhu (2023-03-21 06:07:10)
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> new file mode 100644
> index 000000000000..090810655511
> --- /dev/null
> +++ b/drivers/clk/clk-loongson2.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Yinbo Zhu <zhuyinbo@loongson.cn>
> + * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <dt-bindings/clock/loongson,ls2k-clk.h>
> +
> +#define LOONGSON2_PLL_MULT_SHIFT               32
> +#define LOONGSON2_PLL_MULT_WIDTH               10
> +#define LOONGSON2_PLL_DIV_SHIFT                        26
> +#define LOONGSON2_PLL_DIV_WIDTH                        6
> +#define LOONGSON2_APB_FREQSCALE_SHIFT          20
> +#define LOONGSON2_APB_FREQSCALE_WIDTH          3
> +#define LOONGSON2_USB_FREQSCALE_SHIFT          16
> +#define LOONGSON2_USB_FREQSCALE_WIDTH          3
> +#define LOONGSON2_SATA_FREQSCALE_SHIFT         12
> +#define LOONGSON2_SATA_FREQSCALE_WIDTH         3
> +#define LOONGSON2_BOOT_FREQSCALE_SHIFT         8
> +#define LOONGSON2_BOOT_FREQSCALE_WIDTH         3
> +
> +static void __iomem *loongson2_pll_base;

Why is this a global?

> +
> +static const struct clk_parent_data pdata[] =3D {
> +       { .fw_name =3D "ref_100m",},
> +};
> +
> +static struct clk_hw *loongson2_clk_register(struct device *dev,
> +                                         const char *name,
> +                                         const char *parent_name,
> +                                         const struct clk_ops *ops,
> +                                         unsigned long flags)
> +{
> +       int ret;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +
> +       /* allocate the divider */

Remove useless comment.

> +       hw =3D devm_kzalloc(dev, sizeof(*hw), GFP_KERNEL);
> +       if (!hw)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D ops;
> +       init.flags =3D flags;
> +       init.num_parents =3D 1;
> +
> +       if (!parent_name)
> +               init.parent_data =3D pdata;
> +       else
> +               init.parent_names =3D &parent_name;
> +
> +       hw->init =3D &init;
> +
> +       /* register the clock */

Remove useless comment.

> +       ret =3D devm_clk_hw_register(dev, hw);
> +       if (ret)
> +               hw =3D ERR_PTR(ret);
> +
> +       return hw;
> +}
> +
[....]
> +
> +static const struct clk_ops loongson2_sata_clk_ops =3D {
> +       .recalc_rate =3D loongson2_sata_recalc_rate,
> +};
> +
> +static inline void loongson2_check_clk_hws(struct clk_hw *clks[], unsign=
ed int count)

This needs to return an error instead of be void.

> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < count; i++)
> +               if (IS_ERR(clks[i]))
> +                       pr_err("Loongson2 clk %u: register failed with %l=
d\n",
> +                               i, PTR_ERR(clks[i]));
> +}
> +
> +static inline void loongson2_clocks_init(struct device *dev)
> +{
> +       struct clk_hw **hws;
> +       struct clk_hw_onecell_data *clk_hw_data;
> +       spinlock_t loongson2_clk_lock;
> +
> +       clk_hw_data =3D devm_kzalloc(dev, struct_size(clk_hw_data, hws, L=
OONGSON2_CLK_END),
> +                                       GFP_KERNEL);
> +       if (WARN_ON(!clk_hw_data))
> +               return;
> +
> +       clk_hw_data->num =3D LOONGSON2_CLK_END;
> +       hws =3D clk_hw_data->hws;
> +
> +       hws[LOONGSON2_NODE_PLL] =3D loongson2_clk_register(dev, "node_pll=
",
> +                                               NULL,
> +                                               &loongson2_node_clk_ops, =
0);
> +
> +       hws[LOONGSON2_DDR_PLL] =3D loongson2_clk_register(dev, "ddr_pll",
> +                                               NULL,
> +                                               &loongson2_ddr_clk_ops, 0=
);
> +
> +       hws[LOONGSON2_DC_PLL] =3D loongson2_clk_register(dev, "dc_pll",
> +                                               NULL,
> +                                               &loongson2_dc_clk_ops, 0);
> +
> +       hws[LOONGSON2_PIX0_PLL] =3D loongson2_clk_register(dev, "pix0_pll=
",
> +                                               NULL,
> +                                               &loongson2_pix0_clk_ops, =
0);
> +
> +       hws[LOONGSON2_PIX1_PLL] =3D loongson2_clk_register(dev, "pix1_pll=
",
> +                                               NULL,
> +                                               &loongson2_pix1_clk_ops, =
0);
> +
> +       hws[LOONGSON2_BOOT_CLK] =3D loongson2_clk_register(dev, "boot",
> +                                               NULL,
> +                                               &loongson2_boot_clk_ops, =
0);
> +
> +       hws[LOONGSON2_NODE_CLK] =3D clk_hw_register_divider(NULL, "node",

These should be devm_ variants so they're undone on failure.

> +                                               "node_pll", 0,
> +                                               loongson2_pll_base + 0x8,=
 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       /*
> +        * The hda clk divisor in the upper 32bits and the clk-prodiver
> +        * layer code doesn't support 64bit io operation thus a conversion
> +        * is required that subtract shift by 32 and add 4byte to the hda
> +        * address
> +        */
> +       hws[LOONGSON2_HDA_CLK] =3D clk_hw_register_divider(NULL, "hda",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x22=
, 12,
> +                                               7, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_GPU_CLK] =3D clk_hw_register_divider(NULL, "gpu",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x18=
, 22,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_DDR_CLK] =3D clk_hw_register_divider(NULL, "ddr",
> +                                               "ddr_pll", 0,
> +                                               loongson2_pll_base + 0x18=
, 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_GMAC_CLK] =3D clk_hw_register_divider(NULL, "gmac",
> +                                               "dc_pll", 0,
> +                                               loongson2_pll_base + 0x28=
, 22,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_DC_CLK] =3D clk_hw_register_divider(NULL, "dc",
> +                                               "dc_pll", 0,
> +                                               loongson2_pll_base + 0x28=
, 0,
> +                                               6, CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_APB_CLK] =3D loongson2_clk_register(dev, "apb",
> +                                               "gmac",
> +                                               &loongson2_apb_clk_ops, 0=
);
> +
> +       hws[LOONGSON2_USB_CLK] =3D loongson2_clk_register(dev, "usb",
> +                                               "gmac",
> +                                               &loongson2_usb_clk_ops, 0=
);
> +
> +       hws[LOONGSON2_SATA_CLK] =3D loongson2_clk_register(dev, "sata",
> +                                               "gmac",
> +                                               &loongson2_sata_clk_ops, =
0);
> +
> +       hws[LOONGSON2_PIX0_CLK] =3D clk_hw_register_divider(NULL, "pix0",
> +                                               "pix0_pll", 0,
> +                                               loongson2_pll_base + 0x38=
, 0, 6,
> +                                               CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       hws[LOONGSON2_PIX1_CLK] =3D clk_hw_register_divider(NULL, "pix1",
> +                                               "pix1_pll", 0,
> +                                               loongson2_pll_base + 0x48=
, 0, 6,
> +                                               CLK_DIVIDER_ONE_BASED,
> +                                               &loongson2_clk_lock);
> +
> +       loongson2_check_clk_hws(hws, LOONGSON2_CLK_END);
> +
> +       devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_da=
ta);

Return this error code.

> +}
> +
> +static const struct of_device_id loongson2_clk_match_table[] =3D {
> +       { .compatible =3D "loongson,ls2k-clk" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_clk_match_table);

This table can go next to the driver instead of be above probe.

> +
> +static int loongson2_clk_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +
> +       loongson2_pll_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (!loongson2_pll_base)

Should be IS_ERR(loongson2_pll_base)

> +               return PTR_ERR(loongson2_pll_base);
> +
> +       loongson2_clocks_init(dev);

Please inline this function here.
