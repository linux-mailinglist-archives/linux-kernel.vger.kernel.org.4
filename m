Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B6468E383
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjBGWmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBGWmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:42:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E020273C;
        Tue,  7 Feb 2023 14:42:04 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317LY0R1006817;
        Tue, 7 Feb 2023 22:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AD0UUFGI6Tt2W68X0PQPPUbuTmmuDnepAmdQ4ojs8F8=;
 b=CMDUzH0aqElyTA8cDvqpil/xYdhe4owr7mvZHftbPvyeXg3gNcVkk0JHeMNcp+2uBiKo
 LIZoq1ZHVNE4P4HJFH6YXXZF9ou+sP53kEDAlJtu8Oeod5Ub7CnzryvkDOQnWRNTaaTa
 jy8YmD0YTvLD/d0keFvyQxwv4yXUCgbxhWNII33oylEyWAK6Uv1fdCER3JIVp0YuyKO2
 EBUf7XKqiUD9G/Ly+LJrV/4AyVoEOMgZPpcgfX62mW2FpwP6+0FIuyPsF5r6XlF6h6CU
 cRkopyKmoI2c5D53TW1s7Bo2Jua1A4U2tpGZX/CN703OGS1TxSCQdfU2MBG1YJ6pvqvB VA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nkdeyaruq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 22:41:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 317Mfv3w011698
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 22:41:57 GMT
Received: from [10.110.65.146] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 7 Feb 2023
 14:41:56 -0800
Message-ID: <9bcf323a-5660-da47-dd6c-b218f7f26a45@quicinc.com>
Date:   Tue, 7 Feb 2023 14:41:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/5] usb: dwc3: Add remote wakeup handling
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1675710806-9735-1-git-send-email-quic_eserrao@quicinc.com>
 <1675710806-9735-3-git-send-email-quic_eserrao@quicinc.com>
 <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230207004833.tuy52evcgk7sfa4q@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C6MbMB7DpMkHg8kqf-5t_kI-GzHq2iKa
