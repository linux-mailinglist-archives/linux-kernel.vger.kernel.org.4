Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CFE6DEB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjDLGOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLGO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:14:29 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D2840D8;
        Tue, 11 Apr 2023 23:14:27 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id F1D8924E208;
        Wed, 12 Apr 2023 14:14:20 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:14:20 +0800
Received: from [192.168.125.108] (113.72.145.176) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 12 Apr
 2023 14:14:19 +0800
Message-ID: <89b1dab7-c7a1-4e99-e70d-1cd24b9e2654@starfivetech.com>
Date:   Wed, 12 Apr 2023 14:14:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 6/7] usb: cdns3: add StarFive JH7110 USB driver.
Content-Language: en-US
To:     Peter Chen <peter.chen@kernel.org>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Mason Huo" <mason.huo@starfivetech.com>
References: <20230406015216.27034-1-minda.chen@starfivetech.com>
 <20230406015216.27034-7-minda.chen@starfivetech.com>
 <20230411010157.GA2211844@nchen-desktop>
From:   Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20230411010157.GA2211844@nchen-desktop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/11 9:01, Peter Chen wrote:
> On 23-04-06 09:52:15, Minda Chen wrote:
>> Adds Specific Glue layer to support USB peripherals on
>> StarFive JH7110 SoC.
>> There is a Cadence USB3 core for JH7110 SoCs, the cdns
>> core is the child of this USB wrapper module device.
>> 
>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>> ---
>>  MAINTAINERS                        |   7 +
>>  drivers/usb/cdns3/Kconfig          |  11 +
>>  drivers/usb/cdns3/Makefile         |   1 +
>>  drivers/usb/cdns3/cdns3-starfive.c | 378 +++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/core.h           |   3 +
>>  5 files changed, 400 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/cdns3-starfive.c
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d98b70d62fd4..0610bbf921bb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19977,6 +19977,13 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
>>  F:	drivers/phy/starfive/phy-jh7110-pcie.c
>>  F:	drivers/phy/starfive/phy-jh7110-usb.c
>>  
>> +STARFIVE JH71X0 USB DRIVERS
>> +M:	Emil Renner Berthing <kernel@esmil.dk>
>> +M:	Minda Chen <minda.chen@starfivetech.com>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/usb/starfive,jh7110-usb.yaml
>> +F:	drivers/usb/cdns3/cdns3-starfive.c
>> +
>>  STATIC BRANCH/CALL
>>  M:	Peter Zijlstra <peterz@infradead.org>
>>  M:	Josh Poimboeuf <jpoimboe@kernel.org>
>> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
>> index b98ca0a1352a..0a514b591527 100644
>> --- a/drivers/usb/cdns3/Kconfig
>> +++ b/drivers/usb/cdns3/Kconfig
>> @@ -78,6 +78,17 @@ config USB_CDNS3_IMX
>>  
>>  	  For example, imx8qm and imx8qxp.
>>  
>> +config USB_CDNS3_STARFIVE
>> +	tristate "Cadence USB3 support on StarFive SoC platforms"
>> +	depends on ARCH_STARFIVE || COMPILE_TEST
>> +	help
>> +	  Say 'Y' or 'M' here if you are building for StarFive SoCs
>> +	  platforms that contain Cadence USB3 controller core.
>> +
>> +	  e.g. JH7110.
>> +
>> +	  If you choose to build this driver as module it will
>> +	  be dynamically linked and module will be called cdns3-starfive.ko
>>  endif
>>  
>>  if USB_CDNS_SUPPORT
>> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
>> index 61edb2f89276..48dfae75b5aa 100644
>> --- a/drivers/usb/cdns3/Makefile
>> +++ b/drivers/usb/cdns3/Makefile
>> @@ -24,6 +24,7 @@ endif
>>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)		+= cdns3-pci-wrap.o
>>  obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
>>  obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
>> +obj-$(CONFIG_USB_CDNS3_STARFIVE)		+= cdns3-starfive.o
>>  
>>  cdnsp-udc-pci-y					:= cdnsp-pci.o
>>  
>> diff --git a/drivers/usb/cdns3/cdns3-starfive.c b/drivers/usb/cdns3/cdns3-starfive.c
>> new file mode 100644
>> index 000000000000..925209a97bf9
>> --- /dev/null
>> +++ b/drivers/usb/cdns3/cdns3-starfive.c
>> @@ -0,0 +1,378 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * cdns3-starfive.c - StarFive specific Glue layer for Cadence USB Controller
>> + *
>> + * Copyright (C) 2022 Starfive, Inc.
>> + * Author:	Yanhong Wang <yanhong.wang@starfivetech.com>
>> + * Author:	Mason Huo <mason.huo@starfivetech.com>
>> + * Author:	Minda Chen <minda.chen@starfivetech.com>
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/module.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/io.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/regmap.h>
>> +#include <linux/reset.h>
>> +#include <linux/usb/otg.h>
>> +#include "core.h"
>> +
>> +#define USB_STRAP_HOST			BIT(17)
>> +#define USB_STRAP_DEVICE		BIT(18)
>> +#define USB_STRAP_MASK			GENMASK(18, 16)
>> +
>> +#define USB_SUSPENDM_HOST		BIT(19)
>> +#define USB_SUSPENDM_MASK		BIT(19)
>> +#define CDNS_IRQ_WAKEUP_INDEX		3
>> +
>> +struct cdns_starfive {
>> +	struct device *dev;
>> +	struct phy *usb2_phy;
>> +	struct phy *usb3_phy;
>> +	struct regmap *stg_syscon;
>> +	struct reset_control *resets;
>> +	struct clk_bulk_data *clks;
>> +	int num_clks;
>> +	enum phy_mode phy_mode;
>> +	u32 stg_usb_mode;
>> +};
>> +
>> +static int set_phy_power_on(struct cdns_starfive *data)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_power_on(data->usb2_phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_power_on(data->usb3_phy);
>> +	if (ret)
>> +		phy_power_off(data->usb2_phy);
>> +
>> +	return ret;
>> +}
>> +
>> +static void set_phy_power_off(struct cdns_starfive *data)
>> +{
>> +	phy_power_off(data->usb3_phy);
>> +	phy_power_off(data->usb2_phy);
>> +}
>> +
>> +static void cdns_mode_init(struct platform_device *pdev,
>> +				struct cdns_starfive *data)
>> +{
>> +	enum usb_dr_mode mode;
>> +
>> +	mode = usb_get_dr_mode(&pdev->dev);
>> +
>> +	switch (mode) {
>> +	case USB_DR_MODE_HOST:
>> +		regmap_update_bits(data->stg_syscon,
>> +			data->stg_usb_mode,
>> +			USB_STRAP_MASK,
>> +			USB_STRAP_HOST);
>> +		regmap_update_bits(data->stg_syscon,
>> +			data->stg_usb_mode,
>> +			USB_SUSPENDM_MASK,
>> +			USB_SUSPENDM_HOST);
>> +		data->phy_mode = PHY_MODE_USB_HOST;
>> +		break;
>> +
>> +	case USB_DR_MODE_PERIPHERAL:
>> +		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
>> +			USB_STRAP_MASK, USB_STRAP_DEVICE);
>> +		regmap_update_bits(data->stg_syscon, data->stg_usb_mode,
>> +			USB_SUSPENDM_MASK, 0);
>> +		data->phy_mode = PHY_MODE_USB_DEVICE;
>> +		break;
>> +
>> +	case USB_DR_MODE_OTG:
>> +		data->phy_mode = PHY_MODE_USB_OTG;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +static int cdns_clk_rst_init(struct cdns_starfive *data)
>> +{
>> +	int ret;
>> +
>> +	data->num_clks = devm_clk_bulk_get_all(data->dev, &data->clks);
>> +	if (data->num_clks < 0)
>> +		return dev_err_probe(data->dev, -ENODEV,
>> +			"Failed to get clocks\n");
>> +
>> +	data->resets = devm_reset_control_array_get_exclusive(data->dev);
>> +	if (IS_ERR(data->resets)) {
>> +		return dev_err_probe(data->dev, PTR_ERR(data->resets),
>> +			"Failed to get resets");
>> +	}
>> +
>> +	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
>> +	if (ret)
>> +		return dev_err_probe(data->dev, ret,
>> +			"failed to enable clocks\n");
>> +
>> +	ret = reset_control_deassert(data->resets);
>> +	if (ret) {
>> +		ret = dev_err_probe(data->dev, ret,
>> +			"failed to reset clocks\n");
>> +		goto err_clk_init;
>> +	}
>> +
>> +	return ret;
>> +
>> +err_clk_init:
>> +	clk_bulk_disable_unprepare(data->num_clks, data->clks);
>> +	return ret;
>> +}
>> +
>> +static int cdns3_starfive_phy_init(struct device *dev, struct cdns_starfive *data)
>> +{
>> +	int ret;
>> +
>> +	ret = phy_init(data->usb2_phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = phy_init(data->usb3_phy);
>> +	if (ret)
>> +		goto err_phy3_init;
>> +
>> +	ret = set_phy_power_on(data);
>> +	if (ret)
>> +		goto err_phy_power_on;
>> +
>> +	phy_set_mode(data->usb2_phy, data->phy_mode);
>> +	phy_set_mode(data->usb3_phy, data->phy_mode);
>> +
>> +	return 0;
>> +
>> +err_phy_power_on:
>> +	phy_exit(data->usb3_phy);
>> +err_phy3_init:
>> +	phy_exit(data->usb2_phy);
>> +	return ret;
>> +}
>> +
>> +static int cdns3_starfive_platform_device_add(struct platform_device *pdev,
>> +		struct cdns_starfive *data)
>> +{
>> +	struct platform_device *cdns3;
>> +	struct resource	cdns_res[CDNS_RESOURCES_NUM], *res;
>> +	struct device *dev = &pdev->dev;
>> +	const char *reg_name[CDNS_IOMEM_RESOURCES_NUM] = {"otg", "xhci", "dev"};
>> +	const char *irq_name[CDNS_IRQ_RESOURCES_NUM] = {"host", "peripheral", "otg", "wakeup"};
>> +	int i, ret, res_idx = 0;
>> +
>> +	cdns3 = platform_device_alloc("cdns-usb3", PLATFORM_DEVID_AUTO);
>> +	if (!cdns3)
>> +		return dev_err_probe(dev, -ENOMEM,
>> +			"couldn't alloc cdns3 usb device\n");
>> +
>> +	cdns3->dev.parent = dev;
>> +	memset(cdns_res, 0, sizeof(cdns_res));
>> +
>> +	for (i = 0; i < CDNS_IOMEM_RESOURCES_NUM; i++) {
>> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, reg_name[i]);
>> +		if (!res) {
>> +			ret = dev_err_probe(dev,
>> +				-ENXIO, "couldn't get %s reg resource\n", reg_name[i]);
>> +			goto free_memory;
>> +		}
>> +		cdns_res[res_idx] = *res;
>> +		res_idx++;
>> +	}
>> +
>> +	for (i = 0; i < CDNS_IRQ_RESOURCES_NUM; i++) {
>> +		if (i == CDNS_IRQ_WAKEUP_INDEX) {
>> +			ret = platform_get_irq_byname_optional(pdev, irq_name[i]);
>> +			if (ret < 0)
>> +				continue;
>> +		} else {
>> +			ret = platform_get_irq_byname(pdev, irq_name[i]);
>> +			if (ret < 0) {
>> +				dev_err(dev, "couldn't get %s irq\n", irq_name[i]);
>> +				goto free_memory;
>> +			}
>> +		}
>> +		cdns_res[res_idx].start = ret;
>> +		cdns_res[res_idx].end = ret;
>> +		cdns_res[res_idx].flags = IORESOURCE_IRQ;
>> +		cdns_res[res_idx].name = irq_name[i];
>> +		res_idx++;
>> +	}
>> +
>> +	ret = platform_device_add_resources(cdns3, cdns_res, res_idx);
>> +	if (ret) {
>> +		dev_err(dev, "couldn't add res to cdns3 device\n");
>> +		goto free_memory;
>> +	}
>> +
>> +	ret = platform_device_add(cdns3);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register cdns3 device\n");
>> +		goto free_memory;
>> +	}
>> +
>> +	return ret;
>> +free_memory:
>> +	platform_device_put(cdns3);
>> +	return ret;
>> +}
>> +
>> +static int cdns_starfive_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cdns_starfive *data;
>> +	unsigned int args;
>> +	int ret;
>> +
>> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	data->dev = dev;
>> +
>> +	data->stg_syscon = syscon_regmap_lookup_by_phandle_args(pdev->dev.of_node,
>> +		"starfive,stg-syscon", 1, &args);
>> +
>> +	if (IS_ERR(data->stg_syscon))
>> +		return dev_err_probe(dev, PTR_ERR(data->stg_syscon),
>> +			"Failed to parse starfive,stg-syscon\n");
>> +
>> +	data->stg_usb_mode = args;
>> +
>> +	cdns_mode_init(pdev, data);
>> +
>> +	ret = cdns_clk_rst_init(data);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data->usb2_phy = devm_phy_optional_get(dev, "usb2-phy");
>> +	if (IS_ERR(data->usb2_phy))
>> +		return dev_err_probe(dev, PTR_ERR(data->usb2_phy),
>> +			"Failed to parse usb2 phy\n");
>> +
>> +	data->usb3_phy = devm_phy_optional_get(dev, "usb3-phy");
>> +	if (IS_ERR(data->usb3_phy))
>> +		return dev_err_probe(dev, PTR_ERR(data->usb3_phy),
>> +			"Failed to parse usb3 phy\n");
>> +
> 
> You may not change the comment for if above functions are failed, there
> is not opposite functions for clk and reset.
> 
> Others are okay for me.
> 
> Peter
> 
OK, I will change this. Thank you very much.
>> +	cdns3_starfive_phy_init(dev, data);
>> +
>> +	ret = cdns3_starfive_platform_device_add(pdev, data);
>> +	if (ret) {
>> +		set_phy_power_off(data);
>> +		phy_exit(data->usb3_phy);
>> +		phy_exit(data->usb2_phy);
>> +		reset_control_assert(data->resets);
>> +		clk_bulk_disable_unprepare(data->num_clks, data->clks);
>> +		return dev_err_probe(dev, ret, "Failed to create children\n");
>> +	}
>> +
>> +	device_set_wakeup_capable(dev, true);
>> +	pm_runtime_set_active(dev);
>> +	pm_runtime_enable(dev);
>> +
>> +	dev_info(dev, "usb mode %d probe success\n", data->phy_mode);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cdns_starfive_remove_core(struct device *dev, void *c)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +
>> +	platform_device_unregister(pdev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int cdns_starfive_remove(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cdns_starfive *data = dev_get_drvdata(dev);
>> +
>> +	pm_runtime_get_sync(dev);
>> +	device_for_each_child(dev, NULL, cdns_starfive_remove_core);
>> +
>> +	set_phy_power_off(data);
>> +	phy_exit(data->usb2_phy);
>> +	phy_exit(data->usb3_phy);
>> +
>> +	reset_control_assert(data->resets);
>> +	clk_bulk_disable_unprepare(data->num_clks, data->clks);
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_put_noidle(dev);
>> +	platform_set_drvdata(pdev, NULL);
>> +
>> +	return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int cdns_starfive_resume(struct device *dev)
>> +{
>> +	struct cdns_starfive *data = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	ret = clk_bulk_prepare_enable(data->num_clks, data->clks);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = reset_control_deassert(data->resets);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = cdns3_starfive_phy_init(dev, data);
>> +
>> +	return ret;
>> +}
>> +
>> +static int cdns_starfive_suspend(struct device *dev)
>> +{
>> +	struct cdns_starfive *data = dev_get_drvdata(dev);
>> +
>> +	set_phy_power_off(data);
>> +	phy_exit(data->usb2_phy);
>> +	phy_exit(data->usb3_phy);
>> +	reset_control_assert(data->resets);
>> +	clk_bulk_disable_unprepare(data->num_clks, data->clks);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops cdns_starfive_pm_ops = {
>> +	SET_RUNTIME_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume, NULL)
>> +	SET_SYSTEM_SLEEP_PM_OPS(cdns_starfive_suspend, cdns_starfive_resume)
>> +};
>> +
>> +static const struct of_device_id cdns_starfive_of_match[] = {
>> +	{ .compatible = "starfive,jh7110-usb", },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, cdns_starfive_of_match);
>> +
>> +static struct platform_driver cdns_starfive_driver = {
>> +	.probe		= cdns_starfive_probe,
>> +	.remove		= cdns_starfive_remove,
>> +	.driver		= {
>> +		.name	= "cdns3-starfive",
>> +		.of_match_table	= cdns_starfive_of_match,
>> +		.pm	= &cdns_starfive_pm_ops,
>> +	},
>> +};
>> +module_platform_driver(cdns_starfive_driver);
>> +
>> +MODULE_ALIAS("platform:cdns3-starfive");
>> +MODULE_AUTHOR("YanHong Wang <yanhong.wang@starfivetech.com>");
>> +MODULE_AUTHOR("Mason Huo <mason.huo@starfivetech.com>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("Cadence USB3 StarFive Glue Layer");
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 2d332a788871..8d44ab504898 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -38,6 +38,9 @@ struct cdns_role_driver {
>>  };
>>  
>>  #define CDNS_XHCI_RESOURCES_NUM	2
>> +#define CDNS_IOMEM_RESOURCES_NUM	3
>> +#define CDNS_IRQ_RESOURCES_NUM		4
>> +#define CDNS_RESOURCES_NUM	(CDNS_IOMEM_RESOURCES_NUM + CDNS_IRQ_RESOURCES_NUM)
>>  
>>  struct cdns3_platform_data {
>>  	int (*platform_suspend)(struct device *dev,
>> -- 
>> 2.17.1
>> 
> 
