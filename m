Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A3719679
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjFAJLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjFAJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:11:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAEE7;
        Thu,  1 Jun 2023 02:11:11 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3518O0Mw012420;
        Thu, 1 Jun 2023 09:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ePa9XwvdBgy6fhfjN8vd2RXaK7otIJmK3vM+Waa6444=;
 b=KAtIvsAA0TJv9quD5NbSp3tcn856xqxp7yymj3lBkiMQSvGPuYqBC50VT0Zai4gUfC6d
 pLcuj9KKHGd+GWF+lK9w1T4nMrtDr6NbIDirCzTE13m+RgWLMTlPEdmzkRVTEhRRFO9k
 0eWJHGlOHWGYp8APh/+qdea4AqnpQ9W+ME7Chvvhc7uwE/nHI/XpBlwWL1wbucVfNDeW
 jhO2jJCpXQ+3ltA7fQANLI0UKlJAwfYve5fzyFK8cxuSnZcFrS5tVZJUB+N/B5URyk/A
 M42PsmEIhA2wIU4NnlijQvNDIu4HATbv0cmmzhpDYHgBm1tZ1LSTU1zdeVHTJoFsUSq+ BA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxpt707b1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:10:41 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3519AfYj025264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:10:41 GMT
Received: from [10.216.48.115] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:10:35 -0700
Message-ID: <e50e226d-7c45-8dcb-c51f-6ac62896c8ed@quicinc.com>
Date:   Thu, 1 Jun 2023 14:40:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 06/17] media: venus: hfi_venus: Sanitize
 venus_boot_core() per-VPU-version
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
 <20230228-topic-venus-v4-6-feebb2f6e9b8@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v4-6-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UXu0ACsq1xhoSbe5VgAo4ZVAt0xgkym8
X-Proofpoint-GUID: UXu0ACsq1xhoSbe5VgAo4ZVAt0xgkym8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010082
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2023 6:00 PM, Konrad Dybcio wrote:
> The current assumption of IS_V6 is overgeneralized. Adjust the logic
> to take the VPU hardware version into account.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 5506a0d196ef..9e36ef9076a0 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -447,19 +447,20 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>  {
>  	struct device *dev = hdev->core->dev;
>  	static const unsigned int max_tries = 100;
> -	u32 ctrl_status = 0, mask_val;
> +	u32 ctrl_status = 0, mask_val = 0;
>  	unsigned int count = 0;
>  	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>  	void __iomem *wrapper_base = hdev->core->wrapper_base;
>  	int ret = 0;
>  
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>  		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>  		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>  			      WRAPPER_INTR_MASK_A2HCPU_MASK);
>  	} else {
>  		mask_val = WRAPPER_INTR_MASK_A2HVCODEC_MASK;
>  	}
> +
>  	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>  	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>  
> @@ -479,7 +480,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>  	if (count >= max_tries)
>  		ret = -ETIMEDOUT;
>  
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>  		writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
>  		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
>  	}
> 
