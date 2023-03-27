Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6E56CA1B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjC0Kvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjC0Kvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:51:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABD2101
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:51:43 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R8vYPf000724;
        Mon, 27 Mar 2023 10:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=e9XfZYA8crVMW3ByZsMbmlFkN3H8AwlKiONAqPcFWCU=;
 b=jcALzM1x6nMOrVUeYS2Aee7BvFOubWk5bzJucHXV9xG07jhxS8Fv7wBbhJ4VF9Fj9Oro
 nXSdsgYqpJ0g77Rul0XpLGqNkHxUaRUxjM6+U+jgPxIDa6veU26wVeLQ1XGkTK6Jy2OD
 wdU4RrIR2fHUYp/N57JpzhdtbpCuhZTbOLRhpbGw7lRdOjSiwtT6hZDJiL5a2H1woUWV
 I5nbr74q9yXyFdu1ZFYlMUyY2RyhRZELyEQKcW5V/ObZ64ahco3YenfjOj8Qtf+tOYa0
 k/BL2sDTPlDtVl3vmD9evIJ78fpELv72qqccT/hgy/EX5F43sqg/DdatEGNGxdvfAhcP rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjaru57fu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:51:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32RApWCp026327;
        Mon, 27 Mar 2023 10:51:32 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pjaru57ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:51:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32QNnE5a015876;
        Mon, 27 Mar 2023 10:51:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3phr7ftb7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 10:51:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32RApPAR20120260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 10:51:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4B2E2004D;
        Mon, 27 Mar 2023 10:51:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C56320040;
        Mon, 27 Mar 2023 10:51:22 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.40.181])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Mar 2023 10:51:21 +0000 (GMT)
Date:   Mon, 27 Mar 2023 16:21:19 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arch/powerpc/kvm: kvmppc_hv_entry: remove .global
 scope
Message-ID: <ZCF1J7mzFBXBwmL5@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230327100411.3342194-1-kconsul@linux.vnet.ibm.com>
 <CRH3GJDNC4SF.2HBIHLLQSCWSI@bobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CRH3GJDNC4SF.2HBIHLLQSCWSI@bobo>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E3JJOQ2rOSLbt0wCg5BPivPNtXhdYEmg
X-Proofpoint-GUID: sxH-6zmZlqeQLVxAVZawt2VGlnbBsimr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-27 20:30:02, Nicholas Piggin wrote:
> On Mon Mar 27, 2023 at 8:04 PM AEST, Kautuk Consul wrote:
> > kvmppc_hv_entry isn't called from anywhere other than
> > book3s_hv_rmhandlers.S itself. Removing .global scope for
> > this function and annotating it with SYM_CODE_START_LOCAL
> > and SYM_CODE_END.
> 
> Does removing .global introduce the objtool warning, or was it already
> present? Just trying to understand if this is two changes or one (not
> that it really matters, maybe just for the purpose of the changelog).
Yes. Just removing .global introduces the objtool warning.
> 
> Since the patch only touches KVM, subject should follow arch/powerpc/kvm
> convention, which is not the same as the rest of arch/powerpc. KVM: PPC:
> Book3S HV:
Okay. Do you need me to send another patch in "KVM: PPC: Book3S HV:"
format ?
> 
> Otherwise seems okay
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Thank you!
> 
> Thanks,
> Nick
> 
> >
> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index acf80915f406..0a9781192b86 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -502,8 +502,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> >   *                                                                            *
> >   *****************************************************************************/
> >  
> > -.global kvmppc_hv_entry
> > -kvmppc_hv_entry:
> > +SYM_CODE_START_LOCAL(kvmppc_hv_entry)
> >  
> >  	/* Required state:
> >  	 *
> > @@ -940,6 +939,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> >  	ld	r4, VCPU_GPR(R4)(r4)
> >  	HRFI_TO_GUEST
> >  	b	.
> > +SYM_CODE_END(kvmppc_hv_entry)
> >  
> >  secondary_too_late:
> >  	li	r12, 0
> > -- 
> > 2.39.2
> 
