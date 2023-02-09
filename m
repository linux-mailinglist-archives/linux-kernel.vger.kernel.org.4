Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01768FF98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBIFCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjBIFCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:02:09 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78D519F14;
        Wed,  8 Feb 2023 21:02:05 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3194Ubre032322;
        Thu, 9 Feb 2023 05:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wdJ6uGLfrcc8yxhlQyk6ZtAtxaYH1Fl/TXAVynWAwBU=;
 b=ReY8rfl6Sl+8V/ELK9iCWn2TY2tpiOdrKRM3NHUSeo1zbRxulaYLCy+h+WpktF/4/ROR
 y/We7q3zsY+z3kO14ssQr2MDEHgGDrvPmyjGNIlygBUubl6cFhEPYY3RwbVFwiCqbZls
 nT0dvKdoq7jrkSGw1oTmW5PGCHXs6n9ktiwWY9O5EDaUleczoW8h9vTqcJIRIIqDhCwZ
 uic26hgS7AnpUtIeWgasqivPIXBmIKS+94WQXZSOxrxdZfJStBCK8EP60zCuCD6FIeRr
 3+PUxsH6ujvh09/c1rPW7JAu/KOu5m6+ccbU/lKtkA8HChMUCJvcJPx+adDZsGSRnjux 6A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nmjm68w50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 05:01:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31951uxj010360
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Feb 2023 05:01:56 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 8 Feb 2023
 21:01:53 -0800
Message-ID: <542ee8a6-598c-ca17-6d75-5eca2b34133a@quicinc.com>
Date:   Thu, 9 Feb 2023 10:31:50 +0530
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
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+QEQBxlr6FZ58DK@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qsl7bELqH_Tr0-sX3a7P_vigQzekmCAg
X-Proofpoint-ORIG-GUID: qsl7bELqH_Tr0-sX3a7P_vigQzekmCAg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_02,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=703 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302090045
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09-02-23 01:51 am, Alan Stern wrote:
> On Wed, Feb 08, 2023 at 09:15:54PM +0530, Prashanth K wrote:
>>
>>
>> On 08-02-23 08:24 pm, Greg Kroah-Hartman wrote:
>>> On Wed, Feb 08, 2023 at 07:24:47PM +0530, Prashanth K wrote:
>>>> Consider a case where gserial_disconnect has already cleared
>>>> gser->ioport. And if a wakeup interrupt triggers afterwards,
>>>> gserial_resume gets called, which will lead to accessing of
>>>> gserial->port and thus causing null pointer dereference.Add
>>>> a null pointer check to prevent this.
>>>>
>>>> Fixes: aba3a8d01d62 (" usb: gadget: u_serial: add suspend resume callbacks")
>>>
>>> Nit, and our tools will complain, no " " before the "usb:" string here,
>>> right?
>>>
>> Will fix it in next patch.
>>>
>>>
>>>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>>>> ---
>>>>    drivers/usb/gadget/function/u_serial.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
>>>> index 840626e..98be2b8 100644
>>>> --- a/drivers/usb/gadget/function/u_serial.c
>>>> +++ b/drivers/usb/gadget/function/u_serial.c
>>>> @@ -1428,6 +1428,9 @@ void gserial_resume(struct gserial *gser)
>>>>    	struct gs_port *port = gser->ioport;
>>>>    	unsigned long	flags;
>>>> +	if (!port)
>>>> +		return;
>>>> +
>>>
>>> What prevents port from going to NULL right after this check?
>> In our case we got a null pointer de-reference while performing USB
>> compliance tests, as the gser->port was null. Because in gserial_resume,
>> spinlock_irq_save(&port->port_lock) accesses a null-pointer as port was
>> already marked null by gserial_disconnect.
>>
>> And after gserial_resume acquires the spinlock, gserial_disconnect cant mark
>> it null until the spinlock is released. We need to check if the port->lock
>> is valid before accessing it, otherwise it can lead to the above mentioned
>> scenario
> 
> What happens if gserial_disconnect sets gser->port to NULL immediately
> after your new check occurs, but before
> spinlock_irq_save(&port->port_lock) gets called?
> 
> You may need to add a static spinlock to prevent this from happening.
> 
> Alan Stern
In that case i guess we have to make port_lock a global variable and 
take it out of gs_port structure.

+ static DEFINE_SPINLOCK(port_lock);

struct gs_port {
	struct tty_port port;
-	spinlock_t port_lock;

This will require us to change all the spinlock(port->port_lock) used in 
u_serial.c, what do you suggest?
