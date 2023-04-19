Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C156E7739
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbjDSKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjDSKJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:09:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164161B3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:09:22 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33JA89Nm027920;
        Wed, 19 Apr 2023 10:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=LLS0pJQeMDVHzZ1pRWUSOdu0Lny2cku9AQMDCdPgS80=;
 b=YjIYzAQS6Jes7zHiobkm7f/dYzVDn5LRG4gkCpXAlJd+LuZ0mByLo13dCIPS+jGWxXpL
 VkR8+q6eedwoTYpro46uoGA67y5eyExS+Kzg/nxUxFODMEk5RxFxE3qXeCDTwm0yihhN
 wmGG0vY9IGXzNHL9bGvHs602LYP+aUhG+Ifaag5eGfXd4uH856v+NxSbxTqgB9iO9j5n
 +O5Qz3VcEfflBgUGmrBy7agGJ4vK98CyyuZystIbm9FC12obdK705HqD6HTHZOl9KDW7
 8UebpjXTs6kvNOvD10QGcKBcEpSleyQUh1qfMpi2lMKgRAA2xAwlh8FLIqFCjfJM6Rek ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q28tyse7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 10:09:07 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33JA7JJS033082;
        Wed, 19 Apr 2023 10:09:07 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q28tyse35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 10:09:06 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33J3PLsR012853;
        Wed, 19 Apr 2023 10:09:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pyk6fj600-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Apr 2023 10:09:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33JA8xMd17564182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Apr 2023 10:08:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2FD20040;
        Wed, 19 Apr 2023 10:08:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2700F2004D;
        Wed, 19 Apr 2023 10:08:56 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.42.198])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 19 Apr 2023 10:08:55 +0000 (GMT)
Date:   Wed, 19 Apr 2023 15:38:52 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Sean Christopherson <seanjc@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: book3s_hv_nested.c: improve branch
 prediction for k.alloc
Message-ID: <ZD+9tHrOWs7SbG1H@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230407093147.3646597-1-kconsul@linux.vnet.ibm.com>
 <ZDAeuL2fz1aEW6rz@debian.me>
 <ZDA+WdiqB2931xHB@google.com>
 <ZDTpGsT15s0iOrTJ@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <873557j59d.fsf@mpe.ellerman.id.au>
 <ZDZX7cAa5uKwfJOd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDZX7cAa5uKwfJOd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0U7ujuPgU23qZF-R5pKz9gWorDsokjz_
X-Proofpoint-GUID: Q1BU1_1VGTq-ou__BIWOXY4rwf-DWC6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-19_05,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304190085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-12 12:34:13, Kautuk Consul wrote:
> Hi,
> 
> On 2023-04-11 16:35:10, Michael Ellerman wrote:
> > Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> > > On 2023-04-07 09:01:29, Sean Christopherson wrote:
> > >> On Fri, Apr 07, 2023, Bagas Sanjaya wrote:
> > >> > On Fri, Apr 07, 2023 at 05:31:47AM -0400, Kautuk Consul wrote:
> > >> > > I used the unlikely() macro on the return values of the k.alloc
> > >> > > calls and found that it changes the code generation a bit.
> > >> > > Optimize all return paths of k.alloc calls by improving
> > >> > > branch prediction on return value of k.alloc.
> > >> 
> > >> Nit, this is improving code generation, not branch prediction.
> > > Sorry my mistake.
> > >> 
> > >> > What about below?
> > >> > 
> > >> > "Improve branch prediction on kmalloc() and kzalloc() call by using
> > >> > unlikely() macro to optimize their return paths."
> > >> 
> > >> Another nit, using unlikely() doesn't necessarily provide a measurable optimization.
> > >> As above, it does often improve code generation for the happy path, but that doesn't
> > >> always equate to improved performance, e.g. if the CPU can easily predict the branch
> > >> and/or there is no impact on the cache footprint.
> > 
> > > I see. I will submit a v2 of the patch with a better and more accurate
> > > description. Does anyone else have any comments before I do so ?
> >  
> > In general I think unlikely should be saved for cases where either the
> > compiler is generating terrible code, or the likelyness of the condition
> > might be surprising to a human reader.
> > 
> > eg. if you had some code that does a NULL check and it's *expected* that
> > the value is NULL, then wrapping that check in likely() actually adds
> > information for a human reader.
> >     
> > Also please don't use unlikely in init paths or other cold paths, it
> > clutters the code (only slightly but a little) and that's not worth the
> > possible tiny benefit for code that only runs once or infrequently.
> > 
> > I would expect the compilers to do the right thing in all
> > these cases without the unlikely. But if you can demonstrate that they
> > meaningfully improve the code generation with a before/after
> > dissassembly then I'd be interested.
> Just FYI, the last email by kautuk.consul.80@gmail.com was by me.
> That last email contains a diff file attachment which compares 2 files:
> before my changes and after my changes.
> This diff file shows a lot of changes in code generation. Im assuming
> all those changes are made by the compiler towards optimizing all return
> paths to k.alloc calls.
> Kindly review and comment.
Any comments on the numerous code generation changes as shown by the
files I attached to this mail chain ? Sorry I don't have concrete
figures of any type to prove that this leads to any measurable performance
improvements. I am just assuming that the compiler's modified code
generation (due to the use of the unlikely macro) would be optimal.

Thanks.
> > cheers
