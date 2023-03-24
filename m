Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6656C7CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjCXKoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCXKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:44:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6532EF977;
        Fri, 24 Mar 2023 03:44:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8BE11FB;
        Fri, 24 Mar 2023 03:45:17 -0700 (PDT)
Received: from [10.57.55.150] (unknown [10.57.55.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0B6B3F6C4;
        Fri, 24 Mar 2023 03:44:27 -0700 (PDT)
Message-ID: <0c1d60f7-0d01-832f-a49c-12527665e86e@arm.com>
Date:   Fri, 24 Mar 2023 10:44:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] Coresight: Add coresight dummy driver
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-2-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230324061608.33609-2-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 06:16, Hao Zhang wrote:
> Some Coresight devices that HLOS don't have permission to access
> or configure. Such as Coresight sink EUD, some TPDMs etc. So there
> need driver to register dummy devices as Coresight devices. Provide
> Coresight API for dummy device operations, such as enabling and
> disabling dummy devices. Build the Coresight path for dummy sink or
> dummy source for debugging.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>   drivers/hwtracing/coresight/Makefile          |   1 +
>   drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
>   3 files changed, 188 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 2b5bbfffbc4f..06f0a7594169 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>   
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-tpda.
> +
> +config CORESIGHT_DUMMY
> +	tristate "Dummy driver support"
> +	help
> +	  Enables support for dummy driver. Dummy driver can be used for
> +	  CoreSight sources/sinks that are owned and configured by some
> +	  other subsystem and use Linux drivers to configure rest of trace
> +	  path.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-dummy.
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 33bcc3f7b8ae..995d3b2c76df 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> new file mode 100644
> index 000000000000..2d4eb3e546eb
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/coresight.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-trace-id.h"
> +
> +struct dummy_drvdata {
> +	struct device			*dev;
> +	struct coresight_device		*csdev;
> +	int				traceid;
> +};
> +
> +DEFINE_CORESIGHT_DEVLIST(dummy_devs, "dummy");
> +
> +static int dummy_source_enable(struct coresight_device *csdev,
> +			       struct perf_event *event, u32 mode)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_info(drvdata->dev, "Dummy source enabled\n");

Please use dev_dbg everywher.


> +
> +	return 0;
> +}
> +
> +static void dummy_source_disable(struct coresight_device *csdev,
> +				 struct perf_event *event)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_info(drvdata->dev, "Dummy source disabled\n");
> +}
> +
> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
> +				void *data)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_info(drvdata->dev, "Dummy sink enabled\n");
> +
> +	return 0;
> +}
> +
> +static int dummy_sink_disable(struct coresight_device *csdev)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_info(drvdata->dev, "Dummy sink disabled\n");
> +
> +	return 0;
> +}
> +
> +static const struct coresight_ops_source dummy_source_ops = {
> +	.enable		= dummy_source_enable,
> +	.disable	= dummy_source_disable,
> +};
> +
> +static const struct coresight_ops_sink dummy_sink_ops = {
> +	.enable		= dummy_sink_enable,
> +	.disable	= dummy_sink_disable,
> +};
> +
> +static const struct coresight_ops dummy_cs_ops = {
> +	.source_ops	= &dummy_source_ops,
> +	.sink_ops	= &dummy_sink_ops,
> +};
> +
> +static int dummy_probe(struct platform_device *pdev)
> +{
> +	int ret, trace_id;
> +	struct device *dev = &pdev->dev;
> +	struct coresight_platform_data *pdata;
> +	struct dummy_drvdata *drvdata;
> +	struct coresight_desc desc = { 0 };
> +
> +	desc.name = coresight_alloc_device_name(&dummy_devs, dev);
> +	if (!desc.name)
> +		return -ENOMEM;
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	pdev->dev.platform_data = pdata;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM;
> +
> +	drvdata->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, drvdata);
> +
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,dummy-source")) {

I don't see any reason why this should be qcom,...

Please could we use : "arm,coresight-", everywhere including the "dt"
compatible ?

> +		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +		desc.subtype.source_subtype =
> +					CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> +	} else if (of_property_read_bool(pdev->dev.of_node,
> +					 "qcom,dummy-sink")) {
> +		desc.type = CORESIGHT_DEV_TYPE_SINK;
> +		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> +	} else {
> +		dev_info(dev, "Device type not set\n");
> +		return -EINVAL;
> +	}
> +
> +	desc.ops = &dummy_cs_ops;
> +	desc.pdata = pdev->dev.platform_data;
> +	desc.dev = &pdev->dev;
> +	drvdata->csdev = coresight_register(&desc);
> +	if (IS_ERR(drvdata->csdev))
> +		return PTR_ERR(drvdata->csdev);
> +
> +	trace_id = coresight_trace_id_get_system_id();
> +	if (trace_id < 0) {
> +		ret = trace_id;
> +		goto cs_unregister;
> +	}
> +	drvdata->traceid = (u8)trace_id;
> +
> +	pm_runtime_enable(dev);
> +	dev_info(dev, "Dummy device initialized\n");
> +
> +	return 0;
> +
> +cs_unregister:
> +	coresight_unregister(drvdata->csdev);
> +
> +	return ret;
> +}
> +
> +static int dummy_remove(struct platform_device *pdev)
> +{
> +	struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	coresight_trace_id_put_system_id(drvdata->traceid);
> +	pm_runtime_disable(dev);
> +	coresight_unregister(drvdata->csdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id dummy_match[] = {
> +	{.compatible = "qcom,coresight-dummy"},

As mentioned above, "arm,coresight-dummy-device" ? This has
nothing to do with qcom IP. qcom has a use for this. So, I would
like to keep this "coresight" subsystem specific compatibles.

May be we could even add other types too : i.e,

arm,coresight-dummy-link-split, arm,coresight-dummy-link-merge


Suzuki

> +	{},
> +};
> +
> +static struct platform_driver dummy_driver = {
> +	.probe	= dummy_probe,
> +	.remove	= dummy_remove,
> +	.driver	= {
> +		.name   = "coresight-dummy",
> +		.of_match_table = dummy_match,
> +	},
> +};
> +
> +static int __init dummy_init(void)
> +{
> +	return platform_driver_register(&dummy_driver);
> +}
> +module_init(dummy_init);
> +
> +static void __exit dummy_exit(void)
> +{
> +	platform_driver_unregister(&dummy_driver);
> +}
> +module_exit(dummy_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CoreSight dummy source driver");

