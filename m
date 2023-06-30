Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CE5743D0C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjF3NzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjF3Ny7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:54:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED7CE5E;
        Fri, 30 Jun 2023 06:54:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UBoD09017765;
        Fri, 30 Jun 2023 13:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JPqW/yb8tupNXF0cJMpitNiYM42Q+8XjZnb82FxXeHA=;
 b=ZOe98rViwuR1ltgEy773tSVtfQcLPe2vrzzjHaBeIHXkWZ/cZ1YCo8lhHIzmNG+TgaRI
 /8ZJWAx0W54svKeaswgD331Tm4NRA9w1rRmO8iB/kIohna5+gX4HvHaubPHS+kMtwn0B
 ljgkJ3pfpMtwKLJpWRQqHJqfQ1D3UAKUs058mDv26XRvY/2AERBJV7PuvlLmCINudvDj
 S353P3j76/kWIj9ZWEREwwh2x7E28oI7ikfw01YVQrjy5gxGFFhdXDPKqhP3ZXocD1Xj
 jdGN3t0Z2ySv3COk44ftpxKM8YdZ0X+DfXn7SnNyYhPtN+kBgmIM2nme2gVUKrE3UDMQ FQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rhw70rdp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:54:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UDsr8X021079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 13:54:53 GMT
Received: from [10.216.15.2] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Fri, 30 Jun
 2023 06:54:48 -0700
Message-ID: <88407863-7f7f-aea0-e9b8-4275e667bb4b@quicinc.com>
Date:   Fri, 30 Jun 2023 19:24:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
 <CAA8EJpoZiXWDHGEgBF6KuKruQigqdy37pLH1Q_AnXsN6iRPhyA@mail.gmail.com>
 <db8ea67e-529c-856b-026e-2435a2405f6b@quicinc.com>
 <a16b57be-34cd-d093-ac63-d02aef049e51@linaro.org>
From:   Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <a16b57be-34cd-d093-ac63-d02aef049e51@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NofqB320yLJTH1vpnVFuj0hsts4OTfJ3
X-Proofpoint-GUID: NofqB320yLJTH1vpnVFuj0hsts4OTfJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=629 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306300118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/2023 6:44 PM, Dmitry Baryshkov wrote:
> On 28/06/2023 11:45, Komal Bajaj wrote:
>
> No HTML emails on public mailing lists, please.
>
>>
>>
>> On 6/23/2023 7:56 PM, Dmitry Baryshkov wrote:
>>> On Fri, 23 Jun 2023 at 17:19, Komal Bajaj<quic_kbajaj@quicinc.com>  
>>> wrote:
>>>> Add LLCC support for multi channel DDR configuration
>>>> based on a feature register. Reading DDR channel
>>>> confiuration uses nvmem framework, so select the
>>>> dependency in Kconfig. Without this, there will be
>>>> errors while building the driver with COMPILE_TEST only.
>>>>
>>>> Signed-off-by: Komal Bajaj<quic_kbajaj@quicinc.com>
>>>> ---
>>>>   drivers/soc/qcom/Kconfig     |  2 ++
>>>>   drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>>>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index a491718f8064..cc9ad41c63aa 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>> +++ b/drivers/soc/qcom/Kconfig
>>>> @@ -64,6 +64,8 @@ config QCOM_LLCC
>>>>          tristate "Qualcomm Technologies, Inc. LLCC driver"
>>>>          depends on ARCH_QCOM || COMPILE_TEST
>>>>          select REGMAP_MMIO
>>>> +       select NVMEM
>>> No need to select NVMEM. The used functions are stubbed if NVMEM is 
>>> disabled
>>
>> With the previous patch, where this config was not selected, below 
>> error was flagged by kernel test robot -
>>
>>     drivers/soc/qcom/llcc-qcom.c: In function 'qcom_llcc_get_cfg_index':
>>      >> drivers/soc/qcom/llcc-qcom.c:951:15: error: implicit declaration
>>     of function 'nvmem_cell_read_u8'; did you mean
>>     'nvmem_cell_read_u64'? [-Werror=implicit-function-declaration]
>>           951 |         ret = nvmem_cell_read_u8(&pdev->dev,
>>     "multi_chan_ddr", cfg_index);
>>               |               ^~~~~~~~~~~~~~~~~~
>>               |               nvmem_cell_read_u64
>>         cc1: some warnings being treated as errors
>
> Judging from the rest of nvmem-consumer.h, it appears that not having 
> stubs for this function is an omission. Please fix the header instead.

