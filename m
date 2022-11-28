Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D563B0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiK1STS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiK1SSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:18:43 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE061CB26
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:02:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id h33so5664093pgm.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqR7gX3syiCInnquF56EWljK5oTnyZ4kLzsHzrSx4U8=;
        b=XrntlQpQ/wG0OiIQftDCbN+uoThYM0WKVwGc1A3TKE2KTlJn8V87WyT4zX9a2nHJju
         xw6Zr5feSlgHsrhG7ZBVKADnAnu9fEYEuE4wqafAuSUMHlgMHBmMDXns5VllUngmBOV5
         Tbn3FfezGQpQVFNt2z73QydrRX1AngTxLU9N1x9JoyErL0j78je1qoNFPAShfYIJsvwy
         tPvdwNaYLxskwOScI+bieJ7rSJkjxOOZ0+7V8HFdSDZ5Gt1WLln9/pI5E8duO3JixiMP
         yOZO2ALQTZAKIyKdl3OVJbRTv/OIizP2Z7NnhY6TZu1Pdpzce5XU5PTuE3GPNZxpYUpO
         z1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqR7gX3syiCInnquF56EWljK5oTnyZ4kLzsHzrSx4U8=;
        b=cGIMdlSQDg+deWhJYIMt6R+A/kda5z4faNT6Jl1nQJdzY8O5+bke0+Fjq1a8/FDTwS
         QoBiD9T1EP6QE4N2cEuEsKzGeszmc97m/2zIMkzriMpT693LY6aXFJO8K3ioV//0hyMk
         I2iwxrrU6Tkcg0WOJCnaLaglHwIgDj0H90uCuLFh9WB8K2ZfT+mChvwrlWVu8e0XLxb9
         3Blw1sRlC5IhFpBBJV4pWg1g3TlR22tobUHtvQ77KxQ/s6uHsL2eV8uYI+UkKp/lOYzn
         lgLJY+jDwBYl/qVF49RjEEXPdU6UbHpTE6sNLCtFo7bLKGH2JFfG4BfQhgWN8mjbpvMi
         vdbA==
X-Gm-Message-State: ANoB5pkB0t5lfOQzWuzRxE8jidPikQAsYTJjfSh7/BFI4Rp1PbBiWXuI
        5FXNPlP5iRQh4iMDXR2PL69fgg==
X-Google-Smtp-Source: AA0mqf5MWw3yW2J416iI/C5fdEQJH6MkiDxzNjFAJsF1ffqzknosq0pEbPhDixzsIxsOH76hNDbcTQ==
X-Received: by 2002:a63:e50f:0:b0:477:bac2:e57f with SMTP id r15-20020a63e50f000000b00477bac2e57fmr23589353pgh.614.1669658570567;
        Mon, 28 Nov 2022 10:02:50 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b0017f637b3e87sm2998705plg.279.2022.11.28.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:02:49 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:02:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: x86/mmu: fix an incorrect comment in kvm_mmu_new_pgd
Message-ID: <Y4T3xsxszDShKqK0@google.com>
References: <20221127221245.204208-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221127221245.204208-1-wei.liu@kernel.org>
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

On Sun, Nov 27, 2022, Wei Liu wrote:
> There is no function named kvm_mmu_ensure_valid_pgd.

() when referecing functions, here and in the comment.

> Fix the comment and remove the pair of braces to conform to Linux kernel
> coding style.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b6f96d47e596..361574124fbe 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4452,10 +4452,12 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd)
>  	struct kvm_mmu *mmu = vcpu->arch.mmu;
>  	union kvm_mmu_page_role new_role = mmu->root_role;
>  
> -	if (!fast_pgd_switch(vcpu->kvm, mmu, new_pgd, new_role)) {
> -		/* kvm_mmu_ensure_valid_pgd will set up a new root.  */
> +	/*
> +	 * Return immediately if no usable root is found. A new root will be

s/is/was

And technically, it may not be a "new" root, e.g. if a different vCPU creates a
usable root between now and kvm_mmu_reload().

> +	 * set up in vcpu_enter_guest prior to the next vmenter.

s/vmenter/VM-Enter

Pointing a reader at vcpu_enter_guest() isn't very helpful since that's a massive
function; kvm_mmu_reload() is where the real magic happens.  I generally prefer to
avoid referencing functions in comments unless doing so is absolutely "necessary"
because such comments always seem to become stale, but in this case I think it's
worthwhile.

	/*
	 * Return immediately if no usable was found, kvm_mmu_reload() will
	 * establish a valid root prior to the next VM-Enter.
	 */

> +	 */
> +	if (!fast_pgd_switch(vcpu->kvm, mmu, new_pgd, new_role))
>  		return;
> -	}
>  
>  	/*
>  	 * It's possible that the cached previous root page is obsolete because
> -- 
> 2.35.1
> 
