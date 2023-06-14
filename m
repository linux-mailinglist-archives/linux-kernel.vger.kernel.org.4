Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFE772FDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbjFNL5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbjFNL5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:57:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCE1FE2;
        Wed, 14 Jun 2023 04:57:15 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35E6lrII020496;
        Wed, 14 Jun 2023 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RIctGf2uVKmH+mk7tmv/joN+PNDZnSxno7h5XY/VMJY=;
 b=EUVHIKt3JvOhsrZyGWS/jFKstoqevesBBzezI6umetdxzrEZKSwEm5xNkU6GUKiOQnHr
 CgAGJt1bwO1iWQySJNgUZZXMRoia0r3U20XzYhJQ7Ja2T67VbVqk7k8iZlI2AyE5n4HN
 ueXientQszMrR1cPOOAtYHqkZApYbd1WxPLFT1Pkwwd6rLZPdiuGXSIr1KF5Jzdi1eUL
 Gm7epMICJ2B6/L+/Kf7xa0lnZcLcrisnMLOakgBTi0Vz2TWefe/GnqEi3E0DBcAe7khV
 VPKgbxgYZKTsVQrC0XkNADJaUJAXQkL2v7vyFTjtBEcNumL6GGAo2DMCL6mr0w9lN/Kn 6Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r78c78sdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:57:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35EBvA8C027581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jun 2023 11:57:10 GMT
Received: from [10.218.5.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 14 Jun
 2023 04:57:04 -0700
Message-ID: <c451394a-7e45-45a0-a5e8-8ed547d1b391@quicinc.com>
Date:   Wed, 14 Jun 2023 17:27:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 4/5] clk: qcom: camcc-sm8550: Add support for qdss,
 sleep and xo clocks
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230601143430.5595-1-quic_jkona@quicinc.com>
 <20230601143430.5595-5-quic_jkona@quicinc.com>
 <ee48f7fd-35f1-288f-2133-1c473e8804ab@linaro.org>
 <a818de04-ca30-f4fb-4c69-fd172b96f816@quicinc.com>
 <e075f78a-5eac-8200-853b-db73c3d5025c@linaro.org>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <e075f78a-5eac-8200-853b-db73c3d5025c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zahz6K_lmiogciQaXIVJA9jmZA-a6V5p
X-Proofpoint-ORIG-GUID: Zahz6K_lmiogciQaXIVJA9jmZA-a6V5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_07,2023-06-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 mlxlogscore=899 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306140102
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2023 6:15 PM, Konrad Dybcio wrote:
> 
> 
> On 9.06.2023 13:50, Jagadeesh Kona wrote:
>> Hi Dmitry,
>>
>> Thanks for your review!
> I've noticed that many QUIC contributors seem to add this to the beginning
> of their emails.. Top-posting is generally discouraged on LKML
> 
> You can find gregkh's reasoning for this e.g. here:
> 
> https://lkml.org/lkml/2021/4/21/143
> 
> Konrad

Sure, will take care.

Thanks,
Jagadeesh

>>
>> On 6/1/2023 8:23 PM, Dmitry Baryshkov wrote:
>>> On 01/06/2023 17:34, Jagadeesh Kona wrote:
>>>> Add support for camera qdss, sleep and xo clocks.
>>>>
>>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>> You probably missed the Co-developed-by tag.
>>>
>>
>> Yes, will add in the next series.
>>
>>>> ---
>>>> Changes since V2:
>>>>    - No changes.
>>>> Changes since V1:
>>>>    - Newly added.
>>>>
>>>>    drivers/clk/qcom/camcc-sm8550.c | 180 ++++++++++++++++++++++++++++++++
>>>>    1 file changed, 180 insertions(+)
>>>
>>>
>>
>> Thanks & Regards,
>> Jagadeesh
