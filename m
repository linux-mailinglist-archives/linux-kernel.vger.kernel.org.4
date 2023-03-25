Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAE06C8F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCYPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjCYPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:54:58 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0471206D;
        Sat, 25 Mar 2023 08:54:48 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8BEAB24DC09;
        Sat, 25 Mar 2023 23:54:45 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 25 Mar
 2023 23:54:45 +0800
Received: from [172.16.16.231] (113.72.145.48) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 25 Mar
 2023 23:54:44 +0800
Message-ID: <c7bd699c-77fe-c01b-bbc6-be7ddc511a20@starfivetech.com>
Date:   Sat, 25 Mar 2023 23:54:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 13/21] clk: starfive: Add StarFive JH7110 system clock
 driver
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
References: <20230320103750.60295-1-hal.feng@starfivetech.com>
 <20230320103750.60295-14-hal.feng@starfivetech.com>
 <CAJM55Z_jY67-SUZm3PDRKQTXZS4BJ6jUTBKXMqMTNW5MTFXK_g@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CAJM55Z_jY67-SUZm3PDRKQTXZS4BJ6jUTBKXMqMTNW5MTFXK_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.48]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 15:39:54 +0100, Emil Renner Berthing wrote:
> On Mon, 20 Mar 2023 at 11:38, Hal Feng <hal.feng@starfivetech.com> wrote:
[...]
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> new file mode 100644
>> index 000000000000..f98a508969c3
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
>> @@ -0,0 +1,450 @@
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
>> +#include <dt-bindings/clock/starfive,jh7110-crg.h>
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
>> +#define JH7110_SYSCLK_PLL0_OUT                 (JH7110_SYSCLK_END + 9)
>> +#define JH7110_SYSCLK_PLL1_OUT                 (JH7110_SYSCLK_END + 10)
>> +#define JH7110_SYSCLK_PLL2_OUT                 (JH7110_SYSCLK_END + 11)
>> +
>> +static const struct jh71x0_clk_data jh7110_sysclk_data[] __initconst = {
>> +       /* root */
>> +       JH71X0__MUX(JH7110_SYSCLK_CPU_ROOT, "cpu_root", 2,
>> +                   JH7110_SYSCLK_OSC,
>> +                   JH7110_SYSCLK_PLL0_OUT),
>> +       JH71X0__DIV(JH7110_SYSCLK_CPU_CORE, "cpu_core", 7, JH7110_SYSCLK_CPU_ROOT),
[...]
>> +       /* qspi */
>> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_AHB, "qspi_ahb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_AHB1),
>> +       JH71X0_GATE(JH7110_SYSCLK_QSPI_APB, "qspi_apb", CLK_IGNORE_UNUSED, JH7110_SYSCLK_APB_BUS),
> 
> Hi Hal,
> 
> Thanks for going through clocks marked with CLK_IGNORE_UNUSED and
> either remove the flags or mark them as critical.. It seems you've
> missed these two though.

The QSPI module of JH7110 supported by Cadence, requires three
clocks (qspi_ahb, qspi_apb and qspi_ref), but the Cadence QSPI
driver only supports one clock. As the StarFive QSPI support
patches [1] had been accepted, I kept these two flags here.

[1] https://lore.kernel.org/all/20230302105221.197421-1-william.qiu@starfivetech.com/

> 
[...]
>> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-jh71x0.c
>> index b372083d11c3..a8c60630ae73 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
>> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.c
>> @@ -5,6 +5,7 @@
>>   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
>>   */
>>
>> +#include <linux/auxiliary_bus.h>
>>  #include <linux/clk-provider.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/device.h>
>> @@ -331,3 +332,52 @@ const struct clk_ops *starfive_jh71x0_clk_ops(u32 max)
>>         return &jh71x0_clk_inv_ops;
>>  }
>>  EXPORT_SYMBOL_GPL(starfive_jh71x0_clk_ops);
>> +
>> +#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
>> +
>> +static void jh7110_reset_unregister_adev(void *_adev)
>> +{
>> +       struct auxiliary_device *adev = _adev;
>> +
>> +       auxiliary_device_delete(adev);
>> +}
>> +
>> +static void jh7110_reset_adev_release(struct device *dev)
>> +{
>> +       struct auxiliary_device *adev = to_auxiliary_dev(dev);
>> +
>> +       auxiliary_device_uninit(adev);
>> +}
>> +
>> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>> +                                    const char *adev_name,
>> +                                    u32 adev_id)
>> +{
>> +       struct auxiliary_device *adev;
>> +       int ret;
>> +
>> +       adev = devm_kzalloc(priv->dev, sizeof(*adev), GFP_KERNEL);
>> +       if (!adev)
>> +               return -ENOMEM;
>> +
>> +       adev->name = adev_name;
>> +       adev->dev.parent = priv->dev;
>> +       adev->dev.release = jh7110_reset_adev_release;
>> +       adev->id = adev_id;
>> +
>> +       ret = auxiliary_device_init(adev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = auxiliary_device_add(adev);
>> +       if (ret) {
>> +               auxiliary_device_uninit(adev);
>> +               return ret;
>> +       }
>> +
>> +       return devm_add_action_or_reset(priv->dev,
>> +                                       jh7110_reset_unregister_adev, adev);
>> +}
>> +EXPORT_SYMBOL_GPL(jh7110_reset_controller_register);
>> +
>> +#endif
> 
> Hey, sorry for not noticing this before, but is there a reason these
> JH7110-specific functions must be added to the generic JH71x0 code?
> Can't they be added to the JH7110 SYSCRG driver, and then let the
> other CRG drivers depend on that (which they already do because of
> clock dependencies)?

It's ok to move these functions to clk-starfive-jh7110-sys.c. By the
way, could I still keep the declaration in clk-starfive-jh71x0.h?

Best regards,
Hal

> 
>> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> index 34bb11c72eb7..cfe69aabd65a 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
>> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> @@ -120,4 +120,12 @@ struct jh71x0_clk_priv {
>>
>>  const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
>>
>> +#if IS_ENABLED(CONFIG_CLK_STARFIVE_JH7110_SYS)
>> +
>> +int jh7110_reset_controller_register(struct jh71x0_clk_priv *priv,
>> +                                    const char *adev_name,
>> +                                    u32 adev_id);
>> +
>> +#endif
>> +
>>  #endif
>> --
>> 2.38.1
>>

