Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0096386FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 11:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKYKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 05:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKYKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 05:05:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8727FD8;
        Fri, 25 Nov 2022 02:05:12 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 431EE24E1F0;
        Fri, 25 Nov 2022 18:05:00 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 18:05:00 +0800
Received: from [192.168.125.96] (183.27.97.81) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 25 Nov
 2022 18:04:59 +0800
Message-ID: <95b05ac3-31a9-50dc-8eeb-eb3a9f883a6b@starfivetech.com>
Date:   Fri, 25 Nov 2022 18:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com> <Y3giSQ0YccyY2tVk@spud>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <Y3giSQ0YccyY2tVk@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.81]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/19 8:24, Conor Dooley wrote:
> Hey Walker,
> 
> On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:
>> Add generic power domain driver for the StarFive JH71XX SoC.
>> 
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
>> ---
>> diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
>> new file mode 100644
>> index 000000000000..2bbcc1397b15
>> --- /dev/null
>> +++ b/drivers/soc/starfive/Kconfig
>> @@ -0,0 +1,9 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +config JH71XX_PMU
>> +	bool "Support PMU for StarFive JH71XX Soc"
>> +	depends on PM && (SOC_STARFIVE || COMPILE_TEST)
> 
> `default SOC_STARFIVE` perhaps?

OK, 'default SOC_STARFIVE' will be added to the next line of 'depends on PM && (SOC_STARFIVE || COMPILE_TEST)'

> 
>> +	select PM_GENERIC_DOMAINS
>> +	help
>> +	  Say y here to enable power domain support.
>> +
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
>> index 000000000000..e6c0083d166e
>> --- /dev/null
>> +++ b/drivers/soc/starfive/jh71xx_pmu.c
>> @@ -0,0 +1,380 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * StarFive JH71XX Power Domain Controller Driver
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
>> +#include <dt-bindings/power/jh7110-power.h>
>>
>> +/* register offset */
>> +#define HW_EVENT_TURN_ON_MASK		0x04
>> +#define HW_EVENT_TURN_OFF_MASK		0x08
>> +#define SW_TURN_ON_POWER_MODE		0x0C
>> +#define SW_TURN_OFF_POWER_MODE		0x10
>> +#define SW_ENCOURAGE			0x44
>> +#define PMU_INT_MASK			0x48
>> +#define PCH_BYPASS			0x4C
>> +#define PCH_PSTATE			0x50
>> +#define PCH_TIMEOUT			0x54
>> +#define LP_TIMEOUT			0x58
>> +#define HW_TURN_ON_MODE			0x5C
>> +#define CURR_POWER_MODE			0x80
>> +#define PMU_EVENT_STATUS		0x88
>> +#define PMU_INT_STATUS			0x8C
>> +
>> +/* sw encourage cfg */
>> +#define SW_MODE_ENCOURAGE_EN_LO		0x05
>> +#define SW_MODE_ENCOURAGE_EN_HI		0x50
>> +#define SW_MODE_ENCOURAGE_DIS_LO	0x0A
>> +#define SW_MODE_ENCOURAGE_DIS_HI	0xA0
>> +#define SW_MODE_ENCOURAGE_ON		0xFF
>> +
>> +/* pmu int status */
>> +#define PMU_INT_SEQ_DONE		BIT(0)
>> +#define PMU_INT_HW_REQ			BIT(1)
>> +#define PMU_INT_SW_FAIL			GENMASK(3, 2)
>> +#define PMU_INT_HW_FAIL			GENMASK(5, 4)
>> +#define PMU_INT_PCH_FAIL		GENMASK(8, 6)
>> +#define PMU_INT_FAIL_MASK		(PMU_INT_SW_FAIL | \
>> +					PMU_INT_HW_FAIL | \
>> +					PMU_INT_PCH_FAIL)
>> +#define PMU_INT_ALL_MASK		(PMU_INT_SEQ_DONE | \
>> +					PMU_INT_HW_REQ | \
>> +					PMU_INT_FAIL_MASK)
>> +
>> +#define DELAY_US			10
>> +#define TIMEOUT_US			100000
> 
> Some JH71XX_PMU_ prefixes for the above, as I think Emil pointed out,
> would be great.

I will modify the name of macro according to your suggestions.

