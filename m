Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1026E63E778
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 03:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiLACHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 21:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLACHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 21:07:20 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0D49D811
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:07:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x13-20020a17090a46cd00b00218f611b6e9so561827pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 18:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Yv+muzPKYyoo83bWuTuoWw9IavMvQEWUUPYi5mla7w=;
        b=nu7QmhaB5OU8Sz87xzT0B/TDbai2tkzlc8q8PMFAVC6MmY5ORSCDXElnwD5AeyHTfU
         tQY11jozUluEkW9FOiPUqvg1K2Ad20U+kvZGZsd3j0A9uXZLxsEDaCMW3TEu3rZFnJAL
         y4ReCeui3IxbT0xBUXK5visY533ogW747HkAdHzpFlZRzWGj38cLleZyLcFF4+nMLbkq
         sO+gd9QsBsVD13i66CYdr7XLlkLCGb0IGzkIFe5R4zD8VeU0G4puf/2owFqvYC+u8Nmk
         5f+5aRCjLF0wgzUDxwWBnpsXi9NG6o+joQjmCsGTy75OphDg0GADwMHeO7EHo1Dlq+A2
         7vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Yv+muzPKYyoo83bWuTuoWw9IavMvQEWUUPYi5mla7w=;
        b=SS+5ulaqT4XWa5MdwufoU2YEl1KVNxHAuz7ux+EmuYmaOw81dqISBlhqxi4+dRqLZ3
         +xZ6PNpF7VFchwyPE712yEcVoAURhPxb67WGAnyOrQ6zAJ0cF5B0vqDk5P4JgwSUPakh
         zKHeo5wXVdyhVc9IvNfsfcMj2dS9pl2+BO+enOWUW+GGUsUIczXE5XTQ1iD3RrHBdkdz
         T5MIPvjULBBGrSSeJVRuBs0Y/cbR8vSVZmFXe9KqmHnL9aK/5z9pIQI+He0PyDMSixCC
         YA0e+ScFgucsV7dvfAiTtcoyQoDaZ/1BoYH9o7bTZCZLJuXrQ/NTJl+c3iBrYBWZfcWB
         EklQ==
X-Gm-Message-State: ANoB5pkSJ6rK/sBwgav50jHLY5znrLqWt6iPXsQ1b7eCWxtmrE22cP04
        +nVHxMm55u2t9vmcX+0UPHEtUQ==
X-Google-Smtp-Source: AA0mqf7TrFs8X1Ox0jXmGnlp6X7ZU+swoypahjfGlG54Z6D/xl4AlojOuynTre1dZOAXA5aGhwHUgg==
X-Received: by 2002:a17:90a:8417:b0:210:9e08:d577 with SMTP id j23-20020a17090a841700b002109e08d577mr75432375pjn.134.1669860439764;
        Wed, 30 Nov 2022 18:07:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902c40100b0017e64da44c5sm2164639plk.203.2022.11.30.18.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 18:07:19 -0800 (PST)
Date:   Thu, 1 Dec 2022 02:07:15 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] KVM: x86: Remove unnecessary export of
 kvm_vcpu_is_reset_bsp()
Message-ID: <Y4gMU3bKSE4Pu6Gk@google.com>
References: <20221114095606.39785-1-likexu@tencent.com>
 <20221114095606.39785-11-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114095606.39785-11-likexu@tencent.com>
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

On Mon, Nov 14, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Don't export x86's kvm_vcpu_is_reset_bsp(), the helper isn't used by
> KVM x86's vendor modules. Move up the code block out of existing
> callers' need.

Again, no.  kvm_vcpu_is_reset_bsp() is declared by kvm_vcpu_is_reset_bsp().  The
lack of "static" is the first clue, and the fact that KVM compiles without issue
today is the second clue.  EXPORT_SYMBOL_GPL() only affects resolving module
dependencies, it doesn't provide any information to the compiler about function
prototypes.

> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/kvm/x86.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index f325710a4f25..f3cb3e02bfa6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11496,6 +11496,11 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  	return static_call(kvm_x86_vcpu_precreate)(kvm);
>  }
>  
> +bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->kvm->arch.bsp_vcpu_id == vcpu->vcpu_id;
> +}
> +
>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  {
>  	struct page *page;
> @@ -11993,12 +11998,6 @@ int kvm_arch_check_processor_compat(void *opaque)
>  	return ops->check_processor_compatibility();
>  }
>  
> -bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
> -{
> -	return vcpu->kvm->arch.bsp_vcpu_id == vcpu->vcpu_id;
> -}
> -EXPORT_SYMBOL_GPL(kvm_vcpu_is_reset_bsp);
> -
>  bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu)
>  {
>  	return (vcpu->arch.apic_base & MSR_IA32_APICBASE_BSP) != 0;
> -- 
> 2.38.1
> 
