Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B017692A87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBJWuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjBJWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:49:56 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDE632CFA;
        Fri, 10 Feb 2023 14:49:52 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AKPovC017965;
        Fri, 10 Feb 2023 22:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h/mAMXh5kCQ0g0Z52GBqF6hgV9P8cj6Rm/BSDQE6EcI=;
 b=iVT51v3MpI7xwvFkLZ7xjf/UAguX6WRR1W6VobLi8lW4kI5d6s/TIi31B32T9CYH/c1+
 hzrolbNQQxBfnOJg2QzsZzuOSMsWeRNwG6GLGatW3BC4mqO638k+nTQXvo/HIU+sYYLI
 RB7Fj7lUGiw9lrCd2MHSHErQsu+gUU6EG4vApH04Ecklk/r9hSJJ+vaXMvexr0uzObSn
 G2raS7muJ3+BOsroTZKWyn5IprOSfrNX1o45ZtYkv4ff7EUpA6UbPPCaHjELFyFPMmoy
 vZ9TlJJFG447zpyJzfpsELgFyjgQhOQhp/fPULPKzELM6PvUHfB2J0S5qsS7tGtNa3Cb BQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nndu5ac2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:49:37 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31AMna0V032756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 22:49:36 GMT
Received: from [10.110.21.35] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 14:49:35 -0800
Message-ID: <2c062ab0-905c-f1fe-eca2-02e23cc9fa6f@quicinc.com>
Date:   Fri, 10 Feb 2023 14:49:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH v2 12/22] sound: usb: card: Introduce USB SND platform
 op callbacks
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <agross@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-13-quic_wcheng@quicinc.com>
 <Y9Ui82OaI54Qx8Ft@kroah.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y9Ui82OaI54Qx8Ft@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oGpCI2pZrg6hVncDv50aU6L1diE3-Q0s
X-Proofpoint-GUID: oGpCI2pZrg6hVncDv50aU6L1diE3-Q0s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 mlxlogscore=993 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100195
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/28/2023 5:28 AM, Greg KH wrote:
> On Wed, Jan 25, 2023 at 07:14:14PM -0800, Wesley Cheng wrote:
>> Allow for different platforms to be notified on USB SND connect/disconnect
>> seqeunces.  This allows for platform USB SND modules to properly initialize
>> and populate internal structures with references to the USB SND chip
>> device.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   sound/usb/card.c | 28 ++++++++++++++++++++++++++++
>>   sound/usb/card.h | 20 ++++++++++++++++++++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/sound/usb/card.c b/sound/usb/card.c
>> index 26268ffb8274..803230343c16 100644
>> --- a/sound/usb/card.c
>> +++ b/sound/usb/card.c
>> @@ -117,6 +117,24 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
>>   static DEFINE_MUTEX(register_mutex);
>>   static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
>>   static struct usb_driver usb_audio_driver;
>> +static struct snd_usb_platform_ops *platform_ops;
> 
> You can not have a single "platform_ops" pointer, this HAS to be
> per-bus.
> 

Agreed.

> And what is a "platform operations" anyway?  Shouldn't this be a driver
> type or something like that?  "offload_operations"?
> 

The reason for going with platform operations is because every platform 
may implement the offloading differently.  The offload operations term 
is more direct though in terms of explaining what the ops are going to 
be used for, so I can see the incentive of moving to that phrase.

>> +
>> +int snd_usb_register_platform_ops(struct snd_usb_platform_ops *ops)
>> +{
>> +	if (platform_ops)
>> +		return -EEXIST;
>> +
>> +	platform_ops = ops;
>> +	return 0;
> 
> No locking?  not good.
> 
> But again, this has to be per-USB-bus, it can NOT be system wide for
> obvious reasons.
> 

Sure, will change that when moving to per USB bus.

Thanks
Wesley Cheng