> 
>> +struct starfive_power_dev {
>> +	struct generic_pm_domain genpd;
>> +	struct starfive_pmu *power;
>> +	uint32_t mask;
>> +};
>> +
>> +struct starfive_pmu {
>> +	void __iomem *base;
>> +	spinlock_t lock;
>> +	int irq;
>> +	struct device *pdev;
>> +	struct starfive_power_dev *dev;
>> +	struct genpd_onecell_data genpd_data;
>> +	struct generic_pm_domain **genpd;
>> +};
>> +
>> +struct starfive_pmu_data {
>> +	const char * const name;
>> +	uint8_t bit;
>> +	unsigned int flags;
> 
> Generally, ordering pointers first in these structs would be nice.

These structs are referenced from drivers/soc/bcm/bcm63xx/bcm63xx-power.c

> 
>> +};
>> +
>> +static void __iomem *pmu_base;
>> +
>> +static inline void pmu_writel(u32 val, u32 offset)
>> +{
>> +	writel(val, pmu_base + offset);
>> +}
>> +
>> +void starfive_pmu_hw_event_turn_on(u32 mask)
>> +{
>> +	pmu_writel(mask, HW_EVENT_TURN_ON_MASK);
>> +}
>> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_on);
>> +
>> +void starfive_pmu_hw_event_turn_off(u32 mask)
>> +{
>> +	pmu_writel(mask, HW_EVENT_TURN_OFF_MASK);
>> +}
>> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_off);
> 
> Where are the users for these exports? Also, should they be exported as
> GPL?
> 
> Either way, what is the point of the extra layer of abstraction here
> around the writel()?

The two export functions are only prepared for GPU module. But accordint to
 the latest information, it seems that there is no open source plan for GPU. 
So the two functions will be drop in next version of patch.

> 
>> +static int starfive_pmu_get_state(struct starfive_power_dev *pmd, bool *is_on)
>> +{
>> +	struct starfive_pmu *pmu = pmd->power;
>> +
>> +	if (!pmd->mask) {
>> +		*is_on = false;
>> +		return -EINVAL;
>> +	}
>> +
>> +	*is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
> 
> Is there a specific reason that you are using the __raw variants here
> (and elsewhere) in the driver?

Will use unified function '__raw_readl' and '__raw_writel'

> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pmu_set_state(struct starfive_power_dev *pmd, bool on)
>> +{
>> +	struct starfive_pmu *pmu = pmd->power;
>> +	unsigned long flags;
>> +	uint32_t val;
>> +	uint32_t mode;
>> +	uint32_t encourage_lo;
>> +	uint32_t encourage_hi;
>> +	bool is_on;
>> +	int ret;
>> +
>> +	if (!pmd->mask)
>> +		return -EINVAL;
>> +
>> +	if (is_on == on) {
>> +		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
>> +				pmd->genpd.name, on ? "en" : "dis");
> 
> Am I missing something here: you've just declared is_on, so it must be
> false & therefore this check is all a little pointless? The check just
> becomes if (false == on) which I don't think is what you're going for
> here? Or did I miss something obvious?

Sorry, indeed I missed several lines of code. It should be witten like this:
	ret = jh71xx_pmu_get_state(pmd, &is_on);
        if (ret) {
                dev_dbg(pmu->pdev, "unable to get current state for %s\n",
                        pmd->genpd.name);
                return ret;
        }

        if (is_on == on) {
                dev_dbg(pmu->pdev, "pm domain [%s] is already %sable status.\n",
                        pmd->genpd.name, on ? "en" : "dis");
                return 0;
        }

> 
>> +		return 0;
>> +	}
>> +
>> +	spin_lock_irqsave(&pmu->lock, flags);
>> +
>> +	if (on) {
>> +		mode = SW_TURN_ON_POWER_MODE;
>> +		encourage_lo = SW_MODE_ENCOURAGE_EN_LO;
>> +		encourage_hi = SW_MODE_ENCOURAGE_EN_HI;
>> +	} else {
>> +		mode = SW_TURN_OFF_POWER_MODE;
>> +		encourage_lo = SW_MODE_ENCOURAGE_DIS_LO;
>> +		encourage_hi = SW_MODE_ENCOURAGE_DIS_HI;
>> +	}
>> +
>> +	__raw_writel(pmd->mask, pmu->base + mode);
>> +
>> +	/* write SW_ENCOURAGE to make the configuration take effect */
>> +	__raw_writel(SW_MODE_ENCOURAGE_ON, pmu->base + SW_ENCOURAGE);
> 
> Is register "sticky"? IOW, could you set it in probe and leave this mode
> always on? Or does it need to be set every time you want to use this
> feature?

These power domain registers need to be set by other module according to the specific situation. 
For example some power domains should be turned off via System PM mechanism when system goes to sleep, 
and then they are turned on when system resume.

> 
>> +	__raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
>> +	__raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);
>> +
>> +	spin_unlock_irqrestore(&pmu->lock, flags);
>> +
>> +	if (on) {
>> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
>> +						val & pmd->mask, DELAY_US,
>> +						TIMEOUT_US);
>> +		if (ret) {
>> +			dev_err(pmu->pdev, "%s: failed to power on\n", pmd->genpd.name);
>> +			return -ETIMEDOUT;
>> +		}
>> +	} else {
>> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
>> +						!(val & pmd->mask), DELAY_US,
>> +						TIMEOUT_US);
> 
> Could you not just decide the 3rd arg outside of the readl_poll..() and
> save on duplicating the wait logic here?

