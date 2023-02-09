Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B4690DAB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjBIP4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBIP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:56:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1013213D64;
        Thu,  9 Feb 2023 07:56:27 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319EjUDS001321;
        Thu, 9 Feb 2023 15:43:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W1cLg+CjDES0O/ir/J2Qdi835dMv5+SA6UWh1rvoIvE=;
 b=E3530e8HRT8iYSFWQRJAa5+MUKDzGyam+IGpphamX5Ws64xJCcylGjiK9rAhnCc+bsnd
 cmKsG1JRoArev89008xLKtR/YVPI/eFFxEwXW5WP+vhYojtqFCQICsfd/ZAMliD9E1Yd
 RyWyPJK1qNeKDrPlr7qphvIVGix7HLhDC8knlXv1H0e0ZT2tBiVief3kVoxSKnLEXLq6
 EqFt/5B+UrZAGBFHLMPVB2qU4FtPv+RLGG2kSdmr3Ft5elbSpsbqOf8921mlhN8c1Sxr
 5FvyBjdG/Cho2mkYocpkFofZu5x/vHDr61Y2qI/edecg/IQPHJttrYoAiQzT9m5Z3N/y sA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmg9ejnvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 15:43:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 319Fhi4Z022282
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 15:43:44 GMT
Received: from [10.216.12.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 07:43:41 -0800
Message-ID: <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
Date:   Thu, 9 Feb 2023 21:13:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        "Jack Pham" <quic_jackp@quicinc.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AsVWGL5225m9E03C9TwVYuzo3jq7IfDF
X-Proofpoint-ORIG-GUID: AsVWGL5225m9E03C9TwVYuzo3jq7IfDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=304
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090148
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-02-23 08:39 pm, Alan Stern wrote:
> On Thu, Feb 09, 2023 at 07:37:01PM +0530, Prashanth K wrote:
>>
>>
>> On 09-02-23 12:33 pm, Prashanth K wrote:
>>>
>>>
>>> On 09-02-23 12:31 pm, Greg Kroah-Hartman wrote:
>>>> On Thu, Feb 09, 2023 at 10:31:50AM +0530, Prashanth K wrote:
>>>>> In that case i guess we have to make port_lock a global variable
>>>>> and take it
>>>>> out of gs_port structure.
>>>>>
>>>>> + static DEFINE_SPINLOCK(port_lock);
>>>>>
>>>>> struct gs_port {
>>>>>      struct tty_port port;
>>>>> -    spinlock_t port_lock;
>>>>>
>>>>> This will require us to change all the spinlock(port->port_lock) used in
>>>>> u_serial.c, what do you suggest?
>>>>
>>>> Yes, that would be the correct thing to do.
>> Hi Greg/Alan, One general doubt, if we make the spinlock static/global,
>> wouldn't that be a problem when there are multiple instances, and also
>> multiple interfaces can use u_serial at same time. Asking this because
>> u_serial can be used by f_serial (gser) as well as f_acm (acm).
> 
> You should consider having _two_ spinlocks: One in the gs_port structure
> (the way it is now) and a separate global lock.  The first would be used
> in situations where you know you have a valid pointer.  The second would
> be used in situations where you don't know if the pointer is non-NULL
> or where you are changing the pointer's value.
Lets say we replaced the existing spinlock in gserial_resume and 
gserial_disconnect with a new static spinlock, and kept the spinlocks in 
other functions unchanged. In that case, wouldn't it cause additional 
race conditions as we are using 2 different locks.

Thanks,
Prashanth K
> 
> Alan Stern
