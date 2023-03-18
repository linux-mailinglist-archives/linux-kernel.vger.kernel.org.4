Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D46BF6E6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCRAYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCRAYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:24:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D760E4866;
        Fri, 17 Mar 2023 17:23:56 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32HN6ack006717;
        Sat, 18 Mar 2023 00:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=YbJlbRd8JL1QZiWVWhmE/ZzDI8mZG6GyuQiWnEyG06s=;
 b=kETSDRgYjyYb7aGy0Nqd6EBy99LqQhJ6SLt5c4cTO9PO+/bJKIj9NC8DdcxW7u+gV3sh
 C7muKITMdS8aEl9BJKvjm19rea6BPqBaHsjz4S5Jrv11R1/MneYEPzo/tPibWDCrbhIf
 8SZUykIfWPqnqHm+2IhRE+lwhDj+BXfT9nXtd6xHDOR2WMeLqau38BYdKWymm4t9jNeJ
 lleRlUCfROeIDf+Lkg59Jc4g89ghfzE0FZ4PE8GsRUdBpZASf1MMitlmpgzMrBqMxiLB
 3sX1ld4ufVYKpmJ/a1Oc24KcLC7Mnpz6uNNSuQKDJ0dhUjHtrzJwtrIeLkAnH3tLol5v YQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pce6nkr81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 00:23:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32I0NeBA026158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Mar 2023 00:23:40 GMT
Received: from [10.110.60.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Mar
 2023 17:23:39 -0700
Message-ID: <2632a958-2750-c057-2606-c2541efff392@quicinc.com>
Date:   Fri, 17 Mar 2023 17:23:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v12 6/6] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1679009888-8239-1-git-send-email-quic_eserrao@quicinc.com>
 <1679009888-8239-7-git-send-email-quic_eserrao@quicinc.com>
 <20230317001149.nlvcj2y3fuvq32qt@synopsys.com>
 <0bf5bddd-515b-76b6-f22f-9da10a140d83@quicinc.com>
 <20230317212831.bcapq26jnuk2vkws@synopsys.com>
 <20230317231956.w3kr3zcy44odxdko@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230317231956.w3kr3zcy44odxdko@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hgVwyq6HDxT4RvMPC_OYm9ZzKv7mNncL
