Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755E6CBC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjC1KOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjC1KO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:14:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D761F6A67
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:14:25 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SABcMQ024623;
        Tue, 28 Mar 2023 10:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=0Fmmry5YR1A6mSsjoXxgWix7IBTHAR5xItFEU+x7/RU=;
 b=H+CCGMx6ayQfzwDTxlDBjfNQuem0SDLUMaas+UiCil3Ldxjmpe9Wd2TK80+6RBIQ6mM4
 8oGm3qhtpxDrWBAnwDGz1kN/F/i25qgHCvay9V2J/0U8Y/K3FKz5gnIiCxLrGVZSPano
 re3jkkiDxNlczAfCx4NHj0v5wWi9c2oMk51V3jQpLUSjgsvADSu1lXR9GyWzRsnphYpo
 ju84Jbnc9mDqv88U9BzaictHxdXbaOYYSSCEZVI18la3+r47M6unFQQpHq1dVk6vvJ8t
 GZtlf3RBrTcESiQGxEdqOlwMQUQEPEeApPRsWg+JZ6IkZofH0f8Mt+Eb/L5nFbuvd2Ii jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pkv2ukpq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 10:14:15 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32S8DufI022532;
        Tue, 28 Mar 2023 10:14:14 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pkv2ukpp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 10:14:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32RMpFRD002270;
        Tue, 28 Mar 2023 10:14:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3phrk6u9du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 10:14:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32SAE9T423003808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 10:14:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B56202004D;
        Tue, 28 Mar 2023 10:14:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF12020043;
        Tue, 28 Mar 2023 10:14:06 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.75.27])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Mar 2023 10:14:06 +0000 (GMT)
Date:   Tue, 28 Mar 2023 15:44:02 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc/kvm: kvmppc_core_vcpu_create_hv: check for
 kzalloc failure
Message-ID: <ZCK96ohvWRY12zZ3@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
 <87pm8tcir3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm8tcir3.fsf@mpe.ellerman.id.au>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fhbdjxMr25THdo9-QsyJ3QPp9NeC2oxd
X-Proofpoint-ORIG-GUID: tSy5_A9zlgPKTvptuuptKBK2tnTrZ0OJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280084
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-28 20:44:48, Michael Ellerman wrote:
> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> > kvmppc_vcore_create() might not be able to allocate memory through
> > kzalloc. In that case the kvm->arch.online_vcores shouldn't be
> > incremented.
> 
> I agree that looks wrong.
> 
> Have you tried to test what goes wrong if it fails? It looks like it
> will break the LPCR update, which likely will cause the guest to crash
> horribly.
Not sure about LPCR update, but with and without the patch qemu exits
and so the kvm context is pulled down fine.
> 
> You could use CONFIG_FAIL_SLAB and fail-nth etc. to fail just one
> allocation for a guest. Or probably easier to just hack the code to fail
> the 4th time it's called using a static counter.
I am using live debug and I set the r3 return value to 0x0 after the
call to kzalloc.
> 
> Doesn't really matter but could be interesting.
With and without this patch qemu quits with:
qemu-system-ppc64: kvm_init_vcpu: kvm_get_vcpu failed (0): Cannot allocate memory

That's because qemu will shut down when any vcpu is not able
to be allocated.
> 
> > Add a check for kzalloc failure and return with -ENOMEM from
> > kvmppc_core_vcpu_create_hv().
> >
> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index 6ba68dd6190b..e29ee755c920 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -2968,13 +2968,17 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
> >  			pr_devel("KVM: collision on id %u", id);
> >  			vcore = NULL;
> >  		} else if (!vcore) {
> > +			vcore = kvmppc_vcore_create(kvm,
> > +					id & ~(kvm->arch.smt_mode - 1));
> 
> That line doesn't need to be wrapped, we allow 90 columns.
> 
> > +			if (unlikely(!vcore)) {
> > +				mutex_unlock(&kvm->lock);
> > +				return -ENOMEM;
> > +			}
> 
> Rather than introducing a new return point here, I think it would be
> preferable to use the existing !vcore case below.
> 
> >  			/*
> >  			 * Take mmu_setup_lock for mutual exclusion
> >  			 * with kvmppc_update_lpcr().
> >  			 */
> > -			err = -ENOMEM;
> > -			vcore = kvmppc_vcore_create(kvm,
> > -					id & ~(kvm->arch.smt_mode - 1));
> 
> So leave that as is (maybe move the comment down).
> 
> And wrap the below in:
> 
>  +                      if (vcore) {
> 
> >  			mutex_lock(&kvm->arch.mmu_setup_lock);
> >  			kvm->arch.vcores[core] = vcore;
> >  			kvm->arch.online_vcores++;
>  			
>  			mutex_unlock(&kvm->arch.mmu_setup_lock);
>  +                      }
> 		}
> 	}
> 
> Meaning the vcore == NULL case will fall through to here and return via
> this existing path:
> 
> 	mutex_unlock(&kvm->lock);
> 
> 	if (!vcore)
> 		return err;
> 
> 
> cheers
