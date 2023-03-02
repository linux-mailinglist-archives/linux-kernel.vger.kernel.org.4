Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F216A825D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCBMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCBMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:36:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDBA301A4;
        Thu,  2 Mar 2023 04:36:44 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322AD2tm024258;
        Thu, 2 Mar 2023 12:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ik4MkDp+5de9ERY4gWJP4ao+AH0xhJotFGitbqYlW8g=;
 b=JN8LwIVMya8YyKYiRND/RACCBusDXptvODHkVQov2iIXEe7/Hls5FZfmcyTYNPh5Gk7r
 +mAtDHxALUNPzgSA44owVKZPLLgxajJ+ek9lchwLw5ZAstuW8Oxmuw502FCysyf6BS/V
 QqhAP59iKdnmoiJrdQGlXX40G4IIc0Q2sh8/vwm5T/gFHgwgasYv8GTK2U61WZvSnNTH
 Lse/DTZOg7fAQ5HjUwuED1/mkF4SHBb6kxoy+rIkd552EG/czayWmZY2oQuIh5IVUGd2
 c8T4mALjwo9Kh777fmt4TF+pNkn01jQ3IqiCwyBEQAoPv9N3LW2j2CiRML6dDeCjGuq/ 2w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2ar12mjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 12:36:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322Ca7Zr014391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 12:36:07 GMT
Received: from [10.50.55.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 04:36:02 -0800
Message-ID: <7b88b9c5-24cb-eca3-94f8-0592cb2348f1@quicinc.com>
Date:   Thu, 2 Mar 2023 18:05:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Vikash Garodia" <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-8-58c2c88384e9@linaro.org>
 <a5fe6f7d-d410-9903-789c-d8c760ce6f1b@linaro.org>
 <3d424869-dcdb-5ef7-5cba-0025924e2f50@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <3d424869-dcdb-5ef7-5cba-0025924e2f50@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dS8AQ0bOsVglZmrRrcaTH8jKcNh82KhS
X-Proofpoint-ORIG-GUID: dS8AQ0bOsVglZmrRrcaTH8jKcNh82KhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020109
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 9:31 PM, Konrad Dybcio wrote:
>
> On 28.02.2023 16:36, Bryan O'Donoghue wrote:
>> On 28/02/2023 15:24, Konrad Dybcio wrote:
>>> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
>>> condition for skipping part of it should be IS_IRIS2_1 and not the
>>> number of VPP pipes. Fix that.
>>>
>>> Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
>>> Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> index 4d785e53aa0b..0d137e070407 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> @@ -550,10 +550,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
>>>        u32 mask_val;
>>>        int ret;
>>>    -    if (IS_V6(hdev->core)) {
>>> +    if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>>>            writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
>>>    -        if (hdev->core->res->num_vpp_pipes == 1)
>>> +        if (IS_IRIS2_1(hdev->core))
>>>                goto skip_aon_mvp_noc;
>>>              writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
>>>
>> If you want to denote these as fixes, you need your patch 02/18 as a depend...
> The main purpose of the Fixes tag is to mark commits that fix bugs in
> existing code and it only assists in autoselecting stable patches.
> Backporting this makes little sense, as we only support IRIS2 (8250)
> and IRIS2_1 (7280) HFI6 platforms and new additions won't be backported.
>
> Konrad

IRIS2_1 is nothing but IRIS2 with 1 VPP pipe (just a downstream notation 
to differentiate between two IRIS2 based chips).

So having the num_vpp_pipes check was fine, nothing wrong with that.

but since now you are introducing new VPU based check, it can be 
replaced with IRIS2_1 check.

Thanks,

Dikshita

>> ---
>> bod
