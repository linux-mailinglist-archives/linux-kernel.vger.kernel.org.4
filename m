Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC769A2FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjBQAie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:38:32 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36B53829;
        Thu, 16 Feb 2023 16:38:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31GMxkRn011655;
        Fri, 17 Feb 2023 00:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NaL9qG3jXmJG4YoAfvCGajPOUkkBmmVr4SXb+5Hb8hM=;
 b=BwjA9TFS/0iPBoD8jAjXb5BOrELv270Sb+uIeBl1caRqAAvgQVFi30YihQQy1skvXZCY
 8EuA59hEFqAkoRieWEss+p8ykat5lTjvWoPiTD/xjwDUd8UwnBGp5Ii9iv0LH1ObgZEu
 LgglRF7jfCVl01p/Dau858jVHrfP8uctyhKqKgx+YY3rWAjS1qrT0Yb0FxqmIeHl93H3
 UPdtidSWjxs4zeHjlYedy0HMI8AzWzDxjxbpoS5xqMOYQ9WhC3aM9AJQl7DaGmebERgV
 sTpoLmN7Q/lRnthXx3Jz8jn3BhRKPz5kB14AGcl3tMml2paDc8NizdKdr7fPYlotVHUl fw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrwcs56mn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 00:38:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31H0cQrh008784
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 00:38:26 GMT
Received: from [10.110.33.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 16:38:25 -0800
Message-ID: <96bbacbc-35d5-b8a4-938b-53259dcc03a7@quicinc.com>
Date:   Thu, 16 Feb 2023 16:38:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 3/5] usb: gadget: Add function wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1676586588-25989-1-git-send-email-quic_eserrao@quicinc.com>
 <1676586588-25989-4-git-send-email-quic_eserrao@quicinc.com>
 <20230216235759.ylqsrsyp3tpppmef@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230216235759.ylqsrsyp3tpppmef@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TCc1FVqcEdspprDLrbXNj4zaQGF-m6za
X-Proofpoint-ORIG-GUID: TCc1FVqcEdspprDLrbXNj4zaQGF-m6za
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_18,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=635 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170002
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 3:58 PM, Thinh Nguyen wrote:
> On Thu, Feb 16, 2023, Elson Roy Serrao wrote:
>> A function which is in function suspend state has to send a
>> function wake notification to the host in case it needs to
>> exit from this state and resume data transfer. Add support to
>> handle such requests by exposing a new gadget op.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 24 ++++++++++++++++++++++++
>>   drivers/usb/gadget/udc/core.c  | 21 +++++++++++++++++++++
>>   include/linux/usb/composite.h  |  6 ++++++
>>   include/linux/usb/gadget.h     |  4 ++++
>>   4 files changed, 55 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index a37a8f4..f649f997 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -492,6 +492,30 @@ int usb_interface_id(struct usb_configuration *config,
>>   }
>>   EXPORT_SYMBOL_GPL(usb_interface_id);
>>   
>> +int usb_func_wakeup(struct usb_function *func)
>> +{
>> +	int ret, id;
>> +
>> +	if (!func->func_wakeup_armed) {
>> +		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (id = 0; id < MAX_CONFIG_INTERFACES; id++)
>> +		if (func->config->interface[id] == func)
>> +			break;
>> +
>> +	if (id == MAX_CONFIG_INTERFACES) {
>> +		ERROR(func->config->cdev, "Invalid function\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = usb_gadget_func_wakeup(func->config->cdev->gadget, id);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_func_wakeup);
>> +
>>   static u8 encode_bMaxPower(enum usb_device_speed speed,
>>   		struct usb_configuration *c)
>>   {
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 3dcbba7..59e7a7e 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -846,6 +846,27 @@ int usb_gadget_activate(struct usb_gadget *gadget)
>>   }
>>   EXPORT_SYMBOL_GPL(usb_gadget_activate);
>>   
>> +/**
>> + * usb_gadget_func_wakeup - sends function wake notification to the host.
>> + * @gadget: controller used to wake up the host
>> + * @interface_id: interface on which function wake notification is sent.
> 
> Device notification is only applicable for eSS devices. What will happen
> if the device is operating in lower speed and the driver calls this
> function?
> 
> Thanks,
> Thinh
> 

Since the non-eSS devices dont support function suspend, the function 
suspend feature selector is not sent by the host and the function is not 
armed for sending function remote wakeup. So the usb_func_wakeup() API 
that is called from the function drivers fails the attempt

int usb_func_wakeup(struct usb_function *func)
{
	int ret, id;

	if (!func->func_wakeup_armed) {
		ERROR(func->config->cdev, "not armed for func remote wakeup\n");
		return -EINVAL;
	}

Let me know if its better to add an explicit speed check as well here.

Thanks
Elson

>> + *
>> + * On completion, function wake notification is sent. If the device is in
>> + * low power state it tries to bring the device to active state before sending
>> + * the wake notification. Since it is a synchronous call, caller must take care
>> + * of not calling it in interrupt context.
>> + *
>> + * Returns zero on success, else negative errno.
>> + */
>> +int usb_gadget_func_wakeup(struct usb_gadget *gadget, int intf_id)
>> +{
>> +	if (!gadget->ops->func_wakeup)
>> +		return -EOPNOTSUPP;
>> +
>> +	return gadget->ops->func_wakeup(gadget, intf_id);
>> +}
>> +EXPORT_SYMBOL_GPL(usb_gadget_func_wakeup);
