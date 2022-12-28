Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7149E657200
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 03:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiL1CJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 21:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiL1CJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 21:09:08 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8A6E15;
        Tue, 27 Dec 2022 18:09:05 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 73AA024E00A;
        Wed, 28 Dec 2022 10:08:57 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 28 Dec
 2022 10:08:57 +0800
Received: from [192.168.125.71] (113.72.146.158) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 28 Dec
 2022 10:08:56 +0800
Message-ID: <83899ba9-dff0-a678-e319-565101f71157@starfivetech.com>
Date:   Wed, 28 Dec 2022 10:08:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [RESEND PATCH v2 2/3] soc: starfive: Add StarFive JH71XX pmu
 driver
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-3-walker.chen@starfivetech.com> <Y6DMQpGuXfBWHr8L@spud>
Content-Language: en-US
In-Reply-To: <Y6DMQpGuXfBWHr8L@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.158]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/20 4:40, Conor Dooley wrote:
> Hey Walker,
> 
> Hopefully just some minor bits here. Hopefully either Emil who has a
> board, or someone that knows power management stuff better can give this
> a proper review.
> 
> On Thu, Dec 08, 2022 at 04:45:22PM +0800, Walker Chen wrote:
>> Add pmu driver for the StarFive JH71XX SoC.
>> 
>> As the power domains provider, the Power Management Unit (PMU) is
>> designed for including multiple PM domains that can be used for power
>> gating of selected IP blocks for power saving by reduced leakage
>> current. It accepts software encourage command to switch the power mode
>> of SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>>  MAINTAINERS                       |  14 ++
>>  drivers/soc/Kconfig               |   1 +
>>  drivers/soc/Makefile              |   1 +
>>  drivers/soc/starfive/Kconfig      |  11 +
>>  drivers/soc/starfive/Makefile     |   3 +
>>  drivers/soc/starfive/jh71xx_pmu.c | 396 ++++++++++++++++++++++++++++++
>>  6 files changed, 426 insertions(+)
>>  create mode 100644 drivers/soc/starfive/Kconfig
>>  create mode 100644 drivers/soc/starfive/Makefile
>>  create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
>> 
> 
>> +config JH71XX_PMU
>> +	bool "Support PMU for StarFive JH71XX Soc"
>> +	depends on PM && (SOC_STARFIVE || COMPILE_TEST)
> 
> Why not just do:
> 	depends on PM
> 	depends on SOC_STARFIVE || COMPILE_TEST
> I think that way reads a little better.

No problem, will be changed like this way.

