Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D356B745A93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGCKtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGCKtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:49:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35C3CB2;
        Mon,  3 Jul 2023 03:49:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CF462F4;
        Mon,  3 Jul 2023 03:49:56 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ABA73F762;
        Mon,  3 Jul 2023 03:49:12 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:49:10 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
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
Message-ID: <ZKKnpqaI1zS67zWM@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43109a0f2f362222fca79e2afd15c46ed9a32977.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:28PM +0000, Oleksii Moisieiev wrote:
> scmi-pinctrl driver implements pinctrl driver interface and using
> SCMI protocol to redirect messages from pinctrl subsystem SDK to
> SCP firmware, which does the changes in HW.

I would drop any reference to SCP, which is a reference implementation
BUT not neccesarily the only one.... "SCMI platform firware" should be
generic enough.

> 
> This setup expects SCP firmware (or similar system, such as ATF)
> to be installed on the platform, which implements pinctrl driver
> for the specific platform.
> 
> SCMI-Pinctrl driver should be configured from the device-tree and uses
> generic device-tree mappings for the configuration.

This should be obvious, I would drop any reference to the fact that you
need an SCMI server somewhere replying to your requests and to the need
of a DT configuration thing which is anyeway standard.

> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  MAINTAINERS                    |   1 +
>  drivers/pinctrl/Kconfig        |  11 +
>  drivers/pinctrl/Makefile       |   1 +
>  drivers/pinctrl/pinctrl-scmi.c | 554 +++++++++++++++++++++++++++++++++
>  4 files changed, 567 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-scmi.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 297b2512963d..91883955fc1a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20527,6 +20527,7 @@ M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>  L:	linux-arm-kernel@lists.infradead.org
>  S:	Maintained
>  F:	drivers/firmware/arm_scmi/pinctrl.c
> +F:	drivers/pinctrl/pinctrl-scmi.c
>  
>  SYSTEM RESET/SHUTDOWN DRIVERS
>  M:	Sebastian Reichel <sre@kernel.org>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 5787c579dcf6..c4680a2c5e13 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -546,4 +546,15 @@ source "drivers/pinctrl/uniphier/Kconfig"
>  source "drivers/pinctrl/visconti/Kconfig"
>  source "drivers/pinctrl/vt8500/Kconfig"
>  
> +config PINCTRL_SCMI
> +	tristate "Pinctrl driver controlled via SCMI interface"

"using SCMI protocol interface" maybe is more fitting...it is the pin
that is controlled via SCMI not the driver, which is indeed the
controller of the pin via SCMI O_o

> +	depends on ARM_SCMI_PROTOCOL || COMPILE_TEST
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	help
> +	  This driver provides support for pinctrl which is controlled
> +	  by firmware that implements the SCMI interface.
> +	  It uses SCMI Message Protocol to interact with the
> +	  firmware providing all the pinctrl controls.
> +
>  endif
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index e196c6e324ad..b932a116e6a0 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_PINCTRL_SX150X)	+= pinctrl-sx150x.o
>  obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
>  obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
>  obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
> +obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
>  

Probably needs to be alphabetically ordered.

>  obj-y				+= actions/
>  obj-$(CONFIG_ARCH_ASPEED)	+= aspeed/
> diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
> new file mode 100644
> index 000000000000..e46dffa652c6
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-scmi.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Power Interface (SCMI) Protocol based pinctrl driver
> + *
> + * Copyright (C) 2023 EPAM
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/seq_file.h>
> +#include <linux/scmi_protocol.h>
> +#include <linux/slab.h>
> +
> +#include <linux/pinctrl/machine.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +
> +#include "pinctrl-utils.h"
> +#include "core.h"
> +#include "pinconf.h"
> +
> +#define DRV_NAME "scmi-pinctrl"
> +
> +static const struct scmi_pinctrl_proto_ops *pinctrl_ops;
> +
> +struct scmi_pinctrl_funcs {
> +	unsigned int num_groups;
> +	const char **groups;
> +};
> +
> +struct scmi_pinctrl {
> +	struct device *dev;
> +	struct scmi_protocol_handle *ph;
> +	struct pinctrl_dev *pctldev;
> +	struct pinctrl_desc pctl_desc;
> +	struct scmi_pinctrl_funcs *functions;
> +	unsigned int nr_functions;
> +	char **groups;
> +	unsigned int nr_groups;
> +	struct pinctrl_pin_desc *pins;
> +	unsigned int nr_pins;
> +};
> +
> +static int pinctrl_scmi_get_groups_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

