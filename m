Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA18669104B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBIS1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIS1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:27:32 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646652ED6D;
        Thu,  9 Feb 2023 10:27:31 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319ILAwk013462;
        Thu, 9 Feb 2023 18:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KG6eqgvzQN2bR0YnONQMxW/VrLOc5EmMYuKGlarfJao=;
 b=hTor9wIh8ao6WOsQu8tLJHOu4QHdA1SYKK4tM3Z7U7EC0i6dNh0Yhz7PU6+02n8yQC2s
 F3MFOVj037qsvYqUTafosTqvG7VDg/Zd5Yl7zd1tParDzHzKa2NxNUzVG36awQ5Hde6x
 ypWqgBFO0RV7yUTaap9jIgsYQKYjecvwiTNyos8QFnqr2sSqxhK9yo9wQPoMLO5RYvVC
 w+5PC6H3O/2EheRtEtHzRRreQJPk+yUFvybwzJ0fT9ZdHaWSVEP0ad6l6I9jKZdu4B1G
 7Fd4AO9SaLxM9X/Z8kpj1dUHchn1VY3bVkdsEZ6ET+sNabopkchcM/pFljf24EFOiFLP wQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nn61jg0ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 18:27:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 319IROob012271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 18:27:24 GMT
Received: from [10.216.12.28] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 10:27:21 -0800
Message-ID: <71f624df-5302-8276-2a2a-96223d4ba3c7@quicinc.com>
Date:   Thu, 9 Feb 2023 23:57:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675864487-18620-1-git-send-email-quic_prashk@quicinc.com>
 <Y+O3vBbBh4ZwSBWT@kroah.com>
 <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
 <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
 <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TrjRyfxDYRbWM49cSro-eWEy9pojhmnN
X-Proofpoint-GUID: TrjRyfxDYRbWM49cSro-eWEy9pojhmnN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=567
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090173
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-02-23 09:33 pm, Alan Stern wrote:
> On Thu, Feb 09, 2023 at 09:13:37PM +0530, Prashanth K wrote:
>>
>>
>> On 09-02-23 08:39 pm, Alan Stern wrote:
>>> You should consider having _two_ spinlocks: One in the gs_port structure
>>> (the way it is now) and a separate global lock.  The first would be used
>>> in situations where you know you have a valid pointer.  The second would
>>> be used in situations where you don't know if the pointer is non-NULL
>>> or where you are changing the pointer's value.
>> Lets say we replaced the existing spinlock in gserial_resume and
>> gserial_disconnect with a new static spinlock, and kept the spinlocks in
>> other functions unchanged. In that case, wouldn't it cause additional race
>> conditions as we are using 2 different locks.
> 
> Not race conditions, but possibilities for deadlock.
> 
> Indeed, you would have to be very careful about avoiding deadlock
> scenarios.  In particular, you would have to ensure that the code never
> tries to acquire the global spinlock while already holding one of the
> per-port spinlocks.
> 
> Alan Stern
Hi Alan, instead of doing these and causing potential regressions, can 
we just have the null pointer check which i suggested in the beginning? 
The major concern was that port might become null after the null pointer 
check. We mark gser->ioport as null pointer in gserial_disconnect, and 
in gserial_resume we copy the gser->ioport to *port in the beginning.

struct gs_port *port = gser->ioport;

And hence it wont cause null pointer deref after the check as we don't 
de-reference anything from gser->ioport afterwards. We only use the 
local pointer *port afterwards.

Thanks,
Prashanth K
