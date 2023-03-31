Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5F16D1C82
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjCaJek convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 05:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjCaJeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:34:10 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE071EA1A;
        Fri, 31 Mar 2023 02:33:37 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 550B524DB8C;
        Fri, 31 Mar 2023 17:33:27 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 17:33:27 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 31 Mar
 2023 17:33:26 +0800
Message-ID: <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>
Date:   Fri, 31 Mar 2023 17:33:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 2/4] mmc: starfive: Add sdio/emmc driver support
To:     Shengyu Qu <wiagn233@outlook.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-3-william.qiu@starfivetech.com>
 <TY3P286MB26115A8F90DAD2D7DA4DCBEB988B9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26115E6311132C791616D32B98889@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <TY3P286MB26115E6311132C791616D32B98889@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.0 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/29 0:08, Shengyu Qu wrote:
> Hello William,
> 
> Sorry for making noise about this, but seems deleted voltage swtich function
> 
> doesn't help about this. But there's still a problem about eMMC speed. Currently
> 
> only about 20MB/s maximum reading speed could be reached when using eMMC
> 
> on VF2, any idea about this?
> 
> Best regards,
> 
> Shengyu
> 
> 在 2023/3/28 0:01, Shengyu Qu 写道:
>> Hello William,
>>
>> I'm digging into downstream mmc driver these days and found a problem
>>
>> that current version mainline driver doesn't has a voltage switch function for
>>
>> it. Downstream older version has one but was deleted in this commit [1].
>>
>> It was deleted since vf2's SD slot doesn't have 1.8V input but commiter forgot
>>
>> that vf2's eMMC slot has a proper 1.8V input.
>>
>> So could you add voltage switch function for mainline? I've met a eMMC speed
>>
>> problem possibly due to it.
>>
>> Best regards,
>>
>> Shengyu
>>

Hi Shengyu,

Sorry for the late reply.

First of all, I will consider adding voltage switch function, but the implementation
method is to configure the pmic register configuration in dts, and the implementation
interface will use the voltage switch function in dw_mmc.c.

As for speed, the main reason for the low rate is the clock of JH7110 and the
associated IO driving strength, in this limit, the maximum reading speed I tested was
about 50Mb/s.

I will try to reproduce your problem and try to solve it. Thanks for suggestions.

Best regards,
William

