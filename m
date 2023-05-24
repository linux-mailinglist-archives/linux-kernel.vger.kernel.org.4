Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9670F8BB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbjEXO1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEXO1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:27:49 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88B11D;
        Wed, 24 May 2023 07:27:47 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OAxHfj012125;
        Wed, 24 May 2023 14:27:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2T2sktktkW44kPXRJS6VTyFM0EcE2KDWn+A8955T2/k=;
 b=KnyVnaY1jyg7pDClKfn9Bpx0M+og6hLvXVZhybz7PQQ/FbXaO8nCbgLD9TbNocuMDjKq
 oWTEwmDKMuNI+Qs75yhy5v5px4m5gYOp3LAk4rhQsK1NmhznjvVUFURDXH2tg9ug8yuc
 54ExcC3sICfFXS9MT/US21+JFBJA4BVizDJlIMn4ef+DSbuFi7isKUMSeU4n0pwTSi1b
 Am/KPMU9njsA0QdHAdM9JHDucKpCxYhtJvPT5giYBMX6cHwoIYeFwX4OZWiMf2pJye1B
 I590/ils36k1qKDN02ix8NGqJyvVcZOCjCNjDwGUiSvb4OlKUi9D8NhkM2xGTG3JUWm5 Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs9wesdyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:27:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34OERgH4011769
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 14:27:42 GMT
Received: from [10.217.216.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 07:27:38 -0700
Message-ID: <b7590456-1cd6-8413-e1c6-561d27e804de@quicinc.com>
Date:   Wed, 24 May 2023 19:57:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/4] clk: qcom: clk-alpha-pll: Add support for lucid ole
 pll ops
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230509161218.11979-1-quic_jkona@quicinc.com>
 <20230509161218.11979-2-quic_jkona@quicinc.com>
 <019999fd-3c86-8c85-76c7-8d0206e60f4d@linaro.org>
 <55fc32df-f01b-1ba3-3813-26a5f8c7f730@quicinc.com>
 <4a9248c0-96ec-1986-d874-1cb7d8aac0ac@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <4a9248c0-96ec-1986-d874-1cb7d8aac0ac@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7gzKJotjpo0t6tn6swDPpGE6zGFkpjlm
X-Proofpoint-GUID: 7gzKJotjpo0t6tn6swDPpGE6zGFkpjlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=410 impostorscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

Thanks for your review!

On 5/19/2023 6:39 PM, Konrad Dybcio wrote:
> 
> 
> On 19.05.2023 14:49, Jagadeesh Kona wrote:
>> Hi,
>>
>> Thanks Konrad for your review!
>>
>> On 5/10/2023 1:36 AM, Konrad Dybcio wrote:
>>>
>>>
>>> On 9.05.2023 18:12, Jagadeesh Kona wrote:
>>>> From: Taniya Das <quic_tdas@quicinc.com>
>>>>
>>>> Add support for lucid ole pll ops to configure and control the
>>>> lucid ole pll. The lucid ole pll has an additional test control
>>>> register which is required to be programmed, add support to
>>>> program the same.
>>>>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>> ---
>>> Isn't this commit "write to PLL_TEST_CTL_U2 on LUCID_EVO" instead?
>>>
>>> Meaninglessly duplicating ops does not seem useful.
>>>
>>> Konrad
>>
>> Though we are reusing same ops for EVO and OLE, PLL_TEST_CTL_U2 register programming is applicable only to OLE PLL type.
> Well, your patch makes it unconditional (modulo programmer error) so
> I think that makes little sense.. A comment would be enough, imo.
> 
> Konrad
Yes, will remove the duplicate definitions and will reuse the existing ops.

> And PLL type is useful to properly refer respective hardware datasheets. Hence added separate ops for OLE PLL type.
>>

Thanks & Regards,
Jagadeesh
