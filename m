Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967666DCF8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjAQL4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjAQL41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:56:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529BD166CB;
        Tue, 17 Jan 2023 03:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673956586; x=1705492586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gcnv7FtGXifpk5G8wjofQlyYGroL3+TkMBNsDwKKrQI=;
  b=cL2avsgCpLWpUC7J2oA1lqUoWb27YJ0hPJh0p5233slMizyecsntduzQ
   rErdTuODzbSRAc7Iux5LX5FCZ5YeNFKinm30msrsjM3ygHBp/PqYZYYoo
   PXbaOAmsTMxW2/3fBI96Fzf8smi3KdidCxnJ9bvlUFvWB9gSYsxt52ew6
   9vxB0vyRex68YxQLmkgximog58B1TcyrE5kx+/s6xsh+2btbF9H1Urc6G
   xeWHnJYcJxBR1BfAwC2tIEcNpAxq/wO97+L6+xpjGSxDMrqpFCYeMMEqq
   E13Fi4PoInGeciRUD1I33OzMdPzSLs8SVHN8DP0mxGDpxQSL14lcrNgPi
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="387026941"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="387026941"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 03:56:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801720509"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801720509"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 17 Jan 2023 03:56:19 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 17 Jan 2023 13:56:18 +0200
Date:   Tue, 17 Jan 2023 13:56:18 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: mux: Introduce GPIO-based SBU mux
Message-ID: <Y8aM4kTCphTfEszc@kuha.fi.intel.com>
References: <20230113041115.4189210-1-quic_bjorande@quicinc.com>
 <20230113041115.4189210-2-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113041115.4189210-2-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 08:11:15PM -0800, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> A design found in various Qualcomm-based boards is to use a USB switch,
