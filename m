Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B747285AE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjFHQqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236392AbjFHQq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:46:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A92D2D41
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:46:06 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GeHZe012367;
        Thu, 8 Jun 2023 16:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bqV9AfMSgWxeweMQgKD958byGB5c7rTLSV3DrdPhaSo=;
 b=cVB82dqOfXfUtsdcy6qRG29QebMpYqWj4BJcygDc2ouMg46lVS16cPg8a57XwF2gRJhp
 aka+D2ywBV01d72B+LlfjpzYB3D9GH/oodEevmd6GSYMM8U+pXq6GDT6BgeBcsgeyDO9
 Y4fCnPO5zn/orw+f8p4JjLqZ03SFRiud+VOnRb+B7A4JYlY/ePhhDD2ZW19bFkw/o7Ok
 u/+bNlzVbfdcaM0eUddosaVXlOBhVQ6EXhPOUaY5o+kuXSlHMMCSUqth3OhBL2lC1Fmr
 DoONPmVexsrVNszoqz2pasYOClbF2pnLRGmnlpjkDO+F7Ob845Ia9dQlYr/OOUsjg6HR PQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3jgvrsb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 16:45:58 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 358DKqMX022645;
        Thu, 8 Jun 2023 16:45:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r2a77hn02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 16:45:51 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 358GjoE412648934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 16:45:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 377BB5805E;
        Thu,  8 Jun 2023 16:45:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09DD958052;
        Thu,  8 Jun 2023 16:45:50 +0000 (GMT)
Received: from [9.61.102.249] (unknown [9.61.102.249])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jun 2023 16:45:49 +0000 (GMT)
Message-ID: <25196a3d-865f-8329-0a91-aa74dd0308c0@linux.ibm.com>
Date:   Thu, 8 Jun 2023 11:45:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] fsi: core: Lock scan mutex for master index removal
Content-Language: en-US
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au
References: <20230412185602.1592629-1-eajames@linux.ibm.com>
 <20230412185602.1592629-2-eajames@linux.ibm.com>
 <CACPK8XcK7s44VzkDyA6O3CKKGCfSsV=nmtwkf6YwV-9ZDAx63A@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8XcK7s44VzkDyA6O3CKKGCfSsV=nmtwkf6YwV-9ZDAx63A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rwrgla8_At-3S9RjVRLCMl1LaM51gaz1
X-Proofpoint-ORIG-GUID: rwrgla8_At-3S9RjVRLCMl1LaM51gaz1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_12,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/31/23 02:47, Joel Stanley wrote:
> On Wed, 12 Apr 2023 at 18:56, Eddie James <eajames@linux.ibm.com> wrote:
>> If a master scan occurs while the master is being unregistered,
>> the devicecs may end up with incorrect and possibly duplicate names,
> typo: devices


Thanks...



>
>> resulting in kernel warnings. Ensure the master index isn't changed
>> outside of the scan mutex.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index fcbf0469ce3f..18d4d68482d7 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -1354,12 +1354,12 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
>>
>>   void fsi_master_unregister(struct fsi_master *master)
>>   {
>> +       mutex_lock(&master->scan_lock);
> The ida functions are supposed to not require locking, but protecting
> against the test and changing of ->idx makes sense.
>
> Do you want to add a Fixes: line?


Sure.


>
>>          if (master->idx >= 0) {
>>                  ida_simple_remove(&master_ida, master->idx);
> the ida_simple functions are depreciated, at some point we should
> replace them with ida_alloc/ida_free.


OK, I'll see if it makes sense to do that now.

Thanks!

Eddie


>
>>                  master->idx = -1;
>>          }
>>
>> -       mutex_lock(&master->scan_lock);
>>          fsi_master_unscan(master);
>>          mutex_unlock(&master->scan_lock);
>>          device_unregister(&master->dev);
>> --
>> 2.31.1
>>
