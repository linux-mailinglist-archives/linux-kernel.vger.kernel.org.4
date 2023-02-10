Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56641691741
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 04:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjBJDnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 22:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjBJDnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 22:43:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2501305F5;
        Thu,  9 Feb 2023 19:43:18 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A3hFUB002395;
        Fri, 10 Feb 2023 03:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6R546K2+P4BWJfRMEx/hrrFGGasKc/TNYyxZ0TrCD+k=;
 b=j0UC3onrdscRYcCvaXld3dfXIJV9JZXkeIOcqpU+dFLQrCEoJEDFedmKIY5+bo5nteGY
 YG0Q/9eIsUJhVeFGxh12YSXX6N0Q4607ZHyx2M/2i1td0KzByZWjIFUeD+8/RVZhGNN5
 S0M33nHGY7VttsX3BYJrCsPA+nzwGcZzLj57VBs2OO0WDnJjy5HJnjRuTvvuDwi/8BDK
 A1eWL9vJv7sZlDANCWneGRuOWpD5jghtq35WGsrd0wScdCYccXRYBlMY1gCOlMXT6Gmw
 s7H44MWisJBefo4irBEUCLwHkBF6QhbF4ikvBeHjYmaOf7DOdFt5A4gzfpl006s/ZLTd yQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nn5ek906s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 03:43:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A3hDrk014661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 03:43:13 GMT
Received: from [10.110.96.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 19:43:13 -0800
Message-ID: <808ca5c4-898a-dc94-6811-1d4913f6b6a8@quicinc.com>
Date:   Thu, 9 Feb 2023 19:43:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
 <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
 <20230208011017.47o7m3xt63lbih3m@synopsys.com>
 <cd143a99-f781-fd32-cad2-3df8f8c0d617@quicinc.com>
 <20230208021127.syauhdtpbyyncixr@synopsys.com>
 <28322f07-de6b-81e0-38c5-c856d5ce2dce@quicinc.com>
 <20230210022719.ktggsykndv4k7i42@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230210022719.ktggsykndv4k7i42@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Bg7aAt9ZUE5sUh6TI8nGd0_QQbU0Nec4
X-Proofpoint-GUID: Bg7aAt9ZUE5sUh6TI8nGd0_QQbU0Nec4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_17,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100031
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/2023 6:27 PM, Thinh Nguyen wrote:
> On Thu, Feb 09, 2023, Elson Serrao wrote:
>>
>>
>> On 2/7/2023 6:11 PM, Thinh Nguyen wrote:
>>> On Tue, Feb 07, 2023, Elson Serrao wrote:
>>>>
>>>>
>>>> On 2/7/2023 5:10 PM, Thinh Nguyen wrote:
>>>>> On Tue, Feb 07, 2023, Elson Serrao wrote:
>>>>>> On 2/6/2023 4:48 PM, Thinh Nguyen wrote:
>>>>>>>> +static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
>>>>>>>>      {
>>>>>>>>      	int			retries;
>>>>>>>> @@ -2296,9 +2309,14 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>>>>>>>      	link_state = DWC3_DSTS_USBLNKST(reg);
>>>>>>>>      	switch (link_state) {
>>>>>>>> +	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
>>>>>>>
>>>>>>> It's also possible to do remote wakeup in L1 for highspeed.
>>>>>>>
>>>>>>
>>>>>> The rw_configured flag here is in context of triggering remote wakeup from
>>>>>> bus suspend only.
>>>>>>
>>>>>> The remote wakeup setting for l1 in HighSpeed is controlled through LPM
>>>>>> token and overrides/ignores the config desc bmAttributes wakeup bit.
>>>>>>
>>>>>> Section 4.1 of USB2_LinkPowerMangement_ECN[final] spec "The host system sets the Remote Wake Flag parameter in this request to
>>>>>> enable or disable the addressed device
>>>>>> for remote wake from L1. The value of this flag will temporarily (while in
>>>>>> L1) override the current setting of the
>>>>>> Remote Wake feature settable by the standard Set/ClearFeature() commands
>>>>>> defined in Universal Serial Bus Specification, revision 2.0, Chapter 9."
>>>>>>
>>>>>> Please let me know if I am missing something.
>>>>>>
>>>>>
>>>>> It overrides the setting of the SetFeature request, not the device
>>>>> configuration.
>>>>>
>>>>> The rw_configured reflects the user configuration. Whether the host
>>>>> tries to enable the remote wakeup through SetFeature request or LPM
>>>>> token, the device should operate within the user configuration
>>>>> limitation.
>>>>>
>>>>> If the configuration indicates that it doesn't support remote wakeup, we
>>>>> should prevent unexpected behavior from the device. For simplicity, we
>>>>> can just return failure to wakeup for all states.
>>>>>
>>>>> Thanks,
>>>>> Thinh
>>>>
>>>> L1 entry/exit is HW controlled and the remote wakeup is conditional.(Section
>>>> 7.1/Table7.2 of dwc3 data book). Even though we block it from
>>>> SW the l1 exit will still happen from HW point of view.
>>>>
>>>> To correlate the user configuration with LPM token, I experimented by
>>>> disabling the wakeup bit in the bmAtrributes, but I still see remote wakeup
>>>> bit being set in the LPM token. From the observation it seems like there is
>>>
>>> That's because the linux xhci driver enables remote wakeup bit in its
>>> port without regard for the device configuration.
>>>
>>>> no correlation between the wakeup bit in the bmAtrributes and the wakeup bit
>>>> in the LPM token.
>>>>
>>>
>>> The host can bring the device out of L1, that's probably what you saw.
>>> The controller doesn't initiate remote wakeup by itself.
>>>
>>> Thanks,
>>> Thinh
>>
>> Actually it seems the controller is initiating a remote wakeup by itself to
>> exit from l1 when we send a STARTTRANSFER command. I did below experiment
>> when the device was in HighSpeed
>>
> 
> That's driven by the driver telling the controller to initiate remote
> wakeup and not the controller itself. When we send the START_TRANSFER
> command, the driver does remote wakeup so the host would bring the
> device to ON state so that the command can go through.
> 
> However you bring up a good point that if we prevent remote wakeup for
> L1, then we have to delay sending START_TRANSFER command until the host
> initiate resume. This would require additional enhancement to dwc3 to
> handle this scenario. For now, can we ignore this specific case when
> sending START_TRANSFER command and only check for the case when the user
> trigger remote wakeup via gadget->ops->wakeup/func_wakeup.
> 
> Thanks,
> Thinh

Sure. I will upload v4 with the suggested feedback/comments.

Thanks
Elson
