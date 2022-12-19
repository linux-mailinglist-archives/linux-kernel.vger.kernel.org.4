Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6DA365141C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiLSUkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiLSUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:40:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DA830A;
        Mon, 19 Dec 2022 12:40:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A15061165;
        Mon, 19 Dec 2022 20:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A198C433D2;
        Mon, 19 Dec 2022 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671482439;
        bh=cbT5wFWYsPUPKcL1TTnyLAY/jF4rBk8dA4rI4vvCkJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=th8x7h1WaUPImey81a/g9JO9DqhTsAA+p2xidQmyz2XJl4PBpRhUbAVNchTcBlEUP
         i3ZUfv69wX7EUOBb1/XAanp42RF9lMC1TOYS8EHeOJVRwDSCc9qz2uhFwl2/4aLix3
         0f4lZ9xr7szCUmr1jOHKFT2llzZn1241WFO5AhpujM/ubfLsxbZmTCgNcfwVszMSS+
         EJuOTK7lA/iU1OXfYgLl47s2VSfwsRI3r7zVErHfjA61lxvTo0w/KvbcWrT3nIc97S
         wHhhVgJLc/qXUv0FVOtsUep8tOCskIwnZvN6hld7O0cYnfuyA2CkYf+h525yyh8TG8
         nwRnmQOSkJgDw==
Date:   Mon, 19 Dec 2022 20:40:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Walker Chen <walker.chen@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/3] soc: starfive: Add StarFive JH71XX pmu
 driver
Message-ID: <Y6DMQpGuXfBWHr8L@spud>
References: <20221208084523.9733-1-walker.chen@starfivetech.com>
 <20221208084523.9733-3-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SYCjqAld4EPrrPBY"
Content-Disposition: inline
In-Reply-To: <20221208084523.9733-3-walker.chen@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SYCjqAld4EPrrPBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Walker,

Hopefully just some minor bits here. Hopefully either Emil who has a
board, or someone that knows power management stuff better can give this
a proper review.

On Thu, Dec 08, 2022 at 04:45:22PM +0800, Walker Chen wrote:
> Add pmu driver for the StarFive JH71XX SoC.
>=20
> As the power domains provider, the Power Management Unit (PMU) is
> designed for including multiple PM domains that can be used for power
> gating of selected IP blocks for power saving by reduced leakage
> current. It accepts software encourage command to switch the power mode
> of SoC.
>=20
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  MAINTAINERS                       |  14 ++
>  drivers/soc/Kconfig               |   1 +
>  drivers/soc/Makefile              |   1 +
>  drivers/soc/starfive/Kconfig      |  11 +
>  drivers/soc/starfive/Makefile     |   3 +
>  drivers/soc/starfive/jh71xx_pmu.c | 396 ++++++++++++++++++++++++++++++
>  6 files changed, 426 insertions(+)
>  create mode 100644 drivers/soc/starfive/Kconfig
>  create mode 100644 drivers/soc/starfive/Makefile
>  create mode 100644 drivers/soc/starfive/jh71xx_pmu.c
>=20

> +config JH71XX_PMU
> +	bool "Support PMU for StarFive JH71XX Soc"
> +	depends on PM && (SOC_STARFIVE || COMPILE_TEST)

Why not just do:
	depends on PM
	depends on SOC_STARFIVE || COMPILE_TEST
I think that way reads a little better.

