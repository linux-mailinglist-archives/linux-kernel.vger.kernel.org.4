Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A986DEBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDLGQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLGQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:16:25 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C94340D8;
        Tue, 11 Apr 2023 23:16:23 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 1CE9424DBBD;
        Wed, 12 Apr 2023 14:16:22 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:16:21 +0800
Received: from [192.168.125.131] (113.72.145.176) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:16:20 +0800
Message-ID: <463ee23c-f617-bed0-27a8-56c6fb40d092@starfivetech.com>
Date:   Wed, 12 Apr 2023 14:15:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 07/10] clk: starfive: Add StarFive JH7110 Video-Output
 clock driver
To:     Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230411135558.44282-1-xingyu.wu@starfivetech.com>
 <20230411135558.44282-8-xingyu.wu@starfivetech.com>
 <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org>
Content-Language: en-US
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <683cbe934d1df9436e003466d2a419ef.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/12 2:33, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-04-11 06:55:55)
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> new file mode 100644
>> index 000000000000..4c6f5ae198cf
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> @@ -0,0 +1,239 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 Video-Output Clock Driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
> 
> Include module.h, device.h, and kernel.h for things like ERR_PTR().

The local headfile 'clk-starfive-jh71x0.h' from the basic JH71x0 clock driver
already includes the device.h. 
And I found the module.h is included in device/driver.h file and then it is included
in the device.h file.
The kernel.h is included in the clk.h file.
So do I still need to list them?

> Probably need to include a reset header as well for reset APIs.

The reset APIs like devm_reset_control_get_shared() and reset_control_deassert()
come from the reset.h file and I have included it.