This check is superfluos right ? If you registered successfully with the
Pinctrl subsys and you passed your pmx driver_data as properly
initialized in _probe you can never get a NULL here for pmx or pmx->ph.

> +
> +	return pinctrl_ops->get_count(pmx->ph, GROUP_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_group_name(struct pinctrl_dev *pctldev,
> +					       unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return NULL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return NULL;
> +

Ditto.

> +	ret = pinctrl_ops->get_name(pmx->ph, selector, GROUP_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_group_pins(struct pinctrl_dev *pctldev,
> +				       unsigned int selector,
> +				       const unsigned int **pins,
> +				       unsigned int *num_pins)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;
> +

Ditto.

> +	return pinctrl_ops->get_group_pins(pmx->ph, selector,
> +					   pins, num_pins);
> +}
> +
> +#ifdef CONFIG_OF
> +static int pinctrl_scmi_dt_node_to_map(struct pinctrl_dev *pctldev,
> +				       struct device_node *np_config,
> +				       struct pinctrl_map **map,
> +				       u32 *num_maps)
> +{
> +	return pinconf_generic_dt_node_to_map(pctldev, np_config, map,
> +					      num_maps, PIN_MAP_TYPE_INVALID);
> +}
> +
> +static void pinctrl_scmi_dt_free_map(struct pinctrl_dev *pctldev,
> +				     struct pinctrl_map *map, u32 num_maps)
> +{
> +	kfree(map);
> +}
> +
> +#endif /* CONFIG_OF */
> +
> +static const struct pinctrl_ops pinctrl_scmi_pinctrl_ops = {
> +	.get_groups_count = pinctrl_scmi_get_groups_count,
> +	.get_group_name = pinctrl_scmi_get_group_name,
> +	.get_group_pins = pinctrl_scmi_get_group_pins,
> +#ifdef CONFIG_OF
> +	.dt_node_to_map = pinctrl_scmi_dt_node_to_map,
> +	.dt_free_map = pinctrl_scmi_dt_free_map,
> +#endif
> +};
> +
> +static int pinctrl_scmi_get_functions_count(struct pinctrl_dev *pctldev)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;
> +

Ditto.

> +	return pinctrl_ops->get_count(pmx->ph, FUNCTION_TYPE);
> +}
> +
> +static const char *pinctrl_scmi_get_function_name(struct pinctrl_dev *pctldev,
> +						  unsigned int selector)
> +{
> +	int ret;
> +	const char *name;
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return NULL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return NULL;
> +

Ditto.

> +	ret = pinctrl_ops->get_name(pmx->ph, selector, FUNCTION_TYPE, &name);
> +	if (ret) {
> +		dev_err(pmx->dev, "get name failed with err %d", ret);
> +		return NULL;
> +	}
> +
> +	return name;
> +}
> +
> +static int pinctrl_scmi_get_function_groups(struct pinctrl_dev *pctldev,
> +					    unsigned int selector,
> +					    const char * const **groups,
> +					    unsigned int * const num_groups)
> +{
> +	const unsigned int *group_ids;
> +	int ret, i;
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !groups || !num_groups)
> +		return -EINVAL;
> +

Ditto for pmx/pmx->ph.

> +	if (selector < pmx->nr_functions &&
> +	    pmx->functions[selector].num_groups) {
> +		*groups = (const char * const *)pmx->functions[selector].groups;
> +		*num_groups = pmx->functions[selector].num_groups;
> +		return 0;
> +	}
> +
> +	ret = pinctrl_ops->get_function_groups(pmx->ph, selector,
> +					       &pmx->functions[selector].num_groups,
> +					       &group_ids);
> +	if (ret) {
> +		dev_err(pmx->dev, "Unable to get function groups, err %d", ret);
> +		return ret;
> +	}
> +
> +	*num_groups = pmx->functions[selector].num_groups;
> +	if (!*num_groups)
> +		return -EINVAL;
> +
> +	pmx->functions[selector].groups =
> +		devm_kcalloc(pmx->dev, *num_groups,
> +			     sizeof(*pmx->functions[selector].groups),
> +			     GFP_KERNEL);
> +	if (!pmx->functions[selector].groups)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < *num_groups; i++) {
> +		pmx->functions[selector].groups[i] =
> +			pinctrl_scmi_get_group_name(pmx->pctldev,
> +						    group_ids[i]);
> +		if (!pmx->functions[selector].groups[i]) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
> +	*groups = (const char * const *)pmx->functions[selector].groups;
> +
> +	return 0;
> +
> +error:
> +	devm_kfree(pmx->dev, pmx->functions[selector].groups);
> +
> +	return ret;
> +}
> +
> +static int pinctrl_scmi_func_set_mux(struct pinctrl_dev *pctldev,
> +				     unsigned int selector, unsigned int group)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