> controlled through a pair of GPIO lines to connect, disconnect and
> switch the orientation of the SBU lines in USB Type-C applications.
> 
> This introduces a generic driver, which implements the typec_switch and
> typec_mux interfaces to perform these operations.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Changes since v1:
> - Fixed "swapped" being uninitialized for TYPEC_ORIENTATION_NONE in switch_set
> 
>  drivers/usb/typec/mux/Kconfig        |   6 +
>  drivers/usb/typec/mux/Makefile       |   1 +
>  drivers/usb/typec/mux/gpio-sbu-mux.c | 172 +++++++++++++++++++++++++++
>  3 files changed, 179 insertions(+)
>  create mode 100644 drivers/usb/typec/mux/gpio-sbu-mux.c
> 
> diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> index 5eb2c17d72c1..c46fa4f9d3df 100644
> --- a/drivers/usb/typec/mux/Kconfig
> +++ b/drivers/usb/typec/mux/Kconfig
> @@ -12,6 +12,12 @@ config TYPEC_MUX_FSA4480
>  	  common USB Type-C connector.
>  	  If compiled as a module, the module will be named fsa4480.
>  
> +config TYPEC_MUX_GPIO_SBU
> +	tristate "Generic GPIO based SBU mux for USB Type-C applications"
> +	help
> +	  Say Y or M if your system uses a GPIO based mux for managing the
> +	  connected state and the swapping of the SBU lines in a Type-C port.
> +
>  config TYPEC_MUX_PI3USB30532
>  	tristate "Pericom PI3USB30532 Type-C cross switch driver"
>  	depends on I2C
> diff --git a/drivers/usb/typec/mux/Makefile b/drivers/usb/typec/mux/Makefile
> index e52a56c16bfb..dda67e19b58b 100644
> --- a/drivers/usb/typec/mux/Makefile
> +++ b/drivers/usb/typec/mux/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_TYPEC_MUX_FSA4480)		+= fsa4480.o
> +obj-$(CONFIG_TYPEC_MUX_GPIO_SBU)	+= gpio-sbu-mux.o
>  obj-$(CONFIG_TYPEC_MUX_PI3USB30532)	+= pi3usb30532.o
>  obj-$(CONFIG_TYPEC_MUX_INTEL_PMC)	+= intel_pmc_mux.o
> diff --git a/drivers/usb/typec/mux/gpio-sbu-mux.c b/drivers/usb/typec/mux/gpio-sbu-mux.c
> new file mode 100644
> index 000000000000..f62516dafe8f
> --- /dev/null
> +++ b/drivers/usb/typec/mux/gpio-sbu-mux.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Linaro Ltd.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/usb/typec_mux.h>
> +
> +struct gpio_sbu_mux {
> +	struct gpio_desc *enable_gpio;
> +	struct gpio_desc *select_gpio;
> +
> +	struct typec_switch_dev *sw;
> +	struct typec_mux_dev *mux;
> +
> +	struct mutex lock; /* protect enabled and swapped */
> +	bool enabled;
> +	bool swapped;
> +};
> +
> +static int gpio_sbu_switch_set(struct typec_switch_dev *sw,
> +			       enum typec_orientation orientation)
> +{
> +	struct gpio_sbu_mux *sbu_mux = typec_switch_get_drvdata(sw);
> +	bool enabled;
> +	bool swapped;
> +
> +	mutex_lock(&sbu_mux->lock);
> +
> +	enabled = sbu_mux->enabled;
> +	swapped = sbu_mux->swapped;
> +
> +	switch (orientation) {
> +	case TYPEC_ORIENTATION_NONE:
> +		enabled = false;
> +		break;
> +	case TYPEC_ORIENTATION_NORMAL:
> +		swapped = false;
> +		break;
> +	case TYPEC_ORIENTATION_REVERSE:
> +		swapped = true;
> +		break;
> +	}
> +
> +	if (enabled != sbu_mux->enabled)
> +		gpiod_set_value(sbu_mux->enable_gpio, enabled);
> +
> +	if (swapped != sbu_mux->swapped)
> +		gpiod_set_value(sbu_mux->select_gpio, swapped);
> +
> +	sbu_mux->enabled = enabled;
> +	sbu_mux->swapped = swapped;
> +
> +	mutex_unlock(&sbu_mux->lock);
> +
> +	return 0;
> +}
> +
> +static int gpio_sbu_mux_set(struct typec_mux_dev *mux,
> +			    struct typec_mux_state *state)
> +{
> +	struct gpio_sbu_mux *sbu_mux = typec_mux_get_drvdata(mux);
> +
> +	mutex_lock(&sbu_mux->lock);
> +
> +	switch (state->mode) {
> +	case TYPEC_STATE_SAFE:
> +	case TYPEC_STATE_USB:
> +		sbu_mux->enabled = false;
> +		break;
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_D:
> +	case TYPEC_DP_STATE_E:
> +		sbu_mux->enabled = true;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	gpiod_set_value(sbu_mux->enable_gpio, sbu_mux->enabled);
> +
> +	mutex_unlock(&sbu_mux->lock);
> +
> +	return 0;
> +}
> +
> +static int gpio_sbu_mux_probe(struct platform_device *pdev)
> +{
> +	struct typec_switch_desc sw_desc = { };
> +	struct typec_mux_desc mux_desc = { };
> +	struct device *dev = &pdev->dev;
> +	struct gpio_sbu_mux *sbu_mux;
> +
> +	sbu_mux = devm_kzalloc(dev, sizeof(*sbu_mux), GFP_KERNEL);
> +	if (!sbu_mux)
> +		return -ENOMEM;
> +
> +	mutex_init(&sbu_mux->lock);
> +
> +	sbu_mux->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(sbu_mux->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sbu_mux->enable_gpio),
> +				     "unable to acquire enable gpio\n");
> +
> +	sbu_mux->select_gpio = devm_gpiod_get(dev, "select", GPIOD_OUT_LOW);
> +	if (IS_ERR(sbu_mux->select_gpio))
> +		return dev_err_probe(dev, PTR_ERR(sbu_mux->select_gpio),
> +				     "unable to acquire select gpio\n");
> +
> +	sw_desc.drvdata = sbu_mux;
> +	sw_desc.fwnode = dev_fwnode(dev);
> +	sw_desc.set = gpio_sbu_switch_set;
> +
> +	sbu_mux->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(sbu_mux->sw))
> +		return dev_err_probe(dev, PTR_ERR(sbu_mux->sw),
> +				     "failed to register typec switch\n");
> +
> +	mux_desc.drvdata = sbu_mux;
> +	mux_desc.fwnode = dev_fwnode(dev);
> +	mux_desc.set = gpio_sbu_mux_set;
> +
> +	sbu_mux->mux = typec_mux_register(dev, &mux_desc);
> +	if (IS_ERR(sbu_mux->mux)) {
> +		typec_switch_unregister(sbu_mux->sw);
> +		return dev_err_probe(dev, PTR_ERR(sbu_mux->mux),
> +				     "failed to register typec mux\n");
> +	}
> +
> +	platform_set_drvdata(pdev, sbu_mux);
> +
> +	return 0;
> +}
> +
> +static int gpio_sbu_mux_remove(struct platform_device *pdev)
> +{
> +	struct gpio_sbu_mux *sbu_mux = platform_get_drvdata(pdev);
> +
> +	gpiod_set_value(sbu_mux->enable_gpio, 0);
> +
> +	typec_mux_unregister(sbu_mux->mux);
> +	typec_switch_unregister(sbu_mux->sw);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gpio_sbu_mux_match[] = {
> +	{ .compatible = "gpio-sbu-mux", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gpio_sbu_mux_match);
> +
> +static struct platform_driver gpio_sbu_mux_driver = {
> +	.probe = gpio_sbu_mux_probe,
> +	.remove = gpio_sbu_mux_remove,
> +	.driver = {
> +		.name = "gpio_sbu_mux",
> +		.of_match_table = gpio_sbu_mux_match,
> +	},
> +};
> +module_platform_driver(gpio_sbu_mux_driver);
> +
> +MODULE_DESCRIPTION("GPIO based SBU mux driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.37.3

-- 
heikki
