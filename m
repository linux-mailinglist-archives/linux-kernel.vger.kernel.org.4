Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D6630871
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiKSBY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKSBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:23:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB7B8FB5;
        Fri, 18 Nov 2022 16:24:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97128B825A8;
        Sat, 19 Nov 2022 00:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63804C433C1;
        Sat, 19 Nov 2022 00:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668817486;
        bh=KaU5uebjFfdiCUdlT1dXOUKWD7RAvv5aIc1NdLxgItQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYSP99YyvNAGmZTfxB5OgFklog411FGjGqQ4JXoD2Z6IwWTg76X7DO68r09AZd5j6
         cLtvWEdV5kKQtyesCXQlLS1z/TknFqiz4Ahmu5cGUtMtlkeeedtK4sEOkH4+auz6NM
         Pa7rzGGTOYZSu0pQ4qstOzUlXhHrRL9R41uK4Fk9HKqpH1mRtwsns67vzE/zBZQ7aP
         ou74CuCgPiPRbzBJMACavrfx36aztsBWDOYeno4hgbN4EPBDLduZUI6p+93D6K6Mjt
         GxqeQV+cKij6mzud9jrAFukN5n2q/xXh6jCZEABEtOzaXf1J6Q2k9oRXMSBtqbtH02
         N0ZvezQCulZ4g==
Date:   Sat, 19 Nov 2022 00:24:41 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
Message-ID: <Y3giSQ0YccyY2tVk@spud>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118133216.17037-4-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Walker,

On Fri, Nov 18, 2022 at 09:32:15PM +0800, Walker Chen wrote:
> Add generic power domain driver for the StarFive JH71XX SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
> diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
> new file mode 100644
> index 000000000000..2bbcc1397b15
> --- /dev/null
> +++ b/drivers/soc/starfive/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config JH71XX_PMU
> +	bool "Support PMU for StarFive JH71XX Soc"
> +	depends on PM && (SOC_STARFIVE || COMPILE_TEST)

`default SOC_STARFIVE` perhaps?

> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say y here to enable power domain support.
> +
> diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
> new file mode 100644
> index 000000000000..13b589d6b5f3
> --- /dev/null
> +++ b/drivers/soc/starfive/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_JH71XX_PMU)	+= jh71xx_pmu.o
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
> new file mode 100644
> index 000000000000..e6c0083d166e
> --- /dev/null
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -0,0 +1,380 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * StarFive JH71XX Power Domain Controller Driver
> + *
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <dt-bindings/power/jh7110-power.h>
>
> +/* register offset */
> +#define HW_EVENT_TURN_ON_MASK		0x04
> +#define HW_EVENT_TURN_OFF_MASK		0x08
> +#define SW_TURN_ON_POWER_MODE		0x0C
> +#define SW_TURN_OFF_POWER_MODE		0x10
> +#define SW_ENCOURAGE			0x44
> +#define PMU_INT_MASK			0x48
> +#define PCH_BYPASS			0x4C
> +#define PCH_PSTATE			0x50
> +#define PCH_TIMEOUT			0x54
> +#define LP_TIMEOUT			0x58
> +#define HW_TURN_ON_MODE			0x5C
> +#define CURR_POWER_MODE			0x80
> +#define PMU_EVENT_STATUS		0x88
> +#define PMU_INT_STATUS			0x8C
> +
> +/* sw encourage cfg */
> +#define SW_MODE_ENCOURAGE_EN_LO		0x05
> +#define SW_MODE_ENCOURAGE_EN_HI		0x50
> +#define SW_MODE_ENCOURAGE_DIS_LO	0x0A
> +#define SW_MODE_ENCOURAGE_DIS_HI	0xA0
> +#define SW_MODE_ENCOURAGE_ON		0xFF
> +
> +/* pmu int status */
> +#define PMU_INT_SEQ_DONE		BIT(0)
> +#define PMU_INT_HW_REQ			BIT(1)
> +#define PMU_INT_SW_FAIL			GENMASK(3, 2)
> +#define PMU_INT_HW_FAIL			GENMASK(5, 4)
> +#define PMU_INT_PCH_FAIL		GENMASK(8, 6)
> +#define PMU_INT_FAIL_MASK		(PMU_INT_SW_FAIL | \
> +					PMU_INT_HW_FAIL | \
> +					PMU_INT_PCH_FAIL)
> +#define PMU_INT_ALL_MASK		(PMU_INT_SEQ_DONE | \
> +					PMU_INT_HW_REQ | \
> +					PMU_INT_FAIL_MASK)
> +
> +#define DELAY_US			10
> +#define TIMEOUT_US			100000

