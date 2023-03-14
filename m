Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DCA6BA11E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 22:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCNVDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 17:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjCNVDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 17:03:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70498392BF;
        Tue, 14 Mar 2023 14:03:28 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EKo6Yf011046;
        Tue, 14 Mar 2023 21:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=CL+md/03GKqUxJrYuvso/YSl30J//F1oBll9lY5hqQc=;
 b=fy8kTlv9RDqig4N+uG9OY/82QCel+WDrOWmHtRmh47sKMEK3xfw/NfSsOkJk9ThjAe2y
 FrOUw+6c5OGHrtKbOKND4E1Hj8QC4HXS5hNJYnTHvIeIPDL/kwuS1kF4L1u1MDHDl/K4
 gPH9TcM1dq2eZ9dm9SYQVjcvTkqt+iT0a/ChYhUlXk48+uHnkIfSkvmcxc5WVjpObeeV
 1lCoyHCkZoPBO9NKXlD7L1yWK5TafqrsyYx429tH4Tdcvhyue7MLhmlx8jnWqrbheEuP
 GaW8bMQ1EpGWruWdgkllOF9X4O0q//Srg0e5EQpotCbk4YpRUq4RsjEXWKncEY2g0NBC kw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3paxy1r69n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 21:03:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32EL3NB0029963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 21:03:23 GMT
Received: from [10.110.76.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 14 Mar
 2023 14:03:22 -0700
Message-ID: <c90f9af3-5e1c-c249-6dac-1387511f4fdf@quicinc.com>
Date:   Tue, 14 Mar 2023 14:03:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1678731892-20503-1-git-send-email-quic_eserrao@quicinc.com>
 <1678731892-20503-6-git-send-email-quic_eserrao@quicinc.com>
 <20230313202655.srqfddpn5r36zt3o@synopsys.com>
 <7064988c-9975-64c3-25c6-e1330ed723a4@quicinc.com>
 <20230314201636.mfmjrgluckyk5xhy@synopsys.com>
 <20230314204510.4n72sdm2xk3viy3e@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230314204510.4n72sdm2xk3viy3e@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: U3G1y4v6C0xxkdYf2cqdrozNgL1xhzvU
X-Proofpoint-GUID: U3G1y4v6C0xxkdYf2cqdrozNgL1xhzvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_14,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303140168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/2023 1:45 PM, Thinh Nguyen wrote:
> On Tue, Mar 14, 2023, Thinh Nguyen wrote:
>> On Tue, Mar 14, 2023, Elson Serrao wrote:
>>>
>>>
>>> On 3/13/2023 1:27 PM, Thinh Nguyen wrote:
>>>> On Mon, Mar 13, 2023, Elson Roy Serrao wrote:
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
>>>>>    drivers/usb/gadget/function/f_ecm.c   | 68 +++++++++++++++++++++++++++++++++++
>>>>>    drivers/usb/gadget/function/u_ether.c | 63 ++++++++++++++++++++++++++++++++
>>>>>    drivers/usb/gadget/function/u_ether.h |  4 +++
>>>>>    3 files changed, 135 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>>>>> index a7ab30e..d50c1a4 100644
>>>>> --- a/drivers/usb/gadget/function/f_ecm.c
>>>>> +++ b/drivers/usb/gadget/function/f_ecm.c
>>>>> @@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
>>>>>    	usb_ep_disable(ecm->notify);
>>>>>    	ecm->notify->desc = NULL;
>>>>> +	f->func_suspended = false;
>>>>> +	f->func_wakeup_armed = false;
>>>>>    }
>>>>>    /*-------------------------------------------------------------------------*/
>>>>> @@ -885,6 +887,68 @@ static struct usb_function_instance *ecm_alloc_inst(void)
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
>>>>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>>>>> +		USB_INTRF_STAT_FUNC_RW_CAP;
>>>>
>>>> Need to check the usb configuration is if it's wakeup_capable.
>>>>
>>>>> +}
>>>>> +
>>>>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>>>>> +{
>>>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>>>> +
>>>>> +	DBG(cdev, "func susp %u cmd\n", options);
>>>>> +
>>>>> +	f->func_wakeup_armed = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
>>>>
>>>> Same here. Check config's bmAttributes if it's remote wakeup capable
>>>> before arming for remote wakeup.
>>>>
>>> Done. I will add that check for above two cases.
>>>>> +
>>>>> +	if (options & (USB_INTRF_FUNC_SUSPEND_LP >> 8)) {
>>>>> +		if (!f->func_suspended) {
>>>>> +			ecm_suspend(f);
>>>>> +			f->func_suspended = true;
>>>>> +		}
>>>>> +	} else {
>>>>> +		if (f->func_suspended) {
>>>>> +			f->func_suspended = false;
>>>>> +			ecm_resume(f);
>>>>> +		}
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>
>>>> Need to return negative error if SetFeature fails. We should fix the
>>>> composite layer to allow for protocal STALL here. Host needs to know if
>>>> it should proceed to put the function in suspend.
>>>>
>>>> Thanks,
>>>> Thinh
>>>>
>>>
>>> Could you please clarify what SetFeature fail here means? The host puts the
>>> function in function suspend state through this SetFeature request.
>>> If the device is not configured for remote wakeup (bmAtrributes wakeup bit),
>>> like you mentioned above we should not arm the function for remote wakeup.
>>> But the host is free to put the function in function suspend state and wake
>>> it up through host initiated function resume right?
>>>
>>
>> I mean if we want to tell the host that a feature cannot be set or that
>> it doesn't exist, we should respond with a protocol STALL. How the host
>> respond to the rejected SetFeature request is up to the host. But we
>> should at least let the host know that.
>>
>> I'm suggesting to remove the setting of value = 0 in composite.c:
>>
>> -- a/drivers/usb/gadget/composite.c
>> +++ b/drivers/usb/gadget/composite.c
>> @@ -2000,7 +2000,6 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>>                                  ERROR(cdev,
>>                                        "func_suspend() returned error %d\n",
>>                                        value);
>> -                               value = 0;
>>                          }
>>                          break;
>>                  }
>>
>>
>> i.e. we should allow the return value to go through.
>>
> 
> Also, I imagine there are cases where we don't want the host to put the
> device in suspend because it lacks remote wakeup. e.g. a HID device such
> as a keyboard (though it's a bit odd to see one without remote wake
> capability)
> 
> Thanks,
> Thinh

Sound good. I will make that change. Would you prefer this change (i.e 
removing value = 0  in composite.c) to be part of this series OR should 
I upload a separate change for this?

Thanks
Elson
