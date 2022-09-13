Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851095B7C13
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 22:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIMUN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 16:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIMUNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 16:13:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AAE642D3;
        Tue, 13 Sep 2022 13:13:20 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DK75ng006556;
        Tue, 13 Sep 2022 20:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=49KeXqPoP7h/oTPt48zIFHKnx7IP+rO7dPB/K703Y0M=;
 b=LgQwq52Wz9b120Vw2uBZs6jcv/OQdLl641ZpIGQom9weVEXg+ZKOyRatUjZZyllDtIiV
 nDlF1dFEeUsrzII7s826funCXR7bXGGjNPCGgYfszplafdXnC2ZAYYJafKAHh1h8+Yhk
 Y05mruigbnTkDDc2qQBTFFP5z+ZRfv3uB8b4ZBNa8s0F8T/uagH2EiLz9adlGWnSaaf0
 VunqKZ3hi8hbZIg3Ccp2x9bSm3219eSlJBpjH4ECsb3A3MGrc36Fbo3v3xo10k5Bm1Jj
 IXCpW/clLMs0/tOrdkGJlXVX2WGkkvaM/AiplqUpc7xau5I+F6wOVBAmMUbUFE/JTlO5 HQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyu88sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 20:13:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DKDEPJ005566
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 20:13:14 GMT
Received: from [10.110.6.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 13:13:13 -0700
Message-ID: <3edfc616-1b6f-98f3-79f8-be208ae9a738@quicinc.com>
Date:   Tue, 13 Sep 2022 13:13:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] usb: gadget: Add function wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_mrana@quicinc.com" <quic_mrana@quicinc.com>
References: <ac8e012f-08f3-baed-ead0-231f0527864c@synopsys.com>
 <b123b543-6c82-2787-9730-addd3e6e70a3@quicinc.com>
 <98966b47-0bc5-6ec0-ec80-5eff1d71d9fd@synopsys.com>
 <e3bcfd4c-efdb-c7b0-4e94-1afcd3b8eb73@synopsys.com>
 <1fac4c0f-4e8b-f333-7208-c50353a806f4@synopsys.com>
 <dc5cdba3-fcbc-79a2-797e-2553c727cba5@quicinc.com>
 <6e8de558-7183-d3f1-9ba7-83a612675e17@synopsys.com>
 <e22d4f8e-0ca7-056e-e5ec-4fc97cbaf08b@quicinc.com>
 <20220823010056.5yvd6223awab47vl@synopsys.com>
 <281aae0d-6146-bf65-cf23-2ddf7e16ae1c@quicinc.com>
 <20220826013021.xrvhi3xrgyz2dkin@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20220826013021.xrvhi3xrgyz2dkin@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JXmVpO9MMLUr19sr6Gp1_XDli3JesPSJ
