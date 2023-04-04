Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539D36D7013
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 00:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbjDDWXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 18:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDWXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:23:18 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476FDE4E;
        Tue,  4 Apr 2023 15:23:17 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334M9BS1018788;
        Tue, 4 Apr 2023 22:23:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=+Rcn+qMInw/pPu8jH3sfeBE7azrnJBRIL63Fkv1O7Ak=;
 b=h+tmCkLimFMSb4+pPabZuASrhmqFc/jmBdkSZdurockorg/8riF1ITp14TouPqOpxxzq
 7ThA8bXG1l2TO7/EM53EyXnicC8cwgN8G9aB149AB5vu5KBhhDK6dpNmfWE3O6NG7/Cv
 wtqX1cCQkN0u0YRTh5YEiLeVJshRGbm422nYB5amIJPUrfsurgh7kBbrpqoHtLiOQ4UU
 v4BEImsKRsGpRE4D2KDdK/QMtKwl65frW53h+XaktdOxVGJXzNoqsRV6zgvU5XFIJ61A
 z+5tLe/YTLETweR70QxX3zP9ns5pG+pyTEmYls2sIfeSF36jkChqdVAl18Rqa42K0+I9 xQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prpg2117d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 22:23:14 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334MNDq3015720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 22:23:13 GMT
Received: from [10.110.23.136] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 15:23:13 -0700
Message-ID: <f1ff2346-0fd5-2e77-044c-9dc95cd5683f@quicinc.com>
Date:   Tue, 4 Apr 2023 15:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: gadget: Stall and restart EP0 if host is
 unresponsive
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        "quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>
References: <20230331232039.1407-1-quic_wcheng@quicinc.com>
 <20230404011108.727htmnllj7ojwqm@synopsys.com>
 <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
 <20230404221648.5fbajncfhd6wxkku@synopsys.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230404221648.5fbajncfhd6wxkku@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EBz-xJgFwBwBiEaO84jh6pUckyRwSCZT
X-Proofpoint-ORIG-GUID: EBz-xJgFwBwBiEaO84jh6pUckyRwSCZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_12,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040203
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On 4/4/2023 3:16 PM, Thinh Nguyen wrote:
> On Tue, Apr 04, 2023, Wesley Cheng wrote:
>> Hi Thinh,
>>
>> On 4/3/2023 6:11 PM, Thinh Nguyen wrote:
>>> On Fri, Mar 31, 2023, Wesley Cheng wrote:
>>>> It was observed that there are hosts that may complete pending SETUP
>>>> transactions before the stop active transfers and controller halt occurs,
>>>> leading to lingering endxfer commands on DEPs on subsequent pullup/gadget
>>>> start iterations.
>>>
>>> Can you clarify this a bit further? Even though the controller is
>>> halted, you still observed activity?
>>>
>>
>> Yes...I didn't understand how that was possible either, but traces clearly
>> showed that the controller halt was successful even though there were no
>> endxfers issued on some EPs.  Although, I can't say for certain if those EPs
>> were actively being used at that time.
>>
> 
> The controller should only be halted after the (non-ep0) endpoints are
> disabled.
> 
> "even though there were no endxferx issued on some EPs", which EPs are
> you referring to? If there's no End Transfer issued while the endpoints
> are active and started during disconnect, we need to fix that in the
> driver.
> 

Sorry let me clarify.  When I said there were no endxfers issued, I 
meant that they were pending (DWC3_EP_DELAY_STOP is set for those EPs). 
  However, since the host wasn't moving the EP0 state forward, we never 
moved back to the SETUP phase, which is where we flush any pending end 
transfers.

void dwc3_ep0_out_start(struct dwc3 *dwc)
{
...
	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
		struct dwc3_ep *dwc3_ep;

		dwc3_ep = dwc->eps[i];
		if (!dwc3_ep)
			continue;

		if (!(dwc3_ep->flags & DWC3_EP_DELAY_STOP))
			continue;

		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
		if (dwc->connected)
			dwc3_stop_active_transfer(dwc3_ep, true, true);
		else
			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
	}
}

This is part of the reason for moving the wait_for_completion() call 
until AFTER the stop active transfers, since that is the point at which 
we could potentially set the DWC3_EP_DELAY_STOP.  If there is a host not 
moving the EP0 state, then we can at least utilize the timeout path to 
force EP0 back to the setup phase.

Thanks
Wesley Cheng