> +	default SOC_STARFIVE
> +	select PM_GENERIC_DOMAINS
> +	help
> +	  Say 'y' here to enable support power domain support.
> +	  In order to meet low power requirements, a Power Management Unit (PMU)
> +	  is designed for controlling power resources in StarFive JH71XX SoCs.
> diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
> new file mode 100644
> index 000000000000..13b589d6b5f3
> --- /dev/null
> +++ b/drivers/soc/starfive/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_JH71XX_PMU)	+=3D jh71xx_pmu.o
> diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh7=
1xx_pmu.c
> new file mode 100644
> index 000000000000..7a0145779e07
> --- /dev/null
> +++ b/drivers/soc/starfive/jh71xx_pmu.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * StarFive JH71XX PMU (Power Management Unit) Controller Driver
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
> +#include <dt-bindings/power/starfive,jh7110-pmu.h>
> +
> +/* register offset */
> +#define JH71XX_PMU_HW_EVENT_ON		0x04
> +#define JH71XX_PMU_HW_EVENT_OFF		0x08
> +#define JH71XX_PMU_SW_TURN_ON_POWER	0x0C
> +#define JH71XX_PMU_SW_TURN_OFF_POWER	0x10
> +#define JH71XX_PMU_SW_ENCOURAGE		0x44
> +#define JH71XX_PMU_INT_MASK		0x48
> +#define JH71XX_PMU_PCH_BYPASS		0x4C
> +#define JH71XX_PMU_PCH_PSTATE		0x50
> +#define JH71XX_PMU_PCH_TIMEOUT		0x54
> +#define JH71XX_PMU_LP_TIMEOUT		0x58
> +#define JH71XX_PMU_HW_TURN_ON		0x5C
> +#define JH71XX_PMU_CURR_POWER_MODE	0x80
> +#define JH71XX_PMU_EVENT_STATUS		0x88
> +#define JH71XX_PMU_INT_STATUS		0x8C
> +
> +/* sw encourage cfg */
> +#define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
> +#define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
> +#define JH71XX_PMU_SW_ENCOURAGE_DIS_LO	0x0A
> +#define JH71XX_PMU_SW_ENCOURAGE_DIS_HI	0xA0
> +#define JH71XX_PMU_SW_ENCOURAGE_ON	0xFF
> +
> +/* pmu int status */
> +#define JH71XX_PMU_INT_SEQ_DONE		BIT(0)
> +#define JH71XX_PMU_INT_HW_REQ		BIT(1)
> +#define JH71XX_PMU_INT_SW_FAIL		GENMASK(3, 2)
> +#define JH71XX_PMU_INT_HW_FAIL		GENMASK(5, 4)
> +#define JH71XX_PMU_INT_PCH_FAIL		GENMASK(8, 6)
> +#define JH71XX_PMU_INT_FAIL_MASK	(JH71XX_PMU_INT_SW_FAIL | \
> +					JH71XX_PMU_INT_HW_FAIL | \
> +					JH71XX_PMU_INT_PCH_FAIL)
> +#define JH71XX_PMU_INT_ALL_MASK		(JH71XX_PMU_INT_SEQ_DONE | \
> +					JH71XX_PMU_INT_HW_REQ | \
> +					JH71XX_PMU_INT_FAIL_MASK)
> +
> +/*
> + * The time required for switching power status is based on the time
> + * to turn on the largest domain's power, which is at microsecond level
> + */
> +#define JH71XX_PMU_TIMEOUT_US		100
> +
> +struct jh71xx_domain_info {

	const char * const name;
	unsigned int flags;
	u8 bit;

> +};
> +
> +struct jh71xx_pmu_match_data {

	const struct jh71xx_domain_info *domain_info;
	int num_domains;

Can you switch these two around like so?
> +};
> +
> +struct jh71xx_pmu {
> +	struct device *dev;
> +	const struct jh71xx_pmu_match_data *match_data;
> +	void __iomem *base;
> +	spinlock_t lock;	/* protects pmu reg */
> +	int irq;
> +	struct genpd_onecell_data genpd_data;
> +	struct generic_pm_domain **genpd;
> +};
> +
> +struct jh71xx_pmu_dev {
> +	struct generic_pm_domain genpd;
> +	const struct jh71xx_domain_info *domain_info;
> +	struct jh71xx_pmu *pmu;

And these two too please in the same way.

> +};
> +
> +static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bo=
ol *is_on)
> +{
> +	struct jh71xx_pmu *pmu =3D pmd->pmu;
> +
> +	if (!mask) {
> +		*is_on =3D false;
> +		return -EINVAL;
> +	}
> +
> +	*is_on =3D readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
> +
> +	return 0;
> +}
> +
> +static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bo=
ol on)
> +{
> +	struct jh71xx_pmu *pmu =3D pmd->pmu;
> +	unsigned long flags;
> +	u32 val;
> +	u32 mode;
> +	u32 encourage_lo;
> +	u32 encourage_hi;
> +	bool is_on;
> +	int ret;
> +
> +	ret =3D jh71xx_pmu_get_state(pmd, mask, &is_on);
> +	if (ret) {
> +		dev_dbg(pmu->dev, "unable to get current state for %s\n",
> +			pmd->genpd.name);
> +		return ret;
> +	}
> +
> +	if (is_on =3D=3D on) {
> +		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
> +			pmd->genpd.name, on ? "en" : "dis");
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&pmu->lock, flags);
> +
> +	/*
> +	 * The PMU accepts software encourage to switch power mode in the follo=
wing 2 steps:
> +	 *
> +	 * 1. Configure the register SW_TURN_ON_POWER (offset 0x0c), write 1 to
> +	 *    the bit which power domain will be turn-on, write 0 to the others.

Some grammatical nit picking..

"Configure the register blah (offset 0x0c) by writing 1 to the bit
corresponding to the power domain that will be turned on and writing
zero to the others."

Is that a correct correct summation of the operation?

> +	 *    Likewise, configure the register SW_TURN_OFF_POWER (offset 0x10),
> +	 *    write 1 to the bit which power domain will be turn-off, write 0 t=
o the others.


> +	 */
> +	if (on) {
> +		mode =3D JH71XX_PMU_SW_TURN_ON_POWER;
> +		encourage_lo =3D JH71XX_PMU_SW_ENCOURAGE_EN_LO;
> +		encourage_hi =3D JH71XX_PMU_SW_ENCOURAGE_EN_HI;
> +	} else {
> +		mode =3D JH71XX_PMU_SW_TURN_OFF_POWER;
> +		encourage_lo =3D JH71XX_PMU_SW_ENCOURAGE_DIS_LO;
> +		encourage_hi =3D JH71XX_PMU_SW_ENCOURAGE_DIS_HI;
> +	}
> +
> +	writel(mask, pmu->base + mode);
> +
> +	/*
> +	 * 2. Write SW encourage command sequence to the Software Encourage Reg=
 (offset 0x44)
> +	 * SW turn-on command sequence: 0xff -> 0x05 -> 0x50
> +	 * SW turn-off command sequence: 0xff -> 0x0a -> 0xa0

I think you could replace the hard "coded" numbers here with a better
description idk without looking at the #defines above what these
correspond to. AFAICT, it'd be something like:
First write the ...ENCOURAGE_ON to reset the state machine which parses
the command sequence. It must be written every time.
Then write the lower bits of the command sequence, followed by the upper
bits. The sequence differs between powering on & off a domain.
> +	 *
> +	 * Note: writing SW_MODE_ENCOURAGE_ON (0xFF) to the SW_ENCOURAGE regist=
er,
> +	 * the purpose is to reset the state machine which is going to parse in=
struction
> +	 *  sequence. It has to be written every time.
> +	 */
> +	writel(JH71XX_PMU_SW_ENCOURAGE_ON, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
> +	writel(encourage_lo, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
> +	writel(encourage_hi, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
> +
> +	spin_unlock_irqrestore(&pmu->lock, flags);
> +
> +	/* Wait for the power domain bit to be enabled / disabled */
> +	if (on) {
> +		ret =3D readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MO=
DE,
> +						val, val & mask,
> +						1, JH71XX_PMU_TIMEOUT_US);
> +	} else {
> +		ret =3D readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MO=
DE,
> +						val, !(val & mask),
> +						1, JH71XX_PMU_TIMEOUT_US);
> +	}
> +
> +	if (ret) {
> +		dev_err(pmu->dev, "%s: failed to power %s\n",
> +			pmd->genpd.name, on ? "on" : "off");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}

> +static int jh71xx_pmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct device_node *np =3D dev->of_node;
> +	const struct jh71xx_pmu_match_data *match_data;
> +	struct jh71xx_pmu *pmu;
> +	unsigned int i;
> +	int ret;
> +
> +	pmu =3D devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;
> +
> +	pmu->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(pmu->base))
> +		return PTR_ERR(pmu->base);
> +
> +	/* initialize pmu interrupt  */

