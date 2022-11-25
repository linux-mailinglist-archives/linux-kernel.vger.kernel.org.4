Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BE63826C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKYCda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYCd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:33:29 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B271F62C;
        Thu, 24 Nov 2022 18:33:25 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DBA1324E1A4;
        Fri, 25 Nov 2022 10:33:16 +0800 (CST)
Received: from EXMBX072.cuchost.com (172.16.6.82) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 10:33:17 +0800
Received: from [192.168.125.106] (183.27.97.81) by EXMBX072.cuchost.com
 (172.16.6.82) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 10:33:15 +0800
Message-ID: <d367c8c3-50ce-585f-9caa-573f42b76064@starfivetech.com>
Date:   Fri, 25 Nov 2022 10:33:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
From:   Hal Feng <hal.feng@starfivetech.com>
Subject: Re: [PATCH v2 11/14] clk: starfive: Add StarFive JH7110 system clock
 driver
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-12-hal.feng@starfivetech.com>
 <CAJM55Z9fshBmW0x4B4+9s=tffqcPrAd7MbdbvmS0kCBdJunHPg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJM55Z9fshBmW0x4B4+9s=tffqcPrAd7MbdbvmS0kCBdJunHPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX072.cuchost.com
 (172.16.6.82)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2022 01:03:54 +0800, Emil Renner Berthing wrote:
> On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> new file mode 100644
>> index 000000000000..3c1afd691210
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -0,0 +1,650 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 System Clock Driver
>> + *
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/init.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <dt-bindings/clock/starfive-jh7110.h>
>> +
>> +#include "clk-starfive-jh71x0.h"
>> +
>> +/* external clocks */
>> +#define JH7110_SYSCLK_OSC                      (JH7110_SYSCLK_END + 0)
>> +#define JH7110_SYSCLK_GMAC1_RMII_REFIN         (JH7110_SYSCLK_END + 1)
>> +#define JH7110_SYSCLK_GMAC1_RGMII_RXIN         (JH7110_SYSCLK_END + 2)
>> +#define JH7110_SYSCLK_I2STX_BCLK_EXT           (JH7110_SYSCLK_END + 3)
>> +#define JH7110_SYSCLK_I2STX_LRCK_EXT           (JH7110_SYSCLK_END + 4)
>> +#define JH7110_SYSCLK_I2SRX_BCLK_EXT           (JH7110_SYSCLK_END + 5)
>> +#define JH7110_SYSCLK_I2SRX_LRCK_EXT           (JH7110_SYSCLK_END + 6)
>> +#define JH7110_SYSCLK_TDM_EXT                  (JH7110_SYSCLK_END + 7)
>> +#define JH7110_SYSCLK_MCLK_EXT                 (JH7110_SYSCLK_END + 8)
>> +
>> +static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
>> +       /* root */
>> +       JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7,
>> +                   JH7110_SYSCLK_CPU_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_CPU_BUS, "cpu_bus", 2,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0__MUX(JH7110_SYSCLK_GPU_ROOT, "gpu_root", 2,
>> +                   JH7110_SYSCLK_PLL2_OUT,
>> +                   JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0_MDIV(JH7110_SYSCLK_PERH_ROOT, "perh_root", 2, 2,
>> +                   JH7110_SYSCLK_PLL0_OUT,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__MUX(JH7110_SYSCLK_BUS_ROOT, "bus_root", 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_NOCSTG_BUS, "nocstg_bus", 3,
>> +                   JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_AXI_CFG0, "axi_cfg0", 3,
>> +                   JH7110_SYSCLK_BUS_ROOT),
>> +       JH71X0__DIV(JH7110_SYSCLK_STG_AXIAHB, "stg_axiahb", 2,
>> +                   JH7110_SYSCLK_AXI_CFG0),
>> +       JH71X0_GATE(JH7110_SYSCLK_AHB0, "ahb0", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0_GATE(JH7110_SYSCLK_AHB1, "ahb1", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0__DIV(JH7110_SYSCLK_APB_BUS_FUNC, "apb_bus_func", 8,
>> +                   JH7110_SYSCLK_STG_AXIAHB),
>> +       JH71X0_GATE(JH7110_SYSCLK_APB0, "apb0", CLK_IS_CRITICAL,
>> +                   JH7110_SYSCLK_APB_BUS),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL0_DIV2, "pll0_div2", 2,
>> +                   JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL1_DIV2, "pll1_div2", 2,
>> +                   JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_PLL2_DIV2, "pll2_div2", 2,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_AUDIO_ROOT, "audio_root", 8,
>> +                   JH7110_SYSCLK_PLL2_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_MCLK_INNER, "mclk_inner", 64,
>> +                   JH7110_SYSCLK_AUDIO_ROOT),
>> +       JH71X0__MUX(JH7110_SYSCLK_MCLK, "mclk", 2,
>> +                   JH7110_SYSCLK_MCLK_INNER,
>> +                   JH7110_SYSCLK_MCLK_EXT),
>> +       JH71X0_GATE(JH7110_SYSCLK_MCLK_OUT, "mclk_out", 0,
>> +                   JH7110_SYSCLK_MCLK_INNER),
>> +       JH71X0_MDIV(JH7110_SYSCLK_ISP_2X, "isp_2x", 8, 2,
>> +                   JH7110_SYSCLK_PLL2_OUT,
>> +                   JH7110_SYSCLK_PLL1_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_ISP_AXI, "isp_axi", 4,
>> +                   JH7110_SYSCLK_ISP_2X),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK0, "gclk0", 0, 62,
>> +                   JH7110_SYSCLK_PLL0_DIV2),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK1, "gclk1", 0, 62,
>> +                   JH7110_SYSCLK_PLL1_DIV2),
>> +       JH71X0_GDIV(JH7110_SYSCLK_GCLK2, "gclk2", 0, 62,
>> +                   JH7110_SYSCLK_PLL2_DIV2),
>> +       /* cores */
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE, "core_clk", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE1, "core_clk1", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE2, "core_clk2", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE3, "core_clk3", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_CORE4, "core_clk4", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_DEBUG, "debug_clk", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_BUS),
>> +       JH71X0__DIV(JH7110_SYSCLK_RTC_TOGGLE, "rtc_toggle", 6,
>> +                   JH7110_SYSCLK_OSC),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE0, "trace_clk0", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE1, "trace_clk1", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE2, "trace_clk2", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE3, "trace_clk3", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE4, "trace_clk4", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_CORE),
>> +       JH71X0_GATE(JH7110_SYSCLK_TRACE_COM, "trace_com", CLK_IGNORE_UNUSED,
>> +                   JH7110_SYSCLK_CPU_BUS),
> 
> Why should these clocks not be turned off if they're not critical like
> the clocks above?
> 
> My guess would be that the clocks for core 1-4 are critical, but maybe
> not the trace and debug clocks.

