Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810616DF84B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjDLOW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDLOWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:22:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18849C2;
        Wed, 12 Apr 2023 07:22:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CDCcfZ002529;
        Wed, 12 Apr 2023 14:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=A6rkTKdrp8pWYrTITfHeeRZBDsC4+SFAsWLmky1OPHA=;
 b=k/zW38eNGmfyTt2lmRjcaRALhfG8zGZeKEKK090AuweShwtd8mzfNhUPhbysKX0lCZ69
 sJJyIFR0JE0k92c8FARjeW0F8a111VxLmy0LB6g3ExbtphWtv0O/x6iUvMYN2Ra0bT1M
 cCSAW+owArd0LLIYAlaRMTWvFZq0Sa5Mn4qG4rpt9gXNOzEQEoA1oBP/t4xphXW1OzCn
 fK1YExp1CdVMJcZHlPn0WgA4QhozHs4APeyU3D/KtjGt90HjWuOjHy1x6Jnhugf7n+kX
 nuJ7ZHYFckaakZLlAmiCx9aIZJRgSRJ0epe1btAwkjwp0BNJ6Qpshgf6vUiIN6YtxmZZ Vw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqens19h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:22:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CEM8NP011605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:22:08 GMT
Received: from [10.50.1.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 07:22:04 -0700
Message-ID: <d260f351-1cf1-aecc-e8f5-d0877ed04ab6@quicinc.com>
Date:   Wed, 12 Apr 2023 19:52:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
 <20230407154132.dpguz24f6rukyujq@ripper>
 <8cf793df-b676-bbb4-0601-5647d58bb2b3@quicinc.com>
 <7e180b96-6f47-6b25-8751-01b5186c8c71@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <7e180b96-6f47-6b25-8751-01b5186c8c71@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RaIiqXVUvlEMlkFQilcFQS4ByNlfVERI
X-Proofpoint-ORIG-GUID: RaIiqXVUvlEMlkFQilcFQS4ByNlfVERI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120126
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 1:47 PM, Krzysztof Kozlowski wrote:
> On 10/04/2023 08:48, Souradeep Chowdhury wrote:
>>
>>
>> On 4/7/2023 9:11 PM, Bjorn Andersson wrote:
>>> On Fri, Apr 07, 2023 at 07:34:36PM +0530, Souradeep Chowdhury wrote:
>>>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>>>> stats, like the time when the bootloader started execution and at what
>>>> point the bootloader handed over control to the kernel etc. in the IMEM
>>>> region. This information is captured in a specific format by this driver
>>>> by mapping a structure to the IMEM memory region and then accessing the
>>>> members of the structure to print the information. This information is
>>>> useful in verifying if the existing boot KPIs have regressed or not.
>>>> A sample log in SM8450(waipio) device is as follows:-
>>>>
>>>> KPI: Pre ABL Time = 3s
>>>> KPI: ABL Time = 14s
>>>
>>> Why are these in whole seconds?
>>
>> This is to give a granular view of time.
>>
>>>
>>>> KPI: Kernel MPM timestamp = 890206
>>>
>>> And why is this presented in cycles?
>>
>> This timestamp is used as an intermediate value for calculating one of
>> the KPIs. Can be changed to seconds as well for consistency.
>>
>>>
>>>>
>>>> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
>>>> stage and the timestamp generated by the sleep counter is logged by
>>>> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
>>>> starts execution which is logged here as "Pre ABL Time" and the second
>>>> when it is about to load the kernel logged as "ABL Time". Both are
>>>> logged in the unit of seconds.
>>>
>>> We have a policy to not taint the kernel log with "useless" information,
>>> for kernel developers this seems to add no value and for end users
>>> there's no benefit to this.
>>>
>>>> The current kernel timestamp is
>>>> printed by the boot_stats driver as well.
>>>>
>>>
>>> Why?
>>
>> Same as stated above.
> 
> You did not answer. The question is "why do you think printing this
> during boot is suitable for wide usage?". I don't find answer "give a
> granular view of time" anyway related.
> 
> Please come with rationale why such printing should be used in Linux
> kernel at all, given that as Bjorn said - we do not print
> debugging/profiling information.
> 
> You should probably come with a debugfs interface for this.

Ack. The debugfs interface for this will be present in the next version.

> 
> Best regards,
> Krzysztof
> 
