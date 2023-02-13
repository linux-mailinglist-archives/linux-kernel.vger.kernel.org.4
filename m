Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F25693DFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 06:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBMF7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 00:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMF7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 00:59:43 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF5EF93;
        Sun, 12 Feb 2023 21:59:42 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31D4xjxb029934;
        Mon, 13 Feb 2023 05:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Exykwjo/Gz6rxEwLe8v4+JnzMvN2oAmCKplrEOdTm1c=;
 b=P7xHFiX7DbxY4sN6tvanG7TEbePWhGW4r5mJEOfEg/eJy/RYEeegOnyPP6dyJjgs7q+u
 JeiX4m0BlaRODpLYdsoTQLJ1SPR936vLbZBJC2DRzF+jLGX3s3h72mSvE+/C5FdqQaWG
 pUS8m/9rLjJFgUnDwspto2uidO9ONj6Ckwv7ecxq2ONJfXO3wUSQGTCNiMwBOXZUdLbb
 dD8DVnaSYcKVuBJQLivhUu0jKZakQ6zQr+MkwNm21cZO6oDuA70L/mhw9Y/SRwiq3pHl
 DBB9ZPdIduGNgwqjIjjz7GsR9GiOUh1jI4roYHKbmJrCxvku0Y0RXJHWDBcfTN2VTRQs JA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3np3spu3kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 05:59:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31D5xXw7014750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 05:59:33 GMT
Received: from [10.206.28.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 12 Feb
 2023 21:59:30 -0800
Message-ID: <05442a75-8143-2ee9-608f-4ee367801866@quicinc.com>
Date:   Mon, 13 Feb 2023 11:29:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] usb: gadget: u_serial: Add null pointer check in
 gserial_resume
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Pratham Pratap <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1676146033-3948-1-git-send-email-quic_prashk@quicinc.com>
 <Y+f7WaMmsNBHDIcZ@rowland.harvard.edu>
From:   Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <Y+f7WaMmsNBHDIcZ@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7cNfX8O8a7fpasyZfskmQ8fFd76mQtd6
X-Proofpoint-ORIG-GUID: 7cNfX8O8a7fpasyZfskmQ8fFd76mQtd6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_02,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=809 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130054
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12-02-23 02:02 am, Alan Stern wrote:
> On Sun, Feb 12, 2023 at 01:37:13AM +0530, Prashanth K wrote:
>> Consider a case where gserial_disconnect has already cleared
>> gser->ioport. And if a wakeup interrupt triggers afterwards,
>> gserial_resume gets called, which will lead to accessing of
>> gser->ioport and thus causing null pointer dereference.Add
>> a null pointer check to prevent this.
>>
>> Added a static spinlock to prevent gser->ioport from becoming
>> null after the newly added check.
>>
>> Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
>> Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
>> ---
> 
> This looks pretty good, except for a couple of small things...
> 
>> v3: Fixed the spin_lock_irqsave flags.
>>
>>   drivers/usb/gadget/function/u_serial.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
>> index 840626e..471087f 100644
>> --- a/drivers/usb/gadget/function/u_serial.c
>> +++ b/drivers/usb/gadget/function/u_serial.c
>> @@ -82,6 +82,8 @@
>>   #define WRITE_BUF_SIZE		8192		/* TX only */
>>   #define GS_CONSOLE_BUF_SIZE	8192
>>   
>> +static DEFINE_SPINLOCK(serial_port_lock);
> 
> You might put a short comment before this line, explaining what the
> purpose of serial_port_lock is.  Otherwise people will wonder what it is
> for.
That's right, will do it.
> 
>> +
>>   /* console info */
>>   struct gs_console {
>>   	struct console		console;
>> @@ -1370,13 +1372,15 @@ EXPORT_SYMBOL_GPL(gserial_connect);
>>   void gserial_disconnect(struct gserial *gser)
>>   {
>>   	struct gs_port	*port = gser->ioport;
>> -	unsigned long	flags;
>> +	unsigned long flags;
> 
> Unnecessary whitespace change.  Leave the original code as it is.
> 
>>   
>>   	if (!port)
>>   		return;
> 
> Is it really possible for port to be NULL here?  If it is possible,
> where would gser->ioport be set to NULL?
> 
> And if it's not possible, this test should be removed.
Seems like this is present since the inception of this file, hence I'm 
not exactly sure why it was added. In my opinion lets keep it, so as to 
not cause regressions.
> 
>>   
>> +	spin_lock_irqsave(&serial_port_lock, flags);
>> +
>>   	/* tell the TTY glue not to do I/O here any more */
>> -	spin_lock_irqsave(&port->port_lock, flags);
>> +	spin_lock(&port->port_lock);
>>   
>>   	gs_console_disconnect(port);
>>   
>> @@ -1391,7 +1395,8 @@ void gserial_disconnect(struct gserial *gser)
>>   			tty_hangup(port->port.tty);
>>   	}
>>   	port->suspended = false;
>> -	spin_unlock_irqrestore(&port->port_lock, flags);
>> +	spin_unlock(&port->port_lock);
>> +	spin_unlock_irqrestore(&serial_port_lock, flags);
>>   
>>   	/* disable endpoints, aborting down any active I/O */
>>   	usb_ep_disable(gser->out);
>> @@ -1426,9 +1431,16 @@ EXPORT_SYMBOL_GPL(gserial_suspend);
>>   void gserial_resume(struct gserial *gser)
>>   {
>>   	struct gs_port *port = gser->ioport;
> 
> You shouldn't read gser->ioport here; do it under the protection of the
> static spinlock.  If you do the read here then there will still be a
> data race, because gserial_disconnect() might change the value just as
> you are reading it.
> 
>> -	unsigned long	flags;
>> +	unsigned long flags;
> 
> Again, unnecessary whitespace change.
> 
>>   
>> -	spin_lock_irqsave(&port->port_lock, flags);
>> +	spin_lock_irqsave(&serial_port_lock, flags);
> 
> Here is where you should read gser->ioport.
Yes, understood
> 
>> +	if (!port) {
>> +		spin_unlock_irqrestore(&serial_port_lock, flags);
>> +		return;
>> +	}
>> +
>> +	spin_lock(&port->port_lock);
>> +	spin_unlock(&serial_port_lock);
>>   	port->suspended = false;
>>   	if (!port->start_delayed) {
>>   		spin_unlock_irqrestore(&port->port_lock, flags);
> 
> Alan Stern
