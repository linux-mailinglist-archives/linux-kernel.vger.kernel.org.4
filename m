Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A65709773
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjESMpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjESMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:45:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FF9DED;
        Fri, 19 May 2023 05:45:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C36211FB;
        Fri, 19 May 2023 05:45:45 -0700 (PDT)
Received: from [10.57.73.119] (unknown [10.57.73.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 757123F762;
        Fri, 19 May 2023 05:44:58 -0700 (PDT)
Message-ID: <ac98770b-ad94-1cce-ebe2-d21d5619be9b@arm.com>
Date:   Fri, 19 May 2023 13:44:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH V3 4/6] coresight: etm4x: Change etm4_platform_driver
 driver for MMIO devices
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Cc:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230519052149.1367814-1-anshuman.khandual@arm.com>
 <20230519052149.1367814-5-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230519052149.1367814-5-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 06:21, Anshuman Khandual wrote:
> Add support for handling MMIO based devices via platform driver. We need to
> make sure that :
> 
> 1) The APB clock, if present is enabled at probe and via runtime_pm ops
> 2) Use the ETM4x architecture or CoreSight architecture registers to
>     identify a device as CoreSight ETM4x, instead of relying a white list of
>     "Peripheral IDs"
> 
> The driver doesn't get to handle the devices yet, until we wire the ACPI
> changes to move the devices to be handled via platform driver than the
> etm4_amba driver.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   .../coresight/coresight-etm4x-core.c          | 62 +++++++++++++++++--
>   drivers/hwtracing/coresight/coresight-etm4x.h |  4 ++
>   include/linux/coresight.h                     | 47 ++++++++++++++
>   3 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 914ef6eb85d1..807b3a5a0eda 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -30,6 +30,7 @@
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/property.h>
> +#include <linux/clk/clk-conf.h>
>   
>   #include <asm/barrier.h>
>   #include <asm/sections.h>
> @@ -1073,11 +1074,21 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>   	return true;
>   }
>   
> +static bool is_devtype_cpu_trace(void __iomem *base)
> +{
> +	u32 devtype = readl(base + TRCDEVTYPE);
> +
> +	return (devtype == CS_DEVTYPE_PE_TRACE);
> +}
> +
>   static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>   				   struct csdev_access *csa)
>   {
>   	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
>   
> +	if (!is_coresight_device(drvdata->base) || !is_devtype_cpu_trace(drvdata->base))
> +		return false;
> +
>   	/*
>   	 * All ETMs must implement TRCDEVARCH to indicate that
>   	 * the component is an ETMv4. Even though TRCIDR1 also
> @@ -2135,6 +2146,7 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>   
>   static int etm4_probe_platform_dev(struct platform_device *pdev)
>   {
> +	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	struct etmv4_drvdata *drvdata;
>   	int ret;
>   
> @@ -2142,7 +2154,18 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>   	if (!drvdata)
>   		return -ENOMEM;
>   
> -	drvdata->base = NULL;
> +	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
> +	if (IS_ERR(drvdata->pclk))
> +		return -ENODEV;
> +
> +	if (res) {
> +		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(drvdata->base)) {
> +			clk_put(drvdata->pclk);
> +			return PTR_ERR(drvdata->base);
> +		}
> +	}
> +
>   	dev_set_drvdata(&pdev->dev, drvdata);
>   	pm_runtime_get_noresume(&pdev->dev);
>   	pm_runtime_set_active(&pdev->dev);
> @@ -2188,7 +2211,7 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>   		/*  ETMv4 UCI data */
>   		.devarch	= ETM_DEVARCH_ETMv4x_ARCH,
>   		.devarch_mask	= ETM_DEVARCH_ID_MASK,
> -		.devtype	= 0x00000013,
> +		.devtype	= CS_DEVTYPE_PE_TRACE,
>   	}
>   };
>   
> @@ -2246,6 +2269,10 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>   
>   	if (drvdata)
>   		ret = etm4_remove_dev(drvdata);
> +
> +	if (drvdata->pclk)
> +		clk_put(drvdata->pclk);
> +

Shouldn't this be done *after* pm_runtime_disable() below ?

>   	pm_runtime_disable(&pdev->dev);

>   	return ret;
>   }
> @@ -2286,7 +2313,33 @@ static struct amba_driver etm4x_amba_driver = {
>   	.id_table	= etm4_ids,
>   };
>   
> -static const struct of_device_id etm4_sysreg_match[] = {
> +#ifdef CONFIG_PM
> +static int etm4_runtime_suspend(struct device *dev)
> +{
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	if (!IS_ERR(drvdata->pclk))
> +		clk_disable_unprepare(drvdata->pclk);
> +
> +	return 0;
> +}
> +
> +static int etm4_runtime_resume(struct device *dev)
> +{
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
> +
> +	if (!IS_ERR(drvdata->pclk))
> +		clk_prepare_enable(drvdata->pclk);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops etm4_dev_pm_ops = {
> +	SET_RUNTIME_PM_OPS(etm4_runtime_suspend, etm4_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id etm4_match[] = {

minor nit: This is still only for the system instruction based
etms, so this renaming is going to confuse. Please leave it
unchanged.

Suzuki


