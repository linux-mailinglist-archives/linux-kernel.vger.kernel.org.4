Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03EB688448
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBBQYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBBQXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:23:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0766FBD;
        Thu,  2 Feb 2023 08:23:25 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312Do5g5021826;
        Thu, 2 Feb 2023 16:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i/fsI78IyBx9bILc4falVES2Hy0Lak/0OFe96ksei3c=;
 b=LqpU9PwGcgdU2qPoWZXYtKtNLqdbt9dWYP+YXpKm0B9mM4fhQ5MM//ueN9SwPx30P1SQ
 uzhMqDUmHyWFXxzc0POiWs9Ud89dAPvf5jZQix118bpDPShS1WHhuhZi1BqzWIJLjUZ8
 BA/HaNuJM6JQ+UlO0Iy1QFAnVa8NwAUyK1M4xydL7NvdLWD7MW9rMTUEWuLEIXFreGY5
 rJ8SFKvXp0dXKZBuDdQcUDglp0ezcwboQjf7jQpRo18/E8IChrkX2d3sqjBIzGjG0TUT
 fEIGzIOUDtvElI73f1b1ShOeSirWdYVXe+yzevQcTfLxY7T1VMOCJwZpIh72Djg7Y4jr Fw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfvgbjgr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 16:22:59 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 312GMvqd032326
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Feb 2023 16:22:57 GMT
Received: from [10.50.47.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 08:22:52 -0800
Message-ID: <22fbca02-2f1e-baac-b7c1-9fcba71565d2@quicinc.com>
Date:   Thu, 2 Feb 2023 21:52:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/6] clk: qcom: apss-ipq-pll: refactor the driver to
 accommodate different PLL types
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-2-quic_kathirav@quicinc.com>
 <97e9ae36-6736-0db8-4044-4e874c5af5f4@linaro.org>
 <9ebaa72c-e4d5-ddb4-9d3c-f0d669465991@quicinc.com>
 <1948642d-dab9-4f20-9408-de7c952b9109@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1948642d-dab9-4f20-9408-de7c952b9109@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mZBMRR4hr0Oux0iKb4qEGydnKmWTRIKf
