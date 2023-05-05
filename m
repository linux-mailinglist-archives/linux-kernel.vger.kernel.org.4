Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316A6F8476
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjEEODJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjEEODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:03:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56601386D;
        Fri,  5 May 2023 07:03:04 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345DK5wB015321;
        Fri, 5 May 2023 14:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=s3ZpV/wGaJVzm6Y+0ycgcTbNijMXxVwmoC+9ZkURue0=;
 b=drWEER+nm7VVkaNodtwBXdEAo+j/2AOJp1BbUcpDCoCe6oGXtXcR6nLi61WZxwWYLh/X
 7ilxi+I8Uq1EOoMHtbvaYA+gH2DhjUPKPOHZmq550M1a34TvD2ldT61W10S/CO1Z/ER5
 ft4tkzWj/4PjGuVlS4pPQmnApxE+uI7sJMSAORiR34lmdCS7kk78l2SwALIjGpoOQhpX
 cJP37aJNMIlwzdWmMJM9KP2o85lOpWnaO2B7ehNfdbwn61WwxL8x1TdOh6aDOncNb5e4
 po0SEA1N6n25JGL46oiod5HKRkMOMEX3dVCzgIofT5w/ul52LuC3DXrkPZW7UH4uNCLj qg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qcb24b8rr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 May 2023 14:02:30 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 345E2ShQ001160
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 May 2023 14:02:29 GMT
Received: from [10.216.37.178] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 5 May 2023
 07:02:24 -0700
Message-ID: <2d1f85f2-42c5-1d88-7f0f-f464babfabbc@quicinc.com>
Date:   Fri, 5 May 2023 19:32:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 15/18] media: venus: vdec: Fix version check in
 vdec_set_work_route()
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
 <20230228-topic-venus-v2-15-d95d14949c79@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v2-15-d95d14949c79@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VPfwNNb5tFBHt1nsPG66A2YlsX1198OZ
X-Proofpoint-ORIG-GUID: VPfwNNb5tFBHt1nsPG66A2YlsX1198OZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050117
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
> This is not so much V6-dependent as it's IRIS(1|2|2_1). Fix it.
Again, why is it marked as fix ?
>
> Fixes: 6483a8cbea54 ("media: venus: vdec: set work route to fw")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 51a53bf82bd3..33e3f7208b1a 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -701,7 +701,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
>   	u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
>   	struct hfi_video_work_route wr;
>   
> -	if (!IS_V6(inst->core))
> +	if (!(IS_IRIS1(inst->core) || IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))

Not a good idea to add IRIS1 just for deciding work route and not at 
other places in driver. Add IRIS1 relevant

code in other aspects as well, if the patch needs to handle anything 
w.r.t IRIS1.

>   		return 0;
>   
>   	wr.video_work_route = inst->core->res->num_vpp_pipes;
>
