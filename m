Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930F76D0C11
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjC3Q72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjC3Q7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:59:24 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB1EFA1;
        Thu, 30 Mar 2023 09:58:59 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UAo6SP021758;
        Thu, 30 Mar 2023 16:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Sv17uhHYgvFpNCoZ7tkCqhGfKmpC9s74Md7rd5hn+0E=;
 b=C9i31WyXgRKJJlnkO/41tBGtf7c1jSiOqx5+LXzju9xHtl+OT9WhHnYBhP2aU5Q+yAbr
 h4KUfTMo24a9gbkIACMC8satoGCPLY9FifJZA6DrpTHc6EyoSnEy1G9NzdqweJm1vU/m
 YrZKo/gbenSg/O5uzRNAJe5YbDXtl41slXscnUd8BFTWk+qKopswaQnE3Smtauj3OR8s
 TdlaHI7Ffo2sV+Jzi/oRcZ18eAreDiHFNZ2yNYprl/dmad6jjMW3foOp8BPx7X5f9YEe
 i5JyqfH2AP8krWe7rqhDh1Tyy0CbEcQktb3r2L5s/xpsmezUzMUcG5hy1UuS5fnX1nbx DQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pn7by99k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 16:58:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32UGwfUK021382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 16:58:42 GMT
Received: from [10.216.63.251] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 30 Mar
 2023 09:58:36 -0700
Message-ID: <4f473d08-156a-622f-2ef2-ad11caa7ccda@quicinc.com>
Date:   Thu, 30 Mar 2023 22:28:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] usb: dwc3: gadget: Bail out in pullup if soft
 reset timeout happens
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230328160756.30520-1-quic_kriskura@quicinc.com>
 <20230328160756.30520-2-quic_kriskura@quicinc.com>
 <20230328212048.rpm4ly265etahwm3@synopsys.com>
 <0aa1caae-ab09-2ef9-0ec8-3dd01a3f3af0@quicinc.com>
 <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230330001003.rwzo4n2hl6i22vh3@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pGAFvm1o4iLy6w29EILGHB3tZgKo8aQj
X-Proofpoint-GUID: pGAFvm1o4iLy6w29EILGHB3tZgKo8aQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_10,2023-03-30_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303300134
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2023 5:40 AM, Thinh Nguyen wrote:
> On Wed, Mar 29, 2023, Krishna Kurapati PSSNV wrote:
>>
>>
>> On 3/29/2023 2:50 AM, Thinh Nguyen wrote:
>>> Hi,
>>>
>>> On Tue, Mar 28, 2023, Krishna Kurapati wrote:
>>>> If the core soft reset timeout happens, avoid setting up event
>>>> buffers and starting gadget as the writes to these registers
>>>> may not reflect when in reset and setting the run stop bit
>>>> can lead the controller to access wrong event buffer address
>>>> resulting in a crash.
>>>>
>>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/gadget.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 3c63fa97a680..f0472801d9a5 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -2620,13 +2620,16 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>>    		 * device-initiated disconnect requires a core soft reset
>>>>    		 * (DCTL.CSftRst) before enabling the run/stop bit.
>>>>    		 */
>>>> -		dwc3_core_soft_reset(dwc);
>>>> +		ret = dwc3_core_soft_reset(dwc);
>>>> +		if (ret)
>>>> +			goto done;
>>>>    		dwc3_event_buffers_setup(dwc);
>>>>    		__dwc3_gadget_start(dwc);
>>>>    		ret = dwc3_gadget_run_stop(dwc, true, false);
>>>>    	}
>>>> +done:
>>>>    	pm_runtime_put(dwc->dev);
>>>>    	return ret;
>>>> -- 
>>>> 2.40.0
>>>>
>>>
>>> I think there's one more place that may needs this check. Can you also
>>> add this check in __dwc3_set_mode()?
>>
>> Hi Thinh,
>>
>>    Sure. Will do it.
>> Will the below be good enough ? Or would it be good to add an error/warn log
>> there>
> 
> There's already a warning message in dwc3_core_soft_reset() if it fails.
> 
>>
>> kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales2/skales/kernel$
>> git diff drivers/usb/
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 476b63618511..8d1d213d1dcd 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -210,7 +210,9 @@ static void __dwc3_set_mode(struct work_struct *work)
>>                  }
>>                  break;
>>          case DWC3_GCTL_PRTCAP_DEVICE:
>> -               dwc3_core_soft_reset(dwc);
>> +               ret = dwc3_core_soft_reset(dwc);
>> +               if (ret)
>> +                       goto out;
>>
>>                  dwc3_event_buffers_setup(dwc);
>>
> 
> If soft-reset failed, the controller is in a bad state. We should not
> perform any further operation until the next hard reset. We should flag
> the controller as dead. I don't think we have the equivalent of the
> host's HCD_FLAG_DEAD. It may require some work in the UDC core. Perhaps
> we can flag within dwc3 for now and prevent any further operation for a
> simpler fix.
> 
Hi Thinh,

  Are you referring that if __dwc3_set_mode failed with core soft reset 
timing out, the caller i.e., dwc3_set_mode who queues the work need to 
know that the operation actually failed. So we can add a flag to 
indicate that gadget is dead and the caller of dwc3_set_mode can check 
the flag to see if the operation is successful or not.

Or am I misunderstanding your comment ?

Regards,
Krishna,
