Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7D6CBB66
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjC1Jpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjC1Jp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:45:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73845FC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:44:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pm4Xk2N3Wz4wj7;
        Tue, 28 Mar 2023 20:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1679996695;
        bh=h44tjwPWW2IRwuQCXs8ZriqQ5qG2iC4F4mxOhWNfVck=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F5gJRWm7WYCKGU8Q8KbQ8Da7oWCG2XDwriXfyP60NS1OhQb9+TdIrYsLHNpqTlhiF
         R4Uhpez9mvEBvPvasQa8NQSZZUDDcf7zykZMwRbD4lJJICohazRItWFu+hz42L9kIP
         NnzigE0Fc0+gX7nimp5REAYTGzmdD395VaF1zgu7UNtKlJRHgMgIidbCCbKpSNmjRk
         vMzYtIPuoMcD14nFNidNlNcraSx1+aD/ay3yrSd8dNvswFbBalIErdrAxncLkek7Lh
         Soq5ckLM7ksSOjlq6mHUeR9fbdeeH6PRVeni4wyqlf45qb9a5Y1vq1rAv6vqu6SbzM
         2CpPJwZzloZyA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kautuk Consul <kconsul@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kautuk Consul <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc/kvm: kvmppc_core_vcpu_create_hv: check for
 kzalloc failure
In-Reply-To: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
References: <20230323074718.2810914-1-kconsul@linux.vnet.ibm.com>
Date:   Tue, 28 Mar 2023 20:44:48 +1100
Message-ID: <87pm8tcir3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kautuk Consul <kconsul@linux.vnet.ibm.com> writes:
> kvmppc_vcore_create() might not be able to allocate memory through
> kzalloc. In that case the kvm->arch.online_vcores shouldn't be
> incremented.

I agree that looks wrong.

Have you tried to test what goes wrong if it fails? It looks like it
will break the LPCR update, which likely will cause the guest to crash
horribly.

You could use CONFIG_FAIL_SLAB and fail-nth etc. to fail just one
allocation for a guest. Or probably easier to just hack the code to fail
the 4th time it's called using a static counter.

Doesn't really matter but could be interesting.

> Add a check for kzalloc failure and return with -ENOMEM from
> kvmppc_core_vcpu_create_hv().
>
> Signed-off-by: Kautuk Consul <kconsul@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 6ba68dd6190b..e29ee755c920 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2968,13 +2968,17 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
>  			pr_devel("KVM: collision on id %u", id);
>  			vcore = NULL;
>  		} else if (!vcore) {
> +			vcore = kvmppc_vcore_create(kvm,
> +					id & ~(kvm->arch.smt_mode - 1));

That line doesn't need to be wrapped, we allow 90 columns.

> +			if (unlikely(!vcore)) {
> +				mutex_unlock(&kvm->lock);
> +				return -ENOMEM;
> +			}

Rather than introducing a new return point here, I think it would be
preferable to use the existing !vcore case below.

>  			/*
>  			 * Take mmu_setup_lock for mutual exclusion
>  			 * with kvmppc_update_lpcr().
>  			 */
> -			err = -ENOMEM;
> -			vcore = kvmppc_vcore_create(kvm,
> -					id & ~(kvm->arch.smt_mode - 1));

So leave that as is (maybe move the comment down).

And wrap the below in:

 +                      if (vcore) {

>  			mutex_lock(&kvm->arch.mmu_setup_lock);
>  			kvm->arch.vcores[core] = vcore;
>  			kvm->arch.online_vcores++;
 			
 			mutex_unlock(&kvm->arch.mmu_setup_lock);
 +                      }
		}
	}

Meaning the vcore == NULL case will fall through to here and return via
this existing path:

	mutex_unlock(&kvm->lock);

	if (!vcore)
		return err;


cheers
