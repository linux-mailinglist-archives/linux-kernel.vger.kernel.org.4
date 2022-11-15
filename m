Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C962932A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiKOISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKOISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:18:46 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36263D9B;
        Tue, 15 Nov 2022 00:18:45 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AF5sBTo028476;
        Tue, 15 Nov 2022 08:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6rW4wCvpSBlG5C0IYxHX4R0N6/wMFIdsEgnlxS/vj2Y=;
 b=Na8d11Cmqo5V/9QxyWm8JoJtT5jOTiIhI1BaP1YA2nfZMazwF7Nwbi2h9S+M6DZJz8BS
 aRWB5Lj8r52lkQmqWeptq7cJ7K7Ow50xYI5GwU5th+bWZ9+SlHEwRLjWxMQ1L/T25sko
 GF8WYiITLVCn7kZOlaz7kXHEcRossBZ7u2nuLo37ybeR4xXlzoqqV0mVLfVLTSflZiQV
 aG4uO4NV/7X2UEzLAmUR43WvvEg8/zYisAqJInaGxTCnd1acvoSFc7KJbP7GciZbyIGX
 uK2/NvzMv4T/iymAGUQ4en3VX10bx1i7HrgIOvWs+ZlAHME9MFXMZDCq7OboTJX2beZD BQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kv51dgh5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:18:41 +0000
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2AF8If6Q002808;
        Tue, 15 Nov 2022 08:18:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 3kt4jm2xjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:18:41 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AF8Iess002801;
        Tue, 15 Nov 2022 08:18:40 GMT
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 2AF8IeML002799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:18:40 +0000
Received: from [10.206.12.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 15 Nov
 2022 00:18:36 -0800
Message-ID: <1cad3684-cc4a-9c45-c52c-95ffc2cdb680@quicinc.com>
Date:   Tue, 15 Nov 2022 13:48:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RFC] gpiolib: ensure that fwnode is properly set
To:     Robert Marko <robimarko@gmail.com>,
        Brian Masney <bmasney@redhat.com>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <psodagud@quicinc.com>,
        <quic_ppareek@quicinc.com>, <ahalaney@redhat.com>,
        <echanude@redhat.com>, <nicolas.dechesne@linaro.org>
References: <20221114202943.2389489-1-bmasney@redhat.com>
 <b3860cbd-0967-0b8d-3d67-f2a09f1e0042@gmail.com>
Content-Language: en-US
From:   Shazad Hussain <quic_shazhuss@quicinc.com>
In-Reply-To: <b3860cbd-0967-0b8d-3d67-f2a09f1e0042@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VvKUEOtYHWG17QWwGNvI4rLmbWCcBvb_
X-Proofpoint-ORIG-GUID: VvKUEOtYHWG17QWwGNvI4rLmbWCcBvb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_04,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=838 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211150060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/2022 2:32 AM, Robert Marko wrote:
> 
> On 14. 11. 2022. 21:29, Brian Masney wrote:
>> Note that this is a RFC patch and not meant to be merged. I looked into
>> a problem with linux-next-20221110 on the Qualcomm SA8540P automotive
>> board (sc8280xp) where the UFS host controller would fail to probe due
>> to repeated probe deferrals when trying to get reset-gpios via
>> devm_gpiod_get_optional().
>>
>> of_get_named_gpiod_flags() returns -EPROBE_DEFER, which is caused by
>> of_gpiochip_match_node_and_xlate() returning 0 since the of_xlate 
>> function
>> pointer is not set for the qcom,sc8280xp-tlmm pinctrl driver. The
>> pinctrl driver doesn't define one, so of_gpiochip_add() should
>> automatically setup of_gpio_simple_xlate() on it's behalf. This doesn't
>> happen since the fwnode member on the struct gpiochip is set to null
>> when of_gpiochip_add() is called. Let's work around this by ensuring
>> that it's set if available.
>>
>> Note that this broke sometime within the last few weeks within
>> linux-next and I haven't bisected this. I'm posting this in the hopes
>> that someone may know offhand which patch(es) may have broken this.
> 
> Hi, the following patch should fix it for you, I have hit the same issue on
> IPQ8074.
> 
> https://patchwork.ozlabs.org/project/linux-gpio/patch/20221111113732.461881-1-thierry.reding@gmail.com/
>
This fixes the issue I was facing for sa8540p (sc8280xp). Thanks Robert.

Shazad

> Regards,
> Robert
> 
>>
>> Signed-off-by: Brian Masney <bmasney@redhat.com>
>> ---
>>   drivers/gpio/gpiolib.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 11fb7ec883e9..8bec66008869 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -678,7 +678,7 @@ int gpiochip_add_data_with_key(struct gpio_chip 
>> *gc, void *data,
>>        * Assign fwnode depending on the result of the previous calls,
>>        * if none of them succeed, assign it to the parent's one.
>>        */
>> -    gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>> +    gc->fwnode = gdev->dev.fwnode = dev_fwnode(&gdev->dev) ?: fwnode;
>>       gdev->id = ida_alloc(&gpio_ida, GFP_KERNEL);
>>       if (gdev->id < 0) {
