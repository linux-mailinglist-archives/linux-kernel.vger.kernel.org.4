Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF2671508
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjARH3d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Jan 2023 02:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjARH2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:28:40 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D95C5CFF3;
        Tue, 17 Jan 2023 22:45:46 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 7759024DC7D;
        Wed, 18 Jan 2023 14:45:45 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Jan
 2023 14:45:45 +0800
Received: from [192.168.125.95] (113.72.144.40) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 18 Jan
 2023 14:45:44 +0800
Message-ID: <0ce3f9ba-4cb4-4257-21f3-818ff0b959cd@starfivetech.com>
Date:   Wed, 18 Jan 2023 14:45:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/3] soc: starfive: Add StarFive JH71XX pmu driver
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230116074259.22874-1-walker.chen@starfivetech.com>
 <20230116074259.22874-3-walker.chen@starfivetech.com>
 <10209933.nUPlyArG6x@diego>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <10209933.nUPlyArG6x@diego>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [113.72.144.40]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/17 18:09, Heiko Stübner wrote:
> Hi Walker,
> 
> Am Montag, 16. Januar 2023, 08:42:58 CET schrieb Walker Chen:
>> +static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
>> +{
>> +	struct jh71xx_pmu *pmu = pmd->pmu;
>> +
>> +	if (!mask) {
>> +		*is_on = false;
> 
> nit: While it's not necessarily bad, I don't think callers of
> jh71xx_pmu_get_state() should expect this to be set in error case.

Maybe setting 'is_on' in this case is redundant operation. Will be dropped.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
>> +
>> +	return 0;
>> +}
> 
> [...]
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
>> +	pmu->irq = platform_get_irq(pdev, 0);
>> +	if (pmu->irq < 0)
>> +		return pmu->irq;
>> +
>> +	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
>> +			       0, pdev->name, pmu);
>> +	if (ret)
>> +		dev_err(dev, "failed to request irq\n");
>> +
>> +	match_data = of_device_get_match_data(dev);
>> +	if (!match_data)
>> +		return -EINVAL;
>> +
>> +	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
>> +				  sizeof(struct generic_pm_domain *),
>> +				  GFP_KERNEL);
>> +	if (!pmu->genpd)
>> +		return -ENOMEM;
>> +
>> +	pmu->dev = dev;
>> +	pmu->match_data = match_data;
>> +	pmu->genpd_data.domains = pmu->genpd;
>> +	pmu->genpd_data.num_domains = match_data->num_domains;
>> +
>> +	for (i = 0; i < match_data->num_domains; i++) {
>> +		ret = jh71xx_pmu_init_domain(pmu, i);
>> +		if (ret) {
>> +			dev_err(dev, "failed to initialize power domain\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	spin_lock_init(&pmu->lock);
>> +	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
>> +
>> +	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register genpd driver: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	dev_info(dev, "registered %u power domains\n", i);
> 
> nit: I guess that could be a dev_dbg to not spam the kernel log too much?

OK, will be used with dev_dbg().

> 
> 
>> +	return 0;
>> +}
>> +
>> +static const struct jh71xx_domain_info jh7110_power_domains[] = {
>> +	[JH7110_PD_SYSTOP] = {
>> +		.name = "SYSTOP",
>> +		.bit = 0,
>> +		.flags = GENPD_FLAG_ALWAYS_ON,
>> +	},
>> +	[JH7110_PD_CPU] = {
>> +		.name = "CPU",
>> +		.bit = 1,
>> +		.flags = GENPD_FLAG_ALWAYS_ON,
>> +	},
>> +	[JH7110_PD_GPUA] = {
>> +		.name = "GPUA",
>> +		.bit = 2,
>> +	},
>> +	[JH7110_PD_VDEC] = {
>> +		.name = "VDEC",
>> +		.bit = 3,
>> +	},
>> +	[JH7110_PD_VOUT] = {
>> +		.name = "VOUT",
>> +		.bit = 4,
>> +	},
>> +	[JH7110_PD_ISP] = {
>> +		.name = "ISP",
>> +		.bit = 5,
>> +	},
>> +	[JH7110_PD_VENC] = {
>> +		.name = "VENC",
>> +		.bit = 6,
>> +	},
>> +};
>> +
>> +static const struct jh71xx_pmu_match_data jh7110_pmu = {
>> +	.num_domains = ARRAY_SIZE(jh7110_power_domains),
>> +	.domain_info = jh7110_power_domains,
>> +};
>> +
>> +static const struct of_device_id jh71xx_pmu_of_match[] = {
>> +	{
>> +		.compatible = "starfive,jh7110-pmu",
>> +		.data = (void *)&jh7110_pmu,
>> +	}, {
>> +		/* sentinel */
>> +	}
>> +};
>> +
>> +static struct platform_driver jh71xx_pmu_driver = {
>> +	.driver = {
>> +		.name = "jh71xx-pmu",
>> +		.of_match_table = jh71xx_pmu_of_match,
> 
> In the rockchip pm-domains driver we have
> 
>                 /*
>                  * We can't forcibly eject devices from the power
>                  * domain, so we can't really remove power domains
>                  * once they were added.
>                  */
>                 .suppress_bind_attrs = true,
> 
> here, which might be valid for your pmu driver as well.

Okay, this attribute will be added in next version.

> 
> 
> Other than that
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 

Thanks for your review.

Best regards,
Walker Chen
