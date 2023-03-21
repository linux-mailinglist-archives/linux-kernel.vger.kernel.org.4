Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AFC6C3619
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjCUPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjCUPqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:46:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C327D65;
        Tue, 21 Mar 2023 08:45:47 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LEfsn5003037;
        Tue, 21 Mar 2023 15:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QRt10JJxVCPiCHUlVUqOiidSy3l3ySYjEArqbvKwIRQ=;
 b=dFXWV43Hh0eEsaY7TPTjED6tHhuqYSnVSDy9gw+SLc1YEdmOCc1MVTOtHaeQ+PtOr46X
 KQbKZwkIo9oMgN8tZC2r/w2ZDXiubufMKaaaBnR11wo4aNmeGOEQztmhXoukGYLJBDqK
 Er7I30kBO93hoA200eqZXnIAajozKwzLpXmbBv2QxigGn5IMKXAbv81R8mK9rONvvHCH
 8o9eGqI5DjPVnR/jnB2X1O3SRwVDftzztH1Rzi3tfHGVdyFNG/8XDyjvMBSH8riFk+Up
 how1eUHywRZ3Vazd0eQ04A5fzFAC033ardmVN9IkEfBYsNHKFDp4VfulMnzcWLSxBzvZ 7w== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf2j4ae30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:45:22 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32LDcUHB022636;
        Tue, 21 Mar 2023 15:45:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7g46c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 15:45:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32LFjKNC3408572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 15:45:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 359AA58059;
        Tue, 21 Mar 2023 15:45:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3541C58058;
        Tue, 21 Mar 2023 15:45:19 +0000 (GMT)
Received: from [9.160.111.39] (unknown [9.160.111.39])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Mar 2023 15:45:19 +0000 (GMT)
Message-ID: <88ff9cea-4c44-9c65-4f8a-091851099133@linux.ibm.com>
Date:   Tue, 21 Mar 2023 10:45:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] eeprom: ee1004: Enable devices on multiple busses
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, andrew@aj.id.au, joel@jms.id.au,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-2-eajames@linux.ibm.com>
 <CAL_JsqJR2BOX4sk0K3V7-12Pi7Th0G_Dqjfp_MxxoCf0qnNg0A@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAL_JsqJR2BOX4sk0K3V7-12Pi7Th0G_Dqjfp_MxxoCf0qnNg0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5beygrTMhKaWTmuX9ZjQ7pve0joKCkVU
X-Proofpoint-ORIG-GUID: 5beygrTMhKaWTmuX9ZjQ7pve0joKCkVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/21/23 10:39, Rob Herring wrote:
> On Tue, Mar 21, 2023 at 10:17 AM Eddie James <eajames@linux.ibm.com> wrote:
>> The driver previously prevented probing devices on more than one
>> bus due to locking constraints with the special page addresses. This
>> constraint can be removed by allocating a reference-counted bus
>> structure containing the lock, rather than using global variables.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/misc/eeprom/ee1004.c | 175 +++++++++++++++++++++--------------
>>   1 file changed, 106 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
>> index c8c6deb7ed89..950813821087 100644
>> --- a/drivers/misc/eeprom/ee1004.c
>> +++ b/drivers/misc/eeprom/ee1004.c
>> @@ -9,12 +9,15 @@
>>    * Copyright (C) 2008 Wolfram Sang, Pengutronix
>>    */
>>
>> +#include <linux/err.h>
>>   #include <linux/i2c.h>
>>   #include <linux/init.h>
>>   #include <linux/kernel.h>
>> +#include <linux/list.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>> +#include <linux/of_device.h>
> What do you need from here? I don't see anything.
>
> of_device.h is a mess of implicit includes which I'm currently trying
> to detangle. See the ~13 year old comment in it about removing
> of_platform.h include. When I'm done, pretty much only bus
> implementations should include of_device.h.


You're right, I mistakenly thought I needed it for of_device_id. I'll 
remove it in v3.

Thanks,

Eddie


>
> Rob
