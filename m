Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2A574B1E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjGGNjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:39:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2211FF7;
        Fri,  7 Jul 2023 06:39:31 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367DUIf1004101;
        Fri, 7 Jul 2023 13:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NBoUOIsLUqVy/WBSnp0OWqjY9wRFUIsKCOM30ayksCs=;
 b=tEYbF9lpOwhbRDp8wSbuBF5wsjOpdpOlZbC9Z8NmKa0LgTiacqJ9//IBUPTDyYple3tJ
 o07jlrfHKTLEo7/2kWVZY1onigyKRxHo+p87jFIBZSgpBsqbV+kr0iPSqLKLv/aHZ1Cy
 X4TlbfLtmnWwEjoKIr9yd7SccPjAyCwEqWa0j3glRby4ZJ5wDPqD7iuh6kdxyQ/cQjYU
 dAXU5iUS/3ovl+JOve7MR5KgypkgSjd45N9cqGoybDWgmD6jHzM9vQIiYtPoM+54EEZG
 rwMzrCgTSKO5QK9ChoGtZH4q7oSGMKINcNWzO23bS1rJiYvFKdpvsjDO4WCqUydCwNtu Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpkf18q9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:39:29 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 367DY8X1011408;
        Fri, 7 Jul 2023 13:38:47 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rpkf18mqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:38:46 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3673dXGF020748;
        Fri, 7 Jul 2023 13:37:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4v17b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Jul 2023 13:37:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 367DbLj221627554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Jul 2023 13:37:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4B612004B;
        Fri,  7 Jul 2023 13:37:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CE2A20040;
        Fri,  7 Jul 2023 13:37:21 +0000 (GMT)
Received: from [9.171.43.196] (unknown [9.171.43.196])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  7 Jul 2023 13:37:21 +0000 (GMT)
Message-ID: <8ec43fe6-218c-189f-4a90-73e482a0c5ff@linux.ibm.com>
Date:   Fri, 7 Jul 2023 15:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH net v2 1/3] s390/ism: Fix locking for forwarding of IRQs
 and events to clients
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707105622.3332261-1-schnelle@linux.ibm.com>
 <20230707105622.3332261-2-schnelle@linux.ibm.com>
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20230707105622.3332261-2-schnelle@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qjk6yNTpRQAXkbSGQ48l1KT7E9o8tBpo
X-Proofpoint-ORIG-GUID: 1ZdOLnMmS0jK4qfCZt1mmuDNPF8E4ZF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.07.23 12:56, Niklas Schnelle wrote:
[...]
> Instead of expanding the use of the clients_lock further add a separate
> array in struct ism_dev which references clients subscribed to the
> device's events and IRQs. This array is protected by ism->lock which is
> already taken in ism_handle_irq() and can be taken outside the IRQ
> handler when adding/removing subscribers or the accessing

				typo? s/the accessing/accessing the/g

> ism->sba_client_arr[]. This also means that the clients_lock is no
> longer taken in IRQ context.
> 

[...]

> @@ -554,6 +577,7 @@ static void ism_dev_add_work_func(struct work_struct *work)
>  						 add_work);
>  
>  	client->add(client->tgt_ism);
> +	ism_setup_forwarding(client, client->tgt_ism);
>  	atomic_dec(&client->tgt_ism->add_dev_cnt);
>  	wake_up(&client->tgt_ism->waitq);
>  }
> @@ -691,7 +715,11 @@ static void ism_dev_remove_work_func(struct work_struct *work)
>  {
>  	struct ism_client *client = container_of(work, struct ism_client,
>  						 remove_work);
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&client->tgt_ism->lock, flags);
> +	client->tgt_ism->subs[client->id] = NULL;
> +	spin_unlock_irqrestore(&client->tgt_ism->lock, flags);
>  	client->remove(client->tgt_ism);
>  	atomic_dec(&client->tgt_ism->free_clients_cnt);
>  	wake_up(&client->tgt_ism->waitq);

I am not sure I like the new split. here you fix ism_dev_add_work_func() and ism_dev_remove_work_func(),
that you remove in the next patch. But looks functionally ok to me.


Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
