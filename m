Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFF6C2C9F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCUIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCUIiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:38:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE27A3C16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:37:50 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32L7eWsi007793;
        Tue, 21 Mar 2023 08:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=R2svW98PKPPTPmyvuzhpN7NRgC7Vw1gFSZZjUIWXmj4=;
 b=pgFK8sUi6u2Sy5RO9+gl5X2ekUeeg1QcP4E+XZSjMWyv/C5LJfHc3cMflFbilouqFeJh
 6rORHm3Ha4Lj/FKI+WiTuX+9Ra7CjGvJ+cQAiYFlyips5C8cXlhuXm6cuXgF9/2oLqe6
 6js/+epkzGgXOWAWGZXgDUs52mIKky7zoKYAwQQc3yqoy4CNtVFGBkNSPVS86rfNyDvZ
 I1Ngj+1WRiQmUuwOOVRGpsAixQ+CJpoP8NsoJ21CFiw+OAstiA3i/izXPo8AUkY+qIxe
 HnUIEfAlFRTEcNxYtpLK3VWUQaAWjT15tdYEn260lUHf8XWve+HEDKgq5Z9e3eDQ308B lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf85xs7ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 08:37:37 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32L7f8O5009760;
        Tue, 21 Mar 2023 08:37:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pf85xs7ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 08:37:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH4SMA022346;
        Tue, 21 Mar 2023 08:37:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3pd4x6cd0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 08:37:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32L8bVXM14222052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 08:37:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F4442004E;
        Tue, 21 Mar 2023 08:37:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41D5F20040;
        Tue, 21 Mar 2023 08:37:27 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.88.148])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Mar 2023 08:37:26 +0000 (GMT)
Date:   Tue, 21 Mar 2023 14:07:22 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
Message-ID: <ZBlswnN7RJHn8gFz@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
 <CRBRQAXJRZZW.28LH58EV3T8AL@bobo>
 <ZBk4hCGFqBE+c8+g@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBk4hCGFqBE+c8+g@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I8_aaEKM_kySWpCI9307viXd4qB123ye
X-Proofpoint-GUID: zUmpRGKA7RV5su5V6AFg72GI7LHWWSq8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_06,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303210065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21 10:24:36, Kautuk Consul wrote:
> > Is r4 there only used for CONFIG_KVM_BOOK3S_HV_P8_TIMING? Could put it
> > under there. Although you then lose the barrier if it's disabled, that
> > is okay if you're sure that's the only memory operation being ordered.
> r4 is also used by the secondary_too_late label. So I decided against
> moving it inside the CONFIG_KVM_BOOK3S_HV_P8_TIMING #ifdef as then I
> would need to again load from HSTATE_KVM_VCPU(r13) in secondary_too_late.
> > 
Sorry, forgot to mention, r4 is also being used in the 10f label.
Thats one more reason to not shift the r4 load into the #ifdef.
> > I'm not sure how much new work we want to put into changing this asm
> > code, since it's POWER7/8 only. I would love to move this (and the
> > other) KVM implementations to C like we did with P9. It's a pretty big
> > job though.
> Yeah. I was just reviewing this code and decided to send this small
> improvement to the mailing list. I will check with my team and ask
> them if we could move this implementation to C.
> > 
> > Thanks,
> > Nick
> > 
> > >
> > > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > index b81ba4ee0521..b61f0b2c677b 100644
> > > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > > @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
> > >  	RFI_TO_KERNEL
> > >  
> > >  kvmppc_call_hv_entry:
> > > -	ld	r4, HSTATE_KVM_VCPU(r13)
> > > +	/* Enter guest. */
> > >  	bl	kvmppc_hv_entry
> > >  
> > >  	/* Back from guest - restore host state and return to caller */
> > > @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
> > >  	mtspr	SPRN_LDBAR, r0
> > >  	isync
> > >  63:
> > > -	/* Order load of vcpu after load of vcore */
> > > -	lwsync
> > > -	ld	r4, HSTATE_KVM_VCPU(r13)
> > > +	/* Enter guest. */
> > >  	bl	kvmppc_hv_entry
> > >  
> > >  	/* Back from the guest, go back to nap */
> > > @@ -506,7 +504,6 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> > >  
> > >  	/* Required state:
> > >  	 *
> > > -	 * R4 = vcpu pointer (or NULL)
> > >  	 * MSR = ~IR|DR
> > >  	 * R13 = PACA
> > >  	 * R1 = host R1
> > > @@ -524,6 +521,10 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
> > >  	li	r6, KVM_GUEST_MODE_HOST_HV
> > >  	stb	r6, HSTATE_IN_GUEST(r13)
> > >  
> > > +	/* Order load of vcpu after load of vcore */
> > > +	lwsync
> > > +	ld	r4, HSTATE_KVM_VCPU(r13)
> > > +
> > >  #ifdef CONFIG_KVM_BOOK3S_HV_P8_TIMING
> > >  	/* Store initial timestamp */
> > >  	cmpdi	r4, 0
> > > -- 
> > > 2.39.2
> > 
