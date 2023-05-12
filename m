Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAA700DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 19:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjELRe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 13:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbjELRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 13:34:51 -0400
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8801B8
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 10:34:49 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 4a6e862d-f0eb-11ed-abf4-005056bdd08f;
        Fri, 12 May 2023 20:34:47 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 12 May 2023 20:34:47 +0300
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com, sterzik@ti.com,
        u-kumar1@ti.com
Subject: Re: [PATCH v4 3/3] regulator: tps6594-regulator: Add driver for TI
 TPS6594 regulators
Message-ID: <ZF54t38o2PFsl_oX@surfacebook>
References: <20230512141755.1712358-1-eblanc@baylibre.com>
 <20230512141755.1712358-4-eblanc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512141755.1712358-4-eblanc@baylibre.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, May 12, 2023 at 04:17:55PM +0200, Esteban Blanc kirjoitti:
> From: Jerome Neanne <jneanne@baylibre.com>
> 
> This patch adds support for TPS6594 regulators (bucks and LDOs).
> The output voltages are configurable and are meant to supply power
> to the main processor and other components.
> Bucks can be used in single or multiphase mode, depending on PMIC
> part number.

...

> +	enum {
> +	MULTI_BUCK12,
> +	MULTI_BUCK123,
> +	MULTI_BUCK1234,
> +	MULTI_BUCK12_34,
> +	MULTI_FIRST = MULTI_BUCK12,
> +	MULTI_LAST = MULTI_BUCK12_34,
> +	MULTI_NUM = MULTI_LAST - MULTI_FIRST + 1

Missing TABs?

> +	};

...

> +	for (multi = MULTI_FIRST ; multi < MULTI_NUM ; multi++) {

Just a remark: spaces before ; are not standard.

> +		np = of_find_node_by_name(tps->dev->of_node, multiphases[multi]);
> +		npname = of_node_full_name(np);
> +		np_pmic_parent = of_get_parent(of_get_parent(np));
> +		if (strcmp((of_node_full_name(np_pmic_parent)), tps->dev->of_node->full_name))
> +			continue;

Isn't there an API to compare OF node name with a given parameter?

> +		delta = strcmp(npname, multiphases[multi]);
> +		if (!delta) {
> +			switch (multi) {
> +			case MULTI_BUCK12:
> +				buck_multi[0] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;
> +				break;
> +			/* multiphase buck34 is supported only with buck12 */
> +			case MULTI_BUCK12_34:
> +				buck_multi[0] = 1;
> +				buck_configured[0] = 1;
> +				buck_configured[1] = 1;

> +				buck_multi[1] = 1;

Might be easier to read if this is grouped with [0] assignment above.

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

> +	irq_data = devm_kmalloc(tps->dev,
> +				ARRAY_SIZE(tps6594_bucks_irq_types) *
> +				REGS_INT_NB *
> +				sizeof(struct tps6594_regulator_irq_data) +
> +				ARRAY_SIZE(tps6594_ldos_irq_types) *
> +				REGS_INT_NB *
> +				sizeof(struct tps6594_regulator_irq_data),

We have respective macros in overflow.h that can be used here.

> +				GFP_KERNEL);
> +	if (!irq_data)
> +		return -ENOMEM;

...

> +		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(tps->dev, "failed to register %s regulator\n",
> +				pdev->name);
> +			return PTR_ERR(rdev);

		return dev_err_probe(...);
?

> +		}

...

> +		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
> +		if (IS_ERR(rdev)) {
> +			dev_err(tps->dev, "failed to register %s regulator\n",
> +				pdev->name);
> +			return PTR_ERR(rdev);

Same question.

> +		}

...

> +			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
> +			if (IS_ERR(rdev)) {
> +				dev_err(tps->dev,
> +					"failed to register %s regulator\n",
> +					pdev->name);
> +				return PTR_ERR(rdev);

Same question.

> +			}

> +	irq_ext_reg_data = devm_kmalloc(tps->dev,
> +					ext_reg_irq_nb *
> +					sizeof(struct tps6594_ext_regulator_irq_data),
> +					GFP_KERNEL);

devm_kmalloc_array()

> +	if (!irq_ext_reg_data)
> +		return -ENOMEM;

...

> +		error = devm_request_threaded_irq(tps->dev, irq, NULL,
> +						  tps6594_regulator_irq_handler,
> +						  IRQF_ONESHOT,
> +						  irq_type->irq_name,
> +						  &irq_ext_reg_data[i]);
> +		if (error) {
> +			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
> +				irq_type->irq_name, irq, error);
> +			return error;

	return dev_err_probe(...);

?

> +		}
> +	}
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


