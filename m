Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4416198CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiKDOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiKDOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:06:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434425EA9;
        Fri,  4 Nov 2022 07:06:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCA356602986;
        Fri,  4 Nov 2022 14:06:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667570797;
        bh=Jd5DVDMb4CuL5PHhB23a0DAUDFJyHCwyYU9ukEUegvw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d7ua+Sja4Z8UlwtSzWoN8VpIOJrXcl5AWZ3eXBGs8Q9B7PH7r4vDLlT2Cj79DXEbH
         FoFk3wlWu4kk+LYqXOvfjebIFhQCv0ZRL34Y3SrmKTRvlbzpmhEMf8BoXhiwx0RCEl
         5UOD2KAXapR7SAVcSaX4rFMjqafUo4MZ3bl9PIh+JisjdjjE1tRan+EcNPrDYWU5hC
         cbnVxKvL6pha3mMesSs1VaYImweWeEg7aehgipdrM6Qogy67lI4TANoIizishcWL+D
         iAdJCwV6Y1/0O1roBJccHjdhgyn5f/xM3wORk1dc1Nc0IWWngWfzgNgoCVUgxrPQ/e
         tiLp0hWJLjzGQ==
Message-ID: <818b7c09-842c-983a-3776-95dacbebc0de@collabora.com>
Date:   Fri, 4 Nov 2022 15:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
References: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
 <20221104133506.131316-3-angelogioacchino.delregno@collabora.com>
 <cf1a15c5-a16b-2d23-8f6c-b3892c141c34@linaro.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <cf1a15c5-a16b-2d23-8f6c-b3892c141c34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/11/22 15:04, Krzysztof Kozlowski ha scritto:
> On 04/11/2022 09:35, AngeloGioacchino Del Regno wrote:
>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>>
>> The Ramp Controller is used to program the sequence ID for pulse
>> swallowing, enable sequence and linking sequence IDs for the CPU
>> cores on some Qualcomm SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
>> ---
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/ramp_controller.c | 330 +++++++++++++++++++++++++++++
>>   3 files changed, 340 insertions(+)
>>   create mode 100644 drivers/soc/qcom/ramp_controller.c
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 024e420f1bb7..1e681f98bad4 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -95,6 +95,15 @@ config QCOM_QMI_HELPERS
>>   	tristate
>>   	depends on NET
>>   
>> +config QCOM_RAMP_CTRL
>> +	tristate "Qualcomm Ramp Controller driver"
>> +	depends on ARCH_QCOM
> 
> I propose:
> depends on ARCH_QCOM && ARM || COMPILE_TEST
> 
> I don't think it is used on ARM64 SoCs, so let's make life of distros
> easier.
> 

Agreed.

>> +	help
>> +	  The Ramp Controller is used to program the sequence ID for pulse
>> +	  swallowing, enable sequence and linking sequence IDs for the
>> +	  CPU cores on some Qualcomm SoCs.
>> +	  Say y here to enable support for the ramp controller.
>> +
>>   config QCOM_RMTFS_MEM
>>   	tristate "Qualcomm Remote Filesystem memory driver"
>>   	depends on ARCH_QCOM
>> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
>> index d66604aff2b0..6e02333c4080 100644
>> --- a/drivers/soc/qcom/Makefile
>> +++ b/drivers/soc/qcom/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
>>   obj-$(CONFIG_QCOM_PDR_HELPERS)	+= pdr_interface.o
>>   obj-$(CONFIG_QCOM_QMI_HELPERS)	+= qmi_helpers.o
>>   qmi_helpers-y	+= qmi_encdec.o qmi_interface.o
>> +obj-$(CONFIG_QCOM_RAMP_CTRL)	+= ramp_controller.o
>>   obj-$(CONFIG_QCOM_RMTFS_MEM)	+= rmtfs_mem.o
>>   obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
>>   qcom_rpmh-y			+= rpmh-rsc.o
>> diff --git a/drivers/soc/qcom/ramp_controller.c b/drivers/soc/qcom/ramp_controller.c
>> new file mode 100644
>> index 000000000000..e28679b545d1
>> --- /dev/null
>> +++ b/drivers/soc/qcom/ramp_controller.c
>> @@ -0,0 +1,330 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Qualcomm Ramp Controller driver
>> + * Copyright (c) 2022, AngeloGioacchino Del Regno
>> + *                     <angelogioacchino.delregno@collabora.com>
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/types.h>
>> +
>> +#define RC_UPDATE_EN		BIT(0)
>> +#define RC_ROOT_EN		BIT(1)
>> +
>> +#define RC_REG_CFG_UPDATE	0x60
>> + #define RC_CFG_UPDATE_EN	BIT(8)
>> + #define RC_CFG_ACK		GENMASK(31, 16)
> 
> Drop spaces before #define
> 
>> +
>> +#define RC_DCVS_CFG_SID		2
>> +#define RC_LINK_SID		3
>> +#define RC_LMH_SID		6
>> +#define RC_DFS_SID		14
>> +
>> +#define RC_UPDATE_TIMEOUT_US	500
>> +
>> +/**
>> + * struct qcom_ramp_controller_desc - SoC specific parameters
>> + * @cfg_dfs_sid:      Dynamic Frequency Scaling SID configuration
>> + * @cfg_link_sid:     Link SID configuration
>> + * @cfg_lmh_sid:      Limits Management hardware SID configuration
>> + * @cfg_ramp_pre_en:  Ramp Controller pre-enable sequence
>> + * @cfg_ramp_en:      Ramp Controller enable sequence
>> + * @cfg_ramp_post_en: Ramp Controller post-enable sequence
>> + * @cfg_ramp_dis:     Ramp Controller disable sequence
>> + * @cmd_reg:          Command register offset
>> + * @num_dfs_sids:     Number of DFS SIDs (max 8)
>> + * @num_link_sids:    Number of Link SIDs (max 3)
>> + * @num_lmh_sids:     Number of LMh SIDs (max 8)
>> + */
>> +struct qcom_ramp_controller_desc {
>> +	struct reg_sequence *cfg_dfs_sid;
> 
> I didn't check much, but can these be pointers to const?
> 

Yeah, const is the way. Will do.

>> +	struct reg_sequence *cfg_link_sid;
>> +	struct reg_sequence *cfg_lmh_sid;
>> +	struct reg_sequence *cfg_ramp_pre_en;
>> +	struct reg_sequence *cfg_ramp_en;
>> +	struct reg_sequence *cfg_ramp_post_en;
>> +	struct reg_sequence *cfg_ramp_dis;
>> +	u8 cmd_reg;
>> +	u8 num_dfs_sids;
>> +	u8 num_link_sids;
>> +	u8 num_lmh_sids;
>> +};
>> +
> 
> (...)
> 
>> +
>> +static struct platform_driver qcom_ramp_controller_driver = {
>> +	.driver = {
>> +		.name = "qcom-ramp-controller",
>> +		.of_match_table = qcom_ramp_controller_match_table,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe  = qcom_ramp_controller_probe,
>> +	.remove = qcom_ramp_controller_remove,
>> +};
>> +
>> +static int __init qcom_ramp_controller_init(void)
>> +{
>> +	return platform_driver_register(&qcom_ramp_controller_driver);
>> +}
>> +arch_initcall(qcom_ramp_controller_init);
> 
> Does it really have to be arch initcall? Cannot be module platform driver?
> 

Cannot be platform driver. This has to initialize as early as possible, or
booting will be unstable in some cases (big cluster enabled).

Cheers!
Angelo