> 
>> +	default SOC_STARFIVE
>> +	select PM_GENERIC_DOMAINS
>> +	help
>> +	  Say 'y' here to enable support power domain support.
>> +	  In order to meet low power requirements, a Power Management Unit (PMU)
>> +	  is designed for controlling power resources in StarFive JH71XX SoCs.
>> diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
>> new file mode 100644
>> index 000000000000..13b589d6b5f3
>> --- /dev/null
>> +++ b/drivers/soc/starfive/Makefile
>> @@ -0,0 +1,3 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_JH71XX_PMU)	+= jh71xx_pmu.o
>> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
>> new file mode 100644
>> index 000000000000..7a0145779e07
>> --- /dev/null
>> +++ b/drivers/soc/starfive/jh71xx_pmu.c
>> @@ -0,0 +1,396 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * StarFive JH71XX PMU (Power Management Unit) Controller Driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_domain.h>
>> +#include <dt-bindings/power/starfive,jh7110-pmu.h>
>> +
>> +/* register offset */
>> +#define JH71XX_PMU_HW_EVENT_ON		0x04
>> +#define JH71XX_PMU_HW_EVENT_OFF		0x08
>> +#define JH71XX_PMU_SW_TURN_ON_POWER	0x0C
>> +#define JH71XX_PMU_SW_TURN_OFF_POWER	0x10
>> +#define JH71XX_PMU_SW_ENCOURAGE		0x44
>> +#define JH71XX_PMU_INT_MASK		0x48
>> +#define JH71XX_PMU_PCH_BYPASS		0x4C
>> +#define JH71XX_PMU_PCH_PSTATE		0x50
>> +#define JH71XX_PMU_PCH_TIMEOUT		0x54
>> +#define JH71XX_PMU_LP_TIMEOUT		0x58
>> +#define JH71XX_PMU_HW_TURN_ON		0x5C
>> +#define JH71XX_PMU_CURR_POWER_MODE	0x80
>> +#define JH71XX_PMU_EVENT_STATUS		0x88
>> +#define JH71XX_PMU_INT_STATUS		0x8C
>> +
>> +/* sw encourage cfg */
>> +#define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
>> +#define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
>> +#define JH71XX_PMU_SW_ENCOURAGE_DIS_LO	0x0A
>> +#define JH71XX_PMU_SW_ENCOURAGE_DIS_HI	0xA0
>> +#define JH71XX_PMU_SW_ENCOURAGE_ON	0xFF
>> +
>> +/* pmu int status */
>> +#define JH71XX_PMU_INT_SEQ_DONE		BIT(0)
>> +#define JH71XX_PMU_INT_HW_REQ		BIT(1)
>> +#define JH71XX_PMU_INT_SW_FAIL		GENMASK(3, 2)
>> +#define JH71XX_PMU_INT_HW_FAIL		GENMASK(5, 4)
>> +#define JH71XX_PMU_INT_PCH_FAIL		GENMASK(8, 6)
>> +#define JH71XX_PMU_INT_FAIL_MASK	(JH71XX_PMU_INT_SW_FAIL | \
>> +					JH71XX_PMU_INT_HW_FAIL | \
>> +					JH71XX_PMU_INT_PCH_FAIL)
>> +#define JH71XX_PMU_INT_ALL_MASK		(JH71XX_PMU_INT_SEQ_DONE | \
>> +					JH71XX_PMU_INT_HW_REQ | \
>> +					JH71XX_PMU_INT_FAIL_MASK)
>> +
>> +/*
>> + * The time required for switching power status is based on the time
>> + * to turn on the largest domain's power, which is at microsecond level
>> + */
>> +#define JH71XX_PMU_TIMEOUT_US		100
>> +
>> +struct jh71xx_domain_info {
> 
> 	const char * const name;
> 	unsigned int flags;
> 	u8 bit;
> 
>> +};
>> +
>> +struct jh71xx_pmu_match_data {
> 
> 	const struct jh71xx_domain_info *domain_info;
> 	int num_domains;
> 
> Can you switch these two around like so?

Should be no problem.

>> +};
>> +
>> +struct jh71xx_pmu {
>> +	struct device *dev;
>> +	const struct jh71xx_pmu_match_data *match_data;
>> +	void __iomem *base;
>> +	spinlock_t lock;	/* protects pmu reg */
>> +	int irq;
>> +	struct genpd_onecell_data genpd_data;
>> +	struct generic_pm_domain **genpd;
>> +};
>> +
>> +struct jh71xx_pmu_dev {
>> +	struct generic_pm_domain genpd;
>> +	const struct jh71xx_domain_info *domain_info;
>> +	struct jh71xx_pmu *pmu;
> 
> And these two too please in the same way.

Nice :)

