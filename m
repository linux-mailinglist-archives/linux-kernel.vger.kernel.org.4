Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C965E652
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 08:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjAEH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 02:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjAEH55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 02:57:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE77479E7;
        Wed,  4 Jan 2023 23:57:56 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3057kFpV005404;
        Thu, 5 Jan 2023 07:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=leoUKZpjBHE4UPcagQvr1kAX5H/JI6p/RG60UJCclyY=;
 b=IgqTN/kEfTI7+A7L5Ni6SoM3wyHh/SoDM7MZuFvaTui7AExDcmQM8ShIfks4dkSw1Kn3
 SavU0leS0JioOtMzNHNgxqASkKcLr5roGdEUCnFKS7dWKyBRn6G/sFrEfrGKxW1Ra0ny
 kDC+f++MCBNuw4nUaFFsesfnzK9I/LL4Roe2ZEjsfys2isF8yN+ChuEeRQYKRxZ2IGH8
 TL0gatz/W+c9dKjugYwEKHjAofscNLjl1/W5/VanvF/uBnVvfyeic3hN9wUJcmeCcy+d
 /q7QQc2xpZ8UA3yVieCLbm6kBx4V05gAGrkQ6K/WT6MLUO7Is5du17ku1UXyldQpHaGW 7Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mwtf186kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 07:57:36 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3054pLZu001428;
        Thu, 5 Jan 2023 07:57:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3mtcbfee38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 07:57:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3057vTph20906728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Jan 2023 07:57:30 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E06712004E;
        Thu,  5 Jan 2023 07:57:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DD7720040;
        Thu,  5 Jan 2023 07:57:29 +0000 (GMT)
Received: from osiris (unknown [9.171.68.186])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu,  5 Jan 2023 07:57:28 +0000 (GMT)
Date:   Thu, 5 Jan 2023 08:57:27 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] s390: define RUNTIME_DISCARD_EXIT to fix link error with
 GNU ld < 2.36
Message-ID: <Y7aC50LZK1t8Eysg@osiris>
References: <20230105031306.1455409-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105031306.1455409-1-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kCFQebmxhKqPUH_Qcm2PDBEL4M6DeUEX
X-Proofpoint-ORIG-GUID: kCFQebmxhKqPUH_Qcm2PDBEL4M6DeUEX
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_02,2023-01-04_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 phishscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301050062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 12:13:06PM +0900, Masahiro Yamada wrote:
> Nathan Chancellor reports that the s390 vmlinux fails to link with
> GNU ld < 2.36 since commit 99cb0d917ffa ("arch: fix broken BuildID
> for arm64 and riscv").
> 
> It happens for defconfig, or more specifically for CONFIG_EXPOLINE=y.
> 
>   $ s390x-linux-gnu-ld --version | head -n1
>   GNU ld (GNU Binutils for Debian) 2.35.2
>   $ make -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- allnoconfig
>   $ ./scripts/config -e CONFIG_EXPOLINE
>   $ make -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- olddefconfig
>   $ make -s ARCH=s390 CROSS_COMPILE=s390x-linux-gnu-
>   `.exit.text' referenced in section `.s390_return_reg' of drivers/base/dd.o: defined in discarded section `.exit.text' of drivers/base/dd.o
>   make[1]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
>   make: *** [Makefile:1252: vmlinux] Error 2
> 
> arch/s390/kernel/vmlinux.lds.S wants to keep EXIT_TEXT:
> 
>         .exit.text : {
>                 EXIT_TEXT
>         }
> 
> But, at the same time, EXIT_TEXT is thrown away by DISCARD because
> s390 does not define RUNTIME_DISCARD_EXIT.
> 
> I still do not understand why the latter wins after 99cb0d917ffa,
> but defining RUNTIME_DISCARD_EXIT seems correct because the comment
> line in arch/s390/kernel/vmlinux.lds.S says:
> 
>         /*
>          * .exit.text is discarded at runtime, not link time,
>          * to deal with references from __bug_table
>          */
> 
> Nathan also found that binutils commit 21401fc7bf67 ("Duplicate output
> sections in scripts") cured this issue, so we cannot reproduce it with
> binutils 2.36+, but it is better to not rely on it.
> 
> Fixes: 99cb0d917ffa ("arch: fix broken BuildID for arm64 and riscv")
> Link: https://lore.kernel.org/all/Y7Jal56f6UBh1abE@dev-arch.thelio-3990X/
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/kernel/vmlinux.lds.S | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks!
