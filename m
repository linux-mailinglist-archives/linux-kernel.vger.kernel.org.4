Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBD681D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjA3VzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjA3VzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:55:22 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB87D37F2E;
        Mon, 30 Jan 2023 13:55:20 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UKjWOv024216;
        Mon, 30 Jan 2023 21:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gboaOLZbeOYcm0WHEM6U1xOOIRgeNG+thaSdtg1tNmo=;
 b=AymFxeKa8r7tGD+pKskYHN4ZJLfqQJoYVtAnXMpNiI83riPvZg6xYr9S3vaB6dH2gurG
 OscF8PeWzzgBw0YeR8N3qR9ikW075oXVh2NimXjquj+GX1cL58MLS8DeGlp3parAjPt8
 MD43hD0kpugL7vhvZeSa6P0euBNYg7Do2lzDY3zFj1mgC7peb9izl3Nf4zUGApH9+c0Q
 JC0M/CEeN53I0jQeAvFhYcXWjh59Ow5B5ftGK+vL0e7J05rQKyQdC1GZGdo8D+GsCUN1
 47U7Sf9ZTn9M7pspaq9Vef78lJV+G05ho2gmc1xSrKnGr4LGum5zpxR3zkukb+cWqc7/ 1A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncvfpcmre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:55:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30ULtBX4001051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 21:55:11 GMT
Received: from [10.111.174.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 13:55:09 -0800
Message-ID: <c2bba35e-ea83-0f82-992e-a8ddeb106276@quicinc.com>
Date:   Mon, 30 Jan 2023 13:55:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
To:     Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        <djakov@kernel.org>
CC:     Vivek Aknurwar <quic_viveka@quicinc.com>,
        <quic_okukatla@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "abel >> Philipp Zabel" <p.zabel@pengutronix.de>,
        <abelvesa@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
 <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
 <151790dd-02e5-a1f5-aab5-360f39e21c57@quicinc.com>
 <35dcb764-e340-5fe7-6637-cdb5f84266ce@linaro.org>
 <6dd7b0b0-f6fb-9de4-c365-d6cbfe04f2c0@quicinc.com>
 <742ff9cd-e7be-11b8-3805-5b60aba6b2f1@linaro.org>
 <Y9fZ6GUzWsCMXzba@linaro.org>
Content-Language: en-US
From:   Mike Tipton <quic_mdtipton@quicinc.com>
In-Reply-To: <Y9fZ6GUzWsCMXzba@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C1EauuXgQs6pDzk93uzDi1pYQwV5oFTu
X-Proofpoint-ORIG-GUID: C1EauuXgQs6pDzk93uzDi1pYQwV5oFTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_17,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300202
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/2023 6:53 AM, Abel Vesa wrote:
> On 23-01-23 22:58:49, Bryan O'Donoghue wrote:
>> On 23/01/2023 20:37, Mike Tipton wrote:
>>>
>>> This isn't actually changing it for all providers. Only for those that
>>> define the get_bw() callback. Right now that's only qcom/msm8974 and
>>> imx/imx. If get_bw() isn't defined, then icc_node_add() defaults to
>>> INT_MAX. So, the logical behavior in that case is unchanged. Which means
>>> this isn't even changing the behavior for rpmh yet, either.
>>
>> Yes that adds up.
>>
>> Looking at the commit for get_bw() for the 8974, I think this change would
>> be OK with the intent of this commit
>>
>> commit 9caf2d956cfa254c6d89c5f4d7b3f8235d75b28f
>> Author: Georgi Djakov <georgi.djakov@linaro.org>
>> Date:   Mon Nov 9 14:45:12 2020 +0200
>>
>> @Abel what effect will skipping pre->aggregation() have on i.MX ?
> 
> I don't think there is any impact on i.MX platforms.
> 
> Peng, any input?

It should only have an impact if there are nodes left enabled from 
bootloaders that nobody votes for and need to be turned off.

The imx get_bw() callback returns zero for everything. So, the previous 
icc_node_add() behavior would call set() with zero for everything and 
give the provider an opportunity to disable all nodes by default. After 
this change, set() won't be called from icc_node_add() anymore. And 
because init_bw is zero, set() won't be called in icc_sync_state() 
either. So, it's possible for certain nodes to be left enabled whereas 
previously they were disabled during imx probe.

If this change does result in nodes being left enabled, then the ideal 
fix would be for get_bw() to return non-zero for nodes enabled from 
boot. That would result in them being disabled in icc_sync_state().

Should be same possible impact for qcom/msm8974.

> 
>>
>> ---
>> bod
