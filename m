Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122E6DE3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjDKSdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDKSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E514C3D;
        Tue, 11 Apr 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7E11621FD;
        Tue, 11 Apr 2023 18:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440C5C433D2;
        Tue, 11 Apr 2023 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681238023;
        bh=FgzA+wAQOhvwLPFEU0HXw3rNNZIT+sR+BkcnhuK0cso=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=M6b/gJ2gWuWAdiFoUnfld6Y/G5/BDCSCbnak0Pe+uP5BYjHpWF1iWwB9AxFmDXRce
         kGFg5pOmvTzaOl2xDoXcb/LtV340BO9NXypXG00cOy4szlFYBVZifM7257F7CDYoMJ
         bgZ2lYhwZr6wP0E3PKUo6EefvNV3zCPo+bo9XW7NlY7rK/SPR1cnkYjntmeSR2IHl0
         HHjiZBdvZJxF7A7SowyfjaJyiHse7cpaSBZmFEd7MNjInr93CNlhclydTQaD2WbZiE
         U5Niv8wxCQ7qscG5QTNWUngsBg21He/2V+jeuqZ8zhNUQ4x/2VmdBg401XIbg+dSKN
         ioBbW6nJACBMQ==
Message-ID: <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230411135558.44282-8-xingyu.wu@starfivetech.com>
References: <20230411135558.44282-1-xingyu.wu@starfivetech.com> <20230411135558.44282-8-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v4 07/10] clk: starfive: Add StarFive JH7110 Video-Output clock driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Tue, 11 Apr 2023 11:33:41 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xingyu Wu (2023-04-11 06:55:55)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/cl=
k/starfive/clk-starfive-jh7110-vout.c
> new file mode 100644
> index 000000000000..4c6f5ae198cf
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JH7110 Video-Output Clock Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>

Include module.h, device.h, and kernel.h for things like ERR_PTR().
Probably need to include a reset header as well for reset APIs.

> +
> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +#include "clk-starfive-jh7110.h"
> +
> +/* external clocks */
> +#define JH7110_VOUTCLK_VOUT_SRC                        (JH7110_VOUTCLK_E=
ND + 0)
> +#define JH7110_VOUTCLK_VOUT_TOP_AHB            (JH7110_VOUTCLK_END + 1)
> +#define JH7110_VOUTCLK_VOUT_TOP_AXI            (JH7110_VOUTCLK_END + 2)
> +#define JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK   (JH7110_VOUTCLK_END + 3)
> +#define JH7110_VOUTCLK_I2STX0_BCLK             (JH7110_VOUTCLK_END + 4)
> +#define JH7110_VOUTCLK_HDMITX0_PIXELCLK                (JH7110_VOUTCLK_E=
ND + 5)
> +#define JH7110_VOUTCLK_EXT_END                 (JH7110_VOUTCLK_END + 6)
> +
> +/* VOUT domian clocks */
> +struct vout_top_crg {
> +       struct clk_bulk_data *top_clks;
> +       int top_clks_num;

size_t?

> +       void __iomem *base;
> +};
> +
> +static struct clk_bulk_data jh7110_vout_top_clks[] =3D {
> +       { .id =3D "vout_src" },
> +       { .id =3D "vout_top_ahb" }
> +};
> +
> +static const struct jh71x0_clk_data jh7110_voutclk_data[] =3D {
> +       /* divider */
> +       JH71X0__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP=
_AHB),
> +       JH71X0__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_V=
OUTCLK_VOUT_SRC),
> +       JH71X0__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK=
_VOUT_SRC),
> +       JH71X0__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_V=
OUT_TOP_AHB),
> +       /* dc8200 */
> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VO=
UTCLK_VOUT_TOP_AXI),
> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_=
VOUTCLK_VOUT_TOP_AXI),
> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VO=
UTCLK_VOUT_TOP_AHB),
> +       JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
> +                   JH7110_VOUTCLK_DC8200_PIX,
> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
> +       JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
> +                   JH7110_VOUTCLK_DC8200_PIX,
> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
> +       /* LCD */
> +       JH71X0_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", =
0, 2,
> +                   JH7110_VOUTCLK_DC8200_PIX0,
> +                   JH7110_VOUTCLK_DC8200_PIX1),
> +       /* dsiTx */
> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUT=
CLK_DSI_SYS),
> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUT=
CLK_DSI_SYS),
> +       JH71X0_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
> +                   JH7110_VOUTCLK_DC8200_PIX,
> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_=
VOUTCLK_TX_ESC),
> +       /* mipitx DPHY */
> +       JH71X0_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc"=
, 0,
> +                   JH7110_VOUTCLK_TX_ESC),
> +       /* hdmi */
> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
> +                   JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
> +                   JH7110_VOUTCLK_I2STX0_BCLK),
> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_=
VOUTCLK_APB),
> +};
> +
> +static struct vout_top_crg *top_crg_from(void __iomem **base)
> +{
> +       return container_of(base, struct vout_top_crg, base);
> +}
> +
> +static int jh7110_vout_top_crg_init(struct jh71x0_clk_priv *priv, struct=
 vout_top_crg *top)
