Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FE16F63D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 06:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjEDEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 00:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEDEFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 00:05:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162919B3;
        Wed,  3 May 2023 21:05:52 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3443bnvT009809;
        Thu, 4 May 2023 04:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=hLEHg/VgyoVWUtfiaUwN3sbjiwBGQclOpEtLS7pUm8E=;
 b=g481d1HNP31j8XhT/fQRhQ/j4+kO25jWPEIHesjWBYwvo7tUJqTM97njAOh+Fb3sojAb
 M895eMj6uEhokNOfoaEeRqjzspTV3T+IbPgQYllJkN4aWHte78nI4RcnRtU7kVdbWR+w
 MmQs2LbKpnKU2+pXqX1wDbl82gmK7MiAR/f9yZt2w1334wWw4GYTxVzoEf1rZ0OdWW8f
 p9yG19Lda/ZOcvAhlA7J1usS/puwVnMlI2sB3mVvVTqypUrHiOCzmmlTKLh3scLDYIu3
 ynwWYKq0UErEY5yGL+QbdSn0PMVhmmSufuDN/jJaarimmLDlcMkfaOwWZJNvv9iauhnx eg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbruvsh3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 May 2023 04:05:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34445cEA025980
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 May 2023 04:05:38 GMT
Received: from [10.216.20.183] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 3 May 2023
 21:05:32 -0700
Message-ID: <9c451432-a2ce-fdc1-d831-b7a5c9c731ab@quicinc.com>
Date:   Thu, 4 May 2023 09:35:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "quic_pkondeti@quicinc.com" <quic_pkondeti@quicinc.com>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_harshq@quicinc.com" <quic_harshq@quicinc.com>,
        "ahalaney@redhat.com" <ahalaney@redhat.com>,
        "quic_shazhuss@quicinc.com" <quic_shazhuss@quicinc.com>
References: <20230501143445.3851-1-quic_kriskura@quicinc.com>
 <20230501143445.3851-4-quic_kriskura@quicinc.com>
 <20230502214133.fovxi3vfh2s6ujpz@synopsys.com>
 <2b60b5cd-df7e-0686-cdcb-4a7ccac360cf@quicinc.com>
 <20230503214926.x76cb5p2neaie2hq@synopsys.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230503214926.x76cb5p2neaie2hq@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MbBzIu8oUd2WQQ0wrdG6Yskcrcmxvn0D
