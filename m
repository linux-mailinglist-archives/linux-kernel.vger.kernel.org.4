Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8784B740C41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjF1JDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:03:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131]:15138 "EHLO
        mx0a-0031df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233797AbjF1IxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:53:23 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35S7mYHj014442;
        Wed, 28 Jun 2023 08:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nxbHiyfMNnhx4XUpknlzeEjX+JkKUzyLXEMSoAFObQU=;
 b=NH8rNzW6ByA07gT4EkOlMvFxOhcElpc4QPduqXQ/wzviPLRsXkabdSu4QDRdKAjaaxFP
 7VQYf1+ezrZBDyrDNdk2B1BWP4ZbK1yG70/YE9vuTEz7tawsO/6fd8oeSkfGGuRJO6ob
 aw/Xyhhq22wkXFr4RpyJxXPn0t7KzZPzqCuWtjz2+/XmdkS7dB3U+atGp3uIRi/JTtfF
 S9VFLl0p1DqI6foS9jyoDI2bQF5j2Bm8yFPXX0e5p5Teiq/LIzAJKGmgtr22X0OtevYu
 6AQuP2usEkBkzdOiyZwGHdTaIZeyBbY7QIxcpJBVFdixaj4fMY45Yj9g+X5o3mA5q3eL wQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgfp3raed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 08:52:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35S8qsMN028810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jun 2023 08:52:54 GMT
Received: from [10.214.230.142] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 28 Jun
 2023 01:52:51 -0700
Message-ID: <e80f0bd3-cf1e-dfed-bcc6-d22d4d934230@quicinc.com>
Date:   Wed, 28 Jun 2023 14:22:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
 <b84b2bfc-6f8f-f50f-27b5-52a982ae30f2@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <b84b2bfc-6f8f-f50f-27b5-52a982ae30f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cRMwfyNecBWdklBeIV7n11-jCEgFYkRh
X-Proofpoint-ORIG-GUID: cRMwfyNecBWdklBeIV7n11-jCEgFYkRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_05,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=956
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306280077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2023 8:28 PM, Konrad Dybcio wrote:
> On 23.06.2023 16:18, Komal Bajaj wrote:
>> Add LLCC support for multi channel DDR configuration
>> based on a feature register. Reading DDR channel
>> confiuration uses nvmem framework, so select the
>> dependency in Kconfig. Without this, there will be
>> errors while building the driver with COMPILE_TEST only.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/soc/qcom/Kconfig     |  2 ++
>>   drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index a491718f8064..cc9ad41c63aa 100644
>> --- a/drivers/soc/qcom/Kconfig
>> +++ b/drivers/soc/qcom/Kconfig
>> @@ -64,6 +64,8 @@ config QCOM_LLCC
>>   	tristate "Qualcomm Technologies, Inc. LLCC driver"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>>   	select REGMAP_MMIO
>> +	select NVMEM
>> +	select QCOM_SCM
>>   	help
>>   	  Qualcomm Technologies, Inc. platform specific
>>   	  Last Level Cache Controller(LLCC) driver for platforms such as,
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 6cf373da5df9..3c29612da1c5 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/nvmem-consumer.h>
>>   #include <linux/of.h>
>>   #include <linux/of_device.h>
>>   #include <linux/regmap.h>
>> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>>   	return ret;
>>   }
>>   
>> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
>> +{
>> +	int ret;
>> +
>> +	ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
>> +	if (ret == -ENOENT) {
>> +		*cfg_index = 0;
>> +		return 0;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>   {
>>   	/* Set the global pointer to a error code to avoid referencing it */
>> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>   	struct device *dev = &pdev->dev;
>>   	int ret, i;
>>   	struct platform_device *llcc_edac;
>> -	const struct qcom_llcc_config *cfg;
>> +	const struct qcom_llcc_config *cfg, *entry;
>>   	const struct llcc_slice_config *llcc_cfg;
>>   	u32 sz;
>> +	u8 cfg_index;
>>   	u32 version;
>>   	struct regmap *regmap;
>> +	u32 num_entries = 0;
>>   
>>   	drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>   	if (!drv_data) {
>> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>   
>>   	drv_data->version = version;
>>   
>> -	llcc_cfg = cfg[0]->sct_data;
>> -	sz = cfg[0]->size;
>> +	ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>> +	if (ret)
>> +		goto err;
>> +
>
>> +	for (entry = cfg; entry->sct_data; entry++, num_entries++)
>> +		;
>> +	if (cfg_index >= num_entries || cfg_index < 0) {
> cfg_index is an unsigned variable, it can never be < 0

Okay, will remove this condition.

>
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
>> +
> if (cfg_index >= entry->size)? With that, you can also keep the config
> entries non-0-terminated in the previous patch, saving a whole lot of RAM.

entry->size represents the size of sct table whereas num_entries 
represents the number
of sct tables that we can have. And by this check we are validating the 
value read from the
fuse register. Am I understanding your comment correctly?

>
> Konrad
>> +	llcc_cfg = cfg[cfg_index].sct_data;
>> +	sz = cfg[cfg_index].size;
>>   
>>   	for (i = 0; i < sz; i++)
>>   		if (llcc_cfg[i].slice_id > drv_data->max_slices)

