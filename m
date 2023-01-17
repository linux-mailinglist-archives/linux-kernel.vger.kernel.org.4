Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03993670DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 00:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjAQXhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 18:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAQXfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 18:35:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E706C555
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:29:27 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id c6so34902570pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 13:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+lNEkz0O4zMR1FgXU5ocJNcjThOI8/6Dh7hwA6hzh4o=;
        b=b5OyGAQzNtLsMSGwTdBON874qvcRmyqjarb9IB750Kcl6F0RDw1uwwfE+c7IBY3KAh
         hj5IIOP8eyFCnb6+GoFEWG5NVObDqayqBZHPpiJK4EwNCKB2g3RzMynk8pPHOp0fBQzi
         qzerthWLa8uzt/W0hHkvd8tOk03tQF0hmpyliwPhQteT4YfSg72lGzGu/eWgPvWHg68X
         TjhXbAaNYvxH4rsbPJhbK7F+MJoZezddTF26njKXOF82pRf3e0bCYKG2i5sQByG4sHeL
         a1JGsJV+Djfkryk7hTt66+3HFta9/DU0QZ5xuyFbQunnnuHGpbrFwiJFkcrUL8zVjM7s
         yfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lNEkz0O4zMR1FgXU5ocJNcjThOI8/6Dh7hwA6hzh4o=;
        b=zlbf6/huiboAYc9LtT/v92SuJxa/7AnUoXUdTlAIJPu0EeAzd/l4RXcEblUEMOHMMt
         uAZlK4WPm7TEhshBhW+ih7l4gbDGSCZMGRxaT827p368NDEuRYatbJTMyVBWQIqkZfUm
         zjnXrCWrUZTtufJo2QFHVOO2nEtCTLzjiLLUoV0shZJW8ewjoVoPtQzZPktxYaXyiU6r
         qUNo3VO6FyBLRcMG9/hrC+gt5vu5udmGymAmeNZIUFodkr1IrcoWHDXq5zNPfaE9ZEEG
         l4XJ9zye+4TxIDYpOYmJKisOr2kcb9aCbdsd3UYLI+os6pWHTRiHLBxS2DSQhGMrgFtn
         NrRw==
X-Gm-Message-State: AFqh2kopIFj7XOS1CSAyA6/jw9xjAfAJcZ1PLKRdA8hWbBmi65Dchl0k
        ALIdprrcIbT51p6ag8GV5IHln+A3cvaFzie1
X-Google-Smtp-Source: AMrXdXvKkTvtnpeb2fNvmnhgqPS+1z5o8DTAAuKWY9KxlVN3kYiL4QXiV1Ntx+zlfI+Bdm4QXBkmRQ==
X-Received: by 2002:a17:902:e808:b0:189:b910:c6d2 with SMTP id u8-20020a170902e80800b00189b910c6d2mr2984028plg.1.1673990966791;
        Tue, 17 Jan 2023 13:29:26 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id c21-20020a63ef55000000b00478bd458bdfsm17652197pgk.88.2023.01.17.13.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 13:29:26 -0800 (PST)
Date:   Tue, 17 Jan 2023 21:29:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] KVM: x86: do not unload MMU roots when only toggling
 CR0.WP
Message-ID: <Y8cTMnyBzNdO5dY3@google.com>
References: <20230117204556.16217-1-minipli@grsecurity.net>
 <20230117204556.16217-4-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117204556.16217-4-minipli@grsecurity.net>
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

On Tue, Jan 17, 2023, Mathias Krause wrote:
> There is no need to unload the MMU roots when only CR0.WP has changed --
> the paging structures are still valid, only the permission bitmap needs
> to be updated.

This doesn't hold true when KVM is using shadow paging, in which case CR0.WP
affects the shadow page tables.  I believe that also holds true for nNPT :-(

nEPT doesn't consume CR0.WP so we could expedite that case as well, though
identifying that case might be annoying.

> Change kvm_mmu_reset_context() to get passed the need for unloading MMU
> roots and explicitly avoid it if only CR0.WP was toggled on a CR0 write
> caused VMEXIT.

One thing we should explore on top of this is not intercepting CR0.WP (on Intel)
when TDP is enabled.  It could even trigger after toggling CR0.WP N times, e.g.
to optimize the grsecurity use case without negatively impacting workloads with
a static CR0.WP, as walking guest memory would require an "extra" VMREAD to get
CR0.WP in that case.

Unfortunately, AMD doesn't provide per-bit controls.

> This change brings a huge performance gain as the following micro-
> benchmark running 'ssdd 10 50000' from rt-tests[1] on a grsecurity L1 VM
> shows (runtime in seconds, lower is better):
> 
>                       legacy MMU   TDP MMU
> kvm.git/queue             11.55s    13.91s
> kvm.git/queue+patch        7.44s     7.94s
> 
> For legacy MMU this is ~35% faster, for TTP MMU ~43% faster.
> 
> [1] https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
> 
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---

...

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 508074e47bc0..d7c326ab94de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -902,7 +902,9 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
>  
>  void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
>  {
> -	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
> +	unsigned long cr0_change = cr0 ^ old_cr0;
> +
> +	if (cr0_change & X86_CR0_PG) {
>  		kvm_clear_async_pf_completion_queue(vcpu);
>  		kvm_async_pf_hash_reset(vcpu);
>  
> @@ -914,10 +916,18 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
>  			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
>  	}
>  
> -	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
> -		kvm_mmu_reset_context(vcpu);
> +	if (cr0_change & KVM_MMU_CR0_ROLE_BITS) {
> +		bool unload_mmu =
> +			cr0_change & (KVM_MMU_CR0_ROLE_BITS & ~X86_CR0_WP);

As above, this needs to guarded with a check that the MMU is direct.  And rather
than add a flag to kvm_mmu_reset_context(), just call kvm_init_mmu() directly.
E.g. I think this would work?

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d07563d0e204..8f9fac6d81d2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -927,6 +927,11 @@ EXPORT_SYMBOL_GPL(load_pdptrs);
 
 void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned long cr0)
 {
+       if (vcpu->arch.mmu->root_role.direct && (cr0 ^ old_cr0) == X86_CR0_WP) {
+               kvm_init_mmu(vcpu);
+               return;
+       }
+
        if ((cr0 ^ old_cr0) & X86_CR0_PG) {
                kvm_clear_async_pf_completion_queue(vcpu);
                kvm_async_pf_hash_reset(vcpu);
