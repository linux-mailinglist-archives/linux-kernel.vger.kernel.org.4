Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D5463311E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiKVAJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKVAJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:09:04 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397692B49
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:09:02 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so15719749pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uKZLqRGf8BJZDh7jHE36jyMimT2zwRKVGJSlSOPTg+U=;
        b=wQZOIJONcXbHkFZq1G9+Bpu8n0iCVTwZ7lvZrD5WcJphzDlJUz7sExbOZuOqaLexNr
         oIPGcBT7Mc0PdoZ27QztOPUyPA9Et98Y8Ek/QPpLUPJ9YB448175QKBwIuqa/nUOUQDt
         OgF8zWAj2CxQhsQWRUg1g+ztNWifkgeeiP/Ek05OwR4MHL4GUsHbOl5jyDvMr3apb+n4
         kSprFu0hqOwVFO8pWA4EuVUhk4ZZCNwijjn7/dQSYmascGJIKxzw7d7PRao5aDjPJKta
         CNH5550NIlaxs0eGS4O98OhX8ht1zpYxs+k2FLV2UtfbXEvKmfJv18dshu4eaZADbFy+
         D75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKZLqRGf8BJZDh7jHE36jyMimT2zwRKVGJSlSOPTg+U=;
        b=geuZgUdFH4k0aCrOAVPXBnbt4jxIUGJrxKXAldZCDTdO1P084/Xfbw4WweUrxhImqm
         vvVe7UaUBG/VeCbAgjQRWUwy5pGJMYSr4vZhlYP/AuHJgG6x04isAVMGRGbQs2Vs1bEi
         4eClOYPYEzKf8zq/BuJk64BVqqh/PgW+xRDZ3KpyHvvai6EnjnCayVqbv1MF/gpQa5N3
         ReA/ln8KCBPvygCs4Vt5Dnqi86F0P57Ar3jQnIB5jgs3Nd2Jt44IaBAiFG5i5vmQNyqw
         A2qjm4CPAXUepD7AuP4TDl0nGWKhmJoPtvCN0ZJ41lpdM4EMnoyloOnxN2fkmVRN6YZO
         9ebA==
X-Gm-Message-State: ANoB5pnFg0L5fKbsm3v4EVI1Rg+3Bfel+POuC8fvok05KIk+zPhbSMmr
        fzvDWANQW16iJmY/QXDsKMP23A==
X-Google-Smtp-Source: AA0mqf7M4ltKeAX+jDnV5k1VqRATMO6szxw65EoAXC+2gMC+LMZRb/5GoMTuKt/Ai1V1AsAKWC6sFw==
X-Received: by 2002:a17:90a:dd82:b0:212:fdb1:720b with SMTP id l2-20020a17090add8200b00212fdb1720bmr29143847pjv.66.1669075742029;
        Mon, 21 Nov 2022 16:09:02 -0800 (PST)
Received: from localhost ([75.172.139.56])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b001873aa85e1fsm10211035pln.305.2022.11.21.16.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 16:09:01 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] soc: starfive: Add StarFive JH71XX pmu driver
In-Reply-To: <20221118133216.17037-4-walker.chen@starfivetech.com>
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-4-walker.chen@starfivetech.com>
Date:   Mon, 21 Nov 2022 16:09:00 -0800
Message-ID: <7hedtvam03.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walker,

Walker Chen <walker.chen@starfivetech.com> writes:

> Add generic power domain driver for the StarFive JH71XX SoC.
>
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>

A bit more detail about the features power domain hardware would be
helpful for reviewers.  I'm assuming there's no public documenation for
this, but if there is, a link to that would be great also.

[...]

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
> +
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

Where do these delay/timeout numbers come from?  Is this just based one
experimentation, or is this something described by the HW docs.  Please
add some comments.

> +
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
> +};
> +
> +static void __iomem *pmu_base;
> +
> +static inline void pmu_writel(u32 val, u32 offset)
> +{
> +	writel(val, pmu_base + offset);
> +}

You use writel() in this helper, but __raw_writel() throughout the rest
of the driver.  If that's intentional, you should explain a bit more
about why.  If not, please make it consistent.

If you're going to use a wrapper/helper, you should use it throughout.
But in this case, I'm not sure it's adding anything to readability.  In
fact, it's only adding confusion since you don't use it for most of the
register accesses.

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

This looks wrong.  Why are you allowing external users to power on/off the
domains?  The sate of the domain should be managed by the PM core (and
runtime PM use-counts etc.) allowing external users to change the domain
state is going to lead to the PM core being confused about the state of
the domain.

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

Comparing an uninitialzed stack variable to 'on'?

> +		dev_info(pmu->pdev, "pm domain [%s] is already %sable status.\n",
> +				pmd->genpd.name, on ? "en" : "dis");

Using dev_info() will probably make this a bit verbose.  I'd suggest
dev_dbg() for this kind of message.

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
> +	__raw_writel(encourage_lo, pmu->base + SW_ENCOURAGE);
> +	__raw_writel(encourage_hi, pmu->base + SW_ENCOURAGE);

This "encourage" feature is peculiar.  What happens if you do not do
this?  Does it take a lot longer for the domain to change state? or does
it not change at all?  In the absence of HW specs, a bit of description
here would be helpful.

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

I don't think you need to spinlock in the interrupt itself, as
interrupts will already be disabled, and this handler is not
IRQF_SHARED.

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

[...]

Kevin