Ditto.

> +
> +	return pinctrl_ops->set_mux(pmx->ph, selector, group);
> +}
> +
> +static int pinctrl_scmi_request(struct pinctrl_dev *pctldev,
> +				unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

Ditto.

> +
> +	return pinctrl_ops->request_pin(pmx->ph, offset);
> +}
> +
> +static int pinctrl_scmi_free(struct pinctrl_dev *pctldev, unsigned int offset)
> +{
> +	struct scmi_pinctrl *pmx;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

Ditto.

> +
> +	return pinctrl_ops->free_pin(pmx->ph, offset);
> +}
> +
> +static const struct pinmux_ops pinctrl_scmi_pinmux_ops = {
> +	.request = pinctrl_scmi_request,
> +	.free = pinctrl_scmi_free,
> +	.get_functions_count = pinctrl_scmi_get_functions_count,
> +	.get_function_name = pinctrl_scmi_get_function_name,
> +	.get_function_groups = pinctrl_scmi_get_function_groups,
> +	.set_mux = pinctrl_scmi_func_set_mux,
> +};
> +
> +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !config)
> +		return -EINVAL;
> +

Ditto for pmx/pmx->ph.

> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_ops->get_config(pmx->ph, _pin, PIN_TYPE, config_type,
> +				      &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> +				    unsigned int _pin,
> +				    unsigned long *configs,
> +				    unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !configs || num_configs == 0)
> +		return -EINVAL;

Ditto for pmx/pmx->ph.

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
> +
> +static int pinctrl_scmi_pinconf_group_set(struct pinctrl_dev *pctldev,
> +					  unsigned int group,
> +					  unsigned long *configs,
> +					  unsigned int num_configs)
> +{
> +	int i, ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !configs || num_configs == 0)
> +		return -EINVAL;

Ditto for pmx/pmx->ph.

