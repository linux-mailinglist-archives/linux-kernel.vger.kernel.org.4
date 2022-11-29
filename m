Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18FF63C9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiK2VAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235854AbiK2VAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:00:52 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AC854B02
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:00:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z17so10076903pff.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv7bP6Ykoos9p/GSChQ3hTQpD+T90m2BXvicS8ztKkY=;
        b=LjZa0NyucvKgdFLDZuq/BMDOGwBjA+nS/RFT6FpAkCYZ7VfBn0Zxee9PeRD82I1fN8
         E1bQmWmUQrYGjJni2jrPozVvZT6FDGsqjfy66v3/QQydBYikDmMXH+ULHSk0nfg5QSgP
         h2iuulqYQXz4Su5XKM7uealW6p3CrNk550WHCTnvyoaxLQ2nrEZ/yq8ti7QR4HBj3SgA
         e2RMNQY1NIW38zpdVC5XjX/JXKOVp5mVsxFXRDDscvhzdzCyA92Vs9g2XJUGfFl2xb2C
         kMb9AoRdkWS7O20ZHucbwBET0m1JZX9LwgAZUQyQ6um1Fl+numP+ifFobdYTGf4+VA8/
         rP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv7bP6Ykoos9p/GSChQ3hTQpD+T90m2BXvicS8ztKkY=;
        b=lRTLdL0IsalW0ALxlgkmq0J9h88pOS36F4VOt9da3/jw1avDIDXmLIaPozzHA7Bv/r
         z2ckxgM7OlAEsxUIYtIHn6AJDXXrdMQF5j7f5UuvZBslfeSGT5rUXDCWdl7t5pjj5B8Q
         Li7ntWI5EudqbH8tG9afrVzSrt78/vo9u/u1nFUXx0/a/NRq2asCjLJ0zwXLQodslU2R
         6sUKbzoD6fRDPSOGmj52SzbnlTFbWZyJvLiL0m816Q0O62SdHKWjmgGwoy5qKzhx4o8f
         b12UQscldWnG111hJO01xVcoDbYheUNmJyB6RxaAX153oPMKK70TcTQTTflMo5EpcNGg
         dedw==
X-Gm-Message-State: ANoB5pmOZPg/bVCS18iMUFkHnCtcTwQNNZ9GB/S7IEiyAHGG/eTsr3eo
        KcWFUP7cnTJNKVv0vLmWBHQyTg==
X-Google-Smtp-Source: AA0mqf6LGlNdkJlLDcwfP4oo7asFABbkB+ZP9oQrvqjFFePdLkCPII5mdqk5RqRXD5AGhShcjzDHXg==
X-Received: by 2002:a63:5a62:0:b0:476:ed2a:6215 with SMTP id k34-20020a635a62000000b00476ed2a6215mr34342882pgm.559.1669755648622;
        Tue, 29 Nov 2022 13:00:48 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com. [34.82.181.220])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b0018957322953sm11407727plg.45.2022.11.29.13.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 13:00:48 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:00:44 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Subject: Re: [PATCH 3/4] KVM: arm64: Handle access faults behind the read lock
Message-ID: <Y4Zy/MtIgeLyRGy9@google.com>
References: <20221129191946.1735662-1-oliver.upton@linux.dev>
 <20221129191946.1735662-4-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129191946.1735662-4-oliver.upton@linux.dev>
X-Spam-Status: No, score=-15.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URI_DOTEDU,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 07:19:45PM +0000, Oliver Upton wrote:
> As the underlying software walkers are able to traverse and update
> stage-2 in parallel there is no need to serialize access faults.
> 
> Only take the read lock when handling an access fault.
> 
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>  arch/arm64/kvm/hyp/pgtable.c | 2 +-
>  arch/arm64/kvm/mmu.c         | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> index 9626f615d9b8..1a3dd9774707 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -1097,7 +1097,7 @@ kvm_pte_t kvm_pgtable_stage2_mkyoung(struct kvm_pgtable *pgt, u64 addr)
>  	int ret;
>  
>  	ret = stage2_update_leaf_attrs(pgt, addr, 1, KVM_PTE_LEAF_ATTR_LO_S2_AF, 0,
> -				       &pte, NULL, 0);
> +				       &pte, NULL, KVM_PGTABLE_WALK_SHARED);
>  	if (!ret)
>  		dsb(ishst);
>  
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 886ad5ee767a..347985a56414 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -1404,10 +1404,10 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>  
>  	trace_kvm_access_fault(fault_ipa);
>  
> -	write_lock(&vcpu->kvm->mmu_lock);
> +	read_lock(&vcpu->kvm->mmu_lock);
>  	mmu = vcpu->arch.hw_mmu;
>  	pte = kvm_pgtable_stage2_mkyoung(mmu->pgt, fault_ipa);
> -	write_unlock(&vcpu->kvm->mmu_lock);
> +	read_unlock(&vcpu->kvm->mmu_lock);
>  
>  	if (kvm_pte_valid(pte))
>  		kvm_set_pfn_accessed(kvm_pte_to_pfn(pte));
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

Reviewed-by: Ricardo Koller <ricarkol@google.com>