Some JH71XX_PMU_ prefixes for the above, as I think Emil pointed out,
would be great.

> +struct starfive_power_dev {
> +	struct generic_pm_domain genpd;
> +	struct starfive_pmu *power;
> +	uint32_t mask;
> +};
> +
> +struct starfive_pmu {
> +	void __iomem *base;
> +	spinlock_t lock;
> +	int irq;
> +	struct device *pdev;
> +	struct starfive_power_dev *dev;
> +	struct genpd_onecell_data genpd_data;
> +	struct generic_pm_domain **genpd;
> +};
> +
> +struct starfive_pmu_data {
> +	const char * const name;
> +	uint8_t bit;
> +	unsigned int flags;

Generally, ordering pointers first in these structs would be nice.

> +};
> +
> +static void __iomem *pmu_base;
> +
> +static inline void pmu_writel(u32 val, u32 offset)
> +{
> +	writel(val, pmu_base + offset);
> +}
> +
> +void starfive_pmu_hw_event_turn_on(u32 mask)
> +{
> +	pmu_writel(mask, HW_EVENT_TURN_ON_MASK);
> +}
> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_on);
> +
> +void starfive_pmu_hw_event_turn_off(u32 mask)
> +{
> +	pmu_writel(mask, HW_EVENT_TURN_OFF_MASK);
> +}
> +EXPORT_SYMBOL(starfive_pmu_hw_event_turn_off);

Where are the users for these exports? Also, should they be exported as
GPL?

Either way, what is the point of the extra layer of abstraction here
around the writel()?

> +static int starfive_pmu_get_state(struct starfive_power_dev *pmd, bool *is_on)
> +{
> +	struct starfive_pmu *pmu = pmd->power;
> +
> +	if (!pmd->mask) {
> +		*is_on = false;
> +		return -EINVAL;
> +	}
> +
> +	*is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;

Is there a specific reason that you are using the __raw variants here
(and elsewhere) in the driver?

> +
> +	return 0;
> +}
> +
> +static int starfive_pmu_set_state(struct starfive_power_dev *pmd, bool on)
> +{
> +	struct starfive_pmu *pmu = pmd->power;
> +	unsigned long flags;
> +	uint32_t val;
> +	uint32_t mode;
> +	uint32_t encourage_lo;
> +	uint32_t encourage_hi;
> +	bool is_on;
> +	int ret;
> +
> +	if (!pmd->mask)
> +		return -EINVAL;
> +
> +	if (is_on == on) {
> +		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
> +				pmd->genpd.name, on ? "en" : "dis");

Am I missing something here: you've just declared is_on, so it must be
false & therefore this check is all a little pointless? The check just
becomes if (false == on) which I don't think is what you're going for
here? Or did I miss something obvious?

> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&pmu->lock, flags);
> +
> +	if (on) {
> +		mode = SW_TURN_ON_POWER_MODE;
> +		encourage_lo = SW_MODE_ENCOURAGE_EN_LO;
> +		encourage_hi = SW_MODE_ENCOURAGE_EN_HI;
> +	} else {
> +		mode = SW_TURN_OFF_POWER_MODE;
> +		encourage_lo = SW_MODE_ENCOURAGE_DIS_LO;
> +		encourage_hi = SW_MODE_ENCOURAGE_DIS_HI;
> +	}
> +
> +	__raw_writel(pmd->mask, pmu->base + mode);
> +
> +	/* write SW_ENCOURAGE to make the configuration take effect */
> +	__raw_writel(SW_MODE_ENCOURAGE_ON, pmu->base + SW_ENCOURAGE);

Is register "sticky"? IOW, could you set it in probe and leave this mode
always on? Or does it need to be set every time you want to use this
feature?

