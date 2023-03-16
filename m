Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405416BC4D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCPDjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCPDjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:39:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F21D1E1FC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:39:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcY0F71gLz4x90;
        Thu, 16 Mar 2023 14:39:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678937951;
        bh=NrTPBr622oFvFNttiNz5xJwl/XevdMqOx/8Y12H9wHY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QhWGqZiHprk8la36ExY8454QlH4RQCrApw/vkEbLkntPgfWD+Re1L7riX/fVnSFW5
         zv0z3umIw2kAeYoBeGuQoWBONlUCc3V1HgPG4cKOiNjyx52l+70sRLCcMulK22vbuv
         8ygNL4tCl9rolx4qA71YHbDGjmNsHoY/3Q74mjwyRGQRX7CpDkQC9/JOlaxxXWYYEv
         mLJfIFOyS5ASE8jyGUgSmG/bFN7KPjj0v5ObBn3wvgT88zTB9rQ8IYEUX1R5ogKArE
         yqO9uAW+sShnamBMHh6o8/WR1AUvNXSlsjoRIHJeZ1X9v94fDhUs42fPLtSeWv377n
         n4pgxLx+OHu7g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
In-Reply-To: <ZBFVAxAFsUJtuzEy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20230306123740.3648841-1-kconsul@linux.vnet.ibm.com>
 <20230306123740.3648841-3-kconsul@linux.vnet.ibm.com>
 <875yb2oc0a.fsf@mpe.ellerman.id.au>
 <ZBFVAxAFsUJtuzEy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
Date:   Thu, 16 Mar 2023 14:39:08 +1100
Message-ID: <87wn3hmkkj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> On 2023-03-15 15:48:53, Michael Ellerman wrote:
>> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>> > kvmppc_hv_entry is called from only 2 locations within
>> > book3s_hv_rmhandlers.S. Both of those locations set r4
>> > as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
>> > So, shift the r4 load instruction to kvmppc_hv_entry and
>> > thus modify the calling convention of this function.
>> >
>> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
>> > ---
>> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 9 ++++-----
>> >  1 file changed, 4 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> > index b81ba4ee0521..da9a15db12fe 100644
>> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> > @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
>> >  	RFI_TO_KERNEL
>> >  
>> >  kvmppc_call_hv_entry:
>> > -	ld	r4, HSTATE_KVM_VCPU(r13)
>> > +	/* Enter guest. */
>> >  	bl	kvmppc_hv_entry
>> >  
>> >  	/* Back from guest - restore host state and return to caller */
>> > @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
>> >  	mtspr	SPRN_LDBAR, r0
>> >  	isync
>> >  63:
>> > -	/* Order load of vcpu after load of vcore */
>> > -	lwsync
>> 
>> Where did this barrier go?
>> 
>> I don't see that it's covered by any existing barriers in
>> kvmppc_hv_entry, and you don't add it back anywhere. 
>
> My concept about this is that since now the call to kvmppc_hv_entry
> is first taken before the load to r4 shouldn't the pending load in the
> pipeline of the HSTATE_KVM_VCORE as per the earlier comment be ordered anyway
> before-hand ?

No.
 
> Or do you mean to say that pending loads may not be
> cleared/flushed across the "bl <funcname>" boundary ?

Right.

The "bl" imposes no ordering on loads before or after it.

In general nothing orders two independant loads, other than a barrier.

cheers
