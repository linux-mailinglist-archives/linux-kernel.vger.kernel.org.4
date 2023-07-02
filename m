Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F58744FDF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 20:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGBSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 14:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjGBSsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 14:48:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA53C7;
        Sun,  2 Jul 2023 11:48:35 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362IjiN1022682;
        Sun, 2 Jul 2023 18:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=THj4azlqC/0GvncKa4j76qZmi1NKAKUGKr4lFQvBWh4=;
 b=APhUocEp92ONaOzoiHmUpltv7whH2K8ngszIjkZz/Oj0wrWUgufjzbitR4DcYIhu8nWt
 QqBaJmKfZFR6H8F5mvlDcnJhu2Yi4kWnyfczrnZzxpOa2Ut1KX9GoN5r51Cwn7pxdctk
 UwtMR3bllLaTkpARz5PXf4nJKNq9eUVhcxpbdUHCocIu5ODq34ESLayDl4PeKF1mK8S0
 RIU9xgmP7EPPPxzENcjDypIUm17rjd1RSTDz7q8Tf/6ZwfVfFh54lEDxHMToD30bRpfn
 Z93QkfTLwDNtiHdxAAgFBVBp5TlvIR6+Ve17detVSwJkEoMr2O8bFOXyekRNKTunp5bF +A== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjb3vtfnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Jul 2023 18:48:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362ImLhA028702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 2 Jul 2023 18:48:21 GMT
Received: from [10.216.46.140] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 11:48:15 -0700
Message-ID: <0af6aa13-d83c-8c26-2a60-00cb3bbe4f5e@quicinc.com>
Date:   Mon, 3 Jul 2023 00:18:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v9 03/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        "Wesley Cheng" <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
 <20230621043628.21485-4-quic_kriskura@quicinc.com>
 <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJrL5SXrSiYbvq2o@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tj7Sown18w3bcAIr1VLbF6Fh_oIXBFAv
X-Proofpoint-GUID: tj7Sown18w3bcAIr1VLbF6Fh_oIXBFAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_15,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020179
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/2023 5:15 PM, Johan Hovold wrote:
> On Wed, Jun 21, 2023 at 10:06:21AM +0530, Krishna Kurapati wrote:
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
>>   drivers/usb/dwc3/core.c | 62 +++++++++++++++++++++++++++++++++++++++++
>>   drivers/usb/dwc3/core.h |  9 ++++++
>>   2 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index f6689b731718..32ec05fc242b 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -39,6 +39,7 @@
>>   #include "io.h"
>>   
>>   #include "debug.h"
>> +#include "../host/xhci-ext-caps.h"
>>   
>>   #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
>>   
>> @@ -1767,6 +1768,52 @@ static int dwc3_get_clocks(struct dwc3 *dwc)
>>   	return 0;
>>   }
>>   
>> +static int dwc3_read_port_info(struct dwc3 *dwc)
>> +{
>> +	void __iomem *base;
>> +	u8 major_revision;
>> +	u32 offset = 0;
>> +	int ret = 0;
> 
> ret is never modified, so drop and return 0 unconditionally below.
> 
> You can add it back later in the series when you start using it.
> 
>> +	u32 val;
>> +
>> +	/*
>> +	 * Remap xHCI address space to access XHCI ext cap regs,
>> +	 * since it is needed to get port info.
>> +	 */
>> +	base = ioremap(dwc->xhci_resources[0].start,
>> +				resource_size(&dwc->xhci_resources[0]));
>> +	if (IS_ERR(base))
>> +		return PTR_ERR(base);
>> +
>> +	do {
>> +		offset = xhci_find_next_ext_cap(base, offset,
>> +				XHCI_EXT_CAPS_PROTOCOL);
>> +
> 
> You can drop this newline.
> 
>> +		if (!offset)
>> +			break;
>> +
>> +		val = readl(base + offset);
>> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
>> +
>> +		val = readl(base + offset + 0x08);
>> +		if (major_revision == 0x03) {
>> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else if (major_revision <= 0x02) {
>> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
>> +		} else {
>> +			dev_err(dwc->dev,
>> +				"Unrecognized port major revision %d\n",
>> +							major_revision);
>> +		}
>> +	} while (1);
>> +
>> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
>> +			dwc->num_usb2_ports, dwc->num_usb3_ports);
>> +
>> +	iounmap(base);
> 
> Nit: I'd add a newline here.
> 
>> +	return ret;
>> +}
>> +
>>   static int dwc3_probe(struct platform_device *pdev)
>>   {
>>   	struct device		*dev = &pdev->dev;
>> @@ -1774,6 +1821,7 @@ static int dwc3_probe(struct platform_device *pdev)
>>   	void __iomem		*regs;
>>   	struct dwc3		*dwc;
>>   	int			ret;
>> +	unsigned int		hw_mode;
>>   
>>   	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>>   	if (!dwc)
>> @@ -1854,6 +1902,20 @@ static int dwc3_probe(struct platform_device *pdev)
>>   			goto err_disable_clks;
>>   	}
>>   
>> +	/*
>> +	 * Currently only DWC3 controllers that are host-only capable
>> +	 * support Multiport.
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
>> index 8b1295e4dcdd..42fb17aa66fa 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -33,6 +33,10 @@
>>   
>>   #include <linux/power_supply.h>
>>   
>> +#define XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
>> +#define XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
>> +#define XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
> 
> Again, don't copy defines from xhci.
> 
> Looks like these should be moved to the xhci-ext-caps.h header along
> with struct xhci_protocol_caps.
> 
Can't we just give them an exception ? Modifying xhci stuff doesn't 
sound good. Can I just rename them and keep them here ?

Regards,
Krishna,

>> +
>>   #define DWC3_MSG_MAX	500
>>   
>>   /* Global constants */
>> @@ -1029,6 +1033,8 @@ struct dwc3_scratchpad_array {
>>    * @usb3_phy: pointer to USB3 PHY
>>    * @usb2_generic_phy: pointer to USB2 PHY
>>    * @usb3_generic_phy: pointer to USB3 PHY
>> + * @num_usb2_ports: number of USB2 ports.
>> + * @num_usb3_ports: number of USB3 ports.
> 
> Again, please drop the full stops ('.').
> 
> Johan
