Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7406BA700
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 06:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjCOFXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 01:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjCOFW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 01:22:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C3618AE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 22:20:05 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32F42xNQ017397;
        Wed, 15 Mar 2023 05:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qSSH418kIOoGGXr6c5dJmkGXPsuy72k7qgb8PgBKnuo=;
 b=aKar1w2hH93G7lkhZzqYdCv3y1c2t06e1wQ0/iZCPx6ThkcXzklJioZ/dwSMi0KLu0yN
 6Lpot9KJOCFgMaIPyHK6kKS5YTh0/utiqMN4CXHVIrTzAYy9NzCGyTiiSYgI6Duvmog3
 aoig8Qu+MhN1lp/EY+MHmAjxZXDv3L0zkaAXxKO416aJTISZ+shXl9EVNcmBGWIPdWRj
 Lo78gGsFfNVHKRCsV0nRJxQZRwzGYaZcjD4/7UVfcebC18rhyqzaOO9rfmauhkP01Cwg
 sJx+cV39ZNlCInYzNygMfStXRacu6Z867TSncfHp8C4llgWkFqHSLrdx7HDyRbDvZt/Z Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb6nasekj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 05:18:07 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32F5HsLL004236;
        Wed, 15 Mar 2023 05:18:06 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pb6nasejp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 05:18:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32EN60N5031523;
        Wed, 15 Mar 2023 05:18:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3pb29s08bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 05:18:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32F5I1I140501622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Mar 2023 05:18:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB6A92004D;
        Wed, 15 Mar 2023 05:18:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 804E92004B;
        Wed, 15 Mar 2023 05:17:58 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.57.144])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 15 Mar 2023 05:17:58 +0000 (GMT)
Date:   Wed, 15 Mar 2023 10:47:55 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
Message-ID: <ZBFVAxAFsUJtuzEy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230306123740.3648841-1-kconsul@linux.vnet.ibm.com>
 <20230306123740.3648841-3-kconsul@linux.vnet.ibm.com>
 <875yb2oc0a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yb2oc0a.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9QWMuV-DyYNU86JUtYWhFJs-SYFCsqCM
X-Proofpoint-ORIG-GUID: 7lSf70deN0dIJHRVXSRv1h7jHvgmgBId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_16,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2302240000 definitions=main-2303150043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-15 15:48:53, Michael Ellerman wrote:
> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> > kvmppc_hv_entry is called from only 2 locations within
> > book3s_hv_rmhandlers.S. Both of those locations set r4
> > as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
> > So, shift the r4 load instruction to kvmppc_hv_entry and
> > thus modify the calling convention of this function.
> >
> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > index b81ba4ee0521..da9a15db12fe 100644
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
> 
> Where did this barrier go?
> 
> I don't see that it's covered by any existing barriers in
> kvmppc_hv_entry, and you don't add it back anywhere. 

My concept about this is that since now the call to kvmppc_hv_entry
is first taken before the load to r4 shouldn't the pending load in the
pipeline of the HSTATE_KVM_VCORE as per the earlier comment be ordered anyway
before-hand ? Or do you mesn to say that pending loads may not be
cleared/flushed across the "bl <funcname>" boundary ?
> 
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
> > @@ -524,6 +521,8 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> >  	li	r6, KVM_GUEST_MODE_HOST_HV
> >  	stb	r6, HSTATE_IN_GUEST(r13)
> >  
> > +	ld	r4, HSTATE_KVM_VCPU(r13)
> > +
> >  #ifdef CONFIG_KVM_BOOK3S_HV_P8_TIMING
> >  	/* Store initial timestamp */
> >  	cmpdi	r4, 0
> 
> cheers