X-Proofpoint-GUID: hgVwyq6HDxT4RvMPC_OYm9ZzKv7mNncL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_20,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303180001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/2023 4:20 PM, Thinh Nguyen wrote:
> On Fri, Mar 17, 2023, Thinh Nguyen wrote:
>> On Fri, Mar 17, 2023, Elson Serrao wrote:
>>>
>>>
>>> On 3/16/2023 5:11 PM, Thinh Nguyen wrote:
>>>> On Thu, Mar 16, 2023, Elson Roy Serrao wrote:
>>>>> When host sends a suspend notification to the device, handle
>>>>> the suspend callbacks in the function driver. Enhanced super
>>>>> speed devices can support function suspend feature to put the
>>>>> function in suspend state. Handle function suspend callback.
>>>>>
>>>>> Depending on the remote wakeup capability the device can either
>>>>> trigger a remote wakeup or wait for the host initiated resume to
>>>>> start data transfer again.
>>>>>
>>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>>> ---
>>>>>    drivers/usb/gadget/function/f_ecm.c   | 71 +++++++++++++++++++++++++++++++++++
>>>>>    drivers/usb/gadget/function/u_ether.c | 63 +++++++++++++++++++++++++++++++
>>>>>    drivers/usb/gadget/function/u_ether.h |  4 ++
>>>>>    3 files changed, 138 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>>>>> index a7ab30e..c43cd557 100644
>>>>> --- a/drivers/usb/gadget/function/f_ecm.c
>>>>> +++ b/drivers/usb/gadget/function/f_ecm.c
>>>>> @@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
>>>>>    	usb_ep_disable(ecm->notify);
>>>>>    	ecm->notify->desc = NULL;
>>>>> +	f->func_suspended = false;
>>>>> +	f->func_wakeup_armed = false;
>>>>>    }
>>>>>    /*-------------------------------------------------------------------------*/
>>>>> @@ -885,6 +887,71 @@ static struct usb_function_instance *ecm_alloc_inst(void)
>>>>>    	return &opts->func_inst;
>>>>>    }
>>>>> +static void ecm_suspend(struct usb_function *f)
>>>>> +{
>>>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>>>> +
>>>>> +	if (f->func_suspended) {
>>>>> +		DBG(cdev, "Function already suspended\n");
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	DBG(cdev, "ECM Suspend\n");
>>>>> +
>>>>> +	gether_suspend(&ecm->port);
>>>>> +}
>>>>> +
>>>>> +static void ecm_resume(struct usb_function *f)
>>>>> +{
>>>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>>>> +
>>>>> +	/*
>>>>> +	 * If the function is in USB3 Function Suspend state, resume is
>>>>> +	 * canceled. In this case resume is done by a Function Resume request.
>>>>> +	 */
>>>>> +	if (f->func_suspended)
>>>>> +		return;
>>>>> +
>>>>> +	DBG(cdev, "ECM Resume\n");
>>>>> +
>>>>> +	gether_resume(&ecm->port);
>>>>> +}
>>>>> +
>>>>> +static int ecm_get_status(struct usb_function *f)
>>>>> +{
>>>>> +	struct usb_configuration *c = f->config;
>>>>> +
>>>>> +	/* D0 and D1 bit set to 0 if device is not wakeup capable */
>>>>> +	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>>>>> +		return 0;
>>>>> +
>>>>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>>>>> +		USB_INTRF_STAT_FUNC_RW_CAP;
>>>>> +}
>>>>
>>>> Why do we need to implement ecm_get_status if it's already handled in
>>>> composite.c now?
>>>>
>>>
>>> Yes this can be removed now. Will modify accordingly.
>>>>> +
>>>>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>>>>> +{
>>>>> +	struct usb_composite_dev *cdev = f->config->cdev;
>>>>> +
>>>>> +	DBG(cdev, "func susp %u cmd\n", options);
>>>>> +
>>>>> +	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
>>>>
>>>> This feature selector doesn't indicate whether it's SetFeature or
>>>> ClearFeature request. ecm_func_suspend is supposed to be for
>>>> SetFeature(suspend) only. Perhaps we may have to define func_resume()
>>>> for ClearFeature(suspend)?
>>>>
>>
>>> Host uses the same feature selector FUNCTION_SUSPEND for function suspend
>>> and function resume and func_suspend() callback can be used to
>>> handle both the cases ? The distinction comes whether it is a
>>
>> How do you plan to handle that? Pass this info in some unused/reserved
>> bit of the "options" argument? Introduce a new parameter to the
>> func_suspend()?
>>
>> If that's the case, then you need to update the document on
>> func_suspend() to also support ClearFeature(suspend). Right now it's
>> documented for SetFeature only. Also, make sure that other existing
>> function drivers will not break because of the change of the
>> func_suspend behavior.
>>
>>> SetFeature(FUNCTION_SUSPEND) or ClearFeature(FUNCTION_SUSPEND) which can be
>>> easily done in the func_suspend callback itself. We can add another callback
>>> func_resume specific to ClearFeature(FUNCTION_SUSPEND) but wont that be
>>> redundant and more callback handling on function driver/composite side as
>>> well? Please let me know your opinion.
>>>
>>
>> We actually didn't properly define func_suspend and its counter part. It
>> seems cleaner to me to introduce func_resume as it seems more intuitive
>> and easier to read. Let me know how you plan to use func_suspend() for
>> both cases.
>>
> 
> How about we handle function suspend resume in composite also? I mean
> something like this:
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 36add1879ed2..79dc055eb5f7 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1948,9 +1948,18 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>   		f = cdev->config->interface[intf];
>   		if (!f)
>   			break;
> -		status = f->get_status ? f->get_status(f) : 0;
> -		if (status < 0)
> -			break;
> +
> +		if (f->get_status) {
> +			status = f->get_status(f);
> +			if (status < 0)
> +				break;
> +		} else {
> +			if (f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP) {
> +				status |= USB_INTRF_STAT_FUNC_RW_CAP;
> +				if (f->func_wakeup_armed)
> +					status |= USB_INTRF_STAT_FUNC_RW;
> +			}
> +		}
>   		put_unaligned_le16(status & 0x0000ffff, req->buf);
>   		break;
>   	/*
> @@ -1971,9 +1980,28 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>   			f = cdev->config->interface[intf];
>   			if (!f)
>   				break;
> +			if (w_index & USB_INTRF_FUNC_SUSPEND_RW) {
> +				if (!(f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP))
> +					break;
> +
> +				f->func_wakeup_armed = (ctrl->bRequest == USB_REQ_SET_FEATURE);
> +			}
> +
>   			value = 0;
> -			if (f->func_suspend)
> +			if (f->func_suspend) {
>   				value = f->func_suspend(f, w_index >> 8);
> +			} else if (w_index & USB_INTRF_FUNC_SUSPEND_LP) {
> +				if (f->suspend && && !f->func_suspended &&
> +				    ctrl->bRequest == USB_REQ_SET_FEATURE)) {
> +					f->suspend(f);
> +					f->func_suspended = true;
> +				} else if (f->resume && f->func_suspended &&
> +					   ctrl->bRequest == USB_REQ_CLEAR_FEATURE_FEATURE)) {
> +					f->resume(f);
> +					f->func_suspended = false;
> +				}
> +			}
> +
>   			if (value < 0) {
>   				ERROR(cdev,
>   				      "func_suspend() returned error %d\n",
> 
At individual function driver level there is no need to differentiate 
between suspend() and func_suspend() APIs, as both are intended to put 
the function in suspend state. So your idea/implementation above makes 
it much more clearer. Let composite also handle this and call either 
f->suspend() or f->resume() callback based on the setup packet received. 
Thank you for this suggestion.

> 
> Also, do we need the f->func_suspended flag? we'd need the remote wakeup
> flag for the status, but when do we need f->func_suspended? It seems
> like it can be handled within the function driver's scope.

f->func_suspended flag I had added for below purposes

1.) Function drivers should know the right wakeup() op to be called.
That is if they are in FUNC_SUSPEND then call usb_func_wakeup() and if 
they are in device suspend then call usb_gadget_wakeup(). (we can use 
f->func_wakeup_armed flag for this purpose as well)

2.) If a function is in USB3 FUNCTION_SUSPEND state then it shouldn't 
allow f->resume() called through composite_resume() as the exit from 
FUNCTION_SUSPEND state is via ClearFeature(FUNCTION_SUSPEND).

So we need a way to tell function drivers if they are in USB3 
FUNCTION_SUSPEND state OR device suspend.

Please let me know if you see any alternative or better approach here.

Thanks
Elson
