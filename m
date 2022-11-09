Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F92062213F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiKIBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:14:42 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C45E9ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 17:14:41 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j12so15705414plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 17:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mKyqoiSkzBxH84Qr1HrrOE/dGdA0Clpog0p1k0piuQk=;
        b=NPr9B+bL6MZyQd6+lKX/PXnLnGib/fJJFq8UcR8F8LF5J7fELeKpTzjznjUHoHxfe9
         SpSj9AXF9c20esKhNKmLA2rEfjY/v3mVFSNpbz/4yCP7T1wQuE7gPtL99I+tM41GMrS0
         S9a461pwEESX/mopimUh9uczdRblaJ8rYmDaPmxjpZMy8Zylp1GP+PrY/cbT0KJ5Rzzv
         QmjYQgs6pfaZFeGPdA1aRFFdIIwxTcaRHgA6SNaKW2i1JPdiMdQ990riR6hNBbGMLvZa
         fw95AQCa4zl84rA1FJPGcxB8TAORn40oGadFMGQKntQIv5zLeuKx0FSIzI7kdtJS4aX1
         t+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKyqoiSkzBxH84Qr1HrrOE/dGdA0Clpog0p1k0piuQk=;
        b=YyT1kbUjYFu87zMrUfgzKS8qWhpD56IGo5tuGsGW/DCDG+TrD+B0rNh3jbKxXiJVbo
         SgDJAiu73yHpYAB/zGbab9vyHpX56swabfCzPppvpuvHcW70sRveCI3UFsZGQ7qUPa3M
         ly8UKuNFOrakopbc6f+cOilLNj/1uI5LSfZ0raOaQHeNBBeGQ4X5Rcb5UkP4OxaKIC+O
         VC7sPPI+1vVWTZ77rM5rBdpb+JsOM+8JY7J9yCO383OiGbhqjDtckLMuzYLNBh2FisC6
         0qsvmRnca+lKmMnoizJIjFc6TFa9srwCoW2JpOb2h+qhXs5ABg4ZETrzl2O506HpPY1j
         6kPQ==
X-Gm-Message-State: ACrzQf2UEJRmGwu7YktLuwiffa4T2wzl/2RquibHz1Nqs026vbTA5OwU
        NsSgKoNC3eM5ZDpXm4sEo9FGsw==
X-Google-Smtp-Source: AMsMyM7PPEGcQ4b3ZwhEoIVL/YGFcob35l/PUqwq5A6hdFlK6EVWV/qDf51V0hgcmjj6TzTi91N9rg==
X-Received: by 2002:a17:902:ce82:b0:187:3591:edac with SMTP id f2-20020a170902ce8200b001873591edacmr42472495plg.153.1667956480932;
        Tue, 08 Nov 2022 17:14:40 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id v126-20020a626184000000b00565cf8c52c8sm7198556pfb.174.2022.11.08.17.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 17:14:40 -0800 (PST)
Date:   Wed, 9 Nov 2022 01:14:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        nathan@kernel.org, thomas.lendacky@amd.com,
        andrew.cooper3@citrix.com, peterz@infradead.org,
        jmattson@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 7/8] KVM: SVM: move MSR_IA32_SPEC_CTRL save/restore to
 assembly
Message-ID: <Y2r+/UYNeZ7ljYXC@google.com>
References: <20221108151532.1377783-1-pbonzini@redhat.com>
 <20221108151532.1377783-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108151532.1377783-8-pbonzini@redhat.com>
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

On Tue, Nov 08, 2022, Paolo Bonzini wrote:
> diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
> index 0a4272faf80f..a02eef724379 100644
> --- a/arch/x86/kvm/svm/vmenter.S
> +++ b/arch/x86/kvm/svm/vmenter.S
> @@ -32,10 +32,70 @@
>  
>  .section .noinstr.text, "ax"
>  
> +.macro RESTORE_GUEST_SPEC_CTRL
> +	/* No need to do anything if SPEC_CTRL is unset or V_SPEC_CTRL is set */
> +	ALTERNATIVE_2 "", \
> +		"jmp 800f", X86_FEATURE_MSR_SPEC_CTRL, \
> +		"", X86_FEATURE_V_SPEC_CTRL
> +801:
> +.endm
> +
> +.macro RESTORE_HOST_SPEC_CTRL
> +	/* No need to do anything if SPEC_CTRL is unset or V_SPEC_CTRL is set */
> +	ALTERNATIVE_2 "", \
> +		"jmp 900f", X86_FEATURE_MSR_SPEC_CTRL, \
> +		"", X86_FEATURE_V_SPEC_CTRL
> +901:
> +.endm
> +
> +.macro RESTORE_SPEC_CTRL_BODY

Can we split these into separate macros?  It's a bit more typing, but it's not
immediately obvious that these are two independent chunks (I was expecting a JMP
from the 800 section into the 900 section).

E.g. RESTORE_GUEST_SPEC_CTRL_BODY and RESTORE_HOST_SPEC_CTRL_BODY

> +800:

Ugh, the multiple users makes it somewhat ugly, but rather than arbitrary numbers,
what about using named labels to make it easier to understand the branches?

E.g.

---
 arch/x86/kvm/svm/vmenter.S | 43 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index a02eef724379..23fd7353f0d0 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -32,24 +32,24 @@
 
 .section .noinstr.text, "ax"
 
