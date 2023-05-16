Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8137E704348
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjEPCNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEPCM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:12:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775944231;
        Mon, 15 May 2023 19:12:57 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FNwNWv017179;
        Tue, 16 May 2023 02:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=IfBpWeTUqHrY+m2Ib7tKz8KW2RADJluoWpEKi17h5RA=;
 b=FFNKDk9cxyp4TQ/Z7cdkhslpgPSNJoAFdhDhs9YJ2s5c2oRU+m85Gz7L5p1fa19AJhkD
 gtd1JxXQBBfH+ZQyz0pPb+kYJcQzdpI/ABp7/UEJniJHHIAj40+63JeEZeX5B0Cg4ODy
 tHmhfK9E52GVaTJz0Zu3KBjfO9H9puEIIsR/zFlbIcU0CuFLpYaLnubiKSZO7A+G75Ap
 iEXlw+tYFgezQb2xMD10pqGRBfqA5EgCR0FntLGgXGvCVXF27CnOk1JBQrA2yM7W99MH
 7UAXeF2mqCsa9EIJ+9xWdNUE36jXfn2VHRg+5bAvF3DwZqz2BfN31oHViIZylaMbbAj8 Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjwdt0x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:12:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G2Cf8L006644
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:12:41 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 19:12:35 -0700
Message-ID: <d70ffe46-7282-b81e-1929-90902dd10feb@quicinc.com>
Date:   Tue, 16 May 2023 07:42:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 3/9] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-4-quic_kriskura@quicinc.com>
 <20230515210826.gwvmyrxrtt6yjc44@ripper>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230515210826.gwvmyrxrtt6yjc44@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6nMR75ESquNv7a4yfzueB5TOyHHvm47B
X-Proofpoint-GUID: 6nMR75ESquNv7a4yfzueB5TOyHHvm47B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160016
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 2:38 AM, Bjorn Andersson wrote:
> On Sun, May 14, 2023 at 11:19:11AM +0530, Krishna Kurapati wrote:
>> Currently host-only capable DWC3 controllers support Multiport.
>> Temporarily map XHCI address space for host-only controllers and parse
>> XHCI Extended Capabilities registers to read number of usb2 ports and
>> usb3 ports present on multiport controller. Each USB Port is at least HS
>> capable.
>>
>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>> and num_usb3_ports. The intention is as follows:
>>
>> Wherever we need to perform phy operations like:
>>
>> LOOP_OVER_NUMBER_OF_AVAILABLE_PORTS()
>> {
>> 	phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>> 	phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>> }
>>
>> If number of usb2 ports is 3, loop can go from index 0-2 for
>> usb2_generic_phy. If number of usb3-ports is 2, we don't know for sure,
>> if the first 2 ports are SS capable or some other ports like (2 and 3)
>> are SS capable. So instead, num_usb2_ports is used to loop around all
>> phy's (both hs and ss) for performing phy operations. If any
>> usb3_generic_phy turns out to be NULL, phy operation just bails out.
>>
>> num_usb3_ports is used to modify GUSB3PIPECTL registers while setting up
>> phy's as we need to know how many SS capable ports are there for this.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 113 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/dwc3/core.h |  17 +++++-
>>   2 files changed, 129 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 0beaab932e7d..e983aef1fb93 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1767,6 +1767,104 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>   	return 0;
>>   }
>>   
>> +/**
>> + * dwc3_xhci_find_next_ext_cap - Find the offset of the extended capabilities
>> + *					with capability ID id.
> 
> () after function name in kernel-doc
> 
>> + *
>> + * @base:	PCI MMIO registers base address.
> 
> Should this be "XHCI MMIO..."?

Hi Bjorn,

   I copied this code from xhci-ext-caps.h. The documentation of this 
function mentioned PCI in that file. May be Thinh/Mathias can correct us 
if this is wrong.

> 
>> + * @start:	address at which to start looking, (0 or HCC_PARAMS to start at
>> + *		beginning of list)
>> + * @id:		Extended capability ID to search for, or 0 for the next
>> + *		capability
>> + *
>> + * Returns the offset of the next matching extended capability structure.
> 
> Return: The offset...
> 
> Per https://www.kernel.org/doc/html/next/doc-guide/kernel-doc.html.
> 

I executed the following command and it didn't give any errors:

./scripts/kernel-doc -none -Werror -function dwc3_xhci_find_next_ext_cap 
drivers/usb/dwc3/core.c

I see that even for dwc3_core_init the comments are the same:

/**
* dwc3_core_init - Low-level initialization of DWC3 Core
* @dwc: Pointer to our controller context structure
*
* Returns 0 on success otherwise negative errno.
*/

>> + * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
>> + * and this provides a way to find them all.
>> + */
>> +static int dwc3_xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
>> +{
>> +	u32 val;
>> +	u32 next;
>> +	u32 offset;
>> +
>> +	offset = start;
>> +	if (!start || start == XHCI_HCC_PARAMS_OFFSET) {
>> +		val = readl(base + XHCI_HCC_PARAMS_OFFSET);
>> +		if (val == ~0)
>> +			return 0;
>> +		offset = XHCI_HCC_EXT_CAPS(val) << 2;
>> +		if (!offset)
>> +			return 0;
>> +	}
>> +	do {
>> +		val = readl(base + offset);
>> +		if (val == ~0)
>> +			return 0;
>> +		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
>> +			return offset;
>> +
>> +		next = XHCI_EXT_CAPS_NEXT(val);
>> +		offset += next << 2;
>> +	} while (next);
>> +
>> +	return 0;
>> +}
>> +
>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>> +{
>> +	void __iomem		*regs;
>> +	u32			offset;
>> +	u32			temp;
>> +	u8			major_revision;
>> +	int			ret = 0;
> 
> Please drop the spacing between type and variable name here, if nothing
> else it's inconsistent with the previous function.
> 

Sure, will fix this nit.

Thanks,
Krishna,
>> +
>> +	/*
>> +	 * Remap xHCI address space to access XHCI ext cap regs,
>> +	 * since it is needed to get port info.
>> +	 */
>> +	regs = ioremap(dwc->xhci_resources[0].start,
>> +				resource_size(&dwc->xhci_resources[0]));
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +
>> +	offset = dwc3_xhci_find_next_ext_cap(regs, 0,
>> +					XHCI_EXT_CAPS_PROTOCOL);
>> +	while (offset) {
>> +		temp = readl(regs + offset);
>> +		major_revision = XHCI_EXT_PORT_MAJOR(temp);
>> +
>> +		temp = readl(regs + offset + 0x08);
>> +		if (major_revision == 0x03) {
>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(temp);
>> +		} else if (major_revision <= 0x02) {
>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(temp);
>> +		} else {
>> +			dev_err(dwc->dev,
>> +				"Unrecognized port major revision %d\n", major_revision);
>> +			ret = -EINVAL;
>> +			goto unmap_reg;
>> +		}
>> +
>> +		offset = dwc3_xhci_find_next_ext_cap(regs, offset,
>> +						XHCI_EXT_CAPS_PROTOCOL);
>> +	}
>> +
>> +	temp = readl(regs + DWC3_XHCI_HCSPARAMS1);
>> +	if (HCS_MAX_PORTS(temp) != (dwc->num_usb3_ports + dwc->num_usb2_ports)) {
>> +		dev_err(dwc->dev,
>> +			"Mismatched reported MAXPORTS (%d)\n", HCS_MAX_PORTS(temp));
>> +		ret = -EINVAL;
>> +		goto unmap_reg;
>> +	}
>> +
>> +	dev_dbg(dwc->dev,
>> +		"hs-ports: %d ss-ports: %d\n", dwc->num_usb2_ports, dwc->num_usb3_ports);
>> +
>> +unmap_reg:
>> +	iounmap(regs);
>> +	return ret;
>> +}
>> +
>>   static int dwc3_probe(struct platform_device *pdev)
>>   {
>>   	struct device		*dev = &pdev->dev;
>> @@ -1774,6 +1872,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   	void __iomem		*regs;
>>   	struct dwc3		*dwc;
>>   	int			ret;
>> +	unsigned int		hw_mode;
>>   
>>   	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>>   	if (!dwc)
>> @@ -1843,6 +1942,20 @@ static int dwc3_probe(struct platform_device *pdev)
>>   			goto err_disable_clks;
>>   	}
>>   
>> +	/*
>> +	 * Currently DWC3 controllers that are host-only capable
>> +	 * support Multiport
>> +	 */
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
>> +		ret = dwc3_read_port_info(dwc);
>> +		if (ret)
>> +			goto err_disable_clks;
>> +	} else {
>> +		dwc->num_usb2_ports = 1;
>> +		dwc->num_usb3_ports = 1;
>> +	}
>> +
>>   	spin_lock_init(&dwc->lock);
>>   	mutex_init(&dwc->mutex);
>>   
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index d56457c02996..d3401963bc27 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -35,6 +35,17 @@
>>   
>>   #define DWC3_MSG_MAX	500
>>   
>> +/* Define XHCI Extcap register offsets for getting multiport info */
>> +#define XHCI_HCC_PARAMS_OFFSET	0x10
>> +#define DWC3_XHCI_HCSPARAMS1	0x04
>> +#define XHCI_EXT_CAPS_PROTOCOL	2
>> +#define XHCI_HCC_EXT_CAPS(x)    (((x) >> 16) & 0xffff)
>> +#define XHCI_EXT_CAPS_ID(x)     (((x) >> 0) & 0xff)
>> +#define XHCI_EXT_CAPS_NEXT(x)   (((x) >> 8) & 0xff)
>> +#define XHCI_EXT_PORT_MAJOR(x)  (((x) >> 24) & 0xff)
>> +#define XHCI_EXT_PORT_COUNT(x)  (((x) >> 8) & 0xff)
>> +#define HCS_MAX_PORTS(x)        (((x) >> 24) & 0x7f)
>> +
>>   /* Global constants */
>>   #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
>>   #define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
>> @@ -1025,6 +1036,8 @@ struct dwc3_scratchpad_array {
>>    * @usb_psy: pointer to power supply interface.
>>    * @usb2_phy: pointer to USB2 PHY
>>    * @usb3_phy: pointer to USB3 PHY
>> + * @num_usb2_ports: number of usb2 ports.
>> + * @num_usb3_ports: number of usb3 ports.
>>    * @usb2_generic_phy: pointer to USB2 PHY
>>    * @usb3_generic_phy: pointer to USB3 PHY
>>    * @phys_ready: flag to indicate that PHYs are ready
>> @@ -1162,6 +1175,9 @@ struct dwc3 {
>>   	struct usb_phy		*usb2_phy;
>>   	struct usb_phy		*usb3_phy;
>>   
>> +	u8			num_usb2_ports;
>> +	u8			num_usb3_ports;
>> +
>>   	struct phy		*usb2_generic_phy;
>>   	struct phy		*usb3_generic_phy;
>>   
>> @@ -1649,5 +1665,4 @@ static inline int dwc3_ulpi_init(struct dwc3 *dwc)
>>   static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
>>   { }
>>   #endif
>> -
>>   #endif /* __DRIVERS_USB_DWC3_CORE_H */
>> -- 
>> 2.40.0
>>
