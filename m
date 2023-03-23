Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C86C5E41
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjCWEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCWEy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:54:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24CD26CE0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:54:22 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32N2gJrZ022891;
        Thu, 23 Mar 2023 04:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Fz949UnED9b+z0odK5W4St+mvGSXOw93nxagEvAaO4Y=;
 b=jgjmRsXunbRqluf+PcCSEPmeerRlEhMq6ZcGAY9TLW7lBopmAfw+tlKW8gm8ChorCgEl
 /RYpkeyM8nLDgEg+t2lJYk511v6sXCrVXydr+ooxsKnaFGch5pDjvfn+MJNUub1NuKIn
 UQLVfLrsfVhao8q5iMVuROeIiYW6w3i6u/l3J0dpXD2XOjpdmAVydp+VhdFR9HiEWN/9
 t0eFIwZ9QLLg1TKgEPM432WhuGaYT1+2YBh5V0J5n6vj9m0Pqtr3fc+ngrY06Trcnylx
 YSKvtFv2OoO4rGaG8sjpJwkN9S9Pf13jsZ6yHWLvztQasGXeT9v60KxwYpXrxLfxCCZH 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77a83d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:54:12 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32N4hQrC030824;
        Thu, 23 Mar 2023 04:54:11 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pge77a82r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:54:11 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MB1RbH000634;
        Thu, 23 Mar 2023 04:54:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3pd4x6dqp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 04:54:08 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32N4s5Sf31064674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Mar 2023 04:54:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2563420040;
        Thu, 23 Mar 2023 04:54:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91D932004D;
        Thu, 23 Mar 2023 04:54:02 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.74.26])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Mar 2023 04:54:02 +0000 (GMT)
Date:   Thu, 23 Mar 2023 10:23:59 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
Message-ID: <ZBvbZ1iNcpqDHP0t@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
 <87v8itt1y8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8itt1y8.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bhiEqvG2tWkK9OPUvMTXhfh_puSybM6U
X-Proofpoint-ORIG-GUID: YyCg7sUROtcZmwxYYldgaz7D3p7j4vFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_21,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303230034
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-03-22 23:17:35, Michael Ellerman wrote:
> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> > kvmppc_hv_entry is called from only 2 locations within
> > book3s_hv_rmhandlers.S. Both of those locations set r4
> > as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
> > So, shift the r4 load instruction to kvmppc_hv_entry and
> > thus modify the calling convention of this function.
> >
> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index b81ba4ee0521..b61f0b2c677b 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
> >  	RFI_TO_KERNEL
> >  
> >  kvmppc_call_hv_entry:
> > -	ld	r4, HSTATE_KVM_VCPU(r13)
> > +	/* Enter guest. */
> >  	bl	kvmppc_hv_entry
> >  
> >  	/* Back from guest - restore host state and return to caller */
> > @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
> >  	mtspr	SPRN_LDBAR, r0
> >  	isync
> >  63:
> > -	/* Order load of vcpu after load of vcore */
> > -	lwsync
> > -	ld	r4, HSTATE_KVM_VCPU(r13)
> > +	/* Enter guest. */
> >  	bl	kvmppc_hv_entry
> >  
> >  	/* Back from the guest, go back to nap */
> > @@ -506,7 +504,6 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> >  
> >  	/* Required state:
> >  	 *
> > -	 * R4 = vcpu pointer (or NULL)
> >  	 * MSR = ~IR|DR
> >  	 * R13 = PACA
> >  	 * R1 = host R1
> > @@ -524,6 +521,10 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> >  	li	r6, KVM_GUEST_MODE_HOST_HV
> >  	stb	r6, HSTATE_IN_GUEST(r13)
> >  
> > +	/* Order load of vcpu after load of vcore */
> 
> Just copying the comment here doesn't work. It doesn't make sense on its
> own here, because the VCORE is loaded (again) a few lines below (536).
> So as written this comment seems backward vs the code.
> 
> The comment would need to expand to explain that the barrier is for the
> case where we came from kvm_secondary_got_guest.
> 
Agreed.
> > +	lwsync
> > +	ld	r4, HSTATE_KVM_VCPU(r13)
> > +
> >  #ifdef CONFIG_KVM_BOOK3S_HV_P8_TIMING
> >  	/* Store initial timestamp */
> >  	cmpdi	r4, 0
> 
> 
> But as Nick says I don't think it's worth investing effort in small
> tweaks to this code. The risk of introducing bugs is too high for such a
> small improvement to the code.
> 
> Thanks for trying, but I think this asm code is best left more or less
> alone unless we find actual bugs in it - or unless we can make
> substantial improvements to it, which would be rewriting in C, or at
> least converting to a fully call/return style rather than the current
> forest of labels.
> 
> I will take patch 1 though, as that's an obvious cleanup and poses no
> risk (famous last words :D).
Thanks for taking patch 1. I completely agree that it would not be wise
to introduce even small alterations to stable legacy code. But sending
patches like this and conversing with this mailing list's reviewers
is giving me a good picture of what you are open to accepting at this
stage.

Thanks again!
> 
> cheers
