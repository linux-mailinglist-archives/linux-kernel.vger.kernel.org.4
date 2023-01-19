Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343667433F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjASUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 15:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjASUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 15:03:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB08290B15;
        Thu, 19 Jan 2023 12:03:49 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30JHeR6x000812;
        Thu, 19 Jan 2023 20:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kqsfrCofkojjYRgbFGRrK0ilf0g+pMVDNT2ugpmAgrQ=;
 b=J+JkQlCWv2hnRZSH+Th+vMCmV+Vf/U+3c6/OuEgFfYrcF3r0yIX8mBDc6Z9oDRPdtPL8
 +VjLO/CP3fBG0TeUJHBNa1T0CzEjJA9VTgGaUiTqqByDYLxnn8bjOXLjCFYYuH8XRj2W
 Fk5lFCbskgFGLdw6k+LjU6WRj3Tokj0sn3sOkM2AOGwp6yMrxFiFBwel4EHZDpi0t4pe
 Q+r7haMZ/LPjnfp98I45wjMWsdZwEZ5eYv7Z3x6OYY5VfB/DBeqmMxl5UMHaT/FDFa92
 FWDCYt7bwui+YGDlDdhWotJ66w9xuLYTa/Yux+P1XL6mnVWd6jT3ZrF/78xRsUp8wEWE Bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6r59av07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 20:03:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30JK3i98009730
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 20:03:44 GMT
Received: from [10.110.55.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 12:03:43 -0800
Message-ID: <f541c943-bdf9-f6bd-1826-0aa5a81088ef@quicinc.com>
Date:   Thu, 19 Jan 2023 12:03:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 4/5] usb: dwc3: Add function suspend and function
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-5-git-send-email-quic_eserrao@quicinc.com>
 <20230119021838.luuiwe5n6npf3kaj@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230119021838.luuiwe5n6npf3kaj@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Unl46F9WtiOONfd6eut7m0D5fGKaOKHc