X-Proofpoint-ORIG-GUID: JXmVpO9MMLUr19sr6Gp1_XDli3JesPSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1011 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130093
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2022 6:30 PM, Thinh Nguyen wrote:
> On Tue, Aug 23, 2022, Elson Serrao wrote:
>> On 8/22/2022 6:01 PM, Thinh Nguyen wrote:
>>> On Thu, Aug 18, 2022 at 11:17:24AM -0700, Elson Serrao wrote:
>>>>
>>>>
>>>> On 8/16/2022 4:51 PM, Thinh Nguyen wrote:
>>>>> On 8/16/2022, Elson Serrao wrote:
>>>>>>
>>>>>>
>>>>>> On 8/12/2022 5:46 PM, Thinh Nguyen wrote:
>>>>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>>>>> On 8/11/2022, Thinh Nguyen wrote:
>>>>>>>>> On 8/11/2022, Elson Serrao wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 8/9/2022 6:08 PM, Thinh Nguyen wrote:
>>>>>>>>>
>>>>>>>>> <snip>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> To summarize the points:
>>>>>>>>>>>
>>>>>>>>>>> 1) The host only arms function remote wakeup if the device is
>>>>>>>>>>> capable of
>>>>>>>>>>> remote wakeup (check USB_CONFIG_ATT_WAKEUP in bmAttributes and
>>>>>>>>>>> hardware
>>>>>>>>>>> capability)
>>>>>>>>>>>
>>>>>>>>>>> 2) If the device is in suspend, the device can do remote wakeup
>>>>>>>>>>> (through
>>>>>>>>>>> LFPS handshake) if the function is armed for remote wakeup (through
>>>>>>>>>>> SET_FEATURE(FUNC_SUSPEND)).
>>>>>>>>>>>
>>>>>>>>>>> 3) If the link transitions to U0 after the device triggering a remote
>>>>>>>>>>> wakeup, the device will also send device notification function
>>>>>>>>>>> wake for
>>>>>>>>>>> all the interfaces armed with remote wakeup.
>>>>>>>>>>>
>>>>>>>>>>> 4) If the device is not in suspend, the device can send device
>>>>>>>>>>> notification function wake if it's in U0.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Now, remote wakeup and function wake device notification are 2
>>>>>>>>>>> separate
>>>>>>>>>>> operations. We have the usb_gadget_ops->wakeup() for remote wakeup. I
>>>>>>>>>>> suggested to maybe add
>>>>>>>>>>> usb_gadget_ops->send_wakeup_notification(gadget,
>>>>>>>>>>> intf_id) for the device notification. What you did was combining both
>>>>>>>>>>> operations in usb_gadget_ops->func_wakeup(). That may only work for
>>>>>>>>>>> point 4) (assuming you fix the U0 check), but not point 3).
>>>>>>>>>>
>>>>>>>>>> Thank you for your feedback and summary. I will rename func_wakeup to
>>>>>>>>>> send_wakeup_notification to better align with the approach. The
>>>>>>>>>> reason I
>>>>>>>>>> have combined remote_wakeup and function wake notification in
>>>>>>>>>> usb_gadget_ops->func_wakeup() is because since the implementation
>>>>>>>>>> is at
>>>>>>>>>> function/composite level it has no knowledge on the link state. So I
>>>>>>>>>> have delegated that task to controller driver to handle the
>>>>>>>>>> notification
>>>>>>>>>> accordingly. That is do a LFPS handshake first if the device is
>>>>>>>>>> suspended and then send notification (explained below). But we can
>>>>>>>>>> definitely separate this by adding an additional flag in the composite
>>>>>>>>>> layer to set the link state based on the gadget suspend callback
>>>>>>>>>> called
>>>>>>>>>> when U3 SUSPEND interrupt is received. Let me know if you feel
>>>>>>>>>> separating the two is a better approach.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The reason I think we need to separate it is because of point 3. As I
>>>>>>>>> note earlier, the spec states that "If remote wake event occurs in
>>>>>>>>> multiple functions, each function shall send a Function Wake
>>>>>>>>> Notification."
>>>>>>>>>
>>>>>>>>> But if there's no remote wake event, and the host brought the device up
>>>>>>>>> instead, then the function suspend state is retained.
>>>>>>>>>
>>>>>>>>> If we separate these 2 operations, the caller can check whether the
>>>>>>>>> operation went through properly. For example, if the wakeup() is
>>>>>>>>> initiated properly, but the function wake device notification didn't go
>>>>>>>>> through. We would only need to resend the device notification rather
>>>>>>>>> than initiate remote wakeup again.
>>>>>>>>
>>>>>>>> If we don't have to send device notification for other interfaces, we
>>>>>>>> can combine the operations here as you did.
>>>>>>>>
>>>>>>>
>>>>>>> I still think it's better to split up the operations. The way you're
>>>>>>> handling it now is not clear.
>>>>>>>
>>>>>>> If the func_awake() returns -EAGAIN, I'd expect that the remote wake did
>>>>>>> not go through and expect user to retry again. But here it does initiate
>>>>>>> remote wake, but it just does not send device notification yet. This is
>>>>>>> confusing.
>>>>>>>
>>>>>>> Also, instead of all the function wake handling coming from the function
>>>>>>> driver, now we depend on the controller driver to call function resume()
>>>>>>> on state change to U0, which will trigger device notification. What
>>>>>>> happen if it doesn't call resume(). There's too many dependencies and it
>>>>>>> seems fragile.
>>>>>>>
>>>>>>> I think all this can be handled in the function driver. You can fix the
>>>>>>> dwc3 wakeup() and poll for U0/ON state rather than RECOVERY state, which
>>>>>>> is what it's supposed to poll.
>>>>>>
>>>>>> For transitioning from U3 to U0, the current upstream implementation is
>>>>>> to poll for U0 state when dwc3_gadget_wakeup() is called and it is a
>>>>>> blocking call. (this is a common API for both HS and SS)
>>>>>>
>>>>>>        /* poll until Link State changes to ON */
>>>>>>        retries = 20000;
>>>>>>
>>>>>>        while (retries--) {
>>>>>>            reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>>>>>>
>>>>>>            /* in HS, means ON */
>>>>>>            if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
>>>>>>                break;
>>>>>>        }
>>>>>>
>>>>>> In my experiments I found that certain hosts take longer time to drive
>>>>>> HS resume signalling between the remote wakeup and the resume K and this
>>>>>> time varies across hosts. Hence the above polling timer is not generic
>>>>>> across hosts. So how do we converge on a polling timer value to work
>>>>>> across HS/SS and without blocking the system for a long time?
>>>>>
>>>>> Can't we take the upper limit of both base on experiment? And it
>>>>> shouldn't be blocking the whole system.
>>>>
>>>> On the host I was experimenting with, the time it took was around 110ms in
>>>> HS case. That would translate to a retry count of about ~181,000 in the
>>>> above polling loop. Wouldn't that be a very large value for polling?
>>>> And not sure if there are other hosts that take even longer time
>>>
>>> We don't want to poll that many times. We shouldn't depend on the delay
>>> of a register read for polling interval. Can't we just sleep in between
>>> interval at a reasonable interval.
>>>
>>
>> Sleeping is not an option as the upper layers (those beyond
>> function/composite layer) may transmit data with a lock held.
>>
> 
> You can use mdelay() if it can't sleep. But if the wait is long, it
> should be allowed to sleep.
> 
>> I ran into below BUG when remote wakeup was triggered via a ping() command
>> and attempted sleep while polling
>>
>> [   88.676789][  T392] BUG: scheduling while atomic
>> [   88.900112][  T392] Call trace:
>> <snip>
>> [   88.912760][  T392]  __schedule_bug+0x90/0x188
>> [   88.917335][  T392]  __schedule+0x714/0xb4c
>> [   88.930568][  T392]  schedule+0x110/0x204
>> [   88.943620][  T392]  schedule_timeout+0x94/0x134
>> [   88.948371][  T392]  __dwc3_gadget_wakeup+0x1ac/0x558
>> [   88.953558][  T392]  dwc3_gadget_wakeup+0x3c/0x8c
>> [   88.958388][  T392]  usb_gadget_wakeup+0x54/0x1a8
>> [   88.963222][  T392]  eth_start_xmit+0x130/0x830
>> [   88.967876][  T392]  xmit_one+0xf0/0x364
>> [   88.971913][  T392]  sch_direct_xmit+0x188/0x3e4
>> [   88.976663][  T392]  __dev_xmit_skb+0x480/0x984
>> [   88.981319][  T392]  __dev_queue_xmit+0x2d4/0x7d8
>> [   88.986151][  T392]  neigh_resolve_output+0x208/0x2f0
>> <snip>
>>
>> The above experiment was done by removing spin_locks if any in the wakeup()
>> path of  function/composite/controller drivers. It is running in atomic
>> context due to the lock held by linux networking stack/generic packet
>> scheduler.
>>
>> So below are the only two approaches I can think of for dwc3_gadget_wakeup()
>> API
>>
>> 1.)Polling based approach: We poll until the link comes up. But cannot sleep
>> while polling due to above reasons.
>>
>> 2.)Interrupt based approach (the patches being discussed currently): When a
>> remote wakeup is triggered enable link state interrupts and return right
>> away. The function/composite drivers are later notified about the ON event
>> via resume callback (in a similar way how we notify U3 to composite layer
>> via suspend callback).
>>
>> Please let me know if there is any alternate way that you can think of here.
>>
> 
> The main issue we're trying to solve is knowing if the host had woken up
> and the device notification is sent so that the function driver can
> resume().
> 
> If we can say that upon usb_gadget_wakeup() successful completion, the
> link is in U0/ON, then the function driver can send the wake
> notification after and resume(). That is, we're trying to make
> usb_gadget_wakeup() synchronous. Whether it's polling or interrupt
> based, it's implementation detail.
> 
> Unfortunately, the API isn't very clear whether usb_gadget_wakeup() may
> sleep or synchronous.
> 
> Here are 3 approaches that we can have:
> 
> 1) Clarify that usb_gadget_wakeup() is synchronous and the link will be
> in U0/ON upon successful completion, and clarify whether it can sleep.
> Introduce a separate API usb_gadget_send_wake_notification() to send
> wake notification separately.
> 
> 2) Create a new API usb_gadget_function_wakeup() that will combine both
> device wakeup and wake notification. The function can sleep,
> synchronous, and both wakeup and wake notification are done after the
> function completes.
> 
> 3) Create a new API usb_gadget_function_wakeup() that will combine both
> device wakeup and wake notification. The function is asynchronous. We
> won't know if the wakeup is successfully sent, but we don't care and
> proceed with the function proceed with resume() anyway.
> 
> BR,
> Thinh

