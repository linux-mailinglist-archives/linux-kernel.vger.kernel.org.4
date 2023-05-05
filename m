Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683466F83D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjEENWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjEENWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:22:17 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8F1F490;
        Fri,  5 May 2023 06:22:15 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Cv5Cd005378;
        Fri, 5 May 2023 13:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5EQVVhWshw5GFz8Sv8IEK/OzCkyfIIX+VeQOuoEZpIM=;
 b=Zn3ENJaOZbYlGH9+gFrg/zSQwxdHFIYCJ+azLKhNc1O9Vo5sJPrOGdLCeNQevp+AkBUx
 xlsuo+QbnAGIgUpBQ5/fmZMLSDFPUZqXirNMQRC363JNZuQK0HwBQUB/H6ggIWt6T/x+
 XUtSjkMPEZgb5E7RKdoKXw+zOJfh0m5sQNiZiotXCe1sQgmGqkSdL4aaHOKdS9T1oWjh
 8cxBzbUVKlUB/5pFCanBRHIQyl9s8mMy1C5BXj4HEK8eIlzQ9Mz8mto3WuGRgu6YMCOp
 LAO2AxFFo27wphXyQ0fvOcik4RZq74u6qdjgN4uoHl17dMulJ2YjgQq5tv628GMlWy7/ RQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qd28qg1hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 13:21:43 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345DLg5F002203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 13:21:42 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 06:21:37 -0700
Message-ID: <4a95547d-916a-3875-7752-f815429182e5@quicinc.com>
Date:   Fri, 5 May 2023 18:51:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 09/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
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
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-9-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-9-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rX-Ct0MZMASKWsBwev-uRV7u6U6rVVHx
X-Proofpoint-ORIG-GUID: rX-Ct0MZMASKWsBwev-uRV7u6U6rVVHx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_20,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050111
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
> condition for skipping part of it should be IS_IRIS2_1 and not the
> number of VPP pipes. Fix that.

Do not see any issue with existing code. IRIS2 with single pipe is 
IRIS2_1. This does not

quality as a fix to earlier implementation. Since this series introduces 
VPU versions,

IRIS2 with 1 pipe is being replaced with IRIS2_1.

-Vikash

>
> Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
> Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 9b840440a115..ca56b1a8eb71 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -549,10 +549,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
>   	u32 mask_val;
>   	int ret;
>   
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>   		writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
>   
> -		if (hdev->core->res->num_vpp_pipes == 1)
> +		if (IS_IRIS2_1(hdev->core))
>   			goto skip_aon_mvp_noc;
>   
>   		writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>