Okay, I will add the stub for this function in the header.

>
>>
>>>> +       select QCOM_SCM
>>>>          help
>>>>            Qualcomm Technologies, Inc. platform specific
>>>>            Last Level Cache Controller(LLCC) driver for platforms 
>>>> such as,
>>>> diff --git a/drivers/soc/qcom/llcc-qcom.c 
>>>> b/drivers/soc/qcom/llcc-qcom.c
>>>> index 6cf373da5df9..3c29612da1c5 100644
>>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/module.h>
>>>>   #include <linux/mutex.h>
>>>> +#include <linux/nvmem-consumer.h>
>>>>   #include <linux/of.h>
>>>>   #include <linux/of_device.h>
>>>>   #include <linux/regmap.h>
>>>> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct 
>>>> platform_device *pdev,
>>>>          return ret;
>>>>   }
>>>>
>>>> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, 
>>>> u8 *cfg_index)
>>>> +{
>>>> +       int ret;
>>>> +
>>>> +       ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", 
>>>> cfg_index);
>>>> +       if (ret == -ENOENT) {
>>> || ret == -EOPNOTSUPP ?
>>
>> Okay
>>
>>>> +               *cfg_index = 0;
>>>> +               return 0;
>>>> +       }
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>>>   {
>>>>          /* Set the global pointer to a error code to avoid 
>>>> referencing it */
>>>> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct 
>>>> platform_device *pdev)
>>>>          struct device *dev = &pdev->dev;
>>>>          int ret, i;
>>>>          struct platform_device *llcc_edac;
>>>> -       const struct qcom_llcc_config *cfg;
>>>> +       const struct qcom_llcc_config *cfg, *entry;
>>>>          const struct llcc_slice_config *llcc_cfg;
>>>>          u32 sz;
>>>> +       u8 cfg_index;
>>>>          u32 version;
>>>>          struct regmap *regmap;
>>>> +       u32 num_entries = 0;
>>>>
>>>>          drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>>>          if (!drv_data) {
>>>> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct 
>>>> platform_device *pdev)
>>>>
>>>>          drv_data->version = version;
>>>>
>>>> -       llcc_cfg = cfg[0]->sct_data;
>>>> -       sz = cfg[0]->size;
>>>> +       ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>>>> +       if (ret)
>>>> +               goto err;
>>>> +
>>>> +       for (entry = cfg; entry->sct_data; entry++, num_entries++)
>>>> +               ;
>>> Please add num_cfgs to the configuration data instead.
>>
>> Shall I create a new wrapper struct having a field num_cfg and a 
>> pointer to those cfgs
>> because configuration data is itself an instance of "struct 
>> qcom_llcc_config" and
>> we can have multiple instances of it.
>
> A wrapper struct is a better approach in my opinion.

Okay, will follow this approach then.

Thanks
Komal
>
>>
>>
>>>> +       if (cfg_index >= num_entries || cfg_index < 0) {
>>> cfg_index is unsigned, so it can not be less than 0.
>>
>> Okay.
>>
>>>> +               ret = -EINVAL;
>>>> +               goto err;
>>>> +       }
>>>> +
>>>> +       llcc_cfg = cfg[cfg_index].sct_data;
>>>> +       sz = cfg[cfg_index].size;
>>>>
>>>>          for (i = 0; i < sz; i++)
>>>>                  if (llcc_cfg[i].slice_id > drv_data->max_slices)
>>>> -- 
>>>> 2.40.1
>>>>
>>
>