-.macro RESTORE_GUEST_SPEC_CTRL
+.macro RESTORE_GUEST_SPEC_CTRL name
 	/* No need to do anything if SPEC_CTRL is unset or V_SPEC_CTRL is set */
 	ALTERNATIVE_2 "", \
-		"jmp 800f", X86_FEATURE_MSR_SPEC_CTRL, \
+		"jmp .Lrestore_guest_spec_ctrl\name", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
-801:
+.Lpost_restore_guest_spec_ctrl\name:
 .endm
 
-.macro RESTORE_HOST_SPEC_CTRL
+.macro RESTORE_HOST_SPEC_CTRL name
 	/* No need to do anything if SPEC_CTRL is unset or V_SPEC_CTRL is set */
 	ALTERNATIVE_2 "", \
-		"jmp 900f", X86_FEATURE_MSR_SPEC_CTRL, \
+		"jmp .Lrestore_host_spec_ctrl\name", X86_FEATURE_MSR_SPEC_CTRL, \
 		"", X86_FEATURE_V_SPEC_CTRL
-901:
+.Lpost_restore_host_spec_ctrl\name:
 .endm
 
-.macro RESTORE_SPEC_CTRL_BODY
-800:
+.macro RESTORE_GUEST_SPEC_CTRL_BODY name
+.Lrestore_guest_spec_ctrl\name:
 	/*
 	 * SPEC_CTRL handling: if the guest's SPEC_CTRL value differs from the
 	 * host's, write the MSR.  This is kept out-of-line so that the common
@@ -61,13 +61,16 @@
 	 */
 	movl SVM_spec_ctrl(%_ASM_DI), %eax
 	cmp PER_CPU_VAR(x86_spec_ctrl_current), %eax
-	je 801b
+	je .Lpost_restore_guest_spec_ctrl\name
+
 	mov $MSR_IA32_SPEC_CTRL, %ecx
 	xor %edx, %edx
 	wrmsr
-	jmp 801b
+	jmp .Lpost_restore_guest_spec_ctrl\name
+.endm
 
-900:
+.macro RESTORE_HOST_SPEC_CTRL_BODY name
+.Lrestore_host_spec_ctrl\name:
 	/* Same for after vmexit.  */
 	mov $MSR_IA32_SPEC_CTRL, %ecx
 
@@ -76,18 +79,18 @@
 	 * if it was not intercepted during guest execution.
 	 */
 	cmpb $0, (%_ASM_SP)
-	jnz 998f
+	jnz .Lskip_save_guest_spec_ctrl\name
 	rdmsr
 	movl %eax, SVM_spec_ctrl(%_ASM_DI)
-998:
 
+.Lskip_save_guest_spec_ctrl\name:
 	/* Now restore the host value of the MSR if different from the guest's.  */
 	movl PER_CPU_VAR(x86_spec_ctrl_current), %eax
 	cmp SVM_spec_ctrl(%_ASM_DI), %eax
-	je 901b
+	je .Lpost_restore_host_spec_ctrl\name
 	xor %edx, %edx
 	wrmsr
-	jmp 901b
+	jmp .Lpost_restore_host_spec_ctrl\name
 .endm
 
 
@@ -259,7 +262,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	pop %_ASM_BP
 	RET
 
-	RESTORE_SPEC_CTRL_BODY
+	RESTORE_GUEST_SPEC_CTRL_BODY
+	RESTORE_HOST_SPEC_CTRL_BODY
 
 10:	cmpb $0, kvm_rebooting
 	jne 2b
@@ -310,7 +314,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	mov %_ASM_ARG1, %_ASM_DI
 .endif
 
-	RESTORE_GUEST_SPEC_CTRL
+	RESTORE_GUEST_SPEC_CTRL sev_es
 
 	/* Get svm->current_vmcb->pa into RAX. */
 	mov SVM_current_vmcb(%_ASM_DI), %_ASM_AX
@@ -331,7 +335,7 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	FILL_RETURN_BUFFER %_ASM_AX, RSB_CLEAR_LOOPS, X86_FEATURE_RETPOLINE
 #endif
 
-	RESTORE_HOST_SPEC_CTRL
+	RESTORE_HOST_SPEC_CTRL sev_es
 
 	/*
 	 * Mitigate RETBleed for AMD/Hygon Zen uarch. RET should be
@@ -359,7 +363,8 @@ SYM_FUNC_START(__svm_sev_es_vcpu_run)
 	pop %_ASM_BP
 	RET
 
-	RESTORE_SPEC_CTRL_BODY
+	RESTORE_GUEST_SPEC_CTRL_BODY sev_es
+	RESTORE_HOST_SPEC_CTRL_BODY sev_es
 
 3:	cmpb $0, kvm_rebooting
 	jne 2b

base-commit: 0b242ada175d97a556866c48c80310860f634579
-- 

> @@ -61,6 +126,8 @@ SYM_FUNC_START(__svm_vcpu_run)
>  	mov %_ASM_ARG1, %_ASM_DI
>  .endif
>

Can you add a comment to all of these to call out that RAX, RCX, and RDX might
get clobbered?  It's easy to overlook that detail, and it matters on 32-bit where
the arguments use RCX and RDX.  And because the clobber is conditional, it wouldn't
be that hard for a bug to escape initial testing.

	/* This might clobber RAX, RCX, and RDX! */

> +	RESTORE_GUEST_SPEC_CTRL
