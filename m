Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03BC6C4A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjCVMSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCVMRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:17:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCBA3FBAB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 05:17:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhSCk5TsSz4xDj;
        Wed, 22 Mar 2023 23:17:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679487461;
        bh=ufR99BEAK4No/lNAuV96Y+u4crBQmDihY2XvtfGDO78=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=G59iFYI30uqnlkTsYDvDNmS35pg0t3ED6bwLLG65LRotjV/h8AL3LYwKVf/kd78PP
         l4g7o3fz/hrkPgHDsGAHP7Y2f81TeP8SwXjXElpTCj/yrfGr/nUz5Lqq/H7Arhg5Gi
         TOE+XZtX7i0VbAr1kb+Z204ukjpThT1q7DJJFF+p3iCYOnBj/72XQvLf/NAJp3HPlC
         oQyS1GLw1DXHY6SqPt1s9igAjHqc95OFAO5WQ6X27cLRbgBHMjjd7DxAa0L4sohgJM
         IHrXuZ2vcJEUmGTX+9950n7Vi73/QJNKeCWNHdjkkJ8VrpAZ6RV8W7QqyDH8abY8u8
         tTHgfABHg0jJA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] arch/powerpc/kvm: kvmppc_hv_entry: remove r4
 argument
In-Reply-To: <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
References: <20230316051025.1424093-1-kconsul@linux.vnet.ibm.com>
 <20230316051025.1424093-3-kconsul@linux.vnet.ibm.com>
Date:   Wed, 22 Mar 2023 23:17:35 +1100
Message-ID: <87v8itt1y8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> kvmppc_hv_entry is called from only 2 locations within
> book3s_hv_rmhandlers.S. Both of those locations set r4
> as HSTATE_KVM_VCPU(r13) before calling kvmppc_hv_entry.
> So, shift the r4 load instruction to kvmppc_hv_entry and
> thus modify the calling convention of this function.
>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index b81ba4ee0521..b61f0b2c677b 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -85,7 +85,7 @@ _GLOBAL_TOC(kvmppc_hv_entry_trampoline)
>  	RFI_TO_KERNEL
>  
>  kvmppc_call_hv_entry:
> -	ld	r4, HSTATE_KVM_VCPU(r13)
> +	/* Enter guest. */
>  	bl	kvmppc_hv_entry
>  
>  	/* Back from guest - restore host state and return to caller */
> @@ -352,9 +352,7 @@ kvm_secondary_got_guest:
>  	mtspr	SPRN_LDBAR, r0
>  	isync
>  63:
> -	/* Order load of vcpu after load of vcore */
> -	lwsync
> -	ld	r4, HSTATE_KVM_VCPU(r13)
> +	/* Enter guest. */
>  	bl	kvmppc_hv_entry
>  
>  	/* Back from the guest, go back to nap */
> @@ -506,7 +504,6 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
>  
>  	/* Required state:
>  	 *
> -	 * R4 = vcpu pointer (or NULL)
>  	 * MSR = ~IR|DR
>  	 * R13 = PACA
>  	 * R1 = host R1
> @@ -524,6 +521,10 @@ SYM_INNER_LABEL(kvmppc_hv_entry, SYM_L_LOCAL)
>  	li	r6, KVM_GUEST_MODE_HOST_HV
>  	stb	r6, HSTATE_IN_GUEST(r13)
>  
> +	/* Order load of vcpu after load of vcore */

Just copying the comment here doesn't work. It doesn't make sense on its
own here, because the VCORE is loaded (again) a few lines below (536).
So as written this comment seems backward vs the code.

The comment would need to expand to explain that the barrier is for the
case where we came from kvm_secondary_got_guest.

> +	lwsync
> +	ld	r4, HSTATE_KVM_VCPU(r13)
> +
>  #ifdef CONFIG_KVM_BOOK3S_HV_P8_TIMING
>  	/* Store initial timestamp */
>  	cmpdi	r4, 0


But as Nick says I don't think it's worth investing effort in small
tweaks to this code. The risk of introducing bugs is too high for such a
small improvement to the code.

Thanks for trying, but I think this asm code is best left more or less
alone unless we find actual bugs in it - or unless we can make
substantial improvements to it, which would be rewriting in C, or at
least converting to a fully call/return style rather than the current
forest of labels.

I will take patch 1 though, as that's an obvious cleanup and poses no
risk (famous last words :D).

cheers
