Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9364E6BC4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjCPDks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCPDkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:40:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A971A65A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 20:40:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PcY1y3h2Nz4x8y;
        Thu, 16 Mar 2023 14:40:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678938038;
        bh=I3HdvAcjOnC3mWz6xETiXQNQkQ+kPYn2LRCsS1aHHxo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VSUShDq/swzrokk+AQXZlmmNSi1MzAzEvXjT7bq6peUqR5Ewi6p1APbXY1kSVSbxY
         0UE+BuRiNnuB66zAS5iVv+opzSjKHYw4DLdZkxi4DjBPiYMvtZK9OQPzDAaPo1MQEY
         JqoDlE+rN17JmcXqVkxo9jPzFXqwMZpldavTPLCzb3t20HqHcibHL3uGAapkn37fJ8
         QR/syeAzzKw5SWpZ69p60PP8W8b/hVUdrc8Gxum2if2wyVZMcCILAEho1U1rPspHxg
         9Q8ah4/KqW5RG6oVNXZShpB3S7I2tiSgoA3ol+YsVUGmdfxGj7awNI5XoCBRzKz4Bk
         NhJZfSKQ2xOQw==
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
In-Reply-To: <87wn3hmkkj.fsf@mpe.ellerman.id.au>
References: <20230306123740.3648841-1-kconsul@linux.vnet.ibm.com>
 <20230306123740.3648841-3-kconsul@linux.vnet.ibm.com>
 <875yb2oc0a.fsf@mpe.ellerman.id.au>
 <ZBFVAxAFsUJtuzEy@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <87wn3hmkkj.fsf@mpe.ellerman.id.au>
Date:   Thu, 16 Mar 2023 14:40:38 +1100
Message-ID: <87ttylmki1.fsf@mpe.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>> On 2023-03-15 15:48:53, Michael Ellerman wrote:
>>> Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
>>> > kvmppc_hv_entry is called from only 2 locations within
>>> > book3s_hv_rmhandlers.S. Both of those locations set r4
>>> > as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
>>> > So, shift the r4 load instruction to kvmppc_hv_entry and
>>> > thus modify the calling convention of this function.
>>> >
>>> > Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
>>> > ---
>>> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 9 ++++-----
>>> >  1 file changed, 4 insertions(+), 5 deletions(-)
>>> >
>>> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>> > index b81ba4ee0521..da9a15db12fe 100644
>>> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>>> > @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
>>> >  	RFI_TO_KERNEL
>>> >  
>>> >  kvmppc_call_hv_entry:
>>> > -	ld	r4, HSTATE_KVM_VCPU(r13)
>>> > +	/* Enter guest. */
>>> >  	bl	kvmppc_hv_entry
>>> >  
>>> >  	/* Back from guest - restore host state and return to caller */
>>> > @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
>>> >  	mtspr	SPRN_LDBAR, r0
>>> >  	isync
>>> >  63:
>>> > -	/* Order load of vcpu after load of vcore */
>>> > -	lwsync
>>> 
>>> Where did this barrier go?
>>> 
>>> I don't see that it's covered by any existing barriers in
>>> kvmppc_hv_entry, and you don't add it back anywhere. 
>>
>> My concept about this is that since now the call to kvmppc_hv_entry
>> is first taken before the load to r4 shouldn't the pending load in the
>> pipeline of the HSTATE_KVM_VCORE as per the earlier comment be ordered anyway
>> before-hand ?
>
> No.
>  
>> Or do you mean to say that pending loads may not be
>> cleared/flushed across the "bl <funcname>" boundary ?
>
> Right.
>
> The "bl" imposes no ordering on loads before or after it.
>
> In general nothing orders two independant loads, other than a barrier.

There's some docs on barriers here:

  https://www.kernel.org/doc/Documentation/memory-barriers.txt

Though admittedly it is pretty dense.

cheers
