Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36CF68CC81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBGCOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBGCOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:14:50 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A432E40;
        Mon,  6 Feb 2023 18:14:49 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3170tPVG019555;
        Tue, 7 Feb 2023 02:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HIZqz72hdsGvvVsRL2vVOjvEDEzV7j2IvRzfKDCGvHk=;
 b=Z3vnHnNtAP9RPgBUE7rldF39FOQLZ5QPx5KEnpxO2QVa4qH0SBsAI2W4Emp773LGb43f
 orWXHFjRH+z5mTSXosi/P+y2xoNa9VIG2TbptZXBQmaz1FCG8oeNAGXsj229954V8PsU
 R7EGAQTGSRLdkleuJCHO378tAZlkKWmpGPCBJYDPa22LHPrXgromeGpk7nLqSIrNUeX1
 7k/C32hVdKaa0Lil0nXrUMPKSRY18W7Q2arWnybT3EuVj3SPHswW3Dvne7qLN3Ffp1j+
 QaVgiZrrN7vvwPAMTahAYs6xFfZ5KpGd71pmbL/uhxPLVKKCaWpgSlkL+cqT3H13nk3c +g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhd2qd9sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 02:14:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3172EitL018588
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 02:14:44 GMT
Received: from [10.110.22.31] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 18:14:43 -0800
Message-ID: <06343334-b3e1-004d-954e-93b3cf022079@quicinc.com>
Date:   Mon, 6 Feb 2023 18:14:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 0/5] Add function suspend/resume and remote wakeup
 support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <20230207012412.m2imw4bodu7ehvn4@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230207012412.m2imw4bodu7ehvn4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: F2vtPbXbuTg_M9U89mm3D7_vKDAySdp4
X-Proofpoint-GUID: F2vtPbXbuTg_M9U89mm3D7_vKDAySdp4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070019
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 5:24 PM, Thinh Nguyen wrote:
> Hi Elson,
> 
> On Mon, Feb 06, 2023, Elson Roy Serrao wrote:
>> Changes in v3
>>   - Modified rw_capable flag to reflect the gadgets capability for wakeup
>>     signalling.
>>   - Added a check to configure wakeup bit in bmAttributes only if gadget
>>     is capable of triggering wakeup.
>>   - Implemented a gadget op for composite layer to inform UDC whether device
>>     is configured for remote wakeup.
>>   - Added a check in __usb_gadget_wakeup() API to trigger wakeup only if the
>>     device is configured for it.
>>   - Cosmetic changes in dwc3_gadget_func_wakeup() API.
>>
>> Changes in v2
>>   - Added a flag to indicate whether the device is remote wakeup capable.
>>   - Added an async parameter to _dwc3_gadget_wakeup() API and few cosmetic
>>     changes.
>>   - Added flags to reflect the state of  function suspend and function remote
>>     wakeup to usb_function struct rather than function specific struct (f_ecm).
>>   - Changed the dwc3_gadget_func__wakeup() API to run synchronously by first
>>     checking the link state and then sending the device notification. Also
>>     added debug log for DEVICE_NOTIFICATION generic cmd.
>>   - Added changes to arm the device for remotewakeup/function remotewakeup
>>     only if device is capable.
>>
>> An usb device can initate a remote wakeup and bring the link out of
>> suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
>> To achieve this an interface can invoke gadget_wakeup op and wait for the
>> device to come out of LPM. But the current polling based implementation
>> fails if the host takes a long time to drive the resume signaling specially
>> in high speed capable devices. Switching to an interrupt based approach is
>> more robust and efficient. This can be leveraged by enabling link status
>> change events and triggering a gadget resume when the link comes to active
>> state.
>>
>> If the device is enhanced super-speed capable, individual interfaces can
>> also be put into suspend state. An interface can be in function suspend
>> state even when the device is not in suspend state. Function suspend state
>> is retained throughout the device suspend entry and exit process.
>> A function can be put to function suspend through FUNCTION_SUSPEND feature
>> selector sent by the host. This setup packet also decides whether that
>> function is capable of initiating a function remote wakeup. When the
>> function sends a wakeup notification to the host the link must be first
>> brought to a non-U0 state and then this notification is sent.
>>
>> This change adds the infrastructure needed to support the above
>> functionalities.
>>
>> Elson Roy Serrao (5):
>>    usb: gadget: Properly configure the device for remote wakeup
>>    usb: dwc3: Add remote wakeup handling
>>    usb: gadget: Add function wakeup support
>>    usb: dwc3: Add function suspend and function wakeup support
>>    usb: gadget: f_ecm: Add suspend/resume and remote wakeup support
>>
>>   drivers/usb/dwc3/core.h               |   5 ++
>>   drivers/usb/dwc3/debug.h              |   2 +
>>   drivers/usb/dwc3/ep0.c                |  16 ++---
>>   drivers/usb/dwc3/gadget.c             | 110 +++++++++++++++++++++++++++++++---
>>   drivers/usb/gadget/composite.c        |  50 +++++++++++++++-
>>   drivers/usb/gadget/function/f_ecm.c   |  68 +++++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.c |  63 +++++++++++++++++++
>>   drivers/usb/gadget/function/u_ether.h |   4 ++
>>   drivers/usb/gadget/udc/core.c         |  46 ++++++++++++++
>>   drivers/usb/gadget/udc/trace.h        |   5 ++
>>   include/linux/usb/composite.h         |   6 ++
>>   include/linux/usb/gadget.h            |  12 ++++
>>   12 files changed, 371 insertions(+), 16 deletions(-)
>>
>> -- 
>> 2.7.4
>>
> 
> Hi Elson,
> 
> Thanks for your patches! I provided some comments. Hopefully they can be
> merged soon.
> 
> Thanks,
> Thinh

Hi Thinh

Thank you for your feedback/comments. I will address them in v4.

Regards
Elson