> +{
> +       struct reset_control *top_rst;
> +       int ret;
> +
> +       top->top_clks =3D jh7110_vout_top_clks;
> +       top->top_clks_num =3D ARRAY_SIZE(jh7110_vout_top_clks);
> +       ret =3D devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_=
clks);
> +       if (ret)
> +               return dev_err_probe(priv->dev, ret, "failed to get top c=
locks\n");
> +
> +       /* The reset should be shared and other Vout modules will use its=
. */
> +       top_rst =3D devm_reset_control_get_shared(priv->dev, NULL);
> +       if (IS_ERR(top_rst))
> +               return dev_err_probe(priv->dev, PTR_ERR(top_rst), "failed=
 to get top reset\n");
> +
> +       ret =3D clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
> +       if (ret)
> +               return dev_err_probe(priv->dev, ret, "failed to enable to=
p clocks\n");
> +
> +       return reset_control_deassert(top_rst);
> +}
> +
> +static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec=
, void *data)
> +{
> +       struct jh71x0_clk_priv *priv =3D data;
> +       unsigned int idx =3D clkspec->args[0];
> +
> +       if (idx < JH7110_VOUTCLK_END)
> +               return &priv->reg[idx].hw;
> +
> +       return ERR_PTR(-EINVAL);
> +}
> +
> +static int jh7110_voutcrg_probe(struct platform_device *pdev)
> +{
> +       struct jh71x0_clk_priv *priv;
> +       struct vout_top_crg *top;
> +       unsigned int idx;
> +       int ret;
> +
> +       priv =3D devm_kzalloc(&pdev->dev,
> +                           struct_size(priv, reg, JH7110_VOUTCLK_END),
> +                           GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       top =3D devm_kzalloc(&pdev->dev, sizeof(*top), GFP_KERNEL);
> +       if (!top)
> +               return -ENOMEM;
> +
> +       spin_lock_init(&priv->rmw_lock);
> +       priv->dev =3D &pdev->dev;
> +       priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       pm_runtime_enable(priv->dev);

Use devm_pm_runtime_enable()?

> +       ret =3D pm_runtime_get_sync(priv->dev);

And use pm_runtime_resume_and_get() here?

> +       if (ret < 0)
> +               return dev_err_probe(priv->dev, ret, "failed to turn on p=
ower\n");
> +
> +       ret =3D jh7110_vout_top_crg_init(priv, top);
> +       if (ret)
> +               goto err_clk;
> +
> +       top->base =3D priv->base;
> +       dev_set_drvdata(priv->dev, (void *)(&top->base));

See comment later about setting this to 'top' instead. Casting away
iomem markings is not good hygiene.

> +
> +       for (idx =3D 0; idx < JH7110_VOUTCLK_END; idx++) {
> +               u32 max =3D jh7110_voutclk_data[idx].max;
> +               struct clk_parent_data parents[4] =3D {};
> +               struct clk_init_data init =3D {
> +                       .name =3D jh7110_voutclk_data[idx].name,
> +                       .ops =3D starfive_jh71x0_clk_ops(max),
> +                       .parent_data =3D parents,
> +                       .num_parents =3D
> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CL=
K_MUX_SHIFT) + 1,
> +                       .flags =3D jh7110_voutclk_data[idx].flags,
> +               };
> +               struct jh71x0_clk *clk =3D &priv->reg[idx];
> +               unsigned int i;
> +               const char *fw_name[JH7110_VOUTCLK_EXT_END - JH7110_VOUTC=
LK_END] =3D {
> +                       "vout_src",
> +                       "vout_top_ahb",
> +                       "vout_top_axi",
> +                       "vout_top_hdmitx0_mclk",
> +                       "i2stx0_bclk",
> +                       "hdmitx0_pixelclk"
> +               };
> +
> +               for (i =3D 0; i < init.num_parents; i++) {
> +                       unsigned int pidx =3D jh7110_voutclk_data[idx].pa=
rents[i];
> +
> +                       if (pidx < JH7110_VOUTCLK_END)
> +                               parents[i].hw =3D &priv->reg[pidx].hw;
> +                       else if (pidx < JH7110_VOUTCLK_EXT_END)
> +                               parents[i].fw_name =3D fw_name[pidx - JH7=
110_VOUTCLK_END];

Can you use .index instead?

> +               }
> +
> +               clk->hw.init =3D &init;
> +               clk->idx =3D idx;
> +               clk->max_div =3D max & JH71X0_CLK_DIV_MASK;
> +
> +               ret =3D devm_clk_hw_register(&pdev->dev, &clk->hw);
> +               if (ret)
> +                       goto err_exit;
> +       }
> +
> +       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, jh7110_voutclk_ge=
t, priv);
> +       if (ret)
> +               goto err_exit;
> +
> +       ret =3D jh7110_reset_controller_register(priv, "rst-vout", 4);
> +       if (ret)
> +               goto err_exit;
> +
> +       return 0;
> +
> +err_exit:
> +       clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
> +err_clk:
> +       pm_runtime_put_sync(priv->dev);
> +       pm_runtime_disable(priv->dev);
> +       return ret;
> +}
> +
> +static int jh7110_voutcrg_remove(struct platform_device *pdev)
> +{
> +       void __iomem **base =3D dev_get_drvdata(&pdev->dev);

Why not set the driver data to be vout_top_crg?

> +       struct vout_top_crg *top =3D top_crg_from(base);

And get rid of this top_crg_from() API?

> +
> +       clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
> +       pm_runtime_disable(&pdev->dev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id jh7110_voutcrg_match[] =3D {
> +       { .compatible =3D "starfive,jh7110-voutcrg" },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, jh7110_voutcrg_match);
> +
> +static struct platform_driver jh7110_voutcrg_driver =3D {
> +       .probe =3D jh7110_voutcrg_probe,
> +       .remove =3D jh7110_voutcrg_remove,

Use remove_new please.
