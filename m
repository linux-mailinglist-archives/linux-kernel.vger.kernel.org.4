Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD0F5EE6D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiI1UwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbiI1Uvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:51:42 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD38B12D3E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:51:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f23so12725863plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CKofddAHcPQRc9QC4ZWtaFuWxwVpbiqK8/v/Qzlp8bE=;
        b=MNPQEyCQNePGR3ZzDERJAm37fW4BSdwkxJBruJsOWizn7WK+z6N9sU1ttDDptlxywx
         psY3/OAmm6T/qJLeeJOA5XevX9JcbChMyaq+Z++MRaLNAeAusJyObcczEZCuUCN1+iaL
         ZmffiBzimcNl8QnS4sMuoOp/bA2lf4NJkdFmlmiDzt05gYU1q+AOqOl2ynrMDiEeWlZ9
         8yW4APYwIC6dVqekm5qIcmlc5J4wF22326smqwujaAewww22sJrUBDY/w0F2p562gk0H
         mlb0oqNGAdXNJ2kSUrx97XZjq53YDYfBk/ra8EG/cDAfnhgiqXxTDrSj8qsqUKyp9E3o
         NV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CKofddAHcPQRc9QC4ZWtaFuWxwVpbiqK8/v/Qzlp8bE=;
        b=Qrw7OKw/5UKpbUPP7O7WR5Itsdz+wHMjOqAtgm+J1+bWvXH6inOQX8vZjIkC2kUpRI
         YXstEbWq8lCDJFGKnzCvciTt5uGIVeKS58WuBCqeP+sYlOFTPlM6YuSvvM2EbmUJ64Xd
         DGgodOmJWh4SNv6WWsWVs9wAQ4P4/Vm9nWDW9PnivnFSfzpHBvet/ftFGQt6lQJrQ9tT
         vyrxJ1iIsN+oEzUvWSAECjqxhsMtsxYigq+/9SZHWXkmn+vhzvP5yZ0Th9YYHn0VjfHY
         /pAKNZhDRCkDYny+YNwlHnBv8Z4zB7a6fpO9bbDvzKpvTCjgr9fqVi2gKxKDYmbA+gjE
         J9dA==
X-Gm-Message-State: ACrzQf1Ua48pogyfcch4f14wD7Njam65miAKMzTw+6HWKiqm4afezU/F
        A8L6FxXPMNBb/jHHYp3Ls4XfEQ==
X-Google-Smtp-Source: AMsMyM5+eivQVT0+3BnM+5B4Axqq3jVmRHrdXPU4KQbBWBNGqnxg7pD5N+MvNc+/foeB/fqrzP8U4Q==
X-Received: by 2002:a17:903:2309:b0:176:de48:e940 with SMTP id d9-20020a170903230900b00176de48e940mr1561555plh.15.1664398297185;
        Wed, 28 Sep 2022 13:51:37 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id gq20-20020a17090b105400b00203a4f70b90sm2006978pjb.45.2022.09.28.13.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:51:36 -0700 (PDT)
Date:   Wed, 28 Sep 2022 20:51:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc:     kvm@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] KVM: x86/mmu: Fix wrong gfn range of tlb flushing
 in validate_direct_spte()
Message-ID: <YzSz1bFwD1XQ//yY@google.com>
References: <cover.1663929851.git.houwenlong.hwl@antgroup.com>
 <4c4c0943f431e760a51ec0d45e3979c38820749f.1663929851.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c4c0943f431e760a51ec0d45e3979c38820749f.1663929851.git.houwenlong.hwl@antgroup.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022, Hou Wenlong wrote:
> The spte pointing to the children SP is dropped, so the
> whole gfn range covered by the children SP should be flushed.
> Although, Hyper-V may treat a 1-page flush the same if the
> address points to a huge page, it still would be better
> to use the correct size of huge page. Also introduce
> a helper function to do range-based flushing when a direct
> SP is dropped, which would help prevent future buggy use
> of kvm_flush_remote_tlbs_with_address() in such case.

Please wrap closer to ~75 chars.

> Fixes: c3134ce240eed ("KVM: Replace old tlb flush function with new one to flush a specified range.")
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          |  9 ++++++++-
>  arch/x86/kvm/mmu/mmu_internal.h | 10 ++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e418ef3ecfcb..ae9f84b0fc64 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -260,6 +260,13 @@ void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
>  	kvm_flush_remote_tlbs_with_range(kvm, &range);
>  }
>  
> +/* Flush all memory mapped by the given direct SP. */
> +static void kvm_flush_remote_tlbs_direct_sp(struct kvm *kvm, struct kvm_mmu_page *sp)
> +{
> +	WARN_ON_ONCE(!sp->role.direct);
> +	kvm_flush_remote_tlbs_gfn(kvm, sp->gfn, sp->role.level + 1);
> +}
> +
>  static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
>  			   unsigned int access)
>  {
> @@ -2341,7 +2348,7 @@ static void validate_direct_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  			return;
>  
>  		drop_parent_pte(child, sptep);
> -		kvm_flush_remote_tlbs_with_address(vcpu->kvm, child->gfn, 1);
> +		kvm_flush_remote_tlbs_direct_sp(vcpu->kvm, child);

As mentioned very belatedly[*], I would rather move this patch later in the series
and use kvm_flush_remote_tlbs_sptep() instead of introducing a one-off helper.

[*] https://lore.kernel.org/all/YzMoWghqNJdYBlaE@google.com
