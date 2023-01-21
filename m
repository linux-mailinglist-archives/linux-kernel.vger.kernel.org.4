Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCA6761E1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjAUAGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAUAGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:06:44 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDB772C2D;
        Fri, 20 Jan 2023 16:06:43 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30KNx32w023904;
        Sat, 21 Jan 2023 00:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=URJJNvMzIFG5OS0ainlfqJaPOphmY2mAIG3YZvWWKXI=;
 b=c1jvNBtbSJa5Hg1v+arYQqFXD5zUBq8mEZvlGZJFY8sFtOt3n4LJENLdVTk6oNaR7lAa
 076ej9x6jyi5r/zpbyDH4S7urYijScWdYcb6lJvMRqoPv94ltcixULcd53wCbP/turDS
 koVhh975dyigRVV3gU5qplzw5CBi64YSHWdcpZr3iIshm/rhor8XUotPUKBcbasfyDQD
 l7RvnGd3VRMNcK2SHJq5pfmlhYv2RTwAqBmDhaUFzA4ogSRihR3yaoiSbeUrXlqlhN8L
 XqOeVRpoJFlD9oPO5XcSyfFBphdOpOuXUKVL+MwFXioCtWjrQFs4Im0SwJsiaj95mY+V Rw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n7c28jut7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 00:06:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30L06bgB002229
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Jan 2023 00:06:37 GMT
Received: from [10.110.55.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 20 Jan
 2023 16:06:36 -0800
Message-ID: <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
Date:   Fri, 20 Jan 2023 16:06:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230120011513.ajwum224lfwwb6ws@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aWoYGC2SQq8OlrfFFU6saxsHB1Apbv4K
X-Proofpoint-ORIG-GUID: aWoYGC2SQq8OlrfFFU6saxsHB1Apbv4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-20_12,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200232
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 5:15 PM, Thinh Nguyen wrote:
> On Thu, Jan 19, 2023, Elson Serrao wrote:
>>
>>
>> On 1/18/2023 5:44 PM, Thinh Nguyen wrote:
>>> On Tue, Jan 17, 2023, Elson Roy Serrao wrote:
>>>> Add a flag to indicate whether the gadget is capable
>>>> of sending remote wakeup to the host.
>>>>
>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>> ---
>>>>    drivers/usb/gadget/composite.c | 3 +++
>>>>    include/linux/usb/gadget.h     | 2 ++
>>>>    2 files changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>>>> index 403563c..b83963a 100644
>>>> --- a/drivers/usb/gadget/composite.c
>>>> +++ b/drivers/usb/gadget/composite.c
>>>> @@ -965,6 +965,9 @@ static int set_config(struct usb_composite_dev *cdev,
>>>>    	else
>>>>    		usb_gadget_clear_selfpowered(gadget);
>>>> +	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
>>>> +		gadget->rw_capable = 1;
>>>
>>> Some device may not support remote wakeup. gadget->rw_capable should be
>>> set and reported by the UDC. May need a gadget ops to enable remote
>>> wakeup here.
>>>
>>> Thanks,
>>> Thinh
>>>
>> Not exactly clear on which parameter in UDC decides whether a device
>> supports remote wakeup. Here I have this flag just to indicate whether the
>> connected device is rw capable based on the bmAttributes populated in the
>> config descriptor. If the UDC doesnt have a callback for remote wakeup we
>> have that check when calling the gadget op in udc/core.c (have added a
>> similar check in usb_func_wakeup() also ).
> 
> That flag describes the gadget's capability, not the device
> configuration. However, it's being used as a configuration flag.
> 
> Thanks,
> Thinh
> 

Thank you for the clarification. Please let me know if below approach 
where we consider both gadget's capability and device configuration fine?

if (gadget->ops->wakeup || gadget->ops->func_wakeup)
    gadget->rw_capable = USB_CONFIG_ATT_WAKEUP & c->bmAttributes ? 1: 0;

Thanks
Elson
>>
>> int usb_gadget_wakeup(struct usb_gadget *gadget)
>> {
>> 	int ret = 0;
>>
>> 	if (!gadget->ops->wakeup) {
>> 		ret = -EOPNOTSUPP;
>> 		goto out;
>>
>> Thanks
>> Elson
>>
>>>> +
>>>>    	usb_gadget_vbus_draw(gadget, power);
>>>>    	if (result >= 0 && cdev->delayed_status)
>>>>    		result = USB_GADGET_DELAYED_STATUS;
>>>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>>>> index dc3092c..15785f8 100644
>>>> --- a/include/linux/usb/gadget.h
>>>> +++ b/include/linux/usb/gadget.h
>>>> @@ -385,6 +385,7 @@ struct usb_gadget_ops {
>>>>     *	indicates that it supports LPM as per the LPM ECN & errata.
>>>>     * @irq: the interrupt number for device controller.
>>>>     * @id_number: a unique ID number for ensuring that gadget names are distinct
>>>> + * @rw_capable: True if the gadget is capable of sending remote wakeup.
>>>>     *
