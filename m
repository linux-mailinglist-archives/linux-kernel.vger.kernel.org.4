Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BD3648411
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLIOsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLIOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:48:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C455731F99
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:48:37 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9DOHNI016532;
        Fri, 9 Dec 2022 14:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dLS2kaiAZqkIQEJCpi0YtWFlNLUmOA9qwcezQB2s1hI=;
 b=Dl0sBudvUKlvsRKS3JMQqJ5cuWgXBWtlZ9z0kRImW6Cqhjg1IehLnwintyGSyftb3y1l
 0JWXRfLKDPUMfr6K6U3LzI4JOljtNlUSCQo6sSZbwcALGL3qDw75U5Z2hUa/out/DPC4
 +OSozqHyVGPEFW2k1S+kcGMCHyJ4brFjPPFrqTDU+HwTbg4OlypTdNBa6TbrMF0hYlQ8
 my7CLjC8PLROuiaK76JhNJlAmirTIYQsdY7rkiPw6lCrTK57pDc2+tFqJIWH/2g3HPos
 KOvXVPrQdfY8yhPRyFSqvBzlrxH4brYHjBecmIkTLnGDrK0dKoJA3Kf2ecaIDCroT+zi RA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mbxcqvfhj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:48:23 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2B9B8QUC016511;
        Fri, 9 Dec 2022 14:48:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3m9m5y63mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Dec 2022 14:48:22 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B9EmJCe42926486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Dec 2022 14:48:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2C6820043;
        Fri,  9 Dec 2022 14:48:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60F6120040;
        Fri,  9 Dec 2022 14:48:19 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.171.32.234])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  9 Dec 2022 14:48:19 +0000 (GMT)
Date:   Fri, 9 Dec 2022 15:48:06 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jump_label: explicitly annotate inittext labels as init
Message-ID: <Y5NKpudEBjfD2K+N@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221209060740.2785164-1-agordeev@linux.ibm.com>
 <CAMj1kXF5OR6TGhCrxYCmrnA=CTAfkGcga8BDE2Vj3rixgi7U3w@mail.gmail.com>
 <Y5Murs1nSi45xEuK@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAMj1kXEW-m4Z=wt0S-drRCD0naKrQk07hcONdQTRZJGmHYRY-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEW-m4Z=wt0S-drRCD0naKrQk07hcONdQTRZJGmHYRY-Q@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AbWBqKWhRrriDKYX8OrWLDBzyicbNKsL
X-Proofpoint-GUID: AbWBqKWhRrriDKYX8OrWLDBzyicbNKsL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-09_08,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=808 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212090117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:48:49PM +0100, Ard Biesheuvel wrote:
> On Fri, 9 Dec 2022 at 13:49, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> >
> > On Fri, Dec 09, 2022 at 10:41:55AM +0100, Ard Biesheuvel wrote:
> > > > diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> > > > index 714ac4c3b556..77680665d374 100644
> > > > --- a/kernel/jump_label.c
> > > > +++ b/kernel/jump_label.c
> > > > @@ -481,13 +481,16 @@ void __init jump_label_init(void)
> > > >
> > > >         for (iter = iter_start; iter < iter_stop; iter++) {
> > > >                 struct static_key *iterk;
> > > > +               unsigned long addr;
> > > >                 bool in_init;
> > > >
> > > >                 /* rewrite NOPs */
> > > >                 if (jump_label_type(iter) == JUMP_LABEL_NOP)
> > > >                         arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
> > > >
> > > > -               in_init = init_section_contains((void *)jump_entry_code(iter), 1);
> > > > +               addr = jump_entry_code(iter);
> > > > +               in_init = init_section_contains((void *)addr, 1) ||
> > > > +                         is_kernel_inittext(addr);
> > >
> > > Isn't it sufficient to only call is_kenel_inittext here?
> >
> > I am not sure every arch out there would stick to putting
> > init code to inittext only.
> >
> > However, should not is_kernel_exittext() (which does not
> > exist) also get checked here?
> 
> No, exittext either exists or it doesn't, rather than disappearing at
> runtime like inittext.

May be just swap the order of init_section_contains() and
is_kernel_inittext() checks then?