> 
>> +
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +
>> +#include "clk-starfive-jh7110.h"
>> +
>> +/* external clocks */
>> +#define JH7110_VOUTCLK_VOUT_SRC                        (JH7110_VOUTCLK_END + 0)
>> +#define JH7110_VOUTCLK_VOUT_TOP_AHB            (JH7110_VOUTCLK_END + 1)
>> +#define JH7110_VOUTCLK_VOUT_TOP_AXI            (JH7110_VOUTCLK_END + 2)
>> +#define JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK   (JH7110_VOUTCLK_END + 3)
>> +#define JH7110_VOUTCLK_I2STX0_BCLK             (JH7110_VOUTCLK_END + 4)
>> +#define JH7110_VOUTCLK_HDMITX0_PIXELCLK                (JH7110_VOUTCLK_END + 5)
>> +#define JH7110_VOUTCLK_EXT_END                 (JH7110_VOUTCLK_END + 6)
>> +
>> +/* VOUT domian clocks */
>> +struct vout_top_crg {
>> +       struct clk_bulk_data *top_clks;
>> +       int top_clks_num;
> 
> size_t?

Will modify to 'unsigned int'.

> 
>> +       void __iomem *base;
>> +};
>> +
>> +static struct clk_bulk_data jh7110_vout_top_clks[] = {
>> +       { .id = "vout_src" },
>> +       { .id = "vout_top_ahb" }
>> +};
>> +
>> +static const struct jh71x0_clk_data jh7110_voutclk_data[] = {
>> +       /* divider */
>> +       JH71X0__DIV(JH7110_VOUTCLK_APB, "apb", 8, JH7110_VOUTCLK_VOUT_TOP_AHB),
>> +       JH71X0__DIV(JH7110_VOUTCLK_DC8200_PIX, "dc8200_pix", 63, JH7110_VOUTCLK_VOUT_SRC),
>> +       JH71X0__DIV(JH7110_VOUTCLK_DSI_SYS, "dsi_sys", 31, JH7110_VOUTCLK_VOUT_SRC),
>> +       JH71X0__DIV(JH7110_VOUTCLK_TX_ESC, "tx_esc", 31, JH7110_VOUTCLK_VOUT_TOP_AHB),
>> +       /* dc8200 */
>> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_AXI, "dc8200_axi", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
>> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_CORE, "dc8200_core", 0, JH7110_VOUTCLK_VOUT_TOP_AXI),
>> +       JH71X0_GATE(JH7110_VOUTCLK_DC8200_AHB, "dc8200_ahb", 0, JH7110_VOUTCLK_VOUT_TOP_AHB),
>> +       JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX0, "dc8200_pix0", 0, 2,
>> +                   JH7110_VOUTCLK_DC8200_PIX,
>> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
>> +       JH71X0_GMUX(JH7110_VOUTCLK_DC8200_PIX1, "dc8200_pix1", 0, 2,
>> +                   JH7110_VOUTCLK_DC8200_PIX,
>> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
>> +       /* LCD */
>> +       JH71X0_GMUX(JH7110_VOUTCLK_DOM_VOUT_TOP_LCD, "dom_vout_top_lcd", 0, 2,
>> +                   JH7110_VOUTCLK_DC8200_PIX0,
>> +                   JH7110_VOUTCLK_DC8200_PIX1),
>> +       /* dsiTx */
>> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_APB, "dsiTx_apb", 0, JH7110_VOUTCLK_DSI_SYS),
>> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_SYS, "dsiTx_sys", 0, JH7110_VOUTCLK_DSI_SYS),
>> +       JH71X0_GMUX(JH7110_VOUTCLK_DSITX_DPI, "dsiTx_dpi", 0, 2,
>> +                   JH7110_VOUTCLK_DC8200_PIX,
>> +                   JH7110_VOUTCLK_HDMITX0_PIXELCLK),
>> +       JH71X0_GATE(JH7110_VOUTCLK_DSITX_TXESC, "dsiTx_txesc", 0, JH7110_VOUTCLK_TX_ESC),
>> +       /* mipitx DPHY */
>> +       JH71X0_GATE(JH7110_VOUTCLK_MIPITX_DPHY_TXESC, "mipitx_dphy_txesc", 0,
>> +                   JH7110_VOUTCLK_TX_ESC),
>> +       /* hdmi */
>> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_MCLK, "hdmi_tx_mclk", 0,
>> +                   JH7110_VOUTCLK_VOUT_TOP_HDMITX0_MCLK),
>> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_BCLK, "hdmi_tx_bclk", 0,
>> +                   JH7110_VOUTCLK_I2STX0_BCLK),
>> +       JH71X0_GATE(JH7110_VOUTCLK_HDMI_TX_SYS, "hdmi_tx_sys", 0, JH7110_VOUTCLK_APB),
>> +};
>> +
>> +static struct vout_top_crg *top_crg_from(void __iomem **base)
>> +{
>> +       return container_of(base, struct vout_top_crg, base);
>> +}
>> +
>> +static int jh7110_vout_top_crg_init(struct jh71x0_clk_priv *priv, struct vout_top_crg *top)
>> +{
>> +       struct reset_control *top_rst;
>> +       int ret;
>> +
>> +       top->top_clks = jh7110_vout_top_clks;
>> +       top->top_clks_num = ARRAY_SIZE(jh7110_vout_top_clks);
>> +       ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
>> +       if (ret)
>> +               return dev_err_probe(priv->dev, ret, "failed to get top clocks\n");
>> +
>> +       /* The reset should be shared and other Vout modules will use its. */
>> +       top_rst = devm_reset_control_get_shared(priv->dev, NULL);
>> +       if (IS_ERR(top_rst))
>> +               return dev_err_probe(priv->dev, PTR_ERR(top_rst), "failed to get top reset\n");
>> +
>> +       ret = clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
>> +       if (ret)
>> +               return dev_err_probe(priv->dev, ret, "failed to enable top clocks\n");
>> +
>> +       return reset_control_deassert(top_rst);
>> +}
>> +
>> +static struct clk_hw *jh7110_voutclk_get(struct of_phandle_args *clkspec, void *data)
>> +{
>> +       struct jh71x0_clk_priv *priv = data;
>> +       unsigned int idx = clkspec->args[0];
>> +
>> +       if (idx < JH7110_VOUTCLK_END)
>> +               return &priv->reg[idx].hw;
>> +
>> +       return ERR_PTR(-EINVAL);
>> +}
>> +
>> +static int jh7110_voutcrg_probe(struct platform_device *pdev)
>> +{
>> +       struct jh71x0_clk_priv *priv;
>> +       struct vout_top_crg *top;
>> +       unsigned int idx;
>> +       int ret;
>> +
>> +       priv = devm_kzalloc(&pdev->dev,
>> +                           struct_size(priv, reg, JH7110_VOUTCLK_END),
>> +                           GFP_KERNEL);
>> +       if (!priv)
>> +               return -ENOMEM;
>> +
>> +       top = devm_kzalloc(&pdev->dev, sizeof(*top), GFP_KERNEL);
>> +       if (!top)
>> +               return -ENOMEM;
>> +
>> +       spin_lock_init(&priv->rmw_lock);
>> +       priv->dev = &pdev->dev;
>> +       priv->base = devm_platform_ioremap_resource(pdev, 0);
>> +       if (IS_ERR(priv->base))
>> +               return PTR_ERR(priv->base);
>> +
>> +       pm_runtime_enable(priv->dev);
> 
> Use devm_pm_runtime_enable()?

Will fix.

> 
>> +       ret = pm_runtime_get_sync(priv->dev);
> 
> And use pm_runtime_resume_and_get() here?

Will fix.

> 
>> +       if (ret < 0)
>> +               return dev_err_probe(priv->dev, ret, "failed to turn on power\n");
>> +
>> +       ret = jh7110_vout_top_crg_init(priv, top);
>> +       if (ret)
>> +               goto err_clk;
>> +
>> +       top->base = priv->base;
>> +       dev_set_drvdata(priv->dev, (void *)(&top->base));
> 
> See comment later about setting this to 'top' instead. Casting away
> iomem markings is not good hygiene.

JH7110 resets as the auxiliary device of clocks use the same iomem as the clocks
and the iomem will be got by dev_get_drvdata() in the 7110 reset drivers when registering reset.
So I follow the basic 7110 reset driver and also set the iomem not top_crg struct.

> 
>> +
>> +       for (idx = 0; idx < JH7110_VOUTCLK_END; idx++) {
>> +               u32 max = jh7110_voutclk_data[idx].max;
>> +               struct clk_parent_data parents[4] = {};
>> +               struct clk_init_data init = {
>> +                       .name = jh7110_voutclk_data[idx].name,
>> +                       .ops = starfive_jh71x0_clk_ops(max),
>> +                       .parent_data = parents,
>> +                       .num_parents =
>> +                               ((max & JH71X0_CLK_MUX_MASK) >> JH71X0_CLK_MUX_SHIFT) + 1,
>> +                       .flags = jh7110_voutclk_data[idx].flags,
>> +               };
>> +               struct jh71x0_clk *clk = &priv->reg[idx];
>> +               unsigned int i;
>> +               const char *fw_name[JH7110_VOUTCLK_EXT_END - JH7110_VOUTCLK_END] = {
>> +                       "vout_src",
>> +                       "vout_top_ahb",
>> +                       "vout_top_axi",
>> +                       "vout_top_hdmitx0_mclk",
>> +                       "i2stx0_bclk",
>> +                       "hdmitx0_pixelclk"
>> +               };
>> +
>> +               for (i = 0; i < init.num_parents; i++) {
>> +                       unsigned int pidx = jh7110_voutclk_data[idx].parents[i];
>> +
>> +                       if (pidx < JH7110_VOUTCLK_END)
>> +                               parents[i].hw = &priv->reg[pidx].hw;
>> +                       else if (pidx < JH7110_VOUTCLK_EXT_END)
>> +                               parents[i].fw_name = fw_name[pidx - JH7110_VOUTCLK_END];
> 
> Can you use .index instead?

OK, I try to use it instead.

> 
>> +               }
>> +
>> +               clk->hw.init = &init;
>> +               clk->idx = idx;
>> +               clk->max_div = max & JH71X0_CLK_DIV_MASK;
>> +
>> +               ret = devm_clk_hw_register(&pdev->dev, &clk->hw);
>> +               if (ret)
>> +                       goto err_exit;
>> +       }
>> +
>> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, jh7110_voutclk_get, priv);
>> +       if (ret)
>> +               goto err_exit;
>> +
>> +       ret = jh7110_reset_controller_register(priv, "rst-vout", 4);
>> +       if (ret)
>> +               goto err_exit;
>> +
>> +       return 0;
>> +
>> +err_exit:
>> +       clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
>> +err_clk:
>> +       pm_runtime_put_sync(priv->dev);
>> +       pm_runtime_disable(priv->dev);
>> +       return ret;
>> +}
>> +
>> +static int jh7110_voutcrg_remove(struct platform_device *pdev)
>> +{
>> +       void __iomem **base = dev_get_drvdata(&pdev->dev);
> 
> Why not set the driver data to be vout_top_crg?

The reason is stated above.

> 
>> +       struct vout_top_crg *top = top_crg_from(base);
> 
> And get rid of this top_crg_from() API?
> 
>> +
>> +       clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
>> +       pm_runtime_disable(&pdev->dev);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id jh7110_voutcrg_match[] = {
>> +       { .compatible = "starfive,jh7110-voutcrg" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, jh7110_voutcrg_match);
>> +
>> +static struct platform_driver jh7110_voutcrg_driver = {
>> +       .probe = jh7110_voutcrg_probe,
>> +       .remove = jh7110_voutcrg_remove,
> 
> Use remove_new please.

Will fix.
Thanks.

Best regards,
Xingyu Wu
