Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB7698C71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 06:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjBPF5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 00:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPF5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 00:57:05 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B142ED77
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 21:57:01 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G5LvZd011862;
        Thu, 16 Feb 2023 05:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xR27uGAGk2zgX41yCW/6RpnVB/1Z7I/J+WBAkbNFyGg=;
 b=dDHcSBuT1nC4lTTXkJmY6+HCdcPFVrFqyEcpAwcNt7kLm+b866OJjyR00pfBKvS0U3EW
 O+FaUYrc2LFAlaE904m0+Pw2ZIDklczYB2XOjmi6Tm9FzGIrsDoHwdUs+NdUxVZubS/+
 jzawkSUDcbW1xr9NcCuqcLWNGTPD6CX1jXGe0URyMoJmiAGsvvR7KVIkZXtPZ6nQe70r
 Jey7Cn7Th5TNeetFHF0LC8rAcFe0r6S9+ZqzTygMGhxAciKRXdnOiLyevUralNht52FJ
 IHoTPuQDgh1WbUlClWhdxgvBQ0iF+bjNEICYsvSNntCqAUxHz8OkauBOFBxkWQ0pUz7f Pw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nse98gkrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 05:56:48 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FMktE4028428;
        Thu, 16 Feb 2023 05:56:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3np2n6mk3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 05:56:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31G5uhdj22151478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 05:56:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B8E320043;
        Thu, 16 Feb 2023 05:56:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD3F920040;
        Thu, 16 Feb 2023 05:56:42 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 05:56:42 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id C9945600D2;
        Thu, 16 Feb 2023 16:56:40 +1100 (AEDT)
Message-ID: <4d498c7d1808e5e9090c43822e7c79447e11bbce.camel@linux.ibm.com>
Subject: Re: 6.2-rc7 fails building on Talos II: memory.c:(.text+0x2e14):
 undefined reference to `hash__tlb_flush'
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     "Erhard F." <erhard_f@mailbox.org>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 16 Feb 2023 16:56:40 +1100
In-Reply-To: <20230216005535.6bff7aa6@yea>
References: <20230216005535.6bff7aa6@yea>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dw3gJBOVn4evYq8pSI0UUmnsqfPIOSBW
X-Proofpoint-GUID: Dw3gJBOVn4evYq8pSI0UUmnsqfPIOSBW
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_04,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxlogscore=827 malwarescore=0 phishscore=0 spamscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-16 at 00:55 +0100, Erhard F. wrote:
> Just noticed a build failure on 6.2-rc7 for my Talos 2 (.config
> attached):
>=20
> =C2=A0# make
> =C2=A0 CALL=C2=A0=C2=A0=C2=A0 scripts/checksyscalls.sh
> =C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 include/generated/utsversion.h
> =C2=A0 CC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 init/version-timestamp.o
> =C2=A0 LD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tmp_vmlinux.kallsyms1
> ld: ld: DWARF error: could not find abbrev number 6
> mm/memory.o: in function `unmap_page_range':
> memory.c:(.text+0x2e14): undefined reference to `hash__tlb_flush'
> ld: memory.c:(.text+0x2f8c): undefined reference to `hash__tlb_flush'
> ld: ld: DWARF error: could not find abbrev number 3117
> mm/mmu_gather.o: in function `tlb_remove_table':
> mmu_gather.c:(.text+0x584): undefined reference to `hash__tlb_flush'
> ld: mmu_gather.c:(.text+0x6c4): undefined reference to
> `hash__tlb_flush'
> ld: mm/mmu_gather.o: in function `tlb_flush_mmu':
> mmu_gather.c:(.text+0x80c): undefined reference to `hash__tlb_flush'
> ld: mm/mmu_gather.o:mmu_gather.c:(.text+0xbe0): more undefined
> references to `hash__tlb_flush' follow
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Fehler 1
> make: *** [Makefile:1264: vmlinux] Error 2
>=20
> As 6.2-rc6 was good on this machine I did a quick bisect which
> revealed this commit:
>=20
> =C2=A0# git bisect bad
> 1665c027afb225882a5a0b014c45e84290b826c2 is the first bad commit
> commit 1665c027afb225882a5a0b014c45e84290b826c2
> Author: Michael Ellerman <mpe@ellerman.id.au>
> Date:=C2=A0=C2=A0 Tue Jan 31 22:14:07 2023 +1100
>=20
> =C2=A0=C2=A0=C2=A0 powerpc/64s: Reconnect tlb_flush() to hash__tlb_flush()
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Commit baf1ed24b27d ("powerpc/mm: Remove empty hash__ =
functions")
> =C2=A0=C2=A0=C2=A0 removed some empty hash MMU flushing routines, but got=
 a bit
> overeager
> =C2=A0=C2=A0=C2=A0 and also removed the call to hash__tlb_flush() from tl=
b_flush().
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 In regular use this doesn't lead to any noticable brea=
kage, which
> is a
> =C2=A0=C2=A0=C2=A0 little concerning. Presumably there are flushes happen=
ing via
> other
> =C2=A0=C2=A0=C2=A0 paths such as arch_leave_lazy_mmu_mode(), and/or a bit=
 of luck.
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Fix it by reinstating the call to hash__tlb_flush().
> =C2=A0=C2=A0=C2=A0=20
> =C2=A0=C2=A0=C2=A0 Fixes: baf1ed24b27d ("powerpc/mm: Remove empty hash__ =
functions")
> =C2=A0=C2=A0=C2=A0 Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> =C2=A0=C2=A0=C2=A0 Link:
> https://lore.kernel.org/r/20230131111407.806770-1-mpe@ellerman.id.au
>=20
> =C2=A0arch/powerpc/include/asm/book3s/64/tlbflush.h | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
>=20
> Regards,
> Erhard

Looks like the `return` on the radix version wasn't added back, so it
falls through to the hash call too.

