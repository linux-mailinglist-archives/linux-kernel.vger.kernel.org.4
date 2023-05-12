Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7F700F47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238862AbjELTYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjELTYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:24:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F611D;
        Fri, 12 May 2023 12:24:00 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CEHNO9024991;
        Fri, 12 May 2023 19:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CE0GBCM0M20fvuT9XadoI7r4ryawyDopuUlc13afYpo=;
 b=mkwD1zNWLdpiHnxl58sPoqX4JfkFCVuHEi899rUIr6tHLbMc0nwNUUxEfEGwfVHsmhzi
 SwwWgLbuYnOw1GFG6D3w6uve0TKaZKFqVm+RQlF7FQL2PNa2LWbzuqOpxMLx8Tjtn7or
 jcSAJVDxSfZ8GrYW+bA/jpqVvtbJz/St0FpHJ/dKZXPklYGTMXHRWAqHnU+HmzV8+UNg
 WoHOalcIgc3n/AsIEVhD617wcjsZYSJrDMU9I5//i3bZ1AaGwcW+ovE7h+Ru5AuLnhs/
 JrEGvRP4uPxTYyODw7LoN6fQb62Z5ULKjJtPUYdbKXXG1bDjUysG0mb1eXCebE2qocag qQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qhh391gqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 19:23:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34CJNvtb009743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 19:23:57 GMT
Received: from [10.216.49.187] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 12 May
 2023 12:23:54 -0700
Message-ID: <9bd626de-fecb-c789-4b18-a2bf6e4eb427@quicinc.com>
Date:   Sat, 13 May 2023 00:53:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC] usb: dwc3: core: set force_gen1 bit in USB31 devices if max
 speed is SS
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20230512170107.18821-1-quic_kriskura@quicinc.com>
 <20230512184630.2kt4xgneiovb3vac@synopsys.com>
 <989832ad-e9b4-7c59-f157-6a9239c1b5eb@quicinc.com>
Content-Language: en-US
In-Reply-To: <989832ad-e9b4-7c59-f157-6a9239c1b5eb@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UawGu08IxymVWRKcZmfAIlOeQcDFJjQr
X-Proofpoint-ORIG-GUID: UawGu08IxymVWRKcZmfAIlOeQcDFJjQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_12,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120163
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2023 12:45 AM, Krishna Kurapati PSSNV wrote:
> Hi Thinh,
> 
> On 5/13/2023 12:16 AM, Thinh Nguyen wrote:
>> On Fri, May 12, 2023, Krishna Kurapati wrote:
>>> Currently for dwc3_usb31 devices, if maximum_speed is limited to
>>
>> We usually call the controller dwc_usb3, dwc_usb31, or dwc_usb32.
>>
>>> super-speed in DT, then device mode is limited to SS, but host mode
>>> still works in SSP.
>>>
>>> The documentation for max-speed property is as follows:
>>>
>>> "Tells USB controllers we want to work up to a certain speed.
>>> Incase  this isn't passed via DT, USB controllers should default to
>>> their maximum HW capability."
>>>
>>> It doesn't specify that the property is only for device mode.
>>
>> Since this isn't really a fix, can we rephrase the lines below
>>
>>> Fix this by forcing controller supported max speed to Gen1 by
>>> setting LLUCTL.Force_Gen1 bit if controller is DWC3_USB31 and
>>> max speed is mentioned as SS in DT.
>>
>> As follow:
>> There are cases where we need to limit the host's maximum speed to
>> SuperSpeed only. Use this property for host mode to contrain host's
>> speed to SuperSpeed.
>>
>>
> Sure, will rephrase it accordingly. Thanks for the suggestion.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>> Discussion regarding the same at:
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/__;!!A4F2R9G_pg!YiQpjZIJAw-yu6gEwbKqb5nusjnKQ9dQJrulx39lQP-7JMhcNA2xd8uLJoZ_HE8SuG4Rm2uvhJTSdQ2k0fJVAxU2RWYHHg$
>>>
>>>   drivers/usb/dwc3/core.c | 13 +++++++++++++
>>>   drivers/usb/dwc3/core.h |  4 ++++
>>>   2 files changed, 17 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 0beaab932e7d..989dc76ecbca 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -116,6 +116,18 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>>>       dwc->current_dr_role = mode;
>>>   }
>>> +static void dwc3_configure_host_speed(struct dwc3 *dwc)
>>> +{
>>> +    u32 reg;
>>> +
>>> +    if (DWC3_IP_IS(DWC31) &&
>>> +       (dwc->maximum_speed == USB_SPEED_SUPER)) {
>>> +        reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
>>> +        reg |= DWC3_LLUCTL_FORCE_GEN1;
>>> +        dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
>>> +    }
>>> +}
>>> +
>>>   static void __dwc3_set_mode(struct work_struct *work)
>>>   {
>>>       struct dwc3 *dwc = work_to_dwc(work);
>>> @@ -194,6 +206,7 @@ static void __dwc3_set_mode(struct work_struct 
>>> *work)
>>>       switch (desired_dr_role) {
>>>       case DWC3_GCTL_PRTCAP_HOST:
>>> +        dwc3_configure_host_speed(dwc);
>>  > The LLUCTL doesn't change until there's a Vcc reset. Let's just> 
> initialize it once during dwc3_core_init() if the GHWPARAM indicates the
>> controller is DRD or host only.
>>
> 
> I thought GCTL Core soft reset might clear this bit. That is why I 
> placed it here. For device mode gadget.c takes care of limiting speed. 
> So wanted to do this setting only for host mode, before we invoke host 
> init.
> 
> Thanks for letting know that only VCC reset affects this. Will move this 
> check to core init.
> 
> Regards,
> Krishna,
> 

In fact, The following snippet from programming guide is why I thought 
GCTL reset can affect this register: ( the below is from usb3 prog 
guide, I assume this would be applicable for usb31 as well)

Fields for Register: GCTL
Core Soft Reset (CoreSoftReset)
■ 1'b0 - No soft reset
■ 1'b1 - Soft reset to controller

  Clears the interrupts and all the CSRs except the following
registers:
■ GCTL
■ GUCTL
■ GSTS
■ GSNPSID
■ GGPIO
■ GUID
■ GUSB2PHYCFGn registers
■ GUSB3PIPECTLn registers
■ DCFG
■ DCTL
■ DEVTEN
■ DSTS

If so, don't we need to do this setting after every GCTL core soft reset ?

Regards,
Krishna,

>>>           ret = dwc3_host_init(dwc);
>>>           if (ret) {
>>>               dev_err(dwc->dev, "failed to initialize host\n");
>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>> index d56457c02996..29b780a58dc6 100644
>>> --- a/drivers/usb/dwc3/core.h
>>> +++ b/drivers/usb/dwc3/core.h
>>> @@ -121,6 +121,10 @@
>>>   #define DWC3_GPRTBIMAP_FS0    0xc188
>>>   #define DWC3_GPRTBIMAP_FS1    0xc18c
>>>   #define DWC3_GUCTL2        0xc19c
>>> +#define DWC3_LLUCTL        0xd024
>>
>> Please place the register according to its offset order.
>>
>>> +
>>> +/* Force Gen1 speed on Gen2 link */
>>> +#define DWC3_LLUCTL_FORCE_GEN1    BIT(10)
>>>   #define DWC3_VER_NUMBER        0xc1a0
>>>   #define DWC3_VER_TYPE        0xc1a4
>>> -- 
>>> 2.40.0
>>>
>>
>> Thanks,
>> Thinh
