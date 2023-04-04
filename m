Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E2C6D57A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 06:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjDDEjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 00:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjDDEjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 00:39:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D4AC2;
        Mon,  3 Apr 2023 21:39:45 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3341pWTw030827;
        Tue, 4 Apr 2023 04:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BS5ANVYxiKnf/FtrKDj21/SfNBkxnElHffFQXvRDdnU=;
 b=MNV7wSHblNmrXFr+PYjl+jLqjIaiD2hj1+JXjOVFgxb/3SpT/jnQVX8lqdnf54wOXdBF
 3Rn1bedXTUuLL330U756fteLIFK6gTWhg1WyMU7L43gd40jWsPs8+VMj92SXPFOuHZHE
 MsklbgSari2nQPRhoQJkLxpl6FmjkY+Vpz8Tny1P0I6R1jR19snvW0H28m/fL2wkCocV
 jrKgNefDtZrLUlwvljEz8qIfdgs/O4Wmlsnv3S7wfjAx/x4BVbUw9+nW1PfYyULhWFI6
 UFczSOEYyIIm57+59EWujU3dlmPzLLV+kXMjfzy/YPO+5Sur6JDqVSy+O+6nrnMKMxZX rQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqtdnap88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 04:39:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3344dD7u022819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 04:39:13 GMT
Received: from [10.216.8.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 21:39:09 -0700
Message-ID: <e769cc7c-8b87-c346-5cef-9d89f3ccb91e@quicinc.com>
Date:   Tue, 4 Apr 2023 10:09:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
 <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
 <20230403234937.sotn3pznu4winlkw@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230403234937.sotn3pznu4winlkw@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aFgH2_cuaP3H1H7Fmqkt9dY_HMkIUkAZ
X-Proofpoint-GUID: aFgH2_cuaP3H1H7Fmqkt9dY_HMkIUkAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_19,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304040041
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2023 5:19 AM, Thinh Nguyen wrote:
> On Thu, Mar 30, 2023, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 3/30/2023 5:40 AM, Thinh Nguyen wrote:
>>> On Wed, Mar 29, 2023, Krishna Kurapati PSSNV wrote:
>>>>
>>>>
>>>> On 3/29/2023 2:50 AM, Thinh Nguyen wrote:
>>>>> Hi,
>>>>>
>>>>> On Tue, Mar 28, 2023, Krishna Kurapati wrote:
>>>>>> If the core soft reset timeout happens, avoid setting up event
>>>>>> buffers and starting gadget as the writes to these registers
>>>>>> may not reflect when in reset and setting the run stop bit
>>>>>> can lead the controller to access wrong event buffer address
>>>>>> resulting in a crash.
>>>>>>
>>>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>>>> ---
>>>>>>     drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>> index 3c63fa97a680..f0472801d9a5 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -2620,13 +2620,16 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>>>     		 * device-initiated disconnect requires a core soft reset
>>>>>>     		 * (DCTL.CSftRst) before enabling the run/stop bit.
>>>>>>     		 */
>>>>>> -		dwc3_core_soft_reset(dwc);
>>>>>> +		ret = dwc3_core_soft_reset(dwc);
>>>>>> +		if (ret)
>>>>>> +			goto done;
>>>>>>     		dwc3_event_buffers_setup(dwc);
>>>>>>     		__dwc3_gadget_start(dwc);
>>>>>>     		ret = dwc3_gadget_run_stop(dwc, true, false);
>>>>>>     	}
>>>>>> +done:
>>>>>>     	pm_runtime_put(dwc->dev);
>>>>>>     	return ret;
>>>>>> -- 
>>>>>> 2.40.0
>>>>>>
>>>>>
>>>>> I think there's one more place that may needs this check. Can you also
>>>>> add this check in __dwc3_set_mode()?
>>>>
>>>> Hi Thinh,
>>>>
>>>>     Sure. Will do it.
>>>> Will the below be good enough ? Or would it be good to add an error/warn log
>>>> there>
>>>
>>> There's already a warning message in dwc3_core_soft_reset() if it fails.
>>>
>>>>
>>>> kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales2/skales/kernel$
>>>> git diff drivers/usb/
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 476b63618511..8d1d213d1dcd 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -210,7 +210,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>>>>                   }
>>>>                   break;
>>>>           case DWC3_GCTL_PRTCAP_DEVICE:
>>>> -               dwc3_core_soft_reset(dwc);
>>>> +               ret = dwc3_core_soft_reset(dwc);
>>>> +               if (ret)
>>>> +                       goto out;
>>>>
>>>>                   dwc3_event_buffers_setup(dwc);
>>>>
>>>
>>> If soft-reset failed, the controller is in a bad state. We should not
>>> perform any further operation until the next hard reset. We should flag
>>> the controller as dead. I don't think we have the equivalent of the
>>> host's HCD_FLAG_DEAD. It may require some work in the UDC core. Perhaps
>>> we can flag within dwc3 for now and prevent any further operation for a
>>> simpler fix.
>>>
>> Hi Thinh,
>>
>>   Are you referring that if __dwc3_set_mode failed with core soft reset
>> timing out, the caller i.e., dwc3_set_mode who queues the work need to know
>> that the operation actually failed. So we can add a flag to indicate that
>> gadget is dead and the caller of dwc3_set_mode can check the flag to see if
>> the operation is successful or not.
>>
>> Or am I misunderstanding your comment ?
>>
> 
> Not just in __dwc3_set_mode(). I mean any time dwc3_core_soft_reset
> fails, then we set this flag. So that it can prevent the user calling
> any gadget ops causing more crashes/invalid behavior. The
> dwc->softconnect is already wrong on pullup() on failure.
> 
> So that we can have a check in different gadget ops. For pullup():
> 
> static int dwc3_gadget_pullup() {
> 	if (dwc->udc_is_dead) {
> 		dev_err(dev, "reset me. x_x \n");
> 		return;
> 	}
> 
> 	abc();
> }
> 
> Perhaps the effort is probably the same if we enhance the UDC core for
> this? In any case, I'm fine either way.
> 
> Thanks,
> Thinh

Hi Thinh,

  So you don't want UDC to retry pullup if it fails the first time ? As 
per patch-2 of this series, I was trying to propagate the EITMEDOUT to 
UDC so that the caller (most probably configfs) can take appropriate 
action as to whether it must retry pullup or not.

Regards,
Krishna,
