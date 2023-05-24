Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45870EBD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjEXDZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjEXDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:25:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8E9139;
        Tue, 23 May 2023 20:25:24 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O3E2sN019434;
        Wed, 24 May 2023 03:25:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sbcZ/fvEcFVu4UT1qSQvboKdHf0q4+17TMJDdbLzttk=;
 b=blnKnOZvzG5ev4poYhtg7E5+V7dZS2IPLld4H46Sm5CDwwjxvwCkN2gBQ7plQsRmuCa3
 oO1jvCk7RwnkV2ScvjLDt7TzzpB9eYOmriFyQHPsg9GfVKcnMhUJFqOKKAzVKxtc+Pp/
 sbYtpOZ8JM+7cB2mn7Xs+Tpf99whWQXwQ3FmGHiiHLp6TfQsDDtZEWPNePc0iBOvNgCL
 B0/BtSrEBTcZYK7aH6+suyEgzp71BDCzBc+JVGoFmehPX2hfUrlmy0unqX42NKahvQ4k
 1A3OOhFsO6RhKm/ca3rkYiesOH2bBvFtFhhBNvZ9eXhtDdppJ4tG+aH4wNymL0dI7NnI fg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsa0v821r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 03:25:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34O3PLBx021833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 03:25:21 GMT
Received: from [10.216.26.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 23 May
 2023 20:25:18 -0700
Message-ID: <0dab321e-3a55-aef5-a392-5860e98bb12e@quicinc.com>
Date:   Wed, 24 May 2023 08:55:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC] usb: dwc3: gadget: Fix amount of data copied from event buf
 to cache
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230521100330.22478-1-quic_kriskura@quicinc.com>
 <20230522211651.rr2r3caz6ni7m6xr@synopsys.com>
 <e0f0275a-9418-5aa7-58c6-4ac9ae03e0ae@quicinc.com>
 <20230523212241.av5tts233p5hlodm@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230523212241.av5tts233p5hlodm@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kAJ33fCXkJfirEJ2tcfhj8R7kuTls8wQ
X-Proofpoint-ORIG-GUID: kAJ33fCXkJfirEJ2tcfhj8R7kuTls8wQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_16,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=726
 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240027
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/24/2023 2:52 AM, Thinh Nguyen wrote:
> On Tue, May 23, 2023, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 5/23/2023 2:47 AM, Thinh Nguyen wrote:
>>> On Sun, May 21, 2023, Krishna Kurapati wrote:
>>>> In the current implementation, the check_event_buf call reads the
>>>> GEVNTCOUNT register to determine the amount of event data generated
>>>> and copies it from ev->buf to ev->cache after masking interrupt.
>>>>
>>>> During copy if the amount of data to be copied is more than
>>>> (length - lpos), we fill the ev->cache till the end of 4096 byte
>>>> buffer allocated and then start filling from the top (lpos = 0).
>>>>
>>>> In one instance of SMMU crash it is observed that GEVNTCOUNT register
>>>> reads more than 4096 bytes:
>>>>
>>>> dwc3_readl   base=0xffffffc0091dc000  offset=50188  value=63488
>>>>
>>>> (offset = 50188 -> 0xC40C)  -> reads 63488 bytes
>>>>
>>>> As per crash dump:
>>>> dwc->lpos = 2056
>>>>
>>>> and evt->buf is at 0xFFFFFFC009185000 and the crash is at
>>>> 0xFFFFFFC009186000. The diff which is exactly 0x1000 bytes.
>>>>
>>>> We first memcpy 2040 bytes from (buf + lpos) to (buf + 0x1000).
>>>>
>>>> And then we copy the rest of the data (64388 - 2040) from beginning
>>>> of dwc->ev_buf. While doing so we go beyond bounds as we are trying
>>>> to memcpy 62348 bytes into a 4K buffer resulting in crash.
>>>>
>>>> Fix this by limiting the total data being copied to ev->length to
>>>> avoid copying data beyond bounds. Moreover this is logical because if
>>>> the controller generated events more than the size of ring buffer,
>>>> some of them might have been overwritten by the controller.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>> Only one instance of this crash was observed so far. As per the
>>>> databook:
>>>>
>>>> "The controller always leaves one entry free in each Event Buffer.
>>>> When the Event Buffer is almost full, hardware writes the Event
>>>> Buffer Overflow event and the USB eventually gets stalled when
>>>> endpoints start responding NRDY or the link layer stops returning
>>>> credits (in SuperSpeed). This event is an indication to software that
>>>> it is not processing events quickly enough. During this time, events
>>>> are queued up internally. When software frees up Event Buffer space,
>>>> the queued up events are written out and the USB returns to normal
>>>> operation"
>>>>
>>>> I didn't see any overflow event in the event buffer after parsing
>>>> crash dump. Although this could be some HW issue, I thought we can
>>>> include this fix in software as well to avoid such scenario.
>>>>
>>>
>>> What's the GEVNTSIZ at the point of the crash? That's where the driver
>>> tells the controller how much it allocated for the event buffer.
>>>
>>> Check to make sure that it wasn't reset during operation (not cleanup).
>>
>>
>> Hi Thinh,
>>
>>   The last 3 RW traces were as follows:
>>
>> <idle>-0    [001]   5834.471640:  dwc3_writel   base=0xffffffc0091dc000
>> offset=50184  value=4096
>> <idle>-0    [001]   5834.471799:  dwc3_readl   base=0xffffffc0091dc000
>> offset=50188  value=63488
>> <idle>-0    [001]   5834.471803:  dwc3_writel   base=0xffffffc0091dc000
>> offset=50184  value=2147487744
>>
>> The first one was at the end of previous process_event_entry call where we
>> unmasked the interrupt.
>>
>> The second one was the read of GEVTCOUNT.
>>
>> The third one was where we wrote 31st bit of the GEVTSIZ register to mask
>> interrupt along with 4096 bytes to [15:0] bits.
>>
>> There is only 100-150us gap between each of these read writes and if you are
>> referring to whether the GEVTSIZ got modified in between, I am not sure of
>> that.
>>
> 
> The read from GEVNTCOUNT looks corrupted. When was the last time (delta
> time) an event was handled prior to the failure? If it's a short delta,
> it further indicates that whatever the value returned is invalid.
> 
> So, setting count = evt->length if count > evt->length is no good. The
> event count is probably much lower and you may end up reading stale
> events.
> 
> It's odd that we are only able to see this issue now. For this type of
> failure, it should've been exposed much early on. Is there potentially
> something different for your setup/configuration that may cause this
> issue. Also, how easily are you able to reproduce this. Did you try to
> re-read the GEVNTCOUNT multiple times when this happens to see if the
> value changes dramatically?
> 

The previous event processed was just before this interrupt came in 
which too was having a huge GEVTCOUNT but not big to crash the device 
(in memcpy). And very soon, after it was processed, this current 
interrupt came in.

(That is why in the comment section of the patch, I mentioned that this 
could be a hw issue too that came up randomly. But wanted to check if 
this case is something that can be considered for fixing.)

And there has been only one instance reported so far on a target which 
has very less computational capability and has a hug sw stack (apart 
from linux) running on top of it.

Regards,
Krishna,
