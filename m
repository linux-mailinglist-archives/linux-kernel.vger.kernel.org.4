Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27A9719B03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjFALaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFALa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:30:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A6B125;
        Thu,  1 Jun 2023 04:30:24 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3519ncfo004913;
        Thu, 1 Jun 2023 11:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HWXB6voyMrNJjQ02i9UiHWM2+Zh0uZrvnJMmW3uBPJ0=;
 b=DCgpGjtTUb8CV2aNN5K6myC1X6tC9NMC6IvIiKJgG8qsbJwbGKcZ/f0yxsEueALdPTIu
 VT3+T3M1BhHePeYmZbViSCFs8QtdEgRR2cdZ/uxNIY/r5dTyrW9/USyOo7WyZH6VpDYG
 tVruI6hen5oxqSD9Upc7DPdaPqh/Mp7C81FuLtRx1bVnZT3iGc0bcR5nFpJsYsuPx85/
 E852tW76JeaEZZ8k7bJz0CcQ1/yBTZApw3pCrIxrEqVVj2xUuFONhy2PSxPwh0f5MEh2
 o5WLnVMdUNif/rVsxlIwgKGEUJb4lWRqpWkuUbuDAo8s5uhl+vwZOjP46eC8mXaOekfl JQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxnwv0p76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 11:30:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351BUIsE025487
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 11:30:18 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 04:30:14 -0700
Message-ID: <6b6eb47c-b1fa-8621-5b83-9adb4918b932@quicinc.com>
Date:   Thu, 1 Jun 2023 17:00:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 01/10] nvmem: qfprom: Add support for secure reading
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230512122134.24339-1-quic_kbajaj@quicinc.com>
 <20230512122134.24339-2-quic_kbajaj@quicinc.com>
 <20230527205031.iwsujvlbxazukwfy@ripper>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <20230527205031.iwsujvlbxazukwfy@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gbCSmAMDzfutsO2TKcoci9U9_Mwk9Uwd
