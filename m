Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38B4711FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 08:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjEZGTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 02:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEZGTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 02:19:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E40125;
        Thu, 25 May 2023 23:19:50 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q5DK2h031470;
        Fri, 26 May 2023 06:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Em+1kCMTUyu1hcCs0oHqMvmgA2cmimLiEpDo/Eg5fFQ=;
 b=Huz9+ad4r5fGY51aGPCEURqFzb9XtXW/63bmUtkV5KuRCUsuUpgb8l2RiWLDTguGXNkE
 JhmRTXQJgR3TjNDX6D5ABoFgKvXcUCuog9VZv7rwMSBvhaMQBwbrS8iss3Imrv8nC5vy
 NKphPnMqT6SVoXlS0UND92xRy+nNoKs+ebmXQA/4UXMKNV1qc/bRnaMscnnWxGIBJa+G
 BdPzRnx5ddI9v6WYHCI6/dsNe2B58GfXJRFBQZnDuZxS/w+gfOkETHxf3ZewRRThbEDd
 /T26JMJhS3Y3WZ4ZV1AagSYQYN7otuqVVA+1lWt/S4LlDcnyWz+RiHDVakl3RlMG3oIC xw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt5uft78w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 06:19:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q6J2Ru020987
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 06:19:02 GMT
Received: from [10.50.56.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 23:18:56 -0700
Message-ID: <b22b35fb-021c-2e46-e8ae-9df73c6a8dc0@quicinc.com>
Date:   Fri, 26 May 2023 11:48:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 06/17] media: venus: hfi_venus: Sanitize
 venus_boot_core() per-VPU-version
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
 <20230228-topic-venus-v3-6-6092ae43b58f@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v3-6-6092ae43b58f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BY_F4Tklyqk_XjRzFZFxX_MKrrZ0jbUz
X-Proofpoint-GUID: BY_F4Tklyqk_XjRzFZFxX_MKrrZ0jbUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 adultscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260053
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 2:44 AM, Konrad Dybcio wrote:
> The current assumption of IS_V6 is overgeneralized. Adjust the logic
> to take the VPU hardware version into account.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 8fc8f46dc390..5af24e98caf0 100644
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
> @@ -479,10 +480,11 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>  	if (count >= max_tries)
>  		ret = -ETIMEDOUT;
>  
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>  		writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
> +
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>  		writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
> -	}
above two if conditions can be combined.

Thanks,
Dikshita
>  
>  	return ret;
>  }
> 
