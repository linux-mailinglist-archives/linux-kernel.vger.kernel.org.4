Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB26165E38F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjAEDfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAEDfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 22:35:30 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299F3056F;
        Wed,  4 Jan 2023 19:35:29 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3052VWvu013774;
        Thu, 5 Jan 2023 03:35:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=x7g25aSH20tRBimuyCF5WUO4WPaScgXdldfxyRZwktI=;
 b=ALj5VHM826JxnKVv0uAEAm507hTKfmmSjCyjBthk/qsJEgSswHbuAIa2eSI7DtXvCXnK
 NM4jWQNKvsI2Iol/4BBPtehFa+M21KxXq7bTP+VtPvrZNoIZCymrtlZeIwJy+liRthEv
 mkMbl1b7wBvRNm/FdlfOvUukneOc/9LN/wTZFb4yuipEw2IKFkOI5V9sw8hKopENcx3B
 EJNvxJPODgcR6RmpC3V8kXJgyXXDDWSXny3AL+8wlE3rvRFW6fkMMJSeyLrp8fYhEX0q
 7jShVwpsnFfUnO3mCw0irZ7PQ5SUBHLbw5XVs+vjqujd39s5ccpK6UV+kvTo3P+t01P2 vA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwj1rrfyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 03:35:22 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3053ZLsb014058
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 03:35:21 GMT
Received: from [10.239.154.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 4 Jan 2023
 19:35:19 -0800
Message-ID: <c4e01a0a-1c98-3103-2b91-2fe0ba8c3118@quicinc.com>
Date:   Thu, 5 Jan 2023 11:35:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] usb: dwc3: Clear DWC3_EVENT_PENDING when count is 0
Content-Language: en-US
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     JaeHun Jung <jh0801.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>
References: <CGME20230102050839epcas2p4b9d09d926f9a14c3b8e8df2574d334c3@epcas2p4.samsung.com>
 <20230102050831.105499-1-jh0801.jung@samsung.com>
 <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
In-Reply-To: <af32e2f5-de45-38af-2b4f-47c1ac21ea9e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wWvh_WNy_leOY4RYUyvjmz3RmjiDsFB_
X-Proofpoint-GUID: wWvh_WNy_leOY4RYUyvjmz3RmjiDsFB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=610 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301050028
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2023 11:29 AM, Linyu Yuan wrote:
> On 1/2/2023 1:08 PM, JaeHun Jung wrote:
>> Sometimes very rarely, The count is 0 and the DWC3 flag is set has 
>> status.
>> It must not have these status. Because, It can make happen interrupt 
>> storming
>> status.
>
> could you help explain without clear the flag, how interrupt storming 
> happen ?
>
> as your change didn't touch any hardware register, i don't know how it 
> fix storming.
>
> storming from software layer ?
>
>> So, It have to clean up DWC3_EVENT_PENDING flags set when count is 0.
>> It means "There are no interrupts to handle.".
>>
>> (struct dwc3_event_buffer *) ev_buf = 0xFFFFFF883DBF1180 (
>>     (void *) buf = 0xFFFFFFC00DBDD000 = end+0x337D000,
>>     (void *) cache = 0xFFFFFF8839F54080,
>>     (unsigned int) length = 0x1000,
>>     (unsigned int) lpos = 0x0,
>>     (unsigned int) count = 0x0,
>>     (unsigned int) flags = 0x00000001,
>>     (dma_addr_t) dma = 0x00000008BD7D7000,
>>     (struct dwc3 *) dwc = 0xFFFFFF8839CBC880,
>>     (u64) android_kabi_reserved1 = 0x0),
>>
>> (time = 47557628930999, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628931268, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628932383, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628932652, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628933768, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628934037, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628935152, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628935460, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628936575, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628936845, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628937960, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628938229, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628939345, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628939652, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628940768, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628941037, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628942152, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628942422, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628943537, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628943806, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628944922, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628945229, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628946345, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628946614, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>> (time = 47557628947729, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 1),
>> (time = 47557628947999, irq = 165, fn = dwc3_interrupt, latency = 0, 
>> en = 3),
>>
>> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 789976567f9f..5d2d5a9b9915 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -4355,8 +4355,11 @@ static irqreturn_t dwc3_check_event_buf(struct 
>> dwc3_event_buffer *evt)
>>        * irq event handler completes before caching new event to prevent
>>        * losing events.
>>        */
>> -    if (evt->flags & DWC3_EVENT_PENDING)
>> +    if (evt->flags & DWC3_EVENT_PENDING) {
>> +        if (!evt->count)
>> +            evt->flags &= ~DWC3_EVENT_PENDING;
>>           return IRQ_HANDLED;
>> +    }
>>         count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>       count &= DWC3_GEVNTCOUNT_MASK;
>
> how about below change ?
>
>         count = dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>         count &= DWC3_GEVNTCOUNT_MASK;
> -       if (!count)
> +       if (!count) {
> +               evt->flags &= ~DWC3_EVENT_PENDING;
>                 return IRQ_NONE;
> +       }
ignore my suggestion, add Thinh to comment.
>
>         evt->count = count;
>         evt->flags |= DWC3_EVENT_PENDING;
>