Seems that the readl_poll..() can only be called in two cases 
because the CURR_POWER_MODE register is read to val and then operation with mask every time.

> 
>> +		if (ret) {
>> +			dev_err(pmu->pdev, "%s: failed to power off\n", pmd->genpd.name);
>> +			return -ETIMEDOUT;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int starfive_pmu_on(struct generic_pm_domain *genpd)
>> +{
>> +	struct starfive_power_dev *pmd = container_of(genpd,
>> +		struct starfive_power_dev, genpd);
>> +
>> +	return starfive_pmu_set_state(pmd, true);
>> +}
>> +
>> +static int starfive_pmu_off(struct generic_pm_domain *genpd)
>> +{
>> +	struct starfive_power_dev *pmd = container_of(genpd,
>> +		struct starfive_power_dev, genpd);
>> +
>> +	return starfive_pmu_set_state(pmd, false);
>> +}
>> +
>> +static void starfive_pmu_int_enable(struct starfive_pmu *pmu, u32 mask, bool enable)
>> +{
>> +	u32 val = __raw_readl(pmu->base + PMU_INT_MASK);
>> +
>> +	if (enable)
>> +		val &= ~mask;
>> +	else
>> +		val |= mask;
>> +
>> +	__raw_writel(val, pmu->base + PMU_INT_MASK);
>> +}
>> +
>> +static irqreturn_t starfive_pmu_interrupt(int irq, void *data)
>> +{
>> +	struct starfive_pmu *pmu = data;
>> +	unsigned long flags;
>> +	u32 val;
>> +
>> +	spin_lock_irqsave(&pmu->lock, flags);
>> +	val = __raw_readl(pmu->base + PMU_INT_STATUS);
>> +
>> +	if (val & PMU_INT_SEQ_DONE)
>> +		dev_dbg(pmu->pdev, "sequence done.\n");
>> +	if (val & PMU_INT_HW_REQ)
>> +		dev_dbg(pmu->pdev, "hardware encourage requestion.\n");
>> +	if (val & PMU_INT_SW_FAIL)
>> +		dev_err(pmu->pdev, "software encourage fail.\n");
>> +	if (val & PMU_INT_HW_FAIL)
>> +		dev_err(pmu->pdev, "hardware encourage fail.\n");
>> +	if (val & PMU_INT_PCH_FAIL)
>> +		dev_err(pmu->pdev, "p-channel fail event.\n");
>> +
>> +	/* clear interrupts */
>> +	__raw_writel(val, pmu->base + PMU_INT_STATUS);
>> +	__raw_writel(val, pmu->base + PMU_EVENT_STATUS);
>> +
>> +	spin_unlock_irqrestore(&pmu->lock, flags);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int starfive_pmu_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	const struct starfive_pmu_data *entry, *table;
>> +	struct starfive_pmu *pmu;
>> +	unsigned int i;
>> +	uint8_t max_bit = 0;
>> +	int ret;
>> +
>> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
>> +	if (!pmu)
>> +		return -ENOMEM;
>> +
>> +	pmu_base = pmu->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(pmu->base))
>> +		return PTR_ERR(pmu->base);
>> +
>> +	/* initialize pmu interrupt  */
>> +	pmu->irq = platform_get_irq(pdev, 0);
>> +	if (pmu->irq < 0)
>> +		return pmu->irq;
>> +
>> +	ret = devm_request_irq(dev, pmu->irq, starfive_pmu_interrupt,
>> +			       0, pdev->name, pmu);
>> +	if (ret)
>> +		dev_err(dev, "request irq failed.\n");
>> +
>> +	table = of_device_get_match_data(dev);
>> +	if (!table)
>> +		return -EINVAL;
>> +
>> +	pmu->pdev = dev;
>> +	pmu->genpd_data.num_domains = 0;
>> +	i = 0;
>> +	for (entry = table; entry->name; entry++) {
>> +		max_bit = max(max_bit, entry->bit);
>> +		i++;
>> +	}
> 
> This looks like something that could be replaced by the functions in
> linux/list.h, no? Same below.

Nowadays other platforms on linux mainline mostly write in this way or write like this: 
	for (i = 0; i < num; i++) {
		...
		pm_genpd_init(&pmd[i]->genpd, NULL, !is_on);
	}

> 
>> +
>> +	if (!i)
>> +		return -ENODEV;
>> +
>> +	pmu->genpd_data.num_domains = max_bit + 1;
>> +
>> +	pmu->dev = devm_kcalloc(dev, pmu->genpd_data.num_domains,
>> +				  sizeof(struct starfive_power_dev),
>> +				  GFP_KERNEL);
>> +	if (!pmu->dev)
>> +		return -ENOMEM;
>> +
>> +	pmu->genpd = devm_kcalloc(dev, pmu->genpd_data.num_domains,
>> +				    sizeof(struct generic_pm_domain *),
>> +				    GFP_KERNEL);
> 
> This two allocations both look like checkpatch would whinge about their
> alignment.

Yes, I will adjust these alignment. Thank you for your remind.

> 
>> +	if (!pmu->genpd)
>> +		return -ENOMEM;
>> +
>> +	pmu->genpd_data.domains = pmu->genpd;
>> +
>> +	i = 0;
>> +	for (entry = table; entry->name; entry++) {
>> +		struct starfive_power_dev *pmd = &pmu->dev[i];
>> +		bool is_on;
>> +
>> +		pmd->power = pmu;
>> +		pmd->mask = BIT(entry->bit);
>> +		pmd->genpd.name = entry->name;
>> +		pmd->genpd.flags = entry->flags;
>> +
>> +		ret = starfive_pmu_get_state(pmd, &is_on);
>> +		if (ret)
>> +			dev_warn(dev, "unable to get current state for %s\n",
>> +				 pmd->genpd.name);
> 
> In what scenario would it not be possible to get the state? Again, I
> hope I'm not missing something obvious. From what I can see, this is the
> only caller of starfive_pmu_get_state(), which looks like:
>> > +	struct starfive_pmu *pmu = pmd->power;
>> > +
>> > +	if (!pmd->mask) {

> How can !pmd->mask evaluate to true, given it's just been set to BIT(n)?
> 
>> > +		*is_on = false;
>> > +		return -EINVAL;
>> > +	}
>> > +
>> > +	*is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
>> > +
>> > +	return 0;
> 
> If I've not missed something, looks like you could likely remove the
> function and just do the readl() here?

I will modify the code like this:
static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, bool on)
{
	int ret;
	...
	
	ret = jh71xx_pmu_get_state(pmd, &is_on);
	if (ret) {
		dev_dbg(pmu->pdev, "unable to get current state for %s\n",
			pmd->genpd.name);
		return ret;
	}

	if (is_on == on) {
		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
			 pmd->genpd.name, on ? "en" : "dis");
		return 0;
	}
	...
}

