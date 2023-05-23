Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64A170E5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238190AbjEWTfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbjEWTfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:35:32 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6A5E6D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 12:35:05 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id be849199-f9a0-11ed-abf4-005056bdd08f;
        Tue, 23 May 2023 22:33:50 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 22:33:50 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, u-kumar1@ti.com
Subject: Re: [PATCH v5 3/3] regulator: tps6594-regulator: Add driver for TI
 TPS6594 regulators
Message-ID: <ZG0VHnEByyMW9i4a@surfacebook>
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-4-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522163115.2592883-4-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 22, 2023 at 06:31:15PM +0200, Esteban Blanc kirjoitti:
> From: Jerome Neanne <jneanne@baylibre.com>
> 
> This patch adds support for TPS6594 regulators (bucks and LDOs).

BUCKs (otherwise $$$?)

> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
> Bucks can be used in single or multiphase mode, depending on PMIC

BUCKs (otherwise $$$?)

> part number.

...

> +	help
> +	  This driver supports TPS6594 voltage regulator chips.
> +	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
> +	  voltage regulators.
> +	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
> +	  Part number defines which single or multiphase mode is i used.

i?!

> +	  It supports software based voltage control
> +	  for different voltage domains.

...

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

Are you sure this one is correct and / or of.h is not missing? of_match_ptr()
IIRC is defined in of.h.

> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>

...

> +/* Operations permitted on BUCK1/2/3/4/5 */
> +static const struct regulator_ops tps6594_bucks_ops = {
> +	.is_enabled		= regulator_is_enabled_regmap,
> +	.enable			= regulator_enable_regmap,
> +	.disable		= regulator_disable_regmap,
> +	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
> +	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
> +	.list_voltage		= regulator_list_voltage_linear_range,
> +	.map_voltage		= regulator_map_voltage_linear_range,
> +	.set_voltage_time_sel	= regulator_set_voltage_time_sel,

> +

Redundant blank line.

> +};

...

> +	int error;
> +
> +	for (j = 0; j < REGS_INT_NB; j++) {
> +		irq_type = &tps6594_regs_irq_types[j];
> +		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
> +		if (irq < 0)
> +			return -EINVAL;
> +
> +		irq_data[*irq_idx + j].dev = tps->dev;
> +		irq_data[*irq_idx + j].type = irq_type;
> +		irq_data[*irq_idx + j].rdev = rdev;
> +
> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
> +						  tps6594_regulator_irq_handler,
> +						  IRQF_ONESHOT,
> +						  irq_type->irq_name,
> +						  &irq_data[*irq_idx]);

> +		(*irq_idx)++;

This is interesing. So, even in error case we touch given parameter. Usually
the pattern is not to touch the output if we know there is an error.

> +		if (error) {
> +			dev_err(tps->dev, "tps6594 failed to request %s IRQ %d: %d\n",
> +				irq_type->irq_name, irq, error);
> +			return error;
> +		}
> +	}

...

> +	u8 buck_configured[BUCK_NB] = { 0 };
> +	u8 buck_multi[MULTI_PHASE_NB] = { 0 };

0:s are not needed but I dunno if it's a style in the regulator subsystem.

> +	static const char * const multiphases[] = {"buck12", "buck123", "buck1234", "buck34"};
> +	static const char *npname;
> +	int error, i, irq, multi, delta;
> +	int irq_idx = 0;
> +	int buck_idx = 0;
> +	int ext_reg_irq_nb = 2;

> +

Redundant blank line.

> +	enum {
> +		MULTI_BUCK12,
> +		MULTI_BUCK123,
> +		MULTI_BUCK1234,
> +		MULTI_BUCK12_34,

> +		MULTI_FIRST = MULTI_BUCK12,
> +		MULTI_LAST = MULTI_BUCK12_34,
> +		MULTI_NUM = MULTI_LAST - MULTI_FIRST + 1

		MULT_NUM

will suffice instead all this.

> +	};

But why enum at all? See below.

...

> +	/*
> +	 * Switch case defines different possible multi phase config
> +	 * This is based on dts buck node name.
> +	 * Buck node name must be chosen accordingly.
> +	 * Default case is no Multiphase buck.
> +	 * In case of Multiphase configuration, value should be defined for
> +	 * buck_configured to avoid creating bucks for every buck in multiphase
> +	 */
> +	for (multi = MULTI_FIRST; multi < MULTI_NUM; multi++) {
> +		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
> +		npname = of_node_full_name(np);
> +		np_pmic_parent = of_get_parent(of_get_parent(np));
> +		if (of_node_cmp(of_node_full_name(np_pmic_parent), tps->dev->of_node->full_name))

Why not of_node_full_name() in the second case?


> +			continue;
> +		delta = strcmp(npname, multiphases[multi]);
> +		if (!delta) {
> +			switch (multi) {
> +			case MULTI_BUCK12:

This all looks like match_string() reinvention.

> +				buck_multi[0] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;
> +				break;
> +			/* multiphase buck34 is supported only with buck12 */
> +			case MULTI_BUCK12_34:
> +				buck_multi[0] = 1;
> +				buck_multi[1] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;
> +				buck_configured[2] = 1;
> +				buck_configured[3] = 1;
> +				break;
> +			case MULTI_BUCK123:
> +				buck_multi[2] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;
> +				buck_configured[2] = 1;
> +				break;
> +			case MULTI_BUCK1234:
> +				buck_multi[3] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;
> +				buck_configured[2] = 1;
> +				buck_configured[3] = 1;
> +				break;
> +			}
> +		}
> +	}

...

> +	irq_data = devm_kmalloc_array(tps->dev,
> +				REGS_INT_NB * sizeof(struct tps6594_regulator_irq_data),
> +				ARRAY_SIZE(tps6594_bucks_irq_types) +
> +				ARRAY_SIZE(tps6594_ldos_irq_types),
> +				GFP_KERNEL);

Have you checked overflow.h? There are macros to help with the above calculus.

> +	if (!irq_data)
> +		return -ENOMEM;

...

> +		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(tps->dev, PTR_ERR(rdev),

Why not &pdev->dev here?

> +					     "failed to register %s regulator\n",
> +					     pdev->name);

...

> +		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
> +		if (IS_ERR(rdev))
> +			return dev_err_probe(tps->dev, PTR_ERR(rdev),
> +					     "failed to register %s regulator\n",
> +					     pdev->name);

Hmm... Again, why the error is printed against different device than regulator
registration?

...

> +	/* LP8764 dosen't have LDO */
> +	if (tps->chip_id != LP8764) {
> +		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
> +			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
> +			if (IS_ERR(rdev))
> +				return dev_err_probe(tps->dev, PTR_ERR(rdev),
> +						     "failed to register %s regulator\n",
> +						     pdev->name);
> +
> +			error = tps6594_request_reg_irqs(pdev, rdev, irq_data,
> +							 tps6594_ldos_irq_types[i],
> +							 &irq_idx);
> +			if (error)
> +				return error;
> +		}
> +	}
> +
> +	if (tps->chip_id == LP8764)

'else'?

Or actually

	if (tps->chip_id == LP8764) {
		...
	} else {
		the above part
	}

?


> +		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);

...

> +static struct platform_driver tps6594_regulator_driver = {
> +	.driver = {
> +		.name = "tps6594-regulator",
> +	},
> +	.probe = tps6594_regulator_probe,
> +};

> +

This blank line is not needed.

> +module_platform_driver(tps6594_regulator_driver);

-- 
With Best Regards,
Andy Shevchenko


