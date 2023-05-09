Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E834B6FC53E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjEILms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjEILmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:42:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B41BC;
        Tue,  9 May 2023 04:42:44 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3497uKu1009002;
        Tue, 9 May 2023 11:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TF851nY794WGc1BSkhb3JyJpU3YjFEsvOhd3HkDE+uU=;
 b=XnTHbuBbYcgA9WtAvUGzn1/QtUNH34DCL/s4hfD+8kBb3mIVr0va2HBzvssM0y0AoUFT
 mFQ/smwi/f0fK7n9DH8mDcRR4NirgSHPCKQUjzwSCnVwCMTr/OJm3r4Z+oZoj0CDxUVz
 F7im/zcA7Zb7uq791xHLeMRXYnPPEoZpNT04xHueSIpo67wTJ4QGax8lXsb4mhVgepNz
 tBZstbkU2LajDJBK6vbnJ7XDQIOn9FzeiawJGMy1N25fviLlC28b7HSr0WF971a+BQeK
 2jiRAt0bmoVS1dqzLqaRKqieXOjHvK9h59tr+h26tFfQYBYmCEt+zJeKl0yKmslNMAyV xA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qf7851kq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 11:42:11 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 349Bg9E7013890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 9 May 2023 11:42:09 GMT
Received: from [10.216.61.171] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 9 May 2023
 04:42:04 -0700
Message-ID: <f0590f97-2504-f5e4-9057-e16dc2633f36@quicinc.com>
Date:   Tue, 9 May 2023 17:12:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 02/18] media: venus: hfi_venus: Write to VIDC_CTRL_INIT
 after unmasking interrupts
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
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        <stable@vger.kernel.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-2-d95d14949c79@linaro.org>
 <bfda6e09-2674-8ef1-11b2-83f631329c51@quicinc.com>
 <e5f7420c-2e09-8a29-0958-da0a74fc98b4@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <e5f7420c-2e09-8a29-0958-da0a74fc98b4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IG-wx5tlkG6LxFrT0T1Bs1zk7UD0ChMi
X-Proofpoint-GUID: IG-wx5tlkG6LxFrT0T1Bs1zk7UD0ChMi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_07,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 mlxlogscore=916 impostorscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090093
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/2023 12:18 AM, Konrad Dybcio wrote:
> 
> 
> On 5.05.2023 14:33, Vikash Garodia wrote:
>>
>> On 5/4/2023 1:30 PM, Konrad Dybcio wrote:
>>> The downstream driver signals the hardware to be enabled only after the
>>> interrupts are unmasked, which... makes sense. Follow suit.
>>
>> Rephrase the commit text,
>>
>> 1. No need to mention downstream driver, if something is buggy, fix it.
> Generally I'd agree, however in this specific case the downstream
> driver is the only available source of knowledge about what the correct
> (or at least working) initialization sequence of this hw block is.
Ideal way would be to refer the sequence of register programming from hardware
programming guide (HPG). In this case, the commit can describe the change which
is being done and reviewer/maintainer can certify the sequence from the HPG.
Also downstream driver can be buggy too, so IMO, it is not the right reference.

-Vikash

>>
>> 2. Avoid "..." and lets make it more formal.
> Ack
> 
> Konrad
>>
>>> Cc: stable@vger.kernel.org # v4.12+
>>> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> index bff435abd59b..8fc8f46dc390 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> @@ -453,7 +453,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>>       void __iomem *wrapper_base = hdev->core->wrapper_base;
>>>       int ret = 0;
>>>   -    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>>       if (IS_V6(hdev->core)) {
>>>           mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>>>           mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>>> @@ -464,6 +463,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>>       writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>>>       writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>>>   +    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>>       while (!ctrl_status && count < max_tries) {
>>>           ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
>>>           if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
>>
>> Above code looks good.
>>
>> -Vikash
>>
