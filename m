Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7C6D6C99
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjDDSte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbjDDStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:49:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB31A359D;
        Tue,  4 Apr 2023 11:49:30 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334I74Ef018221;
        Tue, 4 Apr 2023 18:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/XEDtOxVDRf5jeupSmh/Dj9ishhaD7Qwu9S6yl+YpXE=;
 b=TdynBAUnLvslTdEep9ujjKBu3/giTVqoaqEpPoxy4H6n0aGZJdz7SeFJfa0FaP9vNtt/
 yJufqD+hVelV0kHGgdzBIb3kSvwvL7TKiUxqdJl0tSOPSrk/ub0n/Tx8WzGwVfxI0BOx
 HjohNYmuf+/oOwMtwGsiW8/hSdZzwS214lCGFn4OwYAzbJB3ia4/w0P4S9SSQloRnYUG
 ukxWAO+CgJfguspkGjJqentlFRDnmaNT7y0KS07iYc5rdaA0QDNBbWXBMaCm3hZK9mQn
 qaK1BmOsP6cQkkGJUmj7xbaKlEvgMG5GRDpHoSdWMT95JytZEL9ciqkJYnYJSTNIK+eL /g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3prnbt0teq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 18:49:28 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 334InP8o023902
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Apr 2023 18:49:25 GMT
Received: from [10.110.23.136] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 4 Apr 2023
 11:49:24 -0700
Message-ID: <c8181845-0f6a-9c6b-69bc-4ce9dabdf041@quicinc.com>
Date:   Tue, 4 Apr 2023 11:49:19 -0700
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
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20230404011108.727htmnllj7ojwqm@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HNH3y1xG_oBRPqkqBpwRhu3DFX7cKEFb
X-Proofpoint-GUID: HNH3y1xG_oBRPqkqBpwRhu3DFX7cKEFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040171
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

On 4/3/2023 6:11 PM, Thinh Nguyen wrote:
> On Fri, Mar 31, 2023, Wesley Cheng wrote:
>> It was observed that there are hosts that may complete pending SETUP
>> transactions before the stop active transfers and controller halt occurs,
>> leading to lingering endxfer commands on DEPs on subsequent pullup/gadget
>> start iterations.
> 
> Can you clarify this a bit further? Even though the controller is
> halted, you still observed activity?
> 

Yes...I didn't understand how that was possible either, but traces 
clearly showed that the controller halt was successful even though there 
were no endxfers issued on some EPs.  Although, I can't say for certain 
if those EPs were actively being used at that time.

>>
>> dwc3_gadget_ep_disable   name=ep8in flags=0x3009  direction=1
>> dwc3_gadget_ep_disable   name=ep4in flags=1  direction=1
>> dwc3_gadget_ep_disable   name=ep3out flags=1  direction=0
>> usb_gadget_disconnect   deactivated=0  connected=0  ret=0
>>
>> The sequence shows that the USB gadget disconnect (dwc3_gadget_pullup(0))
>> routine completed successfully, allowing for the USB gadget to proceed with
>> a USB gadget connect.  However, if this occurs the system runs into an
>> issue where:
>>
>> BUG: spinlock already unlocked on CPU
>>   spin_bug+0x0
>>   dwc3_remove_requests+0x278
>>   dwc3_ep0_out_start+0xb0
>>   __dwc3_gadget_start+0x25c
>>
>> This is due to the pending endxfers, leading to gadget start (w/o lock
>> held) to execute the remove requests, which will unlock the dwc3 spinlock
>> as part of giveback.
>>
>> To mitigate this, resolve the pending endxfers on the pullup disable path
>> by:
>>   1. Re-locating the SETUP phase check after stop active transfers, since
>>   that is where the DWC3_EP_DELAY_STOP is potentially set.  This also allows
>>   for handling of a host that may be unresponsive by using the completion
>>   timeout to trigger the stall and restart for EP0.
>>
>>   2. Do not call gadget stop until the poll for controller halt is
>>   completed.  DEVTEN is cleared as part of gadget stop, so the intention to
>>   allow ep0 events to continue while waiting for controller halt is not
>>   happening.
>>
>> Fixes: c96683798e27 ("usb: dwc3: ep0: Don't prepare beyond Setup stage")
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 101 ++++++++++++++++++++++----------------
>>   1 file changed, 58 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 3c63fa97a680..9715de8e99bc 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -139,6 +139,24 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
>>   	return -ETIMEDOUT;
>>   }
>>   
>> +static void dwc3_ep0_reset_state(struct dwc3 *dwc)
>> +{
>> +	unsigned int	dir;
>> +
>> +	if (dwc->ep0state != EP0_SETUP_PHASE) {
>> +		dir = !!dwc->ep0_expect_in;
>> +		if (dwc->ep0state == EP0_DATA_PHASE)
>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[dir]);
>> +		else
>> +			dwc3_ep0_end_control_data(dwc, dwc->eps[!dir]);
>> +
>> +		dwc->eps[0]->trb_enqueue = 0;
>> +		dwc->eps[1]->trb_enqueue = 0;
>> +
>> +		dwc3_ep0_stall_and_restart(dwc);
>> +	}
>> +}
>> +
> 
> Can we separate refactoring changes other functional changes? It's
> difficult to review with too many things to keep track of.
> 

Sure I can split this into another patch.

Thanks
Wesley Cheng
