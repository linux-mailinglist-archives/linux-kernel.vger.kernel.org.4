Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9C648290
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 13:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiLIMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 07:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiLIMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 07:49:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51266407
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 04:49:00 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9B5p56038765;
        Fri, 9 Dec 2022 12:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=M+ce5XJ5+K0FLZ/Q3JFl4/fnlN4F1Xiy27TY9fWzOs8=;
 b=J30YsOjkUzG6OvVSweQS55AVLufwUp0ztcgFvqTJ+d4S0/Em+MtT8NlYDSjFqk/qYNKF
 dnO715BwAlEN68vIyXT9o9f0smHqFXDmU4BIp6nMBILzM6ExLRem9Y9Bj1t1n2gxzrc2
 i/pPEwca0fYDHbN6mzdhpaHgJaC2EjO4F5QIM/lyOuWRbVJ6nGBM17r/K+cJcUwzpSUl
 Sie5fao4Wp7tS+GEfOrSXcBP4CO1g1vSpj2G2AQuZXdHLUy12nzUffAMnel79EZcIYto
 ZWBNCDlaBZb1/5RUOO/dmMLdoZJhiNTGsxwZ7jKHShhDq7ZktWTLfL3+o3JeBcq3ONjA KA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mc10qp85c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 12:48:53 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9Bk1Fi027261;
        Fri, 9 Dec 2022 12:48:50 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3m9ks460fc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 12:48:50 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9CmmXC40108464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 12:48:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7299F20049;
        Fri,  9 Dec 2022 12:48:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0691D20043;
        Fri,  9 Dec 2022 12:48:48 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.179.4.6])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 12:48:47 +0000 (GMT)
Date:   Fri, 9 Dec 2022 13:48:46 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jump_label: explicitly annotate inittext labels as init
Message-ID: <Y5Murs1nSi45xEuK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221209060740.2785164-1-agordeev@linux.ibm.com>
 <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y1k8QV6Nt6Xz5O9EUQh-vVsKxE8wXXdG
X-Proofpoint-ORIG-GUID: y1k8QV6Nt6Xz5O9EUQh-vVsKxE8wXXdG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_07,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=815 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 10:41:55AM +0100, Ard Biesheuvel wrote:
> > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > index 714ac4c3b556..77680665d374 100644
> > --- a/kernel/jump_label.c
> > +++ b/kernel/jump_label.c
> > @@ -481,13 +481,16 @@ void __init jump_label_init(void)
> >
> >         for (iter = iter_start; iter < iter_stop; iter++) {
> >                 struct static_key *iterk;
> > +               unsigned long addr;
> >                 bool in_init;
> >
> >                 /* rewrite NOPs */
> >                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
> >                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
> >
> > -               in_init = init_section_contains((void *)jump_entry_code(iter), 1);
> > +               addr = jump_entry_code(iter);
> > +               in_init = init_section_contains((void *)addr, 1) ||
> > +                         is_kernel_inittext(addr);
> 
> Isn't it sufficient to only call is_kenel_inittext here?

I am not sure every arch out there would stick to putting
init code to inittext only.

However, should not is_kernel_exittext() (which does not
exist) also get checked here?
