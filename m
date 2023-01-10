Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A0664CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjAJUE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjAJUEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:04:49 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EFC52C4D;
        Tue, 10 Jan 2023 12:04:47 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ACaKFN014144;
        Tue, 10 Jan 2023 20:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lDhJiMKqhS4cwe6NUw8uuSD1qEAuVbxSRigz1sHh4oQ=;
 b=IkoPBa7d9Vzm84Xbg3Tfh2j4T/m/QIe8kwQNlu8axpUlP7t6DIHi1DnBA+ppoF7bIVID
 sAHYoOvu/J5cRjQwxAy9vNv7teka5ZNhV22YsAyVxmW0ejGBTzMxxmngk7UPuXG+YN/I
 afGGxLfRVh0/6w/YJlWvNi/AyzvI8JbKZ7P3MI0llpZAzL98hyV6gfdMJfQ5PlybpzyS
 W2D0ypEsGCbnxfiQ5rzesSYNykUnkCenXC/DnaennCOvgaCBdxeB5rERb3cPMSVEgvIR
 ZAbjkP2KgYJdWtaWaUtKVF6YdYVr0iHX8E0b3VwZahKoTG+t4G5eXSzWxxzNzpAUQ1N7 wQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n0x0jjac3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:03:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30AK3krn019414
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:03:46 GMT
Received: from [10.110.66.166] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 10 Jan
 2023 12:03:45 -0800
Message-ID: <23a2b82e-4f4f-66e2-2c60-3613ffe7912f@quicinc.com>
Date:   Tue, 10 Jan 2023 12:03:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 07/14] usb: host: xhci: Add XHCI secondary interrupter
 support
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <agross@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
        Albert Wang <albertccwang@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-8-quic_wcheng@quicinc.com>
 <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
 <f7f80320-02bb-a573-dd95-b6d58c260624@quicinc.com>
 <5f54c5a3-caf0-2920-e90f-68124ed2e06c@linux.intel.com>
 <d1334e58-1126-c068-d211-8fd3b7dcbf17@quicinc.com>
 <cefcc5c6-6a91-c737-252a-edf596f77473@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <cefcc5c6-6a91-c737-252a-edf596f77473@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jiQBCJnSBnVkVHxOOa0aeOKcweduyDnY
