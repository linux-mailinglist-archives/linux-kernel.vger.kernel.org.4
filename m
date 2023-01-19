Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E0C673C13
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjASOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjASOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:32:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F144C211C;
        Thu, 19 Jan 2023 06:32:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390C5176A;
        Thu, 19 Jan 2023 06:32:46 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1BA13F445;
        Thu, 19 Jan 2023 06:32:01 -0800 (PST)
Message-ID: <a6a543d5-4623-2010-68e3-ea30b4401047@arm.com>
Date:   Thu, 19 Jan 2023 14:31:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v17 2/9] Coresight: Add coresight TPDM source driver
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>
References: <20230117145708.16739-1-quic_jinlmao@quicinc.com>
 <20230117145708.16739-3-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230117145708.16739-3-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mao Jinolong,

On 17/01/2023 14:57, Mao Jinlong wrote:
> Add driver to support Coresight device TPDM (Trace, Profiling and
> Diagnostics Monitor). TPDM is a monitor to collect data from
> different datasets. This change is to add probe/enable/disable
> functions for tpdm source.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig          |  12 ++
>   drivers/hwtracing/coresight/Makefile         |   1 +
>   drivers/hwtracing/coresight/coresight-core.c |   5 +-
>   drivers/hwtracing/coresight/coresight-tpdm.c | 149 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpdm.h |  26 ++++
>   include/linux/coresight.h                    |   1 +
>   6 files changed, 193 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpdm.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index ba035d7894e0..e2debad59608 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -213,4 +213,16 @@ config ULTRASOC_SMB
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called ultrasoc-smb.
> +
> +config CORESIGHT_TPDM
> +	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
> +	select CORESIGHT_LINKS_AND_SINKS
> +	help
> +	  This driver provides support for configuring monitor. Monitors are
> +	  primarily responsible for data set collection and support the
> +	  ability to collect any permutation of data set types.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-tpdm.
> +
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 80f99d915bc9..c637376e0efd 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
>   obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
> +obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 5eb013f49a0d..a798008ac56e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1061,7 +1061,8 @@ static int coresight_validate_source(struct coresight_device *csdev,
>   	}
>   
>   	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
> -	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE) {
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
> +	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>   		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
>   		return -EINVAL;
>   	}
> @@ -1130,6 +1131,7 @@ int coresight_enable(struct coresight_device *csdev)
>   		per_cpu(tracer_path, cpu) = path;
>   		break;
>   	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>   		/*
>   		 * Use the hash of source's device name as ID
>   		 * and map the ID to the pointer of the path.
> @@ -1179,6 +1181,7 @@ void coresight_disable(struct coresight_device *csdev)
>   		per_cpu(tracer_path, cpu) = NULL;
>   		break;
>   	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
> +	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
>   		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
>   		/* Find the path by the hash. */
>   		path = idr_find(&path_idr, hash);
> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
> new file mode 100644
> index 000000000000..95dbf4badfd2
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/amba/bus.h>
> +#include <linux/bitmap.h>
> +#include <linux/coresight.h>
> +#include <linux/coresight-pmu.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-tpdm.h"
> +
> +DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
> +
> +/* TPDM enable operations */
> +static int tpdm_enable(struct coresight_device *csdev,
> +		       struct perf_event *event, u32 mode)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (drvdata->enable) {
> +		spin_unlock(&drvdata->spinlock);
> +		return -EBUSY;
> +	}
> +
> +	drvdata->enable = true;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_dbg(drvdata->dev, "TPDM tracing enabled\n");
> +	return 0;
> +}
> +
> +/* TPDM disable operations */
> +static void tpdm_disable(struct coresight_device *csdev,
> +			 struct perf_event *event)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	spin_lock(&drvdata->spinlock);
> +	if (!drvdata->enable) {
> +		spin_unlock(&drvdata->spinlock);
> +		return;
> +	}
> +
> +	drvdata->enable = false;
> +	spin_unlock(&drvdata->spinlock);
> +
> +	dev_dbg(drvdata->dev, "TPDM tracing disabled\n");
> +}
> +
> +static const struct coresight_ops_source tpdm_source_ops = {
> +	.enable		= tpdm_enable,
> +	.disable	= tpdm_disable,
> +};
> +
> +static const struct coresight_ops tpdm_cs_ops = {
> +	.source_ops	= &tpdm_source_ops,
> +};
> +
> +static int tpdm_probe(struct amba_device *adev, const struct amba_id *id)
> +{
> +	void __iomem *base;
> +	struct device *dev = &adev->dev;
> +	struct coresight_platform_data *pdata;
> +	struct tpdm_drvdata *drvdata;
> +	struct coresight_desc desc = { 0 };
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	adev->dev.platform_data = pdata;
> +
> +	/* driver data*/
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +	drvdata->dev = &adev->dev;
> +	dev_set_drvdata(dev, drvdata);
> +
> +	base = devm_ioremap_resource(dev, &adev->res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	drvdata->base = base;
> +
> +	/* Set up coresight component description */
> +	desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> +	desc.ops = &tpdm_cs_ops;
> +	desc.pdata = adev->dev.platform_data;
> +	desc.dev = &adev->dev;
> +	desc.access = CSDEV_ACCESS_IOMEM(base);
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev))
> +		return PTR_ERR(drvdata->csdev);
> +
> +	spin_lock_init(&drvdata->spinlock);
> +	/* Decrease pm refcount when probe is done.*/
> +	pm_runtime_put(&adev->dev);
> +
> +	return 0;
> +}
> +
> +static void __exit tpdm_remove(struct amba_device *adev)
> +{
> +	struct tpdm_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	coresight_unregister(drvdata->csdev);
> +}
> +
> +/*
> + * Different TPDM has different periph id.
> + * The difference is 0-7 bits' value. So ignore 0-7 bits.
> + */
> +static struct amba_id tpdm_ids[] = {
> +	{
> +		.id = 0x000f0e00,
> +		.mask = 0x000fff00,
> +	},
> +	{ 0, 0},
> +};
> +
> +static struct amba_driver tpdm_driver = {
> +	.drv = {
> +		.name   = "coresight-tpdm",
> +		.owner	= THIS_MODULE,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe          = tpdm_probe,
> +	.id_table	= tpdm_ids,
> +	.remove		= tpdm_remove,
> +};
> +
> +module_amba_driver(tpdm_driver);
> +
> +MODULE_LICENSE("GPL v2");

I get checkpatch warnings with the line above:

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: 
Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#242: FILE: drivers/hwtracing/coresight/coresight-tpdm.c:148:
+MODULE_LICENSE("GPL v2");

I get the above WARNING with checkpatch. Are you able to respin the 
series modifying the above to "GPL".

Fyi, "GPL v2" and "GPL" mean the same in terms of the MODULE_LICENSE()
and the latter is recommended. See, Documentation/process/license-rules.rst

Are you able to respin this patch alone and send it with the change ?

Suzuki


