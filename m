Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7556A55F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjB1JhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1JhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:37:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F165C29E30;
        Tue, 28 Feb 2023 01:36:59 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S6wqPi010092;
        Tue, 28 Feb 2023 09:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f9iJEgKBIWtE12yxfvC3PM2+H0C+9MQfImj1Ex4J4kU=;
 b=S9Z28mtI7Cd8iBn8ilXGOG/ss7q5Q+JFX8WcSy8aLGqktU1yaumpxB6JJnNrmR3u3DKS
 jd/O4dp3Dm5aNssGEOffvcCPb8WuJ4i1HOAU3FnfmSSD5CrDcG3GZJyDPidwCS5kyk1e
 TcMQPvF5xmR3rtbJKgFhCcQN1je3FHDqJNxNZ6RejcTuHt8sj7nProat3kqRylPWgGKb
 Yw4ABnrwlC3DTwC4VpH9WVl11nYVbadstQ9N89b4eBl/1/bhqyyEkq81tsZ4tUsrN7Sc
 wXnq2YtXVok0P5V2+nBavsjisZY7qW7Z2zY7eflpgzBaOIN1Hf/gPlgwC20GwD3tOGi7 sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1csvrde5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:36:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31S9auQq003345
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:36:56 GMT
Received: from [10.110.31.193] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 01:36:55 -0800
Message-ID: <d01e243e-1ba2-b9cf-2b74-f77f22b5c624@quicinc.com>
Date:   Tue, 28 Feb 2023 01:36:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Add 100uS delay after end transfer
 command without IOC
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <20230227232035.13759-1-quic_wcheng@quicinc.com>
 <20230228021925.j5bquwnwuvog3hx6@synopsys.com>
 <20230228031027.ghrfnda5lkt7qfmt@synopsys.com>
 <24af4a1b-0cc5-e65b-ac66-f767f891520e@quicinc.com>
 <20230228035625.rrda7hpitfrfx34z@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230228035625.rrda7hpitfrfx34z@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0dY_00VpvJP09Qw3MKlOEtSV061EgpZy
X-Proofpoint-ORIG-GUID: 0dY_00VpvJP09Qw3MKlOEtSV061EgpZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280076
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 2/27/2023 8:02 PM, Thinh Nguyen wrote:
> On Mon, Feb 27, 2023, Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 2/27/2023 7:10 PM, Thinh Nguyen wrote:
>>> On Tue, Feb 28, 2023, Thinh Nguyen wrote:
>>>> On Mon, Feb 27, 2023, Wesley Cheng wrote:
>>>>> Previously, there was a 100uS delay inserted after issuing an end transfer
>>>>> command for specific controller revisions.  This was due to the fact that
>>>>> there was a GUCTL2 bit field which enabled synchronous completion of the
>>>>> end transfer command once the CMDACT bit was cleared in the DEPCMD
>>>>> register.  Since this bit does not exist for all controller revisions, add
>>>>> the delay back in.
>>>>>
>>>>> An issue was seen where the USB request buffer was unmapped while the DWC3
>>>>> controller was still accessing the TRB.  However, it was confirmed that the
>>>>> end transfer command was successfully submitted. (no end transfer timeout)
>>>>
>>>> Currently we only check for command active, not completion on teardown.
>>>>
>>>>> In situations, such as dwc3_gadget_soft_disconnect() and
>>>>> __dwc3_gadget_ep_disable(), the dwc3_remove_request() is utilized, which
>>>>> will issue the end transfer command, and follow up with
>>>>> dwc3_gadget_giveback().  At least for the USB ep disable path, it is
>>>>> required for any pending and started requests to be completed and returned
>>>>> to the function driver in the same context of the disable call.  Without
>>>>> the GUCTL2 bit, it is not ensured that the end transfer is completed before
>>>>> the buffers are unmapped.
>>>>>
>>>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>>>
>>>> This is expected. We're supposed to make sure the End Transfer command
>>>> complete before accessing the request. Usually on device/endpoint
>>>> teardown, the gadget drivers don't access the stale/incomplete requests
>>>> with -ESHUTDOWN status. There will be problems if we do, and we haven't
>>>> fixed that.
>>>>
>>>> Adding 100uS may not apply for every device, and we don't need to do
>>>> that for every End Transfer command. Can you try this untested diff
>>>> instead:
>>>>
>>
>> Thanks for the code suggestion.
>>
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 30408bafe64e..5ae5ff4c8858 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -1962,6 +1962,34 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
>>>>    	return DWC3_DSTS_SOFFN(reg);
>>>>    }
>>>> +static int dwc3_poll_ep_completion(struct dwc3_ep *dep)
>>>> +{
>>>> +	if (!list_empty(&dep->started_list)) {
>>>> +		struct dwc3_request *req;
>>>> +		int timeout = 500;
>>>> +
>>>> +		req = next_request(&dep->started_list);
>>>> +		while(--timeout) {
>>>> +			/*
>>>> +			 * Note: don't check the last enqueued TRB in case
>>>> +			 * of short transfer. Check first TRB of a started
>>>> +			 * request instead.
>>>> +			 */
>>>> +			if (!(req->trb->ctrl & DWC3_TRB_CTRL_HWO))
>>>> +				break;
>>>> +
>>>> +			udelay(2);
>>>> +		}
>>>> +		if (!timeout) {
>>>> +			dev_warn(dep->dwc->dev,
>>>> +				 "%s is still in-progress\n", dep->name);
>>>> +			return -ETIMEDOUT;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /**
>>>>     * __dwc3_stop_active_transfer - stop the current active transfer
>>>>     * @dep: isoc endpoint
>>>> @@ -2003,10 +2031,12 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>>>    	WARN_ON_ONCE(ret);
>>>>    	dep->resource_index = 0;
>>>> -	if (!interrupt)
>>>> +	if (!interrupt) {
>>>> +		ret = dwc3_poll_ep_completion(dep);
>>>
>>> Actually, the TRB status may not get updated, so this may not work,
>>> instead of polling, may need to add the delay here instead.
>>>
>>
>> Yeah, I just gave it a try, and I get the ETIMEDOUT error all the time.
>> Don't think we can utilize the HWO bit here.
>>
> 
> I may be over complicating things here. With ForceRM, the controller
> only updates the last TRB it processed. We don't care about performance
> much during teardown. That would mean more codes for something that's
> not need.
> 

Yes :) that is what I encountered as well.  I tried a few other things, 
but it opened a whole new set of topics that needed to be discussed 
further.  Hence why I proposed the simple delay, since this happens only 
in the teardown path as you mentioned.


> Can you add a delay here instead? Make sure it's at least 1ms and
> applicable for dwc_usb32 also.
> 

Sure, I will update the delay to 1ms and also add USB32 check.

Thanks
Wesley Cheng