X-Proofpoint-ORIG-GUID: jiQBCJnSBnVkVHxOOa0aeOKcweduyDnY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 1/10/2023 11:47 AM, Mathias Nyman wrote:
> On 9.1.2023 22.24, Wesley Cheng wrote:
>> Hi Mathias,
>>
>> On 1/2/2023 8:38 AM, Mathias Nyman wrote:
>>> On 29.12.2022 23.14, Wesley Cheng wrote:
>>>> Hi Mathias,
>>>>
>>>> On 12/28/2022 7:47 AM, Mathias Nyman wrote:
>>>>> On 24.12.2022 1.31, Wesley Cheng wrote:
>>>>>> Implement the XHCI operations for allocating and requesting for a 
>>>>>> secondary
>>>>>> interrupter.  The secondary interrupter can allow for events for a
>>>>>> particular endpoint to be routed to a separate event ring.  The event
>>>>>> routing is defined when submitting a transfer descriptor to the 
>>>>>> USB HW.
>>>>>> There is a specific field which denotes which interrupter ring to 
>>>>>> route the
>>>>>> event to when the transfer is completed.
>>>>>>
>>>>>> An example use case, such as audio packet offloading can utilize a 
>>>>>> separate
>>>>>> event ring, so that these events can be routed to a different 
>>>>>> processor
>>>>>> within the system.  The processor would be able to independently 
>>>>>> submit
>>>>>> transfers and handle its completions without intervention from the 
>>>>>> main
>>>>>> processor.
>>>>>>
>>>>>
>>>>> Adding support for more xHCI interrupters than just the primary one 
>>>>> make sense for
>>>>> both the offloading and virtualization cases.
>>>>>
>>>>> xHCI support for several interrupters was probably added to support 
>>>>> virtualization,
>>>>> to hand over usb devices to virtual machines and give them their 
>>>>> own event ring and
>>>>> MSI/MSI-X vector.
>>>>>
>>>>> In this offloading case you probably want to avoid xHC interrupts 
>>>>> from this device
>>>>> completely, making sure it doesn't wake up the main CPU unnecessarily.
>>>>>
>>>>> So is the idea here to let xhci driver set up the new interrupter, 
>>>>> its event ring,
>>>>> and the endpoint transfer rings. Then pass the address of the 
>>>>> endpoint transfer rings
>>>>> and the new event ring to the separate processor.
>>>>>
>>>>> This separate processor then both polls the event ring for new 
>>>>> events, sets its dequeue
>>>>> pointer, clears EHB bit, and queues new TRBs on the transfer ring.
>>>>>
>>>>> so xhci driver does not handle any events for the audio part, and 
>>>>> no audio data URBs
>>>>> are sent to usb core?
>>>>
>>>> Your entire description is correct.  To clarify, the interfaces 
>>>> which are non-audio will still be handled by the main processor.  
>>>> For example, a USB headset can have a HID interface as well for 
>>>> volume control.  The HID interface will still be handled by the main 
>>>> processor, and events routed to the main event ring.
>>>>
>>>>>
>>>>> How about the control part?
>>>>> Is the control endpoint for this device still handled normally by 
>>>>> usb core/xhci?
>>>>>
>>>>
>>>> Control transfers are always handled on the main processor.  Only 
>>>> audio interface's endpoints.
>>>
>>> Good to know, that means interrupter should be chosen per endpoint, 
>>> not per device.
>>>
>>>>
>>>>> For the xhci parts I think we should start start by adding generic 
>>>>> support for several
>>>>> interrupters, then add parts needed for offloading.
>>>>
>>> I can split up the patchsets to add interrupters first, then adding 
>>> the offloading APIs in a separate patch.
>>>
>>>
>>> I started looking at supporting secondary interrupters myself.
>>> Let me work on that part a bit first. We have a bit different end goals.
>>> I want to handle interrupts from a secondary interrupter, while this 
>>> audio offload
>>> really just wants to mask some interrupts.
>>>
>>
>> I was looking at how we could possibly split up the XHCI secondary 
>> interrupter, and offloading parts.  Since the XHCI secondary 
>> interrupter is a feature that is defined in the XHCI spec (and we 
>> aren't doing anything outside of what is defined), I was thinking of 
>> having a separate XHCI driver (ie xhci-sec.c/h) that can be used to 
>> define all APIs related to setting up the event ring and ring 
>> management. (interrupt support can be added here)  This aligns a bit 
>> with what Alan suggested, and removing the APIs in the USB HCD, since 
>> this is XHCI specific stuff. ( 
>> https://lore.kernel.org/linux-usb/Y6zwZOquZOTZfnvP@rowland.harvard.edu/ )
> 
> Already started working on the interrupter, that part fits well into 
> current driver.
> 
> Code (untested, will be randomly rebased etc) can be found in my 
> feature_interrupters branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git 
> feature_interrupters
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/log/?h=feature_interrupters 
> 

Oh perfect, let me take a look.  Thanks for this!

> 
> First step turns current event ring into a primary interrupter.
> last patch is a test implementation for creating and freeing new 
> secondary interrupters.
> 
>>
>> For the offloading part, I think this is a bit more dependent on how 
>> different platforms implement it.  To use more of a generic approach 
>> like how Albert suggested here:
>>
>> https://patchwork.kernel.org/project/linux-usb/list/?series=704174
>>
>> Basically to give vendors the ability to define their own 
>> sequences/callbacks, and from which the XHCI driver will call into. 
>> (if needed)  These would need to be a separate set of XHCI drivers as 
>> well.
>>
>> Do you think this is a proper model for us to go with, so that we can 
>> allow for vendors to easily add functionality?  Appreciate the inputs.
> 
> I'm not convinced that overriding different xhci memory allocation 
> functions is the best solution.
> I think xhci driver will need to know which endpoints are offloaded.
> maybe usb class driver could register an "offloader" with xhci for a usb 
> device.
> 
> Trying to figure out what this xhci offload API would look like.
> The dsp needs at least dma address of an event ring, and offloaded 
> endpoint rings.
> Is there anything else that the dsp would directly need to take care of, 
> or can
> we just export some xhci functions for starting/stopping endpoints, and 
> update event deq?
> 

I'm still working it out with Albert as well to see what they actually 
require, and if "hooking" into these XHCI apis is really necessary.  I 
wouldn't follow the path of hooking into existing XHCI APIs either, 
since I'm sure most of it will be duplicate code that is already done by 
the XHCI drivers.  I'll follow up a bit more to get a better 
understanding, or if Albert wants to chime in here that would be helpful 
also, so everyone is on the same page.

In the QC implementation, we only need the transfer and event ring 
address, skipping pending events in the secondary event ring (similar to 
update event deq), and starting/stopping eps.  Exporting APIs would work 
for us.

Thanks
Wesley Cheng