X-Proofpoint-ORIG-GUID: MbBzIu8oUd2WQQ0wrdG6Yskcrcmxvn0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_01,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305040033
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 3:19 AM, Thinh Nguyen wrote:
> On Wed, May 03, 2023, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 5/3/2023 3:11 AM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Mon, May 01, 2023, Krishna Kurapati wrote:
>>>> Currently host-only capable DWC3 controllers support Multiport.
>>>> Temporarily map XHCI address space for host-only controllers and parse
>>>> XHCI Extended Capabilities registers to read number of usb2 ports and
>>>> usb3 ports present on multiport controller. Each USB Port is at least HS
>>>> capable.
>>>>
>>>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>>>> and num_usb3_ports. The intention is as follows:
>>>>
>>>> Wherever we need to perform phy operations like:
>>>>
>>>> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
>>>> {
>>>> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>>>> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>>>> }
>>>>
>>>> If number of usb2 ports is 3, loop can go from index 0-2 for
>>>> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
>>>> if the first 2 ports are SS capable or some other ports like (2 and 3)
>>>> are SS capable. So instead, num_usb2_ports is used to loop around all
>>>> phy's (both hs and ss) for performing phy operations. If any
>>>> usb3_generic_phy turns out to be NULL, phy operation just bails out.
>>>>
>>>> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
>>>> phy's as we need to know how many SS capable ports are there for this.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/core.c | 68 +++++++++++++++++++++++++++++++++++++++++
>>>>    drivers/usb/dwc3/core.h | 58 +++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 126 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>>> index 0beaab932e7d..b8ac7bcee391 100644
>>>> --- a/drivers/usb/dwc3/core.c
>>>> +++ b/drivers/usb/dwc3/core.c
>>>> @@ -1767,6 +1767,59 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>>>    	return 0;
>>>>    }
>>>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>>>> +{
>>>> +	void __iomem		*regs;
>>>> +	u32			offset;
>>>> +	u32			temp;
>>>> +	u8			major_revision;
>>>> +	int			ret = 0;
>>>> +
>>>> +	/*
>>>> +	 * Remap xHCI address space to access XHCI ext cap regs,
>>>> +	 * since it is needed to get port info.
>>>> +	 */
>>>> +	regs = ioremap(dwc->xhci_resources[0].start,
>>>> +				resource_size(&dwc->xhci_resources[0]));
>>>> +	if (IS_ERR(regs))
>>>> +		return PTR_ERR(regs);
>>>> +
>>>> +	offset = dwc3_xhci_find_next_ext_cap(regs, 0,
>>>> +					XHCI_EXT_CAPS_PROTOCOL);
>>>> +	while (offset) {
>>>> +		temp = readl(regs + offset);
>>>> +		major_revision = XHCI_EXT_PORT_MAJOR(temp);
>>>> +
>>>> +		temp = readl(regs + offset + 0x08);
>>>> +		if (major_revision == 0x03) {
>>>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
>>>> +		} else if (major_revision <= 0x02) {
>>>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
>>>> +		} else {
>>>> +			dev_err(dwc->dev, "port revision seems wrong\n");
>>>
>>> Can we print this instead:
>>> 	dev_err(dwc->dev, "Unrecognized port major revision %d\n", major_revision);
>>>
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
>>>> +		dev_err(dwc->dev, "inconsistency in port info\n");
>>>
>>> Can we print this instead:
>>> 	dev_err(dwc->dev, "Mismatched reported MAXPORTS (%d)\n", HCS_MAX_PORTS(temp));
>>>
>>>> +		ret = -EINVAL;
>>>> +		goto unmap_reg;
>>>> +	}
>>>> +
>>>> +	dev_dbg(dwc->dev,
>>>> +		"hs-ports: %d ss-ports: %d\n", dwc->num_usb2_ports, dwc->num_usb3_ports);
>>>> +
>>>> +unmap_reg:
>>>> +	iounmap(regs);
>>>> +	return ret;
>>>> +}
>>>> +
>>>>    static int dwc3_probe(struct platform_device *pdev)
>>>>    {
>>>>    	struct device		*dev = &pdev->dev;
>>>> @@ -1774,6 +1827,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>    	void __iomem		*regs;
>>>>    	struct dwc3		*dwc;
>>>>    	int			ret;
>>>> +	unsigned int		hw_mode;
>>>>    	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>>>>    	if (!dwc)
>>>> @@ -1843,6 +1897,20 @@ static int dwc3_probe(struct platform_device *pdev)
>>>>    			goto err_disable_clks;
>>>>    	}
>>>> +	/*
>>>> +	 * Currently DWC3 controllers that are host-only capable
>>>> +	 * support Multiport
>>>> +	 */
>>>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>>>> +		ret = dwc3_read_port_info(dwc);
>>>> +		if (ret)
>>>> +			goto err_disable_clks;
>>>> +	} else {
>>>> +		dwc->num_usb2_ports = 1;
>>>> +		dwc->num_usb3_ports = 1;
>>>> +	}
>>>> +
>>>>    	spin_lock_init(&dwc->lock);
>>>>    	mutex_init(&dwc->mutex);
>>>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>>>> index d56457c02996..21312703e053 100644
>>>> --- a/drivers/usb/dwc3/core.h
>>>> +++ b/drivers/usb/dwc3/core.h
>>>> @@ -35,6 +35,17 @@
>>>>    #define DWC3_MSG_MAX	500
>>>> +/* Define XHCI Extcap register offsets for getting multiport info */
>>>> +#define XHCI_HCC_PARAMS_OFFSET	0x10
>>>> +#define DWC3_XHCI_HCSPARAMS1	0x04
>>>> +#define XHCI_EXT_CAPS_PROTOCOL	2
>>>> +#define XHCI_HCC_EXT_CAPS(x)    (((x) >> 16) & 0xffff)
>>>> +#define XHCI_EXT_CAPS_ID(x)     (((x) >> 0) & 0xff)
>>>> +#define XHCI_EXT_CAPS_NEXT(x)   (((x) >> 8) & 0xff)
>>>> +#define XHCI_EXT_PORT_MAJOR(x)  (((x) >> 24) & 0xff)
>>>> +#define XHCI_EXT_PORT_COUNT(x)  (((x) >> 8) & 0xff)
>>>> +#define HCS_MAX_PORTS(x)        (((x) >> 24) & 0x7f)
>>>> +
>>>>    /* Global constants */
>>>>    #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
>>>>    #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
>>>> @@ -1025,6 +1036,8 @@ struct dwc3_scratchpad_array {
>>>>     * @usb_psy: pointer to power supply interface.
>>>>     * @usb2_phy: pointer to USB2 PHY
>>>>     * @usb3_phy: pointer to USB3 PHY
>>>> + * @num_usb2_ports: number of usb2 ports.
>>>> + * @num_usb3_ports: number of usb3 ports.
>>>>     * @usb2_generic_phy: pointer to USB2 PHY
>>>>     * @usb3_generic_phy: pointer to USB3 PHY
>>>>     * @phys_ready: flag to indicate that PHYs are ready
>>>> @@ -1162,6 +1175,9 @@ struct dwc3 {
>>>>    	struct usb_phy		*usb2_phy;
>>>>    	struct usb_phy		*usb3_phy;
>>>> +	u32			num_usb2_ports;
>>>> +	u32			num_usb3_ports;
>>>
>>> can we use u8?
>>>
>>>> +
>>>>    	struct phy		*usb2_generic_phy;
>>>>    	struct phy		*usb3_generic_phy;
>>>> @@ -1650,4 +1666,46 @@ static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
>>>>    { }
>>>>    #endif
>>>> +/**
>>>> + * dwc3_xhci_find_next_ext_cap - Find the offset of the extended capabilities
>>>> + *					with capability ID id.
>>>> + *
>>>> + * @base	PCI MMIO registers base address.
>>>> + * @start	address at which to start looking, (0 or HCC_PARAMS to start at
>>>> + *		beginning of list)
>>>> + * @id		Extended capability ID to search for, or 0 for the next
>>>> + *		capability
>>>
>>> I know that this is a duplicate from the xhci driver, but can we fix the
>>> kerneldoc style as in other places if we're going to keep it?
>>>
>>
>> Hi Thinh,
>>
>>   Isn't this same as other functions ?
>>
>> /**
>>   * <function name> - description
>>   * @params
>>   *
>>   */
>>
>> I missed the function name in comments last time, but added it in this
>> version.
>>
>> Checkpatch too didn't give any errors/warnings other than alignment. Can you
>> help point out any other mistake in this function doc/comments so that I can
>> fix it in next version.
>>
> 
> It's missing ":" after @params.
> 
> You can use the kernel-doc script to check for documentation's
> errors/warnings.
> 
> Here's the output if you run the following command:
> # <KERNEL_SRC>/scripts/kernel-doc -none -Werror -function dwc3_xhci_find_next_ext_cap drivers/usb/dwc3/core.h
> 
> drivers/usb/dwc3/core.h:1684: warning: Function parameter or member 'base' not described in 'dwc3_xhci_find_next_ext_cap'
> drivers/usb/dwc3/core.h:1684: warning: Function parameter or member 'start' not described in 'dwc3_xhci_find_next_ext_cap'
> drivers/usb/dwc3/core.h:1684: warning: Function parameter or member 'id' not described in 'dwc3_xhci_find_next_ext_cap'
> 3 warnings as Errors
> 
> 
> This is a minor style issue. While I don't think it's strictly needed to
> follow the kerneldoc style for a non-api function. But if we do follow
> it, we should do it correctly.
> 
> Thanks,
> Thinh

Thanks Thinh for pointing it out. Will fix this in the next version.

Regards,
Krishna,