This place where jh71xx_pmu_get_state() is called will return and then can not set the state 
for power domain if pmd->mask is missed to assign a value.

> 
>> +
>> +		pmd->genpd.power_on = starfive_pmu_on;
>> +		pmd->genpd.power_off = starfive_pmu_off;
>> +
>> +		pm_genpd_init(&pmd->genpd, NULL, !is_on);
>> +		pmu->genpd[entry->bit] = &pmd->genpd;
>> +
>> +		i++;
>> +	}
>> +
>> +	spin_lock_init(&pmu->lock);
>> +	starfive_pmu_int_enable(pmu, PMU_INT_ALL_MASK & ~PMU_INT_PCH_FAIL, true);
>> +
>> +	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register genpd driver: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "registered %u power domains\n", i);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct starfive_pmu_data jh7110_power_domains[] = {
> 
> Is this driver jh7110 only or actually jh71XX? Have you just started out
> by implementing one SoC both intend to support both?

JH7110 is our first SoC, probably the next generation of SoC jh7120 still use this controller driver.
Maybe now the naming for JH71XX is not very suitable.

> 
>> +	{
>> +		.name = "SYSTOP",
>> +		.bit = JH7110_PD_SYSTOP,
>> +		.flags = GENPD_FLAG_ALWAYS_ON,
>> +	}, {
>> +		.name = "CPU",
>> +		.bit = JH7110_PD_CPU,
>> +		.flags = GENPD_FLAG_ALWAYS_ON,
>> +	}, {
>> +		.name = "GPUA",
>> +		.bit = JH7110_PD_GPUA,
>> +	}, {
>> +		.name = "VDEC",
>> +		.bit = JH7110_PD_VDEC,
>> +	}, {
>> +		.name = "VOUT",
>> +		.bit = JH7110_PD_VOUT,
>> +	}, {
>> +		.name = "ISP",
>> +		.bit = JH7110_PD_ISP,
>> +	}, {
>> +		.name = "VENC",
>> +		.bit = JH7110_PD_VENC,
>> +	}, {
>> +		.name = "GPUB",
>> +		.bit = JH7110_PD_GPUB,
>> +	}, {
>> +		/* sentinel */
>> +	},
> 
> Can drop this , after the sentinel ;)
> 
> I don't know /jack/ about power domain stuff, so I can barely review
> this at all sadly.
> Thanks,
> Conor.

Thank you for taking the time to review the code, you helped me a lot. Thank you so much.

Best Regards,
Walker Chen

