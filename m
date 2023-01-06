Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984365F9FC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 04:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjAFDNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 22:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjAFDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 22:13:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD970625C9;
        Thu,  5 Jan 2023 19:13:21 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3061OmT5020298;
        Fri, 6 Jan 2023 03:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ULYBdqEhaYDavmiyz2xmuAJFoVOLB6mTLBife/XCKic=;
 b=be1VurNgMgEgHN+8Y/q/S4S6VdlXVtgC9QPgfCLpIBuyGGVTdVeY1lDVR+MESbcolowU
 lQvmMKIyNSGDOqaeYc3A7uO/ViM+NWUvSyBUi8bsO5SJNm2pcVgeG9Oy5nn1H5upzWoU
 YTlRfrAX9zj4oocbR3V8WH+kP/OB4bEBlk0NSHX/5QoCUTaySJTizhdktSSeXJdbDCa4
 viaCpVc7O7gBRWdEKJAmk2PQBGbWWta6c1rb5bNzkvdsl6QgQqRW/0J3ijKrA893GutZ
 Fs3uq9sip/VqHzCZHaY+rEHsQUsxUXM8ff9O44t69T58/MpS7KnkpB55R0qBGV7t4H32 tQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mx3s1rxex-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Jan 2023 03:13:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3063DC5D028788
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Jan 2023 03:13:12 GMT
Received: from [10.253.77.237] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 19:13:09 -0800
Message-ID: <0bbd2355-2290-17c7-6860-d8b25930aed6@quicinc.com>
Date:   Fri, 6 Jan 2023 11:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
To:     =?UTF-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        'Thinh Nguyen' <Thinh.Nguyen@synopsys.com>
CC:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
 <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
 <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
 <000201d920eb$c3715c50$4a5414f0$@samsung.com>
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <000201d920eb$c3715c50$4a5414f0$@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Mk43hAkpaOeC4ykw-pTIc6t6OqjKxsGD
X-Proofpoint-GUID: Mk43hAkpaOeC4ykw-pTIc6t6OqjKxsGD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_14,2023-01-05_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301060022
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/2023 5:54 PM, 정재훈 wrote:
>
>> -----Original Message-----
>> From: Linyu Yuan [mailto:quic_linyyuan@quicinc.com]
>> Sent: Thursday, January 5, 2023 12:35 PM
>> To: JaeHun Jung; Felipe Balbi; Greg Kroah-Hartman; Thinh Nguyen
>> Cc: open list:USB XHCI DRIVER; open list; Seungchull Suh; Daehwan Jung
>> Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
>>
>>
>> On 1/5/2023 11:29 AM, Linyu Yuan wrote:
>>> On 1/2/2023 1:08 PM, JaeHun Jung wrote:
>>>> Sometimes very rarely, The count is 0 and the DWC3 flag is set has
>>>> status.
>>>> It must not have these status. Because, It can make happen interrupt
>>>> storming status.
>>> could you help explain without clear the flag, how interrupt storming
>>> happen ?
>>>
>>> as your change didn't touch any hardware register, i don't know how it
>>> fix storming.
>>>
> H/W interrupts are still occur on IP.

I guess we should fix it from IP layer.


but when checking DWC3_EVENT_PENDING flag, it will auto clear in dwc3 
thread irq handler.

there is one possible root cause is it cleared only after irq enabled in 
dwc3_process_event_buf(),

we should move unmask irq operation at end of this function.


