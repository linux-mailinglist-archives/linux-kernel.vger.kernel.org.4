Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C733A704C75
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjEPLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjEPLhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:37:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0887EBD;
        Tue, 16 May 2023 04:37:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C0DC2F4;
        Tue, 16 May 2023 04:37:48 -0700 (PDT)
Received: from [10.163.71.75] (unknown [10.163.71.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 318063F663;
        Tue, 16 May 2023 04:36:57 -0700 (PDT)
Message-ID: <6ebe814c-437a-dead-cdaa-d6b48fa36ba7@arm.com>
Date:   Tue, 16 May 2023 17:06:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 4/5] coresight: etm4x: Change etm4_platform_driver
 driver for MMIO devices
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-5-anshuman.khandual@arm.com>
 <775052f2-ef23-c015-86e9-daaffca75527@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <775052f2-ef23-c015-86e9-daaffca75527@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/23 20:24, Suzuki K Poulose wrote:
> On 27/03/2023 06:05, Anshuman Khandual wrote:
>> Add support for handling MMIO based devices via platform driver. We need to
>> make sure that :
>>
>> 1) The APB clock, if present is enabled at probe and via runtime_pm ops
>> 2) Use the ETM4x architecture or CoreSight architecture registers to
>>     identify a device as CoreSight ETM4x, instead of relying a white list of
>>     "Peripheral IDs"
>>
>> The driver doesn't get to handle the devices yet, until we wire the ACPI
>> changes to move the devices to be handled via platform driver than the
>> etm4_amba driver.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   .../coresight/coresight-etm4x-core.c          | 62 +++++++++++++++++--
>>   drivers/hwtracing/coresight/coresight-etm4x.h |  4 ++
>>   include/linux/coresight.h                     | 47 ++++++++++++++
>>   3 files changed, 109 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 3521838ab4fb..bef205023bbe 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -30,6 +30,7 @@
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>> +#include <linux/clk/clk-conf.h>
>>     #include <asm/barrier.h>
>>   #include <asm/sections.h>
>> @@ -1067,12 +1068,22 @@ static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
>>       return true;
>>   }
>>   +static bool is_etm4x_devtype(void __iomem *base)
>> +{
>> +    u32 devtype = readl(base + TRCDEVTYPE);
>> +
>> +    return (devtype == ETM_DEVTYPE_ETMv4x_ARCH);
>> +}
>> +
>>   static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>>                      struct csdev_access *csa)
>>   {
>>       u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
>>       u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
>>   +    if (!is_coresight_device(drvdata->base) || !is_etm4x_devtype(drvdata->base))
>> +        return false;
>> +
>>       /*
>>        * All ETMs must implement TRCDEVARCH to indicate that
>>        * the component is an ETMv4. To support any broken
>> @@ -2133,6 +2144,7 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>>     static int etm4_probe_platform_dev(struct platform_device *pdev)
>>   {
>> +    struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>       struct etmv4_drvdata *drvdata;
>>       int ret;
>>   @@ -2140,7 +2152,18 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>>       if (!drvdata)
>>           return -ENOMEM;
>>   -    drvdata->base = NULL;
>> +    drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
>> +    if (IS_ERR(drvdata->pclk))
>> +        return -ENODEV;
>> +
>> +    if (res) {
>> +        drvdata->base = devm_ioremap_resource(&pdev->dev, res);
>> +        if (IS_ERR(drvdata->base)) {
>> +            clk_put(drvdata->pclk);
>> +            return PTR_ERR(drvdata->base);
>> +        }
>> +    }
>> +
>>       dev_set_drvdata(&pdev->dev, drvdata);
>>       pm_runtime_get_noresume(&pdev->dev);
>>       pm_runtime_set_active(&pdev->dev);
>> @@ -2186,7 +2209,7 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>>           /*  ETMv4 UCI data */
>>           .devarch    = ETM_DEVARCH_ETMv4x_ARCH,
>>           .devarch_mask    = ETM_DEVARCH_ID_MASK,
>> -        .devtype    = 0x00000013,
>> +        .devtype    = ETM_DEVTYPE_ETMv4x_ARCH,
>>       }
>>   };
>>   @@ -2244,6 +2267,10 @@ static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
>>         if (drvdata)
>>           ret = etm4_remove_dev(drvdata);
>> +
>> +    if (drvdata->pclk)
>> +        clk_put(drvdata->pclk);
>> +
>>       pm_runtime_disable(&pdev->dev);
>>       return ret;
>>   }
>> @@ -2284,7 +2311,33 @@ static struct amba_driver etm4x_amba_driver = {
>>       .id_table    = etm4_ids,
>>   };
>>   -static const struct of_device_id etm4_sysreg_match[] = {
>> +#ifdef CONFIG_PM
>> +static int etm4_runtime_suspend(struct device *dev)
>> +{
>> +    struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    if (!IS_ERR(drvdata->pclk))
>> +        clk_disable_unprepare(drvdata->pclk);
>> +
>> +    return 0;
>> +}
>> +
>> +static int etm4_runtime_resume(struct device *dev)
>> +{
>> +    struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>> +
>> +    if (!IS_ERR(drvdata->pclk))
>> +        clk_prepare_enable(drvdata->pclk);
>> +
>> +    return 0;
>> +}
>> +#endif
>> +
>> +static const struct dev_pm_ops etm4_dev_pm_ops = {
>> +    SET_RUNTIME_PM_OPS(etm4_runtime_suspend, etm4_runtime_resume, NULL)
>> +};
>> +
>> +static const struct of_device_id etm4_match[] = {
>>       { .compatible    = "arm,coresight-etm4x-sysreg" },
>>       { .compatible    = "arm,embedded-trace-extension" },
>>       {}
>> @@ -2295,8 +2348,9 @@ static struct platform_driver etm4_platform_driver = {
>>       .remove        = etm4_remove_platform_dev,
>>       .driver            = {
>>           .name            = "coresight-etm4x",
>> -        .of_match_table        = etm4_sysreg_match,
>> +        .of_match_table        = etm4_match,
>>           .suppress_bind_attrs    = true,
>> +        .pm            = &etm4_dev_pm_ops,
>>       },
>>   };
>>   diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
>> index 434f4e95ee17..78dfe7949548 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
>> @@ -701,6 +701,8 @@
>>   #define ETM_DEVARCH_ETE_ARCH                        \
>>       (ETM_DEVARCH_ARCHITECT_ARM | ETM_DEVARCH_ARCHID_ETE | ETM_DEVARCH_PRESENT)
>>   +#define ETM_DEVTYPE_ETMv4x_ARCH        0x00000013
> 
> This has nothing to do with ETMv4 ARCH. This indicates :
> 
> [3:0] == 0x3 -> Indicates CoreSight Source
> [7:4] == 0x1 -> Generates PE trace
> 
> So, we could call it : CS_DEVTYPE_PE_TRACE, but not ETMv4x

Sure, will rename it as suggested.

> 
> Rest looks good to me.
> 
> Suzuki
> 
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
