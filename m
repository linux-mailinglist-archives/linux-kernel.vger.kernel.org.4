Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D6A705DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjEQDL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjEQDLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:11:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BD51BF6;
        Tue, 16 May 2023 20:11:15 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34H2qki3031180;
        Wed, 17 May 2023 03:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZfZldtV00oMqJfRNaBglSCNdTe6CxYY9T6fSsvVe/eo=;
 b=ckYlXMUxLVAzlK7d2LJz0y6MPOnb3XAcQJwn71D6npszIKec4pQOwNN9XkOIgGdU4R8m
 zXmI+A/bzxpF/QPP3saMEzjn6fRr3Dn6fP09gYGB7Kaxzm6LiJafksWnvFDosce5MvV3
 zxsbeIdrqP/hDh6AngZKJ98l78T7GvZibI2Y7sT6Lt0L7f0rCfyL0lgn+5A+nsbOGlxz
 iPXlECKTU7ERY0YSUTKqFW5lbwFxhNudln8WpsWgiEFn5WAFX+jKvLT0OLQ0Dqnegd0g
 Bv6o/Zis72CFj73+2LSNV3Oqyv7lor6q/SaQQ7Oj1uAbqzV8NVIX4C3ECtKNBtSPl+Pi Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qmbk79ceg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:11:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34H3Asx9007178
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 03:10:54 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 16 May
 2023 20:10:48 -0700
Message-ID: <cacc5813-404a-c2ef-e768-20f2acd696d9@quicinc.com>
Date:   Wed, 17 May 2023 08:40:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
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
Content-Language: en-US
In-Reply-To: <b2954b92-8b12-700a-af50-b914af7b0ace@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BVyr8UUyyVeryjXvGK61Tlq_KYVW82Zl
X-Proofpoint-ORIG-GUID: BVyr8UUyyVeryjXvGK61Tlq_KYVW82Zl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170025
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 8:32 PM, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/16/2023 5:41 PM, Johan Hovold wrote:
>> On Sun, May 14, 2023 at 11:19:11AM +0530, Krishna Kurapati wrote:
>>> Currently host-only capable DWC3 controllers support Multiport.
>>> Temporarily map XHCI address space for host-only controllers and parse
>>> XHCI Extended Capabilities registers to read number of usb2 ports and
>>> usb3 ports present on multiport controller. Each USB Port is at least HS
>>> capable.
>>>
>>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>>> and num_usb3_ports. The intention is as follows:
>>>
>>> Wherever we need to perform phy operations like:
>>>
>>> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
>>> {
>>>     phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>>>     phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>>> }
>>>
>>> If number of usb2 ports is 3, loop can go from index 0-2 for
>>> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
>>> if the first 2 ports are SS capable or some other ports like (2 and 3)
>>> are SS capable. So instead, num_usb2_ports is used to loop around all
>>> phy's (both hs and ss) for performing phy operations. If any
>>> usb3_generic_phy turns out to be NULL, phy operation just bails out.
>>>
>>> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
>>> phy's as we need to know how many SS capable ports are there for this.
>>>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>>   drivers/usb/dwc3/core.c | 113 ++++++++++++++++++++++++++++++++++++++++
>>>   drivers/usb/dwc3/core.h |  17 +++++-
>>>   2 files changed, 129 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 0beaab932e7d..e983aef1fb93 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1767,6 +1767,104 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>>       return 0;
>>>   }
>>> +/**
>>> + * dwc3_xhci_find_next_ext_cap - Find the offset of the extended 
>>> capabilities
>>> + *                    with capability ID id.
>>> + *
>>> + * @base:    PCI MMIO registers base address.
>>> + * @start:    address at which to start looking, (0 or HCC_PARAMS to 
>>> start at
>>> + *        beginning of list)
>>> + * @id:        Extended capability ID to search for, or 0 for the next
>>> + *        capability
>>> + *
>>> + * Returns the offset of the next matching extended capability 
>>> structure.
>>> + * Some capabilities can occur several times, e.g., the 
>>> XHCI_EXT_CAPS_PROTOCOL,
>>> + * and this provides a way to find them all.
>>> + */
>>> +static int dwc3_xhci_find_next_ext_cap(void __iomem *base, u32 
>>> start, int id)
>>> +{
>>> +    u32 val;
>>> +    u32 next;
>>> +    u32 offset;
>>> +
>>> +    offset = start;
>>> +    if (!start || start == XHCI_HCC_PARAMS_OFFSET) {
>>> +        val = readl(base + XHCI_HCC_PARAMS_OFFSET);
>>> +        if (val == ~0)
>>> +            return 0;
>>> +        offset = XHCI_HCC_EXT_CAPS(val) << 2;
>>> +        if (!offset)
>>> +            return 0;
>>> +    }
>>> +    do {
>>> +        val = readl(base + offset);
>>> +        if (val == ~0)
>>> +            return 0;
>>> +        if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == 
>>> id))
>>> +            return offset;
>>> +
>>> +        next = XHCI_EXT_CAPS_NEXT(val);
>>> +        offset += next << 2;
>>> +    } while (next);
>>> +
>>> +    return 0;
>>> +}
>>
>> You should not make another copy of xhci_find_next_ext_cap(), but rather
>> use it directly.
>>
>> We already have drivers outside of usb/host using this function so it
>> should be fine to do the same for now:
>>
>>     #include "../host/xhci-ext-caps.h"
>>
> Hi Johan,
> 
>    This was the approach which we followed when we first introduced the 
> patch [1]. But Thinh suggested to duplicate code so that we can avoid 
> any dependency on xhci (which seems to be right). So since its just one 
> function, I duplicated it here.
> 
Hi Thinh,

   Would like to know your opinion here on how to proceed further.