I synchronized these flags before with StarFive JH7110 SDK which is not
released yet. But you're right, the core clocks should be enabled and the
debug/trace clocks could be disabled during system booting. After some
discussion, we think it's more appropriate to remove the flags of
trace/debug clocks and set the flags of core clocks as CLK_IS_CRITICAL.

> 
[...]
>> +};
>> +
>> +static const struct {
>> +       const char *name;
>> +       const char *parent;
>> +       unsigned int mul;
>> +       unsigned int div;
>> +} jh7110_fixed_factor_clocks[JH7110_SYSCLK_END - JH7110_SYSCLK_PLL0_OUT] __initconst = {
>> +       [JH7110_SYSCLK_PLL0_OUT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "pll0_out", "osc", 625, 12 /* 24MHz -> 1250.0MHz */
>> +       },
>> +       [JH7110_SYSCLK_PLL1_OUT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "pll1_out", "osc", 533, 12 /* 24MHz -> 1066.0MHz */
>> +       },
>> +       [JH7110_SYSCLK_PLL2_OUT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "pll2_out", "osc", 99, 2 /* 24MHz -> 1188.0MHz */
>> +       },
>> +       [JH7110_SYSCLK_PCLK2_MUX_FUNC - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "pclk2_mux_func", "apb_bus_func", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_PCLK2_MUX - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "pclk2_mux", "pclk2_mux_func", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_APB_BUS - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "apb_bus", "pclk2_mux", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_AXI_CFG1 - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "axi_cfg1", "isp_axi", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_APB12 - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "apb12", "apb_bus", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_VOUT_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "vout_root", "pll2_out", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_VENC_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "venc_root", "pll2_out", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_VDEC_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "vdec_root", "pll0_out", 1, 1
>> +       },
>> +       [JH7110_SYSCLK_GMACUSB_ROOT - JH7110_SYSCLK_PLL0_OUT] = {
>> +               "gmacusb_root", "pll0_out", 1, 1
>> +       },
>> +};
> 
> Having these extra 1-1 clocks that can't be controlled anyway seems unnecessary.
> Consider sync'ing with my latest jh7110 branch at
> https://github.com/esmil/linux/tree/jh7110

Thanks. I'll have a look.

>> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> index baf4b5cb4b8a..7a52e46eb6db 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
>> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> @@ -105,10 +105,18 @@ struct jh71x0_clk_priv {
>>         spinlock_t rmw_lock;
>>         struct device *dev;
>>         void __iomem *base;
>> -       struct clk_hw *pll[3];
>> +       struct clk_hw *pll[12];
>>         struct jh71x0_clk reg[];
>>  };
>>
>>  const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
>>
>> +#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
> 
> The function below is used both in the syscrg driver and the aoncrg
> driver, so why guard it like this?

Because the aoncrg driver depends on the syscrg driver, which is set
in Kconfig.

Best regards,
Hal

> 
>> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>> +                                    const char *adev_name,
>> +                                    u32 adev_id);
>> +
>> +#endif
>> +
>>  #endif
