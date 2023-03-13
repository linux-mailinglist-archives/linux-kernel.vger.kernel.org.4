Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3126B7843
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjCMNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCMNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:00:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC4464234;
        Mon, 13 Mar 2023 05:59:52 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32DC17h5001687;
        Mon, 13 Mar 2023 12:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=p/uBGT7CPg8tBHDJ7eVXHXW6FWUluHA2VNiNAc55PD4=;
 b=lakHdwYYL3kYSl8Zp734Lkz6FrB7DUICNNIQ6Ss6w0l8cT4wlVS6d1QuMH6NSMWDvdKL
 u8W9CRduhGrOP0eJpWldzu21k92T8Cm3K5pd2/PYgPUvK7JpAqdqfVLvoPI6VDDDBkYK
 0XBVB6Subt+9QDKG4Ck6i0oHM3G0RGiqVD/XRNJLZdVOg7ggfj+xj0M5XQo1PVNmt5zY
 8LKpA1G/YtwFmKGrHs7S5LeSrvBRKjq/0aR0d2pJPKQIUATRViDvwij9rCYV0DaJ+L+r
 Q9s0/ctkzG+6A9+NAaADw8wcvrvDJZOy5EQC+O/BooIBhaS0AZp7OBZKTF+x8JaB9zvC uA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pa3ffsmtf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:59:17 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32DBjl7u004928;
        Mon, 13 Mar 2023 12:59:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p8h97h539-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Mar 2023 12:59:16 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32DCxEos6816348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2023 12:59:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61F7F58052;
        Mon, 13 Mar 2023 12:59:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F12F58045;
        Mon, 13 Mar 2023 12:59:13 +0000 (GMT)
Received: from [9.160.124.22] (unknown [9.160.124.22])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Mar 2023 12:59:13 +0000 (GMT)
Message-ID: <1cf97806-300d-d79e-4c4c-3b7cccba7312@linux.ibm.com>
Date:   Mon, 13 Mar 2023 07:59:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [RESEND PATCH v4 0/6] crypto: Accelerated AES/GCM stitched
 implementation
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, leitao@debian.org,
        nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com,
        dtsen@us.ibm.com
References: <20230221034021.15121-1-dtsen@linux.ibm.com>
 <ZAsUV4Nn6qrwA2am@gondor.apana.org.au>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <ZAsUV4Nn6qrwA2am@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vs_ATB29RtpnMaJhexFX4MtjxJIZvHME
X-Proofpoint-ORIG-GUID: vs_ATB29RtpnMaJhexFX4MtjxJIZvHME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-13_05,2023-03-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=842 lowpriorityscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303130102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hubert.

-Danny

On 3/10/23 5:28 AM, Herbert Xu wrote:
> On Mon, Feb 20, 2023 at 10:40:15PM -0500, Danny Tsen wrote:
>> This patch series enable an accelerated AES/GCM stitched implementation
>> for Power10 or later CPU(ppc64le).  This module supports AEAD algorithm.
>> The stitched implementation provides 3.5X+ better performance than the
>> baseline.
>>
>> This patch has been tested with the kernel crypto module tcrypt.ko and
>> has passed the selftest.  The patch is also tested with
>> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS enabled.
>>
>> Danny Tsen (6):
>>    Glue code for AES/GCM stitched implementation.
>>    An accelerated AES/GCM stitched implementation.
>>    Supporting functions for AES.
>>    Supporting functions for ghash.
>>    A perl script to process PowerPC assembler source.
>>    Update Kconfig and Makefile.
>>
>>   arch/powerpc/crypto/aes-gcm-p10-glue.c |  345 ++++++
>>   arch/powerpc/crypto/aes-gcm-p10.S      | 1521 ++++++++++++++++++++++++
>>   arch/powerpc/crypto/aesp8-ppc.pl       |  585 +++++++++
>>   arch/powerpc/crypto/ghashp8-ppc.pl     |  370 ++++++
>>   arch/powerpc/crypto/ppc-xlate.pl       |  229 ++++
>>   arch/powerpc/crypto/Kconfig            |   17 +
>>   arch/powerpc/crypto/Makefile           |   13 +
>>   7 files changed, 3080 insertions(+)
>>   create mode 100644 arch/powerpc/crypto/aes-gcm-p10-glue.c
>>   create mode 100644 arch/powerpc/crypto/aes-gcm-p10.S
>>   create mode 100644 arch/powerpc/crypto/aesp8-ppc.pl
>>   create mode 100644 arch/powerpc/crypto/ghashp8-ppc.pl
>>   create mode 100644 arch/powerpc/crypto/ppc-xlate.pl
>>
>> -- 
>> 2.31.1
> All applied.  Thanks.
