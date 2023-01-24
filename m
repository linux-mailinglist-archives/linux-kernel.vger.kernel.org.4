Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83926678DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAXBmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXBmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:42:16 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C988B3525E;
        Mon, 23 Jan 2023 17:42:15 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O1CSWw017692;
        Tue, 24 Jan 2023 01:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pjjFKnCvA08j7aYDULcXn6dMRAmfj/JNUH2Evtj8u68=;
 b=HKMxOCaYbIW27RPKuTKE2tqbkRaH6FBlTc/spuraZucEN+74VruESiGN8IrAaSBra2h0
 Y62mX4BkxD7J7oo8VKp/SHsIJgO3sB5ZxQVRDwEANYYroROOFoAIGBrxIAQbyoaBx6Zr
 yeX7apRidzNF7wvi5qATys751vPzXIUK4wRCK19Mp/4gEuux9wf3f5zuP7+DOj8vf4my
 SEYf2ovSVETIAtgr+AtYUKvxaIE1GdkJt9eEriwEaLVGRzFQ0FqXn48J1iOzHwcYKvHP
 QaBZMu+/HP8SrWhEBjdN2BRWb3cExXJjkVs4/2tIWaUuu+oWJbaqZ2BfNJAjAdBkATEt VQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89dr4435-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 01:42:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O1g9Wg028454
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 01:42:09 GMT
Received: from [10.110.97.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 17:42:09 -0800
Message-ID: <20a4679a-5d62-79dd-f819-bb2829d8881a@quicinc.com>
Date:   Mon, 23 Jan 2023 17:42:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
 <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
 <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
 <20230121021219.udgpwt7tv7dfr3jk@synopsys.com>
 <20230123193320.sxywht5vr3sig2ur@synopsys.com>
 <dae761af-6db4-f611-21c9-122fda74c5b6@quicinc.com>
 <20230123230229.l7uie4tnfzvvgkq3@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230123230229.l7uie4tnfzvvgkq3@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hXOmI00NnaSEaA4lnt-em2r5M_6a5NAy
X-Proofpoint-ORIG-GUID: hXOmI00NnaSEaA4lnt-em2r5M_6a5NAy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=633 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301240011
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 3:02 PM, Thinh Nguyen wrote:
> On Mon, Jan 23, 2023, Elson Serrao wrote:
>>
>>
>> On 1/23/2023 11:33 AM, Thinh Nguyen wrote:
>>> On Sat, Jan 21, 2023, Thinh Nguyen wrote:
>>>> On Fri, Jan 20, 2023, Alan Stern wrote:
>>>>> On Sat, Jan 21, 2023 at 02:02:36AM +0000, Thinh Nguyen wrote:
>>>>>> On Fri, Jan 20, 2023, Alan Stern wrote:
>>>>>>> A UDC design might have multiple versions, some supporting remote wakeup
>>>>>>> and others not.  But drivers generally use a single static
>>>>>>> usb_gadget_ops structure, and they don't modify it at runtime to account
>>>>>>> for hardware differences.  So if a single driver controls those multiple
>>>>>>> versions, you can't rely on the presence of gadget->ops->wakeup to
>>>>>>> indicate whether there actually is hardware remote wakeup support.
>>>>>>>
>>>>>>> Ideally, the usb_gadget structure should have a wakeup_capable flag
>>>>>>> which the UDC driver would set appropriately (probably during its probe
>>>>>>> routine).
>>>>>>>
>>>>>>
>>>>>> I was thinking that it can be handled by the
>>>>>> usb_gadget_enable_remote_wakeup() so we can do away with the
>>>>>> wakeup_capable flag.
>>>>>
>>>>> usb_gadget_enable_remote_wakeup() gets called when the gadget or
>>>>> function is suspended, right?  But a gadget driver may want to know long
>>>>> before that whether the UDC supports remote wakeup, in order to set up
>>>>> its config descriptor correctly.
>>>>>
>>>>
>>>> No, this is to be called during set configuration. If the configuration
>>>> doesn't support remote wakeup, the device should not be able to send
>>>> remote wakeup.
>>>>
>>>
>>> On second thought, you're right about the descriptor. It's better to
>>> warn and prevent the remote wakeup bit from being set in the descriptor
>>> if the UDC doesn't support remote wakeup. Warning the user at set
>>> configuration is too late.
>>>
>>> So, we need both rw_capable flag and usb_gadget_enable_remote_wakeup().
>>>
>>> Thanks,
>>> Thinh
>>
>> Do we need usb_gadget_enable_remote_wakeup() gadget-op ?
>> As per the discussion, we can have rw_capable flag in usb_gadget struct and
>> set it during gagdet init/probe if the UDC supports resume signalling OR
>> wants the remote wakeup feature to be enabled.
>> This flag now represents UDC capability to initiate resume signalling.
>>
>> During enumeration phase, when preparing the config descriptor we can use
>> gadget->rw_capable flag to rightly modify the remote wakeup
>> bit. Based on this, host will decide whether to arm the device for remote
>> wakeup or not.
>>
> 
> If the configuration doesn't allow remote wakeup, the device should not
> be able to send signal to wake up the host regardless whether the host
> armed the device for remote wake or not.
> 
> The rw_capable flag will inform the composite layer whether the UDC is
> capable of remote wakeup. The composite layer needs to tell the UDC
> whether the configuration allows for remote wakeup.
> 
> Whether it's usb_gadget_enable_remote_wakeup() or the remote wakeup bit
> in the bmAttribute, the composite layer needs to communicate that to the
> controller driver. But we should not expect the UDC driver to parse for
> that bit. The prepared control transfer from the the composite layer
> should be abstracted from the UDC driver.
> 
>> For gadget->ops->wakeup callback support we already have explicit checks
>> when invoking this gadget op and device wont be able to send remote wakeup
>> if callback support doesn't exist.
>> Please let me know if I am missing something.
> 
> As mentioned previously, we should also warn the user if the UDC doesn't
> support remote wakeup and prevent the remote wakeup bit being set in the
> descriptor.
> 
> Let me know if it makes sense.
> 
> Thanks,
> Thinh

Sure. That makes sense.
As discussed I will modify this patch like below
1.)gadget->rw_capable flag to represent the UDC wakeup capability. Used 
to configure/modify rw bit in bmAtrributes before sending ConfigDesc. 
Also warn the user if rw bit is set but UDC doesnt support it.

2.) usb_gadget_enable_remote_wakeup() gadget op for composite layer to 
inform UDC layer. Maintain an internal flag in UDC driver to guard 
against invoking wakeup callbacks when user has not configured for 
remote wakeup.

Thanks
Elson
