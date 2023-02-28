Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D526A515D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 03:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjB1Cm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 21:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjB1Cmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 21:42:54 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0158E241CD;
        Mon, 27 Feb 2023 18:42:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9C1FC24E398;
        Tue, 28 Feb 2023 10:42:37 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:42:37 +0800
Received: from [192.168.125.82] (113.72.145.171) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 10:42:36 +0800
Message-ID: <8c30220a-abef-7518-cb44-abcea91408e2@starfivetech.com>
Date:   Tue, 28 Feb 2023 10:42:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 12/19] clk: starfive: Add StarFive JH7110 always-on
 clock driver
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-13-hal.feng@starfivetech.com>
 <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z8H4qmy_BiD0SHW-w5ifzhzokdO-QxpUUz9aeUd+htrZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Feb 2023 18:34:52 +0100, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 03:47, Hal Feng <hal.feng@starfivetech.com> wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>>
>> Add driver for the StarFive JH7110 always-on clock controller
>> and register an auxiliary device for always-on reset controller
>> which is named as "reset-aon".
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  drivers/clk/starfive/Kconfig                  |  11 ++
>>  drivers/clk/starfive/Makefile                 |   1 +
>>  .../clk/starfive/clk-starfive-jh7110-aon.c    | 156 ++++++++++++++++++
>>  3 files changed, 168 insertions(+)
>>  create mode 100644 drivers/clk/starfive/clk-starfive-jh7110-aon.c
>>
>> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
>> index 4640d0665d1c..2aa664f2cdee 100644
>> --- a/drivers/clk/starfive/Kconfig
>> +++ b/drivers/clk/starfive/Kconfig
>> @@ -31,3 +31,14 @@ config CLK_STARFIVE_JH7110_SYS
>>         help
>>           Say yes here to support the system clock controller on the
>>           StarFive JH7110 SoC.
>> +
>> +config CLK_STARFIVE_JH7110_AON
>> +       tristate "StarFive JH7110 always-on clock support"
>> +       depends on CLK_STARFIVE_JH7110_SYS
>> +       select AUXILIARY_BUS
>> +       select CLK_STARFIVE_JH71X0
>> +       select RESET_STARFIVE_JH7110
>> +       default CLK_STARFIVE_JH7110_SYS
> 
> As far as I can tell the JH7110 boots fine without this driver and it
> already depends on the _SYS driver above, so please do
> 
> default m if SOC_STARFIVE

OK. Will fix it.

> 
> And consider helping Conor by changing all the SOC_STARFIVE instances
> to ARCH_STARFIVE for the next version.

OK, I see. Will use the ARCH_ symbol instead.

> 
>> +       help
>> +         Say yes here to support the always-on clock controller on the
>> +         StarFive JH7110 SoC.
>> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
>> index 5ca4e887fb9c..f3df7d957b1e 100644
>> --- a/drivers/clk/starfive/Makefile
>> +++ b/drivers/clk/starfive/Makefile
>> @@ -5,3 +5,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7100)       += clk-starfive-jh7100.o
>>  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)        += clk-starfive-jh7100-audio.o
>>
>>  obj-$(CONFIG_CLK_STARFIVE_JH7110_SYS)  += clk-starfive-jh7110-sys.o
>> +obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)  += clk-starfive-jh7110-aon.o
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-aon.c b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
>> new file mode 100644
>> index 000000000000..da808dc93048
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-aon.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 Always-On Clock Driver
>> + *
>> + * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +
>> +#include "clk-starfive-jh71x0.h"
>> +
>> +/* external clocks */
>> +#define JH7110_AONCLK_OSC              (JH7110_AONCLK_END + 0)
>> +#define JH7110_AONCLK_RTC_OSC          (JH7110_AONCLK_END + 1)
>> +#define JH7110_AONCLK_GMAC0_RMII_REFIN (JH7110_AONCLK_END + 2)
>> +#define JH7110_AONCLK_GMAC0_RGMII_RXIN (JH7110_AONCLK_END + 3)
>> +#define JH7110_AONCLK_STG_AXIAHB       (JH7110_AONCLK_END + 4)
>> +#define JH7110_AONCLK_APB_BUS          (JH7110_AONCLK_END + 5)
>> +#define JH7110_AONCLK_GMAC0_GTXCLK     (JH7110_AONCLK_END + 6)
>> +
>> +static const struct jh71x0_clk_data jh7110_aonclk_data[] = {
>> +       /* source */
>> +       JH71X0__DIV(JH7110_AONCLK_OSC_DIV4, "osc_div4", 4, JH7110_AONCLK_OSC),
>> +       JH71X0__MUX(JH7110_AONCLK_APB_FUNC, "apb_func", 2,
>> +                   JH7110_AONCLK_OSC_DIV4,
>> +                   JH7110_AONCLK_OSC),
>> +       /* gmac0 */
>> +       JH71X0_GATE(JH7110_AONCLK_GMAC0_AHB, "gmac0_ahb", 0, JH7110_AONCLK_STG_AXIAHB),
>> +       JH71X0_GATE(JH7110_AONCLK_GMAC0_AXI, "gmac0_axi", 0, JH7110_AONCLK_STG_AXIAHB),
>> +       JH71X0__DIV(JH7110_AONCLK_GMAC0_RMII_RTX, "gmac0_rmii_rtx", 30,
>> +                   JH7110_AONCLK_GMAC0_RMII_REFIN),
>> +       JH71X0_GMUX(JH7110_AONCLK_GMAC0_TX, "gmac0_tx", 0, 2,
>> +                   JH7110_AONCLK_GMAC0_GTXCLK,
>> +                   JH7110_AONCLK_GMAC0_RMII_RTX),
>> +       JH71X0__INV(JH7110_AONCLK_GMAC0_TX_INV, "gmac0_tx_inv", JH7110_AONCLK_GMAC0_TX),
>> +       JH71X0__MUX(JH7110_AONCLK_GMAC0_RX, "gmac0_rx", 2,
>> +                   JH7110_AONCLK_GMAC0_RGMII_RXIN,
>> +                   JH7110_AONCLK_GMAC0_RMII_RTX),
>> +       JH71X0__INV(JH7110_AONCLK_GMAC0_RX_INV, "gmac0_rx_inv", JH7110_AONCLK_GMAC0_RX),
>> +       /* otpc */
>> +       JH71X0_GATE(JH7110_AONCLK_OTPC_APB, "otpc_apb", CLK_IGNORE_UNUSED, JH7110_AONCLK_APB_BUS),
>> +       /* rtc */
>> +       JH71X0_GATE(JH7110_AONCLK_RTC_APB, "rtc_apb", CLK_IGNORE_UNUSED, JH7110_AONCLK_APB_BUS),
>> +       JH71X0__DIV(JH7110_AONCLK_RTC_INTERNAL, "rtc_internal", 1022, JH7110_AONCLK_OSC),
>> +       JH71X0__MUX(JH7110_AONCLK_RTC_32K, "rtc_32k", 2,
>> +                   JH7110_AONCLK_RTC_OSC,
>> +                   JH7110_AONCLK_RTC_INTERNAL),
>> +       JH71X0_GATE(JH7110_AONCLK_RTC_CAL, "rtc_cal", 0, JH7110_AONCLK_OSC),
>> +};
> 
> This list also contains instances of the CLK_IGNORE_UNUSED flag. Again
> please go through them and figure out which clocks are critical and
> which are fine to turn off when not used.

I had synchronized these clock flags with JH7110 SDK before and I will
recheck these flags. Thanks.

Best regards,
Hal
