Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8FDA6B530C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjCJVn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjCJVnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:43:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F8283C0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w192-20020a25dfc9000000b009fe14931caaso7052601ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678484576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ObFwdAJXxZK7rEHoG6WjsQKHfeCapBjVn8O6HDAvvM4=;
        b=LGYv/Q37hV8YEO/RbuPb2tdeN7C7LhLnu7b24waVyo/wWGkQeypCLzdLu6xNaBtVQy
         0CtifyH945IYv/viuODdnDbTopfZ0dVolkgZbmExnsVID68qFv9BcdkBxCCKuJZwiA6y
         zjOrQNeUzO0zfO9vqChD9SORUCIj8/6fW/j0r08D2SRJIodqs+gslJkgj39qYDThUbGQ
         r3pqKvYjnSO+wdEfF5hppP5Q9VfepL31E63oxtp+TAfmnlUryBAvIqVFb2yQoPcbkcj4
         fsKcpPCbH5vxrsssZykmf4vyCbu/WdrkP+sJS1eumuJl/0Rj3e5TKH0iAHhfoJbhLu2V
         O3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678484576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObFwdAJXxZK7rEHoG6WjsQKHfeCapBjVn8O6HDAvvM4=;
        b=dwryvUbQ6NeMX0hvGsh+nb5Vc6L2LxeRMsIhUKDq+weRSm3n38MWcIrY51gt8FnUSc
         AvUWtufCV2j9h9GYqZ4pvwT0jaNi/4EpdqS62UNXVDJdmgqsUZNm/mCV8yks1wYQo82m
         6qkF/MjRLgvOtcNsO0Z9jIduM33lNbfB925LLoEoJJMs8VWGfFdpba5uZCluMtZRiEX2
         wuYIzfWq4TTqpgZ2ctGRbb7qNyHx8oJQM5LbOfYTefkLZd71LphnqnuVvGm3oWnVw9oG
         iwYGXtgTU6j8NFeuSv0qxwaj92qJEt+/200IrGJWsPo0ou4YpW3QOvok/gGsE8ofOL1p
         33GA==
X-Gm-Message-State: AO0yUKWri8Iyg5TX1xWfaq3+iQwbhSIVGIm0yNyA2plvMcrMF/lTJUp9
        5JFkilOVVbr7ab/HplUgOpKBoedk2Z0=
X-Google-Smtp-Source: AK7set/OLboJVORkfXldDydcCykWheW0PvG30yhzP9kp9JOe2da+UpGxAM2G+FW31SYBIi3cUpotFW1wNnQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:191:0:b0:a6f:b921:cded with SMTP id
 r17-20020a5b0191000000b00a6fb921cdedmr13339721ybl.2.1678484576759; Fri, 10
 Mar 2023 13:42:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Mar 2023 13:42:24 -0800
In-Reply-To: <20230310214232.806108-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230310214232.806108-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Message-ID: <20230310214232.806108-11-seanjc@google.com>
Subject: [PATCH v2 10/18] x86/virt: KVM: Move VMXOFF helpers into KVM VMX
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
index 58856e196536..158853ab0d1b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -47,7 +47,6 @@
 #include <asm/mshyperv.h>
 #include <asm/mwait.h>
 #include <asm/spec-ctrl.h>
-#include <asm/virtext.h>
 #include <asm/vmx.h>
 
 #include "capabilities.h"
@@ -743,6 +742,29 @@ static int vmx_set_guest_uret_msr(struct vcpu_vmx *vmx,
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
@@ -752,7 +774,8 @@ static void vmx_emergency_disable(void)
 			    loaded_vmcss_on_cpu_link)
 		vmcs_clear(v->vmcs);
 
-	__cpu_emergency_vmxoff();
+	if (__read_cr4() & X86_CR4_VMXE)
+		kvm_cpu_vmxoff();
 }
 
 static void __loaded_vmcs_clear(void *arg)
@@ -2848,7 +2871,7 @@ static void vmx_hardware_disable(void)
 {
 	vmclear_local_loaded_vmcss();
 
-	if (cpu_vmxoff())
+	if (kvm_cpu_vmxoff())
 		kvm_spurious_fault();
 
 	hv_reset_evmcs();
-- 
2.40.0.rc1.284.g88254d51c5-goog

