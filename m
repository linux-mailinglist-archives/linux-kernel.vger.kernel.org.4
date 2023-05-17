Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25602705E12
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjEQDZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjEQDZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:25:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3089010E9;
        Tue, 16 May 2023 20:25:54 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H10EEJ026322;
        Wed, 17 May 2023 03:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MsK57kLP8OlAcYdzoiWT7LGPM8O5+0M9U/BUV8nfrDg=;
 b=MOPWREPEHSCiGfbwumfBUu+ccxmbsUQaQ+wObWqgrLyfUtxkCpBiLRykaYLsqLJZRzET
 JwxxyYjO+8D5aNYQ0P2eZcjFpQMMkNsojqaf8rLK7HXNWqILcrsnzOt9IaF6P2pR1bcR
 Y66rmwqo7NZOzwHCzJ25RhWE+MYFhFRGU76/YiFDET9E6dhphCFJ9+rrUB5olLNpYFI/
 0lV2CgljQ6KUHp96LAuWOwezLn9uxhRC7UFknE2AEpNmG1fXYHf4htYx/T/GdguHCbwX
 hFdFt+wG+VLF6AL5esO9sQLrE4KvsBB59LQzf/RiOpG7Wv65TSkZy0NAzm746nuA/6Hw eg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qm36n2gtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:25:51 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34H3PouK016304
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:25:50 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 20:25:47 -0700
Message-ID: <f8882cef-0dfd-affc-1409-5cf0fcaad320@quicinc.com>
Date:   Wed, 17 May 2023 08:55:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] usb: dwc3: core: set force_gen1 bit in USB31 devices
 if max speed is SS
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230514145118.20973-1-quic_kriskura@quicinc.com>
 <20230517001105.v74dyo6asqtcrpii@synopsys.com>
 <20230517003037.i7hsg6k5fn4eyvgf@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230517003037.i7hsg6k5fn4eyvgf@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v4CFkk6aQ48-iI8XiXRQI0TfoKtWa5EJ
