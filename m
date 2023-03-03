Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA236A8FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCCDh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCDh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:37:27 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357884393C;
        Thu,  2 Mar 2023 19:37:25 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1856624E3AD;
        Fri,  3 Mar 2023 11:37:24 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 11:37:24 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 11:37:22 +0800
Message-ID: <7968218d-33ec-14b8-178b-1a6b5680f797@starfivetech.com>
Date:   Fri, 3 Mar 2023 11:37:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 09/11] clk: starfive: Add StarFive JH7110 Video-Output
 clock driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-10-xingyu.wu@starfivetech.com>
 <CAJM55Z8XnBtBJK8tgDBoQ0FLFY10NQ3es7Aj0TwiTG6vfzqUSQ@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z8XnBtBJK8tgDBoQ0FLFY10NQ3es7Aj0TwiTG6vfzqUSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/2 23:48, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 09:40, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>>
>> Add driver for the StarFive JH7110 Video-Output clock controller.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  drivers/clk/starfive/Kconfig                  |  11 +
>>  drivers/clk/starfive/Makefile                 |   1 +
>>  .../clk/starfive/clk-starfive-jh7110-vout.c   | 261 ++++++++++++++++++
>>  3 files changed, 273 insertions(+)
>>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-vout.c
>>
>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
>> index 59499acb95f7..5ebf1ed08627 100644
>> --- a/drivers/clk/starfive/Kconfig
>> +++ b/drivers/clk/starfive/Kconfig
>> @@ -64,3 +64,14 @@ config CLK_STARFIVE_JH7110_ISP
>>         help
>>           Say yes here to support the Image-Signal-Process clock controller
>>           on the StarFive JH7110 SoC.
>> +
>> +config CLK_STARFIVE_JH7110_VOUT
>> +       tristate "StarFive JH7110 Video-Output clock support"
>> +       depends on CLK_STARFIVE_JH7110_SYS && JH71XX_PMU
>> +       select AUXILIARY_BUS
>> +       select CLK_STARFIVE_JH71X0
>> +       select RESET_STARFIVE_JH7110
>> +       default CLK_STARFIVE_JH7110_SYS
> 
> default m if ARCH_STARFIVE

Will modify it.

> 
>> +       help
>> +         Say yes here to support the Video-Output clock controller
>> +         on the StarFive JH7110 SoC.
>> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
>> index 76fb9f8d628b..841377e45bb6 100644
>> --- a/drivers/clk/starfive/Makefile
>> +++ b/drivers/clk/starfive/Makefile
>> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)   += clk-starfive-jh7110-sys.o
>>  obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)  += clk-starfive-jh7110-aon.o
>>  obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)  += clk-starfive-jh7110-stg.o
>>  obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)  += clk-starfive-jh7110-isp.o
>> +obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT) += clk-starfive-jh7110-vout.o
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-vout.c b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> new file mode 100644
>> index 000000000000..d786537563a4
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-vout.c
>> @@ -0,0 +1,261 @@
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
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/reset.h>
>> +
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +
>> +#include "clk-starfive-jh71x0.h"
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
>> +struct vout_top_crg {
>> +       struct clk_bulk_data *top_clks;
>> +       struct reset_control *top_rst;
>> +       int top_clks_num;
>> +       void __iomem *base;
>> +};
>> +
>> +static struct clk_bulk_data jh7110_vout_top_clks[] = {
>> +       { .id = "vout_src" },
>> +       { .id = "vout_top_ahb" }
>> +};
>> +
>> +static struct vout_top_crg *top_crg_from(void __iomem **base)
>> +{
>> +       return container_of(base, struct vout_top_crg, base);
>> +}
>> +
>> +static int jh7110_vout_top_crg_get(struct jh71x0_clk_priv *priv, struct vout_top_crg *top)
>> +{
>> +       int ret;
>> +
>> +       top->top_clks = jh7110_vout_top_clks;
>> +       top->top_clks_num = ARRAY_SIZE(jh7110_vout_top_clks);
>> +       ret = devm_clk_bulk_get(priv->dev, top->top_clks_num, top->top_clks);
>> +       if (ret) {
>> +               dev_err(priv->dev, "top clks get failed: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /* The reset should be shared and other Vout modules will use its. */
>> +       top->top_rst = devm_reset_control_get_shared(priv->dev, NULL);
>> +       if (IS_ERR(top->top_rst)) {
>> +               dev_err(priv->dev, "top rst get failed\n");
>> +               return PTR_ERR(top->top_rst);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int jh7110_vout_top_crg_enable(struct vout_top_crg *top)
>> +{
>> +       int ret;
>> +
>> +       ret = clk_bulk_prepare_enable(top->top_clks_num, top->top_clks);
>> +       if (ret)
>> +               return ret;
> 
> Hmm.. do all the clocks used as input really need to be enabled for
> any one of the vout clocks to work?
> 
> In other words: suppose you just need a single clock in the VOUTCRG
> domain. Do we really need to turn on all the input clocks for the
> VOUTCRG for that one clock to work? Normally I'd expect the clock
> framework to make sure all parents of that clock are enabled.

It must enable core clock and ahb clock before reading or writing VOUTCRG registers
otherwise it would be failed to read and write. And it is even crash if it don't
enable core clock before reading or writing ISPCRG registers.
This serious problem was found when debugging earlier.

> 
>> +
>> +       return reset_control_deassert(top->top_rst);
>> +}
>> +
>> +static void jh7110_vout_top_crg_disable(struct vout_top_crg *top)
>> +{
>> +       clk_bulk_disable_unprepare(top->top_clks_num, top->top_clks);
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
>> +       top->base = priv->base;
>> +       dev_set_drvdata(priv->dev, (void *)(&top->base));
>> +
>> +       pm_runtime_enable(priv->dev);
>> +       ret = pm_runtime_get_sync(priv->dev);
>> +       if (ret < 0) {
>> +               dev_err(priv->dev, "failed to turn power: %d\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = jh7110_vout_top_crg_get(priv, top);
>> +       if (ret)
>> +               goto err_clk;
>> +
>> +       ret = jh7110_vout_top_crg_enable(top);
>> +       if (ret)
>> +               goto err_clk;
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
>> +               char *fw_name[JH7110_VOUTCLK_EXT_END - JH7110_VOUTCLK_END] = {
> 
> this can be const char *const fw_name[...] right?
> 
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
>> +       ret = jh7110_reset_controller_register(priv, "reset-vout", 4);
>> +       if (ret)
>> +               goto err_exit;
>> +
>> +       return 0;
>> +
>> +err_exit:
>> +       jh7110_vout_top_crg_disable(top);
>> +err_clk:
>> +       pm_runtime_put_sync(priv->dev);
>> +       pm_runtime_disable(priv->dev);
>> +       return ret;
>> +}
>> +
>> +static int jh7110_voutcrg_remove(struct platform_device *pdev)
>> +{
>> +       void __iomem **base = dev_get_drvdata(&pdev->dev);
>> +       struct vout_top_crg *top = top_crg_from(base);
>> +
>> +       jh7110_vout_top_crg_disable(top);
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
>> +       .driver = {
>> +               .name = "clk-starfive-jh7110-vout",
>> +               .of_match_table = jh7110_voutcrg_match,
>> +       },
>> +};
>> +module_platform_driver(jh7110_voutcrg_driver);
>> +
>> +MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
>> +MODULE_DESCRIPTION("StarFive JH7110 Video-Output clock driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

Best regards,
Xingyu Wu
