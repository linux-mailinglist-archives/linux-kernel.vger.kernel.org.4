Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68806C4F81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjCVPdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCVPdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:33:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C49724BE9;
        Wed, 22 Mar 2023 08:33:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32M432Tc001262;
        Wed, 22 Mar 2023 15:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CUJZ/1iR8VpxyyECZ+5BYcjYmXeFQHP2bZW1KyKLvBc=;
 b=o9lsISSiTA8FRgHRe7z1U0edqQJtReDHCL8HOHBBPhLWOiWMF3N44tdHtC9qOhR7tvat
 spCjltTqp6oLX6l60CZ7IhWp2wSZZUjZLvBq1W+khlWYU6xyeRw26OObShroT47ZYAqV
 TnhXF1Ax1RbbyRtDllYFrHtDx7R63n1JVH78vhYIsEm8Cb4TC4rGmXUVvY3aczFHHdNj
 hE1ixGHR+Sj+lFOyTUq3OPKMJXgnmPxebvoPuoD/39eb4PN7HOpi+yebkrWjY+n5nS9g
 l+KH3LRoiaHGko0rAFR9MEv1+94hrO0JFtGtxo4PeZR6k3S2gTZn+0B4g3oIF1Eodu4c PQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pfbx03x5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:33:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32MFXQHD032461
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 15:33:26 GMT
Received: from [10.216.37.180] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 22 Mar
 2023 08:33:21 -0700
Message-ID: <33e7f57d-b3f3-b4cb-b466-49c0eeb28191@quicinc.com>
Date:   Wed, 22 Mar 2023 21:03:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC 2/2] usb: gadget: udc: Handle gadget_connect failure during
 bind operation
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Sebastian Reichel <sre@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>
References: <20230322092740.28491-1-quic_kriskura@quicinc.com>
 <20230322092740.28491-3-quic_kriskura@quicinc.com>
 <a5b57150-81e1-4eba-89e5-005cc78e243a@rowland.harvard.edu>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <a5b57150-81e1-4eba-89e5-005cc78e243a@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K6JmAdugmFhGjepNPiF2p203jxVEdaxQ
X-Proofpoint-ORIG-GUID: K6JmAdugmFhGjepNPiF2p203jxVEdaxQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_12,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220111
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/2023 8:11 PM, Alan Stern wrote:
> On Wed, Mar 22, 2023 at 02:57:40PM +0530, Krishna Kurapati wrote:
>> In the event, gadget_connect call (which invokes pullup) fails,
>> propagate the error to udc bind operation which inturn sends the
>> error to configfs. The userspace can then retry enumeartion if
>> it chooses to.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/gadget/udc/core.c | 17 +++++++++++++----
>>   1 file changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
>> index 23b0629a8774..26bfed5c3a45 100644
>> --- a/drivers/usb/gadget/udc/core.c
>> +++ b/drivers/usb/gadget/udc/core.c
>> @@ -1051,12 +1051,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>>   
>>   /* ------------------------------------------------------------------------- */
>>   
>> -static void usb_udc_connect_control(struct usb_udc *udc)
>> +static int usb_udc_connect_control(struct usb_udc *udc)
>>   {
>> +	int ret;
>> +
>>   	if (udc->vbus)
>> -		usb_gadget_connect(udc->gadget);
>> +		ret = usb_gadget_connect(udc->gadget);
>>   	else
>> -		usb_gadget_disconnect(udc->gadget);
>> +		ret = usb_gadget_disconnect(udc->gadget);
>> +
>> +	return ret;
>>   }
>>   
>>   /**
>> @@ -1500,11 +1504,16 @@ static int gadget_bind_driver(struct device *dev)
>>   	if (ret)
>>   		goto err_start;
>>   	usb_gadget_enable_async_callbacks(udc);
>> -	usb_udc_connect_control(udc);
>> +	ret = usb_udc_connect_control(udc);
>> +	if (ret)
>> +		goto err_connect_control;
>>   
>>   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>>   	return 0;
>>   
>> + err_connect_control:
> 
> At this point you need to copy the code in gadget_unbind_driver().  In
> particular, this should have:
> 
> +	usb_gadget_disable_async_callbacks(udc);
> +	if (gadget->irq)
> +		synchronize_irq(gadget->irq);
> 
> Alan Stern
> 
>> +	usb_gadget_udc_stop(udc);
>> +
>>    err_start:
>>   	driver->unbind(udc->gadget);
>>   
>> -- 
>> 2.40.0
>>
Hi Alan,

  Thanks for the review. Will make sure to add it in the formal patch.

Regards,
Krishna,
