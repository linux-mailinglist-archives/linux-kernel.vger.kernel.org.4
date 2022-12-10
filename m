Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D754648E03
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiLJJes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 04:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJJep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 04:34:45 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07D3F55
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 01:34:44 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BA4WuXk019847;
        Sat, 10 Dec 2022 09:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=kT7rEcYWIqlqjIwJ4e87e2WSontyg+RuQltlrjJ9b0M=;
 b=Q3KE96srrU/wfoB4GVcCF771RyVvzzh1K9EdaudwUTLIX/oiKKO4xNe8T1BI6AuKQpc5
 3LAmsx9IhncmE16RblJokgoFkEuACYEZwE9LelrMYwLzBRf/xlgr8Qr7IHIO+vDCv82h
 73qt3RCqvQWI0SGCyfAYVER1UstWmedOYNi+qYrxz0ixEMfJoe/QXqJdC+7XEuMCM9UG
 0P/DWWiE2Q2lEa8nrNu9oCFipa1O2KD5wkDptMA3cL2nd25GJ0CdqpEYfNbnC++6BwGZ
 emvh5CwtCmI7TQHodpviOQSVBEeTBuZXAHOBCTJ+M9TOGjAnH0Aq3Ab533iDdiPh38FM lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mcfh8ybqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:34:14 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BA9TLEY019216;
        Sat, 10 Dec 2022 09:34:13 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mcfh8ybq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:34:13 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BA4KZJW007832;
        Sat, 10 Dec 2022 09:34:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mchcf0ak5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Dec 2022 09:34:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BA9Y95444761494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Dec 2022 09:34:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B85D20049;
        Sat, 10 Dec 2022 09:34:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E6E020040;
        Sat, 10 Dec 2022 09:34:09 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Dec 2022 09:34:09 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nolibc: add support for s390
References: <20221209141939.3634586-1-svens@linux.ibm.com>
        <20221209141939.3634586-3-svens@linux.ibm.com>
        <20221210090728.GB21743@1wt.eu>
Date:   Sat, 10 Dec 2022 10:34:08 +0100
In-Reply-To: <20221210090728.GB21743@1wt.eu> (Willy Tarreau's message of "Sat,
        10 Dec 2022 10:07:28 +0100")
Message-ID: <yt9dmt7vtxf3.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t9KjxL_z4x43AmtDjKxuof8auGEKhsjL
X-Proofpoint-ORIG-GUID: 4BAdwAL7S_z9WxydEGCJUAD5-PxzeGqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-10_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=548 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212100084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Fri, Dec 09, 2022 at 03:19:36PM +0100, Sven Schnelle wrote:
>> Use arch-x86_64 as a template. Not really different, but
>> we have our own mmap syscall which takes a structure instead
>> of discrete arguments.
>
> I'm fine with placing the mmap syscall inside the arch-s390 file, though
> it differs from what's done for other syscalls. But I admit that mmap is
> one of these syscalls that differ between various archs and that it's not
> shocking to leave it per-arch.
>
> However you're having an issue here:
>
>> diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
>> new file mode 100644
>> index 000000000000..34b744e2f7d6
>> --- /dev/null
>> +++ b/tools/include/nolibc/arch-s390.h
>                              ^^^^^^^^^
> vs:
>
>> diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
>> index 4c6992321b0d..fcded65b98d7 100644
>> --- a/tools/include/nolibc/arch.h
>> +++ b/tools/include/nolibc/arch.h
>> @@ -27,6 +27,8 @@
>>  #include "arch-mips.h"
>>  #elif defined(__riscv)
>>  #include "arch-riscv.h"
>> +#elif defined(__s390x__)
>> +#include "arch-s390x.h"
>              ^^^^^^^^^^
>
> As you see the file is not the same so if you build by including nolibc.h
> directly it will not work. The difference between s390 and s390x has never
> been very clear to me, so I can't easily suggest which name is the most
> suitable, but you'll definitely have to choose one :-)  If it's just a
> matter of dropping that trailing 'x' there, I think we can fix your patch
> here without re-submitting, let us know.

Whoops. One of my colleagues suggested that i should name the file
arch-390x.h. Reason for this is that the architecture name "s390"
describes the 31bit (compat) architecture mode in userspace, and "s390x"
the 64 bit mode. To make it a bit more complicated, the architecture in
the kernel is named "s390". That's because in the beginning the kernel
could run in 31bit or 64 bit mode, and there can be only one
architecture name. When support for running 31bit kernels was removed
years ago, the architecture name s390 was kept because renaming the
architecture would have been quite some fun. So in short:

Kernel s390 == 64 bit only
Userspace s390 == 31 bit
Userspace s390x == 64 bit

So i tried renaming the header file, noted that the Makefile just uses:

nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
arch_file := arch-$(nolibc_arch).h

which would then need special handling. Obviously i failed to revert the
change completely during rebase.

So it should be:

>> +#elif defined(__s390x__)
>> +#include "arch-s390.h"

I'm fine with both - either you fixing it up or me sending a v2.

Thanks!
Sven
