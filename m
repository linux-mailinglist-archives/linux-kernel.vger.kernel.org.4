Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6632687BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjBBLK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjBBLKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:10:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824336597;
        Thu,  2 Feb 2023 03:09:57 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C7E7124E255;
        Thu,  2 Feb 2023 19:09:54 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 19:09:54 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Feb
 2023 19:09:53 +0800
Message-ID: <4529a646-1faf-c858-cfbe-1560ebeb1fba@starfivetech.com>
Date:   Thu, 2 Feb 2023 19:09:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <20221207131731.1291517-3-william.qiu@starfivetech.com>
 <CACRpkdYP7MokLdRtxX9w7p80c=wHDHsoTYWrU53CnpsZ7o6aGg@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CACRpkdYP7MokLdRtxX9w7p80c=wHDHsoTYWrU53CnpsZ7o6aGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/9 5:09, Linus Walleij wrote:
> Hi William,
> 
> thanks for your patch!
> 
> On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:
> 
>> Add sdio/emmc driver support for StarFive JH7110 soc.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> 
> (...)
>> +#include <linux/gpio.h>
> 
> Never include this legacy header in new code. Also: you don't use it.
> 
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/module.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
> 
> You're not using this include either.
> 
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
> 
> Or this.
> 
>> +#define ALL_INT_CLR            0x1ffff
>> +#define MAX_DELAY_CHAIN                32
>> +
>> +struct starfive_priv {
>> +       struct device *dev;
>> +       struct regmap *reg_syscon;
>> +       u32 syscon_offset;
>> +       u32 syscon_shift;
>> +       u32 syscon_mask;
>> +};
>> +
>> +static unsigned long dw_mci_starfive_caps[] = {
>> +       MMC_CAP_CMD23,
>> +       MMC_CAP_CMD23,
>> +       MMC_CAP_CMD23
>> +};
>> +
>> +static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> +{
>> +       int ret;
>> +       unsigned int clock;
>> +
>> +       if (ios->timing == MMC_TIMING_MMC_DDR52 || ios->timing == MMC_TIMING_UHS_DDR50) {
>> +               clock = (ios->clock > 50000000 && ios->clock <= 52000000) ? 100000000 : ios->clock;
>> +               ret = clk_set_rate(host->ciu_clk, clock);
>> +               if (ret)
>> +                       dev_dbg(host->dev, "Use an external frequency divider %uHz\n", ios->clock);
>> +               host->bus_hz = clk_get_rate(host->ciu_clk);
>> +       } else {
>> +               dev_dbg(host->dev, "Using the internal divider\n");
>> +       }
>> +}
>> +
>> +static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>> +                                            u32 opcode)
>> +{
>> +       static const int grade  = MAX_DELAY_CHAIN;
>> +       struct dw_mci *host = slot->host;
>> +       struct starfive_priv *priv = host->priv;
>> +       int raise_point = -1, fall_point = -1;
>> +       int err, prev_err = -1;
> 
> I don't like these default-init to -1. Can you just skip it and assign it
> where it makes most sense instead?
> 
>> +       int found = 0;
> 
> This looks like a bool.
> 
>> +       int i;
>> +       u32 regval;
>> +
>> +       for (i = 0; i < grade; i++) {
>> +               regval = i << priv->syscon_shift;
>> +               err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
>> +                                               priv->syscon_mask, regval);
>> +               if (err)
>> +                       return err;
>> +               mci_writel(host, RINTSTS, ALL_INT_CLR);
>> +
>> +               err = mmc_send_tuning(slot->mmc, opcode, NULL);
>> +               if (!err)
>> +                       found = 1;
>> +
>> +               if (i > 0) {
>> +                       if (err && !prev_err)
>> +                               fall_point = i - 1;
>> +                       if (!err && prev_err)
>> +                               raise_point = i;
>> +               }
>> +
>> +               if (raise_point != -1 && fall_point != -1)
>> +                       goto tuning_out;
> 
> There are just these raise point (shouldn't this be "rise_point" in proper
> english?) and fall point, this misses some comments explaining what is
> going on, the code is not intuitively eviden. Rise and fall of *what* for
> example.
> 
>> +
>> +               prev_err = err;
>> +               err = 0;
>> +       }
>> +
>> +tuning_out:
>> +       if (found) {
>> +               if (raise_point == -1)
>> +                       raise_point = 0;
>> +               if (fall_point == -1)
>> +                       fall_point = grade - 1;
>> +               if (fall_point < raise_point) {
>> +                       if ((raise_point + fall_point) >
>> +                           (grade - 1))
>> +                               i = fall_point / 2;
>> +                       else
>> +                               i = (raise_point + grade - 1) / 2;
>> +               } else {
>> +                       i = (raise_point + fall_point) / 2;
>> +               }
> 
> Likewise here, explain what grade is, refer to the eMMC spec if necessary.
> 
> (...)
>> +       ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
>> +                                               "starfive,sys-syscon", 3, 0, &args);
>> +       if (ret) {
>> +               dev_err(host->dev, "Failed to parse starfive,sys-syscon\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       priv->reg_syscon = syscon_node_to_regmap(args.np);
>> +       of_node_put(args.np);
>> +       if (IS_ERR(priv->reg_syscon))
>> +               return PTR_ERR(priv->reg_syscon);
>> +
>> +       priv->syscon_offset = args.args[0];
>> +       priv->syscon_shift  = args.args[1];
>> +       priv->syscon_mask   = args.args[2];
> 
> Why should these three things be in the device tree instead of being derived
> from the compatible-string or just plain hard-coded as #defines?
> I don't get it.
> 
Hi Linus,

I'm sorry to bother you, but as for the definition of syscon, after discussing with 
my colleagues, we think it is easier to distinguish SDIO0 and SDIO1 by defining it in
the device tree, and the code compatibility is better.

Best Regards
William Qiu
>> +static int dw_mci_starfive_probe(struct platform_device *pdev)
>> +{
>> +       return dw_mci_pltfm_register(pdev, &starfive_data);
>> +}
>> +
>> +static int dw_mci_starfive_remove(struct platform_device *pdev)
>> +{
>> +       return dw_mci_pltfm_remove(pdev);
>> +}
> 
> Can't you just assign dw_mci_pltfm_remove() to .remove?
> 
> Other than these things, the driver looks good!
> 
> Yours,
> Linus Walleij