> But. ISR doesn't handle it. Because of this
> "if (evt->flags & DWC3_EVENT_PENDING)"
>
> This is event values.
> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 = kernel_size_le_lo32+0xFFFFFF883B391180 -> (
>          (void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000 -> ,
>          (void *) cache = 0xFFFFFF8839F54080 = kernel_size_le_lo32+0xFFFFFF88376F4080 -> ,
>          (unsigned int) length = 0x1000,
>          (unsigned int) lpos = 0x0,
>          (unsigned int) count = 0x0,
>          (unsigned int) flags = 0x00100001,
>          (dma_addr_t) dma = 0x00000008BD7D7000,
>
> *((struct dwc3_event_type *) 0xFFFFFF8839F54080) = (
>      is_devspec = 1,
>      type = 0,
>      reserved8_31 = 774)
>
> *((struct dwc3_event_devt  *) 0xFFFFFF8839F54080) = (
>      one_bit = 1,
>      device_event = 0,
>      type = 6, << DWC3_DEVICE_EVENT_SUSPEND
>      reserved15_12 = 0,
>      event_info = 3,
>      reserved31_25 = 0)
>
> Occurred interrupts are "DWC3_DEVICE_EVENT_SUSPEND".
> If when "count has 0" and DWC3_EVENT_PENDING are set at the same time than
>   ISR and bottom thread couldn't handle next interrupt.
> We guessing connected with "dwc3_gadget_process_pending_events()" function.
> But, We could not find reproduce way.
>
>
>>> storming from software layer ?
>>>
>>>> So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
>>>> It means "There are no interrupts to handle.".
>>>>
>>>> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
>>>>      (void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
>>>>      (void *) cache = 0xFFFFFF8839F54080,
>>>>      (unsigned int) length = 0x1000,
>>>>      (unsigned int) lpos = 0x0,
>>>>      (unsigned int) count = 0x0,
>>>>      (unsigned int) flags = 0x00000001,
>>>>      (dma_addr_t) dma = 0x00000008BD7D7000,
>>>>      (struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
>>>>      (u64) android_kabi_reserved1 = 0x0),
>>>>
>>>> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 1), (time = 47557628931268, irq = 165, fn = dwc3_interrupt,
>>>> latency = 0, en = 3), (time = 47557628932383, irq = 165, fn =
>>>> dwc3_interrupt, latency = 0, en = 1), (time = 47557628932652, irq =
>>>> 165, fn = dwc3_interrupt, latency = 0, en = 3), (time =
>>>> 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 3), (time = 47557628935152, irq = 165, fn = dwc3_interrupt,
>>>> latency = 0, en = 1), (time = 47557628935460, irq = 165, fn =
>>>> dwc3_interrupt, latency = 0, en = 3), (time = 47557628936575, irq =
>>>> 165, fn = dwc3_interrupt, latency = 0, en = 1), (time =
>>>> 47557628936845, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>>>> (time = 47557628937960, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 1), (time = 47557628938229, irq = 165, fn = dwc3_interrupt,
>>>> latency = 0, en = 3), (time = 47557628939345, irq = 165, fn =
>>>> dwc3_interrupt, latency = 0, en = 1), (time = 47557628939652, irq =
>>>> 165, fn = dwc3_interrupt, latency = 0, en = 3), (time =
>>>> 47557628940768, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628941037, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 3), (time = 47557628942152, irq = 165, fn = dwc3_interrupt,
>>>> latency = 0, en = 1), (time = 47557628942422, irq = 165, fn =
>>>> dwc3_interrupt, latency = 0, en = 3), (time = 47557628943537, irq =
>>>> 165, fn = dwc3_interrupt, latency = 0, en = 1), (time =
>>>> 47557628943806, irq = 165, fn = dwc3_interrupt, latency = 0, en = 3),
>>>> (time = 47557628944922, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 1), (time = 47557628945229, irq = 165, fn = dwc3_interrupt,
>>>> latency = 0, en = 3), (time = 47557628946345, irq = 165, fn =
>>>> dwc3_interrupt, latency = 0, en = 1), (time = 47557628946614, irq =
>>>> 165, fn = dwc3_interrupt, latency = 0, en = 3), (time =
>>>> 47557628947729, irq = 165, fn = dwc3_interrupt, latency = 0, en = 1),
>>>> (time = 47557628947999, irq = 165, fn = dwc3_interrupt, latency = 0,
>>>> en = 3),
>>>>
>>>> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
>>>> ---
>>>>    drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-) diff --git
>>>> a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index
>>>> 789976567f9f..5d2d5a9b9915 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -4355,8 +4355,11 @@ static irqreturn_t dwc3_check_event_buf(struct
>>>> dwc3_event_buffer *evt)
>>>>         * irq event handler completes before caching new event to
>>>> prevent
>>>>         * losing events.
>>>>         */
>>>> -    if (evt->flags & DWC3_EVENT_PENDING)
>>>> +    if (evt->flags & DWC3_EVENT_PENDING) {
>>>> +        if (!evt->count)
>>>> +            evt->flags &= ~DWC3_EVENT_PENDING;
>>>>            return IRQ_HANDLED;
>>>> +    }
>>>>          count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>>>        count &= DWC3_GEVNTCOUNT_MASK;
>>> how about below change ?
>>>
>>>          count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>>          count &= DWC3_GEVNTCOUNT_MASK;
>>> -       if (!count)
>>> +       if (!count) {
>>> +               evt->flags &= ~DWC3_EVENT_PENDING;
>>>                  return IRQ_NONE;
>>> +       }
>> ignore my suggestion, add Thinh to comment.
>>>          evt->count = count;
>>>          evt->flags |= DWC3_EVENT_PENDING;
>>>
