Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DFD71F659
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjFAXEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjFAXEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:04:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADACB193;
        Thu,  1 Jun 2023 16:04:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351MeofL024064;
        Thu, 1 Jun 2023 23:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VBMZ/RX80laZZEUsfa+joAPX4pXl7gMwT6HeOaZg3eE=;
 b=km/UbMrJR7oLxLucygrIyEIhvY96ZKuGHsLOkDjvHnq4H+IKTYGeJl2YgxTdo+iYyliP
 tAsqJCgUDaBFpg550HSWnfrbJsmOSLYq5ufLHkjNrHGpKQXbvnM1IUWagDWRq6kHzQD1
 HbMakFDIRGbXN1dSGcRcrZfRY5ardBErDuJCZv5aVHIwHgo1UOW/xfi2uq6vmRmqvXve
 AbfuL9JzxnPQU58uUny1QsJOilgBhKeYxIROmPVwV7whG+ua+3m07GHRUVG9kMsuZvQh
 wosvvBzBgCWNAMMZ096McLjszGaS/9LwC+O5jrn9L8ZqI798K8OMIO+bzXbphW1DTf8S aA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqyda03r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 23:04:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351N41sv019264
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 23:04:01 GMT
Received: from [10.71.113.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 16:04:00 -0700
Message-ID: <11a60626-2363-e743-8136-3233acf5b85e@quicinc.com>
Date:   Thu, 1 Jun 2023 16:04:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/2] usb: dwc3: Modify runtime pm ops to handle bus
 suspend
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1685141140-26228-1-git-send-email-quic_eserrao@quicinc.com>
 <1685141140-26228-3-git-send-email-quic_eserrao@quicinc.com>
 <20230530225100.wkeai3arwg6cmjjw@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230530225100.wkeai3arwg6cmjjw@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: T7Ik_VDj5goUWLQNBEUXEi9Jr0vbI0i2
X-Proofpoint-GUID: T7Ik_VDj5goUWLQNBEUXEi9Jr0vbI0i2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=822 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010198
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 3:51 PM, Thinh Nguyen wrote:
> Hi,
> 
> On Fri, May 26, 2023, Elson Roy Serrao wrote:
>> For bus suspend scenario we should skip controller halt
>> as we still have the usb cable connected. So modify the
> 
> How can you know when the host requests for resume to wakeup the device?
> We haven't implemented hibernation to handle that. If it's communicated
> through the glue layer specific via the phy's event, then how do you
> plan to make it generic and not specific to your platform?
> 

The wakeup/resume path is platform dependent and is handled by phy 
sideband signalling through an external interrupt. This patch handles 
the dwc3 RT resume once the glue driver resume is triggered for bus 
resume scenario.
According to the dwc3 data book (Section7.2) hibernation is an optional 
feature. So we may not be able to make it generic?
Adding a dt node (say snps,external-wakeup) to distinguish the wakeup 
path and having a check against that flag in the dwc3 RT pm ops to 
handle bus suspend/resume, would that be an acceptable solution ?

Regards
Elson

