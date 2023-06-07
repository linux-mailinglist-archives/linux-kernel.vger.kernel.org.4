Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498627255B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbjFGHbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237719AbjFGHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:30:22 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F443A98
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:26:40 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id a38cc8f3-0504-11ee-a9de-005056bdf889;
        Wed, 07 Jun 2023 10:26:38 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 7 Jun 2023 10:26:37 +0300
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZIAxLdexyKBnMOmU@surfacebook>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 06, 2023 at 04:22:28PM +0000, Oleksii Moisieiev kirjoitti:
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCP firmware, which does the changes in HW.
> 
> This setup expects SCP firmware (or similar system, such as ATF)
> to be installed on the platform, which implements pinctrl driver
> for the specific platform.
> 
> SCMI-Pinctrl driver should be configured from the device-tree and uses
> generic device-tree mappings for the configuration.

...

> +++ b/drivers/pinctrl/Kconfig
> @@ -546,4 +546,15 @@ source "drivers/pinctrl/uniphier/Kconfig"
>  source "drivers/pinctrl/visconti/Kconfig"
>  source "drivers/pinctrl/vt8500/Kconfig"
>  
> +config PINCTRL_SCMI
> +	tristate "Pinctrl driver controlled via SCMI interface"
> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	help
> +	  This driver provides support for pinctrl which is controlled
> +	  by firmware that implements the SCMI interface.
> +	  It uses SCMI Message Protocol to interact with the
> +	  firmware providing all the pinctrl controls.

Sounds to me that u and v should be after S. Decrypting for your convenience,
the above is ordered and proposed change misses that.

>  endif

Btw, what is this endif for and how does it affect your Kconfig option?

...

> +++ b/drivers/pinctrl/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
>  obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
> +obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o

Ditto.

>  obj-y				+= actions/
>  obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/

...

> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>

> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};

struct pinfunction

...

> +struct scmi_pinctrl {
> +	struct device *dev;
> +	struct scmi_protocol_handle *ph;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pctl_desc;
> +	struct scmi_pinctrl_funcs *functions;
> +	unsigned int nr_functions;
> +	char **groups;

struct pingroup ?

> +	unsigned int nr_groups;
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int nr_pins;
> +};

...

> +	pmx = pinctrl_dev_get_drvdata(pctldev);

> +

Redundant blank line.

> +	if (!pmx || !pmx->ph)
> +		return NULL;

...

> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

Ditto. And so on in a few more places.

...

> +		pmx->functions[selector].groups[i] =

> +			pinctrl_scmi_get_group_name(pmx->pctldev,
> +						    group_ids[i]);

It's okay to have this on a single line which takes only 81 character.


...

> +error:

Labels shoud be self-explanatory, i.e. they should tell what _will_ be when goto.

> +	devm_kfree(pmx->dev, pmx->functions[selector].groups);

Red Flag. Please, elaborate.

> +
> +	return ret;

...

> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;

> +	if (!pctldev)
> +		return -EINVAL;

Huh?! When this is not a dead code?

Ditto for other places.

> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !configs || num_configs == 0)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_configs; i++) {
> +		config_type = pinconf_to_config_param(configs[i]);
> +		config_value = pinconf_to_config_argument(configs[i]);
> +
> +		ret = pinctrl_ops->set_config(pmx->ph, _pin, PIN_TYPE, config_type,
> +					      config_value);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error parsing config %ld\n",
> +				configs[i]);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}

...

> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int _pin,

Why this strange parameter name?

> +					  unsigned long *config)

...

> + err_free:

This is better, but shows the inconsistency with the other goto label namings.

> +	devm_kfree(pmx->dev, pmx->pins);

Red Flag. Please, elaborate.

> +	pmx->nr_pins = 0;
> +
> +	return ret;

...

> +	ret = devm_pinctrl_register_and_init(&sdev->dev, &pmx->pctl_desc, pmx,
> +					     &pmx->pctldev);
> +	if (ret) {
> +		dev_err_probe(&sdev->dev, ret, "Failed to register pinctrl\n");
> +		return ret;

		return dev_err_probe(...);

> +	}

...

> +		pmx->functions =
> +			devm_kcalloc(&sdev->dev, pmx->nr_functions,

This is perfectly a signle line.

Also with

	struct device *dev = &sdev->dev;

at the top you may make the entire ->probe() look neater.

> +				     sizeof(*pmx->functions),
> +				     GFP_KERNEL);
> +		if (!pmx->functions)
> +			return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


