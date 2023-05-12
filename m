Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23D7012BA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 01:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241556AbjELXwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241342AbjELXv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 19:51:29 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F97D876
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:50 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-517baf1bc93so9671582a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683935448; x=1686527448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hI6HUK88ajDFBZywtDFlInISuvBrIM7YiPfSco4ddZU=;
        b=S3ZOGuBgFCPTdkJqL5D1ohiGQSYto1Citkxnx7iZrwQ1O+OKJrEBBJZDjc4CDp/g9y
         lw0wbED+SW3RlJm//T51IFB1tlAMVJdQkFXEAgQBM7CwLfi7gLbTPm/YgMf/GYgQf6JA
         nhLjgqxOwdRP9PRZJzFwRmHte0XjKgLUjze9N6+toz53zCc1n7TZGtdivlHnjYrTO0h4
         QjYtwcucRhyLA/TQV39bIC+Gsrg2V55+xHR7WE38i8WLHmEXUOYX0Zu1WZGlZw6QIr8G
         ESAV0nMFZSCI4XW+MK//mEH68yMqkMNNxGnrnlk5sFO8lf2uyxogXVyUTtKD+KdRiMh1
         dufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683935448; x=1686527448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI6HUK88ajDFBZywtDFlInISuvBrIM7YiPfSco4ddZU=;
        b=B/C8nwlYSQvJbwiIGUhz/hOdfXcuwT//ufLEfVZurXWwaNJFSpz6EzrBpI2mWPOHbM
         oDlCB+qhBoq7SVZIUTP/VCH5PZlV46AyQXzxPlVzD0AL4eyhjk6IVWak+Y/w0tiQvtBz
         pbYZjh3c5Gn6XIbT2BuxWCFJjERv+2gRjVtjiPMqxb45Wn+dxzRFNqu7ONWE4FRGyhNJ
         pzN0jjUjyN9I39K/UpA05p5V4K8OpMT+0qAc3OfH6v00cxqC58mC3Bnbowakj1croYf/
         cbQFOcf913lPlJ/CnTHYqai2bB3jp2ViyYkcIGFOYIcFYzJD4EyywOh/0vQzq3ur4WG+
         +DCA==
X-Gm-Message-State: AC+VfDxc69JEb3EY34xVMqN2BFJN0UvR1R0YUyFujCTMAXhckGqJsSXU
        LwuUpRfUNYEIPwLlVy9vgGpZsOHVLLA=
X-Google-Smtp-Source: ACHHUZ6849GFR+yGj04lZIuGIWx0Nl8Ife/1fJ2YqWbkKfswx9jtop//tY1IpFOQw/i0I6AjVK2NN+Cu8YA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fe8b:b0:1ac:a39a:135a with SMTP id
 x11-20020a170902fe8b00b001aca39a135amr4433453plm.11.1683935448368; Fri, 12
 May 2023 16:50:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 May 2023 16:50:18 -0700
In-Reply-To: <20230512235026.808058-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230512235026.808058-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230512235026.808058-11-seanjc@google.com>
Subject: [PATCH v3 10/18] x86/virt: KVM: Move VMXOFF helpers into KVM VMX
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that VMX is disabled in emergencies via the virt callbacks, move the
VMXOFF helpers into KVM, the only remaining user.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 42 ----------------------------------
 arch/x86/kvm/vmx/vmx.c         | 29 ++++++++++++++++++++---
 2 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index b1171a5ad452..a27801f2bc71 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -19,48 +19,6 @@
 #include <asm/svm.h>
 #include <asm/tlbflush.h>
 
-/*
- * VMX functions:
- */
-/**
- * cpu_vmxoff() - Disable VMX on the current CPU
- *
- * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
- *
- * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
- * atomically track post-VMXON state, e.g. this may be called in NMI context.
- * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
- * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
- * magically in RM, VM86, compat mode, or at CPL>0.
- */
-static inline int cpu_vmxoff(void)
-{
-	asm_volatile_goto("1: vmxoff\n\t"
-			  _ASM_EXTABLE(1b, %l[fault])
-			  ::: "cc", "memory" : fault);
-
-	cr4_clear_bits(X86_CR4_VMXE);
-	return 0;
-
-fault:
-	cr4_clear_bits(X86_CR4_VMXE);
-	return -EIO;
-}
-
-static inline int cpu_vmx_enabled(void)
-{
-	return __read_cr4() & X86_CR4_VMXE;
-}
-
-/** Disable VMX if it is enabled on the current CPU
- */
-static inline void __cpu_emergency_vmxoff(void)
-{
-	if (cpu_vmx_enabled())
-		cpu_vmxoff();
-}
-
-
 /*
  * SVM functions:
  */
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f44f93772b4f..e00dba166a9e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -47,7 +47,6 @@
 #include <asm/mshyperv.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
-#include <asm/virtext.h>
 #include <asm/vmx.h>
 
 #include "capabilities.h"
@@ -744,6 +743,29 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
 	return ret;
 }
 
+/*
+ * Disable VMX and clear CR4.VMXE (even if VMXOFF faults)
+ *
+ * Note, VMXOFF causes a #UD if the CPU is !post-VMXON, but it's impossible to
+ * atomically track post-VMXON state, e.g. this may be called in NMI context.
+ * Eat all faults as all other faults on VMXOFF faults are mode related, i.e.
+ * faults are guaranteed to be due to the !post-VMXON check unless the CPU is
+ * magically in RM, VM86, compat mode, or at CPL>0.
+ */
+static int kvm_cpu_vmxoff(void)
+{
+	asm_volatile_goto("1: vmxoff\n\t"
+			  _ASM_EXTABLE(1b, %l[fault])
+			  ::: "cc", "memory" : fault);
+
+	cr4_clear_bits(X86_CR4_VMXE);
+	return 0;
+
+fault:
+	cr4_clear_bits(X86_CR4_VMXE);
+	return -EIO;
+}
+
 static void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
@@ -753,7 +775,8 @@ static void vmx_emergency_disable(void)
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
 
-	__cpu_emergency_vmxoff();
+	if (__read_cr4() & X86_CR4_VMXE)
+		kvm_cpu_vmxoff();
 }
 
 static void __loaded_vmcs_clear(void *arg)
@@ -2821,7 +2844,7 @@ static void vmx_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 
-	if (cpu_vmxoff())
+	if (kvm_cpu_vmxoff())
 		kvm_spurious_fault();
 
 	hv_reset_evmcs();
-- 
2.40.1.606.ga4b1b128d6-goog

