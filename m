Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E223D735758
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFSMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjFSMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 08:51:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943A1BD6;
        Mon, 19 Jun 2023 05:51:33 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JB0CUU025697;
        Mon, 19 Jun 2023 12:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=i7Pr1EWNiHdHSPy/1ruMBzE82xAckINjNAYVQ8T02fk=;
 b=JHJqG1RevQ9dWEWiWoCek00aKqyS3OKu+9A3zMwqTrO6QnH68c8yEX80M2/8iaGcKaFK
 QkKG8JZmX4fWozzd6t826uZ+y25skPXZBjoVhDASKTUcMjLjps++crm6nAGq+5wvIUn4
 rB6OS+I902s7kRB4mPKiQx6Zwgd52vBFOAq3A70leLZGib4W8SlbnkM4TmgXhCQ9VJyk
 q9YwjdlnfgaLimdfLdJKfEySUrQIozma3S+xi5QwO2PLyGhM9Wpp2wHzRgT6c37Vn6aR
 S73GAp3oEQ2cE/nhjGjFzF4n3TEivCTcq7jGbz6NGHRl5VRfOm5AGlhFlRlZg62tvJEK Eg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r95kp2yw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 12:50:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35JConcU017494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 12:50:49 GMT
Received: from [10.216.17.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 19 Jun
 2023 05:50:46 -0700
Message-ID: <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
Date:   Mon, 19 Jun 2023 18:20:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
 <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hgjyP7XNcTCTd239IwR3ntP7fRVaLMEE
X-Proofpoint-ORIG-GUID: hgjyP7XNcTCTd239IwR3ntP7fRVaLMEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_09,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190118
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2023 12:36 PM, Johan Hovold wrote:
> On Sun, Jun 18, 2023 at 05:39:49PM +0530, Krishna Kurapati wrote:
>> In scenarios where pullup relies on resume (get sync) to initialize
>> the controller and set the run stop bit, then core_init is followed by
>> gadget_resume which will eventually set run stop bit.
>>
>> But in cases where the core_init fails, the return value is not sent
>> back to udc appropriately. So according to UDC the controller has
>> started but in reality we never set the run stop bit.
>>
>> On systems like Android, there are uevents sent to HAL depending on
>> whether the configfs_bind / configfs_disconnect were invoked. In the
>> above mentioned scnenario, if the core init fails, the run stop won't
>> be set and the cable plug-out won't result in generation of any
>> disconnect event and userspace would never get any uevent regarding
>> cable plug out and we never call pullup(0) again. Furthermore none of
>> the next Plug-In/Plug-Out's would be known to configfs.
>>
>> Return back the appropriate result to UDC to let the userspace/
>> configfs know that the pullup failed so they can take appropriate
>> action.
>>
>> Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC unbinded")
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> ---
>> Changes in v3: Added changelog mising in v2
>> Changes in v2: Added Fixes tag
>>
>>   drivers/usb/dwc3/gadget.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 578804dc29ca..27cb671e18e3 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>   	ret = pm_runtime_get_sync(dwc->dev);
>>   	if (!ret || ret < 0) {
>>   		pm_runtime_put(dwc->dev);
>> -		return 0;
>> +		if (ret < 0)
>> +			pm_runtime_set_suspended(dwc->dev);
> 
> This bit is broken and is also not mentioned or explained in the commit
> message. What are you trying to achieve here?
> 
> You cannot set the state like this after runtime PM is enabled and the
> above call will always fail.
> 
Hi Johan,

   Apologies, I didn't understand the comment fully.

The reason why I an returning ret is because, when the first get_sync 
fails because of core_init failure and we return 0 instead of ret, the 
UDC thinks that controller has started successfully but we never set the 
run stop bit. So when we plug out the cable,  the disconnect event won't 
be generated and we never send on systems like android the user space 
will never clear the UDC upon disconnect. Its a sort of mismatch between 
controller and udc.

Also once the first get_sync fails, the dwc->dev->power.runtime_error 
flag is set and successive calls to get_sync always return -EINVAL. In 
this situation even if UDC/configfs retry pullup, resume_common will 
never be called and we never actually start the controller or resume 
dwc->dev.

By calling set_suspended, I am trying to clear the runtime_error flag so 
that the next retry to pullup will call resume_common and retry 
core_init and set run_stop.

Regards,
Krishna,

>> +		return ret;
>>   	}
>>   
>>   	if (dwc->pullups_connected == is_on) {
> 
> Johan
