Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9436E7067F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjEQMWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjEQMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:22:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADFC10E3;
        Wed, 17 May 2023 05:22:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HAfIQO026608;
        Wed, 17 May 2023 12:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VH3BAU8yMCKUjeIJzmvqNEkSoCKB5EctEPu7seW1iaw=;
 b=CSqdyTbSCXRGkh1UvjXRXWjkFt/wy8IbjVpKF4siZf9oWz5xzGQtOxNRA/fS5Ttx8hHK
 2xrW1rxXW6zZ+2WdAKnfPsxPYoeX3wGK6aBr2LnlgEfpd4oJ01khEGkTVz6lx9GBxWUt
 0Z/ROvCL3NjGsJJPhzlB/yfjz4tzMT5fMkrCxlN2APDaJmIMM9zmuF0kUosq47ytlw2V
 88eUfPHFciaU33oEN1jkDBe/DED/5OT0vaXoSgN41EbIxew5WpAjFAQhyKZPOZ9tRNmA
 AzGezx+1HhPltwG+XXFkahIapqw/mO3LgCs4bJNIB6KffQZsVLPz0ZXVyPGpoUP0T9oA bA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmjadhfwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:21:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34HCLuoU032384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:21:56 GMT
Received: from [10.216.29.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 17 May
 2023 05:21:49 -0700
Message-ID: <82a8c414-bfa8-5066-fb68-1ac117b76c4e@quicinc.com>
Date:   Wed, 17 May 2023 17:51:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <ZGNy6FvVrBjYmorz@hovoldconsulting.com>
 <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
 <ZGSDr08h3Go1Dk8C@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZGSDr08h3Go1Dk8C@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IGMLd6dNygQmYRaaa3mNHUlReZRUdCyB
X-Proofpoint-GUID: IGMLd6dNygQmYRaaa3mNHUlReZRUdCyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170101
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 1:05 PM, Johan Hovold wrote:

>>> You should not make another copy of xhci_find_next_ext_cap(), but rather
>>> use it directly.
>>>
>>> We already have drivers outside of usb/host using this function so it
>>> should be fine to do the same for now:
>>>
>>> 	#include "../host/xhci-ext-caps.h"
> 
>>     This was the approach which we followed when we first introduced the
>> patch [1]. But Thinh suggested to duplicate code so that we can avoid
>> any dependency on xhci (which seems to be right). So since its just one
>> function, I duplicated it here.
> 
> Ok, fair enough. I still think we should not be duplicating the
> xhci definitions like this even if we were to copy the helper to avoid
> any future dependencies on xhci (it's currently an inline function,
> which is also not very nice).
> 
> I'll take closer look at the rest of the series as there are a few more
> of these layering violations which we should try to avoid.
> 
>>>> +	offset = dwc3_xhci_find_next_ext_cap(regs, 0,
>>>> +					XHCI_EXT_CAPS_PROTOCOL);
>>>> +	while (offset) {
> 
>>>> +		temp = readl(regs + offset);
>>>> +		major_revision = XHCI_EXT_PORT_MAJOR(temp);
>>>> +
>>>> +		temp = readl(regs + offset + 0x08);
> 
>>>> +		if (major_revision == 0x03) {
>>>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
>>>> +		} else if (major_revision <= 0x02) {
>>>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
>>>> +		} else {
>>>> +			dev_err(dwc->dev,
>>>> +				"Unrecognized port major revision %d\n", major_revision);
> 
>>> Perhaps this should be handles as in xhci core by simply warning and
>>> continuing instead.
>>>
>> I broke the loop and went to unmap as we are not sure what values would
>> be read. Any use of continuing ?
> 
> Mostly to align with xhci core which currently handles this case. It
> would not not work unless you get rid of the max-ports check below
> though.
>   
>>>> +			ret = -EINVAL;
>>>> +			goto unmap_reg;
>>>> +		}
>>>> +
>>>> +		offset = dwc3_xhci_find_next_ext_cap(regs, offset,
>>>> +						XHCI_EXT_CAPS_PROTOCOL);
>>>> +	}
>>>> +
>>>> +	temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
>>>> +	if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + dwc->num_usb2_ports)) {
>>>> +		dev_err(dwc->dev,
>>>> +			"Mismatched reported MAXPORTS (%d)\n", HCS_MAX_PORTS(temp));
>>>> +		ret = -EINVAL;
>>>> +		goto unmap_reg;
>>>> +	}
>>>
>>> Not sure this is needed either.
>>>
>>> Could this risk regressing platforms which does not have currently have
>>> all PHYs described in DT?
>>>
>> No, it doesn't. AFAIK, this only tells how many ports are present as per
>> the core consultant configuration of the device. I tried to explain what
>> would happen incase phy's are not present in DT in [2] & [3].
> 
> Right, whether the PHYs are described in DT is not directly related to
> this.
> 
> As long as HCS_MAX_PORTS by definition (assumption) is always
> (dwc->num_usb3_ports + dwc->num_usb2_ports) any such machines would
> continue to work.
> 
> But if you want to catch machines where this assumption does not hold,
> you could also end up regressing machines which have so far been working
> despite these numbers not adding up.
> 
> That may be acceptable, but I'm still not sure what the value of this
> check is (e.g. as xhci core will handle basic sanity checks like usb2 +
> usb3 <= max_ports).
> 

Hi Johan,

   Thanks for the review comments. Ideally the HCC_PARAMS1 must indicate 
total number of ports supported. If not then I believe the core 
consultant configuration is wrong.

According to the spec:

"The MaxPorts value in the HCSPARAMS1 register defines the number of
Port Register Sets (e.g. PORTSC, PORTPMSC, and PORTLI register sets)."

So shouldn't the (usb2+usb3 ports be equal to MaxPorts to ensure each 
port properly accesses the respective PortSC etc., ?

Do we have any machines today that support HOST_ONLY_CONFIG indicated in 
HWPARAMS0 that support multiport and violate this rule ?

Regards,
Krishna,
