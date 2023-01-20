Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB36747E0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 01:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjATAOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 19:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjATAOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 19:14:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E4A296D;
        Thu, 19 Jan 2023 16:14:00 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JNXlZn026397;
        Fri, 20 Jan 2023 00:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GMbhES6LxIObCeJt1QyYwzV3RDgMMaQuc16tcznbwO0=;
 b=iJqxP/Lm+YXSnq0QKlSKaqyi5TQuJuvzf5ljxR4Kp2Jhe7GHgQ8wcQAI/3uSzHVxHpol
 DglkPnECs27nBxPyfPIi3av+jwwd88EtBc/JbpGrXYTMIspFBw8CrSQ3aMAEIYJ5pDuU
 oSqy0drMY4PX6OwN3FIITERogCldx5FPIat8+Pru1Drbumkbxd1IsSwId1pZiauez9jK
 jURcBu1jX5nMynvfebT8ttWBSuruXugzQMo0V5o3uNgyuqeUFNkvVDrwthdFMsELBhXY
 JlzyWuXIH/d5G6yMy81FgUKOIkMgrDAOxa6nWup10O6FU7ykXO9ovWejAwPSiqiPqvAt MQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n70eyje8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 00:13:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K0DuYK011975
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 00:13:56 GMT
Received: from [10.110.55.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 16:13:55 -0800
Message-ID: <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
Date:   Thu, 19 Jan 2023 16:13:54 -0800
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
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1lBQE6YS7GRMsyQaZ0G5YZ_jtBxeQHfX
X-Proofpoint-GUID: 1lBQE6YS7GRMsyQaZ0G5YZ_jtBxeQHfX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0 mlxlogscore=930
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200000
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 5:44 PM, Thinh Nguyen wrote:
> On Tue, Jan 17, 2023, Elson Roy Serrao wrote:
>> Add a flag to indicate whether the gadget is capable
>> of sending remote wakeup to the host.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/gadget/composite.c | 3 +++
>>   include/linux/usb/gadget.h     | 2 ++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>> index 403563c..b83963a 100644
>> --- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -965,6 +965,9 @@ static int set_config(struct usb_composite_dev *cdev,
>>   	else
>>   		usb_gadget_clear_selfpowered(gadget);
>>   
>> +	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
>> +		gadget->rw_capable = 1;
> 
> Some device may not support remote wakeup. gadget->rw_capable should be
> set and reported by the UDC. May need a gadget ops to enable remote
> wakeup here.
> 
> Thanks,
> Thinh
> 
Not exactly clear on which parameter in UDC decides whether a device 
supports remote wakeup. Here I have this flag just to indicate whether 
the connected device is rw capable based on the bmAttributes populated 
in the config descriptor. If the UDC doesnt have a callback for remote 
wakeup we have that check when calling the gadget op in udc/core.c (have 
added a similar check in usb_func_wakeup() also ).

int usb_gadget_wakeup(struct usb_gadget *gadget)
{
	int ret = 0;

	if (!gadget->ops->wakeup) {
		ret = -EOPNOTSUPP;
		goto out;

Thanks
Elson

>> +
>>   	usb_gadget_vbus_draw(gadget, power);
>>   	if (result >= 0 && cdev->delayed_status)
>>   		result = USB_GADGET_DELAYED_STATUS;
>> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
>> index dc3092c..15785f8 100644
>> --- a/include/linux/usb/gadget.h
>> +++ b/include/linux/usb/gadget.h
>> @@ -385,6 +385,7 @@ struct usb_gadget_ops {
>>    *	indicates that it supports LPM as per the LPM ECN & errata.
>>    * @irq: the interrupt number for device controller.
>>    * @id_number: a unique ID number for ensuring that gadget names are distinct
>> + * @rw_capable: True if the gadget is capable of sending remote wakeup.
>>    *
>>    * Gadgets have a mostly-portable "gadget driver" implementing device
>>    * functions, handling all usb configurations and interfaces.  Gadget
>> @@ -446,6 +447,7 @@ struct usb_gadget {
>>   	unsigned			lpm_capable:1;
>>   	int				irq;
>>   	int				id_number;
>> +	unsigned			rw_capable:1;
>>   };
>>   #define work_to_gadget(w)	(container_of((w), struct usb_gadget, work))
>>   
>> -- 
>> 2.7.4
