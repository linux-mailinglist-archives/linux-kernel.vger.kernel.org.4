Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D9F7362D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjFTEyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjFTEyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:54:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE0DF1;
        Mon, 19 Jun 2023 21:54:07 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K4nSdv000605;
        Tue, 20 Jun 2023 04:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tMbOqLbkGaSzt59019hzF7GgEpt3cvTf1DsQRZdhl58=;
 b=WTFWHT+SX89wLj93dj1a7Tq0DjFWuLG+1BsOY7n6Xvn69wvK0r+7jhaQxC5YQbmO/J4I
 7wkgQLqi/WDzbnscwdaQEepKY3qjW7CEUAFAfnXmAm/qh+0ydw2V4Um6h0+3Jrp5D0bl
 d708MBtZHJlBYHOHZqVNG3hdOu9aMRubZmTSyq2tuUQeeCI9pfaXKVKPZ30jYaWMPB/A
 5ni2QRz7KcddlNoXtMj6eBfCBeH76MqnPkbgkUpIXcsJeOplxBpbAqLKqNmCkLsquXJ0
 jlng8i68l4SVUYUFUtYCpqVwcQo2ejGcZxYO4jWaRo+FPdVF8x9n7nSkQOtAegyzJ/go hg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rarwes2ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 04:54:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35K4s1NL009854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jun 2023 04:54:01 GMT
Received: from [10.217.219.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 19 Jun
 2023 21:53:58 -0700
Message-ID: <7efa451e-2601-f448-af33-b844091db264@quicinc.com>
Date:   Tue, 20 Jun 2023 10:23:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v3] usb: dwc3: gadget: Propagate core init errors to UDC
 during pullup
To:     Johan Hovold <johan@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_ugoswami@quicinc.com>
References: <20230618120949.14868-1-quic_kriskura@quicinc.com>
 <ZI_-c5g20DSJOSu2@hovoldconsulting.com>
 <fca531e0-88ec-ba19-2c11-e8965ac653b2@quicinc.com>
 <ZJBvBE-xy2X_wWO0@hovoldconsulting.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <ZJBvBE-xy2X_wWO0@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5xlJuWBHArZYLgWMTiUDCdVmtxD5AaUm
X-Proofpoint-ORIG-GUID: 5xlJuWBHArZYLgWMTiUDCdVmtxD5AaUm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_02,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200043
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2023 8:36 PM, Johan Hovold wrote:
> On Mon, Jun 19, 2023 at 06:20:43PM +0530, Krishna Kurapati PSSNV wrote:
>> On 6/19/2023 12:36 PM, Johan Hovold wrote:
>>> On Sun, Jun 18, 2023 at 05:39:49PM +0530, Krishna Kurapati wrote:
> 
>>>> @@ -2747,7 +2747,9 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>    	ret = pm_runtime_get_sync(dwc->dev);
>>>>    	if (!ret || ret < 0) {
>>>>    		pm_runtime_put(dwc->dev);
>>>> -		return 0;
>>>> +		if (ret < 0)
>>>> +			pm_runtime_set_suspended(dwc->dev);
>>>
>>> This bit is broken and is also not mentioned or explained in the commit
>>> message. What are you trying to achieve here?
>>>
>>> You cannot set the state like this after runtime PM is enabled and the
>>> above call will always fail.
> 
>> The reason why I an returning ret is because, when the first get_sync
>> fails because of core_init failure and we return 0 instead of ret, the
>> UDC thinks that controller has started successfully but we never set the
>> run stop bit.
> 
> That bit is clear.
> 
>> So when we plug out the cable,  the disconnect event won't
>> be generated and we never send on systems like android the user space
>> will never clear the UDC upon disconnect. Its a sort of mismatch between
>> controller and udc.
> 
> Ok, but the controller is an error state after the resume failure. And
> here you rely on user space to retry gadget activation in order to
> eventually detect the disconnect event?
>   
>> Also once the first get_sync fails, the dwc->dev->power.runtime_error
>> flag is set and successive calls to get_sync always return -EINVAL. In
>> this situation even if UDC/configfs retry pullup, resume_common will
>> never be called and we never actually start the controller or resume
>> dwc->dev.
>>
>> By calling set_suspended, I am trying to clear the runtime_error flag so
>> that the next retry to pullup will call resume_common and retry
>> core_init and set run_stop.
> 
> Ok, thanks, that's the bit I was missing in the commit message.
> 
> First, I perhaps mistakingly thought pm_runtime_set_suspended() may only
> be called with PM runtime disabled, but it appears it may indeed be
> valid to call also after an error but with the caveat that the device
> must then actually be in the suspended state.
> 
> The documentation and implementation is inconsistent here as the kernel
> doc for pm_runtime_set_suspended() clearly states:
> 
> 	It is not valid to call this function for devices with runtime
> 	PM enabled.
> 
> and it also looks like we'd end up with an active-child counter
> imbalance if anyone actually tries to do so.
> 
> But either way, it also seems like the controller is not guaranteed to
> be suspended here as pm_runtime_get_sync() may also fail after a
> previous errors that have left the controller in the active state?
>  > Also, what kind of errors would cause core_init and resume to fail here?
> 
Hi Johan,

   As per the comment just above the get_sync during pullup, the 
resume_common path is used to resume the controller and start peripheral 
mode incase the dwc3 was in suspended state. So if we are entering 
gadget_resume we are in suspended state the first time it is called.

Regarding the errors that might leave controller in active state, I have 
faced issue in core init, and in that function there is a cleanup 
happening in case something fails. So controller was actually not in 
active state after cleanup was done. In resume common, if 
core_init_for_resume is failing, we cleanup everything initialized up 
until that point.

The scenario you mentioned would be applicable in case gadget_resume 
fails. We are not having a return value check and I am not sure what 
would be the side effect of not having that check there. Either ways, 
since it was failing for core init, I went ahead and made this patch.

As per the reason for failure in core init, the following is what was 
happening at customer's end:

1. Cable plug-in
2. get_sync calls resume common which inturn calls core_init
3. core soft reset fails in core init, we cleanup and return -110
4. After applying this patch, the -110 was propagated to UDC properly
5. We got a second call to pullup via connect_control and this time 
reset was successful.

The behavior was similar to [1]. There as well, on all Gen-2 targets, 
after the retry happens I see soft reset is passing but failing for 
first attempt.

[1]: 
https://lore.kernel.org/all/20230510075252.31023-2-quic_kriskura@quicinc.com/

Regards,
Krishna,

> If this is something that you see during normal operation then this
> seems to suggest that something is wrong with the runtime pm
> implementation.
> 
> Note that virtually all drivers treat resume failures as fatal errors
> and do not implement any recovery from that.
> 
> In fact, the only other example of this kind of usage that I could find
> is also for a Qualcomm driver...
> 
> Johan
