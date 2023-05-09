Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139CB6FC604
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjEIMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjEIMMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:12:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A2940FF;
        Tue,  9 May 2023 05:12:52 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3497qnRO010896;
        Tue, 9 May 2023 12:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gsfrIH2o13ftVfi1aAlLhsiPu/t999yIHt6DplBOmf4=;
 b=Kqr/Bp0yLQ5PxOvFj8EdiZR4DWycyT7r7XFeEYtddtT7rtiT5AYZLDcPc/+jsH1t4CU4
 /wmGinwOMkzv0gq1kRDkYDdFMhcIdamDFPryMBlEfqJhvv2SydfYrrPgttS4nh/10Znb
 bbncKyqo8gCB0DdeiZ/isxS187lvM8GEi8exPvL5cwOv6965uTAugjp6BZXgUWyTciaB
 hLMenR/GGgUJV0cYUC/YN1hsDW2Pi+iUJsz/LjeKxJddoyhW8bJ5H/8O5OqdKbLcz99J
 p73FqM2rXv4AjA1Xx/4Az0pUTLN7GeG369Q3mAjxmXyV92CBiqaEg9m/xGyFl5h4Qsh+ ug== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf77kspj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 12:12:18 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349CCHXm021146
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 12:12:17 GMT
Received: from [10.216.61.171] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 05:12:13 -0700
Message-ID: <5a12aa8f-eafe-764b-d77a-9b5b7c512175@quicinc.com>
Date:   Tue, 9 May 2023 17:42:09 +0530
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
 <2d1f85f2-42c5-1d88-7f0f-f464babfabbc@quicinc.com>
 <0cfbb9ed-1bb0-ea9e-9896-9d3896ae18ff@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <0cfbb9ed-1bb0-ea9e-9896-9d3896ae18ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UDqoAr-Ys_ENwe-pECBu8R5f090sVwv1
X-Proofpoint-ORIG-GUID: UDqoAr-Ys_ENwe-pECBu8R5f090sVwv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090098
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2023 12:45 AM, Konrad Dybcio wrote:
> 
> 
> On 5.05.2023 16:02, Vikash Garodia wrote:
>>
>> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>>> This is not so much V6-dependent as it's IRIS(1|2|2_1). Fix it.
>> Again, why is it marked as fix ?
> It corrects the logic but does not manifest on currently
> supported hardware. I'll reword it and drop the fixes tag.
> 
>>>
>>> Fixes: 6483a8cbea54 ("media: venus: vdec: set work route to fw")
>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/vdec.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>>> index 51a53bf82bd3..33e3f7208b1a 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -701,7 +701,7 @@ static int vdec_set_work_route(struct venus_inst *inst)
>>>       u32 ptype = HFI_PROPERTY_PARAM_WORK_ROUTE;
>>>       struct hfi_video_work_route wr;
>>>   -    if (!IS_V6(inst->core))
>>> +    if (!(IS_IRIS1(inst->core) || IS_IRIS2(inst->core) || IS_IRIS2_1(inst->core)))
>>
>> Not a good idea to add IRIS1 just for deciding work route and not at other places in driver. Add IRIS1 relevant
>>
>> code in other aspects as well, if the patch needs to handle anything w.r.t IRIS1.
> I'd say that correcting this condition is fair regardless. I can
> however delay this patch until IRIS1 enablement if you'd prefer
> that.

Lets add IRIS1 along with other IRIS1 changes.

> Konrad
>>
>>>           return 0;
>>>         wr.video_work_route = inst->core->res->num_vpp_pipes;
>>>