X-Proofpoint-GUID: C6MbMB7DpMkHg8kqf-5t_kI-GzHq2iKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_13,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070194
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 4:48 PM, Thinh Nguyen wrote:
> On Mon, Feb 06, 2023, Elson Roy Serrao wrote:
>> An usb device can initate a remote wakeup and bring the link out of
>> suspend as dictated by the DEVICE_REMOTE_WAKEUP feature selector.
>> Add support to handle this packet and set the remote wakeup capability.
>>
>> Some hosts may take longer time to initiate the resume signaling after
>> device triggers a remote wakeup. So add async support to the wakeup API
>> by enabling link status change events.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.h   |  2 ++
>>   drivers/usb/dwc3/ep0.c    |  4 +++
>>   drivers/usb/dwc3/gadget.c | 73 ++++++++++++++++++++++++++++++++++++++++++-----
>>   3 files changed, 72 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index 8f9959b..ff6e6f6 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -1110,6 +1110,7 @@ struct dwc3_scratchpad_array {
>>    *	3	- Reserved
>>    * @dis_metastability_quirk: set to disable metastability quirk.
>>    * @dis_split_quirk: set to disable split boundary.
>> + * @rw_configured: set if the device is configured for remote wakeup.
>>    * @imod_interval: set the interrupt moderation interval in 250ns
>>    *			increments or 0 to disable.
>>    * @max_cfg_eps: current max number of IN eps used across all USB configs.
>> @@ -1326,6 +1327,7 @@ struct dwc3 {
>>   
>>   	unsigned		dis_split_quirk:1;
>>   	unsigned		async_callbacks:1;
>> +	unsigned		rw_configured:1;
>>   
>>   	u16			imod_interval;
>>   
>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>> index 61de693..cd7c0cb 100644
>> --- a/drivers/usb/dwc3/ep0.c
>> +++ b/drivers/usb/dwc3/ep0.c
>> @@ -356,6 +356,9 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
>>   				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
>>   			if (reg & DWC3_DCTL_INITU2ENA)
>>   				usb_status |= 1 << USB_DEV_STAT_U2_ENABLED;
>> +		} else {
>> +			usb_status |= dwc->gadget->rw_armed <<
>> +					USB_DEVICE_REMOTE_WAKEUP;
>>   		}
>>   
>>   		break;
>> @@ -476,6 +479,7 @@ static int dwc3_ep0_handle_device(struct dwc3 *dwc,
>>   
>>   	switch (wValue) {
>>   	case USB_DEVICE_REMOTE_WAKEUP:
>> +		dwc->gadget->rw_armed = set;
>>   		break;
>>   	/*
>>   	 * 9.4.1 says only for SS, in AddressState only for
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89dcfac..d0b9917 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -258,7 +258,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
>>   	return ret;
>>   }
>>   
>> -static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
>> +static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
>>   
>>   /**
>>    * dwc3_send_gadget_ep_cmd - issue an endpoint command
>> @@ -325,7 +325,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>>   
>>   			fallthrough;
>>   		case DWC3_LINK_STATE_U3:
>> -			ret = __dwc3_gadget_wakeup(dwc);
>> +			ret = __dwc3_gadget_wakeup(dwc, false);
>>   			dev_WARN_ONCE(dwc->dev, ret, "wakeup failed --> %d\n",
>>   					ret);
>>   			break;
>> @@ -2269,6 +2269,19 @@ static const struct usb_ep_ops dwc3_gadget_ep_ops = {
>>   
>>   /* -------------------------------------------------------------------------- */
>>   
>> +static void dwc3_gadget_enable_linksts_evts(struct dwc3 *dwc, bool set)
>> +{
>> +	u32 reg;
> 
> Add a check here to prevent disabling link state event if the controller
> is dwc_usb3 2.50a. Some older controller always enables this event for a
> quirk.
> 
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_DEVTEN);
>> +	if (set)
>> +		reg |= DWC3_DEVTEN_ULSTCNGEN;
>> +	else
>> +		reg &= ~DWC3_DEVTEN_ULSTCNGEN;
>> +
>> +	dwc3_writel(dwc->regs, DWC3_DEVTEN, reg);
>> +}
>> +
>>   static int dwc3_gadget_get_frame(struct usb_gadget *g)
>>   {
>>   	struct dwc3		*dwc = gadget_to_dwc(g);
>> @@ -2276,7 +2289,7 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
>>   	return __dwc3_gadget_get_frame(dwc);
>>   }
>>   
>> -static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>> +static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
>>   {
>>   	int			retries;
>>   
>> @@ -2296,9 +2309,14 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>   	link_state = DWC3_DSTS_USBLNKST(reg);
>>   
>>   	switch (link_state) {
>> +	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
> 
> It's also possible to do remote wakeup in L1 for highspeed.
> 

The rw_configured flag here is in context of triggering remote wakeup 
from bus suspend only.

The remote wakeup setting for l1 in HighSpeed is controlled through LPM 
token and overrides/ignores the config desc bmAttributes wakeup bit.

Section 4.1 of USB2_LinkPowerMangement_ECN[final] spec
"The host system sets the Remote Wake Flag parameter in this request to 
enable or disable the addressed device
for remote wake from L1. The value of this flag will temporarily (while 
in L1) override the current setting of the
Remote Wake feature settable by the standard Set/ClearFeature() commands 
defined in Universal Serial Bus Specification, revision 2.0, Chapter 9."

Please let me know if I am missing something.

Thanks
Elson

>> +		if (!dwc->rw_configured) {
>> +			dev_err(dwc->dev,
>> +				"device not configured for remote wakeup\n");
>> +			return -EINVAL;
>> +		}
>>   	case DWC3_LINK_STATE_RESET:
>>   	case DWC3_LINK_STATE_RX_DET:	/* in HS, means Early Suspend */
>> -	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
>>   	case DWC3_LINK_STATE_U2:	/* in HS, means Sleep (L1) */
>>   	case DWC3_LINK_STATE_U1:
>>   	case DWC3_LINK_STATE_RESUME:
>> @@ -2307,9 +2325,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>   		return -EINVAL;
>>   	}
>>   
>> +	if (async)
>> +		dwc3_gadget_enable_linksts_evts(dwc, true);
>> +
>>   	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
>>   	if (ret < 0) {
>>   		dev_err(dwc->dev, "failed to put link in Recovery\n");
>> +		dwc3_gadget_enable_linksts_evts(dwc, false);
>>   		return ret;
>>   	}
>>   
>> @@ -2321,6 +2343,13 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
>>   		dwc3_writel(dwc->regs, DWC3_DCTL, reg);
>>   	}
>>   
>> +	/*
>> +	 * Since link status change events are enabled we will receive
>> +	 * an U0 event when wakeup is successful. So bail out.
>> +	 */
>> +	if (async)
>> +		return 0;
>> +
>>   	/* poll until Link State changes to ON */
>>   	retries = 20000;
>>   
>> @@ -2347,12 +2376,30 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>   	int			ret;
>>   
>>   	spin_lock_irqsave(&dwc->lock, flags);
>> -	ret = __dwc3_gadget_wakeup(dwc);
>> +	if (!dwc->gadget->rw_armed) {
>> +		dev_err(dwc->dev, "%s:remote wakeup not enabled\n", __func__);
>> +		spin_unlock_irqrestore(&dwc->lock, flags);
>> +		return -EINVAL;
>> +	}
>> +	ret = __dwc3_gadget_wakeup(dwc, true);
>> +
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>>   
>>   	return ret;
>>   }
>>   
>> +static int dwc3_gadget_set_remotewakeup(struct usb_gadget *g, int set)
>> +{
>> +	struct dwc3		*dwc = gadget_to_dwc(g);
>> +	unsigned long		flags;
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	dwc->rw_configured = !!set;
>> +	spin_unlock_irqrestore(&dwc->lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>>   static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
>>   		int is_selfpowered)
>>   {
>> @@ -2978,6 +3025,7 @@ static void dwc3_gadget_async_callbacks(struct usb_gadget *g, bool enable)
>>   static const struct usb_gadget_ops dwc3_gadget_ops = {
>>   	.get_frame		= dwc3_gadget_get_frame,
>>   	.wakeup			= dwc3_gadget_wakeup,
>> +	.set_remotewakeup	= dwc3_gadget_set_remotewakeup,
>>   	.set_selfpowered	= dwc3_gadget_set_selfpowered,
>>   	.pullup			= dwc3_gadget_pullup,
>>   	.udc_start		= dwc3_gadget_start,
>> @@ -3821,6 +3869,8 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
>>   
>>   	dwc->gadget->speed = USB_SPEED_UNKNOWN;
>>   	dwc->setup_packet_pending = false;
>> +	dwc->gadget->rw_armed = false;
>> +	dwc3_gadget_enable_linksts_evts(dwc, false);
>>   	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
>>   
>>   	if (dwc->ep0state != EP0_SETUP_PHASE) {
>> @@ -3914,6 +3964,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>   	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
>>   	dwc3_gadget_dctl_write_safe(dwc, reg);
>>   	dwc->test_mode = false;
>> +	dwc->gadget->rw_armed = false;
>> +	dwc3_gadget_enable_linksts_evts(dwc, false);
>>   	dwc3_clear_stall_all_ep(dwc);
>>   
>>   	/* Reset device address to zero */
>> @@ -4066,7 +4118,7 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
>>   	 */
>>   }
>>   
>> -static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
>> +static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc, unsigned int evtinfo)
>>   {
>>   	/*
>>   	 * TODO take core out of low power mode when that's
>> @@ -4078,6 +4130,8 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
>>   		dwc->gadget_driver->resume(dwc->gadget);
>>   		spin_lock(&dwc->lock);
>>   	}
>> +
>> +	dwc->link_state = evtinfo & DWC3_LINK_STATE_MASK;
>>   }
>>   
>>   static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
>> @@ -4159,6 +4213,10 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
>>   	}
>>   
>>   	switch (next) {
>> +	case DWC3_LINK_STATE_U0:
>> +		dwc3_gadget_enable_linksts_evts(dwc, false);
>> +		dwc3_resume_gadget(dwc);
>> +		break;
>>   	case DWC3_LINK_STATE_U1:
>>   		if (dwc->speed == USB_SPEED_SUPER)
>>   			dwc3_suspend_gadget(dwc);
>> @@ -4227,7 +4285,7 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
>>   		dwc3_gadget_conndone_interrupt(dwc);
>>   		break;
>>   	case DWC3_DEVICE_EVENT_WAKEUP:
>> -		dwc3_gadget_wakeup_interrupt(dwc);
>> +		dwc3_gadget_wakeup_interrupt(dwc, event->event_info);
>>   		break;
>>   	case DWC3_DEVICE_EVENT_HIBER_REQ:
>>   		if (dev_WARN_ONCE(dwc->dev, !dwc->has_hibernation,
>> @@ -4487,6 +4545,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
>>   	dwc->gadget->sg_supported	= true;
>>   	dwc->gadget->name		= "dwc3-gadget";
>>   	dwc->gadget->lpm_capable	= !dwc->usb2_gadget_lpm_disable;
>> +	dwc->gadget->rw_capable		= dwc->gadget->ops->wakeup ? true : false;
> 
> Just set it to true here.
> 
>>   
>>   	/*
>>   	 * FIXME We might be setting max_speed to <SUPER, however versions
>> -- 
>> 2.7.4
>>
> 
> Thanks,
> Thinh
