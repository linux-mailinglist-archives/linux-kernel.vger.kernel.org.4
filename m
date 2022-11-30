Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B6F63D406
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiK3LKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiK3LJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:09:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDB74AAC;
        Wed, 30 Nov 2022 03:09:54 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AUAoqVU010405;
        Wed, 30 Nov 2022 11:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=PqFTuAxFajv1oFRjQ0A1wChP8j4GC2h2t6wyrjks6VY=;
 b=fmtnChfhvoYKIM/4QiPWJv7jmdY6KO3yNp0rjXE/FwobppHRAOR7GdcEV/rCdPezGJ+r
 aloSZhyDG0N1BKVFPe8UGy9k7MGuHAhQIr4IlorK3hEpCYmLFEPQuTgvzpNvBJO9AaUX
 unjbh88ln23Rn6YRbtV+o4YWNmysX4jkNebG6SSOhIjS2X8G7s5Q3eJZzjYERSPeWQMP
 bbYo/AWNH1hqlyWu7HUFkJAoWFf2a14fTSypb+VNutiUoWDX1nHJcO8wjsUJm4FTgfuT
 gZOnsS5jJq+LkcfKJSimQyc9k25UvqcpvN5bsj9fiBnlUUp/eiygpjXzaAmk81tq4uU4 GQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m63sakd8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 11:08:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AUB5qCr016650;
        Wed, 30 Nov 2022 11:08:41 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3m3ae9t73x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Nov 2022 11:08:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AUB8dWp65011992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Nov 2022 11:08:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5B8B58327;
        Wed, 30 Nov 2022 11:08:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95C6A5832A;
        Wed, 30 Nov 2022 11:08:37 +0000 (GMT)
Received: from [9.163.59.72] (unknown [9.163.59.72])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Nov 2022 11:08:37 +0000 (GMT)
Message-ID: <5e7f44c5-6141-a2d0-238b-6c18978b8d70@linux.ibm.com>
Date:   Wed, 30 Nov 2022 19:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH 0/6] crypto: Accelerated AES/GCM stitched implementation
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        leitao@debian.org, nayna@linux.ibm.com, appro@cryptogams.org,
        linux-kernel@vger.kernel.org, ltcgcw@linux.vnet.ibm.com
References: <Y4Xyflca/hkvR0eR@Dannys-MacBook-Pro.local>
 <Y4blj2RZB4PI7ZYZ@sol.localdomain>
From:   Danny Tsen <dtsen@linux.ibm.com>
In-Reply-To: <Y4blj2RZB4PI7ZYZ@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TnXhTQPKDNTtbZNdt7Be2ibS9ezh1Xzv
X-Proofpoint-GUID: TnXhTQPKDNTtbZNdt7Be2ibS9ezh1Xzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-30_04,2022-11-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=852 bulkscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211300080
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

I will test with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y and provide 
updates.  Please ignore my resend patch that I just sent so it is 
threaded under patch 0.

Thanks.

-Danny

On 11/30/22 1:09 PM, Eric Biggers wrote:
> On Tue, Nov 29, 2022 at 07:52:30PM +0800, Danny Tsen wrote:
>> This patch has been tested with the kernel crypto module tcrypt.ko and has
>> passed the selftest.
> Please make sure you've tested it with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.
>
> - Eric