> The reason we halt the controller and force a soft-disconnect is because
> we don't have a handle for this yet. Perhaps I'm missing something here
> because I don't see you handle it here either.
> 
>> runtime pm ops to handle bus suspend scenario. Also invoke
>> autosuspend when device receives U3 notification so that
>> controller can enter runtime suspended state. Ensure that
>> the controller is brought out of runtime suspend before
>> triggering remote wakeup.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c   | 19 +++++++++++++++++++
>>   drivers/usb/dwc3/gadget.c | 40 +++++++++++++++++++++++++++++++++-------
>>   2 files changed, 52 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 278cd1c..7787805 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -2119,6 +2119,12 @@ static int dwc3_runtime_suspend(struct device *dev)
>>   {
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>> +	u32		reg;
>> +
>> +	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
> 
> This function isn't device mode specific, but you're checking device
> mode specific status here.
> 
Will move this under DEVICE role.

Thanks
Elson
>> +	/* For bus suspend case do not halt the controller */
>> +	if (dwc->connected && (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U3))
>> +		return 0;
>>   
>>   	if (dwc3_runtime_checks(dwc))
>>   		return -EBUSY;
>> @@ -2135,6 +2141,12 @@ static int dwc3_runtime_resume(struct device *dev)
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>>   	int		ret;
>>   
>> +	/* resume from bus suspend */
>> +	if (dwc->connected) {
>> +		dwc3_gadget_process_pending_events(dwc);
>> +		goto resume;
>> +	}
>> +
>>   	ret = dwc3_resume_common(dwc, PMSG_AUTO_RESUME);
>>   	if (ret)
>>   		return ret;
>> @@ -2149,6 +2161,7 @@ static int dwc3_runtime_resume(struct device *dev)
>>   		break;
>>   	}
>>   
>> +resume:
>>   	pm_runtime_mark_last_busy(dev);
>>   
>>   	return 0;
>> @@ -2157,9 +2170,14 @@ static int dwc3_runtime_resume(struct device *dev)
>>   static int dwc3_runtime_idle(struct device *dev)
>>   {
>>   	struct dwc3     *dwc = dev_get_drvdata(dev);
>> +	u32		reg;
>>   
>>   	switch (dwc->current_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_DEVICE:
>> +		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
>> +		/* for bus suspend case return success */
>> +		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U3 && dwc->connected)
>> +			goto autosuspend;
>>   		if (dwc3_runtime_checks(dwc))
>>   			return -EBUSY;
>>   		break;
>> @@ -2169,6 +2187,7 @@ static int dwc3_runtime_idle(struct device *dev)
>>   		break;
>>   	}
>>   
>> +autosuspend:
>>   	pm_runtime_mark_last_busy(dev);
>>   	pm_runtime_autosuspend(dev);
>>   
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 5965796..7587912 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2400,15 +2400,21 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
>>   		return -EINVAL;
>>   	}
>>   
>> -	spin_lock_irqsave(&dwc->lock, flags);
>>   	if (!dwc->gadget->wakeup_armed) {
>>   		dev_err(dwc->dev, "not armed for remote wakeup\n");
>> -		spin_unlock_irqrestore(&dwc->lock, flags);
>>   		return -EINVAL;
>>   	}
>> -	ret = __dwc3_gadget_wakeup(dwc, true);
>>   
>> +	ret = pm_runtime_resume_and_get(dwc->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_set_suspended(dwc->dev);
>> +		return ret;
>> +	}
>> +
>> +	spin_lock_irqsave(&dwc->lock, flags);
>> +	ret = __dwc3_gadget_wakeup(dwc, true);
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	pm_runtime_put_noidle(dwc->dev);
>>   
>>   	return ret;
>>   }
>> @@ -2427,6 +2433,12 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		return -EINVAL;
>>   	}
>>   
>> +	ret = pm_runtime_resume_and_get(dwc->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_set_suspended(dwc->dev);
>> +		return ret;
>> +	}
>> +
>>   	spin_lock_irqsave(&dwc->lock, flags);
>>   	/*
>>   	 * If the link is in U3, signal for remote wakeup and wait for the
>> @@ -2437,6 +2449,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		ret = __dwc3_gadget_wakeup(dwc, false);
>>   		if (ret) {
>>   			spin_unlock_irqrestore(&dwc->lock, flags);
>> +			pm_runtime_put_noidle(dwc->dev);
>>   			return -EINVAL;
>>   		}
>>   		dwc3_resume_gadget(dwc);
>> @@ -2450,6 +2463,7 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
>>   		dev_err(dwc->dev, "function remote wakeup failed, ret:%d\n", ret);
>>   
>>   	spin_unlock_irqrestore(&dwc->lock, flags);
>> +	pm_runtime_put_noidle(dwc->dev);
>>   
>>   	return ret;
>>   }
>> @@ -2711,21 +2725,23 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>   	/*
>>   	 * Avoid issuing a runtime resume if the device is already in the
>>   	 * suspended state during gadget disconnect.  DWC3 gadget was already
>> -	 * halted/stopped during runtime suspend.
>> +	 * halted/stopped during runtime suspend except for bus suspend case
>> +	 * where we would have skipped the controller halt.
>>   	 */
>>   	if (!is_on) {
>>   		pm_runtime_barrier(dwc->dev);
>> -		if (pm_runtime_suspended(dwc->dev))
>> +		if (pm_runtime_suspended(dwc->dev) && !dwc->connected)
>>   			return 0;
>>   	}
>>   
>>   	/*
>>   	 * Check the return value for successful resume, or error.  For a
>>   	 * successful resume, the DWC3 runtime PM resume routine will handle
>> -	 * the run stop sequence, so avoid duplicate operations here.
>> +	 * the run stop sequence except for bus resume case, so avoid
>> +	 * duplicate operations here.
>>   	 */
>>   	ret = pm_runtime_get_sync(dwc->dev);
>> -	if (!ret || ret < 0) {
>> +	if ((!ret && !dwc->connected) || ret < 0) {
>>   		pm_runtime_put(dwc->dev);
>>   		return 0;
>>   	}
>> @@ -4313,6 +4329,8 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
>>   		dwc3_suspend_gadget(dwc);
>>   
>>   	dwc->link_state = next;
>> +	pm_runtime_mark_last_busy(dwc->dev);
>> +	pm_request_autosuspend(dwc->dev);
>>   }
>>   
>>   static void dwc3_gadget_interrupt(struct dwc3 *dwc,
>> @@ -4703,7 +4721,15 @@ void dwc3_gadget_process_pending_events(struct dwc3 *dwc)
>>   {
>>   	if (dwc->pending_events) {
>>   		dwc3_interrupt(dwc->irq_gadget, dwc->ev_buf);
>> +		pm_runtime_put(dwc->dev);
>>   		dwc->pending_events = false;
>>   		enable_irq(dwc->irq_gadget);
>> +		/*
>> +		 * We have only stored the pending events as part
>> +		 * of dwc3_interrupt() above, but those events are
>> +		 * not yet handled. So explicitly invoke the
>> +		 * interrupt handler for handling those events.
>> +		 */
>> +		dwc3_thread_interrupt(dwc->irq_gadget, dwc->ev_buf);
>>   	}
>>   }
>> -- 
>> 2.7.4
>>
> 
> BR,
> Thinh
