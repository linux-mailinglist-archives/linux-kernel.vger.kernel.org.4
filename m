Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A5A6A821F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCBM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:27:20 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1635F46156;
        Thu,  2 Mar 2023 04:27:17 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3229fFKf031978;
        Thu, 2 Mar 2023 12:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/w7lQupZmeqPD5Z8pU6ZtSRWQ6MYh8vv2P922lnRo0w=;
 b=JxDGu/QQGYekye8r2PLvFh5lFZNNjPPUBOKF9AaN57jpvgPBzmufIvv3BDD0+/5es95S
 YWFVeS6syMcD5ODiR4S4GNO4JI8gk2hiXvqquXoMvQghAahapdNGGEL/Dx/BSiGBnjKz
 AAqCfkF25ZmAogUmM76CCRENmk98n5EhabbKhIf+SZrxT6H1riRuqM9/FWNPhA85GX1d
 Z4q6tTRu1OLj0y16mt6fxZOFjTtXQr4P5UdEWLuNzqGLfQfu/Ka/NdmF1JNHRSvJd4e0
 04P+ENer6NeRzp3+BRVwUcrgI6Ntrs94mZjsMjeuV0jD4tvY5k7J8028LW/k9W567NYS Ww== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2cur25ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 12:27:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 322CRB4r002586
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 12:27:11 GMT
Received: from [10.50.55.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 04:27:06 -0800
Message-ID: <56671b88-af51-221f-5d72-8775fd07a433@quicinc.com>
Date:   Thu, 2 Mar 2023 17:57:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] media: venus: hfi_venus: Write to VIDC_CTRL_INIT
 after unmasking interrupts
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-6-58c2c88384e9@linaro.org>
 <54bd7d0b-b47b-dfae-f62e-9393162d79a7@linaro.org>
 <71fd2070-d986-6359-eeca-6105f0835a1b@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <71fd2070-d986-6359-eeca-6105f0835a1b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jZ_8F9B4mkC17YfRcPtUaXeBH0aOUV49
X-Proofpoint-ORIG-GUID: jZ_8F9B4mkC17YfRcPtUaXeBH0aOUV49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_06,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 mlxlogscore=896
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020107
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/28/2023 9:29 PM, Konrad Dybcio wrote:
>
> On 28.02.2023 16:33, Bryan O'Donoghue wrote:
>> On 28/02/2023 15:24, Konrad Dybcio wrote:
>>> The downstream driver signals the hardware to be enabled only after the
>>> interrupts are unmasked, which... makes sense. Follow suit.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> index 772e5e9cf127..4d785e53aa0b 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>>> @@ -454,7 +454,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>>        void __iomem *wrapper_base = hdev->core->wrapper_base;
>>>        int ret = 0;
>>>    -    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>>        if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>>>            mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>>>            mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>>> @@ -466,6 +465,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>>        writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>>>        writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>>>    +    writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>>>        while (!ctrl_status && count < max_tries) {
>>>            ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
>>>            if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
>>>
>> This should go before you add your new macros in-place of IS_V6() and it should have a fixes.
> Ack
>
> Konrad

Agree with Bryan and this change looks fine to me.

>> ---
>> bod
