Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6300F659214
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiL2VQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiL2VQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:16:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F101E5FF0;
        Thu, 29 Dec 2022 13:16:20 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BTKfpfY001084;
        Thu, 29 Dec 2022 21:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qIkk/qrW5WiupjGqG3RQ5ycIyhS77t9ozHsuaoUqxOc=;
 b=oIbmDuRUbURiMmZ4WYT1KTCWZrPBkxycp5FJ8IUs25NiPSwZZ4bh5g+3GW3jQjfRHOi8
 swgLrAYZJZ32RlszbK2K5xmB23P5csdb+452fJecLOTPmWce/Ojs/d+S34aCclBApdRL
 5tniJVJpubZFIO8z29AkNdvrmvchy9/6qqqXkerMNH5BUsD0I3JVWZ9EV/0iOGWVsn0i
 /5C1GgcWvFSdejJhRRL49gkWdQnkMG6FoBhbYh2nxs0SW0/gwtOIwmqc/Ti+uEX2pqy2
 eUKRkm1LjvRSmgxgf4lqSstroe9UCUUPTWGgPw8tGeAAkC2YIKxex28paE7mhSm08GQT Qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mrau43v39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Dec 2022 21:15:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BTLFIGq029699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Dec 2022 21:15:18 GMT
Received: from [10.110.125.32] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 29 Dec
 2022 13:14:43 -0800
Message-ID: <f7f80320-02bb-a573-dd95-b6d58c260624@quicinc.com>
Date:   Thu, 29 Dec 2022 13:14:43 -0800
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
        <agross@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <quic_jackp@quicinc.com>,
        <quic_plai@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-8-quic_wcheng@quicinc.com>
 <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <7dfe215b-4cc7-f95f-17c3-563c0120151a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YntXHpoCwTQ5evl0mf0Ts-VjU7LYksRk
X-Proofpoint-ORIG-GUID: YntXHpoCwTQ5evl0mf0Ts-VjU7LYksRk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-29_12,2022-12-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=859 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212290176
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

On 12/28/2022 7:47 AM, Mathias Nyman wrote:
> On 24.12.2022 1.31, Wesley Cheng wrote:
>> Implement the XHCI operations for allocating and requesting for a 
>> secondary
>> interrupter.  The secondary interrupter can allow for events for a
>> particular endpoint to be routed to a separate event ring.  The event
>> routing is defined when submitting a transfer descriptor to the USB HW.
>> There is a specific field which denotes which interrupter ring to 
>> route the
>> event to when the transfer is completed.
>>
>> An example use case, such as audio packet offloading can utilize a 
>> separate
>> event ring, so that these events can be routed to a different processor
>> within the system.  The processor would be able to independently submit
>> transfers and handle its completions without intervention from the main
>> processor.
>>
> 
> Adding support for more xHCI interrupters than just the primary one make 
> sense for
> both the offloading and virtualization cases.
> 
> xHCI support for several interrupters was probably added to support 
> virtualization,
> to hand over usb devices to virtual machines and give them their own 
> event ring and
> MSI/MSI-X vector.
> 
> In this offloading case you probably want to avoid xHC interrupts from 
> this device
> completely, making sure it doesn't wake up the main CPU unnecessarily.
> 
> So is the idea here to let xhci driver set up the new interrupter, its 
> event ring,
> and the endpoint transfer rings. Then pass the address of the endpoint 
> transfer rings
> and the new event ring to the separate processor.
> 
> This separate processor then both polls the event ring for new events, 
> sets its dequeue
> pointer, clears EHB bit, and queues new TRBs on the transfer ring.
> 
> so xhci driver does not handle any events for the audio part, and no 
> audio data URBs
> are sent to usb core?

Your entire description is correct.  To clarify, the interfaces which 
are non-audio will still be handled by the main processor.  For example, 
a USB headset can have a HID interface as well for volume control.  The 
HID interface will still be handled by the main processor, and events 
routed to the main event ring.

> 
> How about the control part?
> Is the control endpoint for this device still handled normally by usb 
> core/xhci?
> 

Control transfers are always handled on the main processor.  Only audio 
interface's endpoints.

> For the xhci parts I think we should start start by adding generic 
> support for several
> interrupters, then add parts needed for offloading.

I can split up the patchsets to add interrupters first, then adding the 
offloading APIs in a separate patch.

Thanks
Wesley Cheng
