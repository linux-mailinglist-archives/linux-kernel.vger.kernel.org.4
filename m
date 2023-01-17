Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5340266DA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbjAQKJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbjAQKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:09:29 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08F42D17D;
        Tue, 17 Jan 2023 02:09:25 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pHitr-0006k8-Rj; Tue, 17 Jan 2023 11:09:03 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-kernel@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Subject: Re: [PATCH v3 2/3] soc: starfive: Add StarFive JH71XX pmu driver
Date:   Tue, 17 Jan 2023 11:09:03 +0100
Message-ID: <10209933.nUPlyArG6x@diego>
In-Reply-To: <20230116074259.22874-3-walker.chen@starfivetech.com>
References: <20230116074259.22874-1-walker.chen@starfivetech.com>
 <20230116074259.22874-3-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Walker,

Am Montag, 16. Januar 2023, 08:42:58 CET schrieb Walker Chen:
> +static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
> +{
> +	struct jh71xx_pmu *pmu = pmd->pmu;
> +
> +	if (!mask) {
> +		*is_on = false;

nit: While it's not necessarily bad, I don't think callers of
jh71xx_pmu_get_state() should expect this to be set in error case.

> +		return -EINVAL;
> +	}
> +
> +	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
> +
> +	return 0;
> +}

[...]

> +static int jh71xx_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	const struct jh71xx_pmu_match_data *match_data;
> +	struct jh71xx_pmu *pmu;
> +	unsigned int i;
> +	int ret;
> +
> +	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	pmu->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pmu->base))
> +		return PTR_ERR(pmu->base);
> +
> +	pmu->irq = platform_get_irq(pdev, 0);
> +	if (pmu->irq < 0)
> +		return pmu->irq;
> +
> +	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
> +			       0, pdev->name, pmu);
> +	if (ret)
> +		dev_err(dev, "failed to request irq\n");
> +
> +	match_data = of_device_get_match_data(dev);
> +	if (!match_data)
> +		return -EINVAL;
> +
> +	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
> +				  sizeof(struct generic_pm_domain *),
> +				  GFP_KERNEL);
> +	if (!pmu->genpd)
> +		return -ENOMEM;
> +
> +	pmu->dev = dev;
> +	pmu->match_data = match_data;
> +	pmu->genpd_data.domains = pmu->genpd;
> +	pmu->genpd_data.num_domains = match_data->num_domains;
> +
> +	for (i = 0; i < match_data->num_domains; i++) {
> +		ret = jh71xx_pmu_init_domain(pmu, i);
> +		if (ret) {
> +			dev_err(dev, "failed to initialize power domain\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock_init(&pmu->lock);
> +	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
> +
> +	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
> +	if (ret) {
> +		dev_err(dev, "failed to register genpd driver: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(dev, "registered %u power domains\n", i);

nit: I guess that could be a dev_dbg to not spam the kernel log too much?


> +	return 0;
> +}
> +
> +static const struct jh71xx_domain_info jh7110_power_domains[] = {
> +	[JH7110_PD_SYSTOP] = {
> +		.name = "SYSTOP",
> +		.bit = 0,
> +		.flags = GENPD_FLAG_ALWAYS_ON,
> +	},
> +	[JH7110_PD_CPU] = {
> +		.name = "CPU",
> +		.bit = 1,
> +		.flags = GENPD_FLAG_ALWAYS_ON,
> +	},
> +	[JH7110_PD_GPUA] = {
> +		.name = "GPUA",
> +		.bit = 2,
> +	},
> +	[JH7110_PD_VDEC] = {
> +		.name = "VDEC",
> +		.bit = 3,
> +	},
> +	[JH7110_PD_VOUT] = {
> +		.name = "VOUT",
> +		.bit = 4,
> +	},
> +	[JH7110_PD_ISP] = {
> +		.name = "ISP",
> +		.bit = 5,
> +	},
> +	[JH7110_PD_VENC] = {
> +		.name = "VENC",
> +		.bit = 6,
> +	},
> +};
> +
> +static const struct jh71xx_pmu_match_data jh7110_pmu = {
> +	.num_domains = ARRAY_SIZE(jh7110_power_domains),
> +	.domain_info = jh7110_power_domains,
> +};
> +
> +static const struct of_device_id jh71xx_pmu_of_match[] = {
> +	{
> +		.compatible = "starfive,jh7110-pmu",
> +		.data = (void *)&jh7110_pmu,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver jh71xx_pmu_driver = {
> +	.driver = {
> +		.name = "jh71xx-pmu",
> +		.of_match_table = jh71xx_pmu_of_match,

In the rockchip pm-domains driver we have

                /*
                 * We can't forcibly eject devices from the power
                 * domain, so we can't really remove power domains
                 * once they were added.
                 */
                .suppress_bind_attrs = true,

here, which might be valid for your pmu driver as well.


Other than that
Reviewed-by: Heiko Stuebner <heiko@sntech.de>



