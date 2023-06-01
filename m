Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BF4718FC6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFAA5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 20:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjFAA5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 20:57:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474A7119;
        Wed, 31 May 2023 17:57:42 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3510jJjt026755;
        Thu, 1 Jun 2023 00:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=S9xW2FXa8oHpx98ia8cc1fOPh4UByyYSjvylsIzy418=;
 b=C+u0Yg0PSEQrYGg8XqBtryXqT44jzje14zHXr/VEaExicZorKmoS+N4VwOKwXPznBguh
 +FUVXqA6NryUYJfvYbHZItSBrFdL4yYeYap/Y1dZBX6GawnF2cGmQrhEWEt8jTeon+rC
 zb6XIbcBs+Tgc+Dw51wNcFjFVXUuRLChVMkLUPsrrlbagRE3jNx2hjAIba9nPeydIPKE
 SnrRlrB4pMzmpv/OV4M95/8y3HGZPcCDCimfTHxIoR3YGOZWDb5oPnXbRybkIWAAbFIZ
 sxIpiJ2bWB3B06vKB+KsqA4xv52KVy+TzakwK0m55lJiwZdDd0kGPNUo3QCquQRDZTtT NA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8qanmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 00:57:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3510vRFH013733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 00:57:27 GMT
Received: from [10.110.57.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 31 May
 2023 17:57:25 -0700
Message-ID: <38255534-f242-dc06-9216-1568da9b0285@quicinc.com>
Date:   Wed, 31 May 2023 17:57:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: dwc3: Skip TRBs while removing requests in
 disconnect path
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
References: <1685562871-17024-1-git-send-email-quic_eserrao@quicinc.com>
 <20230531231951.vg7x2w7gnnm77alq@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230531231951.vg7x2w7gnnm77alq@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dkHDw27BNv6DOdX_4PNMQglySMuphrGN
X-Proofpoint-GUID: dkHDw27BNv6DOdX_4PNMQglySMuphrGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_18,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010006
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 4:20 PM, Thinh Nguyen wrote:
> On Wed, May 31, 2023, Elson Roy Serrao wrote:
>> Consider a scenario where cable disconnect happens when there is an active
>> usb reqest queued to the UDC. As part of the disconnect we would issue an
>> end transfer with no interrupt-on-completion before giving back this
>> request. Since we are giving back the request without skipping TRBs the
>> num_trbs field of dwc3_request still holds the stale value previously used.
>> Function drivers re-use same request for a given bind-unbind session and
>> hence their dwc3_request context gets preserved across cable
>> disconnect/connect. When such a request gets re-queued after cable connect,
> 
> Why would we preserve the request after a disconnect? The request is
> associated with an endpoint, and after disconnect, the endpoint is no
> longer valid. Shouldn't the request be freed then?
> 


Function drivers generally allocate usb requests during bind when an 
endpoint is allocated to it (through usb_ep_autoconfig). These requests 
are freed when an unbind is called as the function is no longer 
associated with any end point. The function driver is free to re-use 
these requests throughout this bind-unbind session. The only restriction 
is that the function drivers wont be able to queue any requests as long 
as the endpoint is disabled. But that doesn't enforce function drivers 
to free the requests with ep_disable(). Even though the endpoint is 
disabled with cable disconnect, that endpoint is still associated with 
that particular function driver until that function is unbound.

As an example below is how f_ncm driver allocates and frees the requests 
during bind/unbind

Bind()
...
ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
if (!ep)
	goto fail;
ncm->notify = ep;

status = -ENOMEM;

/* allocate notification request and buffer */
ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
...

The endpoint is enabled later when set_alt is received and disabled in 
ncm_disable when the connection goes down (cable disconnect scenario)


Unbind()
....
kfree(ncm->notify_req->buf);
usb_ep_free_request(ncm->notify, ncm->notify_req);

I see similar implementation in other function drivers as well. That is, 
keep the usb requests allocated throughout the bind-unbind session and 
independent of ep_enable/ep_disable .

Thanks
Elson


> 
>> we would increase the num_trbs field on top of the previous stale value
>> thus incorrectly representing the number of TRBs used. Fix this by invoking
>> skip_trbs() in the ep disable path.
>>
>> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
>> ---
>>   drivers/usb/dwc3/gadget.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 578804d..b45e917 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -986,6 +986,8 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>>   	return 0;
>>   }
>>   
>> +static void dwc3_gadget_ep_skip_trbs(struct dwc3_ep *dep, struct dwc3_request *req);
>> +
>>   void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
>>   {
>>   	struct dwc3_request		*req;
>> @@ -1000,6 +1002,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
>>   	while (!list_empty(&dep->started_list)) {
>>   		req = next_request(&dep->started_list);
>>   
>> +		dwc3_gadget_ep_skip_trbs(dep, req);
>>   		dwc3_gadget_giveback(dep, req, status);
>>   	}
>>   
>> @@ -1012,6 +1015,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
>>   	while (!list_empty(&dep->cancelled_list)) {
>>   		req = next_request(&dep->cancelled_list);
>>   
>> +		dwc3_gadget_ep_skip_trbs(dep, req);
>>   		dwc3_gadget_giveback(dep, req, status);
>>   	}
>>   }
>> -- 
>> 2.7.4
