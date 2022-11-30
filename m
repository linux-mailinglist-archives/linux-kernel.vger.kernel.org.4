Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE6363CFF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 08:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiK3HzD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Nov 2022 02:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiK3HzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 02:55:02 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD37A12AE2;
        Tue, 29 Nov 2022 23:54:59 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7A18A24E212;
        Wed, 30 Nov 2022 15:54:52 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 15:54:52 +0800
Received: from [192.168.125.96] (113.72.147.18) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 30 Nov
 2022 15:54:51 +0800
Message-ID: <7c5f2190-ca1e-4d73-66d6-62643d7b4e54@starfivetech.com>
Date:   Wed, 30 Nov 2022 15:54:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Content-Language: en-US
To:     Kevin Hilman <khilman@baylibre.com>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
 <7hedtvam03.fsf@baylibre.com>
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <7hedtvam03.fsf@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.147.18]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/11/22 8:09, Kevin Hilman wrote:
> Hi Walker,
> 
> Walker Chen <walker.chen@starfivetech.com> writes:
> 
>> Add generic power domain driver for the StarFive JH71XX SoC.
>>
>> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> 
> A bit more detail about the features power domain hardware would be
> helpful for reviewers.  I'm assuming there's no public documenation for
> this, but if there is, a link to that would be great also.
> 
> [...]
> 

OK, more detailed description will be added to commit message in the next version of patch.

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
>> +
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
> Where do these delay/timeout numbers come from?  Is this just based one
> experimentation, or is this something described by the HW docs.  Please
> add some comments.
>

Now the delay time is not accurate enough though the things can work normally.
It will be changed to more accurate value according to hardware feature.
 
>> +
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
>> +};
>> +
>> +static void __iomem *pmu_base;
>> +
>> +static inline void pmu_writel(u32 val, u32 offset)
>> +{
>> +	writel(val, pmu_base + offset);
>> +}
> 
> You use writel() in this helper, but __raw_writel() throughout the rest
> of the driver.  If that's intentional, you should explain a bit more
> about why.  If not, please make it consistent.
> 
> If you're going to use a wrapper/helper, you should use it throughout.
> But in this case, I'm not sure it's adding anything to readability.  In
> fact, it's only adding confusion since you don't use it for most of the
> register accesses.

Your suggestion will be taken seriously consider. Thanks.

> 
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
> This looks wrong.  Why are you allowing external users to power on/off the
> domains?  The sate of the domain should be managed by the PM core (and
> runtime PM use-counts etc.) allowing external users to change the domain
> state is going to lead to the PM core being confused about the state of
> the domain.
> 

These two functions are used by the GPU module. Only the power-off of the GPU is not controlled 
by the software through PMU module. So here the functions are needed to export. But according to
 the latest information, it seems that there is no open source plan for GPU. 
So the two functions will be drop in next version of patch.

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
> 
> Comparing an uninitialzed stack variable to 'on'?
> 

Sorry, indeed I missed several lines of code. It should be written like this:
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

>> +		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
>> +				pmd->genpd.name, on ? "en" : "dis");
> 
> Using dev_info() will probably make this a bit verbose.  I'd suggest
> dev_dbg() for this kind of message.
> 

Will fix.

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
>> +	__raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
>> +	__raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);
> 
> This "encourage" feature is peculiar.  What happens if you do not do
> this?  Does it take a lot longer for the domain to change state? or does
> it not change at all?  In the absence of HW specs, a bit of description
> here would be helpful.

There is need specific command sequence for controlling one power domain on JH7110 SoC. 
SW turn-on command sequence: Write the register Software encourage (offset 0x44) 0xff –> 0x05 –> 0x50
SW turn-off command sequence: Write the register Software encourage (offset 0x44) 0xff –> 0x0a –> 0xa0
More detailed comment will be added in next version.

> 
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
> 
> I don't think you need to spinlock in the interrupt itself, as
> interrupts will already be disabled, and this handler is not
> IRQF_SHARED.

Helpful suggestion, it will be fixed. thanks.

> 
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
> 
> [...]
> 
> Kevin

