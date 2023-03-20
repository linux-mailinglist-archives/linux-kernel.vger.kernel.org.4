Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1702A6C1E7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCTRs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTRrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:47:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FFC193C1;
        Mon, 20 Mar 2023 10:43:03 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KBtdcj011731;
        Mon, 20 Mar 2023 17:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+/2qr41QLzpsOm3qPCS2tcZdHfvaFfO9fTdkQXdQgl8=;
 b=C3rUxVaRd5KFPfHWA97FM5IDJaVRyz90lPTen60U/VWVFkwz5HOZSf5dH24EtZ8A7sQX
 EBDHS8SHDyfE3ulW8ofp+8shaYL5yM32qb0czoPx4n5pJvPKg4AfHgeds4/abCynwTDO
 vzAMUPx2ETVR9fo4BglWf5Ktg+fecHh6L2qk9HiL9fZh+HoRORhhv5utV0QThoRU/ZAN
 uveoLurKY8h9bPDC/0L1rYwqqma3hnJIW4kMX02urQYj8VWin9wrLikgcnbHpuVw5Fof
 yHxVlZFw4eBnZKJtdPEEv2IUm4VY+RJGBwL4RT+s3HX6UdH5mrlBP46c6i+VrhwTRaWd XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pene1h5w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 17:42:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KHgKAR020086
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 17:42:20 GMT
Received: from [10.71.115.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Mar
 2023 10:42:19 -0700
Message-ID: <da2d298c-19d9-f304-6b1c-f2ecbc816fb6@quicinc.com>
Date:   Mon, 20 Mar 2023 10:42:09 -0700
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
 <2632a958-2750-c057-2606-c2541efff392@quicinc.com>
 <20230318022558.z5v5ktfus5yt4atc@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230318022558.z5v5ktfus5yt4atc@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yU-ecozGRHNudWCBMnlwnZKfkVCi1aYG
X-Proofpoint-GUID: yU-ecozGRHNudWCBMnlwnZKfkVCi1aYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_15,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200150
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/2023 7:26 PM, Thinh Nguyen wrote:
> On Fri, Mar 17, 2023, Elson Serrao wrote:
>>
>>
>> On 3/17/2023 4:20 PM, Thinh Nguyen wrote:
>>> On Fri, Mar 17, 2023, Thinh Nguyen wrote:
>>>> On Fri, Mar 17, 2023, Elson Serrao wrote:
>>>>>
>>>>>
>>>>> On 3/16/2023 5:11 PM, Thinh Nguyen wrote:
>>>>>> On Thu, Mar 16, 2023, Elson Roy Serrao wrote:
>>>>>>> When host sends a suspend notification to the device, handle
>>>>>>> the suspend callbacks in the function driver. Enhanced super
>>>>>>> speed devices can support function suspend feature to put the
>>>>>>> function in suspend state. Handle function suspend callback.
>>>>>>>
>>>>>>> Depending on the remote wakeup capability the device can either
>>>>>>> trigger a remote wakeup or wait for the host initiated resume to
>>>>>>> start data transfer again.
>>>>>>>
>>>>>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>>>>>> ---
>>>>>>>     drivers/usb/gadget/function/f_ecm.c   | 71 +++++++++++++++++++++++++++++++++++
>>>>>>>     drivers/usb/gadget/function/u_ether.c | 63 +++++++++++++++++++++++++++++++
>>>>>>>     drivers/usb/gadget/function/u_ether.h |  4 ++
>>>>>>>     3 files changed, 138 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>>>>>>> index a7ab30e..c43cd557 100644
>>>>>>> --- a/drivers/usb/gadget/function/f_ecm.c
>>>>>>> +++ b/drivers/usb/gadget/function/f_ecm.c
>>>>>>> @@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
>>>>>>>     	usb_ep_disable(ecm->notify);
>>>>>>>     	ecm->notify->desc = NULL;
>>>>>>> +	f->func_suspended = false;
>>>>>>> +	f->func_wakeup_armed = false;
>>>>>>>     }
>>>>>>>     /*-------------------------------------------------------------------------*/
>>>>>>> @@ -885,6 +887,71 @@ static struct usb_function_instance *ecm_alloc_inst(void)
>>>>>>>     	return &opts->func_inst;
>>>>>>>     }
>>>>>>> +static void ecm_suspend(struct usb_function *f)
>>>>>>> +{
>>>>>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>>>>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>>>>>> +
>>>>>>> +	if (f->func_suspended) {
>>>>>>> +		DBG(cdev, "Function already suspended\n");
>>>>>>> +		return;
>>>>>>> +	}
>>>>>>> +
>>>>>>> +	DBG(cdev, "ECM Suspend\n");
>>>>>>> +
>>>>>>> +	gether_suspend(&ecm->port);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void ecm_resume(struct usb_function *f)
>>>>>>> +{
>>>>>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>>>>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * If the function is in USB3 Function Suspend state, resume is
>>>>>>> +	 * canceled. In this case resume is done by a Function Resume request.
>>>>>>> +	 */
>>>>>>> +	if (f->func_suspended)
>>>>>>> +		return;
>>>>>>> +
>>>>>>> +	DBG(cdev, "ECM Resume\n");
>>>>>>> +
>>>>>>> +	gether_resume(&ecm->port);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int ecm_get_status(struct usb_function *f)
>>>>>>> +{
>>>>>>> +	struct usb_configuration *c = f->config;
>>>>>>> +
>>>>>>> +	/* D0 and D1 bit set to 0 if device is not wakeup capable */
>>>>>>> +	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>>>>>>> +		USB_INTRF_STAT_FUNC_RW_CAP;
>>>>>>> +}
>>>>>>
>>>>>> Why do we need to implement ecm_get_status if it's already handled in
>>>>>> composite.c now?
>>>>>>
>>>>>
>>>>> Yes this can be removed now. Will modify accordingly.
>>>>>>> +
>>>>>>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>>>>>>> +{
>>>>>>> +	struct usb_composite_dev *cdev = f->config->cdev;
>>>>>>> +
>>>>>>> +	DBG(cdev, "func susp %u cmd\n", options);
>>>>>>> +
>>>>>>> +	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
>>>>>>
>>>>>> This feature selector doesn't indicate whether it's SetFeature or
>>>>>> ClearFeature request. ecm_func_suspend is supposed to be for
>>>>>> SetFeature(suspend) only. Perhaps we may have to define func_resume()
>>>>>> for ClearFeature(suspend)?
>>>>>>
>>>>
>>>>> Host uses the same feature selector FUNCTION_SUSPEND for function suspend
>>>>> and function resume and func_suspend() callback can be used to
>>>>> handle both the cases ? The distinction comes whether it is a
>>>>
>>>> How do you plan to handle that? Pass this info in some unused/reserved
>>>> bit of the "options" argument? Introduce a new parameter to the
>>>> func_suspend()?
>>>>
>>>> If that's the case, then you need to update the document on
>>>> func_suspend() to also support ClearFeature(suspend). Right now it's
>>>> documented for SetFeature only. Also, make sure that other existing
>>>> function drivers will not break because of the change of the
>>>> func_suspend behavior.
>>>>
>>>>> SetFeature(FUNCTION_SUSPEND) or ClearFeature(FUNCTION_SUSPEND) which can be
>>>>> easily done in the func_suspend callback itself. We can add another callback
>>>>> func_resume specific to ClearFeature(FUNCTION_SUSPEND) but wont that be
>>>>> redundant and more callback handling on function driver/composite side as
>>>>> well? Please let me know your opinion.
>>>>>
>>>>
>>>> We actually didn't properly define func_suspend and its counter part. It
>>>> seems cleaner to me to introduce func_resume as it seems more intuitive
>>>> and easier to read. Let me know how you plan to use func_suspend() for
>>>> both cases.
>>>>
>>>
>>> How about we handle function suspend resume in composite also? I mean
>>> something like this:
>>>
>>> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
>>> index 36add1879ed2..79dc055eb5f7 100644
>>> --- a/drivers/usb/gadget/composite.c
>>> +++ b/drivers/usb/gadget/composite.c
>>> @@ -1948,9 +1948,18 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>>>    		f = cdev->config->interface[intf];
>>>    		if (!f)
>>>    			break;
>>> -		status = f->get_status ? f->get_status(f) : 0;
>>> -		if (status < 0)
>>> -			break;
>>> +
>>> +		if (f->get_status) {
>>> +			status = f->get_status(f);
>>> +			if (status < 0)
>>> +				break;
>>> +		} else {
>>> +			if (f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP) {
>>> +				status |= USB_INTRF_STAT_FUNC_RW_CAP;
>>> +				if (f->func_wakeup_armed)
>>> +					status |= USB_INTRF_STAT_FUNC_RW;
>>> +			}
>>> +		}
>>>    		put_unaligned_le16(status & 0x0000ffff, req->buf);
>>>    		break;
>>>    	/*
>>> @@ -1971,9 +1980,28 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>>>    			f = cdev->config->interface[intf];
>>>    			if (!f)
>>>    				break;
>>> +			if (w_index & USB_INTRF_FUNC_SUSPEND_RW) {
>>> +				if (!(f->config->bmAttributes & USB_CONFIG_ATT_WAKEUP))
>>> +					break;
>>> +
>>> +				f->func_wakeup_armed = (ctrl->bRequest == USB_REQ_SET_FEATURE);
>>> +			}
>>> +
>>>    			value = 0;
>>> -			if (f->func_suspend)
>>> +			if (f->func_suspend) {
>>>    				value = f->func_suspend(f, w_index >> 8);
>>> +			} else if (w_index & USB_INTRF_FUNC_SUSPEND_LP) {
>>> +				if (f->suspend && && !f->func_suspended &&
>>> +				    ctrl->bRequest == USB_REQ_SET_FEATURE)) {
>>> +					f->suspend(f);
>>> +					f->func_suspended = true;
>>> +				} else if (f->resume && f->func_suspended &&
>>> +					   ctrl->bRequest == USB_REQ_CLEAR_FEATURE_FEATURE)) {
>>> +					f->resume(f);
>>> +					f->func_suspended = false;
>>> +				}
>>> +			}
>>> +
>>>    			if (value < 0) {
>>>    				ERROR(cdev,
>>>    				      "func_suspend() returned error %d\n",
>>>
>> At individual function driver level there is no need to differentiate
>> between suspend() and func_suspend() APIs, as both are intended to put the
>> function in suspend state. So your idea/implementation above makes it much
>> more clearer. Let composite also handle this and call either f->suspend() or
>> f->resume() callback based on the setup packet received. Thank you for this
>> suggestion.
>>
>>>
>>> Also, do we need the f->func_suspended flag? we'd need the remote wakeup
>>> flag for the status, but when do we need f->func_suspended? It seems
>>> like it can be handled within the function driver's scope.
>>
>> f->func_suspended flag I had added for below purposes
>>
>> 1.) Function drivers should know the right wakeup() op to be called.
>> That is if they are in FUNC_SUSPEND then call usb_func_wakeup() and if they
>> are in device suspend then call usb_gadget_wakeup(). (we can use
>> f->func_wakeup_armed flag for this purpose as well)
>>
>> 2.) If a function is in USB3 FUNCTION_SUSPEND state then it shouldn't allow
>> f->resume() called through composite_resume() as the exit from
>> FUNCTION_SUSPEND state is via ClearFeature(FUNCTION_SUSPEND).
>>
>> So we need a way to tell function drivers if they are in USB3
>> FUNCTION_SUSPEND state OR device suspend.
> 
> Ok. So do you plan to update composite_resume to check that? Perhaps
> document this expected behavior also?
> 
Yes I will update composite resume to handle this scenario. I was 
handling it in f_ecm till now, but based on this new discussion I will 
move all handling to composite layer.
>>
>> Please let me know if you see any alternative or better approach here.
>>
> 
> If we have a use for it in composite.c, then it should be made
> available. Otherwise it should only exist in the function driver (ie. in
> f_ecm structure).
> 
Yes I will keep it for now. Since we are moving all handling to 
composite layer better to have some kind of flag that function 
drivers/composite layer can use to check if a given function is in 
FUNCTION_SUSPEND state or composite_suspend() state.

Thanks
Elson

