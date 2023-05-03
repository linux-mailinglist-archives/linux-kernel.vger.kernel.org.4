Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03AE6F4F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 05:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjECDxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 23:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECDxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 23:53:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F1C5;
        Tue,  2 May 2023 20:52:58 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3433cduQ009431;
        Wed, 3 May 2023 03:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RQPQAuei1Sr64hNpHuxiuDF3eNpODHC9jTB4cvnTOhU=;
 b=ewpEEkYPJ/wk41PaiwqGttRbPaSycmQA/zi8e1jVQ2uYC7g3LkY5FZVvctfxYQN9aT+y
 AjX/AXdDxQsbHSt9gZkd37QbYWLsTxBYBuR9S0CAkHjrWvHJVT2eUITK7WwYWXFabaT2
 w0pZ3AqMsGuXDIcYclYp3kbXRQIg9MTDmYOGRGs5N7XNSiSFQQ8wcFluQdY9WbRxtdsi
 4Q77GOoAgesZK7ARuFotzxUvzdZYGY1ceyQtftYftdRHoVW4iY9IYf2lleVdYUuePXnX
 4UmGxGmD5RZzc5qQyF6LLQqcTjtYTdSEk8Htoe4+hCloWaeiWjzMc4o5jC+ywOfZkVpY OA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qbbsw0c3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 May 2023 03:52:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3433qVHJ007148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 3 May 2023 03:52:31 GMT
Received: from [10.217.216.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 20:52:25 -0700
Message-ID: <f55fbdc1-444c-eba5-02f4-aeab7a1b6f04@quicinc.com>
Date:   Wed, 3 May 2023 09:22:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 5/9] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
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
 <20230501143445.3851-6-quic_kriskura@quicinc.com>
 <20230502221100.ecska23anlzv3iwq@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230502221100.ecska23anlzv3iwq@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c1RHadiSSuy4K25EA964TIIwoHbhVoZC
X-Proofpoint-ORIG-GUID: c1RHadiSSuy4K25EA964TIIwoHbhVoZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030030
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/2023 3:41 AM, Thinh Nguyen wrote:
> On Mon, May 01, 2023, Krishna Kurapati wrote:
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
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> Are you a co-author or only Harsh is the main author of this patch?
> 
Harsh began developing this series and pushed the first 3 RFC versions 
(supporting both usb-phy / generic phy frameworks) until maintainers 
pointed out that we only support generic phy changes.

 From then on I took it up and started pushing next versions. I would 
say both of us are primary authors for this patch. But if there has to 
be only one, I would say its Harsh.

Regards,
Krishna,

