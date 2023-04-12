Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD16DF865
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjDLOZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDLOZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:25:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA34C49D1;
        Wed, 12 Apr 2023 07:25:37 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CEPSq5031743;
        Wed, 12 Apr 2023 14:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=xYK7teVJtDzOVlvoPUiSQHsZaeZ0vlZY8VyjJoAnkBc=;
 b=YQd7R4u+YgMbRtDzS7QcsGCu9biQ6iNJeqYGq/BRQrNbC9pZQRz9wU8beHD0nbgMwucZ
 rzlds/GacfvDlDDlAx2YPaRdBABF2sA9ngsHSIMnkR9lprcE8HU4oPMzmO+1NVqdYF53
 L3G/HZDx8bAPgfM4RLajchSQrsEt70auz7k12tehy0RRdZ9UhZiMuljciascRfEVxIht
 vcKIkt2zHa9b+aJ4cAdqfK2uly2lsAv0mDj6N8CjCM+7Bd9YuSDo/Xs9Uqg9Z81xN8p/
 rR1ysTtVErlcJuwFJ0AkFW7ICeiJLxz4KagyeAZ/Kpj8eAakjT0CbSTuAN6d3ooTeMqE 1g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwqnq10k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:25:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CEPQYg015928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 14:25:26 GMT
Received: from [10.50.1.100] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 07:25:22 -0700
Message-ID: <6000d205-5c1d-f342-7d2e-1399ac1cb825@quicinc.com>
Date:   Wed, 12 Apr 2023 19:55:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
 <d05e1184-ead4-3f80-4c06-ff757a10ba3b@linaro.org>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <d05e1184-ead4-3f80-4c06-ff757a10ba3b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GsePT6Qxm8VTaqpA0ocWZmBlX7484fKs
X-Proofpoint-GUID: GsePT6Qxm8VTaqpA0ocWZmBlX7484fKs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_06,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=894
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120126
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 1:51 PM, Krzysztof Kozlowski wrote:
> On 07/04/2023 16:04, Souradeep Chowdhury wrote:
>> All of Qualcomm's proprietary Android boot-loaders capture boot time
>> stats, like the time when the bootloader started execution and at what
>> point the bootloader handed over control to the kernel etc. in the IMEM
>> region. This information is captured in a specific format by this driver
>> by mapping a structure to the IMEM memory region and then accessing the
>> members of the structure to print the information. This information is
>> useful in verifying if the existing boot KPIs have regressed or not.
>> A sample log in SM8450(waipio) device is as follows:-
>>
> 
> 
>> +
>> +static int boot_stats_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np_mpm2;
>> +	struct device *boot_stat = &pdev->dev;
>> +
>> +	boot_stats = of_iomap(boot_stat->of_node->child, 0);
>> +	if (!boot_stats)
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +					"failed to map imem region\n");
>> +
>> +	np_mpm2 = of_find_compatible_node(NULL, NULL,
>> +					  "qcom,mpm2-sleep-counter");
> 
> This is undocumented and non-existing compatible. No, we cannot take this.
> 
> Also, referencing other nodes should be with phandles, not compatibles.

Ack. This will be dropped in the next version as we are not printing the
current kernel timestamp.

> 
> 
> Best regards,
> Krzysztof
> 
