Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D44673CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjASOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjASOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:44:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDA508B30C;
        Thu, 19 Jan 2023 06:42:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A4CA176A;
        Thu, 19 Jan 2023 06:42:36 -0800 (PST)
Received: from [10.57.75.229] (unknown [10.57.75.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965B33F445;
        Thu, 19 Jan 2023 06:41:51 -0800 (PST)
Message-ID: <b9e39e9e-6f59-f8b0-6f5d-401151455488@arm.com>
Date:   Thu, 19 Jan 2023 14:41:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v17 6/9] Coresight: Add TPDA link driver
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
 <20230117145708.16739-7-quic_jinlmao@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230117145708.16739-7-quic_jinlmao@quicinc.com>
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

On 17/01/2023 14:57, Mao Jinlong wrote:
> TPDA(Trace, Profiling and Diagnostics Aggregator) is
> to provide packetization, funneling and timestamping of
> TPDM data. Multiple monitors are connected to different
> input ports of TPDA.This change is to add tpda
> enable/disable/probe functions for coresight tpda driver.
> 
>   - - - -         - - - -        - - - -
> | TPDM 0|      | TPDM 1 |     | TPDM 2|
>   - - - -         - - - -        - - - -
>      |               |             |
>      |_ _ _ _ _ _    |     _ _ _ _ |
>                  |   |    |
>                  |   |    |
>             ------------------
>            |        TPDA      |
>             ------------------
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>   drivers/hwtracing/coresight/Kconfig          |  11 +
>   drivers/hwtracing/coresight/Makefile         |   1 +
>   drivers/hwtracing/coresight/coresight-tpda.c | 211 +++++++++++++++++++
>   drivers/hwtracing/coresight/coresight-tpda.h |  35 +++
>   4 files changed, 258 insertions(+)
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.c
>   create mode 100644 drivers/hwtracing/coresight/coresight-tpda.h
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index e2debad59608..2b5bbfffbc4f 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -217,6 +217,7 @@ config ULTRASOC_SMB
>   config CORESIGHT_TPDM
>   	tristate "CoreSight Trace, Profiling & Diagnostics Monitor driver"
>   	select CORESIGHT_LINKS_AND_SINKS
> +	select CORESIGHT_TPDA
>   	help
>   	  This driver provides support for configuring monitor. Monitors are
>   	  primarily responsible for data set collection and support the
> @@ -225,4 +226,14 @@ config CORESIGHT_TPDM
>   	  To compile this driver as a module, choose M here: the module will be
>   	  called coresight-tpdm.
>   
> +config CORESIGHT_TPDA
> +	tristate "CoreSight Trace, Profiling & Diagnostics Aggregator driver"
> +	help
> +	  This driver provides support for configuring aggregator. This is
> +	  primarily useful for pulling the data sets from one or more
> +	  attached monitors and pushing the resultant data out. Multiple
> +	  monitors are connected on different input ports of TPDA.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called coresight-tpda.
>   endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index c637376e0efd..33bcc3f7b8ae 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
>   obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
>   obj-$(CONFIG_CORESIGHT_TRBE) += coresight-trbe.o
>   obj-$(CONFIG_CORESIGHT_TPDM) += coresight-tpdm.o
> +obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>   coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
>   		   coresight-cti-sysfs.o
>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
> new file mode 100644
> index 000000000000..59897980bbb8
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */

...

> +static struct amba_driver tpda_driver = {
> +	.drv = {
> +		.name   = "coresight-tpda",
> +		.owner	= THIS_MODULE,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe          = tpda_probe,
> +	.remove		= tpda_remove,
> +	.id_table	= tpda_ids,
> +};
> +
> +module_amba_driver(tpda_driver);
> +
> +MODULE_LICENSE("GPL v2");

Similarly here too.

