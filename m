Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A504A71F3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjFAUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjFAUXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:23:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3399AE79;
        Thu,  1 Jun 2023 13:23:14 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351JeNJH015302;
        Thu, 1 Jun 2023 20:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W+jeNyPb1+d2e3DhT9PLjOuuWFn2hh9XeemreQjMQG8=;
 b=DOCEkTgW1Zg8E3jan8UeaLT4XFcpLTluhT7jzinR3yeKnNu+LTzKmY9HZM8hvCnNR2ll
 ph5XI3jvhZhqA8hjgX9hXWAq4vrZ7XypiEmal3ps72U7NsjCX8h+wmFBqmdQ+SDBFab6
 XD4KBYek/G9BbhURcX+1jGeuuPm5LM/Mz4Q2huDRpNF4CLNQd7GhyOv0LUSKyn2sEWHy
 gsWfL+C9jxJnJkvzeSpN3IZhwmfV/WQLPgTR+j9ZJxrfG3AsoJEqRSf6Qg7J2yn4Qhr5
 fl6MLXT4cA8iMVFbE2IV5B8hIEwEltZJMAo/xiJhWAPLb6wipqbNNRDbaBz87fN8aOo5 Hw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qy1bcg3g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 20:23:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 351KN67u031675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 20:23:06 GMT
Received: from [10.71.113.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 13:23:06 -0700
Message-ID: <cb090bfb-6ff5-7200-076d-b99dc13a6b71@quicinc.com>
Date:   Thu, 1 Jun 2023 13:23:05 -0700
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
 <38255534-f242-dc06-9216-1568da9b0285@quicinc.com>
 <20230601012953.47xh7meyr2woowpc@synopsys.com>
From:   Elson Serrao <quic_eserrao@quicinc.com>
In-Reply-To: <20230601012953.47xh7meyr2woowpc@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uP_S7e7dcVMFuaE97Hvf1fIGSCoDkGWC
X-Proofpoint-GUID: uP_S7e7dcVMFuaE97Hvf1fIGSCoDkGWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=807 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306010175
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2023 6:30 PM, Thinh Nguyen wrote:
> On Wed, May 31, 2023, Elson Serrao wrote:
>>
>>
>> On 5/31/2023 4:20 PM, Thinh Nguyen wrote:
>>> On Wed, May 31, 2023, Elson Roy Serrao wrote:
>>>> Consider a scenario where cable disconnect happens when there is an active
>>>> usb reqest queued to the UDC. As part of the disconnect we would issue an
>>>> end transfer with no interrupt-on-completion before giving back this
>>>> request. Since we are giving back the request without skipping TRBs the
>>>> num_trbs field of dwc3_request still holds the stale value previously used.
>>>> Function drivers re-use same request for a given bind-unbind session and
>>>> hence their dwc3_request context gets preserved across cable
>>>> disconnect/connect. When such a request gets re-queued after cable connect,
>>>
>>> Why would we preserve the request after a disconnect? The request is
>>> associated with an endpoint, and after disconnect, the endpoint is no
>>> longer valid. Shouldn't the request be freed then?
>>>
>>
>>
>> Function drivers generally allocate usb requests during bind when an
>> endpoint is allocated to it (through usb_ep_autoconfig). These requests are
>> freed when an unbind is called as the function is no longer associated with
>> any end point. The function driver is free to re-use these requests
>> throughout this bind-unbind session. The only restriction is that the
>> function drivers wont be able to queue any requests as long as the endpoint
> 
>> is disabled. But that doesn't enforce function drivers to free the requests
>> with ep_disable(). Even though the endpoint is disabled with cable
>> disconnect, that endpoint is still associated with that particular function
>> driver until that function is unbound.
>>
>> As an example below is how f_ncm driver allocates and frees the requests
>> during bind/unbind
>>
>> Bind()
>> ...
>> ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
>> if (!ep)
>> 	goto fail;
>> ncm->notify = ep;
>>
>> status = -ENOMEM;
>>
>> /* allocate notification request and buffer */
>> ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
>> ...
>>
>> The endpoint is enabled later when set_alt is received and disabled in
>> ncm_disable when the connection goes down (cable disconnect scenario)
>>
>>
>> Unbind()
>> ....
>> kfree(ncm->notify_req->buf);
>> usb_ep_free_request(ncm->notify, ncm->notify_req);
>>
>> I see similar implementation in other function drivers as well. That is,
>> keep the usb requests allocated throughout the bind-unbind session and
>> independent of ep_enable/ep_disable .
>>
>> Thanks
>> Elson
>>
> 
> Thanks for the clarification. Then you just need to reset the num_trbs
> count when giving back the request. Can we do that in
> dwc3_gadget_del_and_unmap_request()?
> 
> Please add a fix tag.


Yes we can just reset num_trbs in dwc3_gadget_del_and_unmap_request. I 
had used skip trb function so that the trb_dequeue pointer and HWO field 
also gets modified accordingly. But we dont really care about it in the 
disconnect path as we reset that in the subsequent ep enable.
Thanks for this suggestion!
I will add a fix tag and re-upload the patch with above modification.

Thanks
Elson