X-Proofpoint-ORIG-GUID: v4CFkk6aQ48-iI8XiXRQI0TfoKtWa5EJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170028
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/2023 6:00 AM, Thinh Nguyen wrote:
> On Wed, May 17, 2023, Thinh Nguyen wrote:
>> On Sun, May 14, 2023, Krishna Kurapati wrote:
>>> Currently for dwc3_usb31 controller, if maximum_speed is limited to
>>> super-speed in DT, then device mode is limited to SS, but host mode
>>> still works in SSP.
>>>
>>> The documentation for max-speed property is as follows:
>>>
>>> "Tells USB controllers we want to work up to a certain speed.
>>> Incase  this isn't passed via DT, USB controllers should default to
>>> their maximum HW capability."
>>>
>>> It doesn't specify that the property is only for device mode.
>>> There are cases where we need to limit the host's maximum speed to
>>> SuperSpeed only. Use this property for host mode to contrain host's
>>> speed to SuperSpeed.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>> Link to v1: https://urldefense.com/v3/__https://lore.kernel.org/all/20230512170107.18821-1-quic_kriskura@quicinc.com/__;!!A4F2R9G_pg!dCg_3WK2oNXNb6d0a_VuyjkeeZJTU1aY4dik6g35XB7mtG7EJeR1uPMfxFja49OfXp7Yhsg1yqjnylCYYEg7YCAhqfAZ0Q$
>>>
>>> Discussion regarding the same at:
>>> https://urldefense.com/v3/__https://lore.kernel.org/all/e465c69c-3a9d-cbdb-d44e-96b99cfa1a92@quicinc.com/__;!!A4F2R9G_pg!dCg_3WK2oNXNb6d0a_VuyjkeeZJTU1aY4dik6g35XB7mtG7EJeR1uPMfxFja49OfXp7Yhsg1yqjnylCYYEg7YCDRLUrJWg$
>>>
>>>   drivers/usb/dwc3/core.c | 8 ++++++++
>>>   drivers/usb/dwc3/core.h | 5 +++++
>>>   2 files changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 278cd1c33841..33bc72595e74 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1262,6 +1262,14 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>>   		}
>>>   	}
>>>   
>>> +	if ((hw_mode != DWC3_GHWPARAMS0_MODE_GADGET) &&
>>> +	    (DWC3_IP_IS(DWC31)) &&
>>> +	    (dwc->maximum_speed == USB_SPEED_SUPER)) {
>>> +		reg = dwc3_readl(dwc->regs, DWC3_LLUCTL);
>>> +		reg |= DWC3_LLUCTL_FORCE_GEN1;
>>> +		dwc3_writel(dwc->regs, DWC3_LLUCTL, reg);
>>> +	}
>>> +
>>
>> Perhaps this should be done for every usb3 port rather than just the
>> port_0. This patch can go after your multi-port series is added to
>> Greg's branch where you can check for number of usb3 ports.
>>
> 
> Can you also add dwc_usb32 settings? It should look something like this:
> 
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 0beaab932e7d..4bd2564aa163 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1262,6 +1262,40 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   		}
>   	}
>   
> +	if (hw_mode != DWC3_GHWPARAMS0_MODE_GADGET) {
> +		int i;
> +
> +		if (DWC3_IP_IS(DWC31) &&
> +		    dwc->maximum_speed == USB_SPEED_SUPER) {
> +			for (i = 0; i < dwc->num_usb3_ports; i++) {
> +				reg = dwc3_readl(dwc->regs, DWC3_LLUCTL(i));
> +				reg |= DWC3_LLUCTL_FORCE_GEN1;
> +				dwc3_writel(dwc->regs, DWC3_LLUCTL(i), reg);
> +			}
> +		}
> +
> +		if (DWC3_IP_IS(DWC32) &&
> +		    dwc->max_ssp_rate != USB_SSP_GEN_2x2) {
> +			int lsr_speed = -EINVAL;
> +
> +			if (dwc->maximum_speed == USB_SPEED_SUPER)
> +				lsr_speed = DWC3_LCSR_GEN_1x1;
> +			else if (dwc->max_ssp_rate == USB_SSP_GEN_2x1)
> +				lsr_speed = DWC3_LCSR_GEN_2x1;
> +			else if (dwc->max_ssp_rate == USB_SSP_GEN_1x2)
> +				lsr_speed = DWC3_LCSR_GEN_1x2;
> +
> +			if (lsr_speed != -EINVAL) {
> +				for (i = 0; i < dwc->num_usb3_ports; i++) {
> +					reg = dwc3_readl(dwc->regs, DWC3_LCSR_USB32CTL(i));
> +					reg &= ~DWC3_LCSR_USB32CTL_SPEED_MASK;
> +					reg |= lsr_speed;
> +					dwc3_writel(dwc->regs, DWC3_LCSR_USB32CTL(i), reg);
> +				}
> +			}
> +		}
> +	}
> +
>   	return 0;
>   
>   err_power_off_phy:
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index d56457c02996..415e0215fe00 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -170,6 +170,9 @@
>   #define DWC3_OEVTEN		0xcc0C
>   #define DWC3_OSTS		0xcc10
>   
> +#define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
> +#define DWC3_LCSR_USB32CTL(n)	(0xd07c + ((n) * 0x80))
> +
>   /* Bit fields */
>   
>   /* Global SoC Bus Configuration INCRx Register 0 */
> @@ -653,6 +656,16 @@
>   #define DWC3_OSTS_VBUSVLD		BIT(1)
>   #define DWC3_OSTS_CONIDSTS		BIT(0)
>   
> +/* LLUCTL Register */
> +#define DWC3_LLUCTL_FORCE_GEN1		BIT(10)
> +
> +/* LCSR_USB32CTL Register */
> +#define DWC3_LCSR_USB32CTL_SPEED_MASK	0x3
> +#define DWC3_LCSR_GEN_1x1		0
> +#define DWC3_LCSR_GEN_1x2		1
> +#define DWC3_LCSR_GEN_2x1		2
> +#define DWC3_LCSR_GEN_2x2		3
> +
>   /* Structures */
>   
>   struct dwc3_trb;
> 
>   --
> 
>   Thanks,
>   Thinh


Hi Thinh,

  Sure, will split it up into two patches and send as a series. But 
might need your help in testing SSP patch as I don't have any device 
supporting ssp.

Regards,
Krishna,
