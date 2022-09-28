Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73D45EEA12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiI1XU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1XUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:20:21 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0117F27FD9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:20:19 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h62-20020a636c41000000b0043cc1874c79so4913756pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date;
        bh=1BcvkZblEoh81UGBvcbacOXFb2nRKlIjpIAm5OdbSA8=;
        b=Xk8jpCAp7kAIuzwk7BIrTBWEa1j4mAf0fiyNchS/feUtRG57b/rQVM9QarpWa9NP0B
         XFEhW7pOb7H/nYHmczRTjoELvh3S/cY6sekhURDN2N5y69ljts5bXEwWS9ULvqEATSXx
         8/HurJTtyAboLQfzBk2/w8I9te4jVhTMgRXZq2puvhkRRpnavVrCl5xyMbAzvrW3fOzj
         LKoGpCXWnSLxkZF66UBHebmttqXXVYEvE60N4MB5YCjgXyV2uNepsSMh2Or/bbXt1xR1
         myqQwp8jG9tSx90nJl6syWtYPxTwX6HacZ3T4bJkv/8phDkqkX0o+T38xD5xF3Xuhd9Z
         g3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1BcvkZblEoh81UGBvcbacOXFb2nRKlIjpIAm5OdbSA8=;
        b=2gFJOE+Mv9E9YqiKVA72S4FoxAf3fB2wGftF3RWcm6bQ3jbEBM1/2eRnoJi/H7i5CW
         boZFushtnrr4PvCZD6e3WqZm6qClLjbnoQoBZJWhdoUnHs7UH6F31rHCbjp4h55aFCVQ
         k5VdI8yFiO/Z5eldDRVEkQpGQqceKiVLkD5IkpzrgIFdmUjAyJZtHLUUveMjuuUdm4aL
         2zayqbFhEL+zbXznwPK5SNhBItGHuHoFlYLZ5ocf0FzD6ipFXTzfhC9R84bRWBPHL08+
         jQmgqRM+CtSrmvj42WpRpJpxIdbZ8fBUmcttWDUSEbG4dvEtB+BC/flZEAhE+hMpb12T
         7STw==
X-Gm-Message-State: ACrzQf3MlAV+OtRpQRYukyVEagTjlk/7e6qcoU5HoekaHHcLeu4EsC4v
        pOGgmAc49mGe8YvcaTtIhpUwyfSNpVY=
X-Google-Smtp-Source: AMsMyM7wvxCBb8zWCK0CcdiW+UMbMYc8u643F2ltwA5W/bmQ3Mq+yYFDMGhidW94hvR/6yHGKZK1ZccUaJY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:8704:0:b0:542:5288:5e32 with SMTP id
 b4-20020aa78704000000b0054252885e32mr153082pfo.84.1664407219578; Wed, 28 Sep
 2022 16:20:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 28 Sep 2022 23:20:15 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220928232015.745948-1-seanjc@google.com>
Subject: [PATCH] KVM: VMX: Make vmread_error_trampoline() uncallable from C code
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare vmread_error_trampoline() as an opaque symbol so that it cannot
be called from C code, at least not without some serious fudging.  The
trampoline always passes parameters on the stack so that the inline
VMREAD sequence doesn't need to clobber registers.  regparm(0) was
originally added to document the stack behavior, but it ended up being
confusing because regparm(0) is a nop for 64-bit targets.

Opportunustically wrap the trampoline and its declaration in #ifdeffery
to make it even harder to invoke incorrectly, to document why it exists,
and so that it's not left behind if/when CONFIG_CC_HAS_ASM_GOTO_OUTPUT
is true for all supported toolchains.

No functional change intended.

Cc: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmenter.S |  2 ++
 arch/x86/kvm/vmx/vmx_ops.h | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 8477d8bdd69c..24c54577ac84 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -269,6 +269,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
 
 .section .text, "ax"
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 /**
  * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
  * @field:	VMCS field encoding that failed
@@ -317,6 +318,7 @@ SYM_FUNC_START(vmread_error_trampoline)
 
 	RET
 SYM_FUNC_END(vmread_error_trampoline)
+#endif
 
 SYM_FUNC_START(vmx_do_interrupt_nmi_irqoff)
 	/*
diff --git a/arch/x86/kvm/vmx/vmx_ops.h b/arch/x86/kvm/vmx/vmx_ops.h
index ec268df83ed6..80ad6b0a5599 100644
--- a/arch/x86/kvm/vmx/vmx_ops.h
+++ b/arch/x86/kvm/vmx/vmx_ops.h
@@ -11,14 +11,28 @@
 #include "../x86.h"
 
 void vmread_error(unsigned long field, bool fault);
-__attribute__((regparm(0))) void vmread_error_trampoline(unsigned long field,
-							 bool fault);
 void vmwrite_error(unsigned long field, unsigned long value);
 void vmclear_error(struct vmcs *vmcs, u64 phys_addr);
 void vmptrld_error(struct vmcs *vmcs, u64 phys_addr);
 void invvpid_error(unsigned long ext, u16 vpid, gva_t gva);
 void invept_error(unsigned long ext, u64 eptp, gpa_t gpa);
 
+#ifndef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+/*
+ * The VMREAD error trampoline _always_ uses the stack to pass parameters, even
+ * for 64-bit targets.  Preserving all registers allows the VMREAD inline asm
+ * blob to avoid clobbering GPRs, which in turn allows the compiler to better
+ * optimize sequences of VMREADs.
+ *
+ * Declare the trampoline as an opaque label as it's not safe to call from C
+ * code; there is no way to tell the compiler to pass params on the stack for
+ * 64-bit targets.
+ *
+ * void vmread_error_trampoline(unsigned long field, bool fault);
+ */
+extern unsigned long vmread_error_trampoline;
+#endif
+
 static __always_inline void vmcs_check16(unsigned long field)
 {
 	BUILD_BUG_ON_MSG(__builtin_constant_p(field) && ((field) & 0x6001) == 0x2000,

base-commit: c59fb127583869350256656b7ed848c398bef879
-- 
2.37.3.998.g577e59143f-goog

