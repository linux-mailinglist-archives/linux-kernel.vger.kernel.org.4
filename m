Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19846A809C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjCBLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCBLBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:01:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1164615C;
        Thu,  2 Mar 2023 03:01:10 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229f6nO031824;
        Thu, 2 Mar 2023 11:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cYOzM4JlJ8Njrd6UKUPZEMT9RhwG+is1Yriby3JZYa0=;
 b=W92gM6yEADlpAnyeZYAFW+zQtOSV+8bdC2FRkwJrdDYvS9tNwFS3KHcqDCnRWMIR244/
 DipMVbBwPlLoyIvcdttfCJtW3UPSEV49v6rMtXIGFkAI6XpY754pTxwndxVov/yy+V6T
 bJu7VPrYRWFDlnLtqy7aTpzqEwSg4Deg1E2xJ4yWfyeSaIwpWM2vwKV1W2c9F3mCZeWd
 n6K9jAIcEbEXQaTXiWY55qpXsc2KymE0W02h8/jfGWzcVbWa6da9axq/IGP8Tf0SF30w
 NrIqzQO9V6m1o2aRfMcrSgIvqc7j/96wQmwskCjZRYXI+6/q1myYXIsJKqzZE400LZe7 eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2cur1wgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 11:00:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322B0XAk025111
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 11:00:33 GMT
Received: from [10.50.55.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 03:00:27 -0800
Message-ID: <769b4971-aed8-ce6a-b77a-29660957ec38@quicinc.com>
Date:   Thu, 2 Mar 2023 16:30:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/18] media: venus: hfi_venus: Sanitize venus_boot_core()
 per-VPU-version
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-5-58c2c88384e9@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v1-5-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: uaAQz_rp76XZGY104KjEjraiJUnOMu2d
X-Proofpoint-ORIG-GUID: uaAQz_rp76XZGY104KjEjraiJUnOMu2d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020094
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
> The current assumption of IS_V6 is overgeneralized. Adjust the logic
> to take the VPU hardware version into account.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 4ccf31147c2a..772e5e9cf127 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -448,20 +448,21 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>   {
>   	struct device *dev = hdev->core->dev;
>   	static const unsigned int max_tries = 100;
> -	u32 ctrl_status = 0, mask_val;
> +	u32 ctrl_status = 0, mask_val = 0;
>   	unsigned int count = 0;
>   	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>   	void __iomem *wrapper_base = hdev->core->wrapper_base;
>   	int ret = 0;
>   
>   	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {

I think the IRIS1 check can be removed from here as we are not handling 
IRIS1 related things at other places.

we can add the required checks for IRIS1 when we add support for any 
IRIS1 based chipset.

Thanks,

Dikshita

>   		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>   		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>   			      WRAPPER_INTR_MASK_A2HCPU_MASK);
>   	} else {
>   		mask_val = WRAPPER_INTR_MASK_A2HVCODEC_MASK;
>   	}
> +
>   	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>   	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>   
> @@ -480,10 +481,11 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>   	if (count >= max_tries)
>   		ret = -ETIMEDOUT;
>   
> -	if (IS_V6(hdev->core)) {
> +	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>   		writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
> +
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>   		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
> -	}
>   
>   	return ret;
>   }
>
