Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401146B528A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjCJVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:07:36 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834993AAF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:07:35 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id p10-20020a170902e74a00b0019ec1acba17so3407571plf.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678482455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6JKMtwuyYeWcBJAZM434ryy5EllMIQPaNcu6Sr1IDVM=;
        b=CXo5UeDRSeE2H3qb+CLXEgYMbSd2aDneg8uH6pXz8G9ZRIeiCOuZWVMNt7RU8tjbHt
         woTOvwZVipmOUyE4N9waRD9Jr47I/6o2/j6OJV2WqAvsWjfR4frcYnwnyZckjnU3riK2
         /rUKedqs3rFpKPDZ2uf3km99D6ZV4MtyvXmZPIAk0mR2+0YSdDxrSS3tYwGUTfdRCpbm
         +yScQChoLnwr1Mq2S6UHXZelO+558jB3BzsubUl4HTm2H7ZeSZU6rHKmwP08xbA9aiOu
         IJporlxNWuHR7NN+FCIDSDfdT7q+Gr+JozZ1iSYMhou1/56nRP1ojYj3WpSoSGtJ/iaQ
         o0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678482455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6JKMtwuyYeWcBJAZM434ryy5EllMIQPaNcu6Sr1IDVM=;
        b=r+Rfiaf5Vvcj/yDtNpFXx/Wdk56FSD5pOYoqyJTKEkuubXERE05BN+y3aodvNv6ozv
         tcEUELlqOut4yCJ00fbdtjdvpf40Sl9ebjPEvN1euLQX2zPSvU6/sSRr3Aj6XvTD19eZ
         iPvnr6ux+asNM89Hki+ZEuS9PyFhRpVY1tU6eM6aSEG+JVbOZkIRobbWrlAOO/l6Epwp
         0q74eCGd63ChzPEGuKXdtMJ6ih1/7U6L8Ew8k+/E4MI9YadbyHp2BPZufizQkd1RY1pR
         389kHAp8+JMaqQXVvs6sw1pIcGLgECKHCthp3Wer9FWncmXdkWrne7xSc5FtjnwuP3Pl
         l0dA==
X-Gm-Message-State: AO0yUKUWVKOXpxEt7eZPdGVM767nmN9kEDbFbA5/nOjqTwfhRpZESUla
        Hm8i1e4qtcS82BfNehwov7GxtPASodU=
X-Google-Smtp-Source: AK7set9vANUPgzIuHlwrwJIiWycmWxJotd74RaXKUwYIRCFydV0Cwx8VrE4wSNR1vyQIVJ/tlYCB3gZvNWg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:25c5:b0:19a:ebaa:68d7 with SMTP id
 jc5-20020a17090325c500b0019aebaa68d7mr10064359plb.2.1678482455057; Fri, 10
 Mar 2023 13:07:35 -0800 (PST)
Date:   Fri, 10 Mar 2023 13:07:27 -0800
In-Reply-To: <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
Mime-Version: 1.0
References: <cover.1678474914.git.jpoimboe@kernel.org> <432e4844ba65840af4a24f5e3f561aead867f6e7.1678474914.git.jpoimboe@kernel.org>
Message-ID: <ZAucD8gHx8Xp8Dlb@google.com>
Subject: Re: [RFC][PATCH 5/5] x86/kvm: Simplify static call handling
From:   Sean Christopherson <seanjc@google.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"KVM: x86:" please, "x86/kvm" is for guest-side changes.

On Fri, Mar 10, 2023, Josh Poimboeuf wrote:
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1dfba499d3e5..612531e1c478 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1789,8 +1789,6 @@ extern struct kvm_x86_ops kvm_x86_ops;
>  
>  #define KVM_X86_OP(func) \
>  	DECLARE_STATIC_CALL(kvm_x86_##func, *(((struct kvm_x86_ops *)0)->func));
> -#define KVM_X86_OP_OPTIONAL KVM_X86_OP
> -#define KVM_X86_OP_OPTIONAL_RET0 KVM_X86_OP
>  #include <asm/kvm-x86-ops.h>
>  
>  int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops);
> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 6accb46295a3..5f7f860c5f17 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -77,20 +77,15 @@ static struct kvm_pmu_ops kvm_pmu_ops __read_mostly;
>  #define KVM_X86_PMU_OP(func)					     \
>  	DEFINE_STATIC_CALL_NULL(kvm_x86_pmu_##func,			     \
>  				*(((struct kvm_pmu_ops *)0)->func));
> -#define KVM_X86_PMU_OP_OPTIONAL KVM_X86_PMU_OP
>  #include <asm/kvm-x86-pmu-ops.h>
>  
>  void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
>  {
>  	memcpy(&kvm_pmu_ops, pmu_ops, sizeof(kvm_pmu_ops));
>  
> -#define __KVM_X86_PMU_OP(func) \
> -	static_call_update(kvm_x86_pmu_##func, kvm_pmu_ops.func);
>  #define KVM_X86_PMU_OP(func) \
> -	WARN_ON(!kvm_pmu_ops.func); __KVM_X86_PMU_OP(func)

I would much prefer to keep KVM mostly as-is, specifically so that we don't lose
this WARN_ON() that guards against a vendor module neglecting to implement a
mandatory callback.  This effectively gives KVM "full" protection against consuming
an unexpectedly-NULL function pointer.

It's not strictly necessary, but I'm inclinded to keep KVM_X86_OP_OPTIONAL_RET0
around for documentation purposes.  And if I could figure out the compiler magic
to make it work, a WARN/BUILD_BUG on the sizeof() the return type of a RET0
function being larger than sizeof(int).  KVM encountered the fun that occurs on
a u64 return on 32-bit kernels due to "xor eax, eax" leaving garbage in edx.
