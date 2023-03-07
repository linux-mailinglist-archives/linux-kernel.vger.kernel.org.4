Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFD96AD72C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 07:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjCGGMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 01:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjCGGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 01:12:28 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95698567AF;
        Mon,  6 Mar 2023 22:12:27 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3272aIpU030883;
        Tue, 7 Mar 2023 06:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=it/94AUcTq/LJ+zbFq0JcLSQYboFeEing8AEe40H7Qc=;
 b=AWbtLkTAN+5R9imugVKO5D/T2O6gUb4vkHnztN1AN/dVGoXNiUUJsrNKo06o6foPtprA
 YHiywBdyL9NoNQiH8O+m+n0FOSSG+q/gY7IlSO7w9rXNd03KHTz730z+/VK9bPVNiN/B
 jpWJpcq5vj4mitjGzWGYF1aF1bG+Eoa0joLIdAaO2ThNcVUVY5Rz/1qVxqkI1b2dlbf6
 qBWgftp1Id4ksgJo1bW99b5d28V7taWIs2g6zbHrkYiY6LGDxYy8gg/YRXp9ZXO7fEEu
 HXtgjM4eyLB3ynlR+816FOGr2RsXncQfafQyHX0Ti/oLbilONPY1VyCwjnDhFhiGjcFE dg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p4g3mww6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 06:12:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3276CL0T024869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 06:12:21 GMT
Received: from [10.50.8.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Mar 2023
 22:12:17 -0800
Message-ID: <d22e37d3-4d3e-b702-c6b2-99c8f6fccfba@quicinc.com>
Date:   Tue, 7 Mar 2023 11:42:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/18] media: venus: hfi_venus: Fix version checks in
 venus_isr()
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-9-58c2c88384e9@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v1-9-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4DwxnI2_4Q_2qKFcGxh4f-pm4Nh3AVYi
X-Proofpoint-GUID: 4DwxnI2_4Q_2qKFcGxh4f-pm4Nh3AVYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303070056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
> IS_V6 was used there IS_IRIS2(_1) should have been and the !IS_V6
> condition was only correct by luck and for now. Replace them both
> with VPU version checks.
>
> Fixes: 24fcc0522d87 ("media: venus: hfi: Add 6xx interrupt support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 0d137e070407..ecfbac36de20 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1136,7 +1136,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
>   	wrapper_base = hdev->core->wrapper_base;
>   
>   	status = readl(wrapper_base + WRAPPER_INTR_STATUS);
> -	if (IS_V6(core)) {
> +	if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>   		if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
>   		    status & WRAPPER_INTR_STATUS_A2HWD_MASK_V6 ||
>   		    status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
> @@ -1148,7 +1148,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
>   			hdev->irq_status = status;
>   	}
>   	writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
> -	if (!IS_V6(core))
> +	if (!(IS_AR50_LITE(core) || IS_IRIS2(core) || IS_IRIS2_1(core)))
>   		writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
>   
>   	return IRQ_WAKE_THREAD;
reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
