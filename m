Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649F969187A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjBJGWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjBJGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:22:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A0A5C3;
        Thu,  9 Feb 2023 22:22:39 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31A1W9jW008643;
        Fri, 10 Feb 2023 06:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ar0pYUB3i0YoG/YwnKIWqsXl7gBUQvgaTOSgCRz16U8=;
 b=nClCZk+d9nHsbI+yL+xwspeicErEiI6yQZjWzW7m9lJNeLjv7KJoNkRNu9Qn0VN2QDOZ
 OmZ/UR+UfjaQNm3yjPYABt5kIM0Z+3z3azYBDCU1h8eAsB4X8fZn/lwXephl0H0/4hbb
 M3VTrnn+Bxu529RkeP9BQ6GQxBCoeiTEu2lKng48K+LoPDfWlw7Ts1AiocxZ6JYq8TEm
 k0Gw4MXqoskSx61Vqo0yGRCD4Jg0UfPOfubkfG6GBb5VpyIienSKsh1llv4au9zH9WME
 9ETmS/1wYtx2ESVgdmVkn16/d5VZXY12pQTm/V4V6jb7ER9FFca3idDZpI/bIULm7yw2 Bg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmv9btsdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:22:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31A6MTb4010171
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 06:22:29 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 9 Feb 2023
 22:22:26 -0800
Message-ID: <53d48954-3f7e-fd02-5e8e-2912c16565b3@quicinc.com>
Date:   Fri, 10 Feb 2023 11:52:23 +0530
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
References: <482f2c32-41d1-f07e-ee3f-3eb9aee76ac7@quicinc.com>
 <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
 <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
 <Y+SaZrDmaqB0U2QA@kroah.com>
 <f32398bb-62f3-12fd-4b81-7ce7bdf4706a@quicinc.com>
 <e7dde0aa-c1e2-dd6c-94a1-1e9049f0a5fb@quicinc.com>
 <Y+UMkA9iaJTWVQ5u@rowland.harvard.edu>
 <5ad875be-079c-7f91-ede9-68f954cc7f34@quicinc.com>
 <Y+UZQvuh8KR4gE4P@rowland.harvard.edu>
 <71f624df-5302-8276-2a2a-96223d4ba3c7@quicinc.com>
 <Y+VgHdJjrd0ZvY33@rowland.harvard.edu>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+VgHdJjrd0ZvY33@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vVLrAXiukhYdMFF27msqNqcO3V4KIYpP
X-Proofpoint-ORIG-GUID: vVLrAXiukhYdMFF27msqNqcO3V4KIYpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_01,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=485 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100054
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10-02-23 02:35 am, Alan Stern wrote:
> On Thu, Feb 09, 2023 at 11:57:17PM +0530, Prashanth K wrote:
>>
>>
>> On 09-02-23 09:33 pm, Alan Stern wrote:
>>> On Thu, Feb 09, 2023 at 09:13:37PM +0530, Prashanth K wrote:
>>>>
>>>>
>>>> On 09-02-23 08:39 pm, Alan Stern wrote:
>>>>> You should consider having _two_ spinlocks: One in the gs_port structure
>>>>> (the way it is now) and a separate global lock.  The first would be used
>>>>> in situations where you know you have a valid pointer.  The second would
>>>>> be used in situations where you don't know if the pointer is non-NULL
>>>>> or where you are changing the pointer's value.
>>>> Lets say we replaced the existing spinlock in gserial_resume and
>>>> gserial_disconnect with a new static spinlock, and kept the spinlocks in
>>>> other functions unchanged. In that case, wouldn't it cause additional race
>>>> conditions as we are using 2 different locks.
>>>
>>> Not race conditions, but possibilities for deadlock.
>>>
>>> Indeed, you would have to be very careful about avoiding deadlock
>>> scenarios.  In particular, you would have to ensure that the code never
>>> tries to acquire the global spinlock while already holding one of the
>>> per-port spinlocks.
>>>
>>> Alan Stern
>> Hi Alan, instead of doing these and causing potential regressions, can we
>> just have the null pointer check which i suggested in the beginning? The
>> major concern was that port might become null after the null pointer check.
> 
> What you are describing is a data race: gserial_disconnect() can write
> to gser->ioport at the same time that gserial_resume() reads from it.
> Unless you're working on a fast path -- which this isn't -- you should
> strive to avoid data races by using proper locking.  That means adding
> the extra spinlock, or finding some other way to make these two accesses
> be mutually exclusive.
> 
> With a little care you can ensure there won't be any regressions.  Just
> do what I said above: Make sure the code never tries to acquire the
> global spinlock while already holding one of the per-port spinlocks.
> 
>> We mark gser->ioport as null pointer in gserial_disconnect, and in
>> gserial_resume we copy the gser->ioport to *port in the beginning.
>>
>> struct gs_port *port = gser->ioport;
>>
>> And hence it wont cause null pointer deref after the check as we don't
>> de-reference anything from gser->ioport afterwards. We only use the local
>> pointer *port afterwards.
> 
> You cannot depend on this to work the way you want.  The compiler will
> optimize your source code, and one of the optimizations might be to
> eliminate the "port" variable entirely and replace it with gser->ioport.
> 
> Alan Stern
Hi Alan, Thanks for the detailed info. I checked and included few cases 
here.

This would cause a deadlock if gserial_disconnect acquires port_lock and 
gserial_resume acquires static_lock.

gserial_disconnect {
	spin_lock(port)
	...
	spin_lock(static)

	gser->ioport = NULL;

	spin_unlock(static)
	...
	spin_unlock(port)
}

gserial_resume {
	struct gs_port *port = gser->ioport;

	spin_lock(static)
	if (!port)
		return
	spin_lock(port)
	spin_unlock(static)

	...
	spin_unlock(port)
}

------------------------------------------------------------------

This would cause additional races when gserial_disconnect releases 
port_lock and some other functions acquire it.

gserial_disconnect {
	spin_lock(port)
	...
	spin_unlock(port)
	spin_lock(static)

	gser->ioport = NULL;

	spin_unlock(static)
	spin_lock(port)
	...
	spin_unlock(port)
}

gserial_resume {
	struct gs_port *port = gser->ioport;

	spin_lock(static)
	if (!port)
		return
	spin_lock(port)
	spin_unlock(static)

	...
	spin_unlock(port)
}

------------------------------------------------------------------

And this seems like a viable option to me, what do you suggest?

gserial_disconnect {
	spin_lock(static)
	spin_lock(port)
	...
	gser->ioport = NULL;
	...	
	spin_lock(port)
	spin_unlock(static)

}

gserial_resume {
	struct gs_port *port = gser->ioport;

	spin_lock(static)
	if (!port)
		return
	spin_lock(port)

	...
	spin_unlock(port)
	spin_unlock(static)
}

Thanks,
Prashanth K
