Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCDD6BBFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 23:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjCOWlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 18:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOWl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 18:41:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C6E30B03;
        Wed, 15 Mar 2023 15:41:27 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMaO90026410;
        Wed, 15 Mar 2023 22:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/JOteoeY8Ovl3g0R3Mx0oghv6M/meyhQ5pL1Rms2/Pc=;
 b=Doq4FMG69GV0pQCeIidM0e1RtdYdcK2XODpJCF9Ey9aVgBc/bKfNrMLt4pkOTSVNKwwd
 M+9UpcjSYf3+acAituAa9/PwUqbYXw41JfdWCm/NZC768Tg5FruMcoZKONmjaAZLEj1B
 NqSgVscrk8zN9eNPfF0yFiOyCVcK2TUBTwtxBuCdPpkDtDcphYBVp46oNdlDeXmVobQ0
 6itfownyjpv+5hji4speY3ktoh2bKUgV/ILIk/+IzFqtAe6Jx+gnqtf8w2Ald074cNSq
 yE6W8kFfG2RokmUd/HgBAntu4hzWtyl+HNWn1HGH9WeHqKRaUbHcsp/eBET3BmYWVMSm tQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pbpy3g0cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 22:41:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32FMfM8u017471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 22:41:22 GMT
Received: from [10.110.60.126] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Mar
 2023 15:41:21 -0700
Message-ID: <510cd700-7d2e-2bb6-7b76-4ce8305618ae@quicinc.com>
Date:   Wed, 15 Mar 2023 15:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 5/5] usb: gadget: f_ecm: Add suspend/resume and remote
 wakeup support
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1678908551-27666-1-git-send-email-quic_eserrao@quicinc.com>
 <1678908551-27666-6-git-send-email-quic_eserrao@quicinc.com>
 <20230315194733.yjp5ddymehxm6abl@synopsys.com>
 <20230315211542.z6oc2zfgpnrixgi5@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230315211542.z6oc2zfgpnrixgi5@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V4XudwsUI7yTLagrDarw_OnZ40WYsYcA
X-Proofpoint-ORIG-GUID: V4XudwsUI7yTLagrDarw_OnZ40WYsYcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303150185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 2:15 PM, Thinh Nguyen wrote:
> On Wed, Mar 15, 2023, Thinh Nguyen wrote:
>> On Wed, Mar 15, 2023, Elson Roy Serrao wrote:
>>> When host sends a suspend notification to the device, handle
>>> the suspend callbacks in the function driver. Enhanced super
>>> speed devices can support function suspend feature to put the
>>> function in suspend state. Handle function suspend callback.
>>>
>>> Depending on the remote wakeup capability the device can either
>>> trigger a remote wakeup or wait for the host initiated resume to
>>> start data transfer again.
>>>
>>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>>> ---
>>>   drivers/usb/gadget/function/f_ecm.c   | 77 +++++++++++++++++++++++++++++++++++
>>>   drivers/usb/gadget/function/u_ether.c | 63 ++++++++++++++++++++++++++++
>>>   drivers/usb/gadget/function/u_ether.h |  4 ++
>>>   3 files changed, 144 insertions(+)
>>>
>>> diff --git a/drivers/usb/gadget/function/f_ecm.c b/drivers/usb/gadget/function/f_ecm.c
>>> index a7ab30e..fea07ab 100644
>>> --- a/drivers/usb/gadget/function/f_ecm.c
>>> +++ b/drivers/usb/gadget/function/f_ecm.c
>>> @@ -633,6 +633,8 @@ static void ecm_disable(struct usb_function *f)
>>>   
>>>   	usb_ep_disable(ecm->notify);
>>>   	ecm->notify->desc = NULL;
>>> +	f->func_suspended = false;
>>> +	f->func_wakeup_armed = false;
>>>   }
>>>   
>>>   /*-------------------------------------------------------------------------*/
>>> @@ -885,6 +887,77 @@ static struct usb_function_instance *ecm_alloc_inst(void)
>>>   	return &opts->func_inst;
>>>   }
>>>   
>>> +static void ecm_suspend(struct usb_function *f)
>>> +{
>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>> +
>>> +	if (f->func_suspended) {
>>> +		DBG(cdev, "Function already suspended\n");
>>> +		return;
>>> +	}
>>> +
>>> +	DBG(cdev, "ECM Suspend\n");
>>> +
>>> +	gether_suspend(&ecm->port);
>>> +}
>>> +
>>> +static void ecm_resume(struct usb_function *f)
>>> +{
>>> +	struct f_ecm *ecm = func_to_ecm(f);
>>> +	struct usb_composite_dev *cdev = ecm->port.func.config->cdev;
>>> +
>>> +	/*
>>> +	 * If the function is in USB3 Function Suspend state, resume is
>>> +	 * canceled. In this case resume is done by a Function Resume request.
>>> +	 */
>>> +	if (f->func_suspended)
>>> +		return;
>>> +
>>> +	DBG(cdev, "ECM Resume\n");
>>> +
>>> +	gether_resume(&ecm->port);
>>> +}
>>> +
>>> +static int ecm_get_status(struct usb_function *f)
>>> +{
>>> +	struct usb_configuration *c = f->config;
>>> +
>>> +	/* D0 and D1 bit set to 0 if device is not wakeup capable */
>>> +	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>>> +		return 0;
>>> +
>>> +	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
>>> +		USB_INTRF_STAT_FUNC_RW_CAP;
>>> +}
>>> +
>>> +static int ecm_func_suspend(struct usb_function *f, u8 options)
>>> +{
>>> +	struct usb_configuration *c = f->config;
>>> +
>>> +	DBG(c->cdev, "func susp %u cmd\n", options);
>>> +
>>> +	/* Respond with negative errno if request is not supported */
>>> +	if (!(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>>> +		return -EINVAL;
>>
>> We only need to return early if the host tries to enable remote wake
>> while the device isn't capable of it:
>>
>> 	wakeup_sel = !!(options & (USB_INTRF_FUNC_SUSPEND_RW >> 8));
>> 	if (wakeup_sel && !(USB_CONFIG_ATT_WAKEUP & c->bmAttributes))
>> 		return -EINVAL;
>>
>> 	f->func_wakeup_armed = wakeup_sel;
>>
> 
> Also, I notice that we can't differentiate between ClearFeature() and
> SetFeature() in f->func_suspend(). Perhaps we should handle arming the
> remote wakeup in the composite layer so we can set/clear the remote
> wake. It's common across multiple devices. It's probably better to be
> there.
> 
> Thanks,
> Thinh

Yeah agree with that. We check for function_wakeup_armed flag before 
sending remote wakeup in composite.c. So it makes more sense
to set/reset this flag in composite.c itself. I will make that change
and upload v12 along with fixing 'value = 0' removal that we discussed
earlier. Please let me know if that is fine

Thanks
Elson
