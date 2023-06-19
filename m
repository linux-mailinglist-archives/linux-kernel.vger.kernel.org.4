Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF58E735889
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjFSN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFSN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:28:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA94C123;
        Mon, 19 Jun 2023 06:28:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JDGB8W003094;
        Mon, 19 Jun 2023 13:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dtR2RTC/gJFg0dJZ62EmzEQfYKO9OiMUBU5LqXTecqw=;
 b=cBD8gS8VpfwXYs4udFbU7LEEu7rCMF/Dtzi+5Q0DgfA3Q0P1iadhoJkVo+lm0GNTPMaW
 oo0+2IHeGnoECJwrn+vRgny6fQvjdVul5ErBsP315ZUufcuKTb4zcE+/NTHiNoon8svE
 KE0mcZcbpwNwxCz68xRKJep+DStXZxFFaEz+HhwagLNPqe7HVrp64kSeLtuD1RVESPkn
 Pu5HRnfS1iD+eWtg47WtTy6ENqqZNkjlcPRiijbUao1ubf/FP05ANqZKCtgVZR8mc1VN
 gKpA/QHNb/slbN4BYC6G0SMdn+WKuVdyhRhX3u9rLF37l1YKKtK2UTDGVdhvbjcXGjZL jw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r94x1b3xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:27:55 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35JDRsVd017580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 13:27:54 GMT
Received: from [10.216.17.76] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 19 Jun
 2023 06:27:50 -0700
Message-ID: <6f5f0e4c-d18f-b8cb-30cc-53bbfa158c2f@quicinc.com>
Date:   Mon, 19 Jun 2023 18:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
 <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
 <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
Content-Language: en-US
In-Reply-To: <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GIKSEf9prBxGotG0ET1oga_e3QRbHI_j
X-Proofpoint-GUID: GIKSEf9prBxGotG0ET1oga_e3QRbHI_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190123
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2023 6:20 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 6/19/2023 12:36 PM, Johan Hovold wrote:
>> On Sun, Jun 18, 2023 at 05:39:49PM +0530, Krishna Kurapati wrote:
>>> In scenarios where pullup relies on resume (get sync) to initialize
>>> the controller and set the run stop bit, then core_init is followed by
>>> gadget_resume which will eventually set run stop bit.
>>>
>>> But in cases where the core_init fails, the return value is not sent
>>> back to udc appropriately. So according to UDC the controller has
>>> started but in reality we never set the run stop bit.
>>>
>>> On systems like Android, there are uevents sent to HAL depending on
>>> whether the configfs_bind / configfs_disconnect were invoked. In the
>>> above mentioned scnenario, if the core init fails, the run stop won't
>>> be set and the cable plug-out won't result in generation of any
>>> disconnect event and userspace would never get any uevent regarding
>>> cable plug out and we never call pullup(0) again. Furthermore none of
>>> the next Plug-In/Plug-Out's would be known to configfs.
>>>
>>> Return back the appropriate result to UDC to let the userspace/
>>> configfs know that the pullup failed so they can take appropriate
>>> action.
>>>
>>> Fixes: 77adb8bdf422 ("usb: dwc3: gadget: Allow runtime suspend if UDC 
>>> unbinded")
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>> ---
>>> Changes in v3: Added changelog mising in v2
>>> Changes in v2: Added Fixes tag
>>>
>>>   drivers/usb/dwc3/gadget.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 578804dc29ca..27cb671e18e3 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget 
>>> *g, int is_on)
>>>       ret = pm_runtime_get_sync(dwc->dev);
>>>       if (!ret || ret < 0) {
>>>           pm_runtime_put(dwc->dev);
>>> -        return 0;
>>> +        if (ret < 0)
>>> +            pm_runtime_set_suspended(dwc->dev);
>>
>> This bit is broken and is also not mentioned or explained in the commit
>> message. What are you trying to achieve here?
>>
>> You cannot set the state like this after runtime PM is enabled and the
>> above call will always fail.
>>
> Hi Johan,
> 
>    Apologies, I didn't understand the comment fully.
> 
> The reason why I an returning ret is because, when the first get_sync 
> fails because of core_init failure and we return 0 instead of ret, the 
> UDC thinks that controller has started successfully but we never set the 
> run stop bit. So when we plug out the cable,  the disconnect event won't 
> be generated and we never send on systems like android the user space > will never clear the UDC upon disconnect. Its a sort of mismatch between
> controller and udc. >
Typo here:

So when we plug out the cable, the disconnect event won't be generated 
and on systems like android the user space will never clear the UDC upon 
disconnect.

> Also once the first get_sync fails, the dwc->dev->power.runtime_error 
> flag is set and successive calls to get_sync always return -EINVAL. In 
> this situation even if UDC/configfs retry pullup, resume_common will 
> never be called and we never actually start the controller or resume 
> dwc->dev.
> 
> By calling set_suspended, I am trying to clear the runtime_error flag so 
> that the next retry to pullup will call resume_common and retry 
> core_init and set run_stop.
> 
> Regards,
> Krishna,
> 
>>> +        return ret;
>>>       }
>>>       if (dwc->pullups_connected == is_on) {
>>
>> Johan
