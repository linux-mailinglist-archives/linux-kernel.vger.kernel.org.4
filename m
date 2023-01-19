Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E01674643
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjASWhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjASWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:36:34 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB24A5CE5;
        Thu, 19 Jan 2023 14:18:26 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JMEgIV023694;
        Thu, 19 Jan 2023 22:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AxkyY/06uGUrmuwDgIjlBDb5C2vYmq8tk8MxpWGbAkY=;
 b=TchB5w/RTzPV+HNyAyJ72jLoaLB9P7XTT7MXTEP8WOPDJMIGPnrjkYBDD3p2q/du6Kc4
 CmNP7GKIEJYomyl44dBAJpx8p8lhURQgQU8vTeRhv1jrRMRmGp/th7iLkgDYFjGRhrRy
 92z5TeNkkxg0GZ2J63eCRhm98I5iqBGZ8XgSHxHz3XgPl00mUIRPl4KgZS8B20u2mcRM
 G8f9/VoJSRjnlS9n1/1GJ6ahJ1NQa7KieAhU246uF9Ux/1IKhrP2M/DAP51BYGus7MKv
 rDZslcggIc0CiVFdqM1V1del6gfZdXmcLks3BGBK6fDlZ2gy146Hl1CZwTyiwWinR32M 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6r59b46d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:18:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JMIMUb012325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 22:18:22 GMT
Received: from [10.46.163.175] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 14:18:21 -0800
Message-ID: <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
Date:   Thu, 19 Jan 2023 14:18:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, <djakov@kernel.org>
CC:     <quic_mdtipton@quicinc.com>, <quic_okukatla@quicinc.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
From:   Vivek Aknurwar <quic_viveka@quicinc.com>
In-Reply-To: <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EZTNWv0qyfHa0plkKzRRco13XcNlfvMr
X-Proofpoint-GUID: EZTNWv0qyfHa0plkKzRRco13XcNlfvMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_14,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190188
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,
Thanks for taking time to review the patch.

On 1/13/2023 5:40 PM, Bryan O'Donoghue wrote:
> On 14/01/2023 01:24, Bryan O'Donoghue wrote:
>> On 13/01/2023 22:07, Vivek Aknurwar wrote:
>>> Currently framework sets bw even when init bw requirements are zero 
>>> during
>>> provider registration, thus resulting bulk of set bw to hw.
>>> Avoid this behaviour by skipping provider set bw calls if init bw is 
>>> zero.
>>>
>>> Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
>>> ---
>>>   drivers/interconnect/core.c | 17 ++++++++++-------
>>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>> index 25debde..43ed595 100644
>>> --- a/drivers/interconnect/core.c
>>> +++ b/drivers/interconnect/core.c
>>> @@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, struct 
>>> icc_provider *provider)
>>>       node->avg_bw = node->init_avg;
>>>       node->peak_bw = node->init_peak;
>>> -    if (provider->pre_aggregate)
>>> -        provider->pre_aggregate(node);
>>> -
>>> -    if (provider->aggregate)
>>> -        provider->aggregate(node, 0, node->init_avg, node->init_peak,
>>> -                    &node->avg_bw, &node->peak_bw);
>>> +    if (node->avg_bw || node->peak_bw) {
>>> +        if (provider->pre_aggregate)
>>> +            provider->pre_aggregate(node);
>>> +
>>> +        if (provider->aggregate)
>>> +            provider->aggregate(node, 0, node->init_avg, 
>>> node->init_peak,
>>> +                        &node->avg_bw, &node->peak_bw);
>>> +        if (provider->set)
>>> +            provider->set(node, node);
>>> +    }
>>> -    provider->set(node, node);
>>>       node->avg_bw = 0;
>>>       node->peak_bw = 0;
>>
>> I have the same comment/question for this patch that I had for the 
>> qcom arch specific version of it. This patch seems to be doing at a 
>> higher level what the patch below was doing at a lower level.
>>
>> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m0c90588d0d1e2ab88c39be8f5f3a8f0b61396349
>>
>> what happens to earlier silicon - qcom silicon which previously made 
>> explicit zero requests ?

This patch is to optimize and avoid all those bw 0 requests on each node 
addition during probe (which results in rpmh remote calls) for upcoming 
targets.

>>
>> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m589e8280de470e038249bb362634221771d845dd
>>
>> https://lkml.org/lkml/2023/1/3/1232
>>
>> Isn't it a better idea to let lower layer drivers differentiate what 
>> they do ?

AFAIU lower layer driver can/should not differentiate between normal 
flow calls vs made as a result from probe/initialization of driver. 
Hence even bw 0 request is honored as like client in general wish to 
vote 0 as in an normal use case.

>>
>> For example on pre 5.4 qcom kernel silicon we might choose to set the 
>> value to zero "because that's what the reference code did" but on 
>> newer silicon we might opt to skip the zero configuration ?
>>
>> I'm happy to be shown the error of my ways but, absent testing to 
>> *show* it doesn't impact existing legacy silicon, I think we should be 
>> wary of this change.
>>
>> ---
>> bod
> 
> Oh, and what is the effect on Samsung and i.MX silicon interconnect 
> providers of skipping the zero set ?

If interconnect providers are trying to clear bw votes coming from 
boot-loader then best place to clear those is in sync-state call back.

> 
> ---
> bod