X-Proofpoint-GUID: Unl46F9WtiOONfd6eut7m0D5fGKaOKHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_13,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301190168
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 6:18 PM, Thinh Nguyen wrote:
> On Tue, Jan 17, 2023, Elson Roy Serrao wrote:
>> USB host sends function suspend and function resume notifications to
>> the interface through SET_FEATURE/CLEAR_FEATURE setup packets.
>> Add support to handle these packets by delegating the requests to
>> composite layer. Also add support to handle function wake notification
>> requests to exit from function suspend state.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h   |  1 +
>>   drivers/usb/dwc3/debug.h  |  2 ++
>>   drivers/usb/dwc3/ep0.c    | 12 ++++--------
>>   drivers/usb/dwc3/gadget.c | 36 +++++++++++++++++++++++++++++++++++-
>>   4 files changed, 42 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 53ded08..5cda645 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -526,6 +526,7 @@
>>   #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
>>   #define DWC3_DGCMD_SET_ENDPOINT_PRIME	0x0d
>>   #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
>> +#define DWC3_DGCMD_DEV_NOTIFICATION	0x07
>>   
>>   #define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
>>   #define DWC3_DGCMD_CMDACT		BIT(10)
>> diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
>> index 48b44b8..0897d9d 100644
>> --- a/drivers/usb/dwc3/debug.h
>> +++ b/drivers/usb/dwc3/debug.h
>> @@ -72,6 +72,8 @@ dwc3_gadget_generic_cmd_string(u8 cmd)
>>   		return "Set Endpoint Prime";
>>   	case DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK:
>>   		return "Run SoC Bus Loopback Test";
>> +	case DWC3_DGCMD_DEV_NOTIFICATION:
>> +		return "Device Notification";
>>   	default:
>>   		return "UNKNOWN";
>>   	}
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 0c1203d..e05c2b9 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -30,6 +30,8 @@
>>   static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep);
>>   static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
>>   		struct dwc3_ep *dep, struct dwc3_request *req);
>> +static int dwc3_ep0_delegate_req(struct dwc3 *dwc,
>> +				 struct usb_ctrlrequest *ctrl);
>>   
>>   static void dwc3_ep0_prepare_one_trb(struct dwc3_ep *dep,
>>   		dma_addr_t buf_dma, u32 len, u32 type, bool chain)
>> @@ -367,7 +369,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
>>   		 * Function Remote Wake Capable	D0
>>   		 * Function Remote Wakeup	D1
>>   		 */
>> -		break;
>> +		return dwc3_ep0_delegate_req(dwc, ctrl);
>>   
>>   	case USB_RECIP_ENDPOINT:
>>   		dep = dwc3_wIndex_to_dep(dwc, ctrl->wIndex);
>> @@ -514,13 +516,7 @@ static int dwc3_ep0_handle_intf(struct dwc3 *dwc,
>>   
>>   	switch (wValue) {
>>   	case USB_INTRF_FUNC_SUSPEND:
>> -		/*
>> -		 * REVISIT: Ideally we would enable some low power mode here,
>> -		 * however it's unclear what we should be doing here.
>> -		 *
>> -		 * For now, we're not doing anything, just making sure we return
>> -		 * 0 so USB Command Verifier tests pass without any errors.
>> -		 */
>> +		ret = dwc3_ep0_delegate_req(dwc, ctrl);
>>   		break;
>>   	default:
>>   		ret = -EINVAL;
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index db4b438..1c958c4 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2346,7 +2346,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
>>   		return 0;
>>   
>>   	/* poll until Link State changes to ON */
>> -	retries = 20000;
>> +	retries = 30000;
> 
> This seems like a fix that needs to be splitted to a separate change.
> read_poll_timeout_atomic() would be useful here (as a separate/unrelated
> change for status polling).
> 
Done.

>>   
>>   	while (retries--) {
>>   		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>> @@ -2383,6 +2383,39 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>   	return ret;
>>   }
>>   
>> +static void dwc3_resume_gadget(struct dwc3 *dwc);
>> +
>> +static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int interface_id)
>> +{
>> +	struct  dwc3		*dwc = gadget_to_dwc(g);
>> +	unsigned long		flags;
>> +	int			ret;
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	/*
>> +	 * If the link is in LPM, first bring the link to U0
> 
> Reword LMP -> low power.
> 
Sure.

>> +	 * before triggering function remote wakeup.
>> +	 */
>> +	if (dwc->link_state == DWC3_LINK_STATE_U3) {
>> +		ret = __dwc3_gadget_wakeup(dwc, false);
>> +		if (ret) {
>> +			spin_unlock_irqrestore(&dwc->lock, flags);
>> +			return -EINVAL;
>> +		}
>> +		dwc3_resume_gadget(dwc);
>> +		dwc->link_state = DWC3_LINK_STATE_U0;
>> +	}
>> +
>> +	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
>> +					       0x1 | (interface_id << 4));
> 
> Create a macro for 0x1. Something like DWC3_DGCMDPAR_DN_FUNC_WAKE. Also,
> create an macro for interface selection. Maybe
> DWC3_DGCMDPAR_INTF_SEL(interface_id).
> 
Sure.

>> +	if (ret)
>> +		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
>> +
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>> +	return ret;
>> +}
>> +
>>   static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>   		int is_selfpowered)
>>   {
>> @@ -3012,6 +3045,7 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
>>   static const struct usb_gadget_ops dwc3_gadget_ops = {
>>   	.get_frame		= dwc3_gadget_get_frame,
>>   	.wakeup			= dwc3_gadget_wakeup,
>> +	.func_wakeup		= dwc3_gadget_func_wakeup,
>>   	.set_selfpowered	= dwc3_gadget_set_selfpowered,
>>   	.pullup			= dwc3_gadget_pullup,
>>   	.udc_start		= dwc3_gadget_start,
>> -- 
>> 2.7.4
>>
> 
> Thanks,
> Thinh