nit: this comment is ~pointless.

> +	pmu->irq =3D platform_get_irq(pdev, 0);
> +	if (pmu->irq < 0)
> +		return pmu->irq;
> +
> +	ret =3D devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
> +			       0, pdev->name, pmu);
> +	if (ret)
> +		dev_err(dev, "request irq failed.\n");

nit: s/request/requesting

Unfortunately I cannot really review the rest of this, but hopefully
I'll get a board soon and can try it out - or else send me a link to
your TRM or w/e.

Thanks,
Conor.

> +
> +	match_data =3D of_device_get_match_data(dev);
> +	if (!match_data)
> +		return -EINVAL;
> +
> +	pmu->genpd =3D devm_kcalloc(dev, match_data->num_domains,
> +				  sizeof(struct generic_pm_domain *),
> +				  GFP_KERNEL);
> +	if (!pmu->genpd)
> +		return -ENOMEM;
> +
> +	pmu->dev =3D dev;
> +	pmu->match_data =3D match_data;
> +	pmu->genpd_data.domains =3D pmu->genpd;
> +	pmu->genpd_data.num_domains =3D match_data->num_domains;
> +
> +	for (i =3D 0; i < match_data->num_domains; i++) {
> +		ret =3D jh71xx_pmu_init_domain(pmu, i);
> +		if (ret) {
> +			dev_err(dev, "failed to initialize power domain\n");
> +			return ret;
> +		}
> +	}
> +
> +	spin_lock_init(&pmu->lock);
> +	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PC=
H_FAIL, true);
> +
> +	ret =3D of_genpd_add_provider_onecell(np, &pmu->genpd_data);
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
> +static const struct jh71xx_domain_info jh7110_power_domains[] =3D {
> +	[JH7110_PD_SYSTOP] =3D {
> +		.name =3D "SYSTOP",
> +		.bit =3D 0,
> +		.flags =3D GENPD_FLAG_ALWAYS_ON,
> +	},
> +	[JH7110_PD_CPU] =3D {
> +		.name =3D "CPU",
> +		.bit =3D 1,
> +		.flags =3D GENPD_FLAG_ALWAYS_ON,
> +	},
> +	[JH7110_PD_GPUA] =3D {
> +		.name =3D "GPUA",
> +		.bit =3D 2,
> +	},
> +	[JH7110_PD_VDEC] =3D {
> +		.name =3D "VDEC",
> +		.bit =3D 3,
> +	},
> +	[JH7110_PD_VOUT] =3D {
> +		.name =3D "VOUT",
> +		.bit =3D 4,
> +	},
> +	[JH7110_PD_ISP] =3D {
> +		.name =3D "ISP",
> +		.bit =3D 5,
> +	},
> +	[JH7110_PD_VENC] =3D {
> +		.name =3D "VENC",
> +		.bit =3D 6,
> +	},
> +};
> +
> +static const struct jh71xx_pmu_match_data jh7110_pmu =3D {
> +	.num_domains =3D ARRAY_SIZE(jh7110_power_domains),
> +	.domain_info =3D jh7110_power_domains,
> +};
> +
> +static const struct of_device_id jh71xx_pmu_of_match[] =3D {
> +	{
> +		.compatible =3D "starfive,jh7110-pmu",
> +		.data =3D (void *)&jh7110_pmu,
> +	}, {
> +		/* sentinel */
> +	}
> +};
> +
> +static struct platform_driver jh71xx_pmu_driver =3D {
> +	.driver =3D {
> +		.name =3D "jh71xx-pmu",
> +		.of_match_table =3D jh71xx_pmu_of_match,
> +	},
> +	.probe  =3D jh71xx_pmu_probe,
> +};
> +builtin_platform_driver(jh71xx_pmu_driver);
> +
> +MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
> +MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.17.1
>=20
>=20

--SYCjqAld4EPrrPBY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6DMQgAKCRB4tDGHoIJi
0gGfAQDZn5iArS4NP508h5utRHqQG/IjYkHIWH95xRUdAv8LZAD9GeFtdUVcjIl6
t90goMBY3L4vlIu2rCZVF8sB+GlhtwM=
=HL3t
-----END PGP SIGNATURE-----

--SYCjqAld4EPrrPBY--
