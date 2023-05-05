Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320A76F8071
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjEEJ5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjEEJ5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:57:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 079051816A;
        Fri,  5 May 2023 02:57:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF2ED1FB;
        Fri,  5 May 2023 02:58:24 -0700 (PDT)
Received: from [10.57.21.147] (unknown [10.57.21.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24FCD3F64C;
        Fri,  5 May 2023 02:57:37 -0700 (PDT)
Message-ID: <2b02fc8e-4234-30d2-a8dc-3847c574655f@arm.com>
Date:   Fri, 5 May 2023 10:57:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/3] Coresight: Add coresight dummy driver
To:     Hao Zhang <quic_hazha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
References: <20230505092422.32217-1-quic_hazha@quicinc.com>
 <20230505092422.32217-2-quic_hazha@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230505092422.32217-2-quic_hazha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2023 10:24, Hao Zhang wrote:
> Some Coresight devices that kernel don't have permission to access or
> configure. So there need driver to register dummy devices as Coresight
> devices. It may also be used to define components that may not have
> any programming interfaces (e.g, static links), so that paths can be
> established in the driver. Provide Coresight API for dummy device
> operations, such as enabling and disabling dummy devices. Build the
> Coresight path for dummy sink or dummy source for debugging.
> 
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig           |  11 ++
>   drivers/hwtracing/coresight/Makefile          |   1 +
>   drivers/hwtracing/coresight/coresight-dummy.c | 171 ++++++++++++++++++
>   include/linux/coresight.h                     |   1 +
>   4 files changed, 184 insertions(+)
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
> +	  path > +
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
> index 000000000000..ee9881ff4754
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -0,0 +1,171 @@
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

Please follow the alphabetical order for the header files ^

> +
> +#include "coresight-priv.h"
> +
> +struct dummy_drvdata {
> +	struct device			*dev;

nit: We don't need this really. And that completely removes the need for
drvdata too. See below.

> +	struct coresight_device		*csdev;
> +};
> +
> +DEFINE_CORESIGHT_DEVLIST(source_devs, "dummy_source");
> +DEFINE_CORESIGHT_DEVLIST(sink_devs, "dummy_sink");
> +
> +static int dummy_source_enable(struct coresight_device *csdev,
> +			       struct perf_event *event, u32 mode)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_dbg(drvdata->dev, "Dummy source enabled\n");

	dev_dbg(csdev->dev.parent, ..");

Similarly for all instances below.

> +
> +	return 0;
> +}
> +
> +static void dummy_source_disable(struct coresight_device *csdev,
> +				 struct perf_event *event)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_dbg(drvdata->dev, "Dummy source disabled\n");
> +}
> +
> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
> +				void *data)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_dbg(drvdata->dev, "Dummy sink enabled\n");
> +
> +	return 0;
> +}
> +
> +static int dummy_sink_disable(struct coresight_device *csdev)
> +{
> +	struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +	dev_dbg(drvdata->dev, "Dummy sink disabled\n");
> +
> +	return 0;
> +}
> +
> +static const struct coresight_ops_source dummy_source_ops = {
> +	.enable	= dummy_source_enable,
> +	.disable = dummy_source_disable,
> +};
> +
> +static const struct coresight_ops dummy_source_cs_ops = {
> +	.source_ops = &dummy_source_ops,
> +};
> +
> +static const struct coresight_ops_sink dummy_sink_ops = {
> +	.enable	= dummy_sink_enable,
> +	.disable = dummy_sink_disable,
> +};
> +
> +static const struct coresight_ops dummy_sink_cs_ops = {
> +	.sink_ops = &dummy_sink_ops,
> +};
> +
> +static int dummy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct coresight_platform_data *pdata;
> +	struct dummy_drvdata *drvdata;
> +	struct coresight_desc desc = { 0 };
> +
> +	if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
> +
> +		desc.name = coresight_alloc_device_name(&source_devs, dev);
> +		if (!desc.name)
> +			return -ENOMEM;
> +
> +		desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +		desc.subtype.source_subtype =
> +					CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> +		desc.ops = &dummy_source_cs_ops;
> +	} else if (of_device_is_compatible(node, "arm,coresight-dummy-sink")) {
> +		desc.name = coresight_alloc_device_name(&sink_devs, dev);
> +		if (!desc.name)
> +			return -ENOMEM;
> +
> +		desc.type = CORESIGHT_DEV_TYPE_SINK;
> +		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_DUMMY;
> +		desc.ops = &dummy_sink_cs_ops;
> +	} else {
> +		dev_err(dev, "Device type not set\n");
> +		return -EINVAL;
> +	}
> +
> +	pdata = coresight_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +	pdev->dev.platform_data = pdata;
> +
> +	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +	if (!drvdata)
> +		return -ENOMEM; > +
> +	drvdata->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, drvdata);

As above, you may remove the drvdata entirely.

Otherwise looks good to me

Suzuki

