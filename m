Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5570F7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235050AbjEXNim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEXNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:38:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDCEA9;
        Wed, 24 May 2023 06:38:38 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OBuOX7027585;
        Wed, 24 May 2023 13:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=26Xe+0U7QMwhVh87IRNZwFBbY3ioRoGzRLacuVsKBEY=;
 b=Yrk9wlrusa/ztg87WUw0WNCR121ZvOGX+l6WFY+EoKG8llGOhncAqJlm/SJV7EIjSlrO
 wnbCO8jzR9FnDyFoM8XzsbPqt41xOjjTGs4kKrL1IXSYEnjcCU307oTshENgy85lacFe
 FYiVl3Gm579pspGOs/rRCSPTLjxRzJ7dk33yWgATFDJiOS08f+tk80oI67wLfxHxvmU9
 A71gi3UD9uf+OHaI+QvAdzicD4CAviA9KPnGQI+Zg20oNsrTUuGfVXjcd6OrDrWq9kTu
 +CO/XisZOd7m01B+/KFliy+kFQuCCA4n1TF5QLJaK92CqCkKAKkMEAhyqFpC1ZJ0jNlH Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qs6981kru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 13:38:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34ODcR9d019414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 13:38:27 GMT
Received: from [10.217.219.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 24 May
 2023 06:38:25 -0700
Message-ID: <df3ddd18-f893-23d3-f035-d2f3572f1258@quicinc.com>
Date:   Wed, 24 May 2023 19:06:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1684918441-14794-1-git-send-email-quic_prashk@quicinc.com>
 <ebbbee51-8792-6c35-c29b-adb7f83dda23@collabora.com>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <ebbbee51-8792-6c35-c29b-adb7f83dda23@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BuScpakT4Y0KHAtxZYB_u0Pqh9riFyh9
X-Proofpoint-GUID: BuScpakT4Y0KHAtxZYB_u0Pqh9riFyh9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_09,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=868
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240111
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-05-23 03:10 pm, AngeloGioacchino Del Regno wrote:
> Il 24/05/23 10:54, Prashanth K ha scritto:
>> Currently if we bootup a device without cable connected, then
>> usb-conn-gpio won't call set_role() since last_role is same as
>> current role. This happens because during probe last_role gets
>> initialised to zero.
>>
>> To avoid this, last_role is set to USB_ROLE_UNKNOWN before
>> performing the initial detection.
>>
>> Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection 
>> detection driver")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
>>   drivers/usb/common/usb-conn-gpio.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/common/usb-conn-gpio.c 
>> b/drivers/usb/common/usb-conn-gpio.c
>> index e20874c..00af735 100644
>> --- a/drivers/usb/common/usb-conn-gpio.c
>> +++ b/drivers/usb/common/usb-conn-gpio.c
>> @@ -27,6 +27,8 @@
>>   #define USB_CONN_IRQF    \
>>       (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT)
>> +#define USB_ROLE_UNKNOWN    -1
> 
> I would add USB_ROLE_UNKNOWN to `enum usb_role` instead.
> 
> enum usb_role {
>      USB_ROLE_UNKNOWN = -1,
>      USB_ROLE_NONE,
>      ....
> };
> 
> Regards,
> Angelo

Thanks for the suggestion Agnelo. Will change it in next patch.

Regards,
Prashanth K
