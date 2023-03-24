Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCC56C875B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjCXVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCXVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:15:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2680912CDE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:15:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5425c04765dso30747577b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679692535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ByUzQAF933YiOtYjNYUueHaxFJKNZHOc8pGZC9WsDYk=;
        b=kAMLWMRCUtITj+oL6Ekknn8/AbLf0fLJJcRLw0VIjVRkknHGr0IIIEC4rFGbphoYZi
         8sXwdxJCukT0K6uYujXw4qCkHsty7YbgkGIf8XXp0ATZHW0XPLdvhuvgnsJU/Jde6Gid
         eR5jEzGhKFihtGTBHRycX5Bo1j3EXZ/3sxLRdSbH3TgrmAfwuYFDPHIm8CUdggpprbar
         OA5Rm32BLQEvATEIWh1GCP1vAIf+k7cK03jgbgk95r2BFyg/431s5836cHd8lcUK6/SH
         Exw0tCcE3TUpcTpvuEN6hflyKq6EpyM9sQGLrRC3Rdi1f5/9NwdeHl2VAltB3NPjw+Vm
         7hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ByUzQAF933YiOtYjNYUueHaxFJKNZHOc8pGZC9WsDYk=;
        b=Lqw4Az3d1hnMISlKqQVGKNRM4oeHAWzCsz1YzU7VT0Izkdy+zwhmSv88M4sdnK6l9l
         QDyCzL8sfyiMojT22lQ8/uPwVV8QPwpCl22q+sAJSti4eho5BkmNTGQJvLUvovAh9iXw
         MEX7a7o0NpjwzEGs6dxovI1FQldLs1UzNpcuROd/TofD6/ifxkMdS9xEKIQqKVHfGOdu
         8vfLhMmRXdaOkJKPfuRBUeGdgEeMEFowWO8owqzaJcIW0mK1QvZTRUcG6w75nC+yGu9b
         wZQYEeI57ZPetcBCiqcRLMBw6cfAWWMaR0mJAYXcda0cv+aqHf65ZUeDjF8eo9L6eqqG
         fOZg==
X-Gm-Message-State: AAQBX9dM7VXs79wF/DjKIFAZow/fGQrC4ieUGR/MkV7UbYtC0WKQPC4C
        P7GufyZHR0nZMSay7CqCD2A8XlN5Qow=
X-Google-Smtp-Source: AKy350bdF1WVlgJLX2SDiFswwikGhtMGGjqTXIC6huvd0diFGe6fa0Oatun3zdXA8QV0XLUf7NuEb9JviMQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:b67:d295:d614 with SMTP id
 v3-20020a056902108300b00b67d295d614mr1800465ybu.12.1679692535386; Fri, 24 Mar
 2023 14:15:35 -0700 (PDT)
Date:   Fri, 24 Mar 2023 21:15:33 +0000
In-Reply-To: <20230301185838.21659-2-itazur@amazon.com>
Mime-Version: 1.0
References: <20230301185838.21659-1-itazur@amazon.com> <20230301185838.21659-2-itazur@amazon.com>
Message-ID: <ZB4S9eP0tGbGUTSC@google.com>
Subject: Re: [PATCH v2 1/1] KVM: x86: Propagate AMD-specific IBRS bits to guests
From:   Sean Christopherson <seanjc@google.com>
To:     Takahiro Itazuri <itazur@amazon.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, Takahiro Itazuri <zulinx86@gmail.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023, Takahiro Itazuri wrote:
> VMMs retrieve supported CPUID features via KVM_GET_SUPPORTED_CPUID to
> construct CPUID information to be passed to KVM_SET_CPUID2. Most CPUID
> feature bits related to speculative attacks are propagated from host
> CPUID. AMD processors have AMD-specific IBRS related bits in CPUID
> Fn8000_0008_EBX (ref: AMD64 Architecture Programmer's Manual Volume 3:
> General-Purpose and System Instructions) and some bits are not
> propagated to guests.
> 
> Enable propagation of these bits to guests, so that guests can see the
> same security information as the host without VMM action.

Please provide some description on what these bits do, and more importantly why
no action is required to virtualize them in KVM, even if it seems obvious.  We've
had a few goofs with respect to mitigations across guest domains, I just want to
be extra paranoid that we document upfront why it's ok (recommended?) to advertise
this information to the guest.

> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
>  arch/x86/kvm/cpuid.c         | 5 +++--
>  arch/x86/kvm/reverse_cpuid.h | 5 +++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 596061c1610e..c297064208dd 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -704,8 +704,9 @@ void kvm_set_cpu_caps(void)
>  	kvm_cpu_cap_mask(CPUID_8000_0008_EBX,
>  		F(CLZERO) | F(XSAVEERPTR) |
>  		F(WBNOINVD) | F(AMD_IBPB) | F(AMD_IBRS) | F(AMD_SSBD) | F(VIRT_SSBD) |
> -		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_STIBP_ALWAYS_ON) |
> -		__feature_bit(KVM_X86_FEATURE_AMD_PSFD)
> +		F(AMD_SSB_NO) | F(AMD_STIBP) | F(AMD_IBRS_ALWAYS_ON) |
> +		F(AMD_STIBP_ALWAYS_ON) | F(AMD_IBRS_PREFERRED) |
> +		F(AMD_IBRS_SAME_MODE) | __feature_bit(KVM_X86_FEATURE_AMD_PSFD)
>  	);
>  
>  	/*
> diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
> index 042d0aca3c92..1e538e29b117 100644
> --- a/arch/x86/kvm/reverse_cpuid.h
> +++ b/arch/x86/kvm/reverse_cpuid.h
> @@ -43,6 +43,11 @@ enum kvm_only_cpuid_leafs {
>  #define X86_FEATURE_AVX_NE_CONVERT      KVM_X86_FEATURE(CPUID_7_1_EDX, 5)
>  #define X86_FEATURE_PREFETCHITI         KVM_X86_FEATURE(CPUID_7_1_EDX, 14)
>  
> +/* AMD-specific IBRS hint bits, CPUID level 0x80000008 (EBX) */
> +#define X86_FEATURE_AMD_IBRS_ALWAYS_ON	KVM_X86_FEATURE(CPUID_8000_0008_EBX, 16)
> +#define X86_FEATURE_AMD_IBRS_PREFERRED	KVM_X86_FEATURE(CPUID_8000_0008_EBX, 18)
> +#define X86_FEATURE_AMD_IBRS_SAME_MODE	KVM_X86_FEATURE(CPUID_8000_0008_EBX, 19)

These belong in cpufeatures.h, see the rest of the discussion in v1[*].  Sorry for
the runaround :-(

[*] https://lore.kernel.org/all/e5bf7da5-df29-31c6-6d33-81bbecb849ba@redhat.com