>> [1] https://github.com/starfive-tech/linux/commit/8037d59091d276e74be38e5fafaaebe36eaa77e1
>>
>> 在 2023/2/15 19:32, William Qiu 写道:
>>> Add sdio/emmc driver support for StarFive JH7110 soc.
>>>
>>> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>> ---
>>>   MAINTAINERS                        |   6 +
>>>   drivers/mmc/host/Kconfig           |  10 ++
>>>   drivers/mmc/host/Makefile          |   1 +
>>>   drivers/mmc/host/dw_mmc-starfive.c | 186 +++++++++++++++++++++++++++++
>>>   4 files changed, 203 insertions(+)
>>>   create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 85e8f83161d7..644ac9479a6e 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -19640,6 +19640,12 @@ F: Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
>>>   F:    drivers/clk/starfive/clk-starfive-jh71*
>>>   F:    include/dt-bindings/clock/starfive?jh71*.h
>>>   +STARFIVE JH7110 MMC/SD/SDIO DRIVER
>>> +M:    William Qiu <william.qiu@starfivetech.com>
>>> +S:    Supported
>>> +F:    Documentation/devicetree/bindings/mmc/starfive*
>>> +F:    drivers/mmc/host/dw_mmc-starfive.c
>>> +
>>>   STARFIVE JH71X0 PINCTRL DRIVERS
>>>   M:    Emil Renner Berthing <kernel@esmil.dk>
>>>   M:    Jianlong Huang <jianlong.huang@starfivetech.com>
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index fb1062a6394c..b87262503403 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -871,6 +871,16 @@ config MMC_DW_ROCKCHIP
>>>         Synopsys DesignWare Memory Card Interface driver. Select this option
>>>         for platforms based on RK3066, RK3188 and RK3288 SoC's.
>>>   +config MMC_DW_STARFIVE
>>> +    tristate "StarFive specific extensions for Synopsys DW Memory Card Interface"
>>> +    depends on SOC_STARFIVE
>>> +    depends on MMC_DW
>>> +    select MMC_DW_PLTFM
>>> +    help
>>> +      This selects support for StarFive JH7110 SoC specific extensions to the
>>> +      Synopsys DesignWare Memory Card Interface driver. Select this option
>>> +      for platforms based on StarFive JH7110 SoC.
>>> +
>>>   config MMC_SH_MMCIF
>>>       tristate "SuperH Internal MMCIF support"
>>>       depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>> index 4e4ceb32c4b4..32c0e5564b9a 100644
>>> --- a/drivers/mmc/host/Makefile
>>> +++ b/drivers/mmc/host/Makefile
>>> @@ -56,6 +56,7 @@ obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
>>>   obj-$(CONFIG_MMC_DW_K3)        += dw_mmc-k3.o
>>>   obj-$(CONFIG_MMC_DW_PCI)    += dw_mmc-pci.o
>>>   obj-$(CONFIG_MMC_DW_ROCKCHIP)    += dw_mmc-rockchip.o
>>> +obj-$(CONFIG_MMC_DW_STARFIVE)    += dw_mmc-starfive.o
>>>   obj-$(CONFIG_MMC_SH_MMCIF)    += sh_mmcif.o
>>>   obj-$(CONFIG_MMC_JZ4740)    += jz4740_mmc.o
>>>   obj-$(CONFIG_MMC_VUB300)    += vub300.o
>>> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
>>> new file mode 100644
>>> index 000000000000..40f5969b07a6
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/dw_mmc-starfive.c
>>> @@ -0,0 +1,186 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * StarFive Designware Mobile Storage Host Controller Driver
>>> + *
>>> + * Copyright (c) 2022 StarFive Technology Co., Ltd.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/delay.h>
>>> +#include <linux/mfd/syscon.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regmap.h>
>>> +
>>> +#include "dw_mmc.h"
>>> +#include "dw_mmc-pltfm.h"
>>> +
>>> +#define ALL_INT_CLR        0x1ffff
>>> +#define MAX_DELAY_CHAIN        32
>>> +
>>> +struct starfive_priv {
>>> +    struct device *dev;
>>> +    struct regmap *reg_syscon;
>>> +    u32 syscon_offset;
>>> +    u32 syscon_shift;
>>> +    u32 syscon_mask;
>>> +};
>>> +
>>> +static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>> +{
>>> +    int ret;
>>> +    unsigned int clock;
>>> +
>>> +    if (ios->timing == MMC_TIMING_MMC_DDR52 || ios->timing == MMC_TIMING_UHS_DDR50) {
>>> +        clock = (ios->clock > 50000000 && ios->clock <= 52000000) ? 100000000 : ios->clock;
>>> +        ret = clk_set_rate(host->ciu_clk, clock);
>>> +        if (ret)
>>> +            dev_dbg(host->dev, "Use an external frequency divider %uHz\n", ios->clock);
>>> +        host->bus_hz = clk_get_rate(host->ciu_clk);
>>> +    } else {
>>> +        dev_dbg(host->dev, "Using the internal divider\n");
>>> +    }
>>> +}
>>> +
>>> +static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>>> +                         u32 opcode)
>>> +{
>>> +    static const int grade  = MAX_DELAY_CHAIN;
>>> +    struct dw_mci *host = slot->host;
>>> +    struct starfive_priv *priv = host->priv;
>>> +    int rise_point = -1, fall_point = -1;
>>> +    int err, prev_err;
>>> +    int i;
>>> +    bool found = 0;
>>> +    u32 regval;
>>> +
>>> +    /*
>>> +     * Use grade as the max delay chain, and use the rise_point and
>>> +     * fall_point to ensure the best sampling point of a data input
>>> +     * signals.
>>> +     */
>>> +    for (i = 0; i < grade; i++) {
>>> +        regval = i << priv->syscon_shift;
>>> +        err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>>> +                        priv->syscon_mask, regval);
>>> +        if (err)
>>> +            return err;
>>> +        mci_writel(host, RINTSTS, ALL_INT_CLR);
>>> +
>>> +        err = mmc_send_tuning(slot->mmc, opcode, NULL);
>>> +        if (!err)
>>> +            found = 1;
>>> +
>>> +        if (i > 0) {
>>> +            if (err && !prev_err)
>>> +                fall_point = i - 1;
>>> +            if (!err && prev_err)
>>> +                rise_point = i;
>>> +        }
>>> +
>>> +        if (rise_point != -1 && fall_point != -1)
>>> +            goto tuning_out;
>>> +
>>> +        prev_err = err;
>>> +        err = 0;
>>> +    }
>>> +
>>> +tuning_out:
>>> +    if (found) {
>>> +        if (rise_point == -1)
>>> +            rise_point = 0;
>>> +        if (fall_point == -1)
>>> +            fall_point = grade - 1;
>>> +        if (fall_point < rise_point) {
>>> +            if ((rise_point + fall_point) >
>>> +                (grade - 1))
>>> +                i = fall_point / 2;
>>> +            else
>>> +                i = (rise_point + grade - 1) / 2;
>>> +        } else {
>>> +            i = (rise_point + fall_point) / 2;
>>> +        }
>>> +
>>> +        regval = i << priv->syscon_shift;
>>> +        err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>>> +                        priv->syscon_mask, regval);
>>> +        if (err)
>>> +            return err;
>>> +        mci_writel(host, RINTSTS, ALL_INT_CLR);
>>> +
>>> +        dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
>>> +    } else {
>>> +        dev_err(host->dev, "No valid delay chain! use default\n");
>>> +        err = -EINVAL;
>>> +    }
>>> +
>>> +    mci_writel(host, RINTSTS, ALL_INT_CLR);
>>> +    return err;
>>> +}
>>> +
>>> +static int dw_mci_starfive_parse_dt(struct dw_mci *host)
>>> +{
>>> +    struct of_phandle_args args;
>>> +    struct starfive_priv *priv;
>>> +    int ret;
>>> +
>>> +    priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>>> +    if (!priv)
>>> +        return -ENOMEM;
>>> +
>>> +    ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
>>> +                        "starfive,sysreg", 3, 0, &args);
>>> +    if (ret) {
>>> +        dev_err(host->dev, "Failed to parse starfive,sysreg\n");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    priv->reg_syscon = syscon_node_to_regmap(args.np);
>>> +    of_node_put(args.np);
>>> +    if (IS_ERR(priv->reg_syscon))
>>> +        return PTR_ERR(priv->reg_syscon);
>>> +
>>> +    priv->syscon_offset = args.args[0];
>>> +    priv->syscon_shift  = args.args[1];
>>> +    priv->syscon_mask   = args.args[2];
>>> +
>>> +    host->priv = priv;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static const struct dw_mci_drv_data starfive_data = {
>>> +    .common_caps        = MMC_CAP_CMD23,
>>> +    .set_ios        = dw_mci_starfive_set_ios,
>>> +    .parse_dt        = dw_mci_starfive_parse_dt,
>>> +    .execute_tuning        = dw_mci_starfive_execute_tuning,
>>> +};
>>> +
>>> +static const struct of_device_id dw_mci_starfive_match[] = {
>>> +    { .compatible = "starfive,jh7110-mmc",
>>> +        .data = &starfive_data },
>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, dw_mci_starfive_match);
>>> +
>>> +static int dw_mci_starfive_probe(struct platform_device *pdev)
>>> +{
>>> +    return dw_mci_pltfm_register(pdev, &starfive_data);
>>> +}
>>> +
>>> +static struct platform_driver dw_mci_starfive_driver = {
>>> +    .probe = dw_mci_starfive_probe,
>>> +    .remove = dw_mci_pltfm_remove,
>>> +    .driver = {
>>> +        .name = "dwmmc_starfive",
>>> +        .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>> +        .of_match_table = dw_mci_starfive_match,
>>> +    },
>>> +};
>>> +module_platform_driver(dw_mci_starfive_driver);
>>> +
>>> +MODULE_DESCRIPTION("StarFive JH7110 Specific DW-MSHC Driver Extension");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:dwmmc_starfive");
