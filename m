Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9481C70436D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjEPCbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjEPCbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:31:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4CA1BF8;
        Mon, 15 May 2023 19:31:49 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1mxYY009691;
        Tue, 16 May 2023 02:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Fuk41sHbqTHDg5aGbAaI4Rg6atxO8QhIBm3tURHrnwo=;
 b=UyxDgo9Nmz5gsjotE/8rIe6jGSmKyCqqV3bIGnf6VpQiC9kDqphtpVo9+MjgSgsZWT2A
 SyJX88r9IXj44fS5W7BnzQksaqrboQ6zZCO321QzBNtyTXjZti5447z5dxCvseLSp8bf
 VW0LkS47/4K3G2K84R3lovwjiFb0Sz8WqaN9/FHN8aWXQoCELYFDD6han8pMCvlUSoAh
 x5MWkwILj8Cjc+gf3BpNCppKodrZ/k5Ks1ne4wpHLUB5klpfsL+n56u4tDD/i+fgP6wE
 6q5gW3+xutRwxERqZDtVAOJoIXK/dh17wniSG4KAtaeMC4NFITiNACtmr6CjtOarIq/f uw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qkjsct42a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:31:38 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34G2VbEh021856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 May 2023 02:31:37 GMT
Received: from [10.216.35.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 15 May
 2023 19:31:30 -0700
Message-ID: <5a7f993e-9340-825f-e8ea-833d4e0a0c2d@quicinc.com>
Date:   Tue, 16 May 2023 08:01:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v8 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
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
 <20230514054917.21318-6-quic_kriskura@quicinc.com>
 <20230515214730.epeelsnp3bznssr5@ripper>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230515214730.epeelsnp3bznssr5@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Va31c8gg17FH3_JEXT8JMRE63trQEstp
X-Proofpoint-ORIG-GUID: Va31c8gg17FH3_JEXT8JMRE63trQEstp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305160019
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/2023 3:17 AM, Bjorn Andersson wrote:
> On Sun, May 14, 2023 at 11:19:13AM +0530, Krishna Kurapati wrote:
>> Currently the DWC3 driver supports only single port controller
>> which requires at most one HS and one SS PHY.
>>
>> But the DWC3 USB controller can be connected to multiple ports and
>> each port can have their own PHYs. Each port of the multiport
>> controller can either be HS+SS capable or HS only capable
>> Proper quantification of them is required to modify GUSB2PHYCFG
>> and GUSB3PIPECTL registers appropriately.
>>
>> Add support for detecting, obtaining and configuring phy's supported
>> by a multiport controller and limit the max number of ports
>> supported to 4.
>>
>> Co-developed-by: Harsh Agarwal <quic_harshq@quicinc.com>
> 
> Please include Harsh's signed-off-by as well here, to clarify that you
> both certify the origin of this patch.
> 
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 266 ++++++++++++++++++++++++++++++----------
>>   drivers/usb/dwc3/core.h |  11 +-
>>   drivers/usb/dwc3/drd.c  |  13 +-
>>   3 files changed, 213 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> [..]
>> @@ -744,22 +777,38 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   static int dwc3_phy_init(struct dwc3 *dwc)
>>   {
>>   	int ret;
>> +	int i;
>> +	int j;
>>   
>>   	usb_phy_init(dwc->usb2_phy);
>>   	usb_phy_init(dwc->usb3_phy);
>>   
>> -	ret = phy_init(dwc->usb2_generic_phy);
>> -	if (ret < 0)
>> -		goto err_shutdown_usb3_phy;
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		ret = phy_init(dwc->usb2_generic_phy[i]);
>> +		if (ret < 0) {
>> +			/* clean up prior initialized HS PHYs */
>> +			for (j = 0; j < i; j++)
>> +				phy_exit(dwc->usb2_generic_phy[j]);
>> +			goto err_shutdown_usb3_phy;
> 
> The idiomatic form is to goto err_exit_usb2_phy and let it phy_exit()
> from i - 1 to 0. That would avoid duplicating this snippet.
> 
>> +		}
>> +	}
>>   
>> -	ret = phy_init(dwc->usb3_generic_phy);
>> -	if (ret < 0)
>> -		goto err_exit_usb2_phy;
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
> 
> When you call dwc3_ss_phy_setup() the index refer to port0, port1... but
> when you refer to the phys you consistently loops over num_usb2_ports.
> 
> The only case I can think of where this would be useful is if it's not
> the first N ports that are SS-capable (e.g. port0 and port can do SS).
> 
> If this is the case, is it correct that this should not be reflected in
> the index passed to e.g. dwc3_ss_phy_setup()?
> 
> If this is not the case, could you please transition these SS-related
> loops to iterate over usb3_generic_phy[0..num_usb3_ports)?

Hi Bjorn,

  The reason why I used num_usb2_ports here and num_usb3_ports in 
ss_phy_setup is that, there may be cases where not the ones in the 
beginning but the last few ports of multiport controller are SS capable. 
In that case trying to keep track of them and accordingly executing phy 
operations is difficult. Instead since all ports are atleast HS capable 
and calling a Phy op on a non-existent SS Phy is still harmless as the 
phy pointer is NULL and phy op's return 0.

Coming to ss_phy_setup, we need to modify the GUSB3PIPECTL registers 
which are same as number of ss ports present. And modifying these 
registers whether or not the Phy is used is completely fine as it is 
done even in today's code (dwc3_phy_setup). In this case, if there are 2 
SS Phy's we need to loop over and modify GUSB3PIPECTL(0) and 
GUSB3PIPECTL(1) and so we need to use num_usb3_ports.

For the above two reasons I used num_usb2_ports wherever I did phy 
operations and num_usb3_ports wherever GUSB3PIPECTL is being modified 
like I did in dwc3_core_init as well.

> 
>> +		ret = phy_init(dwc->usb3_generic_phy[i]);
>> +		if (ret < 0) {
>> +			/* clean up prior initialized SS PHYs */
>> +			for (j = 0; j < i; j++)
>> +				phy_exit(dwc->usb3_generic_phy[j]);
>> +			goto err_exit_usb2_phy;
> 
> For the purpose of symmetry, same suggestion as above. phy_exit() i - 1
> through 0, then reset j to dwc->num_usb2_ports and fall through to
> err_exit_usb2_phy.

I will try to set i/j to proper values to cleanup code appropriately. 
But isn't this fine for now as I don't want to make too many changes in 
next version. I will make sure to cleanup this section in a separate 
patch after this series if that is fine.

>> +		}
>> +	}
>>   
>>   	return 0;
>>   
>>   err_exit_usb2_phy:
>> -	phy_exit(dwc->usb2_generic_phy);
>> +	for (i = 0; i < dwc->num_usb2_ports; i++)
>> +		phy_exit(dwc->usb2_generic_phy[i]);
>> +
>>   err_shutdown_usb3_phy:
>>   	usb_phy_shutdown(dwc->usb3_phy);
>>   	usb_phy_shutdown(dwc->usb2_phy);
>> @@ -769,8 +818,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
> [..]
>>   static int dwc3_phy_power_on(struct dwc3 *dwc)
>>   {
>>   	int ret;
>> +	int i;
>> +	int j;
>>   
>>   	usb_phy_set_suspend(dwc->usb2_phy, 0);
>>   	usb_phy_set_suspend(dwc->usb3_phy, 0);
>>   
>> -	ret = phy_power_on(dwc->usb2_generic_phy);
>> -	if (ret < 0)
>> -		goto err_suspend_usb3_phy;
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		ret = phy_power_on(dwc->usb2_generic_phy[i]);
>> +		if (ret < 0) {
>> +			/* Turn off prior ON'ed HS Phy's */
>> +			for (j = 0; j < i; j++)
>> +				phy_power_off(dwc->usb2_generic_phy[j]);
>> +			goto err_suspend_usb3_phy;
> 
> As above, I'd prefer that you don't duplicate the phy_power_off() loop.
> 
>> +		}
>> +	}
>>   
>> -	ret = phy_power_on(dwc->usb3_generic_phy);
>> -	if (ret < 0)
>> -		goto err_power_off_usb2_phy;
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		ret = phy_power_on(dwc->usb3_generic_phy[i]);
>> +		if (ret < 0) {
>> +			/* Turn of prior ON'ed SS Phy's */
>> +			for (j = 0; j < i; j++)
>> +				phy_power_off(dwc->usb3_generic_phy[j]);
>> +			goto err_power_off_usb2_phy;
>> +		}
>> +	}
>>   
>>   	return 0;
> [..]
>> +static int dwc3_get_multiport_phys(struct dwc3 *dwc)
>> +{
>> +	int ret;
>> +	struct device *dev = dwc->dev;
>> +	int i;
>> +	char phy_name[11];
> 
> It would be prettier if you sorted these lines by length, longest
> first...
> 
Sure, will fix this nit.

> [..]
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index d3401963bc27..84f6303922aa 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -35,6 +35,9 @@
>>   
>>   #define DWC3_MSG_MAX	500
>>   
>> +/* Number of ports supported by a multiport controller */
>> +#define MAX_PORTS_SUPPORTED	4
> 
> I think it would be preferred to prefix this DWC3_ (so perhaps just
> DWC3_MAX_PORTS, to keep it shorter)

Sure, will fix this nit.

Thanks,
Krishna,
> 
>> +
>>   /* Define XHCI Extcap register offsets for getting multiport info */
>>   #define XHCI_HCC_PARAMS_OFFSET	0x10
>>   #define DWC3_XHCI_HCSPARAMS1	0x04
>> @@ -1038,8 +1041,8 @@ struct dwc3_scratchpad_array {
>>    * @usb3_phy: pointer to USB3 PHY
>>    * @num_usb2_ports: number of usb2 ports.
>>    * @num_usb3_ports: number of usb3 ports.
>> - * @usb2_generic_phy: pointer to USB2 PHY
>> - * @usb3_generic_phy: pointer to USB3 PHY
>> + * @usb2_generic_phy: pointer to array of USB2 PHY
>> + * @usb3_generic_phy: pointer to array of USB3 PHY
>>    * @phys_ready: flag to indicate that PHYs are ready
>>    * @ulpi: pointer to ulpi interface
>>    * @ulpi_ready: flag to indicate that ULPI is initialized
>> @@ -1178,8 +1181,8 @@ struct dwc3 {
>>   	u8			num_usb2_ports;
>>   	u8			num_usb3_ports;
>>   
>> -	struct phy		*usb2_generic_phy;
>> -	struct phy		*usb3_generic_phy;
>> +	struct phy		*usb2_generic_phy[MAX_PORTS_SUPPORTED];
>> +	struct phy		*usb3_generic_phy[MAX_PORTS_SUPPORTED];
>>   
>>   	bool			phys_ready;
> 
