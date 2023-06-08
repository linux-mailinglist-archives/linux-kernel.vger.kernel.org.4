Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8577285A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjFHQqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjFHQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:45:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D184125
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 09:45:33 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358GbIQs000372;
        Thu, 8 Jun 2023 16:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=X36n1Ub6Wok83kfuRc6al1XAx2kj5zm7pu2n9i67kZ4=;
 b=lKZiZYkTxg5c3AWJjwnyxA/5x4edN0ylH+4OlrjTysWhBl0eWuc5g6REXdRdrPKe7Q5c
 YtRby9zahcqvnCY8eWXYU64JlqaBqyvIzFPRaF4rACOUUMcL/F/5ufzOGHN4cwkANJQZ
 MhK6t90DhKRrICl/wfIeyhEJ5h30qC26ApwThSEfqU7HXIFd9oBBNdMjZ9tXjOyMIF4s
 H0E1EaZziUjGjsBX5Z0839ZgNcBvPYRADO5FxKDCY9u6NJdG79gSFuD6bpZalkeXzg6+
 sbSpKidtzgpGWMPbbFxKG5hab3Gf0/C0Jm2c7+ucKkULNuDESFBOWIPjqcIhouqHBTXZ 1Q== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r3jnrrj88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 16:45:19 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 358D4L8r022067;
        Thu, 8 Jun 2023 16:44:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3r2a781n6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 16:44:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 358GiJbA38928934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Jun 2023 16:44:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E2CB5805A;
        Thu,  8 Jun 2023 16:44:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BB2458063;
        Thu,  8 Jun 2023 16:44:19 +0000 (GMT)
Received: from [9.61.102.249] (unknown [9.61.102.249])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  8 Jun 2023 16:44:19 +0000 (GMT)
Message-ID: <c494b420-21de-eb96-aa29-859c9418e887@linux.ibm.com>
Date:   Thu, 8 Jun 2023 11:44:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] fsi: core: Fix legacy minor numbering
To:     Joel Stanley <joel@jms.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jk@ozlabs.org, alistair@popple.id.au
References: <20230413162440.3313036-1-eajames@linux.ibm.com>
 <CACPK8Xdzjh3YATzuA+JB_PpzE-uJsbD+vL2Q3tUf83xYbto8vw@mail.gmail.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CACPK8Xdzjh3YATzuA+JB_PpzE-uJsbD+vL2Q3tUf83xYbto8vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xz4FzYr_w0392fTnNeEQ6L3VcIxMDDzV
X-Proofpoint-ORIG-GUID: Xz4FzYr_w0392fTnNeEQ6L3VcIxMDDzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_12,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080145
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/23 20:54, Joel Stanley wrote:
> On Thu, 13 Apr 2023 at 16:24, Eddie James <eajames@linux.ibm.com> wrote:
>> FSI reserves the first 64 minor numbers for the legacy numbering
>> based on the chip id. However the legacy number shifts the chip
>> id too much, resulting in overlap between legacy and non-legacy
>> numbers. Reduce the chip id bit shift since the type field only
>> takes 2 bits.
> I don't know much about the legacy numbering. Was that something we
> used before the device tree descriptions were in place? Do we still
> need it if we have updated device trees?


Its a way to number the devices based on the "chip id", which came from 
the device tree anyway. Now with the aliasing patch we could do away 
with it I believe, but we would need to update older system device trees 
(and scom devices on p10) to not break stuff.

>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/fsi/fsi-core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>> index 0b927c9f4267..b9f410170655 100644
>> --- a/drivers/fsi/fsi-core.c
>> +++ b/drivers/fsi/fsi-core.c
>> @@ -950,7 +950,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
>>          /* Check if we qualify for legacy numbering */
>>          if (cid >= 0 && cid < 16 && type < 4) {
>>                  /* Try reserving the legacy number */
> Would it help to put some of your commit message info in this comment,
> so we know what the magic shift is doing?


Sure thing.

Thanks,

Eddie


>
>> -               id = (cid << 4) | type;
>> +               id = (cid << 2) | type;
>>                  id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
>>                  if (id >= 0) {
>>                          *out_index = fsi_adjust_index(cid);
>> --
>> 2.31.1
>>
