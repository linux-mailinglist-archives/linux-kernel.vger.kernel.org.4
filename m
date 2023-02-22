Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE0169F09C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBVIrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBVIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:47:32 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69763367F2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 00:47:31 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8Hr3F031916;
        Wed, 22 Feb 2023 08:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=CCRx9fyuYDhkAycHEafQMjxmFOwYzeLo+5/QAk2x5xw=;
 b=qsR6KoMVZiTHeuHA0kiUQHFDaWzwuuPQnPxUgKrglJzkGQHsAdWhwqjEtVVnVoYkqGBo
 WUEvrMSUy5q7DZ3O33l5RMSVL+AF7FlgulOFyZ2RyYs05CgQZI0MNqeUBjSVSBFCIduu
 A19OnqNxdLhp90VpAETGBRO1XF0l5IdHY0RtK0ass8t9Ez9mlzMdIFVzH25CJklBrjPI
 Di8qm0ZobbzpYWMU7rua/RCJBcE08voRVRwV5Kj9ICiFQHMLGIYf1WQ2N2cagFbeK7Zb
 KXGYH3fIDB/Jtw264QwIiEC+kz8rnMfmx0svF2pAGDzE1Mr+uUrOIc6N005KGfK7YonI kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwd5sc85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:47:22 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31M8cwZf015187;
        Wed, 22 Feb 2023 08:47:21 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nwd5sc853-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:47:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31LDgFDt008477;
        Wed, 22 Feb 2023 08:47:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ntnxf3up9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 08:47:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31M8lHQm21168472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 08:47:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7001820043;
        Wed, 22 Feb 2023 08:47:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D994F20040;
        Wed, 22 Feb 2023 08:47:14 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.123.148])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Feb 2023 08:47:14 +0000 (GMT)
Date:   Wed, 22 Feb 2023 14:17:11 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arch/powerpc/include/asm/barrier.h: redefine rmb and wmb
 to lwsync
Message-ID: <Y/XWjysGYHIzhfoc@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230222060107.70565-1-kconsul@linux.vnet.ibm.com>
 <896436d1-04e4-8019-0f89-f4d4938f9697@csgroup.eu>
 <Y/XPZl8V4/0Bjegy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <b02ddb1b-393f-16f7-1d06-caa99bfd3d20@csgroup.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b02ddb1b-393f-16f7-1d06-caa99bfd3d20@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v3mONZh2Kq3z7AgRA5O0ZB9p4qrV6M7s
X-Proofpoint-ORIG-GUID: SgX91qG7nYjc3Txsf5gMuYm4uEc4NJpv
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_04,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> No, I don't mean to use the existing #ifdef/elif/else.
> 
> Define an #ifdef /#else dedicated to xmb macros.
> 
> Something like that:
> 
> @@ -35,9 +35,15 @@
>    * However, on CPUs that don't support lwsync, lwsync actually maps to a
>    * heavy-weight sync, so smp_wmb() can be a lighter-weight eieio.
>    */
> +#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_E500MC)
> +#define __mb()   asm volatile ("lwsync" : : : "memory")
> +#define __rmb()  asm volatile ("lwsync" : : : "memory")
> +#define __wmb()  asm volatile ("lwsync" : : : "memory")
> +#else
>   #define __mb()   __asm__ __volatile__ ("sync" : : : "memory")
>   #define __rmb()  __asm__ __volatile__ ("sync" : : : "memory")
>   #define __wmb()  __asm__ __volatile__ ("sync" : : : "memory")
> +#endif
Ok. Got it. Will do.

> >> Shouldn't you also consider the same for mb() ?
> > My change wasn't meant to address newer usages of as volatile
> > #defines. I just wanted to redefine the rmb and wmb #defines
> > to lwsync.
> 
> That's my point, why not also redefine mb to lwsync ?
That would be incorrect. lwsync will only work for one: load or store.
mb() is meant for barriering both loads as well as stores so the sync
instruction is correct for that one.
> 
> >>
> >> Note that your series will conflict with b6e259297a6b ("powerpc/kcsan:
> >> Memory barriers semantics") in powerpc/next tree.
> > I thought of defining the __rmb and __wmb macros but I decided against
> > it because I didn't understand kcsan completely.
> > I used the standard Linus' tree, not powerpc/next.
> > Can you tell me which branch or git repo I should make this patch on ?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
> 
> 'merge' branch is a merge of branches 'master', 'fixes' and 'next'.
> 
> That's the branch to use, allthough it is not always in sync with fixes 
> and next, in that case all you have to do is to locally merge 'next' and 
> 'fixes' branch until it's done remotely.
> 
> But just using 'next' branch also works most of the time.
> 
> Note that 'next' branch should already be part of linux-next so you may 
> also use linux-next if you prefer.
> 
Will send another patch on this.
Thanks. Will use linux-next branch on this git repo.