>> ---
>>   drivers/usb/dwc3/core.c | 262 +++++++++++++++++++++++++++++-----------
>>   drivers/usb/dwc3/core.h |  12 +-
>>   drivers/usb/dwc3/drd.c  |  13 +-
>>   3 files changed, 209 insertions(+), 78 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 8625fc5c7ab4..b91c3f965abc 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -121,6 +121,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   	struct dwc3 *dwc = work_to_dwc(work);
>>   	unsigned long flags;
>>   	int ret;
>> +	int i;
>>   	u32 reg;
>>   	u32 desired_dr_role;
>>   
>> @@ -200,8 +201,10 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   		} else {
>>   			if (dwc->usb2_phy)
>>   				otg_set_vbus(dwc->usb2_phy->otg, true);
>> -			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>> -			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +				phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>> +				phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>> +			}
>>   			if (dwc->dis_split_quirk) {
>>   				reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
>>   				reg |= DWC3_GUCTL3_SPLITDISABLE;
>> @@ -216,8 +219,8 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   
>>   		if (dwc->usb2_phy)
>>   			otg_set_vbus(dwc->usb2_phy->otg, false);
>> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>> +		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
>> +		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>>   
>>   		ret = dwc3_gadget_init(dwc);
>>   		if (ret)
>> @@ -575,22 +578,14 @@ static int dwc3_core_ulpi_init(struct dwc3 *dwc)
>>   	return ret;
>>   }
>>   
>> -/**
>> - * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
>> - * @dwc: Pointer to our controller context structure
>> - *
>> - * Returns 0 on success. The USB PHY interfaces are configured but not
>> - * initialized. The PHY interfaces and the PHYs get initialized together with
>> - * the core in dwc3_core_init.
>> - */
>> -static int dwc3_phy_setup(struct dwc3 *dwc)
>> +static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
>>   {
>>   	unsigned int hw_mode;
>>   	u32 reg;
>>   
>>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>   
>> -	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
>>   
>>   	/*
>>   	 * Make sure UX_EXIT_PX is cleared as that causes issues with some
>> @@ -645,9 +640,19 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   	if (dwc->dis_del_phy_power_chg_quirk)
>>   		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
>>   
>> -	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
>> +	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(index), reg);
>>   
>> -	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> +	return 0;
>> +}
>> +
>> +static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
>> +{
>> +	unsigned int hw_mode;
>> +	u32 reg;
>> +
>> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
>>   
>>   	/* Select the HS PHY interface */
>>   	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
>> @@ -659,7 +664,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   		} else if (dwc->hsphy_interface &&
>>   				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
>>   			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
>> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
>>   		} else {
>>   			/* Relying on default value. */
>>   			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
>> @@ -726,7 +731,35 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   	if (dwc->ulpi_ext_vbus_drv)
>>   		reg |= DWC3_GUSB2PHYCFG_ULPIEXTVBUSDRV;
>>   
>> -	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(index), reg);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
>> + * @dwc: Pointer to our controller context structure
>> + *
>> + * Returns 0 on success. The USB PHY interfaces are configured but not
>> + * initialized. The PHY interfaces and the PHYs get initialized together with
>> + * the core in dwc3_core_init.
>> + */
>> +static int dwc3_phy_setup(struct dwc3 *dwc)
>> +{
>> +	int i;
>> +	int ret;
>> +
>> +	for (i = 0; i < dwc->num_usb3_ports; i++) {
>> +		ret = dwc3_ss_phy_setup(dwc, i);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		ret = dwc3_hs_phy_setup(dwc, i);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	return 0;
>>   }
>> @@ -734,22 +767,36 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
>>   static int dwc3_phy_init(struct dwc3 *dwc)
>>   {
>>   	int ret;
>> +	int i, j;
> 
> Minor style nit, can we declare in separate lines?
> 
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
>> +		}
>> +	}
>>   
>> -	ret = phy_init(dwc->usb3_generic_phy);
>> -	if (ret < 0)
>> -		goto err_exit_usb2_phy;
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		ret = phy_init(dwc->usb3_generic_phy[i]);
>> +		if (ret < 0) {
>> +			/* clean up prior initialized SS PHYs */
>> +			for (j = 0; j < i; j++)
>> +				phy_exit(dwc->usb3_generic_phy[j]);
>> +			goto err_exit_usb2_phy;
>> +		}
>> +	}
>>   
>>   	return 0;
>>   
>>   err_exit_usb2_phy:
>> -	phy_exit(dwc->usb2_generic_phy);
>> +	for (i = 0; i < dwc->num_usb2_ports; i++)
>> +		phy_exit(dwc->usb2_generic_phy[i]);
>>   err_shutdown_usb3_phy:
>>   	usb_phy_shutdown(dwc->usb3_phy);
>>   	usb_phy_shutdown(dwc->usb2_phy);
>> @@ -759,8 +806,12 @@ static int dwc3_phy_init(struct dwc3 *dwc)
>>   
>>   static void dwc3_phy_exit(struct dwc3 *dwc)
>>   {
>> -	phy_exit(dwc->usb3_generic_phy);
>> -	phy_exit(dwc->usb2_generic_phy);
>> +	int i;
>> +
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		phy_exit(dwc->usb3_generic_phy[i]);
>> +		phy_exit(dwc->usb2_generic_phy[i]);
>> +	}
>>   
>>   	usb_phy_shutdown(dwc->usb3_phy);
>>   	usb_phy_shutdown(dwc->usb2_phy);
>> @@ -769,22 +820,36 @@ static void dwc3_phy_exit(struct dwc3 *dwc)
>>   static int dwc3_phy_power_on(struct dwc3 *dwc)
>>   {
>>   	int ret;
>> +	int i, j;
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
>>   
>>   err_power_off_usb2_phy:
>> -	phy_power_off(dwc->usb2_generic_phy);
>> +	for (i = 0; i < dwc->num_usb2_ports; i++)
>> +		phy_power_off(dwc->usb2_generic_phy[i]);
>>   err_suspend_usb3_phy:
>>   	usb_phy_set_suspend(dwc->usb3_phy, 1);
>>   	usb_phy_set_suspend(dwc->usb2_phy, 1);
>> @@ -794,8 +859,12 @@ static int dwc3_phy_power_on(struct dwc3 *dwc)
>>   
>>   static void dwc3_phy_power_off(struct dwc3 *dwc)
>>   {
>> -	phy_power_off(dwc->usb3_generic_phy);
>> -	phy_power_off(dwc->usb2_generic_phy);
>> +	int i;
>> +
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		phy_power_off(dwc->usb3_generic_phy[i]);
>> +		phy_power_off(dwc->usb2_generic_phy[i]);
>> +	}
>>   
>>   	usb_phy_set_suspend(dwc->usb3_phy, 1);
>>   	usb_phy_set_suspend(dwc->usb2_phy, 1);
>> @@ -1073,6 +1142,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	unsigned int		hw_mode;
>>   	u32			reg;
>>   	int			ret;
>> +	int			i;
>>   
>>   	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>   
>> @@ -1116,15 +1186,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	if (hw_mode == DWC3_GHWPARAMS0_MODE_DRD &&
>>   	    !DWC3_VER_IS_WITHIN(DWC3, ANY, 194A)) {
>>   		if (!dwc->dis_u3_susphy_quirk) {
>> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
>> -			reg |= DWC3_GUSB3PIPECTL_SUSPHY;
>> -			dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
>> +			for (i = 0; i < dwc->num_usb3_ports; i++) {
>> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
>> +				reg |= DWC3_GUSB3PIPECTL_SUSPHY;
>> +				dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
>> +			}
>>   		}
>>   
>>   		if (!dwc->dis_u2_susphy_quirk) {
>> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> -			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
>> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
>> +				reg |= DWC3_GUSB2PHYCFG_SUSPHY;
>> +				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
>> +			}
>>   		}
>>   	}
>>   
>> @@ -1281,6 +1355,42 @@ static int dwc3_core_init(struct dwc3 *dwc)
>>   	return ret;
>>   }
>>   
>> +static int dwc3_get_multiport_phys(struct dwc3 *dwc)
>> +{
>> +	int ret;
>> +	struct device *dev = dwc->dev;
>> +	int i;
>> +	char phy_name[11];
> 
> Minor minor nit. Can we reorder this as follow:
> 	struct device *dev = dwc->dev;
> 	char phy_name[11];
> 	int ret;
> 	int i;
> 
> 
>> +
>> +	/*
>> +	 * Each port is at least HS capable. So loop over num_usb2_ports
>> +	 * to get available phy's.
>> +	 */
>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +		sprintf(phy_name, "usb2-port%d", i);
>> +		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
>> +		if (IS_ERR(dwc->usb2_generic_phy[i])) {
>> +			ret = PTR_ERR(dwc->usb2_generic_phy[i]);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb2_generic_phy[i] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "usb2 phy: %s not configured\n", phy_name);
>> +		}
>> +
>> +		sprintf(phy_name, "usb3-port%d", i);
>> +		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
>> +		if (IS_ERR(dwc->usb3_generic_phy[i])) {
>> +			ret = PTR_ERR(dwc->usb3_generic_phy[i]);
>> +			if (ret == -ENOSYS || ret == -ENODEV)
>> +				dwc->usb3_generic_phy[i] = NULL;
>> +			else
>> +				return dev_err_probe(dev, ret, "usb3 phy: %s not configured\n", phy_name);
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int dwc3_core_get_phy(struct dwc3 *dwc)
>>   {
>>   	struct device		*dev = dwc->dev;
>> @@ -1311,20 +1421,23 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
>>   			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>>   	}
>>   
>> -	dwc->usb2_generic_phy = devm_phy_get(dev, "usb2-phy");
>> -	if (IS_ERR(dwc->usb2_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb2_generic_phy);
>> +	if (dwc->num_usb2_ports > 1)
>> +		return dwc3_get_multiport_phys(dwc);
>> +
>> +	dwc->usb2_generic_phy[0] = devm_phy_get(dev, "usb2-phy");
>> +	if (IS_ERR(dwc->usb2_generic_phy[0])) {
>> +		ret = PTR_ERR(dwc->usb2_generic_phy[0]);
>>   		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb2_generic_phy = NULL;
>> +			dwc->usb2_generic_phy[0] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb2 phy configured\n");
>>   	}
>>   
>> -	dwc->usb3_generic_phy = devm_phy_get(dev, "usb3-phy");
>> -	if (IS_ERR(dwc->usb3_generic_phy)) {
>> -		ret = PTR_ERR(dwc->usb3_generic_phy);
>> +	dwc->usb3_generic_phy[0] = devm_phy_get(dev, "usb3-phy");
>> +	if (IS_ERR(dwc->usb3_generic_phy[0])) {
>> +		ret = PTR_ERR(dwc->usb3_generic_phy[0]);
>>   		if (ret == -ENOSYS || ret == -ENODEV)
>> -			dwc->usb3_generic_phy = NULL;
>> +			dwc->usb3_generic_phy[0] = NULL;
>>   		else
>>   			return dev_err_probe(dev, ret, "no usb3 phy configured\n");
>>   	}
>> @@ -1336,6 +1449,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>   {
>>   	struct device *dev = dwc->dev;
>>   	int ret;
>> +	int i;
>>   
>>   	switch (dwc->dr_mode) {
>>   	case USB_DR_MODE_PERIPHERAL:
>> @@ -1343,8 +1457,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>   
>>   		if (dwc->usb2_phy)
>>   			otg_set_vbus(dwc->usb2_phy->otg, false);
>> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>> +		phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
>> +		phy_set_mode(dwc->usb3_generic_phy[0], PHY_MODE_USB_DEVICE);
>>   
>>   		ret = dwc3_gadget_init(dwc);
>>   		if (ret)
>> @@ -1355,8 +1469,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>   
>>   		if (dwc->usb2_phy)
>>   			otg_set_vbus(dwc->usb2_phy->otg, true);
>> -		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>> -		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +			phy_set_mode(dwc->usb2_generic_phy[i], PHY_MODE_USB_HOST);
>> +			phy_set_mode(dwc->usb3_generic_phy[i], PHY_MODE_USB_HOST);
>> +		}
>>   
>>   		ret = dwc3_host_init(dwc);
>>   		if (ret)
>> @@ -2046,6 +2162,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
>>   
>>   static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   {
>> +	int i;
>>   	unsigned long	flags;
>>   	u32 reg;
>>   
>> @@ -2066,17 +2183,21 @@ static int dwc3_suspend_common(struct dwc3 *dwc, pm_message_t msg)
>>   		/* Let controller to suspend HSPHY before PHY driver suspends */
>>   		if (dwc->dis_u2_susphy_quirk ||
>>   		    dwc->dis_enblslpm_quirk) {
>> -			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> -			reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
>> -				DWC3_GUSB2PHYCFG_SUSPHY;
>> -			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +				reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
>> +				reg |=  DWC3_GUSB2PHYCFG_ENBLSLPM |
>> +					DWC3_GUSB2PHYCFG_SUSPHY;
>> +				dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
>> +			}
>>   
>>   			/* Give some time for USB2 PHY to suspend */
>>   			usleep_range(5000, 6000);
>>   		}
>>   
>> -		phy_pm_runtime_put_sync(dwc->usb2_generic_phy);
>> -		phy_pm_runtime_put_sync(dwc->usb3_generic_phy);
>> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +			phy_pm_runtime_put_sync(dwc->usb2_generic_phy[i]);
>> +			phy_pm_runtime_put_sync(dwc->usb3_generic_phy[i]);
>> +		}
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_OTG:
>>   		/* do nothing during runtime_suspend */
>> @@ -2105,6 +2226,7 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>   {
>>   	unsigned long	flags;
>>   	int		ret;
>> +	int		i;
>>   	u32		reg;
>>   
>>   	switch (dwc->current_dr_role) {
>> @@ -2125,17 +2247,21 @@ static int dwc3_resume_common(struct dwc3 *dwc, pm_message_t msg)
>>   			break;
>>   		}
>>   		/* Restore GUSB2PHYCFG bits that were modified in suspend */
>> -		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
>> -		if (dwc->dis_u2_susphy_quirk)
>> -			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
>> +			if (dwc->dis_u2_susphy_quirk)
>> +				reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
>>   
>> -		if (dwc->dis_enblslpm_quirk)
>> -			reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
>> +			if (dwc->dis_enblslpm_quirk)
>> +				reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
>>   
>> -		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
>> +			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
>> +		}
>>   
>> -		phy_pm_runtime_get_sync(dwc->usb2_generic_phy);
>> -		phy_pm_runtime_get_sync(dwc->usb3_generic_phy);
>> +		for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +			phy_pm_runtime_get_sync(dwc->usb2_generic_phy[i]);
>> +			phy_pm_runtime_get_sync(dwc->usb3_generic_phy[i]);
>> +		}
>>   		break;
>>   	case DWC3_GCTL_PRTCAP_OTG:
>>   		/* nothing to do on runtime_resume */
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 21312703e053..0bba074b44e4 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -35,6 +35,9 @@
>>   
>>   #define DWC3_MSG_MAX	500
>>   
>> +/* Number of ports supported by a multiport controller */
>> +#define MAX_PORTS_SUPPORTED	4
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
>> @@ -1177,9 +1180,8 @@ struct dwc3 {
>>   
>>   	u32			num_usb2_ports;
>>   	u32			num_usb3_ports;
>> -
>> -	struct phy		*usb2_generic_phy;
>> -	struct phy		*usb3_generic_phy;
>> +	struct phy		*usb2_generic_phy[MAX_PORTS_SUPPORTED];
>> +	struct phy		*usb3_generic_phy[MAX_PORTS_SUPPORTED];
>>   
>>   	bool			phys_ready;
>>   
>> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
>> index 039bf241769a..0377295717ab 100644
>> --- a/drivers/usb/dwc3/drd.c
>> +++ b/drivers/usb/dwc3/drd.c
>> @@ -328,6 +328,7 @@ static void dwc3_otg_device_exit(struct dwc3 *dwc)
>>   void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>>   {
>>   	int ret;
>> +	int i;
>>   	u32 reg;
>>   	int id;
>>   	unsigned long flags;
>> @@ -386,9 +387,11 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>>   		} else {
>>   			if (dwc->usb2_phy)
>>   				otg_set_vbus(dwc->usb2_phy->otg, true);
>> -			if (dwc->usb2_generic_phy)
>> -				phy_set_mode(dwc->usb2_generic_phy,
>> -					     PHY_MODE_USB_HOST);
>> +			for (i = 0; i < dwc->num_usb2_ports; i++) {
>> +				if (dwc->usb2_generic_phy[i])
>> +					phy_set_mode(dwc->usb2_generic_phy[i],
>> +						     PHY_MODE_USB_HOST);
>> +			}
>>   		}
>>   		break;
>>   	case DWC3_OTG_ROLE_DEVICE:
>> @@ -400,8 +403,8 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>>   
>>   		if (dwc->usb2_phy)
>>   			otg_set_vbus(dwc->usb2_phy->otg, false);
>> -		if (dwc->usb2_generic_phy)
>> -			phy_set_mode(dwc->usb2_generic_phy,
>> +		if (dwc->usb2_generic_phy[0])
>> +			phy_set_mode(dwc->usb2_generic_phy[0],
>>   				     PHY_MODE_USB_DEVICE);
>>   		ret = dwc3_gadget_init(dwc);
>>   		if (ret)
>> -- 
>> 2.40.0
>>
> 
> Thanks,
> Thinh
