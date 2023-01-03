Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8765C31C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjACPh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjACPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:37:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95E11A3F;
        Tue,  3 Jan 2023 07:37:54 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 303F4Bel023574;
        Tue, 3 Jan 2023 15:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1HebWWOhEKajwexBcr0WiUe2L09PFfQDiNzhHfo5DfI=;
 b=bxdsv4ZdnVzZlac375SXI2YQ7L1cT9EzBIMTScdw3o7zayPPrmQ5dVcKXNWvv5g+8nYW
 xI0auGuSa847flQ2ALN8sjjZ149HbQMbMmsS+FwDfYCzSTyeuYaQO3M8TBlLG5wOlxjO
 biHQCs20+IOkMTyQ35BOaiZkqjz0HgEIriRQeq2TA3/LWY7qqy4ms+VNKiTsanfXoi5H
 26xpxNooShuQQcg2KyhWyhWZIQ276X0YbxPOgQiteMD2LHoFlIBKvL8k4W/JIYEUEqJ9
 tl/uR2c0Q4rVYJDffeTI3/zj0DSl+lgrTUZUeGed8HbWi3gfJmJWZgZh58TpXWJDLqXl ng== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mvm41vxur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 15:37:47 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 303FLxRC010240;
        Tue, 3 Jan 2023 15:37:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq7ag5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Jan 2023 15:37:46 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 303FbjEC4129524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jan 2023 15:37:45 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F14CA58060;
        Tue,  3 Jan 2023 15:37:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC60C58056;
        Tue,  3 Jan 2023 15:37:44 +0000 (GMT)
Received: from [9.163.50.163] (unknown [9.163.50.163])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  3 Jan 2023 15:37:44 +0000 (GMT)
Message-ID: <90e8623a-e9f4-fb41-7671-de1912d139ad@linux.ibm.com>
Date:   Tue, 3 Jan 2023 09:37:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/6] crypto: Accelerated AES/GCM stitched
 implementation
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com
References: <20221205003458.4182-1-dtsen@linux.ibm.com>
 <Y6770EmD7VN3HCn7@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <Y6770EmD7VN3HCn7@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kYVjmPjO4h5UD9tZk94QPel2GEq7m4sD
X-Proofpoint-GUID: kYVjmPjO4h5UD9tZk94QPel2GEq7m4sD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-03_05,2023-01-03_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301030133
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

Uh, I will fix it.  It was set to ABI v2 in assembly file.  Sorry about 
that.


Thanks.

-Danny

On 12/30/22 8:55 AM, Herbert Xu wrote:
> On Sun, Dec 04, 2022 at 07:34:52PM -0500, Danny Tsen wrote:
>> This patch series enable an accelerated AES/GCM stitched implementation for
>> Power10+ CPU(ppc64le).  This module supports AEAD algorithm.  The stitched
>> implementation provides 3.5X+ better performance than the baseline.
>>
>> This patch has been tested with the kernel crypto module tcrypt.ko and has
>> passed the selftest.  The patch is also tested with
>> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled
>>
>> Danny Tsen (6):
>>    Patch1: Update Kconfig and Makefile.
>>    Patch2: Glue code for AES/GCM stitched implementation.
>>    Patch3: An accelerated AES/GCM stitched implementation.
>>    Patch4: Supporting functions for AES.
>>    Patch5: Supporting functions for ghash.
>>    Patch6: A perl script to process PowerPC assembler source.
>>
>>   arch/powerpc/crypto/Kconfig            |   11 +
>>   arch/powerpc/crypto/Makefile           |   10 +
>>   arch/powerpc/crypto/aesp8-ppc.pl       | 3846 ++++++++++++++++++++++++
>>   arch/powerpc/crypto/ghashp8-ppc.pl     |  370 +++
>>   arch/powerpc/crypto/p10-aes-gcm-glue.c |  345 +++
>>   arch/powerpc/crypto/p10_aes_gcm.S      | 1519 ++++++++++
>>   arch/powerpc/crypto/ppc-xlate.pl       |  229 ++
>>   7 files changed, 6330 insertions(+)
>>   create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
>>   create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
>>   create mode 100644 arch/powerpc/crypto/p10-aes-gcm-glue.c
>>   create mode 100644 arch/powerpc/crypto/p10_aes_gcm.S
>>   create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
> I can't build this, it fails with
>
>    LD [M]  arch/powerpc/crypto/p10-aes-gcm-crypto.o
> powerpc64le-linux-gnu-ld: arch/powerpc/crypto/p10_aes_gcm.o: ABI version 2 is not compatible with ABI version 1 output
> powerpc64le-linux-gnu-ld: failed to merge target specific data of file arch/powerpc/crypto/p10_aes_gcm.o
>
> Cheers,