> +
> +	for (i = 0; i < num_configs; i++) {
> +		config_type = pinconf_to_config_param(configs[i]);
> +		config_value = pinconf_to_config_argument(configs[i]);
> +
> +		ret = pinctrl_ops->set_config(pmx->ph, group, GROUP_TYPE,
> +					      config_type, config_value);
> +		if (ret) {
> +			dev_err(pmx->dev, "Error parsing config = %ld",
> +				configs[i]);
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +};
> +
> +static int pinctrl_scmi_pinconf_group_get(struct pinctrl_dev *pctldev,
> +					  unsigned int _pin,
> +					  unsigned long *config)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx;
> +	enum pin_config_param config_type;
> +	unsigned long config_value;
> +
> +	if (!pctldev)
> +		return -EINVAL;
> +
> +	pmx = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (!pmx || !pmx->ph || !config)
> +		return -EINVAL;

Ditto for pmx/pmx->ph.

> +
> +	config_type = pinconf_to_config_param(*config);
> +
> +	ret = pinctrl_ops->get_config(pmx->ph, _pin, GROUP_TYPE,
> +				      config_type, &config_value);
> +	if (ret)
> +		return ret;
> +
> +	*config = pinconf_to_config_packed(config_type, config_value);
> +
> +	return 0;
> +}
> +
> +static const struct pinconf_ops pinctrl_scmi_pinconf_ops = {
> +	.is_generic = true,
> +	.pin_config_get = pinctrl_scmi_pinconf_get,
> +	.pin_config_set = pinctrl_scmi_pinconf_set,
> +	.pin_config_group_set = pinctrl_scmi_pinconf_group_set,
> +	.pin_config_group_get = pinctrl_scmi_pinconf_group_get,
> +	.pin_config_config_dbg_show = pinconf_generic_dump_config,
> +};
> +
> +static int pinctrl_scmi_get_pins(struct scmi_pinctrl *pmx,
> +				 unsigned int *nr_pins,
> +				 const struct pinctrl_pin_desc **pins)
> +{
> +	int ret, i;
> +
> +	if (!pmx || !pmx->ph)
> +		return -EINVAL;

Ditto.

> +
> +	if (!pins || !nr_pins)
> +		return -EINVAL;
> +
> +	if (pmx->nr_pins) {
> +		*pins = pmx->pins;
> +		*nr_pins = pmx->nr_pins;
> +		return 0;
> +	}
> +
> +	*nr_pins = pinctrl_ops->get_count(pmx->ph, PIN_TYPE);
> +
> +	pmx->nr_pins = *nr_pins;
> +	pmx->pins = devm_kmalloc_array(pmx->dev, *nr_pins, sizeof(*pmx->pins),
> +				       GFP_KERNEL);
> +	if (!pmx->pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < *nr_pins; i++) {
> +		pmx->pins[i].number = i;
> +		ret = pinctrl_ops->get_name(pmx->ph, i, PIN_TYPE,
> +					    &pmx->pins[i].name);
> +		if (ret) {
> +			dev_err(pmx->dev, "Can't get name for pin %d: rc %d",
> +				i, ret);
> +			goto err_free;
> +		}
> +	}
> +
> +	*pins = pmx->pins;
> +	dev_dbg(pmx->dev, "got pins %d", *nr_pins);
> +
> +	return 0;
> + err_free:
> +	devm_kfree(pmx->dev, pmx->pins);
> +	pmx->nr_pins = 0;
> +
> +	return ret;
> +}
> +
> +static const struct scmi_device_id scmi_id_table[] = {
> +	{ SCMI_PROTOCOL_PINCTRL, "pinctrl" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(scmi, scmi_id_table);
> +
> +static int scmi_pinctrl_probe(struct scmi_device *sdev)
> +{
> +	int ret;
> +	struct scmi_pinctrl *pmx;
> +	const struct scmi_handle *handle;
> +	struct scmi_protocol_handle *ph;
> +
> +	if (!sdev || !sdev->handle)
> +		return -EINVAL;
> +
> +	handle = sdev->handle;
> +
> +	pinctrl_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PINCTRL, &ph);
> +	if (IS_ERR(pinctrl_ops))
> +		return PTR_ERR(pinctrl_ops);
> +
> +	pmx = devm_kzalloc(&sdev->dev, sizeof(*pmx), GFP_KERNEL);
> +	if (!pmx)
> +		return -ENOMEM;
> +
> +	pmx->ph = ph;
> +
> +	pmx->dev = &sdev->dev;
> +	pmx->pctl_desc.name = DRV_NAME;
> +	pmx->pctl_desc.owner = THIS_MODULE;
> +	pmx->pctl_desc.pctlops = &pinctrl_scmi_pinctrl_ops;
> +	pmx->pctl_desc.pmxops = &pinctrl_scmi_pinmux_ops;
> +	pmx->pctl_desc.confops = &pinctrl_scmi_pinconf_ops;
> +
> +	ret = pinctrl_scmi_get_pins(pmx, &pmx->pctl_desc.npins,
> +				    &pmx->pctl_desc.pins);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_pinctrl_register_and_init(&sdev->dev, &pmx->pctl_desc, pmx,
> +					     &pmx->pctldev);
> +	if (ret) {
> +		dev_err_probe(&sdev->dev, ret, "Failed to register pinctrl\n");
> +		return ret;
> +	}
> +
> +	pmx->nr_functions = pinctrl_scmi_get_functions_count(pmx->pctldev);
> +	pmx->nr_groups = pinctrl_scmi_get_groups_count(pmx->pctldev);
> +
> +	if (pmx->nr_functions) {
> +		pmx->functions =
> +			devm_kcalloc(&sdev->dev, pmx->nr_functions,
> +				     sizeof(*pmx->functions),
> +				     GFP_KERNEL);
> +		if (!pmx->functions)
> +			return -ENOMEM;
> +	}
> +
> +	if (pmx->nr_groups) {
> +		pmx->groups =
> +			devm_kcalloc(&sdev->dev, pmx->nr_groups,
> +				     sizeof(*pmx->groups),
> +				     GFP_KERNEL);
> +		if (!pmx->groups)
> +			return -ENOMEM;
> +	}
> +
> +	return pinctrl_enable(pmx->pctldev);
> +}
> +
> +static struct scmi_driver scmi_pinctrl_driver = {
> +	.name = DRV_NAME,
> +	.probe = scmi_pinctrl_probe,
> +	.id_table = scmi_id_table,
> +};
> +module_scmi_driver(scmi_pinctrl_driver);
> +

Thanks,
Cristian