Thank you for your suggestions.
For handling function wakeup (applicable to enhanced super-speed) will 
implement a separate API usb_gadget_function_wakeup() that combines 
device-wakeup and wake-notification like below in dwc3 driver and 
operates synchronously.

dwc3_gadget_func_wakeup()
{
	if (link in U3)
		Call dwc3_gadget_wakeup()
		Poll for U0
		
	
	If U0 successful, send wake_notification

}

Once the function completes both device wake and func wakeup 
notification are done.

For high speed use-cases when usb_gadget_wakeup() is called from 
function drivers, considering the possibility of significant delay 
associated with remote wakeup, dwc3_gadget_wakeup() should operate 
asynchronously.
i.e rely on link status change events rather than sleeping/polling.

Please let me know if there are any concerns. If not will upload new 
patch sets with this change and other changes suggested.

Regards
Elson


> 
> 
>>>>>
>>>>>>
>>>>>> Some data layers like TCP/IP hold a TX lock while sending data (that
>>>>>> causes a remote wakeup event) and hence this wakeup() may run in atomic
>>>>>> context.
>>>>>
>>>>> Why hold the lock while waiting for the host to wakeup? The host is
>>>>> still inactive. Also, the usb_gadget_wakeup() API doesn't specify that
>>>>> it may run in atomic context.
>>>>>
>>>>
>>>> The lock might be held by upper layers who are unaware/independent of
>>>> underlying transport medium. The above TX lock I was referring to was
>>>> that held by Linux networking stack. It just pushes out data the same way it
>>>> would when USB is active. It is the function/composite layer being aware of
>>>> the function suspend would now sense this as a remote wake event and perform
>>>> this additional step of bringing out the link from u3 and then sending
>>>> device wakeup notification.
>>>>
>>>> In our current upstream implementation of dwc3_gadget_wakeup() API we hold a
>>>> spinlock as well. But yeah that can be rectified
>>>
>>> Holding a spin_lock for this long is not reasonable. We only need to
>>> lock when setting link recovery request but not while polling for DSTS
>>> and waiting for the link to go up.
>>>
>>> BR,
>>> Thinh
>>>
>>>>
>>>> static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>>> {
>>>> 	struct dwc3		*dwc = gadget_to_dwc(g);
>>>> 	unsigned long		flags;
>>>> 	int			ret;
>>>>
>>>> 	spin_lock_irqsave(&dwc->lock, flags);
>>>> 	ret = __dwc3_gadget_wakeup(dwc);
>>>> 	spin_unlock_irqrestore(&dwc->lock, flags);
>>>>
>>>> 	return ret;
>>>> }
>>>>
>>>>
>>>>>>
>>>>>> To make this generic across hosts, I had switched to interrupt based
>>>>>> approach, enabling link state events and return error value immediately
>>>>>> from the dwc3_gadget_wakeup() API after doing a LFPS handshake. But
>>>>>> yeah, then we have to rely on the resume callback as an indication that
>>>>>> link is transitioned to ON state.
>>>>>>
>>>>>
>>>>> BR,
>>>>> Thinh
