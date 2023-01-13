Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFB8669D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjAMQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjAMQFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:05:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFC43DA2;
        Fri, 13 Jan 2023 07:58:00 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEdU18011808;
        Fri, 13 Jan 2023 15:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CUAZX3R8Ar8CybdDlVVmgMlNlnQOFlAHQejDsqAJRyQ=;
 b=D4pekrL3+kU4AfqL73eztlVqFfkr6zb9nNFAhXaw/m2/cN7/g/lVUtLGos3zjYIhwFJw
 uwJMBN2sSPnT1zOiup3UzZWGQsOp2yZRyHB95+Bhh4OXoRDHY5V6WfVK7Tc8O0DBWYNH
 nzqdgMOWGt7eeKsrbC6dkmO9wQykoaJsdnDMVRVYIkoz5Iz6nYDPMG3fq+Jk2IZLNrIG
 i9HwaITcwNY1ESVTxe4iNsCtAB/7LuIOpOWFpc80E1Y1Z6DXuY+LWPh6Qe7KOwK51ONp
 xrslZsB6mGy9aO9ZpiDQCKAEJjAnhDUV8Gv02dvPlDLF10Z35JTFIjXlYhbdHqoHFyXw og== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n38uh2huf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:57:49 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30DFUEZp029149;
        Fri, 13 Jan 2023 15:57:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n1m03mf3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 15:57:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30DFvl4R55247220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 15:57:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 984D258054;
        Fri, 13 Jan 2023 15:57:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28C705805D;
        Fri, 13 Jan 2023 15:57:47 +0000 (GMT)
Received: from [9.163.65.152] (unknown [9.163.65.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Jan 2023 15:57:47 +0000 (GMT)
Message-ID: <84ed2129-4bef-4b84-5d79-f787f498031f@linux.ibm.com>
Date:   Fri, 13 Jan 2023 09:57:46 -0600
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
 <Y8DaRph5Sv709m/m@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <Y8DaRph5Sv709m/m@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zMJ_5q7aon6Nfy-reua4cUvbdStovn5e
X-Proofpoint-ORIG-GUID: zMJ_5q7aon6Nfy-reua4cUvbdStovn5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=801 impostorscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Great.  Thanks Herbert.

-Danny

On 1/12/23 10:12 PM, Herbert Xu wrote:
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
>>
>> -- 
>> 2.31.1
> All applied.  Thanks.