X-Proofpoint-ORIG-GUID: gbCSmAMDzfutsO2TKcoci9U9_Mwk9Uwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010101
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2023 2:20 AM, Bjorn Andersson wrote:
> On Fri, May 12, 2023 at 05:51:25PM +0530, Komal Bajaj wrote:
>> For some of the Qualcomm SoC's, it is possible that
>> some of the fuse regions or entire qfprom region is
>> protected from non-secure access. In such situations,
>> linux will have to use secure calls to read the region.
>> With that motivation, add the support of reading secure
>> regions in qfprom driver. Ensuring the address to read
>> is word aligned since our secure I/O only supports word
>> size I/O.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   drivers/nvmem/Kconfig  |  1 +
>>   drivers/nvmem/qfprom.c | 69 +++++++++++++++++++++++++++++++++---------
>>   2 files changed, 55 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
>> index b291b27048c7..3d896ba29b89 100644
>> --- a/drivers/nvmem/Kconfig
>> +++ b/drivers/nvmem/Kconfig
>> @@ -209,6 +209,7 @@ config NVMEM_QCOM_QFPROM
>>   	tristate "QCOM QFPROM Support"
>>   	depends on ARCH_QCOM || COMPILE_TEST
>>   	depends on HAS_IOMEM
>> +	select QCOM_SCM
>>   	help
>>   	  Say y here to enable QFPROM support. The QFPROM provides access
>>   	  functions for QFPROM data to rest of the drivers via nvmem interface.
>> diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
>> index c1e893c8a247..20662e2d3732 100644
>> --- a/drivers/nvmem/qfprom.c
>> +++ b/drivers/nvmem/qfprom.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/pm_runtime.h>
>>   #include <linux/property.h>
>>   #include <linux/regulator/consumer.h>
>> +#include <linux/firmware/qcom/qcom_scm.h>
>>
>>   /* Blow timer clock frequency in Mhz */
>>   #define QFPROM_BLOW_TIMER_OFFSET 0x03c
>> @@ -59,21 +60,22 @@ struct qfprom_soc_data {
>>   /**
>>    * struct qfprom_priv - structure holding qfprom attributes
>>    *
>> - * @qfpraw:       iomapped memory space for qfprom-efuse raw address space.
>> - * @qfpconf:      iomapped memory space for qfprom-efuse configuration address
>> - *                space.
>> + * @qfpraw: iomapped memory space for qfprom-efuse raw address space.
>> + * @qfpconf: iomapped memory space for qfprom-efuse configuration address space.
> Adjusting the indentation makes it unnecessarily hard to see what you
> actually changed.
Okay, will maintain the existing indentation.
>
>>    * @qfpcorrected: iomapped memory space for qfprom corrected address space.
>> - * @qfpsecurity:  iomapped memory space for qfprom security control space.
>> - * @dev:          qfprom device structure.
>> - * @secclk:       Clock supply.
>> - * @vcc:          Regulator supply.
>> - * @soc_data:     Data that for things that varies from SoC to SoC.
>> + * @qfpsecurity: iomapped memory space for qfprom security control space.
>> + * @qfpseccorrected: starting physical address for qfprom secure corrected address space.
>> + * @dev: qfprom device structure.
>> + * @secclk: Clock supply.
>> + * @vcc: Regulator supply.
>> + * @soc_data: Data that for things that varies from SoC to SoC.
>>    */
>>   struct qfprom_priv {
>>   	void __iomem *qfpraw;
>>   	void __iomem *qfpconf;
>>   	void __iomem *qfpcorrected;
>>   	void __iomem *qfpsecurity;
>> +	phys_addr_t qfpseccorrected;
>>   	struct device *dev;
>>   	struct clk *secclk;
>>   	struct regulator *vcc;
>> @@ -99,10 +101,12 @@ struct qfprom_touched_values {
>>    *
>>    * @keepout: Array of keepout regions for this SoC.
>>    * @nkeepout: Number of elements in the keepout array.
>> + * @secure: Is qfprom region for this SoC protected from non-secure access.
>>    */
>>   struct qfprom_soc_compatible_data {
>>   	const struct nvmem_keepout *keepout;
>>   	unsigned int nkeepout;
>> +	bool secure;
>>   };
>>
>>   static const struct nvmem_keepout sc7180_qfprom_keepout[] = {
>> @@ -334,6 +338,34 @@ static int qfprom_reg_read(void *context,
>>   	return 0;
>>   }
>>
>> +static int qfprom_sec_reg_read(void *context, unsigned int reg, void *_val, size_t bytes)
>> +{
>> +	struct qfprom_priv *priv = context;
>> +	u8 *val = _val;
>> +	int buf_start, buf_end, index, i = 0;
>> +	char *buffer;
>> +	u32 read_val;
>> +
>> +	buf_start = ALIGN_DOWN(reg, 4);
>> +	buf_end = ALIGN(reg + bytes, 4);
>> +	buffer = kzalloc(buf_end - buf_start, GFP_KERNEL);
>> +	if (!buffer)
>> +		return -ENOMEM;
> I don't you need all these variables, the full temp buffer or the two
> memcpy... I think something like this should do the trick:
>
> 	unsigned int i;
> 	u8 *val = _val;
> 	u8 tmp[4];
>
> 	for (i = 0; i < bytes; i++, reg++)
> 		if (i == 0 || reg % 4 == 0)
> 			qcom_scm_io_readl(qfpseccorrected + (reg & ~3), tmp);
>
> 		val[i] = tmp[reg & 3];
> 	}
Thanks, for this. Will make the suggested change in the next patch series.
>> +
>> +	for (index = buf_start; index < buf_end; index += 4, i += 4) {
>> +		if (qcom_scm_io_readl(priv->qfpseccorrected + index, &read_val)) {
>> +			dev_err(priv->dev, "Couldn't access feature register\n");
> What's a "feature register"?
It's a fuse register that we are trying to read here.

Thanks
Komal

>
> Regards,
> Bjorn
>
>> +			kfree_sensitive(buffer);
>> +			return -EINVAL;
>> +		}
>> +		memcpy(buffer + i, &read_val, 4);
>> +	}
>> +
>> +	memcpy(val, buffer + reg % 4, bytes);
>> +	kfree_sensitive(buffer);
>> +	return 0;
>> +}
>> +
>>   static void qfprom_runtime_disable(void *data)
>>   {
>>   	pm_runtime_disable(data);
>> @@ -373,13 +405,6 @@ static int qfprom_probe(struct platform_device *pdev)
>>   	if (!priv)
>>   		return -ENOMEM;
>>
>> -	/* The corrected section is always provided */
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	priv->qfpcorrected = devm_ioremap_resource(dev, res);
>> -	if (IS_ERR(priv->qfpcorrected))
>> -		return PTR_ERR(priv->qfpcorrected);
>> -
>> -	econfig.size = resource_size(res);
>>   	econfig.dev = dev;
>>   	econfig.priv = priv;
>>
>> @@ -390,6 +415,20 @@ static int qfprom_probe(struct platform_device *pdev)
>>   		econfig.nkeepout = soc_data->nkeepout;
>>   	}
>>
>> +	/* The corrected section is always provided */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +
>> +	if (soc_data && soc_data->secure) {
>> +		priv->qfpseccorrected = res->start;
>> +		econfig.reg_read = qfprom_sec_reg_read;
>> +	} else {
>> +		priv->qfpcorrected = devm_ioremap_resource(dev, res);
>> +		if (IS_ERR(priv->qfpcorrected))
>> +			return PTR_ERR(priv->qfpcorrected);
>> +	}
>> +
>> +	econfig.size = resource_size(res);
>> +
>>   	/*
>>   	 * If more than one region is provided then the OS has the ability
>>   	 * to write.
>> --
>> 2.17.1
>>

