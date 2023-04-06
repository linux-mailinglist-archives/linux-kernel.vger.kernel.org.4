Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A23E6D8B7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 02:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDFAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 20:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjDFAKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 20:10:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42761FEF;
        Wed,  5 Apr 2023 17:10:39 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335NUsPg010438;
        Thu, 6 Apr 2023 00:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=a0wpQ1EA8QNyIE3C7KSz1CqdjvCoEWSBpomxXUJOLhU=;
 b=VuOn6hpq+mODuwmnFhRQwuQQrF9qt5bDuneXcCG+hdIIhXnf9P2CSykpPhqgV6d6H6+e
 HNG9LXQur6MSeyQMfrZwqvVlcQATFvhwjBAY8qeprdnLQS1Y2vZMcKjHXKmNGpxn2c49
 61lS9Fa2ejO6Y1rJ/xUyPYuDm/NK47PHweVcO/SFDTmy5DxPgGh4XnPjr8ptvxp3mcUV
 XOKW23w7CaPIrncahoafRcjv0GBlZrgwU+YPgfylrDnjShXrMl6NcZjoDfWTbgtxNQiP
 nRBneZX9E6y1BqWC6wb505VftUv8FmLj942zJiP80OoR0s90NKK2ZW3yelSxpbjUbQ4o qg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ps6vf9p1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 00:10:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3360AZlg012489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Apr 2023 00:10:35 GMT
Received: from [10.110.86.223] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 5 Apr 2023
 17:10:35 -0700
Message-ID: <9a542032-2d2c-3241-6414-f92d5596c222@quicinc.com>
Date:   Wed, 5 Apr 2023 17:10:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230331232039.1407-1-quic_wcheng@quicinc.com>
 <20230404011108.727htmnllj7ojwqm@synopsys.com>
 <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
 <20230404221648.5fbajncfhd6wxkku@synopsys.com>
 <f1ff2346-0fd5-2e77-044c-9dc95cd5683f@quicinc.com>
 <20230405184943.fajtjau2dcgylg25@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230405184943.fajtjau2dcgylg25@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BuumjwMpa7JiqvpOfTMpUrT4FTXOhheO
X-Proofpoint-ORIG-GUID: BuumjwMpa7JiqvpOfTMpUrT4FTXOhheO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050216
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 4/5/2023 11:49 AM, Thinh Nguyen wrote:
> On Tue, Apr 04, 2023, Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 4/4/2023 3:16 PM, Thinh Nguyen wrote:
>>> On Tue, Apr 04, 2023, Wesley Cheng wrote:
>>>> Hi Thinh,
>>>>
>>>> On 4/3/2023 6:11 PM, Thinh Nguyen wrote:
>>>>> On Fri, Mar 31, 2023, Wesley Cheng wrote:
>>>>>> It was observed that there are hosts that may complete pending SETUP
>>>>>> transactions before the stop active transfers and controller halt occurs,
>>>>>> leading to lingering endxfer commands on DEPs on subsequent pullup/gadget
>>>>>> start iterations.
>>>>>
>>>>> Can you clarify this a bit further? Even though the controller is
>>>>> halted, you still observed activity?
>>>>>
>>>>
>>>> Yes...I didn't understand how that was possible either, but traces clearly
>>>> showed that the controller halt was successful even though there were no
>>>> endxfers issued on some EPs.  Although, I can't say for certain if those EPs
>>>> were actively being used at that time.
>>>>
>>>
>>> The controller should only be halted after the (non-ep0) endpoints are
>>> disabled.
>>>
>>> "even though there were no endxferx issued on some EPs", which EPs are
>>> you referring to? If there's no End Transfer issued while the endpoints
>>> are active and started during disconnect, we need to fix that in the
>>> driver.
>>>
>>
>> Sorry let me clarify.  When I said there were no endxfers issued, I meant
>> that they were pending (DWC3_EP_DELAY_STOP is set for those EPs).  However,
>> since the host wasn't moving the EP0 state forward, we never moved back to
>> the SETUP phase, which is where we flush any pending end transfers.
>>
>> void dwc3_ep0_out_start(struct dwc3 *dwc)
>> {
>> ...
>> 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
>> 		struct dwc3_ep *dwc3_ep;
>>
>> 		dwc3_ep = dwc->eps[i];
>> 		if (!dwc3_ep)
>> 			continue;
>>
>> 		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
>> 			continue;
>>
>> 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
>> 		if (dwc->connected)
>> 			dwc3_stop_active_transfer(dwc3_ep, true, true);
>> 		else
>> 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
>> 	}
>> }
>>
>> This is part of the reason for moving the wait_for_completion() call until
>> AFTER the stop active transfers, since that is the point at which we could
>> potentially set the DWC3_EP_DELAY_STOP.  If there is a host not moving the
>> EP0 state, then we can at least utilize the timeout path to force EP0 back
>> to the setup phase.
>>
> 
> Thanks for the clarification. If I understand correctly, the issue here
> is the missing handling of the timeout of the wait for control transfer
> completion. This can happen if we enter flow control and/or if the host
> delays polling for data. If it times out, then we'll have problems as
> you mention above.
> 
> In that case, we can halt the control endpoint causing it to respond
> with a STALL to the next host polling of data, cancelling the control
> transfer. This is what you did with dwc3_ep0_reset_state() on timeout
> right?
> 

Yep, that is correct.  In addition, I also made sure to call gadget stop 
at the end of the soft disconnect API, since we wanted to still service 
EP0 events while polling for the controller halt, right?  If we call 
gadget stop, then we clear the event enable register, so no events are 
going to occur:

static void __dwc3_gadget_stop(struct dwc3 *dwc)
{
	dwc3_gadget_disable_irq(dwc);
	__dwc3_gadget_ep_disable(dwc->eps[0]);
	__dwc3_gadget_ep_disable(dwc->eps[1]);
}

static void dwc3_gadget_disable_irq(struct dwc3 *dwc)
{
	/* mask all interrupts */
	dwc3_writel(dwc->regs, DWC3_DEVTEN, 0x00);
}

I think I'll split this change up as well from the timeout related one.

> I think this should work as the End Transfer commands should complete
> before the controller is halted.
> 

Yes, anyway we poll for the halted status, and in the changes for the 
endxfer timeouts we increased the poll time to allow for them to complete.

Thanks
Wesley Cheng