X-Proofpoint-ORIG-GUID: mZBMRR4hr0Oux0iKb4qEGydnKmWTRIKf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_10,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020146
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2023 9:26 PM, Konrad Dybcio wrote:
>
> On 2.02.2023 16:37, Kathiravan T wrote:
>> On 2/2/2023 8:45 PM, Konrad Dybcio wrote:
>>> On 2.02.2023 15:52, Kathiravan T wrote:
>>>> APSS PLL found on the IPQ8074 and IPQ6018 are of type Huayra PLL. But,
>>>> IPQ5332 APSS PLL is of type Stromer Plus. To accommodate both these PLLs,
>>>> refactor the driver to take the clk_alpha_pll, alpha_pll_config via device
>>>> data.
>>>>
>>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>>> ---
>>>>    drivers/clk/qcom/apss-ipq-pll.c | 55 +++++++++++++++++++++------------
>>>>    1 file changed, 36 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>>>> index a5aea27eb867..6e815e8b7fe4 100644
>>>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>>>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>>>> @@ -8,20 +8,22 @@
>>>>      #include "clk-alpha-pll.h"
>>>>    -static const u8 ipq_pll_offsets[] = {
>>>> -    [PLL_OFF_L_VAL] = 0x08,
>>>> -    [PLL_OFF_ALPHA_VAL] = 0x10,
>>>> -    [PLL_OFF_USER_CTL] = 0x18,
>>>> -    [PLL_OFF_CONFIG_CTL] = 0x20,
>>>> -    [PLL_OFF_CONFIG_CTL_U] = 0x24,
>>>> -    [PLL_OFF_STATUS] = 0x28,
>>>> -    [PLL_OFF_TEST_CTL] = 0x30,
>>>> -    [PLL_OFF_TEST_CTL_U] = 0x34,
>>>> +static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
>>>> +    [CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
>>> Is it really huayra? The definition in clk-alpha-pll.c is
>>> different..
>>
>> As per the HW document, yes it is Huayra. When you say "different", I understand these offsets are not matching with the one in clk-alpha-pll.c right? I checked with the sub system owner and they said it is expected since these PLLs are specific to each subsystem(A53 and GCC), so the offsets are different.
> Okay, that makes sense. Could you please leave a comment about this
> in the code?


Sure, will do it in V2.


> Konrad
>>
>> Thanks,
>>
>> Kathiravan T.
>>
>>
>>>
>>> Konrad
>>>> +        [PLL_OFF_L_VAL] = 0x08,
>>>> +        [PLL_OFF_ALPHA_VAL] = 0x10,
>>>> +        [PLL_OFF_USER_CTL] = 0x18,
>>>> +        [PLL_OFF_CONFIG_CTL] = 0x20,
>>>> +        [PLL_OFF_CONFIG_CTL_U] = 0x24,
>>>> +        [PLL_OFF_STATUS] = 0x28,
>>>> +        [PLL_OFF_TEST_CTL] = 0x30,
>>>> +        [PLL_OFF_TEST_CTL_U] = 0x34,
>>>> +    },
>>>>    };
>>>>    -static struct clk_alpha_pll ipq_pll = {
>>>> +static struct clk_alpha_pll ipq_pll_huayra = {
>>>>        .offset = 0x0,
>>>> -    .regs = ipq_pll_offsets,
>>>> +    .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
>>>>        .flags = SUPPORTS_DYNAMIC_UPDATE,
>>>>        .clkr = {
>>>>            .enable_reg = 0x0,
>>>> @@ -61,6 +63,21 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>>>>        .test_ctl_hi_val = 0x4000,
>>>>    };
>>>>    +struct apss_pll_data {
>>>> +    struct clk_alpha_pll *pll;
>>>> +    const struct alpha_pll_config *pll_config;
>>>> +};
>>>> +
>>>> +static struct apss_pll_data ipq8074_pll_data = {
>>>> +    .pll = &ipq_pll_huayra,
>>>> +    .pll_config = &ipq8074_pll_config,
>>>> +};
>>>> +
>>>> +static struct apss_pll_data ipq6018_pll_data = {
>>>> +    .pll = &ipq_pll_huayra,
>>>> +    .pll_config = &ipq6018_pll_config,
>>>> +};
>>>> +
>>>>    static const struct regmap_config ipq_pll_regmap_config = {
>>>>        .reg_bits        = 32,
>>>>        .reg_stride        = 4,
>>>> @@ -71,7 +88,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
>>>>      static int apss_ipq_pll_probe(struct platform_device *pdev)
>>>>    {
>>>> -    const struct alpha_pll_config *ipq_pll_config;
>>>> +    const struct apss_pll_data *data;
>>>>        struct device *dev = &pdev->dev;
>>>>        struct regmap *regmap;
>>>>        void __iomem *base;
>>>> @@ -85,23 +102,23 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>>>>        if (IS_ERR(regmap))
>>>>            return PTR_ERR(regmap);
>>>>    -    ipq_pll_config = of_device_get_match_data(&pdev->dev);
>>>> -    if (!ipq_pll_config)
>>>> +    data = of_device_get_match_data(&pdev->dev);
>>>> +    if (!data)
>>>>            return -ENODEV;
>>>>    -    clk_alpha_pll_configure(&ipq_pll, regmap, ipq_pll_config);
>>>> +    clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
>>>>    -    ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
>>>> +    ret = devm_clk_register_regmap(dev, &data->pll->clkr);
>>>>        if (ret)
>>>>            return ret;
>>>>          return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
>>>> -                       &ipq_pll.clkr.hw);
>>>> +                       &data->pll->clkr.hw);
>>>>    }
>>>>      static const struct of_device_id apss_ipq_pll_match_table[] = {
>>>> -    { .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
>>>> -    { .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
>>>> +    { .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>>>> +    { .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
>>>>        { }
>>>>    };
>>>>    MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
