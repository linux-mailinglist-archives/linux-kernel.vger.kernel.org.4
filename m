Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE157283AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbjFHPX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjFHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:23:51 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50772D56;
        Thu,  8 Jun 2023 08:23:49 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358BnUjO006197;
        Thu, 8 Jun 2023 15:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4a/RSxU+zuiFmSF4/jq0AB0C2Mw8KLzudBVVVoWc2bs=;
 b=Vm4P/I8wqqJrptb6DYve2TuBbrjaZgkwBWikTQJlNN9CmSaZL7n+v6/2MHNrSF3JpZAA
 Mo74Inc7a8+XfipX1iow1OmMCs+sXIaxAkgGLsXMWaas6K4Xv8dL3+dcnTdhj6+FACqQ
 pYdOvrdttjC9IkS/I2FMBQNeEJ2hee3YDu/wHvhWFDvfgsT1XJeGo9ukhVnHQ2HaXMFB
 ZIB4QmbZSiJtx8nR1bmwIIgcKzmmaJGL0lyzDi/R+4hLh+PdGg4659kD7GsVOPSMNNaP
 1aYx5DYs01EHqKRGUtWg+bdEWb6uqy5JG1KDyIq9/P5EWjSNNYfpd2+IR+su5zfynaXU ew== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r31rghvx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 15:23:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358FNYiU003952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 15:23:34 GMT
Received: from [10.216.61.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 08:23:28 -0700
Message-ID: <279fff8b-57e2-cfc8-cd6d-c69d00e71799@quicinc.com>
Date:   Thu, 8 Jun 2023 20:53:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <bc347624-4539-4a3a-9399-9b4e272cdb32@quicinc.com>
 <ZGUCykpDFt9zgeTU@hovoldconsulting.com>
 <82553597-ce0e-48f4-44d4-9eeaaf4cb1c4@quicinc.com>
 <ZIBsDQJtgDZRe7MG@hovoldconsulting.com>
 <99cded6f-6a71-ffce-8479-c7c0726bfb8e@quicinc.com>
 <ZIGihYS5EacISEFm@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZIGihYS5EacISEFm@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8VVUqSMKehefe8KtqWQ9qGU-rArpE9R9
X-Proofpoint-GUID: 8VVUqSMKehefe8KtqWQ9qGU-rArpE9R9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_11,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080134
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2023 3:12 PM, Johan Hovold wrote:
> On Thu, Jun 08, 2023 at 01:21:02AM +0530, Krishna Kurapati PSSNV wrote:
>> On 6/7/2023 5:07 PM, Johan Hovold wrote:
> 
>>> So there at least two issues with this series:
>>>
>>> 	1. accessing xhci registers from the dwc3 core
>>> 	2. accessing driver data of a child device
>>>
>>> 1. The first part about accessing xhci registers goes against the clear
>>> separation between glue, core and xhci that Felipe tried to maintain.
>>>
>>> I'm not entirely against doing this from the core driver before
>>> registering the xhci platform device as the registers are unmapped
>>> afterwards. But if this is to be allowed, then the implementation should
>>> be shared with xhci rather than copied verbatim.
>>>
>>> The alternative that avoids this issue entirely could indeed be to
>>> simply count the number of PHYs described in DT as Rob initially
>>> suggested. Why would that not work?
>>>
>> The reason why I didn't want to read the Phy's from DT is explained in
>> [1]. I felt it makes the code unreadable and its very tricky to read the
>> phy's properly, so we decided we would initialize phy's for all ports
>> and if a phy is missing in DT, the corresponding member in
>> dwc->usbX_generic_phy[] would be NULL and any phy op on it would be a NOP.
> 
> That doesn't sound too convincing. Can't you just iterate over the PHYs
> described in DT and determine the maximum port number used for HS and
> SS?
>   
>> Also as per Krzysztof suggestion on [2], we can add a compatible to read
>> number of phy's / ports present. This avoids accessing xhci members
>> atleast in driver core. But the layering violations would still be present.
> 
> Yes, but if the information is already available in DT it's better to use
> it rather than re-encode it in the driver.
>   

Hi Johan,

   Are you suggesting that we just do something like
num_ports = max( highest usb2 portnum, highest usb3 port num)

If so, incase the usb2 phy of quad port controller is missing in DT, we 
would still read num_usb2_ports as 4 but the usb2_generic_phy[1] would 
be NULL and any phy ops would still be NOP. But we would be getting rid 
of reading the xhci registers compeltely in core driver.

Thinh, Bjorn, can you also let us know your views on this.

1. Read:
   num_usb3_ports = highest usb3 port index in DT
   num_usb2_ports = max( highest usb2 port index, num_usb3_ports)

2. Read the same by parsing xhci registers as done in recent versions of 
this series.

Regards,
Krishna,

>>> 2. The driver is already accessing driver data of the child device so
>>> arguably your series is not really making things much worse than they
>>> already are.
>>> >>> I've just sent a couple of fixes to address some of the symptoms of
>>> this layering violation here:
>>>
>>> 	https://lore.kernel.org/lkml/20230607100540.31045-1-johan+linaro@kernel.org/
>>>
>>
>>    As you pointed out offline to me that using xhci event notifiers I
>> mentioned on [3], if it is not acceptable to use them as notifications
>> to check whether we are in host mode, I believe the only way would be to
>> use the patches you pushed in.
> 
> I still think we'll end up using callbacks from the xhci/core into the
> glue driver, but dedicated ones rather than using usb_register_notify().
> 
> The fixes I posted can work as a stop-gap solution until then.
> 
>>> Getting this fixed properly is going to take a bit of work, and
>>> depending on how your multiport wake up implementation is going to look
>>> like, adding support for multiport controllers may not make this much
>>> harder to address.
>>>
>>> So perhaps we can indeed merge support for multiport and then get back
>>> to cleaning this up.
>> So, you are referring to use the patches you pushed today as a partial
>> way to cleanup layering violations and merge multiport on top of it ? If
>> so, I am fine with it. I can rebase my changes on top of them.
> 
> Right. A bit depending on how your wakeup implementation looks like, it
> seems we can merge multiport support and then address the layering
> issues which are already present in the driver.
> 
>> [1]:
>> https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/
>> [2]:
>> https://lore.kernel.org/all/ca729f62-672e-d3de-4069-e2205c97e7d8@linaro.org/
>> [3]:
>> https://lore.kernel.org/all/37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com/
> 
> Johan