Regards,
Krishna,
> 
>>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>>> +{
>>> +    void __iomem        *regs;
>>
>> Call this one 'base' instead.
>>
>>> +    u32            offset;
>>> +    u32            temp;
>>
>> I see that the xhci driver use 'temp' for this, but I'd prefer 'val'.
>>
>>> +    u8            major_revision;
>>> +    int            ret = 0;
>>> +
>>> +    /*
>>> +     * Remap xHCI address space to access XHCI ext cap regs,
>>> +     * since it is needed to get port info.
>>> +     */
>>> +    regs = ioremap(dwc->xhci_resources[0].start,
>>> +                resource_size(&dwc->xhci_resources[0]));
>>> +    if (IS_ERR(regs))
>>> +        return PTR_ERR(regs);
>>> +
>>> +    offset = dwc3_xhci_find_next_ext_cap(regs, 0,
>>> +                    XHCI_EXT_CAPS_PROTOCOL);
>>> +    while (offset) {
>>
>> This would be better implemented as a do-while loop (cf.
>> xdbc_reset_debug_port()).
>>
>>> +        temp = readl(regs + offset);
>>> +        major_revision = XHCI_EXT_PORT_MAJOR(temp);
>>> +
>>> +        temp = readl(regs + offset + 0x08);
>>
>> We should try to avoid magic constants, but I see that we already have
>> cases accessing these fields like this.
>>
>>> +        if (major_revision == 0x03) {
>>> +            dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
>>> +        } else if (major_revision <= 0x02) {
>>> +            dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
>>> +        } else {
>>> +            dev_err(dwc->dev,
>>> +                "Unrecognized port major revision %d\n", 
>>> major_revision);
>>
>> Please add a line break after the string.
>>
>> Perhaps this should be handles as in xhci core by simply warning and
>> continuing instead.
>>
> I broke the loop and went to unmap as we are not sure what values would 
> be read. Any use of continuing ?
> 
>>> +            ret = -EINVAL;
>>> +            goto unmap_reg;
>>> +        }
>>> +
>>> +        offset = dwc3_xhci_find_next_ext_cap(regs, offset,
>>> +                        XHCI_EXT_CAPS_PROTOCOL);
>>> +    }
>>> +
>>> +    temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
>>> +    if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + 
>>> dwc->num_usb2_ports)) {
>>> +        dev_err(dwc->dev,
>>> +            "Mismatched reported MAXPORTS (%d)\n", 
>>> HCS_MAX_PORTS(temp));
>>> +        ret = -EINVAL;
>>> +        goto unmap_reg;
>>> +    }
>>
>> Not sure this is needed either.
>>
>> Could this risk regressing platforms which does not have currently have
>> all PHYs described in DT?
>>
> No, it doesn't. AFAIK, this only tells how many ports are present as per 
> the core consultant configuration of the device. I tried to explain what 
> would happen incase phy's are not present in DT in [2] & [3].
> 
>> You do however need to make sure that both num_usb<n>_ports is no larger
>> than MAX_PORTS_SUPPORTED to avoid memory corruption when you're adding
>> fixed sized arrays for the PHYs later in the series.
>>
>>> +
>>> +    dev_dbg(dwc->dev,
>>> +        "hs-ports: %d ss-ports: %d\n", dwc->num_usb2_ports, 
>>> dwc->num_usb3_ports);
>>
>> Use %u for unsigned values.
>>
>> And please try to stay within 80 columns.
>>
> Thanks for catching this potential bug. Will add that if check as well 
> in v9.
> 
>>> +
>>> +unmap_reg:
>>> +    iounmap(regs);
>>> +    return ret;
>>> +}
>>> +
>>>   static int dwc3_probe(struct platform_device *pdev)
>>>   {
>>>       struct device        *dev = &pdev->dev;
>>> @@ -1774,6 +1872,7 @@ static int dwc3_probe(struct platform_device 
>>> *pdev)
>>>       void __iomem        *regs;
>>>       struct dwc3        *dwc;
>>>       int            ret;
>>> +    unsigned int        hw_mode;
>>>       dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>>>       if (!dwc)
>>> @@ -1843,6 +1942,20 @@ static int dwc3_probe(struct platform_device 
>>> *pdev)
>>>               goto err_disable_clks;
>>>       }
>>> +    /*
>>> +     * Currently DWC3 controllers that are host-only capable
>>> +     * support Multiport
>>
>> Are you missing an "only" after "Currently" above?
>> > Please add a full stop.
>>
>>> +     */
>>> +    hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>> +    if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>>> +        ret = dwc3_read_port_info(dwc);
>>> +        if (ret)
>>> +            goto err_disable_clks;
>>> +    } else {
>>> +        dwc->num_usb2_ports = 1;
>>> +        dwc->num_usb3_ports = 1;
>>> +    }
>>> +
>>>       spin_lock_init(&dwc->lock);
>>>       mutex_init(&dwc->mutex);
>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>> index d56457c02996..d3401963bc27 100644
>>> --- a/drivers/usb/dwc3/core.h
>>> +++ b/drivers/usb/dwc3/core.h
>>> @@ -35,6 +35,17 @@
>>>   #define DWC3_MSG_MAX    500
>>> +/* Define XHCI Extcap register offsets for getting multiport info */
>>> +#define XHCI_HCC_PARAMS_OFFSET    0x10
>>> +#define DWC3_XHCI_HCSPARAMS1    0x04
>>> +#define XHCI_EXT_CAPS_PROTOCOL    2
>>> +#define XHCI_HCC_EXT_CAPS(x)    (((x) >> 16) & 0xffff)
>>> +#define XHCI_EXT_CAPS_ID(x)     (((x) >> 0) & 0xff)
>>> +#define XHCI_EXT_CAPS_NEXT(x)   (((x) >> 8) & 0xff)
>>> +#define XHCI_EXT_PORT_MAJOR(x)  (((x) >> 24) & 0xff)
>>> +#define XHCI_EXT_PORT_COUNT(x)  (((x) >> 8) & 0xff)
>>> +#define HCS_MAX_PORTS(x)        (((x) >> 24) & 0x7f)
>>> +
>>
>> You should use the xhci defines instead of these copies too.
>>
>>>   /* Global constants */
>>>   #define DWC3_PULL_UP_TIMEOUT    500    /* ms */
>>>   #define DWC3_BOUNCE_SIZE    1024    /* size of a superspeed bulk */
>>> @@ -1025,6 +1036,8 @@ struct dwc3_scratchpad_array {
>>>    * @usb_psy: pointer to power supply interface.
>>>    * @usb2_phy: pointer to USB2 PHY
>>>    * @usb3_phy: pointer to USB3 PHY
>>> + * @num_usb2_ports: number of usb2 ports.
>>> + * @num_usb3_ports: number of usb3 ports.
>>
>> Use upper case "USBn" and drop the full stops for consistency.
>>
>> Please move these after the PHY structures.
>>
>>>    * @usb2_generic_phy: pointer to USB2 PHY
>>>    * @usb3_generic_phy: pointer to USB3 PHY
>>>    * @phys_ready: flag to indicate that PHYs are ready
>>> @@ -1162,6 +1175,9 @@ struct dwc3 {
>>>       struct usb_phy        *usb2_phy;
>>>       struct usb_phy        *usb3_phy;
>>> +    u8            num_usb2_ports;
>>> +    u8            num_usb3_ports;
>>> +
>>>       struct phy        *usb2_generic_phy;
>>>       struct phy        *usb3_generic_phy;
>>> @@ -1649,5 +1665,4 @@ static inline int dwc3_ulpi_init(struct dwc3 *dwc)
>>>   static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
>>>   { }
>>>   #endif
>>> -
>>
>> This is an unrelated change that should be dropped.
>>
>>>   #endif /* __DRIVERS_USB_DWC3_CORE_H */
>>
>> Johan
> 
> [1]: 
> https://lore.kernel.org/all/20230310163420.7582-3-quic_kriskura@quicinc.com/
> 
> [2]: 
> https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/
> 
> [3]: 
> https://lore.kernel.org/all/966c1001-6d64-9163-0c07-96595156fc8c@quicinc.com/
> 
> Thanks for the review and comments 🙂. Will make sure to fix them in v9.
> 
> Regards,
> Krishna,