> +	__raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
> +	__raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);
> +
> +	spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	if (on) {
> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> +						val & pmd->mask, DELAY_US,
> +						TIMEOUT_US);
> +		if (ret) {
> +			dev_err(pmu->pdev, "%s: failed to power on\n", pmd->genpd.name);
> +			return -ETIMEDOUT;
> +		}
> +	} else {
> +		ret = readl_poll_timeout_atomic(pmu->base + CURR_POWER_MODE, val,
> +						!(val & pmd->mask), DELAY_US,
> +						TIMEOUT_US);

Could you not just decide the 3rd arg outside of the readl_poll..() and
save on duplicating the wait logic here?

> +		if (ret) {
> +			dev_err(pmu->pdev, "%s: failed to power off\n", pmd->genpd.name);
> +			return -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int starfive_pmu_on(struct generic_pm_domain *genpd)
> +{
> +	struct starfive_power_dev *pmd = container_of(genpd,
> +		struct starfive_power_dev, genpd);
> +
> +	return starfive_pmu_set_state(pmd, true);
> +}
> +
> +static int starfive_pmu_off(struct generic_pm_domain *genpd)
> +{
> +	struct starfive_power_dev *pmd = container_of(genpd,
> +		struct starfive_power_dev, genpd);
> +
> +	return starfive_pmu_set_state(pmd, false);
> +}
> +
> +static void starfive_pmu_int_enable(struct starfive_pmu *pmu, u32 mask, bool enable)
> +{
> +	u32 val = __raw_readl(pmu->base + PMU_INT_MASK);
> +
> +	if (enable)
> +		val &= ~mask;
> +	else
> +		val |= mask;
> +
> +	__raw_writel(val, pmu->base + PMU_INT_MASK);
> +}
> +
> +static irqreturn_t starfive_pmu_interrupt(int irq, void *data)
> +{
> +	struct starfive_pmu *pmu = data;
> +	unsigned long flags;
> +	u32 val;
> +
> +	spin_lock_irqsave(&pmu->lock, flags);
> +	val = __raw_readl(pmu->base + PMU_INT_STATUS);
> +
> +	if (val & PMU_INT_SEQ_DONE)
> +		dev_dbg(pmu->pdev, "sequence done.\n");
> +	if (val & PMU_INT_HW_REQ)
> +		dev_dbg(pmu->pdev, "hardware encourage requestion.\n");
> +	if (val & PMU_INT_SW_FAIL)
> +		dev_err(pmu->pdev, "software encourage fail.\n");
> +	if (val & PMU_INT_HW_FAIL)
> +		dev_err(pmu->pdev, "hardware encourage fail.\n");
> +	if (val & PMU_INT_PCH_FAIL)
> +		dev_err(pmu->pdev, "p-channel fail event.\n");
> +
> +	/* clear interrupts */
> +	__raw_writel(val, pmu->base + PMU_INT_STATUS);
> +	__raw_writel(val, pmu->base + PMU_EVENT_STATUS);
> +
> +	spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int starfive_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct starfive_pmu_data *entry, *table;
> +	struct starfive_pmu *pmu;
> +	unsigned int i;
> +	uint8_t max_bit = 0;
> +	int ret;
> +
> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	pmu_base = pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pmu->base))
> +		return PTR_ERR(pmu->base);
> +
> +	/* initialize pmu interrupt  */
> +	pmu->irq = platform_get_irq(pdev, 0);
> +	if (pmu->irq < 0)
> +		return pmu->irq;
> +
> +	ret = devm_request_irq(dev, pmu->irq, starfive_pmu_interrupt,
> +			       0, pdev->name, pmu);
> +	if (ret)
> +		dev_err(dev, "request irq failed.\n");
> +
> +	table = of_device_get_match_data(dev);
> +	if (!table)
> +		return -EINVAL;
> +
> +	pmu->pdev = dev;
> +	pmu->genpd_data.num_domains = 0;
> +	i = 0;
> +	for (entry = table; entry->name; entry++) {
> +		max_bit = max(max_bit, entry->bit);
> +		i++;
> +	}

This looks like something that could be replaced by the functions in
linux/list.h, no? Same below.

> +
> +	if (!i)
> +		return -ENODEV;
> +
> +	pmu->genpd_data.num_domains = max_bit + 1;
> +
> +	pmu->dev = devm_kcalloc(dev, pmu->genpd_data.num_domains,
> +				  sizeof(struct starfive_power_dev),
> +				  GFP_KERNEL);
> +	if (!pmu->dev)
> +		return -ENOMEM;
> +
> +	pmu->genpd = devm_kcalloc(dev, pmu->genpd_data.num_domains,
> +				    sizeof(struct generic_pm_domain *),
> +				    GFP_KERNEL);

This two allocations both look like checkpatch would whinge about their
alignment.

> +	if (!pmu->genpd)
> +		return -ENOMEM;
> +
> +	pmu->genpd_data.domains = pmu->genpd;
> +
> +	i = 0;
> +	for (entry = table; entry->name; entry++) {
> +		struct starfive_power_dev *pmd = &pmu->dev[i];
> +		bool is_on;
> +
> +		pmd->power = pmu;
> +		pmd->mask = BIT(entry->bit);
> +		pmd->genpd.name = entry->name;
> +		pmd->genpd.flags = entry->flags;
> +
> +		ret = starfive_pmu_get_state(pmd, &is_on);
> +		if (ret)
> +			dev_warn(dev, "unable to get current state for %s\n",
> +				 pmd->genpd.name);

In what scenario would it not be possible to get the state? Again, I
hope I'm not missing something obvious. From what I can see, this is the
only caller of starfive_pmu_get_state(), which looks like:
> > +	struct starfive_pmu *pmu = pmd->power;
> > +
> > +	if (!pmd->mask) {

How can !pmd->mask evaluate to true, given it's just been set to BIT(n)?

> > +		*is_on = false;
> > +		return -EINVAL;
> > +	}
> > +
> > +	*is_on = __raw_readl(pmu->base + CURR_POWER_MODE) & pmd->mask;
> > +
> > +	return 0;

If I've not missed something, looks like you could likely remove the
function and just do the readl() here?

> +
> +		pmd->genpd.power_on = starfive_pmu_on;
> +		pmd->genpd.power_off = starfive_pmu_off;
> +
> +		pm_genpd_init(&pmd->genpd, NULL, !is_on);
> +		pmu->genpd[entry->bit] = &pmd->genpd;
> +
> +		i++;
> +	}
> +
> +	spin_lock_init(&pmu->lock);
> +	starfive_pmu_int_enable(pmu, PMU_INT_ALL_MASK & ~PMU_INT_PCH_FAIL, true);
> +
> +	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
> +	if (ret) {
> +		dev_err(dev, "failed to register genpd driver: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "registered %u power domains\n", i);
> +
> +	return 0;
> +}
> +
> +static const struct starfive_pmu_data jh7110_power_domains[] = {

Is this driver jh7110 only or actually jh71XX? Have you just started out
by implementing one SoC both intend to support both?

> +	{
> +		.name = "SYSTOP",
> +		.bit = JH7110_PD_SYSTOP,
> +		.flags = GENPD_FLAG_ALWAYS_ON,
> +	}, {
> +		.name = "CPU",
> +		.bit = JH7110_PD_CPU,
> +		.flags = GENPD_FLAG_ALWAYS_ON,
> +	}, {
> +		.name = "GPUA",
> +		.bit = JH7110_PD_GPUA,
> +	}, {
> +		.name = "VDEC",
> +		.bit = JH7110_PD_VDEC,
> +	}, {
> +		.name = "VOUT",
> +		.bit = JH7110_PD_VOUT,
> +	}, {
> +		.name = "ISP",
> +		.bit = JH7110_PD_ISP,
> +	}, {
> +		.name = "VENC",
> +		.bit = JH7110_PD_VENC,
> +	}, {
> +		.name = "GPUB",
> +		.bit = JH7110_PD_GPUB,
> +	}, {
> +		/* sentinel */
> +	},

Can drop this , after the sentinel ;)

I don't know /jack/ about power domain stuff, so I can barely review
this at all sadly.
Thanks,
Conor.

> +};
> +
> +static const struct of_device_id starfive_pmu_of_match[] = {
> +	{
> +		.compatible = "starfive,jh7110-pmu",
> +		.data = &jh7110_power_domains,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver jh71xx_pmu_driver = {
> +	.driver = {
> +		.name = "jh71xx-pmu",
> +		.of_match_table = starfive_pmu_of_match,
> +	},
> +	.probe  = starfive_pmu_probe,
> +};
> +builtin_platform_driver(jh71xx_pmu_driver);