> 
>> +};
>> +
>> +static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
>> +{
>> +	struct jh71xx_pmu *pmu = pmd->pmu;
>> +
>> +	if (!mask) {
>> +		*is_on = false;
>> +		return -EINVAL;
>> +	}
>> +
>> +	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
>> +
>> +	return 0;
>> +}
>> +
>> +static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
>> +{
>> +	struct jh71xx_pmu *pmu = pmd->pmu;
>> +	unsigned long flags;
>> +	u32 val;
>> +	u32 mode;
>> +	u32 encourage_lo;
>> +	u32 encourage_hi;
>> +	bool is_on;
>> +	int ret;
>> +
>> +	ret = jh71xx_pmu_get_state(pmd, mask, &is_on);
>> +	if (ret) {
>> +		dev_dbg(pmu->dev, "unable to get current state for %s\n",
>> +			pmd->genpd.name);
>> +		return ret;
>> +	}
>> +
>> +	if (is_on == on) {
>> +		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
>> +			pmd->genpd.name, on ? "en" : "dis");
>> +		return 0;
>> +	}
>> +
>> +	spin_lock_irqsave(&pmu->lock, flags);
>> +
>> +	/*
>> +	 * The PMU accepts software encourage to switch power mode in the following 2 steps:
>> +	 *
>> +	 * 1. Configure the register SW_TURN_ON_POWER (offset 0x0c), write 1 to
>> +	 *    the bit which power domain will be turn-on, write 0 to the others.
> 
> Some grammatical nit picking..
> 
> "Configure the register blah (offset 0x0c) by writing 1 to the bit
> corresponding to the power domain that will be turned on and writing
> zero to the others."
> 
> Is that a correct correct summation of the operation?

Yes, maybe your description is better easy-to-understand.

> 
>> +	 *    Likewise, configure the register SW_TURN_OFF_POWER (offset 0x10),
>> +	 *    write 1 to the bit which power domain will be turn-off, write 0 to the others.
> 
> 
>> +	 */
>> +	if (on) {
>> +		mode = JH71XX_PMU_SW_TURN_ON_POWER;
>> +		encourage_lo = JH71XX_PMU_SW_ENCOURAGE_EN_LO;
>> +		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_EN_HI;
>> +	} else {
>> +		mode = JH71XX_PMU_SW_TURN_OFF_POWER;
>> +		encourage_lo = JH71XX_PMU_SW_ENCOURAGE_DIS_LO;
>> +		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_DIS_HI;
>> +	}
>> +
>> +	writel(mask, pmu->base + mode);
>> +
>> +	/*
>> +	 * 2. Write SW encourage command sequence to the Software Encourage Reg (offset 0x44)
>> +	 * SW turn-on command sequence: 0xff -> 0x05 -> 0x50
>> +	 * SW turn-off command sequence: 0xff -> 0x0a -> 0xa0
> 
> I think you could replace the hard "coded" numbers here with a better
> description idk without looking at the #defines above what these
> correspond to. AFAICT, it'd be something like:
> First write the ...ENCOURAGE_ON to reset the state machine which parses
> the command sequence. It must be written every time.
> Then write the lower bits of the command sequence, followed by the upper
> bits. The sequence differs between powering on & off a domain.

Thank you for correction for these description. Because English is not my native language,
so not very good in some sentences. I'll take your advice.

>> +	 *
>> +	 * Note: writing SW_MODE_ENCOURAGE_ON (0xFF) to the SW_ENCOURAGE register,
>> +	 * the purpose is to reset the state machine which is going to parse instruction
>> +	 *  sequence. It has to be written every time.
>> +	 */
>> +	writel(JH71XX_PMU_SW_ENCOURAGE_ON, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> +	writel(encourage_lo, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> +	writel(encourage_hi, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
>> +
>> +	spin_unlock_irqrestore(&pmu->lock, flags);
>> +
>> +	/* Wait for the power domain bit to be enabled / disabled */
>> +	if (on) {
>> +		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
>> +						val, val & mask,
>> +						1, JH71XX_PMU_TIMEOUT_US);
>> +	} else {
>> +		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
>> +						val, !(val & mask),
>> +						1, JH71XX_PMU_TIMEOUT_US);
>> +	}
>> +
>> +	if (ret) {
>> +		dev_err(pmu->dev, "%s: failed to power %s\n",
>> +			pmd->genpd.name, on ? "on" : "off");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
> 
>> +static int jh71xx_pmu_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	const struct jh71xx_pmu_match_data *match_data;
>> +	struct jh71xx_pmu *pmu;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
>> +	if (!pmu)
>> +		return -ENOMEM;
>> +
>> +	pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pmu->base))
>> +		return PTR_ERR(pmu->base);
>> +
>> +	/* initialize pmu interrupt  */
> 
> nit: this comment is ~pointless.

Will be dropped.

> 
>> +	pmu->irq = platform_get_irq(pdev, 0);
>> +	if (pmu->irq < 0)
>> +		return pmu->irq;
>> +
>> +	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
>> +			       0, pdev->name, pmu);
>> +	if (ret)
>> +		dev_err(dev, "request irq failed.\n");
> 
> nit: s/request/requesting

Will be fixed.

> 
> Unfortunately I cannot really review the rest of this, but hopefully
> I'll get a board soon and can try it out - or else send me a link to
> your TRM or w/e.

Anyway, I would like to thank you very much for your time.


Best regards,
Walker

